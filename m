Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595E40B6DB
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641261; cv=none; b=qflN5b6o3aqrhxwb9Uk8+XIBzCTwZkScXE7oAjagjoey2k7h31n1v1XBN6OcgG4LWMkttxpbrKj+1OkjWYBT7sF+0Xo7puPQq/LbQQvAYOGcT7xFjNeIaAplAQ/tyf9H0Giu2SD/ib9SCAGNqhzevYdN+WSP3Wn/GA0aXF2jQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641261; c=relaxed/simple;
	bh=8mFIZ3HOqmMv/pHMm6keWKsMwAwnsh6mRAhnF/eJL1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVy89SoVIH2UqjgFrJhtMWovGANVhNENfTyY71sz7X1zLEGpuyYjEDBqhNvUVc1a5P2NRYAH8Ubm8hayJqUFQS2PWFjtqf80VUbzMxUxMkQWm8yQ8jjX7i+Kl20DNpyhb6gsaH943QTwgiM+U2aJWhk7eFKZNKagF7AqEJ8gIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erQd6/Ci; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erQd6/Ci"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490b7866869so17743155e9.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641255; x=1781246055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nb401KMtNRHidGBJRlK7lutyU3Mg46uMACm5c9L64Q=;
        b=erQd6/CioDQkOk0UnloHvJ0YggUqkBKYjkJrGPaVz26G52hSlJYOjI6BbA+dkWimOX
         QR0EWbXYUXOc8xF6cNbdA7/mrt76ugVFd0mgdyiQg+mpcOgiQlzkIiscsXBDWxFX6NUS
         pJOcsB8BDv79w2cz1Xh7zHmCWwnTFTrW+UM0lQcX6tuV+7LiFHgsEvtzDPM0NbvfJEu9
         Pl50wnjWgAUU1VxYe7E+AiiJ2izayEGW+1uciQno/A3J3PEQqLMAOlYVM6lKwFmwM8Za
         JxCoNpzos3rrbNa7Fcx2nnUn3ptKfrSxhdnwy1N+oc7OK33hmiMyrziJVnlp6eXkqrim
         hohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641255; x=1781246055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/nb401KMtNRHidGBJRlK7lutyU3Mg46uMACm5c9L64Q=;
        b=FqwzujNu8fEriy/TUulCV0yHc1LfSZFJsdPuN4pGTeuvAi8zkZDY3UZSP+wasyk46V
         qB6FGEaeKqlnMuFL+nXT3b0Bfykfw9+jnwwMlNLMP3jWB3bJkXm+OsfsK4EBrUCNkzd6
         VGNUaqxdeI6xBUODZolZVvYD3GMRXtgpnm4bCRzlaLFwI74gZwC1PSad+sKlNoU5/rud
         6y7B/GTKD3ZBFaUsBjLUfNCd5WHgHwZBju9sLm7V3rOrTerfMrdv8HXOeX80o5yr/TWn
         Ljq3245wAYq60WUKf3ShmZycBLAgF/de1ggkOPby/NworZw3NzaUjpqhaS4NkvQ+qLkQ
         otZg==
X-Gm-Message-State: AOJu0YzvNPoiHiTC3f7sudMFBWNxDYFYP0sNu1euYWSFAylX9NDq8ayJ
	/G601AQv8VWFuro6PaCF+wE2ESgDMMyaDXUJwUO9rsWB+Cvn494HU4tMKWf4Lb4f
X-Gm-Gg: Acq92OFkSS30tRlyvKoWbnjus1rF+znt8Vvl8SihKHCtn44dXOLr2UkLwv2ZDlSRNwz
	1DvUtnXM3rFJryIp35V3j+DZP5M/FXgeFlk3ODH2nb8vXwiMKYnu5aD1xWIgPHmzSqP0SqsppNi
	8fbKMxJpKhfs+2qUMf2KRPunXDtN5u/9UejGy1E0RSJ815guoVR0le3SSaFFP3gLKyzy5XSXCzQ
	u71NJNMhhXoBG5k77F+u5UgjOdoIn0D5v9hf5whz+2Xm07hg0Y35dMKjeWMrYQXvP39Tcf30q21
	rRlhJHV2Dp92c5K8I8YT0T0sPlfPSab3OIwbh/hKUk05+xyaGqDkNV2UJH8q9nx/b3UnkJetOv9
	c9iWX0dOfrRJy/qzet9tXRIFUNh8uKjXAv5HcKEVHxxAf4i6+EmNdn97Mv+Gx7SZJOaqZZLYQpU
	/qlOqVeXc3I1LWMtj+CjLaOth3Vmy+rpzWqo8XMb+wSMD9Vn4/BgBoji7zemSP2wjn9c4OwoT0l
	9P4nCGMGfbErC0JdbpqEZDhBD/EhCuLHBuA0WwuxWrkXpf+I1e4Afg06WtcaueDfllptvMZRKp7
	4lAHa869F+c=
X-Received: by 2002:a05:600c:4ec6:b0:490:b780:13f7 with SMTP id 5b1f17b1804b1-490c2631c40mr28649985e9.23.1780641255281;
        Thu, 04 Jun 2026 23:34:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm23092494f8f.33.2026.06.04.23.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 02/17] bpf: Define verifier diagnostic categories
Date: Fri,  5 Jun 2026 08:33:52 +0200
Message-ID: <20260605063412.974640-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3410; i=memxor@gmail.com; h=from:subject; bh=8mFIZ3HOqmMv/pHMm6keWKsMwAwnsh6mRAhnF/eJL1E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt7Do1YEXnR8PfNbk8V0s9137sKad2u8MzkjH295vv 1V9MYrrKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwET6+Rj+ChiKRVvynZV8V2rn ZPzIhvvdtqCph93vV/AdEqp+K/dCjOG/c7B9u4Gu1qnnCy7bWArdyOPKcnwUGW9q63k6WcTniQ8 HAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a central enum for the verifier diagnostic categories used by structured
reports. Keeping category names in one renderer helper makes later call
sites choose a classification explicitly instead of formatting category
strings locally.

This adds no verifier call sites and keeps existing verifier output unchanged.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 32 +++++++++++++++++++++++++++++---
 kernel/bpf/diagnostics.h | 15 ++++++++++++++-
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index a6684adc0c31..d9a103cf3a16 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -68,8 +68,34 @@ static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
 	bpf_diag_print_wrapped_text(env, buf);
 }
 
+static const char *bpf_diag_category_name(enum bpf_diag_category category)
+{
+	switch (category) {
+	case BPF_DIAG_CATEGORY_MEMORY_SAFETY:
+		return "Memory Safety";
+	case BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY:
+		return "Register Type Safety";
+	case BPF_DIAG_CATEGORY_CALL_TYPE_SAFETY:
+		return "Call Type Safety";
+	case BPF_DIAG_CATEGORY_RESOURCE_LIFETIME_SAFETY:
+		return "Resource Lifetime Safety";
+	case BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY:
+		return "Execution Context Safety";
+	case BPF_DIAG_CATEGORY_PROGRAM_STRUCTURE:
+		return "Program Structure";
+	case BPF_DIAG_CATEGORY_POLICY:
+		return "Policy";
+	case BPF_DIAG_CATEGORY_VERIFIER_LIMIT:
+		return "Verifier Limit";
+	case BPF_DIAG_CATEGORY_VERIFIER_INTERNAL_ERROR:
+	default:
+		return "Verifier Internal Error";
+	}
+}
+
 void bpf_diag_report_header(struct bpf_verifier_env *env,
-			    const char *category, const char *problem)
+			    enum bpf_diag_category category,
+			    const char *problem)
 {
 	char problem_buf[BPF_DIAG_MSG_LEN];
 
@@ -77,8 +103,8 @@ void bpf_diag_report_header(struct bpf_verifier_env *env,
 	if (problem_buf[0] >= 'a' && problem_buf[0] <= 'z')
 		problem_buf[0] += 'A' - 'a';
 
-	verbose(env, "\nVerification failed: %s: %s\n", category,
-		problem_buf);
+	verbose(env, "\nVerification failed: %s: %s\n",
+		bpf_diag_category_name(category), problem_buf);
 }
 
 void bpf_diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...)
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index f13a939722bf..8bfc7104eeec 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -6,10 +6,23 @@
 
 #include <linux/compiler_attributes.h>
 
+enum bpf_diag_category {
+	BPF_DIAG_CATEGORY_MEMORY_SAFETY,
+	BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY,
+	BPF_DIAG_CATEGORY_CALL_TYPE_SAFETY,
+	BPF_DIAG_CATEGORY_RESOURCE_LIFETIME_SAFETY,
+	BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY,
+	BPF_DIAG_CATEGORY_PROGRAM_STRUCTURE,
+	BPF_DIAG_CATEGORY_POLICY,
+	BPF_DIAG_CATEGORY_VERIFIER_LIMIT,
+	BPF_DIAG_CATEGORY_VERIFIER_INTERNAL_ERROR,
+};
+
 struct bpf_verifier_env;
 
 void bpf_diag_report_header(struct bpf_verifier_env *env,
-			    const char *category, const char *problem);
+			    enum bpf_diag_category category,
+			    const char *problem);
 void bpf_diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...)
 	__printf(2, 3);
 void bpf_diag_report_section(struct bpf_verifier_env *env, const char *title);
-- 
2.53.0

