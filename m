Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6529BD90;
	Mon, 16 Mar 2026 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700093; cv=fail; b=Zu7xN+irQH1s6XxXUKD4dcz8w5K6pvwd6msRNLGecEfNmsAgnjGs/wyL0AdWqSjS7utkdPO+tV/KopQ3AoMi5qxG9J89XDw6jfKQIIHvJWbM2sTUbM8pcWHH2kTc9Rt80q+YlvE+susMjIWjd8cOxHkd8/7CzUmVd5oz4YGAo4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700093; c=relaxed/simple;
	bh=iYkTQxgr0tQHwWQlUQPV3Jw5akoWHD6Sqg5RlqJH0lU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NIhLScgRfXOwZtWvUzsSMgXC7HyaagizrTCiyOs9h81G+wGm5KX9UYDtrcTAfJezOguTyBwbAv1AczwfIs0I6EXbLlhf2vW/R4t116SEvRudnL2ORtaVFwX72vg9atf5YW60XRPsrUxzFeuDolaAWrPHmrXfXKvHG+9Y10Wgk2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Imjg+ZUP; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Imjg+ZUP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLQf2sh72b/fI9uLI2FDM4VptuLbROctMSqWpC7lEt4Pufivc+egY0r/BYPrxttkDRWU41g+aaBneSJFlBo+cdNKe9vocGPcQ4QRZLtM1Ci+3ditOVa8dl3qC1NTCnuiuP8kF7YX87UKW4NjafuK4roSwZoF6IJWslRL5eBvFaBm8yiGCKlgYLWp3plI6n+2et4iYPZUO65130JQuj29DlzB3kc3pqqkofR90X7v42aQ/fNVEYpq501bpqrLYuiNgvyehmCIsmJ9pY8A3BF/8V1m78nV3ybw1tl44w426Aiek4Y5+FCuT7B9cnk8JjsUP4btqEUnXZZRBc3LflFaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7RKbYzHFfOz75GOUeo74DHypPuRyHvlUw9mh/yGFEc=;
 b=bsqLi2wtCQY0iRXgCKiiAIstsmyGL2tmUIKtYEDofh3WoCjjrvCIWBq3XsrdSdKkzx0J5pwL8Z57T+uBTRCGC+7jqnMFSkhOlsrJr/McvkWuA8wp9rXysjeYN1V9YcwuchgEjmC1kBiSedq5i5qXnApSHnA7pHJQunxDTiMfsrfI/7Gd/oZmchs7R4pjEC4vupPDVzHfJE1EZegj18X2b7xB3guytbfqwhUIMxKKdT4Ttg911zg2Ew6oln3il5npP0BxAmDqHK/WzfG4Lm3JGatWsh03fJX6otPN6a2MQbSghZRMS3jJalQn/ZADq/Fb7BLRlhCE6MBOafTcnv39Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7RKbYzHFfOz75GOUeo74DHypPuRyHvlUw9mh/yGFEc=;
 b=Imjg+ZUPU5fPI8I5ih2mQjh8cRNsPGcY9UXrvRi01mKPwAMRr4cvKMW6D1a6OIYqxn3sRZfOKKcVeDawAEi7Xmp0uwi6FyS9UCw+7NuxdF5KitPVhnf34OQwWCtyTBX8/MMHmpxY4rPm9YlxMJIT4Ue2n/0gHD9e06+r4jWTPjFygI2iwtx9hY+6/MetzpNC6ntKArngAonPJst5+WctrXzuWeAvZYVEECOKoePAj7PPAzRQrT+8TpNF6DRm5mDk7MN+16r/A1QjVLA1pdwQ5wYVvV/sEdRvmYurWu8T9DjidSktGKgXqFkSiS9Wsz7WFiirK57uoVb/MhoPJ9vHaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 22:28:08 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9700.009; Mon, 16 Mar 2026
 22:28:08 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Always defer local storage free
Date: Mon, 16 Mar 2026 23:27:58 +0100
Message-ID: <20260316222758.1558463-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecc2b56-83ba-4b2a-bfbf-08de83ab4ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H4kDkaHj3TAREHxOAD0W7EQ076Cf5hN6RDBi4wLk5X8Ukyb0P184U2VHKPGSR+UDv/rTm5Xl/uwUl07bJ1UNgEG3lkvYnQykmM1kbKSv4gNzC6M3yLIZOcHiRnwd86bFlxq3NA/07x0uKUvBCX8I35bw0wZksRzeOI1eLMq5G75IBIgw/Ai8gXvKpTCLRH+IVNllFBR0pgjUGFs2MPRlsnyVPMP95nzwAmH7wO+eoyUIkIFZFnEmRBC7Dv+xsAZZBJ9p4jqqkjG9+fN6R/jyFtDspyzbKDUr5vpBKn4toB5AJ2TRD+QPQY50K/RzU3p/RmNgFiEUt7PDbGAXe9PuK5xWK1EKT8fqJKmAZsEbMS7Pm1mM6yWScWL9vzo+dw4dw+S4D8hvyhtIZ99SKi01tHGy8F0FuQWoP5VyWwN0REt8QGwY+mj99HhHwcTcvukXSYxkVOtWWpz1qpnAxEWGR54/P8fO7Ks+DlXe2I21rCMMXZFl5amgBscqxQ0wwjcGhpfmnxJhVUXuMf0eElJtCbPa4eMZ1KEh7LTBI6VDgC34IpG0r6jqKFCkSBhz5x9RzQj1p9aJ25UWmH0YA0ceAjTorUojEg8/S50JPgd0bcEXFsf26llYCDxCUX7VFS6Adv0icVpiboGmtWkrT7NErj8MdcUt8niRgsBsG3TLc6xSjp9nXv/UfqiJvJdMXqdIv+Ps2vph6eI5I6eEXu7iDYB03Bdcv/y/lzTGSUNa4iY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AkIWw0xeXqwgUhC6wP9YKwnP6O2s5Isnb8j+yHiplRhYSdu8YyBUjzkPN3QG?=
 =?us-ascii?Q?QfKscrPSsUghGWPDOTDUiNSFZYmwSzdjwmFEBtJe265ZXOAqTdOT6faPIQ4P?=
 =?us-ascii?Q?aa7buKvEkTabsBdBiRL9Zaz7835wZLhgAuK8pJGMTOKp3Y87C6yEzGMTBDcl?=
 =?us-ascii?Q?o+r5s49GNKWz7NA04jqm18NoIEln1Edl6xmwJZW0pwpDeolozpcZHw5GldLX?=
 =?us-ascii?Q?7e/1yE0CGLWB9AGGb3JXXv/2sIaIgNabTIV36mtdnsD32T58GbupllSMD7Pp?=
 =?us-ascii?Q?IhXpb4WkkonrFxEu5brXc7jKI1pQn7BudF662o9kK68VaNgvH+GbwUgsT/Uo?=
 =?us-ascii?Q?VOLKsi85V1ffk55A0US1l/l67GbikU3Wa0opn7gSEsSlQ6UxavBTejCJADfe?=
 =?us-ascii?Q?d9r2/KRRG3zOzAeYl7gLIg7VV4VFxW7Jhv9dDqmXlxUsRHqV3ljAc9mGhNZ+?=
 =?us-ascii?Q?Hk/hcOQgGJJLDHETaORiNnV0hq8d5Df76eZIPJGtDkZHG9yTw/Qnn7x1amcJ?=
 =?us-ascii?Q?SJqFJlqwEEO71VaXwO4OlHCnVb7L9fKz7kJikH0SRk1sikdGQr8GtEaQ4lRl?=
 =?us-ascii?Q?dkR4MiudXCr7yfzBBhIhMbyuGB0stVedJFpdZSxlu6cI4ASC67YrEbHuivYK?=
 =?us-ascii?Q?X2fzi3Se6C4S102CGd+ABBcy7iHqwZFaqPzERsdJe0s0bxru5gQ9GvcTAAgU?=
 =?us-ascii?Q?spK98V2haZcK3FW1eqKR9znc8Z2kpHC+DN9jR0hJ9oSkxeFF9rr8cdx24uHt?=
 =?us-ascii?Q?kCV6X5dIOGvCBhFJNK3pAT+I30s/OOdtDo4VvSm8oGtTETlD42vsG9PHd+Ti?=
 =?us-ascii?Q?I8VaIvxOzBjJL/7H62aTxHH4mJ4XQPVlkxREO8adqkys5/45KwPJ2ZhKw1K4?=
 =?us-ascii?Q?/TvUlhr3e8wFh8qmILslGcGuWEHTcaONWL7JtZQnEZWyKjrVzYOMX9oo1hMa?=
 =?us-ascii?Q?TuvsJWDhojgQzLkKVnjdul5ou+mg5gJl28hsDpl69g2MtNsFpgyI9tFQHZKh?=
 =?us-ascii?Q?pV2PEm0Q4l+KQqKGR5IiDWJU/GmqQpdOYkNA0M2r4iKuTx9EZAtb/52hDsLh?=
 =?us-ascii?Q?GaGcWlQJcE/q3/cDR6D9rWg/FJheroTvbhFpWAMRR15YnKlsYGMNH6LSwMWe?=
 =?us-ascii?Q?dpf1Zm+5dyR8brUFh+3LNxnXAa4cxccEwMYU15dJxLFyswlE9Yk1ak2c1EiJ?=
 =?us-ascii?Q?9mBKNjyCco4gA2YtfXlePHxrjfG/AVR7Am9PI+pt552yf3fRoWQoA03VjfkE?=
 =?us-ascii?Q?JDOhdNjdb4yLxXcrEmBUPcyGtfTqSf+41QswfwVRDT1lZ32M4wgW0uxVPS4c?=
 =?us-ascii?Q?5AtBTOTWH+clohBMnINDWdje6X9NJ6FaGlV86Z/MzeWr5HU6ioUdaTWSFcks?=
 =?us-ascii?Q?2S+Wi9x1QJ3kQsZc6fCSWuYr1qklmRfW+HXz0X+JkrLdMp5o0rsW2x8PEQoW?=
 =?us-ascii?Q?thhxh+q6mv+oX1CSMaTZJTCNHryFB5mDfwuJFn8ouzT4fSST6o7/3IJLmx59?=
 =?us-ascii?Q?T2stygNKBuvt/Kjiz+fs+QWi9uKrTxcSk5brQHun7h9hDmkGzmYuPABFkbzb?=
 =?us-ascii?Q?ep51V2ifx/tkYP5XnKPXsqDkD3en80pCKMTgEEBt+mYreNtwuqz10z21awWk?=
 =?us-ascii?Q?6MLlKdco6TK74pUDZ1uuNWqyOoCeENjY4NjzDiaeG8fvQJ+FptEsI62Uy3bm?=
 =?us-ascii?Q?A1uBA8YgJ13neAi7EzqT6yYcS1uVUPWqnBZatavZveOQvB6lY3iAvVslQSvQ?=
 =?us-ascii?Q?Ma87HcLtsA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecc2b56-83ba-4b2a-bfbf-08de83ab4ca9
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 22:28:08.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F23qrfXyvqXpq+rjDza/kUyCeFj8IPm/vBDa/YoHeACNx9FB/Act9qgZMZVDABUJzR5QNXy6eqeBoviYm7NaqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177

bpf_task_storage_delete() can be invoked from contexts that hold a raw
spinlock, such as sched_ext's ops.exit_task() callback, that is running
with the rq lock held.

The delete path eventually calls bpf_selem_unlink(), which frees the
element via bpf_selem_free_list() -> bpf_selem_free(). For task storage
with use_kmalloc_nolock, call_rcu_tasks_trace() is used, which is not
safe from raw spinlock context, triggering the following:

 =============================
 [ BUG: Invalid wait context ]
 7.0.0-rc1-virtme #1 Not tainted
 -----------------------------
 (udev-worker)/115 is trying to lock:
 ffffffffa6970dd0 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{3:3}, at: spin_lock_irqsave_ssp_contention+0x54/0x90
 other info that might help us debug this:
 context-{5:5}
 3 locks held by (udev-worker)/115:
  #0: ffff8e16c634ce58 (&p->pi_lock){-.-.}-{2:2}, at: _task_rq_lock+0x2c/0x100
  #1: ffff8e16fbdbdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
  #2: ffffffffa6971b60 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x64/0x110
 ...
 Sched_ext: cosmos_1.0.7_g780e898fc_dirty_x86_64_unknown_linux_gnu (enabled+all), task: runnable_at=-2ms
 Call Trace:
  dump_stack_lvl+0x6f/0xb0
  __lock_acquire+0xf86/0x1de0
  lock_acquire+0xcf/0x310
  _raw_spin_lock_irqsave+0x39/0x60
  spin_lock_irqsave_ssp_contention+0x54/0x90
  srcu_gp_start_if_needed+0x2a7/0x490
  bpf_selem_unlink+0x24b/0x590
  bpf_task_storage_delete+0x3a/0x90
  bpf_prog_3b623b4be76cfb86_scx_pmu_task_fini+0x26/0x2a
  bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
  bpf__sched_ext_ops_exit_task+0x4b/0xa7
  __scx_disable_and_exit_task+0x10a/0x200
  scx_disable_and_exit_task+0xe/0x60

Fix by deferring memory deallocation to ensure it occurs outside the raw
spinlock context.

Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/bpf_local_storage.h |  1 +
 kernel/bpf/bpf_local_storage.c    | 96 +++++++++++++++++++++++++++++--
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 8157e8da61d40..7e348a5c6b85d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -105,6 +105,7 @@ struct bpf_local_storage {
 	u64 mem_charge;		/* Copy of mem charged to owner. Protected by "lock" */
 	refcount_t owner_refcnt;/* Used to pin owner when map_free is uncharging */
 	bool use_kmalloc_nolock;
+	struct hlist_node deferred_free_node; /* Used for deferred free */
 };
 
 /* U16_MAX is much more than enough for sk local storage
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 9c96a4477f81a..0fbf6029e1361 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -14,9 +14,26 @@
 #include <linux/rcupdate.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/workqueue.h>
 
 #define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
 
+static DEFINE_PER_CPU(struct hlist_head, bpf_deferred_selem_free_list);
+static DEFINE_PER_CPU(struct hlist_head, bpf_deferred_storage_free_list);
+static DEFINE_PER_CPU(atomic_t, bpf_deferred_free_pending);
+
+struct bpf_deferred_free_rcu {
+	struct rcu_head rcu;
+	int cpu;
+};
+static DEFINE_PER_CPU(struct bpf_deferred_free_rcu, bpf_deferred_free_rcu);
+
+struct bpf_deferred_free_work {
+	struct work_struct work;
+	int cpu;
+};
+static DEFINE_PER_CPU(struct bpf_deferred_free_work, bpf_deferred_free_work);
+
 static struct bpf_local_storage_map_bucket *
 select_bucket(struct bpf_local_storage_map *smap,
 	      struct bpf_local_storage *local_storage)
@@ -260,6 +277,80 @@ static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 		bpf_selem_free(selem, reuse_now);
 }
 
+static void bpf_deferred_free_work_fn(struct work_struct *work)
+{
+	struct bpf_deferred_free_work *deferred_work =
+			container_of(work, struct bpf_deferred_free_work, work);
+	int cpu = deferred_work->cpu;
+	struct hlist_head *selem_list = per_cpu_ptr(&bpf_deferred_selem_free_list, cpu);
+	struct hlist_head *storage_list = per_cpu_ptr(&bpf_deferred_storage_free_list, cpu);
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *local_storage;
+	struct hlist_node *n;
+
+	atomic_set(per_cpu_ptr(&bpf_deferred_free_pending, cpu), 0);
+
+	hlist_for_each_entry_safe(selem, n, selem_list, free_node) {
+		hlist_del_init(&selem->free_node);
+		bpf_selem_free(selem, true);
+	}
+
+	hlist_for_each_entry_safe(local_storage, n, storage_list, deferred_free_node) {
+		hlist_del_init(&local_storage->deferred_free_node);
+		bpf_local_storage_free(local_storage, true);
+	}
+}
+
+static void bpf_deferred_free_rcu_callback(struct rcu_head *rcu)
+{
+	struct bpf_deferred_free_rcu *deferred =
+			container_of(rcu, struct bpf_deferred_free_rcu, rcu);
+	int cpu = deferred->cpu;
+	struct bpf_deferred_free_work *work = per_cpu_ptr(&bpf_deferred_free_work, cpu);
+
+	work->cpu = cpu;
+	queue_work_on(cpu, system_wq, &work->work);
+}
+
+static void bpf_selem_unlink_defer_free(struct hlist_head *selem_free_list,
+					struct bpf_local_storage *local_storage,
+					bool free_local_storage)
+{
+	struct bpf_local_storage_elem *s;
+	struct hlist_node *n;
+	struct hlist_head *deferred_selem = this_cpu_ptr(&bpf_deferred_selem_free_list);
+	struct hlist_head *deferred_storage = this_cpu_ptr(&bpf_deferred_storage_free_list);
+	struct bpf_deferred_free_rcu *deferred_rcu = this_cpu_ptr(&bpf_deferred_free_rcu);
+
+	hlist_for_each_entry_safe(s, n, selem_free_list, free_node) {
+		hlist_del(&s->free_node);
+		hlist_add_head(&s->free_node, deferred_selem);
+	}
+
+	if (free_local_storage)
+		hlist_add_head(&local_storage->deferred_free_node, deferred_storage);
+
+	if (atomic_cmpxchg(this_cpu_ptr(&bpf_deferred_free_pending), 0, 1) == 0) {
+		deferred_rcu->cpu = smp_processor_id();
+		call_rcu(&deferred_rcu->rcu, bpf_deferred_free_rcu_callback);
+	}
+}
+
+static int __init bpf_local_storage_deferred_free_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		INIT_HLIST_HEAD(per_cpu_ptr(&bpf_deferred_selem_free_list, cpu));
+		INIT_HLIST_HEAD(per_cpu_ptr(&bpf_deferred_storage_free_list, cpu));
+		atomic_set(per_cpu_ptr(&bpf_deferred_free_pending, cpu), 0);
+		INIT_WORK(&per_cpu(bpf_deferred_free_work, cpu).work,
+			  bpf_deferred_free_work_fn);
+	}
+	return 0;
+}
+subsys_initcall(bpf_local_storage_deferred_free_init);
+
 static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *selem,
 						 struct bpf_local_storage_map *smap,
 						 struct bpf_local_storage *local_storage,
@@ -419,10 +510,7 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 out:
 	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	bpf_selem_free_list(&selem_free_list, false);
-
-	if (free_local_storage)
-		bpf_local_storage_free(local_storage, false);
+	bpf_selem_unlink_defer_free(&selem_free_list, local_storage, free_local_storage);
 
 	return err;
 }
-- 
2.53.0

