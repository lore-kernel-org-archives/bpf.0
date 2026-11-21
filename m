Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244346;
	b=wgFQYTUx2TTSHGlUGsMsfpIAXPNtgHbujOvAJsoylajx6udodHpR+lDuLUpBIHFg1WSJ
	 hecYmwDZZgt6i/yuMROReBVdObBiyixJz5p/8TGa8QzPrM25r66jPL2vYe3l3rDi0bDhg
	 M+p3O3VvPUAczTO5B9hajtaqrgDtNDbJmPC8PN+gP4HUVN+j+cphYSAyWWN5W5k8ltzes
	 AVZOlqv2kc/FsBm8g7t1eL+eyAJfwUWtZKuCsisUPQrCngLqWtLISYhKSsKH/zQjQUGCg
	 xzuK1nPjfwMrLOmxVSo0ejfeActBER8NhXvXwQfKLLTopdI/JFSq7wYMe7O7RpURufQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YaOrepU6AaV9bsaJ1eqR9wb353r378iiA6um3H27iXs=;
	b=mNqlsCSj5iXfXh5Ggpfw6WWcWc5jNYuwYV3iyxgXvGZle6w0c5myhuz9BQFTt3uPhCEw
	 p3DouNWX6R/UzFDc8E3bTkxlZDX8vPPMGpdJ6M5iXgXvLlDIjSo9PHXl1xAXycU35qDjR
	 BMNGeuC/JD/lceWBMoIlUj1Rax6NEGjFE4PljZDdRzw457VcT9xACfKOXHUnlVpidTMDw
	 V2/eAm2n4ph8yGhUYETjUuppgj7qIGnwoyk1yyTz3l9mvNDQ74Uvab4r7vQMZ9Lqurl24
	 Aef3hqTROSMt6U3BOVB1bmg1wYlh29ZWBGeIocot7rIjXBjh6gIXSEwJUFqIVaewnog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NWlG9GPF;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1400606A683
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 06:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1400606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NWlG9GPF
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so1127948c88.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 22:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244345; x=1795849145; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YaOrepU6AaV9bsaJ1eqR9wb353r378iiA6um3H27iXs=;
        b=NWlG9GPFXRrhC8HnN8Fpxhynk2bHNo+O3biLoOEDn5YG2Xz+N2CNW7biIP8VqFnp1/
         M2i6oBpBXZXV7BlrLOKwPOclFTtaocGAy3Qg5K/4OQnNuZiHSZ0oO3YZqRz7+GBVVbSr
         39A+KXkX71ecY0RH15tch1YysYPHUoD4lURF+bAsZVF6VeG3dipI0rpuDOqWwMtlcFTu
         mS24FJeYYgkjYaZQDqYrL2YzBIdS3eXwXR3cm1JYnLL8o6gJ9W9R0l1q8PYuPt9mjmQC
         ejRWH7vh0y2UJEcwSAT0eaGNKtU5oDu9cLvpg+Pe6eWXN3PZ18tmohriQWZuEVsuHQjA
         sU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244345; x=1795849145;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YaOrepU6AaV9bsaJ1eqR9wb353r378iiA6um3H27iXs=;
        b=eKr6pZoUIGTYaVnM9j2J3OWDEYhuKsU6r/lSELtgk0gR36K/2UcLfYK3gTZRMEJnYy
         HYl5QO0paxgCTQzHav9eKyVojjzASVcHIuUjFt5dde0TMlQHPtFZsH+QesbadJZOfMnG
         BxnrTRHUCQSihEFhhiutDELok3oU28zgSQLRke292QHbIMJQyghtdN6093B2sNrG6Su7
         yQzs9FPdO5uDMHbq5I4y5pNL170nW8FYddb9NjVOwSwmCdds8ntghtzhA91tpr0zISl5
         y/rRval+n88GCY5w+O+UWRsO7T0KlBoQuQiY4MdGfOW9j9/nv3USxda2hiztXlm5Looj
         Vb+Q==
X-Forwarded-Encrypted: i=1; AL+hErHEc/hLcyPuyRHygR0fQ9raMLTA5wC7QUh4jvhr6vcLXE670fpL5q3y/WQoOkGxBtSWJlg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lC+d1k5vIUbbpcHytNk4UvBw5uSUszB4AJbNd1S8X8TLxqvCe
	+9/Rvt1CpViF55/leVPEg2DBL01He5I/p6UWH/3lyzzgvkpUXFHUct2r5PiyfnNeL1+sjKJHUOz
	fUgi43rF8MQ==
X-Received: from dled20-n1.prod.google.com ([2002:a05:701b:42d4:10b0:1b3:befc:72bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2508:b0:1b2:3497:5998
 with SMTP id a92af1059eb24-1b5568f03abmr4870446c88.36.1795244344566; Fri, 20
 Nov 2026 22:59:04 -0800 (PST)
Date: Fri, 20 Nov 2026 22:57:57 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-9-irogers@google.com>
Subject: [PATCH v15 08/23] perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Factor out dso__is_bpf_prog() from __map__is_bpf_prog() and update
dsos__find_kernel_dso_cb() to skip dso__is_bpf_prog(dso),
DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.
In machine__process_ksymbol_register(), also check
event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_BPF before setting
DSO_BINARY_TYPE__BPF_IMAGE for is_bpf_image() symbols prior to inserting
the DSO.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h     | 16 ++++++++++++++++
 tools/perf/util/dsos.c    |  3 +++
 tools/perf/util/machine.c |  9 ++++-----
 tools/perf/util/map.c     | 14 ++------------
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f6c60bafcde1..009bd3001ace 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -1022,6 +1022,22 @@ static inline bool dso__is_kallsyms(const struct dso *dso)
 	return is_guest_kallsyms_pid_name(name);
 }
 
+static inline bool dso__is_bpf_prog(const struct dso *dso)
+{
+	const char *name;
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return true;
+
+	/*
+	 * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
+	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
+	 * guess the type based on name.
+	 */
+	name = dso__short_name(dso);
+	return name && !strncmp(name, "bpf_prog_", sizeof("bpf_prog_") - 1);
+}
+
 static inline enum dso_binary_type dso__dbginfo_type(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->dbginfo_type;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 1574c8885d78..a7f6a98acbaf 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -475,6 +475,9 @@ static int dsos__find_kernel_dso_cb(struct dso *dso, void *data)
 	 * is_kernel_module() treats it as a kernel cpumode.
 	 */
 	if (!dso__kernel(dso) ||
+	    dso__is_bpf_prog(dso) ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__OOL ||
 	    is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN))
 		return 0;
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5b4550e97172..4a3461d79593 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -791,6 +791,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			dso__set_binary_type(dso, DSO_BINARY_TYPE__OOL);
 			dso__data(dso)->file_size = event->ksymbol.len;
 			dso__set_loaded(dso);
+		} else if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_BPF &&
+			   is_bpf_image(event->ksymbol.name)) {
+			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
+			dso__set_long_name(dso, "", false);
 		}
 
 		map__set_start(map, event->ksymbol.addr);
@@ -802,11 +806,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 
 		dso__set_loaded(dso);
-
-		if (is_bpf_image(event->ksymbol.name)) {
-			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
-			dso__set_long_name(dso, "", false);
-		}
 	} else {
 		dso = dso__get(map__dso(map));
 	}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d5319ffa88a7..5155c95df85d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -248,19 +248,9 @@ bool __map__is_extra_kernel_map(const struct map *map)
 
 bool __map__is_bpf_prog(const struct map *map)
 {
-	const char *name;
-	struct dso *dso = map__dso(map);
-
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return true;
+	const struct dso *dso = map__dso(map);
 
-	/*
-	 * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
-	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
-	 * guess the type based on name.
-	 */
-	name = dso__short_name(dso);
-	return name && (strstr(name, "bpf_prog_") == name);
+	return dso && dso__is_bpf_prog(dso);
 }
 
 bool __map__is_bpf_image(const struct map *map)
-- 
2.56.1.750.gf70dc682cf-goog

