Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F0437455
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282111; cv=none; b=ZWjDWtsQb6BfgLSPJBzEpRpjltokQWBOuUkcWZOKm+yxPnE6sHGz8I0EHkBbCEKtEy4/xrB2+gEF2b0hEKOHJZwPtMXYuN6nnGdxUWVe8z96zuVQ44a4k3pPGTFYqijhaU7x7nlUTjq0nnGAf9gR++V3aQSV4yeJR6hXjYXqZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282111; c=relaxed/simple;
	bh=+ggo3QAN93DG5nVraoyxPm3BXiTzTCVut93rqdHvQCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAljbh9w4fG0z1BZxeUseaTm2IweQ0IqMtNSHV9rNyadJxIT60ggrzLfet7OznpGFKmzpSIU/HDuibXagKngCqKeI0++JPYUeNbJkz8A8tg96Qp7A/vfjX9Yqd99GTMNxUGP85ter3bP+Ji6DvTyHVlcG8ht9aOSkr4rLnXXc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9nbVaf+; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9nbVaf+"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1c7364550so109823a12.1
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788282109; x=1788886909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S/HGfpZQkZJuO3OIYZGy+BLzb1UNMZK0dva+xfwCYNg=;
        b=C9nbVaf+Nw4uJ6LvVnQn6tzjWAatsV7gr4t9b3cG4Eoleo49xn3GGZlzepwJW1pnC9
         ZPFmPGMaZjgioDFuqsp94kG0mEmmvC0J6ANz6Szg5KiU8gFTQLIOgzkz58RdmJ2W5VSU
         E2IcM3N8fSFfPN97kGnVEQwQNvJGdnCzC81I9KKcsNX6sL9mLyp+x2i/IYgFFgfvUGrV
         VQudwy6hRYQVgBU6k218oJPQVmjuBCYI+rar959WnvhgExHkdDjf46eVrnVwymi5Fskw
         p0IIw8JXW7aNlO/5g7+7Xk72n1KySoP+ECYDnNy3wTdt2d8ETu3CdolkRlqYj3zLvcgA
         Jukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282109; x=1788886909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S/HGfpZQkZJuO3OIYZGy+BLzb1UNMZK0dva+xfwCYNg=;
        b=dnEz6F34pgjl9B1Q+21QPC53wfrqeQkkQyq0QbSwdBVHMa2oKkSZccL/fYV2pzDvwF
         sL3vs9Uu2dmBVgrSb2iVFcW+iojWplFfzHIVJJJVCI5jQxkq+x/EnlKh7GYRhN0EcMA0
         FhxQHUmPdB7vx7e/JehF0FiR3hQJt3jsOZybivg+WhKcQBKYJ7x5dGquP5LjkpZOcvNm
         9tyNKAtiVu7HMegzLapC7TtlLseRaaj1BvbCy/TVaMpL/3YvvuHOcsbYjcXNSDp/d+7C
         0p0Uq0FU0U8GkjFOHNh6B6y2aR4UiB9hJnOs/OQokqnuNMSnGyOvvlzfptLpMNXV5+a8
         UCWw==
X-Gm-Message-State: AFuF++m+GEJ0DGWuJNBEV6cEKSCVJrqx7OitdT1Lh3M9jg5g2j/ZLhHn
	cWZu4QTIiP+9Fkylx9IZGG9DWroOCNb1Nn9MbAaYVb/m3tIhXzh2NPVZL/BsRge2
X-Gm-Gg: AYBFou0b0K4oa0dF3VG2hLFo3RAFqFIHQjsVbqjd6QpWbNJRyBEldFErt1GIazsZfRt
	dutfYwZFmkAUgBjOWQLiLJZJLGjAeqOGRvFtSE/T7tq/Tf5xF5+dpRuvzYjRAHzDZ2cwE1S2yW8
	XFoYDPGMBvTj5LYntDNg1vqUh8Bop5W34EziJ6xGr00NLM7ksYc+wk6UOXtifOI596t3o0nqiNG
	PVwraO+DYV4W60My6OdafBhWflqC1lQ1JPC8ZL8SOuYjommU1uO22lyZdOkATMCJ3a0pkwNmLia
	4d+GosWdq3yN/RtBXjPlFK1J++o5UAj6+OYndwiPmayU9lQGFwgXUVPY63Dp56MAEkpctNFpZwe
	mgjs4wVgVPQrRh25gTxWsCTcoqn4VeN4LGt1W+OWXulWTvj8q5vHzTokLHsWA4Qg8GI+qdIKIwH
	ljJF6A0Eq6b6KWq4tTV0SpNAyYMKY+l/PpG1FupGUqS8OjXv9KdWKWTtmZrd/VW3Q/OmUeh9Oz9
	IqlV//wRUtqj8FZ0mcYhZFhJbRxGEQ6xXWOOzMfviAYKkCNxSbgBtjyTdm9o2h/a27pAKFu2WKm
	PQT9kSI/cdHqcNWZA9yU/A6xHKwVacwgKqFGS11ty0iZXFsjOs3JyrtYJ7Qz3e1FmzEFeqc5pXQ
	=
X-Received: by 2002:a17:90b:4a42:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-3990723f576mr13759918a91.0.1788282108659;
        Tue, 01 Sep 2026 10:01:48 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1b395sm7602073a91.1.2026.09.01.10.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:01:48 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Test terminal gotox instructions
Date: Tue,  1 Sep 2026 17:01:44 +0000
Message-ID: <20260901170144.70453-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901170144.70453-1-sidchintamaneni@gmail.com>
References: <20260901170144.70453-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that place gotox at the end of the main program and a
subprogram, with each jump-table target preceding the gotox instruction.
This tests gotox as a valid non-fallthrough terminal instruction.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 .../selftests/bpf/progs/verifier_gotox.c      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 5b18c9a27717..cfb5b648891f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -47,6 +47,48 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
 DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
 DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
 
+#define DEFINE_TERMINAL_GOTOX_PROG(NAME, BASE)			\
+	__naked void NAME(void)					\
+	{							\
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:							\
+	.quad ret0_%= - " BASE ";				\
+	.size jt0_%=, 8;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	goto end_%=;						\
+ret0_%=:							\
+	r0 = 0;							\
+	exit;							\
+end_%=:							\
+	.8byte %[gotox_r0];					\
+"	:							\
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,	\
+					    BPF_REG_0, 0, 0, 0))	\
+	: __clobber_all);					\
+	}
+
+SEC("socket")
+__success __retval(0)
+DEFINE_TERMINAL_GOTOX_PROG(jump_table_terminal_gotox, "socket")
+
+static __noinline __used
+DEFINE_TERMINAL_GOTOX_PROG(terminal_gotox_subprog, ".text")
+
+SEC("socket")
+__success __retval(0)
+__naked void jump_table_terminal_gotox_subprog(void)
+{
+	asm volatile ("						\
+	call terminal_gotox_subprog;				\
+	exit;							\
+"	::: __clobber_all);
+}
+
 /*
  * Gotox is forbidden when there is no jump table loaded
  * which points to the sub-function where the gotox is used
-- 
2.43.0

