import {Entity, model, property, hasMany} from '@loopback/repository';
import {InterventionCategoryTranslation} from './intervention-category-translation.model';

@model({
  settings: {
    idInjection: false,
    postgresql: {schema: 'micadoapp', table: 'intervention_category'}
  }
})
export class InterventionCategory extends Entity {
  @property({
    type: 'number',
    required: true,
    scale: 0,
    id: 1,
    postgresql: {columnName: 'id', dataType: 'smallint', dataLength: null, dataPrecision: null, dataScale: 0, nullable: 'NO'},
  })
  id: number;

  @property({
    type: 'string',
    length: 30,
    postgresql: {columnName: 'title', dataType: 'character varying', dataLength: 30, dataPrecision: null, dataScale: null, nullable: 'YES'},
  })
  title?: string;

  @property({
    type: 'string',
    required: true,
    length: 10,
    id: 2,
    postgresql: {columnName: 'lang', dataType: 'character varying', dataLength: 10, dataPrecision: null, dataScale: null, nullable: 'NO'},
  })
  lang: string;

  @property({
    type: 'boolean',
  })
  published?: boolean;

  @property({
    type: 'date',
    postgresql: { columnName: 'publication_date', dataType: 'timestamp without time zone', dataLength: null, dataPrecision: null, dataScale: null, nullable: 'YES' },
  })
  publicationDate?: string;

  @hasMany(() => InterventionCategoryTranslation, {keyTo: 'id'})
  translations: InterventionCategoryTranslation[];
  // Define well-known properties here

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
 // [prop: string]: any;

  constructor(data?: Partial<InterventionCategory>) {
    super(data);
  }
}

export interface InterventionCategoryRelations {
  // describe navigational properties here
}

export type InterventionCategoryWithRelations = InterventionCategory & InterventionCategoryRelations;
