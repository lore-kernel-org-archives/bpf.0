Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F74A0F0B
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278691; cv=none; b=lOyNJcMnzob6n6AxSbQbc+a+HYMqrafEQ/7TgZwyEdyfaEqQWGn6IKbJOjxFKdpRUksWIXgiAziWKND6XELHHkqI2WKBRxoV2YgrRkgCnBnoSphVV4ZgzHYzWIX71FNBxlYnZqB0OMADkzzTyhX9/o9v/dftzBxp4awQPP9E0/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278691; c=relaxed/simple;
	bh=tfcvw00uHTY23YRxDvHsiw/Q54ercj0t5HvX3Tm4Tg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbjOS4QxBVMMFzBybrcHSoU/NR4nsJzTgIsQVVGz26O28/qIOYIo0WZaNRGz92LyXUqq8U+YgKUbADzVD66+Nzj0IqC/Fu2WfHipMcpF+GL+MBlOj++LbdVNDk3C+fmb+jFISIz6N06i/lXGuyg5/fyFdcRC3u0oA2PZ+MiqD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY25KDA1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY25KDA1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac5b090d16so635971a91.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278689; x=1792883489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VbFa4jjlS1E0gpZWmY1/qHYgkgCG90S6QCrInMcS6VM=;
        b=fY25KDA1CepehT9jnCuqGd/Ighk9Iurr4qamoYzuGUX4oOLC1YDUzImcSB46fnSsHd
         pRRPGgdn0fkbUcMfgoJIfFODGnRbeS/1UnvOPjepAZ98rPjhVaqLv53W8xeu1bfD33za
         Khoc07Nf0lEBBm+vmxOXUjzHRMACZuNzTPzkh+POhVDZ59PypGI2dxdJ04vk0odp7/pw
         HONsYl1mbyWHReLwtQkVOi6L5/iExLLU04nFK684qrlgo5VnFt0cT6QrnDN4bPocghY9
         HEnNqVx/XgP6zn1oKyC2LaUrRzVTyYBFMdvh8VW5qG+QaHsT/rKy2PW3/aABYAgFYiYW
         6CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278689; x=1792883489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VbFa4jjlS1E0gpZWmY1/qHYgkgCG90S6QCrInMcS6VM=;
        b=oxDhM2KUq9yAQ6jMZqqOyUg9qacuMuvCHq9cmXcn8qwvT5SFeNHv6tn7foC99VdEZn
         QrGMWbEOjXAlEQtL7FNW7+CSLCd9+XJvMYQb8viODVpuD49Hhyo7+UvHavr7yDN6iZEZ
         NyWpo64sGxiC4ci7TmG7MBrzShDBl6tgwpLf4TdOetW2eAApvGn4T0fIQz3fpMy4+9tD
         rMGDXIPNXs4SPB7Bl6z47o8RH6bxUBwBGoAqY73/t5zenhWf2XRaA5cgSMuXYh+5Bzvq
         LpP/XLZeXTL1cZwZn4jzHL5Ed7bmam8jErmUcL7bdnYuaeyPtuvy6z5BRyvuSwQHxNfN
         9aMQ==
X-Gm-Message-State: AFq9FYIUhExcGyj1nR1Q7b8pplSQOYW1s2P13S5LeVedLTNvELVNq91K
	j1YPA4HcLRvnPN+tqxJSjZlI95M0auJZqdaszLtM/OxhTXiT6280IcG2UfpK5A==
X-Gm-Gg: AYBFou1bFoAIzjaDC//5bveazhrpiQhx7LwZIsd0ekjBgtPMnJG5OzKWyaCyRXTbav4
	bNQswiLKH7BFVeG3TVyUwZBaMhHziv1DIRQUfWZKzm6ZVyRO8cdidUWaPmpelY2Kvh65NPgNB4m
	D+mT27lfSeb1GGQls3hCzY4zQip1Tr/Kl+nc3lFd1uvgMfFj42fVTvP0d+7QindchIoCwz5+P/X
	dFhKHScqvs9JSLoKoO1H02X5nDnwGgtZZK5oj0ryLhtruX3nzzupo0eVToHOlIGWHOia5UOpX8K
	2KR0RtVYXYMcLw06G9PS5a9Q6ZsLs+6ilRqzzs9mNbZzORUcDQ+mDGBlhidkWRIzKVloH9jeM34
	w6sW6oEWYucr5kDqy+i32JM48NJe2HZABSn1MWBejdR6OSHPygP+tEHJwktaou9kfNAtc1eJ+TD
	SSO+oty1t4dDHBPKIXasezo6bwheeG0tks3E+4DhMOJYU4FfJM5hSgYr2ie51VmMYYAvUE0SKAk
	ZMR2lQh8Upn6bj9BFPTiEJEc46e2uOeRhE4v14JtM9VTRPyWktiuW0PGJ6Kp1XcGv2WwFh1UKqS
	+x7mwWhmNwjqtbX97qUyLgHVXVwAaai2Y7lto/mpxsU=
X-Received: by 2002:a17:90b:4a45:b0:3ac:b6eb:e0cf with SMTP id 98e67ed59e1d1-3acef5dcc94mr2389764a91.40.1792278689380;
        Sat, 17 Oct 2026 16:11:29 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e7320sm14331844a91.6.2026.10.17.16.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:11:29 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 16/16] bpf: Refuse packet slices for packet-changing helpers
Date: Sat, 17 Oct 2026 23:09:50 +0000
Message-ID: <20261017230950.802052-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The helpers which may change packet data do not take a packet pointer as a
memory argument: they have no pkt_access. They make the skb writable, or
make room in it, before they read what the argument points to, and that
can reallocate the head which it points into.

A slice from bpf_dynptr_slice() of the dynptr of the skb points into the
same head, but it is a PTR_TO_MEM, and the verifier lets it pass.
bpf_lwt_push_encap(), bpf_lwt_seg6_store_bytes() and bpf_lwt_seg6_action()
then read the old head, which has been freed. bpf_skb_store_bytes() follows
the head by now, but a slice is no better than a packet pointer there.

Refuse a slice of a packet where a packet pointer is refused for that
reason. All other helpers take slices as before. bpf_dynptr_write() and
bpf_dynptr_copy() can be used to copy inside of a packet.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3bc1df7aabe2..63fff641d985 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9687,6 +9687,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (err)
 		return err;
 
+	/*
+	 * A slice of a packet is packet data under another name. A helper which
+	 * may reallocate the packet must not go on reading from the old one.
+	 */
+	if (is_helper(meta) && reg_is_dynptr_slice_pkt(reg) &&
+	    bpf_helper_changes_pkt_data(meta->func_id)) {
+		verbose(env, "function access to the packet is not allowed\n");
+		return -EACCES;
+	}
+
 	if (arg_type_is_raw_mem(arg_type))
 		meta->arg_raw_mem.mask |= BIT(slot);
 
-- 
2.55.0

