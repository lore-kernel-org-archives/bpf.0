Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401897;
	b=Pj0zPa79UZ6/tZFb5PYeuLqQTyv8lgoENM88IsAmDL+29X9EpXtyHu8ChL2Mlyj9e+nR
	 RWVgu3KTQ3/bVnVbklOzHQ1YL/fnNfOvDWPmulH60QWmjWwc2LygHcHNXbvU6S5LqwgpF
	 vSyjDosHgrvGnp9nBc6UVlB1zkvz12Skn6Xl+VaMflS6UTtxWBzK/G+xgPXzcCjTJM4Uk
	 m9tgu/VQuixmQoqIA44kJRVoRpZ3aiBkkg/6WMSg3bo28762aSORmdLQ1MwoFjzvsf5PU
	 xDFbp6VszpVKNZbKJF8L6bUaPQ1rwozwh7AceIOkzBdKR1In/yYeaJv+jdT5Y4vSCMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=4hBvIh9oQq7D6mAOusToYzUJ6Dyllj/MTnnt8Rlp4Rw=;
	b=t4O3XHt+GMNXq4zbIHSqbRrAt9HoXsfMFCtCekZbm3G8a5DQiv8S3yNXk30Rb5fb4jdN
	 wmz+eiDGqYYs+Q1x36iUdrYiHiuRWRYPPr5duRGxE4vWw6oHSVqmRwsWtaOO1cI7TakML
	 KL0GQYX0mKeSiFhDCrhsstyaZMmYAp2wDu1ncN882/cor8ilkvQhV513pg0X4+JxAaxjV
	 IpdBZ+jp6WCas6EQLAM38nVFNa1IcyakEEcKXGDwAWQa4AxCR289U5mpJr1A5fa9RKHYt
	 4PUJOf/3IS4P8RWJNEYt3Or0OXdYpok5mpvrXpwgOlIuQX4T8HQ7hGiPEZf4FGTcTXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xZc+D3wx;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BE606A32E
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F0BE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xZc+D3wx
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a611dcb60dso7331735e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401896; x=1795006696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4hBvIh9oQq7D6mAOusToYzUJ6Dyllj/MTnnt8Rlp4Rw=;
        b=xZc+D3wx3XKcmtOJ4Zbrrbz7hSfmqaPs2Nbn4ovkAMOxgLhvDxCBUAxNW41iWXQ0pB
         pcGgK2lA01hPq4ovqrsUUvn2MgzvF+eWK6tAww5fteFxLUc9FUM37MqoRMuCunkRZSWD
         W185+p8FCweBjZ/OjpwDWQleZ0SxlMFFJ5V5u5joqxLwInnzAKeuG622TpF2rkiHDYz+
         Cl2YFWg3X9rdhIUCjTYMX1xoSB/SmacyVHQuRvbe/uMjx9l8YTlt6hACr3cNa8UKBsBs
         +VPrdbXo8+6XtMfhiED4STnVxQnLedloeMtZH0A1XJTrA7K6YSBenUbWLQ+0cObnow9K
         r4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401896; x=1795006696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4hBvIh9oQq7D6mAOusToYzUJ6Dyllj/MTnnt8Rlp4Rw=;
        b=xWPPT1rHVjp0kkcH6uX8/HszZa7EvHigwI3UnHrikS34f1HAu+8qiMhujiUEXSsjpr
         CoQ2faVfj7P8DvcvzlwbuxpgLUyCQJNWQ0kXdlVINxHJL3JR2tJeW0IXr138b9LKGL//
         jRNqqoHHZOXRyFiSxb2ryvor2nyCsO0ZQaxyndktLaUtyfJVt+xuhJ9gd8f75MlJoaPk
         pXmrHtjA56bP4fc1tGxe7NJIh6Hl2HcdYo3133hk3lpQ3+u09Xhvm2HYip9f+2e1iA1v
         aoEGcHQxfav8juoBhumv9a/g+7IsigXv0L5nC2WwNFEXX+VLTA/s4G/r+wCxhWMU5Hi/
         +bGw==
X-Gm-Message-State: APuU4Z8bcwM+OGxLk3hgZH2a+hhl/0edkia5c9Y2Ty3i3WYyk4f7BuKl
	GjYv0OaAQbDz+nj4NBKisXotYrJrIgkTPhp4MDGcnvxTSKjgMYi4gzt5Aku9IDrLXIo=
X-Gm-Gg: AYBFou2ehlanYaL+bt7a5f6paVNGX5Mve3Yjn05Be3WhKu4jQI8Vaj2GKb68ViidyUj
	sUqAgGBeUuQgf3kK/gysUgE9OOpkQ21IZkT7ThSkVbCsNgz/2WyMsnfb+uKMlSFWpdGF+6UVRlX
	WDO5NxdtkOKfxt0gNQ+6CLAbosj4EfSBWeK9N8SX8gJxbCU+LSGrQ8bDHR88mdQKO961xMuk+T7
	mRg1DeBvtNc98bGKMP42ZdopQ3oCrJlQcjx/EmMUdrFEmz7CKb/4pa8mJiDHtP9yGFDJcxuY2y+
	m5ICOA1U4wna/cfTuvLhrwKKD9MYOAiYtFQFBP2xOS80ouVSKU5UnT3JDNOhXfrnHup3mcCmH+5
	gbjX2GzruAAK8BPOSH3ZWGxNhXNsOD+M37U5kz2Vh4zofZkVKVt5ldnpBkcEMuSMOFnkH0qPo49
	N69o02FsOuq8M9ntsnDWy1WXBADPaTZU3C+UMV8FNCkQjZ+rzQhQxzpyxd5l/eFmE6uT5+JawaQ
	DU22d5cBcenSppdO9gumIm4juFSk66yRxbZwN/eDyilvofpYLMPNp71+aZEm/dtJ740eVLfTDej
	iq8fsn9Gni0L4vdW9WcTHecIcQRBfO2Yd+tekMrvtcnWZTWQVAeQe1CM0jb58cKSURm0vDiqnJU
	97r3Awd66U9Ct2azxZRAizFdO/49qM05iquS5J69fhbNF+6sE0EbYY/DWZqoUGwHl+4AW
X-Received: by 2002:a05:600c:871b:b0:4ab:e27d:e241 with SMTP id 5b1f17b1804b1-4ba0938a51cmr42532925e9.15.1794401895672;
        Wed, 11 Nov 2026 04:58:15 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0204784esm176603165e9.10.2026.11.11.04.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:58:15 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 28/29] selftests/bpf: Test cleanup of locks described at sites
Date: Wed, 11 Nov 2026 13:57:26 +0100
Message-ID: <edb9c688040eac1600ae4e52c5e0bec54ac79065.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5538; i=memxor@gmail.com; h=from:subject:message-id; bh=ndLmkVWA/7V11W4oBDBrM5OzTE2yWQr1+VXm2uo5+PY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzNJ/3a4XZzWsU/G7K8NzSydfb/cRr+OG55zCdJyes c0w38PVUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlkRjEyfPN/8sH95dO07B+Z 10y8eAtLj1oem303/b76Jst3E2x3czH80zxsEbjEyvj3zuuHM2dv6CjYNTvnkGW74TXWbxNdfA8 /4wEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add programs to exceptions_cleanup that throw while holding a lock that
has no hidden slot:

 - the lock of a global variable, taken by a subprog for its caller,
   which is at a fixed address;
 - the lock of a map element, found through the pointer to the element
   that the frame keeps in R7.

Check in verifier_frame_desc that each takes a site descriptor, no slot,
and no inserted instruction.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/exceptions_cleanup.c       |  3 +
 .../selftests/bpf/progs/exceptions_cleanup.c  | 63 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_frame_desc.c | 61 ++++++++++++++++++
 3 files changed, 127 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index 9ba2cd9c8097..5ef5f01a6be1 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -265,6 +265,9 @@ static void run_suite(const char *prefix)
 	/* What a frame holds that a callee acquired for it. */
 	THROW(throw_iter_from_callee, 1, "0");
 	THROW(throw_rcu_from_callee, 0, "s");
+	/* Locks the sites name: at a fixed address, or through a pointer the frame keeps. */
+	THROW(throw_lock_from_callee, 1, "0");
+	THROW(throw_lock_in_value, 1, "0");
 	/* A file and the reader of its dynptr, which goes first. */
 	snprintf(name, sizeof(name), "%sthrow_file_dynptr_held", prefix);
 	if (test__start_subtest(name))
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
index 8700349a8f9c..d6bb893f9da2 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
@@ -1887,4 +1887,67 @@ int throw_rcu_from_callee(struct __sk_buff *ctx)
 	return 0;
 }
 
+/* ---- locks the sites of a frame name ---- */
+
+static __noinline void take_glock(void)
+{
+	bpf_spin_lock(&glock);
+}
+
+/*
+ * A subprog takes the lock for its caller, which throws holding it: the lock
+ * of a global variable is at a fixed address, which the throw unlocks.
+ */
+SEC("tc")
+int throw_lock_from_callee(struct __sk_buff *ctx)
+{
+	mark_acquired(&glock);
+	take_glock();
+	if (ctx->len)
+		bpf_throw(0xeB9F);
+	bpf_spin_unlock(&glock);
+	return 0;
+}
+
+/*
+ * The lock of a map element is taken through the pointer in R7, which the
+ * frame still has at the throw: the lock is found through it.
+ */
+SEC("tc")
+__naked int throw_lock_in_value(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u32 *)(r10 - 4) = r1;"
+	"r1 = %[lock_map] ll;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	"r7 = r0;"
+	"r2 = r7;"
+	"r2 += %[lock_off];"
+	"r1 = %[acquired] ll;"
+	"*(u64 *)(r1 + 0) = r2;"
+	"r2 = 1;"
+	"r1 = %[acquired_cnt] ll;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r1 = r7;"
+	"r1 += %[lock_off];"
+	"call %[bpf_spin_lock];"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(lock_map),
+	  __imm_addr(acquired),
+	  __imm_addr(acquired_cnt),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_throw),
+	  [lock_off]"i"(offsetof(struct locked_foo, lock))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
index 0faf464d113a..e0456a929126 100644
--- a/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
+++ b/tools/testing/selftests/bpf/progs/verifier_frame_desc.c
@@ -799,6 +799,67 @@ __naked int callee_unlocks_slot(void)
 	: __clobber_all);
 }
 
+static __noinline void take_slock(void)
+{
+	bpf_spin_lock(&slock);
+}
+
+/*
+ * A subprog takes the lock and returns holding it, and the throw of its
+ * caller finds it held: the lock is at a fixed address, so no slot has to
+ * follow it out of the frame that took it.
+ */
+SEC("tc")
+__description("frame_desc: a lock a subprog returns holding, held at the throw")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1")
+int lock_wrapper_at_throw(struct __sk_buff *skb)
+{
+	take_slock();
+	if (skb->len > 100)
+		bpf_throw(0);
+	bpf_spin_unlock(&slock);
+	return 0;
+}
+
+/*
+ * The lock is in a map value the frame keeps a pointer to in R7: the
+ * descriptor of the throw names the register and how far into the value the
+ * lock is.
+ */
+SEC("tc")
+__description("frame_desc: a lock found through a pointer the frame keeps has no slot")
+__arch_x86_64 __arch_arm64
+__success __log_level(5)
+__msg("frame descriptors: slots 0 insns 0 sites 1")
+__naked int lock_in_value_at_throw(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u32 *)(r10 - 4) = r1;"
+	"r1 = %[lock_values] ll;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	"r7 = r0;"
+	"r1 = r7;"
+	"r1 += %[lock_off];"
+	"call %[bpf_spin_lock];"
+	"r1 = 0xeB9F;"
+	"call %[bpf_throw];"
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(lock_values),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_throw),
+	  [lock_off]"i"(offsetof(struct lock_value, lock))
+	: __clobber_all);
+}
+
 private(C) struct bpf_spin_lock wlock;
 
 static __noinline void take_wlock(void)
-- 
2.53.0

