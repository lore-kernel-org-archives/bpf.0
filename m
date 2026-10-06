Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93D3380FCA;
	Tue,  6 Oct 2026 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791313009; cv=fail; b=ByLslbxJJjTx6TX3qW+ND1vglxaY2GBFFF2gWihH1OyZYW8Cwci0XLE2kTdAjdlWY/1Y6JXzOtC2GHD6EDCxTjP9U4w7rQwYF8Rmpx8d499+Cv+YrO7/lv/EhUgT08Dcb+XTCHWEqy11tPs0sd9XDc+N9YiE8JgTNw8s3ZN1ACE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791313009; c=relaxed/simple;
	bh=dNiEZ86nIcaad4dhiIu33PvVPovivZdk+jtsfj3PnGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tt5oOvhOhZ93KKnjzNuN+qVqH4eSv3cu8ETPpkG8U+Ll/AlFMAUo+I3b5F5hxzp9u1RLUefbO+zt6jeXLXZpU0qJn5ncmBD5z+NhenrTFHwnQ/mZhNVrP6XAwD8BIX2KKaAH+qiCGPSx4QLzGSzKVj/xPcnpDvmxJCygFjC461M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bK35kmqO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ezDgZr76; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bK35kmqO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ezDgZr76"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696FYF7R282024;
	Tue, 6 Oct 2026 18:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=863QMWGWlOQnMXMbIARV9MbwD02NM5c1xEWVxquG+ew=; b=
	bK35kmqOarYFYR+zh0EyKXnRlr+ULkKEShxG1cObW1R5cZFjG2Tx2RFVRpTvodNA
	3pzTUp4y0rv0PEiAzGc1Ow9B2kFEHVQl/XyON2T7wKZqBL5usf/GzWDfatgkw1h5
	oEYPKBzllMZrqTGhTMRmdML+oYLfL3sx66fSZGSJZAHE+U+VfE3PkxQoO71NUiT+
	t89fwzdHwunBBwF/Pkr3V/iQUuxQBZ+md1TgGmuiJ5VJxFtN9NE89PpEfHNqBlgB
	YVS2hYqCDoTaCLIM8/ZHDEbkT1Ohd+rYM/Oe9PHYgnTdjgPKRwYxknEZgTgSKSzR
	Jys7eiCdzaIG0p2ICngg+A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2rg1vgkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Oct 2026 18:56:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 696IpjXg038735;
	Tue, 6 Oct 2026 18:56:43 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h4cye7sbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 06 Oct 2026 18:56:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+l3UQpyBLiBDGXZcYg0bFq5LZozHtGo2PdsrQGrI52s2Lo5TBc8cFMeVvlOil+J7vUw6ZbuuJzBl/Xz75oRkrN5JGnkqLaeVQN4qtA3QCcacGg/uEkBYy1aPvb3PTKTO9CmTpnv/9BPctsGA9mLG5kJUxJ/hYSS7Y0s0QnS7CLwARWVL7VkRk4U9xiR04sSpOSj0Gb65qGLji3tNEXKqtHweuOlvonZzCMES19rcfaVsVmSo+AAYYEq7unkWXccRInpK4qD4WMdM7TVulk5QJL8vpDNJT4isXxkK6uT4xdaeCR3TZITOZMClNWfVtjRfzJw3jyR5nQv8AAKj61vAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=863QMWGWlOQnMXMbIARV9MbwD02NM5c1xEWVxquG+ew=;
 b=vWACWCi8Qnfs6BW89MMpXBQJt6sFuFuveOa8qm8XOpBKgdb+9iQvTkbtH6KwFil0oBXwIVM22DX3wFA3jjFhtTaOPL6XtjMCGg3sFnORvrcg06YFD2NnjBOPkh7HmNtWheQXj5pULXREGsJ0INuBzzMxXaJ45iV1TPweIdRr2hCTIStTY3RX6vHOgm7IIA7+hvqoyFx3WiPA40VpqnvoioHPA/DtspsSoiLnrIKukON9QnDAj/Cr9Zlu8Ws6+sURY2J58RRwxv1h2AB3pwU9UhHi7i38uuvIsSZSmHOPn+bL10sxdX9DzzhCBgdPIMhGnfyvw22yRHwmmBrK7OByBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=863QMWGWlOQnMXMbIARV9MbwD02NM5c1xEWVxquG+ew=;
 b=ezDgZr76tIBtWZ9Z8ySDfuno6QamRrLmtXPzhc4nb1AEGAm67H1YajIc6pXrTYQC7cRf2wuST5Eq9bNJ4wylrU2eBi00NGHTpJahPrYlX+cGFlz1JbjFCeOtmaCsYlGptJpHsTSzYX24gvOXCRlYFgiQJogLrYiViBqdsfK7Ono=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by IA3PR10MB8299.namprd10.prod.outlook.com (2603:10b6:208:576::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Tue, 6 Oct
 2026 18:56:40 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Tue, 6 Oct 2026
 18:56:40 +0000
Message-ID: <02a60955-f3c7-4e99-b0f4-75dbbce5682f@oracle.com>
Date: Tue, 6 Oct 2026 19:56:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 5/7] btf: Relocate and expose module inline
 BTF
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org
References: <20261003194323.817885-1-alan.maguire@oracle.com>
 <20261003194323.817885-6-alan.maguire@oracle.com>
 <20261003195955.5AE3A1F0089B@smtp.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20261003195955.5AE3A1F0089B@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO2P289CA0014.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:6::20) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|IA3PR10MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac06252-3f29-496e-63d8-08df23db8e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Hh4eCqxH/Dl5I9sEiMWpsBWhmkCX/JbE7RMLI5Z1o4rQzwpZRFiM/x8gcKBi6SJSEiLopRZH5h1UidnNMlHSNoMx5bZtUcXtJ13J99xcPVlLPiJbp+f7LDTszxY47eJfd6jw78RXuvrRdrr1zQe4DJljIb8kE9wxQkzE9ehQQ0H9xk+X2map+FrQvP0mBEqkSAkcTSS3QEgUIJDygJ3ql841glUI1JS3ThbGfJMgzLPw2cvg4xTvya69fIuDBCtxpOuT5m4Qvws/1o7DlwIg33CjxG6gDBYlEH618PpYq3fGQpg6mGivY1aRS9yrvib4y/Crf+vzLvjWzGHchvBfwjEhLReyPuAa3b/6SgClar+yXuR6Y+OOxdUIDFB/38lF7BvJWB3pYutD6mUGiC/+ClI6TdYeMyU33t5PqXqD6YL4XeXjnzaWVZBh+uT7jcUqZzKgrgFK/EcmC9yhkFaFtrlKdWEPxYGfvhv9PEJ+0TdpR0S1fPa6iTb1OAmE8wWGqOCRD0p+3FuSC/VEkvVDC0BSPPPuDjlWN14keN0m3hfG4WlRIgItIDaIOxKEf3/AreBfgDjdmX9o+rXLnhNC9oj0rK4sC1ybqNs5ej+BZmrgmHxohgffY2jXcEFldkinUvJ4eiSJNMOR5anLBiL16er0qh9oNruG/yDADx4xfzM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmpKNGlpYWcwZExVbGJ1ZCtpaUZXSmNqRTVjRjBaM0U3STdpVzRzcGllTHBZ?=
 =?utf-8?B?VkFSeUkyYW1oTWxwVkk5NlRyR1FMYTNqcGJwcFpGUnVJV1lzUHg2aHpsaHAz?=
 =?utf-8?B?eTUrZURLR0J0TVRlRWY4Q2gxa0xHai9pTDJGUUMxSG03UUJaV0JtVlo3U3RO?=
 =?utf-8?B?YmJ1amdGdmZRc3R5MTRUYUxWWXU5L2pGaG5CNjVhbEhQUG0wdXJzeWZRYXFY?=
 =?utf-8?B?azlyQlo5czRvWkIzUExvN1IzU3E1azVkSjlCdmtGUXY4b3htaHpqSzhoa2hm?=
 =?utf-8?B?b2lXN25ha3Y3NkhDWjVHMW50TlpUVFBiMERNd1ptOXRRTUVVcWErbjdWZHlF?=
 =?utf-8?B?UWcyMk40ZWFoanRjY1pFTjlyWUhQbE1TMkhWU0VoWGs1cFAxendCLzdNS0w4?=
 =?utf-8?B?aitQV25wblNnWGlTU1o5VWk5c0dtVUJrcFVHcUNGVDludTA3cFo4Sk90d2pq?=
 =?utf-8?B?M3JuckJxMng0ZGd1enZ4dE1jNGRUcVMrSmppbU9KZmxyTkIwVDZ0TWsrR2Ru?=
 =?utf-8?B?aDFoYTYrMWozQTEvdTBrZzA5eWhMc1UrT2E5OW1uaS9SU1k3VjRzTmJMelRx?=
 =?utf-8?B?MnlSY3RicEJxMERHdFJJTWlvM3k2ZXVGeVdqVzdLMk9ZOFFwV09IdmY4SEkz?=
 =?utf-8?B?c2NuVDN2cVlRS1ZwYStmZGxrcGZJUkMzcFFTUkJ0Q2drL2ZpcWw2V1oyc1BS?=
 =?utf-8?B?TGZPZWFQZndLcXpzZ0NxbEd6OXF1STRxVnV0bmhCdzZxbjNCQUVmaTBwdXNa?=
 =?utf-8?B?a2ZiVzJEdXk3MzBzZEZRUjRJdkhjRUNqNFdaWVIraGM2WDJGcU1WWkFZWjlr?=
 =?utf-8?B?SkdzajI4QlZTRFB1cUo5TmpzTGs1SE1PblhObTBQY1pkb0xmd0ZGRDMvUm9C?=
 =?utf-8?B?QmVTMElJaS9heGNaaU5pbmVMZDhrY0xtUHJjN0l6dVM1TnllcXB6Tk1JWHJj?=
 =?utf-8?B?R1RzVVF6YWlOYncyYjFVUXp1WTh4WkcyU3I0Zy9jYkRkRDQ5bU9MNk9INnhS?=
 =?utf-8?B?ZDNLMTFOQXFiaGFqcVB1YkxpaThvQUNwcEhmU00yc3QrcEg4SnFYemRnSWRR?=
 =?utf-8?B?a29kc0FBM0prTWdVMFBCcUl3Mm9kNHhibCsvdkF3OUVoZDZuaU9lekd1LzQ3?=
 =?utf-8?B?T0RGTGhmTWFvVm5ZRGkwNi8yZ215aDY4ZUp4Rk80NDFJVXpOL0pkbUJlWkRT?=
 =?utf-8?B?UG9QYlQwSlI2Nko3QTdvSGFKK1NNcUFBZCtHSWVhME1sRVUxZDJVcTlJckRO?=
 =?utf-8?B?bXNYblRmZE9EbmI2Y2N3ZDR1UFJvRVZuVktZSmlFNTloOUFSSS9ucnptZmxZ?=
 =?utf-8?B?OGtYWUJkei9WQS9IVjVHY25URE9MVDlmMVBVbjZPNkxwTGdtbHRaS3YwUTh6?=
 =?utf-8?B?bEJMdzF6NjRFa2ptMGVqOTVDWWZ1YXU4Q0RvQ2dlbEIrZm1vT0VXUXhzSU8r?=
 =?utf-8?B?aGk4emZoaFFqdld1TUE1SWJ0bFpycnZGd0hWaWQxWW4rTTc5YUR1YnZxd3Nr?=
 =?utf-8?B?Y0xtV09RRER5RnBjaEhNNU5kb0p1ZUpmTjg0RGhiNWZaYURZTDFpM0FHMCs3?=
 =?utf-8?B?QlhVQXIxZWZRVVB3SnVSUnJ4bWpVWHo5bnVtMVFCNjZzRWpXckt6NFdxb2sx?=
 =?utf-8?B?OExDMnBmcDJHVVh5R2xkaUI2M3ptUTBSRnZSQXdHZTNIYStwR2pxMnliZlhQ?=
 =?utf-8?B?ZEdXZEYxSUxvV1ZsVGREeEtsSGdIN3FXRjZGVEtoSG8zTVlYclpKak1VZGha?=
 =?utf-8?B?akhaSjRRdThlTkU2K3VqeHJSTk1yWmJENlJuQ0tydGtSaGF6ZkV3VGlpYjhQ?=
 =?utf-8?B?ZjYrMm1iR2FIbExydXhneExUUHRXOFZxK3VjRVphUWhOQ2d6T0hnSHVZcEFr?=
 =?utf-8?B?dWRtTVhzdDJPYXJNYUFXK1J5ODd5YUV1dFgvR2MreitxZHVjSFNsMS8xSHhC?=
 =?utf-8?B?L2pWUEczWnFmTitZUWYyTnNqWVRDU3dQYWJ1Mm5rY2toQ0daMUtHL21VZkhB?=
 =?utf-8?B?WjR0c2dOQk1FNE9zUHVoZ2h5cWs4RmtacDAydHRTNkNuQnpBRUVXd0MrS2xU?=
 =?utf-8?B?RjJaMmNOTlkvU0F0Q2ZNdTRwWVJsOU1qaGhNQ0JZM3pzaGVSOW05MFc4K2w5?=
 =?utf-8?B?aXlZUVJHQXRzbElrblU2d3JTK1BjeFJSeGI0UHZFQmxNTjZsQTBEei8rZVRX?=
 =?utf-8?B?MjZQczdUcjRyVVB4Y3crZGVpLy8rK1VwL0x1ODU5dzdzQlFRUmQvMVhMS3Qx?=
 =?utf-8?B?MVhPMDJ1WE4zSTBzeVhEQjlmbVRsU05JbTNrOWo0WmppUUptaEJPN1NhTDB0?=
 =?utf-8?B?TVdpVGV5dlVDYTVVOXZaWjZnRFEzVUN0MkZrajhBeURSREVCUGNDUT09?=
X-Exchange-RoutingPolicyChecked:
	PAtIKtyYZzeJZJjiXkMixyAfgAN3pek+Wm7kLHVIqVDovpb0TO+5V43UpQht9lHZTD4BA+SIw4eAEyPsa9HrE1ZwMN347flca87/coGYrkZTRyvJUabMp/PIia9pMLazDQzvp/BhE0ldR9xgDwlVBiYxWbunVzNglCGCFSdiZ0UY//PsJ5qs6yfse4ijIYYaszc9WFAjZ+SS1KJCwpSVfjyIpq8VbW8TLqOXvyxtY/9QgnoI6w6ik9B3ZA0ZnPXnnHRH8JcZ+28BzI/MROucfuqI+wFAjsxo1n90tv8drg/mltpp5Sn1r5NlS8e0FBScc8iUmJYn9/dtWmiPUZloeg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BzXihmDRnfkO3uE5BTKSwu9O41UVnZqo7MYNJUWBYNlfW3qnvdf88T5msomTGSN43jL93HHZDDAQa0gwqMckBEYl3G3DOrXm0vTx4kkt/VPJstH3ZnxWAhqIdbDGCETxgkoexrDdyNEYkIWBxHy1RGos/s4l6G9sNePvf4ELFSrvg6E0AMH1WqdEcl3ursgsa5UeDJ8jb2Z0r+iXGWpaAnBxFO3Qi4YZdjbLO6FPTKbTw3+pPHOrx83Fo4/GlV3SYCt+f6PXlNFioBudZXo/wIPiE2q9c7uiKEqWjmzHRUBM3aPnsjfrFuMUUBb2bYF7ZZofAnKuHbcBw09luPY6nQMl5mzE+czbDG+LLnAv1CtlkITrA52qhPSFUrwu3XkiiEUPTRNVRM0faoaV/mqccg4Cdr0K/AMzt8dsJ3X9dqpKq3s33HeWv28E+zDDgzhIHe2fQU7V5GIJbIUcSGFW41HhrumLoFwgtcvbZE4l1t0Fz+ZURzxW7wFQfXL8M3wiJLXmpaepnA/fGAu8mclPn8iT+MCKJPW677OiFCxLxPZO+oH3NhcNKfwK8mdpDGAsFdWYLRTid4QV7Vdbbv1NjOwIrnNbJ6oJFP5nx8RUeE8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac06252-3f29-496e-63d8-08df23db8e02
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 18:56:40.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmbgAPa/nHS8aMxtpX57/jNAsP4+7+2Yn5fs120EfVrIzTIdWWGc2dziIdTEUfzcUyYFtEvybHITQaaeigj/7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610060075
X-Authority-Analysis: v=2.4 cv=afj0Dhot c=1 sm=1 tr=0 ts=6ac5446b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=z-3J2M5skUAxIwJIOMEA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3NSBTYWx0ZWRfX9RLpE3Snnd5l
 xQJ2KrHTS6p2xpsR2rSw+6SUlNRjk/Xa/mv+jwOZseR3TP45QDfnm6MKSiRjP08IrqSFqlL+z1w
 qXJkbbaPUSHZVndQFHTo1iiZ3RegYVoGxUhLuqf/mHI9M9MSydJCsbJDxhhHKTfk/vU31XGFUJQ
 il5bixsTOX6l0e7x36Z/vL3V20kA3pE7A4Sq8Sq7ZMGPK+Z5/c6l/ltWzvRL7N1mRWcYK1zvLj4
 CjPoluHtKft74TpHvEvycubyEJp/gA7BD+FeNfB39WRqoiustrYTcRSBa6k3+s1LXfLLZP3GjxT
 ouXzrGy4cZ/j84VgDaGUvcSEBS4Uxc6v5tI+KMM5LJv8Gr6VWkeeSEf3J3FuZ8LVMULeAFJ07Su
 gP7BMcEsnLYDYwGzByTSkqOThU1uNIrIFfU21ghXgb0z+DBqU9abWX5XRGHgW06B4H+xcoZHu02
 h73/OqYJNJV6KhRe8zf0kpKLI8RXwpggE7FaWeuc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3NSBTYWx0ZWRfXwbgc/7BCI2DZ
 Gy2aXFEOnsXCq3AWbGwIvz5qDqY6yDywlGl9Nchsz/I+MPet9rcO97wsfrplJVcD505jXni2ZIc
 W8T50HqUCcisY//AfwEGHAfHyG8njVz9n7UsEOEuculxRdHz7pOz
X-Proofpoint-GUID: YtCQDPzMk6P_Ngs7LFjP0nsE3-U66zh0
X-Proofpoint-ORIG-GUID: YtCQDPzMk6P_Ngs7LFjP0nsE3-U66zh0

On 03/10/2026 20:59, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: kernel panic on NULL pointer dereference in btf_parse_module() error path
> --
> 
> commit 7871f353137bb8eca880dde9f21fa3041a6f681f
> Author: Alan Maguire <alan.maguire@oracle.com>
> 
> btf: Relocate and expose module inline BTF
> 
> This commit introduces parsing of module inline BTF data, rebases inline type
> IDs on top of the relocated module BTF, and exposes the result via sysfs.
> Malformed inline BTF is warned about and skipped without preventing normal
> module BTF registration.
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index c535e636d41c1..28b7c9786fdce 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> [ ... ]
>> @@ -6954,67 +7076,66 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
>>  		base_btf = vmlinux_btf;
>>  	}
>>  
>> -	btf = kzalloc_obj(*btf, GFP_KERNEL | __GFP_NOWARN);
>> -	if (!btf) {
>> -		err = -ENOMEM;
>> +	btf = btf_parse_split(env, module_name, data, data_size, base_btf);
>> +	if (IS_ERR(btf)) {
>> +		err = PTR_ERR(btf);
>> +		btf = NULL;
>>  		goto errout;
>>  	}
> [ ... ]
>>  errout:
>> +	kvfree(module_str_map);
>>  	btf_verifier_env_free(env);
>> +	btf_free(inline_btf);
>>  	if (!IS_ERR(base_btf) && base_btf != vmlinux_btf)
>>  		btf_free(base_btf);
>> -	if (btf) {
>> -		kvfree(btf->data);
>> -		kvfree(btf->types);
>> -		kfree(btf);
>> -	}
>> +	btf_free(btf);
> 
> [Severity: High]
> Will this cause a kernel panic if btf_parse_split() fails?
> 
> In the error path above, if btf_parse_split() returns an error, btf is
> explicitly set to NULL and execution jumps to errout. At this point,
> inline_btf is also initialized to NULL.
> 
> The errout path then calls btf_free() unconditionally for both inline_btf
> and btf. Looking at btf_free():
> 
> static void btf_free(struct btf *btf)
> {
>         btf_free_struct_meta_tab(btf);
>         ...
> }
> 
> And btf_free_struct_meta_tab() unconditionally dereferences the pointer:
> 
> static void btf_free_struct_meta_tab(struct btf *btf)
> {
>         struct btf_struct_metas *tab = btf->struct_meta_tab;
>         ...
> }
> 
> Does this result in an immediate NULL pointer dereference when
> btf_free() is called on the NULL btf or inline_btf pointers?
> 
>>  	return ERR_PTR(err);
>>  }
> 

we need non-null guards on the btf_free()s alright, good catch.
