Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869BB340281
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832448; cv=none; b=Ml+KyDnQHX8ICKdrMGYArwtI6qlIam5zmGJ6KcJQ3jB4Z2oBgtvLOu4JoAv32pFOKJuIQNuJgwZwik9u2ClaTzo4wAdSGuX0etGlJxLllxdZFXZZ+LLhvxX2GPNNF3KSnsv9PVY+M46PJ5MY0fhuQU+b0OESP1uQfR1nqI9ibyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832448; c=relaxed/simple;
	bh=jXFLso0X7JmkwTE0tnEV9pFB0Zsg2XAk5CcpC3peiw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C9IoAkv7S9+TxeAWSZNFe6DV7znkzMAr1qLnVeCQdeTUIKEcbNY5Wg9EcQ6EK18QDJ7+rdmDFO/Zy72TVI+MuamjNL7fZxgaoffsTLmCctsizQemqwBCmTg717X93vPQScMn2QfVmXdh3XCNm4YqawQzuwfHNG9CKGBqG8KAoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ9BZdZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ9BZdZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4F71F000E9;
	Tue, 30 Jun 2026 15:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782832445;
	bh=kwOewv4zLWyrJtrWJAnsgdaAK4Utg8FLc6/x/VOZvDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AJ9BZdZCTFb+bLV/wBbkhwZqHg17erc2OQyE9jkDo6sSCe5UAI8ArwERpNgv7g6Ep
	 wwzcHU/migvx32Iz9zUToT5o3W3O7SEuh1ybRwkWdPVqiafiRhPUkJlvtp5hyk3IGW
	 zZ/RSbIpM29jUokR9ooZ907bv2lFQs0jTXC7qForeRmNqO4HUftea0JWgjMT+r4VXF
	 kruYl0JCPRTa51Ub1Gtdq8496Az66cHBmIGmPH9jT61qa6po6ozn62rVPYXFwLbLhu
	 b+XhpF7CjrcBQ/Rc63p3WIDkRv5pc6GooEDWMQ53otQlORCE3yatkrX8QnRnJ63jJx
	 0WEoKx9gGfrTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] bpf, sockmap: disallow update and
 delete from tc, xdp, socket_filter and flow_dissector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630145410.3648099-2-rhkrqnwk98@gmail.com>
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
 <20260630145410.3648099-2-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 15:14:04 +0000
Message-Id: <20260630151405.0A4F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for lock inversion deadlock: BPF_PROG_TYPE_SOCK_OPS=
 can still trigger the exact same AB-BA deadlock on sockmap deletion.
--

commit a83dfc6fb81e4e2eb338be86e16b21c433de50ac
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: disallow update and delete from tc, xdp, socket_filter and fl=
ow_dissector

The patch prevents a potential circular locking dependency by dropping seve=
ral
BPF program types from may_update_sockmap(). This addresses a deadlock where
a sched_cls program taking stab->lock can invert the lock ordering against
sk_callback_lock held during stream parser receive.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 25aea4271cd08..83ea3b33ff679 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8488,12 +8488,7 @@ static bool may_update_sockmap(struct bpf_verifier=
_env *env, int func_id)
>  		if (func_id =3D=3D BPF_FUNC_map_delete_elem)
>  			return true;
>  		break;

[Severity: High]
This isn't a bug introduced by this patch, but does allowing
BPF_PROG_TYPE_SOCK_OPS to call BPF_FUNC_map_delete_elem still leave the same
lock inversion deadlock open?

If CPU0 calls bpf_map_delete_elem() from process context, acquires stab->lo=
ck
via __sock_map_delete(), and blocks waiting for a write lock on
sk_callback_lock inside sock_map_del_link():

CPU0
__sock_map_delete()
   takes stab->lock
   sock_map_del_link()
      blocks on sk_callback_lock (write)

And concurrently on CPU1, network receive processing invokes
sk_psock_strp_data_ready() and holds sk_callback_lock for read:

CPU1
sk_psock_strp_data_ready()
   holds sk_callback_lock (read)
   ...
   tcp_send_ack()
      __tcp_transmit_skb()
         tcp_established_options()
            synchronously executes attached BPF_PROG_TYPE_SOCK_OPS program

Can the BPF program call bpf_map_delete_elem() on a SOCKMAP, attempting to
acquire stab->lock and deadlocking against CPU0?

> -	case BPF_PROG_TYPE_SOCKET_FILTER:
> -	case BPF_PROG_TYPE_SCHED_CLS:
> -	case BPF_PROG_TYPE_SCHED_ACT:
> -	case BPF_PROG_TYPE_XDP:
>  	case BPF_PROG_TYPE_SK_REUSEPORT:
> -	case BPF_PROG_TYPE_FLOW_DISSECTOR:
>  	case BPF_PROG_TYPE_SK_LOOKUP:
>  		return true;
>  	default:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630145410.3648=
099-1-rhkrqnwk98@gmail.com?part=3D1
