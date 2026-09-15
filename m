Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D85366055
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481413; cv=none; b=GvKFBh0q4uExyzEvIo+hKnmW0YbcRDIa6dRRLIcPjh/srIUhjruzqz0ZGiaAQsjUvKu2yLQfigpiTlyMfwBn87616ZAraosBMvbImI9pFww9sAqNJ/WlbIybvUqVRyKCxsyla5f3MdF0ULaAGUMJL8cCVdSeNhsAMeTCYVDPh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481413; c=relaxed/simple;
	bh=rz90lb/yU3dY3V7flgN2rZXvERZpmP4RMGvInJDKlOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAzLoQAxwuYJMBpTFhZMWHUzKPGNjIWnEhREhtonAMZtGXPHeugTRa44TY5tDAPODTWNn3n71vueDpBi7+sJ96yz52EmhbUuN0XkxYffO4TP8V2F+f88LrxoFDYvWyIKnVhPgU3M7zUImQFbHmPbi8F5V7a0gbFEXv837rdnKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+6Ch4sX; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+6Ch4sX"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484373a2e82so1827357f8f.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481410; x=1790086210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRe2GLbkRzUwMYM1/gGmJstfQzSzI5mpPgCWwtE+PSQ=;
        b=o+6Ch4sXDDQ9vkYQUlzl36T2kWhm9We6hpSy9PFvv7E8nQgxSsIEGOLAQY7JSZAEFV
         v+T7un8LgxyaUs+nzFPsRl+8bl/OeqwyM9Guv7/M5J/GlpbLvaWBY80eX1zVl/VOkpm0
         fJZzg2Bl4FAYEIkn5kcPyiQAevxfcEOsih47ym15VwQxPxnLHhyQYB1l5RM3Qsf+lBJ7
         iYo0ikToJecwyAQnhtHVqLMuwbXRBdj+O7oYYCjwqRzI7l+HI/oZvzPb8ACV7ZktR8GA
         dJR8Tj5uOg5OnKFPRsAxv84ItYqOrHbB0QGLJscJ4mdfInZE1ijJPw8FWi06tdYFH9yA
         SHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481410; x=1790086210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SRe2GLbkRzUwMYM1/gGmJstfQzSzI5mpPgCWwtE+PSQ=;
        b=qr6q18UOJQ5QiC6ftEcI9coI4a8lcuTCnHLCSS6DOvDxrlOIRCi2xlVdLuuW+QdRNH
         XhDgp3FCBBzaDiwG1IsTBTmhNO4K3RQol+yrg+qBywPP4hd1J4XrheFdd6hQOlLEkxaH
         tjanGaFBc8X294+6sCwxHnI5FD0L55ArMpsIBEukDbCu37iFg6LXL3uNXaqEWJLSSO1u
         IOYnWAaa0+Hgv2XHNWjysJGUAVhWAlZGddkGpywhfZ6hGsxE9C3y8YWrWwx8iFZ62oKR
         GbNK7iB9iK5rgJSiSZl5Uloh84LHKmm+kwfJJNtZBv5H3wDL/ytQMTLrJLnIiV2NHKO6
         IszQ==
X-Gm-Message-State: AFuF++lSRiowTyxVeJTG6dN+x7OW45km5WkiAJngCLwhWJFHM8mqJNiU
	k60Rgn5hRoJJWZhvfW80rpzyyYKQTIMadmFtVrfKsHi7x0RpxPIRMa+ZC05ocF/vbJc=
X-Gm-Gg: AYBFou1BAl7V76IOTebbV7X44FO6Ud+ilEGXL4eF9KmbSKO+MpgpJHr7BUoUbpGMbmH
	vCmyOWkG2TJnnauJs1BnWoQqQulMq3ya/9yvjcNFa2P9DGXI+i8QYu5AMtAmqGTM8f+2mZ7k5ms
	KzK1B9TB9O+vvVgmaGLHYZuISb5e8aj/RKCitK4BlAaaha/H1/oQNQYbq9LmuPAw9RGvE0O1kWr
	uY5JRxszD0aGm6d1ynGzRKVHEHqtMJiI/7J8ns9cidW8S633x6sMK1x5joNkwtknKoMt9xiJXcb
	3cxq3hBTRI6A0Kwwy6F4MGq6wbuvaGXXO4XTCzZypElansCaXjxnpkvbtmpKJXUIoOL/+gVZ6FE
	0p5aaWG9Hf0Bf3q6Ea9PR1aTOyRxtL8Jp/uhkjRVpDhtzuArFhPAyC3nTPvLHyy18kex6GhrOTa
	eIupE3Nz0mnfUiTnAm+/V6rSp0qciexRCXG+hkrB4oQZl3YgCgq4ZoCaODxiM8fBzJb4MzebjAw
	cwfnj+HDHx+SFxj+FOiz1eZgbKmemvfLr4mdxKLBEHjBof60VvsZuSx/WNmSUTPY+Smr7izqrxx
	9zPvWBu4HihLTbl7H6wS1Ohc68zhOMUdgLiBWQ==
X-Received: by 2002:a5d:64ce:0:b0:484:3314:eff6 with SMTP id ffacd0b85a97d-48702b3ce87mr18377749f8f.28.1789481409581;
        Tue, 15 Sep 2026 07:10:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34e74esm34629302f8f.25.2026.09.15.07.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:10:09 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] selftests/bpf: Allow privileged preparation for capability tests
Date: Tue, 15 Sep 2026 16:10:02 +0200
Message-ID: <20260915141004.1196460-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915141004.1196460-1-memxor@gmail.com>
References: <20260915141004.1196460-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6458; i=memxor@gmail.com; h=from:subject; bh=rz90lb/yU3dY3V7flgN2rZXvERZpmP4RMGvInJDKlOE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtlYOf93Ff6xud2OSz87KR46Prl50bHHy9dyaPjpGgvc j/i0MOTHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjI+RqG/2F6R92Njpo4sIet DpfZv81XizGqc6ryNaGeqX/TUpNyshn+KS+zXczUHb71r+p3xvN7WW7fuMKRGRbvp/rPYG/ec+n pzAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The annotation-driven loader supports retaining selected capabilities with
__caps_unpriv, but drops the others before libbpf prepares the object.
Resolving bpf_testmod kfuncs requires enumerating module BTF and obtaining
its file descriptors through BPF_BTF_GET_NEXT_ID and BPF_BTF_GET_FD_BY_ID.
Both operations require CAP_SYS_ADMIN, so dropping it at this point prevents
the tests from reaching program verification.

Resolve the module references while privileged, then drop capabilities
before loading the programs.

Add an opt-in __prepare_priv annotation that calls bpf_object__prepare() with
the fixture's initial capabilities, then applies __caps_unpriv for program
loading. Preparation also creates maps and loads BTF, so making this the
default would stop existing unprivileged tests from checking those operations
at reduced capabilities. Keep their preparation path unchanged. The existing
pre-execution callback runs after program loading and is too late for this.

Run cases retaining CAP_BPF even when unprivileged BPF is disabled, since
that sysctl does not prohibit their program loads.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  9 ++++-
 tools/testing/selftests/bpf/test_loader.c    | 41 +++++++++++++-------
 2 files changed, 35 insertions(+), 15 deletions(-)

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
index 28724de06322..940b6d8e47ba 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -71,6 +71,7 @@ struct test_spec {
 	int load_mask;
 	int linear_sz;
 	const char *skip_reason;
+	bool prepare_priv;
 	bool auxiliary;
 	bool valid;
 };
@@ -606,6 +607,8 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
+		} else if (strcmp(s, "test_prepare_priv") == 0) {
+			spec->prepare_priv = true;
 		} else if ((val = str_has_pfx(s, "load_mode="))) {
 			if (strcmp(val, "jited") == 0) {
 				load_mask = JITED;
@@ -1015,10 +1018,10 @@ struct cap_state {
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
@@ -1028,6 +1031,13 @@ static int drop_capabilities(struct cap_state *caps)
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
 
@@ -1049,7 +1059,7 @@ static bool can_execute_unpriv(struct test_loader *tester, struct test_spec *spe
 {
 	if (sysctl_unpriv_disabled < 0)
 		sysctl_unpriv_disabled = get_unpriv_disabled() ? 1 : 0;
-	if (sysctl_unpriv_disabled)
+	if (sysctl_unpriv_disabled && !(spec->unpriv.caps & (1ULL << CAP_BPF)))
 		return false;
 	if ((spec->prog_flags & BPF_F_ANY_ALIGNMENT) && !EFFICIENT_UNALIGNED_ACCESS)
 		return false;
@@ -1351,17 +1361,8 @@ void run_subtest(struct test_loader *tester,
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
@@ -1414,6 +1415,18 @@ void run_subtest(struct test_loader *tester,
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
-- 
2.53.0

