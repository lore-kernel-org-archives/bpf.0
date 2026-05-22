Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B63A5439
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435970; cv=none; b=BxSeeaL5QgQM7sXE8VDyzm7FIzvF6eb+ONVvvjYw2MVWST1mtPDtdXdPaX13N81v/ZylYjPmIfBMj2Ky/JeGfxuoEQz7PGPbysQ3cO0CcnfPztPDdp5r6d5hJCD0OnK4uLHBP3SPtqQpS0OhVxLW25aWnffhEgOie6KiSjFnhK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435970; c=relaxed/simple;
	bh=YGrfI2hL0wwPAhTinlsXS+ugZFdc+65ByQaIbLZr3QM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sKkoWeIr0iXg82d7sjb4OuLJyg/MTOcf81n/LnMZDac8hkAA3mG/WTsBP8sLMODhlml7zG2O+WTMHRxju3ykl+uEx6LTwDpIJCfrc9b2iaOI/aa49gOWPRbZVcaSFOpLarp286H7QEvdbOKxciNGlm1ldqY8E2q0SywXQYImcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QeCI1/1j; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QeCI1/1j"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc763c7256so161549835ad.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435968; x=1780040768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9LfzZEWp6FpHKgSQGvAVVGBFaWBqSJ7AoOM9fQmKEs=;
        b=QeCI1/1jeIUuEfS0fp3akjvHllz+KOBdrc9QPpfbt5tcGN8ywdMWLlN+KM4+h2igYC
         fCSi+7ASXeZSMacO8YBIj/CpJ7st/q2cH+aQBReZJpyzHVnNFtMUxJ6W1BOrp3kegWOw
         cXaqmKH1wmSYOBmsO/nnzZafwqmXyKSPE/OwC+FtcIdajwDNg+yX8D1aHvzk3X0KkHYt
         JtXnlN8Jn4m+V1ep+gMKk4gbXMxsuBipmOZXtEC1q5dFvupbPPS8bdNaymddxVO+VxXj
         Zt0Xq3XACTpKCtawJq3yG4ldc4tD/VT2SEI0Ez0m/QmxFakcewO45/fUcSykr7sLaf5I
         P15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435968; x=1780040768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9LfzZEWp6FpHKgSQGvAVVGBFaWBqSJ7AoOM9fQmKEs=;
        b=HZTW6uIs0fJQaHglOt6sW2oc2xkIG136AD1U5ULSsQ9KaHvWkQwy1jbuZq+LfjM911
         YeP7OKGLk/LlwZOTvUL2s0nahDxWfaIVoqtqSxXSpUsCMrRjUQSHzfAIsL1ko3K269Qg
         mtnQATYSn0yV0goNgxyWWyWjnPwhZubm0veyTHQB5saQa0br0P1/a6s7K5oXtzQM1eBy
         buSk/nVCxLoZAVS+p4kuBMhB+HSuxKx1Ms9RaepRBH5JaPWcY5HEko/1IgJ9Q7SaraVk
         ATO62xyA+5XsIPg+NNNGs1FAw4+kHg2vzVQ0K1RN8rKGTviLeaWqEfQMfEecPbFi/9Qk
         HwKw==
X-Forwarded-Encrypted: i=1; AFNElJ85A6+aIqM1Ekvyf5x5BjRPZjsy69SPqfJx851K7iCH0jqrqR0aXFI0N/SUtA0HjPJOpBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/waBUvG0slDmwdJNw4MBqH/oUMEK3WTW7Qt75uRcgWgNfo9s
	iSHfX8KaFVBJLQmzGSHCkIOxn71ZNBHaIKGbZcshqB5GdGktNtWIHbRvcVsmy3mdesdBxpy/1yh
	/PG1Rwg==
X-Received: from pgum14.prod.google.com ([2002:a65:6a0e:0:b0:c7f:cab4:88ec])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:594:b0:3b3:f46:1eea
 with SMTP id adf61e73a8af0-3b328cba26dmr2426731637.7.1779435967789; Fri, 22
 May 2026 00:46:07 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:54 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-4-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
prog can be called with BPF_SOCK_OPS_RCVQ_CB.

In this hook, we want to parse the RPC descriptor in the skb
and adjust sk->sk_rcvlowat based on the RPC frame size.

However, we cannot access payload via bpf_sock_ops.data on
modern NICs with TCP header/data split on as the payload is
not placed in the linear area.

Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.

Three notes:

  1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
      invoked from recvmsg().

  2) Access to bpf_sock_ops.data will be disabled by passing
      0 end_offset to bpf_skops_init_skb().

  3) ____bpf_skb_load_bytes() is called directly instead of
     __bpf_skb_load_bytes() to allow compilers to inline it
     instead of generating a tail-call.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Explain why using ____ version instead of __
---
 net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4a50fe2cd863..fa8a7c7d86eb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7760,6 +7760,38 @@ static const struct bpf_func_proto bpf_sk_assign_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bpf_sock,
+	   u32, offset, void *, to, u32, len)
+{
+	int err;
+
+	if (bpf_sock->op != BPF_SOCK_OPS_RCVQ_CB) {
+		err = -EOPNOTSUPP;
+		goto err_clear;
+	}
+
+	if (!bpf_sock->skb) {
+		err = -EPERM;
+		goto err_clear;
+	}
+
+	return ____bpf_skb_load_bytes(bpf_sock->skb, offset, to, len);
+
+err_clear:
+	memset(to, 0, len);
+	return err;
+}
+
+static const struct bpf_func_proto bpf_sock_ops_skb_load_bytes_proto = {
+	.func		= bpf_sock_ops_skb_load_bytes,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg4_type	= ARG_CONST_SIZE,
+};
+
 static const u8 *bpf_search_tcp_opt(const u8 *op, const u8 *opend,
 				    u8 search_kind, const u8 *magic,
 				    u8 magic_len, bool *eol)
@@ -8616,6 +8648,8 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_netns_cookie:
 		return &bpf_get_netns_cookie_sock_ops_proto;
 #ifdef CONFIG_INET
+	case BPF_FUNC_skb_load_bytes:
+		return &bpf_sock_ops_skb_load_bytes_proto;
 	case BPF_FUNC_load_hdr_opt:
 		return &bpf_sock_ops_load_hdr_opt_proto;
 	case BPF_FUNC_store_hdr_opt:
-- 
2.54.0.746.g67dd491aae-goog

