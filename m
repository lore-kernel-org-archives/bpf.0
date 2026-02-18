Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DFC34575F
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441734; cv=pass; b=Inv9AJIO6FTCg5GKVJ6P8VqN53OW62KHSzZq99MhgNk8aIozAd43uZ6ObStJnOhyLJ4zsODZi6XVk00weDHqlCicWFvMTZWZjePzT/VlWvF41lSmD9aQU4fJ9RvPkfbDW/wO+9ATOvXgTMcKwZN5tXlQzORRVxmVbF0Pr/Oozxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441734; c=relaxed/simple;
	bh=55eyObI9OH3cLECPGMvQfie4QE3Go6fFpuxhjECulyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBvJgH8u4A/0xX2QCBxYf8EOYPd3cJMgImcvlBtxHI5TS7jiQlrgbPWaZJ9Gw+yq8mxZlbgGdlJdRzrV44q3MwOFGyTQWVzR9eNUk++PnspFx/1lMTQ0TaT21DTv9r3PadcStRqJ5ZZsJpM5IpRQaxqW/6m//qILGxgd7Mu67kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dzs9FUmv; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzs9FUmv"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-354b79a9ad5so46868a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 11:08:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771441733; cv=none;
        d=google.com; s=arc-20240605;
        b=Q63lFWEBMIeQF1CVIVoTvKnkxL7S25YYPSKEqVq4Lx3nxm2oNp5ux0qA3Yz2hQL4/E
         p0wTixs1a2dnO5BqNGgPgJdbmEl5Oc8UtCdlu/L7tDSAqQakRlatJiDypiAWS1i2ObRP
         sVp7Z5hsvanNaAY4+GtbaJuqbthtNMWfxpLZmQQPPgYlVxexlkWWfiVYAs5XPhV25tAW
         AEtksX1x518cSFE+vzpbtMOUYQRsxxPZIA9FcR+22U6OHtohmQd+d2wMG2WevTJcgmA/
         ZnreX1YuE+v/v8t2Ks49cShWjOSyjgeBZ38vQ6BRdfpaQRPfsyzGEqL75jFbp4mHlFON
         AE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oJFhBZvDk1LYazryqCuQuGfIoSu6VJCuDUD60LGclwo=;
        fh=Y35AzsnQchULbvWMtk7UbdXX87wT7zYxw9zz3nQ+3MI=;
        b=O4Bzqq6Lb7u0r1HcVhfHK+/wK48aATQHINYs06uMIs0AphWQ3njaVc+kjsWFLEaFMJ
         s+GWI5hrH5Pgt5Af4sA0JSjmRC6ceMt6L1CdSNTjilE2vuQOabphO9VhxJrYdcjjHvmr
         H6fz7lKKHnY/OFyBg6oqgZQrz1tPjxOZX4jjZIwhdmh0vkPO661LVzOy5AHaZWSR3B1/
         UJCfEFPGilb4JIQHCP7mTSWHm/dss+gVrAs7BPxk4smldwx4L7rCtM1Pv9GE5JtE8RzU
         QFndOFnDcUkt/SECNjKOMgQwWYufVKhS+4QoAtaP75rChRGjTYEgRnIYGanumr7xCPUq
         gi9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771441733; x=1772046533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJFhBZvDk1LYazryqCuQuGfIoSu6VJCuDUD60LGclwo=;
        b=Dzs9FUmvn2xr1e7hJwag+sJAodzgxsRj35JM/mpHtnjFgmcIYkh7wBVEYNnRUdqcL7
         IE6+JRLzw9q2e9YhtQJuFKb6/P4PttPfrBeQxmdG8hDurOFn6gmYilrE3JUSS75YE/FE
         wPrFqpzUIi21G/y5t9kegF1oP/KmbdU9Buq0lvILgJ6RqXG6F8a774a3k8zPWL09YL6K
         oKbFmYOWE86d+tb97615lqhFUFtTk9GnW0NqZxNY7e+XBpHuiytH+hKffETTnlCaY80+
         314iwtfn2UEFYfiEkJXw8LD448Gury+aUrO8FuOCdzOPMssNVCs6RUvedkaNgohy+jCg
         /Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771441733; x=1772046533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oJFhBZvDk1LYazryqCuQuGfIoSu6VJCuDUD60LGclwo=;
        b=fQ7vroyPklvfL7FskFnET4jxS01y9rIzjFO7+P2nksxGz/gtuI3UgsDnkxwLsipGcH
         4MD1nLmJiCpSE9MeIiHSRM2euGDhCmZDj5v4GlnnGllrHsyX8DDe2XCeGh3ts07DZUTj
         97wuXtNQ/5WxoluLVtyUFtXy0shj4GvMSjmSUbLL4nh/sPR53QTdi/Bcwky++wsK/B76
         zMaou54N0B+lU9HOF2d41xTm1/hIkouTT7bfj5KgPZ5iH30B08B+siSCnLgyozml8Fke
         RGfp8mGfa14kXjMXCumihhvC8ns0mhSX8cx5AHQUlV035jtRRsWAA86pX+rkNWPEi6eh
         RkJA==
X-Forwarded-Encrypted: i=1; AJvYcCVUegpdzySj9SAzDMgpEg/cKk4njKNL6jFujvV57z1ExXJobDzPHgcRBvGkWfnKapdUahs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS5FWFks19cLbnagccsy0ED9qEeOCOxpUkSgTbdNBc1o34BgE9
	XyYb8b99AD4a6/real4NzfQZQa0yadeF5o0PZxih8FbmCoTbIy7OT+r1LnwjMwJ//m7fvnT8YtP
	E3XuFktIwKvdoF/m/hE3ok4n1rf0hJ4Y=
X-Gm-Gg: AZuq6aLlMZmNVpdQuhz0/vBlxoSUqHeme5N1Wjku4NUVKazwtmPB4xWjyhbFVa64x8U
	HUNsmigJ4a3gX3KNR7vhhuAucpSlDg8G4S4ABa7TkacbNTdU1LkamW6byj7UFE7SBDKBNRelMAJ
	rBFUqDcoWB3n06RHqu3Qrcr/Sql6/uHAvH5m8izrCKq4eROY0JjPCjtjpP7jBmTKkZq+Ri2/tc+
	FeEex2fLK4V862VLEWJI6rRK+f3wu4YaVt38rTtYn7hgK+ouJ86qjxT38s0kvFdQaDvbavffcrE
	ifmeLrvBLrfkbl3IDpLd2ykz5pOH9uXL
X-Received: by 2002:a17:90b:394e:b0:354:bd08:4802 with SMTP id
 98e67ed59e1d1-358450ed085mr12909079a91.35.1771441732928; Wed, 18 Feb 2026
 11:08:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212-veristat_prepare-v1-0-c351023fb0db@meta.com>
 <20260212-veristat_prepare-v1-2-c351023fb0db@meta.com> <CAADnVQJqBqBaUZjQAGdchePKZMT5BMop8Sn1W5jmVOKUUdv0OA@mail.gmail.com>
 <02973092-a718-4374-a6ee-e31e8c046ade@gmail.com> <CAEf4BzYFGdpdPP+HV085mhPmujW7kcE4TBxLtwu1PegOz_QAZw@mail.gmail.com>
 <7990bafe-d72c-47de-a711-0c8a888d4ed9@gmail.com>
In-Reply-To: <7990bafe-d72c-47de-a711-0c8a888d4ed9@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Feb 2026 11:08:41 -0800
X-Gm-Features: AaiRm52YMO7XqyWWhKRPb4v04QlPOBaC0a2IwXvAW7t8zlJ846Mw4yKX-uaBcDs
Message-ID: <CAEf4Bzbrk9BBHYgZqyoEMS4UzK0TK_Z8DvEOvoKNkeh9X8YyNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Use bpf_prog_clone() in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 10:44=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 2/18/26 18:33, Andrii Nakryiko wrote:
> > On Thu, Feb 12, 2026 at 8:22=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> On 2/12/26 02:45, Alexei Starovoitov wrote:
> >>> On Wed, Feb 11, 2026 at 4:45=E2=80=AFPM Mykyta Yatsenko
> >>> <mykyta.yatsenko5@gmail.com> wrote:
> >>>> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>>>
> >>>> Replace veristat's per-program object re-opening with bpf_prog_clone=
().
> >>>>
> >>>> Previously, veristat opened a separate bpf_object for every program =
in a
> >>>> multi-program object file, iterated all programs to enable only the
> >>>> target one, and then loaded the entire object.
> >>>>
> >>>> Use bpf_object__prepare() once, then call bpf_prog_clone() for each
> >>>> program individually. This lets veristat load programs one at a time=
 from
> >>>> a single prepared object.
> >>> Any performance numbers that prove that it makes a difference?
> >> it's neutral, I did not manage to record any difference.
> >>
> > How did you measure? I just ran
> >
> > time sudo ./veristat *.bpf.o
> >
> > across BPF selftests object files:
> >
> > WITHOUT bpf_prog_clone()
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > Done. Processed 905 files, 4327 programs. Skipped 11 files, 0 programs.
> > sudo ./veristat *.bpf.o  0.01s user 0.08s system 0% cpu 54.512 total
> >
> > WITH bpf_prog_clone()
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Done. Processed 905 files, 4045 programs. Skipped 11 files, 0 programs.
> > sudo ./veristat *.bpf.o  0.01s user 0.11s system 0% cpu 17.883 total
> >
> >
> > 54 vs 17 seconds. Though it's curious we have much less programs
> > loaded (according to veristat reporting). Still, those 300 programs
> > (if the difference is real and we should check why we have the
> > difference in the first place) should account for 37 second
> > difference.
> Thanks for remeasuring, I might have made mistake, will retry.
> Regarding the smaller number of programs with bpf_prog_clone(), that is
> by design(ish),
> now if bpf_object__prepare() fails, we just fail entire file and do not
> print a separate
> failure for each program, while base version of the veristat prints a
> message per
> program, because it tries bpf_object__prepare() for each program in the
> object.
> If we really need to be on par, I can iterate over progs if
> bpf_object__prepare()
> fails, it just looks a bit awkward.

No need, I just wanted to make sure we understand where the difference
is coming from. If BPF object itself cannot be prepared, there is no
point repeating the same error many times.

>
