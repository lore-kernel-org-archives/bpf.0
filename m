Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941370;
	b=X8PM1zGsebNcAWR9enN3EqrotcZEyHnxvAeTYuwgZBRO1ZUgqzdcBo6MMUvAAMz6/cTz
	 WVZSoSz2li3U43j1MX9YJIv7FfJYqYf6c+d1iQiLaYHnM1s3AC4PPevDoJkxWbe2wysq1
	 Ctn/YsXw9lHbqEXYSkoiRL0A6X8rK9Q9vektLGW9q6H3dXzpmycqW1lI7BW8iicNtXOW5
	 jE8jMxJeDcTZZM81V56es+2OCSNHWhzPaETOVdU7lZxQg9FG5gNm9sLxVvO0mcpvITCPq
	 UwTCughv6NnzA/QXgSoNBWDowbqDLbkHZnYWGYhxlgv0vs/Y01OfMzaI/Dupr7cwwcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hG1u1rwgLbGB3LPp4aSvH6eD6mJFKquRJ00BiqMbKNQ=;
	b=TAENEz3/cUqoCkuJAW9bBUXzuYtXpYzsOPVfyZ9q04y8iPQXYlz7r04dHuVpIdoUtJyg
	 ecUukZJnLx3SIWURXmkj+M57jd31xCH07u2Wr2Kz6KbE5PFN/VbEjBJ83VaX97TilCRIv
	 GkdW087A8tHU50qfoyfAEC69ykK3eqXEl1die5T3gTyjiV/3Lel4saFisgmSYaN1fHxfr
	 XyfqAsiSb2fXp4RUGl6NmbfWV+/Z5Q5T9pJnniZNsffdfWTkmvCbCn1IsqeXldfhBwB0x
	 lzRzaUfuCTVPgf1citQ572BIHZ8uexoL4JZLZ5CbWOT6J0pKsLIwsGLECv4SWXhaUbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AiOQxD9P;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA42606A334
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 18:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AA42606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AiOQxD9P
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso82090c88.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941368; x=1795546168; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hG1u1rwgLbGB3LPp4aSvH6eD6mJFKquRJ00BiqMbKNQ=;
        b=AiOQxD9PGkfmzM5FEkoFLnVJHlR7N01vc1BJf8J/N9KvrrgeHJMuKRSqBECPU5FuVJ
         3RFIm64M3lgmGG53mBrXEw//mzRV7OLEJdQW1lAvZzbnJY6EVO6Q6ZzlwN3j7dZg7EdQ
         1fdqWnkoczzyCYxCAj3sFHu7qJw/o1TSd/E19YqeFaEoPMQIIoqmWKjvkZDq6d46//M4
         1IiUKUxj9uQbGKTMOpifl5M8Y1HCnKyQfIPWGaMETru5VRQNsKX+XMtfnHbu/AbZy75h
         XdF3ujiUV2HA+XLaute1/BF87+Av0gz3UH11F5aXomOtndLhs+zexUDUKjJauhUBzEKs
         S5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941368; x=1795546168;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hG1u1rwgLbGB3LPp4aSvH6eD6mJFKquRJ00BiqMbKNQ=;
        b=2xIVi7fkpo3mzNAvuQ6IK0Q19kOk3EDCPPj04ocm/KBWnlF/xUY0Y7E9YKbJzrAPza
         7sviLOic3gzVG5EI67nK1Ps7uWeSAVCw7+uiJWDt9y6+HkqGBNnwHEnbajkcaDNVm3sm
         s7zZQ9ZXp/dKPP2vqHJV4yF/dHC6+pWE7J+PF8BaA2ENSC/wT4yj7kfBVzVl/N0tsv5Z
         FItzmRU/YiVSnCdmLcSy7bz+fP9pQKuUY0+T1crAi7LtONAKF0oJURmvJEoip+J2SHMo
         BgP+gUTtYjS6PJrjv+DTLxvEE9vE8cOZ/E7CCFsC4i9v/XLxEZQfJeNQSwiN9LOK5n3i
         nyHw==
X-Forwarded-Encrypted: i=1; AL+hErGjzYhuhiJDWhyhq+ZavGw+fDdk2/KJzj/KqFI3s2N3OiMvzMMB/kN8Jt/1MxtNs1kcBSA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8raGNb4luWpfA7OtBw/kZazPx2sFApM7LlVouwDI/ki5NzU7IC
	tDXnqeqeasnZjNBfgphuFhNcnrCpInCUH/slOuLnRoWUvEkWNgvoQRwTS1u4zou76GH7HG4/X7i
	xeDHHl9fxLA==
X-Received: from dlbov3.prod.google.com ([2002:a05:7022:1183:b0:1b2:cb3a:f87c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef12:b0:1b5:17c5:9f61
 with SMTP id a92af1059eb24-1b543b3301amr536495c88.0.1794941367867; Tue, 17
 Nov 2026 10:49:27 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:33 -0800
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
Message-ID: <20261117184844.99889-13-irogers@google.com>
Subject: [PATCH v14 12/23] perf dsos: Use read lock fast path in dsos__findnew_id()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In dsos__findnew_id(), try finding the DSO under the read lock first and
only acquire the write lock when a new DSO must be inserted or an
existing DSO needs its ID updated (checked via dso__needs_improve_id()).
Prioritize build IDs over inode fields in dso__needs_improve_id() and
__dso__improve_id() so an existing DSO with a defined build ID is not
updated with inode metadata.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c  | 45 +++++++++++++++++++++++++++++-------------
 tools/perf/util/dso.h  |  1 +
 tools/perf/util/dsos.c | 10 ++++++++++
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5be5d224b246..1c938d1b11e9 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1685,6 +1685,20 @@ const struct dso_id dso_id_empty = {
 	}
 };
 
+bool dso__needs_improve_id(const struct dso *dso, const struct dso_id *id)
+{
+	const struct dso_id *dso_id = dso__id_const(dso);
+
+	if (!id || build_id__is_defined(&dso_id->build_id))
+		return false;
+
+	if (build_id__is_defined(&id->build_id))
+		return true;
+
+	return (id->mmap2_valid && !dso_id->mmap2_valid) ||
+	       (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_generation_valid);
+}
+
 void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 {
 	struct dsos *dsos = dso__dsos(dso);
@@ -1692,22 +1706,25 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 	bool changed = false;
 
 	/* dsos write lock held by caller. */
+	if (!id || build_id__is_defined(&dso_id->build_id))
+		return;
 
-	if (id->mmap2_valid && !dso_id->mmap2_valid) {
-		dso_id->maj = id->maj;
-		dso_id->min = id->min;
-		dso_id->ino = id->ino;
-		dso_id->mmap2_valid = true;
-		changed = true;
-	}
-	if (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_generation_valid) {
-		dso_id->ino_generation = id->ino_generation;
-		dso_id->mmap2_ino_generation_valid = true;
-		changed = true;
-	}
-	if (build_id__is_defined(&id->build_id) && !build_id__is_defined(&dso_id->build_id)) {
+	if (build_id__is_defined(&id->build_id)) {
 		dso_id->build_id = id->build_id;
 		changed = true;
+	} else {
+		if (id->mmap2_valid && !dso_id->mmap2_valid) {
+			dso_id->maj = id->maj;
+			dso_id->min = id->min;
+			dso_id->ino = id->ino;
+			dso_id->mmap2_valid = true;
+			changed = true;
+		}
+		if (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_generation_valid) {
+			dso_id->ino_generation = id->ino_generation;
+			dso_id->mmap2_ino_generation_valid = true;
+			changed = true;
+		}
 	}
 	if (changed && dsos)
 		dsos->sorted = false;
@@ -1715,7 +1732,7 @@ void __dso__improve_id(struct dso *dso, const struct dso_id *id)
 
 int dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
 {
-	if (a == &dso_id_empty || b == &dso_id_empty) {
+	if (!a || !b || a == &dso_id_empty || b == &dso_id_empty) {
 		/* There is no valid data to compare so the comparison always returns identical. */
 		return 0;
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index e8cd13c101a6..bb887d10a9ee 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -802,6 +802,7 @@ void dso__delete(struct dso *dso);
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
+bool dso__needs_improve_id(const struct dso *dso, const struct dso_id *id);
 void __dso__improve_id(struct dso *dso, const struct dso_id *id);
 
 int dso__name_len(const struct dso *dso);
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index a7f6a98acbaf..4ff38cb5e2cb 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -349,6 +349,16 @@ static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, const
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const struct dso_id *id)
 {
 	struct dso *dso;
+
+	down_read(&dsos->lock);
+	dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/false);
+	if (dso && !dso__needs_improve_id(dso, id)) {
+		up_read(&dsos->lock);
+		return dso;
+	}
+	up_read(&dsos->lock);
+	dso__put(dso);
+
 	down_write(&dsos->lock);
 	dso = __dsos__findnew_id(dsos, name, id);
 	up_write(&dsos->lock);
-- 
2.56.1.703.gf848ed807c-goog

