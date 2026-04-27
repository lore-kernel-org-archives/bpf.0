Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817C4A07
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260807; cv=pass; b=AzlyEBbviltPf77zPPcStEPPpIbSXpYMfoWX6aJvv+rpf+uXUXKCP51XSCsjfqECKySJj4K0eHhYKbiN8df99pY0Ajg3f6qVJ/sxMJT8HE0VX4ABcy4IK8AUYrOOfKLdP0e3gZhZPP8cspRw27p09yqprYB7X2EzxGCjRH+bYvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260807; c=relaxed/simple;
	bh=FlRySTzL7yR9u6SjPj5k70NdbvHE2bc1gU3Eq2AkLA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZEPUwxX6MCeSlkNG4rz63wQ0nnO5W9xe+x0FJLgj7xj6cci3NreHxiRSqqrrCoP86Nn8oFI3KzzFGOaMRkZ5j1DtMBT5BAZh/mlzx43KNXvp5GpqDl7UHK8+UeyEqCWwasvAkL4M/0Rr7Sc8RTiCkGv9uOpxQ6cFaKCloG1kJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLEOZyKX; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLEOZyKX"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43fe608cb92so6562465f8f.2
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 20:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777260804; cv=none;
        d=google.com; s=arc-20240605;
        b=MymWkP/P/+FxNuCnEJ8ATQI7NiBq5iDc+/BJNVwlGDTycR0El++pjM6c0eMThguzPD
         Eb09tZwZC7Pmm5ad70QrAn/yMhJYmbyi3zr4TDkuzdB1yZ4scM+rxgcyUvBxPKNOr3Y4
         9hgkt/6rbdMzy7IvHbckjJg07gWC2LcHVKCH/5YVxSzaUcntgOayEYZjnEaRf4gx0Plj
         rYLPl1vJZaZqNtbvtDGzR4u/mmrFXirW8pJdWE9k7S0hPjKIi/0pd7B8lMsjAHCEJkJ4
         SZtquj0S6U1nZlxwaCIX4v5911+fsftSNUm4vOu/3USZZNumfVs9+ylxAveNyK/owOZc
         HVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FMeRQIgABI0rxTD3+7gFqkezgpUe1NFoTAQ8q5oe/AQ=;
        fh=1yPPmuowPJrQV4wNZxkYwKa67DogcC36pqIlSCD7XcE=;
        b=iWvfWbv6dHKWq8iykaT0jbwA5d+znogZJ+hM01nA2vHcmvXFwuXmISfNk9ht35gtP8
         DIduu7jQUrTvrJ1Ck9jnJz86I8si5ev8I4d+kvDWzX9wJqQ8d6QOCtHIv/bjmUT5QUdU
         L8/aKCDogGX34b547RiEw/YRfZRk9zcGcIOxZ0p7miU13USfQze4OgYQlgKlkzNrlrL2
         Qkf+8ZabQ0iUPwiwJDK7P1XeTeLJUgq2k4KH4lkoro6sW77AQsjOLiEeQXCquoOQgr/K
         rdGW+zmveHHjmx702vq7yBXElc+4QB8iFzqDgtAh72OnT1R7Guca2GDiBKjnsuNqtP68
         W5uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777260804; x=1777865604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMeRQIgABI0rxTD3+7gFqkezgpUe1NFoTAQ8q5oe/AQ=;
        b=mLEOZyKXnYS+/AXRTj6N1BZ0VGl4Ed/G7TH285S63iUPgPatg3vhCvbz0aN7hxLud0
         Ma7q4vzRFUKNk6su9OsN/BPXTaFyyYUL4Gy5KTgHSS5efyg10XtBkgh6nlbjyuwm2M6r
         Dv0boad/PpGbwRO+nqBaYXv+JxiMdWuGgGh2/TFP4lgkS+yz0zEzM2MAHRs1dito9ilE
         8LPgcOpGWijtUyQJM1XCdZVMc+g3+Spv0jMaYBJyYduMrIsFCNnmaet9QGX3tntsK+Bq
         xJ7qUX/WaYAKexaR92dbqjoMwr99FHKuzsL2dPyhzAw19gB+gUOWnbEIRRniA53D3U4K
         qFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777260804; x=1777865604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FMeRQIgABI0rxTD3+7gFqkezgpUe1NFoTAQ8q5oe/AQ=;
        b=MOXHGPZVLela0BqzNRkUhYH9nNfJqxD8yksHN9N2WyjSZ3au7A9iCwsLHa+T2tS4NA
         bLMFi4jtlNg851PJltRPKeOdhFd6NG4eb93wnezj/Aeve8dal33G6NT4Gd7diZBZHqhv
         Kw5kzt9vGIIRQE2TZ+XJOoAXk73hrqlCRQhghfBaNdHrxHKH33ERJHeP0Lyhfopm4yVi
         pwaIvIkNGh+9wf7YMw88hC+r4Bt0GyxXvH2S7FScwH8IBB7kDgpLFEEst+6Lr+3VsYK3
         /fX8KOKkVwo0ZaQ8sGwwpJI9T3onE0QWGfoNxTuZsjEcCtDvDecapjfoz5h4BOB2sdHn
         ElMw==
X-Forwarded-Encrypted: i=1; AFNElJ98EeYt6Stnu8Gi5f6ZLcE1EL4hMGe0zukmSMuYl3by60Bcgp5apEzPP2K/bZLQ75CPWsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkumslzbaKvon8jRAC9bhoy3Ov+02nrP9HJD3VRto8qaaZ+ysy
	pwYHPdHe0g+x7Apud4QWWAOJBJVc8btCkwQsRiR00i1Zb6vFIBOBH0xbREBTPS9K3ZCmV+WHBf/
	WrJkBzWey4qlVFC1GktqC7SzkQQHqosY=
X-Gm-Gg: AeBDievICfF9PtGcoFwm9ou8njVxi+R8gyYNbIq27CC7pQpxmNzPP36DGqiOztviq4v
	3uSVdI+ynzCX+Wi8JpKwI2Kgxt5HOlvOii+A9HRs0a3etDJKdDCG3Ub5soPKIV/1ZZa1isTOg3n
	vumKGFdE86CVOEYb0cKlKSopAQdpVOLOzGIQIIBlKvC9v2lbpjM5tye64h3kXQ2ywpuH+yxaSOv
	SSwdBg42DX4bZuuVBZhGd0/0bqtPxbYYYuaWnwZP+Qs1Dktho2UuVYi5qmQAsQZAwe9hnF0heKJ
	w9E/gahY9qWq6CjFK1U6x7bd00uWKvy2iYdj0uM62DFhw3dULW5rYBOGPl5iaP4Ueo6erjWRAqO
	cX99TFoheqBcter2uCh6M4Gdu6UQe/xlVDoHmt4fhGAFGoh9UkuWnnWI6QedAYgqFYSR5
X-Received: by 2002:a05:6000:40ca:b0:43d:70de:1c62 with SMTP id
 ffacd0b85a97d-43fe3e120c6mr64592007f8f.45.1777260803470; Sun, 26 Apr 2026
 20:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com> <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
In-Reply-To: <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 27 Apr 2026 05:32:47 +0200
X-Gm-Features: AVHnY4IWx2cxeZrRnlqhjZ1wcwst3yduTrI_1755npZU2JYycYn4il-T3V10fRY
Message-ID: <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
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

On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> wrote:
>
> On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrote:
> > >
> > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically s=
et
> > > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> > >
> > > lsm_get_xattr_slot() claims a slot by writing to xattr_count, which B=
PF
> > > programs cannot do: hook arguments are not directly writable from BPF=
.
> > > To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> > > value), and the verifier transparently rewrites each call into
> > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs a=
nd
> > > xattr_count are extracted from the hook context, which the verifier
> > > spills to the stack at program entry since R1 is clobbered during nor=
mal
> > > execution.
> > >
> > > A previous attempt [1] required a kmalloc string output protocol for
> > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs =
to
> > > provide xattrs for inode_init_security hook") [2], the xattr name is =
no
> > > longer allocated; it is a static constant. We take advantage of this =
by
> > > passing the name directly. Because we rely on the hook-specific ctx
> > > layout, the kfunc is restricted to lsm/inode_init_security.
> > >
> > > Link: https://kernsec.org/pipermail/linux-security-module-archive/202=
2-October/034878.html [1]
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D6bcdfd2cac55 [2]
> > > Suggested-by: Song Liu <song@kernel.org>
> > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > ---
> >
> > The explanation and code make no sense to me. Why not pass xattrs and
> > xattr_count directly as arguments, even if you choose to restrict the
> > kfunc to a specific hook? Why does the verifier core need the hack to
> > spill the context and extract the two arguments?
> >
>
> xattr_count is an output parameter; we cannot currently write to it in
> bpf as there is no verifier support for writing to int *.  xattrs and
> xattr_count can be fixed up by the verifier, so we only require the
> user to pass the name and value.

Sure, but the kfunc can. Did you try passing them in directly?
If that doesn't work for some reason, we should fix it instead.

>
> > pw-bot: cr
> >
> > >  [...]
