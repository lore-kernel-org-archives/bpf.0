Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99137476683
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432467; cv=none; b=qRGl/d68JyIcfmPrL3readZGKwWzh+Ih7zzoNoPX7g1hIF7S66Jiw+wO2HzVSLlx+et57SK8BJsC6hGgjYaIkZyTogJt0Iqw5xV4hAzHJUr2YjuJu4baGrPRDAWd1vrmUpbf9gW480VUBFl2bKpoMJr3UPVJcwChVpZmQ6Vnp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432467; c=relaxed/simple;
	bh=8WKh6ILQeArCCkMNJRnXdzs4kCXx75aunzcZBsPV9WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2jSTZQKydra50Awvcxw0qqateSqk/RL1VhVRxG08XaSy417Dp0xF+W8IADw0rYcfUNeCSk/L5pE5C8AKNyT1k3XEIh+HMKOgyp9C9upupgMqcDeUkGxaTvu/IgR2whJ2ecmzrMvcS97jMhcGfpQKgCeHPDDp4TFg+23Ms2Zf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3pmpUCH; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3pmpUCH"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d2c37b0bso416815a91.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432466; x=1791037266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=crjq4RONIas12yYuA/eUK2riqsT3JwSyAAmCzqKpOgc=;
        b=W3pmpUCHZsWMMuT/MiiOFtB7k7Alk6xLM6AWVx+sVVlgQS2YTW5tGUDue70meKCe7K
         MOEG349C+VECvTtSHnk/DpwgIrCFJwSPAXkKF+AJrDei3rZH3p8BemIjmFobq7euUfaI
         ABLs1g8g/Tep7EkIndrTIhX4f/PeQyMkEPoYfHdO2H0yek5QVHnp55G95eO2Ssr6mo1G
         ogx9D2Qw0VaIQYc/tzCWgGD9EN0ELiz/Dpnkph5WDPQXrklijXmA3SUQNA2esQHKTGOG
         g/FDuLOGLCNXoGpksWWtlPJzGdoK8QV3ug8CRgaoo7JiIm1/umE7eMoefNPqjFOvOR17
         KTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432466; x=1791037266;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=crjq4RONIas12yYuA/eUK2riqsT3JwSyAAmCzqKpOgc=;
        b=fU99B/Wk2wD7rSU/XGUpvHDcvcIPol3207BL554LSGKXKYmPVyOPIWD+njPjO9moTc
         sZ6CFAvdP28iCfaZxWEGNJhtrsZKW1rtEKh53Sb2VSGlZbEqh+HSyMKEvvbXrweinzDE
         OMqCwJQzUfxfV9qbxEQKtvZbstx9MnKClBc74Q+J0YnOxfYlibWr01Dpe3AhA1m5e66z
         6EnyO3mWSbXMtMyZ/31dQf7OXH3X4G6ggsewyXR22GTh0P0A0y+wutOAbaxPWcVFh72l
         Lp0hfxSKGSFHRHUMvEK4nUU+Y2TquaXu8q8ncCJkKLTlTFVJ4pCzGBNIS0DhwBpHWwzM
         FEQQ==
X-Gm-Message-State: AFq9FYKygw6KL+899ZiRWIXFcTywiCh7MsLPebsIxzeGcNKvHgMnhL5M
	Bdfx8nWO2PItTsx3ESH9hED00VpiHdPavL5xyLUbQbTrLrBP6IgHXfKZ5ToQYYnC91c=
X-Gm-Gg: AYBFou16BpZsS72q+EEaCL4/Tiwh4l9+MTjSJE3kCZNgdsEsrgJx4p6mKZk3q7cSyx9
	RliPrpnq9FdyZ7DJgtC8LBW/6f+cG/xxerWzM7kvaaNAkhtHk6B5p2Xo5byL+sPb2uNKNvrtrbQ
	TyHe0h4prq06LIuXGqE2zb+YUXm3AYaOTjrvYjOIck8TopdelKNitAEyR/3jY2JKRhFoLKFVx3E
	L0C3sM5ADdjIsnvWqNxnj9cp7CrRrUkMqno4Pn033BS0Z1yIEVsARlFhZPCUiU9oao4vG2knHYm
	Pi+Db0yLwlNf7IakEU7a7II0+HvQCBwUgPteLaiV/7fmDnZ8IZvCafbj117kNNHpEMzYPs6r71+
	du6Ji+a7bQAtb/DVEzLnK5GEL4IDC+XcvnxF1UkCOdFKLorhVvow/m+viCPDQrNjkq7nT5XJP5C
	v7heuGPSAbWPVdkKd9CcBa6qEBG+LhH20YUZ6IZ7vFe58ClZtIloOStTCteoI8yDMqm/ZIZPeiF
	Qx89tVN/a4RIdA6gfrjwlb7sDVZpL6AWEN9zgRJYg==
X-Received: by 2002:a17:90a:1649:b0:3a0:abe7:f0f3 with SMTP id 98e67ed59e1d1-3a0abe7f56emr3828666a91.0.1790432465753;
        Sat, 26 Sep 2026 07:21:05 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	Eduard Zingerman <ezingerman@fb.com>
Subject: [PATCH bpf-next 21/36] bpf: record basic-block ends in insn_aux_data
Date: Sat, 26 Sep 2026 07:20:19 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-21-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <ezingerman@fb.com>

SCEV needs information about the program's basic-block structure.
Piggyback on compute_predecessors() and set
insn_aux_data->bb_end for an instruction if:
- it has multiple successors, or
- it has multiple predecessors, or
- it is a jump instruction.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/loops.c           | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f2497236542c..728567bde055 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -729,6 +729,7 @@ struct bpf_insn_aux_data {
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
+	bool bb_end;
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index e269870f6a6e..5f52a88d5283 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -4,8 +4,23 @@
 #include <linux/slab.h>
 #include <linux/bpf_verifier.h>
 
+static bool is_cfg_jump(struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 opcode = BPF_OP(insn->code);
+
+	switch (class) {
+	case BPF_JMP:
+	case BPF_JMP32:
+		return opcode != BPF_CALL;
+	default:
+		return false;
+	}
+}
+
 static struct bpf_iarray **compute_predecessors(struct bpf_verifier_env *env)
 {
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_iarray *succ, *preds, **result;
 	struct bpf_prog *prog = env->prog;
 	u32 *num_preds, i, s, sz, len = prog->len;
@@ -54,6 +69,10 @@ static struct bpf_iarray **compute_predecessors(struct bpf_verifier_env *env)
 			preds = result[s];
 			preds->items[preds->cnt++] = i;
 		}
+		if (succ->cnt > 1 ||
+		    (succ->cnt == 1 && num_preds[succ->items[0]] > 1) ||
+		    is_cfg_jump(insn))
+			aux[i].bb_end = true;
 		if (bpf_is_ldimm64(insn))
 			i++;
 	}

-- 
2.55.0
