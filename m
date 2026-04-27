Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248DD35F192
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261385; cv=pass; b=avceN6mizl5FL3LFQvvKe3QnGpRZyFgt3g6pOnKZ8lWQQm1pdV3XuosR92je4qUjBswHO3gKSASW2a8SkDt1gGGKKZsOHXKsdXGTUDEohld0R9J8oJocgM+S8M5CUPTJInd9urmmzIcffijOjHV5d13yd72koyvWVM7LHbAqdlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261385; c=relaxed/simple;
	bh=t7jMQTzH4WvNAPNg0QKfjgjMMI8uJxMDy8LRPrdEgV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiKjdqRyUxYHbk0G39yBn9GCRhXHRRzXFQiG3fE8qlhOJ7Z40WNbusUD9fNezauk33S8edRLGx1k8N8fchZdCGc8XsV/eiy3AGvOVOngh3YZBkHCZeFw6kARc1linFjPiDHa+aLx54f29UFCQmbubv8vEyGadoTXHCVG29vJUTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv56Ns0H; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv56Ns0H"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a58057d7baso116733086d6.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 20:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777261383; cv=none;
        d=google.com; s=arc-20240605;
        b=VN/5dKc0r48StQemkUD+9hEFHCbMf4pD815IfisL/O166lcxNF5/RF/RbJbtVwx1DM
         HzzE4IWha6hAsgchxUSuBlxP18e7AKBen5QDj5S7ZjMzOZ7rlpf/Y/zOQ2tSoDGWKLpy
         6zBnlcuZkHO/00pzSVxCg6rs9ISWIGRWLyQ2aMnzE1OPMQa7NrpgMqpuZS8csY3Ve1lu
         XVzOIkSlronArt3pVNAwOVrZTs/3EET8YHgCrY+0uJOEhs2Guxa9hpQkjfIhy0XDm7UR
         oDb5WLf3q6gN/f8wFQx5BJnkNfe96iJHN8XVDoIHuRDnXhRnkzmC+Xyu1b/xnwnrFeXc
         ThpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i1wsozKYAd1yUpII51kKd/OUBtsrEEmUo4ZxLHwLHGM=;
        fh=RB864j86E9dIbySnc1mRpfKdCtTq1ganxmxAHIMP55o=;
        b=N1OPi3zePeie0MY0wMA2Ec8ilD0E/VQ88ydZSxN38uiRdFogS7+eSUyFXxHW1ZBsqv
         nowFv5NYhm6/An4PkT0kO+/hWMNravAZvl/dSYoWDEGLve/ASuz+2T19DKRq7SO2vOk2
         ZlK/WNm3EBJiq0vHvvzCNXvvDnt9Rv55Kz760aV94eVQoFuI19J0xxrcBvZjOSCOps3J
         3jMZUZtjman3+ZGu7Nq9IzKvbuzPL840wICJCZmIJMbLZ9Pybw+hwEdekWwOA6JyueyR
         rxwYi7s6XDn+gfT8JmPkxBrX1MrlyquV1+PEwV9ZAkuDuz6KPSWGdZpBFbcNMyZ4WSte
         TtnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777261383; x=1777866183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1wsozKYAd1yUpII51kKd/OUBtsrEEmUo4ZxLHwLHGM=;
        b=kv56Ns0H56/PH3riSf5jXuV/d617/NZ4LBdT7ZKMAIuKsf8cjWvmX1wD84IZvxKa4H
         vcPOHfGrU70eLXMzJId0Zy8Wp5YSQbFqFE9VbPYcxeJesHpsPRSwufZJyddSaT+w39T5
         S6Mw+Tr++2zjfs+9gkizI712Uis5FqqRZ3vOEW9UbxE8eZYAykYWP12v409iv4PH4KxH
         hi2LBR5FmZjD1DhiJXvh1qr+un+DtMDRqm05vaGJ9I1SXBdrYEPNsjVYVmz/FpktiXCv
         J0z6aqPzqxzXsvbFlIMm7YF3CqU1K0TztLam1lv6SvqqqdcNtcZeqLDzrZEjTdUWJU7i
         xUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777261383; x=1777866183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1wsozKYAd1yUpII51kKd/OUBtsrEEmUo4ZxLHwLHGM=;
        b=h/W8VhF46IOwppuQ3L5uUcaLFWmE9WazOYkJgj99fH1vGpV82msiKMJMiIvi8SYCmU
         RR5jhtWBcEi+KsegBwoy2pq+Bbzihq9lI8nMOCI3a3xzYAI6FvC7yjwAuh3dr+9www2k
         98jp59UOsLzK4Zxv5zzgaTr1F4fWA9O2uIjOYEQRh6JNxz8T+5G4Yti3QEMppQ02uaeV
         Cq6b8lnDchtufzAELvX/+bUuID160EOr1FC73mIsqraztWN2Rdh3L0gh8jx4uJ+00zvp
         lj2GEDgioxFLFru5Pp2+9Z/uZ1A5pPVPjs96c/cR24aayLtmX5IIzuiEa1Y3l9PWcX2w
         O36w==
X-Forwarded-Encrypted: i=1; AFNElJ/PtG0DkpD+c41Fe19U9D8jDNjMOkly54AKXTRjPWKpfL00JvpYH5qEVkh04QKPNw0z9as=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4A05LOfqwNZYld5hasBufW2ws/fT5W1sqlHHOll6X7FA2sg1P
	AeNbYNhFgLCN/0NeIdgdZmV18lBsn/0Yt4dzklr4Nf2+V9suPiT/6arMvouMkGJXkuCwtH+c9ZH
	TsTMmGKrm2HrebpRuNL9FM4q6lZSTRP8=
X-Gm-Gg: AeBDieuTSOFXmiw+MIDotbjicPNV3pd4hHOVsTeBzwoDYn3EKCoT9EDURy08kuf5jED
	mMG4DO4tJVm3as88otCTx58L1m8tFwyGz2fGepaWP/P0Z3mnOVWTXJj8YpbhUWYlHhfDczk54ht
	YuqqZrmfSQ3stGAM6k9QRiAk8ufsJTO1RwH8y97DiiAX2dbiqLvbabmTIqkZamPQEmorqPHxCnt
	OtdwuKlhv4gxLRyBq0nIwMH4h/WbPAN/BRtGFelMalnqS0alolQTN4FiUFrQ1abNHxdfLiKMMaC
	LwgulIBQc1gF7co9Os7awxTJ1NqCT3GulJKbsf1e4wl+0ICRON1wx4Sp6CH7kQ==
X-Received: by 2002:a05:6214:588e:b0:8ac:a48a:a586 with SMTP id
 6a1803df08f44-8b02803f167mr647114386d6.14.1777261382999; Sun, 26 Apr 2026
 20:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com> <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
In-Reply-To: <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 26 Apr 2026 23:42:52 -0400
X-Gm-Features: AVHnY4Lv_udS1YjhPNVYhT9R-oIUIcO_YCQ6gEoTqdWddJ4UBJuMugcb2-0tXIc
Message-ID: <CAEXv5_geng=0cNdC99b_p=9GV65wv73npAWBtooVRzXN5xVhnQ@mail.gmail.com>
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

On Sun, Apr 26, 2026 at 11:33=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> wrote:
> >
> > On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrot=
e:
> > > >
> > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically=
 set
> > > > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> > > >
> > > > lsm_get_xattr_slot() claims a slot by writing to xattr_count, which=
 BPF
> > > > programs cannot do: hook arguments are not directly writable from B=
PF.
> > > > To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> > > > value), and the verifier transparently rewrites each call into
> > > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs=
 and
> > > > xattr_count are extracted from the hook context, which the verifier
> > > > spills to the stack at program entry since R1 is clobbered during n=
ormal
> > > > execution.
> > > >
> > > > A previous attempt [1] required a kmalloc string output protocol fo=
r
> > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSM=
s to
> > > > provide xattrs for inode_init_security hook") [2], the xattr name i=
s no
> > > > longer allocated; it is a static constant. We take advantage of thi=
s by
> > > > passing the name directly. Because we rely on the hook-specific ctx
> > > > layout, the kfunc is restricted to lsm/inode_init_security.
> > > >
> > > > Link: https://kernsec.org/pipermail/linux-security-module-archive/2=
022-October/034878.html [1]
> > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > Suggested-by: Song Liu <song@kernel.org>
> > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > ---
> > >
> > > The explanation and code make no sense to me. Why not pass xattrs and
> > > xattr_count directly as arguments, even if you choose to restrict the
> > > kfunc to a specific hook? Why does the verifier core need the hack to
> > > spill the context and extract the two arguments?
> > >
> >
> > xattr_count is an output parameter; we cannot currently write to it in
> > bpf as there is no verifier support for writing to int *.  xattrs and
> > xattr_count can be fixed up by the verifier, so we only require the
> > user to pass the name and value.
>
> Sure, but the kfunc can. Did you try passing them in directly?
> If that doesn't work for some reason, we should fix it instead.
>

Aha yes, I did try that and I believe the verifier rejected it because
btf_ctx_access converts the pointer to a scalar. Will confirm the
exact error tomorrow.

> >
> > > pw-bot: cr
> > >
> > > >  [...]
