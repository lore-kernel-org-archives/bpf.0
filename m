Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118515;
	b=cDW/cTBBwMQuKaC59bCD5j9GpJdgzVSZ6VnuHvh+ubZecNys6McThHUOeEg4l88jGZqE
	 S3FYNmcktOoAMjLt9ZGl8NWRResOGbDY6/K7y6fFDdHeZ3Uecy978CRQ306KLnO88VHiH
	 P83FKwRxwUbFYc4TwvJDuYCp7A+uzUolmCGWO/gfNN9cOKOtezXer1A87lDQ8z5nh2AoV
	 +psA5ZszyjZB455iFHVw33tVIZJ/ZTqG0O6p8/DvXIu/DSQgqA9KYDLg9AQy8aACd/BHo
	 7UColMs7Lt0Gczoka+OVR2oA8i4QHsa22BNBXtTCAagxRP7R3SwaXBoKZG/gaFmDvsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7pu117D6K/Ncqe+5qwMIt/3GEZw46wxY8tKOlE8dy3A=;
	b=psDxJSg/O2cz0MDepfFCCsVn+S6fCP8NBENQM8IlcztAiaxk0nnyeiQXUAVnLPjyVXov
	 Elv1RlNFRJWHeVDsAMlKfP861+SQCzzT8PidK3+8fovRPJfbSG48UOF7CCeShbm3ggsGC
	 afrQvz2hfalHZ5n2s+9bAUXaeK8TVG2uxw8IpNE6RMNKPl2yrRQ9ySs+BRMYcrTtcapGY
	 Iy697a21iS1iwArnZH/fH4cWWZN0BIlS+ah95IAcdZRiUbPG/+lx4/nN/sCpGdt8VTPe/
	 u72O5KdIy/3YtDnDjW9/vL4BlvR3kLd07mlYEXApWRmKa1g8SQhP8j+JjVWpQDiqKbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=V2sOG3In;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3DF606A329
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C3DF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=V2sOG3In
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a05b210703so51771b3a.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118514; x=1793723314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7pu117D6K/Ncqe+5qwMIt/3GEZw46wxY8tKOlE8dy3A=;
        b=V2sOG3InbGFfTQ5xZxxj0nCV4HBGbSmdgRkU5K8D/y9DrY/RqVJOcTWc65pgIUck8R
         91IIt4a1FY55ldf1D3klK4fBx9iLu/+7UV8bQzJ9LfTdp4y5bad58agYAweQWl1xHwmI
         DRk+1V4v4V5ROpAUFw5uLe0CFiz6VvAfXDoyJdYP3yXNb6j/v7Ej4y1fZy0mOYLrpi7l
         SCCTMm7uIpRoKvUwflXyuZkKiYfteGxsmE35h/Wq45H55goiCo9bT5xAbLQKRnanYd5T
         lL9f/EjOJI86/UFyXow2MG2O0hQA+AJBxUwR9aJO1pCxbs9LOCPztb7HOCrDMsWrvbEo
         qb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118514; x=1793723314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7pu117D6K/Ncqe+5qwMIt/3GEZw46wxY8tKOlE8dy3A=;
        b=EyA1tkj1ukHlC123a11aZfXoJd30AIYBZgjbClm/Y/JtyB86jvzSSTyVlV9TBioDHW
         8bmGQ3rMuv7YM9J/yIs9oduRyYqZLU26c9j6lsizGaOLFAShrI/eSA3shDotxrHFXsFQ
         vAqY/zYmQhpFDsZ/1mPmEAPhUx5puhd1e+xXC7BSS27eylaLh2E/8CbKO2YdjsZIAzgV
         7eyqhWGt110Yu4la5RSP7HCqPhzcm5muI2Vpgt8VYgUuee3mq+2+iLHXZXbcPNmmr8gH
         9UIa1kePPzDsuoZBsm7MabY29fGYz/QwL8YWyUoHOL+Rnesyleq8m/Je1trffjtUvn++
         jdSg==
X-Gm-Message-State: AFq9FYJeY/c4XjSwl9khdYTs77TFpug2QlrgMM3MQTAfALsIb4BTH1yS
	N4FurlYVQfdrF+QO6At4zDCw86v3tsOXqe8+ad9KbZBR0E7jOyoq8gCyUhTFePKAUcT6WU9Mol1
	DMm4tZE0=
X-Gm-Gg: AYBFou0inzezfENO0WAaLf1oihY7DIAFINQArZ86JvhUfijE3gvxYU01WMjfpLb0iTh
	NTY2hh0B4ly7a4Zlv3af4suT3K2dIeF7tY9tJW+I0msDwenTeHDftn/BH/reOteLdr/LiqZGrVF
	ST6AH02vRs9PGpU0Vs3fBlxMhGjKfVT75q/OCLHTuo6B5tJIKpFOF1/f/BIewk9HVm9XPMupHlF
	VUB1Hyj/Meu9FVKMUU5hGlZ/rCUt2UUQj3EJfjK354oZKo2jzH4OJ5K8Ar2eUpP3KlVPOi3uB2M
	GCgAR44KjuITTS4LFrAYso6f1JSetEw8fbPtC9WQ/PLTV9z+XV49GpDUGoLfXm/0gAVeaa0sp56
	JX1rlOgxclEpY4nRaO5Q7wT4YoCB5OLfUyZwiduKEMfkoJFOH3PO55e6soWrrexubYZ3mm7QiXy
	zLhXxJl7jFveza2LIrUN/rnWMogAuV9SzmcSJSHhMqoT/fAyjSEaOYueIy72EJMKc6dDUdK9t4a
	nllvqikvar5NoQNXOY6PPz7DATcO2pgOdW4ZGn0G6jHS9By54npxDWaXbv4trW4Gacoj4pswz8L
	1VzAg1Mu+beQ3U34M/OUQn1lzetAjlk3u9afEm0=
X-Received: by 2002:a05:6a00:99e:b0:886:84c7:72b3 with SMTP id d2e1a72fcca58-8a3686c116fmr8390972b3a.26.1793118514420;
        Tue, 27 Oct 2026 09:28:34 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662c913sm257286b3a.31.2026.10.27.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:28:33 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 2/7] x86, bpf: JIT internal IRQ save and restore instructions
Date: Tue, 27 Oct 2026 16:28:15 +0000
Message-ID: <20261027162820.10887-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027162820.10887-1-emil@etsalapatis.com>
References: <20261027162820.10887-1-emil@etsalapatis.com>
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

Implement the internal IRQ save/restore instruction in the x86-64 JIT,
using the encoded destination register as the flags pointer.

Save RFLAGS, disable interrupts and store the flags through that pointer.
Restore loads the saved flags and enables interrupts only when the saved
interrupt-enable bit is set.

Advertise support only when IRQ tracing and paravirtualized IRQ
operations do not require additional work.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 arch/x86/net/bpf_jit_comp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6a2fe3d0039d..62833c0f7c97 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3089,6 +3089,23 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			EMIT_LFENCE();
 			break;
 
+		case BPF_ST | BPF_IRQ:
+			if (imm32 == BPF_IRQ_SAVE) {
+				EMIT1(0x9c);
+				EMIT2(0x41, add_1reg(0x58, BPF_REG_AX));
+				EMIT1(0xfa);
+				emit_stx(&prog, BPF_DW, dst_reg, BPF_REG_AX, 0);
+			} else if (imm32 == BPF_IRQ_RESTORE) {
+				emit_ldx(&prog, BPF_DW, BPF_REG_AX, dst_reg, 0);
+				maybe_emit_1mod(&prog, BPF_REG_AX, true);
+				EMIT2_off32(0xf7, add_1reg(0xc0, BPF_REG_AX), X86_EFLAGS_IF);
+				EMIT2(X86_JE, 1);
+				EMIT1(0xfb);
+			} else {
+				return -EINVAL;
+			}
+			break;
+
 		case BPF_ST | BPF_MEM | BPF_B:
 		case BPF_ST | BPF_MEM | BPF_H:
 		case BPF_ST | BPF_MEM | BPF_W:
@@ -5116,6 +5133,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
 
+bool bpf_jit_supports_irq_save_restore(void)
+{
+	return !IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && !IS_ENABLED(CONFIG_PARAVIRT_XXL);
+}
+
 bool bpf_jit_supports_kfunc_ret_reg_pair(void)
 {
 	return true;
-- 
2.52.0

