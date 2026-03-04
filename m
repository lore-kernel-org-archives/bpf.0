Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C729AAF3
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662356; cv=fail; b=Z+M7UJZr91wmWimlETGNdLL8vHaypq+GrwXlvVPQsKAnG86KgJ9AGt70g4IxCeaPpA/RWN6pK2+IWDpB5xAr+vnV86koC/wscYAtMp8mZYOaHG20aMWbUOVITzmkf/Mbux0QFZH8kZcDCBfLJyvsAYR1Jj58mWoezyk7XvX3xoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662356; c=relaxed/simple;
	bh=g85yYeY3Yy2pBc+JNwNl+Qxxr2XPdWLRwWbrkpJDQys=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tNaWNkfW7hfJcxlzdMM2swCWDmRy/T6D2yUxywRppmNp0cuz3U9shCN1lH8lyUaYV9dxTkT3wORbW3HZ+QMAEXfavFRnQhu0RjYUEQ9UsC947uyTZh86a9QEXzHSitPb2XKqkV9wwSl9X7gsKZctcfoQ/9BQYw3ITZeZ4aNnxNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=elE08IjR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KxIqQt4W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="elE08IjR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KxIqQt4W"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624M5O673259660;
	Wed, 4 Mar 2026 22:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=J9sTnS6eBTKZAf+2mR2qLNlF2bxGaR1tygMqgqY1hak=; b=
	elE08IjRgduw1Aa6CXvr0P0Evlnh3KbG/tdhFBdRoWG4lVTEz4lqZv1GT6X4y8IJ
	12jMstQ0JJvpI5WYlIxoQvX+ZlO0rSoh+PIbMGmZUUIswCGrLUoAAlfFy63Vjf18
	oAh4vAM4Nr7m0jvNFO1V1hZnSqr9VEvJbIfDOq9A4cWQW/KYLkNkPDpFRn20Wa7P
	osDkdvPDofKQYRIZ4jwD4DU3HfW7n8elRxUUgk4955FzEmRaRaa4NQY2adT+O+UX
	ZOMyPofNmcx8TsXLO9Ie4MtmHkIlqADB8BMMp6bB1mpGrRD0iETPwqs7BQvyEoD/
	xohQMXXrQyIYVl9Wr466qA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpw7gr08a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 22:12:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624KOgtT023057;
	Wed, 4 Mar 2026 22:12:31 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptgpqqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 22:12:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chRUdkHuW1sizv+q/UotIH6mZVisR8NdUVzZCteDpMwioGe4dgobCKlFc+na1KXY8oMbhoxG72imtoo8u1TReU7/La+CWrD0O3BeuNatUjnQa3qGtxd9BgCLjiwE4IzubxpxOnIz8oaq3+23v9FEJbFApalz1n0X57MvKATCJB7UetQWTfvzuWUQhQ1lu5rzcZ489+EHBxwhw4BiZ+QT1WTJ4rcmvXJo/lgzBQD4FZYXsyyQ9GqLgRRipgOerlLPLJ8M9HFy+QBS9qMwXrcXvxb1IEPwIwegq0pT6HALIilWQx1Yb9CaB57dV22WFZJVW+pmyzNeDZAp/OeYU874NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9sTnS6eBTKZAf+2mR2qLNlF2bxGaR1tygMqgqY1hak=;
 b=nbaqsWB4Jxe7zHGnh9WVuS91bKlxRPhTigW2bZyONWr5o1v31QsshlFXN0I6QeFrJOYFXDS7baHIxJ8ZjTfrTjqb8xk3flF2nGpMtuLVXuAx/8LSow9L1t2bSqcERl6IXTnZ4MCzJTjR7Z7Wy47zawo9vioJVxo8mQV4f5ozXAJIg4aFZSa1/AILYyE11vHz2DjOnu6EzO8OJoAVFzlbMRIJSGLLEBgUU25apg0Nb7BEPW4UnUDMvSbBlcJ8IjwkyjsXjxCFB+VjKQuOBBMKWvKiNfczWyYS8ygQo7rHjoHfi89+MupSQzrG0cTGx0HxnCggIOrUw9oy3EMDi44ChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9sTnS6eBTKZAf+2mR2qLNlF2bxGaR1tygMqgqY1hak=;
 b=KxIqQt4W7XRbckGHrUK7zuapaCKFlv0wsvgM64p+GG8EgGnLYrBgQ/HECER2IbE4JxfWufZfPbVAxXmCeBoU4eavlHD2WX7y0tBH8MlDdJUbFxugT/n1Y8EyJDUUGk5zEYzg4XDqcZvtsPI88K+TLmEQNCCZT/aKTRw7YCq7GCQ=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Wed, 4 Mar 2026 22:12:29 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 22:12:29 +0000
Message-ID: <1a79dad2-ae41-4dc4-b8cb-dc76d7dc7070@oracle.com>
Date: Wed, 4 Mar 2026 22:12:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] libbpf: support appending split BTF in
 btf__add_btf()
To: Josef Bacik <josef@toxicpanda.com>, bpf@vger.kernel.org
References: <cover.1772657690.git.josef@toxicpanda.com>
 <c00216ed48cf7897078d9645679059d5ebf42738.1772657690.git.josef@toxicpanda.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <c00216ed48cf7897078d9645679059d5ebf42738.1772657690.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS7PR10MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd7d2c9-a3df-44d2-f864-08de7a3b1fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	wBBo57e8kCP/jNpCs6WKk1kKz65l5EBmu4BTrxqBYx731rho/KJVXmn5xibinEkPmXZBhPUBo/Df1dvv3+0vOAR14G/SzdWGbXrkTe9/bXzn1BQwPnQYPT8RU5XDfcvkLQ6FQNa5yTsIEvWUuGu+XuF2OsI/CQ3UPiU/LEt/SknO1dzccsBGe2yB6OLxgB+E76KFpTgWjnNyh5MIgJN5iP4FDJfZ6+Gwmj1ln2NwdGvatyBOzhwDzcePaI7MohlHfzR6CQqGM6zXLRl2P+cW+aII6vi7mOLpkf0SsAQJttc8rgsD/T8t+zZqcdY3mGc3YpHn7aJDOtPsu/DGIZZHobm+wOEJMU6FwmNHI847NgAvKCYkEp58JrngvCxgoZkkrriJNwPT/We9+OhyvdcYZqRKuLNCdObfD21MucTvHO1r+97QjLx0hKCfL32a9107LElTEO7D4CN2Ym4+FmUBMevpFEc1l2W2NFgYDLOB3vIAk7CHJn9B2PwObntU9xDHZIrHOoZ6nnL6LmcAymWn7nnIpTxiN6+xj5I+o+wUZigQKTo5jJDLmGxhA45ZstzfEkN3F2sF9kiY8IaQ9KmY67XD7zWlkarbEzdaOYH808yUe3oEr0N/gYc5u3CVMmqtXcYn9ZLA8I54/ZQ/FaAsUmv4WcYbLPVQWwXYQ7+lRGKWKUuDhFM6Fm/ocNLDEBPOEp7ovLTK4v8gAGNhR7eI0wnoySAkJlDFXpsLpTwCY8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0ZNa0plL2ZEUFhJQWoxRTdlR0QzNmtIQ0w5L3dQOXlyUWZOZEsvSFhibjlN?=
 =?utf-8?B?dFJHQ3Z5SGtiZmI5TUR2L2JWcmViMmdneENraDlPM284TUpxMUxYZEMweDh0?=
 =?utf-8?B?UnF5dllKdkxzZ1A2WlhKM0hiVzgwQVQrY0haSEJQUmZsVkhiUHJHb0x3aFRK?=
 =?utf-8?B?eDA5ZWd5Y2Y0QnpVS1c4cy9WVStJUWx3ZzJEYk5mMGdGNzE0eGVodGFnTmR4?=
 =?utf-8?B?L1RlNGRDeWFiSTcvbjhmYkVpeTFFU2ZEWHc0WGhRT2xPN1I4RHdZWnlmM1Ew?=
 =?utf-8?B?ODhtcFQ0YmRzWURhcjQ0MFBlQ2hjQzBTeHRnZUl1SHRpL0JrTUpvZEQrREkr?=
 =?utf-8?B?ZmNBOTI2R2V3MENCRHlpeWJ4TVNxMEpvemtzd05FZDFUdmFTR1MxWENrVjhz?=
 =?utf-8?B?Ujd4UG1MRndUVURnQSsrNWkreGFWMlAwQXo0T2JUeVBadi9OUlduSGhJdTJq?=
 =?utf-8?B?dGdvejV0RVVUcDRDYitiUnlWTjlJYWZtOVh6RFQ2TGdtNXlaV1pYRndwc2hP?=
 =?utf-8?B?Mm9CRUd0bkhMR1JXOG9zalhjWkhpMXM4bHF6NTdMNTkzTFlUVjd1UEFTWmZi?=
 =?utf-8?B?N2RJa1krWUVQUHM3UUxla2pwL05wSkVmVjBNSnQxelY1NTNoZ1Q4bEZ4aWJK?=
 =?utf-8?B?dlZpZ1VOdFVZcysvSG8ya1RMa3BhZmxUYTdSdHc2aHFGb2Nid0tMY2xLNFN1?=
 =?utf-8?B?TWs4dFFINHhNeEJ4WHlMWlY2TlFTRGJCZ0FlOTl3TWZJdXM3VlA1bW0wRERt?=
 =?utf-8?B?UXZIVGtST3Z2N0FZQ0dRQUcrYWVYR0tkeTFVNVdwU3duNWpCTlFuNll6T1l0?=
 =?utf-8?B?S0k2ZmNXcjhEVmVKZlp4a1MvRnRTdEdmY1hhb3g2cnJ2UGpFc3hYa05DdjZj?=
 =?utf-8?B?c0VjRUZ4Z0IyOTRjZ3ZvUGFyNlFEY3Z3YmYra1kyVlFBV0lxa2tpK21DN0pE?=
 =?utf-8?B?NkVKVE01T3NsTkVDY2hEamR6ZkJna0loM21PSDE5V09ZRkpxTThkZGpJRGdj?=
 =?utf-8?B?SGNwRHA4NzZuRStYNDdQdDU0bUNURGZKRjB3RGc1ZW1qcTY2T1J2czZQT0pQ?=
 =?utf-8?B?NFE5amFjVUZwa09RWGcwTjg2V2FubFRMT052VVgzcm8xeEZNNWYvZ1dzR2ps?=
 =?utf-8?B?ZU50NGxTOWxJbC9OYlBWQzdNRXVzaVNZczErODlXb3Y3TVAzaGI3ZTRpbzFP?=
 =?utf-8?B?V2Fxd3E1ekFaYmlOUlMxOWQvcHVrYk42alFsRDN4T2p0UE05OG83Y3RsaFZD?=
 =?utf-8?B?TE5od0w2VGdUVnFWb29HQzNvY3h0ZUxvMTdMTjZFSE9oL2dOdWM1RUZmcStW?=
 =?utf-8?B?S3FSUC9ocUlzV3BVOUpmTkJ5aEZ2UWNkT1A2WnduY0xJMHgrVGkycktyV1Z1?=
 =?utf-8?B?K3NGRE94RnZ3c004ejNiNGFnbXdiSVA4VVdjck1TbVlxb0hIcGp4aitQMFFQ?=
 =?utf-8?B?cENYbnhCWUR1RjlBcmhlRXlXOHprSDFONHNJV2VPV2RVeXptSUl0R0NTNDNu?=
 =?utf-8?B?L3NnU0ptSVRQL1o4NHdxTGU3OTFESVUxcTdyb0FRSk95aUEvemZHQ1pQdFBr?=
 =?utf-8?B?eG1xT1RiMW53a0NjdFp4eitOc1BmaXB4ZnhUR3JVSk1Iek9qcXh5Tjl5WjNz?=
 =?utf-8?B?RWd4WFh0N2w1RDdFdlFuU0wzUW1nQTlncU9LZlRrYlVyeUJGRHo3NGg1Snov?=
 =?utf-8?B?dFhkbFdEb2lianVtTTJxSEtDOHNkZkFWSjJRZ0FsK1JYSmFFVUN5VVl6VGwv?=
 =?utf-8?B?QU5Qa3poM0pKVGg0WjJuRWF6cWhjS0JKNzBoRG5pNTBmVjhiTGlSMkZyTVdv?=
 =?utf-8?B?ZVNISXFBK3dvVVdET0MyaEtuRUNIc01oRzJJaUh6ZHk3eFV0cmZ5OFVZOWFn?=
 =?utf-8?B?YXYxa0p5SHVIYk9leHFqZjlleitXcUJjRWllWktBVllOVlhuUWQ4cVRncDRu?=
 =?utf-8?B?d2pQeGE4MWw0cE5uYzR3cmNKSHZhdHNZdHNCMzMwS2VXMDREeXRkVWkxa202?=
 =?utf-8?B?OUs0aVhUeEs1NEMwa3FVY3dNZUI2REw3YlNJSzlUUGI5T2NEOXhyNXVxRExp?=
 =?utf-8?B?ZzZSTUphUDhvSHdkT2JvbTlwSUNpNFVvTklyejQrbzJvTlBSUnFnT1VnK0Nx?=
 =?utf-8?B?V1psRmdmb3RkYTZrYkhFZzV0M0dxZjczU1UyVENMMWo2c1dCTS8zd2MrMHBP?=
 =?utf-8?B?akZVSU81QkY4M1Q5N3VBYXZoOXhxR2Q5MlU0bmErQTEyNlZEZEJJWUs2MVI0?=
 =?utf-8?B?bi9NVms5QWFiWjBiOWJDVjEzZHkvNmhFazdCTTBaY002N3RIUGdKTzZhazdP?=
 =?utf-8?B?aGxQV2RMRHBkbVVDOW1PV2NBVFpiQUNrSXZWZUprTC9MK2hxME80dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7eRMqRoj3KcVaKb0LyCUsdujRp8IMgmYlJNYE0kuhudXvc3oPfMx4KWCvle2CbECrQtoPsqfc/hTeGW0rF0fXI2CBx90P6I3i3kW7LuUJtjDlhHWYbfKYVYLgD9FWJ7WNo6Tky7d6FO99V7mP5oMcUVFqfPcye0S6uCt9TDfSlqAKDULWhRL+NqCJgGVEEZOo69SSB6HEBWAft4ceMpXFLgTa3bIcdqfUa6DKWU/5X46hza0T43b08VFE6VAsfPL5HiYcdbF3Vs7P3e8qoFLDAyh4UtSItj3Vda0SaaWjYH6rCFr2DDewVx7r9NdvU+fH6D3w7DLmZqFIhF/ipstnAAgf9ggawlPQrlxZH12nrNzOlQanRfPPXRIEmhVNEErFFAlUFBcma/skcdr9HVU+aurxGTkNiEyVqPZvzeIgqxseCjKKpFJawzOzAxMGbxZtpVF62J2buUiSBZOVDnssAgaGIFyjLWxw0L01KOOS/IRL7JYfe++0T4vhQpNkkg5nQkL0sKxIoT/ZZBHz6OLTb49pLJH7nGD9DiHmsbNORgahNADL5ivQz/tYJeQZsEIvJxqHy9hXSXb28I9MrblV4kH6nvx+RtEReu4q0HwkiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd7d2c9-a3df-44d2-f864-08de7a3b1fdc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:12:29.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epmbLOo9PGzN30jpRgXkiopE9o28wx44/fuwIDpEIK8qInWHZ1qD420EQzYOSU6y7EDuNw6LD1It5LcLvz2KuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4944
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_08,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603040182
X-Authority-Analysis: v=2.4 cv=AMMfTYaD c=1 sm=1 tr=0 ts=69a8ae51 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=maIFttP_AAAA:8
 a=yPCof4ZbAAAA:8 a=9y1GvcSqRpvMbXrwnCYA:9 a=QEXdDO2ut3YA:10
 a=qR24C9TJY6iBuJVj_x8Y:22 cc=ntf awl=host:12267
X-Proofpoint-GUID: B35IxDfXFl95M8BQa2cOfvRP5Vim4EeU
X-Proofpoint-ORIG-GUID: B35IxDfXFl95M8BQa2cOfvRP5Vim4EeU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE4MiBTYWx0ZWRfX4sZR+xq9u3lt
 iJ930vvSl9puQP8sjwwnzWriIgisPNKLeSd3dUXCEkBAk6M1B8Su8Bn1ROgEogntbpTkXl7nbSj
 vRlYLK58i0H5K/KQ8kZiziEZv/+1ssBkYcREksZHbjvDd7C7vQW9qppczTI/idMx9aiCIdq7YfK
 JSwlZW8D/Kcuv4QGzSlQmqCRhMklLxrHoYYeN4fo0ryZug9sD23qEfG9s3Th21omuZ3bzRuazvt
 iFkSSFM8s63KUM6FTwlbRAC+hSOG9nwHbeu8P47adjkrOXrFpID1oBe2LdIK2kZvbn77HCQAzkh
 bek7AD6SHDK9LimBLdOwRmkl2fHScOEueT0KMMCo5m1naUsLpzqTlIVGUjBr4lNlE+t/DolbyvG
 JzWmAzZD8t2F8/VLZ0roeeKqiPEghEORdnntB+x9B12pWnEXyqtZJq2bNPYLnppzebDpbBY36KT
 mDjBWQFiQXjYO3m89afes9kgkK+KkoQ4zIKeNknk=

On 04/03/2026 20:56, Josef Bacik wrote:
> btf__add_btf() currently rejects split BTF sources with -ENOTSUP.
> This prevents merging types from multiple kernel module BTFs that
> are all split against the same vmlinux base.
> 
> Extend btf__add_btf() to handle split BTF sources by:
> 
> - Replacing the blanket -ENOTSUP with a validation that src and dst
>   share the same base BTF pointer when both are split, returning
>   -EOPNOTSUPP on mismatch.
> 
> - Computing src_start_id from the source's base to distinguish base
>   type ID references (which must remain unchanged) from split type
>   IDs (which must be remapped to new positions in the destination).
> 
> - Using src_btf->nr_types instead of btf__type_cnt()-1 for the type
>   count, which is correct for both split and non-split sources.
> 
> - Skipping base string offsets (< start_str_off) during the string
>   rewrite loop, mirroring the type ID skip pattern.  Since src and
>   dst share the same base BTF, base string offsets are already valid
>   and need no remapping.
> 
> For non-split sources the behavior is identical: src_start_id is 1,
> the type_id < 1 guard is never true (VOID is already skipped), and
> the remapping formula reduces to the original.  start_str_off is 0
> so no string offsets are skipped.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

a few optional nits for readability below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/btf.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 83fe79ffcb8f..be8cc4ee83fe 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2004,12 +2004,18 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>  {
>  	struct btf_pipe p = { .src = src_btf, .dst = btf };
>  	int data_sz, sz, cnt, i, err, old_strs_len;
> +	__u32 src_start_id;
>  	__u32 *off;
>  	void *t;
>  
> -	/* appending split BTF isn't supported yet */
> -	if (src_btf->base_btf)
> -		return libbpf_err(-ENOTSUP);
> +	/* When appending split BTF, the destination must share the same base
> +	 * BTF so that base type ID references remain valid.
> +	 */
> +	if (src_btf->base_btf &&
> +	    src_btf->base_btf != btf->base_btf)
> +		return libbpf_err(-EOPNOTSUPP);
> +
> +	src_start_id = src_btf->base_btf ? btf__type_cnt(src_btf->base_btf) : 1;
>  
>  	/* deconstruct BTF, if necessary, and invalidate raw_data */
>  	if (btf_ensure_modifiable(btf))
> @@ -2021,7 +2027,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>  	old_strs_len = btf->hdr->str_len;
>  
>  	data_sz = src_btf->hdr->type_len;
> -	cnt = btf__type_cnt(src_btf) - 1;
> +	cnt = src_btf->nr_types;

would maybe be a bit more readable (if a little less concise) as

	src_start_id = 1;
	cnt = btf__type_cnt(src_btf);
	if (src_btf->base_btf) {
		src_start_id = btf__type_cnt(src_btf->base_btf);
		cnt -= btf__type_cnt(src_btf->base_btf);
	}

(might be an off-by-one error lurking there but I _think_ it's right).
I _think_ we'd rather use the type counting functions where possible
as opposed to dereferencing btf->nr_types.

>  
>  	/* pre-allocate enough memory for new types */
>  	t = btf_add_type_mem(btf, data_sz);
> @@ -2060,6 +2066,16 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>  		if (err)
>  			goto err_out;
>  		while ((str_off = btf_field_iter_next(&it))) {
> +			/* For split BTF sources, string offsets referencing
> +			 * the base BTF (< start_str_off) remain unchanged
> +			 * since dst shares the same base.  Only remap
> +			 * strings in the split portion.  For non-split
> +			 * sources start_str_off is 0 so all offsets except
> +			 * the empty string (handled inside btf_rewrite_str)
> +			 * are remapped as before.
> +			 */
> +			if (*str_off < src_btf->start_str_off)
> +				continue;
>  			err = btf_rewrite_str(&p, str_off);
>  			if (err)
>  				goto err_out;
> @@ -2074,11 +2090,16 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
>  			if (!*type_id) /* nothing to do for VOID references */
>  				continue;
>  
> -			/* we haven't updated btf's type count yet, so
> -			 * btf->start_id + btf->nr_types - 1 is the type ID offset we should
> -			 * add to all newly added BTF types
> +			/* For split BTF sources, type IDs referencing the
> +			 * base BTF (< src_start_id) remain unchanged since
> +			 * dst shares the same base.  Only remap IDs in the
> +			 * split portion.  For non-split sources src_start_id
> +			 * is 1 so all IDs are remapped as before.
>  			 */
> -			*type_id += btf->start_id + btf->nr_types - 1;
> +			if (*type_id < src_start_id)
> +				continue;
> +
> +			*type_id += btf->start_id + btf->nr_types - src_start_id;

not your change really but could we compute this offset addition once as
part of the above prior to the loop, i.e.

	src_start_id = 1;
	cnt = btf__type_cnt(src_btf);
	new_id_off = 0;
	if (src_btf->base_btf) {
		src_start_id = btf__type_cnt(src_btf->base_btf);
		cnt -= btf__type_cnt(src_btf->base_btf);
		new_id_off = btf__type_cnt(src_btf) - 1;
	}

...and then use it unconditionally as

			*type_id += new_id_off;

?

>  		}
>  
>  		/* go to next type data and type offset index entry */

