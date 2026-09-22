Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273F3BB677
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108662; cv=pass; b=BwVEEVKDvydGR/ey3jApqvZddP0CzzeniywfC5rBJOlNBWz1x8vbdAjM7hFr0bVoYGeBPRXATZ5tsW/eNReQswWdKjmvoo2BrQJZ8vAjqn9qri8x1gk8wHeVFZ6ePvTknNJVPkMcMpM89J9NsLWwMvetQcAdJHEgwIiDyqx677I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108662; c=relaxed/simple;
	bh=+sfK3/3ZZLF+ZbTCtO0+5guiWMUXrvSJ8jXz2wEwafs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4i8U6JUH0akSSc3GVofugJeKFF3qPcOC+p8nkDzuhXSrI7eUvGqj15kBxZAYpK7OMVjE9Dk9TkzolUXDNijIKBvHg91y1wFXGhRkUV6ZtrjYDuwB9WCauK+uZzHQ3xTiystrBKHqwuihIhVk4M00WVlefzfazt9QdtMoYxQfqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk0NHcbD; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk0NHcbD"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae736c63so159962eaf.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790108650; cv=none;
        d=google.com; s=arc-20260327;
        b=n6n6bpCy8uoHT+n7HQEaEJVBkQGUfciEwBg9N5nVmRvy7DiwoZFiRIlCvRAx5EgW6W
         qFTErt3QMFo4ojE4i4XhkM8Zm2b2+kqCwaZi+PQuyLqGVmavH3hhOms5nAw5xwHxHYz4
         tbYx7dnbdALwYJ3teAenDAdjObQ8jJOuQxzKtZ1kGGgZsZWFHnfxDpRSLxqiPlXT/cZq
         7t7BrzVRz1zt/Hv6p19BmVLrENQcVWeRnpMQEB6WjQYrxeYas4+fnHgAxBorGsQRSNk2
         0m1syeqj1WuFOhsUhXz3by6+CEBVXOggoQdnjOQct2jICod9RxfyWDXTbj7rXNXrTJdQ
         j14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MGlxY/stF9UV9Yd5mArTkSQ33aYUoCNMkwZq4NryLYc=;
        fh=LejjuwMroHlPzI2FQ6+rJqEQWEks14wV28HDC5Fflns=;
        b=cS2S194+kvIxSHmyurIbr4a+4D79sWYhovuZXACiFyNZM49ZxD96pnKIIMRIBC7enA
         yUiTvo5Qkndm+buIVcgqAf1AgjM5if6sVStMfVz2dikn8HTomRFhg7rbJe+fAMZ1WY6U
         32lHCg04htijufaOsYQrsRa+g2MS9oOlhN393D8AlsQRZmggmXFpCFgZx8zfZ1UTzCCQ
         W0scRQrYqNDjprzptqGgzPCHjX3QcBbr7BuEIHbMdBYLO8jWaoILzT2cTgSsCLwMnbmE
         h/DTZbwvsbJEYi49eShsqhUHDfRp7NuLsyMCQjCh8q3jiaMEuj5dI5Wu7OXKtj6jcX8t
         xooA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108650; x=1790713450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MGlxY/stF9UV9Yd5mArTkSQ33aYUoCNMkwZq4NryLYc=;
        b=Zk0NHcbDSuljmxQ/1VUDrRiCB5dLvex9ZCcpBWXOVe0dAdF3mQUeJEHqY0oD1eO7X9
         6F1TxssewITq1gtquVFmyB4oOAgvgFr9Tjk/1jzXdAf2pldk5Njkf+fvz5QzD4bR+e0e
         Ov+Msy9TN2u3X3ymxNaedMn8sQgUdmjywjPcu1gRihdGSmVj6bVBxeLpoGucDMQjZKAq
         q4Q9ECV5ekOTAJmlvvgAkAZxoUs+/EQBfcqwiR660H9WXLNJUhFRrSg0cGhBZx4zOFge
         qRzo6qXkjvydz67Bmha7/hSF8gw+Zr/kPLAHvRpxcXZvufgSNuaUab04GFvxMtE4ZzEw
         ynyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108650; x=1790713450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGlxY/stF9UV9Yd5mArTkSQ33aYUoCNMkwZq4NryLYc=;
        b=JdX+4tFw7YtSRDp4GfSkxW+WVzmt5uaQZbJrViCrXKqIrAxQwdfRTNJ68CS1v+ybBa
         +8PZdc3iEr6iuHwkPgmpDpK0rymY6veiFLNYqFiHReC1LSHgzvDvAR5IgRg59eVM7CHa
         No/8wOkPoW/LPWjpcYVrT3V7FGgq0ULgk0EwjCxLXyRsHjeJBPfuxhBph/Ahm6CjAJ1h
         zwY47dQvXBtLSmT59P0JpoeZG8ZO6PnDAB08jLIlh2YlcH3gm2yyIeSAWjdUeTYB28ux
         JVUfeqrHCrKTYcxEN9R8Lnqt8zbDu1W1Br+mfs6js6SBBxXK0BlI4VXPA8/p5tjiVLRl
         FCDg==
X-Forwarded-Encrypted: i=1; AKwUvByEZ4CS/HztKix5xIDa3y1sc2UKpo+xNBtoI8Wfu8ysbTYIoEVClnYBO2gHDxMDX1vtBn8=@vger.kernel.org
X-Gm-Message-State: AFuF++kCBXrxge+FTBO99D2Ha4EALwRlJUx9MdTLSWN0Hnmo5Z9nOa7U
	WDZe2/hjLFI0WtCecb9WzSmV6h/ZyoK4rKBEe9KLO1Fky7BghB3tvP7zRTaF6Sf4XJ5b4NP10Hb
	tifxHhDdvmOrYENlV4E70OksLa/B5EZY=
X-Gm-Gg: AYBFou09wNko2J7ZoHvVOFd6OYfymbzpVep64JKgxQBdTIOKeg7QcwqkQ18s7Nx7Gp+
	zCdC0URrb6KRwNsYFNU3WMV70qzSbpRKVYBX+yqHZoTCTOrBvHQj0aCjoYmLl4ds4T5XL20M+Vu
	XOCZKQzDLTzeH1APu8J/ujMUuLuh0xRt7YuOWfwzzruIFI7U5V4+oHzPL2+G2SFjl8cdByLKt17
	SoUmacXIYzSITzDaIwaAeDAR8uZNxMtY5QIlDnw+Ue4Yyck6olqueYNhAxHzdnapTKKPzGsBrpR
	0V3wRlxJ9uC9OvoQd1FVW+iTLMu+WiwMS30epnmiOxjmLfmlZFgdf/Q69XqIlKkzYlteZYynppQ
	HpYecSA==
X-Received: by 2002:a05:6820:c91:b0:6b7:8415:d786 with SMTP id
 006d021491bc7-6d2d261c823mr453823eaf.49.1790108649854; Tue, 22 Sep 2026
 13:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922172028.6269-1-emil@etsalapatis.com> <20260922172028.6269-10-emil@etsalapatis.com>
 <DLM2H0M84V64.3DRNAWAWXR4FZ@gmail.com>
In-Reply-To: <DLM2H0M84V64.3DRNAWAWXR4FZ@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 13:23:56 -0700
X-Gm-Features: AcwNN1W5N_KIAWLFVCBSFDm-7vSGi6EFTLU4zBKjmbFVIMO1UfWu6-IsRp4hrsE
Message-ID: <CAMB2axPbLQhGq-LRLzW4p27YVMowcv0XLdF6gNrLn8U3mG_fJA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 09/11] bpf: Track whether dynptr type is known
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, daniel@iogearbox.net, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 11:49=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue Sep 22, 2026 at 5:20 PM UTC, Emil Tsalapatis wrote:
> > The TYPE_LOCAL dynptr type is used for two different
> > kinds of dynptrs in the codebase: Those that are created
> > locally and backed with a memory region, and those that
> > are passed as arguments to a global subprog, whose type
> > is not known at verification time. The two kinds require
> > different handling in certain scenarios, e.g., packet
> > pointer invalidation. However, there is no current way
> > to distinguish them.
> >
> > Add a new field, type_unknown, to bpf_reg_state's  dynptr-
> > specific state. The field designates whether the dynptr
> > type reported is accurate, or a placeholder for "type
> > unknown". Adding an extra field to bpf_reg_state avoids
> > unnecessarily splitting TYPE_LOCAL into two types, since
> > they would behave identically in most cases.
> >
> > The change is currently non-functional. The new field is
> > first used in the next commit.
> >
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  include/linux/bpf_verifier.h |  2 ++
> >  kernel/bpf/states.c          |  1 +
> >  kernel/bpf/verifier.c        | 27 ++++++++++++++++++---------
> >  3 files changed, 21 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index be0ccad15..f57730d1d 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -71,6 +71,7 @@ struct bpf_reg_state {
> >               /* For dynptr stack slots */
> >               struct {
> >                       enum bpf_dynptr_type type;
> > +                     bool type_unknown;
>
> why extra bool? Can it be another value in enum?

Second this. Could be a BPF_DYNPTR_TYPE_UNKNOWN or BPF_DYNPTR_TYPE_ANY.

>
>
