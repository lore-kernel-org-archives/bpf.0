Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6938759C
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491901; cv=none; b=ifY5d1vjXWdaVSSk0dGDKA8i9ZnZxbrk7jBrovPc5Ca6ojd2o9JA2T5LC01yVuI6oE5iqDz+MPtoj8ZuRGJvU7fmp5rRCZGc9iqXqzQsLnNz/JepBGmxY2PVAiAyfTNHIKjpsqgIBRnXy5UutgbxACGZNVRtIQ7aIrBUuRmsBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491901; c=relaxed/simple;
	bh=UNpkyM9z2Uk+FmGgvL1GAOWInz7HiCFNDnRCqP3sEoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZgTnqnBk7c+PuTxoQNkdR0CgA/5RqFtj7CL65iY2TFcnNi/Oc8DYFt4pqUOoirk6R6AhVDae6Lv24jinSzhQf3EUHlaRSD3FRPIBHLb9Cdhh6fGHAMW0/ywmFEz698xlEBtbUXKq4ORBBk/NVumke5zIhqvUpiI/LU8SeaenQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T75Z370z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T75Z370z"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so54862595e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775491898; x=1776096698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++yFqZU4YJL2pDC+uPFxgCL5MIK1kEP1TNHUNgeqal4=;
        b=T75Z370zx5mWPSVsvQBGM7IWmu77Xg0aFRmwhfCbpW85CH7GeQBW1TfTyByWIyi2pt
         8DB1qeITtx32j97yBmXrYC1J4wDqwXAnnfPcGIxOJ4+qiVgEJf+z9vC3nV46UKIkrqnK
         UeoOh5zkySitFhXrJ4IAjhvzTncy077oBOEjFYGPCbFoIHSFi8RJumeyEV/sjWR5nc7G
         4FBVFGBrdLPKBvkMnB4nBS8nRcgoHSx5CsJRaRxsMUvFd1vckt95cYV0PehQ0Gs9ySYE
         JCLUWcrMi/crAGuCLlmhqEwRfX7aVALNr7d33MS7Yl9MfLtHNcm4Ugq5vDkvPMcd+kYs
         gZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491898; x=1776096698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=++yFqZU4YJL2pDC+uPFxgCL5MIK1kEP1TNHUNgeqal4=;
        b=mmtnFhlrIvwkiEw5NrG0Cz6D7y4i64sFOwq7APb+mHixOZA2GjMT+wAfKYMdhPhSs/
         QlBy+G5KVy9wooo0RFFVPFRnt5ftxkJyAZWbWcKrb2+68zpF/PGLhth7twLXJQmjJVec
         wYfLFwRiGyOeLUwjKRrKPR9z+OR9dx3u5s1JIAxvE18i6TQGIbYKMcGIgtwcb4/vMcQi
         SA+CpXvwZumRQUy8WrCb8b4TUxb0nEgbl5gzeSGALeRRmYfwxqF18ZASbVos8/1Aug8J
         FiWicCJSnZGoQ6qURsrZTmrOJtn82NbRbH8QZgJ6MSOP3cpX63r7YV9B6CYZCtDPeq6x
         21HQ==
X-Gm-Message-State: AOJu0YxpwZsEVKISuiisSzayMrixFpoWBEnyruBzC57Hzff73KLXh6iv
	J1RMzzfxHBTVYfl/AoM9BEjh3lX+AGq3UBIrNXfUjoCnoSrqAdXi2qctt4xq8d6RBiyIBhKTYRi
	IsLIo
X-Gm-Gg: AeBDieuyrvpT9GCIMVL+Plzp/wnZbOVlJkUKMUHv/ukseur5afPjnWlYd7U+85/LP/j
	iMEXR8YzKxTub3ZgLF5IEiCo49CWDbgfpmV/t+BA1kbG6eZlBavP466L1hF5mLA1LrXST6/bvpX
	0Ibmqpu7UdV7lVar/Luyha8tWyT7Mt8ifxNgoi4fnsvTRz3il7PyU2pUmWpaTEgYSClDO0q805j
	Fsm6yQI4PX27A+C1z7H2QWaHPzbHp76zZ7xGAGaXO6iXXU0BjRhmXzKvwLnna1bf8bQjiCjOtqz
	Gcvyhbyr3LNxzkHoB6gfysye+esbOFFC/47JOcyDSNx9h3OvupxI+W4y30edgJFLNRIbhCwG/vs
	Jotn414swnZF9kR0Vb7RVmCvVhV8dDe3FNSPI7sBqSO81mm4iA2iDnoJMFKe6WZygQ4y6Xg64GN
	u0FxU6yAyRIcK8
X-Received: by 2002:a05:600c:4593:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-488997de1c6mr212429245e9.25.1775491898536;
        Mon, 06 Apr 2026 09:11:38 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb84c289sm13683068241.4.2026.04.06.09.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:11:36 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 13:11:24 -0300
Subject: [PATCH v3 02/11] selftests/bpf: Route test_kmods through the
 kselftest module flow
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v3-2-587a1114263c@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775491886; l=2698;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=UNpkyM9z2Uk+FmGgvL1GAOWInz7HiCFNDnRCqP3sEoI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKtb85zZMJ0Of8jLIIs2/ZtZmDnk1/VJC0cgPUaU0InvJi68iydff5f4QHUlKyEl3s7u80ccp47
 wmLGfUHqI0gc=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Now that test_kmods/Makefile correctly handles O=, KBUILD_OUTPUT, and
missing kernel directories, wire it into lib.mk's module build
infrastructure via TEST_GEN_MODS_DIR.

Replace the bespoke pattern rule with a gen_mods_dir target that adds
VMLINUX_BTF and RESOLVE_BTFIDS as prerequisites, letting lib.mk drive
the actual build and clean lifecycle. Make TEST_KMOD_TARGETS order-only
dependents of gen_mods_dir and make the .ko copy step resilient so
that a missing module results in a SKIP rather than an error.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f75c4f52c028..715f282193c8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -123,6 +123,7 @@ TEST_PROGS_EXTENDED := \
 TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
 	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
 TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
+TEST_GEN_MODS_DIR := test_kmods
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = \
@@ -152,7 +153,6 @@ override define CLEAN
 	$(Q)$(RM) -r $(TEST_GEN_FILES)
 	$(Q)$(RM) -r $(TEST_KMODS)
 	$(Q)$(RM) -r $(EXTRA_CLEAN)
-	$(Q)$(MAKE) -C test_kmods clean
 	$(Q)$(MAKE) docs-clean
 endef
 
@@ -277,19 +277,15 @@ $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 		  $< -o $@ \
 		  $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
-# This should really be a grouped target, but make versions before 4.3 don't
-# support that for regular rules. However, pattern matching rules are implicitly
-# treated as grouped even with older versions of make, so as a workaround, the
-# subst() turns the rule into a pattern matching rule
-$(addprefix test_kmods/,$(subst .ko,%ko,$(TEST_KMODS))): $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard test_kmods/Makefile test_kmods/*.[ch])
-	$(Q)$(RM) test_kmods/*.ko test_kmods/*.mod.o # force re-compilation
-	$(Q)$(MAKE) $(submake_extras) -C test_kmods	\
-		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)	\
-		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
-
-$(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST_KMODS))
+gen_mods_dir: $(VMLINUX_BTF) $(RESOLVE_BTFIDS)
+
+$(TEST_KMOD_TARGETS): | gen_mods_dir
 	$(call msg,MOD,,$@)
-	$(Q)cp test_kmods/$(@F) $@
+	$(Q)if [ -f test_kmods/$(@F) ]; then \
+		cp test_kmods/$(@F) $@; \
+	else \
+		printf '  %-8s %s\n' SKIP $(@F) 1>&2; \
+	fi
 
 
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool

-- 
2.53.0

