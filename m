Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF533EF
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441497; cv=none; b=jHAudDa1qmn+PkBNicy0OrBpNo/gqx/4V+UO70LeuVNBwP3CYWAdfkdbzp7DzyQY0nQ5Z9lMsFHfheibfSwdHAZLUM80NAQPF8YwawY9a56ieLh/HMpXBS/8T5boKaolsjlSw560IPkYlPUZ1lhc4At9YH966AtzgVXnLl2yzq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441497; c=relaxed/simple;
	bh=lTxTA/gMwGC7+q6s5bttAJzQYlh5OZ7i/bsUJTG9LMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TUi9onCmOZdAQ4kuoaA3h0Vvtj8ePd7NrZlICZBd2lKu432lzYWEr3eYuXmmw84LHo9m177i114YU41J2pON74jAIt5YjbJzUB6ZKLyC8b71TIjCmm1jS3EhF1fSOOwdJ4XT0grzQPWesNuuhivm8QL20jnDbyDZEypndEJEswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIr/d+xl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIr/d+xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2361F000E9;
	Fri, 22 May 2026 09:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779441495;
	bh=LBrrpy0ZNadbQN4P84D68GBVVl9PN3a0dmX01Zy8N+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JIr/d+xlI+eFNnfozXOsd6FWxV22rSAqTUeFjXWX7G6zyh9oFAV6AIWtECXeVZ/oo
	 5+ucUKaH08iupQZq1XPd75EtxEkUIx+ibXYG0aXoqYf3cU/8r/A2hhg01l1OEFjDgm
	 6dTxWdxJ/iCdtmi2gbe7McCHRJ7uD9LXxZGPCaXhLYQXb1uNTW3ntdRErT7/xU0QCp
	 Z9zZ2RzJCxm0uZ9A196wbIxsrPg+bopLR3Dh1cIXI+cF/zGxB4jEbR7A75+2Zcf9T2
	 EQ3IcJBdzArse6WH4YpQB7zUgSV8CD6nKA5QGc8NsEET21jOTC54PVCxmb+r7RrapZ
	 /JXzv6UfZS2Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 08/11] bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB
 if receive queue is not empty.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522074601.1658705-9-kuniyu@google.com>
References: <20260522074601.1658705-9-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 09:18:15 +0000
Message-Id: <20260522091815.AA2361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf_sock_ops_check_rcvq_cb incorrectly prevents orthogonal flag up=
dates if BPF_SOCK_OPS_RCVQ_CB_FLAG is already enabled.
--

commit 684ea4455b7f13af338937adb28643e76ddccaac
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB if receive queue is not empty.

This commit modifies BPF_SOCK_OPS_RCVQ_CB flag initialization to explicitly
reject enabling it if the socket's receive queue is not empty. It returns
-EUCLEAN to indicate that the queue must be cleared before the feature can
be enabled.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5913b3be9f1d3..883e4aaed49e5 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5395,6 +5395,9 @@ static int bpf_sock_ops_check_rcvq_cb(struct sock *=
sk, int val)
> =20
>  		if (unlikely(sk_is_mptcp(sk)))
>  			return -EOPNOTSUPP;
> +
> +		if (!skb_queue_empty(&sk->sk_receive_queue))
> +			return -EUCLEAN;

[Severity: High]
Does this check prevent orthogonal flag updates if BPF_SOCK_OPS_RCVQ_CB_FLAG
is already enabled?

Because the val parameter represents the new absolute bitmask for
bpf_sock_ops_cb_flags, any update to orthogonal flags (such as adding
BPF_SOCK_OPS_STATE_CB_FLAG) must include BPF_SOCK_OPS_RCVQ_CB_FLAG in val
to keep it enabled.

If such an update occurs while data is in the receive queue, it seems this
will unconditionally fail with -EUCLEAN. This might break the ability to
dynamically update socket flags, especially from within the
BPF_SOCK_OPS_RCVQ_CB hook itself, where the receive queue is inherently
non-empty.

Could we verify if the flag is actually being newly enabled before returning
the error?

>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522074601.1658=
705-1-kuniyu@google.com?part=3D8
