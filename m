Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326912DF13F
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101966; cv=none; b=bbYMSMmXKTE/rNiioUQu33JA/3tC/EOlPECiR5bFqFk3Q5ELU/7CyrhiNl4oAcm42WC/39GrnTeoLoXXdOKpLaPVdRELQZSUKfzRU7DIf++pV8FJTIYV6jR5zTtFkO2zQc9nQZKuq0etu5dBzOZ819xyV0o7CSk7P1WKS2xiUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101966; c=relaxed/simple;
	bh=P/oZVmt/F+eXkvgokIA4KEIKyt5zPIbYRNNkNeWuEc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lYdv/MC68KwfH6ADZjuIxOkOP64Ni3/jDF+P5BJGxczzO6PgHjVCnwGhTuJtAr9m9oRNOOsh5bXqMFHPBOYsf/H8LFi7QXPC4upIFw7cBNwyYCoNFZVhk6m5wu6+T+fqtMgVE32o3Fup4pL8puMOIGk5IOJcSVEJ5VKALyZZp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAnncy8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAnncy8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31E61F0089B;
	Sat, 30 May 2026 00:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101963;
	bh=Cxfnfv29xMJ+28ckWyrFfgYLwL7zJU6mzd+cwbddgE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AAnncy8LeD9Zcfv9xyJvd5xYHEzy1P4xOySJJjwVgqvSR3t3IU9qsDCCs8VLZnwA9
	 dt4SHsZeaDUfm3BCkBUdjI2eY+q68hKVAW7PA+q9HRAwAGbmJDrzllxqLGtmzbIK7A
	 mkGZpAGod10KeR341NyLV7DRVfwgKtK7rXTuYjjBs5CY8DkR60Cv2i9KVEoWbSVFML
	 ZHzhO8pYcfYXaC3AyTg6IvUHX83eLkMn/b7YuXA9K52KUdmj6QGssJFebcBlxY4kjV
	 WRDuMJW/tkhT+YjKEOJOY6VaWZTevYtLccqF4+BLFB/8kZQAUUkQx/FpcDeGD3RYh0
	 FA0wpOzUOKutg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 3/6] bpf: support bpf_setsockopt for bpf
 timestamping rx feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521135244.40869-4-kerneljasonxing@gmail.com>
References: <20260521135244.40869-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:46:02 +0000
Message-Id: <20260530004602.E31E61F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lockless invocation of `sk_bpf_set_get_cb_flags` causes `sk_flags`=
 corruption and global netstamp refcount leaks via `sock_enable_timestamp()=
` / `sock_disable_timestamp()`.
--

commit 3f400ad3640a19655fbde51eedae40506ebf95a8
Author: Jason Xing <kerneljasonxing@gmail.com>

bpf: support bpf_setsockopt for bpf timestamping rx feature

Add SK_BPF_CB_RX_TIMESTAMPING callback flag to enable RX timestamping via
bpf_setsockopt. It updates sk_flags centrally to manage the global network
timestamp static keys.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..08ad102f204e0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5304,6 +5304,14 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk=
, char *optval, bool getopt)
>  	if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
>  		return -EINVAL;
> =20
> +	if ((sk_bpf_cb_flags ^ sk->sk_bpf_cb_flags) & SK_BPF_CB_RX_TIMESTAMPING=
) {
> +		if (sk_bpf_cb_flags & SK_BPF_CB_RX_TIMESTAMPING)
> +			sock_enable_timestamp(sk, SOCK_BPF_TIMESTAMPING_RX);
> +		else
> +			sock_disable_timestamp(sk,
> +					       (1UL << SOCK_BPF_TIMESTAMPING_RX));
> +	}

[Severity: High]
Could this lead to socket flags corruption if called locklessly?

sk_bpf_set_get_cb_flags() can be reached without the socket lock held, such
as through the following call chain:

bpf_unlocked_sk_setsockopt()
  __bpf_setsockopt()
    sk_bpf_set_get_cb_flags()

Since sock_enable_timestamp() and sock_disable_timestamp() use non-atomic
bitwise operations to modify sk->sk_flags, concurrent execution might race
and accidentally drop critical flags like SOCK_DEAD or SOCK_DONE.

Additionally, because the checks against previous_flags in these functions
are not atomic with the bitwise updates, could a race here lead to unbalanc=
ed
net_enable_timestamp() or net_disable_timestamp() calls, permanently skewing
the global netstamp static key refcount?

> +
>  	sk->sk_bpf_cb_flags =3D sk_bpf_cb_flags;
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521135244.4086=
9-1-kerneljasonxing@gmail.com?part=3D3
