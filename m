Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525E04457D4
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513795; cv=pass; b=Sgy2ygYgSbI6dC1+LuyND9DlJBlZpaS9mRyeeiNHB14+JgYyK+bXcK/DShmbshNvy/AwysTe3eyy+WpVNsZuZnqCxBGITQ/HU4kO8egI8M9kUQxD4dO0OqeqetIf9FDpaL8bNXmijbmsMgXuFHg2PXJdbCdxlO+B87zNEiJINxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513795; c=relaxed/simple;
	bh=n+9aQXVCyI5+nq4dxhlKhYIzN+km1UKy1fzyENReD5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bobTIHXbBtDaADKQEpYcSUuk5Ut+Mb4npIExUEY/ilbuzoCmxVGIEQSuOD7Llb4tuNyPPri46FQipnTn4rlR+S/aMGagrtBGaZZeD2Iv0ArBkSA5xTT93da5wgRjyfF+HqaxhjvpQhvTC1jxf17C5TxnPb6xvZCds9sLL9HROUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a0OcVIF1; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a0OcVIF1"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8484f229529so1056706b3a.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 09:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785513793; cv=none;
        d=google.com; s=arc-20260327;
        b=l390enQSKYTbKu8vpw3QUczhM7nTV2WlolnkJlpboJEB9d3rmc43FkHbDK1NlePz32
         CIbS6U94L0r+PJvj0GJl8GrEsBaLOeluT/y0J2CCBWzASnE3lRReXzeLgDWhsgZY9gEH
         JhkzUBWV3FWlojmVGBV+7NI1Ma3V+HlLy7SvEhn6SmZj3xJR/9DqomE8klz1f5+yKK4K
         NEyNpdf/QkjZeU95YhSeRSSsXSRoU7CdKyo+BarctE8AWlFbtXF6ubyKRGHS0EbHdu0m
         4xlif3jWu6ak1N/Zg6UIrLrVyFXKz3JAjbnfXnzVEpoWWyj09MIRluOk9J2s0AbIPFkN
         dfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CFI/kEWUQrMOVwbdW9xBPQDb5xYR+l3PWasJ1nDKXvg=;
        fh=q5kEYTG9kec92VBBhCu/f90eIb49foWu73FhbO5HY08=;
        b=nGChP/RwJin3oiZCzlNqUuripwX3VXe1CcxHeNaU3PVUwgzYKXjjNL39zftgi8HD24
         hqsmbYahgAyKjmgkDKFROuW5uhPpNrzRzPKh1n2YoilSKdw3sb6kdiLuXrXtrBw0PWg0
         +lxBHb0u26fLXpRnz5s5cqTCFZWwC+lWHQlq3dIF6iM8WhA4BLW57WrD/mv/PTFuueUv
         95zt5MmH9OnB4hVeFpqL66lnZpwzLeoBw3Kh2233Mt8t5/NK+WY8bMIjbWS2ch7nS2rG
         7efQkJXJy+3L8zc27CuhkET1gyQeKFvetAUwteFik3CSh4pvXQiAA8cDVkqb6rl2zfqE
         JYBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785513793; x=1786118593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CFI/kEWUQrMOVwbdW9xBPQDb5xYR+l3PWasJ1nDKXvg=;
        b=a0OcVIF12lLVGVOtIfSx1+TKTqNpVgrze1/CLf/w6WuIFAMe8TWbyywpKFz+IZwAGT
         GrA01XVdi6CufaR3E0uq/uXmW+n1tSatdNMF/vxIUisQIQ5W9UmNNseOEq0FvYN0u4GN
         85UibeJSYrH/nIP+P/U5JaIssnF7hOGj7/TDIv3+RyTtovCjHe+vrY50MEBB/c1BRmKo
         U9dt/BvOvjv50PJTJEunlFw0dQvoszF3GjUco86M7dpGhBQsOQ6n2X+j3346ZEB6/Jz3
         shBQ/2418NTPr2DgGAmPzEvTOlUPQZtNU6hktOdQgM1MMra+4+UZJylVnTYHxiQCU14R
         QzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785513793; x=1786118593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CFI/kEWUQrMOVwbdW9xBPQDb5xYR+l3PWasJ1nDKXvg=;
        b=hMuhpyZxRx7OZckEWFaQKsp3MAeLhm5dqXBU10ivZbh+EnS9tuxWQZsUXGHrZf8V0e
         v9U0fzMIZgie4DC4q9VRMmFylvLKDkMHvgW4N8fMEvja76zZAbTbMPSxnnBEdlohKiBZ
         fQEkfqnA7ry6U+axtqX6NdX0/yZIrV9/u2p9OQ72dGV3ALOex1l7MCU59BK+74LJSiy7
         uzRR4l1MJ+c4EjhYqPTp615sn9CNUvuB7FM/3FU9a1e1ZlVMxus9M4FxQ1e8AaV46tg2
         f7GtoHbrAJq2+mRgnGZExl1Ba2Jhl9WyBxOF1jz17aIgd+L3KoVgLJ34tUAi0Yk/7xvk
         SX3w==
X-Forwarded-Encrypted: i=1; AHgh+RoZ2bn/Xd1MgmamonaAU/zyx77YG+EZHTnc8LrLoFme7a/vk4sBKFYuN/Xl60GKgPA/lBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYvqe6hN6t/zs2ar4B3b+gwJltp2ZOUHwc2OryErAeiGFBZ0S/
	OKui4QyBu1TFpyhKdAJHKAWQKa6hri8m7TLb6mnJqpEjJECrLuhb/Uk7KEE8VV/AtPxZ3lMWKAY
	QooPOPzHv9DEcrBLr6GDQmvCGNfyiTSInY5se7qPl
X-Gm-Gg: AR+sD10rxHEf0ydyB32CUvy+Qw2NwCmAIk0Kl1hY1PMCxK0vMH0FM6o28UKecpJl9mC
	KHFTTUm78y7gVf/h09vg5hTP5tiKizi/AySubbh54qV+AFuh1MRUoHEUvQSAaarg5GqdyNDX+XI
	iex6dm3yE/dE+WJb51w4gC50wY5oyP+DX/5COJ5yUMd5sSXmwZoIwKalxlDMw4DwhkwarmhzPjt
	luNIBXjxsPdVGuVJo0w1fDcmpX/PJt0ozfR+r6koUdKNwJOqXVkwZZ/h97UCoUJyQD5zIE+mzio
	Wz1sDQgogQ7T+pxplvtt9vz/zD6bn1Sb90aG4VZWR3Mm
X-Received: by 2002:a05:6a00:1956:b0:84e:223b:98c2 with SMTP id
 d2e1a72fcca58-84ee494dff0mr165281b3a.77.1785513791519; Fri, 31 Jul 2026
 09:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com> <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
In-Reply-To: <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 12:02:59 -0400
X-Gm-Features: AUfX_mxjC65mK_RgbRznYtgcxw-6qcPS9DZ0388yJaipWl41dn8qJKId3QYgWYo
Message-ID: <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>
> >>
> >> Okay, it looks like there was some confusion/misunderstanding.
> >>
> >> My understanding of Kumar's comments was that he was referring to the
> >> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> >> not necessarily the new kfunc you are proposing in this patchset.
> >> Kumar is welcome to correct either one or both of us, if we read that
> >> wrong :)
> >>
> >
> > Yes, after another reading, that does appear to be the case =3D).
> >
> > We'll need v7 anyway to fix the ocfs-related UAF the bot found.
> >
>
> Since there is confusion, let me clear it up.
>
> I meant it for all of them. I don't think it makes sense to keep this one=
 in
> security/ when others are in fs/bpf_fs_kfuncs.c. That confusing limbo sta=
te is
> worse than just placing it where others already are.
>
> As I already said, the discussion around whether all of them they should =
go in
> security/ is orthogonal and should be done separately; it isn't productiv=
e to
> repeatedly bring it up in the context of this patch set.
>
> I honestly don't get the urgency; it will be a mechanical change if we ne=
ed to
> make such changes. The worst outcome would be stalling David's work over =
it.
>
> As for landing this stuff, we can let Paul take the patches touching secu=
rity/
> and route the rest (3-4) through bpf-next after the merge window. We need=
 them
> to go through BPF CI anyway to ensure nothing breaks.

Some existing LSM kfuncs are located in the wrong files.  I'm not
suggesting that David needs to fix the existing problems, but there is
no reason to keep making the same mistakes.  The new LSM kfunc must go
in security/bpf_lsm_kfuncs.c; if that isn't acceptable to the BPF
developers then David will need to find a new way that doesn't involve
kfuncs.

--=20
paul-moore.com
