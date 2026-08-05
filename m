Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DB4A0C
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902517; cv=pass; b=jOyJ6FAEE91sGqHymZQUnXdAj+exkNs5XG67aSNgT8IeAX4+x5zhTGMliB+YtL99lUxrd22PheRG89M2NIg/3el39z8/v7o5biteKvtYe84vcf3lZ5F1PmxxES7U8jaknNnSnkdPAABJdht1EB/V7PZoGLdiZjew5D3QQej3c2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902517; c=relaxed/simple;
	bh=SZ/BMOGRTk9QQFylaTjhIsATjR7rezwaeF9sIcbZ48M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpQ/8C9mYtgmvC7vP4TPWoPf2VfXu/D7hTDyfcP+fRmaU6mCN1FLytSkMmF4pip3MjqrqQT21WBZMgkfRSHGsvj66yS8R+A2LMNzZwzlyxp1UKQjFGlhXu0dakoOEMuckTIUGuknz2hebEVrreTTUXchkFdwMz+fm/aHpjrpT7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NIoffTVd; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIoffTVd"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb973e6749so572480a12.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 21:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785902516; cv=none;
        d=google.com; s=arc-20260327;
        b=P5r/+Td8ZUy08BoY6MRaibH5i2b2EXZQ5yUYKRbM2gSnorOblgrZTyrcqTC3e7lTMG
         DanY06vsFYUAxsaCMZEc/fsVZIGNZjWlpod/A0Nu//igDfCOadIthCnogn2iV0/ltrwO
         9EAau9FSt1Tb/EKFJ6Q0R57z0XJPIEu1RfBVnypkHClTAW0dovIj4a9t3rI7rg6FaqnH
         u5iAos+Fh+QtckEm7xW/tdhUSCPciCl6RzEMZDZp4dRXxwazSmJh4oqPYt2JBvzJmLSV
         b81yakSLxq32o7eHEVe5Pow18GpqtdK+HzNOQcOP/aqdX+E93Tz40iUjbuq/pFqOGuIG
         os3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SZ/BMOGRTk9QQFylaTjhIsATjR7rezwaeF9sIcbZ48M=;
        fh=pVap5fbzIVmulK4ahuMZ15gYTXTxQRsjZPPUKZxeU50=;
        b=ZGUC8CC7WCYkh1qixAVnviD1m7d+WcO2alCAQL74pbrSgcORJlxmNAVN5ocuqKEmmu
         ysiGB4GtndVNHmMAF79k36XUfHxHU0GNLaxVLNsmxVvuPZ054P0rqSCMelnaz4/5R0gL
         69TtYkZX/cW8LXawLlU/yWrIG8/W8bMHcY3SkG5Em9ZESEb5MBLNwHvfb++mIuyhUXzs
         +J8T/7NyopqY/SUJAYAaB9uXGILqo3l7WSHYn3z38kq+hF5Mf5rFx7fYQ0bP/O9louLu
         P3JNdQwi2PApdlgRe2fJKCwkjqkx7TsbK9f3TaNzsERUewsoKhKraf2BA6H+CGUK+vhe
         v4ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785902516; x=1786507316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SZ/BMOGRTk9QQFylaTjhIsATjR7rezwaeF9sIcbZ48M=;
        b=NIoffTVdFMhJ77pNMWsTYmPZbn6mA/sbFneZKlsEbxpKkVT8nZd3Fu2hu5V7MbR1zg
         fHAaeHP6jkOTVjmxDDYwdTgqcRDa/JuwvJRuaLEpGXoH5WV4NfRraR73rhcnVuba+D3B
         xUwcqk+Sq52s8o1D8w/izuyH6RN9Igi/UIDkYpmyce5JFjwohKtBUol2/Nsn8qrJHAD9
         PFj5OzGNAcCIiMwvLCat/TL0alkLkMQhcfNMzGRr/47DFjilbI7pcKRoywpAtgVf03qS
         qpvQvupbvWJyn53HCABHOxcda99RPGDCnRLUyAacbV+BZhxHpVI2Z8v5ngksHWp2fUon
         cb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785902516; x=1786507316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZ/BMOGRTk9QQFylaTjhIsATjR7rezwaeF9sIcbZ48M=;
        b=repZtU9Pv0KhX1JeCXF4N90LxZySDf8211lkuyzHGDfyJA+OzfgwlPr9ir5LCgmJv+
         vW60l/tzjJytyLQCFabDIRFjtns9R/xwhe1n2kCYDw6rhb3D2Qk+2/FF3wh1pvhr3HRB
         0ZquFR0P8DcLXWhWeOiFBHLsM8vfHc6xqA+oeeeOmhlYN78w/3NQr+Cws6hGMVQCVu/n
         eEQiWLguBkvCtVMqWFaSeG0Zx9FYClkuUJ6i/YVb4IhZl6HxSWRYuM781DsB/s1pF2tC
         cS0uzHqjk4v2XZDnUWI/Hq/P8yUo2iW81GZXeYl5UTNvjsBi49TMt1mPfY5W2aIbbeND
         PFmQ==
X-Forwarded-Encrypted: i=1; AHgh+RqfFVy2b9DXqOwbWGwOW9kXsC3zcX7e8bpQ/aF6CLgtNESAk2AgHxsEXb2A8OJqBeqitu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mvqcYhhVEKTnhB1a6B/iF+IZ1DlByuYfVQO4bgtGvtF6x6qs
	0FfSgF6RtjnvmNKzRy6jKEYtNU1jnadpE9F4pZa1/imwf/Q5ZGHlK8u3mxEOg5lVddLVuc4AGJB
	Uo7GkSmxr35Rgln7m1E/i60Zb29+PzmzPX/nAIP8P
X-Gm-Gg: AR+sD121kv31qQy2J8MbUx+HhJf9ddBq7bt4zT0XeSKmoyH5WvLlpmIhwPjIVeXlaDy
	JN6fjnoaypA54YTq4BpLyx8qUZhxGSuBh5lcKGnWrFFNwTNwP5XP1etmtvQ5xqXpaiYHeIC+Yg9
	PSBAwwE807ux8QXaBNsq4OgRcTvnluvrGrJCUQPxDxj9/ihnHy8gyvq9Vl8xcrAW9+Mu7UYnGIC
	s25DQbaKXgqZclD7i3rhlYbWxxMCeZCQzTOyuGkHdUb77862GBrJy2xihW90k8hnKA4k2ejZIfW
	yr7xlyBVbRrJ6bY4bLUwBV0YxpBQI2E5FlctjKRp8VX4FqkpJUn7FsRDuLp3zqglC0lJw98dYpu
	M87OtHXqYkm19zWmNTVNCE+AM5Zyc79K2atjrgsuxLLg5/MBdSFZVUacPZ/lpeqKLz5uw0V3T7r
	5bdGROaeMupXY=
X-Received: by 2002:a05:6a20:7f87:b0:3c8:e10b:7a9b with SMTP id
 adf61e73a8af0-3cb85e2a09amr4105411637.16.1785902514882; Tue, 04 Aug 2026
 21:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
 <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co> <875x1qyyyx.fsf@cloudflare.com>
In-Reply-To: <875x1qyyyx.fsf@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 21:01:43 -0700
X-Gm-Features: AUfX_myy2ETSSWZCV9CW9muE20y4c1Knov8NIRZlDgbnW6vDiP6t6ClWB_tNSjc
Message-ID: <CAAVpQUBcDGX42Dyzo24U3iMKVyNajgOa5ZD7uX=DhSWf4Nb-qw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references in
 lookup helpers
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Michal Luczaj <mhal@rbox.co>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:14=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> On Mon, Aug 03, 2026 at 11:00 AM +02, Michal Luczaj wrote:
> > Lookup helpers gate whether to acquire a socket reference on
> > sk_is_refcounted(), a check re-evaluated at release. An established soc=
ket
> > refcounted at acquire time can gain SOCK_RCU_FREE via
> > connect(AF_UNSPEC)+listen() before release runs; the release-side re-ch=
eck
> > then reads sk_is_refcounted() =3D=3D false and skips the put. The refer=
ence
> > leaks.
> >
> > Make acquire and release unconditional and symmetric: always take a
> > reference, always put it. Adapt sk_select_reuseport().
> >
> > Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> > Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SO=
CKHASH")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.ke=
rnel.org/
> > Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> > TC bpf_sk_assign() has the same issue; it takes a reference only when
> > sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
> > destructor it installs) re-checks sk_is_refcounted() independently at
> > release time. The same connect(AF_UNSPEC)+listen() transition leaks the
> > socket here too. I'd welcome suggestions on the right way to handle thi=
s.
>
> Can we make this scenario unsupported?
>
> listen() could return EBUSY if called on a socket that is refcounted.
>
> WDYT?

I discussed this kind of buggy rehash with Eric today.

We can't make it unsupported although it's super unlikely
that this is used by a real application.
