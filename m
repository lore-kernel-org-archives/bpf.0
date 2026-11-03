Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749285;
	b=t6oB3XjDLxr6MsZjvLy0RCchRml8jLod7M1tJ4dYASCD6q+ZF2sZr0oZayduvGlEkuz0
	 Y/3KllDblkW4anzGr0CGHqmg/6qPS4TdjiuEDLURE0hGFelkTJF+I2BoUJAm/A/XI129J
	 Pz0xC1Rq1VIs5gg3sgrkJQV3T5IDt7MI7M5q21WBDDd2wi6KMn0Jj93u+d+VXy7SmCBbA
	 bLlq98nkSTFWbBolF+wNezUzr0e2PBPSp8Nt+RUsLXjvXrlMZKUH3/5nwvI2DekEmtgsH
	 yEh14g/tpO5PDljknvkgF3/8yNE2QyPUJezC4HW2LxYu2zphJq2OLp2/+QxtUrVMyGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u3L2S2dQLaRCrq9IeSiGqbB7Pc7SQTltDFZtBP0uSGE=;
	b=X+nyPP7Qb4hGK84GBT1L7ABfR0N7vr+kCMggwn7lYCb3YgJQCHJq7O7bCnmrv9/QcaM3
	 3vl+drWY9qNM+o6+Z6yxbuGjtoBtJkLrapqBzcihR6m1r4RQeZbhQomhF7lSKzBFA1D8i
	 6Xf9S7ODE90R7X0hkfTukEcIkZHzaArQEtHmRUh1BnJ3zK6/Y3pz08PVJrgFLbVWC29II
	 XRUJJ+0N4X5HTds/XJoc0ZEN7Bm8uTJ4JitMH6E/50ofHgpj/dcoZ3yRscPjvexrMkW2K
	 HoEthDaswpKZEv4hsNIB5vNKja1IpBkOGFgvqZslaf+mEIYNj9OYoP1Pq/MpEZw5lmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1Osbg+B;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC65606A32C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DC65606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1Osbg+B
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso64406a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749285; x=1794354085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3L2S2dQLaRCrq9IeSiGqbB7Pc7SQTltDFZtBP0uSGE=;
        b=Y1Osbg+BKAxAopud41gcN4hk/kB27Yl21XPU/pSiz2jf3YQuF203KxUC+tpHjM/apz
         PCpdxBvRg+OtYQ7gquWbWTCjX54hk4FCutmqEUawkjqnhH9m1Bg/LFf4e1c9JJaDEcZq
         DCyoVkH+OVwWwwvoWIgQT+UazYqZS8zvvht/Yn+RUdJTmaXUyyTqYJHRklHK7fOQauz0
         wWXFdGq5ceBbzTXgpt5Li+3cvWUtOM+YiSvQtTYcgag1OAKlDQ37gukhMrfKv83JLpH0
         clo26EsfqxhSOV7mATqgnkZa5D8fyuYpuMh+XetI0/Vx+JJ+oSFOtVV20Q3Wl5pPlPul
         mrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749285; x=1794354085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u3L2S2dQLaRCrq9IeSiGqbB7Pc7SQTltDFZtBP0uSGE=;
        b=sbQ2BtIxX0FElAs3mktu/UrTpSzTzTDG7dkLK9Ul7IVSF3mIm251DUN+HmiIyIaQjB
         Drge85hFCJddEj1OjQWVl7KkOIXPLHQPAWQFA3G7FIeBJzrgloK8lmKugflz6IQ6Uyj1
         WZ0wNWwsAxwuhUsX2Ie0yQ8Kv7+AgYsXqiHJBFSITeJw+gr060c3Gz4F16VC2DOflpuw
         pAwacIQEIt+WyNRpMw9sPcuHWmkiVsCMsv7gyiHnS7Ymunq6NEpHULIb5fRfWMXWb3l3
         ZgGdCrahN5gSmmdkYmcj+hQhzbNwq5OUSpO2CpIdTqiCoyuvYVhUfRMvZ1NmGNpXVw0b
         Lpug==
X-Gm-Message-State: APuU4Z/0/b1gNIFvAj5kREkVcQE/Eagex8x91xQcMnVrPsUbFbYLh8GQ
	+tztW5LHj2RknCmlzbjfPVolRV/CM+7887xvME2TQUALNrTkt2j1c3Ub7z5sMg==
X-Gm-Gg: AYBFou3sLNoHqy1UR3PCWKgBjI4Xa4kwxcmiF0tz6A3Wh7F9VrhRHZ12reT2KZJ/yMw
	ynuYBquDO65RDXmJv4tRDsUPMpRoZ15905+Csixj+8+bA6ueSKrHDB53Q9pZsa1cbT+lznNihUg
	JRHDNNV9ajbry1ZyNoWvr73OA+idwi/xahQf/BrXZjplTax2mntgcn3ezlebNy8z28HMUTbhKje
	ssH3eQOG4mlOHU28ZOfRANkMT2Di/P6m5L3cHGhuBmlIoOSiqh9U/kVHac8JRJOLV1R1d8ZvrgB
	6DQ9SrAXupUcJBYLI8IlSJT+ul5Z4rLfQ72j149MN2mHoxH+Auqn7TdWsv6/9MFfMsAtUpL0DW1
	FpYfB7i7mPGl+wTwdgajlpk0kAAJ5MNMkIH1irdKvOomZ85k/XeLLHtKs6C2Idc+pWlXeG/jQgr
	RNKipPTf7GHU9yu/jlgEMQw0v3GdUmLG3ziy8cQB/1e40SH9iVUZPhvD7FRpR/5xQEDdMlvgF7B
	hh03tYF2JLBOW6oPETrYPO2ARtGnSYDx4f86SRYupjAHUkzKL8yxG9drwdleOwsoc7MsIoSSMoC
	X7xTDIrqw+ET2a0zhYZoPhdVJSJIGz6VK8GwlQwvHw3Delf8jAjNivfV7MQ6ImmAkmmjr2wltjb
	MVaqMU5G+AvKNg49aYoUFVzX7izOEDFYQerJ0cLL5C/L5CaGYAsKAlIXIQssV5MeXc+FoB5Z8tw
	==
X-Received: by 2002:a17:90a:d702:b0:3b0:934c:5e41 with SMTP id 98e67ed59e1d1-3b0934c6917mr555024a91.29.1793749284547;
        Tue, 03 Nov 2026 15:41:24 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09311866fsm1191085a91.17.2026.11.03.15.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:41:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 03/37] bpf: Refuse fexit on an unreliable static subprog that returns in R0:R2
Date: Tue,  3 Nov 2026 23:40:28 +0000
Message-ID: <20261103234104.208239-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

A trampoline keeps only R0 of the value that its target returns. Thus
fexit, fmod_ret and fsession cannot attach to a function that returns more
than 8 bytes. The check reads the size from the function model.

When BTF of a static subprog is unreliable, the model is not made from BTF.
It has 5 u64 arguments and a u64 return value. The check passes, and the
caller of the subprog gets R2 as the trampoline left it, where the verifier
saw the upper half of the result.

BTF is unreliable because of the arguments. The verifier still takes the
return type from BTF, and it verifies the subprog and its callers with a
result in R0:R2. Keep that decision in bpf_func_info_aux, and refuse the
attach when it is set.

fentry does not touch the result. It can still attach.

Fixes: 0630ad00d96d ("bpf: Add verifier support for 16-byte returns in R0: R2")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h   | 2 ++
 kernel/bpf/verifier.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5413fa5d2b2b..ef94a168c902 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1763,6 +1763,8 @@ struct bpf_subprog_arg_info {
 struct bpf_func_info_aux {
 	u16 linkage;
 	bool unreliable;
+	/* The function returns in R0:R2 */
+	bool ret_reg_pair;
 	bool called[BPF_FUNC_CTX_CNT];
 	bool verified[BPF_FUNC_CTX_CNT];
 	bool called_with_pkt_ptrs;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa53ee735762..dcfced2573ee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -465,6 +465,7 @@ static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
 			return -EFAULT;
 		if (ret_regs_cnt(size) > 1) {
 			subprog_info(env, subprog)->ret_reg_pair = true;
+			subprog_aux(env, subprog)->ret_reg_pair = true;
 			env->prog->jit_required = 1;
 		}
 	}
@@ -22990,7 +22991,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				return ret;
 		}
 
-		if (tgt_info->fmodel.ret_size > 8 &&
+		/* The model for unreliable BTF has a u64. The function still returns R0:R2. */
+		if ((tgt_info->fmodel.ret_size > 8 ||
+		     (tgt_prog && tgt_prog->aux->func_info_aux[subprog].ret_reg_pair)) &&
 		    attach_uses_trampoline_retval(prog->expected_attach_type)) {
 			bpf_log(log,
 				"Attach to function %s with a >8 byte return value is not supported for this attach type\n",
-- 
2.55.0

