Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9041B8C4
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586908; cv=none; b=bGR8HRVNRMzwxUgfnMej178YgqX/fF1K3Gc/tYufAfQCHnXVns94HTHSjC+1qnfAqbif1MLzoB0lrLaAntRn2/3NKE5ai/EHW58vXppYa5LRVXDp5Eo9Dd12/sRznALw3DEWCxJpWTQxFLgabt6U5hcCSqpvrWk+DuzrzZvB4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586908; c=relaxed/simple;
	bh=+cH4kM/WIfsxGT5aU6nh+OTEiMUxwgXVLXPlSDuAzaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJlQCv5ObZGC7UYJjB5JKbvIAXIcxQbcSGBOOqoj1UdNo1JKllfotCPYwHkBTWahaQgOsOnYj28Rf0QJT1eZvzcmdzl9QVMwSm+CW597vTt1+Uzsg17CTzqXd+uKz6cnAESz7yUaZ52b3g+7aQvPCKjWPp4ZAYjxEtAnQk4bp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C64jU2e/; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C64jU2e/"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e66652cc3so324345e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586889; x=1790191689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YHzF+MG27afXPhvnJLOW6jSoiAU1qS2nIqsKW22ALLg=;
        b=C64jU2e/NKOQa0AXWI9Zolu1+FyOeup2J2OTiMsLkvUmqP0bVfr7Sd6Xk5rtPuDNkO
         VWGQmvJc8Ed70jMx4Gubbes8ce7mFW8PxQhSX2smEq0p8JSE9XbTpVKZB9lr9lQn7hQP
         L50YfS9aZAYRCX8y9OoGMzzbPUorVEYMy/EywwgUcQlmpbS9kVUaL+gaMtwp46GJgC41
         WbG83SMB7HRzHs0fWdpDGdma6Fbze81R/JWAIgaldTwTckFBQVnSLXOoIDLLE5RE3Qmz
         NxV4cJTjqwUnUiDvWOyV35FO50KHy5XEcMMk22sP8cE25xmPPM7UQZlzWYO/cmB89pSM
         NXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586889; x=1790191689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YHzF+MG27afXPhvnJLOW6jSoiAU1qS2nIqsKW22ALLg=;
        b=YemxU2TDdtLNEulktRz9ALh3X9o6bOpYer3dE54JJ0fPjpqZWhY8RIg9Yqnv00/Akl
         G81cL6MEHZeYKgHbv+5JfpavBLEBst6KXRLPTBDYH10EX8pXeoFVvnpicSC7eFM5Cxgz
         ti8kvlL8xVpLLlfYUM/hPq7i8TRKxTyi7quFvHjVX+rTUWwITwSFLFdyiyyqD0ZA6Xnw
         mBwwXvl7PZAZcnDss2WkdM6t0SpjUHeEoSaqWqp/JSCPYIZrtFyECrHD9ENMQWzQ/zUl
         AvWKmC0A1ah6rJJJ6Bu/uaEz/IY2QH7Mg1gXfPhY9S5ZrTuGHzgkn1IPkpum4gKw92Ml
         yybg==
X-Gm-Message-State: AFuF++lvrcafII2UOCuC2d8bLaDFJ25EUEmRd6r8QOEHOn0CeG1DfYwc
	RkCzvbyZkVqgqA4HE9ThM7Rx4B4tFdHK5s/ibt5S8Scgch7seqsu0FO283jZkXZC
X-Gm-Gg: AYBFou0KE7nP1a73brjpxE6ZkFPl15ujiHxIl+2PqwRQv/leKrc2/ThnGmksOcYgXjF
	npzWyO1938/s4xKK2S6ceKcMRXlYyeaK4ZMJk3tDsOvbl6ZMf6jAt/CVWeW/oze7sjokdiPdsNA
	Av41VBQNb81kLK2IUXM6BeoFhIAVDsZUfJrdTbK+o5jrCGZoY6hfFLB2V0k6UJcYB4jnRvKK76h
	yJqVFEno8IQTZnXskLc8O40MSjYmOHKA2gEHOmCNff1y09pxhVk7FAujsYj4Uw9jH2Ayqrpy7Hw
	HEcr0aZyGBf2NV/9QLNjYZwO4lgS8RmT7eGD+vQfGIZZhQimAVpr15AqcxS6bV4KE4GIFn6hw6/
	4rAnKz7u2HAylY1a+ogiszCzqiGDPmzLWn3quQmhReGhx0GKqKM16TMHAKMJ04M3JF3qLv32k+J
	6Qs5qklyfyDLJbaYBNmtaxGlXpTarbQPAzeAYof8F4JPwLj/dFxo1cSg9f/kKQnWkpEe7JY6SpF
	8novPFbW78RMtWWTCf2aNXaCu4Cre2nwZ7wfoVlWKhdg1/xUos45S1U7WcUhEBI5mTizVrLnMjf
	lXT66zgePMG3tXE/h0GOEqGvu3VONWn6cWEfrg==
X-Received: by 2002:a05:600c:a087:b0:49f:bd35:d350 with SMTP id 5b1f17b1804b1-49fbd35d3f9mr7190905e9.35.1789586888718;
        Wed, 16 Sep 2026 12:28:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd24034esm14863375e9.15.2026.09.16.12.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:28:08 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/5] selftests/bpf: Allow privileged preparation for capability tests
Date: Wed, 16 Sep 2026 21:27:58 +0200
Message-ID: <20260916192805.3991983-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916192805.3991983-1-memxor@gmail.com>
References: <20260916192805.3991983-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8679; i=memxor@gmail.com; h=from:subject; bh=+cH4kM/WIfsxGT5aU6nh+OTEiMUxwgXVLXPlSDuAzaQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvV21pbV909/pJ+MzbtLohN4Vu6c8O2zru/TPPea6n1O mSaV6p0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCK5zYwMC/43+TtVT6ufctD0 n2VyrYiIcfRzlh7t8xnLp+2X1l7kx8jw7HZH9PfemDMrzd6H/SywE506ZymDiaTho/+CedpMS3q YAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The annotation-driven loader drops capabilities before libbpf prepares an
object. Resolving bpf_testmod kfuncs requires CAP_SYS_ADMIN to enumerate and
open module BTF, so tests without that capability fail before reaching the
verifier.

Add an opt-in __prepare_priv annotation. Call bpf_object__prepare() with the
fixture's initial capabilities, then apply __caps_unpriv before loading the
programs. This uses libbpf's explicit prepare/load boundary. In particular,
CAP_SYS_ADMIN must be dropped along with CAP_PERFMON to test uninitialized
stack checks, since CAP_SYS_ADMIN satisfies the verifier's CAP_PERFMON check.

Preparation also creates maps and loads BTF. Keep it opt-in so existing tests
continue checking those operations with reduced capabilities. The existing
pre-execution callback runs after program loading and is too late for this.

Allow tests retaining CAP_BPF to run when the unprivileged-BPF sysctl is set.
Check CPU mitigations separately: disabled or undetectable mitigations must
still skip these tests, because CAP_BPF does not restore speculative
execution checks.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  9 +++-
 tools/testing/selftests/bpf/test_loader.c    | 48 ++++++++++++++------
 tools/testing/selftests/bpf/unpriv_helpers.c | 16 +++++--
 tools/testing/selftests/bpf/unpriv_helpers.h |  2 +
 4 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index eb88d9ce6c34..2ced1d751ace 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -9,7 +9,8 @@
 #define QUOTE(str) #str
 #define EXPAND_QUOTE(str) QUOTE(str)
 
-/* This set of attributes controls behavior of the
+/*
+ * This set of attributes controls behavior of the
  * test_loader.c:test_loader__run_subtests().
  *
  * The test_loader sequentially loads each program in a skeleton.
@@ -131,6 +132,11 @@
  *                   Several __arch_* annotations could be specified at once.
  *                   When test case is not run on current arch it is marked as skipped.
  * __caps_unpriv     Specify the capabilities that should be set when running the test.
+ * __prepare_priv    In unprivileged mode, prepare the object with the fixture's
+ *                   initial capabilities before dropping them for program loading.
+ *                   Preparation includes map creation and BTF/kfunc resolution;
+ *                   these operations are not tested at the reduced capabilities.
+ *                   Program loading uses the normal __caps_unpriv selection.
  *
  * __linear_size     Specify the size of the linear area of non-linear skbs, or
  *                   0 for linear skbs.
@@ -166,6 +172,7 @@
 #define __arch_s390x		__arch("s390x")
 #define __arch_loongarch	__arch("LOONGARCH")
 #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
+#define __prepare_priv		__test_tag("test_prepare_priv")
 #define __load_if_JITed()	__test_tag("load_mode=jited")
 #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
 #define __stderr(msg)		__test_tag("test_expect_stderr=" msg)
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 28724de06322..a6e3fcc1079c 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -33,6 +33,7 @@ static inline const char *str_has_pfx(const char *str, const char *pfx)
 #endif
 
 static int sysctl_unpriv_disabled = -1;
+static int unpriv_mitigations_disabled = -1;
 
 enum mode {
 	PRIV = 1,
@@ -71,6 +72,7 @@ struct test_spec {
 	int load_mask;
 	int linear_sz;
 	const char *skip_reason;
+	bool prepare_priv;
 	bool auxiliary;
 	bool valid;
 };
@@ -606,6 +608,8 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
+		} else if (strcmp(s, "test_prepare_priv") == 0) {
+			spec->prepare_priv = true;
 		} else if ((val = str_has_pfx(s, "load_mode="))) {
 			if (strcmp(val, "jited") == 0) {
 				load_mask = JITED;
@@ -1015,10 +1019,10 @@ struct cap_state {
 	bool initialized;
 };
 
-static int drop_capabilities(struct cap_state *caps)
+static int drop_capabilities(struct cap_state *caps, __u64 keep_caps)
 {
 	const __u64 caps_to_drop = (1ULL << CAP_SYS_ADMIN | 1ULL << CAP_NET_ADMIN |
-				    1ULL << CAP_PERFMON   | 1ULL << CAP_BPF);
+				    1ULL << CAP_PERFMON   | 1ULL << CAP_BPF) & ~keep_caps;
 	int err;
 
 	err = cap_disable_effective(caps_to_drop, &caps->old_caps);
@@ -1028,6 +1032,13 @@ static int drop_capabilities(struct cap_state *caps)
 	}
 
 	caps->initialized = true;
+	if (keep_caps) {
+		err = cap_enable_effective(keep_caps, NULL);
+		if (err) {
+			PRINT_FAIL("failed to set capabilities: %i, %s\n", err, strerror(-err));
+			return err;
+		}
+	}
 	return 0;
 }
 
@@ -1048,8 +1059,12 @@ static int restore_capabilities(struct cap_state *caps)
 static bool can_execute_unpriv(struct test_loader *tester, struct test_spec *spec)
 {
 	if (sysctl_unpriv_disabled < 0)
-		sysctl_unpriv_disabled = get_unpriv_disabled() ? 1 : 0;
-	if (sysctl_unpriv_disabled)
+		sysctl_unpriv_disabled = get_unpriv_sysctl_disabled();
+	if (sysctl_unpriv_disabled && !(spec->unpriv.caps & (1ULL << CAP_BPF)))
+		return false;
+	if (unpriv_mitigations_disabled < 0)
+		unpriv_mitigations_disabled = get_unpriv_mitigations_disabled();
+	if (unpriv_mitigations_disabled)
 		return false;
 	if ((spec->prog_flags & BPF_F_ANY_ALIGNMENT) && !EFFICIENT_UNALIGNED_ACCESS)
 		return false;
@@ -1351,17 +1366,8 @@ void run_subtest(struct test_loader *tester,
 			test__end_subtest();
 			return;
 		}
-		if (drop_capabilities(&caps)) {
-			test__end_subtest();
-			return;
-		}
-		if (subspec->caps) {
-			err = cap_enable_effective(subspec->caps, NULL);
-			if (err) {
-				PRINT_FAIL("failed to set capabilities: %i, %s\n", err, strerror(-err));
-				goto subtest_cleanup;
-			}
-		}
+		if (!spec->prepare_priv && drop_capabilities(&caps, subspec->caps))
+			goto subtest_cleanup;
 	}
 
 	/* Implicitly reset to NULL if next test case doesn't specify.
@@ -1414,6 +1420,18 @@ void run_subtest(struct test_loader *tester,
 	bpf_object__for_each_map(map, tobj)
 		bpf_map__set_autocreate(map, !unpriv || is_unpriv_capable_map(map));
 
+	if (unpriv && spec->prepare_priv) {
+		/*
+		 * Module BTF lookup needs CAP_SYS_ADMIN. Allow tests to prepare
+		 * their objects first, then verify programs with the requested caps.
+		 */
+		err = bpf_object__prepare(tobj);
+		if (!ASSERT_OK(err, "obj_prepare"))
+			goto tobj_cleanup;
+		if (drop_capabilities(&caps, subspec->caps))
+			goto tobj_cleanup;
+	}
+
 	err = bpf_object__load(tobj);
 	if (subspec->expect_failure) {
 		if (!ASSERT_ERR(err, "unexpected_load_success")) {
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index 2c8c5edb8751..c8dd5d848584 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -111,9 +111,8 @@ static int get_mitigations_off(void)
 	return !enabled_in_config;
 }
 
-bool get_unpriv_disabled(void)
+bool get_unpriv_sysctl_disabled(void)
 {
-	int mitigations_off;
 	bool disabled;
 	char buf[2];
 	FILE *fd;
@@ -127,8 +126,12 @@ bool get_unpriv_disabled(void)
 		disabled = true;
 	}
 
-	if (disabled)
-		return true;
+	return disabled;
+}
+
+bool get_unpriv_mitigations_disabled(void)
+{
+	int mitigations_off;
 
 	/*
 	 * Some unpriv tests rely on spectre mitigations being on.
@@ -144,6 +147,11 @@ bool get_unpriv_disabled(void)
 	return mitigations_off;
 }
 
+bool get_unpriv_disabled(void)
+{
+	return get_unpriv_sysctl_disabled() || get_unpriv_mitigations_disabled();
+}
+
 bool get_kasan_jit_enabled(void)
 {
 	return config_contains("CONFIG_BPF_JIT_KASAN=y") == 1;
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.h b/tools/testing/selftests/bpf/unpriv_helpers.h
index a7ceb51577cd..c24d53e14f3a 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.h
+++ b/tools/testing/selftests/bpf/unpriv_helpers.h
@@ -5,5 +5,7 @@
 #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
 
 bool get_unpriv_disabled(void);
+bool get_unpriv_sysctl_disabled(void);
+bool get_unpriv_mitigations_disabled(void);
 bool get_kasan_jit_enabled(void);
 bool get_kasan_multi_shot_enabled(void);
-- 
2.53.0

