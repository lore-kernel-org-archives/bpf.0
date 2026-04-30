Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B946AF01
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564966; cv=none; b=u+78kPs7N8YVv1qpJppoS6FqJnP+I2AktbOUHemXhgsO9xaO8tRdNRIxXe+lvRnG/uhSmeFlo9l4t3sgEewgPlFOVcYY7oDd4OdLygX1HAWQwmO06gn5JQW0BPozYpDVFjVv76tw5uum8mU1iTChHplMDnJuuG8I6bsuNfaRtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564966; c=relaxed/simple;
	bh=Tn5NUZT+pbq8d9j5af1FMYMU7d0yJV1oSa3Io45PNeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlXnDx5Rq4Niv79q2zrPoa6rBvjvhj/r+t+g7luDCBr7Nlp8w8x0+EqeTZvt23p00IE5QR/yxE61nWK/tuLoUZMLoblQYPruhX7Acb3bghVvBM0glKhmfgbmCgC0JkXaYpVdITJQI15t9wv+Gdqxur3u1Yr3QDXD59AKsv0RmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JsKokeER; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JsKokeER"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so1596836e87.2
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777564962; x=1778169762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZ/nC6oZIV/xRN2y3005qSyz6fuB0fLlWJ3jGKxB/as=;
        b=JsKokeER2VPkBVKwq2c0EFMSKbv9JF3K3xYriVVhx8LwbCPAlGEXr55Y8VmvXPxNMR
         yh2NcKwl63ydHVW8ZziozO94LmAObg4cZDBlGDwGajMAwcZvXbAG9FbMGsbcBm38k/oJ
         Zpuyq7MtwvT3kUNlyGN6AF2QGCrXBXZ1Dkqt1IPaey64Up//Rl/VnsypD0BydAIaow0q
         YJIZVYWbLP3ZnTE9+BDX1WpLUd5IToiDnOw395fnMv4R5p8hA21nc4a9E8MHVOfJRf4o
         Aa4xqtsY060djFMoP+erUeP1zETjFi8osD+1P8IEa3+o7A5Zh4nFlYEpRWWoBPOi1+pe
         /Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564962; x=1778169762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IZ/nC6oZIV/xRN2y3005qSyz6fuB0fLlWJ3jGKxB/as=;
        b=OYaqhrPtU0uaTga3NSa7gejcUDH33Ph3d8QvYcaUF0xZCfmxu36kz6utekIuXyu8Tq
         H4kE4fkEplUknk1jjko/nJoqbpbcjCm74bsygtcAJPf05ZI3C4L5iJu+SEpx5ksF+AzI
         dJTJiPLFw1sdXZSDqRwqX+F/JvECDkWKe+99gQgtiEB745QV4YhJ2ywkI32rAjpjZi21
         bXFIi2UCPmcJPY3BZ8I+d/TNqnN7xFm7RZRcDsU7u6YELnBmQVRfR9gnZBhSceTtTvuX
         zU4yPIeQMXWVPi631jvMl7bfQu6uBhfKe0DcL0XB4g/XUzjWJovHQL1Mb+OZhUvoxKYN
         RZcA==
X-Gm-Message-State: AOJu0YxrEb5+Q3L/JBM2SBuizXdxKLck6j96nAe84ZlFyrCsi5P9+6QW
	EwgZhfEaNRn4LnqFdUSChNXm5UR01W2rYvU05Q/suCnyP1CkAD2JJCdgODS7YROilSA=
X-Gm-Gg: AeBDiesycRRvokwphnaCjZYRn2//Ffw+gLn98zuKUHgI/l2L7wQJxV2nEJRHL1Aa8Qf
	Mlv5Zw0dpEBeShyGXFxP999N50aFsaKDXTVHDiiDyDvob4u7QvyVhxap3kIfYt2XMxAqVoeUAyD
	ZCoU6VYEYbUH5J2l713MEEj5PRo0yIBdqYSS2DiVzCwrrT1K78LzSx3DoLnjRKcFTKR/N7zbKji
	8Nh8em4I/uBnX/9/SltJgje9YmAvEpCjnw0cd64Z4orBjnw2Kp79y+eJJq98ZHYC6gZtqGv808c
	/tV5E6L+4z83zoFV66d8CWoCLFpXlWnLbfgKDrvfLxdQ/ZRh2VHWL/lSuVer64j0B8AdV49sPOd
	6m2EccN0UWZ7U89WjSwmNUMeFdHb2RodZ7FEG4vE5y2pOCYIJSZN0khGyspTo94jK4PoMQRklY5
	SIIJVEAEG5xDO5fC9OJriHz7Fe
X-Received: by 2002:a05:6512:3ba9:b0:5a2:b43d:ac47 with SMTP id 2adb3069b0e04-5a8522b2610mr1204014e87.5.1777564962328;
        Thu, 30 Apr 2026 09:02:42 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de326a583sm9949074c88.14.2026.04.30.09.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 09:02:40 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 13:02:09 -0300
Subject: [PATCH bpf-next v11 08/11] selftests/bpf: Allow test_progs to link
 with a partial object set
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v11-8-e11f7a8c4fdc@suse.com>
References: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
In-Reply-To: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777564926; l=3578;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=Tn5NUZT+pbq8d9j5af1FMYMU7d0yJV1oSa3Io45PNeo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB7rtyLKv2zd0Vo+lD7jhMZadO7ImkINeDH2z0HsbYRtg70xcDwaC/3gA2KGFzTlRajqwomOy1V
 fwc1xnxJEKA4=
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
index df173f9800f7..04634e6e0661 100644
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

