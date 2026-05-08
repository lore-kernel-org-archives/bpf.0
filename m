Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572A2F616B
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267857; cv=none; b=SS1iJ7Vz4J3wFdl6LqiIOSiuZbjX+87KGfWvNkmXgX3fQhkWfJ2N9QiVV7Eje8FF4Y3usTvDTk7H8WzBb96Jcf+4cHMeL/cCkzWs1jOMheYlWQbNU29DdzddMmg9fQ4Rb+NCsqfA42JNSD5RiuvT39f51ap7B6i54Cvq2BUf9wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267857; c=relaxed/simple;
	bh=D+1t0TJkGZyINEBSfx/VVleEEn7Lp9Q3pwPCFvrLYRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jrfzAuGaEil/txYIq3KHdrY8fXYmDITUffzMGpGpkhKo2fz3FvvX5Qavi62nbKzY4NIsFdEgUJamJ+zp4nc+5R4uk4alZIUx3RcmSeZLRV0p9XPOJ6yv1FJIDZ35T9Jo0hvEJpYif4IjPiKlD6cbZjMHelKy754DHe47AibCTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT1z2GSC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT1z2GSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01190C2BCB0;
	Fri,  8 May 2026 19:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778267857;
	bh=D+1t0TJkGZyINEBSfx/VVleEEn7Lp9Q3pwPCFvrLYRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kT1z2GSCYM9LF+5DuRvjx7owp/xethWs8vXBVVedOo/V0QJghkvyaZ4Cs63ykedoj
	 OwsgmoxugWsdV8TBuLRumnqC6SmIG2R/fvDePI3kHS/6xpbGYugPdWtpqNixj4EYSn
	 onNj84Zpxsy8mu9lolBP2waoxpXJ1w1LMtjjTbBcqIF/WOxMXfP7XQwyFAhjBwn2JA
	 YlzidQwhg0ATH0FQhXOTUH7esfMT7tXJuCB9Nfz38UgdIRygVe8c8i7Udq2sGd9MMG
	 mDjbPAbzoyvhgX6FbHpHMV8syHr8e4RqEUaCdJZZOA0IuUaaq3xVyPsQchKiU4Von6
	 TRcZlHzf3C6iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next 2/8] bpf: tcp: Introduce
 BPF_SOCK_OPS_RCVLOWAT_CB.
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508073355.3916746-3-kuniyu@google.com>
References: <20260508073355.3916746-3-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 19:17:36 +0000
Message-Id: <20260508191737.01190C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The deliberate exclusion of BPF_SOCK_OPS_RCVLOWAT_CB from is_locke=
d_tcp_sock_ops() disables critical socket helpers, notably bpf_sock_ops_cb_=
flags_set().
--

commit 2ab2e31caf792b1e7312616215a88ad7ae1ef4e1
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Introduce BPF_SOCK_OPS_RCVLOWAT_CB.

This commit introduces a new hook, BPF_SOCK_OPS_RCVLOWAT_CB, which allows
BPF programs to dynamically adjust sk->sk_rcvlowat upon recvmsg completion
or when packets are enqueued. The commit leaves is_locked_tcp_sock_ops
unchanged to prevent unnecessary enablement of bpf_setsockopt.

>     This will allow the BPF prog to dynamically adjust sk->sk_rcvlowat,
>     suppressing unnecessary EPOLLIN wakeups until sufficient data
>     (e.g., a full RPC frame) is available in the receive queue.
>    =20
>     Note that is_locked_tcp_sock_ops() is left unchanged not to enable
>     bpf_setsockopt() unnecessarily.

Does leaving is_locked_tcp_sock_ops() unchanged also prevent the use of
bpf_sock_ops_cb_flags_set() from within the BPF_SOCK_OPS_RCVLOWAT_CB hook?

Because BPF_SOCK_OPS_RCVLOWAT_CB is appended to the enum after
BPF_SOCK_OPS_WRITE_HDR_OPT_CB, is_locked_tcp_sock_ops() returns false
for this new hook.

Both bpf_sock_ops_cb_flags_set() and bpf_setsockopt() require
is_locked_tcp_sock_ops() to return true. If it returns false, they fail
with -EOPNOTSUPP.

Since direct modification of bpf_sock_ops_cb_flags is disallowed by the
verifier, wouldn't a BPF program running in this context be entirely unable
to clear the BPF_SOCK_OPS_RCVLOWAT_CB_FLAG once it finishes parsing?

If the flag cannot be cleared, does this permanently trap the socket in the
fast-path hook for every enqueued packet and recvmsg() call, leading to
performance degradation?

While the potential UAF concern regarding bpf_skb_load_bytes() is a false
positive addressed later in the series by "bpf: tcp: Support
bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB", and the hook omission
is fixed by "bpf: tcp: Add SOCK_OPS rcvlowat hook", this limitation
regarding is_locked_tcp_sock_ops() does not appear to be addressed later
in the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508073355.3916=
746-1-kuniyu@google.com?part=3D2
