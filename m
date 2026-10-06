Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3D4AA02B
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314789; cv=none; b=itaY65fKa5XjxqoLbKfu60CoUW+dGv7/HmmTJOwW1iooxcDfoc911mZP7s+ZdXqmfok3YXGB7UVFsd6CttlT5e35BCj1r6mDMO8lPXPQ+3l/fC/v34tvRZGoGqCSPzrw57LmxfZKgO6LUwxurFS//p+Qci5QjYBXbesrLyQ9RP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314789; c=relaxed/simple;
	bh=+KbLmsJgbCpsRE2TpVJS149pVOWFQIlDi8Ye9ATEYVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fa6asp/SkhN9V6UMkB4W4SMo4xuKBKXcm8eJ25VLo8lecbtdGrpaTBPLcALHxtoJ6s76YC7ejPeFoafA7Q2ER5FHyVnS2cm2fkdzMa6NHNBdaqg5qI0UrXbuMxD/V3HAh0Q66EUUoFsAiPjtTrtm+rYTBKpwi7pOPvz8ZbyN610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYI75SFg; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYI75SFg"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so3531305a12.2
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791314788; x=1791919588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LBgRk2qc0jw9FV7CDv8XbUFpGaTrixA96Y4TcCIuQbA=;
        b=aYI75SFgR4u/zWdCA2gW3hI2isInFa5I/XZXB8XNvDYrxbUEg6WpyYd8YDUD9V6/Y6
         ALPhTqjhtv5drXDZqCBp3LutE6BlLqsKLX31Zb4BENT4ModhNwo0EOcJ671m+eav5s+m
         xQMdfeqzt2maBl6proS2aDt7N7uQWi4p0l2H1404KBc/Kcux2s42nEUkJR6ty1IjVPYZ
         NrdzHnMMHxP9m6rxDu/jYxP1Mxja0F6v2YMNYNV3nFwZu1pHGQuowWfO6ynteejWnonA
         U0Gr9PjBFIUMwljJl5dYP4N4Lr11niYGtQp5HjNmGskYckny7Nk+huuM3zMekfpaqYoE
         vJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314788; x=1791919588;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LBgRk2qc0jw9FV7CDv8XbUFpGaTrixA96Y4TcCIuQbA=;
        b=ukvUz7K89YHt9PevRHryupzVDUb6HcD/UGqOrcnOG5s6bjdp9/2Gf3kUO3s/UqNLPb
         ZGAFChE26pGhUGECPd/ThdggE1JYzfajVh/we6oaWAGmbJH6ECQQ75sefwxeg73ZE9br
         Ks7+71GdQWpXQaTOHGj5lqSReyzRPziG6PxDp/lUqOd0uHuj1TSdqsOwr1yef+uCut8S
         CQJ20/QVZYV4ciKjtIbzwAg1qkr7HZiPDfEkyTM4zr4uoqSCwGxdHPLnGc6fZKPGmRvH
         pqJq0DzLDoQvJ0qK0bBQTKyco8kFi4tELfOlBFE3yvs60I+wbcz0Ku33bGnAfT9AZZnr
         s1zw==
X-Forwarded-Encrypted: i=1; AKwUvBz6vNaG5FoYgFTPa6VInP9RaiCvqukkj2rMTxS5QHXWj0S0y5mK2BhL/78arCZaXRfyJWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYILmpAr+v3nQ1IVhJ8AHzgx5cawS5qaS8p/ielJ2rHlnxcMmUKC
	8MYyD31FyCSWF1eznJCdWppbZcg+S1y5IFzUuk4N5mE4LKaH3lIS/YQMZ/y6y+e0+YGfdNnI4mB
	3YpWqew==
X-Received: from plcn4.prod.google.com ([2002:a17:902:d2c4:b0:2df:8129:75b6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:ac7:b0:2e2:e6f1:5e10
 with SMTP id d9443c01a7336-2e5ffaf0558mr3130455ad.4.1791314787378; Tue, 06
 Oct 2026 12:26:27 -0700 (PDT)
Date: Tue,  6 Oct 2026 19:24:35 +0000
In-Reply-To: <20261006192601.1875100-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261006192601.1875100-10-kuniyu@google.com>
Subject: [PATCH v4 bpf-next 09/10] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

bpf_tcp_ops.{enqueue,dequeue}_rcvq() were added to parse skb and
adjust sk->sk_rcvlowat dynamically to suppress unnecessary wakeups.

Let's add a new kfunc to set sk->sk_rcvlowat.

Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.

For enqueue_rcvq(), wakeup is set to false because:

  * tcp_data_ready() is always called after the hooks in
    tcp_queue_rcv() and tcp_ofo_queue().

  * when tcp_fastopen_add_skb() is called for TFO SYN, the socket is
    not yet accept()ed, and when called for TFO SYN+ACK, the socket
    is woken up by sk->sk_state_change() anyway.

For dequeue_rcvq(), wakeup is set to true because tcp_data_ready()
is not called in that path.

An alternative would be to support bpf_setsockopt() for these
hooks.

However, that approach involves excessive conditionals and an
unnecessary memcpy(), costs we do not want to pay for every skb
in the TCP fast path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Tested-by: Cl=C3=A9ment L=C3=A9ger <cleger@meta.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 net/ipv4/bpf_tcp_ops.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 8182037c4269..2ba73dd6c52c 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -361,12 +361,31 @@ __bpf_kfunc int bpf_tcp_ops_set_flags(struct tcp_sock=
 *tp, u32 enable, u32 disab
 	return 0;
 }
=20
+__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
+					 const struct bpf_prog_aux *aux)
+{
+	u32 moff =3D aux->attach_st_ops_member_off;
+	bool wakeup =3D false;
+
+	if (moff =3D=3D offsetof(struct bpf_tcp_ops, dequeue_rcvq))
+		wakeup =3D true;
+
+	if (rcvlowat < 0)
+		rcvlowat =3D INT_MAX;
+
+	return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);
+}
+
 __bpf_kfunc_end_defs();
=20
 BTF_KFUNCS_START(bpf_tcp_ops_set_flags_kfunc_set)
 BTF_ID_FLAGS(func, bpf_tcp_ops_set_flags)
 BTF_KFUNCS_END(bpf_tcp_ops_set_flags_kfunc_set)
=20
+BTF_KFUNCS_START(bpf_tcp_ops_set_rcvlowat_kfunc_set)
+BTF_ID_FLAGS(func, bpf_tcp_ops_set_rcvlowat, KF_IMPLICIT_ARGS)
+BTF_KFUNCS_END(bpf_tcp_ops_set_rcvlowat_kfunc_set)
+
 static int bpf_tcp_ops_set_flags_kfunc_filter(const struct bpf_prog *prog,
 					      u32 kfunc_id)
 {
@@ -390,6 +409,31 @@ static const struct btf_kfunc_id_set bpf_tcp_ops_set_f=
lags_kfunc_id_set =3D {
 	.filter =3D bpf_tcp_ops_set_flags_kfunc_filter,
 };
=20
+static int bpf_tcp_ops_set_rcvlowat_kfunc_filter(const struct bpf_prog *pr=
og,
+						 u32 kfunc_id)
+{
+	u32 moff;
+
+	if (!btf_id_set8_contains(&bpf_tcp_ops_set_rcvlowat_kfunc_set, kfunc_id))
+		return 0;
+
+	if (prog->aux->st_ops !=3D &bpf_tcp_ops)
+		return -EACCES;
+
+	moff =3D prog->aux->attach_st_ops_member_off;
+	if (moff !=3D offsetof(struct bpf_tcp_ops, enqueue_rcvq) &&
+	    moff !=3D offsetof(struct bpf_tcp_ops, dequeue_rcvq))
+		return -EACCES;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_tcp_ops_set_rcvlowat_kfunc_id_set=
 =3D {
+	.owner =3D THIS_MODULE,
+	.set =3D &bpf_tcp_ops_set_rcvlowat_kfunc_set,
+	.filter =3D bpf_tcp_ops_set_rcvlowat_kfunc_filter,
+};
+
 static int __init __bpf_tcp_ops_init(void)
 {
 	int ret;
@@ -399,6 +443,8 @@ static int __init __bpf_tcp_ops_init(void)
 	/* BPF_PROG_TYPE_CGROUP_{SOCKOPT,SKB} share BTF_KFUNC_HOOK_CGROUP. */
 	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
 					       &bpf_tcp_ops_set_flags_kfunc_id_set);
+	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					       &bpf_tcp_ops_set_rcvlowat_kfunc_id_set);
 	ret =3D ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
=20
 	return ret;
--=20
2.56.0.360.g66cac248cb-goog

