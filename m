Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37BE439F75
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121137; cv=none; b=a69rHP2fWNtbBwadcK7+pXEMFrYUxhFQTixTKyw6OqC9iSI/gwnwHvHX5xH458eHXbZ6U4Pmi9kCn+NdxYzq/T7BNcAM2Rk2IuQPotebMmwVY+KOQWNRERmE/YbrkwB6U5re/tOALngWUKj5VqD7kZeW5phZ5imf0JJXoW6q/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121137; c=relaxed/simple;
	bh=9Av/TW74eIut/sHNntK7n2P2ufb2SCXaHNux7ngbjNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lsza1bZZGq2lypSOeCjYeL8M2Gx6gzkNHkjNa6BCDLnbIN6GoWZf49w34hhr4/6JaF7V2rJrZt/Ia319ZI16PWr6CabNbPalVyYTnGidYVneLu1hU3WFW4M6nY+/Ej4HDwFakR169kiHhIoolCfnYL16J/AZgRzcAoGDgfH1Wn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eu5tjKlp; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu5tjKlp"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd54610so211440a12.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121135; x=1791725935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vNX8PMh0eCN8pY/C0/cKZQj0PBY9czV7xRVa4GedHWM=;
        b=Eu5tjKlpAe+cG0rpJ+eP88iGwKEaqib1c+BF2f5BQDDBnKdmzP/9vSorg2ebne2BUj
         ZlaSj8cHPrKPiQ/iWsa6JSLRaGoX03XEMPbmqQfsrMhevVgm8lgQLlGC7ejCR1dtQsa+
         gRmGw6Xnehgzx/DPSHh1UGxCtk87j2cK/E5+EN18pGT/alJ8uZ7N+54htIl/4RZHQab+
         8DskVNL2nUa9CJ8mh1EoX4BOixa+Z4R6ibZwi7NmZuUNwLbva4Xy5ROlQuYVHYaz4aCt
         TzV735iatBiW4tdjXquL7f1tyu38TK4dAHABR+JN5iBIz4bFJN46rFMVi5rRn9DBuerv
         MWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121135; x=1791725935;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vNX8PMh0eCN8pY/C0/cKZQj0PBY9czV7xRVa4GedHWM=;
        b=fBHx1uPMz8DodMm7Rga+3oXHkB8fIAF/OqgKYFcyLzQPcSHXidZTrp0pR2jVVLvKqC
         K9ltg0H1c9cRTivMSEdkaydSajxQgEx/1sSSgac55O6P2PjoOs31iY0gg94/4CSr/Cpr
         NaPwvNRwigyeJ2qjKkACQtUuCBdPhFQp5loe1e1b1eW4ol864IallpPB6VQNS2hWCAD6
         xZnqAccpF5g9jvlOrtQXPO6E3rIY/iIE4XADbhnL6MaKX0ldVcn+vsQWUu1B9VSBUJay
         UfxfsS50WMVm8abYsqtZAS5dFhUrl8fpV27FTpa56s0mpCfC7/8f5NeK+HW/SmhjAZuG
         BoqA==
X-Gm-Message-State: AFuF++kZGdunDZuZak4u3R8YVMC3GpZPsCZI4SEeN8F4YemzLwV8peLJ
	ySv7MookNvksKPXVEP3MklYiP5Z3LBipp+WhCelH/RlQ7JobFa6Nf9OZfevAVw==
X-Gm-Gg: AYBFou0M47yIfo3U6MLdVrgWB02ipIqh2pnPJZ/EtT2sPP2LGtvQsI25eT9SO+/4yah
	cM4rn0ZlCAE029LMGRerjM2FpRkhMY+hY1/LA3GPJjKkLVpPIjJcVoUcs0BLVX955E4PWlrDCA2
	H5C7m7mml8r6r+g5pevv4NnyJZxFDjLnhEQW0rNg9q/bN3nV9xcsxg1w77jYBC/gDXc24feOnJ9
	MX+lRv2P1pZ000bfz+w2JvqqfzjePr5F4PO5dUIa9g/qqpEO0Onia/DSZFI7J0Kw1nlHMBnP2wl
	dtqveIVKAGG2l2MCc3YSzyqZpdsB/4YDANVI0jI9CkwzNjBxaEuRy5PNwZOLkCHMOFmB2nK3qO5
	fMXSmKr9Xo/R7Lm5odH+w36KqLK33RXwYdG0sQUusB98Q+IiViyGgsBrqsuQ8nIWyaVmJlbNWMs
	C+Ds53Kejsdn0UaSysu7gGGvLG8oU16JbSP30acWS3sY/KkBzB6tVmG3LFyHaBOnWFIMUVLIDI7
	sXNXmrNHpFebeQ=
X-Received: by 2002:a05:6a20:94c9:b0:3dd:a196:30a1 with SMTP id adf61e73a8af0-3e0bd4935b2mr6967164637.81.1791121135249;
        Sun, 04 Oct 2026 06:38:55 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 20/43] bpf: add bpf_set_reg_range()
Date: Sun,  4 Oct 2026 06:38:02 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-20-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A utility function for setting a register's range and step information.
Used by SCEV widening and clamping logic further in the series.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 367aad258050..e1c0d0d3f1e1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1811,6 +1811,8 @@ struct arg_access_info
 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn, int arg, int insn_idx);
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
+int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		      struct cnum64 range, u16 base, u16 step);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c0907fad744b..22369b6f747d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17146,6 +17146,18 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	return 0;
 }
 
+int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		      struct cnum64 range, u16 base, u16 step)
+{
+	reg->r64 = range;
+	reg->r32 = CNUM32_UNBOUNDED;
+	reg->step = step;
+	reg->base = base;
+	reg->var_off = tnum_unknown;
+	reg_bounds_sync(reg); /* this should infer the tnum alignment */
+	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
+}
+
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {

-- 
2.53.0
