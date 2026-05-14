Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A37E367283
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776506; cv=none; b=kaWMjnly/rEoYvamgJOYk3LqpSdHUErdwrsAuf6MLhP1OVza8ca0xyxK6HYL8+siXlPEEdvPBcvfHfwSU0mCUAjW8+/CG5cbX5nGPmp1YvXBUS4me77KWAicrRwtGjl7vajr9GYtURvggpV+VNy0Yja+K4kQVyZLJDGTBaJ7p3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776506; c=relaxed/simple;
	bh=NGfYl6kDEytKUmpKfL2C4Og3ft1hP0ENd8qszCmyGZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XqAnQfWjiiCMyrO4MeMwhuBKdxqsADnk4iF1YWjl7eA6UTG95UZfzpb2/SakR3xr2UBAMpeOL/IyhvksAmI1kNJpybow2nnbZEiEoNrJaP1J9rSoblXzLe14oB9nEjBmySyjtcB0b6lJzryHraNdlYaqRuzbI3P5vb8uoZoIa2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8HjMx8g; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8HjMx8g"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f485961555so25121096eec.1
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776505; x=1779381305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugOFCk7HwEprnixRixPWaow/W0W91ZlZhg4SUCGAxfk=;
        b=k8HjMx8gJXPEFICSPrlfWdLaTjZpRZ4i96t6qhDdQZhNQQW1rLL1T+nkuudUhDItgw
         O4kPVD2eC9BC3PN052cwEZlqH7tIy5yW15Xz+lODbLfcO1NElJXN6/GquuZbk/IQhp/1
         c/2xpEUbGfAP6L0tpAvrBz0BNM0X+qonEJxPU9RSlG7E7ZnYxMxrnCpd8MB8BpmYA9+e
         xRZXSURLlG0ons+18eeX7ox96j36kEfGH/4ODx8/t1kTVNje3fKCJMDtHa10iRkhPOIX
         QNO07rlKWT5uleB7x69HNCpvJ3Hci1vdrws2xXDVGrJd0lH9foEL8jnI9Z0RiuVArW7n
         ww+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776505; x=1779381305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugOFCk7HwEprnixRixPWaow/W0W91ZlZhg4SUCGAxfk=;
        b=Fnes12Tu7z212aaDriHd3tO9ZePZFu6ldFi3YQkFgx5OveqGDUfWJBjfv7xwlZLik0
         pAfRUKjg0JOZvlTlC8BriV/6v18alLrdS96UbOxuN7UFA/BzP38RwdeMdGgKGstd1qXA
         PrQaZKS+8hdhZUQeS9V5tx9M4cGrY4dD7qqCITc4KET4JUyANFT3lqDiSn/T1WxkpF6J
         Ov49lNEKKDdEib1WfdSsC04LFxNgG7nW+mFntqTzyMMqw+YgvrPmWJlmxPilXj7DcZKj
         QH0ybPiP3hMTXV1V6buc1kON0mrwW9DcYR7GD52zCf8XTm2FpuH3k0CrKX5g1OeBCYwz
         sbbw==
X-Forwarded-Encrypted: i=1; AFNElJ/L4Ex7a1C+TIqsqcmerTyMg4huRblfC2VOvN7U0C/wg4Z62CTyxaKquZjLmK4FXSKkXPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCrUspgjDmrRrub9+roEZZM1VGcUpuAyYNEcHAbgdk8rU6nkR
	u4n/glrIjiFYbfwqy2L6xX40kxH4zvqclXBrc7Y5s7O7r2r+wA/nOAtrNouqs4Da2YJN21Djf9j
	8cK0qHsz0iw==
X-Received: from dyt2.prod.google.com ([2002:a05:693c:8082:b0:2f9:af7:503a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1293:b0:2ee:ade0:e0bf
 with SMTP id 5a478bee46e88-30398687b27mr111865eec.30.1778776504464; Thu, 14
 May 2026 09:35:04 -0700 (PDT)
Date: Thu, 14 May 2026 09:34:08 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-17-irogers@google.com>
Subject: [PATCH v3 16/17] perf pmu-events: Convert recursive shell assignments
 and macros to Make built-ins
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

In pmu-events/Build, ZENS, ARMS, and INTELS were assigned using recursive
assignment (=), and model_name/vendor_name were evaluated using shell
macros (echo ... | sed ...).

Because these variables were expanded inside the COPY_RULE dependency
evaluation loop across hundreds of PMU JSON files and inside every metric
generation recipe, Kbuild continuously re-executed 'ls', 'grep', and 'sed'
shell forks thousands of times during AST parsing and execution.

Convert ZENS, ARMS, and INTELS to simply expanded variables (:=) and
replace model_name/vendor_name with pure GNU Make string functions. This
guarantees Make executes directory probing shell forks exactly once when
the Build file is parsed and evaluates path macros purely in memory,
completely eliminating over 7,800 redundant sub-processes during build
startup.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 95172a2a851f..372773b998e4 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -56,12 +56,12 @@ $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
 # Python to generate architectural metrics
 GEN_METRIC_DEPS := pmu-events/metric.py pmu-events/common_metrics.py
 # Functions to extract the model from an extra-metrics.json or extra-metricgroups.json path.
-model_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/extra-metric.*\.json@\1@')
-vendor_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/[^/]*/extra-metric.*\.json@\1@')
+model_name = $(notdir $(patsubst %/,%,$(dir $(1))))
+vendor_name = $(notdir $(patsubst %/,%,$(dir $(patsubst %/,%,$(dir $(1))))))
 
 ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
 # Generate AMD Json
-ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
+ZENS := $(shell ls -d pmu-events/arch/x86/amdzen*)
 ZEN_METRICS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metrics.json)
 ZEN_METRICGROUPS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metricgroups.json)
 GEN_JSON += $(ZEN_METRICS) $(ZEN_METRICGROUPS)
@@ -78,7 +78,7 @@ endif
 
 ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),arm64 all))
 # Generate ARM Json
-ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*|grep -v cmn)
+ARMS := $(shell ls -d pmu-events/arch/arm64/arm/*|grep -v cmn)
 ARM_METRICS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metrics.json)
 ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
 GEN_JSON += $(ARM_METRICS) $(ARM_METRICGROUPS)
@@ -95,7 +95,7 @@ endif
 
 ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
 # Generate Intel Json
-INTELS = $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
+INTELS := $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
 INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
 INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
 GEN_JSON += $(INTEL_METRICS) $(INTEL_METRICGROUPS)
-- 
2.54.0.563.g4f69b47b94-goog

