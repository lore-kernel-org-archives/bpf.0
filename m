Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB2F58E2AB
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986511; cv=none; b=EFm57kYXiw9lqa4BJaBNTOtfiR9p+36tG0OzK9LK9dDi8SlTgpb1Plt81fpJ1PrxzYOBcZdNOrquuhuyODyIqz6c1gp5oecgVZ4xKDJQxq9qmDUjcXVs7vBZd/gOP/dQnr5J0bXV6EBrTostw5T9BMbzXyMgWGIXvbwF+l6kb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986511; c=relaxed/simple;
	bh=5WNAbAmqvz1U0NvpbAAHjG7SAeXChb01mwz/ecgi8tg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bMRfOrf5hCkFolss7uHZSSYAYTj42Czy9fh5ha74FDK43SadEE1yCjIrdf85uuuhgYuSGZFNDiQpc0LyS6w+4U25s9Rhj+aZFOHopu9lzRa0lXdONssG/D7z9JyhMtNAUknQIDiKxehOb9GGgdLWW/YiAshGVwG/iIVxrQfyPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmElGZKG; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmElGZKG"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so11315141a91.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788986504; x=1789591304; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkrUTzEBb+NyjtEsjl8suulSniwXaITksVe0VgFQXTU=;
        b=SmElGZKGfz7fuBpkWo6/PwFTgMVKfZsm53A0dBYvIWQ1J8kh2T3XDtSyTQRvrRxkOP
         UwiHRaZ1IOj8sw0wRi87CFeTeR3YNAXk+MNqMAlOE9KD6TN3thzjx/365u5rwlfyrub/
         VdpM6rtkwibTRXZwkYrdc736vRpwarabOw2OLWWD9Qa3hFm+23ERzcejRccB3ex2cNE5
         f2M5bJqniBTILcKqFnNl9VNvyJToUbn+PrdxV8KwJ9WBvfI6iCbNzCrQ6zKUhj/LxhQu
         GIvwd59RvmlGDb+Afws7WH6zxUbL3mvqqfp9rvgVXMGvJKpH96vnJa88nABvU/COv3Nq
         4jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986504; x=1789591304;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dkrUTzEBb+NyjtEsjl8suulSniwXaITksVe0VgFQXTU=;
        b=Bjf4SuZoYU/yjCH0aXb80vcbrIF5pNR92pnlptAF2vhsVLQ2630cGaaxFa1wN+S4Lb
         Fjha+OlSXl+4+QJ+80vkEU6j/vjtgZ2DF3HwStStcAWtMy17wNSsalc1PxgIfHYjZnGN
         yYHYVu6/bPgDdbE4Q97FW1MiLbA9aDt0lGdt4AxtE/rtRZ9urFLd58tSYF2XTCyWxfQ0
         5XP5rS7BN2I1jyh5L8flZYRlBTZFK58+iW6h6msYBiRTQdiAFvr312wHyx8fHOxOcxSO
         nxVzY5u9NCRpnXB9NY54HoEVsYaPbr9pTKYfR1NITOA6JZC+4Y/hNocqCJzBEtisZa7F
         8ZZA==
X-Gm-Message-State: AFuF++mitHb32m5hD7mRCOjVJ99MPTrAPq3Snxl+rIF4dMJWCmHj3gRu
	d0URFu0j7iqoODQOllEhRfBs7GvEtYMv4nyekFa+uuuG09pFuTvDMdQTbR/T2Y7a8ud4ezvSg1Y
	Q9GxySv++Eg==
X-Received: from dybmx5.prod.google.com ([2002:a05:7300:d405:b0:334:ef3c:77c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:1188:b0:39b:a8d8:985
 with SMTP id 98e67ed59e1d1-39ba8d80b06mr7538824a91.12.1788986503981; Wed, 09
 Sep 2026 13:41:43 -0700 (PDT)
Date: Wed,  9 Sep 2026 13:41:21 -0700
In-Reply-To: <20260909204122.1993010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909204122.1993010-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909204122.1993010-4-irogers@google.com>
Subject: [PATCH v2 3/4] bpftool: Add explicitly sequenced -lzstd to libbfd
 feature fallback
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Tomas Glozar <tglozar@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Leo Yan <leo.yan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Distributions like Fedora currently ship a statically compiled binutils
libbfd that natively depends on zstd to decompress sections (e.g.
undefined reference to 'ZSTD_decompress').

Extend the newly supplemented libbfd-liberty-z-zstd feature probe into
bpftool's Makefile so it can natively build against static binutils
distributions.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/bpf/bpftool/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index b0f7168e7943..1cac4508eb0c 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -125,6 +125,7 @@ FEATURE_TESTS += libcap
 FEATURE_TESTS += libbfd
 FEATURE_TESTS += libbfd-liberty
 FEATURE_TESTS += libbfd-liberty-z
+FEATURE_TESTS += libbfd-liberty-z-zstd
 FEATURE_TESTS += disassembler-four-args
 FEATURE_TESTS += disassembler-init-styled
 FEATURE_TESTS += libelf-zstd
@@ -135,6 +136,7 @@ FEATURE_DISPLAY += libcap
 FEATURE_DISPLAY += libbfd
 FEATURE_DISPLAY += libbfd-liberty
 FEATURE_DISPLAY += libbfd-liberty-z
+FEATURE_DISPLAY += libbfd-liberty-z-zstd
 endif
 
 check_feat := 1
@@ -201,6 +203,8 @@ else
     LIBS += -lbfd -ldl -lopcodes -liberty
   else ifeq ($(feature-libbfd-liberty-z),1)
     LIBS += -lbfd -ldl -lopcodes -liberty -lz
+  else ifeq ($(feature-libbfd-liberty-z-zstd),1)
+    LIBS += -lbfd -ldl -lopcodes -liberty -lz -lzstd
   endif
 
   # If one of the above feature combinations is set, we support libbfd
-- 
2.55.0.1003.g10538fe699-goog

