Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F432745E
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635851; cv=pass; b=lUxEU5DN2wHyzlqvW8TrpLFkUyH4VQ9qLa3yQyd0zFIrXmG+LnVOQJOTEf75aDW8N2sVOJ0/EB3bQpdgwXe4vFGwag492bXnYBFDsaZ++/5ltCU2YgX5s4cZjmnqZNyjw+88wRxi9184YnB2R3brj8zx2fLzSnFiCobhB/RjunU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635851; c=relaxed/simple;
	bh=oTDUXuspekuoflCCCvdaf/51nYCK6D4Tq6W7Hr8EGRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsrgI61fm3gE+k6LgYCNLpOvMG9aDO2tHOhTcDEr8f8SmwmWb/V8Ch8hLxxi9XD0WdzNPY7uOWOLoZSE5dGG8Lromo5KQslHRPAqx2z6F6pinDAm3rAu0Fdqc3mQMqoiEHtbWc3R4rwk9I/HU/x0cp7xeT37bgWNpR23pZqWdjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgK0UAt3; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgK0UAt3"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso115637a91.3
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 13:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769635849; cv=none;
        d=google.com; s=arc-20240605;
        b=DgGHvlEyp9jDEwHYzlwPErqL021SDGgbwQI8o2TugW0EfV30BgMQ4w0gvdijqTsVzp
         FynV+5xbCzYSeVEe0egEeB25SieuWJqIwqdVqayFNWxEnsY6C+vHFscwpG7Q106gThae
         fej2BTfgWqFY83E1flYsCXPMKQPulHKHSRroegoydX4RtAVTE3NBt5zO+tnzLjGK/CBo
         dAAQUys5DOXD2J+lM2+gVtEBLdTwuBHBMBsq9VJLW1xeph8pF6zQxvhgpqJQq/XyMbt/
         xHoUnWU1PCXuTuFAjBGCJsEoZAtjp4LyGAng5xYHeRJjzXtnRlOimghAYyJ4qQEKHfwV
         IJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w3n7iunNdSouulzoaJmC9ZCc/sWRudbOfEzNtsnZROQ=;
        fh=pvfNwV8iES3IhNWitM3rEmzegTGM9l+r3dg2e7B82k4=;
        b=RrpbnABc3mAi4RRIN0Ba7qUiC+NcksO6UMwAZBdaXctvSrngPiPRyDejRRUEWd9lwG
         gu45aMZDIPKOSBes0B0dlkAroLyrW/04pK+ch5108NK9rJwuEYDr4YSp+vf6ZzN7WDz5
         ZNtI6IsVwa4rn87C2UQPIW3+riKWx5NQTcIAJbCEWdgSHtEU4FJnetOoKAWX8E8F/Pgn
         J6kzGlOHvRcl2Oz7peTs5icwB4PNAz+uIf9+L76hSnI6nufyZXQbd0jFAHqNAWnSewsO
         OCBQtlBOhRfrYRUwKwARBs1INf+IkeV/s5fNeHcLE3tH6gnUiyLTEew+is5VomYIOrgY
         M+Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769635849; x=1770240649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3n7iunNdSouulzoaJmC9ZCc/sWRudbOfEzNtsnZROQ=;
        b=LgK0UAt3VQ2Muyl2YwcsryRUqQMWR/IZRJu9gyovwXYvwmHlmsGk5Y2CJVGoUkf96Z
         eQnm+D4/C8qxXhLVonqUS4dgUyFTWTu9vLtc671P9DWI9fVn81SngP9maz86FnlkkeYM
         FcnvFlETh0Y+1BKID+blQeJJjCjk6Qho9cijEEMvQ5qjFPeDrN5qZguK39wr0xsiUYpM
         yDxG37u1trtRnaXVTjTaG0duqojPTtfwujlpZv0ku84czZU6a4Hr1qoBs/5D1mBl5YiJ
         Dj3Nt3XI5qrtpZ4fe6Vwf1tXFcM5fERd5cQGsMs01mjAzbGuu3w0vfvirPk1dbTH05Np
         w9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769635849; x=1770240649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w3n7iunNdSouulzoaJmC9ZCc/sWRudbOfEzNtsnZROQ=;
        b=Nibc7yTvjYiEJH4Pb6HEVxp+vLTi7zA8yu1UnbeOOIqImiqM0DO1nvQaAA/Dq0pD6D
         kRqfyt4DQ50s2LBMdjd0UGXtNQkzpkBHgX+hj7C4W4z2ldWJV+RXYx3ddhdgeUmKa0xd
         IblEYrl86OYf6ILoACZ265jHNE5w5Fk+ed8ZgxwpfnA4Y48egng5/is3dpbBwi0bHpzk
         YSMDstI71qki0bI+tG1lZe5khpTgHnFtH26brwqt9MsNW3mXHwkK+XmcPmqu2McTWwxb
         z/LImL6c+eER0jQG/yPc9BI8XpfxZbEgJ94KJGGqiIytTPJi0+p7Bgkyk4Oy9G1yrlBP
         v0YA==
X-Forwarded-Encrypted: i=1; AJvYcCWqmVcQnvmXJwPYKUK1oeyniieFzl5Xs8WH6x221+b8z8uC8uaKtX9rOxORJgYyvQKog1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyekD1E3v3eRp7kpZfyde7/JGUoDuxDNkNMgL77k9/GVvil+l5P
	ADCyvxhXy5ZuAMXZ/Wb0WWsf1TShFT8j8irs2Di4V1dQyfGJXRn8dgPJCGU1JtuJNqFbkBIew8V
	33jmnJAgSZD+D2WtPIxq/Yj4zZsey4Og=
X-Gm-Gg: AZuq6aLjCj0KtgIGPtw9+NaUYFVgUZJyyu+uR6dq8uSzHkjI5aSoKTm4q+T8+cw5b01
	VxGzM5jIeTQGpFyJVSDDwC2hJxv9DAUbUGdSFHaOticY/sdfw/cvSyIg3oXRfmNZU5TKE1/VwTB
	vvUOnxqAuAe1lkupTSp3UEjOOp4BO4NyU643TGFXAm8wIy/0wa5ZxjQc4MohtBpV7x/+9g481Gq
	JA40jY6k4ph9HPfTWm5MMbawguZMdn0YuAYpje6Ob5+JXhrP5A8Drn1gfUcTdyC/AKm3S8kpifa
	gCIXYJNj5UPe5VzNp2qEAQ==
X-Received: by 2002:a17:90b:2892:b0:341:194:5e7d with SMTP id
 98e67ed59e1d1-353fed74c1fmr5879594a91.24.1769635849063; Wed, 28 Jan 2026
 13:30:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128183232.2854138-1-andrii@kernel.org> <20260128105054.dc5a7e4ff5d201e52b1edf85@linux-foundation.org>
In-Reply-To: <20260128105054.dc5a7e4ff5d201e52b1edf85@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 13:30:37 -0800
X-Gm-Features: AZwV_QjHSWyqWt5Dm8Ai8UuksKxp5jniDzRGkYBpB0ZnFwwuHpKNwCSnC3fMcVk
Message-ID: <CAEf4BzZJSuc0AH1Hio-DVpgR9S-KZsMNqU7tb--c4=mPZJ5dcA@mail.gmail.com>
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-mm@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 10:50=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 28 Jan 2026 10:32:32 -0800 Andrii Nakryiko <andrii@kernel.org> wr=
ote:
>
> > Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_l=
ock or
> > per-VMA lock, whichever was used to lock VMA under question, to avoid d=
eadlock
> > reported by syzbot:
> >
> > ...
> >
> > To make this safe, we need to grab file refcount while VMA is still loc=
ked, but
> > other than that everything is pretty straightforward. Internal build_id=
_parse()
> > API assumes VMA is passed, but it only needs the underlying file refere=
nce, so
> > just add another variant build_id_parse_file() that expects file passed
> > directly.
> >
> > Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API f=
or /proc/<pid>/maps")
> > Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Thanks.  ed5d583a88a9 was 6 months ago so I assume this isn't super
> urgent, so it needn't be rushed into mainline via mm.git's hotfixes
> queue.
>
> To provide for additional review and test time I'll queue the fix for
> the upcoming merge window (Feb 18 upstream merge) with a cc:stable.

This seems to be exacerbated (as we haven't seen these syzbot reports
before that) by more recent:

777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable context")

which is in mm-stable. So I'm not sure, probably would be best to have
both of them together.
