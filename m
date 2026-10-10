Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866C39CCFA;
	Sat, 10 Oct 2026 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672572; cv=fail; b=frIVplhLaJktFD49/291N2SqXVPJsl6V9ZaURFon+RK5TqGyyMJc+BovIg2KsNoLd/2tWo9BvrEQnX3DEKCCjNH31CKdlwENH83l7VWrhyoTXmOCU5qc3aobg8w0nrOtPo6jfjTU1zlcbnJ6H7R1N+eCEiKbRqNA0e/D5trWhDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672572; c=relaxed/simple;
	bh=FQ5FvwzL+Q83c5fBs73vEkuM2+eyKIyjckWRiimjQz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BgQfTIwj168kIDPFmQBqFK1X0Z+XAmsxDSKAuvF9H3teNT81Z2AzN+6tqWdz+KTfVvvzE3vdJKepp3XkKrzEwQ/4rnSUUBBYY4BoJrBXbN2n1oGa5dDv77I9TzaFmTkUIBi4aj/oLfLTbUNtxMRLY5KMgP65cIVlhvv8t8C9/oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SchdgU61; arc=fail smtp.client-ip=40.93.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SchdgU61"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgOAGLC6FIBFj58xf3FgAQLoyDTgGPGwFDxzgZ8SxB5SMKf15DwtEENMyI1iJyqS1g7L+DCRKrbOTWZdrbSUY8u2T+qoExupYn3PBiFU6UeGnFN7+zhnFo6+NH4QrRkn68H9o4HHax9eVINsrOuHCl1TCGkMm0shuCCUBpHyxmutq/WNn7DNLClSzQ5ZXWT7rG278ShKB1G+yI/VJDx+yzB90TWjOQwaJ4g3CJrmIY6vlKFaVPordZ1qUgAJJhz5G1Z5QHWV824K9E5vwxkl9OaId6u5yznQ4VhnGLW9j8IwQVhfo5RDxqAl3TIsVpMKLLe4uzxPIfp7KK+yDCP68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=md6L3QUglkgoqWxSmZjW6WKQ2EJGTnkPGeHmea2sS5U=;
 b=waU4nDLKV71qrqNxgX1V0XVCm1ONqYuO7uFP53WNF1YKdG/5qE9mK3d55QTIb1TtkuNUd44+nIazI0r/1iv0Zr46xOJ5VsiAwrzhc0jp5x1RePqfbAjwApiGHXh4gzEkhtFB/U/fCzfcGyEOntd59qFAJCyEQU7b38IL6ckzWpYJFXDG0tlPgdLYbrdyjJpAGbkU+0lWS1nMMs1nSbjyIJw6Q5KFLCcDW5pTLovmwhpAoKD6hUo7AWERHgOTEXZTbe2uVDyvTwWQ3XyaEdd2KCjR2n/bhXs+BoBwAtGoqfAlvrBSEQH/uXtvuhk1tL+eB68mEB2uZotlJZbNSnFSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md6L3QUglkgoqWxSmZjW6WKQ2EJGTnkPGeHmea2sS5U=;
 b=SchdgU61h5+uvvJuYbBRKxi7rg0OHD1r3EqSEhjDVuH8xdZqxngHnM5HVuMlwZ0k1ZeJtixT+PTX07RiKaqtjYzKfAqPgmr8wgaTAFMMNBPhmdBPCyGU47HRlZOKugfn1b5ggAW4ojgRfl8m0A3/jk33Z6yOhmtLCIJCt2XHlN9R5XL1JXBMiUdE58N02vkw0HP0Rxad8EwCS7D6GspllIsFdbm0CB5h+cZwYpRFwfeeABW5PySvoQaS/+XTYvzSJaar69bAC1D2ec4dhZEJ7uRp5nVbDApxTPNIftAHLc/yQPfvBkxAkTKTVwVpxVCB6exkYMJGGJ70Nu4lpiXu/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 22:49:23 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.018; Sat, 10 Oct 2026
 22:49:23 +0000
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
Subject: [PATCH 4/5] selftests/bpf: Test pinned arena file mappings
Date: Sun, 11 Oct 2026 00:45:59 +0200
Message-ID: <20261010224902.1232178-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010224902.1232178-1-arighi@nvidia.com>
References: <20261010224902.1232178-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0089.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::22) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 174c4f8e-9403-4596-50a4-08df2720ba5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|3023799007|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	jJquAj15wD11b/m3M/BotuM5TAYGUrOuThBwDL2FCJhfNySpAnhaE95E6At+V2l/4kzd68sSdqtz0+2FpYSDz3ydIyZE7Y+yaI2t49vd7IRF88M+UfvJEwvYec5RGbIwuFmDLDrgbLyL0Lj+zmR+KGXyEklgmPhdnZ1P81CEHa7cxtgSAqGNwX0d/AT6tE2vwenHITf66j0Vl6lZesugUCcaHiqCzZ+3Kfx6S1AH6PUeVM0qhPeRztGDw20RZwPbT3eBkvmIM+Go0uQQaBhdkpzDgtUEGU5CqJmb4bkGYUCVwfuWLX1FYaU6LTTY9DWuHkuSQzFdIQVa5pWnqfm0ETme6xgv3LVGk+6UajB8wRS0NQKi5WLtjC7nUNSa5ni/sKvL9wXrNiMhRZcooFfHs+ABT7URkkTZMEacZD5biK0Yimembe0MDhClNgY4uu0BGvqfVQwpYJpTmloG5WxgBsdlvlYhF7ZKFJ6KAfcoP0hc+Oc3sCCWf70a5Kbs+sdYkCd7d2R3WTsvvSLS/5gx7SbI5qBsTrkB36//DXgfvU3Lq0cRRFTutCZeMHrMTW+dySxu0sFMSdshdvuI3An/gjj/wJk4hct+7gvy8YcJHvN3CVstdQaCyLXlwSihaZz0YymHWjmnW8ZKZaHOdcObpFG80dTRZ2v6xYwZSRBWM7A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EDh0Br2OAuLTv/oRDkU3ggnxaDdnOBg2VW818/UVyeW2QT1Ry609c1yEf27R?=
 =?us-ascii?Q?7OmjFpL97M2xmyBcaef/Cb+8alfGlNYew/DRLzOKPDOkG4bQu7n/n4oeqLWE?=
 =?us-ascii?Q?4jdCOfqn0RPax1XH83A1Vn6CM/0xECJPJdAP/VQzsPsSAc1sjNKVnZEbWSAC?=
 =?us-ascii?Q?HQdtDkJWoA3GWsEeVJNQNmNl4nHpEhbRumCnbeZFLcR+F2Z1cgUcWMX5ZwQY?=
 =?us-ascii?Q?86SmuTKYbUqzmZOwl0kKTmYcBzegIFnSnptuXIGg8mX6d+cUWxNAUg21FHky?=
 =?us-ascii?Q?GAatrBIFpjY0gaixbpTcX2JCdH77FloXsR5Vzn7+UjAbmgkQLtmdUBfG6xc1?=
 =?us-ascii?Q?28spAqwfrGrUNfV1easdD5rh3z+51VYtf+3CzYSAZ+q9FW+A3xV1+k+UkvIq?=
 =?us-ascii?Q?0Ij/Cz+/hY1rUDF6R6GkAWj5pSq+m2bknCjMgQLYdlHsisR7a0jCzx9E20bB?=
 =?us-ascii?Q?OF4ZoZh5Y6B5Kizd3pcEaWbM5WPE559c/QFMx7+O00VTCRoAYWJ3HIZRYMmN?=
 =?us-ascii?Q?5ALduJ2WeKtaI36+iTPnEU3ZUTd7Qvdj+dMi+wETDJMfmpeMeA057qYzuVhK?=
 =?us-ascii?Q?oeqDycgNcUbBuNq0jxRZL/6R+lPe7S2aK+cMe7wIw4kaV5atXdX5aIWkQJM7?=
 =?us-ascii?Q?vsYQPD76N2ZsIbCJZtlSU/thQEaCyH/0HjNc9cQ4RxEHVToYqDx3V1Qeihf6?=
 =?us-ascii?Q?vb6oqnqP42IleZxlNxoV9ddBLM3t8ljKbQ+VaFwjnWwZqm72DaJfMdXNGxJo?=
 =?us-ascii?Q?0CGxIHSf/FxH4eL0PkWidC0VrKkNNGaRyXdBUJoRNoRzopIF3ePy7Qeo6y/n?=
 =?us-ascii?Q?tfngnyWL+xRL9Lma3+B/yO0fGfkWjuOkrRMfKD82RIFchMoea4R/NMQcC2E6?=
 =?us-ascii?Q?kQ1kyJj0/I2AToZD7tZQBqdNK2+WEXTEHM/eWcrtHf3C5hC6vFnq/IEkcd1V?=
 =?us-ascii?Q?Q/pfupOvJxWpd0+K6uxzYgw/5eiejMeRHZwJRWKWr6vEBjZAKw3QBR4Fwu7p?=
 =?us-ascii?Q?fS3n1Dve1viUaMXzLlaFuJvXq22/URoR6/HVKUQc8mRGgiyk9Ng3Tvg9IkJx?=
 =?us-ascii?Q?7P91ZNgy9XkEFr5Uc/imTntWhvlgpNCUn3TGhIj3/59HMdA5JXem2cPDoo/0?=
 =?us-ascii?Q?SbbO4YH0IqUcKxWxhAClJfDny7UUQR1ACKnrDXpWRclVYsWdFJtuvuolzTCI?=
 =?us-ascii?Q?ZauMedhHrnIefcaTWAR7Dd9kj1KFEQESvPRH01ZfVMIs57V0ODCpoiFwqA2r?=
 =?us-ascii?Q?ZLdt6y0r4V0DhkbvQ3qsPdMqN+0g32FzRWDAcRX1RuTpfUQBFVCOESF1nqz5?=
 =?us-ascii?Q?nhJwBJuVPC9SaVScEUS87hHu98+SUYAQIsIu1iVm2oxEfm2POXuAi9hDGL8s?=
 =?us-ascii?Q?6XjgwW4RnFO6Lxk8oecYJGIDrWBth8rlT3eE92JgIgHhOmBu89YJFGyoMzq5?=
 =?us-ascii?Q?RG1kcRlNby2vCxhe9q+iFPEv7pzAwJqbc/8NBz6KXYNyG/5NiamwBqBKYhl1?=
 =?us-ascii?Q?oP0ApyN/ueH1XrGHfF/nv8+iq6j3A3lKlm4JFSJZ/MbjyHo4RcJUGMMxp14A?=
 =?us-ascii?Q?SrpK4m6vZTgul/5w1AEgd5AAJR4lsncVyUbzM4oQk4S81IB+PtKCIB262jw1?=
 =?us-ascii?Q?F84OslJy+By1tW9i3A6AnEU1jMvwrOsMeSAfeMQomv5sQ2UwLLfbQGN7ub2Y?=
 =?us-ascii?Q?FVKlSh9UH8tzqnjDLSTt4ZU67Nh4y4Ez2HVhHEfmttU6+Au3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174c4f8e-9403-4596-50a4-08df2720ba5f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 22:49:23.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weClu4cr0EX8jo+wmIxwI6Yx6OSc0PHyy8hZk9ZY+w4Ebf4As3ryNuCwyIcPYktvX7fQyDfpplKeVHZMqG/ZsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

Add native tests for pinned arena files, covering canonical range setup
via map FD mmap and map_extra, exported slice bounds, full-capacity
canonical mappings, and mapping lifetime after unpinning. Check that
oversized mapping requests fail cleanly and that size changes are
rejected without zapping mappings, while permission updates and
BPF_OBJ_GET still work.

Reject canonical mapping lengths that differ from the exported arena's
capacity and map the entire size reported by fstat(). Preserve short
canonical mappings for ordinary and retention-only arenas. Drop other
mappings, the pin, and open FDs before checking that the exported slice
retains the arena. Change the pin's mode from its creation permissions
to verify that metadata updates take effect.

Test O_RDONLY pin mappings with MAP_SHARED and MAP_SHARED_VALIDATE.
Verify that readers observe writer updates, retain access after closing
the FD, and cannot request writable or private mappings or upgrade a
mapping with mprotect().

Check that ordinary and retention-only arenas keep their existing pin
behavior, while BPF_F_ARENA_EXPORT requires BPF_F_ARENA_NO_FREE.

Check fixed-size seeking, canonical setup at address zero when security
policy permits it, and the exported mapping lifecycle restrictions.
Verify that partial unmap and protection changes, MADV_DOFORK, and
relocation fail, while fork leaves the parent's mapping intact without
inheriting it in the child.

Assisted-by: LLM
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 .../selftests/bpf/prog_tests/arena_pinned.c   | 442 ++++++++++++++++++
 1 file changed, 442 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_pinned.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_pinned.c b/tools/testing/selftests/bpf/prog_tests/arena_pinned.c
new file mode 100644
index 0000000000000..8b7ca90211296
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_pinned.c
@@ -0,0 +1,442 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ */
+#include <test_progs.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+
+#define ARENA_PAGES 4
+
+struct arena_file {
+	int map_fd;
+	int file_fd;
+	char pin[128];
+	void *canonical;
+	size_t len;
+	bool pinned;
+};
+
+static void cleanup(struct arena_file *file)
+{
+	if (file->canonical != MAP_FAILED)
+		munmap(file->canonical, file->len);
+	if (file->file_fd >= 0)
+		close(file->file_fd);
+	if (file->pinned)
+		unlink(file->pin);
+	if (file->map_fd >= 0)
+		close(file->map_fd);
+}
+
+static void reject_mapping(int fd, size_t len, int flags, off_t offset,
+			   const char *name)
+{
+	void *addr;
+	int err;
+
+	addr = mmap(NULL, len, PROT_READ | PROT_WRITE, flags, fd, offset);
+	err = errno;
+	if (ASSERT_EQ(addr, MAP_FAILED, name))
+		ASSERT_EQ(err, EINVAL, "mmap_errno");
+	else
+		munmap(addr, len);
+}
+
+static bool setup(struct arena_file *file, __u64 map_extra, bool zero)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		.map_flags = BPF_F_MMAPABLE | BPF_F_ARENA_NO_FREE |
+			     BPF_F_ARENA_EXPORT,
+		.map_extra = map_extra);
+
+	memset(file, 0, sizeof(*file));
+	file->map_fd = -1;
+	file->file_fd = -1;
+	file->canonical = MAP_FAILED;
+	file->len = ARENA_PAGES * getpagesize();
+	snprintf(file->pin, sizeof(file->pin), "/sys/fs/bpf/arena_pinned_%d", getpid());
+	file->map_fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_pinned",
+				      0, 0, ARENA_PAGES, &opts);
+	if (file->map_fd < 0 && errno == EOPNOTSUPP) {
+		test__skip();
+		return false;
+	}
+	if (!ASSERT_GE(file->map_fd, 0, "map_create"))
+		return false;
+	if (!ASSERT_OK(bpf_obj_pin(file->map_fd, file->pin), "obj_pin"))
+		return false;
+	file->pinned = true;
+	file->file_fd = open(file->pin, O_RDWR);
+	if (!ASSERT_GE(file->file_fd, 0, "open_pin"))
+		return false;
+	reject_mapping(file->map_fd, getpagesize(), MAP_SHARED, 0, "short_canonical");
+	reject_mapping(file->map_fd, file->len + getpagesize(), MAP_SHARED,
+		       0, "large_canonical");
+	if (map_extra)
+		return true;
+
+	reject_mapping(file->file_fd, getpagesize(), MAP_SHARED, 0, "uninitialized");
+	file->canonical = mmap(NULL, file->len, PROT_READ | PROT_WRITE,
+			       MAP_SHARED | (zero ? MAP_FIXED_NOREPLACE : 0),
+			       file->map_fd, 0);
+	if (zero && file->canonical == MAP_FAILED &&
+	    (errno == EPERM || errno == EACCES)) {
+		test__skip();
+		return false;
+	}
+	return ASSERT_NEQ(file->canonical, MAP_FAILED, "canonical_mmap");
+}
+
+static void test_mappings(__u64 map_extra)
+{
+	struct arena_file file;
+	size_t ps = getpagesize();
+	struct stat st;
+	char *alias = MAP_FAILED;
+	char *full = MAP_FAILED;
+	int expected = 91;
+
+	if (!setup(&file, map_extra, false))
+		goto out;
+	if (!ASSERT_OK(fstat(file.file_fd, &st), "stat_pin"))
+		goto out;
+	ASSERT_EQ(st.st_size, ARENA_PAGES * ps, "pin_size");
+	reject_mapping(file.file_fd, 8ULL << 30, MAP_SHARED, 0, "oversized");
+	reject_mapping(file.file_fd, ps, MAP_SHARED, ARENA_PAGES * ps, "past_capacity");
+	reject_mapping(file.file_fd, ps * 2, MAP_SHARED,
+		       (ARENA_PAGES - 1) * ps, "past_capacity_end");
+	reject_mapping(file.file_fd, ps, MAP_PRIVATE, 0, "private_mapping");
+	full = mmap(NULL, st.st_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		    file.file_fd, 0);
+	if (!ASSERT_NEQ(full, MAP_FAILED, "full_file_mmap"))
+		goto out;
+	full[0] = 17;
+	full[file.len - 1] = 62;
+
+	alias = mmap(NULL, ps, PROT_READ | PROT_WRITE, MAP_SHARED,
+		     file.file_fd, (ARENA_PAGES - 1) * ps);
+	if (!ASSERT_NEQ(alias, MAP_FAILED, "last_page_slice"))
+		goto out;
+	alias[0] = 91;
+	ASSERT_OK(msync(alias, ps, MS_SYNC), "msync_slice");
+	ASSERT_OK(fsync(file.file_fd), "fsync_pin");
+	ASSERT_OK(fdatasync(file.file_fd), "fdatasync_pin");
+	ASSERT_EQ(alias[ps - 1], 62, "full_file_last_page");
+	if (file.canonical != MAP_FAILED) {
+		char *canonical = file.canonical;
+
+		ASSERT_EQ(canonical[0], 17, "full_file_first_page");
+		ASSERT_EQ(canonical[(ARENA_PAGES - 1) * ps], 91, "alias_write");
+		canonical[(ARENA_PAGES - 1) * ps] = 42;
+		ASSERT_EQ(alias[0], 42, "canonical_write");
+		expected = 42;
+		if (!ASSERT_OK(munmap(file.canonical, file.len), "unmap_canonical"))
+			goto out;
+		file.canonical = MAP_FAILED;
+	}
+	if (!ASSERT_OK(munmap(full, file.len), "unmap_full_file"))
+		goto out;
+	full = MAP_FAILED;
+	if (!ASSERT_OK(unlink(file.pin), "unlink_pin"))
+		goto out;
+	file.pinned = false;
+	close(file.file_fd);
+	file.file_fd = -1;
+	close(file.map_fd);
+	file.map_fd = -1;
+	ASSERT_EQ(alias[0], expected, "unpin_lifetime");
+	alias[0] = 73;
+out:
+	if (full != MAP_FAILED)
+		munmap(full, file.len);
+	if (alias != MAP_FAILED)
+		munmap(alias, ps);
+	cleanup(&file);
+}
+
+static void test_unexported_pin(__u32 flags)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		.map_flags = BPF_F_MMAPABLE | flags);
+	char pin[128];
+	struct stat st;
+	char *canonical = MAP_FAILED;
+	size_t ps = getpagesize();
+	int map_fd, fd, err;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_unexported",
+			       0, 0, ARENA_PAGES, &opts);
+	if (map_fd < 0 && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
+	if (!ASSERT_GE(map_fd, 0, "unexported_create"))
+		return;
+	canonical = mmap(NULL, ps, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
+	if (!ASSERT_NEQ(canonical, MAP_FAILED, "unexported_short_mmap"))
+		goto out;
+	canonical[0] = 42;
+	ASSERT_EQ(canonical[0], 42, "unexported_short_access");
+	snprintf(pin, sizeof(pin), "/sys/fs/bpf/arena_unexported_%d", getpid());
+	if (!ASSERT_OK(bpf_obj_pin(map_fd, pin), "unexported_pin"))
+		goto out;
+	if (ASSERT_OK(stat(pin, &st), "unexported_stat"))
+		ASSERT_EQ(st.st_size, 0, "unexported_size");
+	fd = open(pin, O_RDONLY);
+	err = errno;
+	if (ASSERT_EQ(fd, -1, "unexported_open"))
+		ASSERT_EQ(err, EIO, "unexported_open_errno");
+	else
+		close(fd);
+	fd = bpf_obj_get(pin);
+	if (ASSERT_GE(fd, 0, "unexported_obj_get"))
+		close(fd);
+	ASSERT_OK(unlink(pin), "unexported_unlink");
+out:
+	if (canonical != MAP_FAILED)
+		munmap(canonical, ps);
+	close(map_fd);
+}
+
+static void test_export_requires_no_free(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		.map_flags = BPF_F_MMAPABLE | BPF_F_ARENA_EXPORT);
+	int fd;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_export",
+			    0, 0, ARENA_PAGES, &opts);
+	if (fd == -EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
+	ASSERT_EQ(fd, -EINVAL, "export_requires_no_free");
+	if (fd >= 0)
+		close(fd);
+}
+
+static void test_read_only(int flags)
+{
+	struct arena_file file;
+	size_t ps = getpagesize();
+	char *alias = MAP_FAILED;
+	void *addr;
+	int fd = -1, err, ret;
+
+	if (!setup(&file, 0, false))
+		goto out;
+	if (!ASSERT_OK(fchmod(file.file_fd, 0400), "chmod_read_only"))
+		goto out;
+	fd = open(file.pin, O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "open_read_only"))
+		goto out;
+	alias = mmap(NULL, ps, PROT_READ, flags, fd, ps);
+	if (!ASSERT_NEQ(alias, MAP_FAILED, "read_only_mmap"))
+		goto out;
+	ASSERT_EQ(alias[0], 0, "read_only_fault");
+	((char *)file.canonical)[ps] = 42;
+	ASSERT_EQ(alias[0], 42, "read_only_shared_update");
+
+	addr = mmap(NULL, ps, PROT_READ | PROT_WRITE, flags, fd, ps);
+	err = errno;
+	if (ASSERT_EQ(addr, MAP_FAILED, "read_only_writable_mmap"))
+		ASSERT_EQ(err, EACCES, "read_only_writable_errno");
+	else
+		munmap(addr, ps);
+	ret = mprotect(alias, ps, PROT_READ | PROT_WRITE);
+	err = errno;
+	ASSERT_EQ(ret, -1, "read_only_mprotect");
+	ASSERT_EQ(err, EACCES, "read_only_mprotect_errno");
+	addr = mmap(NULL, ps, PROT_READ, MAP_PRIVATE, fd, ps);
+	err = errno;
+	if (ASSERT_EQ(addr, MAP_FAILED, "read_only_private_mmap"))
+		ASSERT_EQ(err, EINVAL, "read_only_private_errno");
+	else
+		munmap(addr, ps);
+
+	close(fd);
+	fd = -1;
+	((char *)file.canonical)[ps] = 73;
+	ASSERT_EQ(alias[0], 73, "read_only_after_close");
+out:
+	if (alias != MAP_FAILED)
+		munmap(alias, ps);
+	if (fd >= 0)
+		close(fd);
+	cleanup(&file);
+}
+
+static void test_fixed_size(void)
+{
+	struct arena_file file;
+	size_t ps = getpagesize();
+	struct stat st;
+	unsigned char resident;
+	char *alias = MAP_FAILED;
+	int err, fd, ret;
+
+	if (!setup(&file, 0, false))
+		goto out;
+	alias = mmap(NULL, ps, PROT_READ | PROT_WRITE, MAP_SHARED, file.file_fd, 0);
+	if (!ASSERT_NEQ(alias, MAP_FAILED, "alias_mmap"))
+		goto out;
+	alias[0] = 42;
+	ret = ftruncate(file.file_fd, 0);
+	err = errno;
+	ASSERT_EQ(ret, -1, "ftruncate_shrink");
+	ASSERT_EQ(err, EINVAL, "ftruncate_shrink_errno");
+	ret = ftruncate(file.file_fd, file.len + ps);
+	err = errno;
+	ASSERT_EQ(ret, -1, "ftruncate_grow");
+	ASSERT_EQ(err, EINVAL, "ftruncate_grow_errno");
+	ret = truncate(file.pin, 0);
+	err = errno;
+	ASSERT_EQ(ret, -1, "truncate_pin");
+	ASSERT_EQ(err, EINVAL, "truncate_pin_errno");
+	fd = open(file.pin, O_RDWR | O_TRUNC);
+	err = errno;
+	if (ASSERT_EQ(fd, -1, "open_trunc"))
+		ASSERT_EQ(err, EINVAL, "open_trunc_errno");
+	else
+		close(fd);
+	ASSERT_OK(ftruncate(file.file_fd, file.len), "ftruncate_same_size");
+	if (!ASSERT_OK(mincore(alias, ps, &resident), "mincore"))
+		goto out;
+	ASSERT_EQ(resident & 1, 1, "mapping_not_zapped");
+	ASSERT_EQ(alias[0], 42, "mapping_value");
+	ASSERT_OK(fchmod(file.file_fd, 0640), "chmod_pin");
+	if (ASSERT_OK(fstat(file.file_fd, &st), "stat_pin")) {
+		ASSERT_EQ(st.st_size, file.len, "fixed_size");
+		ASSERT_EQ(st.st_mode & 0777, 0640, "pin_mode");
+	}
+	ASSERT_EQ(lseek(file.file_fd, 0, SEEK_END), file.len, "seek_capacity");
+	ASSERT_EQ(lseek(file.file_fd, -(off_t)ps, SEEK_CUR), file.len - ps, "seek_back");
+	ASSERT_EQ(lseek(file.file_fd, ps, SEEK_SET), ps, "seek_offset");
+	errno = 0;
+	ASSERT_EQ(lseek(file.file_fd, file.len + 1, SEEK_SET), -1, "seek_past_end");
+	ASSERT_EQ(errno, EINVAL, "seek_past_end_errno");
+	errno = 0;
+	ASSERT_EQ(lseek(file.file_fd, -1, SEEK_SET), -1, "seek_before_start");
+	ASSERT_EQ(errno, EINVAL, "seek_before_start_errno");
+	fd = bpf_obj_get(file.pin);
+	if (ASSERT_GE(fd, 0, "obj_get_after_chmod"))
+		close(fd);
+out:
+	if (alias != MAP_FAILED)
+		munmap(alias, ps);
+	cleanup(&file);
+}
+
+static void test_zero_canonical(void)
+{
+	struct arena_file file;
+	size_t ps = getpagesize();
+	char *alias = MAP_FAILED;
+	void *addr;
+
+	if (!setup(&file, 0, true))
+		goto out;
+	if (!ASSERT_EQ((unsigned long)file.canonical, 0, "zero_canonical"))
+		goto out;
+	alias = mmap(NULL, ps, PROT_READ | PROT_WRITE, MAP_SHARED, file.file_fd, ps);
+	if (!ASSERT_NEQ(alias, MAP_FAILED, "zero_canonical_export"))
+		goto out;
+	alias[0] = 42;
+	ASSERT_EQ(alias[0], 42, "zero_canonical_fault");
+	addr = mmap((void *)ps, file.len, PROT_READ | PROT_WRITE,
+		    MAP_SHARED | MAP_FIXED_NOREPLACE, file.map_fd, 0);
+	if (ASSERT_EQ(addr, MAP_FAILED, "canonical_cannot_move"))
+		ASSERT_EQ(errno, EINVAL, "canonical_cannot_move_errno");
+	else
+		munmap(addr, file.len);
+out:
+	if (alias != MAP_FAILED)
+		munmap(alias, ps);
+	cleanup(&file);
+}
+
+static void test_lifecycle(void)
+{
+	struct arena_file file;
+	size_t ps = getpagesize();
+	char *alias = MAP_FAILED;
+	void *target = MAP_FAILED, *addr;
+	pid_t child;
+	int status, ret, err;
+
+	if (!setup(&file, 0, false))
+		goto out;
+	alias = mmap(NULL, ps * 2, PROT_READ | PROT_WRITE, MAP_SHARED,
+		     file.file_fd, 0);
+	if (!ASSERT_NEQ(alias, MAP_FAILED, "lifecycle_mmap"))
+		goto out;
+	alias[0] = 42;
+	ret = munmap(alias, ps);
+	err = errno;
+	ASSERT_EQ(ret, -1, "partial_unmap");
+	ASSERT_EQ(err, EINVAL, "partial_unmap_errno");
+	ret = mprotect(alias, ps, PROT_READ);
+	err = errno;
+	ASSERT_EQ(ret, -1, "partial_mprotect");
+	ASSERT_EQ(err, EINVAL, "partial_mprotect_errno");
+	ret = madvise(alias, ps * 2, MADV_DOFORK);
+	err = errno;
+	ASSERT_EQ(ret, -1, "enable_inheritance");
+	ASSERT_EQ(err, EINVAL, "enable_inheritance_errno");
+	target = mmap(NULL, ps * 2, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_NEQ(target, MAP_FAILED, "reserve_remap_target"))
+		goto out;
+	addr = mremap(alias, ps * 2, ps * 2, MREMAP_MAYMOVE | MREMAP_FIXED, target);
+	err = errno;
+	if (!ASSERT_EQ(addr, MAP_FAILED, "relocate_mapping")) {
+		alias = addr;
+		target = MAP_FAILED;
+	}
+	ASSERT_EQ(err, EINVAL, "relocate_mapping_errno");
+	child = fork();
+	if (!ASSERT_GE(child, 0, "fork"))
+		goto out;
+	if (!child) {
+		unsigned char resident[2];
+
+		ret = mincore(alias, ps * 2, resident);
+		_exit(ret == -1 && errno == ENOMEM ? 0 : 1);
+	}
+	if (ASSERT_EQ(waitpid(child, &status, 0), child, "wait_child") &&
+	    ASSERT_TRUE(WIFEXITED(status), "child_exited"))
+		ASSERT_EQ(WEXITSTATUS(status), 0, "mapping_not_inherited");
+	ASSERT_EQ(alias[0], 42, "parent_mapping_retained");
+out:
+	if (target != MAP_FAILED)
+		munmap(target, ps * 2);
+	if (alias != MAP_FAILED)
+		munmap(alias, ps * 2);
+	cleanup(&file);
+}
+
+void serial_test_arena_pinned(void)
+{
+	if (test__start_subtest("ordinary_pin"))
+		test_unexported_pin(0);
+	if (test__start_subtest("retained_pin"))
+		test_unexported_pin(BPF_F_ARENA_NO_FREE);
+	if (test__start_subtest("export_requires_no_free"))
+		test_export_requires_no_free();
+	if (test__start_subtest("mappings"))
+		test_mappings(0);
+	if (test__start_subtest("map_extra"))
+		test_mappings(1ULL << 32);
+	if (test__start_subtest("fixed_size"))
+		test_fixed_size();
+	if (test__start_subtest("read_only"))
+		test_read_only(MAP_SHARED);
+	if (test__start_subtest("read_only_validate"))
+		test_read_only(MAP_SHARED_VALIDATE);
+	if (test__start_subtest("zero_canonical"))
+		test_zero_canonical();
+	if (test__start_subtest("lifecycle"))
+		test_lifecycle();
+}
-- 
2.56.0

