Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF8D38645C
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653855; cv=fail; b=jKZlOEGYX8voUwcKcgS6EqgRf58Faqwzj10TBm1zrqC2WuE0Q7dO4383SUzXh+meqX+agnM+1kjsZW1aSSOZngciOBHlNJ+PbwUe9Wel/5nbXXSthakwNNC5OvsXMcODx428M/4nvbfYCALPp1/KlGJvL086/b/4sky0brxbp1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653855; c=relaxed/simple;
	bh=KycwPF1Yk2hIhBlPSzyzVQgjyzi25IjG+mQdHSiHpo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=odBfkIhwkPYwDz1Z4g1HWb5/fS4J64euYu9hisFV2GNJfQL/Xn/krarRHZka73yDVvFzlai6CvUESDl2Z8B9UxsZWfctRFaf0Nvmct4CD6dkCmpA56Pc2yPAeeFrNZEH4FV1E1nNh3fkjofx+VBKZXNarACsbCRwl6xAMX0NpDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QIKPjFXX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=reiGzMDj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QIKPjFXX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="reiGzMDj"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624JmUUP2480815;
	Wed, 4 Mar 2026 19:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wz0/dtEQPZd7ovypbc60WFTVzE/T6y/oFSXbGomt45s=; b=
	QIKPjFXX5/54IxP5fPsRiyjVfz8zjOKp2OElyvpv11eDnEs9Dn3h6mdrEQBs0uDg
	GGMlWTVFzpmCSwyzBqfn/QbdPfEdDkyh/1fkHMeNHpmaBZJ8AuLtQ2SzETm0sWN6
	iPqsk4HniuwqCc0pOeytnqOrADiaL+wB/LAvbD+k3h3k6jOtj562hHTzwt+pnUDf
	rDcbayZ0paZNn9iUX6yN6VOHqFSuLQykMxHIErzA+LqqofwC8hTkTDJgDnhwqFDI
	ICDzS4DRHh5kXaCDjmS69uCOjg4vdhPSMSAK2EFP9qpg+zxBodkPB6DeYUe2veDA
	e8u462jRtZQnLlEShxTqYg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpu758083-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 19:50:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624In1P3001461;
	Wed, 4 Mar 2026 19:50:51 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptgj750-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 19:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4axuhrfYmBlDHWCSoLmZC0+pIvYEOdWw30pdvnO/itJQAT3BjGFiv7NXSZ4m1DpQFeyRpnzWD+CxwVGgjCyE+D/hkIB+2U6ohPX/TlReE1IbDuB4aMsjf4JivE4WFAa45UROEc5+0cE2RxcV3qKlTl7JaKV88yBZrRtJ1RV4tFj0Nux6ATco06VOqVM1AYL49/UEqLEllwiqmdpmt+OfNFf2qG0Rh2bu+5AE+XfaBBQIwYBzLfhLRNeGvQjAp9kOJ6VtUjMzi2guJC80QICVt3519mq+wdKULwwdTMFfQ1rnDKA2zQq+cQBTQf8EWdGU9yK+Q+Kx1+FmZTae3B1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wz0/dtEQPZd7ovypbc60WFTVzE/T6y/oFSXbGomt45s=;
 b=AWKF/8PzRHk64LkQfNPQ6pI898H2h/NwxRxzSalVt8YF8AZjLRTtRxuJkLlbrUBZQuLNatDqKMcgytBckfkjwTJ28w3knYzJwNUHIulUKF3gHl8Kcsc1RT9PdBXUEBMYLWVOsXQpaqKxBagxMopRqDrh6NtgWbR/KcUcJ4o+miSgaAPhtKlV6vL/TxabZlXXsSklf4UwD87+KIA2W7mM9PzJ21qdQzUliKUZpTrHIFB1NEVcEgpHg6+B0569qFxAdY1rVTHB+KIe3KybVoj7ZpdnVnq2pmUo2vq0AbHVnTq4AsjqW9GY9gPYUHYBQmh4vPXFmb/1VeoInqsCQdNeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz0/dtEQPZd7ovypbc60WFTVzE/T6y/oFSXbGomt45s=;
 b=reiGzMDj8GY2aYiQMVzV+n9SgtMktnZnWIRZnuRoMewJa+IkLdZ+SCqFAo00gm9PkoRpjD0mJGv6IRVZNteEsjFV8XZu3HYn10EJU4fY+aEcbaOcKkahI6BHyDOZlqRPf5oa9uzJhmCHVfibBoFpaLpA0kt9GdBpyiMiutd0GU8=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM3PR10MB7969.namprd10.prod.outlook.com (2603:10b6:0:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 19:50:47 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 19:50:45 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v4 1/2] bpf: detect non null pointer with register operand in JEQ/JNE.
Date: Wed,  4 Mar 2026 19:50:17 +0000
Message-Id: <20260304195018.181396-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260304195018.181396-1-cupertino.miranda@oracle.com>
References: <20260304195018.181396-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::17) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM3PR10MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1e88cd-4896-47f5-e2e5-08de7a27533f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	YFIUereq0y8dU7OAHRGYUZ8jcFboB+LyrNxcS3o+RfhuejNdlx99glaAk75rmWx9mqm4qDjEf3rYhbhLbx/0uesl7XIyIfPQtGceWer81pilc/N/F+sPHlelO2B6IEIy1ShFireVCN9WesAJv9FeHegXSmNOpEq5sfXF6GyjQ7mov67bAChdQPJsjovQTS6BmFuGbyJHq+BnowWNjZjJK3U8lopraQzUCbtYNJ6J7o3hnPbficiilPSf6ExhomncveBwMq6RiHyoS9YfqAkxRMWapHgTDfXSJ0lZimXnPUXP8jP8VY+T9XnDXDpJZzygwYxkMMAqF4P59tipLnq6eUZp+bRM5qpvu8V6Bjun7sJwwS1yA+/9F9D6hripCxEjQ5ISmeZdTFhwzoFgsPBt3/BSq4LQpkDpbrdLyVipihQdE2J4KKV4MUJZphiy7ObX8zoOAsDzEycU0vSdMKQw3tR+YFFybpBpz9uZo7v1i1xtR95IzKylBuRQdZ+4u3+nyHX5BLRCXcKZVAnv4s3HzceYRqHBtmYz7ag2ks4aJHDjqTzJgE1oEULOoFYb1sLd3c0XgjyXEu0qvd9tW6g+eSG+zTWyxAaV4FIBLDYJs295IQts1Z5scpVKYhOYAPEAuF3uOnh0yapNtLwrQBiPNQfI0i/KRueg9+hErRQqKxvi2t9gILZ9mnzRWTEfH4ObrJuiqd0NzOTj0rC+94zb45ipgw6EYjOsw/RrNDehS9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HtiCr593U9FhAslhPulnwPTl0uEFqwJJJSmWMg5dLixg3NebBwwJA4ZiaUyh?=
 =?us-ascii?Q?J69L8oPLndrHMFMi0KJtJXF1u5WEuZpSuLv0Y9y963wyL+8Dl6jk+7o6Qxkm?=
 =?us-ascii?Q?DAdGIvk0mZmVDHnBwpupCEQoQQX+3KbJszGIRd7U783vH7YXftATWDMYAk/F?=
 =?us-ascii?Q?2LXk3sxjgp6E4Wup3HdLMv/pnlcCm/eQ5bt9i4LUtPrfGDhsCnAyLfvm/7xh?=
 =?us-ascii?Q?DOWnxH0mWUoBQlGZlqksqjm4er/aJdD+aa4LSj43keUNnXsPCuwWnWKb5FRn?=
 =?us-ascii?Q?YxOvRzZrqGUcowiSeKAfGzpYUlXCYcRbvr8SHruw+H4t2DaPTv4A2ow9Bu8H?=
 =?us-ascii?Q?KTBYwoxOowCDTJuTH/rloKnRZVBJYvAcdh/CeW14rTyJXIqE9e139VYnr1yh?=
 =?us-ascii?Q?GV6dDiIFp3hlNeIYCGyfcrA/8UZpjLm19H2czekQh+LxKYPZkOxGm99JDoT3?=
 =?us-ascii?Q?86FyobcVQiA3cg2j7Ea6nZIFnTTQ7SHjpJYIxDxcpS0RUi8uCdna+Md4GXFO?=
 =?us-ascii?Q?uOpJrLnA52fd5ulSbNFLxZPDgpJuLScCKJufzC2okI5mLRgJskf3uYMbfefT?=
 =?us-ascii?Q?I0ntx0R3YQTb9e2ycP9Iq+rLcpX8LCerbpITGdgL1zwjPGB47421udEjBkq6?=
 =?us-ascii?Q?lc2rfXqtdG5lNLFRe+c8CIUtB6tPjEpINvqdjsj2HxlHTmPC0hgOOGdfjl3g?=
 =?us-ascii?Q?J/vAB9jRVNGehaP0j8a7HXhBIe5k/WvJSpMGuQ+Ef+RIlEk1QfnCRFBm6A5f?=
 =?us-ascii?Q?06D4FrqJ9pmBnzqjXkfhhopASvnOHh7QkGvBCNEoR2UJgt8XbicTDepZhMoR?=
 =?us-ascii?Q?FPylNHayPMAz0kr3HLbwWMeeBa+xhg/Ym5a6MakC8TwgRCg2Jkw3RcuBUERh?=
 =?us-ascii?Q?QNR1kpKnCTLdBExfMkemeDINxVjdTVzHo34fPUCktadGB3hKCS5N3R6uHDbd?=
 =?us-ascii?Q?p8j2JgNTaDKg1sGjziQKzPWCfrECBLLWhbM5y1ZHW645b7qPtmBz1E9lSBub?=
 =?us-ascii?Q?esxFx7HlOhNP1DmrahjrhcaxAozcBPcYDb4MqQrZhzAuvSubrnHHnvsLUzcx?=
 =?us-ascii?Q?115BxP520n3wTXuTJxN8NqjljXynH1OfCOaZVBHR85oWYujRVRnqdhVcHZo5?=
 =?us-ascii?Q?uHvs8/PqjxQayrZrSbR+FOPa+kT9ER+jGUUjkp+i4wTGvRMQGOPjsmwxyNsI?=
 =?us-ascii?Q?CcZSb9S5UWe1HaDV5uZNQdWvi0j2VMKLDpW3Ych3zE9tF5//kObl7glJ5/uY?=
 =?us-ascii?Q?8MYjpcWUN8oyvyUVAK3oHFdBXRLDDA5+Mi/Im82unM4S+ua2LbqNSDlTyEEA?=
 =?us-ascii?Q?PJ2yPUx58rAc90gavd4kwSwwVcv+jt+u1Sl5XoWd8Sonz03xyzVI00RWV04b?=
 =?us-ascii?Q?0OVVks7S0d4D5yV5gMVzPmclVWBTmh7klANX86kUZML7CSPleXRroK9oMrl7?=
 =?us-ascii?Q?Z7MFscEBqhK15N6yHQ7WK0pOrmIzOfyvbNgknFFTqzL19UegE04UW2/UNMXb?=
 =?us-ascii?Q?U/qcUGEi2iwiNwrR/TqsCjhfWqgBqnejoR5rmwIkVSzeM9XFznwAxFQOtwYc?=
 =?us-ascii?Q?i8zjaThx4s10JBKpVJKcnPMyPWI7veQdx9wi7E+8tUR6zPgJUN9crVyh6GZh?=
 =?us-ascii?Q?24TMrlUERZcVLvlv/Ai0DBmwxYEbU3IEWk0MVj3Ndv0CMQfrEZKpGZMLfnWX?=
 =?us-ascii?Q?WoEfzMNEyQ0IoGQQvQbIfeCd8Iwl2Dcc7IpReLqB0aogSLcEBdENq7rFCbEW?=
 =?us-ascii?Q?CN9yPw/KFqNBn9K7Qew5eQ5yioO5c+U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nEhn90dTK/dB/7fehnCNhEanyO5RCtFdV7bwEPi4r6b6BpO4nmt8onGlAmXg4vCdopFAnGP9+l/rtSEdYNFmIm12FghrD0JdDWW1soGbAQDloVnCpQl/5HtZYY15ZY57CeiWbiyyDbM7KEoXXshk2xCXz87hljpRJgbEzQYQsZ5dxbaAF8AzrruNaVa99jzEMBYmh6wsHVR/J5lh5b1XpPFTv17+bRItPAPVbkKkFQUJQTQTXyjVaZMYd604xH+Dd1gfcX4hRlePnyq761AzBsNMFmxBz5pKzNdkn2hlkpfpjHBBlh2rgobd188VMaHPAKMv2C3wNWEEQ0fqUnGmycDTGjCbQQbLs2KAE9vyUQUYagYDGP/rfbcoNoehvk5+fSiqYl56Al9Ct8x3+hRFNwsDj71plyPBSv3X2ZocvswTOMOQKJHxIaq27poFFVzDdPWAb4QPbLqUSZkVvU3OhHDjnn/jN4mRWxgSY3ch1h8rLNYo2w9eRR2O8r9RkLqsdoO6lKNGX+N/51n3R6ZLqYZMtFRwmhd1wnTy9KihLThuDV80AAXkBH5yexgPE9UonY1tD1xncY+pJuD1CTN1IqSC+9klOfFNTWxoqAZJsac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1e88cd-4896-47f5-e2e5-08de7a27533f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 19:50:45.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FYRXjfsGgBiMfJOVtGi3+D2MZ3Wt7YiWP0WYC/TayXSH5ZEEf4hmkgRzIXqP9ihDxPzqvW6vMEH5b9REA7GnKH0XH4Czij0Z3kDDqz0wCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=954 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603040162
X-Proofpoint-ORIG-GUID: xtod9s_9aJNx24AP7yDuVxy474sv_s6L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2MSBTYWx0ZWRfXwWKD3eof0oDf
 809sDOdJl8Vti7DJXbdK4JJUh7h0s9iyps/DZuKAR2vMQK6etDM5rsX/kucMFuWCvOk1eWTOFMq
 9XigURSAxYKLAnVs1cmrjSBgjr6thE3Z6I/NTBlMsL9NCtus+xWF2KHXUZl/lyL4Q/Z8hQLmWx9
 b7L2fm8eoMs8F5sQPdzcjTs7aHuzdjkcbZshKCs0MOtBjwdUMpfbmqDlI5cHT2QT5rSe3OF+b3b
 1+CKIHGs0Qx2wPxX4O+SexQcKosClFl1abzTsnuj19Xpl7FkAaTbm2ps5phIpUYqQIqqicsMpuZ
 6q13k/YWa18iFAE+0mHHURf8c3sigweBR8Hc2ycWwi7KwTLB1zdoHDS+KesdXlXdPHOr/jICf6M
 RmQzAV+qVGKpgaaK25llfoQHRs8Zz8T6t95rIldg3eVJ3Pd7vNndrxnPtcZTe4yUpJhkSYmzTff
 exg7eehiZupU6e/mXkZYALjAfIBpgRfWEnD6TGsc=
X-Authority-Analysis: v=2.4 cv=V9BwEOni c=1 sm=1 tr=0 ts=69a88d1c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=hCXV_dV8TOfl7-zKaewA:9 cc=ntf awl=host:13812
X-Proofpoint-GUID: xtod9s_9aJNx24AP7yDuVxy474sv_s6L

This patch adds support to validate a pointer as not null when its
value is compared to a register whose value the verifier knows to be
null.
Initial pattern only verifies against an immediate operand.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fc4ccd1de569..41a9a99ba7be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17608,12 +17608,15 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	/* detect if R == 0 where R is returned from bpf_map_lookup_elem().
+	 * Also does the same detection for a register whose the value is
+	 * known to be 0.
 	 * NOTE: these optimizations below are related with pointer comparison
 	 *       which will never be JMP32.
 	 */
-	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_K &&
-	    insn->imm == 0 && (opcode == BPF_JEQ || opcode == BPF_JNE) &&
-	    type_may_be_null(dst_reg->type)) {
+	if (!is_jmp32 && (opcode == BPF_JEQ || opcode == BPF_JNE) &&
+	    type_may_be_null(dst_reg->type) &&
+	    ((BPF_SRC(insn->code) == BPF_K && insn->imm == 0) ||
+	     (BPF_SRC(insn->code) == BPF_X && register_is_null(src_reg)))) {
 		/* Mark all identical registers in each branch as either
 		 * safe or unknown depending R == 0 or R != 0 conditional.
 		 */
-- 
2.47.3

