Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022075.outbound.protection.outlook.com [52.101.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664D2DCF62;
	Sun,  3 May 2026 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777826828; cv=fail; b=ZeRDiMaocpeYgWqfxafDWmiAQpyycT2HpuNJSTrP3qWmeUn6DJ6YhOsAPJHfaz04xw2ylMRnVlZzDBEpt5OdL+3d+/V6sos+El6ZcA9PBYvLUq4Ms2qhlAV2UNO6X8BizvkgxzaSqjiU3KEWK/4E2ZKroqPdOv3FH6n+ZcHETLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777826828; c=relaxed/simple;
	bh=oSnFpbWk93IkA+A2u2x7q5f3rembYapA3ZGZJcMPYoA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VRla1VFls3IeI339ZHsTLOPXTtQ6nH7Yug79gFrY3M8LMc9uMztRdxZj21lBwhiagUhwK3X5fdfbJWGhWaK4xM8FoiW7VNvyXTRkQj4nuap2ItJxRQa70dGuBeWu0RBT4yFAtzQmT0bYKitIKqbYxsE9fRNHRmx4teh6lI3rXU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScEc0Nd5ZWNRGtrDKLLvncJ+YJnnNKIhS/oqXuswogAlhIA87jgvvidpk6Lep3RaOR+gKfug54PTvqHMHZrYxfXY28az7wRMnp+EMjKEf5Ex7RupF3bI3H85ZeeYPLSfp4WbjvA6t5e9IJPrYtTbg2xv1rHqlWXyAMA0wDzb99HDdjxlCRwRgZG95Bi+HkOpeITBWKIqNAZMnthYxQtRkrUzPwiQ0WN8phweqqHzIILRuxbLHsNR9h1E5LitWCoeefx5D/l4wQX7bXJrJExfwJp5pvPYNjV79LrRi+grqL6HhjHJTjXOiwlYyLpFkl1dSVl2P31WaVMeq2pWForndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hi7IOF9ztXtqMtd8sTwaQmdsj2IkSZhOy8jYNUe8Plg=;
 b=mNG3miyb2SgayF1v8dM9JZUlZi/0vyQj2xQ7EkyGG9wSy3Pd0JESHqKa7Hjhl4HZcApTn+yAXCylKneE6VBQkUnkUbbrPrQX7zpeEEiK1c3DPyck7faHqvarphFOmyXavs0sFVgsrRfswoVsVplzlSUT5XkycZSd3XO8o2rVqYEUnuwdJ+TAjhOxPLm3qD4xJ6oowwOucW5pJSWdMVPq0NtlewFgCd4rfNXFVgFDGp2xkTDYSoOoeXUSC1RlMMsPVZhYkqDT+h9U14SxFzGISLcEV+tC/SJ+eglgbvBTdFt5EZ6RpzEsevP5FGSeIaOpmfXZ5xttkl1ZKfUpYeQ8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB3535.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sun, 3 May
 2026 16:47:04 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 3 May 2026
 16:47:04 +0000
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
Subject: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
Date: Sun,  3 May 2026 12:47:00 -0400
Message-ID: <20260503164700.548164-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:408:e1::35) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB3535:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4df9f2-9490-41d7-f737-08dea9339ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	4VflK8Jm+o8ff1iaY/zNDzDN4FfkZpsaCRmc7G+0Ga7OqiJ77kwRg0e8P7yaunfTuovnvWPSk8wE4jVJqe+zu7638GsDySJH+u9XFRDzp6DX9RvowzZsw85sszJPOvhT76sYGmH79HJ91E3bRw354xmOsHsZHZuMo1J0GTMAi+uSzfhnWmk4qND/7Mmu4z/LWLzPUK5eUt97FSfkjwDEaXykugpeh/V0+rQl202bI4pDgNs9djlluGAFi6GoGptc1uej+XGngwlySCkJm63lMQighVd/HiasSs7fMn50cX1QzDbSlgP6eKq5Y5gycbp0+3vbSh12iT8uH6DvALXIMSzzbaBPMTaUivXEvGoig3puPV3/tLXhi3NMMCORY2TKWIb6JJwkQehQ8kHH9TbKTTuj6ZbxdmqDTPKDjGSB1nf3UBaCRyEnlF6j2Umu8efasfX1x0MpXEY+aoY8Z23+9FWBwj1kH7oejceDJU8YICRF2qftmaskZKIwxBUTI0p72P04T09lxTWoR7dbh+wdaorMp8ucZcxeALFNdo+2J6zRYx9ZOxMxe9V9BSaETZ9+1PNGhLhMv+0ooL08FcNTC0dXCC9Su6tOIrv0pmaMKE739WvRX3041hYo/1QLBAJhioDGdBWQlcauKq215zAcP+r7ssXKR/fEKOGKpObsjaSv6IL8F/+gme15mEHMTyncF5KnQ1cBU+XE450RvXMm/LPOh2ZbanhBXZmpUvi9IovydPYGHx0hMmO7IID98cba
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8cxQlcfwVqDyjvVZUD3spGCAxWuuneI9ZQvAldsbWYtl714RK3OBTG3jhAKs?=
 =?us-ascii?Q?rdt0EREwGyn4+oYiOJublvKLLoCm/xY5hlD03Obq9qSJNbZzrS0VgOpfi5No?=
 =?us-ascii?Q?DFCn+TNA0vXk9Z8RSDjto07c/Cd2LdXaKdEzS33ox1/t44JkfsDPC39nKYwo?=
 =?us-ascii?Q?0NkYr56VKJLp4EwPBlTGotCaYYLb3XAa5iiU4rNXawub0NAq3aA5Kl0mhhvS?=
 =?us-ascii?Q?Xc2wYeeBDh9mvoJBk4aqrByL586AO9wn++QzzxKkAAJtZc2rYtqRsjX082FC?=
 =?us-ascii?Q?B0+mB0arLJGN7k5CWll/xP0KGnTXjz9sqWN9+YCe1zo85s4AC/nNCdRpFaIW?=
 =?us-ascii?Q?Wrmes0fF9tXO3AqsQdBsDDo11B6mQKMspubIWUZErzh6hN0cgwuLqL/mlAod?=
 =?us-ascii?Q?kUj0J7nFa4mlwpVCf6UJ18BUBhhlLwQ6k4VXVwVXmXdjlTx6rQCaonR5FPBN?=
 =?us-ascii?Q?q8ABtnawVmbV1h3/1qS4VbjKCcA2/Aqh6bRQbvW6S81sy2L5YFLZSnhniDty?=
 =?us-ascii?Q?XL7A8hJnR3wPb74r7zweukt42NOs3ffIPzadR56HYWvTaoiGB6u7wH1H321h?=
 =?us-ascii?Q?YdQbIqtVGvEBgBCwacqHRd4dnaz5lKNeHGGzcumR7w02NAh5IdxcuEXGL/eA?=
 =?us-ascii?Q?deTTua2dFwlV/qfyfADpdY21LfgZcv2WL237Q5I1HHBvNz59q658AJwzp7Xw?=
 =?us-ascii?Q?K8igrFAkzFPzlYBh+q7A/I7lzXH3G8ufPcDCALQEjYglWx9UdpKpKZvdkNWg?=
 =?us-ascii?Q?zkSosXLhybowRTMostEPwr+BQ7R7vUMzC2ZixT0R3qf3eJDHVDMpaXkNFNLu?=
 =?us-ascii?Q?Avs1+lrGVuxWipwE0p6c2/C+7jajeqLOqtAjigrTV0J7A8d+FyPJOrVtJywZ?=
 =?us-ascii?Q?/a62nJmnMfi/XU4oEEgydVUrg7smzmNvcOWv9kAQ/AFD/IakdI4Yr+rI1rgp?=
 =?us-ascii?Q?ZLFJ4YFqMz/UbrV4rXkikCp/uSDSjTPpsMmRewp76/MBnraWDavggy/YuAzN?=
 =?us-ascii?Q?Mm4rJr4xpp/wiLqqX3tqLA0VUQ1vMtdR92qJ9CLjTb0VBnqwihiOPD5qbnl4?=
 =?us-ascii?Q?K9vuK6j6tqbp+3Vu22/PLO9iVcfajxQk+JzHV1/Wt1MdnjPNgFS2he/W0IcE?=
 =?us-ascii?Q?s5jmTMCyB5wdBn3pFqeY/tb+u7nToGmDR5Yg4Xk9ZHz/G3AUIYfZkEFHCFNc?=
 =?us-ascii?Q?0V6FNb49df3BXVYbIr1R8vNOwQVjkyOfMmkr2E9XCzwiS2v/JscNP1s1N24U?=
 =?us-ascii?Q?b+mdW0UxRuMEsYNYgRJe5UTiT5T9qzHYZkcmzFqQqA1+SZEObW9gfcyfxH27?=
 =?us-ascii?Q?q6AMQgznDGzduCgTit1vWz3XcIdWae735urZZsjP3FMzVlepizxgyrO2VoRD?=
 =?us-ascii?Q?wGb2lhVCNAaUSwugtLjrejjqNE9rLC+GsI9Swd1n3+6LaCYoNt+A05j1vtdF?=
 =?us-ascii?Q?JaBEH9FpQm9g3Oe/MsGoUpnOPq5E2QFkh4aX2XXB+4isYZUQaTzcGCdceCHq?=
 =?us-ascii?Q?V2h4LQylqpBJtzQZ8s1kXpR9xq8IzzBt/vxGZ3XdqNbBhKxGd1C6LpeP1gOH?=
 =?us-ascii?Q?8ywNrXoNm5teAsOakJj33mImdgkHHbxWtesGtnzZ5X3r1yfEg7sTTXAz5RAR?=
 =?us-ascii?Q?UkwcPc849WtJzYLrx3HA1Kh8u5oClUmZGAFwsuJLJcct5vNrTjNzGVlIMm3P?=
 =?us-ascii?Q?9E3Xeshmbj4/J7QskNMutC+PUnkWWBSbnFNaUtYlp27OACtedUFIQkQpTaBF?=
 =?us-ascii?Q?CA7uyJ3pdA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4df9f2-9490-41d7-f737-08dea9339ae3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 16:47:04.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkIk8Z1vTYQ+JCC5wK7vNPPsQjKCwQ5xUUZGeqGxHxc/2v1JmzVu/nA3x71d2fondznD+p4ixaPHUjvf+AoW6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3535

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
Changes since v2 [1]:
 - Deferred the application of TAINT_UNSAFE_BPF until after the eBPF
   verifier successfully completes
 - Added taints_kernel to struct bpf_prog_aux to track the presence of
   mutating helpers during static analysis without causing premature
   side effects

Changes since v1 [2]:
 - Moved the taint from run-time execution to load-time verification
 - Added "V" flag decoding to tools/debugging/kernel-chktaint
   (Randy Dunlap)
 - Updated the seq command in tainted-kernels.rst to check all 21 bits
   (Randy Dunlap)
 - Fixed a Sphinx "Malformed table" warning by expanding the number
   column boundaries in tainted-kernels.rst

[1]: https://lore.kernel.org/lkml/20260503153730.541685-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260503035220.520479-1-atomlin@atomlin.com/
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
index a3c0214ca934..34b25609e72b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3083,6 +3083,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err < 0)
 		goto free_used_maps;
 
+	/*
+	 * The program has passed the verifier. If it utilises unsafe
+	 * helpers, formally taint the kernel now.
+	 */
+	if (prog->aux->taints_kernel)
+		add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
+
 	err = bpf_prog_mark_insn_arrays_ready(prog);
 	if (err < 0)
 		goto free_used_maps;
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

