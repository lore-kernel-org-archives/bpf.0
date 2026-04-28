Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F93AE18C
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374218; cv=none; b=GkfCD2cN/LOXli0H15aV9XP8pPDAb1e2R1YyBeMkDLRXpYulDMbaG7UqpDo7KxcRhEPBrspIS8YoXsypnWgoLZnr13HhgpLTG0aoM8t1EOOMrp8ls2+Ll4e9i3K/0rf/3rP/McGiiqJj+Qn06gj1shTDjb/H1QRiBEx0dGChwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374218; c=relaxed/simple;
	bh=nbBfiQy5OmG6fC0ydXJiDdbmzz1c29k9ixxOb2sNiRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svDGy98xVvkv96m19ZFp6R6Bv5/p5ZMtMKj5oQHkC9/YbeV9FyE8cZ4+M0fq/md+Ww3whe+0NNAgJ+M+fHDemSVv91bQzEyGxKPGRKyQWXvEbSEEx80utcggfBKWnWEXTHzn84KKcY1Rh1D/SC3l0i2T9yASq8+/su3fNSnyPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEfq8bWE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEfq8bWE"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8f9568e074so1857591666b.0
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 04:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777374214; x=1777979014; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jo4c4cmPyO4lyFt3dhTmNJgnSzf3xxWYEbZoxm7KBv4=;
        b=JEfq8bWEd24xmIJeNTpRwy8xdWMSMszxPX3CsEzrnv0cTV6uq0KhTpeKGFdTpwGcd5
         DSK7C2a6DQYuEVfPGdbBqlMk86p864HpgrF7ho9XsWDcmJ/lFlFXBu/WsXXag3+fGPbc
         DasVT0ixfRlTAi++0loaN9q5Lys0qI8BPMZlNaTwUzP7iMf0Z3kdUxx3yz8RH0z8G5cw
         L3fPCJyqEzZzhsStPibSHMi5D+UgZ8vsc8enZg4NfmQfYcGvSO63uR29L77lK0USrBpF
         o0s8sYD7VGUzWQBFUVATohH5PboZ1DJbsgXM+Nna1Jn1XdPEtu4AjU8oqPDGY1aip+/q
         ah6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374214; x=1777979014;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jo4c4cmPyO4lyFt3dhTmNJgnSzf3xxWYEbZoxm7KBv4=;
        b=RKQ4vGOEJfc0r4v0VfAvIMXEAfMPk7KZ1ocqSlq2pLHk04nxQm5oS2YlgG3/m8dY/x
         EiKk1r/dH+8WaIvgdEtQD6JRv9hG2mi+OYY0NB9m5Boxd32oFhiBIVMwR/zKTRDOKXEU
         N8uEZ1G1OrMCyXRjS2050nCkouaKMRlBN9tYqnKGrnjg4rT6EetS6hN7fGaWlAwPYoeE
         mae4AlwQMO81y36Ce/UDcl6G5D0MpFpOxyyXpiScz9c9W9drHhrkynDB3HRjTYveDFqc
         a8RVHkW+o13csiVKtr9YXNWyz4m4ilJBeXM6b8eLh/01yb4L77gs5RbnZFUbqf0ZOS4c
         SwAA==
X-Forwarded-Encrypted: i=1; AFNElJ89ZyOQjiEZ+X5T7L6XE6FGgP3MaSP+bRZAasXGEH8bagxxw8jfno7hEphsrlXfEdmH+7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9EerOTl3+6RmS2YN/l8/3cnU6FvOO9E5+k36Lk75YGqZvgJv9
	DKrZQnwv7KFdypBSIv/mxo2kBjzuTB7xoGm+l9RzkLRuAeSyG69u9C1pygWu50/B6A==
X-Gm-Gg: AeBDieuOYjYpCZk3cB3jvycteQCEfyti4wj4PXFFqt5g/FKBA+15hA7dfXHBwHF7496
	ivb1oWmKTScI2IUNmdjAXZy/XLnGtHPpEcyLilib1VjfgTeUYiYCG5DMpLS1fyAps1DVFKDhx1t
	VQgKVWlU/GOseGiIqDNMl5clp1oX3BBLCOEq/aU7P77ydvJlh8nyeP7o3/VHAd2+BPz0DbTJzP9
	Lmi0jvfWqvyB60AKRtUCFOzKBhAy5Il1z1duCl8Lt1nY2hxBzy15aWNDJmx1IB+Q3tV36Gl44Ud
	GBydL7eqM8/v6zyz+GFL0zM/jPzsqrO7cbH0hqolXNmtz7oNmaIAkujL1tDSYIb+L1H8dql/592
	+oVBchwXsq8yS9uJIx85fzNJWubBPuXSHFu9THXyakTJOC2eemWDP/4aLSOfssLKgoCCep2yvxa
	SgxvcLtMrasS1L97ncrsgxc7JTX6rG1mKiAFr94eQjHORHWLaS2T7yK5hHi7hNYO/BdmzkSl8H/
	EYipuOoZg28
X-Received: by 2002:a17:907:3e1e:b0:ba0:d58b:6045 with SMTP id a640c23a62f3a-bb803778202mr162273266b.27.1777374213640;
        Tue, 28 Apr 2026 04:03:33 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb808a35d85sm85472166b.17.2026.04.28.04.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:03:32 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:03:28 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>, David Windsor <dwindsor@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
Message-ID: <afCUADdbNrpbEPMa@google.com>
References: <20260427001602.38353-1-dwindsor@gmail.com>
 <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
 <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
 <ae82Vv0RWzcXqSaz@google.com>
 <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
 <CAP01T75SBw6NNvBKyPW11JSYY2oh449yoBsWi_GOBR5Kq1ykmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP01T75SBw6NNvBKyPW11JSYY2oh449yoBsWi_GOBR5Kq1ykmw@mail.gmail.com>

On Mon, Apr 27, 2026 at 04:33:18PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon, 27 Apr 2026 at 16:21, Song Liu <song@kernel.org> wrote:
> >
> > On Mon, Apr 27, 2026 at 11:11 AM Matt Bobrowski
> > <mattbobrowski@google.com> wrote:
n> > >
> > > On Mon, Apr 27, 2026 at 05:32:47AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> wrote:
> > > > >
> > > > > On Sun, Apr 26, 2026 at 10:57 PM Kumar Kartikeya Dwivedi
> > > > > <memxor@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrote:
> > > > > > >
> > > > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> > > > > > > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> > > > > > >
> > > > > > > lsm_get_xattr_slot() claims a slot by writing to xattr_count, which BPF
> > > > > > > programs cannot do: hook arguments are not directly writable from BPF.
> > > > > > > To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> > > > > > > value), and the verifier transparently rewrites each call into
> > > > > > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs and
> > > > > > > xattr_count are extracted from the hook context, which the verifier
> > > > > > > spills to the stack at program entry since R1 is clobbered during normal
> > > > > > > execution.
> > > > > > >
> > > > > > > A previous attempt [1] required a kmalloc string output protocol for
> > > > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> > > > > > > provide xattrs for inode_init_security hook") [2], the xattr name is no
> > > > > > > longer allocated; it is a static constant. We take advantage of this by
> > > > > > > passing the name directly. Because we rely on the hook-specific ctx
> > > > > > > layout, the kfunc is restricted to lsm/inode_init_security.
> > > > > > >
> > > > > > > Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
> > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
> > > > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > > > ---
> > > > > >
> > > > > > The explanation and code make no sense to me. Why not pass xattrs and
> > > > > > xattr_count directly as arguments, even if you choose to restrict the
> > > > > > kfunc to a specific hook? Why does the verifier core need the hack to
> > > > > > spill the context and extract the two arguments?
> > > > > >
> > > > >
> > > > > xattr_count is an output parameter; we cannot currently write to it in
> > > > > bpf as there is no verifier support for writing to int *.  xattrs and
> > > > > xattr_count can be fixed up by the verifier, so we only require the
> > > > > user to pass the name and value.
> > > >
> > > > Sure, but the kfunc can. Did you try passing them in directly?
> > > > If that doesn't work for some reason, we should fix it instead.
> > >
> > > Hm, perhaps this fixup approach might be the simplest in order to
> > > assure the needed safety?
> >
> > +1. I think this is the best approach I can think of.
> 
> We're not going to add more and more special cases to the verifier.
> The whole approach is unscalable.

Totally fair of you to push back here. I'm also agreement with you on
the fact that extending the BPF verifier with such special casing
doesn't scale all that well. 

> If the concern is that int xattr_count passed for xattrs can be
> unrelated int pointer obtained from elsewhere, can we pack the xattrs
> and xattr_count into a struct and pass it as an argument to the LSM?
> Then the pair struct can be passed in directly, ensuring both
> originate from the arguments passed to the LSM. That should eliminate
> concerns about either being out of sync if obtained from different
> sources.

This could work, but we'd also need to modify all the other
pre-existing hook implementations along with the core
security_inode_init_security() LSM hook itself. I don't think that'd
be an issue. The biggest hurdle here I think would be convincing the
LSM maintainers themselves.

> Even if we wanted to ensure argument provenance was stuff loaded from
> context, the right solution would be some kfunc flag that constraints
> the argument to be derived by following the ctx pointer, not whatever
> is done in this patch.

OK, so it is provenance-like tracking which you were initially kinda
alluding to here. Currently, I don't believe that PTR_TO_CTX is
preserved upon any subsequent R1 (ctx) dereferences, so we'd need to
think about how this type could be preserved such that we can enforce
this kinda constraint (__ctx) at the time which the new BPF kfunc is
called. Do you have any ideas on how to do this?
