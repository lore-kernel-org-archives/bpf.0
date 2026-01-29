Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68032861B;
	Thu, 29 Jan 2026 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672647; cv=fail; b=VtCrAmScj6V/y9rzyC58IE9VkG+vNUr6/sWovErLhddCBvjvcyA/SJzNNLwXA9An6DLM/XAf1QDQG3sVvDvfEQFqlW/VT+3tBtG+RaZQ+9RjfQWDEgQI4RE5kpkDKUa1u9L53AUlWO9Lx6O09XcmzbJX0+Q0DRDr2+2SxPtkjFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672647; c=relaxed/simple;
	bh=H+8iTfzQr1o5iJH1ThPmyX+iaLmn8ecFanarFC46mQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iqJQwMVcE+jgxGuCuSwBEdwQ8YOMaUx94gB9wuGGOeLB4H/HMJzMs+0C9EMroFa3WGG6dTtRY0dm2QBdvMNB2jqbEevpExog2v8cUI4dJw48pgbonBtKXm7lpfLNqBH7uycx8SLT5vcxaWG1NkDA71Cb5vdWcAn9443E/vsN4GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CZB+KPsQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NQynkKbv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CZB+KPsQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NQynkKbv"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T1t1E73722958;
	Thu, 29 Jan 2026 07:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HljGyR1yOI9nu+nZJl
	UT62iXw4lQqp3/PHg4UpbUiF4=; b=CZB+KPsQVe79RSzCkSzbIEP96Yg4hOvVdy
	BMS+jpBU+tCMKw+CYF6C/azcyAO88jUw4JBScyh6oClrqcvxp/y3mnix2wbVtYTH
	l5zNKbS3U2Cb8EX2pCFvzdsPp7HxuR1RQtYKBGPcFVJ2pC70sU6CzxipXWYHn9qR
	dtxM73+FEn+UuZDnRRhKSX5SOlDE9MMJXe1/l3yX9EsvnqhIIUQA+cpWxFzTjkO7
	nAJvFo54LFlh2RY3l+mNkHNJ1oQKu9AABsNKOnAcWE3NKUoSlea+Lwgi7Wn7KLmP
	FRRwD1q4lyYa9B3BAcoA5CbsymOUSliXUVUbnuIYgDvOdGMH+v7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by2vgjt6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 07:43:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60T6vr8d012130;
	Thu, 29 Jan 2026 07:43:38 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhc14y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 07:43:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeJVrq5xpyTHJSmfgnP2Vl6WagWeKtC2u0ykD493Ct1gFBjX8hgc84Tdc7eMuPO1JNgyWHJSEf4kKOzx8Lhz9S3O6SO+w67DSajMUwArMSJ9v1CAnGB9myvd4smhDjq0LMzhbi0lTN+eTFtXAzg6MTgNgBb1psegKF7OH4J+lU/nvIt0wrmMQauSoqwk03ZmocoiDjxfFUHfRO+xvA0wiiVOWet/t2e/pPTrW7tGhF1afvqK90BekIRStoYd2fAjZAlMLrQnMSBocKxUFq2qz2WIH1xaG9NamHn2VvILghYXDu/TQPqWEHJ/hMIcr2BNDQtWC/SDOgFlHpUagMkWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HljGyR1yOI9nu+nZJlUT62iXw4lQqp3/PHg4UpbUiF4=;
 b=OPMTGxNOxVupqYmRsLjDTb6xbqIeZKWu7Y+hmMbpcHnSLQjrxrLjSOrbXX+U+4tTv3tCDvMhbmzaxmrpkM035F9Z8MDY40kHJDoI9HqLJ2f90TJshV19wL1rTMV/ts3ylVYn5ndHyMWGXt45eovINb3X01TUAHOgzwvizHV0zdSA1oNJvEV/RW914VxS8lGE/Vw6AGz0I2sUSsF8l9lP3tcu1ruBBp1iNjirW7VWmvv1hUL0dcUIJwQewcKjc7QroqqQVT2XGEUAEqge1UJSVvT2bLZLEW52IP/MNAv58AedUDeY1GLCh2roF0iyIVA0yOA2KPqUwfsuBy82WJcjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HljGyR1yOI9nu+nZJlUT62iXw4lQqp3/PHg4UpbUiF4=;
 b=NQynkKbve4TA0bTHLDHTVFiQGlo+MSrV4+8NSIotBoPaMH7/6MhASO0F2ehh8cDix7uz1PwfzitsHqOpBTBdXrwArodZln4nU9EZ8NnQD5eAKxeGyrl/I+AmztTrajr/PbrLLfZ95gh0N+upPmMy1/kmkdGv+s4E2G2YDsf7OrE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 07:43:35 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 07:43:35 +0000
Date: Thu, 29 Jan 2026 16:43:28 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Petr Tesarik <ptesarik@suse.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 10/22] slab: add optimized sheaf refill from partial
 list
Message-ID: <aXsPoPXvAWoSizCq@hyeyoo>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-10-041323d506f7@suse.cz>
 <jgmmllqopl4rpihfe4jdnuifzexlffef5gehsocdcdu2xdj62j@xuz56etxseza>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jgmmllqopl4rpihfe4jdnuifzexlffef5gehsocdcdu2xdj62j@xuz56etxseza>
X-ClientProxiedBy: SL2P216CA0195.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c91df7-d3db-4edd-c41c-08de5f0a1be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X5AhYiOAh8tRTbadKcXwL0NSFMZuHNkOe63oEd3SL1dNEXSGdfKTknUpav2i?=
 =?us-ascii?Q?UZ96Gse152x/N51oEkYhgHos9yQtvVFmGw4nxm4mRrTJ5v9G0OI9Srr3AgS3?=
 =?us-ascii?Q?3H7QcYgGacrOGOvR1JTiCJzsaXdpUGrp82KOZY91qPB6zz6U3xlCmcS5RKaa?=
 =?us-ascii?Q?HzG/oBuYQnlqvfF+4tzqbSCPlvYG1nAYvNyR6peZiqfRja34NExOBUyrjrdV?=
 =?us-ascii?Q?NvhVbqWJncYBjc4VKXAoKy4wiLzXv/gma1ZjroV5hyvuHI1rxseHvW/eLcwA?=
 =?us-ascii?Q?rs9ZSiigF44UPoO4C8r1wOpUxsK65wpUw/rz9B5naNLCE81eUpWCzUPGX23+?=
 =?us-ascii?Q?Iiz8kqr0rp+mK/GBm44GSO6MTh/4OTHzfXnVd3wrX8OXNQ6cjok0K4V2Mtxf?=
 =?us-ascii?Q?GEjskB8fOTN3Qylkx8+eBiFmZ7c0R/vOmdy4uS/lt7pCJjQ9roX5LtqnjzYZ?=
 =?us-ascii?Q?NKhjiMB4ZYBkjsY73apo9yb+4slG/FbFBRjUw7tG9Mr1QsA7zQzZ9KODQLvz?=
 =?us-ascii?Q?g89kmX1qgJjEFM9YH+bzByzTSJwtJMub7+LXoC4rl3xdQAbR9zeVxYqrTHAq?=
 =?us-ascii?Q?XNksmNzpakBrcIaP/k9Q7MEPCaktFEVyn/0swvgrdqF/RSbygRGZuZOXMpGv?=
 =?us-ascii?Q?ry3PAkzHgTSZ/F+qLRodlvv9VCLAhvZfZoDu0VN/qY27MUmwSoPEHmoNRMAp?=
 =?us-ascii?Q?3f5lpV6UvC+zAAnUnUsIFJJLveaWWwaTq0F6mBjKGul+JgW2uNrAeDLegilV?=
 =?us-ascii?Q?b1sgKFf2xibYLCeK8lHop/8HJwu6Ec8yb0rMZT6hPLKf2MddZ/HssnJA3wze?=
 =?us-ascii?Q?nFNQuGCojOPatE4aEiBCxEovD0iu2R/ibjJ35soAwZPb2lqsRn4rqAC8sPbU?=
 =?us-ascii?Q?qrqitzjS2zGEG1A9ZLbYy6VkXDtg5Xy0T+yUafh/TVEizBvoS7Pv+lwFizFl?=
 =?us-ascii?Q?Qc2wB791YYLPHcfiM7JW4R8PZ5PwLisAprHHiTOoLvWXKQlpk4b+0srbJtvd?=
 =?us-ascii?Q?+3qbDqWDyd71E03iGaNIoaGSOjnsZNU22viPBjZsj/g7uXfM0pY13bCUwbKR?=
 =?us-ascii?Q?br7ZPFKYyDlzXdzyZDYR5g20dVQw9Hadok56/4WvMOmklATFAJqGaE7CS+/S?=
 =?us-ascii?Q?J/akfo9vTSvL6Z4SIZfyOdsQEp597GJZIu9AKBL7paol+llLq4IEHgcE1E1i?=
 =?us-ascii?Q?5/mvlDWs9e4H2B8l3vG1G8cvTEqUBOaehCDiVyzDjOGml51ER8rrmRX4y8mT?=
 =?us-ascii?Q?qnli/le8E2O7vZZmzq79Ep0TOo8A9ANPX6+kB2bfImxgEnAz5Rq4jzMZHxdS?=
 =?us-ascii?Q?nwy1fmCi+eGBgdFXQNauqF9ZjE2rpv+jg9Rq/tuNBF0YdTOITyUdZglhuRBV?=
 =?us-ascii?Q?aYDwXic/nWoa1bfYTg+7pRUmROoXNj8ILA7ZCZZwE4AsBlWJQMccsptXDRvQ?=
 =?us-ascii?Q?NGnI8LZv4CMbHuC/qWmxJvN4rFPn8yuyoOWRLqq+1SVtAVyrlkHEZ17K2Jk+?=
 =?us-ascii?Q?xqDNd85D506UVO+q/j7FDL2hzdysfEoRbLA4b9c7tM3EUAZqcEzMqsRhwOaA?=
 =?us-ascii?Q?1Jb/OdN03RGNhQpYvDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KCOip8WUEXOBAFLjAzGz26JKd+g3AlApVuvDRQthTodR+B+EjCzSX0gz3SJI?=
 =?us-ascii?Q?AlumIgwFK6Rvug2HIJMyW7aOQMMqlekoqsfdDyNad8a85GZ9gDjyLPzQcKZC?=
 =?us-ascii?Q?z4djq1N779H3WzNpk+sAcdmOqwXh6yyUFuOIWS2VseuOq8HCwt4vTbMCLERC?=
 =?us-ascii?Q?veQRlFiXb5NwfxEuE3Fivm766uRMk2HSmt7yrlGjsF3gqWS7agX45L5cXhRQ?=
 =?us-ascii?Q?21PPmTGKXZHKc5WaGJN+69x3rdr3blKgvCttHFPFrpULORUlpq0ZM2tuORZf?=
 =?us-ascii?Q?u0k5CBqSJDjsZpiQH8CQJO3kQGZ4/ioNelagiDO/YZcyiVoXOzbKNVT7WLbT?=
 =?us-ascii?Q?8f89bEeUsIhHiZ9201IBofN2EGM8uKtKwGBFoSguL49osyd1orrMpXWSQzOt?=
 =?us-ascii?Q?J6bjllbJ+WqK2HaPUlAXZGMy/OGOTHtQA1lSlnEFimrneOG4tAxjcL1jjmSP?=
 =?us-ascii?Q?JQrVV1FOnG0O2xkv62G6+OFKXFpzStNKLYtorl/5BwlRvnmVEudokY89JW12?=
 =?us-ascii?Q?FRu1sScaPhmQu9sopjACvGiyQ3/ljJmQ0Ox5XR2nY57BRWflYT3A47QR+qDz?=
 =?us-ascii?Q?uJDYkf0LPRKyQ6oRHqxTnixyAEUGLtTIzW5VB5n+FLPi29KtP8kZA4lria4x?=
 =?us-ascii?Q?ILAsGuMpDubNIY+Afd/1Is2ow0AZNFABxiNncNNaSG8UTvm8NOqLHvOUcDfk?=
 =?us-ascii?Q?SV2LVy2brCfKeyJBTXjIMev55bkkleuzN+R7iaVZQ+kdGoD2lfKMH1wRUmL8?=
 =?us-ascii?Q?hqpqWwkKSj+Hay/2LCZxL1oa3bm8l1TciYKzGDCRws9wYGS/XMGR9SzGSCHc?=
 =?us-ascii?Q?YDEwNoQLo833bhZXbMl6kSEg+LfpMbBSgITmPY+QSDhMKlxUgQRQNDBMISMP?=
 =?us-ascii?Q?z4wEvA611r/bfTQy29YZQgWP7VBuLriqAdJIfDiHiwyXaorflzZPKfidq1Qq?=
 =?us-ascii?Q?7/J7G99D4sGBeOTadTABGzfdXU+s/9BNCzznvsUs0HKDIppXgBdz2v/3P5aY?=
 =?us-ascii?Q?VPhPsOW4dATsrYGtTdsZbEZEUegPADCXqA7rvcbGQIEOdzyLErg0k1kbMEkg?=
 =?us-ascii?Q?Yh2OHpidvJN1Iyp70xSz/Vcymxmq6pLdvw3iYvq4ZL+TEtS12i2ifJBoUpnV?=
 =?us-ascii?Q?TmzjpTfURgaK79PmnC4UzUn72fABFxyKkjFqnvtmuGvhwzE/Vutv1KBkscMc?=
 =?us-ascii?Q?4aO13oFeKO9fJ+AqP5kMIdTf8sdk8mxqzFqGMsEn9sOg9bgSmSXN5rvp3HoW?=
 =?us-ascii?Q?0pjdixvuuCgVbAWd11ztKd0Q5q+7XYeO0MJdzH0chekYzH3rT9EtycEn8hvw?=
 =?us-ascii?Q?x7TDR13w1u1KTBbDnlgYbT2Q8vjLCZrmqrXOCqiVxfjtls/ATGQkMHgHk/WE?=
 =?us-ascii?Q?sRv3tGKKJutFiC8zmU9l0gQEmG6HxFz5/iISSeDKtaPo3W99D8Upxm8KTnjN?=
 =?us-ascii?Q?qCNYHzQ737E+VGCesaN7ysCrIuqOyEjuf8VGhQ19URNPOYqjCxU+ucEOgijT?=
 =?us-ascii?Q?ZDs4REnEnq5I3FInrZA0m4HyWHq6M4YSGMQESXZMsrPkY8lARH+Z4TXdRA0S?=
 =?us-ascii?Q?heSAXfn6UtpzaDsSZvIuJMCK0njmj7VHW3eMmK5Hh0rs/A51HpVaWsNKLz33?=
 =?us-ascii?Q?pLcwKLQTB4Ack2OM5ifyEPY4iDpxlJBS7RP6KS9an3F4FYqMR+JmKmBRY+Hw?=
 =?us-ascii?Q?lVtjiyodapdCGRnpifv4nX90R3fOrN5DRUglnZG+Ma6e7QWMpAMT2ICYVgXz?=
 =?us-ascii?Q?+wwdc38QUQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	88p3Ut9l0xYFv6psCjP+pUHNaqSW8/I23rh9dwTWdcReOxgdXne79pPOJPzt7ha1aMrEnJyGdPLn/HeQxd6uLG+7+W74IyQNTMYWtm4gZTZoEm8VFbQsoa72rYPWSQPCLo9DbG8d+sNVQ1jBRu5PI9i+zPIWoLXXtwiR+/aI+DIXvDobNG1zNaNE/FnEnPYp31sB4Qdk9d+7ALBxuP3RhfZJ1yq1N4atrbmQ3gJZfF8iX0t4gsIDsLmGOfE2W6G4luTMVltMGemWe7A0krOEKk8Dn/lnGDrSMx4MnlB4AOPLqkNpNzBWI8/yLabjfW4w7+SouMRFLZ78cEvpP10irrOl4F0IYjZ/v03jz2oFo8uWTYrlxSoGTj2fzratTI+lKm/scIZmer0KZYYsWlgaV2DJ1yjeLUKeRng8gBhGgnWJIytqTMgWsjgRQwOcHOpAP/butQanvEVe21NyE6kf8v/RvweZNeKXeLhC99X0Hk5G2g2LSbO2CY+ldYUUH3omhpG8mvGkmLehoxhhHGHLulK1d8+Kia73nqrexy8IkIcNyQ/GkOHuV7xOR5GYfbKDhaFstEjsq6Zidweo9pL9+w1ZohnqASawN8ORfFGvBKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c91df7-d3db-4edd-c41c-08de5f0a1be0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 07:43:35.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVJyltraP94K4GKfVe+3YiLy05gdkl38wrKb7ITiTwZQj4MhcgJE9abHqNewCFWw2wiZ9FHwEno40evGIPpmLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_01,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=950 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601290045
X-Proofpoint-GUID: Tzsn0SsPRWjQ9EaE15ePwBCNK662YL7S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA0NSBTYWx0ZWRfXwW/Nbze5KLOZ
 iP2S3b5uis/AdaTXywXZNlfPmyE6ELfjl40VX/AcyuY1BoiHtZaqz3xZEzM+cGvwrI+NXnFH/Gm
 gWLuAezdutbZ3bJj+N/29uZUpa8sMv4g1TMhTu/y3Drms5scjnrGrHsiDKKvLRqrlfR211IgVQz
 vzD86M4v5Lj9wQqzAOs9USsw0J51/J3jwAqTjtNXTOB29dMyUunJZg3YqBDqR1pR6w7yYl09n6A
 kN+G7O5zKRE5W7BR0SMrm0BytGc7Z6qm+xGD0sJnq4osVkZl70vUtSMXBmi51LtH+GzkRRUsWuS
 aUIKh7DBCbURlbuUY+AKyhTC67sUD+RKT/fGpxw92IIp4RUJQgWdGCTB9LBaP/PNj34P0EwieiI
 4JrduJsGdEJgJ0ThsHDLVEM/lxNWcmQsQ0ZrqPvpoCekeRueefHfUEXmbFiLpzJthiivlLxcACn
 4Q5FFFzvsUe78YN9sgQ==
X-Proofpoint-ORIG-GUID: Tzsn0SsPRWjQ9EaE15ePwBCNK662YL7S
X-Authority-Analysis: v=2.4 cv=a7s9NESF c=1 sm=1 tr=0 ts=697b0fab cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=xTB-ZrKxoltFZRK_9CIA:9 a=CjuIK1q_8ugA:10

On Mon, Jan 26, 2026 at 03:12:03PM +0800, Hao Li wrote:
> On Fri, Jan 23, 2026 at 07:52:48AM +0100, Vlastimil Babka wrote:
> > At this point we have sheaves enabled for all caches, but their refill
> > is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> > slabs - now a redundant caching layer that we are about to remove.
> > 
> > The refill will thus be done from slabs on the node partial list.
> > Introduce new functions that can do that in an optimized way as it's
> > easier than modifying the __kmem_cache_alloc_bulk() call chain.
> > 
> > Introduce struct partial_bulk_context, a variant of struct
> > partial_context that can return a list of slabs from the partial list
> > with the sum of free objects in them within the requested min and max.
> > 
> > Introduce get_partial_node_bulk() that removes the slabs from freelist
> > and returns them in the list. There is a racy read of slab->counters
> > so make sure the non-atomic write in __update_freelist_slow() is not
> > tearing.
> > 
> > Introduce get_freelist_nofreeze() which grabs the freelist without
> > freezing the slab.
> > 
> > Introduce alloc_from_new_slab() which can allocate multiple objects from
> > a newly allocated slab where we don't need to synchronize with freeing.
> > In some aspects it's similar to alloc_single_from_new_slab() but assumes
> > the cache is a non-debug one so it can avoid some actions. It supports
> > the allow_spin parameter, which we always set true here, but the
> > followup change will reuse the function in a context where it may be
> > false.
> > 
> > Introduce __refill_objects() that uses the functions above to fill an
> > array of objects. It has to handle the possibility that the slabs will
> > contain more objects that were requested, due to concurrent freeing of
> > objects to those slabs. When no more slabs on partial lists are
> > available, it will allocate new slabs. It is intended to be only used
> > in context where spinning is allowed, so add a WARN_ON_ONCE check there.
> > 
> > Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> > only refilled from contexts that allow spinning, or even blocking.
> > 
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/slub.c | 293 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 272 insertions(+), 21 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 22acc249f9c0..142a1099bbc1 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -778,7 +786,8 @@ __update_freelist_slow(struct slab *slab, struct freelist_counters *old,
> >  	slab_lock(slab);
> >  	if (slab->freelist == old->freelist &&
> >  	    slab->counters == old->counters) {
> > -		slab->freelist = new->freelist;
> > +		/* prevent tearing for the read in get_partial_node_bulk() */
> > +		WRITE_ONCE(slab->freelist, new->freelist);
> 
> Should this perhaps be WRITE_ONCE(slab->counters, new->counters) here?

Agreed, this should be WRITE_ONCE(slab->counters, new->counters);

-- 
Cheers,
Harry / Hyeonggon
