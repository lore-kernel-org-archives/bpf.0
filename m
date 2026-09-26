Received: from mail-wr2-f7.google.com (mail-wr2-f7.google.com [74.125.225.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918B3A7F46
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465729; cv=none; b=ABNLpL+epYwUNYCYQlZm9g/ngY/RZ6z5q7OI+HF18NNLxdWRHssamwXCqpCzrx2+6MAv1YKqiH9FqJqThEoOj98/3usyiZ7+2hkfSizCBcKZk383xNmcJlreWwBX/C9qaW6pBlWTNdvL858YAjkuz2DJtZJOACfg7+sldVZ4vpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465729; c=relaxed/simple;
	bh=ZLmEI5cq/Suni8pJI8suZUXD0UDh+vhex1BG3mkFFk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4Pk2MZHcKj91wMqBbtNpZVrqu3Y/SfrHhQUvoeUizqZmlxBOM4Cl+DsoEcw/GzdzisPL1CRRucZpz+Eu7KHF2wV66uXQHjlAvu6NnyHzZg/6Bar4QmbKTpMFFLdNJpo5V9BlB3evfwhmZvXfi41oq6E5BhzMqclmke3WKul0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/p2XeDk; arc=none smtp.client-ip=74.125.225.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/p2XeDk"
Received: by mail-wr2-f7.google.com with SMTP id ffacd0b85a97d-48888103f99so271996f8f.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465726; x=1791070526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBukAGD51VpFtJSBzeBykFBrjv1g1mPavrDHfL7i5x8=;
        b=B/p2XeDkLgDkfq5CEU5dAEBFbKgiMKc5nl3hI5QYOEhrr+KkqK4HzPjiA2ZG85oV8l
         ec1mnwkN9q5R5QZjOxVlTdeQ1w0v/9SoRA6pIh6+OCiUq+Ya2eD02+Lsy2l0GCtbJfJ3
         gET1RMydtEWzdGo+48Q9wJ3m+SV2WZd1IXscqjwwTmdMvM31gCRYGuet5FxLR591kBbi
         QSFdK26I8dh8wbdweaIffzIVLDjsJSFnsMgo63lyTkLrA3WpDCPx89mY0EdSwTb32GHE
         70uCl7C5wKmWm4oav1mtMF+BjgGA1mXlVvd43jJZoVe1+hqEJt0yhzwQqtW4nCYdrfPC
         8JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465726; x=1791070526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oBukAGD51VpFtJSBzeBykFBrjv1g1mPavrDHfL7i5x8=;
        b=XQsVUIDSOd3gmzL5ZMZHl0f3hsDNdONpSBzBXpDtXbS1wdlDQalfeaeQ6+P82TDHfp
         NHfKgcVOpbsnmhuzBiF56McScOoz5/FmLOqPYT93t0nH29kM4tVgnxWDElvWGYAitVTt
         HbdFgwUM3kr/bi6UBy+7/jdYrxmkGL50eCUCxrvMdKA6E2Uq8pyredyEKTidTTqoqURd
         crBKFhH01l7xnWGXdDKhJlEtzkG4j04mUMu/h/4MRFXZQbuwdLCo0BZcwrut5XEls02l
         +uPqIF8CvPWXA2WV9hMdlGjdCmy5JjESC3Pgb3xmYbYjYSSirKLK+FqvzO0d4RDr5qUl
         XZfQ==
X-Gm-Message-State: AFuF++mOtpnlOBEWhwn2LHqtNFHeUDzh/e9UbxEHqfsyIXqwh+0nYIEN
	iy2Wwnu3whIP42DpsJ45KZdas/BCplqDDROrtWAUNKnxb0GflhyPIOfC+1BYSweZ
X-Gm-Gg: AYBFou1u8Crq7G4dsdcYdcuAiSxsBTAqDBlYNRo/NrYr4eYpCBr8XZJgEp2gFstMt62
	4/RYzIVcMyJvD6+mHVQ73aRWwbVij5VovkUY6Gnj6vaNvmV04QRDwQCf9FDGC9FEQFcjFAC787K
	Ql9nS0KIRg2mfBh4dz9UFTr+iBfp6Bk9E468uTyR8t58bw2vTJDcO7zVgJEOQrQj8nzXOGVc+2m
	OeU4p+jY4pYoF4xKYda4+aDy2mF6+ftGZ/MxcDMO3k0R9KxZa+rhdEF2xOkolQJv7M/3MFX5jtX
	Ivx4hKfnStLyoEbSOTiVyTjqc/Y4BjhZuQgSe+Mjbn5NtL18nUz64t78WAws/gYX9tvHbzHQF8o
	veqhNFnln8M+zEnILK058sCkmIWXqJCG6jeo9XY4MtupvKBga15w+8A+a3RwZZio0FhtbuEvrFH
	wHjDFjHJMH6he4KRqVd9tAKBgvIPa9nAdm9oPzuYcUfqt0Hc0OGE2426x1Hye0/nK69T7B31SoF
	oruJWI3zeV0f9vF17ORUm28GjV+h4UBDDV+wQPie4khOFds9BkoRXlT+ei4j1IqBWXoFitVQJuH
	WFJd/Ay9JOD5LJ9Et5sLkFfvPrpgv4l5nJ92Zw==
X-Received: by 2002:a05:600c:1d29:b0:49c:fc6e:a3d9 with SMTP id 5b1f17b1804b1-49fe66eeeaamr192025515e9.24.1790465726541;
        Sat, 26 Sep 2026 16:35:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018f0e79sm14477275e9.7.2026.09.26.16.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 12/16] selftests/bpf: Build BPF objects with compiler-inserted typed arena casts
Date: Sun, 27 Sep 2026 01:34:50 +0200
Message-ID: <20260926233503.3114147-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734; i=memxor@gmail.com; h=from:subject; bh=ZLmEI5cq/Suni8pJI8suZUXD0UDh+vhex1BG3mkFFk8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWAIn28TzUd9kvjy5dqLsJE+m6duQi6lfHpru2zh55 ZJ/L8W/dJSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAif7QZ/tfu1lyg/DOoLGfn NYbI/9s+/D0uv9044GCAO/fPGrtL9r8Y/odd7Npy6hZncULi2ecbfj9aMLFK/oLvFiVGr0nXNv6 LZeYGAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Clang inserts typed_arena_cast where a pointer to a typed record is used,
but only with the +typed-arena target feature, and it defines
__BPF_FEATURE_TYPED_ARENA_CAST only then: a struct with kptr fields lives in
map values of programs that run on kernels without the instruction, so the
insertion has to be opted into. Probe the feature the way cpu v4 is probed,
by asking the compiler for the macro, and pass it to every flavor when the
compiler has it. The typed arena tests are gated on the macro and skip with
a compiler that lacks the feature.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index afa589a27b15..bd1f84f55edc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -15,6 +15,13 @@ ifneq ($(shell $(CLANG) --target=bpf -mcpu=help 2>&1 | grep 'v4'),)
 CLANG_CPUV4 := 1
 endif
 
+# Check whether clang inserts typed arena casts; the feature defines the macro
+# the typed arena tests are gated on, so they skip with a clang without it
+ifneq ($(shell echo | $(CLANG) --target=bpf -Xclang -target-feature -Xclang +typed-arena \
+		-dM -E - 2>/dev/null | grep __BPF_FEATURE_TYPED_ARENA_CAST),)
+CLANG_TYPED_ARENA := -Xclang -target-feature -Xclang +typed-arena
+endif
+
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_progs \
 	test_sockmap \
@@ -510,7 +517,7 @@ BINARY := test_progs
 BPF_CC := $(CLANG)
 BPF_CC_MSG := CLNG-BPF
 BPF_SYS_INCLUDES := $(CLANG_SYS_INCLUDES)
-BPF_CC_FLAGS := -O2 $(BPF_TARGET_ENDIAN) -mcpu=v3
+BPF_CC_FLAGS := -O2 $(BPF_TARGET_ENDIAN) -mcpu=v3 $(CLANG_TYPED_ARENA)
 BPF_DEFINES := -DENABLE_ATOMICS_TESTS
 include Makefile.skel
 
@@ -526,12 +533,12 @@ $(OUTPUT)/test_progs: $(RUNNER_PREREQS) $(BPF_OBJS) $(ALL_SKELS) FORCE
 
 $(OUTPUT)/test_progs-no_alu32: $(RUNNER_PREREQS) FORCE
 	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR=no_alu32 TESTS_DIR=prog_tests \
-		$(CLANG_RUNNER_ARGS) BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v2'
+		$(CLANG_RUNNER_ARGS) BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v2 $(CLANG_TYPED_ARENA)'
 
 ifneq ($(CLANG_CPUV4),)
 $(OUTPUT)/test_progs-cpuv4: $(RUNNER_PREREQS) FORCE
 	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR=cpuv4 TESTS_DIR=prog_tests \
-		$(CLANG_RUNNER_ARGS) BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v4' \
+		$(CLANG_RUNNER_ARGS) BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v4 $(CLANG_TYPED_ARENA)' \
 		BPF_DEFINES=-DENABLE_ATOMICS_TESTS
 endif
 
-- 
2.53.0

