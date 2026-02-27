Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E228C2DD
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153853; cv=none; b=YflLttblfPOFhCVSg/vWFLR0fWcqwX7WGQy/mldWWUXMgchYf0D994HInV+KfcB5X/6a+JXE+N/RRV3jmyH6NnbuN/UDFNojzrdrpGcZ53s7DpfHYCqBsyPkRki3zbq83z9L/gbpCuvGEImFGpTwvKNgtvvqO/5s1TsGeJEi5p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153853; c=relaxed/simple;
	bh=7Ai98hOxgTo0AqMWtIeLGJBnCliePX88pbmtYB7wEII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyAP33s3R+UZDk2CgSMTI6M2JiGBCea5DsF3hSBEMCxij/u6fmlallcimA/pra74GqKqxO/L5wPcdoe/ygAVu6SzLq39x/ons9SkzPJzRGMtphsAAJ3V+94g6+4LJy0X6RNN+6pWQkQJMxHHuR6pJt8UvfAi7DC9NeVEVj8FgHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdBsXVep; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdBsXVep"
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-677bb1c3a9dso557595eaf.3
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772153851; x=1772758651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DcbBiSaOVluQH7TK5v1jtq9kWU9o4XKYBGzgIFKtVw=;
        b=DdBsXVepeUVgfpUfhgDPA20TCLrtXQRFCodRUA/LQfYicA5yox5XUgLDu8mrSJa3Ci
         oVbdo6fNMKlK6jwQZTkx3YQK+125i9hHCazCZqr27Y7DNSbDCgKGBBxxh1950L240NDD
         npIw+hN+GNj1rSV/EpLuCvFNpDmmdN6DobuNrIOgTPt4e2eMSGHWsyCvIA6o4PWK5fS6
         sF5Gt2sDemyLMOFuwpopZ1sOUDnrqMHabNz4wYvVGDILZLpAebfgrKWA2miF3aBeBCoH
         kRiEI4H9jSj4T6nBEWOfFvciWPuvs/RfnQWwxn4i4qlf/w+5XVd4wBnAQMmhbz/cQWMh
         Ckrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772153851; x=1772758651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3DcbBiSaOVluQH7TK5v1jtq9kWU9o4XKYBGzgIFKtVw=;
        b=GpSJkBf9VPhY0WhouzkljPsloAjElrD50oPwjg0Nh1asxAkfjZsbWWaLvtOF7zoPxv
         VEtdKNMdJ5YCULaWceFm+qm2RVd2hZ07cplsaIvEvL4gXAypgYPRigPm+RJ2klqrm0Mr
         96Udtu3zO2hdncHG1Tnp0LUVonhUYdg+9RlyKxMH8t3VZid9UqzUiAME4EyO2aekvdiw
         ncUlwxI7XPO/gt+EvaREiKLi2DgJLjnq9n0VRJqJSa3Kj3XnKtNeCm+Lr//4ggDcG8lJ
         gcK8Tl18/RiZwTU24ChI/shDGFU4EnuD73rRyoEklwTpPr3mjyoWbKNeCZAyXcsLYJr9
         xd2A==
X-Gm-Message-State: AOJu0Yykkc1wQudtfHDgK7C3ZnKhxYI9ydvBVjo9e8+Qnlsnzsrpn+9q
	3flwpeb5LF0B5IxPh+6RLMlFQIy4sRweL59ORQRZaVvgs3XpO1YFMbkIy1/AMRev6U0=
X-Gm-Gg: ATEYQzzzmTqb47M0xbeSu2W4+v7hCs8AaMQ1Ge6uyCnZGKbiDR6m0vtNFRtXdhAe9n4
	X3sEfFdKfHkiuAr8InDyg4KHLpRDE15Cx5X4atkpdL/533Kcx/DwBTXvLwm6H+zUQONLPLa0i8T
	iv9GevbS3GSxkyKS22fsEnCn2mYGQy5vpH4jHc4vSPmdPPZiaYmCTeBSbnP+IV6fhnT2c65pOKo
	oKbp0u37f55KVoolKLSxZ5ppHYxI+KJrVCMRfxXNDmeg+qUH62sEJUN3kBhYl8+Jn7wnqLoVdbe
	veG1ftnfHOMfvfw+T2utcTMnPOK0/PBQieUivR2twfJFI+qTxzMs02Lpi2mHsWXyx+fGe5UX9ZL
	766cxWJE6Jy0jBNgCI1o1UUiR0pZXsApO7oOoTtFZbYlUzjDqECc4jQXzaLqLLsQ8zSJ3Pvzxtk
	tcuhHuHWayKq+CakDr6jzPn0q9y2+zUIakIXuN23xoF5Vd
X-Received: by 2002:a05:6820:440d:b0:679:dcb5:b848 with SMTP id 006d021491bc7-679faf472b3mr642214eaf.63.1772153850612;
        Thu, 26 Feb 2026 16:57:30 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d9e8d6sm2387457eaf.13.2026.02.26.16.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 16:57:30 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for ctx fixed offset support
Date: Thu, 26 Feb 2026 16:57:25 -0800
Message-ID: <20260227005725.1247305-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227005725.1247305-1-memxor@gmail.com>
References: <20260227005725.1247305-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3653; h=from:subject; bh=7Ai98hOxgTo0AqMWtIeLGJBnCliePX88pbmtYB7wEII=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoOuDAs+tT0ts19D6C+BFlE+utT6FT5l+EP6XL2q+ a3VAQM2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaDrgwAKCRBM4MiGSL8RykLiD/ 93gr26rylzSjC2efanRShO9RIf3E/5T7SZ/IcSBaoN64jjDg8mHf5a80/bZVQaSYx1xm4/GdLTyHci p+KjWX3UlzB54SD6dvLgEunhStM2lXUiTW9bW5eyuzVVsGF0Gv19RrFZXc282OpHrdtqAw0iMoIki4 6c+nw7I8vjm6+Bg3fjN5KrwWSpTH3D8tneFEsJueIe+aGwdpiixeU8MbUJ1iygRkJV1Ff7jNFKOuoa qQbIZhchnSwZ9GBXMJ9ij6rNxph+Ykgr2UH/gcwZ+ACJ1Ru/D7h3XhzQrWZ2npuqHBaW1OSDk4bw93 sYN2faHNzHlOerUoaJwttx7Qb9d721kWN9ePiJmzLor++LXgE/jMkmB775Uc89hFR33cyDg2BI1tH2 b4jHXK4S7LuhdYLe+d5Fz4zFBzr7kSIi/EgXz7IAh15/vYfc6Zyu8J+AlLxZMZKI8DBbT9o6v4hiaY bme9ucgl7X9byjCgg07rSkBb83ibDZywCEF0Yzmepn6L62xO9WxFTadlVNAd7xgF4OHmlL8yw9KddF Qowa3BbaAEIoWf4ArwsOvYp0HgKu+icm/G4RnGeRCvnSoqlDoz05m+zjBuB6ZlHBFbjYeXfee2YU85 KicHHHIph7kxOBCyfQvj/FTq/DLUqb/sGii2k8p6RJC4NVbpThq7xT0/wY6g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add tests to ensure PTR_TO_CTX supports fixed offsets for program types
that don't rewrite accesses to it. Ensure that variable offsets and
negative offsets are still rejected. An extra test also checks writing
into ctx with modified offset for syscall progs. Other program types do
not support writes (notably, writable tracepoints offer a pointer for a
writable buffer through ctx, but don't allow writing to the ctx itself).

Before the fix made in the previous commit, these tests do not succeed,
except the ones testing for failures regardless of the change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_ctx.c        | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index 5ebf7d9bcc55..371780290c0d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -292,4 +292,80 @@ padding_access("cgroup/post_bind4", bpf_sock, dst_port, 2);
 __failure __msg("invalid bpf_context access")
 padding_access("sk_reuseport", sk_reuseport_md, hash, 4);
 
+SEC("syscall")
+__description("syscall: write to ctx with fixed offset")
+__success
+__naked void syscall_ctx_fixed_off_write(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u32*)(r1 + 0) = r0;				\
+	r1 += 4;					\
+	*(u32*)(r1 + 0) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * Test that program types without convert_ctx_access can dereference
+ * their ctx pointer after adding a fixed offset. Variable and negative
+ * offsets should still be rejected.
+ */
+#define no_rewrite_ctx_access(type, name, off, ld_op)			\
+	SEC(type)							\
+	__description(type ": read ctx at fixed offset")		\
+	__success							\
+	__naked void no_rewrite_##name##_fixed(void)			\
+	{								\
+		asm volatile ("						\
+		r1 += %[__off];						\
+		r0 = *(" #ld_op " *)(r1 + 0);				\
+		r0 = 0;							\
+		exit;"							\
+		:							\
+		: __imm_const(__off, off)				\
+		: __clobber_all);					\
+	}								\
+	SEC(type)							\
+	__description(type ": reject variable offset ctx access")	\
+	__failure __msg("variable ctx access var_off=")			\
+	__naked void no_rewrite_##name##_var(void)			\
+	{								\
+		asm volatile ("						\
+		r6 = r1;						\
+		call %[bpf_get_prandom_u32];				\
+		r1 = r6;						\
+		r0 &= 4;						\
+		r1 += r0;						\
+		r0 = *(" #ld_op " *)(r1 + 0);				\
+		r0 = 0;							\
+		exit;"							\
+		:							\
+		: __imm(bpf_get_prandom_u32)				\
+		: __clobber_all);					\
+	}								\
+	SEC(type)							\
+	__description(type ": reject negative offset ctx access")	\
+	__failure __msg("negative offset ctx ptr")			\
+	__naked void no_rewrite_##name##_neg(void)			\
+	{								\
+		asm volatile ("						\
+		r1 += %[__neg_off];					\
+		r0 = *(" #ld_op " *)(r1 + 0);				\
+		r0 = 0;							\
+		exit;"							\
+		:							\
+		: __imm_const(__neg_off, -(off))			\
+		: __clobber_all);					\
+	}
+
+no_rewrite_ctx_access("syscall", syscall, 4, u32);
+no_rewrite_ctx_access("kprobe", kprobe, 8, u64);
+no_rewrite_ctx_access("tracepoint", tp, 8, u64);
+no_rewrite_ctx_access("raw_tp", raw_tp, 8, u64);
+no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, u64);
+no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, u64);
+no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, u32);
+no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_ctx, skb), u64);
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3

