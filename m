Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549093A9630
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751158; cv=none; b=Fv0afyS/uijIMz9NvIY6f++Tp/V0o239OlTRnV23WEJmWulVhJpagn3dx4WnWO+b2Dy9HDfL2arqoNgkL7UxpaW26bVwWtTnRWMaWtWzb4PUzor0QdXypuzvm/g2cdsbUKM7uDuBcTe1D9Ou1mDSnnJYrE3zXaF0gDDF6L7PLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751158; c=relaxed/simple;
	bh=PhCveEiZIdUmcGwyU5spejpP9AhnWoovrQrg6qXZOwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODJIE7YRIvcDYG9tJ+WuHVqhjflM4H89SbJ3xeqQPnMBwVKwxmLcTTk4SedajnXFMUF5yXAxrtD5YQUekCkYJgLEzsNbodN67ZH1xAv3orO/QVytf/jMFslAiBk2g5Vve+74YZXKxYDQ2gdPEFP05kMvssB2mKwy5SOYOFacfwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKllLdfo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKllLdfo"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe62837baso4071881f8f.3
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778751155; x=1779355955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi50aH0ofyIVTmJunsbTWM1jEiSwseuTv8Zx+hC3coU=;
        b=SKllLdfoN0Y039PhFkLl9oTbjG8i/6bFqAK1ersRlrGseyUNRaCnIy9+QWfDVkY/f9
         BWFii5iiQzPYcVx/xkhRJummjt7betIPkydGzr1pVaC3/qIgPHJhb46KsgsMBZEvoN01
         kHbwJ/ogyi+E1e7WEdXPZwIKk98z39/WjyqvMfUCQGAQlvZZUYxWC03RNJ5OJvDFzXzn
         ehYj5rxpQFFL1Ow1mFV24OiAPiT4qe9h9OwK6a2fV00tOSS8ThAywAsaZ9QYCCSg+EoE
         KonrDqzE4IVe52SzdJCAZ+gG4D5p/7ugJiEOL8eeD662zovMIPy/N8Y+r/RCESH8HgAl
         IG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751155; x=1779355955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qi50aH0ofyIVTmJunsbTWM1jEiSwseuTv8Zx+hC3coU=;
        b=G9tSVIYOa0hBvtOTnex8rQmaD7k58aBoayZS8qKkVDvmEqBl1sPmER+wNiK8coAJfl
         r4wI64IeY/EQIpo3Iafyzt7HbNrI0AWgqrC2FEMD9BRHwamJUJ1YBGwiRmyJ9hUfuh4X
         OHU2n0VxoyjmRrC92xf2ru6HQIgxnJsaSdy+THcby2dc8KLAzM2Bi9WC0nALCn/Esx02
         +DDFsCuxfi/7xxNzbxNnvXzXziAo1maI+9HN5x1mypjtcvOll4yOSldx/JMPRXKCH2EE
         BhvRkjMb3EQf+pcnYYSgIM+wlLsGdinoZhnfF0zLon9qPUw6hmGTu10Lwzvp3jc5pMn3
         5fFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qSC8JNp0GTWFy4Sk6eyMHVqgCqKS7ZCUuUJPknjmiSD6FT1RhVCl4DHEd/Hf3zgfEDD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFSioXm7G6tc8vOe7fNfL0yCAtpQLHefpuTSvpOuOC7c/4zoO
	j2V3WpHawVhQ8zwQ2jnAERBvZ5j6FtMilhiT3EvuxQnBD6wKEqG17vnvMChnHUkFXkA=
X-Gm-Gg: Acq92OGybnNMfzJOx0MBG+btvPYshhsBguCtFM/PBoVWQe6e+78UKGKcKVPX84F4r5u
	nH0J+9bmwe6d8zK53dcnnHVT1PgyBs9cNomd43KSBqskNMtYwihNMu0lrmqioBAy9Fh7MiAH1k7
	Ia4A96Bo7dezLXQLdTxIqOPsEAiNR+SyeALuwWeuaZ0P6qIpg9ifFNOP2rdnkjopB7aFONoaOLH
	5cEYHYkh2SNTYFHMBcqWi5CZF4D1zz2LdyMOAvH6+Dt5ZlbBoDjdfRF6I0iW5HIDehuGSTYzrvZ
	IVpGxTMM5RwCQa6Yu7xczEK6zxh3Zfx0/vBV4OCfRe5icF9UjjAs+mNl02Wujbvg3mapl6puZph
	VqJNwatPlSIYB5gXlg01NWwWy00SjZ2jicVlN5AxpeHfpyj7ciKL8fRBKyKwZS7A4zRmJAuiyUb
	BckDpeHjP1L199/Xh6CFlZL3Uc5kqpdpqt
X-Received: by 2002:a05:6000:2882:b0:43f:ea91:63ff with SMTP id ffacd0b85a97d-45c58a70c1emr11251761f8f.10.1778751154951;
        Thu, 14 May 2026 02:32:34 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm5097164f8f.26.2026.05.14.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:32:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 May 2026 10:32:10 +0100
Subject: [PATCH 3/6] selftests: Remove unused LLD variable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-james-perf-llvm-version-v1-3-6cac1a9a4c8d@linaro.org>
References: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
In-Reply-To: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, leo.yan@arm.com
X-Mailer: b4 0.14.0

This file was mostly copied from selftests/bpf/Makefile, but the LLD
variable is not used here. Also, this copied block didn't get the same
fixes as the original one did later.

Remove it to avoid confusion and so future fixes don't have to be in two
places.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/testing/selftests/hid/Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 50ec9e0406ab..96071b4800e8 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -105,13 +105,6 @@ $(MAKE_DIRS):
 	$(call msg,MKDIR,,$@)
 	$(Q)mkdir -p $@
 
-# LLVM's ld.lld doesn't support all the architectures, so use it only on x86
-ifeq ($(SRCARCH),x86)
-LLD := lld
-else
-LLD := ld
-endif
-
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 
 TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)

-- 
2.34.1

