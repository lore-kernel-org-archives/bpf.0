Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBFB3C3F52
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845486; cv=none; b=m64gOq6uq4nvuaxQHMrCco2xq3gp8DXEFjrhuJ3gkH9wrTaAeJ/E/Pd4P2ujJzxk4XdnyjSWdhErJcfcaRZxU2Ud5ucWJ2ysO8EYxGrhz+a/60bjiap9vowUA9G2LpJChR7sSyVLD9aQXy+2w87wvlVXCxzp/ggzaM16mS5xLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845486; c=relaxed/simple;
	bh=EpRJKEYSiz1NSHR/dT++VDCWF+hWBEbDGgjE238+1OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XucdwIEuBW4jr7NhXwoPn2MrOTrtwW55T1iBobElhRort86BFLKq5zRjnh5nSUzmvuHNNrBmL3F02nB8F3yaAr16uyHbfE1NBYG1Ukcs/BRNQaVavS2zuAOmcHBU60IpLrLxuWD4yWSZJM4dbipsIXogb60MYk5ZIBGVdKtfUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpE1jk7p; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpE1jk7p"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso518633f8f.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845483; x=1787450283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=auBeWHiVqurCBkcr8tyKi0DxpLDt4UBHKgmgMxUVA7A=;
        b=mpE1jk7pC2QcZKMj00giFj+fke2YF9x+f0fZRdCqsj5FmeothpMW3Fk2+xSJneFWME
         9viLEYXQvKXcftrtqTPeDkSZGb76DO3oACSbH/wSBCvBF/8abPReYwcPJ1nc002If5fc
         deUpXQhYXf8PbAmTM1rwnKjPbhifti7oYRnH04TLw4NvIzs1Lzam+aXRzyIh2l9GYa+y
         JHeGkfZagrX/Y4meS8yATCjXwINF2XjUOEJl7zivZHTPHDq0us3IaAlRsQZdWCEHVD61
         bVMtirJwbG/mjn7hEV2MbW2qzbhp64kZap6K+oIlPMZ/GKqKGNwAnb2/KkJQOshS/EP/
         AppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845483; x=1787450283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=auBeWHiVqurCBkcr8tyKi0DxpLDt4UBHKgmgMxUVA7A=;
        b=ZyC+FoVsbdafl9ZyAzaaSUG25BxzQA5z9HDiS9O1nuOqMPBWIQPBRCkSCfZG6f26LA
         kMlFYbqdLjhfS0gCwWPuuH0t4h3BmcTthcjdUo9ENN6cJJTgpUjsBMfPnJwMbGoaLTIi
         HxC44YxqOvQxAFi6bTJ0u9bD+V/JZTwLbwIoek46S73sZ1sAJG300HQ9tuEhIoSICsQP
         EP2Cle/+uyPCP2sZqmRTepE+cD/C47qqlfjyyyH1giukLg9nQD4vj3N6AZlo25qFfQZ4
         CjnHVdIEWAqiVVNRs2h7TsFxUpigJj3nmkS9yJJziRXiPYcp7xqevM2pXrdLdiPPITPh
         nG1w==
X-Gm-Message-State: AOJu0Yz8Gz16T8wefa8ulE7xRsF3LIxl5I//a9Mb2fWACPmhC7/frJ/T
	p+PPnQ3YWA0Itgx0t0SJVL9w6Hk41FzzxgrqsP+nVk6+IZQK8x9gmapvkrBaCBDf
X-Gm-Gg: AR+sD128HXnpieKlLa/MMy2xDCBDypCjp/ojZ1tj0ecrmZ94W/rT/cvtB3l3Ps/1q43
	5WHPtG8UjipZRs42Yy0So6NNYgHHh/9Afqatqzoan/I5rvUMMdtnSdiGo+I51WlMnD4hZOsoQ4K
	97j0ig//ieffMkqtftIVu68l4XOYRYThLpqBaJge/5V+u53B5Iw0R169jsrLrabt6cQhDuzBYNj
	prRnMeR+tXfRXpf6MYrlK/jhmIOEstvnW3f7MHBbfaKiQeKe8QumxsYEB9p+CsReSIlspxcQAJ6
	+h/gm8NkI5hZUtpthCZCucRgmLr9C1wcP864/pBRH40fn96wF5L8CMx/PLSwtA8441nzkZ5SfXs
	rCX090T3uOuzWzcWsllkx417IXRxHRwcZsWSuRtmIotfEq9uCbE0L9jh9yHQppqqo4Tn2CCq5Gy
	hxUazwGjmU7qbycLvVYY3vjniMe/EPOOcE6bDirBrBE0NKojHquyBpnfBkqwVoZ44tH29JZSENC
	kzvYgcEPq/1GDy9oBYcm3uGMmZAURukUFV72CkKuYHrWqy7zm+U8592UUTjyMfrgCcHbI9OIy2d
	KTIldeUcAdcoclH8mtsZn7XdPlo=
X-Received: by 2002:a05:600c:468d:b0:498:8e6:d464 with SMTP id 5b1f17b1804b1-4998797dd82mr188039555e9.14.1786845482881;
        Sat, 15 Aug 2026 18:58:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996100184sm5286095e9.1.2026.08.15.18.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:58:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 11/14] bpf: Preserve source attribution without source text
Date: Sun, 16 Aug 2026 03:57:39 +0200
Message-ID: <20260816015746.2632990-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400; i=memxor@gmail.com; h=from:subject; bh=EpRJKEYSiz1NSHR/dT++VDCWF+hWBEbDGgjE238+1OA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQmL6d+e3K6fLXl5+MWROslTOratyNacEzpWJz39V7 HOsftXhjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEyk/BTDP6O8itrXSjpzjZ+x uYSUsPdLs7LwaKzQnXd+v9LM7E6BWEaGJw+qC4s7rYTNbwblSFk4HlgyM2j6PxF1xo6/+QpBa55 zAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

GCC emits BTF line records with a file name and line number, but leaves the
source line string empty. bpf_diag_source() currently treats that empty string
as if the complete line record were unavailable, so diagnostics fall back to
an instruction number and discard the function, file, and line attribution.

Print the available source location before deciding whether source context can
be rendered. When source text is absent, omit only the source context and retain
the diagnostic annotation and instruction context.

Fixes: b9c5d822f677 ("bpf: Add source and instruction diagnostic context")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index df9259fa0ea7..44d0b7c5f05f 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -833,11 +833,9 @@ static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const ch
 	linfo = bpf_find_linfo(env->prog, insn_idx);
 	if (btf && linfo)
 		bpf_get_linfo_source(btf, linfo, &src);
-	if (!src.file || !*src.file || !src.line || !*src.line) {
+	if (!src.file || !*src.file) {
 		diag_write(env, "  insn %u\n", insn_idx);
-		diag_print_source_annotation(env, 0, 0, label, msg);
-		diag_print_insn_context(env, insn_idx, disasm_lines);
-		goto out_restore;
+		goto out_annotation;
 	}
 
 	subprog = bpf_find_containing_subprog(env, insn_idx);
@@ -847,6 +845,8 @@ static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const ch
 		diag_write(env, "  %s @ %s:%d:%d\n", func, src.file, src.line_num, src.line_col);
 	else
 		diag_write(env, "  %s:%d:%d\n", src.file, src.line_num, src.line_col);
+	if (!src.line || !*src.line)
+		goto out_annotation;
 
 	start_line = src.line_num - BPF_DIAG_CONTEXT;
 	end_line = src.line_num + BPF_DIAG_CONTEXT;
@@ -889,7 +889,11 @@ static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const ch
 			diag_print_source_annotation(env, width, indent, label, msg);
 	}
 	diag_print_insn_context(env, insn_idx, disasm_lines);
+	goto out_restore;
 
+out_annotation:
+	diag_print_source_annotation(env, 0, 0, label, msg);
+	diag_print_insn_context(env, insn_idx, disasm_lines);
 out_restore:
 	diag_fmt_restore(env, mark);
 }
-- 
2.53.0

