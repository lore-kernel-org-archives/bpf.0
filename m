Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219F3859C3
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079680; cv=none; b=il6y3mRxmV8ENMqrZoxQB6Di1A6gT0b+TpVMAS214+RPTp3/jf7NXb9WkUP/W0Mh+96fdP4ZyX+MQuBSLK/4seLdilmfQQV3kDcvBkQVtKzHtzvVjfM5Q33SYLbrfSSQ5poka4fWa9NlhxL4cfUs1AjX9l0TSJVnNXQT+dQ4v8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079680; c=relaxed/simple;
	bh=/7TyOYbdEe9k68HYyv7dCCFzh+d6Q52A6z+ebAC5RwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fOLrDHrZg9BqUFAnITnTM6DrNMdFnzB7nhT6LjNLRnRrpCwd3WuX+AtmhoCCdw8IP+K8YzCEElifaWKM5KvZjKvZ2mDkzjhvtS8cQl/fnfW5TgltaWwuvpvwGBIF8dUWN3igQpQNwSq2hWMqxzloghR97t5h/maKL4TaybHE2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OdR2YqYR; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdR2YqYR"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-134cf343c58so3503447c88.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 21:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079678; x=1779684478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=OdR2YqYRtg1s7LvdVjLrPdSRQKXnivO3Vf5WhLEZwEn4sMmIjgtlyCeGjhEvD6fVX3
         jh4vKf6lU0HF7NJYdc5kmkwsI5bpulTqRVKnTtyNDkFmjfQr2sdHt56OmHrZhvhgbbm+
         /Q09v/DIczDzKlG/bM6w2btfwX13YRWFA7GrU8fw70yNOL8wYuxW6SvBhmhXEMdT6ZXd
         hzmkFQyrRolfB4xQiC9/70elwMf1SeNoXOdgeRlHEqrhcxUh51xMsJUqT+QZUI5ITVbH
         8aAWUnYUSm9eU/GvEohKsOwTNtstihY+jFVncWC20NaHq8Xxop5bJwISo2l0tBHBy0dq
         JmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079678; x=1779684478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=St4S5ZoLOnyNz4bYF3g8qNlKYQ9u0ee/E3D8U/VcZP+ygaeg3ZDVPeLQraYZxstRzf
         I5N3wV3JXHwD+T8IycR61wkPKLLXeBUz4KlTgZRv7IwrtnkSQubnyCxio9KH3nC5RLOP
         HIxfDh6vw1/Hx+pEEMPPSL9l8W0ObUqjUmRN6Knpbb196Xow+OKR6Pu0J5fV9nZ6rfUQ
         T98sb9glzqY04FXGg6KqK1sQxBSMuCVg6guS4yn7J4haa3BpF+uRc/01f2Gp5Rm0un2w
         0coseE2hrU9lV6JojisVsj0sObBjLg1U1LkljuNk8g8x8k80wq7epL2DXbi8lqUNNfin
         IRpg==
X-Forwarded-Encrypted: i=1; AFNElJ+pxdXT7dpVGRJ7cWeMvpSAuGqZ/ta6YLaDnL9z4GY5I0/b8Gui+SvYLaOnAtXmDeBNRfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfpFmhzgqCgSQipFNNWb502FMgSrWCad+DHDsiU3n7GKestGz
	0LPfaeLs16tzonIXuDT9gpcFjpGmy1+BqhNWzjASMkaRt+2KuD8e+Nq3wDZn0C6PSxpJsJdmLf6
	nOzKYwqu4UA==
X-Received: from dled19-n2.prod.google.com ([2002:a05:701b:42d3:20b0:12d:b839:d0b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:128c:b0:133:3a29:8922
 with SMTP id a92af1059eb24-13504841fe4mr5525076c88.28.1779079677966; Sun, 17
 May 2026 21:47:57 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:29 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-4-irogers@google.com>
Subject: [PATCH v6 03/14] perf build: Decouple pmu-events from prepare
 umbrella target
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

Currently, the $(LIBPMU_EVENTS_IN) sub-make depends on the massive
"prepare" umbrella target. Because "prepare" depends on external
libraries (libapi, libperf, etc.) as well as dozens of generated
headers, make completely serializes the launch of the pmu-events
sub-make behind some of those unrelated prerequisites.

Since pmu-events is a large compilation unit, unblock its startup by
binding it directly to only $(LIBPERF) instead of prepare. This allows
background python generation scripts to overlap simultaneously with
the rest of the build.

Testing a parallel build (make -j28 clean all) shows improvements:
  Before:
    real    0m27.642s
    user    2m32.356s
    sys     0m26.683s

  After:
    real    0m22.254s
    user    2m32.810s
    sys     0m24.646s

This reclaims over 5 full seconds of build latency (~19.5% overall
reduction) by elevating average CPU concurrency from ~5.5 active cores
up to ~8 active cores.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c81797ceec42..c66af4c825fd 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -550,7 +550,7 @@ build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 $(PERF_IN): prepare FORCE
 	$(Q)$(MAKE) $(build)=perf
 
-$(LIBPMU_EVENTS_IN): FORCE prepare
+$(LIBPMU_EVENTS_IN): FORCE $(LIBPERF)
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
 $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
-- 
2.54.0.563.g4f69b47b94-goog

