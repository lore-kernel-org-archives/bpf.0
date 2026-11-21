Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260402;
	b=pQwOzA4/dRA4hpBI7CYm8tTwB7pwCuLxRDGB3j6Gb7ljlsShxCVlv4XwJ5U72gmw15pO
	 qKohWguqp4QMDFBdCLPHSoTjH3Ji6v6wZCpAxBK+6pxNvlWEpiYXV8MHsGAGfeix1XPUi
	 NQfxyWpHzwNSKPS9F3izQya4PWvWo5KDxJT6A1ohgA/Fhq8e82OP6XwVWjPxZgIkf7ReY
	 YVlRDua1wj97hSjFsRqm4jlMqX5WQi/DucBzB4ijga1PXGsfBp0DPFtsJsQSsiOexiNR4
	 R0tDAXokbkVx8LPKdQA3wmYWd581tYjBKgI94NyLHttdDjiOKw7HXftGWNmUQAkfcRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260402;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=sGSN7On8nFkwH/9q3bEhemJb5I6b9tJ93aScF88rRUo=;
	b=KDFteZWM4kM7L2xb/a7/9GVSFC4HzdSkinRN3NN8jlaOfbiiFomMUQpYZ0xGCLKqtlOU
	 ZWyot0WQjgs8rfieHubW5os4q/V96oCgNrIqi6vrA1jMTS87CjJFNZTY05garZFV7arBU
	 jmPEAhMm+QQsV+d/FHHJxKKqLb2z8uYp1pPwAFkVpLFGiDh7qL676rIM4yqx+URBsWciX
	 eJH5lBU/yVWDjbArWg35qSkyN0PP6kNiwrcA0lCNeNwuLRXc2G7koFIcieymI+NtzXRn2
	 wHGQfRgPruj3jYulQhP6vW2MnHkRrneLFUiANVfEKnW6yliZYfoNlCk2b5UwXVP1Ggw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g/tABRo7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE62606A320;
	Sat, 21 Nov 2026 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g/tABRo7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09631F000C4;
	Sat, 21 Nov 2026 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795260402;
	bh=sGSN7On8nFkwH/9q3bEhemJb5I6b9tJ93aScF88rRUo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g/tABRo7YRPaovOqVvaleGibiGLNGmDReb1edEr1cRdfkwXR+U6lOnUZWqck58eR5
	 Z3cwfByPRsHNmvYolQqirMc0G/3vWJpqTtqaicPKy9to/lcJZ33T+nWbJEQu8JChr7
	 k+FfBzmkn4HNrS3F13Qck4Q+3uce2ZxohNtGidXAuTZJDfAVlTX+XsHsadFKYCcRKf
	 VJspO+9FZo6/YEeByj+sxiXBaI20l2gpyReUGKXjAstw9Iqp19W2OYit2k+/PGH6eg
	 Esj6Bem/GeE8bUUZbdJgph3/jD5t2FnHq93KSfeycEoHwAQuNxCILDlC45h6Eev7kt
	 IlStXewlTSFJA==
Content-Type: multipart/mixed; boundary="===============6756210861823213151=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <48ff1b193b49c5f1dad6e9335679ba1129916e61ed94976b0b3b8ba4a92e9948@mail.kernel.org>
In-Reply-To: <20261121103222.88209-9-jiayuan.chen@linux.dev>
References: <20261121103222.88209-9-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf 08/11] bpf, sockmap: Fix socket lock taken on a child before accept()
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org,ast@kernel.org
Cc: jiayuan.chen@linux.dev,john.fastabend@gmail.com,jakub@cloudflare.com,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,kuniyu@google.com,willemb@google.com,ncardwell@google.com,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,rhkrqnwk98@gmail.com,mhal@rbox.co,mattia.meleleo@coralogix.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 21 Nov 2026 11:26:38 +0000 (UTC)

--===============6756210861823213151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, sockmap: Fix socket lock taken on a child before accept()

TL;DR: Behaviour change question: sk_msg ingress redirects to not-yet-accepted
children now fail with -EINVAL instead of queueing, and with
bpf_msg_cork_bytes() send() may report success while dropping data. Intended?

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

> @@ -188,9 +188,17 @@ static int tcp_bpf_push_locked(struct sock *sk, struct sk_msg *msg,
>  int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
>  			  struct sk_msg *msg, u32 bytes, int flags)
>  {
> -	struct sk_psock *psock = sk_psock_get(sk);
> +	struct sk_psock *psock;
>  	int ret;
>
> +	/*
> +	 * The listener frees a child that nobody has accepted yet without
> +	 * waiting for the owner of its socket lock.
> +	 */
> +	if (!READ_ONCE(sk->sk_socket))
> +		return sock_flag(sk, SOCK_DEAD) ? -EPIPE : -EINVAL;

Before this patch, an ingress redirect (BPF_F_INGRESS) to a peer that the
server has not accepted yet queued the data on the psock, and the server
read it after accept().  Is this change in behavior intended?

A common setup adds the client at BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB and
the server child at BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, and the client's
sk_msg program redirects to the peer with BPF_F_INGRESS.  If the client
sends before the server calls accept(), the child still has
sk->sk_socket == NULL, so this now returns -EINVAL.

The old path was:

tcp_bpf_sendmsg_redir(child, ingress=true)
  bpf_tcp_ingress()
    lock_sock(child)
    sk_psock_queue_msg()
    sk_psock_data_ready()

and tcp_bpf_recvmsg() read psock->ingress_msg after accept().  The comment
in tcp_bpf_recvmsg_parser() ("We may have received data on the
sk_receive_queue pre-accept ...") suggests pre-accept data on a sockmap
child is a supported state.

For a plain send(), this means the call fails depending on whether it runs
before the server's accept().

With bpf_msg_cork_bytes(), the failure looks worse.  In
tcp_bpf_send_verdict():

    if (unlikely(ret < 0)) {
        int free = sk_msg_free(sk, msg);

        if (!cork)
            *copied -= free;
    }
    ...
    if (cork) {
        sk_msg_free(sk, msg);
        kfree(msg);
        msg = NULL;
        ret = 0;
    }

For a corked message the data is freed, ret is set to 0 and *copied is left
unchanged, so can send() report success while the bytes are dropped from
the TCP stream?

Also, sk_psock_skb_ingress() still queues to unaccepted children, so
sk_skb and sk_msg redirects now behave differently.

The commit message says "Refuse the ingress redirect too".  It does not
mention that a redirect which used to deliver now fails, or that corked
data can be dropped.  Could the ingress case avoid the WARN_ON without
refusing delivery, or should this behavior change be stated and justified?

>
> +	psock = sk_psock_get(sk);
>  	if (unlikely(!psock))
>  		return -EPIPE;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44896626218
--===============6756210861823213151==--
