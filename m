Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857A3B6C03
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564174; cv=none; b=k3zSMrOIvhD6oU3rgFFxZf5cxnDr1IMpWx7PVvljo2bdMfUoFN317/+20CXJI7pv5Y+x1fou99M4m0p8OO3FsPiQ/fUJqKEC7JjxqcY40VvJ3wlE7T6jbp7BVs0FC4hPe0I9yHiYhkixq6IIdzl4gk2SBIMr7A1V0jpha9cXSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564174; c=relaxed/simple;
	bh=WzDIAj5ts6rXROpkwRIYNgahYvSgyAOMZLI2YVAtrrc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P6EEHmkNsWsXIqRpasFDbJ8j0R1wq+2hbTuJGOAc9ptKMJCaMAP1uk/+9r4lyMcJGqwKx3ofxINnTUVMSbiDALk0WMsCpxApL7Fd86+VkI5NQpwI5AkuhcMES7PcORb3UiMZN2buqGycGaf+9Pek6vr7/03mbeKXBKGXYcIOb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cYI+o7c8; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cYI+o7c8"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so7999578eec.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 22:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564168; x=1779168968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9dBs+WDjU005ooWLdgCY5o651CTBGhH8LJU6DbXqZc=;
        b=cYI+o7c8IihlMnK/oipDmVJV/e+71M+JL0Hu+pIz/yKAwGYBD5Xy+aIsPJyDDTMnw3
         UOrMRlW/zlWvUbdlcRyWDaEGzzZeJMkX5N4SkJYLUzbn0GS5KdGi/Ma1YSVEAKSOn4VW
         AyruAJY/JdmqMH5SWbxeBAaJ+9BYjKhvXl2jVbmGyhtHR+3dsg9J8kfiL8o0tjFlg2wo
         JAf7pEh8VprgDTxgiTIZvF39MUTyuOmKtgafSq3ZbZgtgtpDapLUiumFf09Xn5UIDSXl
         4aHV2cvElRXKkaWX1Nd1ZPFnc+QibR0mS+l/m8QDmzY5XuGIR78IB3+OTaJWERplLkKS
         wm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564168; x=1779168968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9dBs+WDjU005ooWLdgCY5o651CTBGhH8LJU6DbXqZc=;
        b=gmeseg/foYrD0uxKltsgsX/CUhW7dlwrlnmoOG0mdTwrr/SB4WSjrVzDX+9+89co5s
         Cvrep4gaBs/hFEchh3kPzPifqamwL5SmAAQWNLD6potctD6SdsYDLVx74XpYVdGh8ERF
         7jDdRY5kGPgA7MmBhi3X28dC+rApdHyWkjuFF4BQZyecB2yKvb6LfbEJGpWSSMvyMA4M
         uv1QOc2ALHFUXnt3Dj3MSk6rgwegrUqxTNBU8ASdaO1CGkmhdJEfPomtE/sHtClvXaCQ
         ZWNLPoLGrp5ENP5Hx/GB5S3QlrKmW/rCLkSzHLIj1PUsEv2tiP7lgdXYjso5vOvJjgIF
         q6/w==
X-Forwarded-Encrypted: i=1; AFNElJ9L4eZFy3x/6a+/A2G3ByaJQJoa8hmlJ1iFEXJz0BghLef5lrvz4AjJlXNfelkgIAAhWcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZbnACc3TWt+FGgqvhw9scpWXnuHeaT+bvr9H+9eh8jLFxTGTF
	jIfnz+wqE7+hz9ZquNo8J/CARmsAvc0L/aTiMIMk4QdEf6FWp8MYXWWTxmYk10q/mWHdO23Z/Ay
	KiA76jltlTA==
X-Received: from dlan22-n1.prod.google.com ([2002:a05:7022:eb56:10b0:12d:bcd0:59a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ba3:b0:12d:de3e:86ad
 with SMTP id a92af1059eb24-13271ec7606mr9491101c88.43.1778564167774; Mon, 11
 May 2026 22:36:07 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:34 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-10-irogers@google.com>
Subject: [PATCH v1 09/14] perf build: Move libsymbol dependency out of prepare step
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

The prepare step is a large serialization point before parallel
sub-makes build the perf tool. The libsymbol headers are used in the
bench and util libraries. Move the libsymbol dependency out of the
prepare step and into the dependencies for those targets to avoid it
being a source of serialization in the prepare step.

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

