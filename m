Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F61395DAA
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187334; cv=pass; b=XhGVu31mevNbxYycnn3uVhO5JMxlYv/3VnZ2XEn9y2d7Ujb1VyCpqwcJemPjOjnWEue0Tg4zH1xW+b/62KnPffdvQExsS9rbrnAO9lQ8J/O8snfjkZ/qYRUb4I5N5UBt80zkPOfPAmzbR92vOVRsImEuOqbF7lbcXZ3ULyx+SKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187334; c=relaxed/simple;
	bh=F0wTGQkkGlxpSFeNyjD6eaC/VlWEy1Nj2KPYSgkBaLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opIBfsnnzAmGJ2cUPMR7H26K0psyW+5GkMM1lR53Wf/fNQqH98QAeVOL+ZTz/60yUsxIcCwjfJ7toq1gFIasBgz+ERwtIr2dgVMPTtZilhwxOBW1ZPNaq74vPim693M30SAEM+FtfSHxBs+K/+H9h4s+I1AGG/bUqcHLCvGOIo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvfEHe85; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvfEHe85"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9159477c893so602281785a.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 21:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782187328; cv=none;
        d=google.com; s=arc-20240605;
        b=X53lAWL4DGJLUPQf3byqJI4npGYTioM29GtLNHjiVDBZuZv4FyC/LBJ78JdXqL5fFK
         YcQyYBHqTUDy/Mgt/g9jRNd8G3DGUovZMlthLmTwX2zQExA+mPODK57k9Nxr9p4vb6ww
         hqlFvNTEhNRhBx3o7+P7BGyUWHt97ikWYo5EulnxNuMxovUq+KaX+5Lx7J3+jRpjc6u4
         O679Elohj5hkgZKMJ8VG9LiKIqMOyCjo7o+GqRQJzpJE1R+MlU+VXPkM50tYXa7Ov0J1
         QnE45uoyFESqxDs9YIJ2zncgY2cJ/3NNzO/NJndDSCSo1uRZwmC69ylwzn6QvgvelIqS
         65DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        fh=kvzkgJ5wM2O8ou2hasNREXIP1cT57FjLylQJxNPuTj0=;
        b=dx5j0ilCnLgMPNfW+dptEF7PhBIs2lxirflw1y9OiAtYRaBP/Ws9hIq7ukWpqOdJQj
         SRhcjORtSGL4m0ByyKexNyWwWUBO7ckZWRRFqpbAXAnqNYX3lsPsFwSstKSXnhcIpegG
         mjMgVMr1zxk4l3pdv5b/95Prml8vXwezdvwCpe1ojRHBErY4iYYI6bZw+mChKbbJxZQI
         LwnZIvreCb4OISjiB0npQMknlysD4AQ5ozl6TscbgVZuSFE6ZE9MN2uX6wPOd9Exwunc
         CLZXP2ZioNlviWG2Zr/LEnx85JMyzDIyk7+EpK0qaLYLhvx21LQjtMf1m/XGeAG4RG+V
         lMug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782187328; x=1782792128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        b=kvfEHe85g9lUYBp4b+HBBNOtnEXPs2FhHtjfbueg3OXE/2zsiVDDCk5Sf2KOR1lxib
         zIoQxQiskpChFQyo21WNgATlA1ZTx/GP/aSDvLer8bGK1k/DXX2aghlwkYqQv2pFkyFz
         oked1raJu7gLr0qxR3h80MSU/LFbvjxaK41XdPy0f5iGOahOso5D6brjklO00daNIfq1
         gIxALTWLg3bznUVXFcT2ZVDOgIwpidNjrhE9Sc+zhNk1C8e6f6KiwIxKTskiB6kpTBMK
         w1nNx8ay0Yr5pDD5SIS7zDfDIGIW66P2uO5D9Xu05DDJK12HXpSTUlR+6N1r5JyQ9KZc
         sUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187328; x=1782792128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eW8+mqrmr6N7CBulx1m18TzlUYk2VeJ10g5AWzjPQEQ=;
        b=scGoF/1fLXSf65LkAbvArg3FtdiaNHIBTRJaUSmO/6F+vIMj1y7hStbMPjd9z1d+ZI
         nkGc608Lu3q+8zzLpV7hVrt6KvrGEHt5FNZaaMCJm5sk8H8FO516uAcxxR03oehmZcDh
         ANHKYCN9UhfTMKuJnqB9hKI2VH9VbiDH5QtQVG0u3wHnfUlajst5COOAwO7EC1w/2BdE
         df85ZfaSIHsY3l4UxqHXKb5mEBNBw65aJUSIq0nnLGfNmkuUniUjnyIL5ZyiLe8xpgId
         bZr57zrj5CQsLxZ/Mhp5+Wvgkp25Ie3hWD05k72DZNOvMQoEqCdF3DRABM2gmstW1CxQ
         vboA==
X-Forwarded-Encrypted: i=1; AFNElJ//RdlulWONUsCUzINc36qVTT3QwMUE6vdrYoBf+dKsAk+Bmt9NvQw3AG5Zvj30g/DT3qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2FxOIev4gI1njAgPEAL7VvuA5aXiEC6pvBVNh9pmPQuojB50j
	8vgrav6pQGXS4d8NESHfg5GS/SyIF5kkuaccqZGm6ThqFDvVqu1XtssTYEhOxOYb+ImStWXqT4m
	EVc27HdtdgSwJplEPxpp4HutiQ7Mm72g=
X-Gm-Gg: AfdE7cnh5DR6VNpfHUXA22qP//nlKArEbJcaGy67GQOvY0sm6ATBX6SGmby4CJNeGhV
	rmUq5bua5ME3cS/ZAnSVkJMyVImDoYFnEiiJTBUiCTkLTa2jc1uh/mfd++wG6z4VB/qzbYAjzcc
	ck1Xolm75pj0vFBm8OuTATJmmd2Y5B75yJL5L2ys+bN2girp8G2k+d9A0oVDBmgs+FS4Rq50plm
	FqWSMyzUUThQ5hNksRcBmNdcyWNikWjFY1SLbWO5NHE8VyClwFNd2/rfG31h/VTP51BUP0rsEVv
	Up/2SU1JWojfiYeFv59+PMqfarSX9e6HqKPGIw==
X-Received: by 2002:a05:620a:4808:b0:915:e9c3:f1a0 with SMTP id
 af79cd13be357-9208f05c232mr2733502085a.12.1782187328229; Mon, 22 Jun 2026
 21:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com> <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
 <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
In-Reply-To: <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 23 Jun 2026 00:01:56 -0400
X-Gm-Features: AVVi8CdBJDCEtsjZ6Cr-k5RWu5qRO4rCaGhk6aOZoAtNJHl7U-y4zrw2gKO9F3E
Message-ID: <CAEXv5_jTxeTRdWpv71=6k_VTN4ZCes30xPs746Frw96fShfe4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>, selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 11:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> >
> > > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > > index 1a721fc4bef5..b41b02173e24 100644
> > > > --- a/kernel/bpf/trampoline.c
> > > > +++ b/kernel/bpf/trampoline.c
> > > > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_t=
rampoline *tr,
> > > >       }
> > > >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> > > >               return -E2BIG;
> > > > +     if (node->link->prog->aux->attach_limit &&
> > > > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_li=
mit)
> > > > +             return -E2BIG;
> > >
> > > No need. The check inside kfunc is enough.
> > >
> >
> > Paul wanted this check because it occurs at bpf prog attach time,
> > whereas the one in the kfunc is at inode creation time.
>
> Sorry, we're not adding redundant code to the verifier.

Thanks, will send v4 soon.
