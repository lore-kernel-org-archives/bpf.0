Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021088.outbound.protection.outlook.com [52.101.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5C64A8D;
	Sun,  3 May 2026 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777834889; cv=fail; b=DNqzdLwfZ+foQdi9LZW8cRC7yWqs6Ogi8GNIIPMcNWyHsWDEjK3xInvJNkFmFYaZDjaa+5cqjloH2RF12uF+o8m+c6R0G+DW7JWvXb1RfQMaO9nm+K6Ihf7p4D+8Cxx9oc5sYKK+Xa/4pdVtJkRvaGaZFJbBUOyexW9HEBAeb5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777834889; c=relaxed/simple;
	bh=OvRaJQY4b+BVP5Oo0CS2c1sMmWX56CRgpAPQj/dFX4E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O1gzBXpenbl8XDHH7QYhyM0xkwRXzHWNtKe1yxlf4zTurdGD/r1flHijgft6huopxSjMB438EXRf7+ZQtNrV9lc2fU2DBh/LDRo/NYkV/DZQe6GUC4vyKVWB3U9uvZ9mt3FCXr6Q5LpSKChkjJkqHA22g9hWFLDAwmpQTj30hvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+jO+u1jWb1A2+uxn1Q2PZMJLu1WopRRHGSGoQisE0ReXr48mcxOJFV54x/z3bLuRHGGnEzk458v9CamR9w+jQN+e0UyB2jvtTkkWisl7sr6HhXIqrhXZOAZfQIxnl5SASaP2g/Z0VYSPHnZStFbWO32VJ1ccqGBsK74TrwK2nDQrZLepjihfc+Qe2g/38ct0auqwRFT3M66EySqpCg8Tf2IRwDMCojrmVDYZJXFAXYs6m3TYvr4QmJ4vANoAjfh5jAcIVIaOmDQBrsGzMYWFHsVr3WmVUp0pNjYhElfdo4VRUf3ak+onZ4Bx6cFuYb+vb4iBZW0xCgc13GxhI0APA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xNosfvN3i8Lom5q9iPOUrJ81nGwBO30nsY+3lwKBEg=;
 b=tbyaZTVef6arhsfE4y5Ri6cpD6WJDEZzUmjLTbvB/xotc0FlR8ybfCGT4Lx3PokivBeyVjiigzY3xR5fbFyAECNqGhj7GozucmCK04wKvC2kvJpLyIkfkSKNXreOS79BKOGlzukajMQcKBq5gTNZ8hTHJB8DJ+Yqs6QzUVCAMkOWEhB1XOMsan9ZBwdWxyAnHy04mHJJyN3peQcVaZ67kVBnA2eNdRvkk9wHqrSRxC1Dm9T3CbuWwyKkv8dlYKxyW41kLBv3YAjOE4TrhkEv8xpt/Tg/6zJGvtA3MqJawFPsxaYj1p533mLmI8we+1P2bOpRgWYzN7qye6SY8dhArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOVP123MB8590.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:488::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 19:01:23 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 3 May 2026
 19:01:23 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: corbet@lwn.net,
	song@kernel.org,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: skhan@linuxfoundation.org,
	jolsa@kernel.org,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	mathieu.desnoyers@efficios.com,
	rdunlap@infradead.org,
	atomlin@atomlin.com,
	neelx@suse.com,
	sean@ashe.io,
	chjohnst@gmail.com,
	steve@abita.co,
	mproche@gmail.com,
	nick.lange@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v4] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
Date: Sun,  3 May 2026 15:01:19 -0400
Message-ID: <20260503190119.559696-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0882.namprd03.prod.outlook.com
 (2603:10b6:408:13c::17) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOVP123MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: a78a3ff0-294a-47ca-104a-08dea9465e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	utsyMQ+Ufx7FpazACtSk9cT7hNXHsdgJ4ZOYaa0AHrtrxGLSfqd6g9aE41fIUR8jbdRBpWdMWnCMFmvDLJHtoGVQZjuMwZAvo0OCvVtRyArYUUmJWbL2WvhgOtZeuAm0O3XQtTMGx4DYUJvAD0toXh/QwLMn/QTSeifYto6b2jMarPmUjJckx+tisa07Wfc5xXNTDusTPlOPlL5X/cqJw6krUfU5ADGBZmXfZoyrLyXvsPCX3FGJZHWHCsybP1ygI8F1m9Nubn9B/YtHjB6jHvw9/yPdtJxRIQsQ7IBMXoycbgCdSlk1hJUfIKavAa5BbaTJzHRN6TpTZ49CpSFeUnLTzi3oGlCVaf7kV4GCUYvZX33LGJCp77p7cG+a/O/V4vU6sOAyoHZTdZZAGVYEBeZ8UKTvFez3T+P6Hbd9PbK4md9DllpOP6/bYjYCA5oPv/CD+LXmLA7mYYjVH+UUVplXdF3sbAWNpKJIPw5K6CZF1K4Bn89kF9LktZ8a9Wj934FUQLc7m/5TMjIzLeLVNqZZAJ6nh6IAly4LTI5j81L98bL8XAps0piOG6BM0gXNv7ay3FdUBLTWtkZHoapXB/i9eo+iPuNyNjizYy1LqoGUMEQzEma5qjWnHx9l9KH/5xoqtTIJCagXJZJHwImOuA+VLmt7E17EaR2SI1onVEj4Gy+1qQ7pIjnnCVoBJK8S6PRJOIDCJZQLMtuGHC/JiSZNS6DBZ02q4xikE/14dG29RI8QcPoklVao1SiC7Ew/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bpI+iUYb3YppBMMJD+TOvnjaSuHL7WSpvcfS3j1lvGH5zLfIwvkelWbGipbb?=
 =?us-ascii?Q?wGv51H5lUy4kv1Z6UDA7hnogBgCi1uruN0MbJsAzHnyFiG5YysRhke6z56IL?=
 =?us-ascii?Q?FdEYU3sotD6I/UndCogBMyky5fdp8tp2aZsqe5BQnrH2nScx50n1PZJEshkP?=
 =?us-ascii?Q?G8NfyeXyo3/3DMNr7F+Mg62J9RN8/g5GP4hmzqh9vywwEUyT9CBEZR7lEq+i?=
 =?us-ascii?Q?YPzWQOo4ofSkj6z8BU3Nc83Lsyyeeh+5VIbYinWc6NlrOgZ33aHjEVdsYkRH?=
 =?us-ascii?Q?HlKjFkqUgYVESe8xZAZMb4mntM0P5/M0XeknJ22mj07GzrAEUcjz8lGKvdO/?=
 =?us-ascii?Q?RHYWGTnhNf2dEdMPZ+IFH9drM4KQqK/YDVuKStmd1+mRzsKsVtA9HcEzJVzm?=
 =?us-ascii?Q?RqJpZhlHE8TpwK9BrLp7FC4OpuS/26XrWCGRnonfDs4xOIWD/ExfQL3CeWxO?=
 =?us-ascii?Q?y5Xok6+ADKs+PUqumK4i312KLXofR+mps1ts4QgxpEcXR5khyrR2k2SucrZe?=
 =?us-ascii?Q?cu8/fJCXJWfqtA4aBdEvu0ScWHUycRQgFW0fOxVOosr3HJ2dEIPbgvv/Nan8?=
 =?us-ascii?Q?RZyTxd+49Msk8/Z8ysSc4BLZ2P7nG6mWafsnqGHGlqh7pE9jTap9pjAQOY43?=
 =?us-ascii?Q?POVVS8/xbOrhj71dq+xpk6yogPwGaqrY5BYzMRa8bkeA8wtQ2BQGRqr+UnhT?=
 =?us-ascii?Q?O9l1WZltrvJntiNWgN1kQV0auirma1ICWcqNec/Q8NfIaEv1lIoWoVJe6QCy?=
 =?us-ascii?Q?N6JqZt9Z98oKlSNAYQzyQrFjftXAKcueFCTSxgjMc6qf7yOnVE3lxw86pxLl?=
 =?us-ascii?Q?coV+aTfJ1cXTwLc0v0MB0YC7Opzdho8IDjL9pFLTNnG69BuEIDy7jGl9zX+o?=
 =?us-ascii?Q?ZtKPnF+m0CnfUvppyGaVYLlcL7eWjxKAwbdtkiwoT0Zgi0r/hA7aysp58jdu?=
 =?us-ascii?Q?5B1DvmwhHC0J+zMpTMIG2XyPArZOQ4KSMXG5eWSn3CmKR4PhC/9lPbwzroDa?=
 =?us-ascii?Q?xcA3CI+DdZE7idSa01Xg39RSkqXGCl5rUzen1wpFjXMsmTAlCqxZq6oDzrPU?=
 =?us-ascii?Q?x/obElF9wlwZSnhmNADS4qudWo0r/MbvA7leLZs8gQ9mT9ttbVmSIdWZxn/e?=
 =?us-ascii?Q?SALm2jpjWWxTl3oo8ZiobERiSeV5qAlv2ssS59iLthhx3AvmniH5b4pWxLec?=
 =?us-ascii?Q?9EOO8P67zsYaJDDDAtxogdomwlOqg9IwrJ58OtRn9zNkThl4UQQ5fvoACFVn?=
 =?us-ascii?Q?ZXkMehaJDAB4d35L84BeQjnYmAL+REatcYoBCjyOX53P0M2BE/sflOwSycm5?=
 =?us-ascii?Q?NgKk5plegCW2z+thuEnFUHA5UicuDVqg8SGFeM2Q3gZuLi6nCu4/UTNKvkb+?=
 =?us-ascii?Q?4irOBJNJS+V1B7/184HVOcN2iGfVH1XqUW8x/uROJGqouJmEX3gkoQqU6DW+?=
 =?us-ascii?Q?OLMA3vhbb9j9uzfzxz1ScJKYOWbDEQo7zgn/e4ap/GlPejB7t83Ko/eqD+ce?=
 =?us-ascii?Q?qY1yVUrlLTjYx6XEv9psx0zpyDbWyFvS4maxMyOxffluneBKzFojQZwZKmkF?=
 =?us-ascii?Q?clrV6OFOmsocsLxaqn0z38oNOY6SqV/o5mHmqYtX992mUNUOAJ7DwooQcPVn?=
 =?us-ascii?Q?MH86sKZO3f48wZlPTseUpXMUNmyRqZJgddjAhmVFOso7S8xkx9NiXhmriQl0?=
 =?us-ascii?Q?4fQ0wfZrVoH0eeEVMDPPzCtdknQ/wQ5U1VRjl2wv7KB9+DLVr/oGE5V1cNOz?=
 =?us-ascii?Q?Yj11N92wSQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78a3ff0-294a-47ca-104a-08dea9465e61
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 19:01:23.2888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi/fE1OHpyEVWpS/xnLJ3XXhD2Njc1IKFXuIldMrnRYD+XjEMfTlGDsUkPCnnwEkPgI8E6omyvKXRAYxxwoBnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8590

The primary remit of the eBPF verifier is to ensure that eBPF programs
can neither crash the kernel nor corrupt memory. Nevertheless,
administrative utilities such as "bpftrace --unsafe" permit the loading
of programs that employ destructive or mutating helpers, most notably
bpf_probe_write_user() and bpf_override_return().

Since commit b28573ebfabe ("bpf: Remove bpf_probe_write_user() warning
message"), the kernel no longer issues a warning when an attempt is made to
invoke such destructive helpers.

Consequently, this patch introduces a novel kernel taint flag,
TAINT_UNSAFE_BPF ("V"). Tainting the kernel establishes a permanent and
readily auditable indicator (i.e., /proc/sys/kernel/tainted) to alert
maintainers that the kernel's execution flow or user memory may have been
compromised by an eBPF program.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v3 [1]:
 - Deferred add_taint() until after bpf_prog_alloc_id() completes
   successfully to prevent false-positive kernel tainting

Changes since v2 [2]:
 - Deferred the application of TAINT_UNSAFE_BPF until after the eBPF
   verifier successfully completes
 - Added taints_kernel to struct bpf_prog_aux to track the presence of
   mutating helpers during static analysis without causing premature
   side effects

Changes since v1 [3]:
 - Moved the taint from run-time execution to load-time verification
 - Added "V" flag decoding to tools/debugging/kernel-chktaint
   (Randy Dunlap)
 - Updated the seq command in tainted-kernels.rst to check all 21 bits
   (Randy Dunlap)
 - Fixed a Sphinx "Malformed table" warning by expanding the number
   column boundaries in tainted-kernels.rst

[1]: https://lore.kernel.org/lkml/20260503164700.548164-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260503153730.541685-1-atomlin@atomlin.com/
[3]: https://lore.kernel.org/lkml/20260503035220.520479-1-atomlin@atomlin.com/
---
 Documentation/admin-guide/tainted-kernels.rst | 56 ++++++++++---------
 include/linux/bpf.h                           |  1 +
 include/linux/panic.h                         |  3 +-
 kernel/bpf/syscall.c                          |  7 +++
 kernel/bpf/verifier.c                         |  8 +++
 kernel/panic.c                                |  1 +
 tools/debugging/kernel-chktaint               |  8 +++
 7 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 9ead927a37c0..d26a8d29808c 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -74,35 +74,36 @@ a particular type of taint. It's best to leave that to the aforementioned
 script, but if you need something quick you can use this shell command to check
 which bits are set::
 
-	$ for i in $(seq 20); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
+	$ for i in $(seq 21); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
 
 Table for decoding tainted state
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-===  ===  ======  ========================================================
-Bit  Log  Number  Reason that got the kernel tainted
-===  ===  ======  ========================================================
-  0  G/P       1  proprietary module was loaded
-  1  _/F       2  module was force loaded
-  2  _/S       4  kernel running on an out of specification system
-  3  _/R       8  module was force unloaded
-  4  _/M      16  processor reported a Machine Check Exception (MCE)
-  5  _/B      32  bad page referenced or some unexpected page flags
-  6  _/U      64  taint requested by userspace application
-  7  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
-  8  _/A     256  ACPI table overridden by user
-  9  _/W     512  kernel issued warning
- 10  _/C    1024  staging driver was loaded
- 11  _/I    2048  workaround for bug in platform firmware applied
- 12  _/O    4096  externally-built ("out-of-tree") module was loaded
- 13  _/E    8192  unsigned module was loaded
- 14  _/L   16384  soft lockup occurred
- 15  _/K   32768  kernel has been live patched
- 16  _/X   65536  auxiliary taint, defined for and used by distros
- 17  _/T  131072  kernel was built with the struct randomization plugin
- 18  _/N  262144  an in-kernel test has been run
- 19  _/J  524288  userspace used a mutating debug operation in fwctl
-===  ===  ======  ========================================================
+===  ===  =======  ========================================================
+Bit  Log  Number   Reason that got the kernel tainted
+===  ===  =======  ========================================================
+  0  G/P        1  proprietary module was loaded
+  1  _/F        2  module was force loaded
+  2  _/S        4  kernel running on an out of specification system
+  3  _/R        8  module was force unloaded
+  4  _/M       16  processor reported a Machine Check Exception (MCE)
+  5  _/B       32  bad page referenced or some unexpected page flags
+  6  _/U       64  taint requested by userspace application
+  7  _/D      128  kernel died recently, i.e. there was an OOPS or BUG
+  8  _/A      256  ACPI table overridden by user
+  9  _/W      512  kernel issued warning
+ 10  _/C     1024  staging driver was loaded
+ 11  _/I     2048  workaround for bug in platform firmware applied
+ 12  _/O     4096  externally-built ("out-of-tree") module was loaded
+ 13  _/E     8192  unsigned module was loaded
+ 14  _/L    16384  soft lockup occurred
+ 15  _/K    32768  kernel has been live patched
+ 16  _/X    65536  auxiliary taint, defined for and used by distros
+ 17  _/T   131072  kernel was built with the struct randomization plugin
+ 18  _/N   262144  an in-kernel test has been run
+ 19  _/J   524288  userspace used a mutating debug operation in fwctl
+ 20  _/V  1048576  an unsafe eBPF program (mutating helper) was loaded
+===  ===  =======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
 easier.
@@ -189,3 +190,8 @@ More detailed explanation for tainting
  19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
      to use the devices debugging features. Device debugging features could
      cause the device to malfunction in undefined ways.
+
+ 20) ``V`` if an eBPF program utilising unsafe, mutating helpers (such as
+     bpf_probe_write_user() or bpf_override_return()) was loaded. These helpers
+     bypass standard eBPF safety guarantees and can alter execution flow or
+     corrupt memory.
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4b703c90ca9..b2e236a7ed0d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1698,6 +1698,7 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool might_sleep;
 	bool kprobe_write_ctx;
+	bool taints_kernel;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
diff --git a/include/linux/panic.h b/include/linux/panic.h
index f1dd417e54b2..8622c02c2c24 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -88,7 +88,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_RANDSTRUCT		17
 #define TAINT_TEST			18
 #define TAINT_FWCTL			19
-#define TAINT_FLAGS_COUNT		20
+#define TAINT_UNSAFE_BPF		20
+#define TAINT_FLAGS_COUNT		21
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a3c0214ca934..47bf0d10af98 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3109,6 +3109,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_LOAD, 0);
 	bpf_audit_prog(prog, BPF_AUDIT_LOAD);
 
+	/*
+	 * The program has passed the verifier and is now publicly exposed.
+	 * If it utilises unsafe helpers, formally taint the kernel now.
+	 */
+	if (prog->aux->taints_kernel)
+		add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
+
 	err = bpf_prog_new_fd(prog);
 	if (err < 0)
 		bpf_prog_put(prog);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69d75515ed3f..9d56082a2ac1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10287,6 +10287,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 	}
 
+	/*
+	 * Flag the program if it attempts to use mutating helpers.
+	 * The actual taint is deferred until successful verification.
+	 */
+	if (func_id == BPF_FUNC_probe_write_user ||
+	    func_id == BPF_FUNC_override_return)
+		env->prog->aux->taints_kernel = true;
+
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	if (!env->prog->gpl_compatible && fn->gpl_only) {
 		verbose(env, "cannot call GPL-restricted function from non-GPL compatible program\n");
diff --git a/kernel/panic.c b/kernel/panic.c
index 20feada5319d..1ae19bd8fc1d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -825,6 +825,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(RANDSTRUCT,			'T', ' '),
 	TAINT_FLAG(TEST,			'N', ' '),
 	TAINT_FLAG(FWCTL,			'J', ' '),
+	TAINT_FLAG(UNSAFE_BPF,			'V', ' '),
 };
 
 #undef TAINT_FLAG
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index e1571c04afb5..c0fbd7bcfcfd 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -211,6 +211,14 @@ else
 	addout "J"
 	echo " * fwctl's mutating debug interface was used (#19)"
 fi
+
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "V"
+	echo " * an unsafe eBPF program (mutating helper) was loaded (#20)"
+fi
 echo "Raw taint value as int/string: $taint/'$out'"
 
 # report on any tainted loadable modules
-- 
2.51.0

