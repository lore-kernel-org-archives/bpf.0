Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620799;
	b=bEMKge+6S1mAfGTEUc6gTQ4IL3GgP+QqPoq1aWPDxzpiyxb7YOwIbFw1nvNWDafSVXxM
	 5TNwWP1y3Q2wJiuJhpkrvv9/yPH0ZZsD58RYGVgkSqgpzvIQGIfueh7roaIH6lTxLGt7h
	 ierNF84dkdmkRR+Z5uooiamRUBLLR/5dtNlIyIp3B/pBftf38TEQnxfpb3WxN2R80JWKh
	 C5HT2mKInjrVFAlDAU4qHWSq7mtZTb/ppqH2d9sxgv6Lo0c71/9DBXv71QCV24OrLWopY
	 oubJbC1qWCI6nMnQeV0XjKgTOBq3bN7zhVmUe9aRzodHJB04VPkuca7luvFictw+zdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620799;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=ZkEC8qhFavea9WaWfEIzjOaCASmyrUeVd8qd42PSLeU=;
	b=qsmW8BHWuUTI8tvJSIuvk7OMAMZKVSGjWO6EqWNLJbxGCtB/omXXQtL8/OuakrTsUlCk
	 foXrUZ7i5C75k8JPOVMYdYeeoXP2cm7nES6cyJdy+05vIhiA2TVaaVpCVQJ6bE9otospS
	 QwLygTqF349n2t4ozEOQyctVvh/dheR6cdlhZU0V4tcE322CrZ1u/rtnv87StTdroKLKn
	 HlNlnErgCtFXyCv7SLWUyPXLKObTY9jlX7no5YISVMKyo06TZ7/D8R65Y9cLV8JRAiyPf
	 4UKn6cmjk28xfpHPJMge0Z+H8oGIXBt6o4ru5BA5jCuSmBC0ncD12sPj9rRtiVYG8ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=LqSyrjJw;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88006606A32D
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 15:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88006606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=LqSyrjJw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795620790; bh=hLCCxLjAUB9l4n/Nhi1FIeLrFkp5TZ6hzav7yFws4+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LqSyrjJwNMVG+xY7ilvmQzo5PYg6ejKf8whM4KJpOzU5KZ79FEOI5NXIskKQpxAOS
	 A8WCdCaocX9Hc1mdZyZTE6fDq4oRFL3S15n+5Ry9YF8/BDavj92dq2JznW2nr/AYzV
	 yDAcx2lPNABEv5JqjhjIZNbCAGs/eEgQFchSExCYqyrAcSD5zoO6TebNig05lj6MFN
	 0emgdFnAqeFKPnLzraukZ9fF58WCAt1spKfe3e1KEi4or418h74YyPru9DJlDDyUcj
	 jYsPAC/MtISnvUFUvA+DDAsyihKAir7XqtHOajBbDHOp4Wi7hghRSUMDqX01Gz3dI5
	 1DUttCqtTIYyg==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Wed, 25 Nov 2026 16:31:58 +0100
Subject: [PATCH bpf-next 7/7] selftests/bpf: Add test for attaching fentry
 to a module with bpf_token
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
Message-Id: <20261125-bpf-relax-get-next-id-v1-7-49175227c8cf@toke.dk>
References: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
In-Reply-To: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
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
index dcb5e9f2d61e..5861eaf2d589 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -26,6 +26,7 @@
 #include "token_kallsyms.skel.h"
 #include "token_lsm.skel.h"
 #include "priv_freplace_prog.skel.h"
+#include "priv_module.skel.h"
 
 static inline int sys_mount(const char *dev_name, const char *dir_name,
 			    const char *type, unsigned long flags,
@@ -1105,6 +1106,34 @@ static int userns_obj_priv_prog_kallsyms(int mnt_fd, struct token_lsm *lsm_skel)
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
@@ -1201,6 +1230,14 @@ void serial_test_token(void)
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

