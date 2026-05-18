Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7F231A23
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119222; cv=none; b=Bf2UKQfDuzjf1ljSyDYUWJczhx2C8BcZlzLA2sjdxVGUnM6vkK0It6sOWPcVYavZA5edhTWd96OkGd3+zxE1CNrjqlPopRgv2PgmreXQISs4rSKCw5xCzZW2pdisymjvqsxl9DC+fBZtb2vxtk1Zp60YKRC5BbVW4MnB0zGPWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119222; c=relaxed/simple;
	bh=xokYndru7r5U27QA5IiJ9grDU4CmNf+aSc8fRA9ncZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PEHkH/gCyKDo8ai3VQe2ZP4mADB7sroxTfBQjjK6Ot3v/SynPj0kMTj55Om7V87WIx8aLUt42fiz0kTa5MqYAKElCq26BEVVEazG5FEWRfee6+1fdkurTA+4BtsyvUKvF2jNVKR39aOu0DsH3iJPcnxlLOlQpjjkcR/TSt4FVXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRp2WZFu; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRp2WZFu"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f485961555so10373399eec.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119213; x=1779724013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=tRp2WZFueCSy6AGtJIlejor+bZoKSJY/BUhsQfmvis6/j8jlJVZrHld++snMJv6Dx2
         YMyZqGhOZohUtYqGVgubsKnew1TWbpNcb8MGHEp4OozY6wnPFz5cmrFWsIxtbKLJKhIU
         qQ576/8gGDjeRJcVu487SXKghOkqowgfk5MlDpPFfqsu26NMctJuF4zK+KQ7VWgbLFr+
         PZ03Odh2BkDwlXzZwwzMrH8SdNS2Q25C9+0NvOqXF7w5bS9GYDtMp7nEPlMwFPwpiQDN
         QdLmGrR9rMzWXXKAxfo1O32VbItju3EIh+IcwbjSHrg2NWAPdujaE+WJP/NDguN6K+N0
         pQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119213; x=1779724013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=r+wYyVBEGMNJGc4N6vKYya1ZHxF1c7OEHrfyQrUn+zzjnDxnwjFE1mZWwdNMb0qhs7
         ui5e50Zj5Axc87D3/O5hw35Cs94hiE4BBMRD1/rHkC1yjF2RUllyvGgrtB/B6BEMVCZ4
         yxD+Eyj3MVhSOG2sIIG33kWamLdRvNCvB+plH7+o1jM6B+6X3KICPZb4zTLU4KTDWiQj
         LC11Cfxpeb6Iz8eOtu7vN3G2DLH1dePTfQT+KDwuF5IhfuqHU4eXJpHQqShr5dI0TjWY
         kDVRrpXvzKGEzRbFmiijjW3mwaD6QB18Ldhwqm41nPMw8Ym9bLNdmP1A0d7hz6aFwLt/
         FExA==
X-Forwarded-Encrypted: i=1; AFNElJ88R6EpuqOWVB/96MtANSieONvj2wfYKOG/RRqmxKDweXlIh/1BZ7fSAIYqW5eZJefs56o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7/iX6ILBqWgFkOd2xfGha8IINJNaCh9kT3mtdrTrRtlj/HnR
	yNwQo25Nr+uGK8asoDH4Xq15B1VQuyxiu492ZAuFrF8TdUTD872BC7OZ4cEbYjX/4t/CsXyEfXO
	NV+OzJCO/Yg==
X-Received: from dybme15.prod.google.com ([2002:a05:7301:188f:b0:2e5:fa99:f6e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:400c:b0:302:e560:afb5
 with SMTP id 5a478bee46e88-303986010f3mr7499182eec.18.1779119213238; Mon, 18
 May 2026 08:46:53 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:28 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-5-irogers@google.com>
Subject: [PATCH v7 04/14] perf build: Remove empty archheaders target
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

Remove empty target that doesn't do anything.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c66af4c825fd..24581941e912 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -627,7 +627,7 @@ endif
 __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(or $(__build-dir),.)
 
-prepare: $(OUTPUT)PERF-VERSION-FILE archheaders \
+prepare: $(OUTPUT)PERF-VERSION-FILE \
 	arm64-sysreg-defs \
 	$(LIBAPI) \
 	$(LIBPERF) \
@@ -1070,7 +1070,7 @@ FORCE:
 .PHONY: all install clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
-.PHONY: archheaders python_perf_target
+.PHONY: python_perf_target
 
 endif # force_fixdep
 
-- 
2.54.0.563.g4f69b47b94-goog

