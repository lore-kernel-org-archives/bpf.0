Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941373;
	b=LhpEJ8TvAzlT5iTqHraPLI2QSUH31mMXAxWWY+B6MHU9xawOBh3RFhkeg6MmzxUHaXq0
	 NfqUrO2lkIsw4P7bEaHqeKe4XiLlHWFneXCyzilZ2Oc4z/yOdRGxCfuSdnsZt72tmwVZu
	 8OSlckk+pyfOLoOYnTIJaMBrr6nYgx6HbuMlCp/BuLkRWC/aP/UcyZS5gUcAb5i6s4hmb
	 gNsFC24i/BxwPVA15AYNJQvpR9XIYkSaZVaT81mVwWhtIbqwxLxRus6cSTbR1stI/a9zm
	 7NhZWUWaP3fN68FprGVq/l+RSsGdp0QMPsVhcMMkaa1P2I+b1+SJ137aHTkrgW1vRuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=pXPIGPG54oUqWIojIh2GG7bYUuWDaaWRUZbCMT5Ft+Q=;
	b=mTJ6npEcoBq7bZ1FgxlSBIO39jf7g7B7MAFfa0sp2OoLEscwhEqAR8TxOiCyWz+fyiWM
	 qTy3NsRPGVIzcqBP0k1RfgKk4xcn1q1eXutjIpdv9ar0/7d8VAARktIabdpc47DEpRcms
	 HZqLpDN5DtjpqxN8fnPE7dMLSnf16IChtY5zt0n+wGg5+WF14FEasqmMOuWTXdAa3LLTc
	 HlajfDo5DfZ9KPPyqBzZqxTW6op54o6U5dkoDQvE6vC1qri+gpbemKsRz0XW1vZ9Z8XWX
	 JGyDc3bVD/1kzN6knYtbhjW1p1Wh3kLHYRJRX08do5R3bDW1y5vEZ8cVyweMx6tSlmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IKGxsjAl;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EAF606A890
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 18:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7EAF606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IKGxsjAl
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-37549877380so121082eec.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941372; x=1795546172; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pXPIGPG54oUqWIojIh2GG7bYUuWDaaWRUZbCMT5Ft+Q=;
        b=IKGxsjAlcLpJYwGwC9lPAqZMpQq0UJYaNcnekq0gfHYYExznFXCP6RDicAZkbkSQpj
         tbZkcsqB9Tky1yGmjSfCGx8rQq0q5oBqln1OXVsfYPrXFG4sQcHqzDCTyHQyMri7HZUb
         xn4OolyCtXu3EOjg1wtjCLjtZ8IluxHuuwU7VGl72/akztx4y9MnnkwulItCc08ZBEPY
         DaFvFVgkTD3wiPrGdwss1zUTxT+o7gDGi12JlM9FiNk36DNx85jgKMISTtJ2M6PgVKQ5
         qRGEizpPpSFKO61uJ1VHNDcEfw8lgK/PV0pyI5OjwaBa1Dh8N0NkKJPiEZQvi/cuWz2z
         HEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941372; x=1795546172;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pXPIGPG54oUqWIojIh2GG7bYUuWDaaWRUZbCMT5Ft+Q=;
        b=mjIc+2RApva2UC4oOCyAqJ99LrNGrxrLcknuNdj8LyVMKvZkazKWMmUvUFDjtY5n9Q
         0p7y0Cf143aa0otgDQtOi74bBLbFuoxigj+uSIES80NDFGa8S0r2ON7XoAn4JEXNkfho
         H1nkU6Eiq3h1hlLgty1KdVwq66IjbkBsSLTJTkD48Vfq5kXJqY9eunKrN9Z2hyshrske
         32UKyafkb1nFBXg0BNu8zuP6cF71AArhbUTMC/ziXO5zOsot0pMh9MQbqEfocaaT2trW
         a2hn59gPb1F5ZbgAhaUxQYjFFUWsWnD2ZA7bfZ7r00cX54igqToNrqqhXYRWbezXDOlz
         /Elw==
X-Forwarded-Encrypted: i=1; AL+hErEyJRHwxIuXHtj+ppWVZIjJCcrpR5xwRgitzENlyptyUczSCgw+NllBrXWvt+XCfP+Rssg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KiDrhCiWPjSUtD9cZWPpwqgdprfDo4/SmHAMyvZM8x9ABDFyB
	Z/hG8VC+9cUiEuS/OeTCtrJ7fDaAsFdHwNzXHSeOg55ycWmPS50u7o8vbRDo0Uh3am2BQpCmSMV
	SmVG5wf2/bQ==
X-Received: from dybgk3.prod.google.com ([2002:a05:7301:183:b0:351:1da6:c2e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:710e:b0:369:f182:8e99
 with SMTP id 5a478bee46e88-382828a678dmr300900eec.35.1794941371799; Tue, 17
 Nov 2026 10:49:31 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:35 -0800
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
Message-ID: <20261117184844.99889-15-irogers@google.com>
Subject: [PATCH v14 14/23] perf thread: Expand context analysis annotations to
 threads and namespaces_lock
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate shard and last_match in struct threads_table_entry with
__guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
last_match helpers in util/threads.c.

In util/thread.h and util/thread.c, add __returns_ctx_lock() to
thread__namespaces_lock() and thread__comm_lock(), annotate
namespaces_list and comm_list with __guarded_by(), and add
__must_hold_shared()/__must_hold() to the namespaces_list helpers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread.c  |  2 ++
 tools/perf/util/thread.h  | 28 +++++++++++++++++-----------
 tools/perf/util/threads.c |  4 ++++
 tools/perf/util/threads.h |  6 +++---
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 616d5bf87baf..af761b1fc5d5 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -149,6 +149,7 @@ void thread__put(struct thread *thread)
 }
 
 static struct namespaces *__thread__namespaces(struct thread *thread)
+	__must_hold_shared(thread__namespaces_lock(thread))
 {
 	if (list_empty(thread__namespaces_list(thread)))
 		return NULL;
@@ -169,6 +170,7 @@ struct namespaces *thread__namespaces(struct thread *thread)
 
 static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
 				    struct perf_record_namespaces *event)
+	__must_hold(thread__namespaces_lock(thread))
 {
 	struct namespaces *new, *curr = __thread__namespaces(thread);
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 9d0ce7742c06..a7850eebce4e 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -48,10 +48,10 @@ DECLARE_RC_STRUCT(thread) {
 	bool			exited;
 	bool			comm_set;
 	int			comm_len;
-	struct list_head	namespaces_list;
 	struct rw_semaphore	namespaces_lock;
-	struct list_head	comm_list;
+	struct list_head	namespaces_list __guarded_by(&namespaces_lock);
 	struct rw_semaphore	comm_lock;
+	struct list_head	comm_list __guarded_by(&comm_lock);
 	u64			db_id;
 
 	void			*priv;
@@ -230,30 +230,36 @@ static inline void thread__set_comm_len(struct thread *thread, int len)
 	RC_CHK_ACCESS(thread)->comm_len = len;
 }
 
-static inline struct list_head *thread__namespaces_list(struct thread *thread)
+static inline struct rw_semaphore *thread__namespaces_lock(const struct thread *thread)
+	__returns_ctx_lock(&RC_CHK_ACCESS(thread)->namespaces_lock)
 {
-	return &RC_CHK_ACCESS(thread)->namespaces_list;
+	return (struct rw_semaphore *)&RC_CHK_ACCESS(thread)->namespaces_lock;
 }
 
-static inline int thread__namespaces_list_empty(const struct thread *thread)
+static inline struct list_head *thread__namespaces_list(struct thread *thread)
+	__must_hold_shared(thread__namespaces_lock(thread))
 {
-	return list_empty(&RC_CHK_ACCESS(thread)->namespaces_list);
+	/* Readers hold the shared lock; writers hold the exclusive lock. */
+	return context_unsafe(&RC_CHK_ACCESS(thread)->namespaces_list);
 }
 
-static inline struct rw_semaphore *thread__namespaces_lock(struct thread *thread)
+static inline int thread__namespaces_list_empty(const struct thread *thread)
+	__must_hold_shared(thread__namespaces_lock(thread))
 {
-	return &RC_CHK_ACCESS(thread)->namespaces_lock;
+	return list_empty(&RC_CHK_ACCESS(thread)->namespaces_list);
 }
 
-static inline struct rw_semaphore *thread__comm_lock(struct thread *thread)
+static inline struct rw_semaphore *thread__comm_lock(const struct thread *thread)
+	__returns_ctx_lock(&RC_CHK_ACCESS(thread)->comm_lock)
 {
-	return &RC_CHK_ACCESS(thread)->comm_lock;
+	return (struct rw_semaphore *)&RC_CHK_ACCESS(thread)->comm_lock;
 }
 
 static inline struct list_head *thread__comm_list(struct thread *thread)
 	__must_hold_shared(thread__comm_lock(thread))
 {
-	return &RC_CHK_ACCESS(thread)->comm_list;
+	/* Readers hold the shared lock; writers hold the exclusive lock. */
+	return context_unsafe(&RC_CHK_ACCESS(thread)->comm_list);
 }
 
 static inline u64 thread__db_id(const struct thread *thread)
diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index 5db81b9debb5..7cf951cbc963 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -24,6 +24,7 @@ static bool key_equal(long key1, long key2, void *ctx __maybe_unused)
 }
 
 void threads__init(struct threads *threads)
+	__context_unsafe(/* initialization */)
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
@@ -35,6 +36,7 @@ void threads__init(struct threads *threads)
 }
 
 void threads__exit(struct threads *threads)
+	__context_unsafe(/* teardown */)
 {
 	threads__remove_all_threads(threads);
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
@@ -66,6 +68,7 @@ size_t threads__nr(struct threads *threads)
  */
 static struct thread *__threads_table_entry__get_last_match(struct threads_table_entry *table,
 							    pid_t tid)
+	__must_hold_shared(&table->lock)
 {
 	struct thread *th, *res = NULL;
 
@@ -79,6 +82,7 @@ static struct thread *__threads_table_entry__get_last_match(struct threads_table
 
 static void __threads_table_entry__set_last_match(struct threads_table_entry *table,
 						  struct thread *th)
+	__must_hold(&table->lock)
 {
 	thread__put(table->last_match);
 	table->last_match = thread__get(th);
diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index da68d2223f18..54fba16657db 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -11,10 +11,10 @@ struct thread;
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-	/* Key is tid, value is struct thread. */
-	struct hashmap	       shard;
 	struct rw_semaphore    lock;
-	struct thread	       *last_match;
+	/* Key is tid, value is struct thread. */
+	struct hashmap	       shard __guarded_by(&lock);
+	struct thread	       *last_match __guarded_by(&lock);
 };
 
 struct threads {
-- 
2.56.1.703.gf848ed807c-goog

