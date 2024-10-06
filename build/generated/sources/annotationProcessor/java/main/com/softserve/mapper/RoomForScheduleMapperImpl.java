package com.softserve.mapper;

import com.softserve.dto.RoomForScheduleDTO;
import com.softserve.entity.Room;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2024-10-06T14:36:26+0300",
    comments = "version: 1.3.1.Final, compiler: javac, environment: Java 11.0.24 (Eclipse Adoptium)"
)
@Component
public class RoomForScheduleMapperImpl implements RoomForScheduleMapper {

    @Override
    public RoomForScheduleDTO roomToRoomForScheduleDTO(Room room) {
        if ( room == null ) {
            return null;
        }

        RoomForScheduleDTO roomForScheduleDTO = new RoomForScheduleDTO();

        roomForScheduleDTO.setId( room.getId() );
        roomForScheduleDTO.setName( room.getName() );

        return roomForScheduleDTO;
    }
}
