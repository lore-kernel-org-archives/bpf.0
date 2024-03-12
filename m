Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57ED567F
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710204474; cv=none; b=mRyFzgz+p1kwxychQtgqf/n6EZsLiMY0i/dX8KZ64N4VllotD0t+3DqEgdJYpkj1sAhSe/7pOZ7qxqxljvUkRRcb2PI1n3eA1YY36Rt68MfbPP9WD2CP1JGuwDjUkj7IVn/cUJznzc8fUf2bPZZvwrrTUU8DfbgFKi3Vm+f4Nfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710204474; c=relaxed/simple;
	bh=7OohOlCU2s+XovQoE7aY53efbQQhJlPdukXoEuw11Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0aZjR1ygiQ+RwhlYfzY1LKGqqu2oskll1+D7fKtYWIkrmxd1iQFNAtywaPSzaRyFE6hqijAdGcGouFN7IeAbV/fjD2HJWAfyfkP0gDSQO9cecMkkYDuacBUIysJdaznjHp9mkEI6/mAg/re+F2UVf0TZA0bOMMl+VBi+Yx7IAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoTGFDr5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoTGFDr5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412e784060cso35037545e9.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 17:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710204471; x=1710809271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OohOlCU2s+XovQoE7aY53efbQQhJlPdukXoEuw11Ps=;
        b=GoTGFDr5u75dHf9huytueEovL5Sc7zYbXKdGM+hpGqo+GZl2qhpIknR7MwLtBi2bj9
         zJ3j2k16WFvjiFgNpKHdyQmsHESo/hqJqfgYQw876xWichavNfm2+MgWoV15qxEyXfvG
         5iNa6jgDsU5LGRiOHe6hGi8vO1dCULurxu1IVKqAhjRpuwkGtu2HmXVoI1sOi9Y0V4nz
         X202AkXPRKtG46LQTJ+koz/nui0H0goVwmlSkZFvChSsZEFdy7VxTtFVyEWhlfBLFCCe
         +tyAfP5VqzcekdunFHz4RTLKLavrQzmpsH6SE1geKr0yCNyDfCyJTzsLg0FqCdZyOJrh
         LdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710204471; x=1710809271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OohOlCU2s+XovQoE7aY53efbQQhJlPdukXoEuw11Ps=;
        b=YQIyqRkoQwDUFOHLygKoFVPtolJ0vNM1/ZFGoffHeVzW12cUtQG3eHnKwgRqRCA9ex
         NdBCDaNW0Cg3w66hTG5jtdQMO+sFzfIHyqWVi8wQrZ56PEAxUhiRyOSbkBR2Wf1tQLlD
         xT1crwc3EuaATGAZ6AOXAEs3vAbA+6nr2eqFBIRAQTTklwlEf3ogfFkl/65aGN/+oZPr
         XfYz/lo4sYz959/T2VhBJjYxb0SguEiDDEWgLkYZqY/XH7gRHjYMLYf4kCPGcRfTHmaH
         O5Yu9rbV16UCLexPXyk8Xf7El+3wFMZ1oV08H2AT+wIpBI6DZSKdLS/yaE81Ct5Th+Lb
         76MQ==
X-Gm-Message-State: AOJu0YyMsUJYnSF1br4hJoLLa5+q0tqOurYCD9dHZLoQ0mSwmd59tNe3
	LzqI7J2ByB7HVlW12Ary9g6OvugGD7PjcLkzum92LLHNKfuaw79PfVLrRupL1BsJsLGfxzRjIAY
	WTbBYOzy4lR/T6MZfEF1fsdrZx/c=
X-Google-Smtp-Source: AGHT+IGlrNsvL97H+tae7tmYd+RxL9rI9nNgdbIUqdPWFW+mjX24TpvINqzknuBv7NwCB5Ii3SAIa0j/Qi7xrxcqHzY=
X-Received: by 2002:adf:a112:0:b0:33e:9912:f0c1 with SMTP id
 o18-20020adfa112000000b0033e9912f0c1mr3163339wro.7.1710204470865; Mon, 11 Mar
 2024 17:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
 <20240308010812.89848-2-alexei.starovoitov@gmail.com> <CAEf4BzZr_Ki7VnEO6Gi-w07vX9p-oaqaGZQq62VTD_fJm39K4A@mail.gmail.com>
 <CAADnVQ+4ySB7hxZ-vbt5u7YPNqORXo87rLq8D05oO_GQLXM2iQ@mail.gmail.com> <CAEf4BzbAxEVYHtdqK8tWD8Fr_OaTxuhg4t7g4VfAAL61KoLJsA@mail.gmail.com>
In-Reply-To: <CAEf4BzbAxEVYHtdqK8tWD8Fr_OaTxuhg4t7g4VfAAL61KoLJsA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 17:47:39 -0700
Message-ID: <CAADnVQLWm=S_kMYJ58g==PgYKvVmPB8qF3vHc+d3BWPSFOxK5g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/14] bpf: Introduce bpf_arena.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 3:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> no, I get that, my point was a bit different and purely pedantic. It
> doesn't overflow 32-bit only when viewed from user-space addresses
> POV.
>
> It seems like it can overflow when we translate it into kernel address
> by adding kernel_vm_start (`kern_vm =3D get_vm_area(KERN_VM_SZ,
> VM_SPARSE | VM_USERMAP)` doesn't guarantee 4GB alignment, IIUC). But I
> don't see what kernel-side overflow matters (yet the comment is next
> to the code that does kernel-side range mapping, which is why I
> commented, the placement of the comment is what makes it a bit more
> confusing).

Got it. Ok. Will rephrase the comment.

> But I was pointing out that if the user-requested area is exactly 4GB
> and user_vm_start is aligned at the 4GB boundary, then user_vm_start +
> 4GB, technically is incrementing the upper 32 bits of user_vm_start.
> Which I don't think matters because it's the exclusive end of range.

yes. should be fine. I didn't add a selftest for 4Gb, because
not every CI has runners with this much memory.
I guess selftest can try to allocate and skip the test
if enomem without failing it.
Will add it in the follow up.

> > > The way you split these zap_pages for page_cnt =3D=3D 1 and page_cnt =
> 1
> > > is quite confusing. Why can't you just unconditionally zap_pages()
> > > regardless of page_cnt before this loop? And why for page_cnt =3D=3D =
1 we
> > > have `page_mapped(page)` check, but it's ok to not check this for
> > > page_cnt>1 case?
> > >
> > > This asymmetric handling is confusing and suggests something more is
> > > going on here. Or am I overthinking it?
> >
> > It's an important optimization for the common case of page_cnt=3D=3D1.
> > If page wasn't mapped into some user vma there is no need to call zap_p=
ages
> > which is slow.
> > But when page_cnt is big it's much faster to do the batched zap
> > which is what this code does.
> > For the case of page_cnt=3D2 or small number there is no good optimizat=
ion
> > to do other than try to count whether all pages in this range are
> > not page_mapped() and omit zap_page().
> > I don't think it's worth doing such optimization at this point,
> > since page_cnt=3D1 is likely the most common case.
> > If it changes, it can be optimized later.
>
> yep, makes sense, and a small comment stating that would be useful, IMO :=
)

Ok. Will add that too.
