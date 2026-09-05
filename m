Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584F1B142D
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788572863; cv=none; b=XwjMCWvq1GkasW7obBTzVYR2w/n78SEs//X5MrZfFA/rKwF2CaO/cRsx/a1EzCvNiVq89PpNkmVBHcM/Se45qYtN7ZwBpP4gTN2+l5ldDdc22EcyjkKLiF4/jGsQfI/UklgYqXZkN6JjkzmQxchhdIBDLEzZtgd2lKtS4vHdk08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788572863; c=relaxed/simple;
	bh=5Vl68cLSk17WOKZkzuFTWkE0n4TXHgPB3CLIwp+oyKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXqs91dlQAfq+MtYDNq7B0lOvrykkDIfzxUDD/uwR42iBM6TW/U0VRzECicL9CF46wsS5pOLPrmRFyExzE0VB08GxOxwgRr7tbnzkjERKAWVf1Z/fTVl+GdFf3HVsSqrMp4SJ4k2lNjPrdXvjRjvKqQikfxHr0O/FZiTtXGC5w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHM1/uzg; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHM1/uzg"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so373851f8f.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 18:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788572860; x=1789177660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KB8h8EKiK0N6LMXrkz0qPqvNXCo0vH4Cr3p+nCbfQJM=;
        b=sHM1/uzgkwUhH6OjDSYoYOo1B0tAnkAuguCXKz/hYWB3S/pEJArleYRe8ScC9RHSjP
         oUafkEPDggVc632phdM5KaSDoESev8XMbpqbN6wTd8+BDjXFWXcrFfkqa4wJD+fpucOm
         9GQoD8Gyeipci8nc+A9WrXHC2gIBIrjSRfxb9x5DsSGYON+TbSiJ6Sdu/AxiBhSSjY1V
         et0cmyiY3Sefqra+of6bdpdtZSshHWHMb3l7PjmfZ2bqakEnsWXC4fAw5Xs3vpmEg14S
         0X5TZaKxUfomWrPQYOnpEOrC5XKopXi7UP3kKNvzRvSwVdmYFvShE9V9J/EosjboUMh0
         ViIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788572860; x=1789177660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KB8h8EKiK0N6LMXrkz0qPqvNXCo0vH4Cr3p+nCbfQJM=;
        b=JJN28KQrI2+EXsiffirEJ/koU1gyq9V9nhY1E5bM8fLYsBSG3FQHKRusu+RF0kpVDv
         i+bePY/ODI3DZaqskeqejWC0uJKSrM5Ol7VL10P8m8bdLN3KiuatrFpc6Svz+nWfNeKs
         zJIy0zVDGZZHxyeSVeOHe1iyiD0/qifShQzkhJSrQShsA2b+mCOtjGhCaB6co24IQJhd
         OxqlATPQkALoKcPkDCLoAebMw5M+EKSw07JTVEzI4T5VHNNjWM44k3CghHn4J4qhdKPm
         UPph+/OSKl1MXdne6JzzxbK0gFr9XURX3dLhSBnnYRPp+ndIHKh6t1DFz/QKaNdVgA90
         No7g==
X-Gm-Message-State: AFuF++l92kdsB7DZS1Abpj2G5i9cQ5GMzQ0C2msVkNH8ljZ8XW9uz2RA
	e84Xc3nb0k9TVqcoND2ym4GAz95GQmRvTpprlUlvwxWz574HQ3zND8Xl7lJ1qilb
X-Gm-Gg: AYBFou2oruec0KqY7vSmdKMQPqywTVgmfI7pygeu+YhLJtQ47soRLkcfjovwRf2rS65
	jQdTBhD3PEQqJAdbWHpaG9mLnYcgYTitKEUbGyq2vUTeI8vfMmsZR9vlqbCCN1N3ckVTlgInWmQ
	siTjw23kER4QzmeMuDySktiT5hq3BHQtuuQsJoy7wvFyHidWLOa98VGH0VBqAR1+lRBL0NNw9Js
	xo4kse/io8bVsqfLx4txL18PbXLQoHB3hOtvyMA8GTrnlvdFP6Ob9lYTdhY8i9V9H+tdXw0pZ3T
	sYmsCEQh1zMe6jkWBGsBZzc1pyqpW5b/h+lOe9DWeYdT4TJVMBrTxi6q0mvXzGAPNuWkw8jjYLf
	ZMlz453KoeuqdJ6TqpNgm1tijEHRKPPAfvjyByuJ7cpKrVYonlHloA/a/pekeYJF+/1H4XQHHB+
	f8fnmKAYXfdA5W6zfGnpXYhGeYGy8QhtVDJCnYHqIteZgoLoA+ehBiwg7nxFqbjk5PNVITrdl75
	tsx17K9IPCujwZxF29bGuLt43akTBvCVzqs8Bxs1OMRvAz2D/ysB7+Kw5CdAjcaxaV9fgLs07p3
	AjXZtaVg+FkPL+Mrsz+kZfrEeGQ=
X-Received: by 2002:a05:6000:610:b0:485:82bf:8728 with SMTP id ffacd0b85a97d-48586e32b7amr12703808f8f.0.1788572860140;
        Fri, 04 Sep 2026 18:47:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859162f354sm1621482f8f.20.2026.09.04.18.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 18:47:39 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/2] selftests/bpf: Test pointer bpf_loop iteration count rejection
Date: Sat,  5 Sep 2026 03:47:34 +0200
Message-ID: <20260905014735.1452988-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905014735.1452988-1-memxor@gmail.com>
References: <20260905014735.1452988-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=memxor@gmail.com; h=from:subject; bh=5Vl68cLSk17WOKZkzuFTWkE0n4TXHgPB3CLIwp+oyKw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWt2UTZfI2Ppi69nDl3umf+dZc6GOYXPzRv3KW73KediX dbm+lq4o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNhF2D4X7cuf/O1jpuzvD5t emqX6q+/Re+UV9+2jO2z+MuKFbamGTAyNO08mXRcsu9bNTuDTP2ds3p7j/YEnGT5qmXw8NXSglw 2XgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a verifier test that leaves the raw tracepoint context pointer in R1
when calling bpf_loop(). This is the smallest trigger for the incorrect
precision backtracking: it reuses an existing callback and needs no maps or
userspace setup.

Expect an ordinary scalar-type rejection. Without the verifier fix, the
test instead reaches precision backtracking and reports an internal
"backtracking misuse" error.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_iterating_callbacks.c    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 75dd922e4e9f..1fbcc5228306 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -168,6 +168,23 @@ static int iter_limit_cb(__u32 idx, struct num_context *ctx)
 	return 0;
 }
 
+SEC("?raw_tp")
+__failure __msg("R1 type=ctx expected=scalar")
+__naked void bpf_loop_reject_pointer(void)
+{
+	asm volatile (
+		"r2 = %[iter_limit_cb];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"exit;"
+		:
+		: __imm_ptr(iter_limit_cb),
+		  __imm(bpf_loop)
+		: __clobber_common
+	);
+}
+
 SEC("?raw_tp")
 __success
 int bpf_loop_iter_limit_ok(void *unused)
-- 
2.53.0

