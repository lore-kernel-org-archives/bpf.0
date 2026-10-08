Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9637DE9D
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 02:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425465; cv=pass; b=Ppoua6ybUYqj3HjdtJPojVNH2RtI3mrrTDhg3PXcW+rRULJLpN2SnEm5g/aD3QdJsbvoO7LTTGMK7O/ye6t3w1iDKEYXnlBz3JKhZALSocTqA6Ii0QUFpKaETxb+4mWTz44WBSocYCKxemNW8XgJGk0RETx8tUiQ2NQdOBp+sVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425465; c=relaxed/simple;
	bh=tRcdTjRQ5UTW4DHDrkJ/ooF5c3DO+DoLfJDkOdlVFZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDCr3Clw4Sz6mHd3IVB82qRkA+5n4j07vF5JY0lIuGk83IafO54ZRBGuOq0MKIqNVcniZuPtMB+QUooPyyf9sWoMJn33WYK0hnAmAfZPQbYsJg0qwwI8c4waunPa2QB03bP0RyO2Sp8PhOwvYZkwDvEgsHvfltVmumHJBikBrI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5EMnMyN; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5EMnMyN"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so3480a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 19:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791425460; cv=none;
        d=google.com; s=arc-20260327;
        b=oUBlNQycVfw72E2cFB7Fs1MjHGKaOU6zdM+SSDuQcYV8TUS59bukcJeohC0Z6aTOPM
         GiaGc/Zj/ncZhnHVbyiW4aKvCm9pSxshS9Qf4vwuNRJLq56Fjah2bCRs3at17SPAL/5V
         H4t2xT6vwR9dzMthgir5pp969coPITVJRVCWDEbEMJxo5TYyEq7eXEP4yUV1AXm122fm
         RW93Ui8wD5Mg37DvPNEEMHLtnXFW9guxYuJlYBgn1fKPgBoZSqazaODwFuB2h7Xl6QJ3
         +ZDHqMKhWiVRD06dLmbv3uJJu0Re/zPzD+pHQT/8T90W5GPiCKN+Il2Fy+tYZAhx071a
         dzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mlmGRFd0U28wTy12oRP1z3Eel/hj8TBM+KWP2O4byi8=;
        fh=7MWxvKHuNYXoygDHdAtK9XYitPJpIKuGp7V+QPuugaQ=;
        b=PKUlSROip2ueZkfzj4C6r807j5bElxA7Ikhtb0d61It6C/oTA5p0YAbAk+FF/a73Kg
         bk4Z1612iOMq3MmYVofMpDsC0vsvC7ik2QKsWmpgpryvxiBC5LGPcV621BmqbNcKm3S4
         il04YN6IYJ+h4GyOYbtfSoGbRlVA+TmVm7V1u95d+8xh85W/7DnYD3UtCeJQvE8sDCfi
         GAmXA9qDq6y6QC180vQjdzo16EaYVkSwRz8Z4UxOmrgExiEaCcSGlDj1c9FPh8bXoqGv
         oodhjUgDDp74tn0IPw1HY8uhL0ZXG3z0j4re9/78lFfZ89xADyDB9WGnq5m+2S+sg5UX
         7abg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791425460; x=1792030260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mlmGRFd0U28wTy12oRP1z3Eel/hj8TBM+KWP2O4byi8=;
        b=I5EMnMyNwBCKYJCIs/h/xX5KJX7bNOo+0PYb/stAlNBfJvn0JC3k7SszWWtFHhFvYd
         SM7dt9heTzBwPrZ1vDo3sHVqhR80CEMXtwz47ChBpq26B2UigRNdecmZzLDeZyv/ZtsE
         hc39fNd5I31Ovznoj7Tg9K36yVoKOFP33RXXE1Bv66dprnTHKRMgKwNltJTgSCNOW97f
         cXYiWHV9xkjWyChFDxTCeDUWBEWOx/z7E4xDKwQWbSSkNXr8OBuWhrcnjug7eNy+u3bc
         +tAoxIu71q81QrEQabZtLrMcrStAES/XYJu73LVcuAcAfLKkk1c8fO/XR8NVNgrDhGBP
         NcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791425460; x=1792030260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mlmGRFd0U28wTy12oRP1z3Eel/hj8TBM+KWP2O4byi8=;
        b=WcHCij339hcE5X6MRZE1/4EX5xn2k5KrBreQRWgsM7V//lXp3yW3f5f1KAZAxjAfJf
         PBDFUWCaNXpbLXdPViqbdRaAhCnFzKkkmk1JSp+4vVcSeyxjCQ/cJu5EB8lmBZLDkF4Z
         /cMIwnQADCu2xYQsBsu6Zmbuztdh2m2p391xq9aIiBP5sscnuaPBsaXScBCXcs/hygTS
         43zpTfF2aLRVXyndmOE1759fIOPeTQozB8G73F9MTRAv6zftYKWC9UBsmWlnzaIgvc9p
         DwBJLRSOJLXcoiGIRvdzMo9RXCsgeOqbS2dWsHA/cmZk54nUuDZ/V7sxHH3Oi+1L8faX
         RNBg==
X-Forwarded-Encrypted: i=1; AKwUvBwdVnZN4KiOaqOiAlyUcC9RsWxPl/28tXeDjKy9FBZZhuMTFJWIIrbGaB/91SlhiUzKELQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsk8hOWIoUZTozmaLnsRYzrl8CuOV7Sop2pc+ibPW4Q21kgobw
	laD5wJUJoyzhATjvrEnCBKgQT2eHJ77ewKZKW2I/8yxwMTyFfujJc/nqgpGY0gZ/dx3UBUY30HY
	p9+MLI8REhVnjWrX9tJ6DOcG+lSfgpP6eTXjlJD8z
X-Gm-Gg: AYBFou1rpk29wBheFq8i7ZCRq7xsGgDwtcVehW/9CZe/nS5LDAWIsVGDiLlBpgWvcZV
	QOlwHE3987XQiyBqiF0dQIgkgsJ+hmBNL7+rn+CReYGqU/vN8JR8Yer29oDqVmKSAnJ6n8GLwJM
	7VNVam0QkYzU/rZFcwSBpkknDdM/+tF9UFFiZMsQb94PnYdprUuB43pblyUK7AEm1Kbee0W15DY
	xa1OQ/t+ne6nZjBuVGd7nwkGmArBb9hBRg1Z3qlnwQwlc+a3QPLYVOkUzsvLFCcGCrkuZhn693n
	I00YH7Z1R1L07GdP9WPi1WgXmv0TdW3HzVkSC3FotuVMvBui0iykDQ==
X-Received: by 2002:a05:6402:46c3:b0:6af:97a9:224a with SMTP id
 4fb4d7f45d1cf-6b01174ca66mr37674a12.2.1791425460145; Wed, 07 Oct 2026
 19:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005004958.3603059-1-almasrymina@google.com>
 <20261005004958.3603059-2-almasrymina@google.com> <4818da7c-be7e-4f97-b5a3-bee05ada500a@kernel.org>
In-Reply-To: <4818da7c-be7e-4f97-b5a3-bee05ada500a@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 7 Oct 2026 19:10:48 -0700
X-Gm-Features: AclHuK98bUqu0UNfrer7PsXheWlbUfZxQHPGdS03OVcyzs99X4ytv2QdoZrorac
Message-ID: <CAHS8izOmh+cjHsF9X39=Gxsw-wMHNrkxBD9OTPApVw=P43Cfbg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] net: netmem: document netmem and memory
 provider design in comments
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Luigi Rizzo <lrizzo@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 12:43=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 10/5/26 02:49, Mina Almasry wrote:
> > Clarify the netmem, memory provider, page_pool, and skb fragment design
> > principles in header and code comments:
> >
> > - Memory providers allocate struct net_iov or struct page, cast them to
> >    netmem_ref, and pass them to page_pool; page_pool, drivers, and the
> >    core stack operate on netmem_ref and must not downcast to page or
> >    net_iov outside dedicated netmem helpers.
> > - Memory providers are not restricted to net_iov and may supply
> >    page-backed netmems.
> > - net_iov is not inherently unreadable; future readable net_iov types
> >    are allowed.
> > - Per-provider logic belongs in memory_provider_ops, and per-netmem-typ=
e
> >    logic belongs in netmem helpers.
> > - All frags in an skb must share the same backing netmem memory type,
> >    and skbs with different frag memory types must not be coalesced.
> >
> > Cc: Luigi Rizzo <lrizzo@google.com>
> > Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Pavel Begunkov <asml.silence@gmail.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
> >   include/linux/skbuff.h                  |  4 ++++
> >   include/net/netmem.h                    | 29 ++++++++++++++++--------=
-
>
> ./scripts/get_maintainer.pl --file include/net/netmem.h
>
> Returns "maintainer:NETWORKING [GENERAL]"
>
> >   include/net/page_pool/helpers.h         | 18 ++++++++++-----
> >   include/net/page_pool/memory_provider.h |  8 +++++++
> >   include/net/page_pool/types.h           |  6 ++---
> >   net/core/skbuff.c                       |  3 +++
> >   6 files changed, 50 insertions(+), 18 deletions(-)
>
> Changes LGTM.
>
> I suggest that you Mina is added the MAINTAINERS for PAGE POOL.

I'm thrilled to be considered and more than happy to help.

> And do we want a new section for NETMEM ?
>

I'm fine either way.

--=20
Thanks,
Mina
