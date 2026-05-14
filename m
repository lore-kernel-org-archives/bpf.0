Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9ED35A927
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776511; cv=none; b=Q+P84Nc23ORcW2ndsHphtB1g0GsrVsC4lVP3+4XEj0WBQy/vrnXxOIccDfLtNscWXJ6GSTq47MGhZkeJv5riON8qjERuZ7/JLyHirDlai6urXDBELYBDLsRzy5qxL/JI/6kLt2sH8s8DPoaEkBi6hWDeIFe7q489v4PSt13urtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776511; c=relaxed/simple;
	bh=KgYhLbj+7JbYPwwwjNkDDjdOGe6Kx8xfZHNose5DOpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s/F2Li1cC5mgWdU2iECvpjXVlmVfpd/osCQ0bdvHmk9lyBZlIEIokxoli5bFc9YFC+FfeXhYfeMLaEgjwIdtfUERGwZOaNj5cJhgpg1YuEwy4FFzuNW7wRtVjJ6yY8RyiN2cAXICIVMwHgbV2wav1nYrzRJIis3lfSAm+1RHYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amwxDYXs; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amwxDYXs"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132d5ad9c32so7980679c88.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776510; x=1779381310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7UhuB240zbvecKzTnCZgue1l2Usf38vhdVC8tHlI64=;
        b=amwxDYXsg2Jcp+Q1eUmF24k7ji2/fD9keeXQ7Cw7McYbp94CSRpM7UXZiIiUBZ0b5d
         aPkcXim9FrJZJB882DHqVaxYA+rT9GI0m1TQbp4oa1GVY20pRbT3o+spu502CyUuCPyc
         0iGBUno1ZZM1qqn+Zm7qEGny/u0MQJqLZtMpgZRxZSrPvzZCZjnGCn+COdTxZE9f9qKP
         rJX+/QjXafxOm17yOitISXidYFqChoO3Huv7nWeJsWh6bEDTjzDylenUt/Ny11R6JMZx
         9Mz23QlgDUyrModPX/NVUgWlWBWiZsRf+LdDQ678CnIHJ26VvFRYkTw/11MfG/L6JsR2
         YcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776510; x=1779381310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7UhuB240zbvecKzTnCZgue1l2Usf38vhdVC8tHlI64=;
        b=fnY65M42ZM03FinxKAlQIFIwVweHcoqrxER4Utzsc8e78NMQQj9Ehd/+8sqzY1hUeB
         aKjcXP+cG+lNjpIgsyZEBJmRQ/ckm9z98xvB4surAoJ/f/vSQUM5r0L41AsDNlOaxDdD
         6M4llePY97Sy7hHJl7udzUgAP7Dh7FpdTU9exX8O6FfhR5lTydrvVyfay988Vc5N44Le
         LJc9gw+C8FBv9DRCjtmjlBtE4FK5RWxWdeabvZX7caxMhKIIs3MHPJeB5FGk2GSqbBo6
         vICX+iFWG2JoH4I8bX2DuM3MWIuYy2CcQtkpvKKkYD1qIuLhRbBc1wviXqPtrB1+WFUd
         gnvw==
X-Forwarded-Encrypted: i=1; AFNElJ8Df2s6z8OK64eO89fg4sIeTXZ/0V53+dnCv9e3jDgwvBWPHv8fgMWXl3zbpri93uvS4C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR/ko/x647KXamd55zfwGXFiZ0fcrmm7I3K8Vf8yq3GA9Gio7v
	Apgj2Os4qhwe5rk+cATllL6h73bvqRvQwHuDOmAYjfiGQaiKDkI4L5AyVr4ybKTONkzRm/Zieu0
	18J0Z1w1b+A==
X-Received: from dlea2-n1.prod.google.com ([2002:a05:701b:4202:10b0:12a:77b3:9893])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:910:b0:12d:b6cb:bdc9
 with SMTP id a92af1059eb24-1342ee3a35cmr5414185c88.9.1778776509284; Thu, 14
 May 2026 09:35:09 -0700 (PDT)
Date: Thu, 14 May 2026 09:34:09 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-18-irogers@google.com>
Subject: [PATCH v3 17/17] perf build: Convert llvm-config shell queries to
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
index fbe7fa83b0bb..7a61da082c0b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -951,11 +951,14 @@ ifndef NO_LIBLLVM
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

