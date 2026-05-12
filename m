Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF03C3C16
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564171; cv=none; b=OGLHlB251ExpfM/dgFKKVA6LUpl5om5sQPNifuk0cI7CmNyxp+X9qY/JlZNs+hQWiZRgaM20y4+V6Fg10fEkx5HTjaHRd9g2gaCGUEVk5oQ7GNKZXrdHoeFZ8JRKzH8o/TZPfe+XhBYtEpCyAfx8cigVRNa20PvZ2sb4ZlQY3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564171; c=relaxed/simple;
	bh=75eKE+tJFe0OAfOA1qho8SQB/O8Uy2A/+7SXYIEKmzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L7Nzsz5f10tAkT0wFAY/2grBxmkkfTwuXKbo2ONIPIbZmUGkJ0aMaRyXxYFlQNESMw/LD/Qjs4eIFECZovsM2h8/+FjHRDaRIi+8mWYvW8qjVWmgjRVCDU3s3BMLGJ57TiJo6O7w79kfzErNPJiQI0Otz2rUFMJ4rPxqSGmkqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuCwMr77; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuCwMr77"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13312be8a31so6429173c88.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 22:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564164; x=1779168964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvl3sORFLrEwbrjqVU+zw5LLtprwRT4ak9UnaDwB2ig=;
        b=BuCwMr77ZtTtEt7kHXYZ2lrtul6Cx4Of2QoE8KTGTdHeo/3USz3smQRAfXNVeoJ0Kq
         ADEpWPQH7oGjuSxknNa4wNMF1TWIiw5BtcjYqBccOBaDkmlJCn30ajXs6hqcXws9V580
         108aeSmh8c7wj/upjv+lr960X8HS83U812QuQjg3U3+KfvdmVZefRe59TbSpAZNiOk4X
         0EN5OzobYJNoQZpiip5Tlbv6RPt0x8hceE33P5Qak2J6CwY6xfUvWTHmb0ZyO/ti6uM+
         zPTXHkeMpTK2Y5+JQLBzdlut1Ul2rt/9GFZqXq/qTj5ZNQo4sBvOpC5RtERGeMxyXfOl
         caEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564164; x=1779168964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvl3sORFLrEwbrjqVU+zw5LLtprwRT4ak9UnaDwB2ig=;
        b=CT0qDuHBkYSTjft4evpqG8uAjQSyNtBf+aGaSzRV2AwUTmF3ferRFcd9dTdvch3bW9
         h+LDR6sRANzR2IxxDefkXABKW7epaLDBL/6CuJ6YEKYEVHAyGJiqxtNt20IQhaWQtVJ7
         NcFtJ9DtUNM5oqu042UnsOPEp6D2NlXQwyRXE2nP4ORwsVbJE+rGfRV82Ujw/Lb6kK6+
         OChXjKzF4qsLN/1dqnji890GNIUjNFS8xUk50bRXIWigv4KswuW1ch3nj7qTKkBHwgcY
         ZkfgzRlUWdJcDKMwjjQRh2UQU8DjmRkfXYDEGgK9k3azLDmxcysLaVWau3tsTZ4v+Vff
         dizA==
X-Forwarded-Encrypted: i=1; AFNElJ/Hqu7AjotWX2uWwdUvHRG64t3PzppTxuMA4kMRTO0fFMoOIU4hPEC9/4SwtSb2/U6LmDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXNdP7ra2+xGJzDlRnboWn4nMGFXuNoMerJxn53KO7Euy3k6Gr
	NX6UN/cozNGKzATiVGOPv7dt3DbeP+vGgYi5g3Kk9cp1OOa4WNyJRNZJq4VX/YnNY9RzI8d14fZ
	l10P3Fzy+cA==
X-Received: from dybgn40.prod.google.com ([2002:a05:7301:2528:b0:2d1:6536:ac8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fb0c:b0:12d:ca31:f19d
 with SMTP id a92af1059eb24-13271b86630mr9447493c88.28.1778564164216; Mon, 11
 May 2026 22:36:04 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:32 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-8-irogers@google.com>
Subject: [PATCH v1 07/14] perf build: Move static libbpf dependency out of
 prepare step
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
sub-makes build the perf tool. The libbpf headers are used in the
bench and util libraries, as well as individual perf builtin
commands. Move the libbpf dependency out of the prepare step and into
the dependencies for those targets to avoid it being a source of
serialization in the prepare step.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ec0e91bedce1..5af767415c11 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -547,7 +547,7 @@ export NO_JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
-$(PERF_IN): prepare FORCE
+$(PERF_IN): prepare $(LIBBPF) FORCE
 	$(Q)$(MAKE) $(build)=perf
 
 $(LIBPMU_EVENTS_IN): FORCE $(LIBPERF)
@@ -558,7 +558,7 @@ $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 
 # The $(LIBPERF_UTIL) dependency is to ensure bpftool and vmlinux.h
 # aren't racily built for bench/bpf_skel/bench_uprobe.bpf.c
-$(LIBPERF_BENCH_IN): FORCE prepare | $(LIBPERF_UTIL)
+$(LIBPERF_BENCH_IN): FORCE prepare $(LIBBPF) | $(LIBPERF_UTIL)
 	$(Q)$(MAKE) $(build)=perf-bench
 
 $(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
@@ -576,7 +576,7 @@ $(LIBPERF_UI_IN): FORCE prepare
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(LIBPERF_UTIL_IN): FORCE prepare
+$(LIBPERF_UTIL_IN): FORCE prepare $(LIBBPF)
 	$(Q)$(MAKE) $(build)=perf-util
 
 $(LIBPERF_UTIL): $(LIBPERF_UTIL_IN)
@@ -636,10 +636,6 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
 	$(LIBSUBCMD) \
 	$(LIBSYMBOL)
 
-ifdef LIBBPF_STATIC
-prepare: $(LIBBPF)
-endif
-
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
 
-- 
2.54.0.563.g4f69b47b94-goog

