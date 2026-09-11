Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201862D5C7A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136194; cv=none; b=OY0pcTWLI0IcrafwJWA0kMmtfd/8SvHpISSdNBu1tziKewjskIZXoWDlpO139zuR33pVxf2lHmxUSxFvP7YTgD2/JldRfMxEZHNGXqJr+6vjwD3XFgNyITrvaWc1LK+PpliaaWm07LqqppsLPiYg3QU5U1d6VEc/8SjGwCTqJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136194; c=relaxed/simple;
	bh=0mZHJkoBKZVg6KtObC8eJA7MPHUd6muWxiLT/UsPSFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NukqTl7j+n8+GImowybSI3Kb5D8dZGYADvltpl5iSc5pb0wMkTJ9qR0PClSaa10BMxUM1yO8APmErKw9BUoCWhlOHO+5ukxCOYmYvaxUMSyUsJX1ZPrc4g3wqh3GAt3d87adbWyarHaFo1DrFV+5wtEw+G+6kROw9KHJHGXbyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5hQTjQj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5hQTjQj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d944747d41so11555815ad.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789136192; x=1789740992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3UtoV/pw3leuZYVI4/SY6nx/n06s07Bocud6331VQDU=;
        b=j5hQTjQjzLGhp506AT+QmAqOe9AApqT8JtQihNYUeFqtdcJuvZGoyNlG1diGo7mKOY
         O257Qxy4zmD562aP31CUAOS9PlP+jtIRKAYfKT5seE5tvc60OxDbSg1RgCDSENHh2Mje
         dGbd3K3K6gvGRJRMBWlT+EUDX5Wcevnm35W/iP9+lBt/IThYObATWNvBIdouEDf4JkMR
         3JZ/sM81q9Bwv2yGNC4vXzmGoW/lYcrPpqR93BzuCFsdAEeIl5/q/MsHW5yyscnu8Xz4
         YFIi2RCjYHaEN6fJiF6nCSqOHovinozB4x9UhIDfhWheX7nPIdfMZKGlk/lG8V4VxkFy
         9qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789136192; x=1789740992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3UtoV/pw3leuZYVI4/SY6nx/n06s07Bocud6331VQDU=;
        b=Vwnscxw77OFsaVEO3yIam3mcfESc+ifPk7EPERgMbGBT3cTdpZ8XqsrJaEh61YgG5M
         KoHEu5rr230Zukv6yrKmNYMxDGphdgXqVTpqZij7PwDMmCNNsZ7hkW1hVWTlhnwDRppN
         UNLhaQWzBECvfaqDpP/FrOsQOu3tEGbi1t/JQ4kO0vQad1FaiofrJDp/eoXDDGiBLyCQ
         SJgVl40u/R9SZ5iov5gj4WhK5VACik/QvC1HA1AH5v1M/O1q4c5t5huClo7HFVOV+8va
         u+Rp9I4iF2pls9zBGBv7YC5pg4jwHQTdJhoSzh0r559GCi3QiCwYkVeHD/x5SiEmVQc8
         HVkw==
X-Gm-Message-State: AFuF++mq6PlMaUyNlOxsz/gGcP4soML8Poa89X7PnGoR0Qo+d/xhQ6Rh
	vxfZwhxgVU8mbn+5F01ngCAlLK7sBIeVVMd5fPQAzSCbx3IyS2XofF6je4w8U57C
X-Gm-Gg: AYBFou0QmUzrCO1mchFUI8YS6RvAoIhMUPoy6AB+8SQre4h53KM5DehjKXZSc6tC6eg
	q1i5hj/nLm6HAa8TmFrdRnVvXEpeP/RruTs80k2spGvRzg3AtldGrHKiyPa5j6zkx0EvuqnlIFu
	hP5Sr2fskkGXVFuk/SClhCUf6P05Ec3EIQCN0vF4CfQreL7voUA19f/+cVcFm0wPuMF253o8nt1
	hkHZ71+t6O7+QNK4FdUSQMUDHvBkhA6qk7kxGPvkrNIFzy4RrtncRy9BCL8TLXDRiQKHnzA9ET4
	MSMwgQ1WvIzC6HhpIFeEmZpkaRaV0ug/Wn4rdgs5mZMiWIMuwvvoWxhj2wlZXWNU/pB5WUOvRay
	nN0INvX9DoUgfL5doqGAfUTVz/S/sT4USplx8o80/4Py3xC3q9QuVJItEMeOd19VXku832U+1ST
	u8rYcwR1vF451pXoXdfC9GfagVSccW9uPtsTB4/ZOStx2kZopBgLmasO9Hou4Mh/OQ5koNYBt6Z
	IfwebWd9iZ2FQzsINPyI4mMdU3N0Yswu1XXcq8TkNxcd9vDmGm9m0cZymGu6am4BHGZhR5I1qT2
X-Received: by 2002:a17:90b:53d0:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-39d9bc1b0demr6575516a91.1.1789136192365;
        Fri, 11 Sep 2026 07:16:32 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d995a42a5sm5172740a91.17.2026.09.11.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:16:31 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	=?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Mykola Lysenko <nickolay.lysenko@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Tolerate libarena skeleton failures under BPF_STRICT_BUILD=0
Date: Fri, 11 Sep 2026 23:16:21 +0900
Message-ID: <20260911141621.1944900-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Makefile documents BPF_STRICT_BUILD=0 as tolerating any BPF object,
skeleton, test object or benchmark failure so that the remaining tests
still build.  Every skeleton rule honours that through
$(if $(PERMISSIVE),...), except the three that build the libarena
skeletons.  Those invoke a sub-make with no guard, so a libarena failure
is fatal even in permissive mode.

With a libarena source that fails to compile, BPF_STRICT_BUILD=0 stops at

  make: *** [libarena/libarena.skel.h] Error 2

while an ordinary program failing the same way prints SKIP-BPF and the
build carries on.

Guard the three sub-makes the way the other skeleton rules are guarded.
The build then prints SKIP-SKEL and continues, and test_progs,
test_progs-no_alu32, test_progs-cpuv4 and bench all link.  Nothing
downstream needs a change, because the missing skeleton drops out through
the existing permissive paths and libarena.test.o is reported as
SKIP-TEST.  The default BPF_STRICT_BUILD=1 still fails on the same input.

Fixes: a6850fa388f6 ("selftests/bpf: Add BPF_STRICT_BUILD toggle")
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
Assisted-by: Claude:claude-opus-5
---
 tools/testing/selftests/bpf/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7ea5ba1df29e..a9951774e5c8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -835,17 +835,20 @@ LIBARENA_SKEL := libarena/libarena.skel.h
 LIBARENA_BENCH_SKEL := libarena/libarena_bench.skel.h
 
 $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
-	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
+	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS) $(if $(PERMISSIVE),|| \
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$(notdir $@)' 1>&2)
 
 $(LIBARENA_BENCH_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BENCH_BPF_DEPS) | $(LIBARENA_SKEL)
-	+$(MAKE) -C libarena benchmarks $(LIBARENA_MAKE_ARGS)
+	+$(MAKE) -C libarena benchmarks $(LIBARENA_MAKE_ARGS) $(if $(PERMISSIVE),|| \
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$(notdir $@)' 1>&2)
 
 ifneq ($(CLANG_HAS_ARENA_ASAN),)
 LIBARENA_ASAN_SKEL := libarena/libarena_asan.skel.h
 CFLAGS += -DHAS_BPF_ARENA_ASAN
 
 $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
-	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
+	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS) $(if $(PERMISSIVE),|| \
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$(notdir $@)' 1>&2)
 endif
 
 # Define test_progs test runner.

base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e
-- 
2.43.0

