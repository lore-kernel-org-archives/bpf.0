Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD293890FF
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079705; cv=none; b=SRQVlXHtFvlgglKVLMz5N2GJE0Yw4h9mmk6qHkq8Z4vEpDNnkYILGDIqkS9BUraLb1+PgffLpvUlSxWDxLrZcxKJRAj4K+bw2U6wyNFYuDp57doXAiYVC7K+otnViTorcdBVSabkzZ00i2pWRez8IqnEDK4iJ53gXcQZREJSzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079705; c=relaxed/simple;
	bh=X/Y6Y0RSQ8C+MKLNRZgURcIaY/WnI4mafzsUsFyDboM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UGP2RDuAYjkPx6POYwBz8nBm9eOCJK5Qx6yrFB1PszTWIf7ieOlWjL8PiOuKGUWr8zn8ZY9zY5gK7woNVOvxtM7nY5d69V+FwTs0fzHPP8aw01sIXGeuQXGX0xnv+w0Li0O7ICd2Aq9BuTMzUKfGUlZw8veAQr5lpfc8qY/jauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrCwG6/f; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrCwG6/f"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dc1c0b7ccso2068330c88.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 21:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079703; x=1779684503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TX+St+pVYkIq20j0v2ezoU/ohjaZ4xJX9nTu6/yN9F4=;
        b=RrCwG6/fcon1Y9E1UwTZvGbuQgn7icbJGIHp8Jz9S41w5Gk2f7DsT+Fv9JF6+dL4x5
         WCkXTCVpshVMODZVvXNzluOV9q2pS9p5vkWp71z32sRJiLRNPjXqdbbXrIANd1fgxKTT
         WCgvIFsYPTex2N1nM841XoqNcEH7Katef63MSTj0wiQzFAbhAvDPmgguRo2Z4YopjfjH
         j/0uFpfeW/WdbroKMDCNUJnZJDKYb2l0OxNUUEfVcu7wuNgsX+WLVYZM3beg8lwIyna+
         sfby0WEBIShvC6p/dRoAkA14DPYr+OPFXMcBQaZNSqS2SzcXBExZ7hYNZEtYPQN4I0g4
         evpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079703; x=1779684503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TX+St+pVYkIq20j0v2ezoU/ohjaZ4xJX9nTu6/yN9F4=;
        b=fck2moamchZFbQvwTbWYkS34vpvvkXoHRmiR1ZfYJaF4eaaM8ypkVwgryEkvjFGEJv
         M/qsqBtTszTIl4xElNkHYD+7gzRkunZD0Jij0W2/iHrqVIoUVtKbQPHj7IJY1RHGTZAS
         7ZtNenRW9HL4EoC+27hUreYzH1kPfbSeQ+CZh9vLadDN0E/mJgbqb9zjdkpIcaliB7F2
         KxJ1ORqbO8C93xkikSZARG0oHF9NS6BecP+MgsHB0S77RECxvuhNVyJwer5pGRjYBmA0
         wPBzgnmQn4r57vHfNofHMOs+uUJCX3P+YQ8I2670IJ5S/xw0l6lX+t18HH5C1UO2s95N
         mtnA==
X-Forwarded-Encrypted: i=1; AFNElJ/7gggZAPm6RRJM6hGT2n4Bw/VwRiOw1quf/O9GX+RGduT/1+IkkjRqUnFYnREoIDHP6Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBXpodB0U8rnUh1KzuPhfTMeB9jknmfXrjtac4apTJkbHlJE7Q
	rli+RCFlVgpPnD9xtXx/OxiNOiSjPo7KTBhIhFygZbKAzu2FaoT118K/A1AaJy3cOFjedcUYNt9
	HmogfZxTQ/A==
X-Received: from dly24-n1.prod.google.com ([2002:a05:701b:2058:10b0:135:66d8:351c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:128d:b0:12d:31cb:b806
 with SMTP id a92af1059eb24-134c8d4fb2amr7693120c88.26.1779079702613; Sun, 17
 May 2026 21:48:22 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:40 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-15-irogers@google.com>
Subject: [PATCH v6 14/14] perf build: Convert llvm-config shell queries to
 simply expanded variables
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

In Makefile.config, CFLAGS, CXXFLAGS, LIBLLVM, and EXTLIBS were assigned
using recursive expansion or appended with raw $(shell $(LLVM_CONFIG) ...)
calls. Because these variables were expanded during dependency evaluation
across every single object file compilation rule, Kbuild continuously
re-executed llvm-config forks nearly 200 times during incremental builds.

Convert llvm-config shell queries to simply expanded variables (:=) to
ensure Make evaluates LLVM compiler flags and library paths exactly once
when Makefile.config is parsed, eliminating ~185 redundant sub-processes
during build startup.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 26de7528d6ce..b56fa8419f7d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -925,11 +925,14 @@ ifndef NO_LIBLLVM
   $(call feature_check,llvm-perf)
   ifeq ($(feature-llvm-perf), 1)
     CFLAGS += -DHAVE_LIBLLVM_SUPPORT
-    CFLAGS += $(shell $(LLVM_CONFIG) --cflags)
-    CXXFLAGS += -DHAVE_LIBLLVM_SUPPORT
-    CXXFLAGS += $(shell $(LLVM_CONFIG) --cxxflags)
-    LIBLLVM = $(shell $(LLVM_CONFIG) --libs all) $(shell $(LLVM_CONFIG) --system-libs)
-    EXTLIBS += -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM)
+    LLVM_CFLAGS := $(shell $(LLVM_CONFIG) --cflags 2>/dev/null)
+    LLVM_CXXFLAGS := $(shell $(LLVM_CONFIG) --cxxflags 2>/dev/null)
+    LLVM_LIBLLVM := $(shell $(LLVM_CONFIG) --libs all 2>/dev/null) $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
+    LLVM_LIBDIR := $(shell $(LLVM_CONFIG) --libdir 2>/dev/null)
+    CFLAGS += $(LLVM_CFLAGS)
+    CXXFLAGS += -DHAVE_LIBLLVM_SUPPORT $(LLVM_CXXFLAGS)
+    LIBLLVM := $(LLVM_LIBLLVM)
+    EXTLIBS += -L$(LLVM_LIBDIR) $(LIBLLVM)
     EXTLIBS += -lstdc++
     $(call detected,CONFIG_LIBLLVM)
   else
-- 
2.54.0.563.g4f69b47b94-goog

