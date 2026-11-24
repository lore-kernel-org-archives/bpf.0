Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540104;
	b=R9gTx1Z0ZoG0fxBDD58RjHq/J7ncrdiYdUus7kbLClHAMHWPvOZ0zXqWtA12AK1oqAO3
	 d4xCtyKT8axprXT0WfZeHKMTKc72/S4B9h6vOPNryNNOjFGBC0hWkUmwwop8hot0PJWYq
	 LmwsLi2XiwzY35J0NHlZSl3yn+dXBM1GliGAbIZTIsAceon6TVJnJ1Vuckux0jR/RRm9Q
	 w2OXdieBt+Q5X41WU8BnQXebwfhSmnrXSNoQUA3TWpVmjmqMWmpk0U2SdHvDIWitLmMaG
	 RghNrAbSSNy/leD67S0UzWWGnbPyfXdi/6bqSUxCzhpWq3fSaa4Zsu9hc65BTuBr1Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=VvLC2UlDBW0JAuPTfvK6h08GgQ/EvuigWXLQ4OjDipU=;
	b=N5lhd9v0M8sbcv4nT3iRv5xiTihNch8LWK1+xOYmmgRcSkv45ro7JxHpOEWgpSFhQMZC
	 tESsPLbFgimJc4fcC7Lz82Ai6AJNDcXhaF4Yi+NJElXEFPv/51GO0RlW7GnzGBCWiM6Xw
	 tjT8SSLkcsselkJIiTFr/Zp5T02xVehy/0cWjM43En58pbnohzqZsp4pU496ggfDfInkP
	 kcGWMQzlZCzooL5UOmQFjbOKmfNAf4f0AQ/QB+OIcTvnLzDkbmgvrmCHunwaell/H8cGj
	 oFCiy8pe1llUpVn01zG/aGtuwfz542Xj8C7R3TgeJWzi0gsjPMQw7E86dawP95IBb7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NA0BQGL1;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27360A261F
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D27360A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NA0BQGL1
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43bf9548df4so4370778fac.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795540103; x=1796144903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VvLC2UlDBW0JAuPTfvK6h08GgQ/EvuigWXLQ4OjDipU=;
        b=NA0BQGL1Dfoh6+CKB8viifXXBlA2jSw1O2UMtykeikDvlL+opQNw3XsryUmoMiDtWJ
         /BGj3A+EqsiDvT3JDWKOWh3FQhtlV0hZJMQLrjHBg5oujJ0KKEh6vV/RgxSH0rzFznlF
         gH3bft8NtGDBCJTonpHCsVl9e976TQKmQmuBfvbt+akETy7/qN7z65a2paBXyO7kNC7J
         17mAhwYYwgaYmeVXyr/MNsijsyzeGX6e+kCZrn+Gogvtgq7RpRy6DaTOybYj/wO0z567
         nZbtXiZUResC3EFFLChlK9KpuLdDBAMMXcwMv6pdBYp76HFYVJCr9FbCLYp/V//RCgfA
         voNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540103; x=1796144903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VvLC2UlDBW0JAuPTfvK6h08GgQ/EvuigWXLQ4OjDipU=;
        b=IRBFNGD8V4VChvqMymrBDH4G15HCEz+zo1stAEXrSnvY+CDhyyDFfkTkrKYJMioUoB
         wgSWPPVcnFsZ1A0AdbfU52ifF/BsiqmBmVZkZIK9HKsKROHHbVyzm5DFi0yRaI+D5qRD
         6yY5f/9pWX6D+OA0qaGnhCmCZUFxZRB/MsZzdNRYqIAWKUPG/5mhXiqd/GcR9CySRa0E
         uIlOF57IEVDsA6U4+FMAJO3jXc7Ipk8OfGMmhbHzoTwEemFUdJ0COKSpZ9awnauCWsx+
         LvU/lz1blSbB+P3+walxLJWY06FkTndzCXHApsf49xM/2GEE2X8cFsBM13OlEwQ556KL
         8tyg==
X-Gm-Message-State: APuU4Z+SapMJWLr1SQBZr3dAhmXym4Kuk6AASis4oCwVOqhqcc7u94c1
	fS7+3IIhGBcwyARsp79GP3uRGbo5oHD+EhoWSsFsnTyS0VIne85Sb8ft
X-Gm-Gg: AZFdTZfTDqIjxMFlgCPwJdgk+zpqWZic+RAqZDSRfMGNv00XOZVm4zoUyXWta5T7eQQ
	HviBYnpChnoQ/P8u3963ZCVOWh3saWZeGxB4TPIez6IvL1uj5mfWi3Q1OnsHSJgxfAixHxKCgvx
	PvsO8NvpLvye6QTkQdvslYy2AeBVH5FmBAsPtKCHcRsU8Ht81JxgJF+GuDBWasru9oidBYd6f0T
	1NBHEhzrGFEAq1EOMprIQo/fD7kxNwd3SCSpdiX0vFUhORl8qyq6ViDNyLJNvSXo8zUWYCbHEGB
	i2GQ7eJGTvmofMd+BgC4M+SnZQx91g2YO+f08ffMf4z3NqlrhUuwEM4imlril6ZMRKEwN7uH37q
	YQWkSv7xxVfDmCDxKa1G3fNJ/aTRsvAMb+f8Gx/XjrBZKl1fdKOnxWBD6KO2oYBPPOr3ueQSXfr
	HZQAR3HVlOEa23HpY3n2PVVl0OeO8FyYJKr6Q2VU+nr5JDuciuiblM3y684Q4t+Zi1CVOMwi0dA
	gNY1XC/7PPkHzomXcrjVU2v1+tR2Ak7DbHkgxyeX5J9vA0hbiJX/RIxgfyF8m4s8LzDuhRHVHvZ
	9pFcqPaXW6GzIZmJEd4=
X-Received: by 2002:a05:6808:4fe3:b0:572:a102:ad54 with SMTP id 5614622812f47-57a0bb79bdemr18139774b6e.40.1795540102710;
        Tue, 24 Nov 2026 09:08:22 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34252987sm11535122b6e.4.2026.11.24.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:08:22 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 24 Nov 2026 09:08:08 -0800
Subject: [PATCH bpf-next 1/2] selftests/bpf: Let __skip() report SKIP for a
 return value
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-arena_big_alloc3-v1-1-141c26210bff@meta.com>
References: <20261124-arena_big_alloc3-v1-0-141c26210bff@meta.com>
In-Reply-To: <20261124-arena_big_alloc3-v1-0-141c26210bff@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 ihor.solodrai@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795540098; l=4415;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=xKiBkzq3eH5jDD3tzyFDBH9C9k+y+OLEwnWerqEAJCE=;
 b=+Zs7q6pTkF6+bEHZL01mOSj0NpF+/ksPfa/cJJRx9LZVmec8KkLnhWc4o4nns7YuPbfQqnPNg
 vJDzZmhT+1VAPrt/+LKIXYv38VnBuc9fFfe4tGhxu+Vr2KUSz9Felc7
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Some test programs need a resource that the kernel can refuse at run
time, for example memory for a nonsleepable allocation. If the kernel
refuses it, the program cannot do its check, and the correct result is
SKIP, not OK or FAIL. __skip() can only report SKIP without running the
program.

If __retval() comes right after __skip(), run the program, and report
SKIP with the reason when the program returns that value. The usage is
like __success __retval(0):

  __success __retval(0)
  __skip("no memory") __retval(1)

No program has __retval() right after __skip() now, so this does not
change existing tests.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  6 +++++
 tools/testing/selftests/bpf/test_loader.c    | 35 ++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 6b930cb48f8d2..4e6b8a5714407 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -115,6 +115,12 @@
  *                   running it. For placeholder programs that stand in for a
  *                   feature the toolchain or JIT cannot provide, so a run does
  *                   not report OK for coverage it never executed.
+ *                   With __retval right after __skip, run the program and
+ *                   report SKIP only if it returns that value. For programs
+ *                   that need a resource the kernel can refuse at run time:
+ *
+ *                       __success __retval(0)
+ *                       __skip("no memory") __retval(1)
  *
  * __skip_without_arena
  *                   __skip() when the compiler does not support the arena
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index d24e4fedae46f..4baee582d6ec3 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -78,6 +78,8 @@ struct test_spec {
 	int stack_mask;
 	int linear_sz;
 	const char *skip_reason;
+	const char *skip_retval_reason;
+	int skip_retval;
 	bool prepare_priv;
 	bool auxiliary;
 	bool valid;
@@ -380,6 +382,19 @@ static const char **collect_decl_tags(struct btf *btf, int id, int *cnt)
 	return tags;
 }
 
+/* Return the value of the __retval tag right after tags[i], or NULL */
+static const char *next_retval_tag(const char **tags, int i, int nr_tags)
+{
+	const char *s;
+
+	if (i + 1 >= nr_tags)
+		return NULL;
+	s = skip_decl_tag_pfx(tags[i + 1]);
+	if (!s)
+		return NULL;
+	return str_has_pfx(s, "test_retval=");
+}
+
 enum arch {
 	ARCH_UNKNOWN	= 0x1,
 	ARCH_X86_64	= 0x2,
@@ -457,7 +472,7 @@ static int parse_test_spec(struct test_loader *tester,
 		return PTR_ERR(tags);
 
 	for (i = 0; i < nr_tags; i++) {
-		const char *s, *val, *msg;
+		const char *s, *val, *msg, *skip_val;
 		bool clear;
 		int flags;
 
@@ -467,7 +482,18 @@ static int parse_test_spec(struct test_loader *tester,
 		if ((val = str_has_pfx(s, "test_description="))) {
 			description = val;
 		} else if ((val = str_has_pfx(s, "test_skip="))) {
-			spec->skip_reason = val;
+			/* __skip() __retval(N): SKIP when the run returns N */
+			skip_val = next_retval_tag(tags, i, nr_tags);
+			if (!skip_val) {
+				spec->skip_reason = val;
+				continue;
+			}
+			err = parse_retval(skip_val, &spec->skip_retval, "__retval");
+			if (err)
+				goto cleanup;
+			spec->skip_retval_reason = val;
+			spec->priv.execute = true;
+			i++;
 		} else if (strcmp(s, "test_expect_failure") == 0) {
 			spec->priv.expect_failure = true;
 			spec->mode_mask |= PRIV;
@@ -1547,6 +1573,11 @@ void run_subtest(struct test_loader *tester,
 				       bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ||
 				       bpf_program__type(tprog) == BPF_PROG_TYPE_RAW_TRACEPOINT,
 				       spec->linear_sz);
+		if (!err && spec->skip_retval_reason && retval == spec->skip_retval) {
+			printf("%s:SKIP: %s\n", __func__, spec->skip_retval_reason);
+			test__skip();
+			goto tobj_cleanup;
+		}
 		if (!err && retval != subspec->retval && subspec->retval != POINTER_VALUE) {
 			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
 			goto tobj_cleanup;

-- 
2.53.1-Meta

