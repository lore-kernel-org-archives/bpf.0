Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605011;
	b=A5DUO1CytgZIlmPs5tcK/SAG5CUa8C/rMMTEMxfjcCN5K+JBD9dnlNfWrWFZ9ebVQPY8
	 0QBcKTiUScqagI1JYaSrlQIYYt3gIvEyc6hQ4jlyPfot6PpwW0kh8rQ6Vm/UQogWPE7xx
	 z8tEBmDri8wG/fhRnRr/kMtDdu4y2l5RnyzUgENPXLl9td23Yw1znpzLDRSYJlyDLBdRR
	 xLbdNG5rw5PA/pbnoL9pSOF0qfA/VZMthIcY8jjyXrJ8oFfN5oK15HET9fq0WmPoNfAou
	 3GfD0rpXPaNAeSFLhQYz0YwPROJ9uZYtZKBtsrxMP5Lf5jZkYRpcumh6rV+eiEhapgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NCiFUlem6qW8F+mY1MeWMFDksPatkBHvYOmj1bKILX0=;
	b=dKKCmMlGGyp7WNeQPpcKSm1Yo7ouGt2N/J1MqJ/kvJF/0BBVaUBWdNpG8exBdIx1zRbO
	 kh2eo1DWi62UiROvyt6eyGHz/VnGyWtPfW7GgHuIr1hRr2tBphSYlcMs9CAOlYXA+QmxE
	 BRD2ny+U9MFrVrUxTE8h5pwFh+XenlBrCuHl5utKUuk8LFeQrdrIZvZudzgsFLBakv3en
	 1acrxfybNPYmhtKl6qPx0YMDcU2jEMP6ZoOFVnxg9oGBpfFUGR0k/SEPE3UUAeJrogZJk
	 KJr91H3v2l5eSwEAzW04iTa+gPBS4Kk/ronk9DnychOUHH/VACoV1ltSmY8l2QCxWDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=JknpP7YJ;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77CC606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D77CC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=JknpP7YJ
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-16079d54c17so1860766c88.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792605010; x=1793209810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NCiFUlem6qW8F+mY1MeWMFDksPatkBHvYOmj1bKILX0=;
        b=JknpP7YJuHqK4K8JU+lEEevXFO0Z8hDPpOJEfVQ2tG7d2WjPMCUFv5PHYoIQSxw8WE
         nG8/1T3sApIfPTKf6r5g1HqBks6vEK2p6thndOk0qY7sL1QECx3lhjqY3NwIQPs/+q2Z
         rpwkpQFg6hXD/4u8LXJMUtXipenNIKBFmas3T1ToHPQ/HmS6XrqA0Jh4nmTX81FOR4gx
         s4Syr3pjelkDiFT4JaghhJ2UJEBDGM3y3l9EvUQWmDF64TZB8aa0jarD9CqxI/lFeHVa
         qoIE8Y2wsFXK4qdq8EloCuDg9Y6dSfKSWhpNK0q3l0zvjcGKOKJSitUaoyuPO3G2IlUj
         GQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605010; x=1793209810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCiFUlem6qW8F+mY1MeWMFDksPatkBHvYOmj1bKILX0=;
        b=spgR1GvhnDQGDGG38NC+NmGpo70MnHJN0njCfb9CKlH2MrrRykHcwIpfxQK3CvkLn7
         qaK3k4bdd+dLL65P2yiVlbM95FV9+raOc1R1aVCMF81lFxqlCxkfU3r/rxBaviMgWEtN
         8IMeX5O2fcrU3IsVcuT7jkmFb4UvFlBrpkTnlExz8uhKzhYs8M+m6eXImgUuBwOQXpoS
         0Ds8V5CW56+8tE2Jln1OQIcaXADzd4hOZINygHCnJvUWJufLlRYnd821VbSkKFYegM+d
         c4NMhATLEHFHbT+Dto9VP2+3Y4pmSWUIRSHzgnWdhNEKWmom0MTxHjnQVf3WLEIOThu8
         oFTw==
X-Forwarded-Encrypted: i=1; AKwUvBzXMrmbfedstvKHSArU17YhtiYPFHMc5J265Q8518BD/p0SqITFuJQ6T0eVPF1eJkpKwaQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIv3SMXoPwc/7MhL7JYkm47DGNUyj1HhYK13mecyLCNpATprt9n
	M33ZmDcs0EyLr209kT3WXh6svGGFN9g2SwIs706A/6PIG2roTF18q/FCmZa5yZ/vxao=
X-Gm-Gg: AYBFou34wLhE/OBMKz8g4O9uHzqkvjioo9niznSp3znJbZa74NFe4E/L2lmu+e5TN5k
	+hidzL7DiS5zKVhOvfxA5Z2siir0npuxQF/5ozuTtiG6dYllYuVOfhCU5LmGp1yriIF2rCxYvul
	WrUQfHgB7HpVdtRjoyEtYAJEllLwFtjo/sI7UzL5Z8ZakP++reSBv9GMhFNFDvY9qGy4kDZKr7Q
	jvJj9W87/y2hjZ68xzbzS3Zyp6n/jpp3LVNVBHBHNJLFVC01BVNVUVYs5rMskA2htzOodB+pYR5
	cHTJZyBAALZMS81SEp8MO/exsQO5TWTtb7+/btwNGblBoB2EQC67c/e1UrvOsKH/qM+c9b9ynGl
	09/WE/hwMpajofc5PE/9CdTXA5oGeTseP9KfFvIlUCzPmZgh2p9HSdGs4D0B2ktvd12RFsRRA+l
	S4OngDEevywiREu8hMCAb6Dq8xwcHZrQquekTZSCaVIQqm1zOeVeHQ1xunr6RWbrgWpdXD2oalM
	twP9T1Dxf6yqrOEQLWG0xSAU90miMR1ijOBA/YHjaUleyr2NiJQDPcwBNe2OVrYe5ZSgx4W/PuI
	RYeiPllEcAXFAijHcRcRATgalAoM9k5zp9T9vZDMVHifyRJC5pUi
X-Received: by 2002:a05:701b:204a:20b0:164:8e14:4939 with SMTP id a92af1059eb24-190a4f0471fmr3741902c88.10.1792605009716;
        Wed, 21 Oct 2026 10:50:09 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d059:e601:becb:a5ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903ca044d4sm8226137c88.17.2026.10.21.10.50.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 10:50:09 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bp@alien8.de,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dave.hansen@linux.intel.com,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	hpa@zytor.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	mingo@redhat.com,
	song@kernel.org,
	tglx@kernel.org,
	x86@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y] bpf, x86: Fix trampoline stack size for 128-bit arguments
Date: Wed, 21 Oct 2026 13:50:04 -0400
Message-ID: <20261021175004.1276-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 814cba835ef648e0c5eb79505c96c0493b29eea6 ]

btf_distill_func_proto() accepts a function argument up to 16 bytes, so a
128-bit scalar such as __int128 reaches the x86 trampoline with
arg_size == 16. But the current implementation assumes an __int128
argument only needs one register, so the register save area is
under-allocated and save_args() overwrites adjacent stack slots.

Compute the register count from arg_size for all arguments to fix it.

Fixes: a9c5ad31fbdc ("bpf: x86: Support in-register struct arguments in trampoline programs")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Link: https://lore.kernel.org/bpf/20260729050204.2586457-1-yonghong.song@linux.dev
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Assisted-by: LLM
[ Backport to 6.6.y: Remove the struct-only guard from the existing
  unbraced argument loop; count eight-byte slots for every argument. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-90358 to 6.6.y.

The backport removes the struct-only guard from the existing unbraced
argument loop. See the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 arch/x86/net/bpf_jit_comp.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8028a5a4ab64570022c15bfdf220c4033ad0d4ab..3d33aafa2cc26541e64b37960ce20a06ce5fd2d8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2467,10 +2467,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	u8 *prog;
 	bool save_ret;
 
-	/* extra registers for struct arguments */
 	for (i = 0; i < m->nr_args; i++)
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
+		nr_regs += (m->arg_size[i] + 7) / 8 - 1;
 
 	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
 	 * are passed through regs, the remains are through stack.
