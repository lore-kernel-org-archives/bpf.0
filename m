Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815120;
	b=DpySuv9wg+DLF0gaoQD5aOyTsQaL8EFZ+WQW5XWBYeOCQdG409A7oiTKeYeUDC6NlFPG
	 Ua4OvPjPZo+7kw8hMXh4s6aBWQApXp7zG8dtp9iKtEF9YBn0LRMUUy5lAZjzuLFWT/WGf
	 DHeeBObUQHgD8hDNEkuBt368oG6oUlFDhsWT2iWKxUS5SZwVib5uq5fFJm8dEoOa8ziYJ
	 f0X2hc5ggn9+Id/NpFjH89SBPIDyE6EvKfkQ8yt7HDqxgL6n5zCD4HLjZlMI2iVsRb6ja
	 giAmxaIzuVAI+FgaJC5R/24kBcHKNe+1Aqg1AJU4hWLMIRpnPwsndinaO2NjVDXNWZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=imQsytKanyvOGoydM1NIQki1Q8sgXr5rCd0tThSCpWU=;
	b=okmF34eXFLGAiheSQl/Itl7DF3UqVNBShVKmvCp0OFLH3Ow4wNszFmEQ4q46C2dUQgIS
	 CaERso5Z6k+o0veYWn6CRU5vHC28bFxEXw+fkc/DIBkxafFVBhJzKgZgXRrgTxDrEBGxg
	 +wrwkE0X6LbKoRglLUzQYLRKlE26NHy7tIX9mSbsilSAE87NJ5gpTzzFThOM6jKz2yV85
	 KO2GLmjjf4eSwcY1munYYU4+tN6rYzggDkbyOwHA+KfhD5mxzhIhciPax1AKEuHmuVGKL
	 x2ZEukS+IA9FKF1BLWeVms7pxNraqqX4WZK46g4Z2ZqoFayQXPdg0S+g3vXqfAANYxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cOjuBTzS;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AEE606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92AEE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cOjuBTzS
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-378722fd4a3so3698112eec.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 23:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815120; x=1795419920; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=imQsytKanyvOGoydM1NIQki1Q8sgXr5rCd0tThSCpWU=;
        b=cOjuBTzS2fPccWCPg0Wl2YhnQqW8ktGVUZsU5p0IySyF0BTt3XBLxusOtxf84p9QmE
         /b0hBatcZY7Fybrx9hZMVCbDmZshcYEx6MO2Hja/SKeromXM/vwdVCe1qmRD+muWezWI
         YGTSH570W+tx4zCOJ31QZNvASLwdH1YZBdnk/qhc/RS8paOAxaYNEOweAbGBGjOcmXmh
         NDOr23FLJ18K9Gk5QQlscfI/xCpuB4PxlBUh9yUlHPZWyCnsDmqFAKcljbsi8d9EpAzk
         5skg25Xgp/eeNqBwl8PYiOfitflLDx82U6UgNNZLdXjhXqfEIjZjvMgfMfuiKAJCykEu
         JO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815120; x=1795419920;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=imQsytKanyvOGoydM1NIQki1Q8sgXr5rCd0tThSCpWU=;
        b=ipIs7oRtpcAFlkDGD1tU7HMXicyxP0c8qKpF7csH2EETiWb4TScd4i7tWxZ4DrhCDn
         pIqofFLc75ZtOIGNgtqEaCf9AdKKFbX1C7Xx3JWO28QQYIDprimI6eYct3vws6lC3wrJ
         tmYH1WC+txD6YlGsABf+xQ7xhrWDXR1WUEqTGKkkseNyiWalP8BlJziDAi1kFzcYup+P
         wof6TR/yIoFAEyy96jC45J1psiiM+zNw0kpxFql4uwXUKxE/kjUEp3jaxl2+TTPQkhsy
         Ee9NHqjaU5RSkxJmHfCrzDP80HUI2b9VTzn4WEt8gudexBWPXeHDUwD5J7ac6lrQG3tH
         spEQ==
X-Forwarded-Encrypted: i=1; AL+hErFBTy6+b9PmefZu5FXuHz8yVTwsgooc+hNDSsimqBaSz4pxqt1kX+ljse+OKqP5kEndDPg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+R2v05E0N6rIZVvUp+3bXsebRw0jqS9PRAeJp8WaCJrxYvn508
	lsmDOPHW1kt2jgudlLZZb09c1Rhf1WpVxHkiMWUFtkfhEDCdpfISuqML3V5gdGjYh1BzkaaP+jR
	GPzhwj68H5w==
X-Received: from dybla1.prod.google.com ([2002:a05:7301:1a81:b0:36c:99b8:3ed7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8115:b0:36a:1008:5815
 with SMTP id 5a478bee46e88-37963372d85mr10634688eec.5.1794815119285; Sun, 15
 Nov 2026 23:45:19 -0800 (PST)
Date: Sun, 15 Nov 2026 23:44:01 -0800
In-Reply-To: <20261116074414.3174737-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-7-irogers@google.com>
Subject: [PATCH v3 06/19] perf/core: Support deferred unwinding for
 BUILD_ID_OFFSET sample types
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When attr.defer_callchain is set on events using
PERF_SAMPLE_BUILD_ID_OFFSET or PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET,
request a deferred user-space unwind via unwind_deferred_request() and
emit a PERF_CONTEXT_USER_DEFERRED marker and cookie in the sample.

In the faultable task_work callback (perf_unwind_deferred_callback()),
resolve the unwound user IPs to build IDs and file offsets using
stack_map_get_build_id_offset(..., may_fault=true), encode them into the
compressed build ID + offset format, and emit
PERF_RECORD_CALLCHAIN_DEFERRED with PERF_RECORD_MISC_MMAP_BUILD_ID set.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 175 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 164 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d38ffe52c301..ef40c4442e82 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -460,6 +460,8 @@ static atomic_t nr_bpf_events __read_mostly;
 static atomic_t nr_cgroup_events __read_mostly;
 static atomic_t nr_text_poke_events __read_mostly;
 static atomic_t nr_build_id_events __read_mostly;
+static atomic_t nr_defer_output_build_id_events __read_mostly;
+static atomic_t nr_defer_output_callchain_build_id_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -5639,6 +5641,25 @@ static void detach_perf_ctx_data(struct perf_event *event)
 	}
 }
 
+static bool has_defer_output_callchain_build_id_offset(const struct perf_event *event)
+{
+	return event->attr.defer_output &&
+	       (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) &&
+	       !(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+	       !event->attr.exclude_callchain_user;
+}
+
+static bool has_defer_output_build_id_offset(const struct perf_event *event)
+{
+	if (!event->attr.defer_output)
+		return false;
+	if (has_defer_output_callchain_build_id_offset(event))
+		return true;
+	return (event->attr.sample_type & PERF_SAMPLE_BUILD_ID_OFFSET) &&
+	       (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
+		event->attr.exclude_callchain_user);
+}
+
 static void unaccount_event(struct perf_event *event)
 {
 	bool dec = false;
@@ -5652,6 +5673,10 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_mmap_events);
 	if (event->attr.build_id)
 		atomic_dec(&nr_build_id_events);
+	if (has_defer_output_build_id_offset(event))
+		atomic_dec(&nr_defer_output_build_id_events);
+	if (has_defer_output_callchain_build_id_offset(event))
+		atomic_dec(&nr_defer_output_callchain_build_id_events);
 	if (event->attr.comm)
 		atomic_dec(&nr_comm_events);
 	if (event->attr.namespaces)
@@ -8399,6 +8424,8 @@ static void perf_output_read(struct perf_output_handle *handle,
 		perf_output_read_one(handle, event, enabled, running);
 }
 
+static struct unwind_work perf_unwind_work;
+
 static void perf_bpf_to_sample_bid_offset(struct bpf_stack_build_id *bpf_bid)
 {
 	struct perf_sample_build_id_offset *bid = (void *)bpf_bid;
@@ -8434,7 +8461,28 @@ static void perf_output_sample_build_id(struct perf_output_handle *handle,
 		       PERF_RECORD_MISC_USER;
 
 	if (sample_bid) {
-		if (is_user && has_user_ctx) {
+		u64 defer_cookie = 0;
+		bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) &&
+				  is_user && has_user_ctx &&
+				  event->attr.defer_callchain &&
+				  (!(sample_type & PERF_SAMPLE_CALLCHAIN) ||
+				   event->attr.exclude_callchain_user) &&
+				  data->ip == instruction_pointer(task_pt_regs(current));
+
+		if (defer_user &&
+		    unwind_deferred_request(&perf_unwind_work, &defer_cookie) < 0)
+			defer_cookie = 0;
+
+		if (defer_cookie) {
+			u64 deferred_bid[4] = {
+				0,
+				PERF_CONTEXT_USER_DEFERRED,
+				defer_cookie,
+				data->ip,
+			};
+
+			perf_output_put(handle, deferred_bid);
+		} else if (is_user && has_user_ctx) {
 			if (callchain_bid && data->callchain_build_id &&
 			    data->callchain_build_id->has_ip_bid) {
 				perf_output_put(handle,
@@ -8811,8 +8859,6 @@ static u64 perf_get_page_size(unsigned long addr)
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
-static struct unwind_work perf_unwind_work;
-
 struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
@@ -10635,34 +10681,117 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 
 struct perf_callchain_deferred_event {
 	struct unwind_stacktrace *trace;
+	struct perf_callchain_build_id_entry *bid_entry;
 	struct {
 		struct perf_event_header	header;
 		u64				cookie;
 	} event;
 };
 
+static struct perf_callchain_build_id_entry *
+perf_resolve_build_id_offsets(struct unwind_stacktrace *trace)
+{
+	struct perf_callchain_build_id_entry *entry;
+	struct bpf_stack_build_id *bpf_bids;
+	u16 nr = trace->nr;
+	u32 max_size;
+
+	if (!nr || !current->mm ||
+	    !atomic_read(&nr_defer_output_build_id_events))
+		return NULL;
+
+	if (!atomic_read(&nr_defer_output_callchain_build_id_events))
+		nr = 1;
+
+	entry = kzalloc(sizeof(*entry) + nr * sizeof(u64), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	bpf_bids = kcalloc(nr, sizeof(*bpf_bids), GFP_KERNEL);
+	if (!bpf_bids) {
+		kfree(entry);
+		return NULL;
+	}
+
+	for (u16 i = 0; i < nr; i++) {
+		entry->offsets[i] = trace->entries[i];
+		bpf_bids[i].ip = trace->entries[i];
+	}
+
+	stack_map_get_build_id_offset(bpf_bids, nr, true, true);
+
+	max_size = round_down(U16_MAX - sizeof(struct perf_event_header) -
+			      2 * sizeof(u64), sizeof(u64));
+	perf_callchain_encode_build_ids(entry, entry->offsets, nr, 0,
+					bpf_bids, nr, max_size);
+	kfree(bpf_bids);
+	return entry;
+}
+
 static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 {
 	struct perf_callchain_deferred_event *deferred_event = data;
+	struct perf_callchain_build_id_entry *bid_entry = deferred_event->bid_entry;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	u64 nr = deferred_event->trace->nr;
-	u16 size, id_size, max_payload;
+	u32 max_offsets = 0, nr_build_ids = 0, nr_offsets = 0;
+	u32 raw_bids_len = 0, aligned_bids_len = 0;
+	bool use_bid;
+	u16 size, misc, id_size, max_payload;
 	int ret;
 
 	if (!event->attr.defer_output)
 		return;
 
+	use_bid = has_defer_output_build_id_offset(event);
+	if (use_bid && bid_entry) {
+		if (has_defer_output_callchain_build_id_offset(event))
+			max_offsets = bid_entry->nr_offsets;
+		else
+			max_offsets = min_t(u32, bid_entry->nr_offsets, 1);
+	}
+
 	id_size = event->attr.sample_id_all ? event->id_header_size : 0;
 	max_payload = round_down(U16_MAX - sizeof(deferred_event->event) -
 				 sizeof(u64) - id_size, sizeof(u64));
-	nr = min_t(u64, nr, max_payload / sizeof(u64));
-	size = sizeof(deferred_event->event) + sizeof(u64) + nr * sizeof(u64);
+
+	if (use_bid) {
+		for (u32 i = 0; i < max_offsets; i++) {
+			u8 bid_idx = bid_entry->offsets[i] >> 56;
+			u32 next_nr_bids = nr_build_ids;
+			u32 next_raw_len = raw_bids_len;
+			u32 next_aligned_len;
+
+			if (bid_idx > 0 && bid_idx <= bid_entry->nr_build_ids &&
+			    bid_idx > next_nr_bids) {
+				next_nr_bids = bid_idx;
+				next_raw_len = next_nr_bids *
+					       (1 + BUILD_ID_SIZE_MAX);
+			}
+			next_aligned_len = ALIGN(next_raw_len, sizeof(u64));
+			if (next_aligned_len + (i + 1) * sizeof(u64) > max_payload)
+				break;
+			nr_build_ids = next_nr_bids;
+			raw_bids_len = next_raw_len;
+			aligned_bids_len = next_aligned_len;
+			nr_offsets = i + 1;
+		}
+		size = sizeof(deferred_event->event) + sizeof(u64) +
+		       aligned_bids_len + nr_offsets * sizeof(u64);
+	} else {
+		nr = min_t(u64, nr, max_payload / sizeof(u64));
+		size = sizeof(deferred_event->event) + sizeof(u64) +
+		       nr * sizeof(u64);
+	}
+
+	misc = PERF_RECORD_MISC_USER |
+	       (use_bid ? PERF_RECORD_MISC_MMAP_BUILD_ID : 0);
 
 	/* XXX do we really need sample_id_all for this ??? */
 	perf_event_header__init(&deferred_event->event.header, &sample,
 				PERF_RECORD_CALLCHAIN_DEFERRED,
-				PERF_RECORD_MISC_USER,
+				misc,
 				size,
 				event);
 
@@ -10672,11 +10801,27 @@ static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 		return;
 
 	perf_output_put(&handle, deferred_event->event);
-	perf_output_put(&handle, nr);
-	for (u64 i = 0; i < nr; i++) {
-		u64 entry = deferred_event->trace->entries[i];
+	if (use_bid) {
+		u64 pad_zero = 0;
+		u32 pad = aligned_bids_len - raw_bids_len;
+
+		perf_output_put(&handle, nr_build_ids);
+		perf_output_put(&handle, nr_offsets);
+		if (raw_bids_len)
+			__output_copy(&handle, bid_entry->build_ids, raw_bids_len);
+		if (pad)
+			__output_copy(&handle, &pad_zero, pad);
+		if (nr_offsets) {
+			__output_copy(&handle, bid_entry->offsets,
+				      nr_offsets * sizeof(u64));
+		}
+	} else {
+		perf_output_put(&handle, nr);
+		for (u64 i = 0; i < nr; i++) {
+			u64 entry = deferred_event->trace->entries[i];
 
-		perf_output_put(&handle, entry);
+			perf_output_put(&handle, entry);
+		}
 	}
 	perf_event__output_id_sample(event, &handle, &sample);
 
@@ -10686,14 +10831,18 @@ static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 static void perf_unwind_deferred_callback(struct unwind_work *work,
 					 struct unwind_stacktrace *trace, u64 cookie)
 {
+	struct perf_callchain_build_id_entry *bid_entry =
+		perf_resolve_build_id_offsets(trace);
 	struct perf_callchain_deferred_event deferred_event = {
 		.trace = trace,
+		.bid_entry = bid_entry,
 		.event = {
 			.cookie = cookie,
 		},
 	};
 
 	perf_iterate_sb(perf_callchain_deferred_output, &deferred_event, NULL);
+	kfree(bid_entry);
 }
 
 struct perf_text_poke_event {
@@ -13552,6 +13701,10 @@ static void account_event(struct perf_event *event)
 		atomic_inc(&nr_mmap_events);
 	if (event->attr.build_id)
 		atomic_inc(&nr_build_id_events);
+	if (has_defer_output_build_id_offset(event))
+		atomic_inc(&nr_defer_output_build_id_events);
+	if (has_defer_output_callchain_build_id_offset(event))
+		atomic_inc(&nr_defer_output_callchain_build_id_events);
 	if (event->attr.comm)
 		atomic_inc(&nr_comm_events);
 	if (event->attr.namespaces)
-- 
2.56.1.703.gf848ed807c-goog

