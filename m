Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8FA3D413D;
	Tue, 20 Jan 2026 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946722; cv=fail; b=vCdbNZBm7RZg/tmcaczIcgvFToy9qTzYau6Gm0XQMED6b5dU9wJRWlEnsTX29b//Ib7K6PvL5r60h2gVf7KHHAo5FTyRG3pTwHzQnatAQP9RZHD76r9YqpSADOieHRqGqZWiShEIXZErd7Ju5d9yueqy+gAwqjSyAs9JlwQoSLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946722; c=relaxed/simple;
	bh=k7CacBXn0Zpme2Z+3TcLAgNid7mE0VT/c/c5JOuGsNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aTZ3rsy3QmUIdX+PbI+LBVJlMDriGo+z0ogKgLS/sYsNwTPPb/SdeFv/yTjP/h0y6pPvBIyi4h+IKDKrqH37xfGBieV6HRPN6k/Pt7ho8FrXLXyUvCvrgeKAWSDfUEd9SXFFrEQw1bRJQl1Ltt/OIdWxYUgzCtWXIBdZ8ZAnYok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r7h/m3yk; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r7h/m3yk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvQRdgv4WIJ1aWTxxVqZvvcHiZfJtTg/yMCjgPNlOtU6whDjUKtdTl6XxbQ8UddFqIswIUe6YMKpOmUbiWI2x6pgsMs1EiPE7U4/6fBAyHjjncytvjFVG6r7qlDmffqphtvG/U+LOYSDzECjej7Umk/xWBLL8X4RCEb9oAPibaMG7zlWovhHMr4SmxPzq9pI98hDLXF8mP3A8yikYxaPmCtp9TGD3crn2ua+rqINKL84BHfygXP9bHFoO6C6ziHMi5gCWnBQq7Y+hxWqDPyBbXSbbQHeVIZj9Em9qi0gZLXDooeBGdt0OK5MYqMcHHd7OeFJslh6ZawlY1lzIad1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FYv+Mz7VTBBpNFUUTTxRNPFgvfvjOiXaeYxmd/jF7M=;
 b=MCDUjxlkpf/TS49kswSyzbHh4zmF+pyG1mqUj4gGWmBPUg4mNIqrhT7NKM1/JQdbSXPDh9pFepxVGLPp7RoTH+BpnROgSSQ48F19+Ochd39Eulm5PEHFS0fLN2vV7b/Hu/s5gcYAw+BHSuN4Icb8jY3FTy60V8Q1eR8TXO3xjVZqblAdWMQvwj5kmq96zA7i4a5mVV09ORMdIrGpX+mEpWnTe6Kmtqwm024Sdh56V8n88McqGX7qeYAh3eZScpe9Kd++iiZuZ6TkHcSWXqWH8zLNQprttLQuVnQk+W4A0DI8IxwmXZUxls3Njr0/2Yp5Dtke5eQRdGqAPnuERNSnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FYv+Mz7VTBBpNFUUTTxRNPFgvfvjOiXaeYxmd/jF7M=;
 b=r7h/m3ykUeXFrsFlF7RkI9oRFqC4OdQIrC0mBsD8Y7cKu6fu63SlIAAFsojrT45D6Czft2HQYsOm1u7DRRTG52M5TexSH1X6UPQk4gC/IJ0hoAea9FXzN+b/9TR5OAwUStrCgdqueYqk8m3T5hSkyYHUEdgCfwNcDShf8lIbZfBTjvEIyRV8aoHtzE7/T1WA+4Prwpx5Dnb2ns/Ot8velyB+0PtUtSfz6ZaXGePkwu6+EbF38Usk2bOwHqUp7g/yEhu6Kp94/u23uPIfovhjqC0HKpO33dLeQO00+ylrQd9qM3W7Xslz0QZUGU9np1akh5l6W/QfrORFvo+FyyU8JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:05:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 22:05:05 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 5/7] sched/debug: Add support to change sched_ext server params
Date: Tue, 20 Jan 2026 23:05:00 +0100
Message-ID: <20260120220502.190159-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120215808.188032-1-arighi@nvidia.com>
References: <20260120215808.188032-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: b488c62b-4920-4152-3614-08de586ff799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FmNICQswcreilerF5cUK6wWxZfuBj1wldyaLOTqIQgjYEgQlxb7Q3hqYG3Uh?=
 =?us-ascii?Q?MQps1G6yC5yogErh+5673pOvo2YyiZ7LialrwxDoTqCy9Hxl/tp2O3iB/lvX?=
 =?us-ascii?Q?x1bHtNHaId03S+k3ia91Gy4QcKrd03E2m/m9VNAO6d7qdjdIgahrViyM7+bb?=
 =?us-ascii?Q?6BRPRKT+841TwHjMc2nn6nO9uJtEpTyQXX7nS2+znlQ2w/FnBxVnFUqR64Rb?=
 =?us-ascii?Q?JvawhDqLuB7lMG3kqMusShLo3R0ROND6TmCVTTRRbZO7N+Uxwqp0YmPNnQDY?=
 =?us-ascii?Q?SPCWMEXw5D4iBHvYKts3u8HpH4XSJ5TKNoQujj0omG+f+IRK16yzP70C5UTW?=
 =?us-ascii?Q?dLY0zLJ4fbkwI6/ebWt+GZ7ZeYv3BWwsoK6Pbc219Bik6sNAMYLQ/Jz7mKSz?=
 =?us-ascii?Q?NiivDo4ZeEPeuZ8RvkVEJOIRbvfhTG4VJwcAni/H1r17S/O8IsfzQgxYuSXx?=
 =?us-ascii?Q?opAwHQspGakeJxai9TzLFX0QJ56ZZc/BsrOOsOja0dJt8Of06V7JiXrtm0v3?=
 =?us-ascii?Q?uytR+Kg6J5sopbaJVGnY6yPjlHoL0AXidM5BAj5pYsIigIrIqxCiLvAxIgzx?=
 =?us-ascii?Q?JnsmqKKthudjEYdeM5274nZAIcnLpjM9KXunZtlhhfPn6zSERGVkXIq9OAPu?=
 =?us-ascii?Q?Gf30RNYct7A1YQ0Uhcxqh6NzW9DhkMW2aG12i75qx/uaShSdNeH3E6HIES1l?=
 =?us-ascii?Q?uP8uC1vU3/B1QLlKlmjPfKR/B8IDEmlns3YbPaOBLtBB8zPjsbfHrrqmZeJP?=
 =?us-ascii?Q?SQJGuRkXGewcg0HLpKf0q/aBqKgGJ2QVEPnAJRb88mOTJeTNqnUH75g2lBJz?=
 =?us-ascii?Q?7tKnST9mHY6QeadiuReSLFBjFKmBr7dz1Tm5Q6uPwot29T7efR1TrPm9tEps?=
 =?us-ascii?Q?ivjsPa5HOxUC7eNqb5eInRBp4ycx3DREfeYUZx10/ebViIwITPXo/P6oqSSG?=
 =?us-ascii?Q?TQ4FhHzm5tqbjZYMUTURZrIZa8SpYSyVbLX5zV/YiPkveWMaxaN4aeYjZpWu?=
 =?us-ascii?Q?opVak6pPB7cbIEW2KqKj8MQSYBKF9xH7ztGWCuXcPU6z56dAIMJvP9Yw9qIv?=
 =?us-ascii?Q?qRQQlPemFFDFacJeQExkEY6LxtyHaMlSwPoEcDqNdTAEsbVnepwLmBVAstGa?=
 =?us-ascii?Q?9zi0o3NsdX1OY8cmGFy6FZppMhRHgoyhc1xBFmBYA5xzZbw9eNxB23eVdJA9?=
 =?us-ascii?Q?8O/frcjwBmG3XMNARrGLLBbClpfXRHo8t7p+jbpX6RrGa0zpPq6qeyFZVMo0?=
 =?us-ascii?Q?u98nlCJPuYECDCiR/PDEBP6E60eSDHuc4ho9Om6ByPxNOPQWIbSUDpIMN4E8?=
 =?us-ascii?Q?F/N+3hDvU0TXZQcEvl672c5+WFoDW+EjUtdhdnyeQHXQ7PoIqVE9fmow1w1m?=
 =?us-ascii?Q?rFpg2PUYr6JBrBDCnufRzrwAIjzmWAFZ2LiYtfXSczb1l343TywCkDtrcFT7?=
 =?us-ascii?Q?kI+Oz/B98ElphvWoKe0F2r2sm1gmqRHTYGyHBJ0Q4kH3ujSe5Dq/LVecndVy?=
 =?us-ascii?Q?kxQ8+Fu3UOY/WFqe6pcQ5Pbad4GyRZItOSz9L1a9Zj9rb2fs+BQtLYbpeQJh?=
 =?us-ascii?Q?CfnDoAmMQnZYoieZ916xfw7VSo0kWptg/CwklWIza0LJSmHbLU9lbT5tBsRl?=
 =?us-ascii?Q?KQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0mqkJPvE/P37JTOfOUq2hhkMMgARoldavdOfHIeeatgcUZR5J7IMNECIOvEc?=
 =?us-ascii?Q?SLEhlqqCOUZAI+rKjnUQiSST6YYjfX2+0n8eLuIKq+9L9PghDTdW28WonyfJ?=
 =?us-ascii?Q?ApeWnk2omWkpu257+EWVE8Bc0GY0ELHHHN87Nj3VQDsdEdTSd1V9Q5EOQV9c?=
 =?us-ascii?Q?lVvfuHP0/yPbU7KoQadjuAsKa19sFLqkxQgPnM51hM6nMnyKNyY36X7YFhMd?=
 =?us-ascii?Q?gLzGvotqKcDxyUdxz+KRPITG/ddxHMrgNoGUS+QD/aIqoZpBVM2zdxB1q0P5?=
 =?us-ascii?Q?UzVtjBXvB9i8IB/Hn/+PQky4evO782cgRFedwW+FUSGbFEg2dz9ucgx92PXk?=
 =?us-ascii?Q?Xn9Fvpc3h0HCZHj9GvJepSCaje3EUxB9jkMImIXcvnl1Rpd/lvjqJ56Skspd?=
 =?us-ascii?Q?og6jtOXBbwK0cxraVXXoQLLGsa73Hkp90yNpKJ360mSgN2Kt6PUmY1e3aQCC?=
 =?us-ascii?Q?KiKQIap8Kpjmc6DX53p7k9WIo3FgRHyov0GRw1dmjDv+BksYbkJP0c8TbjEB?=
 =?us-ascii?Q?rXadYnwHHz/KaQRu9OjaPCPJYhT1jrv9pLR59gDydCVf5ZpQA9uWWLPtj2/d?=
 =?us-ascii?Q?Brn5eO2qOahQbiC4IsbDPaEBw1iEUCXPgHgfoysQQTokzJ/gp1G+BZWcVOcb?=
 =?us-ascii?Q?hm8PEn9eLl3yRbcw5wNzByfQivhSKAbK+WGd55cO16wVQc2QMepByKL9quOW?=
 =?us-ascii?Q?DF9wGzkgFacikVvg/2kbLd3Ag4sKzYAn4qQnxriYj3gFSiincbY17f/whwrV?=
 =?us-ascii?Q?FyFt0GbMpTbaNCnQ9sfyVqk/IpTFD1y3yY8mcWku+MHkZFDu/ZJXpLD+R5us?=
 =?us-ascii?Q?RkA8NEN7gAfwk9hsMpTzilMwedML+4Vb3WfvPBZFiya1Np9rNYIBjIuIojZh?=
 =?us-ascii?Q?iD6JYeXUWvVmojUe5H+SX65fHnu79SeRkgNPzByDLLgV+gm8uW5SIvg8UlRn?=
 =?us-ascii?Q?gL2Y28Pj2HO2RsOtOBGjOzYcwboQPY0z/RDN3+IDW4cXTgaRHhneYnm87mVi?=
 =?us-ascii?Q?m9jAQl9Gu7TKB56o3xHz/ZRiwMhj3FRbHZdteJRdcBZWYMOWm70SFhYMFJsn?=
 =?us-ascii?Q?C/nR9XpJD6ZkULRo+QeK/1LXvCnUfbkJISHHZnTbXawCG7pEHnBPvCg3ARj/?=
 =?us-ascii?Q?dsLa9DmdfkoQ0MR5/umrj+SOndWzYHeLr5Uzm5XiYpBK9BexqbN87LWxGOKG?=
 =?us-ascii?Q?4+z5Tdm5l6RREvsUoRdz/Z6RnnZDh7O27VEtmanPhA5rRAeGCUnwtzSUjf6O?=
 =?us-ascii?Q?X8Z+IhxD6y4Fy1NZrmVAcKRB/29TLATAD6KBej3A8ethdgPNDWVERTHjF3Et?=
 =?us-ascii?Q?1o7zx4cPRx0KZrh92Sd+Qf1ADkvc62rEzLvENaJnymSAS4IHg4hk7gJkVPNa?=
 =?us-ascii?Q?nAIEWyArmmLlq+YrvWNMW4L4V2dLFJFc4xdnOScVTWtQ4AdHdSOBkxsxdmNK?=
 =?us-ascii?Q?gWnKA1+FzOl6CMWSchriP4LDB3gleTzL1vRmEuLPSuKHzB8rRxy+xYkHtES5?=
 =?us-ascii?Q?XaHphUpVr93WCtQrkjXBUf1qqRSN7wxdKsZ0e8U8GoYSNrwteTyixGlGvjiJ?=
 =?us-ascii?Q?vCCqgqJ4PnkA2RME58IArrTpIa4bHnLOIkhNJv6Yu+mhCefHmhlRF61cqtQZ?=
 =?us-ascii?Q?zMx+DTo4ywxufs/ElCcyUwU8IhDg98ClITWkSNWI+yN07nMMsESU8LnkOK6T?=
 =?us-ascii?Q?/L06LxEOfZ3wf9lMhhbWForF0pF/tV0T5wF/Z/Sk7Z0BYq6u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b488c62b-4920-4152-3614-08de586ff799
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:05:05.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TW8/EAmgYgTmc4u1+f9MDXqIAhkH8E4bB5GluUttp0T1aUN9QrhGEGiI86Tc5CGLMGh1BKi0N/0MgE3ZATZYEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426

From: Joel Fernandes <joelagnelf@nvidia.com>

When a sched_ext server is loaded, tasks in the fair class are
automatically moved to the sched_ext class. Add support to modify the
ext server parameters similar to how the fair server parameters are
modified.

Re-use common code between ext and fair servers as needed.

v2: - use dl_se->dl_server to determine if dl_se is a DL server
      (Peter Zijlstra)
    - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)

Tested-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 157 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 133 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index dd793f8f3858a..2e9896668c6fd 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -336,14 +336,16 @@ enum dl_param {
 	DL_PERIOD,
 };
 
-static unsigned long fair_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
-static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+static unsigned long dl_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long dl_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
 
-static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
-				       size_t cnt, loff_t *ppos, enum dl_param param)
+static ssize_t sched_server_write_common(struct file *filp, const char __user *ubuf,
+					 size_t cnt, loff_t *ppos, enum dl_param param,
+					 void *server)
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 runtime, period;
 	int retval = 0;
 	size_t err;
@@ -356,8 +358,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	scoped_guard (rq_lock_irqsave, rq) {
 		bool is_active;
 
-		runtime  = rq->fair_server.dl_runtime;
-		period = rq->fair_server.dl_period;
+		runtime = dl_se->dl_runtime;
+		period = dl_se->dl_period;
 
 		switch (param) {
 		case DL_RUNTIME:
@@ -373,25 +375,25 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		}
 
 		if (runtime > period ||
-		    period > fair_server_period_max ||
-		    period < fair_server_period_min) {
+		    period > dl_server_period_max ||
+		    period < dl_server_period_min) {
 			return  -EINVAL;
 		}
 
-		is_active = dl_server_active(&rq->fair_server);
+		is_active = dl_server_active(dl_se);
 		if (is_active) {
 			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
+			dl_server_stop(dl_se);
 		}
 
-		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+		retval = dl_server_apply_params(dl_se, runtime, period, 0);
 
 		if (!runtime)
-			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
-					cpu_of(rq));
+			printk_deferred("%s server disabled in CPU %d, system may crash due to starvation.\n",
+					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
 
 		if (is_active && runtime)
-			dl_server_start(&rq->fair_server);
+			dl_server_start(dl_se);
 
 		if (retval < 0)
 			return retval;
@@ -401,36 +403,42 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	return cnt;
 }
 
-static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
+static size_t sched_server_show_common(struct seq_file *m, void *v, enum dl_param param,
+				       void *server)
 {
-	unsigned long cpu = (unsigned long) m->private;
-	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 value;
 
 	switch (param) {
 	case DL_RUNTIME:
-		value = rq->fair_server.dl_runtime;
+		value = dl_se->dl_runtime;
 		break;
 	case DL_PERIOD:
-		value = rq->fair_server.dl_period;
+		value = dl_se->dl_period;
 		break;
 	}
 
 	seq_printf(m, "%llu\n", value);
 	return 0;
-
 }
 
 static ssize_t
 sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_RUNTIME);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->fair_server);
 }
 
 static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
@@ -446,16 +454,57 @@ static const struct file_operations fair_server_runtime_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static ssize_t
+sched_ext_server_runtime_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_runtime_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->ext_server);
+}
+
+static int sched_ext_server_runtime_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_runtime_fops = {
+	.open		= sched_ext_server_runtime_open,
+	.write		= sched_ext_server_runtime_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static ssize_t
 sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
 			       size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_period_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_PERIOD);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->fair_server);
 }
 
 static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
@@ -471,6 +520,40 @@ static const struct file_operations fair_server_period_fops = {
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static ssize_t
+sched_ext_server_period_write(struct file *filp, const char __user *ubuf,
+			      size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_period_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->ext_server);
+}
+
+static int sched_ext_server_period_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_period_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_period_fops = {
+	.open		= sched_ext_server_period_open,
+	.write		= sched_ext_server_period_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static struct dentry *debugfs_sched;
 
 static void debugfs_fair_server_init(void)
@@ -494,6 +577,29 @@ static void debugfs_fair_server_init(void)
 	}
 }
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+static void debugfs_ext_server_init(void)
+{
+	struct dentry *d_ext;
+	unsigned long cpu;
+
+	d_ext = debugfs_create_dir("ext_server", debugfs_sched);
+	if (!d_ext)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu = debugfs_create_dir(buf, d_ext);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &ext_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &ext_server_period_fops);
+	}
+}
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -532,6 +638,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
 	debugfs_fair_server_init();
+#ifdef CONFIG_SCHED_CLASS_EXT
+	debugfs_ext_server_init();
+#endif
 
 	return 0;
 }
-- 
2.52.0

