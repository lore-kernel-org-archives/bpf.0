Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022121.outbound.protection.outlook.com [52.101.96.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9222F388;
	Sun,  3 May 2026 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777780354; cv=fail; b=nC/M2+N7ptIBL4a7iqNO7ACQg2UopbuTHRq6+FrfLjuHNBJGjouWce9XNRgTqU+r1i397TrUVwcdsmf5J5an98pyNjQiV2ZoeJx+ygX50qxg1XTtx78PqrQbfHhgSYBZBST+nJRIdOnT+k0cOAOLLnjwNuK+gEiohIuISc9hyJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777780354; c=relaxed/simple;
	bh=kZt7ZPnP6i5nAnQ32d4GG1jWo+411qqFyJodQG390bc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tX9C9UoZ+tfg7ZgNSH4whDg9tpzFfWp5VdnxrznEomU/EpWQTMX5yNEdydBzhXhdniV54ONKXiSR1OOULmwKIZ5qzZlsqxbs5dGfcKWRdjLY4OA1nxxnyTnX9zsvYCthHnzD1yu1tYBRtGZyPwubFReyYMBNhxO+bOPwJH3d46o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQm0pXpdxoYZqlF0Y3qrtucPDyzgspZFE6D24xCIEvFgwvcLbjI8bPmaQqj+/HppSiv8IGrHHNjVj9gBMI1Y9gtJ389fxZfpG680hTX+Pc6+OKG7ss9RcpAs6V4Fdg32lBn249W9daISLFBpmrxNK+Vt4zj7SKTS7QPdFqCq7gaVgISMPdApoS6b3WeRMQU7bhal9v+D6nwxGZ4LsJq+gC8w2Lzvnb4pkMIpTsfszbwu54EKDxLtSX/B57xv8JNa0rPA5Mtx/pi5vQzrtgKqsEMybKMOoBPdPOmMBmq0Owm90JgZbpy39O5BmreCMrRcdIjmZqBhu+RUD+PLASPN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDvV4t1kP/nsStQGYroN7fiMaILiPQpISG1Mh2ccTNs=;
 b=Dxt0EFukJZF1uBwIt59ITmbkSqdQrM1TkAkuppiFR7NkL25ewdtS8RPuBz9fuvFq9EuN5riTvvcEfVRddEAsyZbDdB6AaWh9b9us+ggIvcLhfNZHWQv5GHNFc2WoADb8dKX8oivKVNXK2eVPOQkWz3xFmZsjUonQMQwNhyYvYhCBJZN+R5/d1vBabvnvgMYIryP6txHk9GVmmXLCySwm4Ykt3yyrYoPgA/6DqC7TueyUg4D/IhFBh6FGJpqTq0vlhrm816OM2ccO9sq1N4xcrfNvRxsve8Vk29XiIqxl+teOu7e9HjlyGQHNgPue41IHoOw9UgIs2/RetiSQQpfhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB7143.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:33d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 03:52:25 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 3 May 2026
 03:52:25 +0000
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
Subject: [RFC PATCH] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
Date: Sat,  2 May 2026 23:52:20 -0400
Message-ID: <20260503035220.520479-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0878.namprd03.prod.outlook.com
 (2603:10b6:408:13c::13) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: d33d0cc3-5b6f-4e54-977a-08dea8c762d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	IuY6LN8i804q5BtyErYmKip3Pm7nhj66lDUwfNYc2ik6q/BudIJ7sjeJ3PUxfy0L1unqeZok2u1hbJ8qdrzzH35+s5gg2SCH1nkuFb2FwSgMYKdMrrvp37v5gQBkiRQ8bKfWvCN5t3aycCt+1adLvjwgdgzp9Z6XAkhbcv8HhyIErnUmpPmSPPFdp+wlU4WgqGSzGZHbmnK4K3KphAKZqh2NfehteW+/0rxGgj4OuDkUcZAQQ8cBBSTpqHbykzN/h/2fApLP2gQ9zia4p/uyNYKQ4wmxeYJ9EQnY5fOKK8NHr/xplnfhcaoMTWBSeuBjOt4s4d7SEiX1P5bt8rG9CVElMm8asoA2yFzqSjPog+TXwSF0V3KjepvO4TW+kh6/XsWqY42RSHqePYH0idbgFEQvhzm8BP4aseroCIfzsOPlt//7WQ5dXsJ9AzQd60u7PtqfMJqmp8GcY013U2rRr/FW9qsVEMOxCzs07WMJ0qiPdgsYafzBL3hKRGI8+g1yUCkavcVQ6Hvty8t+v/GvISyr0XdTwcR7NlgF0c9702GAXe6O6gPQaL/urO+J46vp2ofp8NSVY1t4hpE6MjpoS2FsVxvbkzq7k3WF8aGXo+B2GVCWbvJsO6pAJB8+d+8hvopI2pmmQ3nM5ZRDlbcp06Jn09VQPUtXnqAy5ZPui1WUBWh8iHIvOnHYyCUfGrN/BV9oF2dOCQnXf9bhp5l6cpWjnTObzcgQh0BMq1OBx4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4NSFHvIG74SQYuDmU6CPX0/ed0QjlGJNjox1T9q834bnPnjRWibPOVQXd6os?=
 =?us-ascii?Q?JZw5iqEGd+XyqFDim/tRYVX7MaR3QtjYryEGP3RuY2xzq5+Yv9XLHaVevx8p?=
 =?us-ascii?Q?khbaQzE4b8osVuJGDcnbdGX3mOaScPYEf1vG1RrnQ0TMlbBqObUfy62o8qsT?=
 =?us-ascii?Q?u2ZTMC7KMhzjj+YZkmUF+pf/21UkyrZSQ1/H0nyme2c9D2xslmxjgTzgsscr?=
 =?us-ascii?Q?lbf6ZK5GfA+oiOzR41miVuTlSclbxp5FGRhs+pHfgb+zDdsm/ErfWcyh4Iju?=
 =?us-ascii?Q?7Q/UASWcN1zdgtG8eRUpf5xpV4ElLucIDw82IQqS5Juuk9UHps6DLPumw+8u?=
 =?us-ascii?Q?/uxGhmpFX77AJAPr/Woyiq/WUwPZFVPg5EjyXAbXXfLpsehlz92WQSAGeNH3?=
 =?us-ascii?Q?3jiWYYf5Dzs/8XfAXYKYlg4NXru0nbqDmzQV9uSeKgv/E7uJpVfwKzonL2Uw?=
 =?us-ascii?Q?sbo5ira0uVryFXudTm6zz5H3+erKyDJwlq13x/a1QwmlPLguEGFrixRH3b63?=
 =?us-ascii?Q?8GXl86Sd57XDjX7NM1VpGOFxMg2NN19bZaim+Yb1W1HqIoZWl8j5YCYERMJd?=
 =?us-ascii?Q?PcRw6GWSuoBb5IIDg7wU3DMHV8IjnzaNoihtwS5c+BpY/tptdmLZiRZjfWKl?=
 =?us-ascii?Q?vSEon7aKyDQeDUqfAMd/0g4O7q/MLzwnpdYPcHXh1Q1MeOhXOcDVvWWbi/xi?=
 =?us-ascii?Q?KbSLfoqzd3vox9t9VTIvNnOX8Zo5Qj61nwrGatq967pC/vlJ6MU+QgXksxMH?=
 =?us-ascii?Q?89FTAlZIBOoP4qgK2kIWUUdkuofG1AiD6ZooAg2PdA9z3tYQDHc4AWvH7Gp6?=
 =?us-ascii?Q?IrUHKQdS1ftU4Fr1zRYf1zUo9wjBJihR5VBvd5eOZll+owDQ2PVNVdTiPh9f?=
 =?us-ascii?Q?TwpU0Y5GRopnBuQRKH2+ioFvL/ZC3bfkq+bLwtLyYWRVxVwwWYHrgoPoM5Bc?=
 =?us-ascii?Q?2Y24RkOuhnEWs7PCXSFgcEVcLQcCond/d1OPs2MnkpuvAI7f92aRhlRb2T0F?=
 =?us-ascii?Q?zFisCzVU2WEPo0I7BULsYQWfDAZs20bTQwcuFskeDQ2+0JEYa3JIrYRkl3XR?=
 =?us-ascii?Q?ou+A3cWJGkwG7BJCH5nh7I0Bw3nCMGhxMmANUhFj/6ijv6jWg/hY+6A6w3ck?=
 =?us-ascii?Q?iJ2HUsqwV9O9EI7lQlTv1WEsgT4yQnBWKU2TydeP5ENpS5KkMBH+7zF7thlw?=
 =?us-ascii?Q?fMIG+coODPZZEGsbzDa5+ptRW8cC4wR5wtzTPPO/vkfWnDq6Zsff42B6H+Yn?=
 =?us-ascii?Q?0Au/d76QA/R/tF1xJWRSXoTfizNFsqEOawoPZOOojAhxnSNkCXzAhA/NpaRp?=
 =?us-ascii?Q?+0dfSDEGP+bd19iktnG6h87bmkNzFhDmvTHIiVjk4K5DVp91VEaeZr9f/e5n?=
 =?us-ascii?Q?tF7zT3AbTkHoCd+khUh7rT49SgXxFN7YtC92ga7FVrmGcrZqx3b0uIyfcEgT?=
 =?us-ascii?Q?2ykbiZSB2qzFTnlsUDo4prKnu/6q8JRspjyqOzgL3RzDTxdKAC3OgH6Z3OfG?=
 =?us-ascii?Q?iM1LLp9U9O1pcSQzF7VsEMXu1RRSVeo7OrVGyystSak+FvL2iUcosIRJT8WV?=
 =?us-ascii?Q?3wFqPsIZ+Img2Ut1MASuH5NOvilP+hCJtFoc3MYFoFGs2S64CEbAPnd+wQiP?=
 =?us-ascii?Q?fAgFRvbZ8USh6+7uLjByNr6WLf4q18R4r+4jmwUFrMWPeOwqE9lJgmgYwa5f?=
 =?us-ascii?Q?AyRAozoZbSp8hi4TDIXalNKXeQ+zZZNvb5N8s6jEjA9XjUPj253e4bEZ1RJ4?=
 =?us-ascii?Q?4gSV+OB57A=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33d0cc3-5b6f-4e54-977a-08dea8c762d6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 03:52:24.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: www7o7N5Wl4GsUh8xls1CVHIMiX3PsupiBsHcfzzTO96vEeHZ35HlfbRJPfmVEL777yXFd9vX34crEp3LGhX4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7143

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
maintainers and that the kernel's execution flow or user memory may have
been compromised by an eBPF program.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 Documentation/admin-guide/tainted-kernels.rst | 54 ++++++++++---------
 include/linux/panic.h                         |  3 +-
 kernel/panic.c                                |  1 +
 kernel/trace/bpf_trace.c                      |  3 ++
 4 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 9ead927a37c0..630f24996e7b 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -79,30 +79,31 @@ which bits are set::
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
+===  ===   ======  ========================================================
+Bit  Log   Number  Reason that got the kernel tainted
+===  ===   ======  ========================================================
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
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index af7079aa0f36..4e7e5bf76dcb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -155,6 +155,7 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 #ifdef CONFIG_BPF_KPROBE_OVERRIDE
 BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
 {
+	add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
 	regs_set_return_value(regs, rc);
 	override_function_with_return(regs);
 	return 0;
@@ -344,6 +345,8 @@ BPF_CALL_3(bpf_probe_write_user, void __user *, unsafe_ptr, const void *, src,
 	if (unlikely(!nmi_uaccess_okay()))
 		return -EPERM;
 
+	add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
+
 	return copy_to_user_nofault(unsafe_ptr, src, size);
 }
 
-- 
2.51.0

