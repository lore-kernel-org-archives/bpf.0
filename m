Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9F3E559F
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095057; cv=none; b=nvFpD3O0PPDfORT0lYgur43i8DeSuOEIj09B4HMdWwWV2lM7VT2HbFw3yj4XVi6ULsWguNxtteIUEuMY6BJwL80TUD3NGH8yYHu7e8Rq+1doHxFIK1R7AYEAt0aPTkFbDAUVXMlJAtEPIgije9CmU0mWvASklzKyOswYvdmpzqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095057; c=relaxed/simple;
	bh=PhCveEiZIdUmcGwyU5spejpP9AhnWoovrQrg6qXZOwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaSorf9XwmlTs7uJ8UdhytCeANJp31nV5iFdAWp15CQHAVj8KPllbKXkYBJB3NrCiTFLiFF1/qp6IL1THYmAS6+5uW0OcKnDV6s/mMcxq8GyuseC/ySuUdEWYw0Yuzs1iu2FH6XjRp1d5dzdpeED4h9dh2RaN3hPR3p9VfYe+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oXhACppp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXhACppp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e82c23840so14225485e9.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779095054; x=1779699854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi50aH0ofyIVTmJunsbTWM1jEiSwseuTv8Zx+hC3coU=;
        b=oXhACpppSwkeXkVA3Hcw99exvK/M9DFvoRfTCUberOk9q+p4ISB22bhaC5e2UFX45t
         XI4d6dVU+fh2RgS1Hf4zFkLGUSY4ZBX39yjc+TUQMiEYPqneS5oTC/2GqKR64HJOUGu+
         gt6XY/5VIva4kXvtNbJ7mlI3p8Ln8XJawfPg3SwTZCe4Zdnx/lhWBTvUAyOhMSjROSw8
         jcGfX2MKkGGNDxfRK0kMpksudgq+HaNcNCzmnvJIl5/Cs9AHsML8PTXKmMlON0QHPwUY
         c2O7ItcUMKVM6sPfwEOxA57ZK3a9b8G749JkM6NQxM11uUFb+ea5Jf64w507Cb0n/0OE
         +k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095054; x=1779699854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qi50aH0ofyIVTmJunsbTWM1jEiSwseuTv8Zx+hC3coU=;
        b=p7zVlcPeQR1Dg8J0uZMUh63Jvf7ko1V77PVOy2EOUDwUFuCgaR/rkh7cwYZ9nUuLkT
         387svW1WQ+aafjarj7OrmA8k3Ld7yWAhLCFwWoFE+scAeLHLcqRz03CdnqiLWkhXa2AS
         cpqaYl/ityXUQtxkyMR7y6+sohExvfplR/+to3jrzhtPz4jg+TlTcGdA2cM7/EL5l2QG
         iiHiAQKDLZrUPqfgDvJq7zP18EjZAZyo0oYB5jDGHE564mmqKfi4vbRZjjmy2RinFXlu
         CWOvpqTdT8P3NBvi6uRxaSH2WFc4vSctlsmf8CoLPpFhmc748Ymcl7ctKOda4orR0bco
         R3cg==
X-Forwarded-Encrypted: i=1; AFNElJ8ktWexcbdWTUSbuc73BVZxYPAinrc1W4phqHAKNyJ/8bUDR53dN1r2A3fdxoF+Z6ynsOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8K5izoduyJhRO4waMzGqZ4YlfY38w8ur/EmJFDAKyFrtyaZde
	GdWYPZeqngckCxbAqixv0/AeQFTzD3ti5aGJv65jUNP/oG86oj41X+p5pki4hdOkWus=
X-Gm-Gg: Acq92OG7pKrfAWS8bwXvpUP+03rxxGrUjHtVovSp/ygXFwBOYWyelQyRE9jyqjSvQSb
	VuGrJZMU0OPG7e7iTU4sYo6oatkOUqStxLCa8eQ1W1urDpn0wOCaGmPMw2u5XnT9rEwZLN/+eJi
	Vku4Tb9tdl3xpvW0jCEMkZasSv3pdK1rRRdKyenM8FBsxb3lkQvWFkwVYzrfPmC2TE1Pc/tv+JF
	dYHnKkib3dCbRmpfGkAuAmILGNnwMr9OSRCAyWY4QKdt8nHdouzG2c0Pf1w0HSCymwIgadtLxOn
	Xcr4FHNWbVFN88sCp4bpMHL648y2lG4LrxC6AVRP1S6DHbCc3CGdDS6q2v6dfNRSSWkVEe7TOmW
	C7jvi9ZfT8/t5F1Lz1hUbxr6H3c9/YjaSP0TEnSzZnbBP7BgMfIV++SDdEkjEW9zYDrQpMaSJv/
	IFky5N/Eg4w4+gVL27WpCCeSH3qnsOsWtA
X-Received: by 2002:a05:600c:8715:b0:490:b07:5f27 with SMTP id 5b1f17b1804b1-4900b07600fmr72330915e9.24.1779095053446;
        Mon, 18 May 2026 02:04:13 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35084436f8f.5.2026.05.18.02.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:04:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 18 May 2026 10:03:09 +0100
Subject: [PATCH v2 3/6] selftests: Remove unused LLD variable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-james-perf-llvm-version-v2-3-f12cc4f031d8@linaro.org>
References: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
In-Reply-To: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
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
 Yonghong Song <yonghong.song@linux.dev>, ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
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

