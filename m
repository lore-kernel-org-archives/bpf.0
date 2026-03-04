Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CEB337BA0
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637614; cv=fail; b=St3lsOSzURQwykNFaa6Pe3peWsQjUSOumvib+NldFWpqqT3Og7BlrTQ0ZC7aYTVFo+37v7JFZKnIH53kGn5YvpLfwwAdTrM/JX2EDbHeazAe5ruan9iawLF2o58IVthRVH8HOI7zFDBGhj8+THqKlheO+KpJmck87A89sLO8BhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637614; c=relaxed/simple;
	bh=qrwilGdNG76FrpJNZFq1yTs+KvA6IOYAkpB9mzrnMUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PS2OmUEL/SipekOqZJjMbX7F5mJ5VZTXPfg7FKVLBoJrPZ1bk29OhfU6Zuoh2pfCYnMFjORVvcMbDwiXhNAvpig5AEQ+IdWO1YBj4HH+7wK0vJ4wrVaULaXrn3VxkrX2/EnLRfInJQsjolKNB29QeFPHUGTuA3EKwzZIDHAyezU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MsR80JKi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jl4HxMar; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MsR80JKi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jl4HxMar"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624ENSCG1832676;
	Wed, 4 Mar 2026 15:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mVfj4VC6XZWSIoqL9CRmzHfnB/bPZeT1k4YTq/73q7U=; b=
	MsR80JKizR32FDrKvZOg1QO10uwFk0yhqPbtgJN3gPKOUE7gLodV3k2tpkhFfKcu
	pYoe0OR2WjgIRDy/EKown+RF7nfeayrMP9meMIDUZbvodEeUjt8q2KFUXcCWgbBv
	lwS4Vi86LVcVH94D+1RqHGEWvAHjCcZyws4fGLU5a/GJRIIJDRJo3gQH+oFHIPap
	hRAdxid3b1LviSwF72Mm29T9zHCPXb7Zquk6JarBHgtgzC1t24jOOTvTanuGVWmT
	UHEehmYLgWE2zQx5knIkyyMu8aMe1CQ3adRTSi/DL7kBlGdxBNjgtUHPezE0VfUV
	zzOqHrxmpRguRf0A3UOCBQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cppf30492-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 15:20:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624EfiIM023123;
	Wed, 4 Mar 2026 15:20:10 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptg78cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 15:20:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COKZ8KGKSSSoWAybeCHrCnkPIMWPnqfJrfoGOW2OlKXrJeb2ShJDxdigFMr9/5hBrSgRo/YgnUnHQF1h36IHSzUlXjpI3kLimrQ+OOnEhwJZPr5kKuClmgm152+Rbz9oha7E4v756SY7sGdevRapUsEd785X+iuxthq+j1l6Aiu5ukILaJeTZScZYsixgUle0y5YQzswJJwlaDo6B7dwKhGCnLhNJ9glednvmWxOhbjFteNNE2FZcYq9HQk9Std01E5Qa/1dC9c2N07as0mgEP1louSy7QzcmZ/mM03EmoVDvHWxKjEEM79b8q4C+zKiajJVG4HD/bImzpmGL/uc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVfj4VC6XZWSIoqL9CRmzHfnB/bPZeT1k4YTq/73q7U=;
 b=Y0EdFOjooXQj462d0E3Sw71R5N63CckxhwNdEFT5Db07CfZjvQvkDwobUdlpbPWZjKMRM2OyM4zc84pQEaYCTHmc0JtSJCOxFk0rHXNYdn5NzJoRpsA7GIfL1lOSGVK7iDu0M7N1+sMi+z9PcDnVHGcF0ujjubz7RO/3XttJC0y6y8cl/5eLhRu8rQfGLJWPLxUQ5ykrDFfJ3SfY1MJbgfF2KjLLaaaeaebDw51rMHiqMlZH38GH/wYKjMxszfLBEyGj+DitLzeAZ/epGD0fdKwwieokr/32LeJSWNTO1Ll9wOLezVqEWMgBE+Z5+zZqUxUJCfdFe2p0FEMLbQYwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVfj4VC6XZWSIoqL9CRmzHfnB/bPZeT1k4YTq/73q7U=;
 b=jl4HxMarvYCoTsXZrHwEeHHAdsq5TGGSxdoa7l+pN9uxyTcSpjazD46WPwMuxGANDQKfRCLKGSVRfrICMXKDhHbiJNiTsU8eUowpdXNPuujaN5fw81Qx4OpIIaUdQ7Pds4kipo3M8QyhrCBghAiTKRWczepp2qmFbNFMVknJWbg=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CH0PR10MB4954.namprd10.prod.outlook.com (2603:10b6:610:ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 15:20:08 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 15:20:08 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v2 1/2] bpf: detect non null pointer with register operand in JEQ/JNE.
Date: Wed,  4 Mar 2026 15:19:31 +0000
Message-Id: <20260304151932.177995-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260304151932.177995-1-cupertino.miranda@oracle.com>
References: <20260304151932.177995-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0104.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::18) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CH0PR10MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4755bc-320f-40ac-6112-08de7a018502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	Ze7kc05jmzqAoBLMNvFCdIE3WHgmAIW2nSVuJ5I6+iDX+wHaSUiYx8/wNRAEslPIfy5LL9Iv+gmwg2gbCHM75ki29qTDMZSDuk/A9JLVrelRMyDSsNtl29upKg8SNLP0kU6EMZAOX7N3gBbFa66NWZFTGVG5nxvD6SoqFJZvzDaUE/sIFmA3FwoRUdzYXQrXkRC9V39zoxY7qp9Q505wKNqFKHt9sOhzbSEdLpKb24TSvTgk4QGjk1s3djC7bR+zQ5lZe8UQ4U0ug4ODFtbzPr13BTCntIiV+nqVFDxAMGgjp1Z4sJv/eidmmYlVV8bdwfH6onNqrZS/YXqemCxkgVKC5AkWgB3SmOPB4qZkdxM8Us7kfAURQJ0ospfPgbpR7mIrbpU37mdTSGcasTStONKXaiChrYYhtVgpxdhcwMBkyaHkOoFfSqhhqQU3KRHWrAFEvsvP7gNV2VuMPfagoKzs1fEiyqlezNOKAp6dEPUVRfYqYvf53IOIg+LapDnyrtz4w1cwtxu96mf8Aeg51dttSZrfyWOgoIcVBwfv3FWLwkifYKYXDU4GqE4VSQiKN0Jn+dLviQ0h0apqQK95Dr4E+yBVH37n5Ywqgxs65HA8ug02BV71gbGMtK/B7UKJOwm6R+5EBWCHdRN/9iDf1bvl/kDhae3RIkEHO2B/PdMEQq7OXsnRrN6qlQBO3rzzUfLrk8xJysqgCZOd4+UIMbzCcjLxC22HxIM4OK9cR3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOLDFvwEaZze7fHuke3Eg5QAwQMzgISuGGRtMDsBpIinU9dTo6w5AOHdjpK2?=
 =?us-ascii?Q?312v/QDVoUiQkUGHF7i+P3syNzSfNzVO7zJx0mFqHYZKHSBO2VZffFG2S9vr?=
 =?us-ascii?Q?DW/DOzW2l2oe7X6+aU8+nhWB1ikYmYojoJJz5LRy82esw4HnZvunSZfxAzGA?=
 =?us-ascii?Q?tkz/RxClnPo43bWNlMQzsfy1kMncfBdDEUIKdQmSJ66Nu2W2dmymOtXNAydi?=
 =?us-ascii?Q?ycDIhdD1L1CKSsoQ8V6SJqPmQRT6Y3fG4HfBxugqPHAZWEh3HAMLubPjvn0q?=
 =?us-ascii?Q?FlLHSH69tXaRGahAcLP82yBSotnl+bkB4B7DsdoyNBEHTQ3m2ONkbKuBJzI+?=
 =?us-ascii?Q?M3Uj0QyZCSq+pUPY/3I4tWyk3nHwKnph60SmIbZcMwBrBXaNAi41WladfeTn?=
 =?us-ascii?Q?i+UwjeXOITv6iE7XFin5QeHA5UYPfM/n5qWpUzYUG5aq5yq8/4OoCW4x0XJ6?=
 =?us-ascii?Q?Angl7LTTSHo3ax0fT+aS1fcPpTRbbdg8D5AyH8p7wgw0tkZSKL/IN2M3D8Ww?=
 =?us-ascii?Q?SE4DJyBDnnDSGpp2Xud5T+Xc7cvxHyuH4+go7Zud8iQyHVPMDE6whVDKbvhK?=
 =?us-ascii?Q?tRv4R2256SBHKUW2XLRvJbQLDvliDFCAB3dgCitwKADyYN+5bcbzKMvbd2sa?=
 =?us-ascii?Q?loLxqNM/EG7AEhHcACbDbxF2TlE6PIDNeVCJln4Jlr0EcgY3liZcNpFLYBNp?=
 =?us-ascii?Q?3kCbdP6CIbp2JdgA1hDWERLJANri0Q38gxKPHPsALOXPq0p0+ebUr49ob2xf?=
 =?us-ascii?Q?WyzYarwB/YcNqaBZ6JG/TZmxSaSR8nVSkTHd8oAA/It9Sc2NEdeHJEo7eka7?=
 =?us-ascii?Q?63Kok+J2WmPvAru5bxmE+jqP63xUoLhf6ne2LuzRp08Mdy1Er07DTOrR5sH/?=
 =?us-ascii?Q?duqvK6/fEPhBknU+qZYStV7dCQDGf6I37U77FxRskdIGjjgky8sK4/I72HhB?=
 =?us-ascii?Q?80/kCCjNoCQ9UpIkLBYOjI9Q9qBwZyEfL8ykSwMcinmP2MSbBtxpRjf1rtY/?=
 =?us-ascii?Q?NFBcw/V6W5rHWwdim3/fxy3nBCZXeMqVlqa0ODR5Ky33d7fJFcXlliN9YCve?=
 =?us-ascii?Q?QDmlhZz5HGjC239jJHviGGL8H0GU+S8F0jgBUHbWNrwNbDF3ea5+gu/lmU7c?=
 =?us-ascii?Q?a3rTJktN6vG80e4C7Z82v1mHtMz0+MQEA327L/ohDNYHy7gonvlNHAyRDJ+b?=
 =?us-ascii?Q?rKaDDdj5//2GABeRYo5y1drgcZpEM8bvSj0IC2zQijmRvwcw7BTG2+bHrJxv?=
 =?us-ascii?Q?bXqz+OBwatJODf57wVsleBIunud2EhhTx1DuL81L1tqPVLEtDHdldoWJ9v5t?=
 =?us-ascii?Q?Xd/g5gmxSqO+QyTuD8DaIAkpg3B7MIUzLLPHTT6ZfF3Zk4lbiGBelmYG7gxE?=
 =?us-ascii?Q?tyLGPgnaLlE6h7cRnE3vfpf8q1H4Wan25b0JGDfgO897bVbJ0Rpk7BIiBS1M?=
 =?us-ascii?Q?ZUN4Kyr6ToxprR7IJgPFlm90MCkzp+SuUTFWt9BAMqGXt6bpQ3Vwrn2o/AlF?=
 =?us-ascii?Q?XnZHeA9uNe+8lQTRfpcBzLw90IkzbyFlqUL3ZY+F7tnBeXAqYi++u2GGkMPd?=
 =?us-ascii?Q?5kbP7rIFiahCMTlRPihvlXT6A5F0ATYwUq2a9aUhyKcTzvU5FtUQW3UOBeLV?=
 =?us-ascii?Q?6ejSiq/EVYfwtzH1fr6V2BM/ntWqXPo9mjaLQppFirNk3uiUCjohHoKGzplo?=
 =?us-ascii?Q?AQnbZ+91zz9BtpIlW3jt611lyeN1sZ2kWEpk6WRpOouLAos9mDmQ7vODR/Yq?=
 =?us-ascii?Q?7SfLHWi/KRBOfSrwtld1sVb7cR2mOCU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N1kqmGz0f8HAWkeTHBltxLficbZjfoPzKr8CVdi/nlQdSfN0QjWtiPLCogpRzHTY41wmzsoMbHXUhUMWJ+Utoz0MOjAdVEzmH/t+uA+XnUasGk89y8Im942lxccSa1i22SKcgv56GjkyYTbVsaBdsM5BN6tKzCj/t5S68uk1IkNs78oAGqhoV6AU6OgIgUd7wFCvglDkiESQAiXypfGpC4giIMOM8PzFmPSvRcCt0irM5zPhzz+rrhDVVqwzPUa4fkgdd+GUhwVpKQ2EAFPQ3Hp07rMMfyiizv6cQ27zz4WHDZmX7c5e6R9GMM16fS5MKI4iFwjEM5lEwFCOYl0xFkDjyJm8St6RHe52IVBAyHsRKHGaHWga3kY5yKXJ8VD7W31CnrFwUlka8bzgJNTCLj9iLgSOoMicVW14wAkLcNCdprL9nuiDbWpFdNXjIrx7ca35wBWCZashdTuY1mK4HOzSUNRXrTwCNhtj+OnNckF3tV9L9pQtlJyeohMiF7UgodFl4F3DNdvHj+7eY+G8GZuD6kChhXV/68UblA3KN7qfpP1bmTDEQ5wXSycYi3hM0E4gwa9DcqE7OMX9lW8q/K7muWxWcvRr8V5Ios9y6jo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4755bc-320f-40ac-6112-08de7a018502
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:20:08.1507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3Ek9RElZrXoH83QTIAGl8swItc125RqnzVDA/q29skx+Vail5D5vr23/cnDNsIEmjZsp9AbRfeAW5txQsPbCAQ2GZv/MRc7SQAS+iXxwGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=954 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603040124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDEyNCBTYWx0ZWRfX11MehbZeMLFl
 OxTWL5Lnn+GSQWNgRmDLyx2plcdZxSyoANJ/oiL/YyaNAkrqgy1Z1ihIGO7Zzz6XQzmfjEP8Nuo
 64Hr4ojpo7VxIYgQCaclM2Fc/G5Gc7BLPNDxsWeIR8G6YDXJBvUoz16ta6ZhKYroxOKZ/cjNI/x
 z3dqaYg2G/crRy6AAG3TbOIh852er31oHORS/go42lZA0/3tIYozDbcPS7qNRU5rlPDOjFBf3vS
 S+lQ2TZiqWC+stWGBdem0c8K92blTiLo2JDiBaMosCth7bmO5wBZV9sCIWzK2Tgv33JHTVKhoBB
 81YvsQ57c4TrpGjW2QHL+cmow7EUstolIDysjePqHwsy1sdCZt8blBPYfnTsq2vrXsYLYZ3e03w
 ohdlLmIu0MTSwQInkjMO9SrBDj+xTDRcyhwaJFnUPoEfETxoQCCnAH583u5+lY+AckxrseYaunN
 wDH05G6O5cPovkErbYDLYJVUh9c1eGiqtDp89Uwg=
X-Authority-Analysis: v=2.4 cv=Jv38bc4C c=1 sm=1 tr=0 ts=69a84dab b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=hCXV_dV8TOfl7-zKaewA:9 cc=ntf awl=host:12267
X-Proofpoint-ORIG-GUID: GKIJUuvzWyzmIKkO83P2SzL-bXCzX5O1
X-Proofpoint-GUID: GKIJUuvzWyzmIKkO83P2SzL-bXCzX5O1

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
index fc4ccd1de569..14debf11c3a3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17608,12 +17608,15 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	/* detect if R == 0 where R is returned from bpf_map_lookup_elem().
+	 * Also does the same detection for a register which the value is
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
+	     (BPF_SRC(insn->code) == BPF_X && register_is_null (src_reg)))) {
 		/* Mark all identical registers in each branch as either
 		 * safe or unknown depending R == 0 or R != 0 conditional.
 		 */
-- 
2.47.3

