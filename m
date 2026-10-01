Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA754756B6
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889317; cv=fail; b=IbpPItkG8xCaM8P1nehT0/656qPeVdHsNBgpviX+ONTgoqIEXbTubyNcDND3jALrYg5KFO4/YTH3H1BWi0uapjASnFqOLllYhaif8HhkaFQ8Aht+D+VD9W2EsLuW5FLmpOP557nggHmsiDHLbmAcjP6fAa1r3LOJMz0rNDy/he8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889317; c=relaxed/simple;
	bh=oSecbmH3q9Up5qBduBmyBU7k0t3olRhaiar2nRLGfPI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rBga/MVjEabrvEbDg/K9QPUYXyyZSVtvWUULiZX7c5OeJtjjZly6hsD2Fgz9xBqda0P8PC0MZwO/SpJ89NBrMNZbkZL6HttKgMf6AhNJXSKe3BpaO4q/Uemnw4dHmDElP8ZAJpHLUKwFbzshx2avvr3SFbSC9n3D0oT4bwnLAMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nQzHehW/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rMwEZCNk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nQzHehW/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rMwEZCNk"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691KGZXO1693150;
	Thu, 1 Oct 2026 21:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZNlpktvhQvEoaXMaxJ6L+LZn2jMQmTFak3nwfx6oKcM=; b=
	nQzHehW/zezvRWuipwhjTjkyLRhUTAaqPe6IhofHV720LJTLjDeq1+T2c02cypsX
	fnY+M9f2GpAyIQ4eUHProriFSFYCvPOTnPcMYpd7+GlNGBXU1QabscVv6CQwO4SL
	y+auqIQqdxpAVgV9wa5siDvJQn5+Fl9WbhM6Nx9/kkdrstAw95hKk5HYl0dxZZtO
	kV3+x1owFmlJXBa8rQMnmlS0+kjGNSLK2zKzzXKhtxIfNB40TNu4JlIV83qgW3mL
	6oliCqdPutpvQRT3gNRZ0jAi26tD2STxhnvlJO2SLVuakGXQXxCKccthpGzIO/Fo
	5x0vZeshrTC0a9J5QfOJhg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4y9jf6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 21:14:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691L5Pph037163;
	Thu, 1 Oct 2026 21:14:54 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsthwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 21:14:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2sj6HPhp7to+lmQlwhfNNq5IQNhMwNLNcUzJBw4q1/x143GMMUzerXzbswT4TKDpQqWHr2PpCxi0YcRAHCk2inzV2JuVcCYi0p5ndE/KXrf9oveiKjv6uW96jU02cGkyBRm2IaeXup6LimMKwHIIcv+FhHAJ2NSiN0NYoJpq23An2dq4w6LfnIOu0e/KtzOKUPW6Xmfo/C4QT0/dWUfouDH3h1sZvbvS0BOt8ru93IwEJmORkfeefb3xl6eMLLM4xGJmNkSCYKstLuEDLGffYABwgLgQvBCUa0YZLmTQO3OxTa18tsiHrdxHp66mSnWEOTuM5SOeIBU6wFN3sRxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNlpktvhQvEoaXMaxJ6L+LZn2jMQmTFak3nwfx6oKcM=;
 b=OW+h/lFP/KyFqS3el80cG5aPUXsLcNSuwLmj61zrZQATg6KEGok11WP/UeRq6ugW1/+blJbpAC7SwHMPORfKcrPxUP0suvzD5zhuTgRWoxsyQjQ3adSxOsHPUXvzzNw7uX2o3Guf5+2q+nrHdvB5fd+R7uYXlXc+RMZTuquPUmeFeBJpWNuxETMHsbzRly1dMr+MUyShhJRONUmFX4umVyuqcImGVkXCL8LLBuO2daQRc0f1EiFZxzg2jOHTo90/j1foBmbbl87lNzAOr/scnWiVWE3lJZ54oO3Yy4UnnuYX3WLaGSfc2JhG61sMcY0W0iBDeisqVOeGFukeyGBcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNlpktvhQvEoaXMaxJ6L+LZn2jMQmTFak3nwfx6oKcM=;
 b=rMwEZCNkDAiHT/ewgN+XTPDsPek1H/BUNa0be+bhxgFkUHddenVHWIcnWL5RU5ss8sparTlxf7ni7Qa0bQh7tpf7abRTSPu+W0Ri65g6xlBhVj+vLiOC40Fo1+rahlS0dnkpgLqFE+6a1WHA0gq6wCufEiGkrW+uFVkrZc+xnxk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by DS0PR10MB6822.namprd10.prod.outlook.com (2603:10b6:8:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 21:14:44 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Thu, 1 Oct 2026
 21:14:44 +0000
Message-ID: <4445c0a9-4f5d-45da-999b-8a6c00526aed@oracle.com>
Date: Thu, 1 Oct 2026 22:14:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 07/14] bpf: Allow arguments without names in
 static functions in BTF
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
 <20260930193127.2181684-8-alexei.starovoitov@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260930193127.2181684-8-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|DS0PR10MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 44395d89-7918-4498-d906-08df200103d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uCaA5wQSCe8hDUJT7r6nAQ480JQRQZwYLpGCAigFB2MS1OFg3p/Np3P0Vj1efNJdTSpar6PINXTfjcBHKEj7N9ErsSm4sM5XE2ZNX3UDpReE1dHRVzpBXSCEx3xlsNeAuydsPt6ahWFsosgWtNGK95zWyiUYt1Cz5H0ZvVWJzGuXV3zx6PeVCDPw18yz936aS2SVCI/ek+qsj4lmpi1MhN5Joxyukva+dM9hlP1WkoL0afnZvE4NR2rXyct3S7N3wWNN3gWz5cr/+9q/XgVypep/HH5IHVV+FWSKV26h9N9yKn5XqRjbIzyY3Tmo4ko3EpW3yp3qqIpKbwypeFBTiq4wKUBaDv4KlrA6RNSE0aVPwe+FfenqJIYYRI34YClVSpHeq6OL5UFSibHQBm20dn4f6FnZjQVCHS/Ql5xBcKogO0g6WirpYHoaah6NokiNTZq7G0snAXY+nfXhBJU6gnaWwKmxvv4lWXPCeoPlKweZjZgkOrWS6kWzs09QSUIOridTuxoTk+IoVL33UjVmjiouv2pQCGN4PgthXs9NboltIgGk2PObquVHHu/6DelmGtUozD0VwPuUh0I+cyNQQ/m0YJ4u6ZL2wnA0Y8rTABEzeTL8dUHF1tDAPYEtOcFlZvSyQ4+9Es95YBfA9ZmeQtTkfXkb/uYn2m1JQ0Mveoc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDlpRStNMTViQlFmdk1tV21lUnVYK2FFdWJ4cVBiMS9TMU5laXpWeEhiR2dM?=
 =?utf-8?B?SGY5Z3pGZitEajRDRFd5UmlPTHl1SGY1OUg4S0xHZVo2TjI2RzFVb2w2bHFE?=
 =?utf-8?B?SkVvblAxWGlwUmhDSld0WlJ1SEVxMXcwL2JrQkRFUmJseVpZOU5hdStEY2Vy?=
 =?utf-8?B?NGRCbm9PZEhOa0pYdWZxMGg3OXpPUnJvMndYcmg2SDFqT2VpbkVaSElHRkdH?=
 =?utf-8?B?aXRXNzRSOEdFbnI3NzltcUFWVk91MmcrTE5iZ0ZXaWEveVJQOVl0OEljOVZX?=
 =?utf-8?B?ZTljVmZyZXF0NE5xUS90bUNSM2tBWlNBdjBocjZlUVA1ZDdiMi8rcWtHR2do?=
 =?utf-8?B?aWtPWThUK294UkVrRE9qZFo4WDlxdHljd1BrQzNoUnh4enVZWEJ5MG9jT0FV?=
 =?utf-8?B?RDZFUStrYU1DRFFabkZsZ2srL2duNnowNHJCaFVKU0haY2NPUU54aVFQanhI?=
 =?utf-8?B?cmRyancvRkxXbE9TU2dzMDRHS20ydFVWdXJkWCtiYzZGQzlQUnZCWTlHK2Z4?=
 =?utf-8?B?UU9FdWM3bnR2RXRXNDU2R2F0TVhHNktxWTJwRWVVamtlcnBXVFp1WVI5Y2th?=
 =?utf-8?B?RFd0ekpxOVdRcmFUejBEdFdFaWdJRlNqZHNocTNnSFdSQjE1ZG0rWGVtVjIr?=
 =?utf-8?B?bWZNU2tSa3NGS1ZMdmdWcXdWTHNVenlicWRzcHdzVFl6THI4a3d4Q0ZkMUIy?=
 =?utf-8?B?aW5zYTdZcmt3ZWxyYnVPQ0FvUlYzeTNJV3M2RDM1U01lREw4K3lSWHA5dFpW?=
 =?utf-8?B?UXZZTENCL2lITm1xczRpMFJTVUVWbCtsTWNYV3Ayek5ENm9GaE1pZjlnTmxU?=
 =?utf-8?B?M0hqQk9WblJLREMxMEhBb25hem95N0tyN2JGbTdxRGRISEpub3Q2MStKTzM4?=
 =?utf-8?B?bjIvQjNINStzTlNUMlRPK21lNHNhbFMwQW1WaFpTci9uVGFyUm85SWZZaXRH?=
 =?utf-8?B?YTVVS2FlNHd5MTNIS1FScVFocWhrMkRiaDB1S3luNjJ1TUxTYUk0SmxJVkJi?=
 =?utf-8?B?cWl2RzM4bTI5VURsY0N1TzFSUHdJa1ltTkQvSE1XbXdvVUhxbTgydVVQZS9F?=
 =?utf-8?B?aUJHTFcxUDViUVNhZS91eHN3a0E0d3lXV1VBdW9xVWdOdzZiejlsOWlqRTN1?=
 =?utf-8?B?OU9WdjVBL1FydDVvMy9PSlNTY2pUeG52MmFhaFpaU0ZDbGk3cFRIMmZ4R3h2?=
 =?utf-8?B?OHZxR1hoalg3d0pyYWNRME5nV1ZYcDByUHJGMjhyUk03Y2VNRVEzQjBuS1RV?=
 =?utf-8?B?NmZvSFpDci9VYXg0bnFWTUptMFRIWEFIb0pCU2NoZEpRbXF5MWg4dkdvZGxL?=
 =?utf-8?B?ekNCU1dpTVFvS1VVSGtQejg2MjRZUGhFMHdNUWd6aU4vNFVPYlQ2MlpUUmxC?=
 =?utf-8?B?T2VpVHNKRjFBUXdFek1udEREaEl5TnViVzNKd0FKWHRXZE8rWFdzU1EyaVNv?=
 =?utf-8?B?SHJURFJwVWNacHRCK3QwcUJOZk9BZmxaSmNCaWt0b0xUZUZWanloaHY2b2li?=
 =?utf-8?B?Q3MvaFIrdHNUY1dxTE9RSVdMd0ppcmFTUDZLNytET21ld3BPR0ZKZ1Rncmxh?=
 =?utf-8?B?cFpkVVhiZ1JEVmVvZTQ3dGdkdnM5NUlhelJQMm5DL0UxTE1qTnIwMm1iN1ZN?=
 =?utf-8?B?TkdZQkNsT2RHejZaZEJxY2MzeFBhRjhHUzBPV2xyUWJNOHZxNHhMODUzbXov?=
 =?utf-8?B?Nmk4bzBPdy9UdGJPY09GSTR1eEJTY2t5ZXY0QVRUMUhnQUJSY0hVYUpJMHlm?=
 =?utf-8?B?MjJvUDBTdXRmOHV4N3gxVnNqSXdCNjFleUFMaVNrdlNGV3pGZGFxdktlMzBm?=
 =?utf-8?B?R3V5eE85U3pJLzF4a3JnWDVtVmhvQ01EOHczbXBpVmNLVUxTbU0rRnlIajVB?=
 =?utf-8?B?RlhyK1hQV252TVYwSGNNWHVEdGlycWdSWHBMQWlVNGhqMmFMQ0dLSkFROUNY?=
 =?utf-8?B?V2VOMWcwKzRHSUVzRkgxSjBvQ2ppZHBGWERYamU3NUR6VUQybFc1VXllNGNK?=
 =?utf-8?B?N1l2SGFTWFJSUnJyVGFQOFNuTm90cWN4ZnM2T1F3bmRzNU94eHpsVENxQXBC?=
 =?utf-8?B?Uk9xc2JCN01NWDdyTnBiMHh4bllVbFlhSEVkWXpOczNhUVlzdDNTVVFaK3Q1?=
 =?utf-8?B?U0VFNFZ0SjZoRy9DQTd4b3lURnNReVJVSHF5a2xPV1VuN1A1dUZJQTVhNDNO?=
 =?utf-8?B?SytreCsyVHFRL0lRTzlwZkdIaWhkOVd1dHhMVG9HNHRHeldtMWhPclZnZ01P?=
 =?utf-8?B?NjA3YTBVdjkvVG1QU2ljWGZsamEzYllNNEJzbUxJWmp2dTVtVGxhVHFJUXQ4?=
 =?utf-8?B?bUdPVVV1N0R4Rk5ITGJtamluTVNlYjkvd0cyQiswN0o0WHY3UWhSZz09?=
X-Exchange-RoutingPolicyChecked:
	EIQ5Mf3TroMGS/u7esfzjJgPYMgk7pfiEnIffFxG4xMbHrFfJfHG4j5H9gpOtg1xPxQE6IMwlKGP11vtIfIvVAROUocmlY4k9IEJzU90pQYBcDXYDTKV8jUDK57ivaFDG4K2O7LeabY8AB5vOZ5spnJ18Gs26TGQB0FM/1gIptVzwJDvNYr8AejF9ZnxCmamwXgrat0BrSer0zFyJL25JBPRFN9H6zNycszI9DRpX3loCyqbtD/hMAeYmfAkPmq6gQR/kT2eoKQueAYdx35g0R3lTkrq6TSV9isC9vg2fcFtsxZ8zgRYvJOkBUc0QR6XS5zmvEOR3iNcsS5ZCXHy6Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MzzPPNfe9IZbkpnYwQh6tle1KW/2XGQtvWGFBRmngC4hEAwKZD3Mg4lduCUBrOeEQ+h3qrvRFOO/LRKjX9mDa4w8a9rwocuMLtCVg+Ml+piMpzYUrW/XvWa5URw6oGxScGozcdHzYxVgGQPySgE8Xg7BJYIZLnjRJioBKKb8HU2ez6tvGTbHMckcU4MADseLxnzKlaRODu4WC3OtloOkiw1gmb1awWoiIJDVAssNN2ehC3fHYPrzwFhkXpnScD9RBxrfeRmDDqdCEdZsGMvh0cVVEw5WMX52v4jNLPLTqPbDHtKAcG6ppR1j5qGqAs6KqSjO/zp9Cq43tsBBWAkxR0DYW/KzmRa+Ekd0I3ch7QhRyePOF6lR6TRiBTlmf5NHxl5cf6/3zQXXx0IDjW4og+eZwxYCG4n+D2NLT/T0iwAzIZ/h/hhszdlObTj5fA0XljLsbhU5PYALrn1Bj8P0EGgLcui6WcpPyc1Fin/ClcloxVIh2NM6/Co3aMupDV3DjUHdQbptMjR4pRaVPXGQAoNWpIf4jCn5D1J3MdSyeHJvKjqwPuU2U3BXQD+nV08nIMvWaBtqctjKNMCzS9J5bF3twCJXCIJFRRhbQIxiM8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44395d89-7918-4498-d906-08df200103d0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 21:14:44.3288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ5kgmiKNjABZbMRZDTbVHofMr5TdYFggumaZVUg2KqlqGz9ejlR8j+P0DzWEILzDsHMztJ6fwv1tvE6dYM/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4NCBTYWx0ZWRfXz16GlzX13vgt
 MI/LGLRsfGP7GPt+i4+WkwadVfbQvokMXzZTe/fEOGx7FEPYdQ14hLnZwVeWSSf4eyn6xJsFdL0
 6iLjpOg1jh11fBBdmCah2BCA3AIZ0FoKoXglcvaQedOE52jtNecQe1cXAqSIjTUBFVl80opP3PT
 0M4Jd5Zl1BOEXABTpgzhtIZmFzXy56hEeuOyuTD+DHBvQNUXhWyvAjT6K3uOfGLEbFqT+WqJPMR
 LUNoRh/IAtEusvkm/0X1L/HT6AEjPJ/y+NWEH/bQ9TK9xcymsyj2g8SjEjAqDOJYnSw00Yjq3T7
 4EKudMwV4yVWBnb6Hn2UlZyEMIajm6La1vYGWTBrNdMeAkR7p3gLYbLJSjyZKUF3RirckVFYvQd
 njLQxUGXp2axUI6F50Pjh/FBYBjucz4uDmylZdCXZSTKSdgDGytlJAKGAPUeGAFmMkmvR6Sntas
 TtL6S9Sy/X3srMiVLzcL2cZdGovTq02T7amAERv4=
X-Proofpoint-GUID: JmMywPvKfk-GUax6yvOuNgd7BxRpNI21
X-Proofpoint-ORIG-GUID: JmMywPvKfk-GUax6yvOuNgd7BxRpNI21
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4NCBTYWx0ZWRfX6oG1r3145H4q
 TenTOjjwuk3LAGqlG0h3W9ssraTc+GmDihhagmI+POlxHp73vbbJqEeFBt2F2cPpm3mIwSWcGQo
 Uaj/UUxrgMHO1H3dQ6zyuT8VAncKwMSbQUjDuUHHapCWQNQkO68Q
X-Authority-Analysis: v=2.4 cv=IuyL47/g c=1 sm=1 tr=0 ts=6abecd4f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=MUPcqdzk0g83H6djw_4A:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537

On 30/09/2026 20:31, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Some static functions in BTF of a Rust program have arguments without
> names:
> 
>   [71] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
>           '(anon)' type_id=72
>   [81] FUNC 'unwrap_failed' type_id=71 linkage=static
> 
> and the kernel rejects such BTF with "Invalid arg#1". It's 5 of 25
> static functions in scx_cosmos and 6 of 24 in scx_simple.
> 
> The verifier looks at types of the arguments. The names are printed only,
> as "(anon)" when there is none. Allow such static FUNC. Global functions
> are checked as before.
> 
> The test "func (Some arg has no name)" in prog_tests/btf.c has a static
> function. Make it global to keep the check.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  kernel/bpf/btf.c                             | 4 ++++
>  tools/testing/selftests/bpf/prog_tests/btf.c | 5 +++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index d27af5d8e495..c9d4b709380c 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5752,6 +5752,10 @@ static int btf_func_check(struct btf_verifier_env *env,
>  		return -EINVAL;
>  	}
>  
> +	/* Rust leaves out names of some arguments of static functions */
> +	if (btf_func_linkage(t) == BTF_FUNC_STATIC)
> +		return 0;
> +
>  	args = (const struct btf_param *)(proto_type + 1);
>  	nr_args = btf_type_vlen(proto_type);
>  	for (i = 0; i < nr_args; i++) {


> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index 207341f4bd99..21fdeeb23405 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -2793,7 +2793,7 @@ static struct btf_raw_test raw_tests[] = {
>  },
>  
>  {
> -	.descr = "func (Some arg has no name)",
> +	.descr = "func (Some arg of global func has no name)",
>  	.raw_types = {
>  		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
>  		BTF_TYPE_INT_ENC(0, 0, 0, 32, 4),		/* [2] */
> @@ -2802,7 +2802,8 @@ static struct btf_raw_test raw_tests[] = {
>  			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
>  			BTF_FUNC_PROTO_ARG_ENC(0, 2),
>  		/* void func(int a, unsigned int) */
> -		BTF_FUNC_ENC(NAME_TBD, 3),			/* [4] */
> +		BTF_TYPE_ENC(NAME_TBD,				/* [4] */
> +			     BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 3),
>  		BTF_END_RAW,
>  	},
>  	.str_sec = "\0a\0func",

