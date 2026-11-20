Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795153919;
	b=MEpMTcG2GYhaXj1TAK2awPsWEHjceR6QuskgAWGJRLvIbYudYDTHI5pSdBaVSbFw9vJE
	 l/dUJb2Nvp4Yvvz6oABNZ/K8QSPDpjTfO6yz2gD6EDpB8kMp8Dt1kxqiIuFua9qt7IBxT
	 dmwKa2lUKeT4c6edlshzVQaeNSccCn4punq2lpjDMlnmo6X4f5Iz7NVweaaA1EPjTD1Z+
	 7tCzHnOcPXYEPGOjTpwbwPRjUj7G5owvjjPMo1Qvj0MCvRBkqZtRHVA870CdCuOd/Jno6
	 1myvQajyeFnBmdwoYoINQFA1yTx+xpWVRnWk3mWxW/gmfoMn+WADsqOvMWuSHi64luQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795153919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OBFWFQ3yvSvM14Hz5XmTfrlvvKw/w87tsoZwb4IBO4M=;
	b=vgykuvVmQnx1qpw7IH0M7U+PeDAzUjunVAWX3v9s877YboAxG5MnkYqLqRpKUKLmIgTN
	 X7vY9esS5zNyFhKwxP2tqyQqEf+F47jK9r8rmbITYAFWhfU8FvRMWBjnLyA2hXmDnX+Sy
	 1w3/iP8upTgI9XUfrOSCKRxXNDo9T0DBZR4D42HejCtBbMioRe1CYI3aG/GLj+5XIB0l6
	 uNfIBEE1bGw4t7Szn5UTiVIzB8tOvaqHgYL1hl+38/y8PsFYsasPmFmFOFQBgiXOF+3PD
	 nEvKpZyd8Y5qZg183OjpZ0kRaG4OJoLXnTD1sE32EPyamsS9VVerLFXk36st7sl27Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uwdR04+t;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9B606A32A
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 05:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D9B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uwdR04+t
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso238656a12.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 21:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795153918; x=1795758718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OBFWFQ3yvSvM14Hz5XmTfrlvvKw/w87tsoZwb4IBO4M=;
        b=uwdR04+tB/T/p2cupZCCzrCB9+v05sG6vb21FTTtLNoeHPbmCbVHjNQ2A4W4Vbc70P
         PatreL7eNkVim7Bu+1Tx2Cus1Ttd0XOVTKAeNV9j3+WuNnPHvUEj1tVSiApv+SoBLzwT
         e2yuQkyEdXbTJ+CKHdVE3oWCD6pO0I35LBfZgsdIqmf6vDt9p6rPjk2+85KvGwIurn8B
         xNLAwwp6X9a6SVKsiebmD8eof/p8Ojm4J6f2IZUF6k2m7Zf9qGv9Ht8zEYGVvbMsbCpX
         qL+SoWdUQxDpZceZ0agqSp/WWDjC+u8xpHXo96ZjdeDlHEwKPPpAdklPzFYNQXOG3kTP
         mKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795153918; x=1795758718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OBFWFQ3yvSvM14Hz5XmTfrlvvKw/w87tsoZwb4IBO4M=;
        b=jJx5o2jNzsNurxO1wOe196JxwbPuY+QRfPr1Uw72jcI6jc4kB76UFIUroolwlMWNl4
         +fZRqBmptqNF0jiuI+n7+HMyygZk39CrexPkc+1IMqRjH6SiJ78a7h5NXlo7kcbdOuYl
         Apg0Z11kYhLZx13FLgxEMrTh2ijf4VSKKFtvdMMjaKZdluxLsOysd27/GCi3p5XSpgZT
         wDD4c9OzC4s/OBzQ+hjKN7Mw/UJikOJmTXLQWsQ2FkwtE+0FUmTQbnCVdi+zraa0uCP4
         ed/FkpJ09oWDWBWtSzd0b4Lw9QV6uvygivWTl+uWxDkzV9GnL3tTXyDhILlFF5NgYi/X
         wL3Q==
X-Forwarded-Encrypted: i=1; AL+hErESeDjhkRRFZ5nKBcp2AcBHZPb1UDEOCzRQCoIvTEqgEAF0zSvNNIsrwBQKx3VkrWPQk6I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+ALf4fPSEmjNKASQbV3W+BNDR//qFVnKe0U92Qpl5/UEL9Oi4
	wvxxxF23v+83Wo14KW1PhJc0SiU8KzeMMHloOgB4I21kDYIQiA+wvpqh
X-Gm-Gg: AZFdTZdjMkuwX6Yv9es3LCNPt1fmsDdi5vXRKRp/VVszAhGZcltBKVCDATTtby/EfOQ
	xwJ70yhdm+NEbACACux9sAP2FfeMgWcOl6VS3Cks5rtnyZaGt7l3C8RuAcaau0NCic+aJ01oTKs
	wRTAgPkCtENbgFLxChtpzG0GWV+XDK894m/8/OezysHd0XyDCsvzEfw/FL7LmEoFUixtAl4yiOb
	vucADyYbnqTLWBbIGM4AG1i1UZJL/Gl3WX6hI2REPiRowuw5ZMtztKPMXlpOEfYXst2zZ9Ok66C
	cNgcBv0QchPDhPPBL7W7VxsPuBmFiGzrSs8fspiFLMGBuZTfw8OT8aavZ3UCIupNRzMEJPc6vmI
	mMpMpBpqlirvy3l4D0ENW3OzGD6EmcdSdTKN1x4YT3srMwVijjwRkaNh+dGFJFZ4CqzWhnxDcRE
	6Hn/Vwo2KUM+QlSXgTs1aNjtxZ+UvA3QTpH3RLDkz0VyAMzz+feOAYBHB1r+zipXhWhAJo3kIYx
	UwjRsUgDlIM2KRo1clhJamhn+46KcKO8k0EdRRl5f1vb2rjG6sC8omyYDvaI9YYT/Feru1TZIc1
	IgGQunoyk4csKAOVkfbc9PDb3X3PmXImc5Uy0CSzpUkG9iu4hvT96ZWZKiWUiotl
X-Received: by 2002:a17:90b:380f:b0:3ad:1da4:2ddf with SMTP id 98e67ed59e1d1-3b41cb0cae0mr1572880a91.51.1795153918487;
        Thu, 19 Nov 2026 21:51:58 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40a878d50sm5104045a91.11.2026.11.19.21.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 21:51:58 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	haoluo@google.com,
	brho@google.com,
	joshdon@google.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] sched_ext: reject oversized dispatch_max_batch
Date: Fri, 20 Nov 2026 05:49:08 +0000
Message-ID: <20261120054913.3795562-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

bpf_scx_init_member() accepts dispatch_max_batch values up to INT_MAX.
The value determines the size of the per-CPU dispatch buffer, but
__alloc_percpu() rejects allocations larger than PCPU_MIN_UNIT_SIZE.
With BPF_F_LINK, an oversized value passes the struct_ops map update
and triggers an illegal-size warning during link creation before the
allocation fails with -ENOMEM.

Calculate the buffer size using the effective batch count, including
the default used when dispatch_max_batch is zero. Reject values above
the per-CPU allocation limit with -E2BIG during the map update, before
the allocator is called.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/sched/ext/ext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..93128da6b126 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9197,9 +9197,14 @@ static int bpf_scx_init_member(const struct btf_type *t,
 
 	switch (moff) {
 	case offsetof(struct sched_ext_ops, dispatch_max_batch):
-		if (*(u32 *)(udata + moff) > INT_MAX)
+		u32 batch = *(u32 *)(udata + moff);
+		u32 nr = batch ?: SCX_DSP_DFL_MAX_BATCH;
+
+		if (struct_size_t(struct scx_sched_pcpu, dsp_ctx.buf, nr) >
+				PCPU_MIN_UNIT_SIZE)
 			return -E2BIG;
-		ops->dispatch_max_batch = *(u32 *)(udata + moff);
+
+		ops->dispatch_max_batch = batch;
 		return 1;
 	case offsetof(struct sched_ext_ops, flags):
 		if (*(u64 *)(udata + moff) & ~SCX_OPS_ALL_FLAGS)
-- 
2.56.1

