Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA44BCABD;
	Mon,  7 Sep 2026 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810702; cv=fail; b=E3FOPr2Q16cYmhLLdjV3TodboTmIz1WrGXnRtJnj7p/bseB6LJ7LV41hCyfWKoJYsshd6j67kqQOJvvq8HKZ/HyQMjp5QjqblqfsXotB8hBwhP9glQ2YBjq1trykKNoJ5dKH/WjcRnNKvJ2itNSDg9tYBgV1iNbfQIzR8fyWSsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810702; c=relaxed/simple;
	bh=RJ16uSP6s/3hhlJSU2tLbh6Nb6WMOIF10kNVhvZUfNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RFITJonxoZerWgpKKg3as0fHaPq8f8QYq2+LZOZxWfEaJ7yaOPgx836v850Gj+y5r2beFH7haNO5GtAkmLpUjzR1KF9ylQp2RVg8r7Jawrc3Uz73/wL0OCDK+QndPf3XVyxIaAcE+f6KpRRT+grYSKTe/qTaW5lql1fx1/GNESE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qUqb4A6c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nnLWGdKu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qUqb4A6c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nnLWGdKu"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DK3du1459308;
	Mon, 7 Sep 2026 19:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UpHGkL7Xax6uy+ALKhXtW1OvRduYFAv+8f9vsaT/XoE=; b=
	qUqb4A6clmrjhq1IgbLAbSP1+6NFP1+lnLxNIS87CX6+3Ewx+VmAzxpqjRclMXRT
	tvFgdnVk/V8eNAlHKhPnX6gD7ehuduJ3g5qVjuS/JYutCYN9PG8LmxXNtUR6XR0s
	BOTJaiz3lSZ5TK+R3Y4+uRRNtBa7jW/eC3EywTDlrVq4PDgWW5XTGumxhUWyhy4j
	Rq7rsIJf/+2o5npyvmmGCQwhjYplWcSyHYxrINYPvh4fgRA1yoOFebRFny81kr4v
	kWs3C09nQ7a9GJPn0TDFWEhRYWWlhK0BJRsCTm/jxKX5iXE4litRsoxbaCMBwR07
	UAlv1CbsBkKGysElpLbbIQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ggbmqa9fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Sep 2026 19:51:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 687Jo2nS008177;
	Mon, 7 Sep 2026 19:51:03 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gh712b1ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 07 Sep 2026 19:51:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poQM/rtFCarlG9JbQg1yLnQIL7nuidJXpf9MhIbKvU9sf9X10X3iZQf2Rj68iCtglyENY3uZtVfags837eHEDlr3OqBpUvdwnmjjyEPIJv3Z+OjsWCr7pQnZQ+2RuQc67F8lsR0O0eRwWnV6iVf75ykPEcaadj5j1jqCFtuYtPJ8kjbTX64V70iU8+k0yskI2TO2OBHmk1BfIQaSq4+as9ikVMs2gSHupmXcBQtj+2gx6jMZr8XZf23rNJco40OuhjI1suyCM4v2beoys4yDjyqOfgpyTkVT9d4DlUKw6fozUWI7pdHhPqhSWgS0o2dkoZhj9pDg2YOh9k4Y7rf77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpHGkL7Xax6uy+ALKhXtW1OvRduYFAv+8f9vsaT/XoE=;
 b=FUgNR/yFD0flHtZ1H6kS/n7rB4XNOhFbDREFtGQ3HRAbU3is4v32/M64ALiwALEdX2F0TvIOwSyhJlEKnuVtrYKokOQWRgXzTNTe8fCqOL8Iz4xzdnQo2cHk9mMD1moJFsjN4Ojk5dBDr9orO00zRlzgQ7UxT0CMEsyaoA744DRBWT1FQsXLOZ7piRitakrVvQDPyCKDMkezMw9AXE63m1IwsOgBOibk+VNlLvZwr5U2iJwqybfmWHrLhih4NwEJyTHYEbSHYtMyapLojqjjNFjpa5aGaJV/3dfghPp5zIOzm8UtNDe7Km4k833be1a0tf9tYzfkmdvp0DZz5JnWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpHGkL7Xax6uy+ALKhXtW1OvRduYFAv+8f9vsaT/XoE=;
 b=nnLWGdKuh7o9IMNnOItKIIKIwvUyl3uKD3FMFaVGZl29jJulFkeduRisDxrOyUqFZCQeBcWJAhte/7cuc2TzBPbWlTJ7zXKPeWIP8XvT3n+GA1qaf2rUgklZ5XuHvcBpEo9k4VpnT5nzBSjqlw1X3xKDCTFq58MPZLMkPbswdOY=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CH4PR10MB8170.namprd10.prod.outlook.com (2603:10b6:610:247::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 19:50:58 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0406.002; Mon, 7 Sep 2026
 19:50:58 +0000
Message-ID: <932ffcdb-69d8-46a6-924c-4bb8fde7b6b0@oracle.com>
Date: Mon, 7 Sep 2026 20:50:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 14/18] btf: Make vmlinux, module inline info
 available in /sys/kernel/btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
        andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
        nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-15-alan.maguire@oracle.com>
 <DL9C40S8FVWA.2T4J5Y8BSF7KU@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <DL9C40S8FVWA.2T4J5Y8BSF7KU@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0217.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::11) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CH4PR10MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 34de0bd0-4602-4a8f-92c5-08df0d195652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	OqmQGHLWJEyofWK/YZOeI6g+AusPoCvc9QjzKY+4KM/wgEoFBH4HSDwBfFuoURfCJXPKZF/udD73GqC1NBG5R26g/tylUX2AvTyl6z99jkecDahUS6iL+FuzECVMOmNbV9c8KhcwiAXDbjdS98ShLCCaWHwSVCnC9ApeR6f3YXrN7iOXMWzBVwNBPV0I/sAPaAghpi1oefvhs4Rh7oqmw53sD9BaPQbEYINiXQRdVesNTBZUx33+OfLDIkb7g4cRzsKTavXEy3NpxohwdqDuVgAhTDEvVwru0IKAQX2NanLlcTfNQ5l4bHfPR/DfpNhULW8hrLIpaom4mVb1gC07IZdTkRdnlBmZ3E1E/fd/KnE/yJH8Z7IX47hcjC4T6+R/b3J7tnWcWSo0PU//67aYpvZHMu7ID8BB1kiN1WYmRZlVHUh3CZBLHNml2jQCTr0AcXvzXOVQ+S1LUvEa99UsFndiixx6zPNxOXft9fQGb1QBn3BepExHqdDbRG3c+UpN2dEwSBGXqrzdwk9GcqdTCtPGr0VAtDFu8ogm3nTRRmJiANCFzh/rHMFipNqGBJCDpq56vZ7yNFV7yCz+r9IaVtkbFOfdRgzDK1HGt0j8/Rerl0x57ewzSmnSnQdLleQdue6ZVKyLQXlZKCS7Cj+2m7c2mNuXLKrgfTt+2stRjHA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czRsd2w2eG00NWgyMXBtWTRNOG8yYVM5NlpEdzIzVzBVNEZwYldCNmd5dFlG?=
 =?utf-8?B?SDNQVDBUZVdDZWRZSStHV0UxaTk1R2xnWitYS3o1NFN3VitzRDlFbm5Eb2Iy?=
 =?utf-8?B?NllNcG9MSzlMZTVRYXFqZjRHdTdCb0l3MXBVNnQzbWpPTzlCVkJTaWdjUXZq?=
 =?utf-8?B?YXU4bERqajlwQjhYbjhmZzhMUUlNMTF6Y3BqM3pwaEhLenk4SVBndFR5WWZr?=
 =?utf-8?B?VGs0U0xuRVl0UDBFTy95RkpNRFcrd1VpSzBKTExpY2VuOVE4ajRXSWRYVDQ3?=
 =?utf-8?B?MGREVks0K0diWW1pODVZMUZNaWR3aER2SVBURXlUa3VKV29xcUxGSTQyOVhm?=
 =?utf-8?B?aDIyQmVXcmE3ZHVxTjhwcm9JVkwwZFgzZDh6eS9qTWg0ZERueUdWQUhmMUh2?=
 =?utf-8?B?eFEyOWxkQVBabmpMc0JWTThaakQ5ckE1UGZ6ckRpaFNkL0ZGMUloYjlmSHlR?=
 =?utf-8?B?T1lrKzBaQ3UyTUp4WjRlaG9wRFdmNC9jNDI5VmZyYnRDWk82ZUJSNWhwU0c5?=
 =?utf-8?B?VlpVY2hlWnJSNFhkL2lQQVU4Sm16TEhwUC9TSVpKclF5QW00dDZ4RWVFYyt6?=
 =?utf-8?B?TXFCaGFKRFU1ejl3T1o0RmtEU0w3aURSNzJuSE9xZWV1QWZuYXVIWEY0ZXpX?=
 =?utf-8?B?WWFZbHVJZm96TEhtdFJrdnRPQ3M3cCtFMzdoVEcyOEFieWJNNldveVVIUXBu?=
 =?utf-8?B?QVh3MG9TVHI4UjEyWFdSdDZtTUVRMHRRVU9oNjl2clQzMmN2TFlBSFZEeGJp?=
 =?utf-8?B?M2llTmlnZFNFcVZlcHFKeTdKNEozWEUzUGJMeWdhSm1hQU5NYUpCY3VTMjV1?=
 =?utf-8?B?UVVSNXRNWjJtKzJHMENsT0ZTZWJxb3h3UDNqeEhRSmYzS1pLYUcyVzVCKzVo?=
 =?utf-8?B?U0tyRUtRd2tTdU9oZVV1VUpYZVowVk96OHVBalk5eTFlUWtqekd6Y3BoTFRX?=
 =?utf-8?B?SThPaStNL2luV2h4UGdzVVR1MmU5bEMvbTRzeXhYT2E0UTNpMGFyQS9YL1Vn?=
 =?utf-8?B?T2VuRCtkYzdPOWhBOGFXMXlTMXU5RDNyZURUbEZSbGJIZUFRb0FRdzBqV0xP?=
 =?utf-8?B?TDF4ekdRdHlGN3ZUVUlIQ1gzTCtBbU5GOWZ4WUNXSUwxTE5MWWdPYnZ5bVQ0?=
 =?utf-8?B?UHp6b3VkL2NzaXJ2b1BNRDNzbDkwcmo2RlFvMTAzUkpLTFB1aFNQYktpcUhP?=
 =?utf-8?B?eHlPdGdISURXYXlRSURHUS9jODRHRFc3MC82VlkrMXo0SnYvWnZHNjIrZy9I?=
 =?utf-8?B?dm5kcjgyMnJYd2s3RTFMK3hxY0c5OStxQ2twZ1NyUE9BOW5SdVZLYlRvU3Mx?=
 =?utf-8?B?bU1LQzdXQnB2NkwwRWtSb2VaUUtRQnB5bWxnUGtTandpTGdwOGtPVjdDQWVa?=
 =?utf-8?B?aEJDa3NZaENWM1pZM0J4R2xhS2pJNGpKRmVTb1JPaURwSkpHemxvRkg2Vktq?=
 =?utf-8?B?NjRpdGdDK2N6VFdXbDlhNHBINTdhcEJpdk54QTdxRmMzSWlTYlorMmNqNXU2?=
 =?utf-8?B?T3kyalJTMUtxU1RydUJsRzdubHBJOURRQ1ZLSTRzNytjRU91T3RDRW93RDdX?=
 =?utf-8?B?V1NUc3dhaXdVL2NnQlNJbHFHNEZBQXg1Zm5yOUFqSzBpSXY5bzlFbFJKUGRO?=
 =?utf-8?B?MUphZUNBWk9xTjZqdHI0RlJ3enB1TzNVakFodHp5Qjh1c0JrUjB2M3hlV2FT?=
 =?utf-8?B?cElsbkg2YzBxb1VRUkdlTElPRmdpSUQ4MkpxOWIxVlU2UDkzcjhGMGk5aGJM?=
 =?utf-8?B?dUN2czYyd0w1Mm9ZYmZZQ3ROZmRPbm5tWFQxY0hmUkhZQ0dob290SG91UUsr?=
 =?utf-8?B?SnZPaDl6b2NnWS93bHFPYktYSnJhWFUzREJOd3B5ZUxJRGxUbmdqeS93MmRB?=
 =?utf-8?B?MC9vTHkvY2k3bTEvRTZZMHN2QS9PRzVhWEh2b2dvUDJNeERPODUwWlYwU3ly?=
 =?utf-8?B?NDJ4YVYxY2QrMkxJUEt4YTYwT1dMKzVtKzFpeGptcjBtSWJpRFN6Mk1CWXg2?=
 =?utf-8?B?NlJJWkR0cGpHY2VXT2tzRHpqN0xUUkNpVnN3bHdMdWJaTW9wL01TOVg5NEow?=
 =?utf-8?B?NklpcEx3eWRUMzZScDdKd3M3RzJ5TUkxM0lIV3hRaDk1TisySTU3NUY4UXNl?=
 =?utf-8?B?MGJ2dmlQRWhEenlmakZyVnJoR2h3MVhQcnF5SWR1R1RKYWVWSTYvRkJWUitF?=
 =?utf-8?B?cXpwVGlyRzFHd1A2YitzY0h0M2RzMTdWazBBV01rZUZXT2Z5bVlmc0tReXNE?=
 =?utf-8?B?cEhmZGNCcjlJVmdEUC9YM2RRc2NOVWFWVjdTQ0s0TmMyY3V3QWc1c2hIN3U2?=
 =?utf-8?B?SndFcHZIU3YzZlRFWTVUYkIyUVp6d25BUXI5MmwrRS9EMEhjTFNGZz09?=
X-Exchange-RoutingPolicyChecked:
	A/yIYKaLSQfL/epVIJ5Wtk/3UnWO6BrV/no7ZgUTUDbUwHYZVS/nxjU8QbF71P+g1mk6+HUEhqm3SAIaEgbMYVLvmExQAAaTMunv4dWNJcjJecJUwa8BC6o+gZKdY5Vdlg3nj+X4FspEIjFg3aCtqktElSSkP0N34/5268niWiFxCo07PBQgrcjddEkJA+buW+ZqNHFmOFt1QzVMuUsihuWqqxW/nbov3KNsbR1NIDoQiL5yXz7xanmYKHHq7rXs2drFZHLh0E7eCnVC6cRLeyRe1fQLLcxkp4boSnAcND1n9x1uNqvDR0Yyc65QvYiaGWJ3OVie/76KDxyjmFRZtw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hh9YUE0ZhybVHwq3nzyhvAX9BQTBTerx7yYV6N6slfIU1UDHU0YyX7MHxFK7wJAIklq5dwKi8a0izfXgoJUf3fgkm8CWbjnGBEAXqYsZ1/8v7TT6wKBbzP8aXZ67luRras5KxMqwdiIXrrEEjDvOZR71QHEd/noGMBIc7UHdmtA0yAJE1wMSwouWGXq3st3LftW6N4HWSga/MlDsAT+Zq5eMpo+8lTva999VhTabg5Q9TFhivQN0bsbAOTs2azCKzkjrt2hVYzkmQctNFQOIqwXGWdWFppz3zTC+KYqeob1d+dWKscVFRODVZgoRxj9G2Josa6rHXcSHMhoIEMLBE78TS3bqxBehVChgdfzEC40raboFycXriMRrTkFnbJpri9iqWUpaHOWiOzLh5KVGAc5e7fSG1ooFjzoLvhP4yE+bNK2o1/PWM3LPsoNdeLfB2j5WbclZ5J1hkdStAb4T6dkI3LVYg9GGywhUZR+76reWOH1noB6qhobAhSva44/rWK2uPyZaUN+YKaOG6VZIn8FL7qNMknLtOWR/CAGb6mXqBYkiPulwX6XFajmoPT3SBrjy+8zpYeVIQqHIO94Js0JSuJmMlJVmFB0vYQ7aEeg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34de0bd0-4602-4a8f-92c5-08df0d195652
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 19:50:58.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pnr/sBu0aNhdfnlUi3nYTrq5SiIdH7oQCHHPCPpyx8efADUfDivYV9x7ITUKbYujeZWTxQWKC0DqCBeIpc3iQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609070220
X-Authority-Analysis: v=2.4 cv=JYiMa0KV c=1 sm=1 tr=0 ts=6a9f15ac b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=qPSXJOV90GDUtlhNUxkA:9 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyMCBTYWx0ZWRfX6hIz4Nu2fhSx
 cA9n9/R8yUFX1PlW9Sd+A4/Z1nSax1YN//kR92btjI5O7D5Aew2xQc0Q2rKLc/ZlY6YchCuSHKC
 OpMNCwawEhyZRODcE8WATxxiw64+o6+88ecbaYEDVXNWiXTGEZyef28NHfgu9hUXBnB/6aIo4LV
 56pe0EpqvSITZsLpglQsVNTnyZVPiEclvAKNHN7lYJ2/zNrukcD3IEEoNteLyGU5EGqyq3G6YmQ
 lU9hoxIe6wxcZQ8pXn1NGL553EgWNft+K9gTerWOtMC8hogWUQM55Iu79KZs3CVIIBy//6vX8co
 GriFJozNS5fdx2HzrDZ/BahVou7ZpK596qBohLebY7ZXzgJE/rIMukyHi1K0tPBVck740kfYr0c
 Qjlon0uC13Hzlls8Y632941hh+aLO2Mz53NXmtIJBPrBIvUCw90nS0ESCYcqUg3QUef8kmG53Rg
 LBK2V8EL6lV9TJ4LNKA==
X-Proofpoint-ORIG-GUID: BlY2KLCfZvkXklksu0YoFZvQugrF8FXC
X-Proofpoint-GUID: BlY2KLCfZvkXklksu0YoFZvQugrF8FXC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyMCBTYWx0ZWRfX0Dtz719B0mQ1
 R6jUihxzoY63fwIYsFxeR7G1ZGSiuY+Vxvd2byLqJ9/qnFyQsQCNIANykeFAh7HjdX5sePFRdtD
 9gbxGleTFg0SK0lgoKHP1iiWAeaeSDu+AW379DmRW/BtAHx1/bc+


On 07/09/2026 20:34, Alexei Starovoitov wrote:
> On Tue Sep 1, 2026 at 9:57 AM PDT, Alan Maguire wrote:
>> Expose BTF inline-location information from vmlinux/module .BTF.inline
>> sections in /sys/kernel/btf using a ".inline" suffix.
>>
>> vmlinux inline BTF is split relative to vmlinux BTF and can be examined
>> with:
>>
>> bpftool btf dump file /sys/kernel/btf/vmlinux.inline
>>
>> Register the sysfs attribute only when the embedded .BTF.inline section
>> is non-empty.
>>
>> Module inline BTF is split relative to the module BTF, which in turn may
>> be split relative to its distilled base BTF.  For example:
>>
>>     bpftool btf dump -B /sys/kernel/btf/vmlinux -B /sys/kernel/btf/xfs \
>>             file /sys/kernel/btf/xfs.inline
>>
>> Copy the inline BTF data into a private buffer for its sysfs lifetime
>> and remove the attribute and buffer when the module is unloaded.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  include/linux/btf.h             |   1 +
>>  include/linux/module.h          |   4 ++
>>  kernel/bpf/Makefile             |   1 +
>>  kernel/bpf/btf.c                | 109 ++++++++++++++++++++++++++------
>>  kernel/bpf/btf_vmlinux_inline.c |  30 +++++++++
>>  kernel/module/main.c            |   4 ++
>>  6 files changed, 128 insertions(+), 21 deletions(-)
>>  create mode 100644 kernel/bpf/btf_vmlinux_inline.c
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index a4412bc16688..93f10d3ccabe 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -617,6 +617,7 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
>>  bool btf_types_are_same(const struct btf *btf1, u32 id1,
>>  			const struct btf *btf2, u32 id2);
>>  int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx);
>> +struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t data_size);
>>  
>>  static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
>>  {
>> diff --git a/include/linux/module.h b/include/linux/module.h
>> index 7566815fabbe..3d32c4e86f44 100644
>> --- a/include/linux/module.h
>> +++ b/include/linux/module.h
>> @@ -507,6 +507,10 @@ struct module {
>>  	void *btf_data;
>>  	void *btf_base_data;
>>  #endif
>> +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
>> +	unsigned int btf_inline_data_size;
>> +	void *btf_inline_data;
>> +#endif
>>  #ifdef CONFIG_JUMP_LABEL
>>  	struct jump_entry *jump_entries;
>>  	unsigned int num_jump_entries;
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index 9a92c348bbda..60aa5adb0354 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -42,6 +42,7 @@ obj-$(CONFIG_BPF_SYSCALL) += reuseport_array.o
>>  endif
>>  ifeq ($(CONFIG_SYSFS),y)
>>  obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
>> +obj-$(CONFIG_DEBUG_INFO_BTF_INLINE) += btf_vmlinux_inline.o
>>  endif
>>  ifeq ($(CONFIG_BPF_JIT),y)
>>  obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index d74c8668aa3f..3e5890aed2db 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -8735,12 +8735,69 @@ enum {
>>  	BTF_MODULE_F_LIVE = (1 << 0),
>>  };
>>  
>> +#if IS_ENABLED(CONFIG_SYSFS)
>> +struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t data_size)
>> +{
>> +	struct bin_attribute *attr;
>> +	int err;
>> +
>> +	attr = kzalloc_obj(*attr);
>> +	if (!attr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	sysfs_bin_attr_init(attr);
>> +	attr->attr.mode = 0444;
>> +	attr->size = data_size;
>> +	attr->private = data;
>> +	attr->read = sysfs_bin_attr_simple_read;
>> +	attr->attr.name = kstrdup(name, GFP_KERNEL);
>> +	if (!attr->attr.name) {
>> +		err = -ENOMEM;
>> +		goto err_free;
>> +	}
>> +	err = sysfs_create_bin_file(btf_kobj, attr);
>> +	if (err) {
>> +		pr_warn("failed to register [%s] BTF in sysfs: %d\n", name, err);
>> +		goto err_free;
>> +	}
>> +	return attr;
>> +
>> +err_free:
>> +	kfree(attr->attr.name);
>> +	kfree(attr);
>> +	return ERR_PTR(err);
>> +}
>> +
>> +#else
>> +struct bin_attribute *sysfs_btf_add(const char *name, void *data, size_t data_size)
>> +{
>> +	return NULL;
>> +}
>> +#endif
> 
> We do
> ifeq ($(CONFIG_SYSFS),y)
> obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
> endif
> 
> I would do the same here and avoid ifdef inside .c
> 

Will do.

> Also consider adding support for mmaping of vmlinux.inline
> from the start.
> It was useful for regular BTF. BTF.inline is bigger,
> so it will benefit more.
>

Definitely, good idea.
 
> Some of AI bug reports sound valid. Pls address and respin.
> Let's start landing it asap.
>

Sure; what do you think about splitting into 2 series, with
pahole support landing once the first series does (so we 
have libbpf support for the inline APIs)?

patches 1-11: support for inline info across UAPI, kernel, libbpf, bpftool
and tests

patches 12- 18 kbuild support, sysfs availability

?
 

