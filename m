Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5605C479875
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862984; cv=none; b=LKwuHZSH4ZwZa+GMgZRpE2Sa5f54TxSVKFV0PRWLLwlehumaOcKHOkxCy8+eqv/kTeW71/pty+arGPQQbOfeEi+2aAGwh4n7lHoJIIyMF7sn5qqRv8WYz8DEFwUSw8qMEr2LUmREjC8VRCWCmDWFqnM+RqTJ0qu4zVcycPxDfK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862984; c=relaxed/simple;
	bh=PwCbf8zRKKberPwP8FsYBZgPHVKou1luOPCnab0WXHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRQjGIIqG2ZgemJWStCKLeEytAd1UhDscggH+K72qSo1hXN+ZIdUeq2nV73eHsFrMhSrhR+2LBePfqJg9uejp+oIAEehgltyDEh+3qxaeW67m2/oMvERh9Ghg3aYu8KO7Zw/VG3WeDA7gUmdw/ttD9O8UyWSMxo7E2/L7tR0Vdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG3bwaIf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG3bwaIf"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848479c9bd5so25117b3a.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862942; x=1786467742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fUXn1wekIuyVa+nVbgfXIDhBpWFPVvV5WOR74mDWq3I=;
        b=dG3bwaIfRnydTg1Ku+a6aRu89PSXzdVE3cOZ+FRRFCedJrH5Qig9Iq/T3B80VdruM1
         wDcSAZ2IsYB3ayHG61crBmO85ypjE1P1k62WwEOy6CzH+jbGCCZRoGSa+DPBlOAGRsIb
         Na3XfwMjZrLqcST8iV3f1Q4dI8MKMK2vOMdPwaE7iuBpcYkTdzc2/ENNozKB0tcUkyVV
         +WNA3sGb/cZrxM8PQWZ7CS7fNtD6YVSC7fQwMfDlUN5x5T9G7XLLVOeSYF/hhA+P7lCx
         vWoLz1xVqFZrLgqyccKehcGmPturWdQeVe5YRBAfTvTEXnSFOCzUiqCKPzLwDOCddpL5
         cHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862942; x=1786467742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fUXn1wekIuyVa+nVbgfXIDhBpWFPVvV5WOR74mDWq3I=;
        b=QK+DKrns9mlT1Qx8hk5z7Clc2eCGuYQvV35bZtwaXvCEm9VNReLyxxM13buvUco7u0
         tE+zWcP9DUxGfCq3zUtnhElMA4dEtK2ljGXrdYEMfV50YYAhZqvsJ+r5TeXdOYNRFK+z
         mFz5Qe1gFRra66Qj/PDxhxmcIB3m4gEcnE6ZYpxGGFNZn67TYLSR12WwrOYK0mEMGlWW
         rv8oELVBEIBAjdiCA/dr6Sq60J6G3n4j/gMFWV7DtyC16lYq3Z2GaA/QKJVaQi4P4/ae
         f8BevmRD6aVljjVj68FQn+dTM+pr7aCSpwgSV3n6cBKVhflOqx5xQM8oX4yKClnvv6lp
         hviA==
X-Gm-Message-State: AOJu0YzpRrg15Y6UYQKSxIyMs9Z4LINK1v6momaV4hF9jUMkp/eDuLcD
	0633jnXxIaOl/hu9GcpPRDdSWQkOS3r7OV9+Zb4wfE6Op/jNzS77vkPjge0bqIFndfc=
X-Gm-Gg: AR+sD13EU0IQdsuYhvkIBpbH+V8cScGvCvIgVsWnfEF9oBYTksC61oqRZyt7hGI4HOu
	sU2ijs572TTCKxfsAfJJkqF2lrEmywlPZqvJPg6Fus84ZKDo7XWghYkouhfYDwWKD95cYUJnbW+
	4b07mxxdX6a+7YtauuyH5KEB3qPBm/8o3s+EiY9BSk/83djxPsiTiVz6hqHSzQ5ZqvU3FrvFN5e
	LBkWYIFeuNdYYopqgOONe6pqox3tj+8wqQm8aNRu3aPOX1SAZbdcD6bYoVvcz9vv4aNB/L+rekn
	3cUpAnx4x9d+H3m4sz6zkUviJEUAH1Gk4m1hq0S7dWAI8MP9hDS9zj7+IadLAiy1ozK0GbUtuF0
	OyhdJgx4CMRIUXyJZYH/1tKikdJRnEYGZ+sqsc6GyT7WTKAs/UfD5F0brTTP+rwswKu7Bml5MEp
	Sm/iocfASmCw8NLUUdBHq3NN5zSV+mMAXLVUxxSfvnFhXMhUPne1aj9SAv7q2i4howpwq2DnjO2
	YDr4WKwaoA=
X-Received: by 2002:a05:6a00:1a90:b0:845:e7ee:eae7 with SMTP id d2e1a72fcca58-84f2e031774mr306237b3a.5.1785862942035;
        Tue, 04 Aug 2026 10:02:22 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e4d3926sm55508b3a.28.2026.08.04.10.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:02:21 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	nickolay.lysenko@gmail.com
Subject: [RFC PATCH bpf-next v5 2/8] selftests/bpf: drop stale and no-op lines
Date: Tue,  4 Aug 2026 10:01:50 -0700
Message-ID: <20260804170156.1709916-3-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four target-specific lines name objects nothing builds. Three went
dead when commit afef88e65554 ("selftests/bpf: Store BPF object files
with .bpf.o extension") renamed the BPF objects; the
flow_dissector_load.o dependency names an intermediate the generic
one-step compile+link rule does not produce.

The '-fno-inline' pair (test_l4lb_noinline, test_xdp_noinline)
applied the flag until the rename; both programs have compiled
without it since, and nothing was lost: every function in them
carries a noinline annotation (the single __always_inline helper in
each is a deliberate exception the flag never overrode), and
compiling with -fno-inline restored yields byte-identical objects.

The two header dependencies with remaining value are redeclared in
working form. flow_dissector_load.h moves to the binary itself, which
is linked straight from its .c by the generic '$(OUTPUT)/%:%.c' rule
- editing the header now rebuilds it. cgroup_getset_retval_hooks.h -
added by commit e7215f574079 ("selftests/bpf: Make sure
bpf_{g,s}et_retval is exposed everywhere") days before the rename
orphaned it - is redeclared against the .bpf.o of every flavor: the
header lives in the top directory, outside the progs/*.h blanket
prerequisite, so editing it never rebuilt the BPF object. (Its
userspace consumer is tracked exactly by the compiler-generated
dependency files.)

'CURDIR := $(abspath .)' redefines make's builtin to the value it
already has; drop it too.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 65c702613..69093fba3 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -6,7 +6,6 @@ include ../../../scripts/Makefile.include
 CXX ?= $(CROSS_COMPILE)g++
 OBJCOPY ?= $(CROSS_COMPILE)objcopy
 
-CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
 LIBDIR := $(TOOLSDIR)/lib
 BPFDIR := $(LIBDIR)/bpf
@@ -480,11 +479,14 @@ BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
 
-$(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
-$(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
+$(OUTPUT)/flow_dissector_load: flow_dissector_load.h
 
-$(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
-$(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
+# progs/cgroup_getset_retval_hooks.c includes this top-directory header,
+# which the progs/*.h prerequisite of the BPF object rules does not
+# cover.
+$(addprefix $(OUTPUT)/,cgroup_getset_retval_hooks.bpf.o \
+	$(addsuffix /cgroup_getset_retval_hooks.bpf.o,$(TEST_INST_SUBDIRS))): \
+	cgroup_getset_retval_hooks.h
 
 # Build BPF object using Clang
 # $1 - input .c file
-- 
2.43.0

