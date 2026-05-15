Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFB3DC87F
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866751; cv=none; b=ZcgOw3dfhowFRhjfrogDYGpfdt7Br3WUmeUDtyMWbBkMST9cPKrmBS/vk7N2BY4lYQAF8x0rBfKOt/kLy0AQJ8eeFXxIBZQUz1uGGrJHI3IOiTbOUmp4VY6Vn/aBEGIEMLj0nOJR+JKMJUexasnAZ9smLEdRLxkXwMFNcPV2b/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866751; c=relaxed/simple;
	bh=xokYndru7r5U27QA5IiJ9grDU4CmNf+aSc8fRA9ncZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EpGOSx6la/b/EkyvOtx9kmmCtvXLAyKjsqngPC9SVATXNOyNdrKq95O+YxRZQaYbAdehyONCxb8XlwdiAKnDMTMkIh55QVcdpG7jZSOG87L2+mqHQ0s4X/27oTCrqG3QXPYMKpObqkA7P1l0UZZFBeSjBGn733hIJdPidvlkh2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJT3P5MW; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJT3P5MW"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so501963eec.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 10:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866749; x=1779471549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=bJT3P5MWq5IUVOIZVfadHuA7plL+CevtkA7x5sCn4z3OmPI1rwgG6139uUINWMQsB5
         skA8dNGmksd05Y/5zdRF9iQzA6MJYw8maJLepmGenxDrr4qfa/26N4F4AMlRsD+j4bS2
         GAcHfMNXe/VKKAVXi6dEu0D/qvJgmA1lkWtlnQaSQBoHM0lGS19DUbKdBFucnYnK9E+j
         VntDKwlJLY2AqIVfSH802ZY9p6pFkhZ1s9mTRMykwDH4Pf+6gim+saqU6no/Qiq3NWET
         Mfxce+ok4VA8EYXU6xgP++eeiK3ZKsw++QzmEwvlX/LAiFY0skbKSXQWeqwY8qTAIGgA
         ogCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866749; x=1779471549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r68S8jxOjdQsq88pAcfrL0Nqp+mR1s52o0SNFT5DPPA=;
        b=fuYk2wBxfFS+G4kU7urFla3DrdJ6sWZ8xzPa9zHw5fLQV8LVbSnJIHhoczNi+k1Xai
         PsWnPIPs9X1vV5ryxHQ1yepYtmKI9gQZcn09CEKD9tM8yNrHkr8C0EPLPe3TcoygtLdS
         d6b+i+q9c+0D1CqJVxmIIhF3QRRBvH0hg5QLOVETuNVc3ghlK2uAYSAWEppUxYYNIo3b
         j+74CLZpyF0asRcbLfSXr+Tq908n08YeDsWwE2dkDdLlYsObgn03iOiT8kAVrFIJ8xlx
         rhVFl7OC4oxfT4ZbrtWE608/2+BDb0SvaPH8SaubmrCuCVUvnfjiNzYbH80l1Uj7qLXe
         CBmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vf12LWlfSPpc7yjieEew1L0l8yx62tVo8ztG8kgYOeeED7OpISwuvESbWieL0AukEnyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIrG2DCRT5Pviq1+OjI2ANR+emtlpAKjkpauB5nILCS/ctK0rK
	LwnkjSqoQ7PE55c9dkApa/+LcICmd4P9zyB5R/0pRpTfZdGo9DYAAHzL9+wTUGkPiJRWCgjIl0Y
	tsgUOcza75A==
X-Received: from dybia10.prod.google.com ([2002:a05:7301:30a:b0:2da:3d44:ddce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:724f:b0:2ed:27a3:eae2
 with SMTP id 5a478bee46e88-30398189fa8mr2946651eec.15.1778866749283; Fri, 15
 May 2026 10:39:09 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:41 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-5-irogers@google.com>
Subject: [PATCH v4 04/14] perf build: Remove empty archheaders target
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

