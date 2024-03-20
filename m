Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A053FE2C
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939301; cv=fail; b=nEPx4NQsrzlQqGcK0FWFF9YbCyYBcYk3ILidXoNzwHTbzVE/Y5j6Qb5WPb9lS5vtUz5OyuXtwCI5Zvg2P2ipaHlt8E1s5XP9Fg3tZyrL79DPgm7DKKA4dGFGvBF11XWAxKoocybLjqzD6YEdyiHHf8WBlUtIsnjoYV/vyy85iwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939301; c=relaxed/simple;
	bh=5J+EWd5bTY0WhUnV6Wnq5TIUSt2OP0VxepqQsgQ56I0=;
	h=Content-Type:Message-ID:Date:From:Subject:To:Cc:References:
	 In-Reply-To:MIME-Version; b=GY6VY7VhJqSFUnRiquM9Mw0IuFyeW26AWvnZakeU82NBRNgKjBqUGmzyPR+UKDAl61MyTf/fe6E/9pOW4j5nUL6ddQnJDtrLg8x1LizJXRduk9O2VoEOtRe/KmoEngTEzlxiO27CqR6D0neGLZVWcECa5q8vmPJGS0Mn8KnI3xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lwsclgku; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XIbRreBk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lwsclgku";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XIbRreBk"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42KBxRVs028175;
	Wed, 20 Mar 2024 12:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 message-id : date : from : subject : to : cc : references : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=wT6w0HIguDuPcXIreyZzJ7WEBZm01d57PAAnYYrYnhw=;
 b=LwsclgkuBcLHdZCIrU5Snt52A8ENoGfkrV4UKI4AQ3DX7U5hzXeOnA5glrt534+cK+ve
 WRMzk420c/YkE6feDgzIf0C6Vx0XbZgbMDVPS7VO6vE4NQ2XJ36CnK9O7xX9NBR5GeLE
 7eCPky2rLis6J9y9vBm70DPtLPRCeN0B+uGHA776EDH2dg9fm1b16yqjuqc9tcxsZ8cY
 n+tl3TE/Dimy+mvVzyxJnrAL3MqPaRSkcN1QrQW0BiIGeLiPKVH2rxAGAMGbVQJJVl1u
 TZ/70TPExi64Hwg+5KK1hZ0hTnMGVogbLnfP2p6LfCze7XPH464pYAQzBceoGXMqOl2P xQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aafw47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 12:54:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42KCGlG6019588;
	Wed, 20 Mar 2024 12:54:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v7q2ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 12:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGuvb1GI8cwiGifxQPIxM43vrJoCBFOlwFBRz714O+9INmx+1CDcYkdcIMtxej6X08xvyqH9tpgA5zf2pj67g164YJC92/HtcZdd48927a1WLfQfWjUcBk6XPBJZ1fU/TH2gtRSu4gsrxjV4Osq2v57oyi9OKT+vkw+dQx9z3xZc7uRoC14G1dZGScmE6bdH0P6Awx/td4FPY9bR3BwVNMCKPH4k5X8Ys6Nsbh4HZTpOjbwNfL1hzVDY1c0ulKAJAuoW5TLkfygepSJ4Dghil8yGbMvXSZ+1VCAQk/5TJXQWT+ZKhfXhMI5HeV1gOY6eLfuF4YaC47lw0i37fsFNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT6w0HIguDuPcXIreyZzJ7WEBZm01d57PAAnYYrYnhw=;
 b=CjRw88niS/WSOgPMcg3jlTwBAOudvdO9bOZZsQSsWGu8f6gH7gFuAZTcPX4GQe/tJz/TZw/V2tBZvW4b9ZNw3o4RKC5zKu5MaAHwSdGHYRtsq48tf/+HbikbI7hdSOUo3PoL9aYu9HCDL77iSUSwPp/XH7eDylFDfeRkugREIGZMgM70bQeSaq2sBxncRKpUbCgr5MbE92Okg+Pge4D/cxtQKl5NHKavKyyi0LJZCUf9JKcHgnCQqUHYCnL+KcZAODRgUJ+0MFx3ckHZA/tV4prRB6+910CFwrvm1q8O0xdi5lfDxIiikKIZcZ5+RxCKirK+CWjOv4GY71ZZqP6w8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT6w0HIguDuPcXIreyZzJ7WEBZm01d57PAAnYYrYnhw=;
 b=XIbRreBkZnktvO28FgC3UiNr9F4N2i7MG+Cmb21CXAQqyAyfUqfUkvwyJ3/OhJDL5HRgHc+Ll8TW4uk/PaOFY+yQdB7YQFlfZcUOoRmDdgioS5guXIfe4agIxD9nLVV6fisPVqJ1PvGimYYPXuZ5z4MBNoZ8gKhj4jsF5ZE81ac=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5006.namprd10.prod.outlook.com (2603:10b6:5:3a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.35; Wed, 20 Mar
 2024 12:54:15 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 12:54:15 +0000
Content-Type: multipart/mixed; boundary="------------93E2bcJ688PL4aBr3ZQnkk0S"
Message-ID: <6c178658-d5b3-4b71-b385-5ba95349c8ab@oracle.com>
Date: Wed, 20 Mar 2024 12:54:11 +0000
User-Agent: Mozilla Thunderbird
From: Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves v5 2/2] pahole: Inject kfunc decl tags into BTF
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org,
        quentin@isovalent.com, eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org
References: <cover.1710532093.git.dxu@dxuuu.xyz>
 <088c4362fa9f080c319df7c49bc6a4e1b6ae98e7.1710532093.git.dxu@dxuuu.xyz>
Content-Language: en-GB
In-Reply-To: <088c4362fa9f080c319df7c49bc6a4e1b6ae98e7.1710532093.git.dxu@dxuuu.xyz>
X-ClientProxiedBy: LNXP265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: b2386d2b-3c26-40a4-9f0c-08dc48dcd92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/7Qfc6KZpTq0vVxMK6Kgo355R5oGfrTzVCvslXtJfeB+xGlWfTYJ+N+WmYyccvNRyULlmtFcfxTclL4eThJSeINduGi0QrCKtn01ucLZUA3c1d7hQdrAMYrU/w6oMzsdHry4/HZzHNMKrUUYWHVD8H4reDtptxwvpIbDkyF7ygdyZU/611aFU/6HxQ/AUmwAX8Y8j8mGEIv6b8spKJ1dgZXB8+JnCocHQobIM/5fWIT3WKbcpyZ+1O/QcoTCahZWoOHXVPMsmVD9+YgtNY9SZb2HlySAXTCSQsOLMOvTkk7vKySOPW/2J9X4cBnIOf2P1v8IrGWdYFDD+CZv/rNHtMQmUDJaxX9Jm77ODSUYc4BTwLq8yNw+78/jQgEm8jyqufq95OZij7zwZtwRNp6K3tHR1Rm2i6hQH5O77iX+UhkCloXp866medpWPeA7yUobpGN+QJ5sSkQWLumCcZuM15ZTezzzPJU43lDtwP4KSJz5AppV52iM3eAd2n8+kG6Oo7kcUEC8nkQDyh3vWSVDfU8wM/LjsPm6OIcu47z2Iq03WL/vLs2xP01q7yE1IIbGRzvdohcyz7xeZgBGZctDLpsw7x8ISHACwQoEoZSF0wICBntO3gC9DGq0SOqHXdAowSDXdTvUoYO8vsWIvtc50r36uFX9EPCZrbKOoYAibJw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QnBXekpzcVV2cHZUVFByRzNTbGFqbUpvcmpNMFFsYUl5RzFlbENvWmdEbFlI?=
 =?utf-8?B?REVqWUErbTlYd1FFUjRDdkF5d0V2T2ZadEoxSWlmQytsQjJ4VXQwaGhzejZ6?=
 =?utf-8?B?cjZNcS9KRFJLUHVSRW84ZnQ0VG9Oa3VDdHBRR3RtS2k4elltUDgwem50a3VP?=
 =?utf-8?B?djdjdWtCMlFyejBCdmVkQmlNMkkzZjJMNWxyR25Jclk4WUNlK0FKTGxnS3ow?=
 =?utf-8?B?emZVNjN2S2V1Y3FISzRxSEtiMit1N29Kb1A1czB5MVdsWHhxcmRmTzNabDBH?=
 =?utf-8?B?MTBaS3k0VUJSOHNqL0dGbEdDcFJLcVhmQkZyYWp4VTZqVGtzOTQxRlh1SGpE?=
 =?utf-8?B?Qm5JelRwdDF5QU5BMGlhdXlJMC83blZUdmo5ZmV4d1hhQzZQVDBXcm1TSjBQ?=
 =?utf-8?B?UXU5d2dVMUJuaFFMT3VTQTJIQmtIbWdWajhZVXh5UEhqeC9kMUZMT0FLc3RB?=
 =?utf-8?B?Zll1b0ZkenBCMzdSeDVQUndPZitOaVdyVHVUSWVzYkpQdWFMWlhoNURpRUpX?=
 =?utf-8?B?MzdXdVV5Q1VjTHZTbzRqSFNGZXNrR1V0N2VxaXROVFV5TzRwKzdBNldyMks3?=
 =?utf-8?B?K0NZY0FZbWx0TFNGODI1RDdCUTR6S2MwMzQvamRjaXB1ZkxSMlc2Z2wyQVZF?=
 =?utf-8?B?b3BYeG82NjhweXY2WDhad3pFK3hpcGJJb0ZFbUZFL3FaeWYyeEpxcDhHb0NE?=
 =?utf-8?B?bGo5SEx2QWs2Y1MrMVY2eFNIS0ZUeDllb3J1dE9GR0wyczJDQXYzbHRyanlm?=
 =?utf-8?B?emhEUzZ5S2pQRjBMdzhRWHJvRThlQUsvR0ZTblNRQit0Rng0bTNNUlZrMHQ1?=
 =?utf-8?B?N0hud1RPaFMzZzl0NjlYVVdjdzdtSUdNNEJTc3dLLyt1d3lzVVVJTG9na1Ev?=
 =?utf-8?B?YUxITDU1cjhNT21zdEgzZXdRbzBjQ3FQdzdJSENwZGRqNmxyMGlRZmVEL0Ju?=
 =?utf-8?B?YXhMcGNyM1JobVB5cjlaUEdmam96OVdwVDkxQ3hEY2xHejIvT1lHWFgwL1V0?=
 =?utf-8?B?ZWVWQnNCN3p3RC9YM0hWY3ByM1FNREIxQ2hVamQrS3gzWElkem44eEVPbjBV?=
 =?utf-8?B?UGIrQXo3eFNzVE92dTA3bVhmZFlkQlJtQWtLWFpSTnAydTBlRmNocFhyNW5j?=
 =?utf-8?B?a2ZTK3ZlaGtJMXBYRFRaSHJ0WlcvZWRra3REeGNtKzdkSTB4Z1pWaWd6KytQ?=
 =?utf-8?B?UWhDbkxKWVd4ZjlNVzE5OVBscDBiZGR0UUEzTEtMRGNkTHB4WG50QkpzaTJE?=
 =?utf-8?B?emFhZXRkbEIwaU1WMXQvU3hnOGZLdkYzQXQ1cUYwaXp3OUNQcTBrU1BBM0x5?=
 =?utf-8?B?WVRJcG1sczE2cm5Bc09zK29RNE9seTRsd0NtUG5NK1o5ZDRlNFp3eGZMb1Nu?=
 =?utf-8?B?RnowNll3WjlkeHFoSWVmT1ZLcTVrd0V0YUkyazdvcmY2NmhKb0JkVmlhZkx0?=
 =?utf-8?B?alpHTEFpQVlZYk1QN0F3VEpEWXBhbVdidEF1LzN2RjkwTnN1NU1ZeEtjWGJE?=
 =?utf-8?B?OFJIbmJPRDhLM1N4a0sySy81MWFBNUhVUG9TbEVLS1NRWHJSemVrMzhkU2Yw?=
 =?utf-8?B?TitXaGgra09xTFFUTmx4cnhmajV0cUNOTk1OTUtSWCs3L2c1dU5BM1RtcjZs?=
 =?utf-8?B?cXF0d3lqclZhQ1hSOVFtR1BoRGd2Zk5yR1ByWDJuSndxTFpWd0xueUFzU3Zi?=
 =?utf-8?B?bTNadDRFTTJEeHJiZUpHaTJ0bjJJbUN2aUFIUytORFk5Q01oUWhNQmRvNGFH?=
 =?utf-8?B?RlgrOGxMcEc0NCtLOUtsWTk2cmdsTjlUSFJlTVRGUUFCYjZLWWlnKzdBcVor?=
 =?utf-8?B?ejZrY3VCcm1zZ1lBbVpwLzJTSnppdGxTU3l6cXpBYVFlWC9lQWVsRzNjUEtL?=
 =?utf-8?B?Wno0R3JhTnNWekY0bERUbWdlcHpZdVZ0VWE2cDFMOEtmcmo5ZjdrYjdmRGVh?=
 =?utf-8?B?OG96a2E2blYyUzVSNmorOHRxbXAyQzEyVGhEZlNKYnhLbW5tVStobFZMNS85?=
 =?utf-8?B?dWswUDZWWVBaUy9DRC91dERoWWx4aFJNSGRyNFZDN2crK2p5eGQvbFV1UWNU?=
 =?utf-8?B?WkhrWmRUaS9PNjA5K1NiZ2VhWXFsQUpIbndFcWVsRFlkRzFGT2dVTDdvMDVy?=
 =?utf-8?B?dzk1MFhDa0FQd3loUUg4cnppTDVzL2lwclorc0ZKeE8vR2tFTUxsNFFqZU4z?=
 =?utf-8?Q?4zDZnIoAYg0qCvroe919CBM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dzSKoh8Xpa7Uz/8zC9x5Pkcw/XT0Gj2i3O6YtWMz0YMeURNWLmZ1f218JuEy/94GX+MvwKemtdETKO+xB/fj/Gu+JncWSd6wO6RiH5CG7FlkV9TyBlSzS8vfhTLr/2JoVk8jfRErdzaOjPHblYGTmVYso1wq5dPiF0bmQ5RLKU/J0Om2e3EbNlrYn8FdwOyxhT6+CzL4w7I38lkVXqTujHYnUVjD+njIFiER/hKxJcILdoIcSN8EMibFxWelnxTxD1VPrLvJ+/GuaRsG+htKmkMHFLiWvwNxOlf65fjQKvUJMXYFH3LVWt1q1L4RCV1GsDu3j7W8wZKIzn1w22oFiuqoVSTaWzruuIN+lSsWIm5D6b9eG+UAm+dqLktUNTVgA7t9s3I+S49UT2eHKmXLNtkmMF4/lVSaN+xBDZO08eZ18Vbih2yW1BCf3jswHGGSyT3yUJN6BJP/x5ToL/ViVy8xqmFv9PLdQZGqV2LNHgNbVQSKFAIG9iz4P+x4F98DUu47+hGgbySdUtbewW2k1+bsvVJuZBNX6XDA4uNAMGkwMNKX6a0PcOJtSoPEfc68Rftt3G1Hu85rStgqk8SOctktLMbcRqpDNqCWpE2mEJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2386d2b-3c26-40a4-9f0c-08dc48dcd92a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 12:54:15.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4Uo5HPBkTvf4rruBA72HkjdzFSWzvvKuIWyEs0droUbG1sV+YMBFxoOL6KHNi1nOA6HRp2EJSNo2wlIBu+BsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200102
X-Proofpoint-ORIG-GUID: gkMppOTv18rk-d8MSscIOrrKOIkyWPi-
X-Proofpoint-GUID: gkMppOTv18rk-d8MSscIOrrKOIkyWPi-

--------------93E2bcJ688PL4aBr3ZQnkk0S
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 19:48, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> 
> Example of encoding:
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
>         121
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
>         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> 
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
> 
> This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

This is great work; a lot of steps needed to collect this info, but it's
really valuable!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

BTW we need something like the attached patch to switch to using
--btf_features for pahole 1.26 and later; will I send it officially or
do you have something that does the same that you want to roll into your
bpf-next series? Let me know what works from your side. Thanks!

> ---
>  btf_encoder.c | 368 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 368 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 850e36f..31848e2 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -34,6 +34,21 @@
>  #include <pthread.h>
>  
>  #define BTF_ENCODER_MAX_PROTO	512
> +#define BTF_IDS_SECTION		".BTF_ids"
> +#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> +#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
> +#define BTF_SET8_KFUNCS		(1 << 0)
> +#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
> +
> +/* Adapted from include/linux/btf_ids.h */
> +struct btf_id_set8 {
> +        uint32_t cnt;
> +        uint32_t flags;
> +        struct {
> +                uint32_t id;
> +                uint32_t flags;
> +        } pairs[];
> +};
>  
>  /* state used to do later encoding of saved functions */
>  struct btf_encoder_state {
> @@ -75,6 +90,7 @@ struct btf_encoder {
>  			  verbose,
>  			  force,
>  			  gen_floats,
> +			  skip_encoding_decl_tag,
>  			  tag_kfuncs,
>  			  is_rel;
>  	uint32_t	  array_index_id;
> @@ -94,6 +110,17 @@ struct btf_encoder {
>  	} functions;
>  };
>  
> +struct btf_func {
> +	const char *name;
> +	int	    type_id;
> +};
> +
> +/* Half open interval representing range of addresses containing kfuncs */
> +struct btf_kfunc_set_range {
> +	size_t start;
> +	size_t end;
> +};
> +
>  static LIST_HEAD(encoders);
>  static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
>  
> @@ -1363,8 +1390,339 @@ out:
>  	return err;
>  }
>  
> +/* Returns if `sym` points to a kfunc set */
> +static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
> +{
> +	void *ptr = idlist->d_buf;
> +	struct btf_id_set8 *set;
> +	bool is_set8;
> +	int off;
> +
> +	/* kfuncs are only found in BTF_SET8's */
> +	is_set8 = !strncmp(name, BTF_ID_SET8_PFX, sizeof(BTF_ID_SET8_PFX) - 1);
> +	if (!is_set8)
> +		return false;
> +
> +	off = sym->st_value - idlist_addr;
> +	if (off >= idlist->d_size) {
> +		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
> +		return false;
> +	}
> +
> +	/* Check the set8 flags to see if it was marked as kfunc */
> +	set = ptr + off;
> +	return set->flags & BTF_SET8_KFUNCS;
> +}
> +
> +/*
> + * Parse BTF_ID symbol and return the func name.
> + *
> + * Returns:
> + *	Caller-owned string containing func name if successful.
> + *	NULL if !func or on error.
> + */
> +static char *get_func_name(const char *sym)
> +{
> +	char *func, *end;
> +
> +	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
> +		return NULL;
> +
> +	/* Strip prefix */
> +	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> +	if (strlen(func) < 2) {
> +                free(func);
> +                return NULL;
> +        }
> +
> +	/* Strip suffix */
> +	end = strrchr(func, '_');
> +	if (!end || *(end - 1) != '_') {
> +		free(func);
> +		return NULL;
> +	}
> +	*(end - 1) = '\0';
> +
> +	return func;
> +}
> +
> +static int btf_func_cmp(const void *_a, const void *_b)
> +{
> +	const struct btf_func *a = _a;
> +	const struct btf_func *b = _b;
> +
> +	return strcmp(a->name, b->name);
> +}
> +
> +/*
> + * Collects all functions described in BTF.
> + * Returns non-zero on error.
> + */
> +static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder, struct gobuffer *funcs)
> +{
> +	struct btf *btf = encoder->btf;
> +	int nr_types, type_id;
> +	int err = -1;
> +
> +	/* First collect all the func entries into an array */
> +	nr_types = btf__type_cnt(btf);
> +	for (type_id = 1; type_id < nr_types; type_id++) {
> +		const struct btf_type *type;
> +		struct btf_func func = {};
> +		const char *name;
> +
> +		type = btf__type_by_id(btf, type_id);
> +		if (!type) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
> +				__func__, type_id);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (!btf_is_func(type))
> +			continue;
> +
> +		name = btf__name_by_offset(btf, type->name_off);
> +		if (!name) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
> +				__func__, type_id);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		func.name = name;
> +		func.type_id = type_id;
> +		err = gobuffer__add(funcs, &func, sizeof(func));
> +		if (err < 0)
> +			goto out;
> +	}
> +
> +	/* Now that we've collected funcs, sort them by name */
> +	qsort((void *)gobuffer__entries(funcs), gobuffer__nr_entries(funcs),
> +	      sizeof(struct btf_func), btf_func_cmp);
> +
> +	err = 0;
> +out:
> +	return err;
> +}
> +
> +static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc)
> +{
> +	struct btf_func key = { .name = kfunc };
> +	struct btf *btf = encoder->btf;
> +	struct btf_func *target;
> +	const void *base;
> +	unsigned int cnt;
> +	int err = -1;
> +
> +	base = gobuffer__entries(funcs);
> +	cnt = gobuffer__nr_entries(funcs);
> +	target = bsearch(&key, base, cnt, sizeof(key), btf_func_cmp);
> +	if (!target) {
> +		fprintf(stderr, "%s: failed to find kfunc '%s' in BTF\n", __func__, kfunc);
> +		goto out;
> +	}
> +
> +	/* Note we are unconditionally adding the btf_decl_tag even
> +	 * though vmlinux may already contain btf_decl_tags for kfuncs.
> +	 * We are ok to do this b/c we will later btf__dedup() to remove
> +	 * any duplicates.
> +	 */
> +	err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, -1);
> +	if (err < 0) {
> +		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
> +			__func__, kfunc, err);
> +		goto out;
> +	}
> +
> +	err = 0;
> +out:
> +	return err;
> +}
> +
> +static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> +{
> +	const char *filename = encoder->filename;
> +	struct gobuffer btf_kfunc_ranges = {};
> +	struct gobuffer btf_funcs = {};
> +	Elf_Data *symbols = NULL;
> +	Elf_Data *idlist = NULL;
> +	Elf_Scn *symscn = NULL;
> +	int symbols_shndx = -1;
> +	size_t idlist_addr = 0;
> +	int fd = -1, err = -1;
> +	int idlist_shndx = -1;
> +	size_t strtabidx = 0;
> +	Elf_Scn *scn = NULL;
> +	Elf *elf = NULL;
> +	GElf_Shdr shdr;
> +	size_t strndx;
> +	char *secname;
> +	int nr_syms;
> +	int i = 0;
> +
> +	fd = open(filename, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "Cannot open %s\n", filename);
> +		goto out;
> +	}
> +
> +	if (elf_version(EV_CURRENT) == EV_NONE) {
> +		elf_error("Cannot set libelf version");
> +		goto out;
> +	}
> +
> +	elf = elf_begin(fd, ELF_C_READ, NULL);
> +	if (elf == NULL) {
> +		elf_error("Cannot update ELF file");
> +		goto out;
> +	}
> +
> +	/* Locate symbol table and .BTF_ids sections */
> +	if (elf_getshdrstrndx(elf, &strndx) < 0)
> +		goto out;
> +	while ((scn = elf_nextscn(elf, scn)) != NULL) {
> +		Elf_Data *data;
> +
> +		i++;
> +		if (!gelf_getshdr(scn, &shdr)) {
> +			elf_error("Failed to get ELF section(%d) hdr", i);
> +			goto out;
> +		}
> +
> +		secname = elf_strptr(elf, strndx, shdr.sh_name);
> +		if (!secname) {
> +			elf_error("Failed to get ELF section(%d) hdr name", i);
> +			goto out;
> +		}
> +
> +		data = elf_getdata(scn, 0);
> +		if (!data) {
> +			elf_error("Failed to get ELF section(%d) data", i);
> +			goto out;
> +		}
> +
> +		if (shdr.sh_type == SHT_SYMTAB) {
> +			symbols_shndx = i;
> +			symscn = scn;
> +			symbols = data;
> +			strtabidx = shdr.sh_link;
> +		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
> +			idlist_shndx = i;
> +			idlist_addr = shdr.sh_addr;
> +			idlist = data;
> +		}
> +	}
> +
> +	/* Cannot resolve symbol or .BTF_ids sections. Nothing to do. */
> +	if (symbols_shndx == -1 || idlist_shndx == -1) {
> +		err = 0;
> +		goto out;
> +	}
> +
> +	if (!gelf_getshdr(symscn, &shdr)) {
> +		elf_error("Failed to get ELF symbol table header");
> +		goto out;
> +	}
> +	nr_syms = shdr.sh_size / shdr.sh_entsize;
> +
> +	err = btf_encoder__collect_btf_funcs(encoder, &btf_funcs);
> +	if (err) {
> +		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
> +		goto out;
> +	}
> +
> +	/* First collect all kfunc set ranges.
> +	 *
> +	 * Note we choose not to sort these ranges and accept a linear
> +	 * search when doing lookups. Reasoning is that the number of
> +	 * sets is ~O(100) and not worth the additional code to optimize.
> +	 */
> +	for (i = 0; i < nr_syms; i++) {
> +		struct btf_kfunc_set_range range = {};
> +		const char *name;
> +		GElf_Sym sym;
> +
> +		if (!gelf_getsym(symbols, i, &sym)) {
> +			elf_error("Failed to get ELF symbol(%d)", i);
> +			goto out;
> +		}
> +
> +		if (sym.st_shndx != idlist_shndx)
> +			continue;
> +
> +		name = elf_strptr(elf, strtabidx, sym.st_name);
> +		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
> +			continue;
> +
> +		range.start = sym.st_value;
> +		range.end = sym.st_value + sym.st_size;
> +		gobuffer__add(&btf_kfunc_ranges, &range, sizeof(range));
> +	}
> +
> +	/* Now inject BTF with kfunc decl tag for detected kfuncs */
> +	for (i = 0; i < nr_syms; i++) {
> +		const struct btf_kfunc_set_range *ranges;
> +		unsigned int ranges_cnt;
> +		char *func, *name;
> +		GElf_Sym sym;
> +		bool found;
> +		int err;
> +		int j;
> +
> +		if (!gelf_getsym(symbols, i, &sym)) {
> +			elf_error("Failed to get ELF symbol(%d)", i);
> +			goto out;
> +		}
> +
> +		if (sym.st_shndx != idlist_shndx)
> +			continue;
> +
> +		name = elf_strptr(elf, strtabidx, sym.st_name);
> +		func = get_func_name(name);
> +		if (!func)
> +			continue;
> +
> +		/* Check if function belongs to a kfunc set */
> +		ranges = gobuffer__entries(&btf_kfunc_ranges);
> +		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
> +		found = false;
> +		for (j = 0; j < ranges_cnt; j++) {
> +			size_t addr = sym.st_value;
> +
> +			if (ranges[j].start <= addr && addr < ranges[j].end) {
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			free(func);
> +			continue;
> +		}
> +
> +		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
> +		if (err) {
> +			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
> +			free(func);
> +			goto out;
> +		}
> +		free(func);
> +	}
> +
> +	err = 0;
> +out:
> +	__gobuffer__delete(&btf_funcs);
> +	__gobuffer__delete(&btf_kfunc_ranges);
> +	if (elf)
> +		elf_end(elf);
> +	if (fd != -1)
> +		close(fd);
> +	return err;
> +}
> +
>  int btf_encoder__encode(struct btf_encoder *encoder)
>  {
> +	bool should_tag_kfuncs;
>  	int err;
>  
>  	/* for single-threaded case, saved funcs are added here */
> @@ -1377,6 +1735,15 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	if (btf__type_cnt(encoder->btf) == 1)
>  		return 0;
>  
> +	/* Note vmlinux may already contain btf_decl_tag's for kfuncs. So
> +	 * take care to call this before btf_dedup().
> +	 */
> +	should_tag_kfuncs = encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag;
> +	if (should_tag_kfuncs && btf_encoder__tag_kfuncs(encoder)) {
> +		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
> +		return -1;
> +	}
> +
>  	if (btf__dedup(encoder->btf, NULL)) {
>  		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
>  		return -1;
> @@ -1660,6 +2027,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->force		 = conf_load->btf_encode_force;
>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
>  		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
> +		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->verbose	 = verbose;
>  		encoder->has_index_type  = false;
--------------93E2bcJ688PL4aBr3ZQnkk0S
Content-Type: text/x-patch; charset=UTF-8; name="0001-switch.patch"
Content-Disposition: attachment; filename="0001-switch.patch"
Content-Transfer-Encoding: base64

RnJvbSAyY2EzN2NmYTFlOWJlNGY0ZDk3MTdmYzNkYzM0NmNkZDdjNjE3ZTMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGFuIE1hZ3VpcmUgPGFsYW4ubWFndWlyZUBvcmFjbGUuY29t
PgpEYXRlOiBNb24sIDExIE1hciAyMDI0IDEwOjE3OjQ3ICswMDAwClN1YmplY3Q6IFtQQVRDSCBi
cGYtbmV4dF0ga2J1aWxkLGJwZjogc3dpdGNoIHRvIHVzaW5nIC0tYnRmX2ZlYXR1cmVzIGZvcgog
cGFob2xlIHYxLjI2IGFuZCBsYXRlcgoKVGhlIGJ0Zl9mZWF0dXJlcyBsaXN0IGNhbiBiZSB1c2Vk
IGZvciBwYWhvbGUgdjEuMjYgYW5kIGxhdGVyIC0KaXQgaXMgdXNlZnVsIGJlY2F1c2UgaWYgYSBm
ZWF0dXJlIGlzIG5vdCB5ZXQgaW1wbGVtZW50ZWQgaXQgd2lsbApub3QgZXhpdCB3aXRoIGEgZmFp
bHVyZSBtZXNzYWdlLiAgVGhpcyB3aWxsIGFsbG93IHVzIHRvIGFkZCBmZWF0dXJlCnJlcXVlc3Rz
IHRvIHRoZSBwYWhvbGUgb3B0aW9ucyB3aXRob3V0IGhhdmluZyB0byBjaGVjayBwYWhvbGUgdmVy
c2lvbnMKaW4gZnV0dXJlOyBpZiB0aGUgdmVyc2lvbiBvZiBwYWhvbGUgc3VwcG9ydHMgdGhlIGZl
YXR1cmUgaXQgd2lsbCBiZQphZGRlZC4KClNpZ25lZC1vZmYtYnk6IEFsYW4gTWFndWlyZSA8YWxh
bi5tYWd1aXJlQG9yYWNsZS5jb20+Ci0tLQogc2NyaXB0cy9NYWtlZmlsZS5idGYgfCA3ICsrKysr
LS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvc2NyaXB0cy9NYWtlZmlsZS5idGYgYi9zY3JpcHRzL01ha2VmaWxlLmJ0ZgppbmRl
eCA4MjM3N2U0NzBhZWQuLjk2OTRjYTNjNTI1MiAxMDA2NDQKLS0tIGEvc2NyaXB0cy9NYWtlZmls
ZS5idGYKKysrIGIvc2NyaXB0cy9NYWtlZmlsZS5idGYKQEAgLTEyLDggKzEyLDExIEBAIHBhaG9s
ZS1mbGFncy0kKGNhbGwgdGVzdC1nZSwgJChwYWhvbGUtdmVyKSwgMTIxKQkrPSAtLWJ0Zl9nZW5f
ZmxvYXRzCiAKIHBhaG9sZS1mbGFncy0kKGNhbGwgdGVzdC1nZSwgJChwYWhvbGUtdmVyKSwgMTIy
KQkrPSAtagogCi1wYWhvbGUtZmxhZ3MtJChDT05GSUdfUEFIT0xFX0hBU19MQU5HX0VYQ0xVREUp
CQkrPSAtLWxhbmdfZXhjbHVkZT1ydXN0Ci0KIHBhaG9sZS1mbGFncy0kKGNhbGwgdGVzdC1nZSwg
JChwYWhvbGUtdmVyKSwgMTI1KQkrPSAtLXNraXBfZW5jb2RpbmdfYnRmX2luY29uc2lzdGVudF9w
cm90byAtLWJ0Zl9nZW5fb3B0aW1pemVkCiAKKyMgU3dpdGNoIHRvIHVzaW5nIC0tYnRmX2ZlYXR1
cmVzIGZvciB2MS4yNiBhbmQgbGF0ZXIuCitwYWhvbGUtZmxhZ3MtJChjYWxsIHRlc3QtZ2UsICQo
cGFob2xlLXZlciksIDEyNikJPSAtaiAtLWJ0Zl9mZWF0dXJlcz1lbmNvZGVfZm9yY2UsdmFyLGZs
b2F0LGVtdW02NCxkZWNsX3RhZyx0eXBlX3RhZyxvcHRpbWl6ZWRfZnVuYyxjb25zaXN0ZW50X2Z1
bmMKKworcGFob2xlLWZsYWdzLSQoQ09ORklHX1BBSE9MRV9IQVNfTEFOR19FWENMVURFKQkJKz0g
LS1sYW5nX2V4Y2x1ZGU9cnVzdAorCiBleHBvcnQgUEFIT0xFX0ZMQUdTIDo9ICQocGFob2xlLWZs
YWdzLXkpCi0tIAoyLjM5LjMKCg==

--------------93E2bcJ688PL4aBr3ZQnkk0S--
