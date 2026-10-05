Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E74CB8DD
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215151; cv=none; b=uUcPxzp1XdpBGt+7xe5HrCdMoMtcyyGF27X+Mryvqu09gaiu4C8QVCwejNAJpa+u707pRBtIo6ADjHMbCmEQjf7rq0egyRZZdEisvR6gPG+8jKwYotidtrH7u6cRVZk4H2q7oRHVYFyw17Gf7vnyQwfvEbgwnw7PYd0p4mHNtuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215151; c=relaxed/simple;
	bh=nSp/9D9YlfgyOKVoCarZZIrPesUWqwl3EAdvaGNVvlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PGN17utKM6V35GAsNJHZ2pS96Q1FV06BwXQ9K5cMNk/HxPgmRzPGdri5O2Qp7hj35Jnk7rRD74Bv86Ii4iCtgDEpzNW8remDOG1oUG7OizQnpVXZtjUU7FKsboVKxdKyMAdvJRFeU3DDr5w/FptVtXK4Tswy7CeCczP536xiLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fw2dhNPO; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fw2dhNPO"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a6d95d6e08so1516172a91.1
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215146; x=1791819946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TaQOKkiCYJHksF52rDmbmVHar6ztN/SCPJVTP91woAM=;
        b=Fw2dhNPO4dJhnklknAD1pi0QPVoMiPyG9oKOPvt+2gQI59DMOzSj5jaAMZDsaSbW8g
         mUL3fCdP+9oPzAdcuOJZf4XzVU0gNAgl5UPU1B0aJpLinRDoRefVTI+ixLjnArJXiIIk
         q4ANC07W2vD/+ElgfFApKEGqHvtDPf7QU1tiU2ZJGBBofM1xBwTkSoeJykqN655e4j2E
         5xzQoL5QICMG9jBLV067fJra0DZlxz3JlRQ0sn5wp0uk2RlTqLGyzUDgpwBTyvkwC+v3
         DqDQLUNR6w8yp0iFksYzfrS/yyxuxZFU1wzQIF1v4QxvfbYdYUxvOMZz089Topm3w7R/
         42HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215146; x=1791819946;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TaQOKkiCYJHksF52rDmbmVHar6ztN/SCPJVTP91woAM=;
        b=IAp+lzVy96ULvE3jTX+fT4Lmwn5gYUKo0GjoDDrUuIc8AppGXjZu3dJsyG29wXf2kE
         7uew4kuSDQYQACI5qwIU3VWSmfveosbicDVTgYiZ4OA16KXH3LqmqUm3WBFifPlSEka8
         Zx+vhZjTKP8eiwV/M9IQ46+hqiG6lCkUqNvdMaRhUwMGzUS8vVN5+2zy9arHkevZakqS
         uQjSKDCLH80C6gFZgOVbBCuYmFCQQbklO1DXvxfh32to4djb9hb8ImvEEoLckZv1SskX
         OjaFL3kO1w7NYnH3qWNP6ub+D4KCEHCVQlPAEFKi+yqeI28YEHqOr9a7FW+AeCm/2qtQ
         KdrQ==
X-Forwarded-Encrypted: i=1; AKwUvByBwKbudCRUPSSuPlHMRfDgMRbTjGpztr43P9ESdlUyVurMXisug9CIbkvjSxA15RNf7uI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjSIJA0ftU1LRdig0VNriESJ34J1cNgAQKVqN/FUCAxPdYZueM
	MVwXejE8F1NBh6KVRA0FGAa4+wgXq/91JLST1kzNj22R3ZPbL55+tvPvrccdTS0+bN26kBwJgX3
	pjtklFQ==
X-Received: from pjblt20.prod.google.com ([2002:a17:90b:3554:b0:3a5:d81:11dc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b46:b0:3a7:250:333e
 with SMTP id 98e67ed59e1d1-3a7025038dfmr6586332a91.11.1791215145770; Mon, 05
 Oct 2026 08:45:45 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:40:50 +0000
In-Reply-To: <20261005154533.4147685-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005154533.4147685-9-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 8/9] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
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
index c73d3478a8d5..4e4846121ce7 100644
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
@@ -386,6 +405,31 @@ static const struct btf_kfunc_id_set bpf_tcp_ops_set_f=
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
@@ -394,6 +438,8 @@ static int __init __bpf_tcp_ops_init(void)
 					&bpf_tcp_ops_set_flags_kfunc_id_set);
 	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
 					       &bpf_tcp_ops_set_flags_kfunc_id_set);
+	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					       &bpf_tcp_ops_set_rcvlowat_kfunc_id_set);
 	ret =3D ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
=20
 	return ret;
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

