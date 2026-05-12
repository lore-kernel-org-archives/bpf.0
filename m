Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69254DA541
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608021; cv=none; b=n6nXvfi2VEjh0REQX30nAFA7LXBHHaJ8hxMhhbsmSI9ooKb7psBfuJk77abr84krt9Nv/V3cjNIOK+TQdnKVS2AxwmIVl0isFYL9HskjUpDbd1VAUxEQeOU50IjHUoU9Kly1Cw/mchTFwmGOTPepDSS9HiXphtDiv1kznNgprfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608021; c=relaxed/simple;
	bh=AKSQH2siP4utMQ9xhh4jNh7yTLC8UkZ/sL2vSdtCUcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ksvUrQEWBHBx01LDnKdb+IU7YgyS+udkhi4BPVf4UO3CWUhyu+/EXPTVh2wIlQahJKtvV4S+f6KRixMYsZIii19I8a4vG9GzfMF1AeVegn2fT0ZNXPGpfyqmzrbCswB0oJ/lz93+WCtGe6BvAC7Ks1t1hZYltEhNNZZq+o+13JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AKS0up2I; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AKS0up2I"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dece274b1so8988276c88.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608019; x=1779212819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1yVcJX3ToKV+Wqq27E1R2W87lkjzMpr5Ak2bcYR9g3Q=;
        b=AKS0up2Iw1nRWbPfURNvXx46HojS8Vpbvnfz2nOZsoc451WEzeTcs5BZcHVVU5SZW3
         BbhFzZDd+Ok7aFLIxiZyOaf6e5YVxPKCyZVeh93aIif3gCP6iS4WL0Q7p1bB5Vx0IylB
         cmLa5eAXEBUg/lYcMzNAiX5YdL3RN5mIyrAyQJ1oMcdqJHNawsiBlC5P84TCscyQtHpw
         vhNANhO7JMZvPA1KsYpWOXHXGcvrYuFQhy1tFG/WfF0jV7zaPRMQ2Rpd2mrr1qL7JQDO
         CqoCKT9RqV0oEy245ELkNePa7bN5tJkxqFh2LPMUTifA5g7g3ROrCGll8Pej6mANYNHN
         4uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608019; x=1779212819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yVcJX3ToKV+Wqq27E1R2W87lkjzMpr5Ak2bcYR9g3Q=;
        b=r8kKGGLDCG2OCCpsmDK/8qFKj1ZENIjuvcW+zAeTexNxsRXfXozwlHhMCed9wSaMuF
         XnGVH6Z0k05kUPwYQCGSD04DV91DCt5gDt/lOXRcGncblxyn8RXQsCiKTWIYJ8GhSs8p
         mhUAdcLmNPGg5L1XRUnMxOr7n++3KsqIlG/Xbn4DqM3Cbr1snItrCOixrglc1HySZh0/
         kyxqn1bz61QSnRFkuu++P5Uj6YNQy7YUlP6xMlB+nUNrerdSVfBkNvdFx4HST82XZbZd
         1YLvhwsxNA9ICCOPo/akJw3BaIsrl0WlpvGZmsXB9quW9x62nHCoU5JIP270QzGsVIc3
         25uQ==
X-Forwarded-Encrypted: i=1; AFNElJ+k0788AC++ry8alrIjILwFm6e7F/f1Xid9NAV0zLmT7obuCde5QuxQOtkcUkDCN5PHHhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8jYFVj/0i3DnDpOVrzr/kd1tT1OB4DAlaHwI+JpedmgIcA6g
	njursRr5G0Kl4na8T5OSy145ubkd2A1q2CrsOquqxhcF2WlU0cd+pXNi+T7TS4mridSSwQW0MGD
	PIkuUF5636Q==
X-Received: from dlbvv13.prod.google.com ([2002:a05:7022:5f0d:b0:128:cfd6:a3c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e1f:b0:130:6978:c96
 with SMTP id a92af1059eb24-13344d7dc23mr2588285c88.19.1778608018800; Tue, 12
 May 2026 10:46:58 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:24 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-5-irogers@google.com>
Subject: [PATCH v2 04/18] tools scripts: Short-circuit CC_NO_CLANG compiler
 probe in Makefile.include
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

In Makefile.include, CC_NO_CLANG unconditionally executed a GCC/Clang
compiler inspection fork (gcc -dM -E ...) during Makefile parse time.
Because Makefile.include is included across more than 40 sub-makes and
component directories throughout the Kbuild tree, Make continuously
re-executed this compiler probe dozens of times during incremental builds.

Wrap CC_NO_CLANG with a conditional check and export the variable to
sub-makes. This guarantees Kbuild evaluates the compiler backend exactly
once during top-level Make invocation, eliminating 40+ redundant shell forks
across the build tree.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/scripts/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 41971a68972d..3c7803122ae2 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -74,7 +74,10 @@ $(call allow-override,CXX,$(CROSS_COMPILE)g++)
 $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
 endif
 
+ifeq ($(CC_NO_CLANG),)
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
+endif
+export CC_NO_CLANG
 
 ifneq ($(LLVM),)
 HOSTAR  ?= $(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX)
-- 
2.54.0.563.g4f69b47b94-goog

