Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911453;
	b=kpP2a9RVX3A6rk/XR3OoL7DDjmIWFfol7hfvzvdLM50h6e/x7VzhWsOPzsJJpPyJLYBh
	 TZSdmAM3BHV98jO84AuE1Cew+7xj6DW3lboKYUH35I/2asXpheYB7xLaJ5u044OoAlx9r
	 ZDNQqNe2wLtaWJJ1ZoM6dccal10lgWQneiw57paVbm5PGwH0Bh9EjKp+tEChb4fXImv1v
	 AZvI6cqoaWafJk7El987CALKlWQRnPMFk9OESfJZhWNi7b15cZjyO359CgHUenh5Ct1Du
	 uxW/hkn7oMvXTrHYDLSw14VFoSleon6ob7R4Kz+mmL6ICeQpxlBySTbmg9m5KMAnEbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911453;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Ri67obGkof6T9qQF37EZOsJ9tjUT0T5Z563nI+nkqks=;
	b=Yjh5zWcItonQAhHKKYCTg53TytqngL5W7xRe7EeMs/gtomn5ySnlQ3/EB65gzSBMdvFY
	 INxJqwCPIfOuhXhPwM6r7YcfFSKT5UliJtmj530W7MDWzqPxnvRCJtVj8rydCYKN3zmg1
	 DmxxrNNkUsxsKtx8eLeRpRcFoO0aYYziakRY0jRt170SuUkEIoBpn2GjK5+6om72X8kJI
	 fD04ty6khY4O1QvJy/hOzRZIamrCj/cuSjjDi1IAs0Uuu5BzuV14GWjqCuJAyvByDa4E/
	 /EKHOJr6nc5wL0xFzdGd30VvwM2VIUz2fR91C/xtdDEF/87mtoQ62wuKDlfiRJxgPYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LKdaiDBU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.50
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87559606A31C;
	Tue, 17 Nov 2026 10:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87559606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LKdaiDBU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBbVvCj5YZGDBzsjUfYPrcfGUuA8Isp9rZh/bFlMyA5x/vadNtA1YEnvDo+CnIQA2/KxuxN16hWFs5sscyUgZ3CeiWptqwwE9STrXOLsw9/gp87/Tk9vhxo1+8RzVYdWhd64PVjWLOXVoDLuWt6RVJfoBVVvTBrJ0iNN4OAs1gptBpqzKfxjj6R4AZCYgCwUw4NTroIrxXSGmzcHdK99CqKQNQET9h3UF1no3zDjbA/1+FAwNtMSTN4b/eo7Os4+ncHca/c/5FqPHxObFEX+FnSQcZfDr7bhZYTH9j7Ij2201JkLQ95BtWV92+V0sXi3Un+9jyFfUHlae136gNqQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri67obGkof6T9qQF37EZOsJ9tjUT0T5Z563nI+nkqks=;
 b=VKqWTpG150UcXOaQkgYnTA0pyjw8A7LagDOXYsRTWBwYcYHm5nnu9oVXZWp+okVMIkiLnwzPdqtArgwNJyb7yUTkfHgbVgNO24o5mxrSyaomijCxkkj1g2LFNghVK15OiZgiMc9jd7DuOzHIQJw9zxuTPupoxx1QDt2Ot206TyuwpBPLXX0oPdug1mRpYRgWNQjqhJ0MDutLs6MThaXsLPJzLAK06o9x9xYR867tobVaDy30rTRWFXyX2Moj98ah7H6p2ikV0HqXIxH+vckxmyIaY4hRKqL/0gMzR3eSNoyGR6F3C8UQSIIYDoeGC6vex1gDLJmwq3FHCcee3gXTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri67obGkof6T9qQF37EZOsJ9tjUT0T5Z563nI+nkqks=;
 b=LKdaiDBULazIXU3g8a4nUIuKmPbiF6sOGnPF4rHSjfn0BmBEk5isPkToAsR7j92NMWEQCWi9INzwGo9bEQroaAWOMEafm0cIkaoBqj2xxquvk7Ekg8RnGMdEX10tPm7jQSZAlK4dbFkoIFmur/kixOzzPCE9rslRugv2wodkI71BfgEvirOxG409VF7cyzg95JVZM/0yYZhFRZlUutVQ9rnGVYJ22vq0e6usk99pBhorArn4rmJhaqO9t3fDuu7ZlqNGl6AOS+RRZgtV11Ca2EIoGnM73fNrudJJZxdbcCv30UhtkZAmXslS6MNUoqB1NV6ZEfvlp4zn114z2ewVqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:30:45 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 10:30:44 +0000
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
Subject: [PATCH v2 bpf-next 0/3] bpf: Import external pages into an arena
Date: Tue, 17 Nov 2026 11:28:05 +0100
Message-ID: <20261117103028.4105609-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 71a6be5c-6cf7-418f-8436-08df4495d64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|11063799006|56012099006|261022075727099003|261026140227099003|261021121427099003|261021135927099003|261026121527099003|261021123027099003|261022105027099003|261102130727099003|261102123227099003|261028144727099003|261009223027099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	KnqtJEN86jIL7vda9l2M+61PeYRVblzUMv+V99EfNaumKR+iaPRGjRHypxohTtEVeSy2b5yYwsIOh9dAZpf5+1ehr1YlJVn5ZSxn/Q4oKmLZG+iuIkxthmLt2S0BeDI/Pxe8Hk6TLmHu9ic7M1P31RUX0HCZOTocEol4yNC+i0WmhEItouKDJjdnw6nrrvJ56DG8Z4ear/wA07X2LzNcIBvPtRxb4GuxOfrlNxE+K89lkk4E1XmdwhNGwu56+y2M8HT8PzzEriYHozKenECQpV/JKON0HFeBMfTEWv/w5tgqVuEkBUV/wKOu+yMx5+Bkpm99QiHIMTQD3AUWLeGlcBqeaL1CAG874dEg8E44IsoLhmPsSV0rDZ2MFgzknGNYFd2H9JjDE7tsG4pfzypo93xzYjdZbM86LeqJlWa4uPA35qXt+k5Jmmm0HYdnVJBS6U/acOc5bz+M2b+ZJU//SxdvU7Vkbb0pS2pPZ6ufMd/cSq3WIXCy/JYjp7A37h7oU0YcnmqRrN6L0p3i0pPhXSapo2h8Esvb/ndMzXdlGo2tIFYzkGpdMy/7IJFzsqT8kkIhoitJv/Dp+7RekrFpaKPAvBcN7dxMIc0RcTl//op90yQ+cHcDzai8w102tJPcaa/JCaG985ybnSdogT5huUoMN/hmdn3jWSuVzHS0Afw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(11063799006)(56012099006)(261022075727099003)(261026140227099003)(261021121427099003)(261021135927099003)(261026121527099003)(261021123027099003)(261022105027099003)(261102130727099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sM/7S2fhcNhJOMsZCwqhKNL7DhXaPuCxnd6nwW9wPpet3eXGjr57slWvQfnv?=
 =?us-ascii?Q?BaDQ+fovIAjmDyGCJWcxUjEMioU9KA0Bo2hFDeoa3q+DUM9cSuFbXk5jJrGO?=
 =?us-ascii?Q?0JCQZe4fZVNnBU3iAPna6Sa5r0XJ7gxN8RmFWgHuDU+PozUo47YUAJKlza4x?=
 =?us-ascii?Q?/CWsMHC2bzczQbUeVsqow/aNLIDkC0IWthk5QL6czTkFk0Y3DntDb5bpzFpz?=
 =?us-ascii?Q?NphfTughpwTvn/cu6euqmd7RJGraJIOn211kUEJ9psO51zdAcz7kRdSlTRmL?=
 =?us-ascii?Q?00ElUd8zXY+TBBFqcVa/9ggvLGQMUBnZabul3qrH8e0PDBKfCpCFcZNx51WV?=
 =?us-ascii?Q?E/bhkxqsB8w0ZvpYGozWVC8jJucmXqMvpa9lu1IzVcFBpExF44jS/scwXMah?=
 =?us-ascii?Q?V464oMpDFpXa/Kq2rjwlDJe/HdpPh6smRfNgXdYpkV+GoYcg+uTuRIqxdJYa?=
 =?us-ascii?Q?vMYWH+bb88CtttV6aNzme51ndPnwBxcpDsUgkL3RgsRWBk2YVqNgLDv0uTYv?=
 =?us-ascii?Q?zO7cqVp8C73bzgETj12KGbbu2kcycqy6VOmtGgTXpKKYx0Bp96mbsHk1X/mN?=
 =?us-ascii?Q?i9ST5RLE2fjqcq5AwI/6MDdNSTfwwL7xAbpxbk8BuZ8eqiKfcXqDrimyXwv/?=
 =?us-ascii?Q?qXDXv+Jb80xh1dJERaj9gJFY0Vu5YjmqX9SQmMBYsGWHj+LHZzO98AYE+SdL?=
 =?us-ascii?Q?zv5QLo+vBh3503a6nqVnjIlmiWPib3Pm49VEwa3W1KQE9D7ZMUbAGXmneWy2?=
 =?us-ascii?Q?i31/VYK4P10RisBDjTlotee8wxqykCfxCRjR034oNMpRj1imkl4+nuP0O7tc?=
 =?us-ascii?Q?7yTqMTjD+EY4zhIsfg8f9YtNHgztn0SibQCvZ+V1UTjhlgPD+WyBVghzpnpt?=
 =?us-ascii?Q?Xkrv6Sbx2e9KOlZDiAp+WpRaL1u9IE+YYNYcXMHSShwsQchjfWDZRhblxrM8?=
 =?us-ascii?Q?TtyvgODNYaEc9Vuh9kkMa3KaiEJOvdeehA+k3u7QC0SzpraapMu5j7xt1HYL?=
 =?us-ascii?Q?MeaF9tNCexatXb1WAEeLEIbinORkHTJULkcNIrZefsR5viLoYTLIBWfUoC64?=
 =?us-ascii?Q?ZnW+/vbxx5FVKBqDJuNUMZ4vKGS5r4G7JtrerRC0/BsWQ0YjCqXRwsC5sN/8?=
 =?us-ascii?Q?LQ0lSkV6yrNv7Llqrf2JzujRaXW46Ec50k5W/cVpsfXeAzSm8kdWex0zYrRW?=
 =?us-ascii?Q?VC+jTpAvOts9DDfnJQ08UCL37UCD8oi8xNxmalqQnkyr5V1kuPu7LecIDOW4?=
 =?us-ascii?Q?iEDagfvQZrxk8dGk1kXnjWDykNx2LzhEhTty2rjHSTnPuwDuftmF9y8fnXey?=
 =?us-ascii?Q?5gNICRNrbbDmXSDqpR2M0lmx48CAxk6jLz1Ru9PhgU5ksT4wo4dW6Ugyj0+B?=
 =?us-ascii?Q?52xyMK7dgilEIRgDr0tPw9FnDlNSoLB3M64HZvksMV8M0Sqy100wdo5vn5LF?=
 =?us-ascii?Q?s+qbmtAQ5taWI/vaL7TttNrx7QdfoYarNS38ZpDL7McB6YMP1PPSknMqazBI?=
 =?us-ascii?Q?RjFYlY/SHdmj5gchNT44cgGk/ocdPti/cIAaCW4MbVxfVwGALdMgD+5VMxy1?=
 =?us-ascii?Q?LCzmSPPK1c7TUOkLDR032hFcqwVvWx0JNRIqcL/mNvY2b8L+4Ge9ip4vmJZ9?=
 =?us-ascii?Q?T1aUHJlqdN2UXtxG7+noxY0zp001h9zigSaqYInqYdf/8TEGrB2Z79lYSmRF?=
 =?us-ascii?Q?3ZLnnEDEzBpJBEaEuhs9tFDb30ZxWs4SPt3SFSOZrtdieK1B/mj+NrE/E1lF?=
 =?us-ascii?Q?ayZNL8msBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a6be5c-6cf7-418f-8436-08df4495d64e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:30:44.7600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2AfVd1lyNulDLwUtJfaSazc6gQtleEt4TNvhdcB6eDDwwo7KBQWIcRAyMcjCYruf6Mx+oCN4qmyk7f+w5fWvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351

As discussed in the BPF track and the sched_ext microconference at Linux
Plumbers 2026 [1][2], shared BPF arenas can provide a generic channel for
bidirectional zero-copy communication between BPF programs running on a host
and its guests, for example to exchange scheduling hints between host and
guest sched_ext schedulers.

v1 [3] exposed a pinned arena as a sized bpffs file and gave the guest its
share of it as a NUMA node. Following the review, this version drops that
approach and teaches the arena to map pages that it didn't allocate, based on
Alexei's prototype [4].

Background
==========

An arena can only map pages it allocated itself, so its memory can be shared
only with the BPF programs and the user space that map the arena.

Sharing it with a guest through a NUMA node, as in v1, has two fundamental
problems: the node is ordinary guest RAM, so the guest arena's pages go back to
the guest's buddy allocator when the guest scheduler exits, while the host can
still write to them; and memory block granularity makes it wasteful (16M of
guest memory for one shared page) and limits it to a few hundred guests per
host scheduler.

Design
======

The arena gains a single primitive, arena_map_ext_pages(), which maps pages
supplied from outside at a free arena address. Each call creates one import,
kept in an interval tree with its pages, which belong to their supplier, not to
the arena:

 - bpf_arena_free_pages() over any of them releases the whole import: the
   pages are unmapped and unpinned, and the range goes back to the arena, so
   the arena doesn't grow as guests come and go,
 - they are released when the arena is destroyed,
 - they are not counted in the arena memory usage,
 - the arena mapping raises SIGBUS on them (SIGSEGV with
   BPF_F_SEGV_ON_FAULT): user space accesses them through their supplier.

Two sleepable kfuncs for syscall programs supply the pages, one for each side
of a host/guest shared arena:

  int bpf_arena_import_memfd(void *map, void __arena *addr,
                             u32 page_cnt, int fd, u64 off);

Host side: pins the pages of a memfd, or of any file on tmpfs or hugetlbfs,
with memfd_pin_folios() like udmabuf does. The host hands the same file to the
VMM as a memory backend, with no change to the VMM.

  int bpf_arena_import_dax(void *map, void __arena *addr,
                           u32 page_cnt, u64 src);

Guest side: the VMM exposes the file as a virtio-pmem or NVDIMM device, which
the guest turns into a device-dax device (/dev/daxX.Y). The kfunc pins the
device-dax pages mapped at an address of the calling task, and holds a
reference on their dev_pagemap until it releases them.

Both sides then see the same pages as arena memory, at an offset known to both
of them, so they can agree on a layout in-band, with plain BPF loads and
stores, and keep pointers to it in the rest of their arena state.

Use case: paravirt scheduling
=============================

The git tree below has an additional [DEMO] commit, not meant for upstream,
that provides a real, tested use case of this functionality: a pair of
sched_ext schedulers, scx_pvhost on the host and scx_pvguest in every guest,
which share a few pages per VM through their arenas. The host publishes which
vCPUs it has preempted, its idle CPUs and every VM's fair share of the host
CPUs; the guests publish their demand and the state of their vCPUs. With that,
the guests stop queueing work behind preempted vCPUs and fold onto their share
of the host CPUs only while that pays off.

On an NVIDIA Vera host (arm64), with 8-vCPU VMs on QEMU or Firecracker, at 2x
and 6x overcommit, compared to stock VMs, the paravirt pair is 2.2-3x as fast on
hackbench, 1.3-1.9x on a kernel build and serves 1.6-2x the requests of schbench
and nginx; tools/sched_ext/scx-pvsched.md in the [DEMO] commit describes the
design, the results and how to run it.

Known limitations
=================

 - Imports are released whole: freeing part of an import releases all of it.
 - Imported device-dax pages keep the device in use: unbinding it blocks until
   the arena releases them. Revoking them would need a notification from the
   dax core and a way to tell the BPF programs that the memory is gone.
 - BPF programs have no machine check recovery: on a real NVDIMM, the supplier
   has to keep bad pages out of the arena.
 - There is no doorbell: the sched_ext use case polls the shared pages at
   scheduling events.
 - Confidential VMs would need the guest to keep the shared pages shared with
   the host, which the device-dax import doesn't handle yet.

References
==========

[1] https://lpc.events/event/20/contributions/2429/
[2] https://lpc.events/event/20/contributions/2482/
[3] https://lore.kernel.org/r/20261010224902.1232178-1-arighi@nvidia.com/
[4] https://lore.kernel.org/r/DM6HVNSP3USV.AJSWS289Z3I9@gmail.com/

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-pvsched

Changes in v2:
 - Drop BPF_F_ARENA_NO_FREE, BPF_F_ARENA_EXPORT and the sized bpffs file, and
   map pages that the arena didn't allocate instead (Alexei Starovoitov)
 - Import the host's pages from a memfd with memfd_pin_folios(), the VMM uses
   the same file as a memory backend (Alexei Starovoitov)
 - Replace the guest NUMA node with a device-dax import, so the guest's pages
   never go back to its buddy allocator (Alexei Starovoitov, Josh Don)
 - Release an import with bpf_arena_free_pages(), instead of keeping the arena
   at its high watermark (Alexei Starovoitov, Josh Don)
 - Map the shared pages at an offset known to both sides, instead of
   discovering it out of band (Josh Don)
 - Track imports in an interval tree instead of a second range tree and a
   list, so that a release finds its import without allocating
 - Link to v1: https://lore.kernel.org/r/20261010224902.1232178-1-arighi@nvidia.com/

Andrea Righi (3):
      bpf: Allow importing memfd pages into an arena
      bpf: Allow importing device-dax pages into an arena
      selftests/bpf: Test importing pages into an arena

 kernel/bpf/arena.c                                 | 461 ++++++++++++++++++++-
 .../selftests/bpf/prog_tests/arena_import.c        | 451 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/arena_import.c   |  93 +++++
 3 files changed, 994 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_import.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_import.c
