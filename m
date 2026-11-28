Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795825874;
	b=STrAdP4VZz/Tme1svBw67NW1YG6HOTNkRPRNJbcjT6NM8V4FYb+np7KaKynPz3VsLx6Y
	 6ZLNKNmg4csalWjUz8ekZKdGRuaG8h9m2T/ZsLaVpebdHjhiSQkPOzasutDAYJSOWsE6O
	 v5VaefTDDs01Ft30x5zokUjQduse1JkFtjlIWiGNnJ+qJbS+VU1vemNfuRra0MAjLsYdP
	 keDKBBytHPDezeeZauCyJneqvqb3RjGfB+pt8jjL1k2Y61uGKx9Fwj/B9BcH7eUuV0bUu
	 QdTf3EAgH2uhgktFk+kgtBtrylKrUST5KOyQXin3zMvKZ0EM2UyusEZoTCOcLmEfHjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795825874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=81YL22Y23CJWcBybUvGyAQqGzodpMZQhGel6a2MiDuI=;
	b=YR3GwmwgBObCKuDGt2YJrjEvm0teaNYbfKjF5Gvxv6SAGhKz8A+jQzrvUgWa0XyU1Wpr
	 lrBSGiSLY4MaRJGvdwqiGOwPxTAlQZnBgYtbwcvwQrwQYr5uY7ExIheWtO7leP8fLXN74
	 KzbVNy0e9o5YV+V01TGusIFHxX17vSOtny3f49mIJ0lsEx4cWz6GVdA2Pu35RKBJKQwe2
	 TkOmSpKeO3BnnIA8juTreS+xgsBdR49LnFtWbzE0QHMi9cM4hhhZZa/5kGAMUXfNrBTld
	 CeKhwtVig7IuCcf87JztNnSAp3zwdsEyR/iH+j111XYGjesnpp5Hz46RlN9UHAiK4Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aNjW0tJ0;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017DC606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 00:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 017DC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aNjW0tJ0
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a594d313a3so5622231b3a.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 16:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795825873; x=1796430673; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81YL22Y23CJWcBybUvGyAQqGzodpMZQhGel6a2MiDuI=;
        b=aNjW0tJ0BAuRPl+EDlmMczZaANVoX0nyry2zcMGDgCGYm7z7g92SLNdPlJLn6XlJIz
         XY6fVJfkv8jEc5LSLjoc3Kx8ZPrXhUxw+BD4gMM7VRtafZTPjymVsRmWZQmckQsvdknI
         h0DUZtRb9CjaUFtyl2TPmMJ0tAhGAgE4cec8Z+RhE38qxIwjC9bKX3Ezu8XOBKqm/G2O
         C87iegPJzCJT+vSaqFdlGdfUmHZmtyqhLuWjVIOQ9fzIPFZ9NUUqVEyKlbh3LnLu2uLg
         5OhPtVpS9GAqKr5WdZXTIxbjUCpkAfFo0wG9WnmfQYEGim6Lcv9ncbCKobH5CPZtbKVj
         HEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795825873; x=1796430673;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81YL22Y23CJWcBybUvGyAQqGzodpMZQhGel6a2MiDuI=;
        b=sZ4tGGsajyUI9sFFaw3NJqs50Pfd0ZTWDf0AZrLzSZ01Qqrwv7yXNeEhLH+Mfu701m
         Wjt3XhFNKqvhlOJ37q3K3QXwLk7XnTE3eYflha2IDzro9cYd5dAot851zb25vE5ZaLyJ
         /MvCxXbi4TwiDLptutpG1qNKusyXbYu7YGRv0tYiyR8Pc2JH8ZhIqvl6PYXG4n2Bvi6d
         cqeXPIPQ+rA+pedsIdB+J8dHhByho5zKrjjR8+uzqS2CD1KtkK2qI+fwPFJtHhAXUYvy
         SXm05fXxqe/FA2k2io4jjr2fSMrBOhbueH3xYEvmV/6aU2UmHpZrZcKUT9Gidgj2Ajvc
         hkXQ==
X-Gm-Message-State: APuU4Z8EhJt9O8q+6rvkYOxpnkVjzekYns7lvkFuGN+HY18jbQFgFNOz
	G+ER8dbHedbq9WHfY++4t6RYObE81MQsMxC3MIpd2iU6VX3mPBOg86QV
X-Gm-Gg: AZFdTZc3IqE+6dhonD5yADgetFWfbMegHt941DLKZDSPedGouNpOx5dQWofF9Tx9C44
	bmQvvLBUvmNnqdFLG46TzcWmrVXmzpQE3DpIHann30Fq5WZlALyl1BtZjistyVvY/xNmheEyKXC
	kAyaUNHJLOARz7nMVa8EUDkjXOBQJ/gr8cy8FqQrj2yn2wc7TX2dDAl4VpJDEvoOFZqYG3yl0e7
	dHtyH0BHmYJ9dj9wImgApDlFl1/gA+m+nr+3x/abzg258gLqEBfwh6rGEZ7r+NBiHvsSV4cPHnO
	Ssr0856MpzIbyyQajvjFO1eYW2aEPOdaMufQh73a5Mfu4UaYhGYBNYesrn1X+0XPa7JmABVmccy
	q5HGqSz7zQeSLM7YXm/cEUg6PFnZ5K4l587mN63EWsqnOQSDv6mGtfdLH2kBzX/UuJ9IqmrH1Ta
	bbStgZArVrkjNqdlxQrmTJXCaNl42iEZeGuL2LaKt9ULTlgslr7zEKAsjWE8867b0/EWVPaWYer
	abcl9gfCtShafwLTipSnwHgfO/bfjIsdMkGkdbv6uJ3ru/d+rfhKqPhON7AiqA2e5+OXyUJ6roh
	uBpwJTiQrkvEdOogEr9PbO10eRwwKZuLbFXC644mh5sHcye/d2ozM5ApXHraA9rXDK+BRfFcadJ
	vhhlx3BTrm18Vm1WcSKuVCk8AN9+exzYwhg==
X-Received: by 2002:a05:6a00:2d0b:b0:881:4b47:f305 with SMTP id d2e1a72fcca58-8c8794b9136mr25471832b3a.5.1795825872876;
        Fri, 27 Nov 2026 16:31:12 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c228sm13235924b3a.10.2026.11.27.16.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 16:31:12 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 00:31:11 +0000
Message-Id: <DN6F54C8AZSE.3QLYZS0114Q5L@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf, lsm: fix bpf_setsockopt() on a half set
 up child in inet_csk_clone
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Stanislav Fomichev" <sdf.kernel@gmail.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>
Cc: <bpf@vger.kernel.org>, <kpsingh@kernel.org>, <matt@bobrowski.net>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Xu Kuohai" <xukuohai@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
In-Reply-To: <awcUm4PvuYb3nGxM@devvm16445.scu0.facebook.com>
References: <20261125070330.16625-1-jiayuan.chen@linux.dev> <awcUm4PvuYb3nGxM@devvm16445.scu0.facebook.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 09:04 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> On 11/25, Jiayuan Chen wrote:
>>  2. Make these options work. This needs the child set up before the
>>     hook, too much for a fix.
>
> What is too much? Moving security_inet_csk_clone to happen at the end of
> tcp_create_openreq_child? Or is it more involved?

Here is what my bot thinks about moving the hook.

That spot fixes the timers only.
The callers set up the rest:

  call chain                                 option works after it
  -----------------------------------------  ----------------------------
  subflow_syn_recv_sock()
    tcp_v6_syn_recv_sock()
      tcp_create_openreq_child()
        inet_csk_clone_lock()                <- the hook is here today
        tcp_init_xmit_timers()               SO_KEEPALIVE, TCP_KEEPIDLE
      newinet->pinet6 = tcp_inet6_sk(newsk)
      memcpy(newnp, np)                      IPV6_TCLASS
      tcp_ca_openreq_child()                 TCP_CONGESTION
      __inet_inherit_port()
      inet_ehash_nolisten()
    ctx->conn = mptcp_sk_clone_init()        SO_SNDBUF, TCP_NOTSENT_LOWAT

There are two callers, v4 and v6. Let's call the hook right before
__inet_inherit_port() in both. Then there is no need for
bpf_sk_clone_setsockopt() and bpf_lsm_clone_sockopt_hooks.
SELinux and Smack shouldn't care. They copy labels from req.
The v4 route lookup in between takes secid from req too.

mptcp sets ctx->conn after inet_ehash_nolisten(). That's too late for
the hook. subflow_write_space() needs a NULL check instead.
bpf CC hits the same NULL and the patch doesn't cover it:

  tcp_ca_openreq_child()
    tcp_set_ca_state(sk, TCP_CA_Open)
      set_state prog: bpf_setsockopt(sk, SOL_SOCKET, SO_SNDBUF)
        subflow_write_space(sk)
          mptcp_write_space(NULL)

With the move SO_MARK and IP_TOS drop the cached dst of the child.
tcp_init_transfer() looks it up again.
Backports need more. dccp and chtls need their own call.
IPV6=m needs an export.

This replaces patch 1 and goes on top of bpf/master 14f6b10422d6.

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 9a3b05e..759f826 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1276,8 +1276,6 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 
 	inet_clone_ulp(req, newsk, priority);
 
-	security_inet_csk_clone(newsk, req);
-
 	return newsk;
 }
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2fc92a7..d03b50b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1761,6 +1761,9 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 		goto put_and_exit; /* OOM, release back memory */
 #endif
 
+	/* The child is set up, but is not in bhash and ehash yet. */
+	security_inet_csk_clone(newsk, req);
+
 	if (__inet_inherit_port(sk, newsk) < 0)
 		goto put_and_exit;
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 5c7ed38..d704d98 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1516,6 +1516,9 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 		goto put_and_exit; /* OOM */
 #endif
 
+	/* The child is set up, but is not in bhash and ehash yet. */
+	security_inet_csk_clone(newsk, req);
+
 	if (__inet_inherit_port(sk, newsk) < 0)
 		goto put_and_exit;
 	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 00677fb..a0fd3ce 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1602,6 +1602,10 @@ static void subflow_write_space(struct sock *ssk)
 {
 	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
 
+	/* bpf_setsockopt() on a passive subflow that has no msk yet */
+	if (!sk)
+		return;
+
 	mptcp_propagate_sndbuf(sk, ssk);
 	mptcp_write_space(sk);
 }
