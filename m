Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7E374728
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775319178; cv=none; b=mczBsMF0utQyq0hs8T2GBGUaHZNes2S9gA96YxOp8Rx6EYEDLclx6hR8Avh64pkeuw0Tr3De2RfTtsbjZlI/emDETjGITEYJzAiQyAGfSvJ5XF4aA+JjnFx7ikMVCaujaEecVMRfYVBZ/2OANdS6JUgD8awwx0c4FgJhwGr69YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775319178; c=relaxed/simple;
	bh=O9uu2vSaxRnOw554hOlDZfSBOziW2zEVYbkWF3yb/hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDwb2ZLhLmJGDDG+Vd+hr4N5CKyPsozFZ9X3NVE7pIxjThFES/F2orhxSbVsaJyz1c9Hwxx4DsaUENRz/pkpQArhK7Z4oOD0uw1XOPpohP5L/d0LS/i2dZm+mIh/ivypLGWG6dKjyvGci0jgV49MZMWc9SLxpMib5HYgxXCFSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPVEcBd7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPVEcBd7"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82c70e4654eso1253660b3a.2
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775319177; x=1775923977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpyfyGTNc3am5pvom2D3Gy+hEe5S46wtFL1UqsFd/Ww=;
        b=FPVEcBd7cOO9Jk1OOQ2kU0mJ5/7FVcZQ2IWfFnyWquzDIFEg2hOGS2V1X8IQgi9uMQ
         Ee2ZhJsT1kbv+1DvqXsRGr8ZKYtEI0POuPTckt+AVKU5E/o8VpUBz37ATEgvXHtK9LuN
         HYBfjR5mQ2zbRTOe9xuUzN0SG+YZ8lCr5jKFVZgaPiw6qTn4fUtroktNbHKrspKbxwCS
         JOvoadr3Jd+o+KYsD8eaLbeTcTuYF4f1E4v0NUFrKTt2a7nWkhfS9bcjQe3lPoroImr0
         9E+ObFosFZL7i8K3cf1GPkpN3Rox0ff2bd5M031ln4iENm6Cz6Fvs9cTHeu3Xb8jw9kc
         hZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775319177; x=1775923977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OpyfyGTNc3am5pvom2D3Gy+hEe5S46wtFL1UqsFd/Ww=;
        b=lwdq6k2jBCLfWrl9Ue4RQTasklMxr98hm85+gMVR6LVEY80xMKxK3E+K3Fpy+VAYwX
         jdlxang0lGwghvAdi/Imn6SoB4L5EPqA1CjvARjQu5E6qgtidzHWWBcooh5qmU7FECNh
         TqDLYeQFe9jCM/0MFlVfOFAvLjYOOG5vvL/3pa8s32H3FheVLBwIpfb41oe7W4VmJMTK
         ybUSkXVeTtQJYPJDBsEuHGbZ2klBlH9ImME8XLqRYYlt1Rw7PXk29eYZ5NT6JcPuBYs+
         N5iyTuNVhM57SnApsdIwzWzcIlUOMZvdBGRDgSL28rTNNrVWoSCMo7exkkylkH0AmdYd
         SRBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdUqGtr1GSQ6vPC43UwI7iZvMabPPzbQd21xHFaKICt04wgNgpMLfrmCFuR7vM5iRwJAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0kCiTELqEp6Q9Rn7XsxifmA+Gqme0n11/eFQGA+ILNe/AcrU
	RR8pWfpH11rjluSC7/G0qPcMOl28ieBFODFZUaqRseBe47OXza6TIGm1
X-Gm-Gg: AeBDievecvW/FndZDE+bzlA0hSlP4iKD45Yiv5nld40ER/40IQ2TeWuT96ldg9hKhVT
	vbPjDbyJTquF84A2g/7qUqU3UMAgl3HPhv0iW6//L8gXiHwx0Qo6nE4RnsYK3GFW1W/txOhfC1t
	lduJwxbdApvrfeVHE/bx9yFNBFsFemhqkMMs9khTNBBM7EkaQpQoWEdl5SzvAaqIgcipkbaKs99
	T7qg5iWrebM0WJ+p81Y6vDYrIr4Zx7pHrJ+WBicF9KOFSv8Hv4kBqjXxbmFXZBWcly+98flduhV
	x+VYnjaUVf8w4uESkxdfgbFuEKHZvusi12E36A+g/YNjEO4BszqSZKgeFwYvlOo2H3ijxjtHdrN
	fu9kHcapc4uxi+wIztwTgnBpe/j3LosMvQ7nD7cDAPi+sZhtjHI89QgWNM32HxUK1+LtFQ7KWM3
	i894/jDuEGFzacV4znvu5UsFzGbGP8D7OYE1zEh1RCXgSdOa3sxf0BupmjIJiPFskn85i8Ny3MD
	8UYvK9C3SZ1
X-Received: by 2002:a05:6a00:8018:b0:82c:215d:5e9d with SMTP id d2e1a72fcca58-82d0db6bfc5mr6510356b3a.32.1775319176629;
        Sat, 04 Apr 2026 09:12:56 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b6113dsm8301526b3a.23.2026.04.04.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 09:12:56 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: add test for negative CO-RE accessor index rejection
Date: Sun,  5 Apr 2026 00:12:21 +0800
Message-ID: <20260404161221.961828-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404161221.961828-1-bestswngs@gmail.com>
References: <20260404161221.961828-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to verify that the kernel rejects BPF programs containing
CO-RE relocations with negative accessor indices.  The test constructs a
minimal BTF blob with a struct type and a CO-RE relocation whose access
string is "0:-1".  Without the fix in the previous patch, this triggers
an out-of-bounds read in bpf_core_parse_spec(); with the fix, the
program load fails cleanly with -EINVAL.

Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index a18d3680fb16..f7bf6c237d59 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -118,8 +118,102 @@ static void test_bad_local_id(void)
 	close(btf_fd);
 }
 
+/* Check that verifier rejects BPF program containing CO-RE relocation
+ * with a negative accessor index (e.g. "0:-1").
+ */
+static void test_negative_accessor(void)
+{
+	struct test_btf {
+		struct btf_header hdr;
+		__u32 types[18];
+		char strings[20];
+	} raw_btf = {
+		.hdr = {
+			.magic = BTF_MAGIC,
+			.version = BTF_VERSION,
+			.hdr_len = sizeof(struct btf_header),
+			.type_off = 0,
+			.type_len = sizeof(raw_btf.types),
+			.str_off = offsetof(struct test_btf, strings) -
+				   offsetof(struct test_btf, types),
+			.str_len = sizeof(raw_btf.strings),
+		},
+		.types = {
+			/* [1] int */
+			BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
+			/* [2] struct s { int x; } */
+			BTF_STRUCT_ENC(5, 1, 4),
+			BTF_MEMBER_ENC(7, 1, 0),
+			/* [3] int (*)(int a) */
+			BTF_FUNC_PROTO_ENC(1, 1),
+			BTF_FUNC_PROTO_ARG_ENC(13, 1),
+			/* [4] FUNC 'foo' */
+			BTF_FUNC_ENC(9, 3),
+		},
+		/* offsets: 0:NUL 1:"int" 5:"s" 7:"x" 9:"foo" 13:"a" 15:"0:-1" */
+		.strings = "\0int\0s\0x\0foo\0a\0" "0:-1",
+	};
+	__u32 log_level = 1 | 2 | 4;
+	LIBBPF_OPTS(bpf_btf_load_opts, opts,
+		    .log_buf = log,
+		    .log_size = sizeof(log),
+		    .log_level = log_level,
+	);
+	struct bpf_insn insns[] = {
+		BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_func_info funcs[] = {
+		{ .insn_off = 0, .type_id = 4 }
+	};
+	struct bpf_core_relo relos[] = {
+		{
+			.insn_off = 0,
+			.type_id = 2,		/* struct s */
+			.access_str_off = 15,	/* "0:-1" */
+			.kind = BPF_CORE_FIELD_BYTE_OFFSET,
+		}
+	};
+	union bpf_attr attr;
+	int prog_fd = -1;
+	int btf_fd = -1;
+
+	btf_fd = bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
+	if (!ASSERT_GE(btf_fd, 0, "btf_load"))
+		return;
+
+	log[0] = 0;
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_btf_fd = btf_fd;
+	attr.prog_type = BPF_TRACE_RAW_TP;
+	attr.license = (__u64)"GPL";
+	attr.insns = (__u64)&insns;
+	attr.insn_cnt = sizeof(insns) / sizeof(*insns);
+	attr.log_buf = (__u64)log;
+	attr.log_size = sizeof(log);
+	attr.log_level = log_level;
+	attr.func_info = (__u64)funcs;
+	attr.func_info_cnt = sizeof(funcs) / sizeof(*funcs);
+	attr.func_info_rec_size = sizeof(*funcs);
+	attr.core_relos = (__u64)relos;
+	attr.core_relo_cnt = sizeof(relos) / sizeof(*relos);
+	attr.core_relo_rec_size = sizeof(*relos);
+	prog_fd = sys_bpf_prog_load(&attr, sizeof(attr), 1);
+	if (prog_fd >= 0) {
+		PRINT_FAIL("sys_bpf_prog_load() expected to fail\n");
+		goto out;
+	}
+	ASSERT_HAS_SUBSTR(log, "failed: -22", "prog_load_log");
+
+out:
+	close(prog_fd);
+	close(btf_fd);
+}
+
 void test_core_reloc_raw(void)
 {
 	if (test__start_subtest("bad_local_id"))
 		test_bad_local_id();
+	if (test__start_subtest("negative_accessor"))
+		test_negative_accessor();
 }
-- 
2.43.0

