Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941361;
	b=VAapS0hxkTLy2SnlJoUvCgC4GJwQIkoq1JxzjntLTWvlrt/wjceCHkB0a3SvsZY3f9i8
	 V+bj1aHBcrQrCfMeE9lz1oLj4bVUdIjNyaxPKWHJnUh1dAVYiyZPt19OcnXVBIulBI4x4
	 u6//UxZaL7LzXbrGOpx1DcY7cjM/wuNNXF8T3yp700gxCyRyImLi4WLibcF0Ry7tYb5zD
	 4I1ip+1hDrUCdM5JXCWYvD3NjODChhHwjNN1oPiilnNn+dY2ryvzkRld3Dz4ClBBpS+Ir
	 Pc9BYkF427IXhs8EQ+M0jD23YII1x3KQ3YGi+KBZYT+9B19rZCIDVfeD2Q4El9UtEyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=eeTG4TqTHeCP3y4cQ5EWaophStPtsy5e25rUv6vANm8=;
	b=jJfxFxbgD/R5/7jCrABLJnpiR7cdZWV6MiSn0e9M1rXFUqMG1eHI/H+BFMtNE794auXw
	 vBQ4FDBJSRxXoGWxd26xzuphQoFZvf8blEM9Y2UqIHbq2V9wS3pUMEyIIFhjnxWKjZ139
	 WgmWExw6fyNp5c0XC4xR63at9HqVfljrf/UbcY4WqnKirxiIbpI5q1iKVrw/OuOTNCXJg
	 wlP8dOaQ5kEBrX9s1LUGSJiiG/QMfriBj4nkT0A/Rlob6nmqY0APYY37pw2hAEdHBgFeP
	 s3fRB1fVbdQTjCsoSRA4YxF/kyAxkMfuAFca6+vjnDWkwU0g4Yz8ffro+XiIhwuCA9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cKNjeJ9F;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BE606A33F
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 18:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 399BE606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cKNjeJ9F
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3821eb27024so220353eec.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941360; x=1795546160; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eeTG4TqTHeCP3y4cQ5EWaophStPtsy5e25rUv6vANm8=;
        b=cKNjeJ9FvSE+77axmwTQSvSkn4XafyNGQ7u0Uo/fT7Jv5GhUL29FdIYSERWVZhZioP
         /6dVv0fEa+5Nq1fxN/d/dMCbhSrAPE99rhiWvaEMyZiDjNNlhaJ5oS9HmQBit7/zatgx
         YU/0swQ6p8IPKmegVRhjuDFP/fe9g3tTPuBuqMiKmSO9Yl1iQMWRABxHhcEzNSeZAQyp
         tvwIhWFqv/CRLmWH2qTIZIH7/GWbcSpMC4/cQEzMK5ZCyeGl2Artx4Swt6PLzb+XUr4b
         mpGENit2MWjeXualFtfti2MS15e4MTBAH1r9pO5GidLzDZ7oNquWURyAoMkkcGE/zhgj
         Z/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941360; x=1795546160;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eeTG4TqTHeCP3y4cQ5EWaophStPtsy5e25rUv6vANm8=;
        b=p+R0PCcf+E8IFfUYHTwLs23ETbY8OZLMpjBLnXOdt6kvXfX1gdRrZbEfCU3aFfaPZP
         diGBgGRjs7vjwcc3YXXbmMKHYbx36X5kOva7a6hISwv+7v5gIBdNkqEGd1okkrvvDMYx
         qhWozOln82VitytGS8+Vh4di7TvWfHZkqolytXxFuQEoo9YGCsYoMbu96fn64KmmpYw2
         jMbOo2LGf3YOc/Iz+tKWVNm+az8U14Xn0RFpKTAzJNcab/uwcE/X+VulCRedvjiQarjW
         aYhncLnq45/go2JAkJTluKYYrObbxaftVviWeZi1J56uc0D1lgo4YxYCIfuVST6T/Fft
         3Lmg==
X-Forwarded-Encrypted: i=1; AL+hErEn/3Q2qfuVhT0Gv3IOopjcek1S4YyLR9wbrS0gbk71YT6w3kluvGIl1yTjmcAQjct/dDs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+N9q4k+d1W2R5re6rG8XYvCUt2gk47b5ZYMS/7JsQ8VQ+wyLB0
	77ZeZ1cZq38tDXwdzCNwZ289+50JbdjCx87Ob+XADuyixjKe6HMZHtykrSxjsmzQ58Bv6vwFIxv
	mYmNSLBvATQ==
X-Received: from dlbej6.prod.google.com ([2002:a05:7022:c46:b0:1a0:100d:fd6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2409:b0:1b3:b833:6565
 with SMTP id a92af1059eb24-1b543cd7213mr493110c88.20.1794941359867; Tue, 17
 Nov 2026 10:49:19 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:29 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-9-irogers@google.com>
Subject: [PATCH v14 08/23] perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
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
2.56.1.703.gf848ed807c-goog

