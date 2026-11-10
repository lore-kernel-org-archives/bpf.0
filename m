Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271127;
	b=k7mYiSw3GWMRkUt7uC0ZBUSPwibvmObA4qvloQ0TLldAseZogiinbz6fJmkcxT7mncsL
	 OUHbpGQ5Bkg6qxCj/ywjFpeJ30eYSbIPxsEASsg7alPNSOxdqc/aJg30fI1rLJgEltIJU
	 NMXf4a0sXCILSWi2iP/yCOd1BqA9waHR2jrxH1Q/6lhLovdYqmOYJgbDfnMId1YTaPQcd
	 qQzqAHvbKpdeJ8V/rXQJ11mTaGg36lCgD4yh77cIGH1R9REGevEiMavzE5NYgenzpQ+lY
	 uBRDNuCfELy7IMWFgUJ4o/7OYKtXuDtceZzFmTL+H5Bm2bDqOYetLPCVBWB544GUxRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3JI15mL3Rqq61u8xI1VkRyYkk+ZUHPLaKVQIBMFnQeA=;
	b=RZZXBz7RM/vi214Y+tWDGeWAWOoC9yO7milIKQOU3vdn+ACVQbySLPguWmc8PEP0kGJ1
	 DNr1eR5HR7U0ccTvltTVen8UFnjP1mFsSNxEQ2JsQ11EECMRrsVB9jdmnt6tNkyU9uaXu
	 C9pi7b3HLZA15KtEkqLvFhY7RAHh6k3QxauQErsBsc82bLNgqgdpfdNLlBi8iXwlH08yL
	 tuy/pCTv/eZSDJu97QPHa2yxJvsCOo2miWriJcdjVe4mVvXj/krNktFvndWfLGzJtJXlt
	 qKQVy3TmrscvauVn9qMi8j1SGVxII/S9bc1LASrK5rcLny7MSg0m3Vd7P3eu1fZQ4OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=DkyrVuY2;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3942E606A326
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3942E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=DkyrVuY2
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso612415a12.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794271126; x=1794875926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3JI15mL3Rqq61u8xI1VkRyYkk+ZUHPLaKVQIBMFnQeA=;
        b=DkyrVuY2CV8ABTSNVC5gXoDn+AGs37ndpytgaEbv8TqRndVNPEI71NaGRImuNiFpwg
         PLaw1AQkkC9CmsZil9K9oyoX6mutu6+vRDfg5wA8/ceN24d2hUSQwjG5+jEcve5ktuTm
         cIV6UahvXgLsUGZbBMr+5Gr+IVOfTPacmIeEHAvIXNQOFNUi0fI4uuJQSdOghG3yoa9g
         O5VRoADUbAQ4CzqoEaouyVNIX1Fny8SKJ/0VkWFM+fA1sZJiUxlh7fTwrlbIAs2aJTGf
         RAZpNBZXqRuzIXfvRz+GkrZuUzyaV06wGeyC7F6HjOdiYOEL0MyWpm7eEuGLM6As4T1e
         U0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271126; x=1794875926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3JI15mL3Rqq61u8xI1VkRyYkk+ZUHPLaKVQIBMFnQeA=;
        b=tN6QFcmxAC2aURZmv28QXK6evIQ/yygJy+WpRvGlJeg/er2hD+/nA0pASvdXoXo8V3
         LW1ky0rsORlctuFL/Pste+mopjVbJMKRD+QIL1k+RJAb4blD96+DgPbP0NrEonj+HI2N
         vSuEZAKtNqdMYm/0N1l1ZDo0N/RAeBfltysdsm9RxOGPFZANCvmmO6PxfrSrOMnDK0mA
         WJ0FZrNmsVSfhsJdfLTtuYvK8efFoj5S/O8Ik+MHeZSTvTyv+kuC4n7Xb2/7+TrI3haF
         UB08OxeTAkJegFsgBh8m/s4UktG7s56zgdEoFbobrp/sMCo9nlppLsngPihZFZO+mK4K
         LCHw==
X-Gm-Message-State: APuU4Z83/nf2cCMYisWJOgksNe2Opds2rDX00ggmzSrSxTRqlBySr1wG
	bameWFxk98Sv531n/tfBlG8/G0wWAZjo58MLQF7Aetz/n1Sx9jAAdE0W96pV8B+RyAshql9Yoi/
	VxtlBQAY=
X-Gm-Gg: AYBFou35JbYe1sjciB/awWv1aVDb14P/ry7JI0kaJ0rcMn9RzFfhgj8rDqdlP3TtFtn
	bT0v1aQEOnu1LY7psViARHPJ9GJ2xXn4K9FIBEt4uLE41cffbwJiB4077iKlxbq+b0NeOJDlZA4
	lwF4lolvg3I9mmEj9nfYhmA5V4DSDoZ9PrBNDDVMRApaOaZSo7rwAflJ5l2M6TyZJhz7H2Wcris
	w1qa40XVc+Mim4thwAYM7DiCIzXOxxfXNBJwgRM6k8TRfzUKPUfl8tmjSCSFvZyXT6/wXR1EZ0+
	mSwVg90/DgnIaE67yuWOtCuNVG9oren4b6GpMjHDYckG4ao0hJ2oBvYogjFiIo21RqZF0At3N4t
	YvbqwOudIWRNSDahfhv1ONTQnUFIlf9xKtg2mRVQfTG+Uvff8UOY5RdlYh+vfai1OM1mcC8TWZJ
	wuNJrmYR4tdlDfnB34JktrvYaYLYaWc34qXRj0qxYxrKT5SWPknptC3CKgts1ZTQEPho+cNBbdE
	S7wl8RMfnt/i48AkkG3F4DE1fWRlAHAYSQaN+L/2IiQ6L5hMPfkZCcxTV0nKGgTdXK3Pi10qZe0
	Sr6maOi8cpdnmu7Sfrzeu6CC4bAned/Vk58AFhCVMVkHa7dwNvqQarymagQxw/7o1kSKcsZw6pC
	0C5C+xAs2ob/W0W+STwmwkwOQYOk=
X-Received: by 2002:a17:90a:ec83:b0:3a7:b260:9ced with SMTP id 98e67ed59e1d1-3b166cecc28mr1209095a91.58.1794271126437;
        Mon, 09 Nov 2026 16:38:46 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168eacb73sm640209a91.1.2026.11.09.16.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:38:46 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 4/9] selftests/bpf: libarena: Raise arena spinlock CPU limits
Date: Tue, 10 Nov 2026 00:38:33 +0000
Message-ID: <20261110003838.8739-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110003838.8739-1-emil@etsalapatis.com>
References: <20261110003838.8739-1-emil@etsalapatis.com>
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

Bump the maximum number of CPUs supported by the arena spinlocks
to 8K, up from 1K.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/include/bpf_arena_spin_lock.h    | 6 +++---
 tools/testing/selftests/bpf/progs/arena_spin_lock.c         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
index c0eedb59986d..8422c0939c83 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
@@ -77,7 +77,7 @@ struct arena_qnode {
  * 16-17: tail index
  * 18-31: tail cpu (+1)
  */
-#define _Q_MAX_CPUS		1024
+#define _Q_MAX_CPUS		8192
 
 #define	_Q_SET_MASK(type)	(((1U << _Q_ ## type ## _BITS) - 1)\
 				      << _Q_ ## type ## _OFFSET)
@@ -109,7 +109,7 @@ static inline u32 encode_tail(int cpu, int idx)
 {
 	u32 tail;
 
-	tail  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
+	tail  = (u32)(cpu + 1) << _Q_TAIL_CPU_OFFSET;
 	tail |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */
 
 	return tail;
@@ -509,7 +509,7 @@ static __always_inline int arena_spin_lock(arena_spinlock_t __arena *lock)
 {
 	int val = 0;
 
-	if (CONFIG_NR_CPUS > 1024)
+	if (CONFIG_NR_CPUS > _Q_MAX_CPUS)
 		return -EOPNOTSUPP;
 
 	bpf_preempt_disable();
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
index 92e75ec3844c..9e91e562a4ea 100644
--- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -10,7 +10,7 @@
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
 	__uint(map_flags, BPF_F_MMAPABLE);
-	__uint(max_entries, 100); /* number of pages */
+	__uint(max_entries, 256); /* number of pages, including qnodes */
 #ifdef __TARGET_ARCH_arm64
 	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
 #else
-- 
2.52.0

