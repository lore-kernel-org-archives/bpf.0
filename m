Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454340B6F5
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553627; cv=none; b=ZFu+G6WUWg75QZ1ytUClhO8g50W+Rbfiwlw8Bde2tcCn4OibjifvsVx89gcKGS3eNec6Az7hVxI927Tx9i+L4Jd6Viu7MJ+x54d5zyrB9pPADhQn5olN4Ty4c2qFacRPxWdizOkfW/ntuSas3MDIe0Yc+M0U03AZC87o76LoYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553627; c=relaxed/simple;
	bh=jhJGxFLXxkLJMjYYafkYMHZLmy3CdijahvtwkglC+SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ls1hcOJENTAWl7RCXnBXCAipACa7AHpWNsoj0wuRARlJeFylSlWFtKaCqp7tCNnacxXGBT6QdFDEg6iMoGVcmoI0g8hABZFjYER1U8vvL3Kp956rwvwji8yoPKYnj+jxzcWmeaf3QtH7KY+aM+SuWnxE5b5J1bdWj2L/u4n+Pjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NJb43LMr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NJb43LMr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso8383085e9.2
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777553624; x=1778158424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT2xKlbvDdzA1YOF+HW6JVqGVpjLZaiDVQi7htx3o/c=;
        b=NJb43LMru5z2jqAW9FreObAKaEppL2DzYUCPILGchwZ045As3IsaAw1RpnTPqlrQBn
         jtA8sAvBRkR60YRKk/Z2/Txjkj+QMTR0u1xqGC95KoxloC+s6epkSrrTNo3UsPFtVUBO
         Qtn4M3SubCxCpkKFH9OGkWwimJsHZMy6y6WTCYSSjUSiLIw4VWD6eU5M/wTSDLhRDEXM
         Tus003Pqu7o+6PQMqCCfM+K9QTx5BI6VG5saRgz9anSjvRErYu4QBXWuUPRyng7Gcykt
         GMFjvjPhALMfKdFGScvpOukc30XB26QiHqz+kAPbSvCTTlIrCiyF5xAbcV5P07W6d4yv
         U+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777553624; x=1778158424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FT2xKlbvDdzA1YOF+HW6JVqGVpjLZaiDVQi7htx3o/c=;
        b=Acbco5/737Z2nPTVVJtSuLOhjMdQhMMtu28rtD7KDuP9F1ihum1dN7yiMwuilZ9HBU
         KzOlQMryWmhV26UoV6IYQdSmTl39T9MC+Hi5K9iPJn8ZhVMUtQ6qRGgLJ4uuFOvcUksS
         /niojis+r/4SM0FEHipcMpdU0oeHRJPUj17HAfikSdyN8RuxfLhgt7o42h4W/IxGcKu7
         5stlD/08JbWkFc5d4yww5rBh2VFVkntsnMGmag9pWLJkMx4EtE3nR8rNjFMqozgdnXdu
         PzRc551MZAp7QbErYrIYWRPlA/dpwnqt1beFVnY+/dF4z+FoBhBCfrQrqmQZSDwLlqB8
         TiTg==
X-Gm-Message-State: AOJu0YySAAY4Vqv5j6dewXuUYWOMFL7nPvwXPVGgwYnJx8/scMSq4li+
	o5z8PQgzUkRftfukyVGSkiTF8vSk/CN/d2B3vyQ73N5XlQLlthgitCO5VmO4rvCDetM=
X-Gm-Gg: AeBDieuDjCiejFCzj13rF6i8X4ooGkbT+zh/whahWwMrZ6X5VjNR8a036oArI1op8Am
	NP52TtIEfBWWJtJHygKco5hHEIEzTTDmzGnxh7dCS5/Q6YEE6mFgFV2p6T3dBa8aUt2ev13dGqW
	zJ7rE2bBr9Rq3FmVi4K45pQodZxvy1QeAVJDYRFR0pPlBzsW5XUp1vaXzGLGY75Yc1EHtob1BxW
	/LWVQD+S1uwo0azQEjqA5/Oi3P0+WpUpsz9gzozfQ00bIPyXhait0quyqB+KukU3OpJ5AF6cMMr
	jgi33Fi16xPVfd2+R+75aMJV0NsuERl2k+phXcprdgfbUvtCHbpupU1dcUuMlNHpy26TGQl5p/X
	FKenlwa2s7deOdastUGg3jGoROuZmfoTu7KPmRYxLitowRHaCiSQlmAe9OqajbY+b/c3gt3K3ti
	ct/W2kB/VfMm9ga13aSqy8WhXQ
X-Received: by 2002:a05:600c:a409:b0:489:1fa5:997f with SMTP id 5b1f17b1804b1-48a83d6c37cmr37470475e9.9.1777553623585;
        Thu, 30 Apr 2026 05:53:43 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf8e268sm6512299eec.12.2026.04.30.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:53:42 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 09:53:18 -0300
Subject: [PATCH bpf-next v10 06/11] selftests/bpf: Tolerate test file
 compilation failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v10-6-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-0-cd302a31af16@suse.com>
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-0-cd302a31af16@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777553600; l=3956;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=jhJGxFLXxkLJMjYYafkYMHZLmy3CdijahvtwkglC+SU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPyh1r4yQgGiTl7p10u76G1+dBl73UkoQ6YCfM7dVMhLmRrPWXvgE4uU12xenX0boJ/djBmN+wv
 lxiN8QRBfcwM=
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
is invalid inside a shell if-then-fi body) and gate the printf on $(V)
so verbose mode does not double-print the line that the recipe shell
already echoes.

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
index 608e6dff0392..9becc077eb23 100644
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
+		$(if $(V),true,printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]" "$$(notdir $$@)"); \
 		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
-		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
+		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
+		fi)
 
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\

-- 
2.54.0

