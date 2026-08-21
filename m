Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C6364E89
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340923; cv=pass; b=mUksS/RmZjyJoT5IMXyvRnQ6ZgRPiAUgQw2K/gOjI3DUJy1+L/+8saaXAqos5FSNu84yHisTytUpwp+h8QvjYFB48NFneTZhb6sw8RSfiVxUHjB74YcEFmxktROrOWBQDYBLvL7+Pu7v+9vM2Y4wbhlmuDO4j/gu8nGgFd7oNOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340923; c=relaxed/simple;
	bh=PQPCf6Bs5NaG8E8LJnNzTtqooomT9tfOhJ3y7X6kSOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4IYqRmNhMc4fp+K44FHarK8u+kdAtqn/oTd3DjtZSVsDuVw9oh8QuBk9h937BkXY/tM7ejOT2jggu/qekqGqYKf/7bXikO8ZSF8VoQUCGg+DCHxoghdS0exfsO79OdbQu2juTOLFBQ/7iG74woIe0nhtRo9Z6JvvtoJCcYHwMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2EchImh; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2EchImh"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8518d5ddaabso1062180b3a.2
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 12:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787340922; cv=none;
        d=google.com; s=arc-20260327;
        b=d2S/uJtTkp5rzDy6XUu653vr9jPwFzNXof38iRcuL6s4yknC9iWgdeNecWKcGtx6RO
         LIxSqwgjF4C6U6gp+y4nwmPQqQq1eFZ/PjTNIuH4oZNw2UZHwaNb3OXK+8aMpblAg74b
         kAo1bgOUb+JEUT2g/l2pz0endp++UgujVMe05lO2IlVskmb63hVPYTGRvstQ4Nw+vHqf
         pE5T72HGuf6ae9mwBuSkepP16tt2whMS0Di2mTaWccPrMz1Qu9hZQpDbsUV7lH6/oMj7
         FsaiUTJPdfuDD8wJwKM/2PTWItp1VhgF/7HBRnmxwbJpVQWhfL9qmsHNQ+tP6jeTTk+H
         8SOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QI7IADVH6ooVfN2xCQn04L1X4G0AYXhHXQ+WEpDAZP8=;
        fh=Hvc26XbtTaDnVaZ7PQITkRgocO2YOJ7GbBpcGCtRl0E=;
        b=Nsbb0U/qsb9D03ie6tnFKGUTvjkh75KPaPnSHL9WE2Dg2Cdn96UoIB3nkygNl7fIR4
         zS8yWivYSm8nWMsuXPLQwiba0D9ETQn5QlQodNvjbgfYtqXSCFHWg7H9+/Ip/9uKuR3O
         DjYmktdaEtzq3BMp1bOMADlCounT5tY0ksnwZs4dyIhjMXwVJ5ud/VKbQ4z12vyEWclP
         TvFNKDCugWDsOCzWVjpYpl6h0IradEj9Usa23xgFdgm1auUxtpS0namcgHKTkUj7eCaM
         X2IzIkAuCSRFe1Lw8MFrP/wC3gYYsPa22vLuknCtCIEb/NZ51UYy0G/v/aSXz1+3k1ha
         dEDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787340922; x=1787945722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QI7IADVH6ooVfN2xCQn04L1X4G0AYXhHXQ+WEpDAZP8=;
        b=E2EchImhCI0kpzRLM8vrO7j9tKwz3vt/KpDPnExBljgvSawTA6VGtziVPv5Xec9N97
         XlskSz9wJt9f3Y+rbEGIltsavfB056Y5jf0mzPizGpWxu0odRcpS5vpQHzWO8gcHRlkM
         kSYLiWioCLFie5/iHGNmH3YtMgjQYimdGeVrgdB7BtmMCKsdGVQwn+qkbxu+WRAfaDG7
         v1vWX5ipNiBWnj6G2Etw3AuZmfS9ViVF/4iA0XizIotd0XGFk21e1HQ4wIHLSId9wEwZ
         DbPch7WrTXifXQgJ6DYbnUCrYZeiyZgYBO86uOePgSSN7V4+l00wB9SKh1obZm73xouQ
         q0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787340922; x=1787945722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QI7IADVH6ooVfN2xCQn04L1X4G0AYXhHXQ+WEpDAZP8=;
        b=F2r4C1wZFUEOBqgrnoanL/tDXMFK/K/MhloMmW4/9flccS66L2xAbLvOamKvP7DnEv
         d6v05s6fOyVXbO0pvBJgTDG78SKo7ydfXTcpVk5XjvnR2A/Gsw2/MQrMoLgvxakeNFZP
         KgSluD7FVIf2L5nHR8w0I0VgBDzcZvsyMnh3kNn34wIZF+YCAuqsHwNB3+k0XJ5h+IKs
         L7Fuc44uWXMKWG93zzQH3xEN3jdJISUPqKq8tmTeExKED2uJVcnRgEsqXlflC7Hq3j1n
         gSXS8NuLyXLMWD6ND/f48L28+4v+5GHK7wy8zBXvtx3y7oSG9O8f6ew51ssLA2DT6rAo
         kV1A==
X-Forwarded-Encrypted: i=1; AHgh+Rq83+18RBgFs8LLoeo8/3ogVd0rDpfmcCSaqFp66PV8K2K4Q9aelyoijDRM0cwomv5Oh44=@vger.kernel.org
X-Gm-Message-State: AFuF++lJjOJ2GNMEKz50phzp3rVU2uJPJ/iBi6kdlDBYEzc01EuRj25x
	tuJDtQprO05RBdDWX7+f9lRe/DEMa0paogQRglSqCnBca+HnGJx28pAC+SzPFXRBS1vdlS7THj6
	zNjr7wBCtQIbily2yK6qqLdVQMjQuaJU=
X-Gm-Gg: AR+sD10PulgV9GnbmAE9HyMGslRoY9s+9SIeTCLczBaA/4cFRrXxEVZnckeggsRmnc/
	3zyHh+sUDjDNWUvLsbWnqbXJWubaiwMhryMIh0w8WlZqGphtidkmo8Dxb5NT+GeV4sTzTwpp/ro
	FC5dkAfUuJZheDeyQCJ6HgQncdVOBUSraIfnqrNvAsp5sh78qfNFsPeNWYQLj1WkYgpEBqIKpn3
	UT1AJjMt2K4KgC27PIneJQ/1wNB8N5DarPzM9VAJANVg92hdHzibdOuIQuzu8T/zLtE8+SG35v8
	mqfUSuPzGXxrrw0BfFxs1Oq76TlkCI0Xxd7hzpMmi3hF/2YaqAA1EYd7eKEa1Fatq8hjtxr/2Hk
	yWYK/zXoc7+UyBDlvYl366lOb1A==
X-Received: by 2002:a05:6a20:244b:b0:3cb:8280:71f8 with SMTP id
 adf61e73a8af0-3cd301e87f3mr15425646637.18.1787340921537; Fri, 21 Aug 2026
 12:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com> <b380f7e7-2e0e-4c8c-9a70-e6a577d268cf@linux.dev>
In-Reply-To: <b380f7e7-2e0e-4c8c-9a70-e6a577d268cf@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 12:35:09 -0700
X-Gm-Features: AcwNN1WwzN1M4QIDgIarQ8tYafGHimYBYXfqbKkcLCkZn93yiCH_7G53n_7XRIM
Message-ID: <CAEf4BzYM+b4E5S6ZCDcpEaw2uvdNPDVUdTgxUxkvCdM86DkubQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Fix stack out-of-bounds write in cgroup
 link update
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Pu Lehui <pulehui@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 3:26=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 21/8/26 16:47, Sanghyun Park wrote:
> > The cgroup link update path checks only the program type. Several cgrou=
p
> > hooks share a type while using different runtime contexts or verifier
> > contracts. A UDP6 sock_addr program can therefore replace a UDP4 progra=
m
> > and write beyond the four-byte ipc.addr context into adjacent fields of
> > the stack-local struct ipcm_cookie. The same omission lets an LSM_MAC
> > program replace an LSM_CGROUP program despite the incompatible return
> > semantics.

Patch subject "bpf: Fix stack out-of-bounds write in cgroup link
update" is absolutely out-of-sync with the contents of the patch, can
you please update it to reflect what's going on in a more direct way?

> >
> > Validate replacement programs against the link attach type. Use the
> > existing per-type rules where applicable, and compare LSM
> > expected_attach_type explicitly because both flavors share
> > BPF_PROG_TYPE_LSM. Preserve legacy non-enforcing CGROUP_SKB
> > ingress/egress updates.
> >
> > CGROUP_SKB programs do not require CAP_NET_ADMIN when loaded. That
> > permission is checked when the program is attached. Once the link exist=
s,
> > updates are controlled through its FD, so BPF_LINK_UPDATE does not chec=
k
> > CAP_NET_ADMIN again. Keep this behavior and only validate the attach ty=
pe
> > during link update.
>
> Any issue of checking CAP_NET_ADMIN for BPF_LINK_UPDATE?
>
> If no, checking CAP_NET_ADMIN for BPF_LINK_UPDATE looks okay.
>

Why do we need extra capability checks during LINK_UPDATE if we
already performed the check during LINK_CREATE? If you pass link fd to
some process that doesn't have CAP_NET_ADMIN, but has link fd and
another validated prog fd, they should be able to update the
underlying program without extra checks, IMO.

pw-bot: cr

> >
> > Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active=
 bpf_cgroup_link")
> > Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
> > ---
> > v3:
> >   - Factor the CGROUP_SKB CAP_NET_ADMIN check into an attach-only helpe=
r.
> > v2: https://lore.kernel.org/r/20260818061021.2551771-2-sanghyun.park.cn=
u@gmail.com
> >   - Extend validation from cgroup sock_addr programs to all cgroup prog=
ram
> >     types, including exact LSM attach flavors.
> >   - Preserve legacy CGROUP_SKB ingress/egress replacement compatibility=
.
> >   - Keep the CGROUP_SKB CAP_NET_ADMIN check on attach, not link update.
> > v1: https://lore.kernel.org/r/20260805052858.2390918-3-sanghyun.park.cn=
u@gmail.com
> > ---
> >  kernel/bpf/syscall.c | 41 ++++++++++++++++++++++++++++++++---------
> >  1 file changed, 32 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 6874ba1424af05..dfea337ff25ea5 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -4483,12 +4483,6 @@ static int bpf_prog_attach_check_attach_type(con=
st struct bpf_prog *prog,
> >       case BPF_PROG_TYPE_SK_LOOKUP:
> +       case BPF_PROG_TYPE_LSM:
>
> Add a 'case' here instead of checking it in link_update()?
>
> And, a selftest is needed to verify the issue and the fix.
>
> Thanks,
> Leon
>
> >               return attach_type =3D=3D prog->expected_attach_type ? 0 =
: -EINVAL;
> > [...]
