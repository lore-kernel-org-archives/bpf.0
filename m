Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE433469FA
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564957; cv=none; b=VJMZpWP81wS8XMHW7zdbXeO13zo46WJ3JukWJKZCl52V1BeD5oYYWqhFRyJ3qGKaxg8+zLDO1MJLosA95qfEXluEcxf8aqPdJ5Q18NP0JGBRG4ERRWwlVg+22EUD1sG6TnoGWhL0pzPevvjx7Tczs8UdyR6vup5vIPtZpEAJ5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564957; c=relaxed/simple;
	bh=sCL3BBNlvDSegGw1RYfwGLaOwuamABwTCX8jZIraTaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y4wnfdKo0aNnvLmfNmdFjNI6vYK0SqA/cA+p1YBwQ3avt+2qwerIK5+5gpLsKlLCBDJFmd5fYN8bgS3njszU/QJVSEsXO6slA1myP3ur1+ahHdIGeNSI6agxAdHA74crltPg51yW0DfiYUzvWAXfKiXJAPE16YeLh9KVy6Tmn0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IvqtWk5A; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IvqtWk5A"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a2c500750dso1938023e87.1
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777564954; x=1778169754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixuEYraq8V8r2ObYxyMzyXo1gSQVYrBbLSiWlZ9LJqs=;
        b=IvqtWk5A/GQbMWUXMvPhA3PFM5o+B1+DxvvaH3zdo3odQovpsIL+VvTfhnrPfcAK0h
         fTekRuxqGxQkb34gsM9Hf1F7Wp6SAlELhEajOyxvtsZ7AFDF9gmgA6vOkXwwyBGmycfd
         tmAbk4MWXwz2I3A5XCSria1y552fQ1weQlcwWIbpuGZsNtwoNKHnxRoUQr4b56v3mDj3
         CuhEaUU/q5qCO5NDO3xBbKxTMFGXyN/Qui94wx3k4M/H9Kq8yRophXDnTFcuOAWFtZ/C
         Hu05FUrH4UG+jyg2EWMRV6QmwqYu+oO2JYu8oTratYzNiJ6XPj5FP/TsWShsCiAng8IJ
         gyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564954; x=1778169754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ixuEYraq8V8r2ObYxyMzyXo1gSQVYrBbLSiWlZ9LJqs=;
        b=PUNx3I+hX1wdW9HnT7MZWRu7I80T28E5C5k9Ku2WAYAN6WZG2C645EgOBdW+saHaNp
         gf6yoHCvidAWk25WoFjsHihTt9Pe/sIkTJOyGODYlWHpszy8YGOgbVDnRreDA7bOfBsb
         /ReQKOKdDQf3dQwxCsl6fRggP/mTFi9d9gl+2/jtvLFMjasZ56hPijToBn4l44zym1Bg
         ids0vIKiwRY8bw0fall4BnaX0nc6ReA3efgyuE7uSaAuy4jNpj33vMSdqYOlR5f2HOi+
         Wa47W2xo7R5uQ3eLvJ7wJMjAqX2SBcS7XwdaR75P/WvTyhREt+UC4EfmsN0vGHQML4pK
         iAOw==
X-Gm-Message-State: AOJu0YzRAgwowRgpUZ/AyzoMstw060s6BTfhwtOhH6uEnS/xzpzT4OUN
	ZPNjNQtBnH1C0WR7c9AzDoM2MSLVLE1r9LQ/KZArJL2lmokr5K6Wx8rZDqMe7II1O0M=
X-Gm-Gg: AeBDievw7Lc7N7V68O5kEws8MxUMp7BluJepm+swzOgxT2OrsSv3HIfw/eG4vVBwqlh
	60vIb8YegEgBKD4LAoRmf5haXiS4ktLF/Hs3tOcOg4hhGNO7pY/h+tucsISPQ43MBAjO2Miyg+T
	/N52KBnQSkC/Vl+Stoq4Aqsh3c81BRK3WDoXjc7H+I7XLgtPo+QwuoQd/kYKmwfnyCPSpHnt6zW
	+DYWYjJFyDv6h1BYqkm14PNJVCsj8+E0lvNOMUtS50GcPe8azfsMwOPtDH4ltvirSlUftevuz/5
	4dM1llSbVrBiXoQnomR4wZGSXG48xVkzdIt2zgQsYa6DNdbVd++3DYNNiihQ1SMc9vKMlQKNHFE
	Bajtag8JJGmYNy/wR3ehy2/sCSMqf+xJi49BvYcT8f96LYAJMoUk9U9LALw//OHYR6Kw0nOVp76
	upqWoZoT3Hfc7l84q7zHtATWRU
X-Received: by 2002:a05:6512:10d3:b0:5a2:b487:b945 with SMTP id 2adb3069b0e04-5a8522c316bmr1399814e87.18.1777564954314;
        Thu, 30 Apr 2026 09:02:34 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd54b018adsm10643367b3.8.2026.04.30.09.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 09:02:33 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 13:02:07 -0300
Subject: [PATCH bpf-next v11 06/11] selftests/bpf: Tolerate test file
 compilation failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v11-6-e11f7a8c4fdc@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777564926; l=4111;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=sCL3BBNlvDSegGw1RYfwGLaOwuamABwTCX8jZIraTaM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBLv9nDN2lTqYKeZiw2HLgL+bWLZC9uuMjxtiu1Qcs08vuV2yeTKDzwBfamXV6aKfs4sGZVihi9
 QGi26znR71QE=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Individual test files may fail to compile when headers or kernel features
required by that test are absent. Currently this aborts the entire build.

Make the per-test compilation non-fatal: remove the output object on
failure and print a SKIP-TEST marker to stderr. Guard the BTFIDS
post-processing step so it is skipped when the object file is absent. The
linker step will later ignore absent objects, allowing the remaining tests
to build and run.

Group cd and CC in a sub-shell so a cd failure cannot leak into the
error-handling branch and operate in the original working directory; use
$@ (absolute path) for $(RM) so it cannot match an unrelated file there.

Replace the $(call msg,...) in the BTFIDS block with a plain printf
(the msg macro expands to @printf, which is a make-recipe construct and
is invalid inside a shell if-then-fi body) and gate the printf on
$(filter 1,$(V)) so verbose mode (V=1) does not double-print the line
that the recipe shell already echoes; non-verbose modes (V unset, V=0,
V=2, ...) still print the BTFIDS marker, matching the convention of the
shared msg macro.

Restrict tolerance to test_progs and its flavors via an inlined
$(if $(filter test_progs%,$1),$(if $(PERMISSIVE),...)) check: runners
with strong cross-object references (e.g. test_maps) would link-fail
with a partial object set, so they keep strict semantics even when
BPF_STRICT_BUILD=0. The check is inlined rather than stored in a helper
variable so $1 is substituted at $(call) time and the per-runner result
is baked into each recipe.

Note on bisectability: this change is gated entirely behind PERMISSIVE
for test_progs%, so default builds (BPF_STRICT_BUILD!=0) compile and
run identically at every commit in the series. Bisecting in PERMISSIVE
mode at this commit still requires the next two patches ("selftests/bpf:
Skip tests whose objects were not built" and "selftests/bpf: Allow
test_progs to link with a partial object set") to avoid the linker
rejecting missing objects and the runtime aborting on NULL function
pointers.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 608e6dff0392..df173f9800f7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -588,6 +588,12 @@ endef
 # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER_RULES
 
+# Permissive build behaviour (skip-on-failure compile, partial-link) only
+# applies to test_progs and its flavors; runners that use strong cross-object
+# references (e.g. test_maps) keep strict semantics even when permissive.
+# The check is inlined per-runner so $1 is substituted at $(call) time and
+# the result is baked into each rule's recipe.
+
 ifeq ($($(TRUNNER_OUTPUT)-dir),)
 $(TRUNNER_OUTPUT)-dir := y
 $(TRUNNER_OUTPUT):
@@ -717,11 +723,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_TESTS_DIR)/%.c				\
 		      | $(TRUNNER_OUTPUT)/%.test.d
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
+	$(Q)(cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)) $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),|| \
+		($(RM) $$@; printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)))
 	$$(if $$(TEST_NEEDS_BTFIDS),						\
-		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
+		$(Q)if [ -f $$@ ]; then						\
+		$(if $(filter 1,$(V)),true,printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]" "$$(notdir $$@)"); \
 		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
-		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
+		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
+		fi)
 
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\

-- 
2.54.0

