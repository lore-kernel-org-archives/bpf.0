Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6CD370D61
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447381; cv=none; b=BUqCMPDfEdxO5+niOQrDtrRZIVXiZXaNLabVyYK4EmMIltNmvGg1b0ova8e2H/J+uJmeigGmIsIyX5Z3kbCs0BCydvHlQbNw8GgVJ2TekUUCnvkpmwnK9H9m/gx1nPPI2dDa4Zwic/DJbFIBlxv/iU50uh9x9jEpDqZEvXTjARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447381; c=relaxed/simple;
	bh=h+B7Qg0HlW8n8JKdcP4s0noqZmQ8rg/w882lMkjds6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIoc9jSu7BCp3dCrVQuip1cH6OcDaBvVADQgK663RcQusgWwjYzOZTuu8u77Im+tzNKb6At8eurOnQDwt+MSGrON9FEtxMfncrPxck2iR9EkyBbWk1AYSyHfgxHDBgrlC8OfmdYQTTyEDx8IRwhzeHuI4TJQ241U8ZGAlK42m4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv/9W1of; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv/9W1of"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso30799925ad.2
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 18:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447372; x=1788052172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sC4cmVAyzCBkeVkGL2KoW0PWLik78rhv/g/hr8wEP1M=;
        b=Rv/9W1of40ID9j6WZL+LSrktLgFvMkCFSV4T4/gyV2yEDw9XeKA210SENqQlbyUk3x
         3YDHW48+utgAXMFaXqDjPe8tIigxYhGSFhXDHqSdE9sVgsOb5jZpv/nm/+x3ac+jjDbt
         O2Qe/SQ9l5VoTsqiUObLLAX65beuTr2yxxENpUYY7RfI5fYVZ+Gv2m2TibL6bHgtRRFs
         IP88od0W/PGhJhL6zgHtDcrTGL3ddFKFUCVHbsDfZtSroUbyeOi990RSkAJkm694dH/M
         1eL5ytwcrhrFJuLB2VlaWlNW7gGclHSlNTkHe5Hcwp8bSBlNKceBnC2zrdwhhNI+9tyD
         +VbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447372; x=1788052172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sC4cmVAyzCBkeVkGL2KoW0PWLik78rhv/g/hr8wEP1M=;
        b=n0p30ymzbFX3KkU5yBokP96BiyuxiYLiSjc+N7m2QtslNn9/hnRz4FAyPWrvqLQ1oN
         TSQv4ve4/FO67iozDaZ/+1YKYFUyeR5NKkbHqsiNh5nwcc8Lhc+8MJEn7zQB4r3qwrLh
         ClQBEWDJ4x0X+PtDN5mFjvwPPvyAPtckG6q+iTdlju7VJBfkVpjMlvqhZgY2tvSx5hLt
         T1uaGS1V2jxa6IQyyFheN5DrE5V2haaFX5FswVkckHVtrdoeNL35Hb5As2SOJc9pEH/7
         PsC6QQlPd1wsQzn4cER6HLiJt0MCDyfI5zZ83nS6Ta3IFgCRx2LCKGiAa5XPIlihCp46
         G/fQ==
X-Gm-Message-State: AFuF++n9C99Sf6Ciqu2K9CtvI4qBsmcOngIX9EdnMjNoqO93qkOH5vM3
	hyrauWDPx+TVfA/KCG/5c2FmVkxZDRISIMdbKUC6LHjFTv/qduqilbSmEiiQcErg
X-Gm-Gg: AR+sD12F9MgZ7yDDE+iwtIXHrdR6YpJ+Csa8n2XxgO0nXlO/sgOylWfy+5AFAuervZa
	M5vU5rJic/e0/hReameCG773sihr7mIO6XnEFXhHJvrIXocjF9uu6TVw90ibtvB6nvjENYHU25h
	XbUdFHmzVQESZRQAzTFmtXcCsIW+C102DzIK7FigUep7AVQj9rVq6079GCvt9zM9S194kGLe+vv
	Wl0ID/wL8l6aLnoRLy7ZIQKN0B0SUCIq9qE3nB4bxwWqzaUWj1Qo76ByWRqWfqHb1zDUZb1JI0H
	52rkm5CKQoWXObhDTel0CfGewvfllVMAgpViAqDjBwI2kVpbzPXvp7DdST/rZZ2yyHZJ1L1crEW
	LZWCl3UexeKCNC/LbJ52RVP0Nm0dRs7TBnjgnmcTTa9sks57mqTIS9o/B9GrKdV8L1WD4lh5q2P
	Xn5JSLjzI6784i0anPE0KGOudt/2Myw6A3VpkHP4jA543HBkh9ywC2gcE+Wk1O9NEE+xhK5qUG2
	1fcgl5yQ2PTe71g3CiOaaxHAOA7dcF32ZVBZ/y8bUJv5miiBli18uw=
X-Received: by 2002:a17:90a:c88b:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-395c2f4b17emr32178803a91.0.1787447371076;
        Sat, 22 Aug 2026 18:09:31 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm4219994a91.13.2026.08.22.18.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 18:09:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 4/9] selftests/bpf: generate the signing key and certificate once
Date: Sat, 22 Aug 2026 18:08:55 -0700
Message-ID: <20260823010900.1730708-5-nickolay.lysenko@gmail.com>
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

$(VERIFICATION_CERT) and $(PRIVATE_KEY) come from a single genkey
invocation, but a rule with two normal targets runs its recipe once
per stale target - under -j both runs execute concurrently and the
openssl invocations race on the same output files. Rewrite it as a
pattern rule: pattern rules with multiple targets are implicitly
grouped even before make 4.3 introduced grouped (&:) targets - the
same workaround the test_kmods rule already uses.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 04eea6ebc75c..d30f2e46b136 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -789,7 +789,11 @@ VERIFY_SIG_HDR := verification_cert.h
 VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
 PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
 
-$(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
+# One genkey run produces both files. A plain two-target rule is not
+# grouped - under -j make would run genkey twice concurrently and the
+# openssl invocations race; the pattern form is implicitly grouped even
+# with make < 4.3.
+$(BUILD_DIR)/%.pem $(BUILD_DIR)/%.der: $(VERIFY_SIG_SETUP)
 	$(Q)mkdir -p $(BUILD_DIR)
 	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
 
-- 
2.43.0

