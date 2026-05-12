Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB33CEBAA
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 05:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564186; cv=none; b=TjO3SKrflcgN7KYyY1wAafE9A/0Wby8C3QMIRyxUBS1qnQ6ptUZl0EPeitTvCY6PUYvv888trY1An8nq9QDH3tyfbmGK8MSROf0xl3mWe/1uo9yKnYScXJH2bFrdQji16KK0rTuztaTJRcAM5GxPkrjuxQGZK70TYoyN8x++vSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564186; c=relaxed/simple;
	bh=wg4Sia+6L1oqyBOz6Vz+MKcNnctoIs84Y9DLLf2rMiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YVztrQ4l/lC+dApJh6jFVqMiBAkeaFRz8mu9u/d8PJYpR7RKwqCmyuw/C5K7HRBL/JxFeUR9JWmcxCGQJ20xGnfOjkZOgHHSShVmmgyvA+kDl6qAxiFhMuUel9k6nGVeFfOWRdGO0W7zPeQRRTHjPXcpQH+yZQAjpgkAilnd73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDf65VC+; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDf65VC+"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132c3280e03so3645166c88.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 22:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564177; x=1779168977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbbT+jKjvRNTTC/7q7wKcFx51iGVFTzOe0Jmi+PVdUg=;
        b=sDf65VC+N9hZ7rpYsVSUKRqzDJ+o68Ci1ve15eqDnV4IavNaHxG+cRPIe0BqRIczKr
         YaRDHkuZ94No/oWd3GHuUG0Oii128rXW5lUktDSlAjx5tTU3lKIHN0yP4sLnj5fvCBdD
         Xv3t7HvqiPl/PlcYM+0IALJGB/ms6k1qP1KDBRdZxf/iNo4eU3/fYCDLO2J7fnoHgAw9
         KUt2akbDFFjyDJe5K5Vj8nrMxZKburQf6B2jI7wncmYzRRSkJSl7S5QZxSt3AF0+nS/I
         yIeX8vhE8erzxNlp47lg1mKLw0WHsVorFzmL1WvNIFlU6MiQCGi7t+RvvxiaQgGhUKz0
         w7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564177; x=1779168977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbbT+jKjvRNTTC/7q7wKcFx51iGVFTzOe0Jmi+PVdUg=;
        b=IF6So1Lxsg0VjNSTLs7ccKW/oC/97K25UllnmTYxsBcdsRsMriNCxEGQORUguKxbT1
         Q/AslO4FWGaLrTRV6Z2L88vferbZc3DB0xguE5bmZPR+QilVnq6+2AgI5ZlhBoPTlxZB
         TOSOthVLHsXPCO2kcDe/hFNEUpdct7wWxgMgYwTLenA38vR3UKBfZFkJiBM4livqRbE4
         7yEaUpNGHnSBBxztXnXseSMYC4MUTSOQKWOP3RUweK+UDdjb9PZg7waEamMr2agOfwTz
         xPhp2cKK8frpIIcqtBTXTwtcBiqmso0n02lP3qVDcn6kSZgNYYMMFemOK6VjQMOI+Nt7
         JWkA==
X-Forwarded-Encrypted: i=1; AFNElJ891EG27SmB3Qxe1C8FUiHO64YoOgAAcxw+BvbKhFStW5OqAKRm/W99Fmr390jQZOc+KW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHbWLPloR8vXOoH0z0WZ7cRSQtd0IQy8x9OXBiLBV1BTtr/uHK
	0Kfy3AFNNFjYrNTAh98/cmEoUPy6slBCua2xvJdx1GNPBuPANsz7mdNlS7pF1NY0ueZlBp+F4bh
	bF/FQmNSdHg==
X-Received: from dlbbo27.prod.google.com ([2002:a05:7022:439b:b0:12d:e33d:70da])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea33:b0:12b:ee92:a60e
 with SMTP id a92af1059eb24-132a7edc4a9mr7122787c88.8.1778564177049; Mon, 11
 May 2026 22:36:17 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:39 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-15-irogers@google.com>
Subject: [PATCH v1 14/14] perf build: Prefix SCRIPTS with output directory to
 fix continuous rebuilds
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Markus Mayer <mmayer@broadcom.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In Makefile.perf, ALL_PROGRAMS includes SCRIPTS (perf-archive,
perf-iostat). However, unlike PROGRAMS and DLFILTERS, SCRIPTS was not
prefixed with $(OUTPUT).

During out-of-tree builds (or when O= is specified), Make checked for the
unprefixed target 'tools/perf/perf-archive'. Since the actual script was
installed into $(OUTPUT)perf-archive, Make concluded the target was
missing and continuously re-executed the script installation rule on every
single incremental build.

Prefix SCRIPTS with $(OUTPUT) and update the static pattern rule to ensure
Kbuild correctly tracks generated script prerequisites during incremental
builds.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 98b6f9fda8d1..e700cc1ed028 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -405,7 +405,7 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
 # Use the detected configuration
 -include $(OUTPUT).config-detected
 
-SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
+SCRIPTS = $(addprefix $(OUTPUT),$(patsubst %.sh,%,$(SCRIPT_SH)))
 
 PROGRAMS += $(OUTPUT)perf
 
@@ -592,8 +592,8 @@ $(GTK_IN): FORCE prepare
 $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
 	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_LIBS)
 
-$(SCRIPTS) : % : %.sh
-	$(QUIET_GEN)$(INSTALL) '$@.sh' '$(OUTPUT)$@'
+$(SCRIPTS) : $(OUTPUT)% : %.sh
+	$(QUIET_GEN)$(INSTALL) '$<' '$@'
 
 $(OUTPUT)PERF-VERSION-FILE: .FORCE-PERF-VERSION-FILE
 	$(Q)$(SHELL_PATH) util/PERF-VERSION-GEN $(OUTPUT)
-- 
2.54.0.563.g4f69b47b94-goog

