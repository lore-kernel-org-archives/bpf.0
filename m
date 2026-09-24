Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045D415F07
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269621; cv=none; b=Wf9EdQ7BZz6h7Au9umacaiBfrnNxRtiihjpE71uBVwaylfR1hpEMCvqFLuz4Y6wo2xGjY6eC3pCg+J9jAY88xsdusH8RArkI+LWRh7riu1TBOh2sfLZVaoYwnP7uSXq7ptF6G71LAWEBNzqrLz64SoeVfqe832j2Y6lyLsq56rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269621; c=relaxed/simple;
	bh=NhlHw8/KmsZBDW2rgeMsMJZbUcS7zcHgwpTBFbHNFg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXpi0PcXrVZaZzSvENF5Jme9DyBV1RjS4QLV+Oa3IQD7C9rB2jlb4sVS7RR58DMxAHuvm/47chvwSaV3W0aMMS9YsDGG8csBI2WreY62uLsyhLdyWTZAf/DFnW5ivAcTTOSn2d/KI21qHPpV65835QLRUPB2U4Y10gFvdO3Vkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJn0xJ0b; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJn0xJ0b"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so198855e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269617; x=1790874417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6doM8jy3a1x4EW/XleKbWc4iYyEpszSF9MzKzfFDbds=;
        b=cJn0xJ0bu8c9M3IScLcfOEcYaw1XLQkzl4moJm+uPGxjt1nT8Qc5m77uiMdFNVQFJo
         h86yifoceTIlzhqitBJKQiqfZvsKu2tdMCYcQ78oGZzpxMV/I6G2VE+wrT+2gbYXQTkG
         lnHbwUU/U2ZLtnLg+/aoLfAo1+Rv5P6o25XgeDMLYib3+ghNSW4g+Q+v8KZccCI1XlLH
         ZXxnqOOSe1MOoXJsq0G6YgMCqhTUF1qgCaxJnbYnCoAYtAM59zTvkiIFIZSOHsKEVNnd
         BFrE57Nw0HkkHr9F0rRgadgBmUgXJBRbwJ0IKVepDSTG+O0afU3q/CuUrpT5f3xQ0mUc
         SPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269617; x=1790874417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6doM8jy3a1x4EW/XleKbWc4iYyEpszSF9MzKzfFDbds=;
        b=pI1rSb6xKpfLMf25ll/NWr07wbj/VUldCVP5kPdKf3O973hgSrlflxy3BDWCIjlySE
         Xv8aNkg9UJJeLiIr4u3bE8Vdr4WKiAxVCdEJ0hkCpuC2A2G2DYNBDnxCyKipcvMk+I7O
         17AIRngkQugVMmfUP8hN+hQ+OPw3U5bQ3e2UGOpUnqjyZtVHDQRCJb9j47Or8TOkXrSV
         qLQiuYoCvMRwJXE1Qjx901MHGpgMZ1+w85RoLQ+kKe1N+LZfCIh0cRl5uFK4ET0aOQp/
         conkSEJY/gnmuthyDaVtEtXwyytsLF1VLoF5nNZftSZLLUIiWxjtB/Skaky8DdQq4XVz
         wEYA==
X-Gm-Message-State: AFuF++mhmqhGcORqIQg5K7GHFdV29u4CivbRzcZXqYK1Q9YJ15TO49A0
	D1oK0I8R7h24NV/ENnssH1Q+L4UPMwOTPYC5c1CyuZXUIs1IQAw3Qbr6/MW/0lKY
X-Gm-Gg: AYBFou3zxHQ9yq8OWQhNgzIvquTojxc9rd2mJKNAfBdjfKRoJfqezm5jV7G9ETQShJe
	91XDD3qP96pYmGczHvK7H5BK/1dzyDBUg/i7KprMYOSrLDD8TIGZN2XR+I/UIyU8kjM4bbR7TrV
	CH6oPlZ9NTWNO2Khj4/Rs18LLQ4y87hxgn3p7h9v/Ue1vymEYnKmVnQVEiJmHpwJuZBgOg10jEy
	aFZcPp67XvCGiZd6MPZRJ87NXXbu6HqGraqgEa1ZqU2fCgXihVRvQjHqL6/9rLfrDRi5EeBTgxg
	mFtiZ1OhJZjxoOctm/uPkCEi0K9atIKWdhguNNdsxVh9tKKQNEcnMlI8ED9OuyPFGvrCaIp/CmH
	YublK767P/Y59vf2tVkrS2L3SadFfkcc+orPmBC/KYtei8e+Zw6hMZ4J6foyhmi1TZA2/18KR8R
	rr3UkIEgdp2C4A+fuDrz674mjoxxsQA/C5oe7zdjM+6ybFP/x/2wqkVqLgkdg0fLh/Hg6P0hd/f
	ZES5dfirv6WqoYxpewvlODGCwDOAxHm3ugEmOA0O63lvzcYsTyhcNHzXbsvaljNyGuDleOiyrhw
	e+vPlvhLCkfuueJHFC2BJ5ekF2f4CtnItCPpVg==
X-Received: by 2002:a05:600c:8b86:b0:49d:1fd8:b874 with SMTP id 5b1f17b1804b1-49fe66f13c2mr56843365e9.19.1790269617362;
        Thu, 24 Sep 2026 10:06:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cbd134sm79589495e9.9.2026.09.24.10.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:06:56 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 5/7] selftests/bpf: Test non-sleepable kfunc context
Date: Thu, 24 Sep 2026 19:06:39 +0200
Message-ID: <20260924170646.2366016-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924170646.2366016-1-memxor@gmail.com>
References: <20260924170646.2366016-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243; i=memxor@gmail.com; h=from:subject; bh=NhlHw8/KmsZBDW2rgeMsMJZbUcS7zcHgwpTBFbHNFg8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtrRMky3YxtERHvll9rtlRyOJjz6Ev2md0nDxS/fvD2i OIisx/ZHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIz6mMDBvZmWecOfhcyMPi 7qf9U6t/vbRxl49zenuuTL+mKM5pXwMjQ5euJ7vLHs1XRyKztzxNmKu2/eaKTkmPpM0b16xZYhk ezgUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A sleepable kfunc call can be rejected because the program itself is
not sleepable or because a sleepable program is inside an active
critical section.

Exercise the two causes separately. Call a sleepable kfunc directly
from a non-sleepable tracing program, then call it from a sleepable
tracing program inside an RCU read-side critical section. Assert both
the legacy verifier messages and the structured reasons.

Link: https://lore.kernel.org/bpf/2e42a1a2bf45f4d2aba7495bdc9f147558055740e2f3c8b9dae255f6c57fc13c@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/preempt_lock.c        | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 81c459435680..955391da326a 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -6,6 +6,8 @@
 #include "bpf_experimental.h"
 
 extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr__ign, u64 flags) __weak __ksym;
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
 
 SEC("?tc")
 __failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
@@ -179,6 +181,30 @@ int preempt_sleepable_kfunc(void *ctx)
 	return 0;
 }
 
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+__failure __msg("program must be sleepable to call sleepable kfunc bpf_copy_from_user_str")
+__msg("cannot be used in non-sleepable program")
+int non_sleepable_kfunc(void *ctx)
+{
+	u32 data;
+
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("kernel func bpf_copy_from_user_str is sleepable within rcu_read_lock region")
+__msg("cannot be used in RCU read lock region")
+int sleepable_kfunc_in_rcu(void *ctx)
+{
+	u32 data;
+
+	bpf_rcu_read_lock();
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
 int __noinline preempt_global_subprog(void)
 {
 	preempt_balance_subprog();
-- 
2.53.0

