Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95453DD848
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608037; cv=none; b=UttubMlZghabt8BsSRUrRqrDSUUectjWKXy9ScYAd9xF1IoDJ4hYuOwTuVMZQLSR2uueLbnqcXuFHSerysTgQs5rImBEaPZfxg5LFJ5eWf1cNu91kSdBoRLeY7U4S0ofIHaZj988PfqvoTz84jYnpSV9oo1g8s72sOywUZaS+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608037; c=relaxed/simple;
	bh=BWtcwch9wSpm+jcG4ZyiBYkU6wNGJJ6j24TCjJCtDxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tfIkXPPWxGGHqHZTVTsMwb1iZFUKeAux7hfQ5mHWkzK91C0RnCb1k81+Sfny8mY7zjgHBVlYAdbshldld0eN9cyE6FPh6RdYtVSCgA4OxGGeRIZhb6IfzRcJnoWOqarzlqMkuutPwHWISltSYFl3dLRgWNigpRMdr6/zOKslFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wu6t0AA0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wu6t0AA0"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828ab3b033so2986658a12.3
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608035; x=1779212835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YigNKPWKB82lJT8UYMSKceUMHop1vuFK75H7FYEGV78=;
        b=Wu6t0AA0I2+ybNq86mWs3uItgEWGY3hJws5tDt802bGEOtWz9lnKQ8W5vbrauj1iGq
         bHnw9nNHStr0heJ2Edlo2yOVE/mprJU2sykngST/SPLfuCMa6E6l/m/q4BzRoJhsjqNq
         XfIbnFuHD4If+I157cBgBW3xcFSxNa9CJhYFo8JxpQORoPmJLlmN4tHEZIx6Q/r8IPts
         U65vtuwjFDAJELiqgzJVckMvjgl7PeQw0OVz7cHEj+D0qkXgnMzSDKY5vuQMRdVEBlIW
         o5kmbmtvlC4vWgN8l+uotq+kOrXrCDDuLKRBWdzyu4jpzac6zFul1gNfLh6ZzQOoWWn/
         RmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608035; x=1779212835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YigNKPWKB82lJT8UYMSKceUMHop1vuFK75H7FYEGV78=;
        b=tUSZaDMyknUUZrCCbE9CFaQ/ORRDGTeZxk70WlulLTZWVxeJ++7q38NMIWvCNZkScx
         AWkxtQtcNcj66Rk7K5T1h4ucFoQyDGMeJdtk6EoFG0D5fu9Zqk/VdrveWo8DWRpygaAr
         N5leRVWQBqAVeWkj8l6sQQcIGRTHG0djoaRy7L9bCzCdGV/XhQbcJXsZErfUP2ahLsGe
         t6h2A4SSFt+rQ8nNjBsJSwr2YHLT69CGgdi68fXROOTv7aXqpt1+wPeguZ0DSWRGw754
         XXLomr71VKt4mm6OmdTR7B7KcHAFP1+x3b6jsQcCIF6PYZOQy4wFrnrAP4akGuV9eu7M
         9WTA==
X-Forwarded-Encrypted: i=1; AFNElJ8Dz8D1/Y+eduM/Ld+sKOrwYD2CgGpgX0JCexllpKb3cOr1SPaPPTw8lVKcUKLHzzSbRHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcD+LiSZ1r7GxSZsrbdhZVBK/3CaS0bCfmc0wYD2PiCuea/rCH
	ptAwXjBx0Pa1YIfNBWby8/CJdCNMfl5sdtByDaKz04wihwWcAjLYY7+89qmb2rSd2niIuuv8SUl
	7QmCcyguCXA==
X-Received: from pgww13-n1.prod.google.com ([2002:a05:6a02:2c8d:10b0:c7f:cbe1:2d84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:2786:20b0:3aa:c93b:625b
 with SMTP id adf61e73a8af0-3aad425fecfmr11319658637.3.1778608034842; Tue, 12
 May 2026 10:47:14 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:32 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-13-irogers@google.com>
Subject: [PATCH v2 12/18] perf build: Move libsymbol dependency out of prepare step
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

The prepare step is a large serialization point before parallel
sub-makes build the perf tool. The libsymbol headers are used in the
bench and util libraries. Move the libsymbol dependency out of the
prepare step and into the dependencies for those targets to avoid it
being a source of serialization in the prepare step.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index df68d29ecab7..d2e673d5e5be 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -558,7 +558,7 @@ $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 
 # The $(LIBPERF_UTIL) dependency is to ensure bpftool and vmlinux.h
 # aren't racily built for bench/bpf_skel/bench_uprobe.bpf.c
-$(LIBPERF_BENCH_IN): FORCE prepare $(LIBBPF) | $(LIBPERF_UTIL)
+$(LIBPERF_BENCH_IN): FORCE prepare $(LIBBPF) $(LIBSYMBOL) | $(LIBPERF_UTIL)
 	$(Q)$(MAKE) $(build)=perf-bench
 
 $(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
@@ -576,7 +576,7 @@ $(LIBPERF_UI_IN): FORCE prepare
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(LIBPERF_UTIL_IN): FORCE prepare $(LIBBPF)
+$(LIBPERF_UTIL_IN): FORCE prepare $(LIBBPF) $(LIBSYMBOL)
 	$(Q)$(MAKE) $(build)=perf-util
 
 $(LIBPERF_UTIL): $(LIBPERF_UTIL_IN)
@@ -637,8 +637,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
 	bpf-skel-prepare \
 	$(LIBAPI) \
 	$(LIBPERF) \
-	$(LIBSUBCMD) \
-	$(LIBSYMBOL)
+	$(LIBSUBCMD)
 
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
-- 
2.54.0.563.g4f69b47b94-goog

