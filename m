Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051570;
	b=JhvC4JTwhIIHDrc7kyChDJ9h9fIrU4VhM2zb+Ez5l2MUQ9aucvQDJEp5o02nxaTd5S8H
	 iK3oPeCCaJzMM5lU2F8FuyAfnvypuLAvq31kBzxDXsMRe/noOKi24fJTnhyLSnr0bkBB+
	 DrB7pmsPOsVUEzFlxMq2LurgdkILOcrqJbc+05o2KPSUbgDe0POJ+BLKMswYfW0NJLR3f
	 /34YrRfJLzc0ob+WnGHd+yR6oBCGgpoM8JBjPlVqn7TnYW3YoZlqjuCMRsrtmYtDbf+QF
	 ulQNTAg85dQ+dSUUqazJFfP0KNWdV+l2bB4QY4rqBwu0kd2KK+OaSbT4QTvzcQIIUpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/8L34Uc9Xo1d4oJ1WUUvtNMd/yh9NNapi89sPDAfm6Y=;
	b=KC8NTIngwuy+8roXfdEwxXXN+EHvxjzyov4QWQhjcfbc4pGcl9IgOG7weUd833t4sjg4
	 y7aGCNo+Hpu3LeD3r3Ilp5/2UvFCGf+4slh74p2AlHH5JRW0tGiHCmMpaHjx/5LqpTKCe
	 aNS3embL3x5LxL3vmycXtjzqaPOsbrupxkI0Gf0e8Ku4iJ8HXhI//PajfDOLzoIw8bRgT
	 3ULbE+kQGLlAnoqb34rgEh26ZE9LsYS5wcFn3KsULtdzM8GIWeCgV52cM3SypgbywbA1h
	 vFnb5dEVXTDQdl/OHyekD8TtIzp45YilLmGaZkYRluy+q6B9I0JEOvApwy36rzVUXrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fU7gA7Dl;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5580260A2620
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 21:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5580260A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fU7gA7Dl
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac76132001so2715664a91.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793051570; x=1793656370; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8L34Uc9Xo1d4oJ1WUUvtNMd/yh9NNapi89sPDAfm6Y=;
        b=fU7gA7DljvCqdvdMpaU2dp8kIrEccZFKOmWnfW6sw+A054S6dlNZugZLhIYYcfiePQ
         hsLgQW99gw7/40gSfJI6nU0rtnm0+1dPDbRaUoY665tdkjNVHr2UFbegtIbotfU9v9/A
         uK7QOilz2oAfaWXl/tsF91D3vAUMVrFCU+UmdWgUF2++tfRICFcImVM7cH8b81croIe/
         3gbPbeDpIxRnPDaXaoU22kL/RynJy6L0hYZfzyDRTzTeCDcQlDb8FUzF1BEGuZLmjKzH
         eeONqBOhxrAFnMU8HI0VT7oOvpOxL8LajgaOKQMUvvRXhW0M5pmi7s9QGStFhbTf6Lb8
         9JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051570; x=1793656370;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/8L34Uc9Xo1d4oJ1WUUvtNMd/yh9NNapi89sPDAfm6Y=;
        b=bdhF12pow6NWXWK8FRGKebtsiUrng7ieQT8lixrs7hNSu2vmvlL+090SWBq0m5a6ei
         TZRu+hppZECW7gy4DA2XajfUpEzmRe454tEGovAgzjRPSKlXa5bEv3ONOQ4wFAz0ySnh
         edrs+qF31/riYYJUA/R5R8G8G4hgPNlA/+8Q2meIUJWIArtQLqm+yskiWvyxpmLLg374
         Mk61mPoVKrRSJ+/jFDZyOlc6n9CiniBZAPTQNCCk58gnkOHbWJVslL1vokyu8UfWEp3/
         KZklL6Wuhd2UZrXV9hHIo6GfHUwzwAfKXCh+5tMv8bHdP9k2f3tEOFSJBidxJ41l4PqM
         2zOw==
X-Forwarded-Encrypted: i=1; AKwUvBz01VdI51RiSCWeq4jMpXFhQ1ofyD86aEC6uoNj3dE6lWYIQx87uapErxkM+LE+6S58Zxw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhkCqE2Fyj9wYzbb7knnG0gvDUTKtPhbDJdrgl3bSIJvSekkfi
	OBm5xxLW3VSsiJNBJJwppDcgZyUC5hvY3ghNgYjJF9fzT63nuIfchhKBya9ZeqVo9/KnnFgYskj
	VaYYh2RhYEQkLvUsk9mQHnw==
X-Received: from pjbme4.prod.google.com ([2002:a17:90b:17c4:b0:3ae:349e:2bcd])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:35cc:b0:3ad:1b31:92d8 with SMTP id 98e67ed59e1d1-3adeb16ecffmr5865801a91.60.1793051569572;
 Mon, 26 Oct 2026 14:52:49 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:52:18 +0000
In-Reply-To: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026215226.3713941-3-jthoughton@google.com>
Subject: [RFC PATCH 02/10] btrfs: Don't copy encoded read data to user memory
 when canceled
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

btrfs_uring_read_finished() copies the data of an io_uring encoded read
to the submitter's buffers with copy_page_to_iter(). It runs as io_uring
task work, but io_uring may also run it with tw.cancel set from other
contexts when the submitting task can't run it: from a kworker when the
submitting task has exited (io_tctx_fallback_work()), or from
io_cancel_local_task_work() when a DEFER_TASKRUN ring is torn down.

In a kworker, current->mm is NULL, and the copy does not reliably fail:
the user half of the address space belongs to whatever mm happens to be
lazily loaded, if any, so the data may be written into an unrelated
process.

Don't copy the data when the task work is canceled, and complete the
command with -ECANCELED.

Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/btrfs/ioctl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f3e2afe221be..d9044fbd9547 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4609,6 +4609,16 @@ static void btrfs_uring_read_finished(struct io_tw_req tw_req, io_tw_token_t tw)
 		goto out;
 	}
 
+	/*
+	 * If the request is being canceled, e.g. because the submitting task
+	 * has exited, this may run from a kworker or in a different task, so
+	 * don't copy the data to the submitter's buffers.
+	 */
+	if (unlikely(tw.cancel)) {
+		ret = -ECANCELED;
+		goto out;
+	}
+
 	if (priv->compressed) {
 		index = 0;
 		page_offset = 0;
-- 
2.56.0.307.g5fe7bd680c-goog

