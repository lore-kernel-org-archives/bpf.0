Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93E1F03EF
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750297; cv=pass; b=H8Uosr1Syk07WY784a2zedVQa7WJyNCTsZAtxJY2ztuNXksTp6dHqybiLZcUE9+NiJRIOC9/RGdXEp/1LJG2ntu4hXRbtTaR34AG3WEjwz83fKMKx6YK4cAxoCX2jStOWJLG7D66cquxRn8OkvTLTcOrKp4hnEJU0nVNVzcIfyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750297; c=relaxed/simple;
	bh=waSjE+rNF9IPR01Ke+2jjzhLW5be7EOFjC/vRgwA+j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaUcjefwSV1z/4e4dCTBt6l9YbW4u4BDde8DdDMTvF/2O8R+Zsd1752CrnDah9ExH0StCBn5lscu3Te9HyzqSffDyyvrqwTvFBVzXKmwYE7DnS1ud1K+k2C+542xdWj1wch9HDlxRcZZafxQjMqy0qRePoYo7jgCNvuAeanW7rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFAfxdwG; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFAfxdwG"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35480b0827bso96489a91.0
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 11:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770750295; cv=none;
        d=google.com; s=arc-20240605;
        b=f2xAcf5oAojgurzuQ61TfIUZWa11RjJ6w7dsIHG9ELtWkGvpIPfwnqHvoWelZfQkMy
         cP2jS9FyhpZgmf2Yzt23rPns+G1cxL/Wl39GAEZVoqBMw27STl8pAZ8cfdkkPLrZlctI
         n9nr+3dnpbAQvyuUT1zXmS7qV7XT2ut9DDLVBH3/TcrXRi4H0w9+88x+Vh/jp9hdrAVn
         HOqoEUI7/+aM3Z6F53KWXIyiz0z8oVbhZ/7g4iw7+QxVcrOf8ADhjtwm8W2nRdfIQerh
         89JH3yGMMGQXz+w2F2ekgx9DtoCS+puXlN5TwBa5xNHNxdwB6tOayxW8JpnszTx81W9e
         0gyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zA1TNrRJqKyG8q/TmmtSKmp3ptZDT+TpaazJ5Y0UgEs=;
        fh=dc5otNP2dy5Z8RyO68T/IlHoY14/KGwnNllTVbfTWPo=;
        b=FWdULvvp924KyoicuQ1Hd5itBn/ZDkE1fAj54Im28EL0K7lHYVb3tFLfD7U2SoavnV
         7YIjJWYS+5O9vO15pzZdPW3KdpAT7H6BIJ0VI0A2s2Szh1M/6bcn7tp/zeKCe3Hy2wuv
         PK7OsDHwO99/HXHQL4KKt6U7gXEV7mjpLQsrVoE2afj9UMe2ykxLTHO37WmXNf7EzQfX
         9/l7P/i/vBlYGlDn5OI+l+wGCF8qrw7IBzrxLU2ryzqw5x7xMP7Hd+pDRsm1Ink7Bqn7
         qj38UVAbSURWEup446rp5SmlvNMxJIlZ+1FvJJxIfWD/zzOk9Gp+ukcMwDo9S5IwsMX7
         WGSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770750295; x=1771355095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA1TNrRJqKyG8q/TmmtSKmp3ptZDT+TpaazJ5Y0UgEs=;
        b=DFAfxdwGaB/wDB1InxJLX5WJqq2HrYmL0QfsT4n9vuwW8J0eqFk3d85OM4+OC1HDXo
         WMPHzHwLIL8zlR7fW10CD+uKJ0zEVxRLnxtjmgDx2L6ZBetM9rNwnwvHVmOzb0ciBrRo
         t28EHo80Q9AYksrE9SPVClzF9o01CVVLjFVC59LCVkXIpdNxHUeVwKeYp5cCjjGVOGob
         fDd3zZHa4jrQ6X3J4fQ8/CiOdEVFZUPhVlX95z6topjTQhdBtmFYj9W/hL4znFioBmVC
         A9ZL3Te5YvpCu2760eBRBu8oNO2RWRrAh3/3XFTQlSQARZkp0G3kRtPq2ZzvArN9nDwg
         3wSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770750295; x=1771355095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zA1TNrRJqKyG8q/TmmtSKmp3ptZDT+TpaazJ5Y0UgEs=;
        b=ObjVN3KjA5hLyMYu5GQlCOqb3A+mMj0ETKX3YXUX84mGx/fEM1ARUifuhAqXxi9l+E
         QVKx8jjhSq1X94BNGhoXQnNL4XSPqdlk+/t/O+gKcgZNQ+SdrykR8DxZgVh/BaoHvxq2
         i5Qf5l+OvISdqQ3k12GaV4SV/VCsYByZDHkpxMrPrGlKqEXoPEYXfHiIzzn3zDGV5JHf
         oRnGDzFiZ4upLy8X9GNtsuOrt4+iu383/uUPdhrvTVKCmX0W6obOCbLpUgHW1rpRr1cB
         U5AzvTQJ6PKE6MtnwadRZEZqI+k3j9ddJfvXrnOP/eySjgJrXn5+W5PlirRhIZIDhk0x
         z48g==
X-Forwarded-Encrypted: i=1; AJvYcCVQQ1O1S8qIjXAZqDqpHvS9FF7ZkcU7wSvYeVzzWJaINIzW9xsXsWenCCT4dWmOWtLHyko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/lllQ6rn2qXA8A9P2YqN+uMQjUpo7KxWEXS1aJHQd/+gVhey
	sEK7fmJFAFhtZcblJ4XWxvS4xgbW8dhGSE5x5QE6aJBgwkTJvTaAbFCIHnAdHNPIGYVvGmQqrjN
	nenR03L8e7vjFu/1vVND0ZpwOhH+FiKE=
X-Gm-Gg: AZuq6aJrqEXpc2Gg5C2eK3sMzxxYXwllZKm/uEtYTwT760Vdv9CPP5vTb5w+cWrdQhY
	rKu6Zt7mueQt6Zfm9KAz83+Fva7DwExfrZyAkKL98J2wUbWB7eXM7ZfV5rztoppZk8Q2Di2y+xY
	JqPx/Fl9PWfhQq2xg25mqLRxN4D9l3NGDqaWVwxyi8MIe7kGi4v4BWfjYJ225K4SyVwXYJd9toG
	HjV6DrPBnJmf+LivLvfBd/VrkQX5xeCwalGHrhs/TaUr8qKliWc/ni2A6aBBvypvyEX/Grae0ck
	t406qGfHjL8h6K5OPvJvizQ=
X-Received: by 2002:a17:90a:c2c8:b0:356:26c5:aaa9 with SMTP id
 98e67ed59e1d1-3566615404amr2614078a91.2.1770750295328; Tue, 10 Feb 2026
 11:04:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129215340.3742283-1-andrii@kernel.org> <87qzqsa1br.ffs@tglx>
In-Reply-To: <87qzqsa1br.ffs@tglx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Feb 2026 11:04:42 -0800
X-Gm-Features: AZwV_QioTD-2tB90VI5wBvuDYhjyIi8I9OHw4H2v3xPsXfvoZ1RNWowMJzaHBTc
Message-ID: <CAEf4BzZHktcrxO0_PnMer-oEsAm++R4VZKj-gCmft-mVi58P8g@mail.gmail.com>
Subject: Re: [BUG] [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
To: Thomas Gleixner <tglx@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com, 
	shakeel.butt@linux.dev, syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com, 
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 10:41=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> =
wrote:
>
> On Thu, Jan 29 2026 at 13:53, Andrii Nakryiko wrote:
> >       /* unlock vma or mmap_lock, and put mm_struct before copying data=
 to user */
> >       query_vma_teardown(&lock_ctx);
> >       mmput(mm);
> >
> > +     if (karg.build_id_size) {
> > +             __u32 build_id_sz;
> > +
> > +             if (vm_file)
> > +                     err =3D build_id_parse_file(vm_file, build_id_buf=
, &build_id_sz);
> > +             else
> > +                     err =3D -ENOENT;
> > +             if (err) {
> > +                     karg.build_id_size =3D 0;
> > +             } else {
> > +                     if (karg.build_id_size < build_id_sz) {
> > +                             err =3D -ENAMETOOLONG;
> > +                             goto out;
>
> Introduces a double mmput() here.
>
> > +                     }
> > +                     karg.build_id_size =3D build_id_sz;
> > +             }
> > +     }
> > +
> > +     if (vm_file)
> > +             fput(vm_file);
> > +
> >       if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_n=
ame_addr),
> >                                              name, karg.vma_name_size))=
 {
> >               kfree(name_buf);
> > @@ -798,6 +808,8 @@ static int do_procmap_query(struct mm_struct *mm, v=
oid __user *uarg)
> >  out:
> >       query_vma_teardown(&lock_ctx);
> >       mmput(mm);
> > +     if (vm_file)
> > +             fput(vm_file);
> >       kfree(name_buf);
> >       return err;
>
> See:
>
>         https://lore.kernel.org/all/698aaf3c.050a0220.3b3015.0088.GAE@goo=
gle.com/T/#u
>

Ah, silly mistake on my part, thanks for the heads up, I'll send a fix shor=
tly

> Thanks
>
>         tglx
