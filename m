Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273782;
	b=QriT5xZiHvDSKF4bSkuYaoBHPIECiphvjGnlvCBFRjyZzBqrSjQYfR4bTTfEz7d71XAs
	 ipQXPEX6Cw7LJBbH5677/j2vUtLS/kOOhgG+jLRGsiU8ov8HD4qXALoBxWmL9r1wrtkri
	 cIW/tBYblLxtaZ+KkhQ85NDzQOVCkOyUS3XgvEEtq6dQdwR43urQNaIzRCpZALFplNXfC
	 7xGmvKGSqJVDIrodGjithMkH0nPxAMwxoqySxHhOS+bbV3xpqoe+J/xrPoa/9oxlaMyKK
	 CSd0Q/s1EZYEvWmuLjhgSP8fIWxRMcpu24KiQ3AV2mXUZxV6JOWhPTKwlmIlSg268qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273782;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zDcWjEiuTeWEvpP/9tc/MwWduB+JGfUQadQax8dMPQY=;
	b=Uk9mO58VhH0lRPs6EodSMIZj73z/p6wzLEfopGDLxGxc3KdZwQtENnWpc/gsaet7PJ/F
	 88mvakm+83GVVgy5s7o7Jlc2uhbwduSvarecg09mamMORIwUeIrLc1BBY2nns/kJiv11N
	 WQcQQvpywSRQyVmr95BFXg7ER2nP43d6H6PEh0qPyldzBTy5p8Pe+u2TmYf3yBN0LSJxv
	 aLig0hnEpuiJufE8lEjF8CAljr3dDqrpUzY9CJOiIHEXhzcKr2JV9YnpnIlop6y+CuzS+
	 mfRj6UB1KQHD/3Kgt5obCillBAr+3+3m1YRgEzmYF6RTN4R6SNt6dasrWebrdf4YTIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Cs29LN2V;
	arc=none smtp.remote-ip=95.215.58.18
Received: from mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070960A382B
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 01:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C070960A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Cs29LN2V
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=B8IHCXgmRdg1OYPmSUOl1x4rvW8jBb9fhzbRGWNLTsM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794273779; v=1; x=1794878579;
 b=Cs29LN2VHlAOEjnMd3Gru4jSkSiDLqmKvlECKk9+WEUqQTAxpk0Ydjl1qntxQHcq0ojBh7R/
 GdkG3PuyxOiBui1dNP3zOp26WWCyg9Jvd2KNk4s1kGbOfXKMeUU9O/2VQajlimu98U7glguSp/A
 QUL3lHHpNQ+dAWDBtCFWHSOw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 492985442f232e3a;
	Tue, 10 Nov 2026 01:22:58 +0000
X-Mizu-Trace-ID: 492985442f232e3a
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org
Cc: longman@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	acme@kernel.org,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	llvm@lists.linux.dev,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [RFC PATCH 2/2] local_lock: do not put btf_type_tag on the lock guard type
Date: Mon,  9 Nov 2026 17:22:35 -0800
Message-ID: <20261110012235.1024461-3-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110012235.1024461-1-vineet.gupta@linux.dev>
References: <20261110012235.1024461-1-vineet.gupta@linux.dev>
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

local_lock.h applies __percpu the same way the per-cpu declarations do,
and hits the same problem as the previous patch:

	DEFINE_LOCK_GUARD_1(local_lock, local_lock_t __percpu,
			    local_lock(_T->lock),
			    local_unlock(_T->lock))

	local_lock.h:86:1: warning: ignoring attributes applied to
	'struct local_lock' after definition [-Wattributes]

which -Werror turns into a build failure, four times over: the same
pattern is repeated for local_lock_irq, local_lock_irqsave and
local_lock_nested_bh.

local_lock_t is a typedef of struct local_lock, and DEFINE_LOCK_GUARD_1()
hands its second argument to cleanup.h, which forms a typedef of it and a
guard struct holding a pointer to it. An x86 defconfig preprocesses the
line above to

	typedef local_lock_t __seg_gs
	__attribute__((btf_type_tag("percpu"))) lock_local_lock_t;

	typedef struct { local_lock_t __seg_gs
	__attribute__((btf_type_tag("percpu"))) *lock; } class_local_lock_t;

Both put the tag on local_lock_t, an aggregate: the first on a typedef of
it, the second on the pointee of the guard's member. Every variant of an
aggregate shares one DIE, so there is nowhere to record it, exactly as for
DECLARE_PER_CPU() of a struct. clang writes the annotation into DWARF
without complaint, but pahole does not translate it from that position,
so with today's toolchains it reaches BTF from neither compiler.

Use __percpu_var here too, which leaves

	typedef local_lock_t __seg_gs lock_local_lock_t;
	typedef struct { local_lock_t __seg_gs *lock; } class_local_lock_t;

Sparse keeps the __percpu address space, and the __releases() casts to
"local_lock_t __percpu **" further down are unchanged, so the pointer
spelling the tag exists for keeps it.

Unlike the per-cpu declarations this changes no BTF at all. A tag in that
position was never recorded, so there is nothing to remove, and the one
percpu TYPE_TAG that does reach a local_lock type comes from those casts,
which keep it. An x86 defconfig built with clang is identical with and
without this patch: 152551 BTF types and a 6828300 byte .BTF either way,
and .text is unchanged. The patch removes a GCC diagnostic and no more.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 include/linux/local_lock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index b8830148a859..9d3d62e46007 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -83,13 +83,13 @@
 #define local_trylock_irqsave(lock, flags)			\
 	__local_trylock_irqsave(__this_cpu_local_lock(lock), flags)
 
-DEFINE_LOCK_GUARD_1(local_lock, local_lock_t __percpu,
+DEFINE_LOCK_GUARD_1(local_lock, local_lock_t __percpu_var,
 		    local_lock(_T->lock),
 		    local_unlock(_T->lock))
-DEFINE_LOCK_GUARD_1(local_lock_irq, local_lock_t __percpu,
+DEFINE_LOCK_GUARD_1(local_lock_irq, local_lock_t __percpu_var,
 		    local_lock_irq(_T->lock),
 		    local_unlock_irq(_T->lock))
-DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
+DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu_var,
 		    local_lock_irqsave(_T->lock, _T->flags),
 		    local_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
@@ -100,7 +100,7 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
 #define local_unlock_nested_bh(_lock)				\
 	__local_unlock_nested_bh(__this_cpu_local_lock(_lock))
 
-DEFINE_LOCK_GUARD_1(local_lock_nested_bh, local_lock_t __percpu,
+DEFINE_LOCK_GUARD_1(local_lock_nested_bh, local_lock_t __percpu_var,
 		    local_lock_nested_bh(_T->lock),
 		    local_unlock_nested_bh(_T->lock))
 
-- 
2.53.0-Meta

