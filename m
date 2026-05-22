Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E82DC791
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440140; cv=none; b=qyD4b+Yii/Dgi5oF49gkVD3whaS1g9PZ3BwSw+zpc8LnMwt/YIzAQX7SN5rVFZbXjYY/xJtZYMqOmqhLz9xlIux55xkf/ABPxwvr2r3y5pe+g0qg217sitWsYjIllKi682BUQ0ZMtdN9fHofT7mftOmI2zWbpq35C7O80slKCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440140; c=relaxed/simple;
	bh=OeG+Ggb60vdt8bZRmgHM+kdeNMaKWU+IJZ8OGwl013Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o7ys+ZEK1pk6PE4dHL2ukyBg2taq3pEHWspcuEF2b18WnLothxx4igCie8JUxKn3zwKsPiA5AvKvVMFpnu45TCDstzqufFGOhNCxOo8NAUQlmRvufxacKTZHSubfNy7LGRsi5rIknHWsNLmrRLq9bf5o9bez6OOjE5zhImDs8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntCnTpHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntCnTpHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746F91F000E9;
	Fri, 22 May 2026 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779440138;
	bh=KKbK1HkapYDojmcDkd7UA0vhMB4o/vSGflpW9pITU/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ntCnTpHTWfi4iTb8rI6C1qYmCkZDhSA8sSN5EJMCgdFSYz8H5I/dZOAMKHFjDZ4K0
	 lLIVvO6iIT166sXSSpvqO8GKCDOwHCcch5eYLeBQPiGnpZHpPHiX2EREChDcuRxrwX
	 OYGwVUk8SaYlUoY8cFdbtixteLE5qKCGuG13EZVFthnqLvgiLmbPDZSNdvxA77/2wK
	 SFXTtCoQoTo5znMbIvtWiOIsLLBafsy2+WZ3rtTzIWE8vxBOmq7lBXQ7vh8JZSeFrD
	 eSIkM0UEaieliWmAdQznkJJDdb/xmqgjt0JxhEaLy5/sjmu+NoBNkFffuywePA+3AX
	 DJnOoo3ltnv/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 02/11] bpf: tcp: Introduce
 BPF_SOCK_OPS_RCVQ_CB.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522074601.1658705-3-kuniyu@google.com>
References: <20260522074601.1658705-3-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 08:55:38 +0000
Message-Id: <20260522085538.746F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] BPF subsystem multi-line comments must have the opening `/*` on its=
 own line.
--

commit 43e79a11591d79f0e01d647cd7fa7c248226e7b6
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Introduce BPF_SOCK_OPS_RCVQ_CB.

This commit introduces a new BPF sock_ops hook, BPF_SOCK_OPS_RCVQ_CB, which
is invoked when a TCP payload is queued and after recvmsg() completes. It
can be enabled via bpf_setsockopt() or bpf_sock_ops_cb_flags_set() and
allows dynamic adjustment of sk_rcvlowat to suppress early wakeups.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index aec171ccb6efd..31130e1b63ea0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6960,6 +6960,9 @@ struct bpf_sock_ops {
>  	 *					the 3WHS.
>  	 * BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: The ACK that concludes
>  	 *					the 3WHS.
> +	 * BPF_SOCK_OPS_RCVQ_CB : No header included.  The payload is only

[Severity: Low]
This isn't a bug, but does this comment align with the preferred BPF
multi-line comment style? The BPF subsystem generally expects the opening
/* on its own line before the comment text begins.

> +	 *			  accessible by passing bpf_sock_ops to
> +	 *			  bpf_skb_load_bytes().
>  	 *
>  	 * bpf_load_hdr_opt() can also be used to read a particular option.
>  	 */

[ ... ]

> @@ -7031,8 +7034,16 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> +	/* Call bpf when TCP payload is queued to sk->sk_receive_queue

[Severity: Low]
This isn't a bug, but does this multi-line comment also need its opening /*
on a separate line to match the BPF style guidelines?

> +	 * and after recvmsg().  The bpf prog will be called under
> +	 * sock_ops->op =3D=3D BPF_SOCK_OPS_RCVQ_CB.
> +	 *
> +	 * It can be used to adjust sk->sk_rcvlowat and suppress
> +	 * unnecessary wakeups before sufficient data is available.
> +	 */
> +	BPF_SOCK_OPS_RCVQ_CB_FLAG =3D (1<<7),

[ ... ]

> @@ -7176,6 +7187,11 @@ enum {
>  					 * sendmsg timestamp with corresponding
>  					 * tskey.
>  					 */
> +	BPF_SOCK_OPS_RCVQ_CB,		/* Called when TCP payload is queued to

[Severity: Low]
This isn't a bug, but could this multi-line comment be adjusted so the
opening /* is on its own line?

> +					 * sk->sk_receive_queue and after recvmsg()
> +					 * to allow adjusting sk->sk_rcvlowat and
> +					 * to suppress early wakeups.
> +					 */
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522074601.1658=
705-1-kuniyu@google.com?part=3D2
