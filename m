Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244349;
	b=zyA6OzAfyHWSqkq42tjxTYo3Wj/9dOMeX1KI3CNXiCu7mTsHe0S5j5WHX5soK/lwlOXY
	 slbYcBAMXkBeknHj6Caz+2IWVcYFXMLJ+XEaeXaNr1XRnBmkwZroUUwi1GEizyDPQNOC0
	 Ag8PperBKph3SRP8HIK5VQvK4WNwxlQ5f8OMx0tX62T2K/TiczzIPtmMCd9U+xG2rRyQx
	 yeP/jNE670kjATeR+V7ojVjfizrWYv4gukHuLCGJiQZv8Yn3BJfMU5XwukgM4u56w8vTy
	 vKzErxNdCWWRN2xCFPDUDNR/gIf12myehTE5TYtN/6c3BlzZIqGxwsBPa/xXVqqcSYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=BRO7iFim5TO3kyhnlqJsKmtRLu5OZtTESX0CvoKHMNc=;
	b=QS1pxusmomNOE7FyR6IB+IZu4u/kRw51oebt/7FHViKQHf0YG8UjHpiwn5X7YxcrZbxG
	 wDdKA7oPXaMbshe/fitphBjaiAHCSjeICEKT6LN1O5SGCcoPF1pkdDGcWlun+ehL6hUa7
	 O4taw0J57mfZxE6d3Xj8UyJIzCYIvHy2cNuot0t8AcyTX8S7HbSna0aKlvhdGYbl8w1Wv
	 3qDQevE0sc8Bj1oi4ugc9mqQ9vV8L0fy2JNk8lYnWUBrUa+xTaTDb4IK42jnZwXe/hmUw
	 i/dhP5ldKNPdMad4b+0KmhpTTeNXM6bJT0o667BlIjsos1DciD9sX4WuESkliPFCm8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pPDepwGG;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBCA606A681
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 06:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FBCA606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pPDepwGG
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so4489889c88.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 22:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244348; x=1795849148; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRO7iFim5TO3kyhnlqJsKmtRLu5OZtTESX0CvoKHMNc=;
        b=pPDepwGGUb23mWjZdGhrVTgo2+/ZHDDXRihHeFaRr0SRAcPbECsVyarsNxdL6jpUFg
         9Z8wAHuc+4SEVXzs76OnXW16FPTF5ttbSE2CMgNgOgLFYmnnrHomAKlK5zb2GCJNF28l
         XAMGEBHIJz5x2YD75AsSbjpTuubEpgHsw55xasZ9amTkt4Hrsyr2x22sDysBgqQiuwao
         dXSfGCz2kGwX0L/fHX2nvxpHwDGWnMErUtB4t+nwXhLyrXTFQQhCI+d2WdeqtNhP/iKT
         g6cZ9Al0+pbVmjEa9jaMgJcJgvEq32ax5X9Jwx0TckokOFCgLkgE2NZQ/c+V3kAjfB2v
         fw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244348; x=1795849148;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BRO7iFim5TO3kyhnlqJsKmtRLu5OZtTESX0CvoKHMNc=;
        b=LHhrQC5IrUyFeL/lRRoLtDyexi8Em7pzqOTKS1/LHHh2uqvH3KSjuE/CKCsZClX7kN
         11xF81or+pqppD3YlF4C5cliSDN67haQE0HKzjKU+r++reQcthF+Ut2lTvrOWmjFOR6P
         IyShRI7efh70qmlb/J9BbcycECL2P575qmUFUraP4fGdD2+Ehq/v2d1yxdWMbvD/81pS
         6aCyU75U30tyuQNHeBYdcjzprI968I9hdFlLjhgMQPeDi+ASutZH+lUdf+IiHB2BdVix
         2UX7PcQp3lqCCGjlf1eOL7NRp8FAmHT6KKSdsg1+mRRYGRQ3AbcFbsfjYhMGAHrHjD51
         mvLg==
X-Forwarded-Encrypted: i=1; AL+hErFRYTZ2dtmubusT2czpTp9+bYpN6HHjVy0S/gm60VLZMKO+dsck2fK98RO8+jYgI2sCtZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VzBd6Sxx1gCQCeZSoq8nB0+jFgIzs4AVs5V1dBURw355MY3pw
	++R/YHcP6xCa021N8/OMx1w3HMzMEVHt93hJNIJLcH6kfix8yPMTtYLUNzYvgwCUl+KrN7QuBWB
	5dGl0NU5tYg==
X-Received: from dlam22-n1.prod.google.com ([2002:a05:701b:2096:10b0:1b5:345d:ed30])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b82:b0:163:a197:722d
 with SMTP id a92af1059eb24-1b5567f6a63mr6449552c88.4.1795244347246; Fri, 20
 Nov 2026 22:59:07 -0800 (PST)
Date: Fri, 20 Nov 2026 22:57:58 -0800
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
Message-ID: <20261121065813.4143649-10-irogers@google.com>
Subject: [PATCH v15 09/23] perf dsos: Ensure DSOs in auxtrace, machine, and
 symbol are in dsos
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

Place the DSOs created in addr_filter__resolve_syms(),
machine__process_ksymbol_register(), and maps__split_kallsyms() into a
dsos collection so that all DSOs that may have data fds opened or be
referenced by maps belong to a dsos collection.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/auxtrace.c | 16 +++++++++++++---
 tools/perf/util/machine.c  |  4 ++++
 tools/perf/util/symbol.c   |  4 ++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 8bb491d389a2..1451de019df0 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -29,6 +29,7 @@
 #include "config.h"
 #include "evlist.h"
 #include "dso.h"
+#include "dsos.h"
 #include "map.h"
 #include "pmu.h"
 #include "evsel.h"
@@ -2684,7 +2685,7 @@ static int addr_filter__resolve_kernel_syms(struct addr_filter *filt)
 	return 0;
 }
 
-static struct dso *load_dso(const char *name)
+static struct dso *load_dso(const char *name, struct dsos *dsos)
 {
 	struct map *map;
 	struct dso *dso;
@@ -2693,6 +2694,11 @@ static struct dso *load_dso(const char *name)
 	if (!map)
 		return NULL;
 
+	if (dsos__add(dsos, map__dso(map))) {
+		map__put(map);
+		return NULL;
+	}
+
 	if (map__load(map) < 0)
 		pr_err("File '%s' not found or has no symbols.\n", name);
 
@@ -2794,6 +2800,7 @@ static int addr_filter__resolve_syms(struct addr_filter *filt)
 {
 	u64 start, size;
 	struct dso *dso;
+	struct dsos dsos;
 	int err = 0;
 
 	if (!filt->sym_from && !filt->sym_to)
@@ -2802,9 +2809,11 @@ static int addr_filter__resolve_syms(struct addr_filter *filt)
 	if (!filt->filename)
 		return addr_filter__resolve_kernel_syms(filt);
 
-	dso = load_dso(filt->filename);
+	dsos__init(&dsos);
+	dso = load_dso(filt->filename, &dsos);
 	if (!dso) {
 		pr_err("Failed to load symbols from: %s\n", filt->filename);
+		dsos__exit(&dsos);
 		return -EINVAL;
 	}
 
@@ -2831,13 +2840,14 @@ static int addr_filter__resolve_syms(struct addr_filter *filt)
 
 		err = check_end_after_start(filt, start, size);
 		if (err)
-			return err;
+			goto put_dso;
 
 		filt->size = start + size - filt->addr;
 	}
 
 put_dso:
 	dso__put(dso);
+	dsos__exit(&dsos);
 
 	return err;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 4a3461d79593..02711995f0b6 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -797,6 +797,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			dso__set_long_name(dso, "", false);
 		}
 
+		err = dsos__add(&machine->dsos, dso);
+		if (err)
+			goto out;
+
 		map__set_start(map, event->ksymbol.addr);
 		map__set_end(map, map__start(map) + event->ksymbol.len);
 		err = maps__fixup_overlap_and_insert(machine__kernel_maps(machine), map);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a1ac1cd1d2e7..8dded88c9763 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1078,6 +1078,10 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 				dso__set_symtab_type(ndso, DSO_BINARY_TYPE__KALLSYMS);
 			}
 			dso__set_loaded(ndso);
+			if (dsos__add(&machine->dsos, ndso)) {
+				dso__put(ndso);
+				return -1;
+			}
 
 			curr_map = map__new2(pos->start, ndso);
 			if (curr_map == NULL) {
-- 
2.56.1.750.gf70dc682cf-goog

