Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644186331;
	Fri, 19 Jun 2026 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828846; cv=none; b=NDeiVxWrgrruuqianujaSIACcZm2H2LBIU91Q2gm8ZX6swB3rzmxQAJQS3RiFIxPTJu/5mP40fifrDnDCsw9PPdWiEJEh3GsMHY9IeLGIgeXrKxvkMXQoShBsc4HUO1lQuCYTLw99lmkptFDkON1ACakiVq0lWMB24GgmNxA+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828846; c=relaxed/simple;
	bh=UPUdDUPbs7iMCbosBePwRY2ube8h1ghRx+S84Le3f4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMZ5lnwPi1r6LEtKDrFlzoc1nXvG/qbF+i8Ok1KVXxIfdWokooqVFx5qMGtM01jd2gtKKCz99NKEpoU05WquiC8Aw+C7IAX824SQfJDkuBLE4vsjArMBqTBH3gUKUXZ7qlbs0DuFWdzJtZapvMT/l68fnWmbhaMjSVPSzVpLPGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQUCoSHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQUCoSHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0231F000E9;
	Fri, 19 Jun 2026 00:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828843;
	bh=Rl3hLtJHPeTaw8xSqhav/Hnte+I7t3W/3SaZAlb6uVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RQUCoSHAUw52HHxuEgx5BDyy9Pu2ou3w2V4JqcBDUFKbQo0sb7haWmRB6JoOcxuvN
	 pTaz+Tk4aaxDp8ND7ewCQxPAMRmXrPZnKe6qe6eibpN0KqoxR2OZ8NovKoyqynWeMd
	 RqhEiPacj90fl6FCT0QP1Xm9vzCILmsdQ3ArvFGcKt9x9VW00J3vaRgXnIWYevBJsL
	 6ulB7ladT/5uupqfEnjttP9+9XiuEPy8UIqTmor4X0+YljwBKNf5TGzr+yEq41n2oW
	 vvo48pdBwUG6GvyS17rJIIwpGhHvqpTRlqe+UhW08r7zPPIHLUnA1Q4J+GNcWuGKq3
	 B05u7AgM2V0oA==
From: Tamir Duberstein <tamird@kernel.org>
Date: Thu, 18 Jun 2026 20:26:44 -0400
Subject: [PATCH bpf v2 6/8] bpf: user_ringbuf: Handle position wrap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-bpf-ringbuf-fixes-v2-6-33fde039ddf3@kernel.org>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
In-Reply-To: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>, 
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
 David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Tamir Duberstein <tamird@kernel.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544; i=tamird@kernel.org;
 h=from:subject:message-id; bh=UPUdDUPbs7iMCbosBePwRY2ube8h1ghRx+S84Le3f4M=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFkmPdc/r/re2HisceVK6eC/Yvxni81WpMvJbl3T9oXlx
 nznuPqvHRNZGMS4GCzFFFkSRQ/tTU+9vUc2891xmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHQMeYgYtTAKY61JWRYU7pbL5P5+uU/0zpC0oMSPkz9/ozvWPC929Mdq4wMtJr7GP4Z7rq/Ny
 n/s6rK50En/NFLOlc+rDgzdeTTld/tRjtMF6ZwgcA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

User ring buffer positions are unsigned long counters, but
__bpf_user_ringbuf_peek() widens them to u64 before comparing and
subtracting them. On 32-bit systems, producer_pos wrapping below
consumer_pos therefore appears to move backwards and permanently stalls
the ring. The widened subtraction can also bypass the advertised-window
check.

Keep the positions word-sized and derive the available data with
word-sized subtraction so the arithmetic wraps with the counters. Treat
a zero span as empty and reject spans larger than the ring before
reading a record header.

Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/bpf/20260614020552.022A11F000E9@smtp.kernel.org/
Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 kernel/bpf/ringbuf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 909880031fd3..19cbb9b74ee7 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -748,9 +748,9 @@ const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto = {
 
 static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *size)
 {
+	unsigned long avail, cons_pos, prod_pos;
 	int err;
 	u32 hdr_len, sample_len, total_len, flags, *hdr;
-	u64 cons_pos, prod_pos;
 
 	/* Synchronizes with smp_store_release() in user-space producer. */
 	prod_pos = smp_load_acquire(&rb->producer_pos);
@@ -759,8 +759,11 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 
 	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_release() */
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
-	if (cons_pos >= prod_pos)
+	avail = prod_pos - cons_pos;
+	if (!avail)
 		return -ENODATA;
+	if (avail > ringbuf_total_data_sz(rb))
+		return -EINVAL;
 
 	hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
 	/* Synchronizes with smp_store_release() in user-space producer. */
@@ -770,7 +773,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 	total_len = round_up(sample_len + BPF_RINGBUF_HDR_SZ, 8);
 
 	/* The sample must fit within the region advertised by the producer position. */
-	if (total_len > prod_pos - cons_pos)
+	if (total_len > avail)
 		return -EINVAL;
 
 	/* The sample must fit within the data region of the ring buffer. */

-- 
2.55.0.rc0.159.gbe5d7338c2

