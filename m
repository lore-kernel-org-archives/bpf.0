Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577524;
	b=sgdfxQRjYipWY8GJ2cVjElT9w+K3SJhdj6+BHgQlpt6VnWuUou73GhBWKJjn+ICF/UvF
	 wjUxuWvRu/qVP9EkxVUeqzZM4HIlU0X55EeX8uCT8HRMjKEKRp1uPKbGO5enkQdg1t78l
	 81YouzKt/IVpFxTgccQUj8cnyC8SVSyhkCI97CBe5jYnCH/GfTGOFZBEx77UZUd1xuaQm
	 KwppDTDfPC9U3HJExjefrRgnhDTxOf9wOThe2Mp1c9oULwbbuJ+4PuZHfVcQZS/zJQ4kw
	 OMKMfqNgqPmNVtLvv7aFWVl4xRTs+Jx9OgB9SMMBQGjZUSJ1STVk4aGlPTv4TZonAgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1dLA7Qg3YqWzZ5p+cmNB3YEzD0Iml2SmSEBqb/OQ8Vk=;
	b=ek/dPaYVJEX6URecBc5DoYUos5ke9Va1ikkRlQ0oNiImRM5s5jUk+SREx8UQIF2+cuSH
	 bL+1qhjT1oWPq8ongMqMge/8aN1nNuK3jyzLYsW6kJYbFz/MzHPKr55yEPdnErwZvQcew
	 +BNSLDdc4bNDvTL76ZfX/L4xfgQYDozsMhls1ZTWeLew795ZTyLQaRuAgmrZsBM0l+P1h
	 m/BceW8Ud5Eo2qYwXGvkf2FabFlMa+S0gHKbFk+EkNLggg6sROhxH2L0k0T1R/nr7y+B3
	 m5Tds2eOjG78/i1kQ57SuSl0f1G2wOrsg/Opl1Um5iwhul1RFl6PftajeYRjsyDuKGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7l9F6QN;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C3F606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C3F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7l9F6QN
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so2818142a91.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577524; x=1796182324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dLA7Qg3YqWzZ5p+cmNB3YEzD0Iml2SmSEBqb/OQ8Vk=;
        b=F7l9F6QNawWER+LRWzND6PggOeEcXL0xy+6a8WS6XkA96Xh+Iros2gvi5yYyJq3ZD1
         DYUsdeeXQwbpda+j3oBYA5OnlGubnDjfDRgEMek+j/9Olrsbucjo5soYqC5Rtnk7qDxE
         LgbAV5Po/WkkHJkoTgqBkPluoPO6dotRSylAI1M3sSJphp+WBwDz8cCiEzHsdrKPuUzK
         pcpiPwCKT3OFoQ1TnCMhYoLqWbwwRaHhE2YvZn39RE6wlD/gdcYNlCGyMqbmMA6CgqhQ
         x4TUwWcg752u6bF7rqNxqqas6tvfzfz76VFq9Pag/Wgob81DLlBB5hr935AXcX8AUetb
         gkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577524; x=1796182324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dLA7Qg3YqWzZ5p+cmNB3YEzD0Iml2SmSEBqb/OQ8Vk=;
        b=UBaioLUsWkyXT5jsxhDgnwgk+GydTMedmgW9fL8UQFxB0xEPU+avVu+tolTiVjUgc1
         norJQY3gAELah609lmQTTCQfIPfwcoPH/qMTkCjeVXaJ/0u9Ogc4poBgngQTR/xwmTbY
         3w8PRmWK2GOQ26Xd4fiw517pdXs2Lx8U3z4vJPRacugV02BpH9lqB+sf2U7YpKoyq9go
         xurH00LuaxX8PbVYfSVMQ9MMZ64R8ISLVEIVC/JUy+LdFf4vjgGniz9B/c1HOQBdmX/8
         oztFV6JPRuaDs19GKG79uYcWQLM/JpFa08bO+oDX46sy/LOqZxVIuch7O2qsdWuq5Xwu
         c+8A==
X-Gm-Message-State: APuU4Z945G2/y+7f5s5Ye1uRx99gDI14vsE5irwb08l3fHiQoPLZgb+g
	xQOnYeRToSvYGwjKad6hM8zEvZWVyDJAacTjd2fmHMp9MyxOMYcE6ZhBkljGRPs7
X-Gm-Gg: AZFdTZelxHtWVoqiuapiixea2hSOy0cBDITRSYiAYtLVVW1oasCBw9RKQSsfpRuxehw
	2ditHuuY6/fW+6qERdXM2Fpf0LhrayZ0SYq/kNt8RBgadQNfbe8JrNbJUfjIxqIg93Hpg+Ys8zV
	A7aZnBrk+5fbK9M9CZ411mV8ofpODVgiI8rFLGy1qNJT1tsSmkriStxn9G8x7XYMKtATpmAWC4A
	3xuBYeqIrYUzYl7daVLMb/yaiVTjnYA1MJaRx5K+bfZ889be6FyRWQxzJqu39WwU+M+OYMVBx7a
	UoW92q0lJWAEvkDfSpquim5yhD45a44Oy5ytS8qC0y0qOSM9Z6AVrEfV2qs2avCYWWF6P3c0eLR
	dDOA4pwFB1bG1v6J7F/YSPLooomqLMaMaIK9SAkuticwWP5lOfOmiM2Pa2dxnD4gu6xxUCTKiz6
	OU1LVtqsUKZ8G37S/H949vWFc7YU3lyvapcHmWLmC+ENlsTezrS/VlgbOhFuSGN/AwK712d/thd
	Wcz20BTH+tDwsZnYa1Nxb93Qill0cdZj+DJ5eDz7Bn7oYrC5onF4PXGDbVzqnYSZMEhWWFbLX1P
	pGDG4JwuFQ+J0YDti5ir/u8bsKA60wD90ztMo06BKCNN47FADDk0myAr5KrtMCdjsB/U+xvxEcC
	XguB/+fv70c0Pw2CkZAeQMoz3M3fAdAAW6cjrnQgi1zcQ/oE+xysfP1OzMJSAbhSlmBXwFd3F+g
	==
X-Received: by 2002:a17:90b:134e:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3b41c96764dmr16184994a91.49.1795577523596;
        Tue, 24 Nov 2026 19:32:03 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm27969507a91.16.2026.11.24.19.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:32:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 24/47] bpf: Give the error of bpf_res_spin_lock() a 32-bit range
Date: Wed, 25 Nov 2026 03:29:15 +0000
Message-ID: <20261125032938.670542-25-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The verifier gives r0 the range [-4095, -1] in 64 bits when
bpf_res_spin_lock() fails. The kfunc returns int, x86-64 and arm64 leave
the upper half zero. Give the range to the lower half only.

GCC extends the result with r0 = (s32)r0. Keep the range of the lower
half there, so that a test of the sign still tells the error.

Fixes: 0de2046137f9 ("bpf: Implement verifier support for rqspinlock")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 76a50cc2138b..d29d0725ec01 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6217,6 +6217,7 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 	u64 top_smax_value, top_smin_value;
 	u64 num_bits = size * 8;
 	s64 limit = 1LL << (num_bits - 1);
+	struct cnum32 r32;
 
 	/* If every value fits the signed N-bit range sign extension is a noop. */
 	if (reg_smin(reg) >= -limit && reg_smax(reg) < limit)
@@ -6271,7 +6272,13 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 	}
 
 out:
+	r32 = reg->r32;
 	set_sext64_default_val(reg, size);
+	/* the low 32 bits fit, they do not change */
+	if (cnum32_smin(r32) >= -limit && cnum32_smax(r32) < limit) {
+		reg->r32 = r32;
+		reg->r64 = cnum64_from_srange(cnum32_smin(r32), cnum32_smax(r32));
+	}
 }
 
 static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
@@ -15538,12 +15545,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		for (i = 0; i < CALLER_SAVED_REGS; i++)
 			bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
 
+		/* The kfunc returns int, the upper half of r0 is not known */
 		mark_reg_unknown(env, regs, BPF_REG_0);
-		err = __mark_reg_s32_range(env, regs, BPF_REG_0, -MAX_ERRNO, -1);
-		if (err) {
-			verbose(env, "failed to mark s32 range for retval in forked state for lock\n");
-			return err;
-		}
+		reg_set_srange32(&regs[BPF_REG_0], -MAX_ERRNO, -1);
+		reg_bounds_sync(&regs[BPF_REG_0]);
 	} else if (!insn->off && insn->imm == special_kfunc_list[KF___bpf_trap]) {
 		verbose(env, "unexpected __bpf_trap() due to uninitialized variable?\n");
 		return -EFAULT;
-- 
2.55.0

