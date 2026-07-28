Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43325473C61
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269932; cv=none; b=iSFxJ+hFkWLALmV49Fd/u62HCfMWODnzMQpK/w/l0TWkHosoS0QsvdAJjjvG53XQMzad2618HQxAfIIE/w0byEiTKM2PrdtWNU67d+g5162WI9j88Vdjf2TliRdhnuk8+BObGIDpTX91lo2sOmeioSdopr9MDkUCQc5a3PZqnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269932; c=relaxed/simple;
	bh=mRvcUIZPf+vUPHO7daq15YjxhvSVbEAeRVy16VcjNe0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZIpLRlNS4xjfV7MuIe38lvwmO1tvttqX33CRr6SSaPzCrqlh5XEwqz4uVd+JIfpXIIKy5gED1htmQ8TVeGwJSg9hPtVm8rGHbSLFtVkiBIiiJmPqhakZZSB5K2ofaUfwgkuY4waqzDN2t6xRHzQDszk1qu28G2tHPr6IF9aRYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPMTEnKo; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPMTEnKo"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso657355e9.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 13:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785269929; x=1785874729; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YkBb7DN2FbeWUIim280DJKrJC6CieDlFXz4+/+vE7Jk=;
        b=ZPMTEnKoJ4en5Ec3fxEAU7r4cNCuMdGMRHBdq2sNTYBCyL/SnhuM254d1aD1KGJtKK
         Ves6dJMzVUSI4yY3QKkjq4taofuIMkKCYAVNOcKcwE+TW1ojubVvAGlI0fg5Rk/Qhjq/
         P970nyHkksO+8Fb5QQB27ElmZNTV9gdtLZk1gyvvrIbMaumWKc+Nb04xVpUWEBuWq6D3
         7vYjpIy11IRNe+TovUBmbHBWhUxPFoImuIOJ5jzqlYH6RmsF2V5IBeCEEB+SIOzFaYuK
         OcbtmOOUhKvbGL6wBKMnTULLpt1n6izYBxpL21I0I6eY/Tt3gjT/jJkmaAwdBgvIaohy
         T/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785269929; x=1785874729;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YkBb7DN2FbeWUIim280DJKrJC6CieDlFXz4+/+vE7Jk=;
        b=JkziQ7HsZWbrBziBcrzhUobCEFSVbFSOCm+6nDc2BVUY3RAR6thRdUTwzB5Zjjvq90
         8S80+H1ZZg4qdmIWtJguAwPkOzl4Xfgma3t4TjhNJKMC/RED8GnzwWmAu1D8i+/SNIjI
         F40/bBUXMv9ZEw4lWJ33Eby3wtfpRXnbKY1mbTuTdwbELJvdMl9acX/EdL5z+Yq1JMht
         Um3W19muUZb3cU+5Gl62VKMBp9CKj10B4MRLexNz4gnF+P7xnCmhp3f/zV2M0Y8K3SY/
         R6w05TOiGqQxQKZEBxvKXNBubJljDYcCKWWrgFRcnG1zd9kUtXiVCOddx6HoPA1ZgR2F
         S6QA==
X-Forwarded-Encrypted: i=1; AHgh+Ro2Ru3qjgHRxaGVpTadNfNqpEh10Wzp7tqdZMLyeY2NE2lMH2IpzUJNAkRBiN4vtP8N3gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuB7Zu9y9gx9sHN06IDJFzWgGmxBNeBP3pwi6Lq5cYUARalix0
	ohdL6aBV2KRr9fg+coeIegoKmFjXmoZRLQfctLqZw2grwNklFyh31NBi
X-Gm-Gg: AR+sD10lng7nSN4JcqyudxFdps7L0dHbXbdFQ8ANJQZM0y1kd1AD6FbJOpLUz4YDuLD
	CJRksr0hhP2oDz9vDdHXprXZkeYPXqKzRXKNJO7M0ZdEiDYc3mgtNnbQSZ4ZkttLguAn6XEPg9U
	88kuO98TMogEvFqhYCHS09x2CxfqF9U31R0VWinAW8SQuO8wGg6uNtufIReCVJJ7PZnPDb8qjaF
	+YQbJ56O6wNQi3Blvnaj4LYiS1GDasQrh8Oflq0dD7cbbt28gtoaO0EGLAr9MYY5+FpciSL0wrH
	mYH7lUmSxAnM/k6NmcU5b6CsMAgEH9Q4G0TB4sUHqu/wL4L8xvNA4vjP6R6zD293P6C3ObdKM8V
	3g+bUNX6N8F87ZjCdnof31TY8ZNT5yBnzKKVFKGYHW7xhYAar/czGA5+EhOs4Ik/W9vttMqhbKm
	F+DSVzmbe1OqBj9C7lxc/kD7aMS5Gzy1aNB3HWb84jBN70h19sLq72KJAEbtJvA29RYqedSzUT3
	Ca6atpIkVYdRQJBij52DgY+ucRaKdOUQbzYIrXmrddJc+zRoGMbQI1jORnvmGd+HTLLU4heG79O
	5EE5CiWqwsKNsxZuvztGZMz0W+VZJU4tRHaVzA==
X-Received: by 2002:a05:600c:a44:b0:495:6482:9d8c with SMTP id 5b1f17b1804b1-496c6597960mr42075235e9.37.1785269929295;
        Tue, 28 Jul 2026 13:18:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d72d9asm5832925e9.3.2026.07.28.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 22:18:48 +0200
Message-Id: <DKAHDEXC1VES.GVZ3GAOKVRZY@gmail.com>
Cc: "Jiri Olsa" <olsajiri@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmark
 for array maps
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Song Liu" <song@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260722065308.4116186-1-song@kernel.org>
 <20260722065308.4116186-3-song@kernel.org> <amJhnbom_expRgN2@krava>
 <CAPhsuW4NKdRmFxsmLoAYKV60NuKoRO-3NKqHAucaXPyFKk4BMw@mail.gmail.com>
 <amMoJnZUF5flJazb@krava>
 <CAPhsuW5bhv+CktsvnhEy97KA4oQY1dZfnGkzgKdAZTk77Pe90g@mail.gmail.com>
 <DK79S0WM9AYK.162USUO6EB2ZA@gmail.com>
 <CAPhsuW5Zf7ufT2iiyQWBdG_7JOuJMJqwf+jHbumMRVPqFGn7pQ@mail.gmail.com>
 <CAPhsuW5RC9JkLwfc2V-iO0pw5ggsrrwamJGRL_haN5fs8KRLkQ@mail.gmail.com>
In-Reply-To: <CAPhsuW5RC9JkLwfc2V-iO0pw5ggsrrwamJGRL_haN5fs8KRLkQ@mail.gmail.com>

On Tue Jul 28, 2026 at 10:11 PM CEST, Song Liu wrote:
> On Mon, Jul 27, 2026 at 5:19=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> [...]
>> > I think it would make sense to compare cumulative cost of mmap+read-ev=
ery-page.
>> > I am sure it would also be lower before this change, due to the added =
context
>> > switches for fault on every page access that would be amortized before=
 this, but
>> > may give a better picture about the difference.
>> >
>> > I do feel like it's a corner case realistically, and after the first f=
ault the
>> > page remains mapped (and users who care about pages being present can =
go the
>> > route of passing MAP_POPULATE). I am assuming passing that before was =
a noop, so
>> > it can be added to code in a backwards compatible fashion if someone r=
eally
>> > depends on this?
>>
>> Given there is MAP_POPULATE flag, yes, the user can preserve the old
>> behavior with this flag. While this requires users to make changes for
>> this corner case, I think it is still cleaner than adding a BPF map flag
>> for this. If there are no strong objections, I will keep this behavior i=
n v3.
>
> This turns out to be a little more complicated:
>
> 1. Bad news: MAP_POPULATE is not a noop for old kernels. The pre
>    fault mechanism still adds some overhead (for almost no gain). For
>    8MiB mmap, MAP_POPULATE addes about 80us (raw data below).
>
> 2. Good news: We can further improve MAP_POPULATE with a batch
>    pre fault (vm_operations_struct->map_pages). With batch pre fault,
>    mmap then accessing 8MiB is about 34us slower than the best
>    option before the set:
>    (before: no MAP_POPULATE =3D> access all pages: 252us;
>    after: MAP_POPULATE =3D> access all pages: 286us).

Interesting, though I figure we can let it be, since repeated
mmap()+MAP_POPULATE on very big array maps should not be a common occurence=
.
We can always revisit in the future though.

>
> Note that, all the above are worst cases: we need to access all pages
> and fill the page table one way or another. If we don't need to access
> all pages, the change saves a lot (220us =3D> 1.2us) for the mmap.
>
> Overall, I think this is a net win for most use cases.
>

Thanks for the analysis and data, makes a lot of sense, and agreed about go=
ing
forward with the set.

> Thanks,
> Song
>
> Raw data:
>
> All of the following are for 8MiB, access times are in microseconds (us).
>
> Before:
> no MAP_POPULATE (do not access pages) 220us
> no MAP_POPULATE =3D> access all pages: 252us
> MAP_POPULATE (do not access pages) 304us
> MAP_POPULATE =3D> access all pages: 334us
>
> After:
> no MAP_POPULATE (do not access pages): 1.2us
> no MAP_POPULATE =3D> access all pages: 543us
> MAP_POPULATE (do not access pages): 262us
> MAP_POPULATE =3D> access all pages: 286us

