import {Entity, model, property, hasMany} from '@loopback/repository';
import {CommentsTranslation} from './comments-translation.model';

@model({
  settings: {idInjection: false, postgresql: {schema: 'micadoapp', table: 'comments'}}
})
export class Comments extends Entity {
  @property({
    type: 'boolean',
    postgresql: {columnName: 'published', dataType: 'boolean', dataLength: null, dataPrecision: null, dataScale: null, nullable: 'YES'},
  })
  published?: boolean;

  @property({
    type: 'date',
    jsonSchema: { nullable: true },
    postgresql: {columnName: 'publicationdate', dataType: 'date', dataLength: null, dataPrecision: null, dataScale: null, nullable: 'YES'},
  })
  publicationdate?: string;

  @property({
    type: 'number',
    required: false,
    scale: 0,
    id: 1,
    generated: true,
    postgresql: {columnName: 'id', dataType: 'smallint', dataLength: null, dataPrecision: null, dataScale: 0, nullable: 'NO'},
  })
  id: number;

  @hasMany(() => CommentsTranslation, {keyTo: 'id'})
  translations: CommentsTranslation[];
  // Define well-known properties here

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  //[prop: string]: any;

  constructor(data?: Partial<Comments>) {
    super(data);
  }
}

export interface CommentsRelations {
  // describe navigational properties here
}

export type CommentsWithRelations = Comments & CommentsRelations;
