Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316832;
	b=1mW1VodkkjINxJrm6r/t9hupl46qMrDP8ZtWMujAG9F9gQbBG/WlH0qmANyKil02rzMx
	 2HaaTnsI6nsKgpPc+I3BBrdeP5VeRMKu9DLzy+sMT8WmgFArRDX8RNnmZxSCTQSJLgdvU
	 +J/0b5JAEQuyEwxolJAbKp9v87yC8VZY88B7uBwV0WM+0sJbJ/Ug/A5lUDIGUUc8QtRoT
	 LD4KL/yr2yAFP1jg4ujDus8z0Bv5sXgI4Ct8lukLFEhBr3leOVFZyLy2gbedFeDuoAmHZ
	 A9BAVVq4qaXEKya4eP5T0mw9Smyjz4G9hbVO7Y/CEERgGq46+5E5mX3ojsIXt6FbhBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316832;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5ZYn6g5KvoKQBfSrzv4r7DYQHQqIRbGBYmHd2osdmPg=;
	b=0nrHCuO16E8t1n5heSYvRWZ40pXvxcuyOZPn8sLIzX8IJZMV8n4MtT4xB/X60/E55the
	 ghXvp1qta6rlsacdMtXo+dGXyTe3sSFRJwUh5OxRby1uXghSo0ro4aljESFGzHTOZ7vjt
	 siL9XFxBniaC4oTyqECx96V7ASo3fNzhIZsbAK7wey3hUF8Pn7VwDpbrWlQAPAUuMjNgb
	 pz1PAokOJ3Z+ZSAGkekZo8GDzvwkwBrnGyxzlX2/oXEQuo/e0vDPkx5mMppSAWNCt/Z0n
	 05ASUsdRYwlfvbZWK0669kBp5Y/wlfXgGSj95lrLZcqtS5N9CHh1MIGrLt1Yv6lBPkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ayLPJYB0;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=euXWtkgy;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA3607683E
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5CA3607683E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ayLPJYB0;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=euXWtkgy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZYn6g5KvoKQBfSrzv4r7DYQHQqIRbGBYmHd2osdmPg=;
	b=ayLPJYB0crduJYSPLE0XJndfqWdG2PhlxOiLubmeGSMjhhpJ5BrqWEXk/eGiDRTkz0FAXQ
	NZKfIanXOBsHkmzb37VKNRBtWDsFD+FwRwyE+Yz2hgOWu2Z7Kr7MF6gU9HN2v8qyY3UG1w
	bvnLbl8j9VX7lPHpdKQUAv77mHbExJQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-kkmMCY2YNlCnnv9puJBB_w-1; Tue, 10 Nov 2026 08:20:29 -0500
X-MC-Unique: kkmMCY2YNlCnnv9puJBB_w-1
X-Mimecast-MFC-AGG-ID: kkmMCY2YNlCnnv9puJBB_w_1794316828
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c505ee610feso13101166b.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316828; x=1794921628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ZYn6g5KvoKQBfSrzv4r7DYQHQqIRbGBYmHd2osdmPg=;
        b=euXWtkgyfTM95UuZaRgtaBJQGbW90bAgiIqj+7QnBtc7ZMzREnAFT73dGaW1/SVvxs
         ubG1ZQbL2WuRcig+5iCSh7RPRw8VhAw5TJP++tDR4rjL/mmB+ivJDvK4zdSiz2Ow1nc6
         Pc5qoSNH11NSfXpE71LCm1ISWzA2mxiEz7oxy3RbTX2oF+LVVNlhq9Ldk6ix7ETITFrC
         4gJg+F69ozAM34WtPOrWjaW36PSc3V2hB9q3ujz7vhYQsWI2upakVY5FjzCq+MH+c3nM
         +jD2Ugs0SLOSy7eoZmxRoA/LZwEG1TuUoKkZSUZU9vowE7vJaAQTtVVDpsazrUG2MQ61
         Dqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316828; x=1794921628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ZYn6g5KvoKQBfSrzv4r7DYQHQqIRbGBYmHd2osdmPg=;
        b=XYpvTvWX3aYSiz6WiReSkKxrkH7uElkN211AhTY9GQRkO8sEfNZCAaFRd9gXsC4vU9
         dQwRGvJvuVytPkjVnolL512n28jaT8qhTLRPbgGoUEWSYuZbto8A3u+/NWAFB2oq6XGz
         C8zQkc126TGEOSwCkMdZKg1pHeD0h1AsIrwRReapPB6FJvKk8gmX5QTRHWMSNs1bY7fn
         g899YjMXEMzSiBF4wSbWRW7QOIAZWnZ11hQUWS68TxiW9LyIwD0Tczidxv69O0ZxommX
         1dvhtqbPx8N75nsr0HM5k5aVGVeIc4bZ7EkqZr82IcFwqgtxyq397PU0zVHuNa0OkhLw
         jiAQ==
X-Forwarded-Encrypted: i=1; AL+hErHO+cCKhQJPiAXdW7BG3MPzOGULf4VIQTfrn306PjtzSj5iHBt07kRmxAdNQmF7rPDxXW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2VNATI+hkTJ2LOH/dy2RIb0V4R5NU39Ax2fVR3dQ7vAwmfhEl
	0OYhv4odgQ1ohLJxVowO1MvW/3L8EksBCdVX88o8Pz4UfcrQss/WE6Gop1CyAOwp9DrB5lHOEBd
	DorAwuIg/VpX+brmjvAbVgZHCRWpdvIcMY1lu5oxeLFS5yah45tBu8A==
X-Gm-Gg: AYBFou1Yu9RkQFnh1jBalb7MN+uKjmVKa+05+IZ1n+96LQIe8OEKBGAEZdXMcRUHNX4
	qTAt5kXmT7X9vXiRDVPu7WFUbovtN6XZTlkCGfdol5IiPaISk17O37PO9d76MWFzglToA/mCrSl
	G1Lq5tF9smoVl+i7DMynpbqbemI9oC/12tjWcKB2N3RibYmBRf5rg03ekmmdbtjodsfFZy2oeCf
	41KzbwcYnZHOlr8845IHTuCQQT95iUM7hcH34oW334vpom9adFArF+sa+Wre6WiqLupzlo5Cs83
	AKUl2yGgpRJVOy1g8ifTZ+WtF1xkJ120TP3dp6T2cZ3MiNnAtnisUo8wcbPtCJ0/kIUtmzQnAxL
	r8V31w7+DFtWJTwNHicDl2R0WnQwT1/KCw1MZ7BJGPdmUxXHKvtcx4SiLcjsgohPCA7YvSHdcCH
	B9seWLEZsjvTjxUCSjAkWUMT3163O5KOPcZpMo6Tkh6t16siS4gAC82PSx8hlaotuE3Kv1A4geO
	7yqjP6BvaOM/115tzyafNX5fwWxMEiA6qdOCNC+A9EYBZ/xtflY
X-Received: by 2002:a17:907:3f28:b0:c31:7495:e57 with SMTP id a640c23a62f3a-c50496e6ccdmr217739466b.44.1794316827469;
        Tue, 10 Nov 2026 05:20:27 -0800 (PST)
X-Received: by 2002:a17:907:3f28:b0:c31:7495:e57 with SMTP id a640c23a62f3a-c50496e6ccdmr217736766b.44.1794316826703;
        Tue, 10 Nov 2026 05:20:26 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:25 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 11/12] io_uring/opaque: add manual and automatic compaction
Date: Tue, 10 Nov 2026 13:20:05 +0000
Message-Id: <20261110132006.3280986-12-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110132006.3280986-1-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse retained receive allocations can cost much more backing capacity
than their payload length. Add COMPACT to copy an object into dense
backing and publish the replacement under the same handle. Requests
already using the old version keep their references. A dense object
completes immediately; concurrent compaction of the same object returns
-EBUSY.

SET_POLICY configures automatic compaction with a flag, byte rate, burst
size and per-copy temporary-backing limit. Preparation snapshots the
policy when its SQE is consumed. Updating candidates walks the object
table in chunks of 256, dropping the mutex and yielding between chunks.
Newly published objects see the new policy immediately; a newer update
stops an older walk. Store shutdown ends the update with -ESHUTDOWN.

One delayed work item serializes copies for each store. A run handles up
to eight manual requests and one automatic copy. Automatic selection
examines up to 32 candidates and skips young, forwarding-only and dense
objects. It estimates a nonnegative saving from current charge minus the
page-rounded payload length, considering an estimate of at least a quarter
of the charge or multiple source extents with zero estimated saving.
Selection does not guarantee fewer destination extents or an immediate
reduction in retained charge: allocations can fall back to smaller orders,
and old versions or shared backing may remain pinned. Rate tokens and a
100-ms scan interval bound automatic work. These rules are implementation
heuristics, not ABI guarantees.

Every copy reserves destination capacity under the hard store limit.
Publication requires that the handle still name the source version; if
FREE or LAST removed it, the replacement is discarded. Compaction never
evicts an object. Disabling automatic work preserves accepted manual
requests; shutdown completes them and waits for the work item to finish.
Run reserve/build, publication and accounting settlement in the existing
per-store dispatcher before readiness enqueue. A deferred ring owns only
delivery of the decided result, not active accounting or source pins, so
independent shared-backing copies cannot be excluded by idle ring task work.
Only concurrent compaction of the same slot returns EBUSY.

Prepare whole extent releases before final version zero, including shared
versions and releases started before tagging. Retain backing metadata
through prepared puts, credit source charge after physical release, and
settle credits, unused reservation and transient exclusion coherently.
Keep a private published-replacement pin through the handoff. Predicate
waitqueues drain already-started frees, not live readers; physical frees,
mode updates and wakes occur outside accounting spinlocks.

Failed setup detaches partial tags before returning. Automatic setup
failure refunds tokens within the same policy generation and burst.
Publication and cancellation share a bounded commit decision; committed
copies cannot be retroactively canceled or published twice by task work.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/uapi/linux/io_uring/opaque.h |   1 +
 io_uring/opaque.c                    | 363 ++++++++++++++++++++++--
 io_uring/opaque.h                    |   6 +
 io_uring/opaque_compact.c            | 394 ++++++++++++++++++++++++++-
 io_uring/opaque_internal.h           |  25 +-
 5 files changed, 757 insertions(+), 32 deletions(-)

diff --git a/include/uapi/linux/io_uring/opaque.h b/include/uapi/linux/io_uring/opaque.h
index c04eaed8ce5f..410061906684 100644
--- a/include/uapi/linux/io_uring/opaque.h
+++ b/include/uapi/linux/io_uring/opaque.h
@@ -92,6 +92,7 @@ struct io_uring_opaque_frame {
 #define IORING_OPAQUE_OBJECT_F_COMPACTING	(1U << 1)
 #define IORING_OPAQUE_OBJECT_F_FORWARD_ONLY (1U << 2)
 #define IORING_OPAQUE_STREAM_F_EOF		(1U << 0)
+#define IORING_OPAQUE_POLICY_F_AUTO_COMPACT	(1U << 0)
 
 enum io_uring_opaque_memory_mode {
 	IORING_OPAQUE_MEMORY_NORMAL,
diff --git a/io_uring/opaque.c b/io_uring/opaque.c
index 78ae19a6ad82..59752db9a041 100644
--- a/io_uring/opaque.c
+++ b/io_uring/opaque.c
@@ -282,17 +282,30 @@ bool io_opaque_charge_transient(struct io_opaque_store *store, u64 bytes, u64 li
 	return charged;
 }
 
-/* Uncharge and stop excluding transient bytes; the two amounts may differ. */
-void io_opaque_release_transient(struct io_opaque_store *store, u64 uncharge,
-				 u64 transient)
+static void io_opaque_release_transient_locked(struct io_opaque_store *store,
+					       u64 uncharge, u64 transient)
 {
-	spin_lock(&store->transient_lock);
+	lockdep_assert_held(&store->transient_lock);
 	write_seqcount_begin(&store->transient_seq);
 	atomic64_sub(uncharge, &store->bytes);
 	atomic64_sub(transient, &store->transient);
 	write_seqcount_end(&store->transient_seq);
+}
+
+static void io_opaque_release_transient_quiet(struct io_opaque_store *store,
+					      u64 uncharge, u64 transient)
+{
+	spin_lock(&store->transient_lock);
+	io_opaque_release_transient_locked(store, uncharge, transient);
 	spin_unlock(&store->transient_lock);
 	io_opaque_memory_mode(store);
+}
+
+/* Uncharge and stop excluding transient bytes; the two amounts may differ. */
+void io_opaque_release_transient(struct io_opaque_store *store, u64 uncharge,
+				 u64 transient)
+{
+	io_opaque_release_transient_quiet(store, uncharge, transient);
 	if (uncharge)
 		io_opaque_wake_budget(store);
 }
@@ -396,6 +409,157 @@ no_space:
 	return ERR_PTR(-ENOBUFS);
 }
 
+static void io_opaque_handoff_put(struct io_opaque_handoff *handoff)
+{
+	if (handoff && refcount_dec_and_test(&handoff->refs))
+		kfree(handoff);
+}
+
+/* Wake outside transient_lock, with a reference spanning a racing settler. */
+static void io_opaque_handoff_wake(struct io_opaque_handoff *handoff)
+{
+	if (handoff) {
+		wake_up_all(&handoff->wait);
+		io_opaque_handoff_put(handoff);
+	}
+}
+
+/* A failed setup owns no physical source free: its version pin is still held. */
+static void io_opaque_compact_unreserve(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_handoff *handoff = op->handoff;
+	struct io_opaque_extent *extent;
+
+	if (op->data) {
+		list_for_each_entry(extent, &op->data->extents, list) {
+			struct io_opaque_backing *backing = extent->backing;
+			bool put = false;
+
+			spin_lock(&store->transient_lock);
+			if (backing->handoff == handoff) {
+				handoff->pending -= backing->pending;
+				backing->handoff = NULL;
+				put = true;
+			}
+			spin_unlock(&store->transient_lock);
+			if (put)
+				io_opaque_handoff_put(handoff);
+		}
+	}
+	op->handoff = NULL;
+	io_opaque_handoff_put(handoff);
+}
+
+/* Tag while the source pin still owns every backing, before allocating a copy. */
+int io_opaque_compact_reserve(struct io_opaque_req *op, u64 charge)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_handoff *handoff;
+	struct io_opaque_extent *extent;
+	struct mem_cgroup *old;
+
+	old = set_active_memcg(store->memcg);
+	handoff = kzalloc_obj(*handoff, GFP_KERNEL_ACCOUNT);
+	set_active_memcg(old);
+	if (!handoff)
+		return -ENOMEM;
+	refcount_set(&handoff->refs, 1);
+	init_waitqueue_head(&handoff->wait);
+	handoff->active = true;
+	op->handoff = handoff;
+	if (op->data) {
+		list_for_each_entry(extent, &op->data->extents, list) {
+			struct io_opaque_backing *backing = extent->backing;
+			struct io_opaque_handoff *previous;
+
+			spin_lock(&store->transient_lock);
+			previous = backing->handoff;
+			/* The dispatcher settles each copy before starting the next. */
+			if (previous != handoff) {
+				refcount_inc(&handoff->refs);
+				backing->handoff = handoff;
+				handoff->pending += backing->pending;
+			}
+			spin_unlock(&store->transient_lock);
+			if (previous != handoff)
+				io_opaque_handoff_put(previous);
+			cond_resched();
+		}
+	}
+	if (!io_opaque_charge_transient(store, charge,
+					store->config.hard_limit - store->config.reply_reserve)) {
+		io_opaque_compact_unreserve(op);
+		return -ENOBUFS;
+	}
+	op->transient = charge;
+	op->reserved = charge;
+	return 0;
+}
+
+static void io_opaque_backing_release(struct io_opaque_store *store,
+				      struct io_opaque_backing *backing)
+{
+	if (backing->accounted)
+		io_opaque_memcg_uncharge(store, backing->charge);
+	put_page(backing->page);
+}
+
+/*
+ * Finish one prepared put. Its pending count keeps backing metadata alive even
+ * if another put releases the last physical reference before this one returns.
+ */
+static u64 io_opaque_backing_done(struct io_opaque_store *store,
+				  struct io_opaque_backing *backing, bool released)
+{
+	struct io_opaque_handoff *handoff, *wake = NULL;
+	u64 charge = released ? backing->charge : 0;
+	bool free;
+
+	spin_lock(&store->transient_lock);
+	handoff = backing->handoff;
+	if (released)
+		backing->released = true;
+	if (handoff && handoff->active) {
+		handoff->released += charge;
+		charge = 0;
+		if (!--handoff->pending) {
+			refcount_inc(&handoff->refs);
+			wake = handoff;
+		}
+	}
+	free = !--backing->pending && backing->released;
+	spin_unlock(&store->transient_lock);
+	io_opaque_handoff_wake(wake);
+	if (free) {
+		io_opaque_handoff_put(handoff);
+		kfree(container_of(backing, struct io_opaque_chunk, backing));
+	}
+	return charge;
+}
+
+/* Register even without a tag: a later copy adopts already-started releases. */
+static void io_opaque_extent_release_begin(struct io_opaque_store *store,
+					   struct io_opaque_extent *extent)
+{
+	struct io_opaque_handoff *handoff;
+
+	guard(spinlock)(&store->transient_lock);
+	extent->backing->pending++;
+	handoff = extent->backing->handoff;
+	if (handoff && handoff->active)
+		handoff->pending++;
+}
+
+static void io_opaque_extents_release_begin(struct io_opaque_store *store,
+					    struct list_head *list)
+{
+	struct io_opaque_extent *extent;
+
+	list_for_each_entry(extent, list, list)
+		io_opaque_extent_release_begin(store, extent);
+}
+
 /*
  * Let go of @extent, and of its backing if it was the last to use it. Returns
  * the charge of the backing that went, for the caller to give back to the
@@ -405,34 +569,46 @@ no_space:
 static u64 io_opaque_extent_release(struct io_opaque_store *store, struct io_opaque_extent *extent)
 {
 	struct io_opaque_backing *backing = extent->backing;
-	u64 charge = 0;
+	bool last = false;
 
 	list_del(&extent->list);
 	if (!extent->embedded)
 		kfree(extent);
 	atomic_dec(&store->extents);
-	if (refcount_dec_and_test(&backing->refs)) {
-		charge = backing->charge;
-
-		if (backing->accounted)
-			io_opaque_memcg_uncharge(store, charge);
-		put_page(backing->page);
-		kfree(container_of(backing, struct io_opaque_chunk, backing));
+	if (!refcount_dec_not_one(&backing->refs)) {
+		spin_lock(&store->transient_lock);
+		last = refcount_dec_and_test(&backing->refs);
+		spin_unlock(&store->transient_lock);
 	}
-	return charge;
+	if (last)
+		io_opaque_backing_release(store, backing);
+	return io_opaque_backing_done(store, backing, last);
 }
 
 static void io_opaque_extent_free(struct io_opaque_store *store,
 				  struct io_opaque_extent *extent)
 {
-	u64 charge = io_opaque_extent_release(store, extent);
+	u64 charge;
 
+	io_opaque_extent_release_begin(store, extent);
+	charge = io_opaque_extent_release(store, extent);
 	if (charge)
 		io_opaque_uncharge(store, charge);
 	else
 		io_opaque_wake_budget(store);
 }
 
+/* Release physical backing, retaining its store reservation until the caller settles it. */
+static u64 io_opaque_extents_release(struct io_opaque_store *store, struct list_head *list)
+{
+	struct io_opaque_extent *extent, *next;
+	u64 charge = 0;
+
+	list_for_each_entry_safe(extent, next, list, list)
+		charge += io_opaque_extent_release(store, extent);
+	return charge;
+}
+
 /*
  * Free the extents of @list. What they held is returned to the store in one
  * step, and the waiters for budget are looked at in one go: each look takes
@@ -444,14 +620,11 @@ static void io_opaque_extent_free(struct io_opaque_store *store,
 static void io_opaque_extents_free(struct io_opaque_store *store,
 				   struct list_head *list)
 {
-	struct io_opaque_extent *extent, *next;
-	bool any = false;
-	u64 charge = 0;
+	bool any = !list_empty(list);
+	u64 charge;
 
-	list_for_each_entry_safe(extent, next, list, list) {
-		charge += io_opaque_extent_release(store, extent);
-		any = true;
-	}
+	io_opaque_extents_release_begin(store, list);
+	charge = io_opaque_extents_release(store, list);
 	if (charge)
 		io_opaque_uncharge_quiet(store, charge);
 	if (any)
@@ -469,14 +642,122 @@ struct io_opaque_data *io_opaque_data_alloc(void)
 	return data;
 }
 
+static u64 io_opaque_data_free(struct io_opaque_store *store,
+			       struct io_opaque_data *data, bool *extents)
+{
+	u64 charge;
+
+	*extents |= !list_empty(&data->extents);
+	charge = io_opaque_extents_release(store, &data->extents);
+	kvfree(data->bvec);
+	kfree(data);
+	return charge;
+}
+
+static u64 io_opaque_data_release(struct io_opaque_store *store,
+				  struct io_opaque_data *data, bool *extents)
+{
+	bool last;
+
+retry:
+	if (!data || refcount_dec_not_one(&data->refs))
+		return 0;
+	/* Announce the entire underway release before exposing version ref zero. */
+	io_opaque_extents_release_begin(store, &data->extents);
+	/* Serialize potential final drops with the published copy's private pin. */
+	spin_lock(&store->transient_lock);
+	last = refcount_dec_if_one(&data->refs);
+	spin_unlock(&store->transient_lock);
+	if (last) {
+		smp_acquire__after_ctrl_dep();
+		return io_opaque_data_free(store, data, extents);
+	}
+	/* A reference acquired during preparation keeps the version live. */
+	{
+		struct io_opaque_extent *extent;
+
+		list_for_each_entry(extent, &data->extents, list)
+			io_opaque_backing_done(store, extent->backing, false);
+	}
+	goto retry;
+}
+
 void io_opaque_data_put(struct io_opaque_store *store,
 			struct io_opaque_data *data)
 {
-	if (data && refcount_dec_and_test(&data->refs)) {
-		io_opaque_extents_free(store, &data->extents);
-		kvfree(data->bvec);
-		kfree(data);
+	bool extents = false;
+	u64 charge = io_opaque_data_release(store, data, &extents);
+
+	if (charge)
+		io_opaque_uncharge_quiet(store, charge);
+	if (extents)
+		io_opaque_wake_budget_all(store);
+}
+
+static u64 io_opaque_compact_source_release(struct io_opaque_req *op,
+					    bool *extents)
+{
+	u64 charge;
+
+	charge = io_opaque_data_release(op->store, op->data, extents);
+	op->data = NULL;
+	return charge;
+}
+
+static bool io_opaque_handoff_idle(struct io_opaque_handoff *handoff)
+{
+	return !READ_ONCE(handoff->pending);
+}
+
+static void io_opaque_handoff_wait(struct io_opaque_handoff *handoff)
+{
+	wait_event(handoff->wait, io_opaque_handoff_idle(handoff));
+}
+
+/* Settle source credits, replacement ownership and its exclusion together. */
+void io_opaque_compact_end(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_handoff *handoff = op->handoff;
+	bool extents = false;
+	u64 charge = op->reserved;
+
+	charge += io_opaque_compact_source_release(op, &extents);
+	charge += io_opaque_data_release(store, op->replacement, &extents);
+	op->replacement = NULL;
+	for (;;) {
+		struct io_opaque_data *published = op->published;
+
+		spin_lock(&store->transient_lock);
+		if (handoff && handoff->pending) {
+			spin_unlock(&store->transient_lock);
+			io_opaque_handoff_wait(handoff);
+			continue;
+		}
+		if (published) {
+			op->published = NULL;
+			if (!refcount_dec_not_one(&published->refs)) {
+				spin_unlock(&store->transient_lock);
+				charge += io_opaque_data_release(store, published, &extents);
+				continue;
+			}
+		}
+		if (handoff) {
+			charge += handoff->released;
+			handoff->active = false;
+		}
+		io_opaque_release_transient_locked(store, charge, op->transient);
+		spin_unlock(&store->transient_lock);
+		break;
 	}
+	if (charge || op->transient)
+		io_opaque_memory_mode(store);
+	op->handoff = NULL;
+	io_opaque_handoff_put(handoff);
+	op->reserved = 0;
+	op->transient = 0;
+	if (charge || extents)
+		io_opaque_wake_budget_all(store);
 }
 
 /*
@@ -705,6 +986,7 @@ struct io_opaque_store *io_opaque_alloc(struct io_ring_ctx *ctx,
 	for (i = 0; i < cfg.max_objects; i++)
 		INIT_LIST_HEAD(&store->objects[i].candidate);
 	INIT_DELAYED_WORK(&store->retry_work, io_opaque_retry_work);
+	INIT_DELAYED_WORK(&store->compact_work, io_opaque_compact_work);
 	return store;
 free_store:
 	bitmap_free(store->stream_used);
@@ -729,6 +1011,7 @@ void io_opaque_stop(struct io_opaque_store *store)
 			return;
 		WRITE_ONCE(store->dead, 1);
 	}
+	flush_delayed_work(&store->compact_work);
 	cancel_delayed_work_sync(&store->retry_work);
 	for (i = 0; i < store->config.max_streams; i++) {
 		struct io_opaque_stream *stream;
@@ -777,6 +1060,8 @@ void io_opaque_free(struct io_opaque_store *store)
 	if (!store)
 		return;
 	io_opaque_stop(store);
+	/* The dispatcher can requeue itself while stop flushes it. */
+	cancel_delayed_work_sync(&store->compact_work);
 	WARN_ON_ONCE(atomic64_read(&store->bytes));
 	WARN_ON_ONCE(atomic_read(&store->extents));
 	io_opaque_txs_free(store);
@@ -1817,6 +2102,12 @@ static int io_opaque_publish(struct io_opaque_req *op, u64 *object_flags)
 	op->slot_reserved = false;
 	slot->born = jiffies;
 	slot->retry = jiffies;
+	if (!slot->data->dense && !slot->data->forward_only &&
+	    (store->policy.flags & IORING_OPAQUE_POLICY_F_AUTO_COMPACT)) {
+		list_add_tail(&slot->candidate, &store->candidates);
+		queue_delayed_work(system_dfl_wq, &store->compact_work,
+				   msecs_to_jiffies(100));
+	}
 	return op->length;
 }
 
@@ -1831,7 +2122,8 @@ static void io_opaque_ready(struct io_tw_req tw_req, io_tw_token_t tw)
 	io_tw_lock(req->ctx, tw);
 	list_del_init(&op->cancel);
 	op->phase = IO_OPAQUE_IDLE;
-	if (tw.cancel || READ_ONCE(op->canceled) || READ_ONCE(store->dead))
+	if ((tw.cancel || READ_ONCE(op->canceled) || READ_ONCE(store->dead)) &&
+	    !(op->op == IORING_OPAQUE_COMPACT && op->copy_committed))
 		ret = -ECANCELED;
 	if (ret >= 0 && op->op == IORING_OPAQUE_INSPECT)
 		ret = io_opaque_copy(op->data, 0, op->data->length, op->addr);
@@ -1883,7 +2175,6 @@ int io_opaque_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (READ_ONCE(sqe->fd) != -1 || READ_ONCE(sqe->rw_flags) ||
 	    READ_ONCE(sqe->buf_index) || READ_ONCE(sqe->__pad2[0]) ||
 	    cmd > IORING_OPAQUE_AVAILABLE ||
-	    cmd == IORING_OPAQUE_COMPACT || cmd == IORING_OPAQUE_SET_POLICY ||
 	    (req->flags & (REQ_F_CQE_SKIP | REQ_F_FIXED_FILE)))
 		return -EINVAL;
 	op = io_opaque_req_alloc(req, store);
@@ -1931,14 +2222,17 @@ int io_opaque_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	} else if (op->offset) {
 		return -EINVAL;
 	}
-	if (cmd == IORING_OPAQUE_FREE || cmd == IORING_OPAQUE_STREAM_CLOSE) {
+	if (cmd == IORING_OPAQUE_FREE || cmd == IORING_OPAQUE_STREAM_CLOSE ||
+	    cmd == IORING_OPAQUE_COMPACT) {
 		if (op->length || op->addr)
 			return -EINVAL;
 	}
-	if (cmd == IORING_OPAQUE_STAT) {
+	if (cmd == IORING_OPAQUE_STAT || cmd == IORING_OPAQUE_SET_POLICY) {
 		if (op->handle || !op->addr)
 			return -EINVAL;
 	}
+	if (cmd == IORING_OPAQUE_SET_POLICY)
+		return io_opaque_policy_prep(op);
 	return 0;
 }
 
@@ -2251,6 +2545,12 @@ int io_opaque_issue(struct io_kiocb *req, unsigned int issue_flags)
 			ret = -ESTALE;
 		}
 		break;
+	case IORING_OPAQUE_COMPACT:
+		ret = io_opaque_compact_start(op);
+		break;
+	case IORING_OPAQUE_SET_POLICY:
+		ret = io_opaque_set_policy(op);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -2274,7 +2574,8 @@ static bool io_opaque_cancel_req(struct io_opaque_req *op)
 		mutex_lock(&op->stream->lock);
 	spin_lock(&op->store->wait_lock);
 	phase = op->phase;
-	if (op->canceled || phase == IO_OPAQUE_IDLE) {
+	if (op->canceled || phase == IO_OPAQUE_IDLE ||
+	    (op->op == IORING_OPAQUE_COMPACT && op->copy_committed)) {
 		spin_unlock(&op->store->wait_lock);
 		if (op->stream)
 			mutex_unlock(&op->stream->lock);
@@ -2411,6 +2712,8 @@ void io_opaque_cleanup(struct io_kiocb *req)
 		io_opaque_vec_cleanup(op);
 	if (op->op == IORING_OPAQUE_CREATE)
 		io_opaque_create_release(op);
+	else if (op->op == IORING_OPAQUE_COMPACT)
+		io_opaque_compact_end(op);
 	else
 		io_opaque_data_put(store, op->data);
 	io_opaque_stream_put(op->stream);
diff --git a/io_uring/opaque.h b/io_uring/opaque.h
index 4001a4484ff9..f63729c19af5 100644
--- a/io_uring/opaque.h
+++ b/io_uring/opaque.h
@@ -14,6 +14,7 @@ struct io_uring_opaque_config;
 #ifdef CONFIG_IO_URING_OPAQUE_OBJ
 struct io_opaque_stream;
 struct io_opaque_data;
+struct io_opaque_handoff;
 struct io_opaque_tx;
 struct io_opaque_vec;
 
@@ -74,6 +75,11 @@ struct io_opaque_req {
 		};
 		struct {
 			struct io_opaque_data *replacement;
+			/* Private pin retained after the table takes the replacement. */
+			struct io_opaque_data *published;
+			struct io_opaque_handoff *handoff;
+			bool copy_committed;
+			bool copy_reserved;
 			u64 reserved;
 			u64 transient;
 		};
diff --git a/io_uring/opaque_compact.c b/io_uring/opaque_compact.c
index b59c7cb95d42..5bde1701f189 100644
--- a/io_uring/opaque_compact.c
+++ b/io_uring/opaque_compact.c
@@ -11,6 +11,48 @@
 #include "io_uring.h"
 #include "opaque_internal.h"
 
+static void io_opaque_auto_compact(struct io_opaque_store *store);
+
+struct io_opaque_cursor {
+	struct io_opaque_extent *extent;
+	u32 offset;
+};
+
+static int io_opaque_compact_copy(struct io_opaque_req *op,
+				  struct io_opaque_cursor *cursor,
+				  struct page *page, u32 length)
+{
+	u32 written = 0;
+
+	while (written < length) {
+		struct io_opaque_extent *src = cursor->extent;
+		u32 pos = src->offset + cursor->offset;
+		u32 in = offset_in_page(pos), out = offset_in_page(written);
+		u32 chunk = min(length - written, src->length - cursor->offset);
+		void *from, *to;
+
+		if (READ_ONCE(op->canceled) || READ_ONCE(op->store->dead))
+			return -ECANCELED;
+		chunk = min_t(u32, chunk, PAGE_SIZE - in);
+		chunk = min_t(u32, chunk, PAGE_SIZE - out);
+		to = kmap_local_page(page + (written >> PAGE_SHIFT));
+		from = kmap_local_page(src->backing->page + (pos >> PAGE_SHIFT));
+		memcpy(to + out, from + in, chunk);
+		kunmap_local(from);
+		kunmap_local(to);
+		written += chunk;
+		cursor->offset += chunk;
+		if (cursor->offset == src->length) {
+			cursor->offset = 0;
+			if (!list_is_last(&src->list, &op->data->extents))
+				cursor->extent = list_next_entry(src, list);
+			else if (written < length)
+				return -EIO;
+		}
+	}
+	return 0;
+}
+
 struct page *io_opaque_owned_page(unsigned int *order)
 {
 	struct page *page;
@@ -24,10 +66,360 @@ struct page *io_opaque_owned_page(unsigned int *order)
 	}
 }
 
-/* Destination allocation for dense copies and CREATE. */
+/*
+ * Destination chunk for compaction and CREATE: the largest order within the
+ * remaining size, falling back to smaller orders.
+ */
 struct page *io_opaque_dest_page(struct io_opaque_store *store, u64 pages_left,
 				 unsigned int *order)
 {
 	*order = min_t(unsigned int, IO_OPAQUE_MAX_ORDER, ilog2(pages_left));
 	return io_opaque_owned_page(order);
 }
+
+static int io_opaque_compact_build(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_cursor cursor;
+	u64 done = 0, length, charge;
+	struct mem_cgroup *old;
+	int ret = 0;
+
+	length = op->data->length;
+	charge = ALIGN(length, PAGE_SIZE);
+	if (READ_ONCE(op->canceled) || READ_ONCE(store->dead))
+		return -ECANCELED;
+	ret = io_opaque_compact_reserve(op, charge);
+	if (ret)
+		return ret;
+	op->copy_reserved = true;
+	old = set_active_memcg(store->memcg);
+	op->replacement = io_opaque_data_alloc();
+	if (!op->replacement) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	op->replacement->forward_only = op->data->forward_only;
+	cursor.extent = list_first_entry(&op->data->extents, struct io_opaque_extent, list);
+	cursor.offset = 0;
+	while (done < length) {
+		u64 pages_left = DIV_ROUND_UP_ULL(length - done, PAGE_SIZE);
+		struct io_opaque_extent *extent;
+		unsigned int order;
+		struct page *page;
+		u32 chunk;
+
+		if (READ_ONCE(op->canceled) || READ_ONCE(store->dead)) {
+			ret = -ECANCELED;
+			goto out;
+		}
+		page = io_opaque_dest_page(store, pages_left, &order);
+		if (!page) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		chunk = min_t(u64, length - done, PAGE_SIZE << order);
+		extent = io_opaque_extent_new(store, page, 0, chunk, done, true);
+		if (IS_ERR(extent)) {
+			put_page(page);
+			ret = PTR_ERR(extent);
+			goto out;
+		}
+		op->reserved -= page_size(page);
+		list_add_tail(&extent->list, &op->replacement->extents);
+		ret = io_opaque_compact_copy(op, &cursor, page, chunk);
+		if (ret)
+			goto out;
+		done += chunk;
+		op->replacement->length = done;
+		cond_resched();
+	}
+	ret = io_opaque_vector(op->replacement);
+	if (!ret)
+		op->replacement->dense = true;
+out:
+	set_active_memcg(old);
+	return ret;
+}
+
+int io_opaque_compact_publish(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_slot *slot;
+	struct io_opaque_data *old;
+	int ret = -ESTALE;
+
+	mutex_lock(&store->tables);
+	slot = io_opaque_lookup(store, op->handle);
+	/* Cancellation shares this bounded publication decision, not the frees. */
+	spin_lock(&store->wait_lock);
+	if (slot && slot->data == op->data && !store->dead &&
+	    !READ_ONCE(op->canceled)) {
+		old = slot->data;
+		op->published = op->replacement;
+		refcount_inc(&op->published->refs);
+		slot->data = op->replacement;
+		op->replacement = NULL;
+		op->copy_committed = true;
+		slot->compacting = false;
+		list_del_init(&slot->candidate);
+		atomic64_add(old->length, &store->compacted);
+		atomic64_inc(&store->compactions);
+		ret = 0;
+	} else {
+		old = NULL;
+	}
+	spin_unlock(&store->wait_lock);
+	mutex_unlock(&store->tables);
+	io_opaque_data_put(store, old);
+	return ret;
+}
+
+/* Complete accounting in the existing dispatcher, never in deferred ring work. */
+static int io_opaque_compact_run(struct io_opaque_req *op, bool automatic)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_slot *slot;
+	int ret = io_opaque_compact_build(op);
+
+	if (!ret)
+		ret = io_opaque_compact_publish(op);
+	mutex_lock(&store->tables);
+	slot = io_opaque_lookup(store, op->handle);
+	if (slot && slot->data == op->data) {
+		slot->compacting = false;
+		if (automatic && ret)
+			slot->retry = jiffies + HZ;
+	}
+	mutex_unlock(&store->tables);
+	io_opaque_compact_end(op);
+	return ret;
+}
+
+void io_opaque_compact_work(struct work_struct *work)
+{
+	struct io_opaque_store *store = container_of(to_delayed_work(work),
+						   struct io_opaque_store, compact_work);
+	unsigned long delay = MAX_JIFFY_OFFSET;
+	unsigned long now;
+	unsigned int i;
+
+	/* Once shutdown is observed, drain every accepted request in this run. */
+	for (i = 0; i < 8 || READ_ONCE(store->dead); i++) {
+		struct io_opaque_req *op;
+		int ret;
+
+		scoped_guard(spinlock, &store->wait_lock) {
+			op = list_first_entry_or_null(&store->copies, struct io_opaque_req, wait);
+			if (op)
+				list_del_init(&op->wait);
+		}
+		if (!op)
+			break;
+		ret = io_opaque_compact_run(op, false);
+		/* Cancellation cannot complete a request still owned by this worker. */
+		io_opaque_queue_ready(op, ret);
+	}
+	io_opaque_auto_compact(store);
+	/* Keep automatic scans paced even when manual requests wake us early. */
+	guard(mutex)(&store->tables);
+	now = jiffies;
+	if (!store->dead && (store->policy.flags & IORING_OPAQUE_POLICY_F_AUTO_COMPACT) &&
+	    !list_empty(&store->candidates))
+		delay = time_before(now, store->auto_at) ? store->auto_at - now : 0;
+	guard(spinlock)(&store->wait_lock);
+	if (!list_empty(&store->copies))
+		delay = 0;
+	if (delay != MAX_JIFFY_OFFSET)
+		queue_delayed_work(system_dfl_wq, &store->compact_work, delay);
+}
+
+int io_opaque_compact_start(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_slot *slot;
+
+	guard(mutex)(&store->tables);
+	if (store->dead)
+		return -ESHUTDOWN;
+	slot = io_opaque_lookup(store, op->handle);
+	if (!slot || !slot->data)
+		return -ESTALE;
+	if (slot->compacting)
+		return -EBUSY;
+	if (slot->data->dense)
+		return 0;
+	op->data = slot->data;
+	refcount_inc(&op->data->refs);
+	slot->compacting = true;
+	io_opaque_wait(op, IO_OPAQUE_COPY_WORK);
+	scoped_guard(spinlock, &store->wait_lock)
+		list_add_tail(&op->wait, &store->copies);
+	mod_delayed_work(system_dfl_wq, &store->compact_work, 0);
+	return IOU_ISSUE_SKIP_COMPLETE;
+}
+
+/*
+ * Install @policy and mark the objects it concerns as candidates, or not. Where
+ * the table of handles is long this is the longest thing done under tables, so
+ * the walk drops it every IO_OPAQUE_POLICY_CHUNK slots and those waiting
+ * for it wait for a chunk. What happens between chunks cannot hurt it. The
+ * policy is in force from the first one, so an object published meanwhile joins
+ * the candidates by itself, or does not, and one freed leaves them; the walk
+ * adds a slot only if it is not on the list. A second change that starts
+ * meanwhile walks the whole table itself, so the first gives up when it comes
+ * back and finds it was overtaken, as it does if the store has stopped.
+ */
+static int io_opaque_apply_policy(struct io_opaque_store *store,
+				  const struct io_uring_opaque_policy *policy)
+{
+	bool automatic = policy->flags & IORING_OPAQUE_POLICY_F_AUTO_COMPACT;
+	u32 i, seq;
+
+	mutex_lock(&store->tables);
+	if (store->dead) {
+		mutex_unlock(&store->tables);
+		return -ESHUTDOWN;
+	}
+	store->policy = *policy;
+	store->tokens = policy->burst_bytes;
+	store->token_time = jiffies;
+	store->auto_at = jiffies;
+	seq = ++store->policy_seq;
+	for (i = 0; i < store->config.max_objects; i++) {
+		struct io_opaque_slot *slot = &store->objects[i];
+
+		if (automatic && slot->data && !slot->data->dense && !slot->data->forward_only &&
+		    list_empty(&slot->candidate)) {
+			list_add_tail(&slot->candidate, &store->candidates);
+			slot->retry = jiffies;
+		} else if (!automatic) {
+			list_del_init(&slot->candidate);
+		}
+		if ((i + 1) % IO_OPAQUE_POLICY_CHUNK || i + 1 == store->config.max_objects)
+			continue;
+		mutex_unlock(&store->tables);
+		cond_resched();
+		mutex_lock(&store->tables);
+		if (store->dead) {
+			mutex_unlock(&store->tables);
+			return -ESHUTDOWN;
+		}
+		if (store->policy_seq != seq) {
+			mutex_unlock(&store->tables);
+			return 0;
+		}
+	}
+	if (automatic) {
+		mod_delayed_work(system_dfl_wq, &store->compact_work, 0);
+	} else {
+		guard(spinlock)(&store->wait_lock);
+		/* Policy changes cannot cancel an accepted manual request. */
+		if (list_empty(&store->copies))
+			cancel_delayed_work(&store->compact_work);
+	}
+	mutex_unlock(&store->tables);
+	return 0;
+}
+
+/* Copy and check the policy at prep, so its struct need not outlive submission. */
+int io_opaque_policy_prep(struct io_opaque_req *op)
+{
+	struct io_uring_opaque_policy *policy = &op->policy;
+	u64 hard_limit = op->store->config.hard_limit;
+	int ret;
+
+	if (op->length < offsetof(struct io_uring_opaque_policy, __resv) ||
+	    op->length > PAGE_SIZE)
+		return -EINVAL;
+	ret = copy_struct_from_user(policy, sizeof(*policy), op->addr, op->length);
+	if (ret)
+		return ret;
+	if ((policy->flags & ~IORING_OPAQUE_POLICY_F_AUTO_COMPACT) ||
+	    policy->__resv0 || !mem_is_zero(policy->__resv, sizeof(policy->__resv)) ||
+	    policy->bytes_per_second > SZ_1T || policy->burst_bytes > hard_limit ||
+	    policy->max_temporary_bytes > hard_limit)
+		return -EINVAL;
+	if ((policy->flags & IORING_OPAQUE_POLICY_F_AUTO_COMPACT) &&
+	    (!policy->bytes_per_second || !policy->burst_bytes ||
+	     policy->max_temporary_bytes < PAGE_SIZE))
+		return -EINVAL;
+	return 0;
+}
+
+int io_opaque_set_policy(struct io_opaque_req *op)
+{
+	return io_opaque_apply_policy(op->store, &op->policy);
+}
+
+/* The same dispatcher handles bounded scans and the store-wide token bucket. */
+static void io_opaque_auto_compact(struct io_opaque_store *store)
+{
+	struct io_opaque_req op = { .store = store };
+	struct io_opaque_slot *slot = NULL;
+	struct io_uring_opaque_policy policy;
+	u64 minted, elapsed;
+	u64 length = 0;
+	u32 policy_seq;
+	unsigned int scanned = 0;
+	int ret;
+
+	mutex_lock(&store->tables);
+	policy = store->policy;
+	policy_seq = store->policy_seq;
+	if (store->dead || !(policy.flags & IORING_OPAQUE_POLICY_F_AUTO_COMPACT) ||
+	    time_before(jiffies, store->auto_at))
+		goto unlock;
+	store->auto_at = jiffies + msecs_to_jiffies(100);
+	elapsed = jiffies - store->token_time;
+	if (check_mul_overflow(elapsed, policy.bytes_per_second, &minted))
+		minted = policy.burst_bytes;
+	else
+		minted = div_u64(minted, HZ);
+	store->tokens = min(policy.burst_bytes, store->tokens + min(minted, policy.burst_bytes));
+	store->token_time = jiffies;
+	while (!list_empty(&store->candidates) && scanned++ < 32) {
+		u64 dense, saving;
+
+		slot = list_first_entry(&store->candidates, struct io_opaque_slot, candidate);
+		list_move_tail(&slot->candidate, &store->candidates);
+		if (!slot->data || slot->data->dense) {
+			list_del_init(&slot->candidate);
+			continue;
+		}
+		if (slot->compacting || time_before(jiffies, slot->retry) ||
+		    time_before(jiffies, slot->born + msecs_to_jiffies(100)))
+			continue;
+		dense = ALIGN(slot->data->length, PAGE_SIZE);
+		saving = slot->data->charge > dense ? slot->data->charge - dense : 0;
+		/* Selection heuristics are implementation details, not UAPI. */
+		if ((!saving && slot->data->nr == 1) ||
+		    (saving && saving * 100 < slot->data->charge * 25) ||
+		    dense > policy.max_temporary_bytes || slot->data->length > policy.burst_bytes) {
+			/* Immutable backing cannot become eligible without a new policy. */
+			list_del_init(&slot->candidate);
+			continue;
+		}
+		if (slot->data->length > store->tokens)
+			continue;
+		slot->compacting = true;
+		store->tokens -= slot->data->length;
+		op.data = slot->data;
+		length = op.data->length;
+		refcount_inc(&op.data->refs);
+		op.handle = io_opaque_handle(slot - store->objects, slot->generation);
+		break;
+	}
+unlock:
+	mutex_unlock(&store->tables);
+	if (op.data) {
+		ret = io_opaque_compact_run(&op, true);
+		/* No reservation means no copy was attempted; return its tokens. */
+		if (ret && !op.copy_reserved) {
+			guard(mutex)(&store->tables);
+
+			if (store->policy_seq == policy_seq)
+				store->tokens = min(policy.burst_bytes, store->tokens + length);
+		}
+	}
+}
diff --git a/io_uring/opaque_internal.h b/io_uring/opaque_internal.h
index 2d5f69ee8925..f27c30d32e13 100644
--- a/io_uring/opaque_internal.h
+++ b/io_uring/opaque_internal.h
@@ -7,6 +7,7 @@
 #include <linux/bvec.h>
 #include <linux/net.h>
 #include <linux/sizes.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/io_uring/opaque.h>
 
@@ -44,8 +45,22 @@
 /* The head of its queue, still to take its references. */
 #define IO_OPAQUE_TX_SETTLE	2
 
+/* One copy's deferred source credits; mutable fields use transient_lock. */
+struct io_opaque_handoff {
+	refcount_t refs;
+	u64 released;
+	unsigned int pending;
+	bool active;
+	wait_queue_head_t wait;
+};
+
 struct io_opaque_backing {
 	refcount_t refs;
+	/* Owns a handoff reference until retagged or physically released. */
+	struct io_opaque_handoff *handoff;
+	/* Prepared extent puts keep metadata alive through physical release. */
+	unsigned int pending;
+	bool released;
 	struct page *page;
 	u64 charge;
 	u32 filled;
@@ -214,7 +229,7 @@ struct io_opaque_store {
 	 * that move bytes and transient together are one seqcount write.
 	 */
 	atomic64_t transient;
-	/* Serializes transient_seq writers. */
+	/* Transient writers, backing handoffs and potential last-version drops. */
 	spinlock_t transient_lock;
 	seqcount_spinlock_t transient_seq;
 	atomic_t extents;
@@ -269,4 +284,12 @@ struct io_opaque_slot *io_opaque_lookup(struct io_opaque_store *store,
 					u64 handle);
 void io_opaque_wait(struct io_opaque_req *op, enum io_opaque_phase phase);
 void io_opaque_queue_ready(struct io_opaque_req *op, int result);
+int io_opaque_compact_reserve(struct io_opaque_req *op, u64 charge);
+int io_opaque_compact_publish(struct io_opaque_req *op);
+void io_opaque_compact_end(struct io_opaque_req *op);
+void io_opaque_compact_work(struct work_struct *work);
+int io_opaque_compact_start(struct io_opaque_req *op);
+int io_opaque_policy_prep(struct io_opaque_req *op);
+int io_opaque_set_policy(struct io_opaque_req *op);
+
 #endif
-- 
2.34.1

