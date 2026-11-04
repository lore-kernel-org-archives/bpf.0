Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766625;
	b=N4G9JXUGQwq2X9Hh70NeB855dudGOJkjS8DDFlZ4bwj87xmiWdU2Vl4N9dgTxsPqrRDQ
	 Vss/bY5hD67PplOAIfyKm1rRkTij8BuQXny+8zhohV3ir2UGtXv+0jlc44XpCvCm7cC4Q
	 vv3ngCHWML7Nju77FH6Y2bLKk5LCIkzcOngdM4zOO2cCw3BVD10YZ1d1aso5uPmKcIKE/
	 ii54jepSh12WzhKEPWGB6VQT6oagIuXeRep4asJ0c7wxTcM1Jm+lNfhyNiSQ/bpnBLGcs
	 rSluaTyCARCT4nAm/caLrJ3ES5qn1XyQxyyC1erzMkTOHCVHiJhqSEZo8mmmMP725uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=lf8+fUIi9nYvAfKMMCuyoqEDJu1jsXhBuDkXiGeAP2M=;
	b=z2U1ocRlbNNYwUpBHcJSJTuJjLJhTRFAWx6GDfC1cjWWFH+RpAojuV2+payk7ZK1ptYs
	 8iWP2Jnxu4m0pM85sHBmYhQ/bOtxHKPDkZdGrKzaKYtkclHCzMKj+Pj675tMCxl1eE0wB
	 8y0nymT2KPfhv47lWqrTRBNm76LpXCvPj14i8b+HTlYby9q4EPqYTbbI3wh8zBn/IGi/L
	 Jh5gzEeg1LSkb0txvkVpGKdN9sl4j870UvExWp7cXsSNx81YqgrnCEjm48dG9w4vWEIr/
	 P49ZNP5Ez01xHpKU8v+cjEPNV96lBY3iST3MHVoUGIdd2oXqLQgInDaFzbGPCPDrqSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S2NL62jh;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC9606A328
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 04:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FBC9606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S2NL62jh
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3662e7a9299so1048478eec.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 20:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766623; x=1794371423; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lf8+fUIi9nYvAfKMMCuyoqEDJu1jsXhBuDkXiGeAP2M=;
        b=S2NL62jhYPj0Kpdrgpiy41JLh38Zfoiq8uefbVCDNEgr4KYtyJVuB3qKbIxFcqMfj3
         WP8uVp5Em69yb8z5c7Ft/lUEjpm2jhsCFoiOoKG3Ax1DLRpRVWeQnfZUyv4Tmb+LfjyE
         6ZHiGPH9o8242nilDtRyg+IEAb+GhYyVT5bYfctX71Bz3y704RRZo0eEGw2L0NDSAZD2
         uCt6deYmbJYCUCWkYM62+MJUUUaMgI+4cFvpOZ6uCFT8JNAcZ1iu/WDczv9QpGffQmi9
         9iA+brl/6pJUhGIDSjPbZ89rUlS+iPQ3kxvscT4wR8Uo3mU+ONTxldGuGjh7yNXx+rsV
         YDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766623; x=1794371423;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lf8+fUIi9nYvAfKMMCuyoqEDJu1jsXhBuDkXiGeAP2M=;
        b=Bq2Uk6B2kmfzeahmqmXb9LXqpqIEty8RW7fPH96IibdKEx8xldPFjR9Dctf8Wx6tgA
         6aeIxaA/OFkTa/iXsIVF0Y2A6Lphbcbvg3HH5D4GmbRCfIyIS6f5S5/YpNFjDUxPKsFg
         mv/GyP4gGqv6Nmo5peOjVK/1YHj7Y/A5sPmVtZc7Yf1gjv2rWEwJkYQh+gRQne6WR+2B
         sBPt6cu6kKjiVSnEaVL6BPx/EfXhSP1BsEvK1cgVuaTcOJ6iMeTNsDy+okiB9DkD1qgz
         ik19IyoOJ0rEb/AHN+eNYGRYnxWyS9b81Wgv/ngr8u4npROLlJ2Oe+3DABB9/yvUfU6O
         /bdA==
X-Forwarded-Encrypted: i=1; AKwUvBwp8TbBZhah/zemGNyK6gi5TIaDFRJHfNnUPSsqLzghmXjpaC+5bnMpwO/+hQcE91p4oM8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9k9JtyylZrdyUMg+R8wvPMh+wNeEpLNtftzZWP1w2FaT0RYOIS
	YZju0IE363fzLTbxGUmqQyxfvfLDg8GPnV3P/ox5tCkfHaz56lPzfjOtuqSO3w8BLjsoAHw2QlQ
	PYo0xzjX5hQ==
X-Received: from dynv12.prod.google.com ([2002:a05:7300:5a0c:b0:36c:9b55:8436])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:6312:b0:36a:1709:458
 with SMTP id 5a478bee46e88-36a423cce1fmr25708786eec.27.1793766623064; Tue, 03
 Nov 2026 20:30:23 -0800 (PST)
Date: Tue,  3 Nov 2026 20:30:04 -0800
In-Reply-To: <20261104043006.1199857-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104043006.1199857-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104043006.1199857-3-irogers@google.com>
Subject: [PATCH v3 2/4] perf build: Add explicitly sequenced -lzstd to libbfd
 feature fallback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Quentin Monnet <qmo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Distributions like Fedora ship a statically compiled binutils libbfd
that depends on zstd to decompress sections (e.g. undefined reference to
'ZSTD_decompress').

Since libbfd does not reliably distribute a .pc file for pkg-config,
perf probes manual linker flag combinations in fallback chains (-lbfd
-ldl -liberty -lz).

Extend the testing cascade in tools/perf/Makefile.config to check
libbfd-liberty-z-zstd and append '-lbfd -lopcodes -liberty -lz -lzstd'
when detected.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b4764f69f47f..78423b0dcc73 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -896,6 +896,7 @@ ifdef BUILD_NONDISTRO
   $(call feature_check,libbfd-threadsafe)
   $(call feature_check,libbfd-liberty)
   $(call feature_check,libbfd-liberty-z)
+  $(call feature_check,libbfd-liberty-z-zstd)
 
   ifneq ($(feature-libbfd-threadsafe), 1)
     $(error binutils-dev(el) 2.42 or later is required for non-distro builds)
@@ -909,6 +910,8 @@ ifdef BUILD_NONDISTRO
     EXTLIBS += -lbfd -lopcodes -liberty
   else ifeq ($(feature-libbfd-liberty-z), 1)
     EXTLIBS += -lbfd -lopcodes -liberty -lz
+  else ifeq ($(feature-libbfd-liberty-z-zstd), 1)
+    EXTLIBS += -lbfd -lopcodes -liberty -lz -lzstd
   endif
 
   CFLAGS += -DHAVE_LIBBFD_SUPPORT
-- 
2.56.0.385.gac671c819a-goog

