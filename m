Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA03E5EF6
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969378; cv=pass; b=h9YtkzpYyUq79+491ECD8d1v64kEErNMWZJcAZfiyoDpiF5vIvcgeN+ScC5A7PGbc2dgDV0lbzfPe1CiyuXKjuGuMbYpfieRbfCGDoFIW/+Hl7VjX8HhuIHjOMXPc7Ph5bVl7MSo3AXewSOJco42xwlg/GNsxNCJbeFys8KJTUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969378; c=relaxed/simple;
	bh=QZ5BTdhWuwNTqn+F9W1Yqtel03/GsDTkRYB+N3uM570=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebpDFKZDyKuZxS28to02YWSsD/25a3Sy1WjZPRENLyt8bM7Du5QBvSHMAgApIVDG6PzLG9Y4GulR+S+u3ap0rumm4fE8dK7LwTEkj+Ku9SPipIY3UOad3bEaZKfWgbdO5QEDsEgx/bXXS7kF/4nVE2WkpGgupAG8xnlvNynBDQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BepPKLQu; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BepPKLQu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954d5d814fso20605e9.0
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 15:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785969375; cv=none;
        d=google.com; s=arc-20260327;
        b=Lr9xbfn5KUqzFf0ZJh+fIRCHSqqixfas383r7lMtwc1XjTz7mJxGdjzk5Slh69OOmu
         a5e4lIrqUi1Qsf+kB60ZxB8q7xCIVabx8opTNkce/XC0JQ4kyQ2yADIuqHWOpkP4H9RO
         7aetybbwqM0FsMbGHpW19v5p8Xom2MnCoQST5NxEugFcNNw/ILguPcQcdW+OFRrwHmKd
         4mpPcDu7+ZNATl/3lsP6igVzIG6TCQ5iAy9ejFkVRZIsCYNFPp2XLo/rI81tHLziHgWZ
         M5F5QF8CQ6E64bj4Uz2v+KJAppCFTWTK0iAcM1uGC/C96FKM/RMm+RPdcziazsISckgH
         c23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vbUa1U5S2JVGGRifyu/m/Voi0f7XGnyVnDbFu9OkoGE=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=MOqlRgp491An7xcULr3sRJEdEfJO576ysBewCxwYxnkuM1pr6w8PAZ1yx4fbmBnNK+
         iUQ+4qXCy3l1cbkqQGKFyUvOPozXZ454QV3HAoybgtc+Gdaz+CXWMtVrTw8d8gSC7e+3
         /YaPd7G0kGOfyUoOT6LdIghh/CbaI6t/UnsgAZ18UJnn9fXR13S6RYWYtPX8zMNP/d76
         QPw7KhDrO1q+amtJc2AC0UV/xN/atz9Wid0tRq7bhM4XM+Au+HAlwC8zuh9iazBikBBB
         Tu//fCp3wbrXESQFl+vBVaAsevFQFjXi8mvIYKDJaCauKFEGJZZJ3+SSw8lX/p2+5a1t
         wB7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785969375; x=1786574175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vbUa1U5S2JVGGRifyu/m/Voi0f7XGnyVnDbFu9OkoGE=;
        b=BepPKLQubW+fjHxT00hcYmhNV2kkVhtWtWtp6am6mTy+piPTP1hy9xp8HMFL/Tjcjf
         uJT+DsMAOejYBLZ4JGNZ8YMQWmnue8xyVZQci9wfgj3TbEZ6AspwyI/5+9rC8iaURquT
         L86VOIjMNYkmM3AYXj9fLPPanVFkAHyfWIG5PBhbWloiyO9wy2UmtjDow9eSon768sNW
         ik4qcjWdcrTQP/Af3PK1Tj5FjGTkDPrxYZh03MOvWpkxdYzF0sDbkAMgcTQswCnBeBtK
         8xvlGIlzLVTzllqnayZgD3G/UAeNCWlmHT2fxeJyeJBidTmb+0nqfDc840bzk/7xa9pr
         kURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785969375; x=1786574175;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbUa1U5S2JVGGRifyu/m/Voi0f7XGnyVnDbFu9OkoGE=;
        b=VZkRRRXMzLeIRKbvR7YaTa/0FubqavAVzxKUDwy3dwBqwxAY7+Pu7hsVvFKeRxboLm
         9bmZKrdQ7X+y6o1ODKhvwyvcMrFsRMnEddMlE/frMRGmvPQedP939YOWKMlFbWG3jn5Q
         IC8mXEfF+Q58Tw4klAj98qCLmBkIqexScDNcoa4TAnI8cIdl/wbvUEH9HysMtZSju3g8
         J36Y34lJDWhzxuKvq9CcMQSjFrx6WeTtA4b0HU2XFO/CbyU6ck773wgWaa/IbFIdqdUk
         9K5u+tbVZn7bHLbcM0BP8+hfpQF2GoUlT2A6zG+qUe6Hv1qmau7A2aoM0TKkNOWNWgtN
         e39A==
X-Gm-Message-State: AOJu0Yy+knt5EhscpHrfsI5N7dCObqrmH/DLDDw6bvZibwfYMq5UKZjh
	Dr0CxSsQ/VDaXkwiocIbwnc8GKXn38MiOaUluEGSGjeZnbV0RbpiJamYTesswZlB3P1bXSNLSQb
	KtG/E4mg0oTBQzv69Ve1Jpmcg25gAhWVzC6AltLOmRsQePmEm2WajUjCu
X-Gm-Gg: AR+sD12pbIwiTYdB2AhQD2NRAD7a2uIG7gpQ7cq7vTlXg6vKcGU7AQMYsWakkx/utqx
	KHp6ii0kN0aVk3AVKR8IFUzLFFRtEtQ3pSyW0xpdDPLP/rIgVndREj1IIf1lAEb1hrUhfolU1Mt
	15OrxfFDoqCmT5AfHI0KXDhS4dlQX6ppLf7mlMcwMnkOpnadB2SMCoL5IPlb7V2yce21vzfVIpg
	pGbd5COVCPEX6fX3FA3efvwwgHYceH4YEHU0XJ+kEeqa5+k5//eyRWWJxV3EvnZ2rLjAyJauMy0
	BLeCvOzVCBMruzwpGZFZfCwqSexpFdbWCBVhyOjDE6OpgE7H3lexMRSPASpH1RaqlXxWeHAEzIr
	Eb2wD2bKO64tuMoTns1CaSOv/qfl18QySPjPlRfz+Hv8=
X-Received: by 2002:a05:600c:6d5:b0:495:61fa:c936 with SMTP id
 5b1f17b1804b1-49953a481efmr395135e9.0.1785969374277; Wed, 05 Aug 2026
 15:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731010645.3965783-1-tjmercier@google.com>
 <20260731010645.3965783-2-tjmercier@google.com> <20260731013500.5D2491F000E9@smtp.kernel.org>
In-Reply-To: <20260731013500.5D2491F000E9@smtp.kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 5 Aug 2026 15:36:02 -0700
X-Gm-Features: AUfX_mx1O7U8jJ7lxB8hApscdlIws8QflJDWDCXDBxhjjF7HNLkg2iDBvs1YmTs
Message-ID: <CABdmKX2iuMORY+_iWDqE62tPk6sVAa9sNC8eMcZT0Js+2CqQqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: htab: Split htab_elem_lru and
 htab_elem_pcpu off of htab_elem
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:35=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Multi-line comment does not follow the preferred BPF subsystem st=
yle.
> --
>
> --- Patch [1]: [PATCH bpf-next v2 1/2] bpf: htab: Split htab_elem_lru and=
 htab_elem_pcpu off of htab_elem ---
> commit d1965b9ee7c9db7418fb306ab2fc480a8cd067d3
> Author: T.J. Mercier <tjmercier@google.com>
>
> bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
>
> This commit eliminates per-element memory overhead by splitting the gener=
ic
> htab_elem structure into dedicated structures for different map types. It
> introduces struct htab_elem_pcpu and struct htab_elem_lru, and updates
> struct bpf_htab to track a dynamic key offset for element accesses.
>
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 9f394e1aa2e85..f54366da459f5 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -117,11 +119,27 @@ struct htab_elem {
>
> [ ... ]
>
> > +struct htab_elem_lru {
> > +     struct htab_node node;
> > +     struct bpf_lru_node lru_node;
> > +     u32 hash;
> > +     char key[] __aligned(8);
> > +};
> > +
> > +/* Only for non-preallocated PCPU maps. Preallocated PCPU maps don't n=
eed
> > + * ptr_to_pptr, and use htab_elem.
> > + */
>
> [Severity: Low]
> This isn't a bug, but does this multi-line comment violate the modern BPF
> subsystem comment style? The BPF guidelines specify that the opening slas=
h
> and star should reside on their own line, with the text beginning on the
> following line.

The multi-line comments above and below this one use the same style.
Same for most of the file.
