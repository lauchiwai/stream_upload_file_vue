
export interface ResultDto<T>{
    success: boolean;
    message: string;
    messageNo: number;
    description: string;
    object: T;
    remark: [];
}


export interface ChunkUploadType{
    fileHash :string;
    fileName : string;
    totalChunks : number
    uploadedChunks : number;
}
