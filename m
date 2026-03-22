Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C51DED4C
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774219892; cv=none; b=MFFrtGlKgn8xlKqhBr/kWZziFYVYUGZ8Bpelc1LLpfq4fPaJZvl+fKz9+kpQtizzRobpmWIjHWkHZa9n9LazC+eG+eGtpL2oALdCPIGTAm+66YHx7y80jsXoYbe8j8OdEnz7EUsnhJnQ5Tsi7j3KamR4G30d6xWVGHgahQ7Ay8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774219892; c=relaxed/simple;
	bh=C5bPly5nXEt1zAfNR452/7xLo2XsA1/NnmF95YCpdr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIZHGtNIjaZIu1orUOQ0gxgnZVely8PwOpY64oEwnEh2qZbjMwAfrX74TMo8/QgyL5Yf+kkeLMTu8eo4J1/m8mNGzKlfgjNQ6xd9A13AfS1UJZoR3z1xE8zPjIzQz5KDsPneN0n4n3wUXjAB4JRj2Lv+xrozGZgmPdyRcAyJSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+j1v/Hl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+j1v/Hl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a9296b3926so27158855ad.1
        for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774219891; x=1774824691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LCDXdwjvwwl9EtwdAFSnDnYdNNIwVGtw9qFUtWLRX8=;
        b=S+j1v/HlNNbYl0iyW/nxRSoH6PbUNLjAB8wE1p44TKav9qkffbEU9osni18V3JaOmy
         1en9q8KKpAi4gpKlY2iRAuWUsP8T6QVGur+8QvtigJUD1ijUI4T9Fa/SesOdQl+ONhOZ
         LiwuffOF+CXLysXtb0GQNr7fObcqZoWkPhyyzn1/e67WV/vWOdsYku2VmZCf7SYOByKP
         psfRHxUZDLJIQaV/DlVJqTVT7nutIe8fn2ELVwCCxp1UqwKTr3bJgiSR19kpZB+2l3Nt
         4hG8Jcf0x8uHq3oFbGUUuj47eBXe7mpB33yHXR9gT1fwR7WEc3m32qgjU7y6xcFT/d/2
         KJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774219891; x=1774824691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+LCDXdwjvwwl9EtwdAFSnDnYdNNIwVGtw9qFUtWLRX8=;
        b=oK6OymVnK72XiKA2re3a7erCptsG8c8RoH7pofl8/Xr+HugyPo0CxRQgVlBtjAumfP
         tR7L71YqRQYUpe/g6LH/YTg8dOLFx80+KEstowjH6OS+JQY7Tg+0GPWL7Nv8A0zdXDht
         TAc8oRgaV90zKgqk59oDbhhGSN0+8Pdq0HIrFeg7TnLQP8lVjJDhLVtvo8LSkU5eYHOh
         Qn//nDXzOfmfWE49ilmpI75OyOnAW16VrnrZh3feVp6K7a7Fj26ugpbHgi6W+rz5tKeN
         rwrUma5El3ahCHxVICkuxTmv4i+1Hxs4ntVCq10lt7STEazrTDLeK847tpXnsFMuRz0a
         /RmQ==
X-Gm-Message-State: AOJu0Yw7uyHWgtRUFGbs9hyf5oL02HEgBpQjbRIlDGmrMch6MQct++Gc
	dfxw0KwpAdojzxeBkOu4nIzsU09iex+Sco+A1CdKVRc3xV1iDNjntPyqxs0mBw==
X-Gm-Gg: ATEYQzzvyqHdl9Dpw5/Ik5KlftRVWTqlYuoe8w+Gy+4v/8GDz9cgWwm8hNzZf5TAqJ5
	7/NvwIWyaU6+ZnPzlfBCyfw0AiPFIPehLuXhkmRwci8erSmexBmgGPfDwb24i0Z90krNOc0khjs
	msyuN+u5mV34TwVAk3Mfs5AZHKjfkc1vSdlEiYeN1/MymxM1XPJjcKOfKq5nqleOymIgnCdAUNN
	beeiO7QR7WY+0Xgp72NRTECXbvLVpPXaa2pT6TheQo4ouhJpFXYWhqQe4CHm72XIDuC/CV/VuD8
	idBrZeDLQ9mrYeCDNSP4j5ObuS2mz4CQSdw2ZC26ZF6HCjB2WZ0O7pmti1EQ6tm1iuOyWfCGEzu
	KWLG7FvHWqc3VDadG2CKoUJH+WKoFv26QkHctUGY1kC7Gmvh4tQ7NN2Mp66o6ZThnQlR/xzL7b/
	vwN5NEGKCwPWUf3FasdRYJsHUhFnI6m7sxhEjtTwe+bwnPSncTshwkktReRzbNwzYFfdunvtbh9
	cjUxBYyOebKQ0DU63aH6HEl4/4uV5gX2K0Y9WYogkZZwE5sXicvbN/ZTlVJQQ==
X-Received: by 2002:a17:902:eccb:b0:2ae:4d23:3364 with SMTP id d9443c01a7336-2b0827d6452mr83669715ad.52.1774219890591;
        Sun, 22 Mar 2026 15:51:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354bce3sm106347925ad.32.2026.03.22.15.51.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Mar 2026 15:51:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test 32-bit scalar spill pruning in stacksafe()
Date: Sun, 22 Mar 2026 15:51:24 -0700
Message-ID: <20260322225124.14005-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260322225124.14005-1-alexei.starovoitov@gmail.com>
References: <20260322225124.14005-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a test verifying that stacksafe() correctly handles 32-bit scalar
spills when comparing stack states for equivalence during state pruning.

A 32-bit scalar spill creates slot[0-3] = STACK_INVALID and
slot[4-7] = STACK_SPILL. Without the im=4 check in stacksafe(), the
STACK_SPILL vs STACK_MISC mismatch at byte 4 causes pruning to fail,
forcing the verifier to re-explore a path that is provably safe.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 893d3bb024a0..8c74827d5396 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1279,4 +1279,41 @@ __naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
 	: __clobber_all);
 }
 
+/*
+ * stacksafe(): check if 32-bit scalar spill in old state is considered
+ * equivalent to STACK_MISC in cur state.
+ * 32-bit scalar spill creates slot[0-3] = STACK_MISC, slot[4-7] = STACK_SPILL.
+ * Without 32-bit spill support in stacksafe(), the STACK_SPILL vs STACK_MISC
+ * mismatch at slot[4] causes pruning to fail.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("8: (79) r1 = *(u64 *)(r10 -8)")
+__msg("8: safe")
+__msg("processed 11 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void old_imprecise_scalar32_vs_cur_stack_misc(void)
+{
+	asm volatile(
+	/* get a random value for branching */
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 0 goto 1f;"
+	/* conjure 32-bit scalar spill at fp-8 */
+	"r0 = 42;"
+	"*(u32*)(r10 - 8) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure STACK_MISC at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u16*)(r10 - 8) = r0;"
+	"*(u16*)(r10 - 4) = r0;"
+"2:"
+	/* read fp-8, should be considered safe on second visit */
+	"r1 = *(u64*)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0

