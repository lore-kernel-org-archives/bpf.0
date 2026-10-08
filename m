Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26F372B2B
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429377; cv=none; b=MAj2Ncy4ZkrsBKJMCbcEhdOs9a/oPxREcxe2settXdX2cudAENNdG0EMK6vuugVvgAURMyeJqVjpKPXiv8e6OBZE+53lMF70t2HmoLSF9UxgQlSs98rmQVCZUeSz26r9rjJqEspQ6utYABWGio2dYkuY/3TZlnUHyilZuWtkuhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429377; c=relaxed/simple;
	bh=h2WeFeeCDFVj+y4fbC2OCwfgh0BpW7xdiETLvZTef38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OSkJr0Ku4xBoDEjIW1otmyLkLDfxTV2mlF17VbvYUTI6Co3JjUNGgtmnDZ7zBoTrC6ZwOpyGu4tDtEj/Y73DLB66rGHF1PhF3suZaDlhQ0Y4h2t91UkEKIu7rKrORqfdHFH0pKHT1H8crSNBAu9ObR2McYTkumuFf8ekmS+tjhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gpvfv+7D; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gpvfv+7D"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8883dcc671eso3535656b3a.0
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 20:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429376; x=1792034176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BLNokIdOHDkBwAGf2/9c8ogz5rqrF0qPp9rU+W0rBS8=;
        b=Gpvfv+7DcehOiPf51lYvImu7K5bCehh6rG5gjr9AniVzuE1GasRXmiuv8TwkwHg5JF
         UPtDGaEduZlebEqD74Dbznogj4ViWyhf4Mb4MLpwIvs4os11rJcUYnqDoKWvPhvqc3Xk
         rLpXso1g40+xDegr7OwmYjV4hJRZEKD42t1HQqglEj8UGhhsS00nnTzBT2dO9xGCXxsU
         UYNiLtR6+V4OJVXOMFVo47GoyU2pyoNL0eBAbRIiq6mQB6iUFqsNwx2uWB1xM42yxOGn
         Z2xIHucCNM9VTNxl+Sq5AdtoRbFZQsqH/HxAfWHB17wOAZWWVqlledxJRCzPSegbn7sR
         MQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429376; x=1792034176;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLNokIdOHDkBwAGf2/9c8ogz5rqrF0qPp9rU+W0rBS8=;
        b=NrnM4dKUVCKVFEQQO5z0ZIt/8yFtxJl7xxb6kpB4LZH5PrPpIYse4qNaH7XQFbtsi0
         VYaN1vfNs6wVN2PE5wETYr+E+9GO3hkOmrLdkvVgqGK4cnjkw13yPDGgRL2deO2bZta1
         c2hVkkjSy1mJcRE9c75wX/NNx6dziLSfz4dvYILGIKYDrwvOpnMCBghy/Xi69NuiudAi
         mzmKn+YtS9MMtYC7kIGp9CxPgJacL4GFrE7aPSLvmTcjBJ3HNJpGH64we78sNPStAm76
         Kt+871ycyr/XZ5PW2Dah0oc4p7pCZYSCa60zFXSAfPF9VuJkdJY9nY3ZoIFei/a8evlm
         Rk1g==
X-Forwarded-Encrypted: i=1; AKwUvBx0wkbRaRdU28q3DW8Ima55KXQLsu9/sQ1tKM7+zizQqmlAAEzkKLig7TFbT7JJk0QYl3g=@vger.kernel.org
X-Gm-Message-State: AFuF++mzhiY8e5n4P4IeF4qdqldANFOW34bQ10vsPp76HF7cRKaTmfHL
	4U3LvoRyvrCEmGefaKhhKKIf8X3rhAEHzapSQrwFF6GeRXQ1Ug6ha5hJWVruNvN3iX6ZR/HmdbN
	+PWc43Q==
X-Received: from pgac24.prod.google.com ([2002:a05:6a02:2958:b0:cc7:9c4b:f6f6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4c85:b0:3dd:a197:735c
 with SMTP id adf61e73a8af0-3e13410bb96mr3270199637.53.1791429374089; Wed, 07
 Oct 2026 20:16:14 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:29 +0000
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-10-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 09/10] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
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
Reviewed-by: Amery Hung <ameryhung@gmail.com>
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

