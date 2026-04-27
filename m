Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3DB35A3B9
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260252; cv=pass; b=eOeub3Bf35lpWcdT7KKhW5+uqard92US5p4c4Dzj2Sfe5LDzcD/IvxEH+kgRtyLjqyTCuRMNmHUoKg3yNVPLims57hAdj3O3zKAIcQj5TIIHvweNJ7Q+zGRuvuBD8rVZDrV3kZD9nDhuSFcHrAcHXorb+2rpY9mIEwJnyGzGZbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260252; c=relaxed/simple;
	bh=5scMGizBEZQ+MRt1lEr1zuH+6NL7GMmtobGuYdV0JtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpAFNuh0gxwG2w/mNo5zGnABaGWYwLtGkLxOKwuh0rtUToIkVHq4X+k8NLI0ElD9p8AhVzsCNEk4VdFk8zbGrcs4FFl1zU7AxSnAiAZRF+HOGnp6Z0r1oQnFaDrFBdarCSnkrs45baYHd992mulsCcU9rxYMF2iSkYbqbRzhww8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNefJAuf; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNefJAuf"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d6ab4476eso97090771cf.2
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 20:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777260249; cv=none;
        d=google.com; s=arc-20240605;
        b=H5YnSTItX3mm1kDt+8eMl1fuT/zGHQOnsKR30nBqBQcbS0teDDs3VCnZNNuMjHMiZw
         1T69AUd+pFyJLfqrkkczIWtwDTPQbUF+v4C5taz7ZT0wIjXn+/s08Lx2+GS6CSPk1wCu
         5iEapb/0mDEIaTbCi0aWmFt4LfbaKn3pPaEhFJ+Sfp6KKSS0r8boyJTUppyAeBttTu1O
         65cP3ln974DRql04DkRoD+VMQD+A9VkyS0L4PAIyjsc6lDahRFwY6vuNdZ8i4vGYrEoh
         f20tvumZBBgrQPQGZTj8GkkSgapSiS1gbv3C1i+ym5yr+1eEe//rh/ldqus/X2J9IX49
         I2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2zE68H0RpKyKb+UxxWIY0vid0AEaBVY0DBcP4n4sG7w=;
        fh=SDyEWDBkqtcegwcM+cFi1PDE7Aw838heHZkhOhNHIf8=;
        b=OKYVxxI8GJkPb32p1Kao3anFja/xqOITUrOMZlppgmjOqASnGM69V7zkNcfebw37xd
         KggBGY9kpY4nkU3sC/YrV/8jPAk97ItFL+i862ERdVRSokgTs0UmHotz+fFXSYXFqiOb
         G7sus8KMULm/HjwfYbsKm51RjYq8FQtQ1yiJc1TN3Zzwx+poAdBPheNny/1QmaqWh5/B
         OoypYIzYHxueiqOyHUNSeEtJ7ZviX+wIwOUEqj2wIc+LNhEHBSfidunMtvtK8Mi1Bf+3
         KjXKWYS0xrk/yEFgvSOONENPpFvcFYmie06Ns7T+OFvp7UPcRqW3i3K5C/uJ5a+F38Dt
         l1sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777260249; x=1777865049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zE68H0RpKyKb+UxxWIY0vid0AEaBVY0DBcP4n4sG7w=;
        b=ZNefJAufyWGznw27IG/u0F3FYcP8TsMm3USawUoCjfR5T+l1F/1NEkjhSgvVKwyg2/
         VfHTz63Ur+sU67l870IFMK2bB+eqc6pVLKYKhfMWV77p0Ts7Qzpzz8Kvelf9hfETnR7l
         847n6nL3AuQzLErajeLlQh9jyLgBXDy63+97Z8m/ZqBrv2phit/G9Y0eQCzlulhQ5vja
         QcoH6gprOgVLQlma6Jyewdgs2SOR27H24qLLbe7WQ54rthMRDjgQ3o4rf9HCZSXZvNJb
         wsQPBrvg9Gk3sSKAWddauav3oTTSCPJtBHR8hxGrCnjgRXam9Pt+BRdQQIyFZPloxPKO
         nXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777260249; x=1777865049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2zE68H0RpKyKb+UxxWIY0vid0AEaBVY0DBcP4n4sG7w=;
        b=lHvkvu5qZLU/YiJCOdQP/zg1264p6sQ7OBdam3CZ6Wmqi9C+tZXPovVV/plsj6hG8F
         MdYbTOq9Vl9zXiGItieQcWueIbAQUJwp01YLRuwZh4Recs+FwHBk7Lb24xsNH19rIV0k
         LpJM2jTStzRtNfNPHjomg6+z1STGrrhcvAHTShHU82IHWXTr+zOEUq6efZSAewaNL+nW
         /sAylV+AqmLN8dy0Ts6remjevH861bP5dFA5kEEquVYGY+aMMrcQCqjkJYbBLEjV7onn
         /abIeBdVMV3zY+9SJtB1VRootyI02rkhzPZgn/GcrpKCiKeISeo8vuCU6FmZLTNQdkm5
         I47g==
X-Forwarded-Encrypted: i=1; AFNElJ+qLt5sUUz0E8sCpis3Smc7lxPcZFXMLMPuG3+ju0al1e3bA/cIuZT2UpCfevWWBKQJBJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3xiVJvuXto17d73INmEnj4w0xDybtAhtzt5/11NRQM4ms+bnm
	ftaWHlF+7KyfHZ3VA61Z0/5xZ6sr3CeycQPw11jubIjSsDcCY4BTdcen2CgOtOnrSA5TOO5PQXR
	nlgDDFbuHR9enktZ5B8rMwRVdQeKgoZI=
X-Gm-Gg: AeBDieuwxCiEVZEUmWHja2NFyRjbLhgPFb0+f7uZfsS/GETfeNmgS9HdyuzygXyTAW9
	C5PTOWS6k36pX+NJIQ7qR2LgsOyNzL58YVQ1SIgza9yxBD5lW6N8gAEaCDACvOdkE2mM15FghEu
	F5i8kMgJFasvVWUDJoPBtEuCmQP2s6BmPPaGsuFb40hqGFVdmo636ifA4/8MuNiRoCPwmRszh93
	CQqJD/kg71BAKIbM3w0GAEUs2kbLpvxL36u7jxo6KH5uH19qOEGSTETP6g28a5qrT45YawQWO84
	EnJJUaCnvqLJ5oH1E5Y+Phe1Upwx9jqIsBTa399grTfchGJAIvzBCUV2E+Z6iA==
X-Received: by 2002:ac8:7e82:0:b0:50f:c15d:3f65 with SMTP id
 d75a77b69052e-50fc15d4453mr321942841cf.1.1777260248936; Sun, 26 Apr 2026
 20:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
In-Reply-To: <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 26 Apr 2026 23:23:56 -0400
X-Gm-Features: AVHnY4LNYufhxdoAmceUuZwiccpvrcrEMwYgU2MUvTWN4N_kz_NZl2ifuCum7P8
Message-ID: <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Song Liu <song@kernel.org>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrote:
> >
> > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> >
> > lsm_get_xattr_slot() claims a slot by writing to xattr_count, which BPF
> > programs cannot do: hook arguments are not directly writable from BPF.
> > To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> > value), and the verifier transparently rewrites each call into
> > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs and
> > xattr_count are extracted from the hook context, which the verifier
> > spills to the stack at program entry since R1 is clobbered during norma=
l
> > execution.
> >
> > A previous attempt [1] required a kmalloc string output protocol for
> > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> > provide xattrs for inode_init_security hook") [2], the xattr name is no
> > longer allocated; it is a static constant. We take advantage of this by
> > passing the name directly. Because we rely on the hook-specific ctx
> > layout, the kfunc is restricted to lsm/inode_init_security.
> >
> > Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-=
October/034878.html [1]
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D6bcdfd2cac55 [2]
> > Suggested-by: Song Liu <song@kernel.org>
> > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > ---
>
> The explanation and code make no sense to me. Why not pass xattrs and
> xattr_count directly as arguments, even if you choose to restrict the
> kfunc to a specific hook? Why does the verifier core need the hack to
> spill the context and extract the two arguments?
>

xattr_count is an output parameter; we cannot currently write to it in
bpf as there is no verifier support for writing to int *.  xattrs and
xattr_count can be fixed up by the verifier, so we only require the
user to pass the name and value.

> pw-bot: cr
>
> >  [...]
