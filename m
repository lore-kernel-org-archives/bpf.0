Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9755E3750A9
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473276; cv=none; b=cEBzpcQa8w2Vu/LRrWZTVciLcl5KZEskiqMDx5PrKmeKcljC5x0ZG179Ci1F36S2J92pwIvxRid/a9Te2Gma2Jy/oHLVIPZChATqRSo2SZis6FIVwtEyOy/TTwT54QZiJTiCxqdKpwaBrMCL+/qm51xBZHQ7Q1tq+3vjNz8nh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473276; c=relaxed/simple;
	bh=I2jxLztduWlfcb809/jc6vkR7pIiCKbFQIGItdln2/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EV/uLbvGU8ea70TPUIDXFegobpj89C3rSkgA2e27RXkvQXe9nhXjN7SoQaTQBaEUx6r05CLKhb/QoZXZfQjJFX65RUccIiE65nZco08zPOa2/kcE8G5b9ck6Dy6mouN6uFRZFXDRswe3UZy0x26JtTKb7IW536oJTe+EOwlXjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ha17tGVy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ha17tGVy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so153485215e9.2
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777473273; x=1778078073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+XbIgjuLQuX1ZjiX/bxTtSVSE3u4tQE56sxmhIL67k=;
        b=Ha17tGVyXmvGhF6J/cUjAXgxCO7NUel6nWlneZ5ULVJg2s8a6TjQKwLoYzcynia09E
         fNsm4VIJkbX+OtrfMMUTguNlWOgGM30u12EZvll8SYgM3a73TldxYyXH1QUsFfMGBQBW
         Ij78QY0XUKIUiWXPZFBys/bn5P9ZDjIehKkVtfBF7Vd5oGlwBfSGkJ2k1Hn+4F5S/AHx
         Spt/4eK2sj4+is0swZfrP2HpAS/UDOQryt7VlmIiZal3+pXiaQM7g5zjxPQ/dWTycWgI
         iAUR2xClhK+hGCgkv8W8QnsO7OxnFhEQ6yeBAqOivVhO/5ISrmTmLonueOTe4JicJgZp
         +b+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473273; x=1778078073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q+XbIgjuLQuX1ZjiX/bxTtSVSE3u4tQE56sxmhIL67k=;
        b=qFNxcubF4sfTssOkidXMj9Mi2D1uJooJzwXCiQ8FUv9A1crDMiy2uOAdvOFntERZC9
         JwcN4xGmgCEDAQM9NvGYXTFGN2/mUWVzgmRZQcnGVsf32jO52m7KYs9FZqKrB0l62moH
         +nLnJ5HsObdRMVrIVF67rOjRFyZGTJAebB0vE7Eu/3W2+zMpZ2xp4ISyXmfUKWCGpl2K
         AeRKMAvvqY8Fdb/4hY4LFC2PWWAAnSXooynyylumMNV5MuHCxBo5E+6THpkqXXGSm9xB
         qK+mTfP+2+2mjeEqagJn88BSAmSIFJdyO4tPDL6+I1huJZLJTGg7TeNltjUDJKXLYozy
         sYkg==
X-Gm-Message-State: AOJu0YyW+3e4GYL3YJJbdXyKfrv+8X3YeZH3bQMCRVacUXuLH8tPH4Pq
	/gtdys0OF4wZn0Qzq6gVNjjzNrUNwJbzBsuWs9+9BcngaRQV+zxKk6ywVaNTyRZqoucsqIM2UyS
	WlJkFSuU=
X-Gm-Gg: AeBDieutYSD0Wo9jLkiQeMN+sd+NgaGDcb5mD7YfWS/ATy7r5SHxO6a5Iz3epbnT9FM
	Du2TjRWsgd/qH0/la9ZeXZFjThI/CPkbFl5+Evpol/WoD+7McIl1+/cEBRKi7Vl5gjSDqxrEyJc
	oQAznMF3aQPPp6h2HRpUXOOD6LYpMxkjcLmvrfhzY0s7A5NaCTXklaCyZYf4TBItso4hCpXYfyY
	O/kHn+wLdvq23CSp9HMFbu8nSLq08jPqNQa3yxaHnjRbzq63l5hgrwgldZoQiUTkvRhMkWloQiG
	QH3sLdgzzDYccpD8/bQBwDPY0hBDws2yFufHiyhWlrztg7BuaZW7O0KKJbuXauFUgqp2Y2JtQQd
	GT4SSI99tUWRqwKfF+bOpBGiGs1CaKJMXOGUKaVOThenub+FIZUsijxp6YR4j9M5bVp1QPrQzjq
	dQpXsSmJnEOnulNetaRZAI3Uws
X-Received: by 2002:a05:600c:3b0f:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-48a77b0a507mr122496495e9.15.1777473273043;
        Wed, 29 Apr 2026 07:34:33 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6d87e40sm1209329e0c.12.2026.04.29.07.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:34:31 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 29 Apr 2026 11:33:50 -0300
Subject: [PATCH bpf-next v9 08/11] selftests/bpf: Allow test_progs to link
 with a partial object set
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-selftests-bpf_misconfig-v9-8-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1777473237; l=3578;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=I2jxLztduWlfcb809/jc6vkR7pIiCKbFQIGItdln2/s=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIzdYHk5cwif+RQ3mArgKXEe1OmNUYvqf/YJSAHl/MfszMfMQiXYeQnyGabY4+HfuNyh6OOx+ma
 C3x0RZ2Z08wM=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When individual test files are skipped due to compilation failures, their
.test.o files are absent. The linker step currently lists all expected
.test.o files as explicit prerequisites, so make considers any missing one
an error.

In permissive mode, declare the test objects that already exist on disk
(via parse-time $(wildcard ...)) as normal prerequisites of the binary so
that modifications to a test source still trigger a relink, and keep the
full TRUNNER_TEST_OBJS list as order-only prerequisites so that initial
fresh builds still produce them and missing objects do not abort the link.
The recipe filter is split per mode: in permissive mode it combines a
recipe-time $(wildcard ...) (which catches objects freshly produced via
the order-only path on a fresh build) with $(filter-out
$(TRUNNER_TEST_OBJS),$^) (which keeps the non-test inputs from $^ but
drops the parse-time wildcard duplicates). This avoids passing the same
.test.o twice to the linker while still presenting test objects before
libbpf.a so that GNU ld, which scans static archives left-to-right, pulls
in archive members referenced exclusively by test objects (e.g.
ring_buffer__new from ringbuf.c). In default (strict) mode the recipe
remains the simple $(filter %.a %.o,$^) since TRUNNER_TEST_OBJS is part
of $^ exactly once.

Gate the partial-link behavior on $(if $(filter test_progs%,$1),...) so
it only applies to test_progs and its flavors. test_maps and similar
runners using strong cross-object references would link-fail with a
partial set and intentionally retain strict link semantics.

Note: adding a brand-new test_*.c file in permissive mode requires
removing the binary (or a clean rebuild) before the new test is linked
in, because the parse-time $(wildcard ...) is evaluated when the Makefile
is read and will not yet see the new .test.o. This is acceptable since
permissive mode targets tolerant CI builds rather than incremental
development.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9becc077eb23..a64e822dc540 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -773,14 +773,15 @@ endif
 # some X.test.o files have runtime dependencies on Y.bpf.o files
 $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 
-$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
+$(OUTPUT)/$(TRUNNER_BINARY): $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$$(wildcard $(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS))	\
 			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
 			     $(TRUNNER_LIB_OBJS)			\
 			     $(TRUNNER_BPFTOOL)				\
 			     $(OUTPUT)/veristat				\
-			     | $(TRUNNER_BINARY)-extras
+			     | $(TRUNNER_BINARY)-extras			\
+			     $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$(TRUNNER_TEST_OBJS)))
 	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$$(filter %.a %.o,$$(wildcard $(TRUNNER_TEST_OBJS)) $$(filter-out $(TRUNNER_TEST_OBJS),$$^)),$$(filter %.a %.o,$$^)),$$(filter %.a %.o,$$^)) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
 		   $(OUTPUT)/$(if $2,$2/)bpftool
 

-- 
2.54.0

