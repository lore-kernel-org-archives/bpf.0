Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9A376475
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473267; cv=none; b=OKj3NyzjROCOyrVuXlDOIcGAtjHcxc8y3H+b94+EBNuAWYv+68ssqNIctHMGZ4Bw29AHLUI+1dfw7p+IiEmy0F9Dov7C/rL6aa7WmmE2/4JPwL3eKNkogmNN3wz1fMXfvf+nrXcIYr3potTcbLJCxSNsu5GxpBDFsV1oy9RWHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473267; c=relaxed/simple;
	bh=jhJGxFLXxkLJMjYYafkYMHZLmy3CdijahvtwkglC+SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQH3ePtp9bk5WlUNMCrccvNPA8dGuEtqcif1twLGgHN85HEQTXJ1H4jZpDkRbW0D7rK/P3UYSGw8qIMPLWcxcRYDLeoHajSDPvWmUcvJVxjz8ro5qRpqcLriRAQalzxxAtDYPZOgH7G7lifv9M/E32Uoi0J04vFUg5djlQICzaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M/aMJ75a; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M/aMJ75a"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso1629251666b.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777473264; x=1778078064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT2xKlbvDdzA1YOF+HW6JVqGVpjLZaiDVQi7htx3o/c=;
        b=M/aMJ75aBDodtmzPRvyWzBDRLEix+SFRKmWVl2IuThAvoXoEyuL0DLRmFHKCefe6Kf
         1on0CaVZY0XUB7N8KQSCcDhjUxxwQlJfAhSGI9cqrGJN3Mvd/RVzKQZMjs+GaCybLnW+
         QDKaqk+Hv6Yr1Wqo096LkuQ/3reu1EpmasHeVUJAhAtZyBi+2md5h6dQ67pePc/xSFrG
         /IPiZKxQHf9sP5IeTNi8h2g1MaklnM9A8Z5c59QW9oZQgknwyvaZTeVC6TRfKCtBMPd9
         8JY8QIYtoTsEFnqHPI32AkFX2Qe3wVGz8xb9vVuhdSGFpEomnoLtR9bmQpO5gPwHUVvl
         Tjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473264; x=1778078064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FT2xKlbvDdzA1YOF+HW6JVqGVpjLZaiDVQi7htx3o/c=;
        b=iHOYmLCf+1wBIwMiKlsMP9rqsA7v3Ze+qvEjCG2g24WgTn7v3nO0RwbK/rCYjZyrXl
         FO0yChXhXThy+fUTdq8wLsOF0lhkWIOjrpxSn5NdwQZwLS2NNki9tjmHRXrbWge+lYUe
         8cB+f0G/of2cfY39S9vuvW3lNnfxNPIglqn9gep0raLYGiXNcvJDJnEatR+JA+I87iro
         hykfX5upLub7oQ6UTzqO54wCV7prPs4lITHGc1x+UL1be1c7oOOiB5GsitUQ3PsbVu0J
         uXWtDQ8OT1RcdQogAShPkj8OEgk3C2NC8dKDmoeNRz+TEg1InVco8ENoTryIkaeMZ25+
         3eZg==
X-Gm-Message-State: AOJu0YyhIuCnExAhS05v1922K50lptWLcxaluHCSfh31AzNhtvskphiO
	Hmm1DEI34yE2rHLnhY+LtY4XqwinejieKF6oErme/ssakiZz961hfNX1qgyZYoSWpfI=
X-Gm-Gg: AeBDiev7aqYQsf5KVR4Yt9Qz3nQQhRe3hQGm9hMkRjN2SfguB0FKESaTVxgQXwKAR6R
	YwbrBoQDhTTba762naosR4/YRhGHv5BMiVHDMWluyZxbWsYZBJEqk1CxcTBML+8tAlndlI0sO+H
	9pHaCorwAAFleCHF8OFsibogcWX/JN41Gh14s3VViY987iHtJcXYS1n8fiRNI7N3Msq5b2aKePW
	rdWcVRtGkSsigAdo+dlm0j7wDLt74E7orxERCItX94EbbWT3GNLmLpY0iLwt4jjbiuF13J1ir4G
	u39xuYN0e5GXhaR17RT2KryUMYIiW7DWunspU9P/sXuoitzqXgDOKRZlVn/b8YoXZ4149DIef6o
	tgq8s5dMlz5FhIMT3Yw2ystdQSI+fE50BPvihD3IvFJZWiDc5S6U/9p27XbECC/NSD7UrdXWjYE
	1JHV+1kYccFkcoV2JD4/zZHSOM
X-Received: by 2002:a17:907:e152:b0:bb6:4c2f:92d1 with SMTP id a640c23a62f3a-bb93f138aebmr173310366b.40.1777473263728;
        Wed, 29 Apr 2026 07:34:23 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-629843365e9sm1145522137.7.2026.04.29.07.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:34:22 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 29 Apr 2026 11:33:48 -0300
Subject: [PATCH bpf-next v9 06/11] selftests/bpf: Tolerate test file
 compilation failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-selftests-bpf_misconfig-v9-6-c311f06b4791@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777473237; l=3956;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=jhJGxFLXxkLJMjYYafkYMHZLmy3CdijahvtwkglC+SU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJxoiWVdJnlM4a8nqBXmAhZlgBt/AZtIgb0JaFVSwQNmUj+tSqtoWMa7bWoR5Hcl0OsAIERRbI5
 hqTAjbjOH5gU=
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

