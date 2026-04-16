Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB938B7DF
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355740; cv=fail; b=FCB9nplLplritAGe0CADakJgoR6QICG0x5TbkHM8tnOxKgbXDE537g2cXQ2CBo9zI+7tmcqQGUfzO4Kg0+V14FfiqJMrnUS3YeFuGlB7qQvDjDCNyqXV+5XyYtswTPhj6K4E5yjuEsgLDf+LhKt2ijCeJ2ovN4ATZMvhyweJolk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355740; c=relaxed/simple;
	bh=bdwgouCTHbzRfjvJvrgJB0HcgXigAZmXmZMjTLxzZls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aTfdZwLu2AaBY0Qo6JSOR2GRKmf8mAcL7QOfJL4XHalu4JLgOUB/oisvrU5QbBkCCCZHGX7PzelgK2oTa1VHHkBX6hCA7tN7hxguLDr3sFfURpnURAThY6fo5oTsiORHOjHkSsRmJHq4fC8T6+8yhNgkoJW61ypA6+HMPL/fZRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a46AjXc9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V3ZYSPKz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a46AjXc9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V3ZYSPKz"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GFTcGi4004979;
	Thu, 16 Apr 2026 16:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uRSbNmJ6gS8rXq16ygX8KCquFU2tuOKCBPfYlZB7fGg=; b=
	a46AjXc9BDFXWLgHDUhBMDFTSyZjd6d3jznHAE867TZTXOXtlRrkhUt7otG32PJh
	z2rxwo6D24Eu6tnd+oIiFjx2CuUCicKNZWqL5yhDKFrknnUocTYu0aMippfxRasB
	4b8mnJW4V83li401fZbonI/C1uVhGpz1FtG5Rw2HU6ayxFIPVX1ec92xKzbS/vQu
	Jdg98Po1MjM0dOpkSdi0aj/t020SbI52HCUIVV627etkqwl4rxkBirXzuckEO4E1
	03J7ycV/AWmUzl+X7zRKEzQds3NzCqafp3Iiwh220eL/JE5UsIgo56lzmSxzOhUg
	6Q8dmcdGQ4IVFE+tbwRXZA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh867g48k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 16:08:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63GG4Rb9029023;
	Thu, 16 Apr 2026 16:08:31 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7np5p22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 16:08:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfPhpGIiaBNzyV+pts5+oY0ipI9jkxMDzPbalatu2gQ5yvWJbIRA3IEKDGcwpJy6KAzFeBE1R8CRZ1p4hWnLxtrawIw3GFd/ameMWj4r7nfdMahXPv8Oj7F76vTAM30kIzNQS2O2VYp25Nt/0NNKC1xH83GisvKTwX/ORIr0P8MaWggERdSE2IGvkT2jIB8A3fR+auyp6SX/nLc7qzRgcX66v/o1GW0AQsfivHID1eTS7gp89sMJiaI5DfH4nqp2uoG5PyAlNBxpBxvR5bomXAaIfrEvmaE0Ir7F6vught80NlYogszUN0FH7glx5hxmoxLrPU6u+HEBBGiUEhtSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRSbNmJ6gS8rXq16ygX8KCquFU2tuOKCBPfYlZB7fGg=;
 b=YWLXjQqphPE6cVlQHnzVo7Dj8eqR5sGid3fBZaCxNwaPxsVpzfkVvW4r4NLChpMxphyedrkh1+h7SAQ4+EU/YjjlwPlbLw4s7v1Ulpm3QQDGGy/3isB5yV1c9qfUdMZHgEI67jTrPTTwrhuBuOwBCTJ+qmTGHtxrdelcGoLD5ocO+1jERB0Y6PfYQocL1x5sGNTzhlgaWbjkhSbBI8ylcR0Lr18e53FFkAYJ00esWBvzO2Eh4vhA9lpfjGHkswn8aBn2bRwKnnZsSFNhoZck0w8c72xklJ7ibj/RCYonUqWd3/Vwbznv8E3/vzGusRBF0O0OmyuERvSN/SKLn83PHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRSbNmJ6gS8rXq16ygX8KCquFU2tuOKCBPfYlZB7fGg=;
 b=V3ZYSPKzqSpvHLTzhhHuvK2Ebm2+cyBTjfb4M1tOiByUSUVTkQ/vrKWjotuUYPjXNoizx8zuMyalU9nCNmxfUvbKgufNFxAA3cafrQtHLOyAtViLQ7NugJ22Qo2GhJ/TEAsmh/LCPhRyd5EWWv36lxLaqOC4K1KSnrZ/BX9eXHc=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by BN0PR10MB5126.namprd10.prod.outlook.com (2603:10b6:408:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 16:08:27 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 16:08:27 +0000
Message-ID: <1ca0c6f0-5379-4de2-8557-301223e20c4d@oracle.com>
Date: Thu, 16 Apr 2026 17:08:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 3/8] libbpf: Add feature for kernel extended
 vlen/kind support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org
References: <20260416143904.1220662-1-alan.maguire@oracle.com>
 <20260416143904.1220662-4-alan.maguire@oracle.com>
 <DHUPA71FA3G8.JVO2WB7X5YWX@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DHUPA71FA3G8.JVO2WB7X5YWX@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P251CA0003.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::13) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|BN0PR10MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b062a32-e49f-4328-e699-08de9bd264df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BpOnnJwQjlpY5BjDUoQrpqSljvwP+5MgZs3kl+/C0Kbl1gyDT7c/nXXXPSvA5fSvjnU15OJawYec2R5SZltyJ/RHNbrLzFP2lLlod5Q8UJbYhlpjp64DRrC14xBTxDRtTcOeUTOcQq0HjQ/3099BSNSPomAPne9PShk8lKkXI3llif1tyw8/vtu6O7vPy0CcfyOwHCudONAmn+gg3yppB97mAvsIBZR9rNc4Ehk2k5VZWrL/c+0N9CQwAAR4ejBaR+QKK3EC9eqUr8ckFZwnttwU0Y4fBjSWCb7/NC34vmOF/Y6xYti3rnaWfTOfkgbsintV2mzZY8hiOLyS895kaAVEQ+CUr5QB8qEYHXbCdU2Tam6MfnZTE0ZXwlVcAkh5VVRPeGMP2Cc+yW880n4m0mmie+olWjjd5YdXdlI8fUEMUo35+biYQAVISzOXs9iJrXa0s0nY7hpDml4woiS0vjByz6z6D0LSGLjVe+EOrwk5JadSufGyeYWALp+3fZ5b9hKeH/uA6uHPqb/P9pXApS6Fyj+1pGvfhghP4jw8D9vEdMDFwREYkojHskNs+SC8AjuDcY9nOjpdLHF0AQMrcM5hHOvfAPxV6Id8yjHhnJjm/FJxVViey4fn0/bMQnWbr0s7xudWEQDweMCh7hhFY9mZx1LQ19KVlVgHV/HwgP6EW1F2EsL06RQ9mJpedBVxiTzc+SYtVd2TOzGpNoLTiF3uwB93rfWpD891dfw6PkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3hFY2NVVVdxeEMzY1NpKy96aHFtbHBldjR3bzRrWHE3bEhVNGNiUHRkM05Q?=
 =?utf-8?B?eHRsQlVSdGhaeXRjRi9wall5VGZiRGJhVGJ5Z1ZPdHV2UisxdUoxb2pMZWZk?=
 =?utf-8?B?WHhtUUl1QUxvQUtJejZteDJaQllrTVZRUko3QVNIMFNScFk3Yk8xUk4ra2Y1?=
 =?utf-8?B?N0VRV0RTZ1JhRDJKSFh1WlNTRE5hS1BoZ3E2VWozZzF5WnJybm5CajFZZ2Z1?=
 =?utf-8?B?NXFmM0pQZkp0emVrMzRUNUZVdmY5NnF2ZlBlcVpheGtIeGdJM282STEvN05Z?=
 =?utf-8?B?TlF0eWJzbW5zZ2tKdGNJR2JIcDRZclcrMG94UWh4cGZqcHVPUFlIbEV5T0JV?=
 =?utf-8?B?K09ia29HbzR5L1pwUitUMWVYbm4vYjlycHZmR1lMVlZ2UDNPbzJUcVNhbURZ?=
 =?utf-8?B?eDA4SmJFQnViTjJNYmNTQkpralJqTFVNL2p6d0xScFZianVjc2toK1Z2WC9i?=
 =?utf-8?B?YjRadWVQaWtrOUtYMHpXamp3VGEwelc4a1ZYRGkyY2QvYXNEMzg4eFRSVXJX?=
 =?utf-8?B?VTNtNlJsRTVDV3dyM0l3a3RZT1JtVHNjWmNqdGpQd0RXVS9CWTFPUTZkSFEz?=
 =?utf-8?B?dll0REFiUzR4NTNaeWtwMDJmRUV2QndhWXpHVGVySUpleGNERVBkTlQ4d3U5?=
 =?utf-8?B?M0lMcHhEZEdZYTVVY2JwTU5ac0xOa1JsdGJxNlh6K0Vaa1VCZ1dNTFZLVFRm?=
 =?utf-8?B?N2xIbjFnZHhBOWRBRjEyeFdzajlESVRCNHZaNFJSRDNBWFlXWjdFeWQvTmRC?=
 =?utf-8?B?Q3ZMN2ltbnYvUTg1dW56OW9VS3pKRlc4OFVSV2pVeVhJV3JsWUVGaGs3V1VH?=
 =?utf-8?B?N1ppdWlpS29ROTVzdVVrc3hKLytsVnlySGZzZVUzR01OOUF3b1FMRitJYnZL?=
 =?utf-8?B?QWV3R3pSYTVsTEFLSTRqNnBHa0tRbmxiME1obERPbXA2OHc2TEdlRWlGcElG?=
 =?utf-8?B?UnFGZ3oyK2xyQmxENDM4MVgrd0IrWGwxdHk3VTRtNGJpUjNncDQ5UGJ0NEcz?=
 =?utf-8?B?QVhSYTF1dTdqOUtBSVV3WHkveFlIU3Z4K1VlRzdiVnQxa29GSzFFbUVoMTBz?=
 =?utf-8?B?c0FsWjRpMjIxV3ZTT1NEUlFkbWMwWXdnc0JLWnFBVG1Vd3FWNTJKRFg3Z1Az?=
 =?utf-8?B?ZXNhZ25RV2ZmY0g5d3k5UXZRMytkSWZ3bjJOc3hHRVRXU3l4UWRQODdScUhH?=
 =?utf-8?B?eS9FcEhuei9TdzlZN1c5MlpDZTAvakoveTdRcmVxc0daVlRuanpWWk1iR1Vl?=
 =?utf-8?B?ZXVrVlg0RURhcHo3cmhKL0tlbzUyVDN3OW9kN0dRMkZKQ0I3QWJ5RVFYV0Zk?=
 =?utf-8?B?UGFqSXUxM0xZbDlyZmM5VW4xVGV0d3JlK0FSVDAyZXBxSFZuMzBEQTVibXIz?=
 =?utf-8?B?K0xnd09OdUVQVmpNYWZXRzJQQ1J4Zmg2cnE4dmJUYTdQRkxFQUt1RFhTQ2po?=
 =?utf-8?B?UmczV2R6UDROY1cxQkY1VEZPRkthWkxZQUNJZnE4YS9pcGNUdGFWWlhDTHlY?=
 =?utf-8?B?eURnamNRekIxL2N6Y2thVThjL1drQTIrT2pFUnVPSkRYWDZmZkJpcnR2UDk0?=
 =?utf-8?B?V3ZpK2dONjZSZDJ5TXB4dTNkL2F0WnU5YUhISUdBVmJPQ2RVK2Z1b2JTaTIz?=
 =?utf-8?B?MjdOSjFlL0dCQ1pORjhDWG95YVRtYkFkMkJrN0h2ZWRtUjhwOTNHUWJTWEZO?=
 =?utf-8?B?V2tJZ2tIRkZ4cytNTm9WZ3RnT3RoNCtpaVNTNHRmWXR1M2k5R3A2Y0ZMNXd4?=
 =?utf-8?B?T2VSOTZhVXZpVTN1SW1tZVVqQXRBWnZCcXJ2ZFNveWhQS29xNFB5cDljRzRV?=
 =?utf-8?B?V21zZ3dyK3grNC9nR0NJRFhTejhDNmxxaUp3dXdQNDVkZ0YzY0JsWDdZWGFU?=
 =?utf-8?B?cUtJa1BKT3FiVDVBMFdZWERWdGFkVHVoZ25sMlo4M3ZPdHl1MHlmWTdoeWdW?=
 =?utf-8?B?SHpCeUYyLy9VUU9oR3JnMkNkNzJ2TUg5VXN4V2E2SmRTVmIwU0lQQ2NiVm5Z?=
 =?utf-8?B?MkFIMFZoRGVqRUpJLzBFZ2dERS8wNFFxc3p3WHBvTFpLN3YwNWg1blF3ZnZy?=
 =?utf-8?B?MXkwWktITXRvcE55SG04U003NUh4OFUwQXdYNWhpaGovZmpUcGdLV0U2QmM1?=
 =?utf-8?B?M1NwRXJBbkJ0RTJmNGpFRDRqa1BTRG42V2FrNGtyNHNJcURsMW1lODhnUGIv?=
 =?utf-8?B?bVBxSWFMWCtNdXlNVmRqNzFLTkFBcVZCVU8wbnF1YnBTY2EybU05QzBmTmk4?=
 =?utf-8?B?OE9YK244MVdCemFUa3h4V3VMQTAwRGtaN2Q0THB6ZXVzNHl0cmF1VVk3UU9M?=
 =?utf-8?B?L09vWkRrdlhvejVFN2ZBMWZNS2JzVlRwYnhhbEQ5eEI2a0ZxZjk2dz09?=
X-Exchange-RoutingPolicyChecked:
	RY+p4J031JywDslBt38NVpovdxgLsPANV04xUcv+K4wExxNO5z7BS+u0qE4gkddFSVn9+dP2g/+kE51LEvkkbVyelXe8sfVzSmfC5lDNE2ucmJVjeWq/6zvy7N/ey1WfBRu3gMfx0k5uodWuFoNC27nsamg0MR+3JAyChQDl4Q9QXkdt7k47RJyTzqO9jThlKYZSFpVdi+v4SnB29jhEQGZrgkPG6+G1a5AW1Y39FAj4tSG8/kTdNlSG5TuBKBfrgYK7k3J5lKluwmGnL49Na16qmDcIC8ioT/83D42KBYtB2PsZXyjruc7Xg/K1NT58uZqv00JBQh9z08wA8UQjyQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qZkq+gKGfxUuxW3qG8Lw21do8YtlP9ufZXufDOPK8Wb6og4PIfS64WYe34IBnV6KxQJMjkpLRowkRr1HnDuMVVJ+03b1wMzdbwJU5EzRTgewNHemyxTaKROZVSd9GhPk3pkcR70gHpctVMwxPSf9D2SF65K9XJZMFh3PjSsL9nJYAtsQFq4hKKaX5/qDJ5Td6JFqKPnmGj3yMFnY34So4Y4vlpqdaWYRK9LtGK1qhyS5/Kc4dIa81bi8FR9u8+cVO4Ux73YJdcY/vL8e1PqTmk/DOV2+43YAlQsS50MT73yHGpsbvU9UHXhhwANqTU8LjukDapagbWq9q9u4Z5VEah8dVeR831orkMqzLVhyXU8Y45BprkziK6aTgHHI71JXcGvYwI8HVoENMkwhEUvC3Gmcq1Q5jxdRAFuAgv+sYMLn66RKHm3cxL/s7cc5ftapyJSvWm4fWC1uG50/Ngcu8QYhaI9+EjthAgr2hdUkJ6xsfCr3y5hTyjqSUpFDsvwpzbM9yHsSubsAz3jW9Eq1gxgTOLt1XNeyjDsdbG3EHDYbu1JdzqEWap1s56pmXu7/iS4SNfu4bCIovDJWe7nHo6v4T61iN+qZP3CBcohhUIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b062a32-e49f-4328-e699-08de9bd264df
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 16:08:27.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdIL+BjV59tWAuFE/5ykOyi2b7O62Bs7ZobTIE73ihwPTJPTEXnjx0uPgd102GefGxrsHPw7+aAm/VaY3CcE0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604160153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE1MiBTYWx0ZWRfX0UCCM9NB45nr
 X7eJnHsaP4+pZY4u6SvDY9jRQEjCE2Yil8gZAp3cksPemXZ/va5VyJMGB9dD4pP8GYzBBjVfuBd
 C1uTUj8MGIynvE3LZmbo3QPrk49yAA03n5iCNK+djkCUg3IuVmEWjPFXTNqvWCflxLKhc2hD1os
 xyUqicde4NX5KKhqYTW5qC5I4mY//PF20d2H01yqZSZA3BdcCe+vadw0qYte1xvnhh2HQBp2QbN
 tPaePSGYBovYMlZMUyY0Vqp4E/2SCV+6HdpVy7wRZgvvTj/LyKSpcZkeG/VtF+n9uNhTAtI1PT6
 LvKj/JVcAqRatoKuGkwd0ozChbrsWvzn7B0sr+rhQcjYi4fbJkgwP8UzFyn03hrImpd76cN6aeR
 gOpsuwWnw/ELMaLW5cWycK4MBx6ZTweIWPQvdDZzWSY808sS6Mb2XCoNe4nFmjdSHIcghYDtULM
 DBFcK/XpaABTHVy6eBA==
X-Authority-Analysis: v=2.4 cv=cbjiaHDM c=1 sm=1 tr=0 ts=69e10980 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8
 a=bSJ5v875tk0EAj3z-1sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cvNaX5AeWMULnlUCf-cW3apP__lIr6qF
X-Proofpoint-ORIG-GUID: cvNaX5AeWMULnlUCf-cW3apP__lIr6qF

On 16/04/2026 16:56, Alexei Starovoitov wrote:
> On Thu Apr 16, 2026 at 7:38 AM PDT, Alan Maguire wrote:
>> Add feature check for kernel extended vlen/kind support, and reject
>> BTF that uses extended vlens/kinds if the kernel does not support
>> it.  There is no reasonable path to generally sanitize such BTF.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/features.c        | 43 +++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.c          | 17 ++++++++++++-
>>  tools/lib/bpf/libbpf_internal.h |  2 ++
>>  3 files changed, 61 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
>> index 4f19a0d79b0c..f835931f4afe 100644
>> --- a/tools/lib/bpf/features.c
>> +++ b/tools/lib/bpf/features.c
>> @@ -615,6 +615,46 @@ static int probe_kern_btf_layout(int token_fd)
>>  						 (char *)layout, token_fd));
>>  }
>>  
>> +#define EXTEND_TYPE_LEN	((3 * sizeof(struct btf_type) + sizeof(__u32))/sizeof(__u32))
>> +#define EXTEND_VLEN		0x10000
>> +#define EXTEND_SECINFO_LEN	(EXTEND_VLEN * sizeof(struct btf_var_secinfo)/sizeof(__u32))
>> +
>> +static int probe_kern_btf_vlen_kind_extended(int token_fd)
>> +{
>> +	static const char strs[] = "\0int\0foo\0bar";
>> +	__u32 types[EXTEND_TYPE_LEN] = {
>> +		/* int */
>> +		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
>> +		/* var */
>> +		BTF_TYPE_ENC(5 /* "foo" */, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
>> +		/* datasec */
>> +		BTF_TYPE_ENC(9 /* "bar" */, BTF_INFO_ENC(BTF_KIND_DATASEC, EXTEND_VLEN, 0), 0),
>> +	};
>> +	struct btf_var_secinfo *s;
>> +	__u32 *types_data;
>> +	__u32 i;
>> +	int ret;
>> +
>> +	types_data = calloc(EXTEND_TYPE_LEN + EXTEND_SECINFO_LEN, sizeof(__u32));
>> +	if (!types_data)
>> +		return -ENOMEM;
>> +	memcpy(types_data, types, sizeof(types));
>> +
>> +	for (i = 0, s = (struct btf_var_secinfo *)&types_data[EXTEND_TYPE_LEN];
>> +	     i < EXTEND_VLEN; i++, s++) {
>> +		s->type = 2;
>> +		s->offset = 4 * i;
>> +		s->size = 4;
>> +	}
>> +
>> +	ret = probe_fd(libbpf__load_raw_btf((char *)types_data,
>> +					    (EXTEND_TYPE_LEN + EXTEND_SECINFO_LEN) * sizeof(__u32),
>> +					    strs, sizeof(strs), token_fd));
>> +	free(types_data);
>> +
>> +	return ret;
>> +}
>> +
>>  typedef int (*feature_probe_fn)(int /* token_fd */);
>>  
>>  static struct kern_feature_cache feature_cache;
>> @@ -699,6 +739,9 @@ static struct kern_feature_desc {
>>  	[FEAT_BTF_LAYOUT] = {
>>  		"kernel supports BTF layout", probe_kern_btf_layout,
>>  	},
>> +	[FEAT_BTF_VLEN_KIND_EXTENDED] = {
>> +		"kernel supports extended BTF vlen/kind", probe_kern_btf_vlen_kind_extended,
>> +	},
>>  };
>>  
>>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 8b0c3246097f..5f19d8ac17a9 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -3139,10 +3139,11 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
>>  	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>>  	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
>>  	bool has_layout = kernel_supports(obj, FEAT_BTF_LAYOUT);
>> +	bool has_vlen_kind_extended = kernel_supports(obj, FEAT_BTF_VLEN_KIND_EXTENDED);
>>  
>>  	return !has_func || !has_datasec || !has_func_global || !has_float ||
>>  	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec ||
>> -	       !has_layout;
>> +	       !has_layout || !has_vlen_kind_extended;
>>  }
>>  
>>  struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_btf)
>> @@ -3156,6 +3157,7 @@ struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_bt
>>  	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>>  	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
>>  	bool has_layout = kernel_supports(obj, FEAT_BTF_LAYOUT);
>> +	bool has_vlen_kind_extended = kernel_supports(obj, FEAT_BTF_VLEN_KIND_EXTENDED);
>>  	int enum64_placeholder_id = 0;
>>  	const struct btf_header *hdr;
>>  	struct btf *btf = NULL;
>> @@ -3217,6 +3219,19 @@ struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_bt
>>  	for (i = 1; i < btf__type_cnt(btf); i++) {
>>  		t = (struct btf_type *)btf__type_by_id(btf, i);
>>  
>> +		/*
>> +		 * If BTF uses extended vlen/kind and kernel does not support
>> +		 * it, there is nothing we can do.
>> +		 */
>> +		if (!has_vlen_kind_extended) {
>> +			if (btf_vlen(t) > 0xffff || btf_kind(t) > 0x1f) {
>> +				pr_debug("Unsupported %s for id %u\n",
>> +					 btf_kind(t) > 0x1f ? "BTF kind" : "BTF vlen", i);
>> +				btf__free(btf);
>> +				return ERR_PTR(-EINVAL);
>> +			}
>> +		}
> 
> What's the point of the patch?
> Just to make libbpf error early?
> It seems it can be dropped. The kernel will error if it's old.

Yeah, I guess the BTF_INFO_MASK test in btf_check_meta() will catch extended vlen/kind use
for older kernels, and it's been there since 2018. Can be dropped alright.
