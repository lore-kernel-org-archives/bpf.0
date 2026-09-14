Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C34481652;
	Mon, 14 Sep 2026 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396277; cv=fail; b=il/TcgTHRst3Oc99D1LSy1sTCNM7y4ZF1Ka9WiYmEWDVMNz1hPve1tjVfFkTxIVTvowwKj0odPZsIE3gxXjSaZmIYss418OZiA8cn7Fpi1kGTjwE4h6M04C6yPc+iA8zn/twlG5alNEidowSVVfkLfTPO4QaUrCm2VA+mApuy80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396277; c=relaxed/simple;
	bh=9ni8AtB+xzsQUJYM50kz3zYAq67SesreLtbecMLgr6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=RIqm0rSJFUikJOhS/58ncZUh1qd5l91T8V+50kUDtcbzTxLolcghkPdGoeZMpgNHVPG7b6yvYRb8rbIjM05CJITvOiYG6E4v/9cbWxDgT95crodXB1WpWcu8vntrinAx6WZrjusUwKaCJtXTTnNbCSou3hzDUh7hf0Iuo3VM+Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PENEg1Es; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RqdmC3yj reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PENEg1Es";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RqdmC3yj"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EEQjo51660090;
	Mon, 14 Sep 2026 14:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JkS2zDzLU3A5xqm9V9gCQe3iZyllWIR6poCOw997DfI=; b=
	PENEg1EsqftvgIqyl59c8MX7KuSBewmWOgh/QBkUjRG6weHnhF3Tc/BmpHfgAxDS
	m1XdykpMuAYh40bRjmAzN3rdKRSVlgSVhU4bAB3UCZVVAzG/D+MAKU2m8Z0+iV3B
	1c1wDtJilqKbJ4JdDZ0KbD+Ya4Q/PJyehbHsz1LTttENAEQirtQQSbf8C/h2ZG4g
	Qglu1syN6A3K2Sn4CM5cXQXjYjDRE/64++jrFWZcHtE2oHFFaRBhYHl0IarE9q+M
	7oS9QaDkQNG3D8bbW2WpLYS5qmrVcxB1fzoVjGej0/JRRKR3fiu2jCnyDrCvMpow
	gjLNkbWo8JXSCbtaLSXGjA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmwh1hyme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 14:30:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68EEUPgp040625;
	Mon, 14 Sep 2026 14:30:36 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6n2ttb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Sep 2026 14:30:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipP+69JUTqgce6Xp2mfb4KUQTrPcnJ7TRyqi5aqcI/QmbXEEp5zaBWQOaWjKBU/vKbfu0A9Cu/DFmkdALz78a5synNXRi5GUaYzeJ5nQaRtOp4NA7/KTA2qbnpmqOkz5rAhel0drHWfCnWdN/NR5yIdJsZzPKMW0LjVlVB0eQP24UtVV8H5eRziivba8qIof4dbzlA3de5frD08+uZ5k6Db3sUNbCklWZoyCEy1THUsTG0VITAonLYGSvYxyImX9s+M820gcQ7KzspNhCVbAq44ktZhKtbXnafcrFMfO2IETn5bZtYySwis+ZxTuXlDofMacg0QIbt6U0hJZFWKtUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BkhwOZh95ILzwMfzqorfsVv88/UUOZe2Z1+dkGiTJY=;
 b=AiEl+WyYmqUYmm5TcXiMDLLXg+CIekqF988pYvOj1/2WxetX5PudayHWTTolv1bjVJlEODeopEV2duPFiCvs3cFwXQVOhm1I2P1c/fxYpg4SpX59ZdwRjT07HgkcFRGegT2V1PQx+jUGeY4V7AlvYbi845HtSWDgHeaJx37KnqCBTiyiejNLkVHAxqb7EusD54Z5F3nyP3dR2GjF3LgwgLwZJn5WYVYqmmw6/pYNA+BW3Z+X4ZFOVV8+D87OEby3LGn65zdvdNpJYLYFfhMGqrwiSfPPowDzFbW7Gl+KkOL4CQJ0bsqk1SbNH7EFyPN4ve89vDYEYY6iewVAnTgR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BkhwOZh95ILzwMfzqorfsVv88/UUOZe2Z1+dkGiTJY=;
 b=RqdmC3yjYJAsncmDr5sNTNegv9zkzzYvkawYL0BnYN/zO3gUz+uTmamOf/joFQyvy83r5az+z394SBg9UjQls+2T51ZUDnJAnw9gjZrLQp34C7QSMS41kjbWUCUZI323Z4NArIEEt4fkyc7uQzdSKwFMGeucitioy3LWH2P8NkM=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 14:29:37 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 14:29:36 +0000
Message-ID: <eb560e37-0eb1-4f11-a9c8-866562b178ed@oracle.com>
Date: Mon, 14 Sep 2026 15:29:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 01/18] btf: Extend UAPI to support BTF
 location (inline site) info
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
        nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-2-alan.maguire@oracle.com> <aqRVysZxIpP5lSOT@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aqRVysZxIpP5lSOT@krava>
X-ClientProxiedBy: DO3P289CA0016.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1e::18) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: d345bc5a-bcd3-45c4-0a1e-08df126c9a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|366016|376014|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003|4133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nCPFEm11tH5i7I9E9loD6/i/SoXLISOZc8GkIerbhUlXR5KBX1u5bmO1kNTfZpCb8+3D/CCHynZZ57oZ/Kcq2QGR1pP5trAbkP0+mlfvgef5NY1x8uYnDkRYcCChdh7MkFBkhdP/H9LiRM9U9kvAixFkX89pTK8B85X2pZ0RGwMsfWo4qnq1+crGZmuj3IagAP0f3Lx+2+iJyZHJ6/iWQI58btXDB4mBmsySlLFn80EQm4cwJJ+I8LU4P7wq9cGbYKRXYe1/LcBOJjR5Lkp86SZJ/yib/XYSkIbOJXcgX9lPCWT11eCpuNrVq92mQ8iRefamPnhCExQuDSyJt6wJtq9pKLqPIEh3mHk6+0iZiw1Ezm5dQKHLF0qt3xKyc2DlC5PIU4jbKIWWU2Hii8iRsWnen0+U4MMkFnZ8Lou9CMVkDx8arQgabgrZTEK3Zokhbi6hQEX9m+FieYarYwZEztKMFHPL0bxRR6Cn4yN9o2aecP1MgtZBbIAopGixejRGEMJ8EORPsyGlu8SuFdgZfmRMeK3XEMqbAdnhymDDdLiqvoccxs+EiGCe1CmOzFbnD5C9eDaXWSnEqh91Fbi6tNWR0yLo2N0hg0GTAihsUwpTS2hN/z2iIoHEexeCExXY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(376014)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(4133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U05hNlY5L256ZDE0SnJyS0Y4elBPVTBjcTMzTytYejV1M3BROXU4T1ZSSkFO?=
 =?utf-8?B?VHdIRzcxNHlIc0ZoOGZnZFk2eHR4ZnJ6eEZIR3RzNTRIU1VCYTNocGpqeVBQ?=
 =?utf-8?B?WUhYWmJNRy9Ld0oxbmp2UEVsUXJMM1Qwd2I5RURoak9OcDh6L0RaYmFoU3ZT?=
 =?utf-8?B?T3Z3QlY5RmlYR29FY2p2MjhXM29RMzFqSkcveEtibFJYWUlyNm9TdFZ0bzFS?=
 =?utf-8?B?UnNPMitIaUZkZ1ZBaUlRSkR6bU53VGJIQlBieTEwRU0weHAxYy9ZSTNXTGpa?=
 =?utf-8?B?UHpLU29sMFk3RWVDbzRUTHBGMlFyWGZFSEJNNkNnTlRBU05ndmRORnpzSnVE?=
 =?utf-8?B?SkVhYllvWHZpQjcyM1V3NlJSTkc4VzhFdTllRXJ6SG1DYldnY2RNTVZBdXhQ?=
 =?utf-8?B?TkxhSVk4SlNNVWd0WXVOMDhyQU42eHVUYStsWHV0YWhVcVhGMEZPdGZwUFRm?=
 =?utf-8?B?N1pxZFdjMG1OQkJMK0NpeUI1eUt1VDI3L1NEaENNSDV4VHZWYVI0OUFiNy83?=
 =?utf-8?B?N2JIdzNKSFU2MS94QjR4YlhPVXdNa3Y2Z3dQMURwRHV5V3JodmtuVlhDU3Fi?=
 =?utf-8?B?dnVma0J2RWp4aHZRbGhjTVlFcVVaalgzeDhNYkh6d0h6dytObUtObVluTjBW?=
 =?utf-8?B?ZU1jdEZBZmR5VS92SWlYNDN0NUZLQjkvR0ZsR2JVMTNjUExERll4V1RkcnJV?=
 =?utf-8?B?VmlXVnFnVEdRL0NnOXpDTzh5L1o3aFdZcmJ1M09WSnlBZXYxQWd4TUxwVE94?=
 =?utf-8?B?L2UrVzN0MXlQOXV0cHl6QlNaTWZ1VGdmU1lmb3lwcXdnTHdRSnJqNnZqdGVj?=
 =?utf-8?B?ZzNFT21QQU9qekU4WDdZRlY2ZTJpcGFPY01JS01YTUh0V0I0dG5iYzhSQ1or?=
 =?utf-8?B?NjZwYkRKK2QyaG5NNXNWWlBKKzhkLzVPOHJmQVpNSWROWm9QUU9jcmRPWElI?=
 =?utf-8?B?V05mWkRxSE0zaGE5VFlPQ2NqWGpHZjV0cE5oZjU2L0wrb291THQzckpUZ3Zq?=
 =?utf-8?B?T3lybGdOc1dLRTJPRi9GM2JWd2RnUFdyTzlHRFpnT0Y2NFcxTXczZ2FpK1ZL?=
 =?utf-8?B?bUpwYWcydXBhcEJhOXdMZE4yZGhXOWFsQS90OGJya3V5YjZneFo0YUVLYTdQ?=
 =?utf-8?B?SjhCMElXeW9DYllxb24wNzY0TTNkTEhLZGZzMHp4WlFUaDZhbXRUcFNJZjVL?=
 =?utf-8?B?ZVAvK2M5Rk5HVWxQSlIzdDdwQ0dxcXAwemhnTVRGa3NyQzMySCtVZ2ovR2s4?=
 =?utf-8?B?L2tGdXErK2VsQjl4RUdhaDNiaUtOY3kxcHR3SWpjSzhyQzhKVjNVdk0zTk5S?=
 =?utf-8?B?L3RHRVR2TzQvRHUrZ0ozTEVGRUhGWjhQRGdQK0syZ0srSEVhQXd0TDBuVEY4?=
 =?utf-8?B?N2ZHSEV5SlZpaTkzcEF6b0YwTjhsTUJ0Tmt3cDRWRFZFaGVaZWpRNGsxMmJO?=
 =?utf-8?B?dkJUd1lDaXRwSVZ6bm0zeHR5TVQrMnRuc0ZFaCtkU1RwTGhTNWNnVVoydW03?=
 =?utf-8?B?dnExZXRCOE42ZE13L095eWVvK1k5WkgxSnlKUmlqdHFpZ2p6MzZIN2xtdi94?=
 =?utf-8?B?MzB4c25ZOGtRd3Y2d0hCOWYraGZLQzVhRzl4Zk1PYS9XaUgyZjM1MEpnZytC?=
 =?utf-8?B?ZU8zc2szSGwzMzZqWXRRdkgyMEdaY0t6ZmJJZjh1RWVXSmYxUEdTTzE4THBQ?=
 =?utf-8?B?VVc3MW5UWmd6ZDhiOXMxazZYSnBBWXhBSGoxTEhNRFh3c1Z5Mjl6NkFEaWlp?=
 =?utf-8?B?NXdKOGJXczlKUHlyYkV0TGxYSUpyR0ZVUEY0bXNSSTFKMlRXaitDRUN3Smdk?=
 =?utf-8?B?VWRDUjkyTk9FQWE3WTVPS2dvd0Rtc2QvU090M3RCS2FkQW14NGZwb2hQMVIw?=
 =?utf-8?B?amNsKzc3Q0owVll6UTcwYnNscHd5ZzhXN045Q3VBOXN5Sml3UEY2QUNJY1Y2?=
 =?utf-8?B?aUgxaXptemVIMmpEMVIwNW5ONW81cEVxQi84dUpKZjZHUlpzbkdXYlZ5UlNu?=
 =?utf-8?B?blFRQ3ZNSmdDMFpzMElvTHBPZHhHalFyWUsraGF0VzJ1Wnc4R1crbEN6eEtN?=
 =?utf-8?B?bDhNUE9ORDIzd0tLVkNSeGhqYXAyTU4zV0JmejZQbHJ1Ump1TlRrbWlGWXJq?=
 =?utf-8?B?bEpUTkFQMENJN2FxUU4rZmJNVTJpUEptamsxbWRyeHFhMzB6ZUZtUzZQcGRk?=
 =?utf-8?B?d09ZYkwxMWkreHB3Vk9PRlptdjErM0RtK0tJMVJmNFIybG1nMDV3WXh1WmRL?=
 =?utf-8?B?MzEzWTM4QXFmZG4rVTV4b3RKRGtqYTNoV1FSNDhaMmg2Y0dkbk9ETjhRYlpS?=
 =?utf-8?B?M1MwckloelZGVEtyMm4rVVdCdnB2Q2g1SnB1bVExc3pEcWpJNXlKdz09?=
X-Exchange-RoutingPolicyChecked:
	rGaQ52345hS25oDMiO6BqQHyAVgDx33DZ/P1iwA6VspJNb6+jL/X9yxQhjvtd3dFvmnWWR70YixR02nQQtBYGVK+nORJe/I5AoRS+ua2YG7B9+IckoFey3IBT/65LQqCgp6/DqPWZuMZ/jIscZwx/2QGjmBTCJEd4Gnanmw6iR5j5qUTypas05JBvugpVYSTN4VmdaVAD4gwAWF0RjIpwAN1i/WfgXUNPixy7ZUXYcQwFDh4w3IRXEbe8J1U44ffo+ggpJKbQJla1lko7uTaxS+5VuTm89ehGSvQXfrs4e00F+2fhe7kB+G4C/hBFpmWBRTGcFN8Ve89gBI9H2f8dA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/tQY6j53HZm5ri4hhuGesEAUKM3APs0P8Zxuvp/Ih+uptte75hSkBz0rwU7d+ryo+KhCYbDBb4SYQg3ZTYBiWqyq+JWyafhIV681cTxbFh0lzArrOyxMhEv03LUSl2YvHulWTBWOk0WWEvJMcjXewj2HVrjdWGSq4uVT9jpHGrbS2tXBGm0Gk8DAhCfrHNuzTC5cyihxKG8WJjH8ZGW16w4BOSxHanXOiVGkBIfc/sVzkk3HYpDa3B0Ro6LGKcmsA/Yfi0lpUwNTYI7YLAf52P3r9T1YDLVmvzG0xpaABQHZ72iAF7EEABe8kUnl3/2R+h1FMFmPRGtyrcsiQ+PUFqoQiY47INsT0H4eesJporQy4RdW3Bv6s2zqUSaExyIH7Y/arL+DRwgjKxCEjSk4dKTG+uk7CT8RAtLrak6W2u2/ABbjKsunRIO75xF88+CnykRg03QOJJtCSoDB+T72eZ2V8vJFJqmyLY6JHFcsXQMnkNBU2MSPpJfpDgKZop4tGykewL3sVUoAm2HoZ9AAzwa8Hdr+BPZfHeEVo9OwxzxJx+ToS6fVrcpCy/rKOCD1wtgxFCPG+taDeXfrPx1xEiCwjjsG+sLr7DgB9UoBFiQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d345bc5a-bcd3-45c4-0a1e-08df126c9a50
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:29:36.7451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95XC1vl+rV/UFw+WqzTYP1d5Klxyreo349rcf3ERJ17RBOGq/h5DtsWBvemX7/2soApfMx2tFR4yFEKgN5UAmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609140208
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwNiBTYWx0ZWRfX93PhnSSgnOS2
 wveg15+PVgO8L4pZFLBGCaw6vDdI6CP/+TLmk+7SmD66mvirnBANt2AYOkxfgdhpH6Hmyub00UN
 K79kphQ6Cb2GywK5JODNqUf/Kakg9HX/khaaD0P5kJk+lZLI1NOjb6rumUhevvYwVXBiZR7B822
 YlB5DKeTEYE/oN1mq2Qs1cMv8tq3PK4NPVXwdWGc+nD0IB0goKgwoFnBeN6tKsnpRMZLaV0OodO
 d62Z3zPraSS7mcUzqsAZH1BDtzV5OR+C35r/yIomsgyb6q3hPO/f+bIC7WpYD0PPLrnJ5Clh+RK
 LiJaOhoWqX6a3j3RHtHpYRmHHpS+WCJvsZrAZPTe/Qatd/DzsDJYZfJam8YWaZCT6ZTzBVllkb0
 xwm3gg8gVjFLRtP+re0Jectuu+dajY4FxoIVpWlveyP2K83heXNZBF2BIjAIiDxSQeOB0fHpO0s
 gCIw9sTZh1JysQJ1i9wQcawmOtipTQSbYlVqW860=
X-Proofpoint-ORIG-GUID: xzUuH1ra6sNw6WLvzdJxgmiB9phVB3RF
X-Proofpoint-GUID: xzUuH1ra6sNw6WLvzdJxgmiB9phVB3RF
X-Authority-Analysis: v=2.4 cv=HPhWhYtv c=1 sm=1 tr=0 ts=6aa8050d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=RpNjiQI2AAAA:8
 a=w3zyBCzKu8VyveJjs_MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13533
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwNiBTYWx0ZWRfX/BnBpNeMnckB
 dLMlb8Pb+m8MLjdFV4/gzdu2pttEFLT5EQx71gTcMdmNkJ/9ptio6CQlaDQOM3cUFM/RmKUTyGb
 9C//SVBJM2hYZ9BqIQszjaN7WzdDz8ELLAhaR+MZCzjXf4lkALag

On 11/09/2026 20:26, Jiri Olsa wrote:
> On Tue, Sep 01, 2026 at 05:=E2=80=8A57:=E2=80=8A40PM +0100, Alan Maguire =
wrote: SNIP > + > +/* > + * BTF_KIND_LOC_PROTO specifies location prototype=
s; i.=E2=80=8Ae. how locations relate > + * to parameters; a struct btf_typ=
e of BTF_KIND_LOC_PROTO is followed
>=20
>=20
> On Tue, Sep 01, 2026 at 05:57:40PM +0100, Alan Maguire wrote:
>=20
> SNIP
>=20
>> +
>> +/*
>> + * BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations=
 relate
>> + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed b=
y a
>> + * a vlen-specified number of __u32 BTF type ids which specify the asso=
ciated
>> + * BTF_KIND_LOC_PARAM for each function parameter associated with the
>> + * location.  The type should either be 0 (no location info) or point at
>> + * a BTF_KIND_LOC_PARAM.
>> + */
>> +
>> +/*
>> + * BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
>> + * containing location site-specific information;
>> + *
>> + * - function (func)
>> + * - location prototype type id (loc_proto)
>> + * - address offset (offset) relative to kernel base address
>> + */
>> +
>> +struct btf_loc {
>> +	__u32 func;
>> +	__u32 loc_proto;
>> +	__u32 offset;
>> +};
>=20
> would it be possible to include btf id of the immediate parent function?
> we have use cases for tracing just inlined function called from particular
> parent
>=20
> I thought we could use the location offset for that, but because inline
> functions could be nested, this seems like hard search.. also we do not
> know the size of the inlined code, so not sure how reliable it'd be
>=20
> I checked the dwarves code and I wonder we could instead store parent
> function (struct inline_expansion) during dwarf decoding and use that
> later to get parent function FUNC_ID and have:
>=20
> 	struct btf_loc {
> 	     __u32 func;
> 	     __u32 parent;
> 	     __u32 loc_proto;
> 	     __u32 offset;
> 	};
>=20
> wdyt? thanks,

hi Jiri,

So in the case of encoding the immediate parent it is quite expensive -
my concern is that adding it as an extra field is another 4 bytes per BTF
location, and because there are a lot of inline sites that would mean
somewhere in the region of 4 * 500000 =3D 2Mb extra. This is the tricky part
with this stuff; even small per-site tweaks really add up.

Is the immediacy of the parent-child relationship a dealbreaker for your
use-case? As you say the offset can tell us the function B was inlined
within the bounds of uninlined function A, but it won't tell us if it was
via function C. The other thing that complicates this is that an inlining
doesn't always have a size; it can be inlined in a non-contiguous manner.
So in some ways maybe the best we can do anyway is to be able to say a
function was inlined in a particular uninlined function?

Alan
