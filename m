Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06EE330678
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394039; cv=pass; b=Lcqkbc0zvYRf9u8305C7rti9NEwFgklAoQwwzBwOLNlQFncTZE612h7A+oixB1ytRFIci/23VGPMgaxGnZZXGATKRtiuvh27p6ReGZW5cnYovrE3PhnDEqH1Rij3qfBHyqDE0efxKNGPxPTjucz3s0+11mXzI3Vu7IAVAo6Ezf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394039; c=relaxed/simple;
	bh=52MdagQnrh3ZadMCj+Aj5TQ5SCuB+VKPYF2izc01Hgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8dSZzPNjteQXhyzv9DmvOUY0gu6ab1y45X8pZK+h7tRdB5+A3Mp2/KjMTzp9HQO+ZOX5gAqgxzfI1OnjB+2vB+XF5jz5krHU2PBqEJ6W193V+Q9BO2Wf8Q9V3VgpE8WABhFvpv/uf2YWpPqtcVNNNEfgl7ZhFs5l/OaoAMj1h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOq5rH3q; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOq5rH3q"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48909558b3aso116658515e9.0
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 09:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777394036; cv=none;
        d=google.com; s=arc-20240605;
        b=K0Y+IAdMUAas7jiLMliY8OFMEDOX2a2YXOts5OHIioL9Ew7dBxxPssRf+NXu2ZjOIa
         99wkTfAAmX8iwBrXuzrysr7iI+CQw9tUyNzrj5gmWA3+JtAkswpElwASDwVCVVvnOsEG
         2raS/6VCUPVGxSQwatlZUPGGDJPlxfpflJtUsNwqcvATIgwxtMb3XcP7TT+gEIGxgYN5
         xWxWArKnyqliOfuIQnypzO9l+2OzJ+VRoSapkopxyzTnhIkrL94o1PzoRC33X64dfZqQ
         En0DHiV53lFWchlrGw3xZ0EjcdE3evcvL/ndmyQlXGVqWvAFyFtCxC/f8hPFftv1Wj1N
         lMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H4tL94f/+zrQ9tmGfQ35+hzuIQymZx/bUR4W9C2f3sk=;
        fh=o/4bPWkr4zU7RQSKTV+kxdTca914vOsgprRpec2EvAg=;
        b=Hl+STqaDFtq+smPIeR4V7K8yV2xJBVjQ7eOGSrlsLhaN2lZMYQcg5qTnw6etQ7Mhzf
         8xJko1Sr6I+6thmfXwTjkJJgM6hEzKI2oH9fE4EbA7Q1Xne+/Sp+JE+6jZ82y+/j6A0B
         F0o3JE2TqBCaamxJC9NhZ2MJinnrAbVOU0pKlDmSirBfgHaE+K7SulErcqbKVvNrCksu
         MtcB6d7YE3wAKIQuO2Y7Q5RXiEGnAmvokPexVJVtBCuUaUt80198DPqooX4g7kgcSh8D
         eyWeIEFpBFtVnnQ0fH/B1POw4mgee71XvJz7Dsk8FbzC54eCsQLwwVq0tPbUdD3SWITc
         tM+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777394036; x=1777998836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4tL94f/+zrQ9tmGfQ35+hzuIQymZx/bUR4W9C2f3sk=;
        b=gOq5rH3q1hO6smyOz5GzqsPvxPNLDz3e/MlvRz5dyyg0/MnMIvzOWGlOBynkUz6bQB
         l/Oi6SUp1x+0mOtg7NTulQSbwDWDik7w/N4axau/LqIf9ZdF7JeWdEX7v4r26ewv4z3e
         fX7xTBb/NjxY2OdM9axpZruwB2LphvNJOwDJOcDUvympYS4DrBJbv0fXzsvJYbPC4Y+h
         n5grZAEZeYcHy326JARFl4XHpajn2scsSbcTzYR1E1jC6I/mdZMKrYtukmwZhize6Y0R
         csIqvJZCB6+vRcboClVSHD9IyGs+6KOBRDdE+Ay/2h+oJ6KxhDjW3pDzfMak6C31RPoX
         v9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777394036; x=1777998836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H4tL94f/+zrQ9tmGfQ35+hzuIQymZx/bUR4W9C2f3sk=;
        b=TaGtc9jpzQIZbvETJUYQi8DG4QXHDe7wFba7pq6tcacBNma3P6pKjXptZ43jcSvz8K
         Up9Btl96INLFJjtbursdzuqXB3EvycL7t7ndsO8b2zJjMcOOj0is0Qtnq6DwUOtTnMrF
         aVuWixoWm2cWOlPw3sXhG8Hcixln+mZnD3UQgTja8Yxd2zPWTEElmYEqWTwx2lsh4fVP
         5Ez09k/JRzVyxCnhjWzeSAtaRBCGJyaN1Rj8cfwGe+twSDcxgygHTLeCUXNwENXjblWh
         VSqe+43EkQYE3ZxFJkmFcDEkLCna0J+dsQ28SWlRIhhY4MWzLYVP5Dv0A6pICMUWqVgL
         4FjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gqDoQrOzZRZ9a7M+BYvrEewsUpMSMs/zDb0FNzO2DaO23iiJ7NHi40x5dZe3NXAvQatc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4DMsHhy3AJ8BcpMpyH+socaisAvEEf7KwmnWH07ju14qkRL7
	NYMXfiapprqLwrZVa++lUmy8bJ8xbCBIxGNizaeWjzHNEExLNySN1ocKDG26K9tLcTpdoipsg/S
	EQG7bnrXcSJsWGjfQNXpnmGWugmK1Zkc=
X-Gm-Gg: AeBDieuRB8JEoKzhH4DiHJBX4yRs+vngQwkfZdFp3tsUfFEn9NiC0p9Q3pywYHZvaBN
	i1iv0RHDDh68zWU3umNxVfE6etI37SGT39b0i4NtJYfGWB1ur14qte2TOalOVXcxDufYPHv/TAk
	AnifO5fLkWG7ECgDEApim2uVFgUcjUXCrsltxTbwiw2rRmZLRuO2FV//j3pCgYln5+E8T+qFf/3
	z1FuuevF8LHut4388c3vj12c/FXz7cury9MN3KaNS+pPgH6qEDjNEPIt8lqxkTNZXNOVFIrNGBt
	X0mrjl0LkLrTsBALgiTHtluSsiC+2sUQt5SnJRA0upcBUTuz4P0KIwPIQw+FkSFZ31Yf2AR2VKy
	8F8bdxZr4K72hvLDUfXlt4MS8+IfgNWqVv5WPqRWy2h5e1NFxqhFK6glReHkvSXvODBsw
X-Received: by 2002:a05:6000:2905:b0:43f:e94a:e777 with SMTP id
 ffacd0b85a97d-4464a070b10mr6490623f8f.37.1777394036183; Tue, 28 Apr 2026
 09:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
 <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
 <ae82Vv0RWzcXqSaz@google.com> <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
 <CAP01T75SBw6NNvBKyPW11JSYY2oh449yoBsWi_GOBR5Kq1ykmw@mail.gmail.com> <afCUADdbNrpbEPMa@google.com>
In-Reply-To: <afCUADdbNrpbEPMa@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 28 Apr 2026 18:33:18 +0200
X-Gm-Features: AVHnY4I9zeiNlmD4AyDEKEpxt8mFMp29ig53d2G_1svR9xHiMr5JdVGll07goQM
Message-ID: <CAP01T76ipTgY3EM8uMSXymdO4co3AWZeXqwV3amqDnHiFXhrTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Song Liu <song@kernel.org>, David Windsor <dwindsor@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Apr 2026 at 13:03, Matt Bobrowski <mattbobrowski@google.com> wro=
te:
>
> On Mon, Apr 27, 2026 at 04:33:18PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 27 Apr 2026 at 16:21, Song Liu <song@kernel.org> wrote:
> > >
> > > On Mon, Apr 27, 2026 at 11:11=E2=80=AFAM Matt Bobrowski
> > > <mattbobrowski@google.com> wrote:
> n> > >
> > > > On Mon, Apr 27, 2026 at 05:32:47AM +0200, Kumar Kartikeya Dwivedi w=
rote:
> > > > > On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> =
wrote:
> > > > > >
> > > > > > On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwived=
i
> > > > > > <memxor@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.c=
om> wrote:
> > > > > > > >
> > > > > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to at=
omically set
> > > > > > > > xattrs via inode_init_security hook using lsm_get_xattr_slo=
t().
> > > > > > > >
> > > > > > > > lsm_get_xattr_slot() claims a slot by writing to xattr_coun=
t, which BPF
> > > > > > > > programs cannot do: hook arguments are not directly writabl=
e from BPF.
> > > > > > > > To hide this, the BPF-facing API is just bpf_init_inode_xat=
tr(name,
> > > > > > > > value), and the verifier transparently rewrites each call i=
nto
> > > > > > > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value)=
. xattrs and
> > > > > > > > xattr_count are extracted from the hook context, which the =
verifier
> > > > > > > > spills to the stack at program entry since R1 is clobbered =
during normal
> > > > > > > > execution.
> > > > > > > >
> > > > > > > > A previous attempt [1] required a kmalloc string output pro=
tocol for
> > > > > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow=
 all LSMs to
> > > > > > > > provide xattrs for inode_init_security hook") [2], the xatt=
r name is no
> > > > > > > > longer allocated; it is a static constant. We take advantag=
e of this by
> > > > > > > > passing the name directly. Because we rely on the hook-spec=
ific ctx
> > > > > > > > layout, the kfunc is restricted to lsm/inode_init_security.
> > > > > > > >
> > > > > > > > Link: https://kernsec.org/pipermail/linux-security-module-a=
rchive/2022-October/034878.html [1]
> > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torva=
lds/linux.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > > > > ---
> > > > > > >
> > > > > > > The explanation and code make no sense to me. Why not pass xa=
ttrs and
> > > > > > > xattr_count directly as arguments, even if you choose to rest=
rict the
> > > > > > > kfunc to a specific hook? Why does the verifier core need the=
 hack to
> > > > > > > spill the context and extract the two arguments?
> > > > > > >
> > > > > >
> > > > > > xattr_count is an output parameter; we cannot currently write t=
o it in
> > > > > > bpf as there is no verifier support for writing to int *.  xatt=
rs and
> > > > > > xattr_count can be fixed up by the verifier, so we only require=
 the
> > > > > > user to pass the name and value.
> > > > >
> > > > > Sure, but the kfunc can. Did you try passing them in directly?
> > > > > If that doesn't work for some reason, we should fix it instead.
> > > >
> > > > Hm, perhaps this fixup approach might be the simplest in order to
> > > > assure the needed safety?
> > >
> > > +1. I think this is the best approach I can think of.
> >
> > We're not going to add more and more special cases to the verifier.
> > The whole approach is unscalable.
>
> Totally fair of you to push back here. I'm also agreement with you on
> the fact that extending the BPF verifier with such special casing
> doesn't scale all that well.
>
> > If the concern is that int xattr_count passed for xattrs can be
> > unrelated int pointer obtained from elsewhere, can we pack the xattrs
> > and xattr_count into a struct and pass it as an argument to the LSM?
> > Then the pair struct can be passed in directly, ensuring both
> > originate from the arguments passed to the LSM. That should eliminate
> > concerns about either being out of sync if obtained from different
> > sources.
>
> This could work, but we'd also need to modify all the other
> pre-existing hook implementations along with the core
> security_inode_init_security() LSM hook itself. I don't think that'd
> be an issue. The biggest hurdle here I think would be convincing the
> LSM maintainers themselves.

Yeah, when these parameters were introduced, we changed all LSMs, so I
don't see why we cannot adjust things again to benefit this use case.

>
> > Even if we wanted to ensure argument provenance was stuff loaded from
> > context, the right solution would be some kfunc flag that constraints
> > the argument to be derived by following the ctx pointer, not whatever
> > is done in this patch.
>
> OK, so it is provenance-like tracking which you were initially kinda
> alluding to here. Currently, I don't believe that PTR_TO_CTX is
> preserved upon any subsequent R1 (ctx) dereferences, so we'd need to
> think about how this type could be preserved such that we can enforce
> this kinda constraint (__ctx) at the time which the new BPF kfunc is
> called. Do you have any ideas on how to do this?

I think we'll have to track in the register whether the PTR_TO_BTF_ID
came from a PTR_TO_CTX load. That said, I still prefer changing the
prototype to pack the array and its output size parameter together. It
is even clearer to have a well named type than int *xattr_count in the
prototype.
