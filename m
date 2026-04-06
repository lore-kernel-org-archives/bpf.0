Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1426B388E5D
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491915; cv=none; b=fqkKRHuJA9Tf8ohl+2mwajUKTSR2m2abwslU+CFymknbUr3YPu+w0npMiR4BKCQUUjVLQFbtpsnY1C5v3K8HPcbg8nndeFMldFH2bs4TJaOTgozC0zrxnUeI3AQD+aYJeC1Fep5vfzWroreOR6pZ5PDJpGQUPLIx6llJQLjAYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491915; c=relaxed/simple;
	bh=/h+s7+bE5ZJXA3QpL/3ITmBG4H2GDTMc7y6eKrVeE/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IrdLiDxUwyCUhkgQoLIDYG8zMSdPNtEP1aPl+gki8CrKKNzHQNG0iP+wYF4BbxlDsMt54vEDvGqZnn77sXQ3bcgLR5/gel5B/iuLX5Fc2QTrmik68kOcFII6vWIyjYlFktQtuReEa7X0Qn8iaGe1rAzpIix9L3yhl5kEO6XvV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MPdOqOKD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MPdOqOKD"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488971db0fdso29425605e9.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775491912; x=1776096712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckauTTLJIyO099lw+jHxSzjQ/8v0Ic+OtpUGoPBjYBQ=;
        b=MPdOqOKD6CqD01ClMUrxyEIIEyrHVTJ2AXTHQldYuJysKoRh+R7CAtzYxQuZbRZMW1
         MI7FVAxn4YsGd4NzYCErgXs3Sce+AT/HySTY/ZrC6Jsc1R8bi7akTYSXOFkSgfUb3+Zr
         mL2cqITDVRHv/VppKDTP6C/cEOzRyp4qJUyI6Bzp2WPOm7A6ff2BqDIfcNDnr1KDSpny
         E14xll9n5Yo+GAozKAsYDi2qDpaqcUejaCpxjFStdPc1mrR1dev6Z8Pzs2xlp0KkqRlt
         TEQ3hV/coCh5f2Ca/ZFsYDwu+VgLitJw7wU/r/X/6oGkM30oeT7/3DDKULzerG68XOYt
         IsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491912; x=1776096712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ckauTTLJIyO099lw+jHxSzjQ/8v0Ic+OtpUGoPBjYBQ=;
        b=ddOIzEBrYuvFcISe3l+bKmG52NBDbiWFED0WqQBQjowC/zFTberc4EHuM6S2gevPzY
         mBj9MYthOCFKr77ZR7iA0MTbUmROD362Cux/GywzmZ8bZZabCWz9YF6Ph215Rr1Ay4CH
         zow1wyMMqGVn1FzNiWB14CXWF12u+7KfVnAKFnQcbtFuGmKq8VZRmtsq3wgAGgH6q8dK
         6Oc0wGFr/UgPNy9+ireUN3wG3C//RaYi4h1OZEx37IbNPxeG4dOE1zCX1a4ai8Cb90uO
         NckejR2vIaZAOSHd0ujp03Cd66MCxVsl+LVzh1JJ0GtXlUPGPhZXSVVeAM28FVMlw0IQ
         WRIQ==
X-Gm-Message-State: AOJu0YyoIKqMhpz1kJehz7v6EBFJwCiG9HVPEEpGtZchOLith/AUawqo
	hMnbABuIGtK5iRAvU+I1bMCZpaw7BKy8DlJsPNynrb4mL0MTxqqSandNRC8Xv0mIy7aswDRpc40
	h5iy9
X-Gm-Gg: AeBDieuUbeRVe6ZEvtfKGhRk8sEdmUOayaxGCHmTVIH2Pyf0QKoI4jQg/B3ZDSEf5Kc
	y90f4sjOrzgfGLNHmDBcYfOgtiElgSiUXEWutDxrM2402hEcYakvGHjHY0Hz50Lbku6y37lxTUm
	eQ/vm3ChxekKUF0k+IVBMnuqsIxRWpCFLGMzDiw2HRkMwsFVispNhcmDFGOQ/fkwvJlhC686uYu
	tS0Ihx/qWJzeeV8IY8J92J3MvWgxvgwlbmi3qXUFNGX6I+tRlCjER5KEU79ceyEVux9NvTcxOeo
	onxIkF1Gyom00YHFl9ypIb2yREV1rXv6dx/kl3VVY+Gnu+w87oU7rM2IWhIdKztLp6ew4z1xQgS
	iZz3kF6OVAUz23et4WhWjIWA8Y5rtH/dSHqhJ1G/TZZKArOcTXkY+U4HKPT1zgo4YXqbnwPgncg
	VAmKZ8bCEzNTuXIltPJ8eTUKU=
X-Received: by 2002:a05:600c:4652:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-4889ed3266bmr92859425e9.10.1775491912203;
        Mon, 06 Apr 2026 09:11:52 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fbb1a0d7sm13429067241.13.2026.04.06.09.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:11:51 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 13:11:28 -0300
Subject: [PATCH v3 06/11] selftests/bpf: Tolerate test file compilation
 failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v3-6-587a1114263c@suse.com>
References: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openssh-sha256; t=1775491886; l=2101;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=/h+s7+bE5ZJXA3QpL/3ITmBG4H2GDTMc7y6eKrVeE/s=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCuPGOX/lbVrPTXQKqld5XrQJRD0QeJbC/Qyn3vUJZ2POvIip14fjL0yU+C37pESD8YRqXKpTu5
 Aa02yreGY1QY=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Individual test files may fail to compile when headers or kernel features
required by that test are absent. Currently this aborts the entire build.

Make the per-test compilation non-fatal: remove the output object on
failure and print a SKIP-TEST marker to stderr. Guard the BTFIDS
post-processing step so it is skipped when the object file is absent.
The linker step will later ignore absent objects, allowing the remaining
tests to build and run.

Use plain printf and $(Q) instead of $(call msg,...) in the BTFIDS block:
the msg macro expands to @printf which is a make-recipe construct and is
invalid as a shell command inside an if-then-fi body; $(Q) restores
echo suppression at the recipe level where it is meaningful.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f4d6c5ed7b3a..e8e92ba9d5b4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -684,11 +684,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_TESTS_DIR)/%.c				\
 		      | $(TRUNNER_OUTPUT)/%.test.d
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
+	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F) || \
+		($(RM) $$(@F); printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)
 	$$(if $$(TEST_NEEDS_BTFIDS),						\
-		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
+		$(Q)if [ -f $$@ ]; then						\
+		printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]" "$$(notdir $$@)"; \
 		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
-		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
+		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
+		fi)
 
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\

-- 
2.53.0

