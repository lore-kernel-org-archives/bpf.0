Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044C3C2B81
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867008; cv=none; b=XcqOmzjCh2FIFT670HhlY1aRzbGxyv/KumNCZbMCOBCy+iH6uf2QywYXid3YB8n5xuq0A1uZ9NkYKnUcl4RfIeTmfuypecf906d+LhEAsm0bYxukjysVGwsJ8JKoFAxRSpCCWpuGopgBtui+AzxFi5rFcoalo6FM6YMnKHXx+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867008; c=relaxed/simple;
	bh=00LfnSRhQPc8NwCIz1Zo0P0wM1qahPv0VdmWV7pRIcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7MOsTIxkQG/SQxYUMuPaPqJeTTSltn5vd17+J3kiEdJZgshovZNjAdkbtUKENJzjoUZA22maS2VrsuSIMBPkb8mKNeMplwoPG3ze5USlo3eBj5xqeHoIYgXd/CFI15izOg/GE00A7sTEWXYQG2aaWvNniY9tTiwBufPl+eUyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiHxHbR1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiHxHbR1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b45cb89f7eso76918905ad.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779867006; x=1780471806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npGqVhP8n9x6x471sGBoVF4CI1h8RVxBdHiIBPxf/24=;
        b=IiHxHbR1trugnLAV28z5GltVtP9NZVmgD3Y+Nxrnf83Rmgg5nxGkxG0FoMCG3beO+h
         9fO4BDmFmSPH1O34bY3uO7BCW8cLUfPpJlcZgybkW+m2HPcFb/d35j3+aiTukhkNrA1w
         w/pimAggDlfNWAldm4KW+vIpM5APeG8X4hEpW6CQEDsBQpuyT7m+5bIuhN+mtieYp50b
         pjiHKQtfO7b9Cun1vyUJa88/r4pnrmGzSlPgLKUODUaDynMMl+UUvRMOYa/Y+xPqNvux
         6w75aEWLwxBjZUq/fGfanxagctAMZMfqIs8hG98Xc2jyhehcg6Q8CvM1S0EkIW8Cr28i
         bt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779867006; x=1780471806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npGqVhP8n9x6x471sGBoVF4CI1h8RVxBdHiIBPxf/24=;
        b=gogP51xd717PpwHve+O1m80mWmoFAOpR11omJ3zhOW5l9R0bGlqyYW7Y7JLDHZl9l+
         9bJ2Fb9Fuq6kaVQKdZDDQ67VLUqr7HFIFqp/c2tSKP4KKmS7PDerJndTHEmHUJ7ML8Da
         tDduETkinz4VHWBS6sUxDNHrYuez9WenqCYewT6LSFpD7zPyzbsB1SB8DHyU8fJ8pHNt
         EJSZlvw/RtTJJmTv8s2fXGoyOoU9EuXfKVG7Dowk+tFyOxwfKlVeupYwT/2te5CqFMkT
         K+NOJW96TRGbhm6PVNnjURwn/i5tHYtcUKkraOAsRPjBf+IV7KHntjPnixd3A9OHGSrh
         TOdA==
X-Gm-Message-State: AOJu0YzDXGD8F8pQxb7OXpPhE2N4ytapX47ttdZ6GMCKEII1RvuYly1D
	uNWGZTFaVzmd+IdjQqlVLF2DiAnPi63VTQ/ARXZ2zVAVzS7MMbK5O4Hl6H9JCB9i
X-Gm-Gg: Acq92OEo4UJcXiLkg1IMDV0DHD3HZ4LlsX9hfkNpAdPCug67EItvrcwnjxghNzYuota
	ZTM0pKtMYTFty5U8Bmk4L860NK147Wcmk6oKUz8XA8C+J2g9lxhxyUmqi3kstS+ITL39n/Q9mQT
	jWS6zIxOBbwcmCcKz7i5Q4l2pFmQWNMdNsCaE4RErnWTx2h08QPBPLdhRm9hvbkCsYzmuxHtqZ1
	1QC5teGLpIelDHYzuuhGZWPJOuq1LLqadWt7nMgwmF4zs9ZPWbjuFHO+u/G+5hqRYZ9sQrkJ6S8
	Ij2eV6iExYPbT7duxGy40t2YC3dan+D+C8IoMvTwi9kwOAQF6NVTwkPSeJliV2+iMNTEDyEFQv7
	2pIcIFJqL3/4Bv19m80Z4Ij/T2vLjwbFE7IEvK0r3iTmeToyfxU926kCtSR+TtGmGjjkYSMeEaj
	VxhQ/3ivcQOBwppTcNHlZFAsfYmU+C2OkLXB7FxfiPkmRN7eGk/3o=
X-Received: by 2002:a17:902:e78e:b0:2bd:657f:3a1b with SMTP id d9443c01a7336-2beb065d2b3mr228804655ad.40.1779867006043;
        Wed, 27 May 2026 00:30:06 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm89242325ad.2.2026.05.27.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:30:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next v3 1/6] bpf: move live registers and scc printout to a standalone function
Date: Wed, 27 May 2026 00:29:49 -0700
Message-ID: <20260527-better-1m-reporting-v3-1-b3ede0588a75@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Tests for multiple analyses performed by the verifier need the
verifier log to contain analysis results alongside the program
disassembly. This patch moves log level 2 program dump from
bpf_compute_live_registers() to a standalone function called from
bpf_check(), in order to provide a common logging function for such
analyses (and thus avoid printing program disassembly multiple times).

This is a preparatory refactoring, subsequent commit extends this log
with loop hierarchy.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c                              | 22 +--------------
 kernel/bpf/verifier.c                              | 31 ++++++++++++++++++++++
 .../selftests/bpf/progs/verifier_live_stack.c      |  2 +-
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..16d030fdd83a 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2209,7 +2209,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct insn_live_regs *state;
 	int insn_cnt = env->prog->len;
-	int err = 0, i, j;
+	int err = 0, i;
 	bool changed;
 
 	/* Use the following algorithm:
@@ -2270,26 +2270,6 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	for (i = 0; i < insn_cnt; ++i)
 		insn_aux[i].live_regs_before = state[i].in;
 
-	if (env->log.level & BPF_LOG_LEVEL2) {
-		verbose(env, "Live regs before insn:\n");
-		for (i = 0; i < insn_cnt; ++i) {
-			if (env->insn_aux_data[i].scc)
-				verbose(env, "%3d ", env->insn_aux_data[i].scc);
-			else
-				verbose(env, "    ");
-			verbose(env, "%3d: ", i);
-			for (j = BPF_REG_0; j < BPF_REG_10; ++j)
-				if (insn_aux[i].live_regs_before & BIT(j))
-					verbose(env, "%d", j);
-				else
-					verbose(env, ".");
-			verbose(env, " ");
-			bpf_verbose_insn(env, &insns[i]);
-			if (bpf_is_ldimm64(&insns[i]))
-				i++;
-		}
-	}
-
 out:
 	kvfree(state);
 	return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8d980fdd709..3d569e36128c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19619,6 +19619,34 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+/* Various log level 2 information about the program */
+static void log_program(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *insn_aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	u32 insn_cnt = env->prog->len;
+	u32 i, j;
+
+	verbose(env, "Program dump (scc? insn#: live_regs_before):\n");
+	for (i = 0; i < insn_cnt; ++i) {
+		verbose_linfo(env, i, "    ; ");
+		if (env->insn_aux_data[i].scc)
+			verbose(env, "%3d ", env->insn_aux_data[i].scc);
+		else
+			verbose(env, "    ");
+		verbose(env, "%3d: ", i);
+		for (j = BPF_REG_0; j < BPF_REG_10; ++j)
+			if (insn_aux[i].live_regs_before & BIT(j))
+				verbose(env, "%d", j);
+			else
+				verbose(env, ".");
+		verbose(env, " ");
+		bpf_verbose_insn(env, &insns[i]);
+		if (bpf_is_ldimm64(&insns[i]))
+			i++;
+	}
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	      struct bpf_log_attr *attr_log)
 {
@@ -19771,6 +19799,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	if (env->log.level & BPF_LOG_LEVEL2)
+		log_program(env);
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 401152b2b64f..923572df4bbf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -64,7 +64,7 @@ SEC("socket")
 __log_level(2)
 __msg("stack use/def subprog#0 must_write_not_same_slot (d0,cs0):")
 __msg("6: (7b) *(u64 *)(r2 +0) = r0{{$}}")
-__msg("Live regs before insn:")
+__msg("Program dump")
 __naked void must_write_not_same_slot(void)
 {
 	asm volatile (

-- 
2.53.0
