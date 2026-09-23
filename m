Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114E9475347
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199451; cv=none; b=DxbQ9p6bXs+4Dz3uzZqnVcRrbQInsk3s25XQmcywjknVapOZlo8N/Ux8Lu3MUS6rtWBP9qQ4kgdwc4LQ0xSKT3u4r9ADUME4XaxUYJMY8MvPNQjAWgnB/BIQQb/iHPuSz4wCClGCQ3wjyxLug1lPgGGServM40YgZgLlDWnsojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199451; c=relaxed/simple;
	bh=mqoyradyQoXLPKEgf9rYwqBejhn1SZTJygtYmiDczts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G7bDlc7gct5BwZNjtTF2f+XcNdTieelNFT93MSFxL0OE4PL2mVEwILtxaWsG4y/Ad4NEOhYqxtDCXnfgGRmNZMmqoZ77KkU1NMhIUC41QNRJ2U8/qJjWsUtpszA1BWhf4Z+NOWeBgj680/+LpCeoEpuNGLl2HAyBZzVctW1yOsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dr8v5yq0; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dr8v5yq0"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8645a62066dso1013369b3a.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790199448; x=1790804248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kpxAtPcXutsCICQhVJQwToJu2eQ0NjMEjIdcOItmsAw=;
        b=Dr8v5yq0CUip1Twy8JrcjvXZSDACWlvNUrxrBrJPA3Yq3zhIN+9nNmc3fJ9IXMWfen
         GbpnikyJOVl8K8Djy/wDbj98lGR54jHlUj2666uCR4s8nBkrZuKGiYNKlZnhQiUKC3QD
         Kp2l6Aat+YSKygBpcF9cXHIAv2jV6sti3JMyCyFpefrS/AvwSf/GjFN0jc5KNtSALK1M
         b9WHTlwhQPp1na9uFnk9opaOKUonSBpu9u0Fy8Tdk3NqyG1JzoAXtrgRKP+JLk8OLn4c
         MTVKpR3J9Yf4LCu/FFdBvSkec9gu+2b/19TB8LljTtUSBhGAwCgW59WjUUFxOmTkXdgS
         bJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199448; x=1790804248;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpxAtPcXutsCICQhVJQwToJu2eQ0NjMEjIdcOItmsAw=;
        b=y4X0I8S8qbuY2Idv3FSKuEkIRz0LcwTSGm4jngte+kQFk3CmgkfhYak8x3ZkAmwj20
         Vrv54QqwW8J0S9mBS0UzS4WbHOKmrJpS+ELD7iegEUQMQweOfY/+VJIr2Tx0f/dUZfeH
         zkkb2qE+5PneqvJ8qnV7cAv1+Di8HzaoBj36H8Qw2vJbuG49tXUzk5H7OByArBPGCtm2
         6F06PG57ZnVewXGDptnLhvQDlaTxlhe6LjDc/3UJujUhfY2Yq+xF2tgTmU2Vfo+ErqhP
         Mw/VoGxu8gvg1T32udyhIN02gk5t0VmRCVaSQzDobKVMJNI04csjcZNlytRa1YZRtEaE
         SXkQ==
X-Forwarded-Encrypted: i=1; AKwUvBw13lx/VUkMHaUGLzY7U7SVOQAsUyTBKZ1F7J2kgN5e5qetmfJaZxqPrdupCrN8MVUFMF0=@vger.kernel.org
X-Gm-Message-State: AFuF++lzIuK95hA6CLI/b0fBLgpu3LZBuPkcGSBgGcwynVUnzsKhmV7O
	zEK3SBNNeBXZR7ilMrr5kwkhvhRa8ykacsH7ULCE0iFpnFhJ02QtuuK3210cjEG6V18CN4mPH/3
	Dl0mWRg==
X-Received: from pfbgh13.prod.google.com ([2002:a05:6a00:638d:b0:87c:dd7e:8e68])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:728b:b0:3dd:a197:cf2b
 with SMTP id adf61e73a8af0-3de0e9422camr392703637.79.1790199447974; Wed, 23
 Sep 2026 14:37:27 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:35:37 +0000
In-Reply-To: <20260923213719.224838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260923213719.224838-8-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 7/8] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
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
---
 net/ipv4/bpf_tcp_ops.c | 56 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index b0cade34cce6..e93c8d13684e 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -368,8 +368,62 @@ static struct bpf_struct_ops bpf_tcp_ops =3D {
 	.owner =3D THIS_MODULE,
 };
=20
+__bpf_kfunc_start_defs();
+
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
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_tcp_ops_rcvlowat_kfunc_set)
+BTF_ID_FLAGS(func, bpf_tcp_ops_set_rcvlowat, KF_IMPLICIT_ARGS)
+BTF_KFUNCS_END(bpf_tcp_ops_rcvlowat_kfunc_set)
+
+static int bpf_tcp_ops_rcvlowat_kfunc_filter(const struct bpf_prog *prog,
+					     u32 kfunc_id)
+{
+	u32 moff;
+
+	if (!btf_id_set8_contains(&bpf_tcp_ops_rcvlowat_kfunc_set, kfunc_id))
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
+static const struct btf_kfunc_id_set bpf_tcp_ops_rcvlowat_kfunc_id_set =3D=
 {
+	.owner =3D THIS_MODULE,
+	.set =3D &bpf_tcp_ops_rcvlowat_kfunc_set,
+	.filter =3D bpf_tcp_ops_rcvlowat_kfunc_filter,
+};
+
 static int __init __bpf_tcp_ops_init(void)
 {
-	return register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
+	int ret;
+
+	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_tcp_ops_rcvlowat_kfunc_id_set);
+	ret =3D ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
+
+	return ret;
 }
 late_initcall(__bpf_tcp_ops_init);
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

