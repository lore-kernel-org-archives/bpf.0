Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559945;
	b=z/JIwzar5JugS9WGSijBANxiXUC8fnXvx9+JjRnO4uzVk9sdDK6x5QA1UHsDyvUxJu4w
	 Ycvqmo1G7xOf8hJxaT9bTzZOvkWmY2xebEruGiiloOaXzb+hsOg3qXAe5Gsx9r7HiqG8V
	 I+HALUbZYjGSmC+KEMc7lKLq3Mgo/djXcmUCAuI2bLGDXRKXLZXCuM5GuPTFprdACzgBD
	 X4DX7Q1/8V4SZMqEegocIvPx2xxZ5FbdVqrKSm0WknSHcteqXvWjmwuxb7vhdWjbaezdo
	 4QwzDcHPGNnnn9riVuaefu4fMeBlW47RuesHvQ/uwfKM8trdtSg14sJI0zUgNaL8vng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=svjOE/n/Fd13ROHNQetyktt5qAG2/EiumbQrkwIKbsU=;
	b=hVAbw64pLVNvtW00n4dO+oamnq+BXrOs6w45Uv6pwI8ZrXTtbNAd9Fnc+Nujepksjywc
	 2cIup3NGyKDJGFhyHQSyoGypI//4PH7KOH5ntC5iQx7K98Xwbd7bng65bxPgVdfqWHsmG
	 +4howAg/H1UWV4GPZ9z9UHaphyGtIRZRTrILN8LW8Bfi7baGntiCpzTMtlIgqFhPtyLvF
	 gf5iDHABGxzeORYUMSTR5olSS4UPt421HUCy6lAgu7q/4wgUjNWP81J0lpjje+db79GBz
	 dkyf1eGCVqbxJNVcqMOAyxzUbvdktSKK4RIbqYOgk5vwvKNqtE40nNF5dTxuFbwZMiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XKtTurX3;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0A7606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C0A7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XKtTurX3
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a058f74a54so700964b3a.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793559945; x=1794164745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=svjOE/n/Fd13ROHNQetyktt5qAG2/EiumbQrkwIKbsU=;
        b=XKtTurX3Ql5Zu+RBfoPTH6MLol7lxHvIDhdRdkIdStReD7Dg70d70sifCQSrNcQBiu
         YI0QQqpkVUZd5dQvqIDmTl8l/1b2IcuEFuPIE8xYE0hxxIUJ3qFwsMNZzNnq6PuxVk2Q
         d3X/9vzTgfp5Bwp7Ffn0LHmV4QQeesyq2bQOWcHm6FscdaUyCHjdZvEGTai56S3g69G+
         uoozO32Hfp47ohDzO79zPSYobDVo+8QulibP1dyEHTiOMeKfu9rBSWeFDL0LIx2sFyxq
         4sBf5FYPL4olfuyKlYWCZ3vl8UJNpAjtLjPkAVm0xul2EmSNyGxwdvP67Fhd4Zgvx6r0
         wGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559945; x=1794164745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=svjOE/n/Fd13ROHNQetyktt5qAG2/EiumbQrkwIKbsU=;
        b=AAwF/1eGwD215KeBxcfntKUtghigunTeY4DrKDOiNb7zUCnC5D5Rok5A/pg8Qx2GW9
         aXBm9dftdjGj2jDTRJo9gc/zOX3clhMGD+l9XSRBEkgAAFutb4ZYC9yeYsx2mvoWXi5o
         p852BnVFG5IgWYPhm1Vl62wK+FEGF63Yp2FCrIm3oQtO2T5WKVYNgmf9dUXLaCL2GZK+
         N/PDMkGjb6KX51RZ9pBEA5lilroomsY5ZkNLpZUt2Qvvqn0Rb684g8IjeEKXCvkqD6XG
         b64XYqZe7BgRvNfGdHwYxeavrbtGy4AHMZv7HTi6JnKYZjkkscTjrVIxkXQA51Ya3Lc9
         IWgQ==
X-Gm-Message-State: AFq9FYJGHqETSF8ViWHbRedKRO8sE+uWg8NzBuf7pELe1foi/+K2cGpW
	LZ1K9vz8ddIqi0R/XLxjLkRfF13rIqFfoG12oyDkVLG+Cct3qY6S7ZoPjmHGtw==
X-Gm-Gg: AYBFou3rEig+SJr4jbonbIvGpy9EmlEgJdCU5jAMz0MwEHGWwHepGLFUVNUQnAhEyNO
	ryGukQm5TyJjBcmJoOO1loGPuKd2okKYl65As65VQ+WiWPL9am1XTLlZLoNlyaw34841hsMp7xc
	dBvmaexO32E94nOZ5IBFAn/Qvwp7pACBEur/ogkl46XDc48hKV45doSKUZTYFYbDhUKAy5+1HwB
	msyot43W3ZjvD6Kx7LOlFNdhknPFoBhn57iax9k4GbfnqdZ6afZ9yvS0hZ67Ny8AMXS07D1imQH
	Jqm9HYjiDeLzPiLVlfbuVcADFoDxzDtPqlgb5+8H5/eh8Fer03/pjAtqKOCVFRsNMSUoog8S1V3
	02D902A2zefXMdj1Wt17PKXYbjqiZafyYE99/lY4ug2PvxypDm25Qatl0Q/m2mJ8FQuWBHkQA1r
	X6CLFIYaAvAlIBE4PkWdZXdBiN8ZoC379z5zhWFqu8FJFnl2xTEBuXP0V96Vz476p+3WLUJtrJh
	+K8pudGc02d15sDua2sN+7Hd4ONLayxqP/o28C4hKsTs9CoWaLTxDAU0kR0hi+1zXbq+0C0Lg7H
	wn+mYNsXNV53Z7/1WQW1Vjr4TJRUgHYR1Rqin4HKV0tH7/oN40DqJ1qfGWwmsAgZMeZQvELqnxh
	Z2y1WE9zvaqtreeZgfzYMRhc5bxp1DH5V8WPc10uvenp41UyNy/FStt3lGSMSUtjZ6N4e1WUDtg
	==
X-Received: by 2002:a05:6a00:1491:b0:8a6:1bfd:41fc with SMTP id d2e1a72fcca58-8a9bafda28bmr6398365b3a.1.1793559944538;
        Sun, 01 Nov 2026 11:05:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d03424sm1211500b3a.24.2026.11.01.11.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:05:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 01/27] bpf: Clamp the trace length in __bpf_get_stack() again
Date: Sun,  1 Nov 2026 19:05:09 +0000
Message-ID: <20261101190535.1454146-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

get_perf_callchain() and get_callchain_entry_for_task() store a trace in a
per-CPU entry, one per context. They release the entry before they return
it. Thus a second user in the same context can write to the entry while the
first user reads it. preempt_disable() stops only other tasks.

__bpf_get_stack() requests at most max_depth frames. This is skip plus the
frames that fit in the buffer, but not more than perf_event_max_stack.
Since the commit below, it copies 'trace->nr - skip' frames with no limit.
But a second user can store a longer trace. The unwinders of PowerPC add
context markers that max_depth does not limit. In both cases the copy
writes after the end of the buffer.

Read trace->nr one time. Clamp the value to max_depth before the skip test,
as __bpf_get_stack_pe() does. Thus when max_depth is less than skip, the
helper returns -EFAULT, and 'trace_nr - skip' does not underflow. The
copied frames can still be those of the second user.

Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/stackmap.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index f7e8d766d128..7d90891cce0a 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -822,14 +822,20 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 					   crosstask, false, 0);
 	}
 
-	if (unlikely(!trace) || trace->nr < skip) {
-		if (may_fault)
-			rcu_read_unlock();
-		preempt_enable();
-		goto err_fault;
-	}
+	if (unlikely(!trace))
+		goto err_unlock;
+
+	/*
+	 * trace->nr can be above max_depth. The per-CPU entry is released
+	 * already: a tracing program or an NMI which takes a callchain in the
+	 * same context before the copy below reuses it. And the unwinders of
+	 * PowerPC store context markers on top of max_depth.
+	 */
+	trace_nr = min_t(u32, READ_ONCE(trace->nr), max_depth);
+	if (trace_nr < skip)
+		goto err_unlock;
 
-	trace_nr = callchain_store(trace, trace->nr, buf, elem_size, flags);
+	trace_nr = callchain_store(trace, trace_nr, buf, elem_size, flags);
 
 	/* trace should not be dereferenced after this point */
 	if (may_fault)
@@ -838,6 +844,10 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 	return callchain_finalize(buf, size, trace_nr, elem_size, flags, may_fault);
 
+err_unlock:
+	if (may_fault)
+		rcu_read_unlock();
+	preempt_enable();
 err_fault:
 	err = -EFAULT;
 clear:
-- 
2.55.0

