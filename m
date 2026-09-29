Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307D5218A1;
	Tue, 29 Sep 2026 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706380; cv=fail; b=VsdSQTWvq+j+t/NzhlxAxQecBTJI1SCYTGyygawgXsYvzC/GN7xej9Wcxxt3RM3YVlKZeqzk+z+jjWQZRwevVMcJNJtzPkKYx/xzGMZpWrLvvnPvK6lzCpVEHECDw0LP6FqsTaNWha2GnfgcApCDs692zr+4ep4N2iCqACPan9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706380; c=relaxed/simple;
	bh=6O4NjpN9P28J3Lw/aHfshJobaCH7PNK/pY22c5jy2v8=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=WeFgX66cuoKI0YWBHPIhp0OzXKKDDO/XXZGbecYJqSLKBrKxMzIqBqYINcgyms8tN/6Vh32y4CTop35P3rh+2Zy0ZTKNMkLzgE2IfnmyVx88PQB8TmIHtflf9yRNYuKkxSXN2PO1FJe4iIw0BqD29xalv3oWmodzk/YsjgaxiM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RaW2/jQh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VKcoJE40; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RaW2/jQh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VKcoJE40"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TE8wKt4147342;
	Tue, 29 Sep 2026 18:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ybyGNI+nwIVF61uDEo
	CtVy7M8Yds/pzwe7GNE4rVz/w=; b=RaW2/jQhlr3o3ZZviyoBhDPAHLtNoXG3/U
	TCKXGYsTRb0SzLgrv4oXOCIanFH6wdXhml/WU8aG+ft2mXmo43+FS14zPyAeuhGU
	J/uVBDwSnRYzJHoy4G5geQJZbolKoir8deIk84OkqoTVBu5qSElWkpYlF9RX1IKP
	1X1SdmiNMBdSLknQGTrWZPDalW3T/Y3+EISAQ2mPDT8RL4O1h0mC94WcRrMUnVl9
	SphV1mOuGMfTo1m8JbuHMBZOtzJB/z6UdpOlf8ykJ/j0C0SocXyIt5Ss2fJMOfy+
	8AVdvCNoGQfN9F+g0Jq0PQ05UUzQ6gYFOMvjaU0T1O5VLA3OUB5w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbd75x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 18:25:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68TIJnao014501;
	Tue, 29 Sep 2026 18:25:39 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gca6ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:25:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwGdJEZt4ysoNqiDND6ld98roHqUp8FRpYRy8X3SgxJ30npTVywuNUweYlAa2c4ZZd9q12cssbPNBZ8OK8j72/U1dF9uZwQXr6iGhRngHF98Q8fdOyXCi2riJH/Q7JsuIIZelyOnS+4Y/8iAk+xk5tBLaqbux5Kbq5zePST/XzaE20/USl+UHoMVYAWgvTzEwUdSpJP6GhSRmWFSV3kwRaRTaXOsnt0aLagfIHDY7XP70hQnxSVsB3thp8fXU6gcwwszYUU20bQv9QqsbvBAhapysOefx2Pe1IGiSBV+aIlx4mzdUV28JdsN9FtHYeem28Xir3M5Sl0W43m1aLkbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybyGNI+nwIVF61uDEoCtVy7M8Yds/pzwe7GNE4rVz/w=;
 b=iVgliuj8GksHbZqxwfw8jyEb/ICN3Jgrgqj1JI1bH2XhUzmdKLNjbU/C81djTNNlRB3oHgH7ZdyW+uXieE6DyNOM0bfCrr99bfVrJlv9Oe+03hfWKXfhO7aX2WdGA6jMjPGfievB1otn5VNjmfRPiz6Gv1e1NfzzyaSemzg72Cna5/TWfBQEqWTzMbsxLxrhifndI6Bpz6ztHWDmh656kDU47Z9ACnXKRQupQUEZxdJfakENLVyZTZTqMdFB+Foe0wHDpM7JnO4AODi0aBfxQTbcLBORRD5kqmofYD+AtYpBoDDjjN0Kx5Fx3YUYCWqUKGpj2KVTm/Uj7HXavNejxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybyGNI+nwIVF61uDEoCtVy7M8Yds/pzwe7GNE4rVz/w=;
 b=VKcoJE40qRZRfEXGWxKlpjYi7cMsERVFuaWEJf4rdkQUgYY4vXOpuri4ex+JgD84m1TM+IV/b6RxVSeFm+6vfba6lO9cGn8YR51/Auj8uRp0c7PRnz7KI/fefdQSxWsy7atQaLPI8cqvGSokmCBi0BcqaymSsSqtM8e8MdhPRAA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SA3PR10MB6952.namprd10.prod.outlook.com (2603:10b6:806:31b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 29 Sep
 2026 18:25:32 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 18:25:32 +0000
Content-Type: multipart/mixed; boundary="------------X00nbEwTtj4Q9GBCz0CupJ0C"
Message-ID: <dbbb6cde-9889-4445-abf6-0486c380925d@oracle.com>
Date: Tue, 29 Sep 2026 19:25:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 9/9] kbuild, bpf: allow building the vmlinux
 BTF as a module
To: "Wang, Jay" <wanjay@amazon.com>,
        "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
        "Doebel, Bjoern" <doebel@amazon.de>,
        "Pohlack, Martin" <mpohlack@amazon.de>,
        "jay.wang.upstream@gmail.com" <jay.wang.upstream@gmail.com>
References: <20260925224229.1850-1-wanjay@amazon.com>
 <20260925224229.1850-10-wanjay@amazon.com>
 <de28ce03-67c3-4a03-b452-80b92cdfd243@oracle.com>
 <DM6PR18MB2666F6B235D5B356AA157A7DA98D2@DM6PR18MB2666.namprd18.prod.outlook.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DM6PR18MB2666F6B235D5B356AA157A7DA98D2@DM6PR18MB2666.namprd18.prod.outlook.com>
X-ClientProxiedBy: LO4P123CA0361.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::6) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SA3PR10MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: ce26c90a-a9c0-4c10-f5fe-08df1e570bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|6049299003|366016|1800799024|376014|7416014|4053099003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TjTvuPm/x//7fyurk9Hes+Se8W9JQgOAvofhWgEDKR4KIqJFhPTf5mfxkLQmq/6OeD2F6kehRluwC92WgzsyBKLYwToGS96JhF9q/DHSFKr0OQQf4NRZbY3v+iu61CaqsKRBmF+O2MamovORaoNoUFi861orQIDct/qxoJyyiyn89B0hE5wAUFKAheG8NPE4rTv/p96OPCfz6rqb6FNOejLVKVlYHMBltJ+cm2x2jDmtWaVKKw1O6jSZqg+ZG0JH5uGmtx/8X0nzeTe3aDwyU5HEubpCMGvOHxn0M+Ky0TiryqoWDkHnUtiu3T6JL6ljAdihcKTTQDaLXV1jXK2/E/6qX8RX68tbTPciWhwzsrt3LjqHfOw2rR0PfR3F6yM+W/YYKzfTmFiEAkRprbzLV+wfq47yt4pqp79+1WtmTRCoTqFMibWXtCHT447Qlk3ZndzbTFjyoyXVqSedAzXvAxtH4pGoTiSHUbp/qMLEvcPam+mtgaIy17pOtCB2BlqcYgOq/20n15E4HIEU/NYeWSIF3mo6U0ixI8QOxYz1vFEdVFWa6jtL1RPIDIloizwYbJgTMJds70Eld1ygIC78S/bRL01kOO3QoKRTsSlUpgcujQmIrYQysG3seIAwkPqL4Aq/iK59HoKoSx5UR6K7TS1IcklRkbuxpgw45GuU8+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(6049299003)(366016)(1800799024)(376014)(7416014)(4053099003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Snl0U0hhQ0FMelBTN3Y3RkdHVUUzd2VSeWREOUhvMUJ0OWdOZWZwRHZmWHZ1?=
 =?utf-8?B?dmVYM0d5R1lCdndVQ0pRWUVBVGtmbmNSc0VOd3NVb1ZsdHpwVUkveUFOcktV?=
 =?utf-8?B?cVlkRlNWRG1kdUNPRTIrZExFQ0lFWTh4YnpNZG5TSFdxa3RzSDNrbVRLaWwz?=
 =?utf-8?B?Q3VueUZHNExQMTdZMDhGejAzRGtDc1pxM1czU21XQ0xmWVcwSHBjR1BXdDh3?=
 =?utf-8?B?bWVHYUVYSmkxcC9pM2tFK3BoYjZBTkd0VFBFUkhRd3lYakpLS0xYQXZoUko0?=
 =?utf-8?B?Mm1vOGU3RVZYSXhmNjZwM3RJZzM1UGMyOTBUb3BLandLWjVUbW1nN29WaXF5?=
 =?utf-8?B?S0pwYXRNZ3Rkb3F2L0NuSnJyVFVrMTFEaUY4dnYzeVpocytMQzd4KzJNeVZl?=
 =?utf-8?B?eEF0NW9OMGNmQURTL3JicFJvdmFZdEJRVmNIMHJDSlRWcjNHMXVBM0NFVWZh?=
 =?utf-8?B?KzJGMjdqcTJ5TG80akFpYmowZ1JxWFFweWMzRC9CbUsrRXNsN3lJWkNwdlhO?=
 =?utf-8?B?RVI1RVVVRW10aGNuakM5ajlKendsREZHUkV4TkhoVzh1VzZMaStMNVRaNEZs?=
 =?utf-8?B?aTR2Snd4MjlkbWFicE5NZHc5UjhUZlBsTXlHeHpzSlpQTlNtdmJORHZkQmdD?=
 =?utf-8?B?Ty9yNDJGZFBXZmhzdWZIbHlNay9vbS9pVUJBK2NlRVFqbWFqY0NFTEpYZFpm?=
 =?utf-8?B?ZklTdXlkM1NNN1UweHJrOXFCYzNyYUNZQkc2SUpIb1NjNElodlp1SXNPVVRx?=
 =?utf-8?B?aENucFBvNVp5VG1FbFVTcG5hSDRFaXpvZ2UvREFKV0ZRaFAxdWdvMGRLd0p0?=
 =?utf-8?B?YldJSWxWelRWQUEyMVRMQ2RjcGhOUVZpOEkyTUpBZzhqVHoxODRURVRsSlRF?=
 =?utf-8?B?L2JtT2VESXJEa3BQVzQrUUV5Q3EvSXE1azVNdzhjRXc5RTRtaEQrS3YybWoz?=
 =?utf-8?B?N0k0SzhDWWFEamdTSWZNVW9vdUV5cG9LYzFoSEYvaXUwZzZFUzJvMGU1R3g4?=
 =?utf-8?B?cmNKNXV6bGNEL3lYMmRBMzJMejRrb3FBZXlrc3JuNlk3dTZVQ1l5eHJVd3JH?=
 =?utf-8?B?ZnIyWVhTWU1rS25PS2Rad3praXJ0MDM3UE9nRlk3UHZxS2NJSGY3N21RVTZl?=
 =?utf-8?B?RWZqZlRBc0tlZXRFck40MTJuYWJEbVpNd0NoUHJiV0ZsUmNXNW5SdGlRN1pH?=
 =?utf-8?B?bG90bkhyMFY1L29pYVF4bS9sL205RWVvbExNZWRmbGdkZS95dTA0RFhtdng4?=
 =?utf-8?B?Zk01NXNPQUs2b1g4bk5hb2R5REhDUkN2eWpPR1lmV3pJTXpqdWpBMy9LdWxM?=
 =?utf-8?B?b3YzTENiR1ZLb2JOb0dUbTgvTEkxVW9qWjFzeTI3ZFBMRHJZdzVjR1J3S3Zo?=
 =?utf-8?B?OFZIZ3hKZU9xak1Bb0dIQTNxV1hWUnhzcW94Mm55STdQS2pmSFpadzlSQzJW?=
 =?utf-8?B?ZS9uZGFuRnJQZ1BnS09GVDlWUzJ3SCtmbXJpelJaSlNtL0VDV1VGUjFhR1Ji?=
 =?utf-8?B?amx1MTVMV0s4RlJmUm1wc1JOTlJTS1ZnNjFQU1huTGU3d3BVQUZWZ2JPUGZa?=
 =?utf-8?B?U0tMdCszOFNIZTFSbGFFM09UMFJESlpKV3hGRUxaU0Z3NTAxck03N0xZSVRU?=
 =?utf-8?B?ZUlRNHJNLzI5VGFialkzdEFiVUNha3MzcTVFb1pBRUltY2xNWGdtUTF2SzU5?=
 =?utf-8?B?Q3hYOEtrU00vOTlxT3BxY2c3eFA3UE5CT0czakRHbnVPRUMzWXI2MXMyOThK?=
 =?utf-8?B?ZWNKYjUzS1lrbkdFOG1ndWdJejA5SnJYVHBnYnJJQndFblpJcXBQTW52amtF?=
 =?utf-8?B?ZlVIajUyZWFZaGhEY1NxcDdFN0hBY1J4bFdTejI2Y3BKMmgzMXMyUE9PTkRk?=
 =?utf-8?B?anRnUktheXZaQksvVEZWdWQvK2V6aVZXVEFTTVFOOU5VVnVQMDIzcHl0RjJN?=
 =?utf-8?B?VnlTZHVXQjR2K2tBUG41KzNGZkI2WWY5Z1Q5am9RaEF6cmtoVVVrKysxRzhp?=
 =?utf-8?B?WmM0ZTZQSStLODh2emN2V1dxRkw2RS9ydWkwcXg1Vmw3QU1DNDZzVnRmRGpQ?=
 =?utf-8?B?NUN3eXFqUG5NcjQ4SUsrVitLbU51dlhEbjNPVnpYY2o3eGVUTlpBd0x3bTg3?=
 =?utf-8?B?bC9DanpjV0pMMmN4QjZFZXMrM0c3YWkrT2dXZllpSEhjKzRKcTIxOElFQm1Q?=
 =?utf-8?B?MDA0MlRPM1lwVit1UXBYdWExSXlnZ093d1ErR2M5NWVhempjdXlyZ1NEMWJH?=
 =?utf-8?B?dENDOFNFOE9KV0c5d0tRZlI5Ry9MaHNseklzUmI5UmtIUW41SytoNjNpaUhP?=
 =?utf-8?B?OFRiWGlxNTJDaXJYSzlCdVNwZS9acEhTeWNpeHRPNXBMK3pvNkxVZz09?=
X-Exchange-RoutingPolicyChecked:
	5nAtPyHhAqCGaeQ92FC08sLdTK7GCbMmZga/A6OeUVu8dhy/t2198ox4m9WygQFNifjMbILFtEPVVjMfqexTEA+eSlA2Wr2BJG47KsmK2AG72kxg3gEVmdbiVD+4DLpcVS5NqFruDErKASYQZW9eqXB/JmuRGR+GsyOg0xxFUg1z5OH5/Eb8epLswAoOhmn5ESIPSZHLOvnQUtUT4HaWrsgeuMcCtdjp0SE+sJKSPid3D7loYzTe45BUJGsWWBAWgjbyU2ij6DwXKfftec/VF44L5sFRw/yAhClhdugnkiyDP1/dtdauDOrrfALAboCM5tTsOj5QovuRb+B9TyRc+A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pfyiSh79zaciA7AlkoByTc79vM71bFO8AX4BySTZj/jdISCXPSVl3vjvUtSIKQf/mHfZDs/4DQ7yxDGZXzPOdMUyDZdx+3witKrgmChsRgi9K8eLybETv17bWJoAmAGAn+gcPb3pn2EbnAVe4CQa3rim3dq3iwaYzjeOAW5UfxtRewFmjAFpK07KOSGpu/W55kDTUdctWaEsQUFQ19K0ROumSO97aW+pzen+4X1AR2TnxVW4eg806qGaMrmfIlP6JDKPNQ/fDTWjoNwT8xmIcz/0qNChuRFbLVof/OI4ifVbX5OUudYUXkAGlLO82jcIxCPdkskCLJSWhv/AJCXcBR9M2QAA4sAzNF/6dMyI7MbzbnWXS2K3pa5c3VbQ63SDEvZED73uH4g1TGiMgo5pqJGvo5nILyzAS3UMRLdGJi2myq6bfm8+OXnyyR97cV9Zxt2HypYU3aLVBnyEvBwTXww1TV+hx5jyiOH4OHyXG1bMqOIOpRlIiV6b56NEMaReQ4I3IMsqed3XHIJlgQw2sPtU2Ve4h2bRpzkvSucaCawFrQP/JKbdJtvU1jLrVhsV5eWDXaf3pEBXkmqZ6VvAM7ni3IYCpW+7/c7fzs7BtLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce26c90a-a9c0-4c10-f5fe-08df1e570bdb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:25:32.1198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDrPzhUoRWu/VFzB3+tfQj1dBV8s6eargBI+EvUqVATuPyge4QdXrWeAyi3ZJ4V4Q1mcRZmwJG2xlZnYiraE7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6952
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609290073
X-Proofpoint-ORIG-GUID: wFpmZvK9RvkL8rFZzCtXI2zOhJZr1vqJ
X-Proofpoint-GUID: wFpmZvK9RvkL8rFZzCtXI2zOhJZr1vqJ
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abc02a4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=9HaCCVg3_eLuYpul8sgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O6e0_Sd5G08VqZACAkEA:9 a=B2y7HmGcmWMA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3MyBTYWx0ZWRfX/SXn9rhegdO0
 B4ftPtFDsORM7uAzTpGJJP630ulTimUbz12qKTiQQnu7/hthB6eRZDwMF8YbogfSKSQiqtF181h
 UHU4QzSD6SuqOd9ikp8T2tTdi/iZbXXIsiyWyyRA/ldHkssWP4yc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3MyBTYWx0ZWRfX0KVi+wsBI2n/
 OGSRud+Wp/IMjAb7A0mEPR/993hhpY8ZAzgUBgqyaP692iG5eJm17oCpJ40Cb3upT3bmNYDb0FR
 zPoKK7VnZBb1fK+pb7bf8Hg3HxkGt9PXN0X8n/FWfXfD8Wz8WpG8fMWWhHuTzsDX5bxItiE5r/g
 Pan7nnbgOi2Aa9bodP9HhwjditViKCMLCJcRi/nvXRv5zip9YvcG95Z+0J4BEb2f3+sf4ht+NP7
 8NMl5CS0U8W0QNf6LVCrlicXAN+oaaHqHKgWRbYFja2wgBbzfZ4kvphk652iC/dGlcr+IwB9CUu
 lV5u55NzOYzPzxlzBDgAeqRNPNoYxVf8aWL+b6OECWJSJz9o6L51NYjK8NpnRmEcVnk94gJHFae
 XRkNKDmgitczDaGNWfsCgRziNl0okbfcWZ2Og6v4P05ufvX3B2dVLu6hFfJLWS4rSt2ygs4gUSQ
 C82VLo+3o8KCamPqCsQ==

--------------X00nbEwTtj4Q9GBCz0CupJ0C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/09/2026 19:04, Wang, Jay wrote:
> Alan and Alexei, I’ll address both of your comments in V4 and provide more detailed responses later as well. ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍ ‍
Sounds good. To expand on what I had in mind, as I've tried putting together a generic approach
that will work both for your use case - BTF vmlinux delivered as a module - and mine - inline
vmlinux BTF delivered as a module. They'd need to be separate modules as some folks might want
vmlinux BTF as a module but not want inline BTF.

The idea is close to what you had; we have a .BTF.link / .BTF.inline.link ELF section which consists of:

#define BTF_LINK_SHA256_LEN    32

/*
 * A .BTF.link or .BTF.inline.link section identifies the module which
 * carries a vmlinux BTF section.  The module name is NUL terminated and the
 * field is padded to __MODULE_NAME_LEN.
 */
struct btf_link {
       char module_name[__MODULE_NAME_LEN];
       u8 sha256[BTF_LINK_SHA256_LEN];
       u32 btf_size;
} __packed;

These sections .BTF.link / .BTF.inline.link live in vmlinux and tell it

- the module that delivers the payload
- the SHA; and 
- the size

again similar to what you had.

The link section is populated at the same time resolve_btfids populates the .BTF_ids section;
we add support to resolve_btfids for a --btf_link option of the form

    --btf_link <section>:<module>:<raw-btf-file>

So in your case it will be 

    --btf_link .BTF:btf_vmlinux:vmlinux.BTF

and in mine

    --btf_link .BTF.inline:btf_vmlinux_inline:vmlinux.BTF.inline

The attached patch adds resolve_btfids support for this to give an idea of the approach,
and at the final vmlinux linking where we patch BTF ids, we would add the above options.
resolve_btfids is written to support multiple --btf_link options, so whichever work lands
first could add the support that the other series uses. Hope this helps,

Alan
--------------X00nbEwTtj4Q9GBCz0CupJ0C
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-resolve_btfids-add-generic-BTF-link-section-patching.patch"
Content-Disposition: attachment;
 filename*0="0002-resolve_btfids-add-generic-BTF-link-section-patching.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5Y2I5ZDBlMGJkMzQ4YTAzOTYwZTBkN2Y3ZmI2ZWYxYTc2MTY2ZDU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGFuIE1hZ3VpcmUgPGFsYW4ubWFndWlyZUBvcmFjbGUuY29t
PgpEYXRlOiBUdWUsIDI5IFNlcCAyMDI2IDE4OjUwOjE0ICswMTAwClN1YmplY3Q6IFtQQVRDSCB2
MyBicGYtbmV4dCAyLzRdIHJlc29sdmVfYnRmaWRzOiBQb3B1bGF0ZSBCVEYgbGluayBzZWN0aW9u
CgpBbGxvdyB0aGUgZmluYWwgQlRGIHBhdGNoIHBhc3MgdG8gcG9wdWxhdGUgb25lIG9yIG1vcmUg
QlRGIGxpbmsKcmVjb3Jkcy4gIEEgbGluayBpZGVudGlmaWVzIHRoZSBCVEYgc2VjdGlvbiB0byBi
ZSBkZWxpdmVyZWQsIGl0cwpjYXJyaWVyIG1vZHVsZSwgYW5kIHRoZSByYXcgZmluYWxpemVkIEJU
RiBwYXlsb2FkOgoKICAgIC0tYnRmX2xpbmsgPHNlY3Rpb24+Ojxtb2R1bGU+OjxyYXctYnRmLWZp
bGU+CgpVc2UgdGhlIHJhdyBmaWxlIHNpemUgYW5kIFNIQS0yNTYgZGlnZXN0IHRvIHBvcHVsYXRl
IHRoZSBjb3JyZXNwb25kaW5nCjxzZWN0aW9uPi5saW5rIHJlY29yZC4gIFRoaXMgYXZvaWRzIHJl
cGFyc2luZyBCVEYgZHVyaW5nIGZpbmFsIEVMRgpwYXRjaGluZyBhbmQgc3VwcG9ydHMgYm90aCBp
bmxpbmUgQlRGIGFuZCBhIGZ1dHVyZSBtb2R1bGUtZGVsaXZlcmVkCnZtbGludXggQlRGLgoKU2ln
bmVkLW9mZi1ieTogQWxhbiBNYWd1aXJlIDxhbGFuLm1hZ3VpcmVAb3JhY2xlLmNvbT4KQXNzaXN0
ZWQtYnk6IE9wZW5BSSBDb2RleCAoR1BUIDUuNikKLS0tCiB0b29scy9icGYvcmVzb2x2ZV9idGZp
ZHMvbWFpbi5jIHwgMTg3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiAxIGZpbGUg
Y2hhbmdlZCwgMTgzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dG9vbHMvYnBmL3Jlc29sdmVfYnRmaWRzL21haW4uYyBiL3Rvb2xzL2JwZi9yZXNvbHZlX2J0Zmlk
cy9tYWluLmMKaW5kZXggNTcxZjYzYzRjYjgyLi4zYmFhMDFmMTRmMzMgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL2JwZi9yZXNvbHZlX2J0Zmlkcy9tYWluLmMKKysrIGIvdG9vbHMvYnBmL3Jlc29sdmVfYnRm
aWRzL21haW4uYwpAQCAtOTMsOCArOTMsMTMgQEAKICNpbmNsdWRlIDxzdWJjbWQvcGFyc2Utb3B0
aW9ucy5oPgogCiAjZGVmaW5lIEJURl9JRFNfU0VDVElPTgkiLkJURl9pZHMiCisjZGVmaW5lIEJU
Rl9MSU5LX01PRFVMRV9OQU1FX01BWAk2NAorI2RlZmluZSBMSUJCUEZfU0hBMjU2X0RJR0VTVF9M
RU5HVEgJMzIKICNkZWZpbmUgQlRGX0lEX1BSRUZJWAkiX19CVEZfSURfXyIKIAordm9pZCBsaWJi
cGZfc2hhMjU2KGNvbnN0IHZvaWQgKmRhdGEsIHNpemVfdCBsZW4sCisJCSAgIF9fdTggb3V0W0xJ
QkJQRl9TSEEyNTZfRElHRVNUX0xFTkdUSF0pOworCiAjZGVmaW5lIEJURl9TVFJVQ1QJInN0cnVj
dCIKICNkZWZpbmUgQlRGX1VOSU9OCSJ1bmlvbiIKICNkZWZpbmUgQlRGX1RZUEVERUYJInR5cGVk
ZWYiCkBAIC0xNTcsNiArMTYyLDcgQEAgc3RydWN0IG9iamVjdCB7CiAJCXNpemVfdAkJIHN0cnRh
YmlkeDsKIAkJdW5zaWduZWQgbG9uZwkgaWRsaXN0X2FkZHI7CiAJCWludAkJIGVuY29kaW5nOwor
CQlpbnQJCSBlbGZfY2xhc3M7CiAJCWNvbnN0IGNoYXIJKipmdW5jX3N5bWJvbHM7CiAJCXUzMgkJ
IGZ1bmNfc3ltYm9sc19jbnQ7CiAJCXUzMgkJIGZ1bmNfc3ltYm9sc19jYXA7CkBAIC0xNzksNiAr
MTg1LDE5IEBAIHN0cnVjdCBvYmplY3QgewogCXUzMiBhZGRyX3N5bXNfY2FwOwogfTsKIAorc3Ry
dWN0IGJ0Zl9saW5rIHsKKwljaGFyICp2YWx1ZTsKKwljaGFyICpzZWN0aW9uOworCWNoYXIgKm1v
ZHVsZTsKKwljaGFyICpidGZfcGF0aDsKK307CisKK3N0cnVjdCBidGZfbGlua3MgeworCXN0cnVj
dCBidGZfbGluayAqbGlua3M7CisJdTMyIGNudDsKKwl1MzIgY2FwOworfTsKKwogI2RlZmluZSBE
RUNMX1RBR19GQVNUQ0FMTCAiYnBmX2Zhc3RjYWxsIgogI2RlZmluZSBERUNMX1RBR19LRlVOQyAi
YnBmX2tmdW5jIgogCkBAIC0yNjYsNiArMjg1LDQ5IEBAIHN0YXRpYyBpbnQgX19lbnN1cmVfbWVt
KHZvaWQgKipkYXRhLCB1MzIgKmNhcCwgdTMyIGNudCwgc2l6ZV90IGVsZW1fc3opCiAjZGVmaW5l
IGVuc3VyZV9tZW0oYXJyX3B0ciwgY2FwX3B0ciwgY250KSBcCiAJX19lbnN1cmVfbWVtKCh2b2lk
ICoqKShhcnJfcHRyKSwgKGNhcF9wdHIpLCAoY250KSwgc2l6ZW9mKCoqKGFycl9wdHIpKSkKIAor
c3RhdGljIGludCBwYXJzZV9idGZfbGluayhjb25zdCBzdHJ1Y3Qgb3B0aW9uICpvcHQsIGNvbnN0
IGNoYXIgKmFyZywgaW50IHVuc2V0KQoreworCXN0cnVjdCBidGZfbGlua3MgKmxpbmtzID0gb3B0
LT52YWx1ZTsKKwlzdHJ1Y3QgYnRmX2xpbmsgKmxpbms7CisJY2hhciAqc2VwYXJhdG9yOworCisJ
aWYgKHVuc2V0KQorCQlyZXR1cm4gLUVJTlZBTDsKKwlpZiAoX19lbnN1cmVfbWVtKCh2b2lkICoq
KSZsaW5rcy0+bGlua3MsICZsaW5rcy0+Y2FwLCBsaW5rcy0+Y250ICsgMSwKKwkJCSBzaXplb2Yo
KmxpbmtzLT5saW5rcykpKQorCQlyZXR1cm4gLUVOT01FTTsKKwlsaW5rID0gJmxpbmtzLT5saW5r
c1tsaW5rcy0+Y250XTsKKwltZW1zZXQobGluaywgMCwgc2l6ZW9mKCpsaW5rKSk7CisJbGluay0+
dmFsdWUgPSBzdHJkdXAoYXJnKTsKKwlpZiAoIWxpbmstPnZhbHVlKQorCQlyZXR1cm4gLUVOT01F
TTsKKwlsaW5rLT5zZWN0aW9uID0gbGluay0+dmFsdWU7CisJc2VwYXJhdG9yID0gc3RyY2hyKGxp
bmstPnNlY3Rpb24sICc6Jyk7CisJaWYgKCFzZXBhcmF0b3IgfHwgc2VwYXJhdG9yID09IGxpbmst
PnNlY3Rpb24pCisJCWdvdG8gZXJyX3ZhbHVlOworCSpzZXBhcmF0b3IrKyA9ICdcMCc7CisJbGlu
ay0+bW9kdWxlID0gc2VwYXJhdG9yOworCXNlcGFyYXRvciA9IHN0cmNocihsaW5rLT5tb2R1bGUs
ICc6Jyk7CisJaWYgKCFzZXBhcmF0b3IgfHwgc2VwYXJhdG9yID09IGxpbmstPm1vZHVsZSB8fCAh
c2VwYXJhdG9yWzFdKQorCQlnb3RvIGVycl92YWx1ZTsKKwkqc2VwYXJhdG9yKysgPSAnXDAnOwor
CWxpbmstPmJ0Zl9wYXRoID0gc2VwYXJhdG9yOworCWxpbmtzLT5jbnQrKzsKKwlyZXR1cm4gMDsK
K2Vycl92YWx1ZToKKwlmcmVlKGxpbmstPnZhbHVlKTsKKwlyZXR1cm4gLUVJTlZBTDsKK30KKwor
c3RhdGljIHZvaWQgZnJlZV9idGZfbGlua3Moc3RydWN0IGJ0Zl9saW5rcyAqbGlua3MpCit7CisJ
dTMyIGk7CisKKwlmb3IgKGkgPSAwOyBpIDwgbGlua3MtPmNudDsgaSsrKQorCQlmcmVlKGxpbmtz
LT5saW5rc1tpXS52YWx1ZSk7CisJZnJlZShsaW5rcy0+bGlua3MpOworfQorCiBzdGF0aWMgYm9v
bCBpc19idGZfaWQoY29uc3QgY2hhciAqbmFtZSkKIHsKIAlyZXR1cm4gbmFtZSAmJiAhc3RybmNt
cChuYW1lLCBCVEZfSURfUFJFRklYLCBzaXplb2YoQlRGX0lEX1BSRUZJWCkgLSAxKTsKQEAgLTQ4
Nyw2ICs1NDksNyBAQCBzdGF0aWMgaW50IGVsZl9jb2xsZWN0KHN0cnVjdCBvYmplY3QgKm9iaikK
IAkJcmV0dXJuIC0xOwogCX0KIAlvYmotPmVmaWxlLmVuY29kaW5nID0gZWhkci5lX2lkZW50W0VJ
X0RBVEFdOworCW9iai0+ZWZpbGUuZWxmX2NsYXNzID0gZWhkci5lX2lkZW50W0VJX0NMQVNTXTsK
IAogCS8qCiAJICogU2NhbiBhbGwgdGhlIGVsZiBzZWN0aW9ucyBhbmQgbG9vayBmb3Igc2F2ZSBk
YXRhCkBAIC0xMDM2LDYgKzEwOTksMTA2IEBAIHN0YXRpYyBpbnQgZHVtcF9yYXdfYnRmKHN0cnVj
dCBidGYgKmJ0ZiwgY29uc3QgY2hhciAqb3V0X3BhdGgpCiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRp
YyBpbnQgcGF0Y2hfYnRmX2xpbmsoc3RydWN0IG9iamVjdCAqb2JqLCBjb25zdCBzdHJ1Y3QgYnRm
X2xpbmsgKmxpbmspCit7CisJdm9pZCAqcmF3X2J0Zl9kYXRhOworCUVsZl9TY24gKnNjbiA9IE5V
TEw7CisJRWxmX0RhdGEgKmRhdGE7CisJR0VsZl9TaGRyIHNoOworCWNoYXIgc2VjdGlvblsxMjhd
OworCWNoYXIgKm5hbWU7CisJc2l6ZV90IHNoZHJzdHJuZHgsIG1vZHVsZV9uYW1lX2xlbjsKKwlp
bnQgZmQsIGVyciA9IC0xOworCXN0cnVjdCBzdGF0IHN0OworCUZJTEUgKmJ0Zl9maWxlOworCXUz
MiByYXdfYnRmX3NpemU7CisJRWxmICplbGY7CisJdTggKnNpemU7CisKKwlpZiAoc3RhdChsaW5r
LT5idGZfcGF0aCwgJnN0KSB8fCBzdC5zdF9zaXplID4gVUlOVF9NQVgpCisJCXJldHVybiAtRUlO
VkFMOworCXJhd19idGZfc2l6ZSA9IHN0LnN0X3NpemU7CisJcmF3X2J0Zl9kYXRhID0gbWFsbG9j
KHJhd19idGZfc2l6ZSk7CisJaWYgKCFyYXdfYnRmX2RhdGEpCisJCXJldHVybiAtRU5PTUVNOwor
CWJ0Zl9maWxlID0gZm9wZW4obGluay0+YnRmX3BhdGgsICJyYiIpOworCWlmICghYnRmX2ZpbGUp
CisJCWdvdG8gb3V0X2RhdGE7CisJaWYgKGZyZWFkKHJhd19idGZfZGF0YSwgcmF3X2J0Zl9zaXpl
LCAxLCBidGZfZmlsZSkgIT0gMSkKKwkJZ290byBvdXRfZmlsZTsKKwlmY2xvc2UoYnRmX2ZpbGUp
OworCWlmIChvYmotPmVmaWxlLmVsZl9jbGFzcyA9PSBFTEZDTEFTUzMyKQorCQltb2R1bGVfbmFt
ZV9sZW4gPSBCVEZfTElOS19NT0RVTEVfTkFNRV9NQVggLSA0OworCWVsc2UgaWYgKG9iai0+ZWZp
bGUuZWxmX2NsYXNzID09IEVMRkNMQVNTNjQpCisJCW1vZHVsZV9uYW1lX2xlbiA9IEJURl9MSU5L
X01PRFVMRV9OQU1FX01BWCAtIDg7CisJZWxzZQorCQlnb3RvIG91dF9kYXRhOworCWlmIChzdHJs
ZW4obGluay0+bW9kdWxlKSA+PSBtb2R1bGVfbmFtZV9sZW4pCisJCWdvdG8gb3V0X2RhdGE7CisK
KwlzbnByaW50ZihzZWN0aW9uLCBzaXplb2Yoc2VjdGlvbiksICIlcy5saW5rIiwgbGluay0+c2Vj
dGlvbik7CisJZmQgPSBvcGVuKG9iai0+cGF0aCwgT19SRFdSKTsKKwlpZiAoZmQgPCAwKQorCQln
b3RvIG91dF9kYXRhOworCWVsZiA9IGVsZl9iZWdpbihmZCwgRUxGX0NfUkRXUl9NTUFQLCBOVUxM
KTsKKwlpZiAoIWVsZikgeworCQllcnIgPSAtRUlOVkFMOworCQlnb3RvIG91dF9jbG9zZTsKKwl9
CisJZWxmX2ZsYWdlbGYoZWxmLCBFTEZfQ19TRVQsIEVMRl9GX0xBWU9VVCk7CisJaWYgKGVsZl9n
ZXRzaGRyc3RybmR4KGVsZiwgJnNoZHJzdHJuZHgpKQorCQlnb3RvIG91dF9lbGY7CisJd2hpbGUg
KChzY24gPSBlbGZfbmV4dHNjbihlbGYsIHNjbikpKSB7CisJCWlmIChnZWxmX2dldHNoZHIoc2Nu
LCAmc2gpICE9ICZzaCkKKwkJCWdvdG8gb3V0X2VsZjsKKwkJbmFtZSA9IGVsZl9zdHJwdHIoZWxm
LCBzaGRyc3RybmR4LCBzaC5zaF9uYW1lKTsKKwkJaWYgKG5hbWUgJiYgIXN0cmNtcChuYW1lLCBz
ZWN0aW9uKSkKKwkJCWJyZWFrOworCX0KKwlpZiAoIXNjbikgeworCQlwcl9lcnIoIkZBSUxFRDog
c2VjdGlvbiAlcyBub3QgZm91bmQgaW4gJXNcbiIsIHNlY3Rpb24sIG9iai0+cGF0aCk7CisJCWdv
dG8gb3V0X2VsZjsKKwl9CisJZGF0YSA9IGVsZl9nZXRkYXRhKHNjbiwgTlVMTCk7CisJaWYgKCFk
YXRhIHx8IGRhdGEtPmRfc2l6ZSAhPSBtb2R1bGVfbmFtZV9sZW4gKworCQlMSUJCUEZfU0hBMjU2
X0RJR0VTVF9MRU5HVEggKyBzaXplb2YodTMyKSkgeworCQlwcl9lcnIoIkZBSUxFRDogc2VjdGlv
biAlcyBoYXMgdW5leHBlY3RlZCBzaXplXG4iLCBzZWN0aW9uKTsKKwkJZ290byBvdXRfZWxmOwor
CX0KKwltZW1zZXQoZGF0YS0+ZF9idWYsIDAsIGRhdGEtPmRfc2l6ZSk7CisJbWVtY3B5KGRhdGEt
PmRfYnVmLCBsaW5rLT5tb2R1bGUsIHN0cmxlbihsaW5rLT5tb2R1bGUpICsgMSk7CisJbGliYnBm
X3NoYTI1NihyYXdfYnRmX2RhdGEsIHJhd19idGZfc2l6ZSwKKwkJICAgICAgKHU4ICopZGF0YS0+
ZF9idWYgKyBtb2R1bGVfbmFtZV9sZW4pOworCXNpemUgPSAodTggKilkYXRhLT5kX2J1ZiArIG1v
ZHVsZV9uYW1lX2xlbiArIExJQkJQRl9TSEEyNTZfRElHRVNUX0xFTkdUSDsKKwlpZiAob2JqLT5l
ZmlsZS5lbmNvZGluZyA9PSBFTEZEQVRBMkxTQikgeworCQlzaXplWzBdID0gcmF3X2J0Zl9zaXpl
OworCQlzaXplWzFdID0gcmF3X2J0Zl9zaXplID4+IDg7CisJCXNpemVbMl0gPSByYXdfYnRmX3Np
emUgPj4gMTY7CisJCXNpemVbM10gPSByYXdfYnRmX3NpemUgPj4gMjQ7CisJfSBlbHNlIGlmIChv
YmotPmVmaWxlLmVuY29kaW5nID09IEVMRkRBVEEyTVNCKSB7CisJCXNpemVbMF0gPSByYXdfYnRm
X3NpemUgPj4gMjQ7CisJCXNpemVbMV0gPSByYXdfYnRmX3NpemUgPj4gMTY7CisJCXNpemVbMl0g
PSByYXdfYnRmX3NpemUgPj4gODsKKwkJc2l6ZVszXSA9IHJhd19idGZfc2l6ZTsKKwl9IGVsc2Ug
eworCQlnb3RvIG91dF9lbGY7CisJfQorCWVsZl9mbGFnZGF0YShkYXRhLCBFTEZfQ19TRVQsIEVM
Rl9GX0RJUlRZKTsKKwlpZiAoZWxmX3VwZGF0ZShlbGYsIEVMRl9DX1dSSVRFKSA+PSAwKQorCQll
cnIgPSAwOworb3V0X2VsZjoKKwllbGZfZW5kKGVsZik7CitvdXRfY2xvc2U6CisJY2xvc2UoZmQp
OworCWZyZWUocmF3X2J0Zl9kYXRhKTsKKwlyZXR1cm4gZXJyOworb3V0X2ZpbGU6CisJZmNsb3Nl
KGJ0Zl9maWxlKTsKK291dF9kYXRhOgorCWZyZWUocmF3X2J0Zl9kYXRhKTsKKwlyZXR1cm4gZXJy
OworfQorCiBzdGF0aWMgY29uc3Qgc3RydWN0IGJ0Zl90eXBlICpidGZfdHlwZV9za2lwX3F1YWxp
ZmllcnMoY29uc3Qgc3RydWN0IGJ0ZiAqYnRmLCBzMzIgdHlwZV9pZCkKIHsKIAljb25zdCBzdHJ1
Y3QgYnRmX3R5cGUgKnQgPSBidGZfX3R5cGVfYnlfaWQoYnRmLCB0eXBlX2lkKTsKQEAgLTE5MDgs
NiArMjA3MSw3IEBAIGludCBtYWluKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndikKIAkJLnNl
dHMgICAgID0gUkJfUk9PVCwKIAl9OwogCWNvbnN0IGNoYXIgKmJ0Zmlkc19wYXRoID0gTlVMTDsK
KwlzdHJ1Y3QgYnRmX2xpbmtzIGJ0Zl9saW5rcyA9IHt9OwogCWJvb2wgZmF0YWxfd2FybmluZ3Mg
PSBmYWxzZTsKIAlib29sIHJlc29sdmVfYnRmaWRzID0gdHJ1ZTsKIAljaGFyIG91dF9wYXRoW1BB
VEhfTUFYXTsKQEAgLTE5MjUsNiArMjA4OSw4IEBAIGludCBtYWluKGludCBhcmdjLCBjb25zdCBj
aGFyICoqYXJndikKIAkJCSAgICAiZGlzdGlsbCAtLWJ0Zl9iYXNlIGFuZCBlbWl0IC5CVEYuYmFz
ZSBzZWN0aW9uIGRhdGEiKSwKIAkJT1BUX0JPT0xFQU4oMCwgImlubGluZSIsICZvYmouZXh0cmFj
dF9pbmxpbmUsCiAJCQkgICAgImV4dHJhY3QgbG9jYXRpb24gQlRGIGludG8gYSAuQlRGLmlubGlu
ZSBmaWxlIiksCisJCU9QVF9DQUxMQkFDSygwLCAiYnRmX2xpbmsiLCAmYnRmX2xpbmtzLCAic2Vj
dGlvbjptb2R1bGU6YnRmLWZpbGUiLAorCQkJICAgICAicGF0Y2ggYSBCVEYgbGluayIsIHBhcnNl
X2J0Zl9saW5rKSwKIAkJT1BUX1NUUklORygwLCAicGF0Y2hfYnRmaWRzIiwgJmJ0Zmlkc19wYXRo
LCAiZmlsZSIsCiAJCQkgICAicGF0aCB0byAuQlRGX2lkcyBzZWN0aW9uIGRhdGEgYmxvYiB0byBw
YXRjaCBpbnRvIEVMRiBmaWxlIiksCiAJCU9QVF9FTkQoKQpAQCAtMTkzOCw5ICsyMTA0LDIyIEBA
IGludCBtYWluKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndikKIAogCW9iai5wYXRoID0gYXJn
dlswXTsKIAotCWlmIChidGZpZHNfcGF0aCkKLQkJcmV0dXJuIHBhdGNoX2J0ZmlkcyhidGZpZHNf
cGF0aCwgb2JqLnBhdGgpOwotCisJaWYgKGJ0Zmlkc19wYXRoKSB7CisJCWVyciA9IHBhdGNoX2J0
ZmlkcyhidGZpZHNfcGF0aCwgb2JqLnBhdGgpOworCQlpZiAoZXJyIHx8ICFidGZfbGlua3MuY250
KQorCQkJZ290byBvdXQ7CisJCWlmIChlbGZfY29sbGVjdCgmb2JqKSkgeworCQkJZXJyID0gLUVJ
TlZBTDsKKwkJCWdvdG8gb3V0OworCQl9CisJCWZvciAodTMyIGkgPSAwOyBpIDwgYnRmX2xpbmtz
LmNudDsgaSsrKSB7CisJCQlzdHJ1Y3QgYnRmX2xpbmsgKmxpbmsgPSAmYnRmX2xpbmtzLmxpbmtz
W2ldOworCQkJZXJyID0gcGF0Y2hfYnRmX2xpbmsoJm9iaiwgbGluayk7CisJCQlpZiAoZXJyKQor
CQkJCWJyZWFrOworCQl9CisJCWdvdG8gb3V0OworCX0KIAlpZiAoZWxmX2NvbGxlY3QoJm9iaikp
CiAJCWdvdG8gb3V0OwogCWlmIChvYmouZXh0cmFjdF9pbmxpbmUgJiYgY29sbGVjdF9mdW5jX3N5
bWJvbHMoJm9iaikpCkBAIC0yMDAxLDEwICsyMTgwLDEwIEBAIGludCBtYWluKGludCBhcmdjLCBj
b25zdCBjaGFyICoqYXJndikKIAkJaWYgKGVycikKIAkJCWdvdG8gb3V0OwogCX0KLQogCWlmICgh
KGZhdGFsX3dhcm5pbmdzICYmIHdhcm5pbmdzKSkKIAkJZXJyID0gMDsKIG91dDoKKwlmcmVlX2J0
Zl9saW5rcygmYnRmX2xpbmtzKTsKIAlidGZfX2ZyZWUob2JqLmlubGluZV9idGYpOwogCWJ0Zl9f
ZnJlZShvYmouYnRmKTsKIAlidGZfX2ZyZWUob2JqLmJhc2VfYnRmKTsKLS0gCjIuNDMuNQoK

--------------X00nbEwTtj4Q9GBCz0CupJ0C--
