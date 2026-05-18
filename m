Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4F2F0C62
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119230; cv=none; b=KFTPlUggxgjWrIWxWgcYMGar9b/JoW+F11dHSrm5UUyk/6K1nRc2zJi00BoqN0jr2DWoLL8rFY572uaMHpz0A6aCTwEADhq6pbwP/T/ppZju1+xV4cFfsHasGQoK5d/IrW4oWSbxUwYpKIqDw7lmSH3Jn++tSFmlb2YD6iDudTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119230; c=relaxed/simple;
	bh=l5QKav5wmqSVNvurZfB75hgd7Q4yiRfMQ7JC8EnR+0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HEb0New47IVoycpYFPZz93AgpWEXxhLXayQPpXRj7JlPEoQk+b65G8kEsJW3X955zohLrHVovUn6LsOMjtNSF22BzBFBpdupeagqGamEtUsm2hpUMLvhQmLQjKT4EuJLF1KL8Nx75blG/m96OXLjbMsNK9PXqgCZkhQggAmnetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inN5A96y; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inN5A96y"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-835423c69ffso1182100b3a.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119222; x=1779724022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ko4k/zOsIwJVmScnIi9Okmp0zWky5zOptE9t4gyo8w=;
        b=inN5A96ygbRa1owLWamZcHGtfneBMNJbayNQ6cUlCB+rHss4NEQStfV9DKj/2s0uCj
         USpnZzXOoBrqEkFFlRFGl7rMG2mqsFTJIy14NLt1s16HpO3ePJeUQCxy2Rftr0gmxsnt
         xykhbMgOj0bbPISIRXayzcIJOIgnMOx/qNzAKQZWCOMbCQWGRIr7lLm1D8/p8srK+dsw
         8TTTG8YM8o5BaIXKWAFhSIgeLuc4adsTFz/fwCDM3ieYfbHMaForQIK2f67iwCgYE7wt
         IPEsaT7R5BSnd4X3UpU2ASuucTBMEw6Gx84ZZQIFhwU2YmW05qPlQifwQKNcK1zKbaPG
         dV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119222; x=1779724022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ko4k/zOsIwJVmScnIi9Okmp0zWky5zOptE9t4gyo8w=;
        b=g3SS0OgafrfGvoS7oY7/izkN4C6hS9t//PDmBqsO0CM/4iNEcPekrEdeUTnblGNhoe
         wXibSoDwthUtAY5RTnVHiiKntliMpjOfR59DZPOs8gRfMggHE7nf243Vgi1xpECPwIKT
         uVc2ZE5TaZ31aLs5dPFUBqv84UuthV6+SmuiHj8W0eNBmoXFerB01jNkRI/0S7DJUnVd
         82ZwyPLOArqdYzR2cuETknDArpLCyWzQPzwi9xH+OcpEfGfFiXlZF90wk4OhCM7vV1hq
         ebtWc8Fif/V1FrbdQQzTq81QIrnQBWqVNt+u+quz4utB8tMpLP/YrnGPEfwPa0PQahJK
         k/lw==
X-Forwarded-Encrypted: i=1; AFNElJ/0gofzIoUyEwqzMhWC6Zvg3y7Xockwav20AC4Z2TZs6Dz2QsL2/ZMrgvoepEj1tv6O1wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4gm7HDmmZr++PM8HoMFdQaG5cNMuO7vYQw5xsm/mnCL3sycGw
	X56FrxggK71nK1cpPKPNIPcVFD4hE+OlWt1pr7u5LAdW4xGXbEhS4TPJ35EvCWk/nn3ePw/beY3
	UgkDrqs1z3g==
X-Received: from pgar28.prod.google.com ([2002:a05:6a02:2e9c:b0:c76:b173:30d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d25:b0:3b1:a9ce:507f
 with SMTP id adf61e73a8af0-3b22ecaebfdmr17076556637.29.1779119221649; Mon, 18
 May 2026 08:47:01 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:32 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-9-irogers@google.com>
Subject: [PATCH v7 08/14] perf build: Move libsymbol dependency out of prepare step
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
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

