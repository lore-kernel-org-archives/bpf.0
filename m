Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5942DFFF
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309818; cv=pass; b=uWXpuZnt1jTwQhLpDQpU/DGbdGj/QP1Un/BuXvvCK4hAe0HoNMpcX0LrPL+8zuzccL83LN85WWVB0OmtlRYLf7vXCcNVbwoLj10nIasH2bDVNe5xnRh2FRf5nZufVGu87kzr+/bk7ZyLF60kfDoYuhzFPoHtC+h6emrVVuYN1eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309818; c=relaxed/simple;
	bh=gTr98O/DYzbyUlRuEsGi1UGtuGUdlDO/0L6WtpJZlQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrqGis3prkbUE4fbDHwkcEoK6pogBS5wULnNViMCqgI+slOwmikuiTTsdrwxZff1D3BB74S5aYQp1TXfk4gWF+iU/gB7WFOLneW+RGbeUTgPg+1ZXGMPzw012MK7nLKCmHiM1KftjXKST+w+HFMeX6JriNWyPc/QCQw2p+PFMY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keRh4j1A; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keRh4j1A"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359a16a400so1250530f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 08:43:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770309817; cv=none;
        d=google.com; s=arc-20240605;
        b=EXAQVvDAj8pEXllPWmF6jrQ62Z2IJPXGqs8U5Wc7AexX80aKzMFMcapiO1AimWfwh4
         IjeYBCgg1Ro+dUZ1kci5MSIjOZ0UFOWQpryMbAv3W5rfeIKUntpE0JxK6p5nYQgPfcdh
         ePr1yPCECWut5yNKx1JKPil8srDz3PgZ/2oSAX424iqIXFxfVmGYZ3nm75BM55XmqzpI
         7VUfI9k/8lKVpySpEZ5ZgwvY5TkYZyT703LXfumTrYzTOXBpy4SACxctgJiIK0SwhT+3
         PyJo3YZ2pWllGdwJ3PzXEqIf+uZhx3eS0f5GWCMchw9dydCeXw+oBMX3ffisi+bD1glY
         /qtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UgbA8L5X3UGyVPXB+Do1ZNMkWOmroS+AR1xUyGD8l3Y=;
        fh=M6o0nxtam/45a1Xu6gS4IFM6OTs+iyxFFD9Omc2qecg=;
        b=H5thXOk53GOIs73uCZgnNMesP00YMPWdj2fgKDM4Z2Np+v9w65sFpsjpLL33HUTAMc
         r0HmDc60VMY2UbQjrtP19wcC1BYTsBK28XyU9e8xTF93Gk8PR/AGI45jJz4Z63B19AKh
         2SQC1uF5gZvv24n5sur1wWqtER7AWye4zd75MMlzZIZWFQ6JgnnbFNue5njYT4NwUqgA
         gSL9Nzt0gbIaWEIiF/Fjd69MrwGTxm8+MTEoTVg2//pfcWKoLi2sGhR2aeqbqoDS04Fh
         PeNGXLhEJg4AN/vx3LMvz7UU+FAPDsqKZ1bpFy0LWUIlnrcCpK6fCvEBcwP/CkE/db67
         IUlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770309817; x=1770914617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgbA8L5X3UGyVPXB+Do1ZNMkWOmroS+AR1xUyGD8l3Y=;
        b=keRh4j1A/2sSPssu0N5iEK85lBjEnmPpr4qnUXVP+jpQ5uIHwwstNGXKeTSY0LO0ec
         lt4r2dTZt9wf97oHVg51WybBVbaPvv1cxcIOThZH1vNH09ubsEXirX8Y6Irjgb2b9+TG
         Igz7ffSUGte9ifDtjnjyhn9C0D82Tbs1/CfDE9o09R/8EXypB9tnspiyayj0hrqqjIQG
         XiPp+qdcrt0/EPADXkPV8yW8EGeh3quuzKxaHRisQUAkXvZ0J26jxk+48DsyFSaoa8xs
         kXNjLQpQlT5pdc4qSEEotZJ0dXZ4mb6l+ei3NhcO6sdowDNLeUV5JzKHNEqNw+cPuRr3
         NF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770309817; x=1770914617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UgbA8L5X3UGyVPXB+Do1ZNMkWOmroS+AR1xUyGD8l3Y=;
        b=L9pPaJmfmEkvuLItEeQAJpzRx1S9NGeB+vzrug/zKOW94N4nxkeXv783++ZklWV4Rn
         FWRvoVbPnfOSZZ98qVF0iBOu51HG2uaJnwVTeSU8zZix6iAV0TU/zmg95WUXM6Lg1J0D
         s+6ClaEfCtgdHix3ZzcTDccC3acsjbnRbZMBJonQoJt6cHWmH129EtGICgDu/kd/itNj
         Buv37TJNe+7F7jcTUMi/MEBh/8p62FrIdPxP5DEBa9j5rIdSBSc/jxtpCQaUe9xb7dln
         WNJiliZN7mXgw1Sce7etCCKg6hP3Y5Ud9vljA92OWXV7zyhlan7I78C6DyB8AG/sMCd7
         N3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCW0aB20tIFr0/Ywvs7LOm2EZZHodSrEa0qdH10rtw2UKkAp3plwsiENJ1Jq5isrGHCz7nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBHJ4IYX2hkZ5Eaw29Bgb1PQtmHxXE2G+UMJyV4l4qC5CIbMmD
	IgBBCUKDy9G/QCjVIC/ZoqAiIrsGn4dVSLOkWWQaxQMO99MwOuESIuUobRbW1sH3fEIN4HIAMiH
	Bei1eHNa94uN6ygCjcc8T8/RkITm9UKo=
X-Gm-Gg: AZuq6aJT6L/T6UlOpohMdrT47f7WrBVcx1TmJ/0qVRrokA/fM8z9eFrgsiBxe/D20XC
	+CU2elXQ1GPkLx9Qwjr/YEBfUa8CTG2ubObCLL62ap4A2gZwX5mZiBUOKn5gzvr/4WFicesHN6q
	EUmEOplk38WsMRWYw9M5vx+tdpY7/eWLQ2g4wu37QTyJsL8Fqozw5GM45PzHvJMzhNIDOR8Rcml
	AIyi9AkFaDaojV+CqAj+f5+TmQf6ISKPybOLaQo5QFqqdQ8Af7HK9kut4kUPIz08m9RLuwViNZ6
	KUokfhhHI6+CZGebEezneaCbWg7sz3bfcx9MSXMLeSzJ7sm96XhI1AQhQlM8HK7eOJVk24UHnO1
	BqXCH1ww=
X-Received: by 2002:a5d:64e9:0:b0:430:fc0f:8fb3 with SMTP id
 ffacd0b85a97d-4361805108amr11435730f8f.38.1770309816579; Thu, 05 Feb 2026
 08:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
 <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com>
In-Reply-To: <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 08:43:25 -0800
X-Gm-Features: AZwV_Qjb6S-iktO4Dnfz_v9yb534efgmChlpNeMneF3ap-F0hPrqSmgKQJpJcKA
Message-ID: <CAADnVQJqL0FUKZ5Vo4thH1Xk-O6d4BSO2M6kPNRZP0V=opEMNg@mail.gmail.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	aleksandr.mikhalitsyn@futurfusion.io, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 3:27=E2=80=AFAM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
> >
> > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > index 005ea3a2c..c350857b2 100644
> >
> > [ ... ]
> >
> > > @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type =3D =
{
> > >       .init_fs_context =3D bpf_init_fs_context,
> > >       .parameters     =3D bpf_fs_parameters,
> > >       .kill_sb        =3D bpf_kill_super,
> > > -     .fs_flags       =3D FS_USERNS_MOUNT,
> > > +     .fs_flags       =3D FS_USERNS_DELEGATABLE,
> > >  };
> >
> > FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the ker=
nel
> > tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is defi=
ned
> > (at line 2268), not FS_USERNS_DELEGATABLE.
> >
> > The commit message states this flag was "recently introduced", but it i=
s not
> > present in this codebase. Will this cause a build failure due to an und=
efined
> > identifier?
>
> Yeah, this should be applied on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dv=
fs-7.0.misc&id=3D269c46e936f3b5f2b6b567ca124d5f5ea07a371c
> in vfs/vfs-7.0.misc I think.

I think it's better to go via bpf-next this after the merge window
to make sure it goes through full CI run with AI review, etc.
