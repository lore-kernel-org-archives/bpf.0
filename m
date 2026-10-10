Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8230399350;
	Sat, 10 Oct 2026 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672560; cv=fail; b=C0aP9U0Yz2ktXVpeE1bIUi5pxudTrK+RUpQQ9kXdvcOcj5YS4+ELLw2H7ZEVf35TTxMT/MojDS3wjuChySgktwahMEUzhJEGQxYhrrhASx+mI9W1w8Bn7uKdDZ6mhtmpmy63AL9/bEVRLiMspjReJBz9fcmqaKRy8AkYUogrOFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672560; c=relaxed/simple;
	bh=0FeFCHJIRTOxreJgOWDB37tiw4pz8sGVvKwRTxAu6G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DITmCDhXii8vt7/JP9YlxvJMt0/6DyK7VISUWUd2TWdYKjwAvtFT2t9l9JA/8goLITJRCTC+K0KW24R3xxUVTlFoQchG1Gr3Izdp+KRk83FKEP7r4du4vrgaJdBKs2gtH1nDLYkGSa/VdlEJKbU+9tFiSZlA+Ue8bKMl1ps+eek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VEdO9Gvv; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VEdO9Gvv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MF88OcCXvu3U5SS7SIbRU0WIAASkf0V0WjyTlgzEri8g0xYuqHFEAx4AN2b/AGXfwwEs4uXzQE3DjgDor6a3EFL7R5NwEn+G80mE7XJqhHlqXwS84i4KTgQ3C9MO8IzCXsvhgkbLdVnQ3CrzxXr1uM/SWUqPb0RN/mlrOinJLRl0OEYM+yxH2VIYSqr+ZqWp+3LcSK3Y6qUhPrw+AD0eXk5VnAMoAAjNOAfNKwANQjVDQ9vCn0Zh2B+vlWEBvqlT6jI5QTZpYmSZde8wvkialk/p3nZo2ozSJ/pXH2M2yAILDbZ/zgwi+xKLkv4mzUy3pTwgPEcav2qtIEXC2l4pDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TD99+ed4bjJqU394MSKLgbTc5wf+Uf04d2twyTMmR3k=;
 b=cc/MoiSi2a/oRALxfpumdZh3/VGye2ForZbPfvdcfQQrTSD21q6hE6IdM7isgLJDrWpt75gcJSMYBHjSt12WzJCmsEOsoAd6s2ir5iKX4YE7nfqBkzTj3s8QDJWP+jHgHMIzKhWZRtrhDVf0nx6kKoh5FDLFd4eO2x56mc0XFg0lwzHlYRVKZ0dpftQ5bNTfs1/NFgMhvt2bJnhwZCboO1XgV+0ZXTClCwRROOM9Nm8Nxzpe7pwN81kAr00IWEaRcJB1JHV9EO5oAS91lwtGhRz1+uMbq0t2r67lbmr/z4I+Br8Ad0XzhZFizSaxTVSEfxTNdmoi6jp4L2K+MyaSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD99+ed4bjJqU394MSKLgbTc5wf+Uf04d2twyTMmR3k=;
 b=VEdO9GvvA0pKVi9mu5ypHLSUpDfTtwT/pYMw4rMKpTaBLJzY4u8nbRLQcsIqOEij7MB8IQLGwM4ReRi0y01mebUU+AE6ZBJ3RTc6JC8eJEfMPQ6iCSzu/NbLWIlLTnovUGNA1HnjCJ6QzVDXyeoaA2/CZ57bpzRZlFggwbmtTo3FpHgiucwGnjSN3hAYkbnHCobG9kEeTtdP1WTzBMlwMASE1J731nf7ushQBAdD20jUequvzrbvxru543TTkD3KD8j0CKE+XmjQ0j+3JBFjxbmrR/TuA25xh3u/pLgaL4EgDwxURfRHFjFGO8o1nN5yyvBw7V+SLfOOjNjgVSTVwg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 22:49:15 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 22:49:15 +0000
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
	Josh Don <joshdon@google.com>,
	Vineeth Pillai <vineethrp@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>,
	NchangRoy <royfru44@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] bpf: Expose pinned arenas as sized bpffs files
Date: Sun, 11 Oct 2026 00:45:57 +0200
Message-ID: <20261010224902.1232178-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010224902.1232178-1-arighi@nvidia.com>
References: <20261010224902.1232178-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B7C.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40f) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5bd0f1-5284-4a8b-a8c7-08df2720b5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	dvT7YkvfnZ4yHipBh/M7q8vN0zB0xVXWjePKKxJmGE7ur7JRtehpuHs/iD9s6hVbEQG2QDsDLz3JWXnHEvgIvc5XdqJJ9RNWR9DLfJ4W/dZN1hc3NdAPp/1KB92y3IrXLSEH1mkIfhYw/PowDjlZZhPFEexEhWeSTGpeikMeZcH0BrEq+oWGUKjb0AJq3cMS8jxd6GNZclY5stTEDPHgBJfBOXbXvO68Mm5Tj7XoDeB786zuL8qz9p9D7SrKM2/fETDS29jWtZaAn0+6Gh3TshkRxUsg9pja8f0nLNdER+dV5TG1G7MYP4weznX0mmEiK9xTR4dcSDZGfEaJdGRIBvrF6otgumI4EqXWH0GNFn/iaU1WJqicYk2pXluTNVZm/v4sjTBPbwhOptcoaUct398vqYexH+Z9rzZznLNckwgxejQUYx5RZWt8Dtf/rjhzP6Gw7s1tTkrl0UEUoUZqEpRsxx6gh/mT6SF//YY76aofJ9MKb27BxdpRZGvCeDOMo4uMuSCJ6xhIpxDnnC5w8DlqzCM+bm4NAWyeEYjO5zI83v4tB9uVJ+jaxMf4+ZR8L0L+CahTHOzYpLcuLaGS1FflF12+y2XlK6VPiRfIw+YsbZp6vBwaUYYtnm7LScVecaRrO2gzO1AxcMgLYUpyabxsu2nKwxST6fG0jE13VA4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2iTVFdIZa+LpL0gvLjCxUuJXWpUELtnvys02cGTrFwiOWWGzRs5diBBXsSTZ?=
 =?us-ascii?Q?DNJ+bKdVfwEHNZA2GN+6yPzE7EE8iGIkcEOwWL+73hkw9P6xLi2RhstZp7SZ?=
 =?us-ascii?Q?A1XiGow0NMegUIMJejCy+IMKqFImn7zz11r96ko9LkexJULbic/8iEz10DIa?=
 =?us-ascii?Q?LMxc0/uO3EWcyb1Ssag0mvXjXiu3OXoObLI37RZkrvBMXddB+jvHgm6GzWiJ?=
 =?us-ascii?Q?FKzmnaRhTnR2br2pUs47QV7L7x2hh8ttryX9mMBZqaZWHO7G8bDUE7If/Mrs?=
 =?us-ascii?Q?pfD3kPHKvFotztusFY5bt3DeVoPjKe3/d2QRRRrs08xgru9YOL2PYzp+JNWa?=
 =?us-ascii?Q?WUgNCO/WzbSoWwIrMAwbh7OpBXB/DD3RGV+94vO07syJ6886eOJEq+484+u7?=
 =?us-ascii?Q?YPKbUQTY0GlSEUVFhj0+t/kTYZY0nuDd9q7RH15QRGU5fPQ87SZ20Ar6IKxb?=
 =?us-ascii?Q?syr6hu5rKla9KKmMLVAsOj5ODMhdtuYR5cS2mfsqUQiHHkz40KTBgTdtRhfw?=
 =?us-ascii?Q?Q8mDOV3RJYZfQzc9fOpncOTO10LG1TeH5uwF++IwMNl47Y8J2bVr/SI4WLkp?=
 =?us-ascii?Q?1ECbCRq3HebulI6WLUtM4sWttt1IbGMNwfvsdgOmMj6jBTqM8RE7LKJ5BuhL?=
 =?us-ascii?Q?wwgY2l30rL8eDBymmXqv/1veXYdK31zgxt52BfhgPaF/C85ft5wEAxaMQSkL?=
 =?us-ascii?Q?10Jmv0d0RMv3OAIPtdWYuwp8y2CIQipDgSthvQd97ycT5zQZQmYoBPp97ZeY?=
 =?us-ascii?Q?0ys7gTMD9nEp63X5g+9jHQG8eHNgfFx/ZeNlxg1TX7UytAqso0QKKjDu67Tj?=
 =?us-ascii?Q?U+7v9bCcpnnNsxdnytAVgVVv4/oCsbLgjEmF1CNawCjzIlc7mvlgqwC+8ZaO?=
 =?us-ascii?Q?YNEPh9tHqc1XKS9dkb8t4AmVs53gTGjwFI1vyWqdo0FfnbOTa8ciTwZNvqK6?=
 =?us-ascii?Q?3fF8JF98kVpm5K3eDgrtySBwLGQr+epBGrdeAS6wdiz4EKnusAcgfl3xYomf?=
 =?us-ascii?Q?bfgLoemJIEjwfssTL5BNHTWs5BmN5hWEYVxMwyPvB55QJT14IAnHkNtw0iDj?=
 =?us-ascii?Q?MRXjdQmwzDwPuR/bRliospSmm37x7NP4B7lHqhy1Uv+Ax0GUx3uWhzm2V0Eb?=
 =?us-ascii?Q?GefKR7AVsP5nUbE4StifS0bt/8mXtA5QeAUJMlgCmfnPoLoPG5pgE6ufuxg6?=
 =?us-ascii?Q?bHViX9BvRUaQccAvN+XiXCYbcsk/XwcZ+7GKyhicM47zXlUY9k2S0PdjitF5?=
 =?us-ascii?Q?3D7ANkmvKs/HuAuj1suRsdViopPdJlOiqtBLUl40EHwOMAOz2+edciHqb3m8?=
 =?us-ascii?Q?qUEz51V/0vdXaN9q+uVa1QrsqqCrY79pwLo+ykDlMU3mcWXdaB2ZeFRjMS+w?=
 =?us-ascii?Q?2ouZ+ZbbDWe8JBeo+r5Q48MtFqVyrDCLNV5StV6I/565AuXjK9ZhUqsnSzTl?=
 =?us-ascii?Q?M43YM/fZCTgYhTZx7rNEniK4zvHpTlOhCcn2+rNptHMghFENTYlIn+IfCnD4?=
 =?us-ascii?Q?b51eBsz71Xg5e4hWdoYxmrHQqkinVv7SA17dXeuwCzjPwP0V2CCj1nULcjjD?=
 =?us-ascii?Q?ZHe+rWmj8ZA5G9KkkGjg5ZfCvVxKBDCS14A+FKIdDU00XmLSU2707vEf5oZY?=
 =?us-ascii?Q?KOte8Pj2JphCUYWxhfqjOoIduTYL/m2V/qpTRdT8bM0P5EnRSwIK7n/XNNUb?=
 =?us-ascii?Q?0Vt0qBT0CbxrUBB64tgfF/B6G8K/tuwxj0TrlNAwFP+bmC4t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5bd0f1-5284-4a8b-a8c7-08df2720b5c9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 22:49:15.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Nb+tdz1bgrW8tYnX/4iWl+k0sV9ikyXZ5g8/uQycIR8FKb1SfovQf5fb9K6SqLbMvENu8oVRhYt/CHFKer07g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

Allow userspace consumers to access pinned BPF arena memory through
ordinary file-backed mappings. This enables shared-memory communication
with consumers that require a sized file, such as QEMU guest RAM
backends.

Add BPF_F_ARENA_EXPORT to expose pinned arenas as sized bpffs files that
userspace can open and mmap. Keep the map FD as the canonical BPF
mapping, while exported mappings can use their own virtual addresses and
bounded file offsets and lengths. Resolve faults by file offset and zap
only the overlap with each exported VMA, allowing consumers to map
disjoint slices of one arena.

Require full-capacity canonical mappings for exported arenas so the
initialized address range matches the size reported by the pinned file.
Keep shorter canonical mappings available for arenas without export.
Validate exported mappings against the map capacity and canonical range
before resolving faults. Keep the pin's size fixed while allowing
permission and ownership updates.

Allow read-only shared mappings through O_RDONLY pin FDs by restoring
VM_SHARED when generic mmap retains VM_MAYSHARE, without granting
VM_MAYWRITE. Keep private mappings rejected and preserve existing BPF
map and LSM checks, allowing pin permissions to distinguish readers from
writers.

Require BPF_F_ARENA_NO_FREE with BPF_F_ARENA_EXPORT, so BPF programs
cannot free pages while external consumers may still use them.
Retention-only arenas keep their ordinary pin behavior. File mappings
and map references keep the arena and its pages alive until the last
reference is released.

Initialize the pin's capacity before publishing its inode, and support
bounded SEEK_SET, SEEK_CUR, and SEEK_END operations. Use the canonical
range end to distinguish initialization from a valid mapping at address
zero.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/uapi/linux/bpf.h       |  3 ++
 kernel/bpf/arena.c             | 68 +++++++++++++++++++-----
 kernel/bpf/inode.c             | 95 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |  3 ++
 4 files changed, 150 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 75101d602bd32..40a5489ac9fea 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1503,6 +1503,9 @@ enum {
 
 	/* Keep arena pages allocated until the map is destroyed. */
 	BPF_F_ARENA_NO_FREE	= (1U << 20),
+
+	/* Expose a pinned arena as a sized file; requires BPF_F_ARENA_NO_FREE. */
+	BPF_F_ARENA_EXPORT	= (1U << 21),
 };
 
 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 343e84139ec29..98f6dffe0138f 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -284,7 +284,12 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	    !(attr->map_flags & BPF_F_MMAPABLE) ||
 	    /* No unsupported flags present */
 	    (attr->map_flags & ~(BPF_F_SEGV_ON_FAULT | BPF_F_MMAPABLE |
-				 BPF_F_NO_USER_CONV | BPF_F_ARENA_NO_FREE)))
+				 BPF_F_NO_USER_CONV | BPF_F_ARENA_NO_FREE |
+				 BPF_F_ARENA_EXPORT)))
+		return ERR_PTR(-EINVAL);
+
+	/* Exported memory must remain allocated while consumers use it. */
+	if ((attr->map_flags & BPF_F_ARENA_EXPORT) && !(attr->map_flags & BPF_F_ARENA_NO_FREE))
 		return ERR_PTR(-EINVAL);
 
 	if (attr->map_extra & ~PAGE_MASK)
@@ -496,7 +501,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	int ret;
 
 	kbase = bpf_arena_get_kern_vm_start(arena);
-	kaddr = kbase + (u32)(vmf->address);
+	/* vmf->pgoff includes the file offset of a bpffs-backed slice. */
+	kaddr = kbase + (u32)(arena->user_vm_start + ((u64)vmf->pgoff << PAGE_SHIFT));
 
 	page = vmalloc_to_page((void *)kaddr);
 	if (!page && !(arena->map.map_flags & BPF_F_SEGV_ON_FAULT)) {
@@ -613,13 +619,23 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	long ret;
 
+	if (filp->f_op != &bpf_map_fops) {
+		if (!len || pgoff >= map->max_entries ||
+		    len > ((u64)map->max_entries - pgoff) << PAGE_SHIFT)
+			return -EINVAL;
+		return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
+	}
+
 	if (pgoff)
 		return -EINVAL;
 	if (len > SZ_4G)
 		return -E2BIG;
+	if ((map->map_flags & BPF_F_ARENA_EXPORT) &&
+	    len != (u64)map->max_entries << PAGE_SHIFT)
+		return -EINVAL;
 
-	/* if user_vm_start was specified at arena creation time */
-	if (arena->user_vm_start) {
+	/* Once established, the canonical range cannot change. */
+	if (arena->user_vm_end) {
 		if (len > arena->user_vm_end - arena->user_vm_start)
 			return -E2BIG;
 		if (len != arena->user_vm_end - arena->user_vm_start)
@@ -633,7 +649,7 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 		return ret;
 	if ((ret >> 32) == ((ret + len - 1) >> 32))
 		return ret;
-	if (WARN_ON_ONCE(arena->user_vm_start))
+	if (WARN_ON_ONCE(arena->user_vm_end))
 		/* checks at map creation time should prevent this */
 		return -EFAULT;
 	return round_up(ret, SZ_4G);
@@ -642,9 +658,13 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	bool exported = vma->vm_file->f_op != &bpf_map_fops;
 
 	guard(mutex)(&arena->lock);
-	if (arena->user_vm_start && arena->user_vm_start != vma->vm_start)
+	if (!exported && (map->map_flags & BPF_F_ARENA_EXPORT) &&
+	    vma->vm_end - vma->vm_start != (u64)map->max_entries << PAGE_SHIFT)
+		return -EINVAL;
+	if (!exported && arena->user_vm_end && arena->user_vm_start != vma->vm_start)
 		/*
 		 * If map_extra was not specified at arena creation time then
 		 * 1st user process can do mmap(NULL, ...) to pick user_vm_start
@@ -655,19 +675,31 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 		 */
 		return -EBUSY;
 
-	if (arena->user_vm_end && arena->user_vm_end != vma->vm_end)
+	if (exported && !arena->user_vm_end)
+		return -EINVAL;
+	if (!exported && arena->user_vm_end && arena->user_vm_end != vma->vm_end)
 		/* all user processes must have the same size of mmap-ed region */
 		return -EBUSY;
 
-	/* Earlier checks should prevent this */
-	if (WARN_ON_ONCE(vma->vm_end - vma->vm_start > SZ_4G || vma->vm_pgoff))
+	if (exported) {
+		u64 page_cnt = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
+
+		if (vma->vm_pgoff >= page_cnt ||
+		    (vma->vm_end - vma->vm_start) >> PAGE_SHIFT >
+		    page_cnt - vma->vm_pgoff)
+			return -EINVAL;
+	} else if (WARN_ON_ONCE(vma->vm_end - vma->vm_start > SZ_4G || vma->vm_pgoff)) {
+		/* Earlier checks should prevent this for map FD mappings. */
 		return -EFAULT;
+	}
 
 	if (remember_vma(arena, vma))
 		return -ENOMEM;
 
-	arena->user_vm_start = vma->vm_start;
-	arena->user_vm_end = vma->vm_end;
+	if (!exported) {
+		arena->user_vm_start = vma->vm_start;
+		arena->user_vm_end = vma->vm_end;
+	}
 	/*
 	 * bpf_map_mmap() checks that it's being mmaped as VM_SHARED and
 	 * clears VM_MAYEXEC. Set VM_DONTEXPAND to avoid potential change
@@ -841,8 +873,12 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 	struct mm_struct *mm;
 	struct vma_list *vml;
 	unsigned long vm_start;
+	u64 start, end, vma_start, vma_end;
 	u64 my_gen;
 
+	start = uaddr - arena->user_vm_start;
+	end = start + size;
+
 	/*
 	 * Taking mmap_read_lock() under arena->lock would deadlock against
 	 * arena_vm_close(), which runs with mmap_write_lock held and then
@@ -881,8 +917,14 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 		 */
 		vma = find_vma(mm, vm_start);
 		if (vma && vma->vm_start == vm_start &&
-		    vma->vm_file && vma->vm_file->private_data == &arena->map)
-			zap_vma_range(vma, uaddr, size);
+		    vma->vm_file && vma->vm_file->private_data == &arena->map) {
+			vma_start = (u64)vma->vm_pgoff << PAGE_SHIFT;
+			vma_end = vma_start + vma->vm_end - vma->vm_start;
+			if (start < vma_end && end > vma_start)
+				zap_vma_range(vma, vma->vm_start +
+					      (max(start, vma_start) - vma_start),
+					      min(end, vma_end) - max(start, vma_start));
+		}
 		mmap_read_unlock(mm);
 		mmput(mm);
 
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 7837968c0842c..d3dc6f70e32ae 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -119,8 +119,24 @@ static const struct inode_operations bpf_symlink_iops;
 static const struct inode_operations bpf_prog_iops = {
 	.listxattr	= bpf_fs_listxattr,
 };
+
+static int bpf_map_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			   struct iattr *attr)
+{
+	struct inode *inode = d_inode(dentry);
+	struct bpf_map *map = inode->i_private;
+
+	if (map->map_type == BPF_MAP_TYPE_ARENA &&
+	    (map->map_flags & BPF_F_ARENA_EXPORT) &&
+	    (attr->ia_valid & ATTR_SIZE) && attr->ia_size != i_size_read(inode))
+		return -EINVAL;
+
+	return simple_setattr(idmap, dentry, attr);
+}
+
 static const struct inode_operations bpf_map_iops  = {
 	.listxattr	= bpf_fs_listxattr,
+	.setattr	= bpf_map_setattr,
 };
 static const struct inode_operations bpf_link_iops  = {
 	.listxattr	= bpf_fs_listxattr,
@@ -351,6 +367,68 @@ static const struct file_operations bpffs_map_fops = {
 	.release	= bpffs_map_release,
 };
 
+/*
+ * An arena with BPF_F_ARENA_EXPORT pinned in bpffs can serve as a
+ * shared-memory file. The ordinary map FD is an anonymous inode with no
+ * size and cannot be opened by pathname, so keep the pin's inode and
+ * forward mmap to the map FD implementation. The pinned file uses ordinary
+ * address selection so QEMU can map the pages at another virtual address.
+ */
+static int bpffs_arena_open(struct inode *inode, struct file *file)
+{
+	struct bpf_map *map = inode->i_private;
+	int err;
+
+	err = security_bpf_map(map, file->f_mode);
+	if (err)
+		return err;
+	bpf_map_inc_with_uref(map);
+	file->private_data = map;
+
+	return 0;
+}
+
+static int bpffs_arena_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	/*
+	 * Generic mmap clears VM_SHARED for O_RDONLY files, but VM_MAYSHARE
+	 * still distinguishes shared mappings from private ones. Restore
+	 * VM_SHARED for the map mmap path without granting VM_MAYWRITE.
+	 */
+	if (!(file->f_mode & FMODE_WRITE) && (vma->vm_flags & VM_MAYSHARE))
+		vm_flags_set(vma, VM_SHARED);
+
+	return bpf_map_fops.mmap(file, vma);
+}
+
+static int bpffs_arena_release(struct inode *inode, struct file *file)
+{
+	return bpf_map_fops.release(inode, file);
+}
+
+static unsigned long bpffs_arena_get_unmapped_area(struct file *file,
+						 unsigned long addr,
+						 unsigned long len,
+						 unsigned long pgoff,
+						 unsigned long flags)
+{
+	return bpf_map_fops.get_unmapped_area(file, addr, len, pgoff, flags);
+}
+
+static loff_t bpffs_arena_llseek(struct file *file, loff_t offset, int whence)
+{
+	return fixed_size_llseek(file, offset, whence, i_size_read(file_inode(file)));
+}
+
+static const struct file_operations bpffs_arena_fops = {
+	.open		= bpffs_arena_open,
+	.llseek		= bpffs_arena_llseek,
+	.fsync		= noop_fsync,
+	.release	= bpffs_arena_release,
+	.mmap		= bpffs_arena_mmap,
+	.get_unmapped_area = bpffs_arena_get_unmapped_area,
+};
+
 static int bpffs_obj_open(struct inode *inode, struct file *file)
 {
 	return -EIO;
@@ -362,7 +440,7 @@ static const struct file_operations bpffs_obj_fops = {
 
 static int bpf_mkobj_ops(struct dentry *dentry, umode_t mode, void *raw,
 			 const struct inode_operations *iops,
-			 const struct file_operations *fops)
+			 const struct file_operations *fops, loff_t size)
 {
 	struct inode *dir = dentry->d_parent->d_inode;
 	struct inode *inode;
@@ -382,6 +460,7 @@ static int bpf_mkobj_ops(struct dentry *dentry, umode_t mode, void *raw,
 	inode->i_op = iops;
 	inode->i_fop = fops;
 	inode->i_private = raw;
+	i_size_write(inode, size);
 
 	bpf_dentry_finalize(dentry, inode, dir);
 	return 0;
@@ -390,16 +469,20 @@ static int bpf_mkobj_ops(struct dentry *dentry, umode_t mode, void *raw,
 static int bpf_mkprog(struct dentry *dentry, umode_t mode, void *arg)
 {
 	return bpf_mkobj_ops(dentry, mode, arg, &bpf_prog_iops,
-			     &bpffs_obj_fops);
+			     &bpffs_obj_fops, 0);
 }
 
 static int bpf_mkmap(struct dentry *dentry, umode_t mode, void *arg)
 {
 	struct bpf_map *map = arg;
+	bool shared_arena = map->map_type == BPF_MAP_TYPE_ARENA &&
+			    (map->map_flags & BPF_F_ARENA_EXPORT);
 
 	return bpf_mkobj_ops(dentry, mode, arg, &bpf_map_iops,
-			     bpf_map_support_seq_show(map) ?
-			     &bpffs_map_fops : &bpffs_obj_fops);
+			    shared_arena ? &bpffs_arena_fops :
+			    bpf_map_support_seq_show(map) ?
+			    &bpffs_map_fops : &bpffs_obj_fops,
+			    shared_arena ? (loff_t)map->max_entries * PAGE_SIZE : 0);
 }
 
 static int bpf_mklink(struct dentry *dentry, umode_t mode, void *arg)
@@ -408,7 +491,7 @@ static int bpf_mklink(struct dentry *dentry, umode_t mode, void *arg)
 
 	return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops,
 			     bpf_link_is_iter(link) ?
-			     &bpf_iter_fops : &bpffs_obj_fops);
+			     &bpf_iter_fops : &bpffs_obj_fops, 0);
 }
 
 static struct dentry *
@@ -483,7 +566,7 @@ static int bpf_iter_link_pin_kernel(struct dentry *parent,
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 	ret = bpf_mkobj_ops(dentry, mode, link, &bpf_link_iops,
-			    &bpf_iter_fops);
+			    &bpf_iter_fops, 0);
 	simple_done_creating(dentry);
 	return ret;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 75101d602bd32..40a5489ac9fea 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1503,6 +1503,9 @@ enum {
 
 	/* Keep arena pages allocated until the map is destroyed. */
 	BPF_F_ARENA_NO_FREE	= (1U << 20),
+
+	/* Expose a pinned arena as a sized file; requires BPF_F_ARENA_NO_FREE. */
+	BPF_F_ARENA_EXPORT	= (1U << 21),
 };
 
 /* Flags for BPF_PROG_QUERY. */
-- 
2.56.0

