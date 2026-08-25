Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81A33E37A
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675718; cv=pass; b=lH9mTNLqg3dGxUmJ4tUqW/kJ4qkv87eZUqUtQKp5416qbHSKuVcs+6XDjuYv94JZU9RApJ9w5Gk8gc7d8BjOKsXRORW6bYRvFwrv+ONlpY1AzqY2Cf0sAU6p8kURzGgqi5t6FETlP0xVGLFfpAjEQqkXsL82ERR3ZsyIvWK/B+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675718; c=relaxed/simple;
	bh=XEFaONL8xYC/7ZTJ7N0jE0D6XCHhZNztG+W53n6kkco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcJfYY7JVAsNMK5hWFgIrEfHLfziY0BbvB3GWzKODjg2DpH/VH0tdpHTCpzCBOuiA7ich62MHfhbRhpgbyYW5xNLNpjKEZh3YYjoGE3x9GtaI/KVwWF+m4uaIIw9T/F1Y9zcCGxtaeNh/s9/9OG9d5CWn2LOdsrTOb4qWe4AWqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYqYPqWm; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYqYPqWm"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e507b079dso58184b3a.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787675716; cv=none;
        d=google.com; s=arc-20260327;
        b=FvVvxeyusZ9fFCTTvK67dROyrXWf3B+y5racW+T3Lw6mMfeYN6rYjko1dACgxxPXAM
         UrmaUxgeNKgJuTw06GXlmB19jTkhQ4ApW7H3C9c+esAD9k4pbeSaFYjxR3Vt215J8sem
         xeLIq2/qCLmHAvYWQJSeCWtLd0ZQfrngOcweaLkhVSQIAS6dIcc3Bbge5uqxLGyUceyM
         sd0n+CObT1GFTY0BjB3aRMqN+GzimhAjlhFRWYj84c6D84keq0izuk/zLXmuwhqZozjS
         KTAjg33KnDTWDcwogTlgXJI3J4xYZKyXc3Qmp3bg0beUjnDvLCW4l7pukd2eDSMF7R15
         XDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H0MU9SiN4cYunR3HktWWkcncktf+nU2XpGwFxF8Xzfs=;
        fh=YqiyZXhfxn4kSi3L+L758fjm6RPHuIThR0sloNOrzVQ=;
        b=lZg0rpmtGFfS19xjhBtzFTYWPedYFuhm0zQCtdduizbaPrOpXp5lAvNoKCSKbDhjOc
         GVCoWsh7hnVrcQrAT4P6sXUl5xc8p6v7hQegN28JpaSTXq7wUvS1nAh+1naKlDPpLmmk
         sYZBtrATOBCqHfBapaA9O1Fs00IhYx2CW5eG75jpt06oR4cCd8TxomKzEwauRQxm7kCN
         OWUBy5jO8OyRHCGwodkQ42sGxQBWBNo4yPC3D106NLy7JtYX/kvz1GpBV5+dgwTYHR79
         lJsTSpK4qDNiRTX8dwBjB3bdKvlTm6jUm/Z51ai1jJieMpqwsisEVwN735ZjU8us42Nl
         N/FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787675716; x=1788280516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H0MU9SiN4cYunR3HktWWkcncktf+nU2XpGwFxF8Xzfs=;
        b=iYqYPqWmjR+kZUt5iXsryJLFGT2ko+6vFfY2RtU4aevSxTprQJwb6usyd5MYkerQlo
         OzsoxIDtP2TKA0+JexXRRCSuIjz1un0bYT7EWEdIXYLn0QQvo4oEXec2Xoc71JkKwDd5
         ieA8K5tJE1WZfjINI50q+8wBYZSzLgQmfR4/9howMnbrYUCgLH4svMi5fl9otm2CDmxE
         yQdYtW213NBnD3+Zz/Wo8mvoz/W65Xfq/BYJB3zSSZPvbSbIGQzvwQ34nLDI32IXTSpZ
         aKCqIZ5Puzv1l+rh8DVcqojnG9CRYKvg5pjZhfTjyzlkcR5iq4DQS3TUCYhelskDaY1G
         LcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787675716; x=1788280516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H0MU9SiN4cYunR3HktWWkcncktf+nU2XpGwFxF8Xzfs=;
        b=hjj85g0U4rEcfNala9gPBwci2VXi9/R2lJbfPe4W3xSjmLO+/kqYYxGHGTOexXa16c
         POAttmPuw02eF5/euaNXzM2qhbDUyVQbfcBB+30ERKi+N6T8Ph/MMSsrctmxjp3if3Tz
         Lr8yceJQhwmgPcA512PLBNQ9f/tlReu25N8yJujdZaNPhWLfMGngd77JYD8cJUE19U/x
         sftxerYbiPyy12LNFoi1jIPfdHFJOY1eaaSkPaO6jvlC5Gy6ZHMMHOMUvFiLh/eMMhsM
         lcjbDdSqkAe6/OMiJENT5E838+YxOnOeBzIts8TpZNYeloSprc+cZJNxuTYhHVbVUiGJ
         XuqA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3yzZjn5J+wmUw9xYbKHoWN+Tg5LNw8EFv/kDEB7HYyhR33HKHJY7OUop2Rb4ej5S0F2w=@vger.kernel.org
X-Gm-Message-State: AFuF++mcuKJzhXHZd3779y1F6tqka8Y2+0AXIHicZxucW+lK/KkcxPIL
	iU8S3UX8N9yfJL808tBdV04mUml3356Jj2fxML01mfCD7e718E0l6GMif8Bn48sHu09dOCDrDCg
	1HsZpOa7nacjUZnI2/xE2dpaolbJs5grdl8EP
X-Gm-Gg: AR+sD10OhDJydeBvboqyFWpnalwSqPjyCP3qT/M5bYtaVxij50s79q5imrpA5XAgo9i
	Me57cFD9Dw07t1dd+UBIMQsQQwwV1CQPBeyPdJvclpA1HXztFrxXWLZxTtMhtouOzcaoynIO6CC
	l4wfLOeQbKKdExSU9hlgSSB67u7XgmIbKktCNy/rhFIk9A87J9jT6daz1KPEOL2EGEZWo4eERWV
	JkRCDvn5BePWFH2MSB4+c8Wef8ALJJpd6lmLr168B5gqYqSE2eOTeVicfhoFHhOhnGALvZM5B6U
	I27LIjFUayTbOAa39NWyYXM+ZmbR5EdskPZSbxDNTSB1Ye0QxP3xslgoSZd3iJd3RU2/uy2PdjQ
	I4XwdD9BWVM6bPQbUJwJkjlhEh4DYZXU+RdXS9QBr1QJOU4AAVT1mMJ9ye4BK
X-Received: by 2002:a05:6a00:2ea0:b0:847:99bb:b6d0 with SMTP id
 d2e1a72fcca58-8523c9474b5mr12854188b3a.15.1787675714932; Tue, 25 Aug 2026
 09:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-b4-bpf-arena-free-resched-v1-1-5c447477a64b@debian.org>
 <20260824170831.33E051F000E9@smtp.kernel.org> <ao2gP7Y6UJ2o2tUc@gmail.com>
In-Reply-To: <ao2gP7Y6UJ2o2tUc@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Aug 2026 09:35:03 -0700
X-Gm-Features: AcwNN1WjlWkMaVf3-1mw13hLMnxI3KEyHvkkyPcaIqvfs5peMp6PpF-5TCuL0uE
Message-ID: <CAADnVQKP8R=1aZiDcnfkqD3mA=32R2Yrw642u3w7de4JSfMWKg@mail.gmail.com>
Subject: Re: [PATCH] bpf: arena: reschedule while freeing the arena pages
To: Breno Leitao <leitao@debian.org>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 7:29=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Mon, Aug 24, 2026 at 05:08:30PM +0000, sashiko-bot@kernel.org wrote:
> > > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > > index 7b6847200b431..c5f6bebbb15c3 100644
> > > --- a/kernel/bpf/arena.c
> > > +++ b/kernel/bpf/arena.c
> > > @@ -364,6 +364,7 @@ static int existing_page_cb(pte_t *ptep, unsigned=
 long addr, void *data)
> > >      * the freed page. So it all relies on 1.
> > >      */
> > >     __free_page(page);
> > > +   cond_resched();
> >
> > [Severity: High]
> > Does adding cond_resched() here violate the lazy MMU mode contract?
> >
> > The callback existing_page_cb() is a pte_fn_t called by apply_to_pte_ra=
nge(),
> > which establishes an atomic context by wrapping the callback loop in
> > lazy_mmu_mode_enable():
> >
> > mm/memory.c:apply_to_pte_range() {
> > ...
> >       lazy_mmu_mode_enable();
> >       if (fn) {
> >               do {
> >                       if (create || !pte_none(ptep_get(pte))) {
> >                               err =3D fn(pte, addr, data);
> > ...
> > }
> >
> > On architectures like PowerPC64 with hash MMUs, lazy_mmu_mode_enable()
> > explicitly disables preemption. Since preemption is disabled, cond_resc=
hed()
> > evaluates to a no-op, which means it won't actually yield the CPU and w=
ill
> > fail to resolve the original softlockup.
> >
> > Additionally, if CONFIG_DEBUG_ATOMIC_SLEEP is enabled, this could trigg=
er a
> > "sleeping function called from invalid context" bug during teardown.
>
> That is a good point, I think a better approach would be to drop the
> cond_resched() from the callback -- existing_page_cb() goes back to its
> original form.
>
> Then we walks the range in chunks from arena_map_free() instead, so the
> resched happens outside the lazy MMU section (FREE_CHUNK_SZ is SZ_64M):
>
>       addr =3D bpf_arena_get_kern_vm_start(arena);
>       end =3D addr + SZ_4G + GUARD_SZ / 2;
>       while (addr < end) {
>               u64 size =3D min_t(u64, end - addr, FREE_CHUNK_SZ);
>
>               apply_to_existing_page_range(&init_mm, addr, size,
>                                            existing_page_cb, arena);
>               cond_resched();
>               addr +=3D size;
>       }
>
> Would this be a better approach?

Just to be clear.. Is this needed to backport to some older kernel?
New kernel with CONFIG_PREEMPT_LAZY=3Dy shouldn't need
this old practice of sprinkling cond_resched().
