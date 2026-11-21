Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795259475;
	b=h+xUjQlm6ByUyw1jQ4J3aLWHScetUtDsH5i1Ptuk/ZFFvjgkyEtcU7L4+usL7MZYrwcf
	 gpSLCzDssUaKuOh+2pCyTBFmjx42U+T5K4QfTyCAg+PsggIBsVtZICK3X0hVzYjxy5PJT
	 zuWaPKMABg5cYwInZF54ieZcap/W2gKBTyt/Q/xznrwXpZGvACrHAYvPeKdMizpVWBmw/
	 VK8HCAx+bZZs0tYXbx017mZMNM8SKmqTSegItsvuQgB4lzlg0UxkgtFiTmV9LKPoae9ob
	 0OFWTIMfx56AF+KgQ9OrP3urH9mr4vENXZNiJP5dJqrYBoYkvtFZvq7QYfgExVjgg2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795259475;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=pc3/8eaz2R7en0wB3IVJjUSju2aIpRoh8x5NratlNNQ=;
	b=ivgBx978G15BT/2XDBPx1mUgjFinUVRbZ9jEDbc74LQku9zYaNiRlzUNqi3qVrUEiKPv
	 PfIE2xgu485jMx00wPKG4LTzgawQlVWbpgxZq29RKlX5OJKFiFzJSUDffJhmSJ6AU1PkI
	 1z8zkboIRtL7jgdr6hKxc8u4e9eZuy7qr43qC20uouI43v4IizDpRp3fEuWnb+TnnLXYn
	 0CIFT7vVB33st/eZ25sxEeJoIizsAsJzUmej0dnC3oeUrntYy1sO3OuwF7KxjAM/td9Up
	 H84a8CkRNienIbS/g5LGjEBWlKsPjkfXP8dEJWJUOl4JzJjpP1kmw562DxSFUd8F+Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRyesDRR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB60606A32C;
	Sat, 21 Nov 2026 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRyesDRR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71D01F000C0;
	Sat, 21 Nov 2026 11:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795259475;
	bh=pc3/8eaz2R7en0wB3IVJjUSju2aIpRoh8x5NratlNNQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eRyesDRRrnGA4qkWPsWNmEDPNX5cBFgK5rTNvgPH6WFIOjDoJZkAZrjzjyaKM0Srx
	 x2vUqChiO26jFcj8M6OJ36RuMsuXigPD0i6Sak/zkqhH+nI/gbHHsrCU+mDqMyNnnS
	 nR2TOxKuV+kkV5qcjOoPlvf2GgRpQggIJlH6Mi8sqoIUj5TeRxoBcjr7zCgUO85Z7L
	 axTWJG1XCiGpQNI9yu1Qf21umDXXMARk4d3LudGhP4knmkZoKvXOJS5VCKN0gxpPYM
	 mg5JLjdFzQSomX2c8UWAuyl3CjRBpyuuMvZnBp77LdDCCtSmwe2YtiuNT5NDqMdCvJ
	 LhMJt96dx5zGQ==
Content-Type: multipart/mixed; boundary="===============1453606125876828301=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <10c5af49a70a8f40bbcf3afaddefa15089060a8d1d1aac01d5810c5b088adc47@mail.kernel.org>
In-Reply-To: <20261121103222.88209-10-jiayuan.chen@linux.dev>
References: <20261121103222.88209-10-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf 09/11] bpf, sockmap: Fix apply_bytes when a redirect sends only a part
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org,ast@kernel.org
Cc: jiayuan.chen@linux.dev,john.fastabend@gmail.com,jakub@cloudflare.com,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,kuniyu@google.com,willemb@google.com,ncardwell@google.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,rhkrqnwk98@gmail.com,mattia.meleleo@coralogix.com,mhal@rbox.co,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 21 Nov 2026 11:11:11 +0000 (UTC)

--===============1453606125876828301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, sockmap: Fix apply_bytes when a redirect sends only a part

TL;DR: The apply_bytes give-back in tcp_bpf_send_verdict() may leave a source
socket permanently failing sendmsg() with -EPIPE after its redirect target
closes, since the restored redirect verdict is never cleared.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

> @@ -566,6 +563,21 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  			msg = NULL;
>  			ret = 0;
>  		}
> +		/*
> +		 * Bytes that were not sent and come back, in msg or in the
> +		 * next sendmsg(), are still covered by the verdict.
> +		 */
> +		if (apply && sent < tosend && !cork) {
> +			psock->apply_bytes += tosend - sent;
> +			if (eval == __SK_REDIRECT) {
> +				psock->eval = eval;
> +				psock->sk_redir = sk_redir;
> +				eval = __SK_NONE;
> +			}
> +		}
> +		if (eval == __SK_REDIRECT)
> +			sock_put(sk_redir);
> +		sock_put(sk_redir);
>  		break;

Can this give-back leave the source socket unable to send after the redirect
target goes away?

The give-back runs for every short redirect, whatever the error.  Some
errors from tcp_bpf_sendmsg_redir() are permanent and send nothing
(sent == 0):

    if (!READ_ONCE(sk->sk_socket))
        return sock_flag(sk, SOCK_DEAD) ? -EPIPE : -EINVAL;
    psock = sk_psock_get(sk);
    if (unlikely(!psock))
        return -EPIPE;

They happen when the target was closed (__tcp_close() -> sock_orphan()) or
removed from the sockmap.  The same goes for an egress target whose
connection was reset, where tcp_sendmsg_locked() returns -EPIPE.

In those cases sk_msg_apply_bytes(psock, tosend) takes off tosend bytes and
the new code adds tosend - 0 back, so psock->apply_bytes ends up at its old
value.  When apply_bytes had reached 0, the code also puts back
psock->eval = __SK_REDIRECT and psock->sk_redir = <dead target>.

Nothing else clears that state.  The only writers of psock->eval,
apply_bytes and sk_redir are this function, sk_psock_msg_verdict() (which
runs only when psock->eval == __SK_NONE), the cork_bytes reset in
tcp_bpf_sendmsg(), and sk_psock_destroy().  So every later sendmsg() on the
source socket follows the same path:

    tcp_bpf_sendmsg() -> tcp_bpf_send_verdict()
      psock->eval == __SK_REDIRECT, prog not run
      tcp_bpf_sendmsg_redir(dead target) -> -EPIPE, sent = 0
      apply_bytes restored, verdict restored
    -> sk_stream_error() -> -EPIPE (plus SIGPIPE unless MSG_NOSIGNAL)

The source socket's own connection is healthy, but it can no longer send
while it is in the sockmap.  The sk_msg program never runs again, so it
cannot pick a new target or drop.  The dead target's struct sock also stays
pinned by psock->sk_redir until the psock is destroyed.

Before this patch the verdict always used up tosend bytes, even on failure.
A redirect to a dead target failed at most about apply_bytes / tosend times.
Then psock->eval went back to __SK_NONE, the prog ran again, and with the
closed target gone from the map the lookup failed and the prog returned
SK_DROP (or chose another target).

The give-back is right for short sends the user is expected to retry
(-EAGAIN, -ENOMEM from bpf_tcp_ingress(), a partial ret == 0).  Should it be
skipped, or should the verdict be cleared, when the target cannot take data
any more (for example -EPIPE)?

No later commit in the series changes net/ipv4/tcp_bpf.c; the rest of the
series only adds selftests.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44896626218
--===============1453606125876828301==--
