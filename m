Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56703471437;
	Wed, 23 Sep 2026 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152074; cv=fail; b=Wni+X5pkmnkUOft5wscuPWtGhV0HGyZrDecw+PAnl3KhfLVq16BKbP2148lZ/SA13pt8VzISZnvXFgQnKhBSx57QeCFV3SA3eC+JKmBi2ncxz42pIr7GhJvTbdedp8rL1JXTy/ljW1X0z64K+EpgPOa8A/sqpXgBpoBH9OeIjBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152074; c=relaxed/simple;
	bh=RwohmyYsvmPoMPjekhgb5Pnw89EQgp8Dg4VGyUEP/F0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xmd/XioGJiJ/ZLiD72BhJAHzpDfktfCdeHxQUaSDN8rtI2frnJjs+PPTZR+inI0xaU7Sq4nIXutoFFjwi0gKhQZbburZKsyKLmjjC3+oFXfXgW5GFFCQYA94reg5fjk2UwcSqRoKnV2Lg+qL+14zuGuIrl0XN7Dvl4mNnHI8WV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WzfRtRFS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z7th/u8F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WzfRtRFS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z7th/u8F"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N1uZB83640237;
	Wed, 23 Sep 2026 08:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wyks3klrg6+VZgYxA5pWJsN9inqkKMkPV3unFhrwIqE=; b=
	WzfRtRFS11rka0esL8WKsW7xJsEJ7Yr8iXQRRPdukfgd8vM52prIOAkGj+6XzD2E
	M6gC8OXUguNOfUjESf+7/LGC+2RUwR+kWRGXs2QtZ9PH8JrcfHtBwSYcn5CrGXmR
	TGF1K9A//93yySvj53ri+3HV0irz/qUScL0yGK81v0PxovSBJDA4a6ujNkblv0AM
	uxdx9ixiNPmbSLO8S55yUn+uA860+Ud5Rywyt8uzN+UqGwhB2v7DOjvp1kAkm4b/
	rE0Yl/Zprevzo8zBz2tHwwJLrRrdXpbdzEesOD483jEg61LuTCqdxZkSD5mpbI2B
	U82e8xNXlHPGK/35AmQk1Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsjxb5cek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 08:27:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68N8LK62015585;
	Wed, 23 Sep 2026 08:27:11 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepqgyry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Sep 2026 08:27:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ysb/FmulFMr0kTdbSqkR3eBMeHr1e8fnzd0KoCd9XVsWrN/5PrjnUrfQo2aGnPpZ0pMO0AI64Ug/B4zmKKisdAUvqGOlB0AQ4Y68WyBhCBl5v+9VIa2bfhhQTq1THVpe6sG0PIAtchtxmDf88RlrxEJJ8CiVEvbpkv08oJvhBn80SjPfxZj+Tic480Tn78tOClseaINRB/u3s1ZamCHVLDzPJOWr16DrCtOrrPwrig5N73Ip7YqKGrGAh1qIAVvFifTcdhSy0eXSiKJ7PcCc7Mmz1SfinH5ChicgQ3NYTojijT3jbKgsFRstnQJ+2mDDAKsilgdKPee8TiWvqWcrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyks3klrg6+VZgYxA5pWJsN9inqkKMkPV3unFhrwIqE=;
 b=i/TjoAaIC1Q0XXNfhZFVHwQukRIs5UdyrthddiV+P0Fs+9nmutK3Y+RoPGtyAaMTVBbKHWDLImSp9LeHbdYpgpwsPvCU6orhhJLcE09eRWUhfwNbeJoo1M5tipot5EdgOQjRLjocvNOS7E4WjNoPj7m/W0pfdxparWC6KAmBpZmogWJslLK0/Y897wF+2XU+Ac1q5dn3pMdJMYavl+sEgtJCbrLbfE9aLpcz/MQoWfn4hCMtgQQw+eEMD1mVXmP/EPQyX0DEjAZEwnY3x7vjpU/yRktVvA3HQa3yMk/hvX/m0X6iI3hgBDmIruGDUczP53xy+ApjKqvxXpHk+xbvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyks3klrg6+VZgYxA5pWJsN9inqkKMkPV3unFhrwIqE=;
 b=Z7th/u8FAE7gEmcl1hxjRYPvCGUkKodYgoW1fcu824KWC6D0G84XqV0hGVGgORLYr555ms6y6pZv28Fye04nsaPTKA8tpbM8WQ+G0Xfi7rI+qaIqTeRGVZO+8X8dpdSE38X7xBf64lBd/nQILHU6p7jEJihcMH70orcYcpcfAJE=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by IA3PR10MB8065.namprd10.prod.outlook.com (2603:10b6:208:50f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:27:08 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 08:27:08 +0000
Message-ID: <9cf62f86-0b7d-4175-8334-74493ea3b04c@oracle.com>
Date: Wed, 23 Sep 2026 09:27:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/6] bpf: make the vmlinux BTF an on-demand
 loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
To: Jay Wang <wanjay@amazon.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yonghong.song@linux.dev>,
        Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        linux-kbuild@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>, linux-modules@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>, jay.wang.upstream@gmail.com
References: <20260923053948.30617-1-wanjay@amazon.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260923053948.30617-1-wanjay@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::18) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|IA3PR10MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 096060eb-1884-41e5-8d36-08df194c74bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sOFVkQcB8vvZku3A4Mjw+xh5p7pbNe+WFauCwltild3KvTJFNVrrp6kgvA6cuySxaMy8tpze8Hzk1RCtwgPzKuxDMF9zyh6au0BOJqIFJ9OGyNr8vUj3lDgQ4kHFiVfBWvwM6bEVsdh4GGkvssz+0ivRTaoVRoNlBtRPXfM5lY50QRHW9g9vnMKYs1DGMyLWO2ibHvsXgaK9nE30aUxZ6GVGzmBFBHbEou7a4i4db1SFfW5rHtCajHi/3jCASw1pJ9qGYAraQ+5in1URbygp8wkhxSH77S8g5a2h468sIzOgwp34yp3bt29deno0OQ/RdYS+iD4XXpcT1Hyc+6FJRwhkEPYNfpws6mGVuSISS5OAp9YVVzFL7cOmdG5PuHMcaHxewnGP8Mwhj9ioeIOHdjHiJvA+UxK+7THrie+THYa569s4Bp3gbjiRnG9ctz3rLEVPeQgsdVOywP1BEeAB1UHzWjrouM2Z8TGzkxoUFXrO1Sda3uZlCNlyk26SDTnXO5mUBmk4JSzSnTUMDfckWfxJFjv7I5Cn87U3FOrl0bxWAlrah/xPJ2Fj05V6P9JQxxbJCfxMLgYNlxrC1+s0YrCTbaHIgIdUNA6W/OiEccPJAcZv00BMGNnfzD4gjHOj2rlD8LswPIIGJrB6VydcQ83/p9iL3kwMsey1quyM4XU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3pWTTJadjEyUUdzTUpLc0cxSlgxaVM1aEttMlZ4WkVnd3BPVW11bWgvZU5E?=
 =?utf-8?B?bWF0QllCMi9GR1NQQTF6TW94OHg2UXRXYWF3RUpuRGxjcTAreTdvUXk2SlRC?=
 =?utf-8?B?V1czbjVpRkp1RkRhLzVqMUljRG1SL0xKaEViZ1dmU2EzQXUwSE0zM09RV3R6?=
 =?utf-8?B?dE1VeGM1NUZJb3JZTFdYYWRSQlVXSCtiT0JDVUUxTDV3QjQrVUkvRFVmcEI3?=
 =?utf-8?B?azZuYzZyRGwxUVVUckVpNVhIdDE0amJyUmxvVHhsSmZyYWh2ZGNxeUhKNXB2?=
 =?utf-8?B?eE5sWDExTkRQcWdCYmVDMkRWd1F4OWNaczArbzhZM05WUXlZS1hTN0JOMHdC?=
 =?utf-8?B?RGYzcTF2NG1xK05RclFHWlN1RFBvcGhVTHdxRHlDTDBpczloMGNmRDIzbTh6?=
 =?utf-8?B?VE84bkYrNG5kM2VFYTBPcVFEcW9XY2pzc3JoUUw5cjNWSVVPZVRjalNDWG9U?=
 =?utf-8?B?WVVnK2ZJaWxScndKNXgvQnhZU2UzOUptQ0NEcko4N1NGSURtMHVrd21Pbito?=
 =?utf-8?B?N0pRUlYwQWJpdWlRM0s3eUZKQU1BMUhNdXBTV2VTMXhTcWZuUGV5SGxBM3Zq?=
 =?utf-8?B?aE1OTWRYZHJZdlQxcWlUMzJXRWJFOTNBWERyQXhYQ0lvcmNaLzZ2RDJxSDJE?=
 =?utf-8?B?ZEhoVU1VVzFXbUhVMXVET04zaEprb0IzOGJJZXM5V0VZTlZ6Mk5YRE5USWdP?=
 =?utf-8?B?T3QwbFR0eWU1UWlNRUtWMlZnaHJ2cG9aYnljYVNOK0JwMkx0WkFSNnBWZGFS?=
 =?utf-8?B?QVVTS1BGTVdpS2tlQ2dQWGVITmt1WTVuMDYwK0xvYWVrSXh3Y3pSMzVIVTNu?=
 =?utf-8?B?TWNRL0xQRzdMbHZJTk5iK096c3hhUUxPV2lySXdqVW1wTFVWdk42MUdLK1hF?=
 =?utf-8?B?QjBidDZkeWlaUDVNd1BabWNBSVhUclFpOVFPS1RWWFExQ3BBM01Ra2JEeW5o?=
 =?utf-8?B?N29ydFc2MGNpcHZhZVlvT0NzK29wV1k5VTYxbE5mUUdPM1FETUZWaU44MEt5?=
 =?utf-8?B?L0p5bEtlSUdvQUp4OEVWL1pvSFQzUzU5eWVuaXFoV1JQbEpVS00rS0EvanVz?=
 =?utf-8?B?ek93Qm5tK083OWl6bldBWS9Xc1JMYVpyMGxNVVBIRVh6Z3VaODJ3b09VaGlH?=
 =?utf-8?B?YUtiQkU0ZmNkWmx4Z3ZSZy94bHhyZFl5dkJTWXRCSGt1Z0RqNzRJQncwcHFa?=
 =?utf-8?B?d3hyL1VVb1hTTlgxVmZHVm1GNUlMZFJzRXpHcTVDK3AyUDhiNU9vUEdqRjU0?=
 =?utf-8?B?ZnV1eC9NQXd2SXd4eC94K25FaDZQNkl3Z3dMNituZ1huaiszeDVVemZESFk1?=
 =?utf-8?B?TUVHRXRpQnIzbGNyQ0szT0pyd1hoaWJkZ3FBZFFzR3ExRnVQazI3RVhpRFVD?=
 =?utf-8?B?TXVock11UFM1YWRxWVB2TDRwNnNiMVRQaUFvU2c0MmdTQWx5S1U3aXgraWha?=
 =?utf-8?B?KzVOQ1UxNE1HejByTzBCWlFldnFLR3ZQSFU2NEFlTVowbWhub2I0ZG5YRW5Q?=
 =?utf-8?B?M3dNUG82LzlBM2JCOXpjN3Jia0dwUU54Nkk5Rm1mR2p2akR5ZWR2WC8xamdl?=
 =?utf-8?B?cmxNdlNlNjJibjA5MWk5YTJsZ3dKc3VqZEpYUU1ZaUVDeVlzYW50VWtsT2xo?=
 =?utf-8?B?SUtiU1g1K05IOGtnSmhYWVpFUlNyQUlXalZOOG9JS1NrZG9sdFM3YXcvSVR3?=
 =?utf-8?B?bDhIcW5xS2trS3RIZitmZXFIRVVrc0tSSmVhWFRPYkRhWTE3L0EveU5ia2RL?=
 =?utf-8?B?UnIrZkN0VHVBa1U5ZTV0am5UdjdESTRGK1EwandSNkhBUTNJRy9JempLR0hy?=
 =?utf-8?B?eGNmcFJuYU9URVIvTEtWc21GQ3plS3FVaTQ3TTA1UzR3OHYwQVo2cmVuZXBC?=
 =?utf-8?B?aDFyUS96RUFPSVlPMGlUYkpxVVp1QURxNHBGeDl3T3ArN0tuY2Q5NldkSmZE?=
 =?utf-8?B?YTVuQWw5YjNFTWZDVHBIUnl4UHFOVnhwTUx5aUt6N3Jrc3J0RDZLSlB6cjVD?=
 =?utf-8?B?eHVWaVR3SnJkMjdFNTAybjhXcHFjQmh0RHpJL2VEZUxDR1JNMlpVZUVZMk9n?=
 =?utf-8?B?eDI1R0h3M2pxQXFQS1hNOVljZ3hONWJhMEpPTklWWGJjRHluWGF5azRCZVlM?=
 =?utf-8?B?c3hPZ2lYWWVIU2VjVlVJM1ZvZ1NXM0I2TXdCRmU0QjdoWXhzV2VaR3JtU2tY?=
 =?utf-8?B?N2c3SEg3MTY5cVVDUkVuMjlaMUN4MHgyOFN5cjgycGpvNy9JdWZpbEJpejlM?=
 =?utf-8?B?VlZvM1hDc1JRUFgzcnR0NGM2N0hEY2VRSVlLazQ1YjMvMzBNNE84R2FHMEp0?=
 =?utf-8?B?dEFYV3Q5MmNZVkJsNHZUOTdoc3lVY0Z3bVFrYmpvenRzbmhjWEcyQT09?=
X-Exchange-RoutingPolicyChecked:
	aH6/e+0ZE4UACsijBMHyTnF5M/UdZyUdTyNrTUT8Fmyhtpdfmpdum3RzRaUb/O6SsxPnqMpPabWR3Q8eJnLRjPIT0aibxpAMNuJDqi+1GVZmUiIebBum8kL+d72aNIn768FD/Wl3+elNsOgDPUYs906fwwhPsinnvkcNoLGP+YKhS8dG7Rs1NoVkxR9kwx8lUwDkOm6e042cttMNAOEROSnJfhK6nAlZsIA3haILw80os+fFoDFB913/sUwzmlEtEZl9lesxlI3b+ZCCJzFhDze+zil0I0isD4BwQKsa+cQh5CgwJsoIWuP4/mdCoHU1hq9G7AtFsjTtH+iYNLEyow==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1oo3Ak6TvJ/cK4SbkRrJmbfHkX1VSLEOVUpRL05CdNIaPlR0qpq6EQBFUZNBcEbfYE+jewzsNryPJX/QB0JuhY21tuPEqHvkBP9V7YpQ7l0vhA+TI/tUNkgaa8w7drzqKXAPYmEWkseSTZAIm0A8eT4bGTT8eFKWdHTDrTLBUEoJSD/8EdP18oknmBNJo5IkOiC9nG0xd86ve57lPejxTWaSjfLfI3RBUN3HjO/bVc5T1UqMJ9iS3gUVipOH3loGYVhQELfDr44+1mo9335e/1IHGVf2BkEHRCH0REYGVZ5+a/d6DChR8aVPPbYcAzVhoKXgaCRECHnm0rWY38akTvotIwQcWR62tmL9PwqrBJaE9v1QcOSruNSMdqUopV8icqb87HH0rBQvBY76YMKJrX6aNOoKIwejw9S+cI7lVafEdGbzxS0Z8YcCdipUjWc1l8uvOc/4bGAp9mZKnspWn20+VneIpf/ZixNbvsC2AoUngj22YZgTbSiL0Iwu+jwnOUwxcr70c2gAc8WUs7t4QQQJW5lU7klRxT3XKzFlKzhzvWeMp3PCqSIwN7dFcNS/MRuXBqHX5j0+7CaezxPynt4w0/SD1ynG79M4aFvsgWM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096060eb-1884-41e5-8d36-08df194c74bf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:27:07.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtP8nrj5VzNocxKyenItupC+irQeqLeIdOkoDp7+LvhX1nuQBLVwHgCHRigSgmBh04ebLecuuGaAmV+PRxD3gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609230033
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMyBTYWx0ZWRfX8/ir3a+zMSwU
 ztz48P4rpbsebO/fwKRFFzIB6n4anPKFnC8+WPwpqWlDC+meqRB663/B2xXy4yUzgvrybP3V+BA
 tZ+Zl1Yo7ElHkb7n+Cwcx3mZnMdOq/kMYZHWVkLMvQ1LEZjoQGTyq+R0KlGCkEq21BBHGguVydn
 Bz4hrJzAzWJlYmJSMcdZe7VmFs872WTeULAblxtEEUPRZD+FTEoAsi7DpfhMc5y/JBYVZzC08FH
 DzK59oB00GLGHMJE3urNkpF0yXw/SvubQtAdoH52WPW2nbtUbB49DKeKkch44e/zD/UqNaGvyfo
 EBVcF1Xtv1F+Vz8EftxXfkG60+Xy/1i76RGi55uFW9pHTT42Tzj35bkkrvPoJOqFi8Awbw6d9d7
 3YQZjWeGug4LcIOfjr8x2VY3DdZHzk5JzVA1IPhP9pkm30riUus2FWSoFTXtjKXhNwtgyN+c91O
 nBnTPcYhkgjaAJBq8kZcKPLT61ptKBWkR/ulA0mQ=
X-Proofpoint-ORIG-GUID: Qyz7OzlQoA8th4ZQJl1pmMcH4gGAHf1q
X-Authority-Analysis: v=2.4 cv=UINIjyfy c=1 sm=1 tr=0 ts=6ab38d61 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8 a=D-FxW4-ertOsDJHnGyoA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-GUID: Qyz7OzlQoA8th4ZQJl1pmMcH4gGAHf1q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMyBTYWx0ZWRfX34SV5AgPyrEg
 eBJiA0g8l2YuFbFoMS5oGJZizb/Z1sOHJC6Q9URaXUTBpdQ6AcufAK/6azbY+Fo/WBpi5qlv/Uh
 tINDVNYMVdtR0BOAEcQtfgk2nA22/4CsMmLBMYNWhNmGpwomf/GO

On 23/09/2026 06:39, Jay Wang wrote:
> Based on and tested against bpf-next commit 91f8613d95ad ("bpf: Drop
> duplicate check_app_limited in tcp_bpf_push").
> 
> This series makes CONFIG_DEBUG_INFO_BTF a tristate, so that it can be
> set to =m.  With =m the vmlinux BTF is carried by a module, btf_vmlinux,
> that the kernel loads the first time anything needs the BTF.  On a
> system where nothing does, that saves ~5.4 MB of RAM with a distribution
> config; on a system that uses BTF, nothing differs from =y.  =y itself
> is untouched.
> 
> Problem
> -------
> 
> The vmlinux BTF that CONFIG_DEBUG_INFO_BTF=y builds into the kernel
> image takes ~5.4 MB of memory, resident from boot whether anything uses
> it or not.  On small instances that is not negligible.
> 
> A distribution cannot simply turn it off for the users who do not need
> it: it ships one kernel build for all its users, and BTF is not debug
> info anymore.  CO-RE, fentry/fexit, kfuncs, struct_ops, sched_ext and
> bpf-lsm all depend on it, so =n takes those away from everyone who does
> use them. 
> 
> Hence this series adds CONFIG_DEBUG_INFO_BTF=m: the BTF becomes an
> on-demand module.
> Users who never use BTF get the memory back; for users who do, the first
> use loads it automatically and everything works as with =y.
> 
> Approach
> --------
> 
> Do not remove anything, defer it.  The BTF is generated exactly as
> before, but with =m it is not part of the kernel image: it is packed
> into a module, btf_vmlinux.ko, which the kernel loads itself the first
> time anything needs the BTF.  Once loaded, the BTF stays, and nothing
> differs from =y.
> 
> Making that work ran into five problems.  The first three are existing
> components that rely on the vmlinux BTF being present from boot, which
> a loadable module cannot provide; the last two follow from the BTF no
> longer being part of the image.
> 
> 1. Verifier.  Problem: bpf_check() fetched the vmlinux BTF for every
>    program, so the first socket filter at boot would have loaded the
>    module on every system.  Solution: fetch the BTF only where kernel
>    types enter a program (attach_btf, kfunc calls, ksyms, map pointer
>    access, helpers that take or return kernel pointers).  A program
>    using none of these never touches it.
> 
> 2. Initcall registrations.  Problem: kfunc, dtor kfunc and struct_ops
>    registrations run from initcalls and need the parsed BTF, which
>    would again pull it in at boot.  Solution: queue them and apply the
>    queue when the BTF is parsed, before it is published, so no program
>    can ever see a vmlinux BTF that lacks its kfuncs or struct_ops.
> 
> 3. Module BTF.  Problem: module BTF is split BTF against the vmlinux
>    BTF and was parsed at module load.  A module loaded before the
>    vmlinux BTF cannot be parsed yet, and the module notifier cannot
>    load btf_vmlinux (that would nest a module load inside a module
>    load).  Solution: keep the module's BTF aside, expose it in
>    /sys/kernel/btf right away, and parse and register it, together
>    with the module's own kfuncs and struct_ops, once the vmlinux BTF
>    arrives.  Module BTF thus works regardless of load order.
> 
> 4. Trust.  Problem: the verifier treats the BTF as the description of
>    the kernel's types, so a carrier from a different build must be
>    refused even if vermagic lets it load.  Solution: link the size and
>    SHA-256 of the BTF into the image and check them when the module
>    loads.  The linked-in size also lets /sys/kernel/btf/vmlinux report
>    its final size before the load, which tooling expects.
> 
> 5. Tooling.  Problem: pahole --btf_base for module BTF, bpftool and
>    external module builds read .BTF from the vmlinux ELF.  Solution:
>    keep .BTF in the ELF as a non-loadable section, so it is in the file
>    but not in the image.
> 
> CONFIG_BPF_PRELOAD is made unavailable with =m: its preloaded programs
> attach through the vmlinux BTF, so every bpffs mount, which systemd does
> at boot, would load it and defeat the point.
> 
> Relation to the inline BTF series
> ---------------------------------
> 
> Alan's inline BTF series [2] adds inline function information to BTF,
> which is even larger than the BTF itself, and its cover letter leaves
> delivering that information on demand, through a module and sysfs, to a
> follow-up.  When Alexei suggested taking the same route for the vmlinux
> BTF, Alan pointed out where the difficulty would lie [3].
>

There are patches handling the sysfs details in

https://lore.kernel.org/bpf/20260901165757.801449-1-alan.maguire@oracle.com/
 
v3 and later do the split, but the above series has sysfs handling in
it. I have a question about the approach here; my experience with using sysfs
with a dummy placeholder file which triggered on-demand module load when
accessed was it didn't work with sysfs interfaces because the file size needed
to be refreshed, and the reader would usually error out since it saw an
empty file and gave up reading. I wound up having to switch to using
kernfs to update size attributes on open such that the caller would see the
size change synchronously once the load completed. See patch 15 in the above
series for the details. 

It seems like you used a different approach here, and by storing the size
in the BTF metadata this problem was avoided. From the below it seems like
there are no first-caller issues from userspace (like if the first caller
does "bpftool btf dump file /sys/kernel/btf/vmlinux")?

Another issue; during boot, request_module can call back out to modprobe 
and depending on where you are in the boot process, the module may not be
available due to filesystem not mounted yet etc. Maybe this just means that
btf_vmlinux.ko needs to be in the initramfs image? If that's the case, I 
would suggest highlighting that in the CONFIG_DEBUG_INFO_BTF Kconfig description,
something like

"For CONFIG_DEBUG_INFO_BTF=m on systems where BTF use is likely during
system startup, ensure that btf_vmlinux.ko is one of the modules added
to initramfs to avoid BPF-related failures."

I get that it's not the intended consitituency for this feature, but best
to highlight the risk just in case.

Another concern to balance; embedded folks were interested in vmlinux
BTF as a module to limit on-disk footprint rather than (or likely as
well as) runtime memory; for them having a smaller vmlinux image - even 
at the cost of a module - was fine because the modules lived on a different
partition on such systems. If I'm following, the final vmlinux image that winds 
up on disk doesn't contain the BTF section, right? If so that's great
news for them.

And another thing I was wondering about - did you test with modules
containing a .BTF.base (built standalone via "make -C path2module")?
The code has handling to preserve the .BTF.base sections such that BTF
can be relocated and available after deferred vmlinux BTF load, but I just
wanted to check prior to testing at my end.

> However, that approach cannot be used directly for the vmlinux BTF,
> because of what depends on the data:
> 
> 1. Boot-time consumers.  Nothing needs inline information at boot, so
>    loading it late only concerns the sysfs file.  The core vmlinux BTF
>    is needed at boot by the verifier, by kfunc and struct_ops
>    registrations, and by every module's BTF.  Therefore we need to make
>    each of those wait for the BTF instead of expecting it at boot: the
>    verifier fetches it only when a program brings kernel types in, and
>    the registrations are queued and replayed once it is parsed.  That
>    is most of this series.
> 
> 2. Module BTF.  Module BTF is split against the vmlinux BTF, so a module
>    loaded before it has nothing to be parsed against, and the module
>    notifier cannot load btf_vmlinux itself.  Therefore we need to keep
>    the module's BTF aside, expose it in sysfs as raw bytes right away,
>    and parse and register it once the vmlinux BTF arrives.  Alan named
>    this as the hard part; it works here regardless of whether the module
>    loads before or after the vmlinux BTF.
>

What I meant by the hard part (aside from deferred handling which is hard
enough!) is that there is a conflict between the goal of saving memory and being
forced to allocate memory for module BTF for a deferred-load scheme like this.
While the series is specific about the amount of memory saved, I think 
it would be good to highlight this aspect clearly; we still need to
allocate space for module BTF regardless of whether CONFIG_DEBUG_INFO_BTF=y
or m ; the saving is for vmlinux BTF only. So

CONFIG_DEBUG_INFO_BTF=y results in upfront allocation of memory for kernel and module BTF
CONFIG_DEBUG_INFO_BTF=m results in upfront allocation of memory for module BTF only

It might be worth thinking about providing a means to control whether such
module allocations happen prior to vmlinux BTF loading for highly memory-constrained
systems. Anything delivering kfuncs etc should probably always allocate since it 
constitutes core BPF infrastructure.

> The btf_vmlinux module added here could carry the inline information as
> well when that follow-up comes, so both would share one mechanism.
> 
> Patches Structure
> -----------------
> 
> Patch 1 (refactor, no functional change): btf_parse_module() takes the
> vmlinux BTF as an argument and can adopt an existing copy of the module
> BTF data instead of duplicating it.  Needed so that module BTF kept
> aside at load time can be parsed later without moving the buffer the
> sysfs file points at.
> 
> Patch 2 (refactor, no functional change): splits the kfunc, dtor kfunc
> and struct_ops registration functions into "find the BTF for the owner"
> and "add the registration to this BTF", so the second half can be
> replayed on a queued registration.
> 
> Patch 3 (verifier): stops fetching the vmlinux BTF up front in
> bpf_check() and fetches it where kernel types enter a program instead.
> Adds bpf_peek_btf_vmlinux() for the helpers that run in program
> context and cannot load anything.  With =y the BTF is parsed at boot
> anyway, so this is invisible there.
> 
> Patch 4 (carrier): the runtime side of taking the vmlinux BTF from the
> btf_vmlinux module: request it on first use, copy it out of the module
> in the BTF module notifier after checking size and SHA-256 against
> .BTF.meta, and serve /sys/kernel/btf/vmlinux from the copy with its
> size known from boot.  All under IS_MODULE(CONFIG_DEBUG_INFO_BTF), so
> unreachable until patch 6.
> 
> Patch 5 (deferrals): queues kfunc, dtor kfunc and struct_ops
> registrations made before their BTF is available and applies them when
> it is; keeps the BTF of modules loaded before the vmlinux BTF and parses
> and registers it when the vmlinux BTF arrives.  Also unreachable until
> patch 6.
> 
> Patch 6 (kbuild and Kconfig): makes CONFIG_DEBUG_INFO_BTF a tristate;
> with =m links .BTF into vmlinux as a non-loadable section, emits
> .BTF.meta, builds btf_vmlinux.ko with the vmlinux .BTF as its payload,
> makes the Makefile and #ifdef sites that must hold for both =y and =m
> do so, excludes CONFIG_BPF_PRELOAD, and documents the option.
> 
> Patches 1-3 are independently useful cleanups; 4 and 5 are dead code
> until 6 flips the switch, which keeps each bisect step building and
> behaving as before.
> 
> Testing
> -------
> 
> Tested with 1 GiB of memory, same tree, =y against =m, both with
> CONFIG_DEBUG_INFO_BTF_MODULES=y.  The on-demand behaviour is easy to
> see by hand on an =m kernel:
> 
>   # lsmod | grep btf_vmlinux
>       -> nothing: the BTF is not loaded at boot.
>   # ls -la /sys/kernel/btf/vmlinux
>       -> the file exists with its final size (from .BTF.meta), although
>          the BTF behind it is not loaded yet.
>   # modprobe ext4 nf_conntrack
>   # ls /sys/kernel/btf/
>       -> ext4, nf_conntrack, ... appear immediately, although their
>          BTF is only kept aside, not parsed: there is no vmlinux BTF to
>          parse it against yet.
>   # lsmod | grep btf_vmlinux
>       -> still nothing: loading modules does not load the vmlinux BTF.
>   # cat /sys/kernel/btf/ext4 > /dev/null
>   # lsmod | grep btf_vmlinux
>       -> still nothing: a module's BTF file is served from the raw copy,
>          reading it does not need the vmlinux BTF.
>   # grep VmallocUsed /proc/meminfo
>       -> baseline.
>   # cat /sys/kernel/btf/vmlinux > /dev/null
>   # lsmod | grep btf_vmlinux
>       -> btf_vmlinux ... [permanent]: the first use loaded it, and it
>          cannot be unloaded.
>   # grep VmallocUsed /proc/meminfo
>       -> up by ~5.5 MB: the BTF copy, allocated only now.
>   # bpftool btf list
>       -> vmlinux and every loaded module now have BTF ids; the modules
>          loaded before were parsed and registered on the way.
> 
> Any BPF program that uses kernel types (kprobe with
> bpf_get_current_task_btf(), a kfunc call, fentry, ...) triggers the
> same load; a plain socket filter does not.
> 
> Results:
> 
>  - MemTotal is ~5.4 MB higher with =m while the BTF is unused, which is
>    the size of the .BTF section.  Once the BTF is in use, MemFree is the
>    same within run-to-run noise.
>  - Modules loaded before the trigger (ext4, nf_conntrack, which
>    registers kfuncs from its init, xfrm_interface) get BTF ids once the
>    BTF is loaded; a struct_ops map for tcp_congestion_ops and a syscall
>    program calling bpf_task_from_pid() work; nf_nat loaded afterwards
>    takes the usual path.
>  - stat() of /sys/kernel/btf/vmlinux reports the final size before the
>    load; fstat/read/mmap agree afterwards.
>  - A carrier with one byte of .BTF changed is refused with -EINVAL.
>  - lockdep and kmemleak kernels are clean in all trigger orders.
>  - =y and =n build and behave as before; =m without module BTF works.
> 
> [1] https://lore.kernel.org/all/20260917000201.25581-2-wanjay@amazon.com/
> [2] https://lore.kernel.org/bpf/20260916074118.1007116-1-alan.maguire@oracle.com/
> [3] https://lore.kernel.org/all/33592fca-88a8-44aa-8d94-40e1e604554e@oracle.com/
> 
> Jay Wang (6):
>   bpf: pass the vmlinux BTF to btf_parse_module() and let it adopt the
>     data
>   bpf: split the kfunc, dtor kfunc and struct_ops registration bodies
>   bpf: fetch the vmlinux BTF where kernel types enter a program
>   bpf: take the vmlinux BTF from the btf_vmlinux module
>   bpf: defer registrations until the vmlinux BTF is available
>   kbuild, bpf: allow building the vmlinux BTF as a module
> 
>  Documentation/bpf/btf.rst         |  35 ++
>  Makefile                          |   8 +-
>  include/asm-generic/vmlinux.lds.h |  30 +-
>  include/linux/bpf.h               |   1 +
>  include/linux/btf.h               |   7 +
>  include/linux/btf_ids.h           |   2 +-
>  include/linux/compiler_types.h    |   2 +-
>  include/linux/module.h            |   2 +-
>  include/trace/trace_events.h      |   2 +-
>  kernel/bpf/Makefile               |   6 +-
>  kernel/bpf/bpf_struct_ops.c       |   3 +-
>  kernel/bpf/btf.c                  | 782 ++++++++++++++++++++++++++----
>  kernel/bpf/btf_vmlinux.c          |  23 +
>  kernel/bpf/preload/Kconfig        |   4 +
>  kernel/bpf/syscall.c              |   6 +
>  kernel/bpf/sysfs_btf.c            |  80 ++-
>  kernel/bpf/verifier.c             | 104 +++-
>  kernel/module/main.c              |   4 +-
>  kernel/trace/bpf_trace.c          |   3 +-
>  kernel/trace/trace_syscalls.c     |   6 +-
>  lib/Kconfig.debug                 |  13 +-
>  net/netfilter/Makefile            |   6 +-
>  net/xfrm/Makefile                 |   4 +-
>  scripts/Makefile.modfinal         |  14 +-
>  scripts/gen-btf.sh                |  93 +++-
>  scripts/link-vmlinux.sh           |  25 +-
>  26 files changed, 1121 insertions(+), 144 deletions(-)
>  create mode 100644 kernel/bpf/btf_vmlinux.c
> 
> 
> base-commit: 91f8613d95ad8cd99d8baf094806d1ef98bc6380
> -- 
> 2.47.3
> 

