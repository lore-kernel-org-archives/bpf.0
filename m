Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86222DA757
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754972; cv=none; b=X3FT36a6ivhcBdCG6Gd3LzFN5wpvV1euc1H6dNsH3O06t3PxjyINr+N+sLuMI5lkGZT6jej9k0O+Keuq0AZZnfQeOekM0nncYCr3jD4ua65Ki27fZzbKUF1pgAXcUrci/2gW8rxWi7s7TiRLfWqlOyG65mBoHqTEUilIpXdaOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754972; c=relaxed/simple;
	bh=9xbkvuC0Oo+xhLW95N/vnGJZrJCD3+nukXF0S3HTjoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=duaGX9N4wSXryoSwjR78UR/f56bx+6vnxOjlPyLjC2MS3Ykxl0eXfHIs2ulWBt65j+TuNldlNLALDQ8o71qIgyQaU+z4JzDjM6s5Uskg8pOM81C9M5e9UC9eM40e9Ry/fBMB40FPEFnaFCz9TB6/3/91Ignxqz2hHlqUWzikJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoZo0S/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoZo0S/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F014B1F000E9;
	Mon, 29 Jun 2026 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782754971;
	bh=IFgW2U/ymLKMUAWG9k8uGnpSnkAI2fCiJ2IjmJRdKT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GoZo0S/+DvPT4gQ2PRKRotHG37prVpQlDQDcxYAaqXWaEXLVhMtXr2b22yoLg5omK
	 iLGbaSEXKPp5VTA3Wg8OARtcydPGb6i/EkayZzYmpgy8xQUca/2D8167XgotVf7kfF
	 BpYsX3zV7Q31g2Rdh1X43YfDghztNg7aXKdi6B1dIF7JornSYnUd5PjtO3WQaYkJJ0
	 Q4DdhIeYjvXhLikRw1AqF/zUEehuGbJWJyjIXlCA0MGEUtkr6a42eQIVHn+j1xfGyL
	 8NBGuNfXq4YUCdWte/ml3K8/+1aYoMI++Tucgk0OmczHsxGYThgGKrUOITPD/y56gg
	 HDUhWwwccoijw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf, sockmap: disallow update and
 delete from tc, xdp and flow_dissector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629172704.1302218-2-rhkrqnwk98@gmail.com>
References: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
 <20260629172704.1302218-2-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 17:42:50 +0000
Message-Id: <20260629174250.F014B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Deadlock Fix / Bypass Vector
--

commit 11c2a6f499580e1830b9a3c86513eb4f154d7710
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf, sockmap: disallow update and delete from tc, xdp and flow_dissector

This commit aims to fix a circular locking dependency between
sk_callback_lock and stab->lock by disallowing sockmap updates and deletes
from tc, xdp, and flow_dissector programs.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8489,11 +8489,7 @@ static bool may_update_sockmap(struct bpf_verifier=
_env *env, int func_id)
>  			return true;
>  		break;
>  	case BPF_PROG_TYPE_SOCKET_FILTER:
> -	case BPF_PROG_TYPE_SCHED_CLS:
> -	case BPF_PROG_TYPE_SCHED_ACT:
> -	case BPF_PROG_TYPE_XDP:
>  	case BPF_PROG_TYPE_SK_REUSEPORT:
> -	case BPF_PROG_TYPE_FLOW_DISSECTOR:
>  	case BPF_PROG_TYPE_SK_LOOKUP:
>  		return true;

[Severity: High]
This is a pre-existing issue, but does leaving BPF_PROG_TYPE_SOCKET_FILTER
and BPF_PROG_TYPE_SOCK_OPS (located just above this block) allowed to
update/delete sockmaps leave the deadlock unresolved?

The commit message describes a deadlock where sk_callback_lock is held for
read, a TCP ACK goes out egress, and a BPF program modifies the sockmap,
acquiring stab->lock.

Can BPF_PROG_TYPE_SOCK_OPS execute synchronously during this same egress
path and trigger the same issue?

sk_psock_strp_data_ready()  // holds sk_callback_lock
   __tcp_cleanup_rbuf()
      tcp_send_ack()
         __tcp_transmit_skb()
            bpf_skops_write_hdr_opt()  // runs BPF_PROG_TYPE_SOCK_OPS

Similarly, can BPF_PROG_TYPE_SOCKET_FILTER be executed synchronously during
egress when dev_queue_xmit_nit() calls run_filter()?

If either of these programs calls a sockmap map update or delete helper,
wouldn't they acquire stab->lock and recreate the exact same circular
locking dependency?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629172704.1302=
218-1-rhkrqnwk98@gmail.com?part=3D1
