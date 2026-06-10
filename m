Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4B1A6824
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 01:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056706; cv=pass; b=EFjXiVkQpo7+xGoAHGOhHairq6A7Us1p3f46dCliGNbolQ9vizQPUiyFJAlb6ojxgyMZyh/9C0hIBfxZ+8iWsOlIHVjr//I6E1kNDKlxep1bDR/UrpaIobDFtmw+s7rpp08dfBuYqULUbrGvbg9Milk7sIDwUA6eNLgjzpzeg0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056706; c=relaxed/simple;
	bh=r7wZRIULkzfdJ6PbIVDPQrynqxU84BnGc6ZnGMKQxbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdQGQVF0kOhj4Zr3hWq9XF4gmhPGCDFvtT3TE+ncT5P8hAD5BrYxvT/wFwJRNHYt5gkmSz7xo28sUpaAV46ilV/YpK8rUiRIoE13XofaIO2WLcvJDR6cQ4afHPZnvD5W48M9F9wxZjDJuFelk+G6K47eVTXmkJUCW3UhjKNJS/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHt6vqUW; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHt6vqUW"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6611689dc10so3670224d50.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 18:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781056704; cv=none;
        d=google.com; s=arc-20240605;
        b=VG+beaSIOedIay5b30szpUE7pb3L4X74bSYyVCxqN6vlKz+BUYxQrnUakGzahN86Cj
         aETOYpHmYUjKTlZHG7F57QnVRxSzlxtchyid6QzDf5qUy7RYIYv93VaglL5uKQsW14Xv
         7FCpRhUOz4qdyvv2/j8/apjtz9lNgblcEuI8fuYWmxJ6NQcgJ6yvnf9Wez0rogR2oqf/
         XS4twCtIRuQ7BnYaBZYG/8c6HxfDg+0eUL1GT2PfBy7TI/aE4WIgnpPpKSZ6yuU7YPvq
         jbpU63itsxETCBxXh9gMKQpXSN0jvcTw1PhzPAwG9++TZcZ54PzAK7F6NXELp3pvobxT
         9/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V26tMOgLqjN+F+t/D87zLfcdZGcgB0R+hwG90xbmU9k=;
        fh=UPr6o3wYPlHfsVg1G82RRkZU8CVR8baGsbpkyAR1GC4=;
        b=YSWDE0Yd1D0JOi2IDbrJRtib2JPHiJn/jI5JPM4T4UAmDXl4De3jYikdi3nekbYnro
         acr0OJxPFCrYfmtpC+3aqR3xnZPpITffRBYuMQLuC/NRKqbNLwo5C+1zFfOWx9QFqLxS
         xdwNROlBhIGLdauTwR2aCyUnOEtXegQAwmkBPfjgnJSKWdk2TYs0xhIQDupNRwflkDEo
         bd8Ak07UoEUmIKXoBVcHG5GjO7beyv1II/Jxh/WAYmCo6HPyv/SUyRVmg5hsFaNfwDPc
         Mu9d8pFr3pAcCePARvgb+EkszN1WvnX5vaNHuNGRm1+QFCI2sLuKtm6YthRSFFVOUcQC
         Aa1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781056704; x=1781661504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V26tMOgLqjN+F+t/D87zLfcdZGcgB0R+hwG90xbmU9k=;
        b=IHt6vqUWTuoZQ6HfufaMFIuLw052EaXdX8WR6Bn8l0Zcj9CUfBNVtlj+y+OblMvU3+
         R5cMN5n+jW6V7I2+Aq58v39Y14o4e2l6YXq0p2HQ0qLH6fWJpxqfLckfIqsJBADapRTn
         iJzHgEt7YXq+OuSufbQFiP9UYS0h8HGrNwj5VF/FPKx3Tba6il9QnQzDeCJO2gYmrWml
         C2SWNZpiErUUpSBs1SWocJdfNrgO9RyKA0mQ7MS65XahO6PcZiUQD2QubNxnQoyw1lWK
         YzUD2bG2KVd+ACm5Zai4385tTx5/yPGWsWIrhTHfFxS0HJHKZA6b1rY0Tl0dHWZSy/7c
         vC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781056704; x=1781661504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V26tMOgLqjN+F+t/D87zLfcdZGcgB0R+hwG90xbmU9k=;
        b=g+CFkQNSIg1Ti/G8I1ZYzbalHQBL4jyfFISfB0fFbb6MO6XNUqrt+chgk9fEhLyfez
         2XueI3v0mU7Mo1Jp0bBueKlvfjaDM4OIDpROwedIT2H4TUSCn+ZQEtXe3osO7SvcRJOg
         CzN5tV0vos++66leS25KDAU3SSlWM4oNFDe6xpgvjCTi6R3YmgfXhYH0M+k3JTnstHzK
         kWFhOFZrAyRvsaykTdnEy/LgRGSOggSO45T5BB9bf9yCo0ShaNlZMLS4sg5WZYaXIg9K
         MOIeUzlZGAVeuB3GL+IZNyeA14PzYPW1Dm45JUn12fXXtfpwJHWRSlQiKEuCgtzTnCV7
         qp/w==
X-Forwarded-Encrypted: i=1; AFNElJ/XL+YGmlN648grafaF4z9V23kj/avVIZuDDH5FX1XUXCoXs/Kb/IeeIEHOkrhBxG49FIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSaAjIP4jjqPRm56PJRpmIt/SOHozY/eaNoh1l1lKaS+FVHiD5
	/emxkag1BO4oEOg/H3v1jo9rQczrimhF2kWup9GRR3roIsDHju1Eb7UlQRWiPKfPSg8aFsNXB59
	DAXemeBeTyXmaNTDx3JhAzz4KzjFpctXT60U46guntA==
X-Gm-Gg: Acq92OH/Sjy3bcFvruL3YNJs9AbPHArrrs6u54vkjD7jJs86MADahJ5LmLeFjTs4gF+
	ilZAQBVDTwVhHH5Na4RBXoSoSGDZNKlak7GuS1cW+nkQy0SaU+ePjM9ym/vM6tC0NOHUsVeW2ku
	+pOsvX+O1m6f0nTqr8eibyDiE2LJqhnREFcivRHJ1qs/2mqHRkVkYyBonKCAOTDKZj8RRFMk56h
	akYNFYm3P37rveDcBPmA43CQ1BOqGoWhMnuLPrsH11TGhfaLtQMU6aaGWLc3sJ3CjU3259YyEQk
	WZvxp94OJzGEYvifG3QicDOZNoT2nE4xyJdJ3W6xkexl42t9BNb5jL39QY3DzO4vhlgJFQkr
X-Received: by 2002:a05:690e:4390:b0:660:4369:8cb1 with SMTP id
 956f58d0204a3-66106e90b5cmr15646241d50.24.1781056704624; Tue, 09 Jun 2026
 18:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
 <L0cwr1-KRSKR7-dJdjDmJA@linux.dev> <DJ4XIOT2RVMT.28I5LA2UOZVUI@etsalapatis.com>
 <AgOg1pJHQN-gpKhYUz3SMw@linux.dev>
In-Reply-To: <AgOg1pJHQN-gpKhYUz3SMw@linux.dev>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 10 Jun 2026 09:58:13 +0800
X-Gm-Features: AVVi8Cd2Bbe0wde5qToQ7hXErFi3TvnK9_5Ol1Mi8_YsK_saSVysuCpjLW1uQ1Y
Message-ID: <CABFUUZH9F+tiitstSBy2-M=WC84jg28CVMXU+Lu-va6jm71fDw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Unshare cloned skb before devmap egress XDP program
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org, 
	liuhangbin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:21=E2=80=AFAM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2026/6/10 08:06 Emil Tsalapatis <emil@etsalapatis.com> write:
> > On Tue Jun 9, 2026 at 7:06 AM EDT, Menglong Dong wrote:
> > > On 2026/6/9 18:02 Sun Jian <sun.jian.kdev@gmail.com> write:
> > >> dev_map_redirect_clone() uses skb_clone() when redirecting a generic=
 XDP
> > >> skb to multiple devmap destinations. The cloned skb can share packet=
 data
> > >> with other clones.
> > >>
> > >> If the destination devmap entry has an egress XDP program, that prog=
ram
> > >> can modify packet data. Such modifications can then be observed by o=
ther
> > >> clones sharing the same packet data.
> > >>
> > >> This can be reproduced by strengthening xdp_veth_egress to configure=
 a
> > >> different source MAC for each egress device and checking that store_=
mac_1/2
> > >> observe the MAC configured for their own egress devices. Without the=
 fix,
> > >> the SKB_MODE subtest observes store_mac_1 receiving the MAC configur=
ed for
> > >> the next egress device.
> > >>
> > >> Fix this by unsharing the cloned skb before running the devmap egres=
s XDP
> > >> program. Limit the extra copy to destinations with an attached egres=
s
> > >> program.
> > >
> > > Hi, Jian.
> > >
> > > This sounds like a good idea in this case. When I have a look at bpf_=
clone_redirect(),
> > > I found that it use skb_clone() too, which means it has the same prob=
lem. The
> > > data can be modified by other xdp prog in the destination NIC if we u=
se
> > > bpf_clone_redirect().
> > >
> > > So maybe this is the default logic, and I'm not sure if this patch ca=
n break the
> > > existing users :/
> >
> > I think for use cases where we are using bpf_clone_redirect() to use
> > one clone for inspection this would add an unnecessary copy. Maybe
> > adding *_copy() variants instead of changing the *_clone() would be
> > better? That way we wouldn't be changing the behavior for existing
> > consumers and the naming would be consistent with the skb_* methods.
>
> Agree. It's not a good idea to change the logic of the existing API. Or
> maybe we can add a BPF_F_CLONE flag for the existing API.
>
> >
> > But more importantly, is there an actual use case for the kind of API
> > that the modified selftest requires? Nobody until now has considered
> > the existing behavior to be a problem.
>
> Agree too. Obviously, this is not a bug. For the use case in the commit
> log, it's something that can be fixed by the user themself. If we need
> modify the MAC, we'd better attach a BPF program for all the egress
> device in the devmap.
>
> >
> > >
> > > Thanks!
> > > Menglong Dong
> > >
> > >>
> > >> Tested with:
> > >>   ./test_progs -t xdp_veth_egress
> > >>   ./test_progs -t xdp_veth
> > >>   ./test_progs -t xdp
> > > [...]
> > >>
> > >>  destroy_xdp_redirect_map:
> > >> --
> > >> 2.43.0
> > >>
> > >>
> > >>
> >
>
>
>
>

Thanks for all the comments.

I agree this should not be treated as a generic skb_clone() issue, and I
understand the concern about changing existing clone/shared-data semantics.

The case I was trying to address is narrower: generic XDP devmap
broadcast/multi redirect with per-devmap-entry egress programs. The use cas=
e is
not newly introduced by this patch. The existing xdp_veth_egress test alrea=
dy
attaches xdp_devmap_prog to all egress devmap entries, and that program rew=
rites
eth->h_source based on ctx->egress_ifindex. My change only strengthens the =
test
from checking that the observed MAC is not equal to a single magic MAC to
checking that each destination observes the MAC selected for its own egress
ifindex.

So attaching an egress program to all devmap entries is already what this t=
est
does. The SKB_MODE failure happens because the cloned skbs can still share =
the
packet data, and a later per-egress rewrite can be observed by another
destination.

That said, I see the concern that this may need a clearer semantic boundary
between clone and copy behavior. I will also check the last_dst path pointe=
d out
by Sashiko before deciding whether this should be handled as a bug fix, or
whether it needs a separate explicit copy/isolated redirect semantic instea=
d.
