Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699271;
	b=jh5P9hZasElvRi5v2Np78f2yuyGrJAxwzkbehXPUrIXJKF9udAGtwqZbb5+Imz33T7ct
	 ZNO4uz7O3Jz7CH2NM/GhDobECFlCjmmVBsp+RHumELQ5fWAJXtk8cj39wkI9QB5q8tMG6
	 OZ1uxiZlLY3mYkJ03RyzsWlPFmSUAZJzVJ3KRpYwmDckB9f0tQ7HHakheEMcB/H3iNS82
	 d+B28OpH793LAmwOPBmuJGz5e1I9Aln9MrC/OLshhBzzHKbSuE1yAg0k/obqC9a7zCJAu
	 smhMjx3Jcco6B//8hdOtxg4e8NCFIHPvbL5UGauV53L5bGWlrxCLmpojmHb2AnYbfUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699271;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=XLBvFlpk0i4H0M5dBkxGdm01QiVAQGPf2B/R72aPnJY=;
	b=cvRu/speV8UhEq3UTT+q2YIIb5Pxm9ineeb9xfDQ21j/BjVVsOqVFOQShuuey/zAhKaG
	 T9kw/0+2VFmz/+7e22fRp0tadXJpaaTTJk0SB/NMkVBl9dkLntBewPGon7r0AkZvJSrge
	 hbYS6bgqY7Cjq3nEmWX08BeH1cTkm/DGyM9Gilcjk7iVTILQITxQMLd537dq1t6D6y6ow
	 H90ohN0IT6dRJ6YrvMuhF9CnFb20qiNWzV/cuLgpGL7muqPSacPxGaRLtEMldsKqD5phT
	 cK/SoadNCylQ2G26M71qcSDtjsgAHzlL3X8AaMFfjOK5CRRiVRmbTqv/atY5Yh38xxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=hGvsVdos;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAD606A680
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12DAD606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=hGvsVdos
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795699266; bh=gY9TbNfUsSKIHMhhscKmlaHR+DvpMQBoJHNJg34uoNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hGvsVdosOKdRdllMSj6XfIApiw1+4N3PN6kOoUlScDLnJaumdphKNcvD59Kkdv4H7
	 kaGhFPPz5AI4Kro1W6/SLabCnOfyMKffkYu5ksER6kH9c5R7sEytw9+Vv+Gsct8ItX
	 Ov8FtY92wm6iuF/xNZNVuhBwQDi3u5VI/j9k3nB9hXiaJ3LJll0rQCxiPj8RxzXSRr
	 jtJWM6ywm6JvdK8ylHtQF/5QcMx/2p49ljvhxllWPOHTFCtz1wgUBJ70jZSmmd5U/N
	 sa6ZHdzkxy/z1fGZk9DRbKlew6UBCXfzzy7xvdFvdHSqwEhtVa9kfqRp2lXrx9GyzC
	 6CNCXUoO1inUw==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 14:21:05 +0100
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: Add test for attaching
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
Message-Id: <20261126-bpf-relax-get-next-id-v2-7-039e92757f9c@toke.dk>
References: <20261126-bpf-relax-get-next-id-v2-0-039e92757f9c@toke.dk>
In-Reply-To: <20261126-bpf-relax-get-next-id-v2-0-039e92757f9c@toke.dk>
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
index 17cd7f176e09..c46574839563 100644
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

