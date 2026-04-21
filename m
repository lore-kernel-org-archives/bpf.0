Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9D533D6
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790245; cv=none; b=WBxlfRdUtcseLWN0eB6Ne6nMpBIZvt6eDLTP+CMWy+uyR0U/BNdZodFqbEo71bncskh4wCtCoTpJPslaGYlhOTgosLE6OcKMeR89rgzG7TvQdhnmF2YXSogqRzpgMNKXXrNOQnpfQiDWwNx/lVuI5vamceR546AvbQqNaqVVtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790245; c=relaxed/simple;
	bh=rBtoOP1wfOoFCRc3E8mp/x0O1yTQYvgg9UBrMFCPSjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtoTdLqpK9TLx9NDgOT8/Zx29ppHpYn4hVa5Jk7Tydr9I82HPJrqs02msCLHfECugDFybtIB9ZZmn1Woy33MiosvXOY6PKwNDVpJ12+y7pA17AeyxPAJkY0XtqpSPKBN17bpGiGwytRY0UWUbuFwPnUW4ND8QKAVyJfqt6tAjZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gnPeg0RA; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gnPeg0RA"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c8f9846c8so3164270c88.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776790243; x=1777395043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5u9WyiowzM0NvNfH+UAyn1lL339N+/bgkrOmfuAeTo=;
        b=gnPeg0RAbNgSYsVily0odEn5qel+rIfzbcPgwpzhKr1OhR1ec6xL//42uA93HQDBz5
         6kii0+eeA1AfPOOozoJ3L170dvjxWT2d2UJTLj6mgz/6THOrcQaUs/di+rqCKqXpCTxL
         2zc44KX0NlAHmC9TkTb0S2rop8+tXb3UcBm4ZNKg6Lp+28xa5B9WsXY+4aJNn1rTs22T
         kOumvwiYX27KGrqZSx0wZIbm7JTQIFTvKiuWM3w3gtQwCTTaea7DQXeOggFJQPFTKlVX
         6csvxO2Xyp5eRgCkX48H5nMXnpsMOe2FZZXDzylMrNR+i4n6fzGkt0noh8rVaZJiiWSX
         qhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790243; x=1777395043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5u9WyiowzM0NvNfH+UAyn1lL339N+/bgkrOmfuAeTo=;
        b=XHy4UXTfpg52WTm6m3HfaGiE9Ubei5IHRS2mRAC6aihSVKBa7FuCtkegpvURguzRfO
         eaY/W0YsUt5GSM8FmrLFnIegnlZ1W/wiDz4SQ5EYM/X0mhYAnAd9hEFCbRHH1pauF40E
         5qa8Jlg0etaMRNYkt+5a4pifvf5QQVvof7Of0oiCEsKwMNicrwCEBhM1C3Xs83e4GdiD
         CylgE2ikngHvkvMta+xUdOp2preEOoZzDdP8YUDuFpnhq8cFEe3dXmsc76DUmoHN/wwV
         dLQsSbml5mbV0xzQoL/cf+Y5HCd3eBbeW5u4sc38tGeWy11xhiJr04rrd2Om7Q/Qj82Y
         Ov5A==
X-Gm-Message-State: AOJu0YwRaQY53RpqZcMiBrlDvUKXGQM3sHxIKceSuJUM9/kReYq7F6u+
	GQb7JGdNzrdHhLbmGeoSFWBIOzRgE25OLHWuaKq9AgxPP44ii9gWtBDLPJ2t/nl7K63rB/NGKAN
	fmKwHWjWNM+0z
X-Gm-Gg: AeBDieu5t3lxWtKXu198VF/YzfM96mzLmXi9SIeFr+lmh46CrpSsvxuY8XDad3rwupa
	WVMoW50loSkl/rJMdfnG2DX8bAgQ5KFyV9yfpTL1TyVwrSaQIy84VbZqVjAmdVcCZZ2pQvXzJxL
	41XxG2kRXS7TWABiP3Rmi4oI6YcOk6cH2UsQ6w0RGv0rQ9VCiq1fsLd9mkA4USzqDk64WJr0rFj
	G5yHE6HcgUHOMEfEHj4MU/8B2zObQjNU65G3/PPNXD/+qg0mX25BhshDiQOAsp9Z5MgUdCS6CRD
	eeQEIRMtyazia7UyzQ1Mn/REg7Gwm1N5otC9AqlJ4cCvoAkIjCW7c8OjV8mScOEKuevxaJPSlgR
	RVgmLVan28loSFrtv0UN82W68BquesDFCI9zp4gj9IwZSvrt7ZwEtOOlB+jks0bM+lgwXvWWTGl
	7RdlbgKhdZDlocKftG8BWcEFbBD1f+Mg==
X-Received: by 2002:a05:7300:641b:b0:2d1:d434:d022 with SMTP id 5a478bee46e88-2e4521f9d92mr9934734eec.0.1776790242930;
        Tue, 21 Apr 2026 09:50:42 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::8110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm24514993eec.8.2026.04.21.09.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:50:42 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v8 1/8] selftests/bpf: Add ifdef guard for WRITE_ONCE macro in bpf_atomic.h
Date: Tue, 21 Apr 2026 12:50:30 -0400
Message-ID: <20260421165037.4736-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421165037.4736-1-emil@etsalapatis.com>
References: <20260421165037.4736-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WRITE_ONCE macro is identically defined both in bpf_atomic.h
and in bpf_arena_common.h. However, the bpf_atomic.h definition has no
ifdef guard. If bpf_atomic.h is included after bpf_arena.common.h,
compilation fails because of the duplicate definition.

Guard the definiton in bpf_atomic.h with and ifdef to let programs
include the two headers in any order. Duplicating the definition is
the simplest solution out of all the alternatives:

- Keeping one of the two existing definitions is not possible because
both BPF atomics and arena programs need the macro, and the two features
are independent. Using one should not require the header for the other.

- Factoring out the definition into a new header that only includes it
is more churn than just duplicating it.

- Factoring out the definition into bpf_experimental.h requires all
users of WRITE_ONCE to include the header. However, the arena library
introduced in subsequent commits must be self-contained, while
bpf_experimental.h is in the base selftests/bpf directory.

Both headers are moved to the arena library in a subsequent patch.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/bpf_atomic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
index c550e5711967..d89a22d63c1c 100644
--- a/tools/testing/selftests/bpf/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/bpf_atomic.h
@@ -42,7 +42,9 @@ extern bool CONFIG_X86_64 __kconfig __weak;
 
 #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
 
+#ifndef WRITE_ONCE
 #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
+#endif
 
 #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
 
-- 
2.53.0

