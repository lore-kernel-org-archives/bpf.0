Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045D476047
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789934202; cv=none; b=IhEzIma8FqIHYIACkJrKeQ8oWuP4ipxehSJOZuwrcE5SwjgrW01uGu63Av5uhs/4RDrbypFfW7S0QtWMgDc7GIsDIVDk9aKw1O8USSqaOFMmXbEzY/MVNNPedBg/Qhqr260iHlxLEdIykewcJAXPZcZ+nStuhBJ/UhAbDIiU4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789934202; c=relaxed/simple;
	bh=iK3m91mM+CrJ0czvOdotfSvYLWMqWyzLW2F7/AzZ5iw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HUoA8UFYsBBIAyJ/ZNt4nfMazVrj35GwxhAB7epbbeoGZ2vNQLoRbQo7WKGdvF+Cx9kqrH9KbJJhAgMt/N+XVya3JkP9lMKp1qUA74iemzG8hsg5dKfhU+Yc2dLx/WhHPC/65zl17zEXV5VLjmSqPNJVNyvxeL3iU59C2S0cQkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2fO1RhG; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2fO1RhG"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso2052137a12.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 12:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789934200; x=1790539000; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IHpOOnwxbruAeL/LrqWPDSIV027ekWzloCJ8rbcfmIA=;
        b=E2fO1RhG06xWAsXqwaOGtO5C4DWptXN42EnT8mCA3Uy9XuRaimAtWPN7tWPXoiVIXP
         rpUBDJlblj1gkkrPKVL0k7o7GlpV/NcHciPWL0VVL3olLvD0ULpY9P7D01NfV+HOr44D
         JwKS5hZAXYuPs3ogt/k2FQvl6wx93xow7zNdSdVqV41ei5uLP6R6WIdih9fZj8vyLWfg
         KuY3EVLAzq0sDpD0KnXqLA1oQq+thoXuLSZ0lokikBJDojZQzWAVsIMBuAfFaTE6kLdW
         Bza5Nch+s9yaarN6swqlDKB0tG3hsXJjAYaQdHFAq3pGZEOz6qAaPqtftWz78tKq5Wqm
         gVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789934200; x=1790539000;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IHpOOnwxbruAeL/LrqWPDSIV027ekWzloCJ8rbcfmIA=;
        b=gRfkCjG/EMO2dmVYhOxn7wKh5UksXkpvzfjzvElQDiWWR+aaWIFT+VhkzDtrAHqIdb
         Pw2fHBnhf/LK78NKWx6YSOiEvLCWSH3qXv2oWp5Fv/1S6zDQNR0Olh+YhcFWYe2bT2AJ
         QZp2afEKjC2FdLZjOB5Eyim7ru9I8rY89as1GAzOoig+kBJTEaNgyc8PskH6SdqfnZGc
         dSp1ZpZG0z3WWppt+/e4CrJpYLXiAc4tCoWpHNg6TJ0V7fcwNaKmH8akpoh9KkyK21cZ
         KKNo8HR4f98IuXJszE6Hd2p9fKL+JAhhDsV1lqE4S8boNCOgZFkqQI7g9E87+0jHip35
         TvgA==
X-Forwarded-Encrypted: i=1; AKwUvBwW8EzYfO4YKbhRmoziLrq/asuhE11eG30m4xWwGACqzVKHnTGfhF53V02JBFV1iW5nnpk=@vger.kernel.org
X-Gm-Message-State: AFuF++ksCsum+RiE8NImnfSVPkKeGBQ4bBGvolGilCeSdxp+yX/ljT1Z
	SqxrxQlMKBK2SgC39fFBAdRe534vzVexspl3qy7e2xrtonKOhuFFHO1PwyJIRFv6geip/h78F3q
	AZv44uw==
X-Received: from pgte19.prod.google.com ([2002:a65:6893:0:b0:cc5:fb4:a5d3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:939e:b0:3db:3d0b:31fd
 with SMTP id adf61e73a8af0-3dd8c3d214cmr18305254637.1.1789934200170; Sun, 20
 Sep 2026 12:56:40 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:56:15 +0000
In-Reply-To: <20260920195633.3033620-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260920195633.3033620-7-kuniyu@google.com>
Subject: [PATCH bpf-next 6/7] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
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
---
 net/ipv4/bpf_tcp_ops.c | 56 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index b0e14b54917e..3768b1440eb7 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -359,8 +359,62 @@ static struct bpf_struct_ops bpf_tcp_ops = {
 	.owner = THIS_MODULE,
 };
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
+					 const struct bpf_prog_aux *aux)
+{
+	u32 moff = aux->attach_st_ops_member_off;
+	bool wakeup = false;
+
+	if (moff == offsetof(struct bpf_tcp_ops, dequeue_rcvq))
+		wakeup = true;
+
+	if (rcvlowat < 0)
+		rcvlowat = INT_MAX;
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
+	if (prog->aux->st_ops != &bpf_tcp_ops)
+		return -EACCES;
+
+	moff = prog->aux->attach_st_ops_member_off;
+	if (moff != offsetof(struct bpf_tcp_ops, enqueue_rcvq) &&
+	    moff != offsetof(struct bpf_tcp_ops, dequeue_rcvq))
+		return -EACCES;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_tcp_ops_rcvlowat_kfunc_id_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_tcp_ops_rcvlowat_kfunc_set,
+	.filter = bpf_tcp_ops_rcvlowat_kfunc_filter,
+};
+
 static int __init __bpf_tcp_ops_init(void)
 {
-	return register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_tcp_ops_rcvlowat_kfunc_id_set);
+	ret = ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
+
+	return ret;
 }
 late_initcall(__bpf_tcp_ops_init);
-- 
2.55.0.1082.g2b9226bbc0-goog

