Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045F437115
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831082; cv=none; b=XkyWr0sdBqQmEGcDih5+0ZsMDLviJ7w2Pp0muDTslGcNugClaw0jFMwDC4agQV7qPwwPCH6s1S3TvcG0mY4LPsdPVp5D2tuIWt7M56azqfPJR+IVNDkUs8T0DSnaSbChrVXPro4etYIHbkOyRAhrZ0h9zdb5zBAmkVagspwwjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831082; c=relaxed/simple;
	bh=TGZhnHSwY2RuJE3MeeOvRjFc9mXHIanOjRGMrEgAqDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxdwaTrlcqCdTNbHKLa5/0Jdohw5lKyumozD9ar0s6JBZUjVlmY54Xi9lQIxxQpr04GNiCElN7xiwhNXG/oyzU2MjwebwueCX7KPmyM1zNFzceAWrAgk8OQe+2VOzCA5griHo0eUjXzjJWYxM/PT0bf3iUYd/7k+35WIbWLVJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnBuOUD5; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnBuOUD5"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fd1b2021fso1425685f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785831079; x=1786435879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zZH/JzJQt1Dlvisg4wD3sULSMRuk6IrfV5RudZtE3Eo=;
        b=OnBuOUD5i4bgHV6NBbcZVF3dDPeeusW5YGQPASQMS2ovTLnZX4I7r+SD+CwPT93rwv
         dtIKkjcIhM5/dBePe8+SOT6+6VCwAZ6oOlgPxN5v10iz6uydCfQUNYNEGcgowbnlfYe/
         mdUVSskJ3ydjrrIGE/6ZdI/u2X/ZcSr2gRjD7uBd7hmjwB8gkI7GTfPVvkvsMpEcmNby
         Kv2qu+L0N3z83xZA9FNHqSoaGqY37DjRBkHXovnQhW2d4zd5jm8PdMU30uSn4yRitGMF
         VB9iGNSyQm7zBJkoU52icpRC7brmP6HWmd/vegK5BSwiT1XTyNXJ07Veaa4gRXrUBfwJ
         PHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785831079; x=1786435879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zZH/JzJQt1Dlvisg4wD3sULSMRuk6IrfV5RudZtE3Eo=;
        b=dIk+bENwMO0kcD8zovIS9jZGua90Ik65+ykidudQeSztPZ07L+ZM4a+WSzI/jk8ltr
         1Ahraxr/fGaEEFO48li85kp/sxoZOtH8Xqp/uVGPHfPN0Tpm7f2K4SNyiJif1xXZZOXB
         ZKTQ9CmO+ZUCqA1k7dBRVIDbNXkZ8lOEeKsBMYyk+9Hl878xdqtfqq7tUvhMHQ0FWCqF
         lGOFPEIa5OEMwJBsFxqQD5qdF2XYVXBzykbtSfiaMBb18cBN17bdMH8YRakK7zjpEMWM
         72aj2cw29dfiOY/pSyNhGTD+e2oa6mZ8yUuymCLqrm7lb34Y7FP7/EAcElDGmYXeb5x/
         wYmA==
X-Gm-Message-State: AOJu0YwOHnRY7nEiEUSku1QEUe8DOPZH7Kx2yduOMH4NiXcjLmKe38z2
	25tLFEjSzZUKUG/6UfmXthhGD0bYV3rf3TC2MEm/Vx1Yi9b72StulXHzGg7K5LOf
X-Gm-Gg: AR+sD11oGnlTrptKMANyer6sNuGs+DgI1PgPlJlTQxpcMoX5jrYAaeWGuMZJO8n18wz
	JnkulaIND+5O1QmWJ0bRgz9Ki4XhB9C8hfvoqju5L8OtFcypmf4dcfMIacJOON1wN9O0S9SEjFT
	gxlWGwyr8qsxbTzwp8TTDDNN0eoMVe2AOo8urwkXKQLVONntMH2IaHwRA0Ec/kjZ8Nv+s83gCR3
	3aEf4ewkCvxZOK3BVIkwYmm70nt/eNxB+RfcrOF7iaAm0PiKkjeFbpj515XZ8p+eiTcnQwwwVnw
	LWq3ijW+vLczecbKFEkF2l2GVdkgaHhetk4peyRbW7JShI/7PFgPETvsAhiVo70S3KobAE3Ewn7
	GdKhj/n7v5NIRusLnLOFjML+trw/D8sXRXgKxbEyZSv6V8DGdvyEI4PFLlADdSt5M5UOdCXm7Fx
	diMnL36Zm8i484k6DfPOGKbTQPFbB+rIss4JiRcAEyGmhiDlzzSWoff2noBYy8iiwO7LaZJKEGO
	mCZaTZL0GHOSFgCY41JrgBBzDQrrGaJDQbASqb5ToqAII6L7U+OKXQ4Ca4j24Bb5ncyFbVTAF5N
	m3kh77eM1B8IJHYNX9Dq8ofGrsw=
X-Received: by 2002:a05:6000:25ca:b0:47f:4dfc:ca1e with SMTP id ffacd0b85a97d-47fd9b5659emr30165146f8f.5.1785831079057;
        Tue, 04 Aug 2026 01:11:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6besm38854024f8f.22.2026.08.04.01.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:11:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Test stack depth stats without BTF subprog names
Date: Tue,  4 Aug 2026 10:11:12 +0200
Message-ID: <20260804081114.3871564-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804081114.3871564-1-memxor@gmail.com>
References: <20260804081114.3871564-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=memxor@gmail.com; h=from:subject; bh=TGZhnHSwY2RuJE3MeeOvRjFc9mXHIanOjRGMrEgAqDw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatwnl+EpscbScmtRQEVIR0P1Z1L81YdmLD6hOCvg/Xc8 b7OFjodpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmEjNRkaGaY8fbb2u+Ssmzo7p wo2CA6ce3fRLvG1hXSRnIeZS8Kj4HMP/oJnytztdDuWFB785NffwOoZNhwJ1ZBbkJ5n5Nzbb/T7 DDAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Test the per-program instruction and stack depth statistics emitted when BTF
function info does not provide subprogram names.

Make VERBOSE_ACCEPT request verifier statistics so the raw-insn test can
validate the <unknown> output without a test-specific log level.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c  | 2 +-
 tools/testing/selftests/bpf/verifier/calls.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index a8ae03c57bba..bffb7360434c 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1560,7 +1560,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 
 	opts.expected_attach_type = test->expected_attach_type;
 	if (expected_ret == VERBOSE_ACCEPT)
-		opts.log_level = 2;
+		opts.log_level = 2 | 4;
 	else if (verbose)
 		opts.log_level = verif_log_level | 4; /* force stats */
 	else
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 8cd626e04551..6bf9ca5c5600 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1091,7 +1091,14 @@
 	/* stack_main=32, stack_A=256, stack_B=64
 	 * and max(main+A, main+A+B) < 512
 	 */
-	.result = ACCEPT,
+	.result = VERBOSE_ACCEPT,
+	.errstr = "stack depth max 352\t"
+		  "prog (<unknown>) insns \t"
+		  " stack 32\t"
+		  "subprog 1 (<unknown>) insns \t"
+		  " stack 256\t"
+		  "subprog 2 (<unknown>) insns \t"
+		  " stack 64",
 },
 {
 	"calls: stack depth check using three frames. test2",
-- 
2.53.0

