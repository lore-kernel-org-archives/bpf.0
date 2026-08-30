Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A4202F70
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788082523; cv=none; b=ic9YrG44XvUlno+5ijL6vgurjvFd4zKXShHGuh/newtERk8/LPv74q/itINCC0ygLZ+iwOZMu3/0CBmknL0YzBtwoZ/imhHHEY5pMkG+6qKuwua4I1KDYiWSessPlnoLuWVKrc6wV7gneMvnhULCiVIMeWzOf7QzefyntBPBRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788082523; c=relaxed/simple;
	bh=u0w6QFkZ+N0Nu/wLcDM/LfvJNV1JGyP0vhfyIOPw7kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsS9f7B4RHitR40nXxSBj9Gw+WteMFW7A+OuXpxba/ynX4kZwlrmaM9HmpP/aes5RyOBnU8oeXqKAxNQtiznFip0BQCVbvi4fR/qCxXlW9RtySYVnZudE40z4XSWmqS5RpEy3wM9HZYFxClpF+er8GrQ6N1IPtjq1QTiHzo+PZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DayTYBfV; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DayTYBfV"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499aaf0a723so8356325e9.1
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788082520; x=1788687320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WHhwAl53j7qcV0Ve4HJGemvMX3Yxb7lhlI4UBvi2EOo=;
        b=DayTYBfVppYau3qD2fahiHPATRj5O11f3LJYPTxzIOyMDwV7G/I4fSM7FCEhZV98GK
         xlMkOb9vD032/M/FjqjYPmhdUG75ON8hBoWiZ0DmK+4UODqzj/Ecl00KEMEXi44FYmYZ
         59T+oDX0+eyTlgdJfC7e1GoQVKW3bK7bI78Kjqps78opXP4bcWFUREwyBXHRYDCmG2HF
         V57CejrX50X8GnCJczBUIsgqqZ6uZEMslTGmxm0EnLrLRzCHr8UvyfpfIvdtV+O29cAf
         JM6fKJvZM77g5qIqBL2fzWMJYFEsdk1t5DQ1lbkewvPY40IQ7mYzcOGmCPXbxUj8B5Lu
         EAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788082520; x=1788687320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WHhwAl53j7qcV0Ve4HJGemvMX3Yxb7lhlI4UBvi2EOo=;
        b=Q9+/wF5TyN0/qJ5qdw7Sv4YfeGcMUDYo86QDKR1hx/7jtu/fE4A0hiXnKa9+IDHW37
         Wcu7v8XYYoHwu4nfq7x7bLQ67HUGkOBn9fCEY5NsZxzg9jEZIBkaaReKkCUNmU8euRjZ
         cM92VmWjTSEWzcOX4K+x8TB+N+7LSTdNh6N/wqibhqfd0yLE/dz9zWFExIbQ9EEOo2zg
         Tkb4dOA4MGsMUFrtBAmhqFY8iXq1LJ9OauDkurFuNSdi5rSR3OZRid61H2LE/YyNIROr
         VuL8drgjYGQ0YFMK2yv+w/JcJ9HeCnbMX1NO0YcaFpenzZwva7YzznX0KHSWh9XqMEx2
         0Fkw==
X-Gm-Message-State: AFuF++kjXLe98jPF20e+Y8Hn9Jc8aUQg+cvkmyg2KPLg+asnTsibryG5
	DkXXlVVvEgvjrkBVn1GUf/GLZXwoUxiKJUM1F4U5m4CAHDWsIrr2LnWowN+JJcGJ9JA=
X-Gm-Gg: AR+sD13tuvftNgMNFFeo6BaElNK2OGYHQGcd+m0800gmKq6JogaNLxaHaJ2TcAvV1mX
	SStkN6wgyzSwFvMTPUji/1aYum4V6UUC4T83PkxV6vTp6cLQP+oEtM1rvPEuDyyo0SdFThWlcES
	sOOkXBgggJkl2SsXyImjSd3M1SGeE5BZKY/Gsjlv4UTrgdTUukKTa4dKiHpBIX9vUlIFY6Ba3qF
	qIkR/Eu7LpAIGJPijwzaBRFhINQ55bubNecsQsiMZT8JXUeA5en80pJmbVtPzQCSYlvN13ad6Ew
	if3oPtxLNsdoo1sXUuc0H+XT7Oh3+ZZGPjCVjg6VBeQIImXqVG/cJv5QPiSHnzTFs42AeSQvV+W
	eCwM9lh2RYwACSQLUchf/z1yEKjWj1OecekZqvwpe+e2BMCM7hQuKJpL4omdQRIvfbTG/Dj+WfH
	UTgjiPst+yxHvaDTpqBpCA3T+Yh0JR6zBBb8OWVfuTMCEVsJ0+i+ctQnaUphR8xlK+ykWBqtliS
	riqcGpkivu8u1TSL3QWrp2U08fdUSE8MdcZKHMcULjQ8Qap0Yz7DIpKyofFAkys84cghvzhY5GS
	qt0YPfSZWyNH4i8Vmpg3ncEPl4A=
X-Received: by 2002:a05:600c:3513:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49b91c4faebmr262555085e9.13.1788082520088;
        Sun, 30 Aug 2026 02:35:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48435b024fbsm6157116f8f.29.2026.08.30.02.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 02:35:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/6] bpf: Defer stream file notifications from NMI context
Date: Sun, 30 Aug 2026 11:35:07 +0200
Message-ID: <20260830093514.4105972-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830093514.4105972-1-memxor@gmail.com>
References: <20260830093514.4105972-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4145; i=memxor@gmail.com; h=from:subject; bh=u0w6QFkZ+N0Nu/wLcDM/LfvJNV1JGyP0vhfyIOPw7kM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvyxy1tkfeTBAoyL841vniCx2SlaHWMwHkjlbvtFreZD M7oFaZ0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCL/bjEyXN2fLfdU/OK3knKP n2alz3OXKDcevfbN4mJa1rqvfs91uBgZ1p5nX6YhPOO6/qwJZlZpG+K3/NnP1DXbrkG44eFMn+1 Z/AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_stream_vprintk() and staged stream writers can run in NMI context.
The stream file interface currently wakes its wait queue directly after
publishing data. Wait queue wakeups take a spin lock and can invoke epoll
callbacks that take further locks, so calling them from NMI context can
deadlock.

Give each stream an irq_work item and queue it after publishing data. The
irq_work callback reports readable data to poll waiters outside NMI
context, while naturally coalescing concurrent notifications. This matches
poll and epoll readiness semantics: notifications do not count records,
but prompt waiters to re-evaluate persistent readable state. Publications
made before a coalesced queue attempt are ordered before the pending
callback, and the work can be queued again once that callback begins.
EPOLLET consumers drain until EAGAIN, so one wakeup may safely represent a
batch.

Synchronize pending work before releasing the final stream reference so
the callback cannot outlive the stream.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  2 ++
 kernel/bpf/stream.c | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1745686331be..0af3c79f5d03 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -17,6 +17,7 @@
 #include <linux/numa.h>
 #include <linux/mm_types.h>
 #include <linux/wait.h>
+#include <linux/irq_work_types.h>
 #include <linux/refcount.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
@@ -1719,6 +1720,7 @@ struct bpf_stream {
 	struct llist_node *backlog_head; /* list of in-flight stream elements in FIFO order */
 	struct llist_node *backlog_tail; /* tail of the list above */
 	wait_queue_head_t waitq;
+	struct irq_work notify_work;
 	bool dead;
 };
 
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index d3dbb1aca792..99a89533eaef 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -6,6 +6,7 @@
 #include <linux/filter.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/gfp.h>
+#include <linux/irq_work.h>
 #include <linux/memory.h>
 #include <linux/mutex.h>
 #include <linux/poll.h>
@@ -76,6 +77,17 @@ static void bpf_stream_release_capacity(struct bpf_stream *stream, int len)
 	atomic_sub(len, &stream->capacity);
 }
 
+static void bpf_stream_notify(struct irq_work *work)
+{
+	struct bpf_stream *stream = container_of(work, struct bpf_stream, notify_work);
+
+	/*
+	 * Stream writers can run in NMI context, while wait queue callbacks may
+	 * acquire locks. Defer those callbacks to irq_work context.
+	 */
+	wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM);
+}
+
 static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int len)
 {
 	int ret = bpf_stream_consume_capacity(stream, len);
@@ -87,7 +99,7 @@ static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int l
 	if (ret)
 		bpf_stream_release_capacity(stream, len);
 	else if (len)
-		wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM);
+		irq_work_queue(&stream->notify_work);
 
 	return ret;
 }
@@ -230,6 +242,7 @@ static void bpf_stream_put(struct bpf_stream *stream)
 	if (refcount_dec_and_test(&stream->refcnt)) {
 		struct llist_node *list;
 
+		irq_work_sync(&stream->notify_work);
 		list = llist_del_all(&stream->log);
 		bpf_stream_free_list(list);
 		bpf_stream_free_list(stream->backlog_head);
@@ -402,6 +415,7 @@ int bpf_prog_stream_init(struct bpf_prog *prog, gfp_t gfp_extra_flags)
 		init_llist_head(&stream->log);
 		mutex_init(&stream->lock);
 		init_waitqueue_head(&stream->waitq);
+		init_irq_work(&stream->notify_work, bpf_stream_notify);
 		prog->aux->stream[i] = stream;
 	}
 	return 0;
@@ -482,7 +496,7 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 		list = tail;
 	}
 	llist_add_batch(head, tail, &stream->log);
-	wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM);
+	irq_work_queue(&stream->notify_work);
 	return 0;
 }
 
-- 
2.53.0

