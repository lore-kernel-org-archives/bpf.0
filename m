Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748E1FFC59
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104835; cv=none; b=gj0GqGtXXPmZb9zdvzdny0XA2mnMnFHxCL75sVqmyfVYHWYQ+OQLdYIpI1gg9wfWA5AlqTwH7C1zIcmsWB0Pdwqkl89Ze7ECs6yQZmj4Xt7WhfCdgfCyaz3VV13YDYSgCPmgReqTBRPgjOr+MQ8ZfDRyeodT7SiKAExRA4b8LDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104835; c=relaxed/simple;
	bh=h/2BW9o0AUtROsOGIicYV4DJ2huVNz1mMY0Oszj4c98=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RPmc3HeklWnTkNHk/0JstHOXZ74tYGpqtmax3JXcqhnNLh6402ljdfGynUAtSQLIx5GFPrSz1eMqmNpebAPmESbFFOVLhnHzyJRsCZIXRet9sVDrBWkk6SE5TLzZSFeMKfhDNP3M3QjPzzKA61nN5K4jNxubGAFOrhHlY1SDdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qV7ccxvx; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV7ccxvx"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-493af9b574cso6178675e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 01:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784104832; x=1784709632; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IGALH0uG77Q7AOHLicxo0tx+ocagMVQNWTIbBaTngBA=;
        b=qV7ccxvxq41Nai5/c5TJoDS1To3L5qkNFlaQa9OhrSxumqigs3O9ec0Zk9YOl27896
         NpEwAcjerFbGXPWuSJvtIoJGaRx7nYkBX9v6lG5OXVwdKgil9rSI5uv0Qn9+M3qJgVx3
         ygkPXDyZYWbzRhxc0+XhKwqRSyDWZNZBq/r3FfjMLFiRF1VZWGOdeJ/SeG6eeWSGrN/k
         S5UtsxTkrrGJz3zr3or8ZRvYPUF1CRYeX+DP87zAmJq/MZ5lJfWp9CkjzJudbmI/TnTB
         twGS06FN7A51wmKgBMod4tfAHTazf+d2OA7LgUNceLM0QWSjEQrGIaOD/mJJyhJaps0+
         tiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784104832; x=1784709632;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGALH0uG77Q7AOHLicxo0tx+ocagMVQNWTIbBaTngBA=;
        b=NkLn2feRGFpr604Epf2kJiNHoYfm4DmidqRb7yW9s1parAthBJQiUUNBEIq3BdFZqP
         m7pcCCuQpegSunoUSqPslCd8ywZx7hUVsgiCv3gTdMFtSy1QZgJirMsu4UEmWRaCtWUU
         DIPBOuLB9m+lgBo1EqJDyWLBJmg0a8eKrsbbrgVT8clzalNTdWDq7lMCM7lVdT4yanPZ
         uIbMkafzjOXPK2uO2Zv/pvzq4lvdTyKsKMXb17lt1smt+WWX74ERmJ/GAq8+GrRwZvMA
         Ip4zpTl7pvUzgPtG1K+Xr7JIBPbt38NpzyGHUV87OIlY1+v40YzYne3BWyzDD7BTH1MV
         qs0w==
X-Gm-Message-State: AOJu0YyMb62XEtBB3Kf/0e6wACSESPyJjOAuyh1fuYnxnCA5CJgZgIQj
	eFlzNhq5zPFVyoKxallmaDxobqheGHQkB4f+PWGLWRu4rHuFWHajafS/
X-Gm-Gg: AfdE7clNITWGx3Z+6vg/8/t/G0uSTihNkHVmX7h8vQ3ecbHJy73GDP/GrM3pSQoRbsj
	q2y4OhuTZ1Hk0oSSjrrkQlEhlSFU8ou9xfUrRbE6EF8hz4gDdCkyXZNC9kM0e5puuYJfGDlBnBc
	3+wSIS+pjYpMe/UP/Yh0cHhB82VYoemEVF5XY+zUcLcxfbbzecEr3t5050TsGGQyQihKVQwtPod
	v5Zg/C5v3OeHg0k1PEK3nOlNDMIhp93odNXnFC2RgBkXu/Uy+eYkrqpXNId9NDjvRtIh6TXipRm
	JU/BXqyBQ30Rb26vOpvgnHXScE1Qz2Y4lhGycUuWfehP2fkbxP5vVuqxfsfLk+2zsKqiFOdUwkp
	PrBViK7pFXb1Nx+pRc7B54NsG6BcvLENMw1MSFG+0a5SRChC/RE2SEA/NjTZG2+gQGaHLQAmROh
	aqAu5lrFCyOM1kj113/csM/PYYPDJwWVA3gGOA0JEjlpi3tHk0xrses5inl4B+Ib65nizQxvB7c
	Dp8HevUYkp0/+fEaAl6I00Rho4eAr830AbZabI4VMGnpf2c0eDwJaY=
X-Received: by 2002:a05:600c:6692:b0:493:bf84:53d8 with SMTP id 5b1f17b1804b1-493f87e472cmr169828475e9.9.1784104832136;
        Wed, 15 Jul 2026 01:40:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2edd6fsm133869555e9.11.2026.07.15.01.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 10:40:31 +0200
Message-Id: <DJZ0DOKOTZ5Q.45F1NZIM8WJX@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Michal Luczaj" <mhal@rbox.co>
Cc: <bpf@vger.kernel.org>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Jakub
 Sitnicki" <jakub@cloudflare.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v4 2/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
X-Mailer: aerc 0.21.0
References: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
 <20260707-sockmap-lookup-udp-leak-v4-2-f878346f27ab@rbox.co>
 <20260707045338.B30C41F00A3A@smtp.kernel.org>
In-Reply-To: <20260707045338.B30C41F00A3A@smtp.kernel.org>

On Tue Jul 7, 2026 at 6:53 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The patch prevents a refcount leak for UDP sockets by rejecting =
unhashed sockets, but an identical reference count leak can be triggered fo=
r TCP sockets because `sk_is_refcounted()` relies on the mutable `SOCK_RCU_=
FREE` flag.
> --
>
> --- Patch [2]: [PATCH bpf v4 2/4] bpf, sockmap: Reject unhashed UDP socke=
ts on sockmap update ---
> commit efe688dfced966a49066087e860ab73696a8f75a
> Author: Michal Luczaj <mhal@rbox.co>
> Date:   Tue Jul 7 04:23:57 2026 +0000
>
> bpf, sockmap: Reject unhashed UDP sockets on sockmap update
>
> This patch addresses a socket reference count leak by preventing unhashed=
 UDP
> sockets from being updated in sockmaps. It removes the ability for BPF pr=
ograms
> to increment a refcount on an unbound socket that subsequently gets bound=
 and
> skips the refcount decrement upon release.
>
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -542,6 +542,8 @@ static bool sock_map_sk_state_allowed(const struct s=
ock *sk)
>>  {
>>  	if (sk_is_tcp(sk))
>>  		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
>
> [Severity: High]
> This is a pre-existing issue, but can the exact same reference count leak
> happen for TCP sockets because sk_is_refcounted() relies on the mutable
> SOCK_RCU_FREE flag?
>
> If a user creates a TCP socket, connects it (entering TCP_ESTABLISHED), a=
nd
> adds it to a sockmap, a BPF program can call bpf_map_lookup_elem() on the
> sockmap. This increments the socket's refcount because SOCK_RCU_FREE is n=
ot
> set on established sockets.
>
> If a user thread concurrently calls connect(AF_UNSPEC) to disconnect the
> socket (moving it to TCP_CLOSE and removing it from the map), and then ca=
lls
> listen() on the same socket, inet_hash() unconditionally sets the
> SOCK_RCU_FREE flag.
>
> When the BPF program subsequently calls bpf_sk_release(sk):
>
> net/core/filter.c:bpf_sk_release() {
>     ...
>     if (sk && sk_is_refcounted(sk))
>         sock_gen_put(sk);
>     ...
> }
>
> sk_is_refcounted(sk) will now return false because SOCK_RCU_FREE is set,
> causing bpf_sk_release() to skip the decrement and permanently leak the
> acquired reference.
>
> Could this sequence be abused to cause memory exhaustion, and is there a =
way
> to safely track the acquired references without relying on a flag that mi=
ght
> change mid-flight?

Could sockmap/net experts comment on whether this case needs fixing too?

>
>> +	if (sk_is_udp(sk))
>> +		return sk_hashed(sk);
>>  	if (sk_is_stream_unix(sk))
>>  		return (1 << READ_ONCE(sk->sk_state)) & TCPF_ESTABLISHED;
> [ ... ]

