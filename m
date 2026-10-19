Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880E55C9EE
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421341; cv=none; b=ko4Yq+w58NQwI5pbp7bDCpmHaO0dJkp0bx8rF7bKp2CdKy3QPgZtv0l99oLB1slKEhX1OKZwYSJg65ZeMbLx9jnMYrU3IufaROJ/DVJjBZ0sh23i8adW+uVnKBYpjr1ffUwacVp81JKr/eKeqsxZxiZ5mN+WYGAnJqt9+Zo3wNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421341; c=relaxed/simple;
	bh=Z8tlh1BcQ4RQzZxqBONrIPgKcJMRVs5xw/h5Zr7K/sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBvHrGTblC5SArc/wegBeCSfEPyrlcT91vBLJ836GKNQbaW63uyPGtZO9KhBi55p4OoLZlLo3cqCimwRtqaUO3YnfYQsTNGhoEO7r5MAyy3B03oXjGvgXIZ/H7IVmUzTaSR9K4q6b10qLICH4PMjcNFF4fXSC6SrOEO/rm4cqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFvxD5AI; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFvxD5AI"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-828912d37e6so560685a34.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792421339; x=1793026139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fodFFz3XBaFazuL3SUx4CvMDlfcvqTN0Qfgh4HkR58o=;
        b=kFvxD5AIU/NDr6bFHcT7WJJwg/cMLMddfcH1VO5Eoc5Cj5Xzw8JaG3qkjjjOYodoal
         g8xm9BUEq3lq9rLiNVGD/yMyq5lNcfjG3Q1zs7CGgvNKkF84bJdS36fgSprpeFEUHXOB
         TCqWq+Ti8IB99fOoqJyXBQMBqx21UXF/5tGaeCqw9fpH2xC6gLS6w4Bjxx37fw/qXX2P
         bPGdUerm6iwI/gk7pNkSwUGPWjV7l8OViyWbhz2cMVd57lNggNOWCAo0pYQd2qJ0QHKj
         zn1jDXgVTV7WfdmtISnNYUS9O86UU/ksWEVmITrqgwZBaX8I/BbMeaoQ/uOlLF0SanvS
         o0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421339; x=1793026139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fodFFz3XBaFazuL3SUx4CvMDlfcvqTN0Qfgh4HkR58o=;
        b=dJ1u+RkzXySAW93udy460lM+/GZw69fo+mLGqbAlceynCIymk3WXyK1mDeOx9WcHDB
         YHAjVPz9mVUvzjs72kDO9Eq9LkQNG9glETXBgf8PHfWZwf5RecRtfGEhV9raugIavW6K
         hfGp9BzRFDVkE1xc9YicuJqiAJ4etvEm4kEwbf7fEjAycu5H1a6gnb9u9nlJFaRV34wl
         wVwzYRzDtn3/x2uVz+/QRRckftX+xOZJuHUJreHEfoyrIk0+615uz+l5Ccji9FguMtmv
         HXVV3yqaw5yahrykdtS5+YEa2NJYddagjfkM1uM28TlGhxHv3WXS2xJMDObqZgLFE/n4
         NUcQ==
X-Gm-Message-State: AFq9FYKY3gvyO3SGMfcMHpPBc1WKMOfW5XBfRcCdguUp32oAAikAHyTl
	SR1QOcVKJzkJqLccmvrIHWY0DBfwOBwRBqbx7sSApw1eycrYSM+NnoAdY4P3pqq6A80=
X-Gm-Gg: AYBFou3ByPr1Om+lSDYTfz6QFn0ng8yXfZlcHixWzDK7nfnlyyva3Adijm+nalUswWJ
	MOfZsZURsmz14doCZ7DQvCRFiLqAGpa3vymeY3FDxMNbgyc/K8sdk8r05Hk4L+UG0+wq32cp56Z
	m0aG3A/CjmWonwW1ixri9PPcjrSkYS6l3wnwUxqBUp5K1X1EclEK6YPwZv/iWo968rR8X6HNFQ0
	6qqZFbPtNQpdtKe/KhHq14qD6Cih8ktGBlyMuL1ck7mhcY32h4ZyPzGflB4cKjANdelqDXgWwHx
	f6BKv9tG61gE1DoG2mCpcxaDlG94ul2iIO3+ZYPSEc+fKYTKtQeSknOB4ney+XLlCsIBkhz/QVT
	Vwuz7xyGqOWcs8FTPhQg3Y6axBGXso0ZWhATY22JwSvRMrLOjHkB3EyIbkxlFSS0WrVJJUfz3Ap
	ZN+KO0VOkEm5+wqqdaXqrgJ24Zvqh6eQ1ZoJ0cooX/bVxDiCG6TeMThaUO+obJ38E3hjg2pbhq0
	KFpAhsmDekdlPrcSNQV2gq6oxQdJKRT0mPIei+UOV+MCjgLKnk6jFATOOBgz3arZrOYe37aYugH
	kPt/hw==
X-Received: by 2002:a05:6830:81d8:b0:81c:9abc:974b with SMTP id 46e09a7af769-845021dcfa5mr5244058a34.17.1792421339331;
        Mon, 19 Oct 2026 07:48:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-849859184easm2804163a34.23.2026.10.19.07.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:48:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Test that a signed program with CO-RE relocations is refused
Date: Mon, 19 Oct 2026 16:48:50 +0200
Message-ID: <20261019144851.4052056-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019144851.4052056-1-memxor@gmail.com>
References: <20261019144851.4052056-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; h=from:subject; bh=Z8tlh1BcQ4RQzZxqBONrIPgKcJMRVs5xw/h5Zr7K/sU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeua7jaz1s9rpV/ccC+xt1aOj1sl1JLwXaSnzaCwIMiDvd9p 15+OUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATKTlP8P/kBWGAoJT5Dn01KUvbpUPEN 0t+kOsb3pvWHTay2//ipqiGBkWsXwukf9/86nvlNXWl/TiDFok1tSIW5yxvqynb+Rx+QM3AA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Load a two insn program with a junk signature and one CO-RE relocation
record, and check that the kernel refuses it with -EACCES and the message
naming the relocations, before it examines the signature. Without the
check the same load gets as far as the signature and fails on it with
-EBADMSG.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/signed_loader.c  | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index a0f93756e717..e43dba8fed8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -379,6 +379,51 @@ static void signature_enforced(void)
 	gen_loader_fixture_fini(&f);
 }
 
+/*
+ * CO-RE relocations would have the kernel rewrite the insns after the
+ * signature was checked over them, with values the loader picks through the
+ * BTF it supplies. A signed load that carries any is rejected before the
+ * signature is examined, so junk serves as one.
+ */
+static void signed_core_relo_rejected(void)
+{
+	static const __u8 junk[64] = { 0x30, 0x42, 0x13, 0x37, };
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_core_relo relo = {
+		.insn_off = 0,
+		.type_id = 1,
+		.kind = BPF_CORE_TYPE_ID_LOCAL,
+	};
+	char log_buf[1024] = {};
+	union bpf_attr attr;
+	int fd;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
+	attr.insns = ptr_to_u64(insns);
+	attr.insn_cnt = ARRAY_SIZE(insns);
+	attr.license = ptr_to_u64("Dual BSD/GPL");
+	attr.prog_flags = BPF_F_SLEEPABLE;
+	attr.signature = ptr_to_u64(junk);
+	attr.signature_size = sizeof(junk);
+	attr.keyring_id = KEY_SPEC_SESSION_KEYRING;
+	attr.core_relos = ptr_to_u64(&relo);
+	attr.core_relo_cnt = 1;
+	attr.core_relo_rec_size = sizeof(relo);
+	attr.log_level = 1;
+	attr.log_buf = ptr_to_u64(log_buf);
+	attr.log_size = sizeof(log_buf);
+	fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, offsetofend(union bpf_attr, keyring_id));
+	fd = fd < 0 ? -errno : fd;
+	ASSERT_EQ(fd, -EACCES, "signed load with CO-RE relocations rejected");
+	ASSERT_HAS_SUBSTR(log_buf, "signed program cannot carry CO-RE relocations", "log");
+	if (fd >= 0)
+		close(fd);
+}
+
 static void signed_nonexcl_fd_array_rejected(void)
 {
 	static const __u8 junk[64] = { 0x30, 0x42, 0x13, 0x37, };
@@ -2187,6 +2232,7 @@ static const struct {
 	{ "signed_unfrozen_fd_array_rejected", signed_unfrozen_fd_array_rejected, BOOT_SEALED },
 	{ "signed_nonarray_fd_array_rejected", signed_nonarray_fd_array_rejected, BOOT_SEALED },
 	{ "signed_btf_fd_array_rejected", signed_btf_fd_array_rejected, BOOT_ANY },
+	{ "signed_core_relo_rejected", signed_core_relo_rejected, BOOT_ANY },
 	{ "signed_module_kfunc_rejected", signed_module_kfunc_rejected, BOOT_SEALED },
 	{ "signature_failure_logs", signature_failure_logs, BOOT_SEALED },
 	{ "signature_too_large", signature_too_large, BOOT_ANY },
-- 
2.53.0-Meta

