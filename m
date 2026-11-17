Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911463;
	b=zeeX8eKX5CCcpxHApDSVyMq+14wkECwLOV05KjxeSrJ9AmolQk/lk2gmtyPqu1opLzkA
	 LuwHQPT2aRvnRU8oLGVfDx6FvYies8DT43FXK140/3oJ71eQ4I4hniYBI71tBrqjW8YbI
	 lNZc/dLGNNBSkb7etqFctrcNBbDBpJu+sv7uilzfQGXxE70dCP7fHYQrg7r2E/uuj3bi/
	 Wbi0IWAOqgsH3J21iQychadLrOl3oV/zdd676S0E3IniBV6TSHj7usvoAFuQV143yqZf7
	 NJH9l86On44HXmlWriGS1VOEOceKTyRolvNB49jVSInxwt3JMbZfSwwYNMrffDOVAww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911463;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RbuUQ/q5+Ci5j7ofk/zbFxif3MkE1CpANG4IjEGPf2s=;
	b=L33E0XY86HUxLybUbcJsc878972iuHp0p+cKXLdPSJ2X7jbZnE8zeOUyHcoiRq/wtL0z
	 d6dmq8Qy4ivTmtviaF45nAlgg/n+8jtSFi2jkmKxAozQuwSL8AD6QpcQwBUVmYrTjniPA
	 ugEb4VfqHmWStML89yDaDYl/aZESxdFLQkMNWTtos19h+iML0Tff8HOlS35+YKz7qugLJ
	 aAr+4M9Qw4y0MyfZXkxXGVSxW9CaYSGQWL600or5i5aLmQGDrxH2scY580+RYgYXqcbAA
	 vMMfJLJQKx40A2Yc4oIspaNK+gcnaNgO8gOi56m9W62VtJfnVNSAmvFQvoJM0HDokKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f19CQM1g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.69
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE1606A323;
	Tue, 17 Nov 2026 10:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CAE1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f19CQM1g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMgMs3m8rg9fIEPYB84Ngw1FCWNvB6v/rY9qByGqRUdujHXIPdR1gKAouhw+ZcBZBGwGFY9PEB/QU0wpIQssDU6XWedsQ3X4+lDqsBpHe8b8MzCLjhEdJl2MWw2jWFeZ3KhZm1dxyI7eSC5tqeQ+pKYMRRdOL9NewLY14y8JCyh74Ggl7qdqgiU1h7/8mzVRqwT1ShZRRuPeqNXVxU1UUCfeuiAYMM8iPsnv3wEcNyvywHp2fWOrLuvCrWdlz+McfU3pMPZyUNnFGnznwbeeHst9D8J/xQIVZT1GgcidJLo3k5zARUO8YjOrEX/HIFKeBPrRE1UrzNtke4T8fQwwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbuUQ/q5+Ci5j7ofk/zbFxif3MkE1CpANG4IjEGPf2s=;
 b=w/DL849xTyy/11JKNDAuqRA+UkQHE67jLVmLozMRZjogCLWoZjxFlVPjv+H8BxHgqsrjOShNpTEQ5IQeFK31WteHR21vzTfzbE1z3AKtXxYP+ZrrKWnBZrn2tO+lusWDo6wIBAqlhsRC/FW/ANa0mW8WH1TkbvPlt4GpUw559qPB5FnQDHmY+zkZud3MbSmr+yeZSOLcj1MAiFPpk/FoaKi9sQcZ3atmCQKfsfCrZTI3Mhp8qVUs6P6SObjX2oyLrW3981h1hppNGIWpCkdW5Aj7lGLnUkJFLr16BFclZTyi5vBwG1kvOfKKux51i0rSH4g7KF0nUJUq79MbQrH2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbuUQ/q5+Ci5j7ofk/zbFxif3MkE1CpANG4IjEGPf2s=;
 b=f19CQM1gT3xTEi8qx8BiIOQk0U04TLruG/98BBe/daLxuxHKSaC3QhkWxJT3xQFpfjMLLNOdGJiaccxFuRkNGqGQ/SNKvsN+LQ/7HQUTE8rAdeXEigxUUrOmAxTZ7YfAY/2mIFrPlqP+DdKSW2eFXd+UOwEE5TO3tryS6PoFtdxOV8c5QEgNjB3/KEMVDO+f2eRm2Z0igsZu4LaE4PS4dS78M+m9uJZNcsQMncebz9zRdWLFQjwwtbQOCdxkKpZ2pVY9j7Iq22sg4oJvZ4Z2soqBSN4tuRzyQoUsvqb9xp9rbKyCN2ASrqn1ockpif+Cvp2EU/DEyyyTIGuRa3Cp+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:30:56 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 10:30:56 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Josh Don <joshdon@google.com>,
	Vineeth Pillai <vineethrp@google.com>,
	Peilin Ye <yepeilin@google.com>,
	Zhi Wang <zhiw@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>,
	NchangRoy <royfru44@gmail.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] bpf: Allow importing device-dax pages into an arena
Date: Tue, 17 Nov 2026 11:28:07 +0100
Message-ID: <20261117103028.4105609-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117103028.4105609-1-arighi@nvidia.com>
References: <20261117103028.4105609-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:806:121::19) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: a05442ac-376a-4b1e-8835-08df4495dd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|11063799006|56012099006|261026140227099003|261021121427099003|261026121527099003|261021123027099003|261022115727099003|261022105027099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1ITl5tUT39fpHNpBs8Ot+kpfqcP5I6mPrPOvKxqxwdo46JVZiXU4RxzyXfOl5LlMUm5hzlbD0qaziv4pN/c9Od5PPmK1FfGhrn3CR7HUcQK9wOpmkjNbR1kRadCAxXpFg2iKVKPX7JrPXLyluwb+uVPNgWm8N9GuwyguQZCfisJeR6v0G9RLaWyaZ9O3kqLKwRfZuvAbu3lNSnZq8DN4C6/xE862u/Qog9omeZUaDQhyKKE3bKzfE3FljJ0In0kOqxMGpavCPHHWjrO5BvkrUUlf7c1U5QUub1/peK8YzNndNuyjOfWZ9M2fr67oju69lq2/zyglvKo7goNwQI4ym+juXN9JbO36t8hf5HxGnqKXbIra/xTCLTJ3LJIyHUjUOICtuCoGtGF1kmClzUJbdnRMoJJdX6cJ5XdjyVyN+3MaTgZ4wCnWxdj9bStBuKEOq/aQdF/pI5jxG5qam2GtJI8/ss47P0IbG/H7GicOwYmdslMWii73T/AkPhCc8esHWYKlFFkVRB7fg3WFOI6ank3+8eJC6LJEPzRq4VfVxnmbTHKuD3hmH4kGyomqjRF/6WXS8kR9rireCoXcURxhH3HlXhapCJu2LRIEakd/n5fWAxXKjqK58/1zGieP9R5oTQdM2kDff1sfrLYAuoQoRqLaDvVmCxque6y1xda54hU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261026121527099003)(261021123027099003)(261022115727099003)(261022105027099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E2YbFZqyfipMw2nRa4r1L/RBg2dAe4NSdqoY0R5IZnANsT5QSxd4YDJkDB0q?=
 =?us-ascii?Q?An5RiNFdy72SXZyZTHaYpGmVbDlglCWpAaG0oJK9wKs/6kf6xAjTBLLpKojR?=
 =?us-ascii?Q?LEAH7BvFmLzPfhuWd8ow0K3m+Dlwq21XMtzU0dwb5Sj8iew6pNuJ9nwGTKSM?=
 =?us-ascii?Q?3gH0AciijTe6xyFuLOlxyjV28EGsjtzf62lr7AR1IsHR4ZF0uWJb1AHWPVVo?=
 =?us-ascii?Q?Rl02CTOPeFncZa8MPnwEMMu04MVheq4I8seB9SyT7lS9M1zBBslabDqE/1+8?=
 =?us-ascii?Q?QzDJhoUmOcLRD844CHgiRediKeK7UL3whhxUziYabe+YEhQQVUx0NIgteHwc?=
 =?us-ascii?Q?GXMsumD3N2Vy0u1gLIbl/2/NjiL7YmGBG0Zd7e8S4+4kRqRypgFeLrAlRlNS?=
 =?us-ascii?Q?A3fL8x1twnOf7yTYAJvq17mC9H/qUtGWxnCqw6bE2fOjDf+5vhu27c6D223Y?=
 =?us-ascii?Q?UCGVKfCuUt91iwdZlGTu/+g8S5uRSCgGRuNviVR1SUMp/dOYRGGhcxQTwg2Q?=
 =?us-ascii?Q?/SERSU22CBteOKSdWs7KrFJQJyoJBeYZyrsCC8MqrbED3+xVxNq/16xAZwsg?=
 =?us-ascii?Q?v/aai+kljw8Kh6NY5uFskhpd9cMKK9ZinA8QIrpj+HJCprjpebkOboUlZQ9d?=
 =?us-ascii?Q?+7raorW5KS4uakHHMiefuadOA/6J884dp0tAHkGdajQBgYE5xn4HpykEIfHy?=
 =?us-ascii?Q?9rxricDQhqVV5JaqYAF6wNXxaze/Gv7BaycMUXFxTUz8xmS0HR+fbWuY6SiV?=
 =?us-ascii?Q?x85SB+IV2tRv5KenF1FrTuG1kDUdm2jyJHib6M0u5E4KhOVvPvflSoL2CGPb?=
 =?us-ascii?Q?x2cA7Jo7enbhbHwZhuAMJFFpemO5vS3GrwYCO/xitYEDrZBEH6L9cERnA/6R?=
 =?us-ascii?Q?Joki2QcxY5cHHS7em4ftB127J50z7nudbz6mTPAAjmJ7UzdEtt2qvnNfj8KK?=
 =?us-ascii?Q?MQivwAolxyf4Q0pLDtrUxC3k+pZiCI94+4N/R7i7BTFKTrk9ixr3GLnogjdF?=
 =?us-ascii?Q?keKAaJEwrJG2wLTm73/J16XlziP0jXxSoKKwKZJj4N0xUMXPTZq/6THC5Vrd?=
 =?us-ascii?Q?rZUoTHgabmZF/4Icvxg/0+VEXDXIEiml4tradkjfAnMDlxEnpu/+S4E2kdHe?=
 =?us-ascii?Q?VvVARndFJe12A32wZ1cUW6dOJm2kpFYsdSrTLSJkIYnjOjcgA9ukfY1GTNBq?=
 =?us-ascii?Q?ifoTRMeEA/GDJguwdsH92Dh8Vg/oxIsJHONpYWQPMx24MuWD8sPyX8jAtzHn?=
 =?us-ascii?Q?HiTEoYqPj5dsVo4SUINR5du2e6R5oQG3gqgob3tNYexY8L9CaCTH+WxM4Cwx?=
 =?us-ascii?Q?zQiEXlHivLtr1M3hqZ++kygD3WejsmgdoU1S863THfkO1yj+8PmP/sZPnih3?=
 =?us-ascii?Q?N+OTLOlkD8NR76sy9iRIIg8/tVmCRfoDwMd9muQjmPezVzbQQVzZzYM/DRmB?=
 =?us-ascii?Q?g+oufIbtVsJF26w8XdljsMRA/4nAqxQTbQR11nFJcvJSBpO39SxuU2l461sp?=
 =?us-ascii?Q?QTsN8629evnjpVUIWBiz7SatvEsmuh8CqN1hQ8ZboNXFlPsFhvjWmxpXbILt?=
 =?us-ascii?Q?Hxq+fkEmMREFCxz7hUBYs4QabTMkiB5IZdNUWOsBkhHY3lWp48z7GlZ+Ak/q?=
 =?us-ascii?Q?kFa7UKiCeWOwA34BRaS20X8zj3CA4fADHVyZqMXDrXbIzT6pQNy/eSI4b8CZ?=
 =?us-ascii?Q?gG9LVfRYb6nNdUD42AzJR3fcnjl9tCJKZ74O2fCesem8uxy9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05442ac-376a-4b1e-8835-08df4495dd28
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:30:56.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7O2bc9OyyrxBt4+aiFKhREe7P/Yo6PD3tJ1jFlyCFe1UhT5+dtWVYHONLc5GWOzeY9TNnZTgRZYcgJDTj5Sbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351

bpf_arena_import_memfd() covers the host side of a host/guest shared
arena: the host imports a memfd and hands the same file to the VMM. The
guest has no such file. The host memory can be exposed to the guest as
a virtio-pmem or NVDIMM device, which the guest turns into a device-dax
device, /dev/daxX.Y.

Add a sleepable kfunc for syscall programs that imports the device-dax
pages mapped at an address of the calling task:

  int bpf_arena_import_dax(void *map, void __arena *addr,
                           u32 page_cnt, u64 src);

The pages are pinned with pin_user_pages(FOLL_LONGTERM) and mapped like
memfd imports. Only a device-dax mapping is accepted, checked under
mmap_lock together with the pin.

A pin doesn't keep the dev_pagemap of device pages alive, so the import
holds a reference on it until the pages are released: unbinding the
device waits until then. Until the reference is held, an unbind could
free the memmap of the pinned pages, so mem_hotplug_lock is held from
the pin until then.

So removing the device waits for the arena: an unbind blocks until the
pages are freed or the arena is destroyed. Revoking the pages instead
would need a notification from the dax core and a way to tell the BPF
programs that their shared memory is gone, rather than remapping it
under them.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/bpf/arena.c | 137 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 129 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 799a8cf1ee728..8635bba7907ac 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -7,7 +7,10 @@
 #include <linux/file.h>
 #include <linux/interval_tree_generic.h>
 #include <linux/irq_work.h>
+#include <linux/magic.h>
 #include <linux/memfd.h>
+#include <linux/memory_hotplug.h>
+#include <linux/memremap.h>
 #include "linux/filter.h"
 #include <linux/llist.h>
 #include <linux/mman.h>
@@ -130,7 +133,9 @@ struct arena_import {
 	/* on a list while being released */
 	struct list_head head;
 	struct page **pages;
-	/* the file, with write access on its inode */
+	/* device pages: one reference keeps them all, NULL otherwise */
+	struct dev_pagemap *pgmap;
+	/* file pages: the file, with write access on its inode, NULL otherwise */
 	struct file *file;
 	long pgoff;
 	long page_cnt;
@@ -396,8 +401,12 @@ static void arena_release_import(struct arena_import *imp)
 {
 	/* BPF programs write through the kernel mapping, which doesn't track dirty */
 	unpin_user_pages_dirty_lock(imp->pages, imp->page_cnt, true);
-	put_write_access(file_inode(imp->file));
-	fput(imp->file);
+	/* After the pins: the memmap of device pages goes away with it */
+	put_dev_pagemap(imp->pgmap);
+	if (imp->file) {
+		put_write_access(file_inode(imp->file));
+		fput(imp->file);
+	}
 	kvfree(imp->pages);
 	kfree(imp);
 }
@@ -1392,11 +1401,11 @@ static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt
 
 /*
  * Map @page_cnt pages that the arena didn't allocate at @uaddr, which must be
- * free. On success the arena keeps @pages, their pins and the write access on
- * @file until it releases them, see struct arena_import.
+ * free. On success the arena keeps @pages, their pins, @pgmap and the write
+ * access on @file until it releases them, see struct arena_import.
  */
 static int arena_map_ext_pages(struct bpf_arena *arena, long uaddr, struct page **pages,
-			       long page_cnt, struct file *file)
+			       long page_cnt, struct dev_pagemap *pgmap, struct file *file)
 {
 	/* The first mmap() may be setting the user range: a non-zero start is final */
 	u64 user_vm_start = READ_ONCE(arena->user_vm_start);
@@ -1421,6 +1430,7 @@ static int arena_map_ext_pages(struct bpf_arena *arena, long uaddr, struct page
 	if (!imp)
 		return -ENOMEM;
 	imp->pages = pages;
+	imp->pgmap = pgmap;
 	imp->file = file;
 	imp->pgoff = pgoff;
 	imp->page_cnt = page_cnt;
@@ -1438,7 +1448,8 @@ static int arena_map_ext_pages(struct bpf_arena *arena, long uaddr, struct page
 		WARN_ON_ONCE(apply_to_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 						 apply_range_set_cb, &data));
 		flush_vmap_cache(kaddr, page_cnt << PAGE_SHIFT);
-		get_file(file);
+		if (file)
+			get_file(file);
 		arena_import_it_insert(imp, &arena->imports);
 	}
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
@@ -1513,7 +1524,8 @@ static int arena_import_file(struct bpf_arena *arena, long uaddr, u32 page_cnt,
 		}
 	}
 
-	ret = cnt == page_cnt ? arena_map_ext_pages(arena, uaddr, pages, page_cnt, file) : -EINVAL;
+	ret = cnt == page_cnt ? arena_map_ext_pages(arena, uaddr, pages, page_cnt, NULL, file) :
+	      -EINVAL;
 out:
 	if (ret) {
 		unpin_user_pages(pages, cnt);
@@ -1544,6 +1556,82 @@ static int arena_import_memfd(struct bpf_arena *arena, long uaddr, u32 page_cnt,
 	return arena_import_file(arena, uaddr, page_cnt, fd_file(f), off);
 }
 
+/*
+ * A device-dax file maps the inode of its dax_device, which lives on the dax
+ * pseudo filesystem, whatever CONFIG_FS_DAX says (S_DAX is 0 without it).
+ */
+static bool vma_is_devdax(struct vm_area_struct *vma)
+{
+	struct file *file = vma->vm_file;
+
+	return file && file->f_mapping->host->i_sb->s_magic == DAXFS_MAGIC;
+}
+
+/*
+ * Import the device-dax pages mapped at [src, src + page_cnt * PAGE_SIZE) in
+ * the calling task. Only device-dax is accepted: other drivers hand out
+ * MEMORY_DEVICE_GENERIC pages too (e.g. Xen grants).
+ */
+static int arena_import_dax(struct bpf_arena *arena, long uaddr, u32 page_cnt, u64 src)
+{
+	struct mm_struct *mm = current->mm;
+	struct dev_pagemap *pgmap = NULL;
+	struct vm_area_struct *vma;
+	long i, pinned = 0;
+	struct page **pages;
+	int ret = -EINVAL;
+
+	/* A sleepable callback, like a bpf_wq one, may run without an address space */
+	if (!mm || (src & ~PAGE_MASK))
+		return -EINVAL;
+
+	pages = kvmalloc_array(page_cnt, sizeof(*pages), GFP_KERNEL_ACCOUNT);
+	if (!pages)
+		return -ENOMEM;
+
+	/*
+	 * A pin doesn't keep the memmap of device pages: an unbind can free it
+	 * until a dev_pagemap reference is held, but only under mem_hotplug_lock,
+	 * which nests outside of mmap_lock
+	 */
+	get_online_mems();
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, src);
+	if (!vma || !vma_is_devdax(vma) ||
+	    ((unsigned long)page_cnt << PAGE_SHIFT) > vma->vm_end - src)
+		goto out_unlock;
+	pinned = pin_user_pages(src, page_cnt, FOLL_WRITE | FOLL_LONGTERM, pages);
+	if (pinned < 0)
+		ret = pinned;
+	else if (pinned == page_cnt && is_zone_device_page(pages[0]))
+		pgmap = get_dev_pagemap(page_to_pfn(pages[0]));
+	if (pgmap && pgmap->type == MEMORY_DEVICE_GENERIC) {
+		ret = 0;
+		/* All of the pages are on the device of the mapping */
+		for (i = 1; i < pinned; i++)
+			if (!is_zone_device_page(pages[i]) || page_pgmap(pages[i]) != pgmap)
+				ret = -EINVAL;
+	}
+	/* Still under the lock: there may be no dev_pagemap reference */
+	if (ret && pinned > 0) {
+		unpin_user_pages(pages, pinned);
+		pinned = 0;
+	}
+out_unlock:
+	mmap_read_unlock(mm);
+	put_online_mems();
+
+	if (!ret)
+		ret = arena_map_ext_pages(arena, uaddr, pages, page_cnt, pgmap, NULL);
+	if (ret) {
+		if (pinned > 0)
+			unpin_user_pages(pages, pinned);
+		put_dev_pagemap(pgmap);
+		kvfree(pages);
+	}
+	return ret;
+}
+
 static void arena_free_worker(struct work_struct *work)
 {
 	struct bpf_arena *arena = container_of(work, struct bpf_arena, free_work);
@@ -1677,6 +1765,38 @@ __bpf_kfunc int bpf_arena_import_memfd(void *p__map, void *addr__ign, u32 page_c
 		return -EINVAL;
 	return arena_import_memfd(arena, (long)addr__ign, page_cnt, fd, off);
 }
+
+/**
+ * bpf_arena_import_dax - map device-dax pages of the calling task into an arena
+ * @p__map: the arena
+ * @addr__ign: page-aligned arena address where the pages are mapped
+ * @page_cnt: number of pages to import
+ * @src: page-aligned address of a writable device-dax mapping in the calling task
+ *
+ * Pin the pages backing @src and map them at @addr__ign, like
+ * bpf_arena_import_memfd() does with the pages of a file. The whole range must
+ * be in one mapping of a device-dax device, e.g. the /dev/daxX.Y that a guest
+ * gets from a virtio-pmem or NVDIMM device backed by host memory, which the
+ * host imports by file. User space keeps accessing the pages through @src.
+ *
+ * Imported pages keep the device in use: unbinding or removing it blocks until
+ * the arena releases them, for as long as a map fd or a bpffs pin keeps the
+ * arena alive.
+ *
+ * BPF programs have no machine check recovery: on a real NVDIMM, the supplier
+ * has to keep bad pages out of the arena.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+__bpf_kfunc int bpf_arena_import_dax(void *p__map, void *addr__ign, u32 page_cnt, u64 src)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || page_cnt > map->max_entries)
+		return -EINVAL;
+	return arena_import_dax(arena, (long)addr__ign, page_cnt, src);
+}
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
@@ -1692,6 +1812,7 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
 
 BTF_KFUNCS_START(arena_syscall_kfuncs)
 BTF_ID_FLAGS(func, bpf_arena_import_memfd, KF_ARENA_ARG2 | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_arena_import_dax, KF_ARENA_ARG2 | KF_SLEEPABLE)
 BTF_KFUNCS_END(arena_syscall_kfuncs)
 
 static const struct btf_kfunc_id_set syscall_kfunc_set = {
-- 
2.56.1

