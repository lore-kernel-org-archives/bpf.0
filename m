Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB67340407
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472095; cv=none; b=Yv8baeKwThVf+7GmxeUhm8ueVJtI7pSgvzn+y3MBsl1uO8bL0LGjZW2QgMRW2ETYqy7lrhXOWtzeWu0gEaNyvumJd5om8OxIpsc+8HBUErU0WTEqiV14RjpednsMOPtwf7RMqzbQAi+7NxLTGas5HdfOGO7GBsLcgljIP9w0g8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472095; c=relaxed/simple;
	bh=hvTzlgDzrOksH+Ma2i+rBLnZ2nt87NN/dKuU9PqkU4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocE7aiyzs/V5S9oUomgyqe3Rs3VHMQTep1ASDTyisJxyySbWB8mvNaS68mm5ZaNk0CnKSyRRlGy2EoKgIOBMEpNmC42qNlzIQY6uHlhthHGegBp3wimDMF4faCtrMN7BFzDu5NdZDmCDFJrNhOpNeaScky29pf+r3fkYZSeGo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD3yk1eu; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD3yk1eu"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-4843147998cso55669f8f.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472092; x=1789076892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcnH+X9kp/u/YiW0oEijrkvvvx+5cplTTtX1IHUqCyM=;
        b=hD3yk1eu/wDHhhybqyjoK5Sh1GJF860U7U+VIiQLDsF2BdKFP3CDDB0Z5a8YM+owiK
         DR5kUhklZcNW/5WYNRCJwhFYrL3Ks+3GHnVyx8oIKyf2f/kNmgeGqzzevbVMcz/UTKuv
         Qx3NZHYnSnT8eHIx0uxwHumRuAYJ06g2xxCP5B4x+EOQ3CfcfzQUJc+ktyJdEpKBh2Pu
         vBEVtAsYadjnmWrK1+lQVKODh9p1ewXi0xKtGdWDttOW8XewSwezjqFk93y+qxk4z1qM
         fAmKkMpldEXHEukYPIm+0od0Q4+NURDpxTQoSLG9Y+lpiwXIGYGrtY1/NLpg6wpTkn0s
         BShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472092; x=1789076892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kcnH+X9kp/u/YiW0oEijrkvvvx+5cplTTtX1IHUqCyM=;
        b=cBc8A6qjwsoCXy5oVoVSGXy6H2Hx2OZRQTx3sioSFfJdf6ofOqaheHzA0Ih7xCYn8X
         BNFHbyAB5kMaMSHD8Ht0GO75SDBS4z98DlS7ULp3S2H01KRBbXCMfGavrMUf4BVrTEN/
         VCm2/jXPgaIP7+/EgZyrd7U3zXoWo8VuanFGFT8SNMpo36pcxXpWAS6c3MAZzd6/kHJP
         B9gh7dHDheSAh4x44+4fppZ1998DYsAL1lcmEgfkVPZ4K2cKOzBmZeI/Ccx2giyWIRWs
         cHU1FneyLcUmyRJgx28OvjH/Z6bfq8Li/+8pebp7XyAvlTJpXI0MOoEJoVCChENE9SM3
         co5Q==
X-Gm-Message-State: AFuF++mLDPnwJvxyuj9DAvnWxMtGbKkBwipOosKfvXlMgf3X3c3yvWSR
	Ltu2wMhfOnL/xc/2pWTHzAqm/0ueC17MzS4Et5kI3u9MeVRqJ3QBhqAWbwXg78iz
X-Gm-Gg: AYBFou0GblC+zIJr6zT6s3chrxHIKox7HO5FHbqg8mhmoLV+yP5vtIi/ZBKz83leXfH
	l96Cii0+INdpaBMmm9+YM5RtKyg5Lg/5qOS4Y6bSEflrtYq0f2Z1N29oeLWzXVz8RfmPVx7k19m
	45lHkjkVPLW6SSXVKqvurc8sjLf/D8Z9OJT4Q0tjAdOBppr/1ojiNm4lFJlO68x3u8wlthK67wv
	86n0ml0/t+aAaalcugXWCRugY+egWoDJHsJ8bgm4uNjA0KSlrvVZFaUSTaUtq5lSd5aCXsCvYja
	uh7wgnAxITbpZypZgzbO1xI8jr4u/gGVhjzvqEaXKA9fxsEVGY89Ye7xR7WeXZaBCLH5ORy3YaQ
	4pGApDxFrR3eNArKwWfjpsF+YpuR4W+A3xITf2KcRshCKWnJuTNVHF4vpUeV4e4RI2BWeQOFQrP
	Mjkwi26Jl2IexzeXEAiEielxuLG1KJ+sRrkrFdt6MQARH+LAYEC2J2HDG4EOEiO6rxmZ6k8tAZK
	Cn9cPzJD9uV4EYi9uHz0NwZRh9561kY3aKGEfWbDKwk0W4pBa1S2tpeMEBT/kt+a/DTTY6LNSrv
	B3ZzH5KCsC7TxXVKL11IJNZqoOA=
X-Received: by 2002:a05:6000:61e:b0:485:86bf:654a with SMTP id ffacd0b85a97d-485892298edmr715103f8f.19.1788472092323;
        Thu, 03 Sep 2026 14:48:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9a67sm1331360f8f.16.2026.09.03.14.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:48:11 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 8/8] selftests/bpf: Reject legacy packet loads from callbacks
Date: Thu,  3 Sep 2026 23:47:54 +0200
Message-ID: <20260903214758.2727663-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903214758.2727663-1-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3614; i=memxor@gmail.com; h=from:subject; bh=hvTzlgDzrOksH+Ma2i+rBLnZ2nt87NN/dKuU9PqkU4E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvma7biG3MOZHJYCR6vipz1KfTM/8kyT5Mib6/b+K2f8 yRjbhtLRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZyXZiRYeHqxbu0LoZKnF0W apvT+Jw93dL8C/fTyINpk+dFv+roXcbIcHTpnAeTzJ74nitJDyo8yaga8Hz7iYuRUTKuS2ZbSuk 6MAEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add verifier coverage for the callback restriction on legacy packet
loads. Exercise BPF_LD_ABS directly in a bpf_loop callback and
BPF_LD_IND from a static subprogram called by the callback, ensuring that
callback context follows nested static calls.

Also exercise a callback which reaches BPF_LD_IND through a global
function and its static descendant. A sibling success case calls the same
global chain outside a callback, preserving support for ordinary global
packet loads. Existing success cases continue to cover loads from ordinary
static subprograms.

The failure cases expect the policy-specific rejection instead of reaching
the implicit-return path, triggering a verifier warning, or being accepted
through a function boundary.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_ld_ind.c     | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ld_ind.c b/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
index 09e81b99eecb..32989f981fb6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
@@ -194,6 +194,102 @@ __naked void ld_ind_subprog_both_paths_safe(void)
 	::: __clobber_all);
 }
 
+__naked __noinline __used
+static int ld_abs_callback(void)
+{
+	asm volatile (
+	"r6 = *(u64 *)(r2 + 0);"
+	".8byte %[ld_abs];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(ld_abs, BPF_LD_ABS(BPF_W, 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_abs: reject in callback")
+__failure __msg("cannot use BPF_LD_[ABS|IND] within callback")
+int ld_abs_callback_reject(struct __sk_buff *skb)
+{
+	bpf_loop(1, ld_abs_callback, &skb, 0);
+	return 0;
+}
+
+__naked __noinline __used
+static int ld_ind_callback_subprog(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"r7 = 0;"
+	".8byte %[ld_ind];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_7, 0))
+	: __clobber_all);
+}
+
+__naked __noinline __used
+static int ld_ind_callback(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r2 + 0);"
+	"call ld_ind_callback_subprog;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("ld_ind: reject in callback subprog")
+__failure __msg("cannot use BPF_LD_[ABS|IND] within callback")
+int ld_ind_callback_subprog_reject(struct __sk_buff *skb)
+{
+	bpf_loop(1, ld_ind_callback, &skb, 0);
+	return 0;
+}
+
+static __noinline int ld_ind_global_static(struct __sk_buff *skb)
+{
+	asm volatile (
+	"r6 = %[skb];"
+	"r7 = 0;"
+	".8byte %[ld_ind];"
+	:
+	: [skb] "r"(skb),
+	  __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_7, 0))
+	: __clobber_common, "r6", "r7");
+	return skb->mark;
+}
+
+__noinline int ld_ind_global(struct __sk_buff *skb)
+{
+	return ld_ind_global_static(skb);
+}
+
+static int ld_ind_global_callback(__u32 index, struct __sk_buff **ctx)
+{
+	ld_ind_global(*ctx);
+	return 0;
+}
+
+SEC("socket")
+__description("ld_ind: reject in callback global subprog")
+__failure __msg("cannot use BPF_LD_[ABS|IND] within callback")
+int ld_ind_global_callback_reject(struct __sk_buff *skb)
+{
+	bpf_loop(1, ld_ind_global_callback, &skb, 0);
+	return 0;
+}
+
+SEC("socket")
+__description("ld_ind: allow in non-callback global subprog")
+__success
+int ld_ind_global_subprog_ok(struct __sk_buff *skb)
+{
+	return ld_ind_global(skb);
+}
+
 /*
  * ld_{abs,ind} in subprogs require scalar (int) return type in BTF.
  * A test with void return must be rejected.
-- 
2.53.0

