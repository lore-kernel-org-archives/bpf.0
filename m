Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26123955DC;
	Mon, 20 Jul 2026 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518309; cv=fail; b=jSDjuL8v4X5zr9IAqypOtsCcRZi7qyq2wBolAQPU4m2E7u+8QJVKI5MGs0C62CnK2mBedK17h1/BDBS/5agve0ZDcGaWFWgxss41kkeEOtWwYrA1JJgMujfAqih8Pn026twRYxXbSMR57RfOZjVP7oy5bLz05Xl9NR8FnmoM+No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518309; c=relaxed/simple;
	bh=DH8ZpYp/Z2DVigMu6wax7QRPajmqv3PT2kNlejAOVDM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WBOLQMWFzt7wLCgkDr+DFk3D+oDDWcddmJW04OGk56x8rDbQzH+0gvqGfltW8U/TVGExwdlHqrS1HImqCA57AVL/+JzD/H7AooyaPHXpqavUBnta/I7jFUz2fQAGdYN2g7lUFK0E4V4GYp+kZsSTkD7wPRQdlUH2HeKXRyJiyXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KtWlKNcN; arc=fail smtp.client-ip=52.101.85.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KtWlKNcN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kY4N2k8ZEgR9YxXugOIsvkM+BSry4hNVEFQNZkPPNJA/QCnwO9BOP1j/KPMskaEzNvUJ9Z/QnYjVZ5bd6sKTs6W8jIaffOb2uIy66WnpdKjsmTxXj8UQuDLb/MJGhSI2YPqXfjmLqxeo3VktJexDjBztbmlYikz1uh+929R8MXvItTexUT5lityLDopxDL52WzMccYH6aILLp51KRe7lbYCfisveZMkj54kxQOXVl9vEr7s92GqKiXgJAw2Z+EnXPIuSn5FBKwG2zrTP2/J6VOkCjwQNz4F0LQWvi5sT8MJhTjwcf6KyANBvl9Pje9gBdgqj5sfacZVBIuqwqbSsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP/hLuAJPLX4p9+cOcPCWAojBI5kSd4iz0bJD8QIbkM=;
 b=Ren5/Fjh2NS7FAY0LFzPaiZGBPZSPIWIH4xM3sBgyuWEq0x0B4+9Uorle5x34lBSyMXvsbWd68lL1Rd2ulDfQIWnSbjM3yAye9IvtFxpWr2vzTnU4WPKzJ2ffx0NzDPhuaMNTbwUsOpj1fU+COXe1KqTsowFWJNkW++yoXsiPv5xMrDQkAcSYHCjRMG2eGorDY0QJkpXTE9Qbct4+cynY5PQtvVpOICvoU6H3J4Kx7X3CJkIMSNjgjZXDSQT4o2OoXoxTI6pKPHC/O1VRR1eW6Hx6JGYAEMzeBgAtvK+Vs+n23eeWj+eD0Quzqc7XwlTkRDphj6Ouid+qkKp7J0BIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP/hLuAJPLX4p9+cOcPCWAojBI5kSd4iz0bJD8QIbkM=;
 b=KtWlKNcNFaOuviKL2u3z2mvw99jtm/B3UJbhgsDSqnDylHe3egpu0/EF4bT+0GEt7CZ1/NGqxZsEqQwNLjvsZG/F5z3pa4NlnRKgkCKO13TB0xqFp+fbqVlxFBNKnL2yPAeM4pCWRk8k9lFYCClTVLdrCOK5eiMK3tVT46Aqv2vX51plqsnMmbE2u1TnNr8HFnGaE/XRQQ/TZH0cw14NX8n8XOYigVU+6FMoY8JIQXr3QmGDmntsGydyS2KlZE5uCeLs7xtXevXbHKhvbKBcm/6bMaTpGfsKrcYkMwkfw4PHuLq1b2f87buagji722aMT6PRx66gmXGcdplRtZ8z4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 03:31:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 03:31:44 +0000
From: Richard Cheng <icheng@nvidia.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] bpf: Run deferred program freeing on system_dfl_long_wq
Date: Mon, 20 Jul 2026 11:31:35 +0800
Message-ID: <20260720033135.62223-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:d10:31::8) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cbbf1bd-5043-4694-cdaf-08dee60f6b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|6133799003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	84Q+I2YHtYimjRXSNaEjQJdIAY1MWxSfddtSErRLLItsfNFfaP3ypwuwsnv+MV4PhMYlunqYfbQBGKP4yEjQzqUZMCvXeqzsRxYGvISUauC9w8epjvFro4Nd9i3INN6LwRHwdJrTQ8IzAcxL2+Vx/NA7F0Np75ecrxD0nXftZ9AraOEq1Lti+AZlb+v8FsBSXHPBS5P4N5JIwwEDkpvSxE8FJAetqMTyj+GQRJxRLpDxm+gOXr/v7MBQzDw7EkBMU+U9l2HfYfO9oUTmsxfCWZhnIK9i+Gv+RRUEIwbapUPJY4Oei7FDO0s3/MfZq/PUb3fGJKBuIdsE+38tmypzUCtX6CnBk89LOX4gMWV8gmw2sWmRa6OmB18WKFbV+un/4jMpEq+fshvzxyaDWyo7xDTUGo/DxLso4BAR+RDOP4R4obuB31YBa30GDGz/YSzMWVDZJJztgXx+5LcMUasp88RVTulThLjtb0sRKwBHMHFbT6Sa0sxzGrj+q75aG4qrBgMjDVQSXvMz1ygKIX2FzkhZtlsIISVgfbCn9DuKvxJXq/P3ZS/RkNkPTNYVonUK+ZFs10IsCePamjEKHvwH22BxJwxRTh59hQiiKyEvhSOeN2fhsKQTjpbmbBtSi8NvSuKnAH2f/yuSfSGO/esFcf1w1isZ7gEXOGsxA/pMxRe0Mol1hrsZY1RqTg0f6ugbWBHn1XnTY3+XNMPKk/mbbQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?To9H1dAsurHNe6YWXIouahSAfhPeb6xNQYA5rHqk+Qqs4U6aumjBJefzQiTh?=
 =?us-ascii?Q?mhMIpIfVRpjNKVnbXrWFhtu1dZYjoQY93SsR766mk17E6wujxp9fRHzWLm4b?=
 =?us-ascii?Q?kgbQq64JYyKozf+KW4+8B0h9gHbpRNhD77GNh4ANO++fm2CyMx59JkjLTv+X?=
 =?us-ascii?Q?EdyKXcMQrxsnwXxzeRDHAV2B+R3Ju1gzxxY1gUvigCQ7YrgQK29VNNgHh7E5?=
 =?us-ascii?Q?19/fxjSF+RqNeVIMe9g9Kz8iHaMdSryMKzXPo2zFTO9pMjDLWbY/wHo5zRjY?=
 =?us-ascii?Q?ejx724HU2wQ8wXIuhesdShhg+SyUHKN+UthVKByf/Q7wTGvXq0ro2IRU9aAj?=
 =?us-ascii?Q?EusOS9L1jqabsRdEF9tO9kS3ibWn9LGPHvyDzXV9RkrFkgX288JJ6Acxylgq?=
 =?us-ascii?Q?qJ4HUoqkDeTBPMxxPKluDEOlY1vPNwRIgDSnw35V1BYlU6Uk3lsoFXqHYlaO?=
 =?us-ascii?Q?NPKKAK8JnGpzk8Ka7p0ZbRc4IFUbazxWMUVdgV3r8gO2EJx59tkYWkQIB7j9?=
 =?us-ascii?Q?aPU552eOv07L3e+aAWan+GUs6N5YZIvw/72uBJTA86+zDUE/dn0ZWwtfRpuc?=
 =?us-ascii?Q?OL2YU3NxRRZHSFU8EM+T1inawFEUEOPbMA9RBSz49Bd1FiAqCtvLSwi/y2QJ?=
 =?us-ascii?Q?QNbYNpNkKOs4V7xtLGyn8v3gKxcT042jXa+Z3kSIMdEK3/eOdmuF0gzb6F8u?=
 =?us-ascii?Q?gayf14Dp2y5ra1VyeWmfn50S0qhqjUZp51Ha7HGP+rKdSnJ4YCkwcdR1QTVM?=
 =?us-ascii?Q?9qrI6cO2a6BLE8dazUDQAJz8MNvPb5EcKe2djVFvHVj6YCY8wYrbjXt6PNDs?=
 =?us-ascii?Q?yHgC9l7uwzjzGG4dna17+bM18LoqJqkHixCwiaGwdgfnwyJCcg7LKCpQaMwY?=
 =?us-ascii?Q?QpsawE2RjfmnzNpqZnnuzqUOffsorS7xGev8dG2rePuT7KTJWNEAMfMBRB94?=
 =?us-ascii?Q?IBSNnJVUh/jEAZjy6c1V8aS+y8ZCN5xmdvxbmmvGjykblN4qC7OHidR8FigV?=
 =?us-ascii?Q?VAue2cn2381+qjw9i2rqZk8Ka5gTPfOD+h9ULiABst0ad039Kuyg1j8ZM1aY?=
 =?us-ascii?Q?GVmp7z4oCkzBFsONMyYPVOHq2Duvv9jbOJFxmVFuknSvjdEacrrX8lqgW9+6?=
 =?us-ascii?Q?oAbVvJSQ5DZzEyhxeg0RXQIsUUkVtHlVkzA5Q6XEBdnYTM/AlGop5gxnDbUH?=
 =?us-ascii?Q?WzAV2FRFMj9UMPJZ+NBDWqcGsy9couloX8KISP3cSDj+LA7gtWUfbdhNeOIK?=
 =?us-ascii?Q?JtqDbjjaMIRPB0v8ovuJsbyQyV20pPcTWwDA22IdKPAKGvu6XG8C6cwOwbGR?=
 =?us-ascii?Q?rpNV+JIel5uwoQfnW5yO9nOg4mmnw9ZvMUlfpmtPA96+PWB2UWe6u+eNsEvm?=
 =?us-ascii?Q?esTsR6xwdit5/WGVga0AdGX9PlCiYrdtaYK/R69PLaCjsZJuAPfLfmM2MeRY?=
 =?us-ascii?Q?GHq7HylzECydnNjWtN+C60wfTOk87kcW2rgtZAOEG6Iuz4V1ZyXszQ44hnO3?=
 =?us-ascii?Q?NXJRVPCO++nTO5lHK+Q0rvi6WGB9oO5Smb6SD96+MoiJ7dHMB36RJLCDpyha?=
 =?us-ascii?Q?Jbvl9vCQ3De9D1S4fxn/QeE+EnvL+OtM1pGyXiP/46kr9vQpHJGmlvua0QES?=
 =?us-ascii?Q?7ojvpBah2EAJSgh6PoeC38QRPafGhxYqev5GZct6BO4NUQ0KrrvxLz5l5oER?=
 =?us-ascii?Q?B2tm/bXUswA7OA5xWo0kva7j1dGUfLDG/TxkLkoXIR7IycKq25FtXO0IQwUg?=
 =?us-ascii?Q?9ETWYxxQ5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbbf1bd-5043-4694-cdaf-08dee60f6b87
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 03:31:43.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWy5TGbIEagAnOdHlN1AXqmxuWF7GkAlyuVXAM1QKVvJcG4TdmNcZwxn58labqHEY/Dv3rZYZ+DZu5ZITZlSNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940

Destroying APT's seccomp BPF programs can spend over 20ms in arm64 JIT
text invalidation. bpf_jit_free() calls kick_all_cpus_sync(), which is
especially expensive on system with many CPUs.

schedule_work() uses a per-CPU workqueue, causing:

"""
[204351.169849] workqueue: bpf_prog_free_deferred hogged CPU for
>20000us 5 times, consider switching to WQ_UNBOUND
"""

This is triggered during a normal "sudo apt update -y"

Queue the cleanup on system_dfl_long_wq, the unbound queue intended for
long-running work, to avoid delaying concurrency-managed per-CPU
workers.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6e19a030da6f..a2ca6bdfb6f5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3115,7 +3115,7 @@ void bpf_prog_free(struct bpf_prog *fp)
 		bpf_prog_put(aux->dst_prog);
 	bpf_token_put(aux->token);
 	INIT_WORK(&aux->work, bpf_prog_free_deferred);
-	schedule_work(&aux->work);
+	queue_work(system_dfl_long_wq, &aux->work);
 }
 EXPORT_SYMBOL_GPL(bpf_prog_free);
 
-- 
2.43.0

