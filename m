Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577501;
	b=1ezZJc/UPKyJsuG1VgJXJ44OEH0Ng1nJgk1+Bw+qvjpaQqQoUoGMAIvIsSFcCZ9TTe4P
	 05OlgGOP8gkjtakdI+RCg6+mxW0bIZyrsLswbUuu/vcLPTKkVBgs4lv7mR3IJkqpk8qeT
	 xjvajYIRTDV3CD9FDQV4MEpbNNbMILSGOrf/BLHUnECHtNpZqS8UJyv32Ft+DcltG4ryG
	 a15a7BvFwhnLawQwtYHQ2JJ6lB5yGZiV997UjupaHSHpz13VvU0CoTYi+CzWChgxqFJSu
	 g86tsr3MD5pKe/GS/zKXGppw1toIWzV2DCArCeTs0BBiQyYDzRBKp5fOXUy8Z8/6ffQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HVAJBAmjGbPAOjSl65DCtf2SbsUtmSEnDzK6RS98Q0s=;
	b=TWyxpSwvqmMJUgh1+TLrL0oLjjH32sKiTpUB/Uurm44Y40ebtd0e0lfy3t/JqT7MOyCs
	 rJmTz4lKKpy4mqGLin1UiM4u7R/PvCBGmMtOAsMor9I9E4IIGAqnpnWxq7WnT7tHzARXD
	 vbL1g/+Y6ZGI5rV76ey76kQddWDmzczlF6hfz/5LxeS3g0QKs6SUUjNriracFfQUiFoYB
	 54MYw+FtTk8Ue2k17LYxSNJrllskbsdftSCOwGZCsKJbdgILanv4Qtqc6X3wC70/WsIrT
	 8NLKG02NPZ6K97bXC10qqtm+S6UIwR3VTqIeAo7LYZe9/Eccc3QS3N2JM1xaoz+EQEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4JPgZp6;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0331606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0331606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4JPgZp6
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b413d04c93so3065861a91.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577500; x=1796182300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HVAJBAmjGbPAOjSl65DCtf2SbsUtmSEnDzK6RS98Q0s=;
        b=x4JPgZp6pT7wrVq1pwuY/zxlpYp8hqZaFPhvC37Nm+H2LUcN33lq2JglAF1Oh1sN0y
         Q9WWMcikWR2eVCKLJUyuXp8AlqANg7T9oWX7DX9DD0U7Vi8mqQ+4l1TDneZ3oL4cvRTx
         7DhEDyyzA6woXnmTifeCLlxvOa/YfhrEc2AiGMoqlOP0o1UmB0WUbL3YWh3XYn/QNd0B
         QrfZ/CQrbihVP7u3ChUHw8uAkKHdkfKqxTvUSM8x7Xs9XsEXGWsi1zw9Vldquj6kxTvT
         vqi7EReWIi1HeH99ONp3+pMKRM5RYHVYS/kMwg6Q7MRljYaTM6rMj1YN41zsLut3rrbb
         zWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577500; x=1796182300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HVAJBAmjGbPAOjSl65DCtf2SbsUtmSEnDzK6RS98Q0s=;
        b=0L5Vih8eEPyoKKnA6k9/nzIZCr4ix38Dtf2aSs/PHWaza3b0sBBKYc7uswqFvVMlpq
         N0ppgz7ZBhNsO8f3Ryov1tsW2OExTD9tLcCdbPK8C62wotVCEJR/1/GCQS/iE2LjX2Wx
         neVdk0UBCMrus/U2DaEruAcPYqsaxfYykHacqVupmWg78ShM1aJ8mZKjxe2yW38I5NxY
         JYdeUSjsZTVtYx3mCZcsTOMAE/c7B4/+TU1vCEfNtFHb5XMyoS1+Tt6BCdLrTdZwVMXR
         DhQJdwcmA/voXYWF3zMZ5qXkRitGLufgItpBV7ITZolQU72Necqp0PNeTDJS5bMU+pTx
         7mDQ==
X-Gm-Message-State: APuU4Z+bCR9Qaa39u+wqjRRIIkx7c72tjeBh05uKfvg1R0GQV8U5md7n
	0g78iMmLsy3/hcs7nzF3gBmHMkOg9MzsJmEIwDdyo2rNqCRibBXamPUkM23PXf+Z
X-Gm-Gg: AZFdTZeZODAJVVwJz2c6KgHnlapo1HR3fUgObqz1FHwIsWjdi+lFyy76DpGpp7uVmYg
	WY/SvKvGmo/PHrUQlN316JkP4b0B1+FP4HG72/tpb7Vr9oK6HkO7F53ZpNr19aIJgQPycvdmsPv
	dK3qVt7b5G5UNCB8mECX+fwvIX0dG76+DCLlJVnwxJukw/Ro1ldyFbeTUC7i3NPFmngSOZyrguG
	SlLeIaN3vJ+bHO7Rj7HggMlXTKyFFRIzbF0ON026Qo4/S8A+25NEuV16uGtuMIvxU69t/YRCFYH
	k0GKQ7DyvYLAKQbxvks1HqN7BCchXwzgxFM7hFNditcbj+E4SCaDMSS+Tim3BgCXU/sfQj7JzXC
	l90vjdPJGp3eeIHqgaQqcYJrYLCnLTuxfwjMzrzhQ04Xh9TaxJJ8yMqr6k6haeX/EUSS+acw8xX
	O+uXEX6E1CjdlZ/E/TVsqsrRJGgCX3XqYTDfyFbdYWqLPOBhg9MXUZFLHou8e6L1ArCOwsuuWVg
	OZMLYDg+vU8oaTrbaRPUua04NDOKTO8gRz9mhNrIIUkBkxWYuvwHVyz+VuO6tcbkPpNFEYannEv
	7Un4ZIyBewwSSEWIEUbyjo26ZnMj4FmVDQL5xKCYZ3hB1cS3T9yb+obf8JwoS0yI8yUCIUee9aK
	1lPjxhinR/UlTVX7E616qoih74aGuI84jQn1sbdqgm2mmVn9BjgEd2bnNvnWr0vzsN1wKc2q1Ij
	Q=
X-Received: by 2002:a17:90b:2b46:b0:3ac:7f4c:a68c with SMTP id 98e67ed59e1d1-3b41cb0d0e2mr17073693a91.49.1795577500009;
        Tue, 24 Nov 2026 19:31:40 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0b58fce71sm23958595ad.45.2026.11.24.19.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:31:39 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 20/47] bpf: Bound the time that dumps of the stack take
Date: Wed, 25 Nov 2026 03:29:11 +0000
Message-ID: <20261125032938.670542-21-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

may_goto looks at the time once in BPF_MAX_TIMED_LOOPS trips. A dump of
the stack takes long, and it is staged before the stream is asked for
room. A may_goto loop over bpf_stream_print_stack(), or one that faults
in an arena on each trip, holds up RCU tasks and can end in a soft
lockup.

Let the next may_goto of the program look at the time after a dump.
Remember the length of a report that did not fit, and skip the next ones
until a reader has made room for it.

Fixes: d7c431cafcb4 ("bpf: Add dump_stack() analogue to print to BPF stderr")
Fixes: 63328bb23f26 ("bpf: Add bpf_stream_print_stack stack dumping kfunc")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h    |  5 ++++-
 include/linux/filter.h |  1 +
 kernel/bpf/core.c      |  9 +++++++++
 kernel/bpf/stream.c    | 21 +++++++++++++++++++--
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e98d26cf6ced..448431c4cd2d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1841,6 +1841,7 @@ struct bpf_stream {
 	struct llist_node *backlog_tail; /* tail of the list above */
 	wait_queue_head_t waitq;
 	struct irq_work notify_work;
+	int refused;		/* length of the last stage that did not fit */
 	bool notify_used;	/* notify_work was queued at least once */
 	bool dead;
 };
@@ -4339,6 +4340,7 @@ int bpf_prog_stream_init(struct bpf_prog *prog, gfp_t gfp_extra_flags);
 void bpf_prog_stream_free(struct bpf_prog *prog);
 int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, u32 len);
 int bpf_prog_stream_new_fd(struct bpf_prog *prog, enum bpf_stream_id stream_id, u32 flags);
+bool bpf_stream_has_room(struct bpf_prog *prog, enum bpf_stream_id stream_id);
 void bpf_stream_stage_init(struct bpf_stream_stage *ss);
 void bpf_stream_stage_free(struct bpf_stream_stage *ss);
 __printf(2, 3)
@@ -4353,7 +4355,8 @@ int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
 #define bpf_stream_stage(ss, prog, stream_id, expr)            \
 	({                                                     \
 		bpf_stream_stage_init(&ss);                    \
-		(expr);                                        \
+		if (bpf_stream_has_room(prog, stream_id))      \
+			(expr);                                \
 		bpf_stream_stage_commit(&ss, prog, stream_id); \
 		bpf_stream_stage_free(&ss);                    \
 	})
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 5a664d706ee9..5cf3582823f5 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1334,6 +1334,7 @@ u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 u64 arch_bpf_timed_may_goto(void);
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *);
+void bpf_timed_may_goto_check_time(const struct bpf_prog *prog);
 void bpf_timed_may_goto_save(const struct bpf_prog *prog, struct bpf_timed_may_goto *saved);
 void bpf_timed_may_goto_restore(const struct bpf_prog *prog, struct bpf_timed_may_goto *saved);
 bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 47c43e8099dc..50d175fcef69 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3713,6 +3713,15 @@ void bpf_timed_may_goto_restore(const struct bpf_prog *prog, struct bpf_timed_ma
 		*cur = *saved;
 }
 
+/* A walk of the stack is too long for BPF_MAX_TIMED_LOOPS trips. The next one looks at the time. */
+void bpf_timed_may_goto_check_time(const struct bpf_prog *prog)
+{
+	struct bpf_timed_may_goto __percpu *tmg = prog->aux->main_prog_aux->timed_may_goto;
+
+	if (tmg && this_cpu_read(tmg->count))
+		this_cpu_write(tmg->count, 1);
+}
+
 /* for configs without MMU or 32-bit */
 __weak const struct bpf_map_ops arena_map_ops;
 __weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 83e803ea54ef..65f65876afdb 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -74,7 +74,9 @@ static int bpf_stream_consume_capacity(struct bpf_stream *stream, int len)
 
 static void bpf_stream_release_capacity(struct bpf_stream *stream, int len)
 {
-	atomic_sub(len, &stream->capacity);
+	if (atomic_sub_return(len, &stream->capacity) + READ_ONCE(stream->refused) <
+	    BPF_STREAM_MAX_CAPACITY)
+		WRITE_ONCE(stream->refused, 0);
 }
 
 static void bpf_stream_notify(struct irq_work *work)
@@ -490,6 +492,15 @@ void bpf_prog_stream_free(struct bpf_prog *prog)
 	}
 }
 
+/* A dump of the stack is expensive, and a loop can ask for one on each trip */
+bool bpf_stream_has_room(struct bpf_prog *prog, enum bpf_stream_id stream_id)
+{
+	struct bpf_stream *stream = bpf_stream_get(stream_id, prog->aux);
+
+	return stream && atomic_read(&stream->capacity) + READ_ONCE(stream->refused) <
+			 BPF_STREAM_MAX_CAPACITY;
+}
+
 void bpf_stream_stage_init(struct bpf_stream_stage *ss)
 {
 	init_llist_head(&ss->log);
@@ -531,13 +542,19 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 	struct bpf_stream *stream;
 	int ret;
 
+	bpf_timed_may_goto_check_time(prog);
+
 	stream = bpf_stream_get(stream_id, prog->aux);
 	if (!stream)
 		return -EINVAL;
+	if (!ss->len)
+		return 0;
 
 	ret = bpf_stream_consume_capacity(stream, ss->len);
-	if (ret)
+	if (ret) {
+		WRITE_ONCE(stream->refused, min(ss->len, BPF_STREAM_MAX_CAPACITY / 2));
 		return ret;
+	}
 
 	list = llist_del_all(&ss->log);
 	head = tail = list;
-- 
2.55.0

