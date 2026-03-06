Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA739903D
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804674; cv=fail; b=kDLjVGUeoybkGVmjn+TVkVjvuJaWuGVaEvNxCevnOW4uUb9HFa4F7ugA8yT3pNLRCtv7PV+6GRabw2X+yapMghPkObV5DqG3kCfS5QHT3i7PETCAE/qTg858QZQL4QLMdpJDuzdwKK4z4+pIPyHuk8XCxi4P+pvl4P6p6xrKJRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804674; c=relaxed/simple;
	bh=IUXaXH+fxMDLp8RQ3Gn13pTeb3iAFoYIe6RzJpVqV9g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cHBxcUAgDhEc6dGiVk3gCx6appa61DSZ4iD+jaNShHroExocsdSvk12Li94eK1U+Qq18keaTS7r23PYIho9BiBQgDB/duV5DWzwYq4kUASEqUjHPJBXmO5ryv4J9TmihMgNdi02ufJx5rXzo3jlfIp8Z/IOWNTD5TNYITKCx5Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pEcdWfnd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xJg066sp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pEcdWfnd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xJg066sp"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626DWbbS3318697;
	Fri, 6 Mar 2026 13:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9CI0Q+agjoIC63g7ueYYfGgxPfYakF+5P6Ub+2gFjqM=; b=
	pEcdWfndIHgyn0HXGrC6WCT13NPio4aCUUU/c+H6EXotRESuwrgsXz9ZzFlKcMUm
	5fljnHqQFnhmod9Cndikd2bv2rGpX2D8mqnsTfOuXe7/HW7FGMl/jpkdKNfbKnKa
	fQ4fcWP2SuVC44Sda3wcTnCvRiAwavdvrzvAxbv2O8w5G0Vfdv5aXl0zgGwpR0hd
	87CY1dVF02DX3lEfpL/9F4YRAAv24KEw6Zjzh8RyPGvfcsSsktNiKsYViNOfTtsO
	7Cgx1AEDtdBTunMWa6B+eI1oJFZ0KzKwh1ZUI/jipEoj1ELeacXKQi14FdmY/Gym
	dLZCmqocv/b+SypNSpHv0w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqyw500ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 13:43:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626BLvOI035421;
	Fri, 6 Mar 2026 13:43:56 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptjq05u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 13:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTk82BKrFaFn3by/ZXi5oyyh9wMZ9r6ng/4iTbxcOSnI217zyUFbpfLwsHv3BAqM8sFWsIRod39U/ns0Jox7H5ektaXqwS+l7oKcfPlm+26pDYls2rbSaEuE0xgWYy0x//Bsgdq6z6vJO3nUupk2RyS5tdK4SCpysSIqJt0Hd2MU07IgzAgbMCV/rQFm9aH3df2uL5OsqmuJGZPyWkGaSf0KkNMOgzWKFvgUla8FvBaHOPYdHkHZthmAs8TSe+JGChN2jUjvnoPhdlD3C2NUVWOwJG2wS6oP1c8kNEa1SfSPVaqOqjtcUdWhPPuvofMuw1rHqPALc6979hkMGLwX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CI0Q+agjoIC63g7ueYYfGgxPfYakF+5P6Ub+2gFjqM=;
 b=YFGzcYWtvMLDakIi1LuLAu1vvHHG/lWnmJ+Jj8gfPV8WDR1yXiBNvzmGGR30m0SJISTEfB78hQANCy+Luj3kQJTdpEnIvGOvU4gLa4JsXlbDXgSmB6cqPJkQsdsLdSXOS5qrd09xov514gKDfrhJ/QbPBBRp2LGi4y77Akwmd2Tndq9Tl92sVioWarHpp31k6Ev9tV9CwSXZGl6QtAlYysV3K8CY6kDvda0Zk/C/+5DCcoz3y8U5emWtJUbr/1vrXFtdB0O+dnc87DeRzDupuRtTPK0YNganza6t4fhQDo0DW4aO3QGgYu7I1xYnmu33f4Molshl1p/z07eHDGzPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CI0Q+agjoIC63g7ueYYfGgxPfYakF+5P6Ub+2gFjqM=;
 b=xJg066spoG8t01sNzNrDg42XVPFi6bsTsJrONf+04iqzDguluw3INNBx/cRSpHarIVejL0P2gZuHnXRtGwdK3cf8Fh/4fFLG16wf6hvtkxPGj+SYEOxN3fZRqdzui68f6q0CtHhN9NvBCSh4pK5KKF63AYmGCo1QW3Pl+/uitBY=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB4520.namprd10.prod.outlook.com (2603:10b6:510:43::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.19; Fri, 6 Mar 2026 13:43:37 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 13:43:37 +0000
Message-ID: <e3a8da67-7841-4839-96be-f1c56ab27c4b@oracle.com>
Date: Fri, 6 Mar 2026 13:43:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Speed up module_attach test
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Shubham Sharma <slopixelz@gmail.com>
References: <20260306101628.3822284-1-vmalik@redhat.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260306101628.3822284-1-vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::16) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb00ea3-549b-43a6-512b-08de7b865e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	/sCiGBW0bp1dhy/HY2k8nbJR4jtvnqsdTu92P+9dlJzgVjlKbMA3dODgPKlrs0q5spHa7ecVdu5ar4l0zhzVT6iRaZ3G4/QJ0Lt3OFpSww1XT//N5behyEw/QMCZZAUcvB07fBr72APKL2c0xfxe+9Tj7z6ceY5BS26ov9pTY1TA7L+qPZm0UAK+kZk/0wF95IppD1W/F0U9IxwxUfTBOF5/8BlSG53r2SbT0T4xSb6atZn8Q2FpHLEE/4wCYASotz+L5TaNNcToQddwZaQuGroOxOjNPsMJnNGKo+754jVUZrvbiLUqzD98hFjiAYZzCDysuMUAycf9PdZmxoazw28lZYOl10UKUuvzsjhCqY776ImX8iA8VUFjin9Dv2M1kMUr/Yy8pY3+p4/HmMxZUhrz5TVPIc9UfSKVXdaOanp/MXBsPvozJqC4MHFeKe6SejyaILv3Ac2pU0lJl4Pn25Hap0/Ikr5iHvY15jXhlH5FkIeIay6tyQnKDaYk+CdiLUvZ1IE2QGlfU/KTHbcE3TvAwPwiBUhzvi3SbOkDdJakjkW1L0N4MG5kIRN1z32OH9KSP3dgYNUMLp1DbAvBN3JdaynQiFhYBQM0d0n1vM4Seb4Zo5JJVPCt2J1FKkl8fipAEEfEIyY2xur58mfeLGh7P6ULkkV/oC/ZTJcGqGZJ4TLVTU7Gp9IbIl1ftKdjB/+v6L9czE8nubZxRBXjizTy0JiSqlmlICnNxeYllEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2VHU21kUEl1cExYV3NPY2tHRW43VGhYM2Mvblc1S1FMaFo0a1NEajYyT2FN?=
 =?utf-8?B?QXl1K1hBWW9Xb0U0MnZRaFNaZ0E1aXhydzh3TXhwOEdNSTRJZWo0enljenZI?=
 =?utf-8?B?YlVsb3orMGY1OEtyOHZRVTJxK216V2U4YUdLZ0N4MllGUXlaRTNNTnZDbjA4?=
 =?utf-8?B?TFB5Rmk5enlheDVtYjNBVzN2Y3NsR09ZOW9qQmFFaWVtQlUrUU5Ld21jSGlF?=
 =?utf-8?B?a0ZRWXlaZnhJQzk4S1hpR045ZDNCdHQ0ZVZnMFlxdmJPUlhiRzZLeHpvTmRu?=
 =?utf-8?B?ZHBDWXdkVllkRFVjVW1KVFA2TVlySkJVL1ppb1J5N1I2a3ZpVEYxL0MwUGlh?=
 =?utf-8?B?WCtXaHozTlVkQjRXelpUTmFhQnc2V0lhZEozalp4c1N2bzcyMktzWUN1OEt4?=
 =?utf-8?B?WDE0MWR6TEJ4M0VaMDZEQ0dVbnFsSWpmazBwSnpNRDd4ZzFKclZqK2h4WHla?=
 =?utf-8?B?eSt1Z0YvSFM2dXpySk1XT1VQWEJkbDJBMjlNUFRSYlgrV1FFQnoyMmgyMU5m?=
 =?utf-8?B?Ty9oajBSbUJCRVlsK2NiY3V4S2pFUmc1OVp3ZlEwQnFiOGlDcHZiZzRhQzhR?=
 =?utf-8?B?SEo2OWQ5ZC9XSk53cWI4aE9BMFpJaDRtT3Z6cFk3eWl5dE1SczViZysrY3hW?=
 =?utf-8?B?RjYrMFROa0lzcU9aQWVJa2tEbGdKQWQ4WHJkYWtNaHlrMDFIcTRzd25NdHpG?=
 =?utf-8?B?WExyRk5VcE8zWUF2ckdvKytrNFJDWVJOK2hDTzhnSFI2bDBmU1ZVOVFUNUpJ?=
 =?utf-8?B?VklnNDVLM25zR2dTZWNIbUlzS0FwbVZneXZsSC85ejEzRWRNS0JDd3paVVF4?=
 =?utf-8?B?NnBBeW5SaGNLK3F6MHFOMm5lVHZXQ0VKQjRKbUx2b1FtSzlpaGJwelVjblJO?=
 =?utf-8?B?L2IrOUI4VGR1ZVpZeUx2ZHNnQjk2TmN6T1JiSDEwalBHSG1YU0s1WUs4d1Vz?=
 =?utf-8?B?alVBa2NhUGcxWDUwV251WE1YcXJ4OHR4QmtXWGp2cjZmNytvMmg0dlI0OEwv?=
 =?utf-8?B?WjF4SEdoZWFTclFkT2sxa0tnODVqaXoyTmN2UWJUOFFaR2lQaHYwbExodHhl?=
 =?utf-8?B?OVZkN2pWY2pVTWZ5RVFVakZEclA0TkphWUJUV1ZmcllQZXpuTEcyblhZcVJP?=
 =?utf-8?B?aVZJdERpcVovQnRNTlUzWjZjZEwzN0FxclVFS3pMM250NEQ4V1REa05oQ2w1?=
 =?utf-8?B?Ykthb012Q05QSUxrSi9QR1A0MUU4QXYrSTdLYVJCTWo5NEdrS3NrQUFPVmJz?=
 =?utf-8?B?SUowOFJSM3ljQmhJUFl5d25aVzVRL01URFI0Z3U1T2hRK0dvRTZZd3hhWGRu?=
 =?utf-8?B?dThUTU05VmNlNHBLY29Mb3lMUFZOamZMcHY2SlphaDU1QW05ZGJLZDZMeUsx?=
 =?utf-8?B?UUppbkNGYmVpRTZacS9IMUZGbXAzVVRRY1hQWDBmeUxGSjVPMVZ5MVlsSzM2?=
 =?utf-8?B?S0JnYUpiYVRoemsxczhzbVBmL0tTUHpJNm8ybkNseUw5V1U0cjE3WlhKdXNa?=
 =?utf-8?B?dWJRQm5QRHo5S2JvWmNRbGg3NURNTDQrTTh6WWl3V28yb1FOSFZPeExla1No?=
 =?utf-8?B?a0ptaXFBRXV4WDRERFhySktFQ0R2YjFzbnAxazdjS0gzSEpVSE5NSm05eWxR?=
 =?utf-8?B?Y0pxaE9wWTdGZ2tGSFBUK05LZzB2dERXbFNiRVdDbXU0VVRMS3ZBWFRFbWt3?=
 =?utf-8?B?V25MMHJqYkM2VkR6WkREV0ljVGtLdFg3YVgvcjlPYkRGRHRkTWJmU0ZoL1JE?=
 =?utf-8?B?VERIVis0SzBvbGcyRGZCVDZ4LzE2Mkw2ODV4YVJ3UkFVMFVGaUd5OUtuQUVz?=
 =?utf-8?B?WDBXMjNXblpuV1AyUllrMjBYTVNzL1pqY0hVamh3cWxBQXdWVGRaRWtTZWZr?=
 =?utf-8?B?OUhoSUlHWVVCZUZaN0dmN1pjeDF3WEtEMXAzekZWQktENDZENHVISlpDRVRi?=
 =?utf-8?B?cFR5OFU4ZkF6NE9vZ3ZiUEljaUErR2pzbk1lV2o1NnFwczBMUDJubHNXTXdt?=
 =?utf-8?B?UFluMm9uMkFid0k2VzhVVUluRlNidE5FNU9vSVdMMktGN3ZSSjdieG5POWlT?=
 =?utf-8?B?NjNpMUF3Unl3Q0UwcnRrUThCSWN0aklEVFNjOVp2MVVOblFkeS8ycGdFWUpB?=
 =?utf-8?B?NkE5MFFqRE9ySExCSDdYeXpUejBUU0lEU3AyOFo0SzlNTnFiVjhsL1JJQUN4?=
 =?utf-8?B?OUM1STkxZEorU1NGSUdnelpqcDBaaWRqb1Q5SW1rM1R5Y05VYTFSckVNSTdr?=
 =?utf-8?B?dm5vZWhBM0xRTzMvdWZsbTJDcjVITlZWOHRBeWZ6VVRQZzFFWFV4bjN3SHM0?=
 =?utf-8?B?ekxuNWdqbDZ3M1QvNUszbVY4dkZDem0wWFlvOW84UUhJb24wcDRUQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8y8vM/ADthpZ0KBuc0gMghyvGmLn409YuWgTxTo3PHlLGbwCwkcngRQ2GgZw24Yu9OYOCyYy+e9IisXHBXoL/w/jD/XjHBwWUwGodRAjcVG5p+byOWVeCkoI5gJDqUQwSR7SmaEA3J9RdjjDaxOzIfpVVqoGM9APQqz+rSrFPjsatt0j2PssAMO+qQ30BVVJwsbGmibISXPg5oNW8/9AmAioBHlfWpcjNMKCXBZIXfPP1JtV9+S45TM9Q9+TA488nySAs4rX8+J/oMJEPBv/1PvdYzPAXX34qryGepDhHvIu+J+Op0tDWpk+Zh8Sod96my/6/mzwH6eunVn0UI2JelOnPejrj5HHUpFHt+Ic+6WZbo/HuNIwxsmv+uhAEdM+cIdEsusRcpJ24ZbLT5jIZy/F5aJxSBMCwVKj350duHcUvfSncli7vbY+RY9xuN+KBSbnB5WSxRJDxhH6TqLdXrCAkkoQGklAojZ/qr6HPl4c6uZlDj/1L7kgr1OdlKpyELjBVA630aVb6ny6tX9PFJMNrsD1VcYVbfLfz+tstLE+GFMGXDE4FvlSzhSzilW3rBoQKPgYBQWTrYCMyxQ6BTzsxN/u0KwAjbj1vSV+jPI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb00ea3-549b-43a6-512b-08de7b865e40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 13:43:37.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09fs4VttvNFVxv9cXhsG5np2eFI1E8Iv2WFkVaWZ2/kZVId2pdEyReRz9oS3MOIbkvdPS2Soqqh4cagUD3GakA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603060132
X-Proofpoint-GUID: eyOp90M19fRVKkcjhD8YIxViu5GLbate
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEzMSBTYWx0ZWRfX/ONeiV12WIZr
 apSKXXdfYCM9G8ple3j10BXiiq67Uby2K67Qm3Cdd1G0x0LlTint1D4HBDz354b12MDztXE57UR
 DCJ+TohUWIBnnHskOqsWsPDvC97Ma6PFRbS94NdmUQOyg/LLr26U+aeAwX9pjVJABX5eo2cT0QQ
 1ejxnLbh+H/c3vy9OIpvSTUbFzztVHYmJR4U8zi+SfUnsQK4Bs6qYEnEAyynwC0espLtzqWHkzs
 sVNXsN8zEo0dPhOfhaoD1gW4PgG3NSCl/UOub5qER6r5FGYWAz5JAVkXP8UbSF4myaPLaKuT49Z
 Yy2Oge1WW6V1CprwhBllLjd7tk5tddpqIpeg0+rGPVDEdRTaM980xMo3bhK+IPwdTkhdFVoWC/1
 jTZdSZPYTQ4z43SMidJ+Hy2xGPqys8IgcAcydbWTYDyhAVhQ4VFt2A04yF2GoGbhPXnrUSxS+MQ
 RjlOKamXtteD4AslL73++2CQ0QqXCYDnG7va2I70=
X-Proofpoint-ORIG-GUID: eyOp90M19fRVKkcjhD8YIxViu5GLbate
X-Authority-Analysis: v=2.4 cv=Y8b1cxeN c=1 sm=1 tr=0 ts=69aada1d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=cwy9oES99GwppE21DWgA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12266

On 06/03/2026 10:16, Viktor Malik wrote:
> The module_attach test contains subtests which check that unloading a
> module while there are BPF programs attached to its functions is not
> possible because the module is still referenced.
> 
> The problem is that the test calls the generic unload_module() helper
> function which is used for module cleanup after test_progs terminate and
> tries to wait until all module references are released. This
> unnecessarily slows down the module_attach subtests since each
> unsuccessful call to unload_module() takes about 1 second.
> 
> Introduce try_unload_module() which takes the number of retries as a
> parameter. Make unload_module() call it with the currently used amount
> of 10000 retries but call it with just 1 retry from module_attach tests
> as it is always expected to fail. This speeds up the module_attach()
> test significantly.
> 
> Before:
> 
>     # time ./test_progs -t module_attach
>     [...]
>     Summary: 1/14 PASSED, 0 SKIPPED, 0 FAILED
> 
>     real        0m5.011s
>     user        0m0.293s
>     sys         0m0.108s
> 
> After:
> 
>     # time ./test_progs -t module_attach
>     [...]
>     Summary: 1/14 PASSED, 0 SKIPPED, 0 FAILED
> 
>     real        0m0.350s
>     user        0m0.197s
>     sys         0m0.063s
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>

nice speedup!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/module_attach.c | 2 +-
>  tools/testing/selftests/bpf/testing_helpers.c          | 9 +++++++--
>  tools/testing/selftests/bpf/testing_helpers.h          | 1 +
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
> index 67763f609b6e..92c336333fcb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
> @@ -151,7 +151,7 @@ static void test_module_attach_detach(const char *prog_name)
>  	if (!ASSERT_OK_PTR(link, "module_attach attach"))
>  		goto cleanup;
>  
> -	ASSERT_ERR(unload_bpf_testmod(false), "unload_bpf_testmod");
> +	ASSERT_ERR(try_unload_module("bpf_testmod", 1, false), "try_unload_module");
>  	bpf_link__destroy(link);
>  cleanup:
>  	test_module_attach__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index 66af0d13751a..6fbe1e995660 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -368,7 +368,7 @@ int delete_module(const char *name, int flags)
>  	return syscall(__NR_delete_module, name, flags);
>  }
>  
> -int unload_module(const char *name, bool verbose)
> +int try_unload_module(const char *name, int retries, bool verbose)
>  {
>  	int ret, cnt = 0;
>  
> @@ -379,7 +379,7 @@ int unload_module(const char *name, bool verbose)
>  		ret = delete_module(name, 0);
>  		if (!ret || errno != EAGAIN)
>  			break;
> -		if (++cnt > 10000) {
> +		if (++cnt > retries) {
>  			fprintf(stdout, "Unload of %s timed out\n", name);
>  			break;
>  		}
> @@ -400,6 +400,11 @@ int unload_module(const char *name, bool verbose)
>  	return 0;
>  }
>  
> +int unload_module(const char *name, bool verbose)
> +{
> +	return try_unload_module(name, 10000, verbose);
> +}
> +
>  static int __load_module(const char *path, const char *param_values, bool verbose)
>  {
>  	int fd;
> diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
> index eb20d3772218..2ca2356a0b58 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.h
> +++ b/tools/testing/selftests/bpf/testing_helpers.h
> @@ -40,6 +40,7 @@ int finit_module(int fd, const char *param_values, int flags);
>  int delete_module(const char *name, int flags);
>  int load_module(const char *path, bool verbose);
>  int load_module_params(const char *path, const char *param_values, bool verbose);
> +int try_unload_module(const char *name, int retries, bool verbose);
>  int unload_module(const char *name, bool verbose);
>  
>  static inline __u64 get_time_ns(void)

