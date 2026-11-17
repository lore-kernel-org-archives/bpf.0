Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941365;
	b=T8fYs8PAhRuIxzE5ukTQCMh6GISb33MWwrLo9Z3/OB8xglNAlxLgGrKfp1kQUEezH/ji
	 ENPAbnJ7e80OfjbfMjcmj/ZYLCE839xfZTnBqqnaXxggJ+D0FkwSKStZwGw+3hxfdxzZj
	 7aEuVg5Nzaj5nJjcCBGmhbseXGrj8JmyH1V4g5qm377jjxPuzZ7hixqoKvR3UzWvtBdRY
	 e+qYuqgDpYtaTDkXr980lLU528Vn2Rv+ymR6OsEkAaxbxdQNT01AgdiGjmn82yLU2asir
	 PJyFozqzCLNyVbfbFJVFyArH+Iiu7a1dB/QEb7wOefXsS2aEjlpIoes+doTpAu6dU0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8ggbCEwlfzRbA27+TjU62Ly4PMjFdMyFNzJvu8wfXHU=;
	b=qzsfhkX0O6kWZVDn3nWIpOuUWV83SaIYGmnxudzLFkcO5sd1PLro1QRGiILE79CEKi+l
	 l6Szb37PMcfZ6rRAZpg88XTRiYn4/JBx3/d8CaG92Yg+AGzCcbMe8ThU0D9Oc4Oh7okSL
	 YKnvKv0lW3l8V7ClVLb/BfyxApQzkMwIYizhG56ll91AJ/2qvw0+nkoXJ/N8yZ0VaB4qs
	 BjqohEy08EiBhexEsN5PYZ23ZEfKbwKlxAeyl5S+DEYlOM8Q4KfLecEjUKtEtwC+DgozB
	 r2O012cZAP96pxZe/rQ+HGBpFk4Jd16x4YVkqGHaZe51tkAofXRwiX5UpybUVyHYd/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=emQxVATP;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3A0606A32F
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 18:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E3A0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=emQxVATP
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36fa5673fccso432975eec.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941364; x=1795546164; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ggbCEwlfzRbA27+TjU62Ly4PMjFdMyFNzJvu8wfXHU=;
        b=emQxVATPTNkjvIjWccL+dIH+1FvYRhnr/lIqZlhQj/9gYexHPq2iYHFvQdTUli1lMY
         DV9aae7bJYeh/DOekbsX9UAYQy98HwsjKlK01UnOvZzNUmmwrCqjcfcQGDDjMQ0d0esu
         cqDnXmgaz9cQBmzgv6zuMSGyQsyMsg9/+/Zzyz/qj31gPDWUCmLPst1tUX3clPSZfxOR
         eDtnnU2gBktnOOmOvTv3phRWsic+o4IU9/qBEcNA6VhwCLIovEGsTAd2LvnopYeqbGVF
         4RyKA6bW5j4cY4Ibf6ihW/m2xNGb+DgzpUzyEgzKlYgZIyWfqctON0JLta1W3cO9US7a
         q6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941364; x=1795546164;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ggbCEwlfzRbA27+TjU62Ly4PMjFdMyFNzJvu8wfXHU=;
        b=c76cZZxpa+PU31ybBrHc81jsawXAuUiwR3oPk+hiH5xujLyo8y7i5GOn7GXITXpvnu
         OyNwRmhCEejNFni2vmtR/CIyvi3IeLFq7WAllLhUAN0DydFPw4ko5php96xRpQc1hGRK
         8TBWCpUG+8KknlCTkHUeJ3HW2/ZMoOF6ACjqfiNeDqeBK79A3sSqj/I7NxfK/DP6hf/B
         /Pdw2RPcYcVcnGkPZWJyA47+17b5TiaVXNDCc/3qbOSD5TWLGB/uuBOJfFr27fpCxx9P
         yciY+O70oHyXqVW3y4KLFDVlmM1wVdgm1wF7HHKejJquCsBhW4XScYOXCTSbYBrOHIXU
         dJWA==
X-Forwarded-Encrypted: i=1; AL+hErE60OWei2f/N84m9vqEKYU1Czdhn8E1k3m3fv+dwKUcCUSnbLXfaTZbLKIqLRNhWN1ev5o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+v6D1i7lcIGQYb4WGasq62SdAl2y0Rbpx3KwyzMxDg36qViwc+
	xqo14oZ80VCXHj2X8TP/BCHXOYnnW8yi1ai/zeYsGOMU8QLfTi0IGIB/Kpq30XLPOdeWRso6HQq
	7vg+mqZQ6JQ==
X-Received: from dyjp21.prod.google.com ([2002:a05:7300:4615:b0:351:1933:2028])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c7c4:b0:36a:1d6a:596b
 with SMTP id 5a478bee46e88-382818137a5mr287848eec.29.1794941363998; Tue, 17
 Nov 2026 10:49:23 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:31 -0800
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
Message-ID: <20261117184844.99889-11-irogers@google.com>
Subject: [PATCH v14 10/23] perf dso: Pass dso_data to close_data_fd() and dso__list_del()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

close_data_fd() and dso__list_del() only operate on struct dso_data
fields, while close_first_dso() retrieves a struct dso_data * from
dso__data_open. Pass struct dso_data * directly to close_data_fd() and
dso__list_del() so close_first_dso() does not need to recover a
struct dso * from struct dso_data *.

This removes the REFCNT_CHECKING dso pointer from struct dso_data and
avoids dropping _dso__data_open_lock in dso__list_del() to call
dso__put(), preventing lock-order inversions and races during EMFILE
eviction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 44 ++++++++++++-------------------------------
 tools/perf/util/dso.h |  3 ---
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 3975b6c935a0..3d0ed7b0be54 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "dso.h"
 
+#include <assert.h>
 #include <errno.h>
 #include <stdlib.h>
 
@@ -544,22 +545,14 @@ static struct mutex *dso__data_open_lock(void) __returns_ctx_lock(&_dso__data_op
 static void dso__list_add(struct dso *dso) __must_hold(&_dso__data_open_lock)
 {
 	list_add_tail(&dso__data(dso)->open_entry, &dso__data_open);
-#ifdef REFCNT_CHECKING
-	dso__data(dso)->dso = dso__get(dso);
-#endif
-	/* Assume the dso is part of dsos, hence the optional reference count above. */
+	/* Assume the dso is part of dsos, holding it live while on dso__data_open. */
 	assert(dso__dsos(dso));
 	dso__data_open_cnt++;
 }
 
-static void dso__list_del(struct dso *dso) __must_hold(&_dso__data_open_lock)
+static void dso__list_del(struct dso_data *dso_data) __must_hold(&_dso__data_open_lock)
 {
-	list_del_init(&dso__data(dso)->open_entry);
-#ifdef REFCNT_CHECKING
-	mutex_unlock(dso__data_open_lock());
-	dso__put(dso__data(dso)->dso);
-	mutex_lock(dso__data_open_lock());
-#endif
+	list_del_init(&dso_data->open_entry);
 	WARN_ONCE(dso__data_open_cnt <= 0,
 		  "DSO data fd counter out of bounds.");
 	dso__data_open_cnt--;
@@ -729,13 +722,13 @@ static int open_dso(struct dso *dso, struct machine *machine)
 	return fd;
 }
 
-static void close_data_fd(struct dso *dso) __must_hold(&_dso__data_open_lock)
+static void close_data_fd(struct dso_data *dso_data) __must_hold(&_dso__data_open_lock)
 {
-	if (dso__data(dso)->fd >= 0) {
-		close(dso__data(dso)->fd);
-		dso__data(dso)->fd = -1;
-		dso__data(dso)->file_size = 0;
-		dso__list_del(dso);
+	if (dso_data->fd >= 0) {
+		close(dso_data->fd);
+		dso_data->fd = -1;
+		dso_data->file_size = 0;
+		dso__list_del(dso_data);
 	}
 }
 
@@ -748,21 +741,15 @@ static void close_data_fd(struct dso *dso) __must_hold(&_dso__data_open_lock)
  */
 static void close_dso(struct dso *dso) __must_hold(&_dso__data_open_lock)
 {
-	close_data_fd(dso);
+	close_data_fd(dso__data(dso));
 }
 
 static void close_first_dso(void) __must_hold(&_dso__data_open_lock)
 {
 	struct dso_data *dso_data;
-	struct dso *dso;
 
 	dso_data = list_first_entry(&dso__data_open, struct dso_data, open_entry);
-#ifdef REFCNT_CHECKING
-	dso = dso_data->dso;
-#else
-	dso = container_of(dso_data, struct dso, data);
-#endif
-	close_dso(dso);
+	close_data_fd(dso_data);
 }
 
 static rlim_t get_fd_limit(void)
@@ -1858,9 +1845,6 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		data->fd = -1;
 		data->status = DSO_DATA_STATUS_UNKNOWN;
 		INIT_LIST_HEAD(&data->open_entry);
-#ifdef REFCNT_CHECKING
-		data->dso = NULL; /* Set when on the open_entry list. */
-#endif
 	}
 	return res;
 }
@@ -1918,10 +1902,6 @@ struct dso *dso__get(struct dso *dso)
 
 void dso__put(struct dso *dso)
 {
-#ifdef REFCNT_CHECKING
-	if (dso && dso__data(dso) && refcount_read(&RC_CHK_ACCESS(dso)->refcnt) == 2)
-		dso__data_close(dso);
-#endif
 	if (dso && refcount_dec_and_test(&RC_CHK_ACCESS(dso)->refcnt))
 		dso__delete(dso);
 	else
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 009bd3001ace..a5e8d195f129 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -261,9 +261,6 @@ struct dso_cache {
 struct dso_data {
 	struct rb_root	 cache;
 	struct list_head open_entry;
-#ifdef REFCNT_CHECKING
-	struct dso	 *dso;
-#endif
 	int		 fd;
 	int		 status;
 	u32		 status_seen;
-- 
2.56.1.703.gf848ed807c-goog

