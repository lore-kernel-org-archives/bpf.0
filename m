Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795463738;
	b=QHJ3rvfqKCIH9/NmD6aNfRtTWczWtZiCk5SONuXB2M5DdBdL4E7VAmUEKhUAYhrWVCsz
	 5UbmAeh0WdicQQh1POW37NJah7lUr0HhqVwa1OcoI6KS7ATjanVyK0AYXPt9f436Z2gIU
	 BmQJi4xOiwz+yqMiS5Bu/2PeW/z0W8lYB7/3q7UBooU0s7eMhDKRzCBpB0nKxQdvxD9Es
	 Wsd2sYqSdBt6eRQhqn/UJqkWLGuscLQHO6IIhRfXyvzvHi1DJA9d+wcFJ5B2p6StDE36d
	 fJOX3+YhtC8OHWDg0FImPPRXPB7mFycm6PCzHV0fNCFqHG2ptOdvNx49/D6nuw1SYJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Gd5vkS8rekRzrNw14AZBHfRH+N9fBKRzF69D+TwAlOc=;
	b=aphAbaktb/4kmtTdiVgMcK5xQ35jLzX/ud3z5SwiaZz8FFE/fZPN9sjFREoSsDzJRpZ0
	 RCSn44cWq8l+Rm18QEtLjNNx7ZwoHPFc7vLNzikY7UWeBa7207Fyd4PciRRMDpr2M9h4j
	 CpMwzFnQ1qW3HY8dn3gpreitnkbK+eC/6pmqfjGIfHEHYkqqoRl+1EP9KoZY6HPrVxGuX
	 bifURARzzflXB78dxpcIIigVP+1q8J9hBg2ph+sNK6/QKnq4MyqMVJP8HQk/hl12fHxrE
	 pEhALm/rOghRJbUahZ3vdivhz2Te2HudhOKZWseO8lZ7rVKORfn2ctjm99wy8Dhyd8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=klX4BZ2S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE0606A31F
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 19:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61AE0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=klX4BZ2S
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso1737334f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 11:55:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795463737; cv=none;
        d=google.com; s=arc-20260327;
        b=Z0ILfgWB3WtfYXK8ca/MhRWdKx5G3oL4yb4XHbjezuJDNJfRDHAbrFSiVMGLhTd79t
         DOf13Xd3bRgp8xWv+hqjsfiBxxsFc9nD8UOlrhVDxAWwB8qSoLC6RL78B2w8ULPOzblZ
         NAypj6aEKr4pY9Jecar4cAxAl/siTxGCQC/pO4GianiS3fDnQJJLuvQqrOYrcPzQ9pz+
         UlPKZxeK7EGxRausm8tQlfcUO84errWNdX6OGkJeVCiwbbbMVD5CMePGk6OlUMK7gXxg
         tdgODvizKk3wdZ1UYlonAkbMuqFg27Jv3wjjyuyUqMUSRVR5pVGbBCN1WNXOMLYfluJO
         Bdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gd5vkS8rekRzrNw14AZBHfRH+N9fBKRzF69D+TwAlOc=;
        fh=1OXVCQc27ypUHKFiuwmZexxZIppHFZUI6P3i9XG6NEA=;
        b=HRHuEPpuUUAmQTWo6Lk4+vjGf3GleICFBOAQao7mRhZQ/HZoRISLJ+ReauXMC8eb6M
         Vvfp4wbMW+bbDG/4gwnN+arTpPLy5vupsDIvSGOyKKdDS+wLFL56VPc2vKB6nRc/eMk5
         9cJd9MLiPbhkhjm4yil7vk/T1Htz4TT01Xc3BCk2TEhiG0vzfcBwafrItMWl8OvQOJuY
         Ckp4C1Y6UOfZYz9f/kHiXSINQmtXgKu7ZYXLvVhS93nXd+VgzFvtC+N7pk2r8wgS6zDc
         Z2BZgbPnVXxIqDJyY/wAHMnPuikK3KX1vYGy5MHlX8XlbER0GZYLOtKCdIp//Mqnz0dy
         QdWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795463737; x=1796068537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gd5vkS8rekRzrNw14AZBHfRH+N9fBKRzF69D+TwAlOc=;
        b=klX4BZ2SJNTMSrywDGSIV/16noC15wpAvjoBOkCL6VprZy61rDcD9QTHuztfR9Tuzg
         ya2nK4c06Oxw/VjQ01rYZooWGjRYhIlcehQDLDYYHAihJcTUhaX+DcZEH7BVZC7b8DdI
         3VE9xpA6SNF0jRhObUVsSkdyTgO/dD9XZSshAODtcgr/63eyBQDMfk2w21S/AWnlOAmx
         C6Nxy8ygfimfdk7a67J7QXglsWVIVZ87KpZL0j3iWCA02hOY1H6mCULb6CwOnFGgqsaJ
         Z1GsKqUmNaVZa85kFWwKTasKVepJYI+oWjQPr8BOLjrBomj0HKFEKJN0TbNA9qYZJyZo
         rGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463737; x=1796068537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gd5vkS8rekRzrNw14AZBHfRH+N9fBKRzF69D+TwAlOc=;
        b=jfEyn8baMVqonGVEutDyH5EbVUfnxcjxwjOmQwNx/LjZOoZY/MhZ/fvBImYWgA/9G5
         oD7WphFQga2Vs3DAxmTQCZIjBTavADdNaNHXg4wO3b6HUTQTSBARtv0DBLQLLppUoRiH
         MtMbHo3F4IgUO/iQWS8vaSGCiLVw31wTp5fjrICy3vqtYhZZ/XVzFXVsTWix3cyjiZNe
         qYjtKJ4EDEQVoARKM2mhPQ3tV3nEOhNfxlBT9U+6OUKjCMfsYeaxuxS/aIdVwceqHo7U
         dVuLC8UwYX0bLIK7K7fB6CscVQWpGMERlyjPOONGzlQCl15ylLRGsok4sLKZGKRsEtbC
         G/XA==
X-Forwarded-Encrypted: i=1; AL+hErF26gC/Pt7eBaGILs9eF7qZxxBz3DP8MR41iDIMs4cHE+f6H7kAo3eHlBCD+HnCt4t5a4A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rpmY+KC0ELmyvWmDM23jL2+9CnoG5BdpAP5wxlZp7J9F1rFB/
	kZgp21NTano2N6S1DsAgzBkWaMwkh7Sv8KMMZgBNlcpJGreroaFCfzVQ4g76zVilgpgnUzoZt10
	ZeJgK5j0anNRSo1YfDRk+b0YBHdgRJAE=
X-Gm-Gg: AZFdTZe5u9Xl1cLQXR6BTvkppcRRINjNU94C4zghfjZX0UetOrOaw6777Cncvns/Owm
	E2BC3uNBEsH6VoWvRc8LJ7nl6FBAp44vCLXWW07XOOW4hRR2EfZ0+59NTJPSkDj0o6VIgcxnxAw
	vU/3GIgSPJzODzL98BmccDOIuAjMNJWEVfAKhAX4jwbJJG+XKpu9oFHrZA025nzUSDI21ey+fjZ
	kKew4zGQmpD8ACzS90UhFbyTGE2J9p/Rd5HKcNXtX8ksL5Gs6m/ejtlG7FPLKCDpsOQ7XkAxV0b
	ItbVDvV82Ijnh7U+sExBWUAuZaAnet+z5C6HPCuq+Cz6CpryHFAha4DFcU9F7zFqEjWexqzt1N8
	u9BJMZcySl315hKCCPwc/1wHFQ3P36vVELjb7rR9wXnEF1FZX+uLmmEDMTl04snUyThoaUNgC8n
	Fh8wosV83z60WUjF7XOMg7EndExXusxN1gyg==
X-Received: by 2002:a05:6000:29d2:b0:4aa:831a:d0eb with SMTP id
 ffacd0b85a97d-4abb3c37a50mr16976489f8f.9.1795463736432; Mon, 23 Nov 2026
 11:55:36 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
 <CAPa8sAh6b5xn4rZzPfM0nZ+_kkywWj22fy8deLq+6qYews0rdQ@mail.gmail.com>
 <MRYP264MB7057096D13282544720793F2E67A2@MRYP264MB7057.FRAP264.PROD.OUTLOOK.COM>
 <CAEf4BzZWEU24+ZC0W_20hc3t+qnEHncQA1ztTF7ZPPOf3DDPVA@mail.gmail.com> <CAHC9VhSFvOiP5Tyt=rOFMwg=Ro1jRw+hfcw4AdCkEyftZJHQCQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSFvOiP5Tyt=rOFMwg=Ro1jRw+hfcw4AdCkEyftZJHQCQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Nov 2026 11:55:24 -0800
X-Gm-Features: Aa3M54rW4zsDQnYRhxM3Ycfdbtgyp7iJNkovd2OcGLgGuI-HlydZfB9BSFPhl3s
Message-ID: <CAEf4BzZqjiWR4EzBFdV-czH-GnxqOeOAsMLgXtQ6TwN2ZiiT8w@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Paul Moore <paul@paul-moore.com>
Cc: Paul Mabileau <paul.mabileau@harfanglab.fr>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Daan De Meyer <daan@amutable.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, roblabla <linux@roblab.la>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 11:37=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Nov 19, 2026 at 12:59=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Nov 18, 2026 at 7:14=E2=80=AFAM Paul Mabileau
> > <paul.mabileau@harfanglab.fr> wrote:
> > >
> > > Hello,
> > >
> > > On our end, we also have already merged code to adapt our eBPFs to th=
e argument order change. However, we would still prefer if this easily-avoi=
dable breakage could be fixed by moving the argument to the end, even if it=
 means having to revert our fix.
> > >
> > > This is motivated by the fact that such a change is not made in place=
 on our end because we ship our software to environments we don't control, =
meaning that any and potentially all versions ranging from 4.11 to the very=
 latest should be supported, so the change is made by compiling and shippin=
g a new variant of the concerned eBPFs for the version interval it is valid=
 for (7.4+ in this case). And that has to be done every time there is an up=
stream change like this, so the total installation size and overall complex=
ity grows accordingly.
> > >
> > > If we could avoid that, especially for such trivial root causes, it w=
ould be nice.
> > >
> >
> > I agree, and that's why I'm asking Paul to accept the patch reordering
> > the newly added argument before 7.4 final is released.
> >
> > I do not think that the maintainer's personal preference for argument
> > ordering beats real user pain.
>
> As stated several times in the past, the problem lies not with the LSM
> framework but with the lack of an abstraction layer in the BPF LSM
> providing a stable API.  As far as I can tell the lack of an

I think the problem lies neither in the LSM framework itself nor in
the BPF LSM in particular. Neither have any abstractions built on top
of LSM hook prototypes to guard against argument reshuffling. And
that's fine and basically inevitable. If you change LSM hook
prototype, you'd need to adjust source code of all LSM frameworks
relying on that LSM hook (which is easy for in-tree source code, of
course). For BPF LSM, if argument is added at the end, that pain can
be avoided completely.

> abstraction layer in the BPF LSM is by design, and while that does
> provide some advantages, one of the notable disadvantages is that the
> API is unstable.  If you want to be upset at anyone, direct your
> frustrations towards the design and current implementation of the BPF
> LSM.

What upsets me is that your personal grudges against BPF community
(or, perhaps, just particular members of it, doesn't matter) gets in
the way of doing the right thing as a maintainer and putting Linux
users' pain above your personal preferences and/or dislikes. And
hiding this behind "I like this specific order of arguments" or "BPF
LSM should have better architecture" is just petty.

>
> --
> paul-moore.com
