Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C41368D40
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614731; cv=pass; b=kp5OH2W0FwmmF+Damc4vxXXag6Sl/CNFrPzs1RTjEiWIPzMfJOadYYz8TJSTZ/0YJy4UPNtGEU2Wx3f+HeYKcVQdSnpKrMZijpV5JA/NV0HKTePXqRx79hjkD3vMzS0CEOkPA0BI/oTikB/y7SW+e1ZI+C5E1TF+55dbeNfIj8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614731; c=relaxed/simple;
	bh=z/n4l+tnD0xY6u8oFv5FhpmWDe1bwms0P4exdidL/5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7hGfAalo+pSCgdr4CDfeNkearjA63T3r9P0dHi6yHiiT+a4LKxN7+I8OHWeuoe92hqY0YLOKj6oJ6jXhCKHGMEJ5383lrcO+CFgBKy9T5gZr7hpVJblI/N31kFbhZ8EJAJz99vFvV7vdSVmzwcb7v0kaMiCoEh16O0sssZ3eA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXxcKabm; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXxcKabm"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3653cb9c6f8so4883459a91.0
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 12:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778614729; cv=none;
        d=google.com; s=arc-20240605;
        b=KCbO15Dw2dV438ezU7YprFFM001gwDl+lBPj71ux4SP66TIBqRDMzsgWZasmQU5LKx
         FO5zPIu4Pfu8LrILFJexo9k+smwveEWFTCZWhIFcLqZ35AgPm6xPWzYB7rCJE7Q5MlhC
         wqiyuCnYXZzwVJvm8zkGO3z9ul8ROpFiRlVaGfaJmyPMW49tJR07c6aHQrC5NR1pJz8Q
         fGgofLKdlK1BaViou19DR5UfNHJCW5PfQSIlxEd1Gz4QABklKwxiPVZYMu8x7T8Q5+Ll
         /suZEayVnijPOWlsSEh2DhyC1A6Vd6e9t8+iY1qw5+U60gDhfPF8rVW08oxwx21Bl42t
         fNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lV5/9Lh09aeZxFXscjoWXpJTticrrygDaBuVo3TZXZU=;
        fh=/zjp4Zs7HOODi/3OaH85TomlkS0nVpQq3WCP2LnKR34=;
        b=CKrbqJUyZDQSRSgyganu7bi/JkHfatiTtvoso0+oZs+/AtgqOzbJOQnQXJWOegl64P
         x8N2WkC54VmIY8iUaP+zSVlu1P72l57s86xGYp+yDl8/P3IQFenfbzbHJsHJ/61niLTB
         +7QZh53t9Z2WMv99GGsOnZQHVMwxfjBmiwpD/W0x/5b3ykTnsaVncy8GOK9ormJ9/IDj
         r+AboBn5LP2aUygsA2qYDHKG+cwaHTJS2GOpnKPSI9NdO084OFgQAGNr0WCIB/pRota5
         aBxXH9OUR6otMqEF5wbEG8r0iTxZkSZ7EnjkgaJQPvZR/NIFeA0p7dX5uucRL08Zi8vG
         8hZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778614729; x=1779219529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV5/9Lh09aeZxFXscjoWXpJTticrrygDaBuVo3TZXZU=;
        b=VXxcKabmkhYf/D8c646ZYuaq+gg5ofk/6I6DclgC0KbsaFaV+gUajmQega5u3MRTe2
         TophAmO94DYOaU0e8YVdlZ3znf+KXvuc5SfH2Qc8Q+8KV446Jg9onRo+89D0uW3pKAua
         jYzn5cKQA1mhR8Lk+2vEtJTFUFXOBYiASP6NCXakSVb9lshNKaqDi3h1oCaKt3GL8yGY
         OG+o6Gl3DMG/0A3pAsVgfoBkbVDeqj3Tvr9GKqqDXw46lKUOiO9Y2VHGt9s+TF0xjNJk
         LOKvaHgZiIld/0Q3pA435P2i//kVbprtzw50LLVzGQFYczrPlUZ4vdaJpXqSTercn2J+
         v6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778614729; x=1779219529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lV5/9Lh09aeZxFXscjoWXpJTticrrygDaBuVo3TZXZU=;
        b=pL2GqGsSQ8AL3yiqyruMY46hf91pqr2+C0AfTNrShTyr2XD1xe1dxULHKdY1GUw1vq
         7kiSovgKJBTGc8M1fYNF1+CxsC0H2g0qdSo+0vj94sWqKZo+xWgcxHsCic3dCV+zH4a4
         A+b1UnZHLrdirEnptRdo+eNnXEfQzjcYlFW9tqd/guQ8mn3W2aKwDM2SOkRKq5fZmPFB
         OQrDd6NYAzk80UMLuyBGm67QSLTd095+dFn6kkLA6Gn9CsOXWzBdeBHZ6ZGQ5/U9D7FS
         /7Ab6a4fsjsCcK9tewiaBVYBZh9D2ZySnNKjajGPbbf3o6rWFoR6MdLVrrvxDrkMR4rE
         rFqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1eWrv1nCcipbuhUYji5Q0PWNfGAKJcY7i2bCi/nisszTggCyjIWGXD9pn1a3ynmOF5es=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuYqEgHgiybnD16qdrvmCWHhFWMGeBSXn9NRxOEA6x5Ng4U4/3
	yU+AY9NURwnT10xzcnElH0ZJfvA3iTxSPb/EHs3RHwkJJRE88MdtiZV/mmgNycMhA3LSlVydklC
	VxW2D0/q7K5JVzbsfFmqftHn2dAdXyyI=
X-Gm-Gg: Acq92OEyZRNhrcYYPVFBkrXN2VhnneI/X7NvfyjmjXlSWRG8O6VfK9Z3qdjf66psi/8
	2h+PrD3pSrrIVOY60x360wIdVlqjEJ4nQLFU84JUQbrzK5a+je+BNe7wCZX5LuSyxCm/ZHzkmKZ
	aM4MEBsFN2nQKjj2gvLE0Xf9zJNfyT1YLriaTtJ7Pjfkkt4k1kYhuwjTqJm9S+XfQzghN4lcl2J
	zHzVIBgUdq/cT5wRU7UJlriRz45nbwMQ2QFV0fpDeGGxiPDlXwk580R7+0CzxtusfrIncIhWtvm
	qx2CC+GSDVmNmtdgwwLmSiU=
X-Received: by 2002:a17:90b:4983:b0:368:147b:536c with SMTP id
 98e67ed59e1d1-368f3d183femr373798a91.13.1778614729550; Tue, 12 May 2026
 12:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509003146.976844-1-andrii@kernel.org> <agD3xq2MUyskd7X-@krava>
 <20260512141431.a70375744fdae263bda5b722@kernel.org> <agNeEzjiThzmJHiP@krava> <CAADnVQLfgxEzpSTLhsxN2BYWpSxJ+RYku03UMfrSTi4Abu5SBw@mail.gmail.com>
In-Reply-To: <CAADnVQLfgxEzpSTLhsxN2BYWpSxJ+RYku03UMfrSTi4Abu5SBw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 May 2026 12:38:34 -0700
X-Gm-Features: AVHnY4KOZOgesKLsiEao1QlpFEyAIoutj7tuM-2Hyb1lGjbSX6Zp8KuwqBV9yV8
Message-ID: <CAEf4Bza4sqLw8GHoq+MFBgsnhiJ_s91UUrMcA-paYeBr7=bz0A@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5 optimization
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 12:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 12, 2026 at 10:07=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> >
> > +       /*
> > +        * We have nop10 (with first byte overwritten to int3),
> > +        * change it to:
> > +        *   lea 0x80(%rsp), %rsp
> > +        *   call tramp
> > +        *
> > +        * The first lea instruction skips the stack redzone so the cal=
l
> > +        * instruction can safely push return address on stack.
> > +        */
>
> typo: lea -128(%rsp), %rsp
>
> you can also do:
>
> add $-128, %rsp + call tramp =3D 4 + 5 =3D 9 bytes instead of 10.

When I asked AI about this it explained that add instruction modifies
flags, so it's not a good fit here. lea doesn't touch flags.

>
> Initially I didn't like this approach, since we just introduced
> usdt nop5 and now need to recompile everything again,
> but looking at the fix it's definitely simpler than alternatives
> and doesn't have annoying limitations.


yeah, limitations are annoying, especially with those global "DO NOT
OPTIMIZE" flags... Jiri, let's polish your version and land it?
