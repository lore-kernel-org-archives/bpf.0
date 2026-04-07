Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17D3101D8;
	Tue,  7 Apr 2026 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775560816; cv=fail; b=bLqNA9nKmkgLo5EzBgGp9pkcUnkEWamU09OtZDFgc2WBT7f4DEGTP0d67/LgdH4ompd9SlcLGZ+Ll5HYFjvAqWUEl+XPnJy9laUMjJ3jM0xmEBgP0QFy7lF5xhdBaT450F4p01Vb9HPLY3C+tVDZ6o8U6V6/N8A8WyrcR2VstOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775560816; c=relaxed/simple;
	bh=qTRI7PeXzAUrw/o7lfRQxwLQ9m+HVM+m5cFHRMAQRbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cek1L9c6VBulJODd50Rl1XvSw1muFrceErnIlJbQGLRGsN1oQuOhTIPA7pNqK3OLBHByj7E/beAOxO59NPUNrIyTC0gmP8+FgW9y7xcMjVqXzsXTpoSbMUZ6Qx6zxzLZXhiMHc8Mt1s+Nb1JmmuP2KypBcH/pnN4Xin/AyxJerE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gk4nkJwU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ddv9LkSS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gk4nkJwU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ddv9LkSS"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6371Bhe3880930;
	Tue, 7 Apr 2026 11:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DhG1LCIg9GSQORze3fqDgUHSFuo54oD2ojohTYWExcs=; b=
	Gk4nkJwUWwNufW1qJmu6/ES/Uo6Ck5JVFgB5yQEMshCAlYrpufQmaP5OTexoBtUl
	YlIoHqsGlCyGqCZ/aYlMLNwvraeg+CVmDwwxhi2Rj9cMMOqzh15s8dKh0VSrG5/B
	oynCZFg3FTqO6s/zWgNOumZtiLjL5EUk5wck0/Z2+9N5S+qsSX2TsyTEkY0WlnVr
	73uzh2e1Ge5I0894D9Linl4ckPHM6NXFpzsFADABueoUpJB/uSpuemK/+qErWzot
	oVGupXxWX/Z1AArtkvvVoA+yhtOVVsvM2yKbjv2LSKxdPSGkb51CBmnb8/8rIGev
	y493AinqK6YPb1Y/x/oToA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqb0v2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Apr 2026 11:19:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 637BE1bw008088;
	Tue, 7 Apr 2026 11:19:36 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmeh7qne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Apr 2026 11:19:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLuakoANfRfKO5RbqCd29hp6VTj150SL5TAiehLpKvLQLetoezsBKYHxemas7fKxjCHwvjm8fhzmtdJ5VuZeScGIKFNRwLRzgLYh+2ZBsqtI2cdjnpvrr4wfYa4c8C50p5vFJcNKEzfDZJYZN/qjGuaobC81HxRswb4HdiMzWVwfLezI2Ttg3g6Y9XxEZJdJl/vtB7Ktl4UhEzNSHi7NW97qZP8cpKL4axdnB3EIbfs6VVpNERa9AMdvVSBXRug2fuVuwhPppiGBwKGRKVGZOW4OP3ZjtmW0X9GPTxnBWU57t9wRsgSTNkTeXzdGQCcCne5zSqrhAfI48/BSj+ksug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhG1LCIg9GSQORze3fqDgUHSFuo54oD2ojohTYWExcs=;
 b=Yg/u0KwX1jUHqbh4LOM2n15rqItL3/5myQwD92La7s98GRHbexcoIM8KVnOIO0iFdii+m7YAuFlZXIO3I9GwMLTuVrn1ILCO9ClBiY3yS3hxMB8pDl+oLGZUwg3JXus168sWBoziwzW0yOi8jy2d4WVaxbJ4YX4vwQrBnQ9tmi3GZWGNhD0fbzEnleQuWIO5IOF2hW9QY8J0BUuhSuZauXwOztVx9Gqqi7R2lDPlt1fKqqMwEBIGsX+ny62ZGOwWT/a5PI6F6XP6ATAbdtryZEDda3V8ie3lBaO6L0cynAKg+DGxjQxLQ+NNMlWYM/sQfTm/qj9f+asMb8aVsrYH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhG1LCIg9GSQORze3fqDgUHSFuo54oD2ojohTYWExcs=;
 b=Ddv9LkSSgN+dqN0q1sTTm6Brsgk11ic3ALQhCxT9gnolFp9BmpddKqZtbctQ4SPMHw4tZO6h/0Qj4ZUy024umlj8uE0oIQ5C7EGfw4tfmIlnAF0uloiy+zIcf4rrwgl7JyC3NfGNQ3dkEKRd1O+QOFYBEZdxGxR0vhmiip/HPyQ=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 11:19:33 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 11:19:32 +0000
Message-ID: <753239a3-3431-46b5-ae20-60e8d1d93f2d@oracle.com>
Date: Tue, 7 Apr 2026 12:19:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: fix btf_types_are_same for cross-BTF type comparison
To: chenyuan_fl@163.com, martin.lau@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Chen <chenyuan@kylinos.cn>
References: <20260407080900.551797-1-chenyuan_fl@163.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260407080900.551797-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|PH0PR10MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3b5d7e-225f-4e90-4008-08de94978af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DSJN6lYAPY1CQLUlXHvzb5TtQN7hKIRMw7CZdlVefKnCXrgI6r560AMForz4R1lNhb4Eq4CpfEM9QS7d5eskwVlQFwlJngOA6TO9b0Rh9QHNU7WJkZovy2y2Q4wRCcKANRNKqDmJqb1EjzvekVUrsRUrJvY+kg/7bLHQcnKCIw14PizXgwNbBrPmqQjsGPGhUoCstifYbmKEV6FsiomA1AbWPDKNGzYf0ulQNSajsB8I+KjEtapV8XHnEWFwLo0hUhM/6wcd1Vfsap3eiKo8JkDDlybuVBs2ONpndaaNNc7BdtD9vpp0Pow8tajN+AEqm8ga14QD+1uEzqwGU0S42m4WUHyAntfEbf8xWuKB98NDout0GZpjMW+/2FTjLEcO4wVWqORkbt+mL2GjRYT7snhIbWqxQPaBwTNy2gZ0/26So1WD9f55PHAS4LnozYEzC1nkZtC/60S9Y+5aznJXaB/N3p9oNrIggavGozjDxDRqnKfbqJRdSaMmrrhaNA/OAe7u+RyzEJvPLDXZz3L2gDYKdGsBbil64UaQZU0zPxtKmlkDW6cZl93VmDsP4Ct2a0LaEEpvBQI/MVK4SDATtM4HTolYaWD6Lqj5daU+ACEETaGucAbDN1vD5PPzClHSf0teLrHqlAFt5wUHTQqD83gFMI0sVv8jaxNUPiebr7AorpDOxqh0157Q0+2SiU4KBTzcBrJgsHy+52AM6dXBrt+PmAXqwE6O2mrV+1MajgTJWrgatUgQDvgadmh104SslnT3xHOIMgCYySdoB4KTVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU9FNXlFWi9MK0NVMWg0UlBraklHRjJ3MzVCcHFhbFh3WkVncVVRaFZROGRr?=
 =?utf-8?B?ZXNZNGdQZFdBczN6RjluMEVLUFlubDRjS3F5SVhCM0t5eTZBRko4RWNranR3?=
 =?utf-8?B?cGo3bDVwMVcyUE02eHdTY1JNdnY3anUrSlBTUnJxdlovQ0pCdExJVi8yTDh0?=
 =?utf-8?B?RHZ6Q3VGVEtFb1pxbVZpOEJ2N0hzZU9WcElLS0RpbGdYc3NjRlJaVWpreHg3?=
 =?utf-8?B?eGRxdTFuYk5DR0o4d3lORm5nWXIrN1ozd014VXVoMTVVeFc3SHo2ZVc0R0Z5?=
 =?utf-8?B?eTZEMlExL0FUb2NyQXM2eGRtMlV6UHJ2RnllS2V5UUgvOWViaDRvdHU1bE9q?=
 =?utf-8?B?TWhKS01TdWtBazhOQ1pIbnNzNmZBVkpYa3ZaYjFORFRQZ242YUxSbDFnbFVP?=
 =?utf-8?B?RGdiMkl4SlI3MlFSYVh3TmgwNy9vdFdKTzREVGk2cHFodUg1TjQwenZ5TFpm?=
 =?utf-8?B?dGlPblF3dmR3ZmNmZlhCVUdSSEZtWkJZMFg4L1pNMFk2NVBFWWc4VFphVTRl?=
 =?utf-8?B?aW5HQTJPeHNKd3M5SjRuUjczQVdiN0RzaXB0KzAxNUxpcGRJUlRGbStrREto?=
 =?utf-8?B?NlZqbEdDMzBKWml2cWtWUXljRVo5QnY5UlFTSUNhOWRWSEtYWmtiUjcwNkRs?=
 =?utf-8?B?d3U1RkFZZS83UnZtYmlHbU1EdDhiWWFiajRpQmFvd1plWFZsZmt3aGFWQlA3?=
 =?utf-8?B?Y3kzVGhEd1NhdlVPcXdwbFVtaHFJUS80QmczV1NEemdFNzhIcWRXOTZudkhD?=
 =?utf-8?B?amVKZk1SYzNtWUZRZDN5V3p2WG41a2FRSDdCK2ovZ1lvNzJzN0tJYjRvZWFq?=
 =?utf-8?B?M05oa0xCUUdENWEzaVJiSThkRlNtR3ExL3lWeGJUUkxVZCt5dXRvZlVrbFZI?=
 =?utf-8?B?QThrY2xTVlFvS1VuQTdLOWZtNHpOaG1JNEVrSE5nQ2pobzRWWXcyTzlNSk9R?=
 =?utf-8?B?K2ZBZEpzTk0vUnEvVWdWcEYrRXA2QU1HUExNdVFpcDUzNklnN0VLcll1bXMr?=
 =?utf-8?B?MmJPeHVVSkUyNUtPV1JaSzlpdU1ucGsyb202bTFpUjNSSjBDMGlySUQ4RXZo?=
 =?utf-8?B?WWlZYm1zQklvV1pteU4zMjJNMlhuck1jYzBqZWl5WlVENUR0M0ZIcVZ3M2ZM?=
 =?utf-8?B?MzN3WStodXZ4RVArVE5oMGxKZmo3SHRZNExRL0FNclRzYnp4eDk0TWdPdkhz?=
 =?utf-8?B?NDEzaXNMbDZFM3hrSHk3UzJORk5qQmE0VUhqME9FMmh6L1dJc1h5WEo0TXlD?=
 =?utf-8?B?VStJNll2Wk4zSDh6aHdGeDVpOXE1TUx3c1ZodWNMQWZaTDhsVnl5U21udXJT?=
 =?utf-8?B?TmQvQ1NwZE83alZHUS92cFZ1NXduTnJKZ2hGSWt5Nnp4VTVaZnY4TVF6c1Zm?=
 =?utf-8?B?angzNjZlOU1GK2g2K3JLQjNVajZBK1YxYWM1NUhJTnFSTjAxVDJhQk5lRTRC?=
 =?utf-8?B?NmJCMjhGUkpiOTFuaXVuSm9aVUswQkw4bmtUdkNQeWJIVGgzcjJKYjZ5L0ZN?=
 =?utf-8?B?OFAxM1czTGhabzhNaXQ2aitzSFZpdktBV2REeWpjMkd2UjBlTmdQOVZURXky?=
 =?utf-8?B?Wm1qdUhvaTJKMUs5MWVCUW0yS0pzcy8yS0tHNlF2V25FaDZlVm9NWmNwRGYy?=
 =?utf-8?B?VmYzenQ5TlZlWG5xL0Y1dzh5MWgwa3cxVlRYRzhWT2s5MTBkU1B0UkI0Q3Fz?=
 =?utf-8?B?SnZ2Ymtza3FWVWdCUWlUQm45UVh3ek1mUFQ4cFc2eHdUZEtnT05jWHp4aFI4?=
 =?utf-8?B?TWpxb1poQkoybk5aSm1LZmY0bHVhVWtxR0oycG5veXJpWjdhQzREdGVHTDFF?=
 =?utf-8?B?ektQZHNoTjhJMWhpNWVwbTRtZk4yMjBTdm5iMmRZN2tic3RLd0JpZlorWS9i?=
 =?utf-8?B?ODdNKytMRHFhSUFLRStQZ0VDUFNodEZaUnppSmVOZWtVZW1GN012bE5rNGdk?=
 =?utf-8?B?QVUyM3ExYTFOZFNCUTArai95VDFobWswR1F0ODZMNjErS1ZXK0RPNi9QbU9Y?=
 =?utf-8?B?d3hxaktmMDZrUGE4S2hyRmV5THMrOHAxYisyODlDeFh0N1FKMzVMM0wxTUVS?=
 =?utf-8?B?NkppdHl5OCticDAwbVhranhzK0pZM3Z1aDZ6aU5ycFhpMDBCR2c3MTk3R255?=
 =?utf-8?B?cC9HUU1SbUQwTExDN0NRZUp5UTEzRmhod0hTZFZCUWl5bHVCajQxUnA1K3pS?=
 =?utf-8?B?M2NvVUYxU1JMU29Pdnl1UGdETkx5b1pOclpIVWFERXY4RlhWcGZ6eFhEeHRC?=
 =?utf-8?B?M2Q5Q3pMWlczeDdpbVJjYktjbHNxYU5oSEhZbFpLVFJWOEoxaWl3eXA2ekhT?=
 =?utf-8?B?QlcyWjBLZkZNeFdvNUt0UFBKUk5kV0UvbWp6anliZzFHMUpTTEc2b2lBa0lq?=
 =?utf-8?Q?0tNl4WiIftzUSkWc=3D?=
X-Exchange-RoutingPolicyChecked:
	ltz0oBrhXjCCT5prqNfi+T8SjHWs0cUcrMOf7g6BT5Nl72ZcWC8fe5bAOv9nTGUyE2chQW+8m0Sd8KE+3dxNbRy1Bt186EuiNR8UARmxGxuV2hKY1jobpD8EUSnHA+mF+1CaIdeh372NmZO17bzb2rKqCsYv5lHrAZdQrmb7dF/3krz5sVWbVVbqKcO+nTb4fRHa0jsJJGA/nwkJvx+qB33sjouE1G9aG/6x4mMUY3tKKZA5/ZA0wEGt4JorTnTcrcBm5QiXAlv4xZh7GY2oNkONwxEwgBxiqgM3GDq+TakMiWegQ5BWlymPRN8liM8HFOlbSNq/HEV4IyF7r4/k5Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LP3K+XcAHSIyykjSbvHIhbzzI8Oyeo/KV/5Xed/2r8t/VSGQCKl67XqCFJQuSjGJvhlbOVTaP4bsdAB+ksapRIVz73r7WRLlpNKRrm5u+Box9PWKX+DYNWLR7EqErJ8P0Go+uiMe8ykYCI5NC3I/gW3FqA0ISgsBssN894SLO12zDucPMqnN/14w6gk48zRCJadRdGgOAYQ2GaiLaha1JBtx9Bi7D1SZ8WiuNHmMws4VVMqol1Q8jYShqly27ZgDizuJsMCt92b7Ox/skwHjEp1zEk0voGZE11NYGGZRZk00U434F2y15iTrfORk5FNxvuwSsE7JNhUgTnYF1RMYBW6NvK5lxaLemMyxwwEuvxas1j0F1tBcJTkCXNHQh3b5L7jmmiuyEYoRjLOt/TB7J0wAgLsvnivMbPXBA/aNTSMnOyHvuklOFazJOYStWDQ6ej0wK2EBnVVRP4gR8rajuNTPXh1kldULISyNeidbbhK8E0zVW6r+2JOQqtNCTsbH9cML7EEUK/L3aDDvk2agC+EK9a4BEKcCAGzioh3TsgXmq4Mm0UL/XTkcUa5U7sMa6iiIGy4ocIe8dB9hIAQl2mr9hseduP5oQe+gJc7Aikw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3b5d7e-225f-4e90-4008-08de94978af2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 11:19:32.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3/hGQXJgZMDjTnh9DWmng9q8lV/w5nYudLFxkTFwy/g4jVS+U6NDPDQZYbeASBWZDx6hATDPuv5ievBEuAstw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604070106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwNiBTYWx0ZWRfXx3v+fPp+ARF1
 lyniXHVTJtOKH53wJ39yeRWc+xwo1GhnEd0lAHJHmvYnIhFmrwAdWkSqyfnjhGSHxeL7E/Op3ZT
 OtxQdR8qbrpO7RH0eqGPEz0FjNo3HETc5LdhM66Trg/mQk1He5L6iwyg/XCPhP3ov+/n2UPH1iC
 P6CwQGBJfnwWUBbuN7nJa7Au1z8xCyj0anGvq+u4nHQ6pD1LOSrtwbgFHvhL7f4Vjt41LO43QEf
 IpsekFyOu76Ok+2JfzOM7Mj+a+mBbkBFuiM6khHt11pDVMw8m6jpMEva2PBQi7UbrCc/O4R9mxw
 bfkFNa7FdPveacG4biDhUq450XFucnJC3VC1lZg4GrCbq39ZbJc/yqWowGi86E7H5ww8UWarAsC
 n060ksEwp2EBvQb3GvHPhKzby7aACaGfBb4WYDGOFM8Eq/IqH+gnudWr71fc8wo8JVZP/NTh2AY
 AW+Z45rpwDZF6KMca3r9w+jBN1Nq/jUgXlKR8E6M=
X-Proofpoint-ORIG-GUID: fOwcvxFQOauUc-IbV5pw8PGwH5qSur-h
X-Proofpoint-GUID: fOwcvxFQOauUc-IbV5pw8PGwH5qSur-h
X-Authority-Analysis: v=2.4 cv=cK7QdFeN c=1 sm=1 tr=0 ts=69d4e849 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=Byx-y9mGAAAA:8
 a=8J0Iuv9lop-g25S-77cA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13825

On 07/04/2026 09:09, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> When comparing types from different BTF objects (e.g., module BTF vs
> vmlinux BTF), the original btf_types_are_same() returns false because:
>   - Type IDs are local to each BTF
>   - Pointer comparison of btf_type_by_id results always fails
> 
> This prevents kfuncs with KF_IMPLICIT_ARGS flag from modules (like
> bpf_kfunc_multi_st_ops_test_1_assoc) from properly recognizing implicit
> arguments such as 'struct bpf_prog_aux *', causing the verifier to not
> inject the aux pointer value during fixup.
> 
> Fix by comparing actual type content (kind, size, name) when BTFs are
> different instead of comparing pointers.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  kernel/bpf/btf.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..daad28ae32e5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7432,15 +7432,39 @@ int btf_struct_access(struct bpf_verifier_log *log,
>   * the same. Trivial ID check is not enough due to module BTFs, because we can
>   * end up with two different module BTFs, but IDs point to the common type in
>   * vmlinux BTF.
> + *
> + * When comparing types across different BTF objects (e.g., module BTF vs
> + * vmlinux BTF), we need to compare the actual type content (name, kind, size)
> + * since type IDs may differ between BTF objects even for the same type.
>   */
>  bool btf_types_are_same(const struct btf *btf1, u32 id1,
>  			const struct btf *btf2, u32 id2)
>  {
> -	if (id1 != id2)
> -		return false;
> +	const struct btf_type *t1, *t2;it wo
> +
> +	/* If same BTF object, ID comparison is sufficient */
>  	if (btf1 == btf2)
> -		return true;
> -	return btf_type_by_id(btf1, id1) == btf_type_by_id(btf2, id2);
> +		return id1 == id2;
> +
> +	/* Different BTF objects - compare actual type content.
> +	 * Type IDs may differ between module BTF and vmlinux BTF,
> +	 * so we need to check if the types are semantically identical.
> +	 */
> +	t1 = btf_type_by_id(btf1, id1);
> +	t2 = btf_type_by_id(btf2, id2);
> +	if (!t1 || !t2)
> +		return false;
> +
> +	/* Must be same kind and have same name */
> +	if (BTF_INFO_KIND(t1->info) != BTF_INFO_KIND(t2->info))
> +		return false;
> +	if (t1->size != t2->size)
> +		return false;
> +	if (strcmp(__btf_name_by_offset(btf1, t1->name_off),
> +		   __btf_name_by_offset(btf2, t2->name_off)) != 0)
> +		return false;
> +
> +	return true;
>  }
>  
>  bool btf_struct_ids_match(struct bpf_verifier_log *log,

This feels insufficient as a type equality check; for pointer types
as cited in the commit message, it will only really work if the
pointed-to type ids (t1->size, t2->size above) are identical ids. 
That may work narrowly in the specific case you're dealing with but I'd suggest
looking at how libbpf dedup handles this and figure out a depth-limited
recursive equivalence check that winds up comparing structs/base types rather than
reference types.
