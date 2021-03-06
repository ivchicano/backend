import { Entity, model, property, hasMany } from '@loopback/repository';
import { EventCategoryTranslation } from '.';

@model({
  settings: { idInjection: false, postgresql: { schema: 'micadoapp', table: 'event_category' } }
})
export class EventCategory extends Entity {
  @property({
    type: 'number',
    required: false,
    scale: 0,
    id: true,
    generated: true,
    postgresql: { columnName: 'id', dataType: 'smallint', dataLength: null, dataPrecision: null, dataScale: 0, nullable: 'NO' },
  })
  id: number;

  @property({
    type: 'string',
    postgresql: { columnName: 'icon', dataType: 'text', dataLength: null, dataPrecision: null, dataScale: null, nullable: 'YES' },
  })
  icon?: string;

  @property({
    type: 'boolean',
    postgresql: { columnName: 'link_integration_plan', dataType: 'bool', dataLength: null, dataPrecision: null, dataScale: null, nullable: 'YES' },
  })
  link_integration_plan?: string;

  @hasMany(() => EventCategoryTranslation, { keyTo: 'id' })
  translations: EventCategoryTranslation[];
  // Define well-known properties here

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  // [prop: string]: any;

  constructor(data?: Partial<EventCategory>) {
    super(data);
  }
}

export interface EventCategoryRelations {
  // describe navigational properties here
}

export type EventCategoryWithRelations = EventCategory & EventCategoryRelations;
