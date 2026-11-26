Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704707;
	b=NCHZQVxgTwddINAswmyu9UZZ7NorzJx/eaHcE4HYcY5uBxfWJ6+R2kHnobPhASSEgjGD
	 iXxkqkgv7hOSwIOJ0AMnUOEpVjLJ9SxRytcEqMJtBJwJUUh6LkBR4b+RLHDM1iiDMbFB1
	 fz7/Qa943DNNNT2BSkkTCCsxyOLeQ2UEaZKzpg8OEDgDoEfR7zpGufNVI4m1JUlysOybt
	 nOtzYJgoewqLI8LlZAbN5y4VN1CGw0M3VHC1RE6Pif5XBvGt/nJwi+tdxWvedzsM4eeeH
	 H9hjZtzGVm/OxC/+YkmlQu4l2Yq7J/9/gK12PkGnOVHzfa4j68p3MttnZ8Gf56pPRNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704707;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=4WwrD4eFRzKITqyYCyeNz51jvJ8OINOATwhNZaRKqtE=;
	b=kQnQsdHuDVOUVFrmYui2tKeHnH+lMIRuGxBseENEWeGwqUPvy9qODhmppVr4Y3uI40UU
	 C1+uOUiz/zIZ2+EPh2gSnjE48/NBoXXwYphX46RJyZ2S8DgfyWCVGBB3DuwdbwSkAxeE9
	 YPAJrFtuA/WuIC5up5OGMbpMHSrXH2h6v25O03OrisqhdVud/sIMUxB7ocxAgp9LCBZ8m
	 tgd006NOq/UoBti0AAFm+XJlaKQ+Ukj+4Ea+GhMh6QiZz3/M7TI6wdl7DScyLaKrFPZLJ
	 NfUA155vwpR64ohrQP8OV4YZJxQk08jlqP9jaNsql7Np6XmDiLbAmy6qJlJGpYAKOGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=vK3tdPg8;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22F606A68B
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD22F606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=vK3tdPg8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795704703; bh=JkhbsbcaFu/hDNAAggJ9zfx8f833lPwYl3RkdN2rvuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vK3tdPg8KyCgQw9GhYBE+ay8WststpShSJvuBGoGTurU5C2ZQx6aAa7nX0kwyoxo3
	 JR1rmeizldaPV79M6Vinkh11x6Jk8mzaksQQZatnYSO/tlaLoZcPrLXqphNx0GYH4+
	 Uj/NOn0My5Oa5nP3aZpFiXcDslCw02MglBATk3Pe3mUKrOS6GmIdUc+ouV/teQor11
	 Qi/Cu8sZrsmalhKqPKWGnHlRYGFlDcsB1IUr0Z8gJ4WMcqApNwwcMDx0cpjk5UOl9v
	 Nw+qXxF0MFXOUz3bSMBXHlNpE+T7E2AC0Sb4/D90z5VqX00RzBELGDsUZTOsGU9t0T
	 oUsfFFTCMfMQA==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 15:51:43 +0100
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: Add test for attaching
 fentry to a module with bpf_token
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-bpf-relax-get-next-id-v3-7-338e1d3077e7@toke.dk>
References: <20261126-bpf-relax-get-next-id-v3-0-338e1d3077e7@toke.dk>
In-Reply-To: <20261126-bpf-relax-get-next-id-v3-0-338e1d3077e7@toke.dk>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>

Add a new subtest to the token prog_test which attaches an fentry
program to a module function. This requires libbpf to read the module
BTF information using a bpf_token, which is only possible with the
fixes in the previous commits.

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 tools/testing/selftests/bpf/prog_tests/token.c  | 37 +++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/priv_module.c | 15 ++++++++++
 2 files changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index 6499db1704bb..b16b9b4d3d45 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -26,6 +26,7 @@
 #include "token_kallsyms.skel.h"
 #include "token_lsm.skel.h"
 #include "priv_freplace_prog.skel.h"
+#include "priv_module.skel.h"
 
 static inline int sys_mount(const char *dev_name, const char *dir_name,
 			    const char *type, unsigned long flags,
@@ -1099,6 +1100,34 @@ static int userns_obj_priv_prog_kallsyms(int mnt_fd, struct token_lsm *lsm_skel)
 	return err;
 }
 
+static int userns_obj_priv_fentry_module(int mnt_fd, struct token_lsm *lsm_skel)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct priv_module *skel = NULL;
+	char buf[256];
+	int err;
+
+	/* use bpf_token_path to provide BPF FS path */
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", mnt_fd);
+	opts.bpf_token_path = buf;
+	skel = priv_module__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "priv_module__open_opts"))
+		return -EINVAL;
+
+	err = priv_module__load(skel);
+	if (!ASSERT_OK(err, "priv_module__load"))
+		goto out;
+
+	err = priv_module__attach(skel);
+	if (!ASSERT_OK(err, "priv_module__attach"))
+		goto out;
+
+out:
+	priv_module__destroy(skel);
+	return err;
+}
+
+
 #define bit(n) (1ULL << (n))
 
 static int userns_bpf_token_info(int mnt_fd, struct token_lsm *lsm_skel)
@@ -1195,6 +1224,14 @@ void serial_test_token(void)
 		};
 		subtest_userns(&opts, userns_obj_priv_freplace_prog_fail);
 	}
+	if (test__start_subtest("obj_priv_fentry_module")) {
+		struct bpffs_opts opts = {
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD) | bit(BPF_BTF_GET_FD_BY_ID) | bit(BPF_BTF_GET_NEXT_ID),
+			.progs = bit(BPF_PROG_TYPE_TRACING),
+			.attachs = ~0ULL,
+		};
+		subtest_userns(&opts, userns_obj_priv_fentry_module);
+	}
 	if (test__start_subtest("obj_priv_btf_fail")) {
 		struct bpffs_opts opts = {
 			/* disallow BTF loading */
diff --git a/tools/testing/selftests/bpf/progs/priv_module.c b/tools/testing/selftests/bpf/progs/priv_module.c
new file mode 100644
index 000000000000..3743ceb43c42
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/priv_module.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "../test_kmods/bpf_testmod.h"
+
+SEC("fentry/bpf_testmod_test_read")
+int BPF_PROG(handle_fentry)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.56.1

