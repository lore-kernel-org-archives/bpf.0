Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC33433042;
	Sat, 17 Oct 2026 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222681; cv=fail; b=VcprEAWZx1+WdA0PJ7NjUIhRkLPKH/eQ8fRWj4OaYfGy3z/hDB44+YiFuzClK4P5FrlR2cXmyDA4s22CR2TuVC8SgCb4TGBUHoyFr0TXkDuBYn7ODOyj0elp3bOrF/k5sK1x2Ed7+sV/yGJcJtTLD1PheUQC4o4TL9aqA8WcUck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222681; c=relaxed/simple;
	bh=ln5fs7JJ0butV3VfO4ldVD8vaOWhS0FJKMQ9cVqvXuI=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=hHQf/bX6UBFzBNjlMekaqFoO3m6PrYypgWghT2EYn5Gw/Fb0+d/e9+pDicjDiyoWnxo1rs4z8kpmBlfQTFiHwMiZ7GXYITt2PchqgB/S/mtsZgH+FjjpcWuMao2wzWmnd7Yozj/44UhFGYpOdy2flvBsEUqrzjZH5aNMKv2Sjtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pXvz1uf2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sz/LO+CU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pXvz1uf2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sz/LO+CU"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H7Xnq9525632;
	Sat, 17 Oct 2026 07:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=j9/i8F2cnXn9IGrIFm
	S6Nx0LzLb+F5WBKURETck5G7Q=; b=pXvz1uf2ljzCPIttPJ3wn1PSjwUsCHhOiO
	z6o5qqDZt6lbnB4qY2mJn3OiVTSNLuDL6ve+LDE9AIZTHq5RVxCmPfrr7kDJVc9D
	389CkWwl7hHrxsR+RtwyXPj+3sLZdcmwmZa2oc5bqUMAKSpe7wOqqK7y2BowRftZ
	YEeubNY2HPDhUK3xX575TgtzHzPmNML0xT1eSwFAonyngS2Y3pFoOirZeXYbpHLE
	ugxd6jEfpViDvdu8KbcRoAmOyEZd9mh96IaMDZsebj01jsLQxktWe//kMtLZc0IY
	iX2fZ+mPWOwEZZUvgoEOdWSufgTK0d760qwoFTksB0gxtgfymE9A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hbyemr4uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 07:37:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69H7N1A5017825;
	Sat, 17 Oct 2026 07:37:57 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012030.outbound.protection.outlook.com [40.93.195.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hbyfkw75p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 17 Oct 2026 07:37:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TttZZj7H1neSQaPXVoXcpea1ud3X/aNWshDxGKRxzG/nyqeuT/PhPdj4/9p0WiRHQwY74jyTHmf0TIOuIquCl8szZpedPR4XK3zInHJ+isFMzQRR6XL8IrGxE3H/RciNlxbahbMZ+ZW6ASFnqWEH9alWrvo39C505p4ExzAbw/0M94u9HW1pus9IvG+ZCbJKZ/0jIbxzvA1QSItu1k4nj0+gozzmhBLAKGxPwMDLFb/+b6lwSTR/bqyecgCvHBiTCOs3fRiYaF6E0ytbeOidCdUkd05EtgcmfXa7vLMrAyGLfEBXkhajTwS2oyoJIce6PPBvUDHSBzLao+G4xtm07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9/i8F2cnXn9IGrIFmS6Nx0LzLb+F5WBKURETck5G7Q=;
 b=OLQcTfhp2PWGLV9CEPFuylQnGD51H/zwmOMLDtkHdlVH9wVXD7McRLUDuiDWPtxWlmMbYyx9gpNhJSsQj6kGT5/2foH7zO1s/w6pL4gGnpVPehFTc+M7mDMoyZaKwOG4YH5cPzAgujL3Pm7IqI27C0GWQH0jXP7gqPyF6XcX6sqQG0BY5G6k6Lww3MAlINe05HyrluuDvqQBC3lU+F3Sl2B8xXZz4GJt+uMcwXQFr2jG32ZqsYNcgxBuaS5axUGyFEB6HUpzPsxmjJNy/wU7qIuva0Uf2UsGlVAQ/uF9AsJaETF2qGrK91Oh+9If1IZcDt6B1/V6RF3eu6A06f8WJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9/i8F2cnXn9IGrIFmS6Nx0LzLb+F5WBKURETck5G7Q=;
 b=sz/LO+CUPYYhUJ1nfBZjuEEmfXeP3XB5meIEDbLoanIUmTGikXkGE/zWKc0jcR75L/cZD+7a2Wh6nvT/vaSYHJcEvhcVf/sNKvV+D9LeogIsbP9p4W4c2fiedT4NavHLRyPWfNoxx720LZ1Bwlyw52kTCwj6QeDE1Zti4jcFdBI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB4533.namprd10.prod.outlook.com (2603:10b6:510:39::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.12; Sat, 17 Oct
 2026 07:37:55 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.011; Sat, 17 Oct 2026
 07:37:55 +0000
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <20261016070837.440748-3-ankur.a.arora@oracle.com>
 <sashiko-outbox-173922@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: sashiko-reviews@lists.linux.dev
Cc: Ankur Arora <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v16 02/16] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
In-reply-to: <sashiko-outbox-173922@kernel.org>
Date: Sat, 17 Oct 2026 00:37:54 -0700
Message-ID: <87zewcpyjx.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:303:8d::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: cca815db-7afb-4fd5-a75d-08df2c218ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|10067099003|3023799007|4143699003|261009221227099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BqSEZ+stTtohuwqLVZU3I+YDMEIKwqDACUFKbOIGsFHLR9SIuJt9g1ogxjDyde4qbLyXE1xmqmQ+zKaFaCz8mQDHBbN4GFVARQGvSnj8zuVL4kpF+7P1/TOEXPzNC60O3ust0HNLFC3TiANFK+Dxc6W1+OmGpwC2oq6XDPXg4gM3sJF6h2OQ5g2NLXCdnT2CfheHCk/Xfqf8egz39uB481pH8Tni7yHTeCgLGM6Byh8N46mG2KiSiGzYxa9xYRPuaqTHKHndTsc+bSGHs15rjKHcO5jmnNKYJFTzsy0WhNrzbSYzPdagsEoqC2a+5fl21k8ve45z+cHVfOmyJtuPz/5fxHJJejKd9if90cj+888BflILxzKvZu0Y81he5naKr8x+rhnr42GWZHk6g7JuldFCSZIYsDJulRbQkAOgmhU3b2paOlMmEVrJGZTCxYIbrP2Kagu7kTXxF9+2Y/RD84l76PP5dwEJqqLEbqBgyh6mItEhA2UGj2zN0HzSMY4dQWwkFtxn+X7t0ilgqA7yc7pQXqnJcyphaeJ3p09eemUsalrfma7YYpTZH+z3mvQj55S3pGTS6JZGxlhLeH+y0BbkwrJGuYsaaO4DR9V9rokZr3sVd6nA2GAp/lh18At49R9PM2CSq+pyIRbtZMGh8NpJxZVP7ZmyCTir3JG5hJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(261009221227099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3kBpUxHkHwKcH+gGLYBZ1v9fkPQxAf6y96qmR6AspZm33LZioaYo35Fc1HGJ?=
 =?us-ascii?Q?DgVs2AmlXjK0bwpF2ZnXO1Kc9dJGGy7532zI5RzpkDW3I8Mx7QK4QbFWHFa8?=
 =?us-ascii?Q?PZHBIXlFVUMPhHoRh7l660lf7RQ+U/6F1nM9kCJxG4ZAdJLncoJ4iaBt7kDJ?=
 =?us-ascii?Q?cBV/IRKxr+2PcEv+0q/X0t99CTqtqwJ0zxFj+wR0HmNtGLgYugteIDFrlrTI?=
 =?us-ascii?Q?aNpXxbSZW1xLQVvhp3kUSvWUk+eg3EFWfAlybjdPqhjIHN5w7ROEM0PA76y6?=
 =?us-ascii?Q?DiSlVnDvOxWNLbbg8BClSWG3fHqHwGYMuDdSYfXTFOVI3raCYOMpu8Dz33RT?=
 =?us-ascii?Q?GKWKjsEpRm0xZo+4bPlNpvaXn35kTK3VQJ3+zh9gyOi/JnyqqXfWL7x+oPen?=
 =?us-ascii?Q?SdvgeYod+emjr72QJyTV32qGlV8iRzi1Fp1Km5xycWpgkDlQx4iomatCAQmd?=
 =?us-ascii?Q?+wb11BXsK0sd/sc95ptEtenuoCwN0H3uDca1vtF01+xfCcRhmMOM2Eg+tbxu?=
 =?us-ascii?Q?+JEk3ggnWHPiyNzms+y0yQTV5uiiK1XQKNpymmLNhrbW2CFWx7Z9YZ2R8lKm?=
 =?us-ascii?Q?2686tpAaKL8GWHX5Qt2vAqd+rBB12I0lOIHOXkfbfhQuv8GdF0/4aAiP6SoK?=
 =?us-ascii?Q?PReFacHiGx4yU8hWHSh/et0EslTqmgV6y5H71mis3UjecdhpAvPsGq5ukEML?=
 =?us-ascii?Q?i3z5ejSOt46XGaMfWvr+rIKQ12Dl+sFBbzpKNZY23HGNSKrD/fBxQmdb3l6m?=
 =?us-ascii?Q?Re6sKzJ4oDsqG6G2q8NM+QIJW5BYTzzdv3FlZFJIlfx6Wrn6EKTpSbLtSXKD?=
 =?us-ascii?Q?hWwDOOcnPyxr0RdZkkJSmZxz05q55DkV22udMwvZ2QjJkkNnSCsRvQiX3PfQ?=
 =?us-ascii?Q?s2mq6MJWb7nWg3ZR/4QCUMBAW6FkfnoA2nYBBOgR3OsHrd0Qyn2bHSKxtyot?=
 =?us-ascii?Q?ysOuHFibticC5lKLfr7EIaXhNR4ShvxmfaAi7LTX0jI6ZUolhl9t7DT5hy3H?=
 =?us-ascii?Q?BHEHsuiKgXHTxA3PzU8tTth4ZR7155Ci8VLn2NxtrQ9FIMLJqdlAISt8P/de?=
 =?us-ascii?Q?MG0Nc2I9OQM6dfeO2wwYz5K4o9Q9dTD6ABHYGx1nLBt2G1ufpTbJp74v1dTz?=
 =?us-ascii?Q?xTXPVU5Vb3Ue0zHfWDkORv4HRWACc7LoW1gj54yPCUnrmTTjLuSMf45s436f?=
 =?us-ascii?Q?osQ30dUSqMpnIou8FKfOyAQVAv1VTr8dcqBa55Ag4hudL8tf8cIs+tK8k640?=
 =?us-ascii?Q?ESy1BxnUkmXeauvoGWOQGyj7jd7KoJbMOxVbEfso0AmXLnrY0BahUPB492jF?=
 =?us-ascii?Q?EZK6XDLTbEIhLwnms2OaKzW2tdVyAE0N9yd+Qa3xNFvFHX036OUJFjJSK5Qu?=
 =?us-ascii?Q?GdOsQ3CsxdqPAtpatqwAPyX/eNxzduYq6Dr560CTew1oj4V5YcLT4Yz5JG3t?=
 =?us-ascii?Q?AIuTwX6L0KeMI6cpseh2e6wEeiuXmjuin7u0UaYpHO39VKD0kaTgfpjS7DDY?=
 =?us-ascii?Q?CwLpCYZcWJfi7PfxSNlpy9eUmOMgfVLBhcoaAzH9+BwC9iQkqzdY4K+czpK6?=
 =?us-ascii?Q?m0TC/xD0qLlBtJtiCqtQijlbK3CLgUWKvHxHqvLleEkykSmus02Kb3lMTIKI?=
 =?us-ascii?Q?/DZR4OPetADxoptzZPl4aIUPUkYXUwXB4g7/1BcE7ayL+3rSdcu0RrN7/l+P?=
 =?us-ascii?Q?WwCSJKR5X8EIt+NdwRG4qiz2EdyCW2ADeHAgvbuexH1g4o7C/dPWvJl+bwUi?=
 =?us-ascii?Q?GUSG6Mm2dnchsiekUXd1JcAw80TKAs0=3D?=
X-Exchange-RoutingPolicyChecked:
	dJn5BxAnM8qeshlX0QjlCYskXKjjdnbcbmNIc4Y7dxbaoa0y7eGEtuGqqCjNb6gk4SExm75sIprNOMbQ+jrXM0p6uDDylqw47kjg1QAEK5nHhKeqSNm4dUk+0S0eMgVb8sQYdvNmnCLJxBi3gC4X7kfAUmhVJBqaEmw/zsvlWcaE86PTAjn+lL83+b+tgwEbwr0Hvht7amkxH02BQaL8q6EXqp+gNBF3bx4pCdIO4xi7BHjFSdrj6LIVIbsH1O3MGPHQGH6VOjRNm2Gx7d0crC28JiMDCTKjMW27mK8bzy81D8u1IfA0IQSF48hhMG5K0/LIIlsaU/A74KIoolZLgA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bJ5FRcBswMpKM+Hl6uP2jQoXOc9XVjQEgXh4lDmiuUD0DDnP+EvimBL4qaDxvRZpjsbWPnItdwtDTeRki7zBrs9ayCbeuGKNHvZn2gzrGAhw+z5PkreMAydan7NFbSeNLb39+uVCA5IycqSoxPL3M1qpdVTYNVYYfJwJICx5U9x9h3UNaMyxPnln9ILf1aReWP9b/dTGFJ1+UoGUkA9Zue2E3ZUr8ZnqJThvDHwJqrpvrH0W4rrZUlrxNqHUqMTSfAdMJtR2HfTqlEaEE8jc7UmgSin6Zwd1bdlTKqaqnlu/csQ1bRAZUPhiqEor64eX0p9/nWxMXxQCn8P8C/iIW3R2mLDVy+a/j22dWegIj4V7KPJv8bPoakdCdqEGb54XFMRuNungDMLCivh1YLYgLce5y46JFJRpTuNkzEGITESEDHTDuk/YPqIxY1VyxDLwF96GtATtQeuFulcoIdjWqFmW3zhqVSWvCVHi16xYNqTrQbM3izHuBrF/IZjZ+7NuinBGepDqRjO3FEMamR007eUvKeTOOn2/bRrbzPYdXrRpK8/bfypcJW774cWu+vbXtbT+pntnIxtqDTf18TWvLDuGnBQOWEY2rTREBJG9ddc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca815db-7afb-4fd5-a75d-08df2c218ec0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 07:37:55.1515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggITrsHTpHXpI4Xq9EWI5xx4THERqY2f453ZOYVwX9SXX9MjGHY7oF7EcYRaJuE/vUWfmlGGA8W/rc1HeuSIJjGsUtq+Xq/6VKud+lgXJm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610170029
X-Proofpoint-ORIG-GUID: lngWGsrGUPlO0HdRpNgRYaeEzfXuHi4U
X-Authority-Analysis: v=2.4 cv=H9VOUOYi c=1 sm=1 tr=0 ts=6ad325d6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=khnm2orjGHyqfzgCPZMA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12108
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX4OEjbbSp9X24
 nuIqIhIdK6pAVA4K0Xlshc9+44O9f4c7qfKuB4soUfugF4D8zqL9Hj58CrIUi8cTUtJx26l0OqY
 HWT2m6AX7QlqQPD/esHn7d+S42H8zJwxt8CIx33bOitiBEG6gO9Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX8bc4lnjlyBGl
 tg6pPIe7+CX817vMw+wHmh7Uuc0ojCjie6xwR7NniNkXrdLHdLcgH7+tNfSvOwS9fjuQdIKYmJ2
 bRNsscHJQu0lHSjxGi3RidXWtQbw788l43K4z4Zln+ZodEaO8FPEKhVpOvNE/oXQnTc69yeREMV
 vU+928MMbntfZrmsX3WCtD27ZaTNdpeR+AY2Tj/QFRal12lTVI2zzDq3y/NnroPKWyQe5TDp3nQ
 gImOWk5ZgtaFE8lyedqjrddgx9PoVvhoq3uoUTyYEMHwR4XofXABIo0GU9cRUnpHQ6lGZzUe8dh
 5d+vW9LvnrUj2fFnDeSSYzXR4VuXcKWkITPHjD/XZ9ef1en0x8pWXQ/zn4RNHf+XBcmgbvBI+yZ
 tBIpiskSZAIafV5l5UBHyl9wTBMCPkMOUgZkJ672xmFrYMcr9dLonovN7UOSE3l3oNcW/e33Hxt
 csVcgrqY7nph3wfVLociRXi0YCERZIcnmu2McHwc=
X-Proofpoint-GUID: lngWGsrGUPlO0HdRpNgRYaeEzfXuHi4U


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] arm64/barrier: massive timekeeping contention in spin loops without event stream
> - [Medium] arm64: barrier: missing export of arch_timer_evtstrm_available() breaks modules
> - [Medium] arm64: noinstr violation in cpuidle via cpu_poll_relax()
> --
>
> commit 7a1bb257570118eb8f711a76f172539e20eeaac8
> Author: Ankur Arora <ankur.a.arora@oracle.com>
>
> arm64: barrier: Support smp_cond_load_relaxed_timeout()
>
> This commit supports waiting in smp_cond_load_relaxed_timeout() via
> __cmpwait_relaxed() when the event-stream is available, falling back to
> cpu_relax() otherwise. It defines CPU_POLL_RELAX_WAITS to indicate that
> there is an optimized wait implementation.
>
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index 9495c4441a46b..e2263c754a550 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>
> [ ... ]
>
>> @@ -219,6 +220,27 @@ do {									\
>>  	(typeof(*ptr))VAL;						\
>>  })
>>
>> +/* Re-declared here to avoid include dependency. */
>> +extern bool arch_timer_evtstrm_available(void);
>> +
>> +/*
>> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
>> + * for @ptr value to change.
>> + *
>> + * State this by defining CPU_POLL_RELAX_WAITS. This enables a time-check
>> + * optimization in smp_cond_load_{relaxed,acquire}_timeout(). Note that this
>> + * is not ideal for the cpu_relax() fallback but that's not a production
>> + * configuration.
>> + */
>> +#define CPU_POLL_RELAX_WAITS
>
> [Severity: High]
> Does defining CPU_POLL_RELAX_WAITS here cause massive timekeeping contention
> when the event stream is disabled?
>
> When CPU_POLL_RELAX_WAITS is defined, include/asm-generic/barrier.h sets
> SMP_TIMEOUT_POLL_COUNT to 1. This causes the loop in
> __smp_cond_load_relaxed_timeout() to evaluate the expensive time_expr_ns
> on every single iteration.
>
> If the event stream is disabled, cpu_poll_relax() drops back to a fast
> cpu_relax() yield. Evaluating the time expression (e.g. reading timer hardware
> or seqcounts) on every fast spin loop iteration across multiple CPUs can cause
> massive lock contention and interconnect flooding.
>
> Is it accurate that disabling the event stream is "not a production
> configuration"? It can be disabled via Kconfig
> (CONFIG_ARM_ARCH_TIMER_EVTSTREAM=n), kernel command line

And as the Kconfig doc for CONFIG_ARM_ARCH_TIMER_EVTSTREAM says:
  "This must be disabled for hardware validation purposes to detect any
   hardware anomalies of missing events."

> (clocksource.arm_arch_timer.evtstrm=0),

Same thing for this where the kernel-parameters.txt says "so that code
using WFE-based polling loops can be debugged more effectively on
production systems"

> or under hypervisors that lack virtual event stream support.

Common hypervisors KVM/QEMU, Xen support this. Even beyond this
cpu_relax() on arm64 doesn't do much (is a yield) so increasing the
SMP_TIMEOUT_POLL_COUNT doesn't do much.

The correct solution for a case like this would be to detect this
case (or have a new kernel parameter) that disables polling at init.

That's out of scope for this series.

>> +
>> +#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
>> +	if (arch_timer_evtstrm_available())				\
>
> [Severity: Medium]
> Does this break the build for loadable kernel modules that use the new
> smp_cond_load_relaxed_timeout() or smp_cond_load_acquire_timeout() macros?
>
> This macro injects a direct call to arch_timer_evtstrm_available() into the
> caller's context. However, arch_timer_evtstrm_available() is defined in
> drivers/clocksource/arm_arch_timer.c and lacks an EXPORT_SYMBOL_GPL directive.
>
> Without the export, standard loadable modules using the generic barrier
> timeout API will fail to build with undefined symbol errors.

Yes. Can be fixed when there are users.

> [Severity: Medium]
> Can this introduce a noinstr violation in the idle entry path?
>
> arch_timer_evtstrm_available() is an out-of-line, instrumentable function
> since it is not marked noinstr.
>
> When smp_cond_load_relaxed_timeout() is used in poll_idle()
> (in drivers/cpuidle/poll_state.c), it is executed in a noinstr context
> because poll_idle() is marked __cpuidle, which places it in the
> .cpuidle.text section. Objtool strictly validates .cpuidle.text as noinstr.

Oddly enough I didn't see any objtool errors.

> Calling an instrumentable function directly from the idle spin-loop macro
> risks tracing recursion and objtool validation errors.

Will check.

>> +		__cmpwait_relaxed(ptr, val);				\
>> +	else								\
>> +		cpu_relax();						\
>> +} while (0)
>> +
>>  #include <asm-generic/barrier.h>
>>
>>  #endif	/* __ASSEMBLER__ */


--
ankur
