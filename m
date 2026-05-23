Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178835A3A4
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525009; cv=none; b=eY80MX+PJcJnG4kkZeJ8kC2jcM3OmqIEwPOJsEGZnccFd6UAL5ZLkCirWlV+xGxcTHQrHzapxiGxE1bBpS8N7rkttnkl9mGMO6DZe8zXl0LOoE+BUhLHXBDwv0Lh98GJtiPzOxlxK38cVze9Ch9emmUqf6wsGr4L3gf6T5hBMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525009; c=relaxed/simple;
	bh=YGrfI2hL0wwPAhTinlsXS+ugZFdc+65ByQaIbLZr3QM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M4fxooYaLSv5sff5x/1cTWlAVoa5ZAVJK1RilqF5QM1Y1RLbJxcMFR0aRrV4g0xVleeaVO6bbpLLN6rNIJsnxFvPTQLm6/PyTpFFSWXZFTZAowMwZEDRGLYb3BWt4r/svuaDyxJU9XEixi1NY9sINeEbQDAz+IFhsarkGRIopGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=myzaeVHJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="myzaeVHJ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd6aeb3637so195865935ad.2
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525007; x=1780129807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9LfzZEWp6FpHKgSQGvAVVGBFaWBqSJ7AoOM9fQmKEs=;
        b=myzaeVHJns+3Y5NeTf3eFTFyE7GdKMDpxDdb28r6yhLAMT1JiHDiNXFMXMD2gbVH+x
         vyWMmOe1JwKO4eTCDVsdg6OCQcUQpwWdjmyNqGP6BoNh2x3zrUl0C3HdV/udhKAWzer5
         88eFaEuTe0wAHIfdVdJS9OPOZ7LJrsnZpNvHPycl0E1BDwx0+wKlJIVOvJvz3I4fczoF
         6VLnhmyc7t6tV4Nmbd/p0DAMbiz3vJ97DPvWPkR0aS42z7spoGfSbGEbBpkRy0TYNAdm
         4RjcbHBiuur1TGNpv1gHJzE4zHfVYev0s92iXdk0uFkHPRVtkUKJh6/1INHb1l7n5iAb
         IxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525007; x=1780129807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9LfzZEWp6FpHKgSQGvAVVGBFaWBqSJ7AoOM9fQmKEs=;
        b=dA4TNv5q0KGaOyVLhK4iiFmhbqXDKZcYMPeYh3hLR+S3i/NIAUwRhncJO9Jwhic326
         ZbmcPtkrZizLEdLTbgQ2KtXlbacsyPHtPtP19JdX6GvIaHZ/7rm1flpbNG8gjOh7euK1
         0DP+Pc+AdhCwSrUAAfw+KAs/L20m+UMUAJF6dqe91zJwqBZ98IzQMOPFSK/S/w5SD8FJ
         AWO2qwLxHvjzXYPU10vlyV7UAyudrkzk8KcXQNdp4Q7iwLW0QNR45ej9e79WfNqGX8yR
         BuEvLG5Xnt+g8sXPsDAepIW3bqspbP/WHwox2sB9f7JapNaN2boOZgXb6aLsnqu5i3ef
         agjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tX1qQyDNd51aq93tbvSj3zE5cHFyljB1yFkZJicR5GTwjtm31WsgyqkdMd5+5UFPsaeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwohAnCUPDfhPJCcPDUCjX0lWZq7cJe6E6E8FJcasD7hC5OxEU
	vhwVFNH2wLC6ycws0mTRw0d9Ntm02vNg7hSg/HbaL1nA86y8OxUSGoJNjtHZiLkxPc7gvA9nJU/
	culpc8g==
X-Received: from plht3.prod.google.com ([2002:a17:903:2f03:b0:2ba:903:90e2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c951:b0:2b4:5aff:de60
 with SMTP id d9443c01a7336-2beb06fc2c0mr82433795ad.22.1779525006541; Sat, 23
 May 2026 01:30:06 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:32 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-4-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
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

