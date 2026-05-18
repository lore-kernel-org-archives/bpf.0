Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CC386C05
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079694; cv=none; b=C2W8ZTf9mCOE7RXPWANhhzw01USbHCDrh5LDUapPcqJ7Nu47PNkiQsAOjqCbBvt3KDifKo6CANodZGGEFmjP33Uq43i3xTloSNuMmHIN7IKX6AHHD2kbF8ylBRb1jildPDZKbjUeRsaQp8QfifRBK1qApNPBrxlj2Z8zMYr5KUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079694; c=relaxed/simple;
	bh=l5QKav5wmqSVNvurZfB75hgd7Q4yiRfMQ7JC8EnR+0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M5juCITLtP8eMV3gdyxG+HmZMXEl/MOSNJgMg2IDwHbBp05x3gDmgAiBcDvsuWmTMZhaPJZ30FgLpUS8S7xuHIGibBjMOYY/Jz6NOTtyiIEi02vySWSHj2xpfl3WunKKeaehdrAFgJTX/B0AnPkPJOe3AvUUwhTFRD7Kpf4POBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1uJ+38i; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1uJ+38i"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82bd90afbbso940241a12.0
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 21:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079689; x=1779684489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ko4k/zOsIwJVmScnIi9Okmp0zWky5zOptE9t4gyo8w=;
        b=Y1uJ+38iJYxpCRtTUs05/owdjGJ2OG0yXtWCv5EN5ZCOgMbMNBsMekmQelOMyTdXhq
         ZmfYgeypyX3e+KId3toi6Ijxbs56INPE1ktA5fnM6ITIOn9Eez84ktWc2XpWw103985E
         ZGmkJ/LNQlszd5grOXGIzC2UdlReYSMLoYW0OMGOPhRWeny6AnKHY5r27Ui5vIyAizmn
         ybYWW+nvfAznZGz4vebAfkVIs0It15YsxFllY6kdRio9x+t7SBrfzr1/N7oL/RGV/uVj
         iRJwheLEYZ9nwLkm7dnbPAOOsYyUThCTMTgnUDm6S4X6P1A6QvCaX/ghgd3/lgKul3Ob
         1I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079689; x=1779684489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ko4k/zOsIwJVmScnIi9Okmp0zWky5zOptE9t4gyo8w=;
        b=E4NdENpFi5tWlAopiS1vxH5gEprYa+BmO4MduHtDcvJREujgRYmDWO4xzOEUsPaKC2
         XpNsRf5NULSCUY4CCfokPtJH7W5E/X37o6ZvDVwBOBzn5FvxXY3iICQiaAPW8SLQmG8A
         wjMa77S12WV1WXBeHEbV1aWOaco/XJsGijL6N4nXxCu+gBlidQ3H0XmdjJ5aJWLTIMXH
         ioygXRxyHf2D4eRZ4HgP/h29VAhTmmbAPvK2ijcDy8+AG72oNiL3UHwDnNL7AR7Wq/TY
         jYau9jsneorltLpnTUcG1EKlEnRtQEGVe+Zp7KMemoig1GVQHsrTsN6cjZBEk1cZFY77
         Co2A==
X-Forwarded-Encrypted: i=1; AFNElJ8oz0cvdvNZcWM7Ztd8hBOn6TDdncP5A2A4i0l3FByyQB6KanznNYcBJD7NvTwcDR1b5+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRcHoP+0rqWhU+x/8mwVM6qjRQVi0EY869MEOqkC42vyHtokqg
	xPBmKgEr9FTzMcz3rh3JNmfaTtiM5B+npHullzxymHTOjdGR9hsNzmHhd5BXcuZ9Pj9zA30cgma
	3ptmkmmTKhg==
X-Received: from pgbfm5.prod.google.com ([2002:a05:6a02:4985:b0:c82:7df9:8c1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f91:b0:3a0:c2b4:d976
 with SMTP id adf61e73a8af0-3b22ec9c542mr15812454637.44.1779079689046; Sun, 17
 May 2026 21:48:09 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:34 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-9-irogers@google.com>
Subject: [PATCH v6 08/14] perf build: Move libsymbol dependency out of prepare step
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
index 876065a02de6..96a68723109f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -558,7 +558,7 @@ $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 
 # The $(LIBPERF_UTIL) dependency is to ensure bpftool and vmlinux.h
 # aren't racily built for bench/bpf_skel/bench_uprobe.bpf.c
-$(LIBPERF_BENCH_IN): FORCE prepare | $(LIBPERF_UTIL)
+$(LIBPERF_BENCH_IN): FORCE prepare $(LIBSYMBOL) | $(LIBPERF_UTIL)
 	$(Q)$(MAKE) $(build)=perf-bench
 
 $(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
@@ -576,7 +576,7 @@ $(LIBPERF_UI_IN): FORCE prepare
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(LIBPERF_UTIL_IN): FORCE prepare
+$(LIBPERF_UTIL_IN): FORCE prepare $(LIBSYMBOL)
 	$(Q)$(MAKE) $(build)=perf-util
 
 $(LIBPERF_UTIL): $(LIBPERF_UTIL_IN)
@@ -637,8 +637,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
 	bpf-skel-prepare \
 	$(LIBAPI) \
 	$(LIBPERF) \
-	$(LIBSUBCMD) \
-	$(LIBSYMBOL)
+	$(LIBSUBCMD)
 
 ifdef LIBBPF_STATIC
 prepare: $(LIBBPF)
-- 
2.54.0.563.g4f69b47b94-goog

