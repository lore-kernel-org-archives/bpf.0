Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836823E8C61;
	Tue, 20 Jan 2026 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946309; cv=fail; b=j2gAdnZu3+jipWe03UBsQDFZkXqQnEBvAEhujbfY0EAgw9ibYaHxjino9KyBFftKr+5ToA/lZOxmIXxkRWrzlkEPhNAGggFUEkK/CgdMBs6W56zYjS4WwXpg82Z4qBtHA9n1SQ058+5u0zDHajQMnq6oDpIWplEB67znuwKOZMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946309; c=relaxed/simple;
	bh=6vEr4bzHlEuAwz+cLeabtpEu6Lzl3CdGEZYrw23GhgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W8NjPOWpAf1oq43FZiKCgbTDSxzprGxPuWbE/+eomEZ2Ul+eEHaV99tRAX+ZhrjItDk672UMG7HFGfXM4ngUC6WFjtIoYqwn3kPwnNfv9NFOuWN3om3btZDfohKq3aBgeIilHrPnvq3/ycB7fz0Lvadi1dBthLvVfQkQDmd//3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rNmNOagl; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rNmNOagl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiOYPbJCD84jBvE6wzsRMnZaj4FdWcRYMrx3YLngVDeeePIFIemm/SPs+sGUNBJq41tVIrosmnPvo2I8+RG8cid3od//cjDPilCl99ElXI6UprO2cmKPu6poU0ArmSnRRcp4Ks4X8rUG8unPh7VZOoW52ToUbGQzOlh/zRTO7PUJWzox+mfrdIzr+tJflYR4sxENBdNa7aPCidHAuSxEi/VIjdU3vgV1kwUAdTwjMiCjYqi0JC3wbzvO9aljo/EjuXEIe/+dA9M0rEGgHI1c1f67hrP0D9/EHSEDXrCRzjLyuvH3FYvH1ccrGszVxNCxp1EY52OfhVaF9BFZarNuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLvZQJrN9sti6NuWnv7l4mZawbEJKPCb+dPs/H22E9c=;
 b=Lw0qiLqe/2fqP8/hOxCo5dfUekolDLcFy0Ro5o+BJrdFTFwqJW8bUQaj6llO4UWirjdYL05MOddq/H0PJztn4xFnkAzc+xdQhuIgrLB3664hNpOvwD/tzczdnzBqh3dCfu2V+KnYYCin7qFx9coak6/rRTWWlQYWTOTdibgDLA19j334yy8w8boeNNX9ZmCmCVxU3VA7OC3qCAoBRzGvgv7l9WVOwAU94nxRNVBOT+hA0tsOKE52zKmXstEGH7qsQEK9Xt5O3oEP0HRirLsM7qylzraAPQvCkTrdVv4uj5I79OYRkLYIVEj/sBs1dzHhIv1U6Vb0Zk5kuk4cfuC96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLvZQJrN9sti6NuWnv7l4mZawbEJKPCb+dPs/H22E9c=;
 b=rNmNOaglcRF0hlrEUZNLmMZDhgvW7gdt7/P8RAE56bW7IpvUcj+llGunJiC2YWwnHBo4VEwPVT21jxQw5Z6cwEqTapbd3EHAaDPCq8XmvUb8RacykNU4R25deZEHRHnuEThYaH0L2M9rxbRQe+W+Ya5ebNlPZ0sPwHhl58jwHf9xZ50CU+uSaMoITB2a6cTY8gvTt6ljSGGoHrnF+qcSgFmrPWzfcBTp2b99+//c7IxynnbTjJp5Ma2a6i9cDCMt+kT5ifW48rfkctKDSJnTn75v9xbFVf/lYfPjF75Z971TsSsm+ST3JSqSbQm3gvvIU30j2MVQUkJ7Clm0PIpfpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 21:58:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 21:58:21 +0000
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
Subject: [PATCH 2/7] sched/debug: Fix updating of ppos on server write ops
Date: Tue, 20 Jan 2026 22:50:33 +0100
Message-ID: <20260120215808.188032-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120215808.188032-1-arighi@nvidia.com>
References: <20260120215808.188032-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6b6294-9d22-40da-0d07-08de586f06fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hUT2Xtphc+Eyg2MCmVnprtHB86tuoYWllRz8DClPL6QYQVnHYfB4JCKffOE3?=
 =?us-ascii?Q?4yrzfYzDUK09uYCsSWfbUbM2KrxItPgMLObqTDUL+dr768UGsmLRQneVFye9?=
 =?us-ascii?Q?GelJkpb3jp/BoGDrOPYorAjfw6LmZ/MKqRIrtMKTKGsfgczvOMKwa+LFopab?=
 =?us-ascii?Q?BO0sxkQLVikFnC55eLDuj7TTzO9QlIM5Vz7w0uGHnxsQ8ZDC1olnY38Z3IMA?=
 =?us-ascii?Q?MErMu/nGzHDv93/SZ0s6qv070Un6P9q4ZNcR3sYAO15NIuegYXYX29YoqCfa?=
 =?us-ascii?Q?UxHU3Mib+oznWcMUchf0z2J7RoX/n7cmSZlpCy6GSgNuoJvA4Mu5dWZuOqvU?=
 =?us-ascii?Q?T+2m6tLLq02Fx6a9nctEmKuQ07gpz0vKinpmuf+BCkoKfcrxjLuqacL1gTXM?=
 =?us-ascii?Q?jwt5o968YQXoTRdPzFDCFie48hxXnqscrZdh704cxXInAHtFknPPwZCj+THF?=
 =?us-ascii?Q?LZ3lcpyfsHCKNMVRc8oU0ggarP/DhaZbZBCywMrBGR64D6bxKwMLiAOTDggB?=
 =?us-ascii?Q?bdKniLygBWk0NFC6W7SjaXMWbk9y0JCnZ7sFQKi5Rk5X6rIGxkNWxXudPC6I?=
 =?us-ascii?Q?z3La34PcyLUabP6ST8KyMajPLBqXk7ILlzH4jtT6zPAlKw349SK653Plj1fV?=
 =?us-ascii?Q?5QebbVFvrXbbZpynsqKuayxWHhIA6uvemy83WuuhqKb9aKnYg+kzk8bL6Lxc?=
 =?us-ascii?Q?wOTqfQ+NSD+i0w71t1av3xpbvh32WHozf9mTKj9Xk3l+AB+65rpfA2X/QvUy?=
 =?us-ascii?Q?WwHXvr211EFDpKXJ0dtTTdgNyGW3jSZqbFUXbrfQq7/12gce1cvyA4RV5EGx?=
 =?us-ascii?Q?HqSmhAJ6pJmVnVRXSoSPUBweADQuHM+hClN8GL9W8i0hrphegNdtYgfmAgTW?=
 =?us-ascii?Q?sI71GQ7XdTUmyWTYwHEDWJn/3VbCaOcEoatGwobkKsei2py+/qGG5ILCosVC?=
 =?us-ascii?Q?VmZD8n/Xm/GYX6WOeMpp4YndW2uWiC205cn3M4Z8+sK+aY7jiJX8cEZrMqZQ?=
 =?us-ascii?Q?5Bp+8X5kdIUEWZ/uoQqLZLn6qDxKX/pC7KaI0/8a/HL3UPjyRElVH0V47cE7?=
 =?us-ascii?Q?/W0tcWEX8MQPO1LSG5wBYrSQim0RRS3LOsHWssYNd0dN47bKGMS5bVYyN1By?=
 =?us-ascii?Q?8ev8YgRR8INHcDnbcNb5R8SjtE3zQK7MMIHr8R1bG8O9oBEaHzEcv1LREMZk?=
 =?us-ascii?Q?BeOdZbsJCIHg2dBk9kYqpy+WvZCvg7vSgFApD/v+Txn18D2ZwgYYSNNdhn6Q?=
 =?us-ascii?Q?XjuFI+aEV10BGBFT7iNce4XcxbQA+/5F85UcXISg+3sR+4kP/g4bEkKcmxyc?=
 =?us-ascii?Q?jea91x9DDcfPWpU3naEVR+wbrLwrB2Vi7eJf2Ahw6jmlPbG/jWOQe4z7RdkU?=
 =?us-ascii?Q?/4Ws2a7Pyvd+aesf5VE/qnuhZxsBE8xK8TdeI66eMcO1VWS3A1bkyavDQWcO?=
 =?us-ascii?Q?WdkXd6lodhtqq6Bp6dwOJYAyZVpu5c6erCOIdVdNYr5ufn01+Ojgo43DvbHC?=
 =?us-ascii?Q?IpU9rT6JItul6YoJdgxi0ekqupcq9neZqMi4X8iKoXGhCq0ih+R7BNe1ay7K?=
 =?us-ascii?Q?ZonTxzODqNWwU1KT1x28iySKykGPzZy1tszDwLdaJI9iLJBL9WFZfYlHvMTY?=
 =?us-ascii?Q?Dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o6GPuvx5oJMdtl/cQxhHeyPVmM2EIrRb7qvewVKNwnea5aK6E7ZbtY42RiI0?=
 =?us-ascii?Q?HUmHrBWMGRlEQSy73tG3ovHjZ8KZ7Uzzpp4I3OZ82a4F1Vlqr32tMQg5HRzb?=
 =?us-ascii?Q?j+/+F1+EWPEikfsTxdJHl7AbDKBQ7cNjwO2mJeamqVUU8LjAtcu9Hb2tYgrl?=
 =?us-ascii?Q?p85QhHSyG5OCG1IYFWC94l36QRkoTf23S8T5qVPu5X2Qhk0hnBQpoo7d9p3H?=
 =?us-ascii?Q?HICBYUxKgCc93KyWdlpHSE1h7oZ3SNLztFqez4NtUozzSkma5GgA55bpp7DC?=
 =?us-ascii?Q?GbLue5rdyAwy3UVQ96okRWCCxGU7bgEdd3M+oAGWV+ljTo12gL9B+oCBC7rI?=
 =?us-ascii?Q?Ggp7QBgCoNiIvck+twnaargc/lRbszv/pkSrxeYV/aTAZjTxzI22kli/HL6j?=
 =?us-ascii?Q?PBBERVTSFwRV1y4XyRdQlh/yiRSeioO6kza0G45DacwnbltLpwPz9L3H2vCs?=
 =?us-ascii?Q?yIrszGbevWPEjFoL26l0WRC1/EVjzQjmJIrGuM/ltkZRD03/05fTXolJ8O5W?=
 =?us-ascii?Q?6xGo5lQLYInWBFYnzLZlFHRInPJxEpO0yLwprfVM4L1kCxn4QVntkzQzOULQ?=
 =?us-ascii?Q?MyPywatYlBQ5YxVIC3CryVso8sQXc/17jkhG9BolHZG0CCUOm5V+8i8xJr1z?=
 =?us-ascii?Q?Z/0097VGpa/K8BrocSOPXigQNLVjeZMK3LqDTFd3+Kfqbw6bWHkZdYr4zzYf?=
 =?us-ascii?Q?Fyjwl37ovF2Y7QGu2afq6b//ggWX1bDMNQftfvzTdq404WjlJqF39D0ANFWG?=
 =?us-ascii?Q?Glrm3MtI/FtYQLD6RiwXUO+LMqRozYP9wasHiHT9H379S4TbPLkYxa8EUlOH?=
 =?us-ascii?Q?UhgTAXRw74jmeQs4Zj+/pO5EMA+NyONCt9nT+DQ8OGFE0ILNEFL6uCH6r9dA?=
 =?us-ascii?Q?yLU4orzm+lKU9UPu350zwNBUSm3eLrE4dPLJidd+bWX+xPCEAkJcmJ8HP4B6?=
 =?us-ascii?Q?Z3PNEJL5kEMjbRz/QV6Mr6r7to+Fuw5gKqRAxoN+uB/mGACei/nS55KS+v3T?=
 =?us-ascii?Q?9q2Wl06NpSNsk7C66aQHIlVx2whwLunWi7JMmdpuSrY5Xc5Gj6DUZMQh78MR?=
 =?us-ascii?Q?G3zkQCGziWbbWmrHT3G0XWXKWZJcjfXGtWhODSWxkkmuguxut08l+W3Qlwcl?=
 =?us-ascii?Q?Jf8grOIhlMHCDkVfwnWkI8c9al7QEAzlSWiM7RSZCGc+qp9AymUlG7E0FtJJ?=
 =?us-ascii?Q?zt4JGGxFxgm3kaNz1i9M1TcI0SOZXZaA59FjXK6tyndl/vVZw3HwSPY5q/yu?=
 =?us-ascii?Q?Gk2/gWxxXI6kb+7C5M049ANUFQMMEt8tEwdSm+5nFLwjLN3MtGHDECjHWjLm?=
 =?us-ascii?Q?hoXx03bkmTHJhmhRNpy6YRVzybKc0sMhLPW5tow7DgNL5o5HlGs2tu/Pm/3S?=
 =?us-ascii?Q?bWh+xQIUj5JiVTi9v/IPrGYtk9eajBKoCgtD/NTJJHUengF1csUwN6TMJhN7?=
 =?us-ascii?Q?3uP0Va9lvU03Ucv9yUrERylWkTAUsEBda47ScJgltMSkQ6G2ZeOTr1Apw/aQ?=
 =?us-ascii?Q?yjAhbIA3oT+tTQCGjEp8DJm7uv3YN1oH1dtBqDhpTxZvhg+EUg5kJkCKkh0U?=
 =?us-ascii?Q?f/jVV39ZVSY6fow8iwItU/d8wdlpg/BmTfGUUeixaoUg4NB2QqBUb/pDyGw5?=
 =?us-ascii?Q?N1dFavEgBmjj4Wrj7j1BahhZGTS8gNBYGP8pWbKoO0GE/J6y0Wzy8sEN89Fa?=
 =?us-ascii?Q?9+8Z4D0PLHnt3+ZaCNhNaHapUFUBctQCwZ9thLHMVzicvVhf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6b6294-9d22-40da-0d07-08de586f06fd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 21:58:21.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHRgIIzweoyplnjNLOzwt9ZlZk5+NOrzAzwwub0FotLjIUAtzfT8tdqte3k7mdAcXBwm+mmavjYj44ErSCXZwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101

From: Joel Fernandes <joelagnelf@nvidia.com>

Updating "ppos" on error conditions does not make much sense. The pattern
is to return the error code directly without modifying the position, or
modify the position on success and return the number of bytes written.

Since on success, the return value of apply is 0, there is no point in
modifying ppos either. Fix it by removing all this and just returning
error code or number of bytes written on success.

Tested-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 41caa22e0680a..93f009e1076d8 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -345,8 +345,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 	u64 runtime, period;
+	int retval = 0;
 	size_t err;
-	int retval;
 	u64 value;
 
 	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
@@ -380,8 +380,6 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		dl_server_stop(&rq->fair_server);
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
-		if (retval)
-			cnt = retval;
 
 		if (!runtime)
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
@@ -389,6 +387,9 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 
 		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
+
+		if (retval < 0)
+			return retval;
 	}
 
 	*ppos += cnt;
-- 
2.52.0

