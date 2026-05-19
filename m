Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F63E1220
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179114; cv=none; b=mWgDizGWl79y1X2jhruceGI3A9h0hWozxWOMwdfHFw4fF1+smB6sTO4OA0sAzem9fAnto530O8qsbzJ3ua6lgytmusnykkd7/0G0fHSUampYjzcHvy3JEj+Bm8cfvdJEo43A1/BY0931zw6MccufLWGls0Nphr1GlCnSI3DEoxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179114; c=relaxed/simple;
	bh=SHiVfwiU5Ngd2W+3buFa4qpdrncZO+ppzbCAdf6kXrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eARkZUS7so5RU9ma0gp4gx1Z4yIjD9KyBofijbHJoCZpka1yafyaFZAbnP29O0Sebt+ehN/DL++8/z2R8Mm/gBhZbpWpK3rXnq3Qnsspf4JR/FpKLj+tG/+6tD/cKhYElcOC/8A8j9yBB5bKAU6ML9Dk9GTQVKv8W6fjMb+Ri70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3NIfszX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3NIfszX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38EFC2BCC6;
	Tue, 19 May 2026 08:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779179114;
	bh=SHiVfwiU5Ngd2W+3buFa4qpdrncZO+ppzbCAdf6kXrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=L3NIfszXXgRDC0VAASfDRyOdqdFvqMfBSKj+/nNBC4H/sk083qUwTHp60MiQDXR5Q
	 bPx7y0/F7VqGhfcq4ZHS6v19XVjBZoNd7STviJyEst7r67x3ZWU3DrlnrnWmu6hL/y
	 jwpyU0nfVXUKkDrwV7gWGeC+HX8S/DgcYuPoPrkRe4k4NDZnijJuYLmfhRr7gtddeh
	 3rMkC7s0ND2/1UYyM6xhwE/LxQhQPSsZNZ9fiGdWfcojHpnokWknfbdgwGBkQ7AKNK
	 1rzurKeFUb8iG1xz1+rF2+me2mzH/sdTNvCIe/BrmHxk1E7tt047aU/sZqKOl5jZra
	 9ZwObEADu8DPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/6] net: export sock_disable_timestamp()
 declaration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518082344.96647-3-kerneljasonxing@gmail.com>
References: <20260518082344.96647-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 08:25:12 +0000
Message-Id: <20260519082513.D38EFC2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Calling `bpf_setsockopt` to enable or disable `SK_BPF_CB_RX_TIMEST=
AMPING` from BPF hooks executing in softirq will trigger a kernel panic (sl=
eep in atomic context) if `CONFIG_JUMP_LABEL` is not enabled.
- [Low] API asymmetry between `sock_enable_timestamp` and `sock_disable_tim=
estamp` creates a dangerous bitmask trap.
--

commit ae551b79a5c9f8c77421dc360627b1e40e3ceaec
Author: Jason Xing <kerneljasonxing@gmail.com>
Subject: net: export sock_disable_timestamp() declaration

This patch removes the static modifier from sock_disable_timestamp() and ad=
ds
its declaration to include/net/sock.h. This change exposes the function to =
the
rest of the kernel, specifically allowing the BPF subsystem to dynamically =
turn
off the global time record function.

> diff --git a/include/net/sock.h b/include/net/sock.h
> index dccd3738c3687..8a49312ee0976 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -3038,6 +3038,7 @@ static inline bool sk_listener_or_tw(const struct s=
ock *sk)
>  }
> =20
>  void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
> +void sock_disable_timestamp(struct sock *sk, unsigned long flags);

This isn't a bug, but does exporting these two functions with asymmetrical
signatures create a bitmask trap?

The newly exported sock_disable_timestamp() expects a bitmask (unsigned long
flags), while sock_enable_timestamp() expects an enum index (enum sock_flags
flag).

If a future developer mistakenly passes an enum index (like SOCK_TIMESTAMP
which has value 7) to sock_disable_timestamp(), wouldn't it silently clear
multiple unrelated socket flags (bits 0, 1, and 2) instead of the intended
flag?

>  int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, int=
 level,
>  		       int type);

[ ... ]

> diff --git a/net/core/sock.c b/net/core/sock.c
> index b37b664b6eb92..2d552ae5edd42 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -474,7 +474,7 @@ static bool sock_needs_netstamp(const struct sock *sk)
>  	}
>  }
> =20
> -static void sock_disable_timestamp(struct sock *sk, unsigned long flags)
> +void sock_disable_timestamp(struct sock *sk, unsigned long flags)
>  {
>  	if (sk->sk_flags & flags) {
>  		sk->sk_flags &=3D ~flags;

If BPF programs running in an atomic softirq context call bpf_setsockopt() =
to
disable SK_BPF_CB_RX_TIMESTAMPING, could this trigger a panic?

Looking at net_disable_timestamp() which is called immediately after this
bitmask update, if CONFIG_JUMP_LABEL is not enabled, the code falls back to
calling static_branch_dec() on netstamp_needed_key.

This expands to static_key_slow_dec(), which unconditionally acquires
jump_label_mutex and cpus_read_lock().

Since acquiring a sleeping mutex inside a softirq context triggers a
sleep-in-atomic panic, will this cause a deterministic crash when users
dynamically attach these BPF programs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518082344.9664=
7-1-kerneljasonxing@gmail.com?part=3D2
