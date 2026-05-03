Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DB269D18;
	Sun,  3 May 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822659; cv=fail; b=uAQhQirziqZNvl6EpGrVhiqVi9CInRNBXb1FBaPKe0M66s7Akj7kZZ96XygsApLpsHtNBfwWqe7N4koNV4hXtosPAaa1oZpBJmGadxnxf7NUhKyIdmE+hx/7U7kMWtHY8HtheDkIf+O+x5/NVC4GxX3nHdbxwilbypJPN9yTFxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822659; c=relaxed/simple;
	bh=EjyuMHGg8JTvl/X2z0RATRMo/Iq/Bl9zkJ7+/eFHhFk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I2WIc5+XbVctOrvWy6PlxKLOKRmx98nr83xMlhdvqg2ahV2R97gQaj3GP0NxNwZW49hH8EFV+O5xAJAC9AbfjeJ3SZ0F61QhNjuk46afwFlMmaAZW86wJzsnogUifJw9eeMOBFMuMY2vshvLjkIHtyNYgb1g7y0XVSWWkNVXxtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdCHqmLqMlYAAdH0rrqfnjjMzBFxhZAsdcZoYlFw8elhhJt6syYeKHZi65GAEV0C3ifGriXkIOlbB/SSxAdGoDsKeCDRGMRnBP7QajNSapEfUNVacZSWcmUQFQ+5R/4j55jHWYiizGLVfShd+aN6+XLWsWSK4TfS400bu+KhClAX7wxlHpTME+pbkff/YUUyA6wl6vS97jZz4e6QsCa8hO1NU3td9ngPT+JCKBAMvKxYRxcQMqVZVDw1weCTGEEN9HFHCVNl0uUs+zYdzzk0Tz8Z6XpVMN8Fuxt8VV1pS4ABK/jlmobv0fSmmoekkg0GF4A8N3CBfl/Jx9zD2rXgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNDg4s4CxElRJ7ZQ8/5ti1QR2j6oH79ZmmsCBtGcQoQ=;
 b=zG9ieQgP36NvZznIHPaillT4cAl2nyEUAv57M+y5GHr5eFUv/nQhXgqhrXBBCr6gleo3AvjuEsva/bpLoqwRSF9KDArLP4z0C79Mw44xGzglbjOTMYB+DN0o6eyKZfBq2G5zh2IBIa/xCN16FIjaUNNh3nBTQ6QK/5wNsAqKpHwE7jv7yPG8jcwLELFloxWN3hIXdxS1ScuO3bzavDiwwl7f2HaelryXD7dHGPCB5zj88dd1GKZWJpH2YtR2PLafh0Bzf1rk7nZNZAYTxL2CGxQfq2sskeZWJooAGbLWIok08Yzzi+O8MP3fP24NOl1uSwSUyS8mYlhutDd9fFjp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4066.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:8d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 15:37:33 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 3 May 2026
 15:37:33 +0000
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
Subject: [RFC PATCH v2] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
Date: Sun,  3 May 2026 11:37:30 -0400
Message-ID: <20260503153730.541685-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0667.namprd03.prod.outlook.com
 (2603:10b6:408:10e::12) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8b956c-dfd6-4f40-ebf1-08dea929e504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2dBc8lxmb/aoOfklWEL9LG0KhKk2kgeWTffiyI0iNnSC2XOiVXE/YqryKZJf5Nf9++86KRM+MlEUO20GQ7lg5ls3MEq9k7padW/DmLpxbZ+c52LiO5DJOpXrtYIYF/RBwID/QU5UZ41ZIN+i5u8Mj0F/Gn3QGYG5l7PlhEhYnwDBZkCih42QLmJ9yAQsXn6kymJKJtREx6Er53Pbfh4OzyhKdfjs/SO4FHVIk4aGFBeFOKqbPUxZwlcproMIYNPsgXngrnsbnRTXqF2ra9JfyzFECYsJ02c9jT0Sb4sdf0qUihVr3o6wPhcGWvL98+oIDfm8fgSPHDO9koEE7yQmpWBDw0FJe+B7wctQLyKd35paBlVzx9OBQ8YobPsVXzLKz9e4I2RACj98rBB679fHRDYUF6T4L7COr1SC+a85PU6x0B0aDWnF2I6ojdtgT+IqgQRcGCdEAWvH6c8BLeWH7/1dVeHx7KRL8nt54XqKSPoqwFaVx6eGAVhSa9pjDNYWWK8bWG+QWuCityEyioZ4nx5vrxMm3tPL3yYEQFPVu5EZ0OMnZPQjc6JQIgFoz77FJpNJruaLg6r+PQ+kURVXmxJNLEYg/Eww39bKNVQdbgk+/hjWNQMzoEE6ruZapR0AV4rlz0mCX0kYXULNOJgcy5qqwLXVdAHd4h+yzMYksTTyTZEkALK4uTQjowIiwYEQIsqbIoKMuxnAno0D0Ht4GbkuPig4GIsjuLlVf37TQb1bat6guN7FKmuLCyuHnb3c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uz8p9Q39ooE4QgCVNezri4ogcGUSsfL6dZZUQSKtiLhi3s7n09vssgHzRif4?=
 =?us-ascii?Q?/8uYBYgiC3pbbkWf+hUcb9l5pJTwKR09E/+uFc4xYctE2td7z4IK2HGooQIC?=
 =?us-ascii?Q?7eGt0yXv5KVXe6/lOlbxELzAO+arpNUWL0IIeOHbvMigRg6MlNOaYd7csBDK?=
 =?us-ascii?Q?l2JNdoZstOCjGfCle2/nikHscBqmkhhf166iV0ygGlmXc7rpoGQbA+wlZeLE?=
 =?us-ascii?Q?Deg0b8zCKsIoBsAuH5BSIMdOdXeZqEyjSttV5UGE1CqCg08A0KgvzjFLgcrZ?=
 =?us-ascii?Q?MypkMH3mQ1mkDPHayCKtdVycBZ36U9MPGlquVFcvfNQ6p9p612+6PbKLUGWh?=
 =?us-ascii?Q?z7MzobsXVoLw11ptdtk0gd9gy4XYIoZ3bCMuSoMwdLadCB1yfAmPIJxQUIyU?=
 =?us-ascii?Q?zsVhC/Jfjwd+ZbQE1G6SliizEJIoAzY7xygqMepQnik+1y9FdKafTTdxaobS?=
 =?us-ascii?Q?Qld7rk8TZatB9Lqh/D7Omv8O70jTehIURJ0FeaVDbwQK9M22uulqu6JC+YDU?=
 =?us-ascii?Q?miiPi33yvYqdi9od/+X7KSDEDwa0IfFq/2j833c5gx1IKL2a190MLzwd96Sy?=
 =?us-ascii?Q?EB0fqFbAIWyZyFuF9/uSqBS5eszIOiGn5i9X3c1mQKqEt73HOahqluFxUFLV?=
 =?us-ascii?Q?Nkel4LlbHimYDU7L1D2HtVDxI7yqGxxP7zb9YS03AkJhUxCLN19cwhTOInMx?=
 =?us-ascii?Q?RATgySm5OZL0wYCEFXekgyGoJXacgdwHC5pXdZXZ+IqdjCpz2TPWds81mSmY?=
 =?us-ascii?Q?q3kd3sZxh6RZKtY3Up1+NPT37hq8oIAUs2NzsOBGpSJJ5WV0Lw/ju1K+2Dzy?=
 =?us-ascii?Q?HJHgmPDxXN5v0Gs/O249AhsgIH7Cx1Gge4c78Az923AyV2RzyG0DqCES0C7S?=
 =?us-ascii?Q?/1YBw1vcv9y3FVBvBrddH7xTnHK4SqYf67Dry19qqlT0e4HGl/alTFsl9o4T?=
 =?us-ascii?Q?y/6+HVpKlmTLrxJEkl9CPjmRudkixLKh0d/abbL+Ucyo/9GEKO7p5KoOzV3F?=
 =?us-ascii?Q?Lijc1AVFcD92iSGpR9IpBYY0F5xq4aM2/gbdu5Xfsvbo7kI/xlb1W66UPYid?=
 =?us-ascii?Q?6xc5J/vXu5jDsL1VBwTmBf7yhEOL21ilPd0FWaP6Yq78UHQAG0fOl6oHp3l2?=
 =?us-ascii?Q?ca8aPieINNf8woXLFLcHHIG8OjacKhQUMdQFOCxUNYAtTydVoKrApba+r6Vd?=
 =?us-ascii?Q?pMpVkd76cAp8CTFFWAuAN5PUuYpR3RAh83fSCNuqkxjqOimYRR1O3o280+ae?=
 =?us-ascii?Q?TU74l9Pb2lDetsvL1yU+hYTQ2Zq0YGjpbgcpw093iJg8LYZz8bx5sHfY7bR0?=
 =?us-ascii?Q?az66aCsS5wl5P3+oKiGLuwf2sqfZtyHr7mWrK32OWYROR3yXzzq13CL2/Lf9?=
 =?us-ascii?Q?McH1CgGD9pe7qDWazhPFu5ZIGqHxrUvL+kWO4Cc+w2YbOFI+INgyZXcK7HTL?=
 =?us-ascii?Q?U3p3AAx1JRbSt1Hkt7jVqI3RIGj7YrncN3IihXy0xiHZBzbew5XcmhP7xoHO?=
 =?us-ascii?Q?j/q/D7O5x/XoDX7bPSjShPB1auQxUhPjaVyUbKYDwNanPWODoQYSzy/0f0tm?=
 =?us-ascii?Q?y78jpreWnNPHrVMLGdCLCcTa7WKBQ07IOLvu9vTikkzTnitag8S2ZARHtOB1?=
 =?us-ascii?Q?axPXZd4EnO6h+LdWx7TXlkKDwNt4GeEDNkSWrizoWxEdrsGdIZwbePUUVTLX?=
 =?us-ascii?Q?619omkR3rdp+8cNlReZ+kqe001f1zMEfTY/Ua/MSeLHWKzqJGrMlUMpKNhH8?=
 =?us-ascii?Q?Pb+yOkDAMA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8b956c-dfd6-4f40-ebf1-08dea929e504
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 15:37:33.6545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ifcx49Brgsou469VFAJTANVmm2/KKLL7I+1S1LpUV/7XfkmjEZKpg8viqfE8tSH8b7HTPDyqZvjiVbGbUIp2OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4066

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
Changes since v1 [1]:
 - Moved the taint from run-time execution to load-time verification
 - Added "V" flag decoding to tools/debugging/kernel-chktaint
   (Randy Dunlap)
 - Updated the seq command in tainted-kernels.rst to check all 21 bits
   (Randy Dunlap)
 - Fixed a Sphinx "Malformed table" warning by expanding the number
   column boundaries in tainted-kernels.rst

[1]: https://lore.kernel.org/lkml/20260503035220.520479-1-atomlin@atomlin.com/
---
 Documentation/admin-guide/tainted-kernels.rst | 56 ++++++++++---------
 include/linux/panic.h                         |  3 +-
 kernel/bpf/verifier.c                         |  8 +++
 kernel/panic.c                                |  1 +
 tools/debugging/kernel-chktaint               |  8 +++
 5 files changed, 50 insertions(+), 26 deletions(-)

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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69d75515ed3f..cf0634d8901f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10287,6 +10287,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 	}
 
+	/*
+	 * Taint the kernel if the program attempts to use mutating
+	 * helpers.
+	 */
+	if (func_id == BPF_FUNC_probe_write_user ||
+	    func_id == BPF_FUNC_override_return)
+		add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
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

