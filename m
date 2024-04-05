Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3008171072
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354921; cv=fail; b=BvL8eDzIl+2v1JXu6m/nJqIugNaTRLM0hWrUa/qs/t7rbbt08d8FnAM6WbyrXXvQMOKs10jGbqADkjicFBAKJ2Txwh+cmHgdG89wfpZwwh1kD7bOrxzADo/V7RIazKHVYUpWqVEa4E2OWCOe94Bko/8/kV62Y9OrSkVXzXyPGcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354921; c=relaxed/simple;
	bh=3kGX1zT/c9XsV06ybH186yZIed8hcY/mEsD4PyxeQcA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JwvZK7x3lzP8z3lVSxfAAE27XENuaqphkQ5PdCPjcUVc8qC+aWLv7XcH8HTLlUKEArZKiSrSyKRCR8U6kNPIlqt6MB3G4sWSUtX7Xt90qBvACr7eKDHvOtkfTcQl1RiQ7PNVMT7V97HDYnqlrXjBIwvaCUIifEcR8mwZj6GHka4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cvk1dPYo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g0hWwu0A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cvk1dPYo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g0hWwu0A"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435LXJHX026553
	for <bpf@vger.kernel.org>; Fri, 5 Apr 2024 22:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Xwk2Mr4H93V0RwCXZc8U/KI5WM3nVdraPjt1F0v/iJI=;
 b=Cvk1dPYod8kV6ctVQBzImLJQzYmYffwqiseKfQs/8ai9Vh2o2i/tf82Y5/+InxVfYTCJ
 GONJem3BroolXGFBjuLfxahzoqagvsvi+wzrTLZ6hcnj2Ar2ELB+EVrXmnL/dbm8yBro
 w2jUJVYoFPH4IOyQenZHveFjI0cYWsmAxnE8slVlR2Cb/v+J16QJ+cDA6LaSOLcAryT9
 BkivYo4bsUjGxytNgk10g28GUCFeuo/l7ig6b9MHDO4Jmxi0zaj/22j1Qkp/q+j3EUYq
 COl4FtzJrMX/ADL6Nyz1rQQzuzXyCa4LY8DNjDz9mImVK1oY/NvU7EsDAZT5wfWadp4L 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9en94gg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 22:08:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435LbKl7039049
	for <bpf@vger.kernel.org>; Fri, 5 Apr 2024 22:08:37 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emt5k7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 22:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoI3XvCYTFxkYassKgmhlkf2a/qimxvKlDPnDaPMiXy0Wzy+0ZcOhRNXGuiaI4TC8JE3WZrEsKjB0YnJFOlPbEmWnlDUsI2DApcFBu9RcNhmT2btU9Gmbq0wrM8r8Nsm41S867rwBnlPKq4iWAlF0s4IR3g9c+4Lrf3TnnQXc8SyNggk5Rjcj5aIEQOIrW5OYRHp0NRJiWB1tPGeVnRbGmgSroOGHcqtB8o+6QdmB3BNYowBbvqC06nLU1Pn6HAmWcobp3FRQ2o4T7AGwCK5dWpvnL9wWbbsHJfQZErBCeI6XTsGotw1RqjP5LvUkcgFyCy+1ODNNFCXY+0P5T2I+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xwk2Mr4H93V0RwCXZc8U/KI5WM3nVdraPjt1F0v/iJI=;
 b=DbV2wr+gxCcsBCB8Q6b4E/vgFveK0TmPGV8Y/7JwAe0+S+pK4gfWY9FhZYOUhVwC+zQl+c4HQUuCd7heiqiOeNDPUcy9WA1psdmqErl0Ry/e8hzuXQ/T4XYjP2CXFLCZAAXxFBs2HCrL5hki3VEjlFKeiobZufbP8unN7J9aRqI+SWsHw13FUGvDzzwdCKK9IA+q5GGb5d3mwckjBahvA9BJjfl77MlX9uGNVTImmKmXtuIqsxwkWBVRjzFxCqFP5zAWxCNQdwU/0lr8aiDuyKj49dHyzSd4SI/Iw0sbXR2OvtNKGMAzfY2fO8M59b6r0H07VUizERhwFjjVLGsDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xwk2Mr4H93V0RwCXZc8U/KI5WM3nVdraPjt1F0v/iJI=;
 b=g0hWwu0AeHp7PlQzyTmmD6z8vOefkyp7ipP1Q7QHJIjwAcQvhF53w1xjGPa+eorqHL/M0e4VSW4pPPIzhGyuspQvzegSIeK9bPGu3IAzYKVkOUplgaJU4lga0sQHn5tbteuhF4DZOyg+gADO/kTaFOt9BZIR9lX1jHzwSdwh2n4=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6157.namprd10.prod.outlook.com (2603:10b6:8:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 22:08:35 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::a112:9d4b:46a1:879f]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::a112:9d4b:46a1:879f%7]) with mapi id 15.20.7409.046; Fri, 5 Apr 2024
 22:08:35 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com, elena.zannoni@oracle.com,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [RFC PATCH bpf-next] verifier: fix computation of range for XOR
Date: Fri,  5 Apr 2024 23:08:17 +0100
Message-Id: <20240405220817.100451-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0027.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::15)
 To MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6157:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	78AyvygpRQ3A2pgfhwoDepNBx6eqRHte8eWWFwo3GwaDW91x3LBvSNSnjdBUnbe8TAU21TYvk2Ijm5DrJKXmUz0XYZVorxZX1PzZJhP3G4ANK6xGYHjCfYNNjtPoM43N/KxLrdsV8lOOH5pC9LNJu8EOkQzjodhxYQOHAc6IZb76tNBK+whB9s8VqrnXX0lTl89v8MzN7pUDkF6HUQydh58NCfEL3nXPxcZpQP+8KqydcHI3R7gACRLReH+pdQ2YvfiM99mZC54a/vk2gPhTpZfT6a1kxJrpRgrW/EF/EsodkKdXrw4trZEC8NLbeq21ua+Zs6C12uIXw+3J/TXpafUqGjeO0+s8eD/h6f3cW9MxOfyN57yMt1FaI/L6hn7II5XYSUJPu9oCuut7HJg8FKsnpPy6cvLj2FaiQwHFx2gdAvYlmwo/ig2XpzkIw7ecPJgQtGcpYijiCkOHzWInWGnhLRaXBnSiIvDTkq7932F2/Xrg1IjqBYGejrGlrVqMfyBR0cl26RhEWzxq8gCwF/6KtKQPuz6Nx27rL36RqYMnz0fwmThbewAiBvCeBQgcb0QsxUknaI+RAIBx8cecbJ1Gy4Xu3K0D7BGFtjY1+nGEV9vOgksQGMTYe13kQQjB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8Dodbb08CdfPFZokWNo5ZUS+sBEUYmJfKCuguh/tGT5D/4uQ0kGefReK4ND/?=
 =?us-ascii?Q?HMK8xRjjg4sP4FhIxg6jdpO5w71rJHgl4Jll0CkBzhIS7X/jiUTIZfHarKM2?=
 =?us-ascii?Q?axX1sMMOUiRfqs5IRTTM2VkqoNUINu1QIBte9ZleniRbkzszWzDRV480XT+W?=
 =?us-ascii?Q?MMJtEGz3wz/uJMdwN2f7fSWcKSE1X4qFupPRIV5GGib9kQCmoqeUmcA8rkic?=
 =?us-ascii?Q?Cv47I7duWr7qSnhz94pPRnoGNwqk40K6KRT4RFqL6PzKUh1rZPFTCKqZBd3N?=
 =?us-ascii?Q?0arbPVEXiPY+MSZYqfqli95qvYXogfVq/BW4qhgC2vwacRTn8f5yfawncjSO?=
 =?us-ascii?Q?jW2XvMXVyhHg2zLa8lWZzrelyyLxD3faDcjWV2khU0iWZepWNSD0CEII9NvR?=
 =?us-ascii?Q?uVVqz2ShJ6cdWu3r1ipDb3w6KbzmGQItaIyF9agKl4cX1eCJN+Bz1wswqh5X?=
 =?us-ascii?Q?nHvovpm4GeFoSJzQvGg++3V0kMJm5d58EVFNN3nZCYEr+X82/RH9F1irT2hh?=
 =?us-ascii?Q?WodzZEbCaxAEFxALCK/trDQU50ZiqcCZPcP+BgPPNoeGZeFcidqnooczMpWA?=
 =?us-ascii?Q?RNBMYyv/xms4nZ61W+bwZhLwdJgruVg5lUs0WVvPtUq7qw1Fvsx1CxaU1Nk2?=
 =?us-ascii?Q?ZVpBlASFKaf+l0uTbm1fpYkn95IqZL8SlS1s8A4CrrkRp5TY6Pj4QWycS2pA?=
 =?us-ascii?Q?m0G3fH0PQtAUNUJsBhVI/ZRon1wUXa3LNb7hEF1xLeZ08DO9NaPuw23TkvbW?=
 =?us-ascii?Q?FK9133G/902O7rfuPb2aFqEcGX3/FEiXwB3Koms2e/tISRDH1LuAVCAJZ9pA?=
 =?us-ascii?Q?GBlXB2M2DVcP+F0dNBswVUfQWRotVlOvIlrK+lUOPNbLfLsTjgoRIrK4uAJS?=
 =?us-ascii?Q?akUbbnPWib73faBfX3pMLQC5PF+1bptwB6NetuO+LHmz9Snne1qcwqUiD0kq?=
 =?us-ascii?Q?EVUuSYfgypLlNTz7flw4AFUeHDjnK5668mu3qac8dc71eM5ydh5s/evl/Hfi?=
 =?us-ascii?Q?BDss9qlbeZ4ubQAhrJPaaNR9UTBWufiLYcNIv7VsA4MrDXOBnPlCN1ZWxwf2?=
 =?us-ascii?Q?TS5vnMaRSU5dQFALHk8a1NYOr0j+u8w2XwTk26UsNPJPlHcwO3VoPzVHYSO5?=
 =?us-ascii?Q?Y43sM35ZLKj+ehtyrS6x903Ftn+SMw4Dx/2KDxHiCISiUkIx2XAxeDe0PNcx?=
 =?us-ascii?Q?dWZtnH9PN9U/T1RnHNIak1I4Ctrc5T+8bvRysf7SZDcktfVzuPMDARxsuoKv?=
 =?us-ascii?Q?WU7WuOXXaMVW/gDmkiSj263/NLSVDg3GFuNTjCdilf4vbXziM46/lPEmBaPR?=
 =?us-ascii?Q?ET4M7sQUPeicu6HKijbM3VfJ9eZc16CiWHzbKOPAy9vV+p0Phh5lfmFQZtiS?=
 =?us-ascii?Q?s3cNKMaOfzyVXv1/svuKUiSXCKxdTb/FTp2uSM0owpc/8lHBW4UiJn2z03sx?=
 =?us-ascii?Q?T5EKHrxPi2XZArKcordbscDy5AsZiB8pE9Y6Bp51EDKUEgk4q+ZedI5Il4pQ?=
 =?us-ascii?Q?zpjR61Mu3yjeZ335D5Rt2ouMiA/7E89Uvq/SfJz372MKMdK5+hJkKKkDQ/DN?=
 =?us-ascii?Q?l3hOrcxjJg7f908jgvqnTpTA+TIbRLi63fmoUEuAvfr7DXqDkaV+xc5Vj8YP?=
 =?us-ascii?Q?dCVF9p4Bgpd9zjPeLmLY+M8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Na7IC7KA5CbwmidiFKCud67W6IeOW8BX+NQC+7AB1go2/1ggF0j+SX9vILZpARqJQKar5hlibELjwn5W/0BVqBdVFip2JcOc826E1AiQpDsWlwZSGUc9c2icHSC5spvY3uhpqXVz4s3S6dT7AcSGOhlHIHJ6wp9hFr6d+qWFAGc6s6NCv9KKyAfFQNAPMV1AqdewWGZDJQ0wJNdbVw5iMUWFBMkyHdQ/gmAm8vqNHEPzn6Vp/3s+oRjjwFzA40Cj75ZgzexDW6o4nDs4TkGqT/l2bv0L5cptrrK6PigNmHypImLXKknggopUUsrnCymqL1B1D8gqtuVS663E2J8Wf6X6+7oSZ85dWJOZ68jsn3nNOIBD3Uk3GMGh4698lCiY+pQz92kA5puF0Ah4VFHtEsNq2H3FbeL8KkbmQpxhrgqvoHXCUvyUF4JCSlhC+4zRimjU7BE/yFFhTpnrvNXvKvIFKClAkO/1yA2q6bVxJtBKJ4q+UIRQ9eWXRSK920ZpdeZPYQWEJ2TwG+OSdlI1CEOXq/PhFAZK3iEymgfZzjWOmHywWMhE4iqwqdoDojSMVsqDLRQ59WRF+t17zMKNlaxKc6DJF2PLt2amjY0hmzU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa712af-0eb4-4908-4f8d-08dc55bcf042
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 22:08:35.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jeBKj3aBNu7JiFY2hWShGzF0Y2XUWZF0LGe+N3q5+wKomoavMZfXa7NaruPR1xBh7GEPbGi2AgGyx7aqbT0rqteOgpsVXzGJbJeJoQwEg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_26,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050159
X-Proofpoint-GUID: gayfMp0pgtAQdBkAbzz4OXWLNGWBSqBI
X-Proofpoint-ORIG-GUID: gayfMp0pgtAQdBkAbzz4OXWLNGWBSqBI

Hi everyone,

This email is a follow up on the problem identified in
https://github.com/systemd/systemd/issues/31888.
This problem first shown as a result of a GCC compilation for BPF that ends
converting a condition based decision tree, into a logic based one (making use
of XOR), in order to compute expected return value for the function.

This issue was also reported in
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114523 and contains both
the original reproducer pattern and some other that also fails within clang.

I have included a patch that contains a possible fix (I wonder) and a test case
that reproduces the issue in attach.
The execution of the test without the included fix results in:

  VERIFIER LOG:
  =============
  Global function reg32_0_reg32_xor_reg_01() doesn't return scalar. Only those are supported.
  0: R1=ctx() R10=fp0
  ; asm volatile ("                                       \ @ verifier_bounds.c:755
  0: (85) call bpf_get_prandom_u32#7    ; R0_w=scalar()
  1: (bf) r6 = r0                       ; R0_w=scalar(id=1) R6_w=scalar(id=1)
  2: (b7) r1 = 0                        ; R1_w=0
  3: (7b) *(u64 *)(r10 -8) = r1         ; R1_w=0 R10=fp0 fp-8_w=0
  4: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
  5: (07) r2 += -8                      ; R2_w=fp-8
  6: (18) r1 = 0xffff8e8ec3b99000       ; R1_w=map_ptr(map=map_hash_8b,ks=8,vs=8)
  8: (85) call bpf_map_lookup_elem#1    ; R0=map_value_or_null(id=2,map=map_hash_8b,ks=8,vs=8)
  9: (55) if r0 != 0x0 goto pc+1 11: R0=map_value(map=map_hash_8b,ks=8,vs=8) R6=scalar(id=1) R10=fp0 fp-8=mmmmmmmm
  11: (b4) w1 = 0                       ; R1_w=0
  12: (77) r6 >>= 63                    ; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
  13: (ac) w1 ^= w6                     ; R1_w=scalar() R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
  14: (16) if w1 == 0x0 goto pc+2       ; R1_w=scalar(smin=0x8000000000000001,umin=umin32=1)
  15: (16) if w1 == 0x1 goto pc+1       ; R1_w=scalar(smin=0x8000000000000002,umin=umin32=2)
  16: (79) r0 = *(u64 *)(r0 +8)
  invalid access to map value, value_size=8 off=8 size=8
  R0 min value is outside of the allowed memory range
  processed 16 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
  =============

The test collects a random number and shifts it right by 63 bits to reduce its
range to (0,1), which will then xor to compute the value of w1, checking
if the value is either 0 or 1 after.
By analysing the code and the ranges computations, one can easily deduce
that the result of the XOR is also within the range (0,1), however:

  11: (b4) w1 = 0                       ; R1_w=0
  12: (77) r6 >>= 63                    ; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
  13: (ac) w1 ^= w6                     ; R1_w=scalar() R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
                                            ^
                                            |___ No range is computed for R1

The verifier seems to act pessimistically and will only compute a range for
dst_reg, if the src_reg is a known value.
This happens in:

  -- verifier.c:13700 --
  if (!src_known &&
      opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
          __mark_reg_unknown(env, dst_reg);
          return 0;
  }

Is this really a requirement for XOR (and OR) ?
Unless I am missing some corner case and based on the logic presented in
tnum_xor (and even in tnum_or), it seems to me that it is safe to compute a new
range for both XOR (and OR) in case both operands are not known.

Looking forward to your comments.

Regards,
Cupertino

---
 kernel/bpf/verifier.c                         |  3 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 33 +++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c34b91b9583..850a2950e740 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13698,7 +13698,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	}
 
 	if (!src_known &&
-	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
+	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND
+	    && opcode != BPF_XOR) {
 		__mark_reg_unknown(env, dst_reg);
 		return 0;
 	}
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 960998f16306..b0f9aa9203f6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -745,6 +745,39 @@ l1_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds check for reg32_0 = 0, reg32_1 = (0,1), reg32_1 xor reg32_2")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg32_0_reg32_xor_reg_01(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;                                        \
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	w1 = 0;						\
+	r6 >>= 63;					\
+	w1 ^= w6;					\
+	if w1 == 0 goto l1_%=;				\
+	if w1 == 1 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("bounds check for reg = 2, reg xor 3")
 __success __failure_unpriv
-- 
2.39.2

