Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA037AA8E
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225661; cv=none; b=tgLW3tXQM0tRxX4Vc2qHWaAotB7DwoXo0SUGEcxh/Eo0Yus2Zca5ZlWGiQK/BMk18vE8MDJTG+8BTy+hXVPde1NUp/EVdaO5fi5X4YnQ3fSoznK/IWgL2xwsHclgq/J+xdukRcsuVmXjMuAaWQNCAf8mMWGN0o61pLS6qbEZPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225661; c=relaxed/simple;
	bh=26gn+M4pY38Nt/IYcQ1MvzQNTcsML7huVSIiWFPsGYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f5HnWQk62ODfd9YY3jPkDEm1kE4vxSQrsCm7S35xCt33QONk4qEcZBAYeOGrtNuq/htlSdCX2bPixu8MoSt/p26JihBo4fzrcXXrBuytouV7VV1BdR6vfmQXYPLv8aRm/VfdsRSpe3tvMuTIRBlY9kylCwKOVDc1MD/W/bbyDXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n6Z55Ff9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6Z55Ff9"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so1737695b3a.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225659; x=1778830459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwlSPJSVpKQDjKE55hD8gfU2VDN+huaExAB4xtPp1vg=;
        b=n6Z55Ff9+yzq2CCsK52w8J3b5CGgFm5hxIwwsoIedRQ+TcjcffHgm3cgrgp4kD3tSV
         PXMCrHKU6p2r1tfTXVRcKssh2PDc3ZrOZbG6ytHYGyWKpqXL0gnXb2ZmVTXaxYmg/6lJ
         h8wMneG1ZjhWgnIEEvFvnEUNLbF0TuND+Feb9quou+WQ+WuvCFAABUZbu5/weeGTU/8S
         rXGENYqoSocxBrgu864WnbStsoCLtH5Vvw3MYradMzWOEYGit9QUEWnN57PmbpKdz3JX
         xmVFgByeyWZePZbSH7oT8KNFvqx+lqAokGOiLpTtD4/iR+Ls0/uBzyNllpG8zNNQIYjM
         Yptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225659; x=1778830459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwlSPJSVpKQDjKE55hD8gfU2VDN+huaExAB4xtPp1vg=;
        b=X9Ch3zfxwjHhoLJyuLuZ3SZriMCT/ETehVCt8QaItJjw4K0BgXNdFyEkmoUP00V0Au
         6JENzGVYpDpqEUkVIFhxrkdI365tr9g2yU+UNunP6ANcZqZvpL49/YOnEbT8JbsjCuPa
         MP46BBhJYTSwraSHnWXrMk2pU/h1gKNNGP/RSypqWr5/Hc7yoGLfgOo6oam4rPZyqzm6
         mhv1HRoYeO+b6Ms93PDDDTdr0C/eBIYXycfRJrZ0fOHcpGqz5y163OvwQej/WcKt2GTd
         ZxF1rnlgmUHw/6DyHApkhMN086xifXg3gzCyRGN5yGxO0A6C1Qrnjp8Q9d6UijZ1OsaM
         YTwA==
X-Forwarded-Encrypted: i=1; AFNElJ/lcbLjdkxztbEKoQ0buCb+sLMTtaHoe26Xjl3ADmkEsMJKu0SEmKGm4hgSeq8J+T3Y2sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCc57IEhOintfwXSEJauLCoWr1bQbigtBGyZWwXWbfvhMRzgyo
	FpnhDXqgW0d2vQz6v7kbAMC5LUy1ocVuuTjGYK151X0bUR4b6GWb9tloMMUZcYi9HLexwU0q33K
	90iKkxQ==
X-Received: from pfcj19.prod.google.com ([2002:a05:6a00:1753:b0:837:e800:7c2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a21b:b0:82d:5da9:adc9
 with SMTP id d2e1a72fcca58-83a5c2be03dmr11803194b3a.12.1778225659127; Fri, 08
 May 2026 00:34:19 -0700 (PDT)
Date: Fri,  8 May 2026 07:33:26 +0000
In-Reply-To: <20260508073355.3916746-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508073355.3916746-6-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 5/8] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
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

We will invoke BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVLOWAT_CB
to adjust sk->sk_rcvlowat when

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

Let's provide a kfunc to set sk->sk_rcvlowat.

Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.

The wakeup flag is determined based on bpf_sock_ops_kern.skb:

  * For the enqueue hook, skb is always non-NULL, and wakeup is
    set to false because

    * tcp_data_ready() is always called after the hooks in
       tcp_queue_rcv() and tcp_ofo_queue().

    * when tcp_fastopen_add_skb() is called for TFO SYN,
       the socket is not yet accept()ed, and when called
       for TFO SYN+ACK, the socket is woken up by
       sk->sk_state_change() anyway.

  * For the recvmsg() hook, skb is always NULL, and wakeup is set
    to true because tcp_data_ready() is not called in the path.

An alternative would be to support bpf_setsockopt() by adding
BPF_SOCK_OPS_RCVLOWAT_CB to is_locked_tcp_sock_ops().

However, that approach involves excessive conditionals and an
unnecessary memcpy(), costs we do not want to pay for every skb
in the TCP fast path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 94d07a15b2ab..9c4cd27c6d4e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12346,6 +12346,22 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
+__bpf_kfunc int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern *skops,
+					      int rcvlowat)
+{
+#ifdef CONFIG_INET
+	if (skops->op != BPF_SOCK_OPS_RCVLOWAT_CB)
+		return -EOPNOTSUPP;
+
+	if (rcvlowat < 0)
+		rcvlowat = INT_MAX;
+
+	return __tcp_set_rcvlowat(skops->sk, rcvlowat, !skops->skb);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
 __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 					      u64 flags)
 {
@@ -12497,6 +12513,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
+BTF_ID_FLAGS(func, bpf_sock_ops_tcp_set_rcvlowat)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
-- 
2.54.0.563.g4f69b47b94-goog

