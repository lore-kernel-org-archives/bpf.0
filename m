Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA31478E51
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945257; cv=none; b=snJ3c8e+ybNV6vYa9Up/mR9/sLMcW06kw5cBj0fJ7hh9qeFGp3oJAO52p801iErbSCe9fLO3D99UZ6f4fyN61glSvWDqHWLlFyFZyU3TFY1Pq6/8/KDurqcYRylSLejsbZyC1GGPzPpQxA1Or8U6KWMSxESSwaqn75KkKD0jL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945257; c=relaxed/simple;
	bh=3fd9AMRp90J0fasmWvaPfRonNfr7Ey9I7PHgmBaIfmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWJ9WizxnJHHwBPD6YDv1m2K4y/zt88yhxhOOa9vG9LxKFFfPRv7pUdhh7fZrl/uRt1k0PsEfLBxHAQgkVo9LEtGnTQkJEr2BT6Wog2l8DbxxgsTzupM57B2HLg/N2tLmQkM6vx1XvuKroLS9x/kjHSgf6igUpMXX+bkw0KgdWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaFksWGr; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaFksWGr"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e44so2736874a12.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945255; x=1791550055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e7N0L8l0ft5pLvT3VjJaFoiIZzkbn2c7ZLKysL6r8LE=;
        b=UaFksWGrEUB+aVYxVPZog1HhhFN2h68xXgI2JrKP5+zUmkMmFEIrUAvuKo+tbYhJSx
         fYf43WZdy5m5oGy90wzY2NjUctrQl6uN6DiKDGxzoWnAcXyFPjEiIq/vpW0KPPSk68z7
         SQuW+11lrXzmVszjxxFR1A/GtnfQ5y1myizbO2kZk0qOxAEY0naz/lFKYZnPNrTkyPlV
         zkDQXHA+SnBDUp8G259ZLHd1KwIhqFHbm5dMuy8elyOi3Fxo32YkXtgBaxLncdnkLp1k
         0G/3OMFGGVAUd0/c2h6cHNrL9sw/EZwbhVYaDqZ2T6ALCjPfPXvZSsxdDzTnpaGUr3gp
         UwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945255; x=1791550055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e7N0L8l0ft5pLvT3VjJaFoiIZzkbn2c7ZLKysL6r8LE=;
        b=G0pWISKE3hywScO4no1JFjFTCNHbPE87rZQbDWXa2Tsg09oxuYyl73ktxBBWnpM2xy
         VLKZKSK4cdSTGBjQgD4LSYn6k2aUxu+UvTc/uZliCUlOnM+7JoJLcWG5ALq6o3Q4/X23
         6hUvHJVAkzLMPoe1iP1arSbDWxmNvhraMj0l6/QB4G11yUAr+przV+UEK2uYAtWzjEgN
         DFXn4xRVk9qg8dLR3J7ccWOFwEkuMJdw0uxXWbCcDl1k5rr9TjEOnS8MHlDwffVJqccn
         Hp40pYmcP2/wZ70PHJwFSpyDaMcEVlp4GxwBAwV7rXHiTjoL5jfXpiwYeqotQXefNepU
         ISCg==
X-Gm-Message-State: AFuF++mlMbdH0pSIQiM4NMpJzq6lHJ+0VnIeGSPrvsc9Uph+cAxVWaQa
	iXYg7MCTDFaiccgOux4iUm1YSVGNlFL0uMgL5xb/ezCeIMIGOet8hkeFZN3PcVqica4=
X-Gm-Gg: AYBFou1uXlJpPuaqg/VUzeFBWDMaZOqCtnIDmL8BSR98w5GIjbdwLpv6lT0khBPUf9m
	cNKZBjQ49B8GgXE4wMRhZ5Vy7yVV0tHh20otONMq29ck4G3L8CqAowy5GF6SAAil20nz3+B2RgX
	e+4XhS5YnQFH4pNN1rJlKYkfDFNqNcx+j77EPumeUWbDTgJLhSm5kL15/Yl9Wb79Nf8V/C9w9a5
	KAwAH/OuC6aqyJmFYhOUpUgzq95sA0QklI8Gnj0TIOm/bOTYgYArHJRcpAJBx4dXNERqAfyCXxD
	69O96TjnKCpBBdIQvqSOvaPcrYSX5kAzJwvpgr159lxZxX2V6tLlyzJ8MmaE+kPmnbrtOSHfpeV
	0jF99CG/B6/NUBPtzUZsXNYo2W8XtRy4R7MOYBu3MYILrRAVEFEw771syNEVfPbUgdr11SxlyTF
	/J1KZYqLVeHYsByuJBnPPY+K/VGGvF0hNxQMGmjahhYumi44viGdbFZJ1bd0dN/PUHGjcoZq+BO
	qiQQRbHCmD5JTUlSEcl+wAvrniG+QNupw2Fhb0GIE9WDUuoms7rPBJZZnx6ExPzq1zwKx5SZeqG
	o5sLsMzWsE92Fzl8fkS8D7B9wNm2vRUVCfMSlhCKdPk=
X-Received: by 2002:a05:6a20:918c:b0:3de:63f4:7053 with SMTP id adf61e73a8af0-3e0bcee79c1mr2480134637.26.1790945254261;
        Fri, 02 Oct 2026 05:47:34 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0bfc3e0fsm837583b3a.22.2026.10.02.05.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:33 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 06/15] selftests/bpf: Add tests for names of Rust types and functions in BTF
Date: Fri,  2 Oct 2026 12:47:05 +0000
Message-ID: <20261002124714.180012-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Check that BTF with names of STRUCT, FWD, TYPEDEF and FUNC that Rust
makes is loaded and that the name of FUNC is an identifier in kallsyms.

The test is serial. Programs are not in kallsyms while bpf_jit_harden
is set and there are tests that set it for a while.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf.c  | 15 ++++
 .../selftests/bpf/prog_tests/btf_rust.c       | 69 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_rust.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 87b554067071..207341f4bd99 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3593,6 +3593,21 @@ static struct btf_raw_test raw_tests[] = {
 	},
 	BTF_STR_SEC("\0?foo"),
 },
+{
+	.descr = "names of Rust types and functions are ok",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(NAME_NTH(1), 0, 0, 32, 4),	/* [1] */
+		BTF_STRUCT_ENC(NAME_NTH(2), 1, 4),		/* [2] */
+		BTF_MEMBER_ENC(NAME_NTH(3), 1, 0),
+		BTF_FWD_ENC(NAME_NTH(4), 0),			/* [3] */
+		BTF_TYPEDEF_ENC(NAME_NTH(5), 2),		/* [4] */
+		BTF_FUNC_PROTO_ENC(0, 1),			/* [5] */
+			BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(6), 1),
+		BTF_FUNC_ENC(NAME_NTH(7), 5),			/* [6] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0u32\0Option<&str>\0__0\0*const str\0{impl#9}<[u8; 4]>\0self\0fmt<str>"),
+},
 
 {
 	.descr = "float test #1, well-formed",
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_rust.c b/tools/testing/selftests/bpf/prog_tests/btf_rust.c
new file mode 100644
index 000000000000..ce2b31087b59
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_rust.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#define FUNC_NAME "write_fmt<scx_simple::BpfStream>"
+#define KSYM_NAME "write_fmt_scx_simple__BpfStream_"
+
+/* The name of a function of Rust is a part of the name of the program in kallsyms */
+static void test_func_name(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	int int_id, proto_id, prog_fd = -1, i;
+	struct bpf_func_info func_info = {};
+	struct bpf_prog_info info = {};
+	unsigned long long addr;
+	__u32 len = sizeof(info);
+	char sym[128], *p = sym;
+	struct btf *btf;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf"))
+		return;
+	int_id = btf__add_int(btf, "i32", 4, BTF_INT_SIGNED);
+	ASSERT_GT(int_id, 0, "int");
+	proto_id = btf__add_func_proto(btf, int_id);
+	ASSERT_GT(proto_id, 0, "proto");
+	ASSERT_OK(btf__add_func_param(btf, "ctx", int_id), "param");
+	func_info.type_id = btf__add_func(btf, FUNC_NAME, BTF_FUNC_STATIC, proto_id);
+	ASSERT_GT(func_info.type_id, 0, "func");
+	if (!ASSERT_OK(btf__load_into_kernel(btf), "btf load"))
+		goto out;
+
+	opts.prog_btf_fd = btf__fd(btf);
+	opts.func_info = &func_info;
+	opts.func_info_cnt = 1;
+	opts.func_info_rec_size = sizeof(func_info);
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns,
+				ARRAY_SIZE(insns), &opts);
+	if (!ASSERT_GE(prog_fd, 0, "prog load"))
+		goto out;
+	if (!ASSERT_OK(bpf_prog_get_info_by_fd(prog_fd, &info, &len), "prog info"))
+		goto out;
+	if (!info.jited_prog_len) {
+		test__skip();
+		goto out;
+	}
+
+	p += sprintf(p, "bpf_prog_");
+	for (i = 0; i < BPF_TAG_SIZE; i++)
+		p += sprintf(p, "%02x", info.tag[i]);
+	sprintf(p, "_%s", KSYM_NAME);
+	ASSERT_OK(kallsyms_find(sym, &addr), sym);
+out:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	btf__free(btf);
+}
+
+/* Serial: programs are not in kallsyms while another test sets bpf_jit_harden */
+void serial_test_btf_rust(void)
+{
+	if (test__start_subtest("func_name"))
+		test_func_name();
+}
-- 
2.55.0

