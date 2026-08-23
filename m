Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F3B379EF5
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447375; cv=none; b=cRegnkff6gpIdpyE+1PrspktNEV8iGYLI5bYS/HmV13rxCkf70eO4DahPCJR6lqJuPaEH9IWfA9u3E+XZjSv7trSdo3G5vJFpG/srxk73Nynw9bgxe6ErcNI8haDiyYuq9Iu4LAH/QM3zzFK0zNZ2JWpg6XrHPqWnC68EFf+YZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447375; c=relaxed/simple;
	bh=Ha9kKJXTBZMw1CCowN5kui64oaNtZuSs3DcUuRmb7LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrHFPc08KnTpVyCzv4Itm3YS6t6Io8K+Uy6PUth6wTimUS9cKDa03n0ZEiUFP1Xj0sHnSS3daT3p1SW5YSJ63Dowlvn4K9oVdF0pGNCw2Tk+tZShbSw5gmetLjAMkW/bS8oAI5adFAn6nP9YwjjKLa/V3iCoTjlT8RFAmz5jZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px0b0PQg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px0b0PQg"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1649465a91.0
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 18:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447368; x=1788052168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJESwTNVDWZzlxhNUg/gb15QWCLIr7Z5bZshEHLkMeU=;
        b=Px0b0PQgu4za+jBxCuE2P0pFwQeLPPdZgouVlqRCiBASzvLqZSzEz2+NbLWJMkpB7B
         oMylg2xbmmPByEQLUP96Ye1WJox3brhnb3gTKQCPg4+WLBc6flcP0Rw3HiZn/w2knJjB
         3C5Ikz5cD3wd/j7xCq9IRbU+FK7nZaOazWkrPCDkWl3LUKFAPiFjjVaulM0kQ9H7AixG
         +cI1LO8Rp948TYq1oQvZPVa4gdPKmZ9q8KXU+RBfyOsWf2LQDd3OntJjO/HIdAUpj6Ua
         Uagq9XX4sikhFBQGZv1PNORMw9+v6EAAsPF8h0F1htP8L9/WHy53kpQ3E0Wn70jvCfBA
         s0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447368; x=1788052168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OJESwTNVDWZzlxhNUg/gb15QWCLIr7Z5bZshEHLkMeU=;
        b=a007Ml7k1KjBiG5m/mF+JS8PgNWAqhxdGyKkaZjfBlkWAcsfH5YqQazcSUT4ZZJ5a0
         OL+17Hu/b+b51t9dukztfvYPspo7CVa7QBPUfOPv7AGhCMqHWOYNhK73e1A7zaQvAHKb
         CFlYeBGtft4DcqyatAtPGy2aP7UgkwQOcyDOodyXw2jZ7/dbx7cHjAfN15ZOb+CDaEHL
         0PSFhpIFHi71Wp96NIquJ5AxdqC7hJTdnzeInw/NS7c92Zew03G0y59IEpdFMJaSSzlw
         JlycRMpueJu5eZi7bitFXmdPbo0iu8isGeZAOwO2w0NYHdD6jHMAU74hPcv61/AuhMMN
         MdgQ==
X-Gm-Message-State: AFuF++mtMGs8iLr/JXn8dMGpkqmbIx5JkC4ToFGOt9hVMSOjWxh9wN6u
	kqzCLSiYZhXLhFN3Nac7AU5chR2Iwk0KGxN/wiFC/bBd8r1I8muYRFctydeXsD2U
X-Gm-Gg: AR+sD13Gu8hiaj4Yg2EZj3QD5Nv8aaxmvnupwhNQRIpWjXE0y3QfETEKAHikNg5iIR4
	PRCrYIYIy21gRahtAHy/R9eagSdOrBgHcqZLc8M8R18k3qdwvhAT3sNQqTM0bwldiTeRJ/TtWNm
	XfqxwJVFdcbb8y4j5k4PsF67jm3O5Bkz0hIRyX4xg7JyGr3LdMwFRKIPgzjJZp9smFlUXJMV2Ln
	Eye/E9QFlgf//hlgulg3b57p5AnI/8khMAfGEEFrHqdGcWQ/Z61aKAm2hm7vELsK/rx9tgjDyED
	/bSlDHp9pWCSdp5l++J3ZBnGceO9Fvb8fTnkUgn/Qo3N3SpyPiSQx/SMt6EUmL4EVw5YCwHvc30
	+9vOKh8TJ/ffftmpvnR2INQQ4nqUqmKfLHvN9YWdCE2fIYNMfXmZslzJr/Pl1h8f7HIfoEtbTGy
	G9ulGPdjm7SGJogz9n6h94GAwnSuMvVcnunKROWTHErO3Jvl84VOlEsxWrSKagKuyTs4xAE4Go2
	j34xWSz+Y8NjCC1Nd/C7bxcOP1DoqKWF6xytz7eXIhxxaNHL6oq//k=
X-Received: by 2002:a17:90b:57c3:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-395c4fa443fmr14365837a91.6.1787447367730;
        Sat, 22 Aug 2026 18:09:27 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm4219994a91.13.2026.08.22.18.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 18:09:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 2/9] selftests/bpf: drop stale and no-op lines
Date: Sat, 22 Aug 2026 18:08:53 -0700
Message-ID: <20260823010900.1730708-3-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
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

Three linked-skeleton dependency map entries (xsk_xdp_progs,
xdp_hw_metadata, xdp_features) were dead on arrival: commit
f0a249df1b07 ("selftests/xsk: get rid of built-in XDP program"),
commit 297a3f124155 ("selftests/bpf: Simple program to dump XDP RX
metadata") and commit 4dba3e7852b7 ("selftests/bpf: introduce XDP
compliance test tool") each added one, mimicking the neighboring
entries without adding the skeleton to LINKED_SKELS, the only place
the -deps map is read from; these three skeletons are generated by
the regular pattern rule, which never consults it.

The '-fno-inline' pair (test_l4lb_noinline, test_xdp_noinline)
applied the flag until the rename; both programs have compiled
without it since, and nothing was lost: every function in them
carries a noinline annotation (the single __always_inline helper in
each is a deliberate exception the flag never overrode), and
compiling with -fno-inline restored yields byte-identical objects.

The two header dependencies with remaining value are restored in
working form. flow_dissector_load.h moves to the binary itself, which
is linked straight from its .c by the generic '$(OUTPUT)/%:%.c' rule
- editing the header now rebuilds it. cgroup_getset_retval_hooks.h -
added by commit e7215f574079 ("selftests/bpf: Make sure
bpf_{g,s}et_retval is exposed everywhere") days before the rename
orphaned it - lived in the top directory, outside the progs/*.h
blanket prerequisite of the BPF object rules, so editing it never
rebuilt the BPF object. Move it under progs/, next to its only BPF
consumer, where the blanket prerequisite covers it - the arrangement
several other headers shared between progs/ and prog_tests/ already
use. Its userspace consumer is tracked exactly by the
compiler-generated dependency files and now includes it by its new
path.

'CURDIR := $(abspath .)' redefines make's builtin to the value it
already has, and 'OBJCOPY ?= $(CROSS_COMPILE)objcopy' defines a
variable nothing in the selftests build or the included kselftest
infrastructure ever reads; drop both.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile                  | 11 +----------
 .../selftests/bpf/prog_tests/cgroup_getset_retval.c   |  2 +-
 .../bpf/{ => progs}/cgroup_getset_retval_hooks.h      |  0
 3 files changed, 2 insertions(+), 11 deletions(-)
 rename tools/testing/selftests/bpf/{ => progs}/cgroup_getset_retval_hooks.h (100%)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 118a7c356e26..8d71345c2e86 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -4,9 +4,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 CXX ?= $(CROSS_COMPILE)g++
-OBJCOPY ?= $(CROSS_COMPILE)objcopy
 
-CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
 LIBDIR := $(TOOLSDIR)/lib
 BPFDIR := $(LIBDIR)/bpf
@@ -480,11 +478,7 @@ BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
 
-$(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
-$(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
-
-$(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
-$(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
+$(OUTPUT)/flow_dissector_load: flow_dissector_load.h
 
 # Build BPF object using Clang
 # $1 - input .c file
@@ -546,9 +540,6 @@ linked_maps.skel.h-deps := linked_maps1.bpf.o linked_maps2.bpf.o
 test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o test_subskeleton.bpf.o
 test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o
 test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
-xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
-xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
-xdp_features.skel.h-deps := xdp_features.bpf.o
 tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
 tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
 tracing_multi_intersect.skel.h-deps := tracing_multi_intersect_attach.bpf.o tracing_multi_check.bpf.o
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c b/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
index 2bb5773d6f99..ea342859d6ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
@@ -465,7 +465,7 @@ struct exposed_hook {
 		.expected_err = EXPECTED_ERR, \
 	},
 
-#include "cgroup_getset_retval_hooks.h"
+#include "progs/cgroup_getset_retval_hooks.h"
 
 #undef BPF_RETVAL_HOOK
 };
diff --git a/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.h
similarity index 100%
rename from tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
rename to tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.h
-- 
2.43.0

