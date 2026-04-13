Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE2D358367
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112773; cv=pass; b=TABRRctzdEEyIuJLhXrFfZHhJwM05RbChVkTxKN6X4pHB3h2DV7t71RtLnLGy7v4HemhQKKB3LDk620zmNmDTbouQ//qBeKhAQrnDW+jPkWqa4Oq1TfbELZ1CDp7mnk5YJpGPLyxQSBbl6+SAtui53gzzaEJklRgryLLkHwNIe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112773; c=relaxed/simple;
	bh=PEZjoZa12UUj5SyO1b3BkdxKCeo86DiqtO9Y9tXDXgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAL5++W04BTrTHhwSe69U3mNZ1uB34PhZvS+snY5V3bTESAASKRlscdse6YwMJuLD85VgLVjyUa0Q12H4u4ukCQQRNu+7AaTDVppv1HLL6GCoi55BHDKtf5VDxpaEihqtSwe+tm13c6OiQUGUKfmpv4p7IN0rrDJUS3h8gLuS5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYuEVTNO; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYuEVTNO"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9d6c8871c7so704239666b.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 13:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776112770; cv=none;
        d=google.com; s=arc-20240605;
        b=DDu9qbbu4GUIZD+T/0LreDrM31Usi3FFAJH1xuwAzzkfoEZe9wRBQAYc+yyb1U5sTs
         hzA5O9hFg8XJ7INuCXfhETFCrpHThExmrTTZpS0Z85x9bexSrow27q7cGMAlZD9856AA
         NRmn/FdKmK/OAa8I++aESo7acAtV8vYVXzHXRyOK8dtuSaJuHXYDYaQvT2/WA73EBsZ9
         FxgC/X6DOxQwgfaDgAHleBL4XqScxJI7WbQasPEdULaiBxrUoUG2wIWYBteIzBXX3Wpa
         qURqLCzhh2+pW7uMcTYQN/A7vPYpYpz85m2QfBbbrYkT684piOZb9NmO3zuiUVsr3bZl
         nn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TH4m/idJ4M3FjDEc3vL3oLYbFEZ5XJk9GPdaO6YXJ0Q=;
        fh=4i2pWxlBjZU6yhKYRVFZWZdjvkpCYMxWo4lOVY/0kgc=;
        b=Z9j6K6+8zLOL8stznU8ZeljwFp6+4hddbPbzZYHMYbC1riaJJovKrMa3FPO6Z6YJB+
         UAV7jnYGu3QlUWc/0mxDe0V/YA4TCRF4dTHtC8tHP2bYVVsrccfJOa6DWpfF1C56JEAW
         K4H0u/sRpEZiLYSvj9AnMep+QwhOusvbDJbx2KGQeT/Vki3bfbZeKPupEhbACUw8c+pf
         bchLdRSvSczrTqVI+RnirMfqOgwYK+TYEb2sPngMKNgv1IJTLDtkb0KDbTZyW7fcreGJ
         OzEzgt95dv3h2ypcdmBJFRMyNjwWGcemRVIqCIdfdq97ivDdHBwD6fCzaW9610CuiHsF
         7YzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776112770; x=1776717570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH4m/idJ4M3FjDEc3vL3oLYbFEZ5XJk9GPdaO6YXJ0Q=;
        b=AYuEVTNOxkfjOnhiGgaWyFJXPBfPMBLT9Lbr2ZambnIGebfZFxb1S+VYVHJZUb/Kh0
         MLKk8m+sF1yTVJGmr2X9Vv4SsVD2/hElrbcXczRepLMuW3ghoBiy0q/nf57gPc0nHZ7k
         uCEoVkp+J7F/+4NVvOGzQ/tE2wCh0TElZOKe6ITjBjM+/3yrwkHSUc4fmkeBqBNlLIbE
         D/bnmUcH04UeUHrVfROCdRfywUBszRrqoer40a0XPBn9pOqe8+wgFir5e8DsP5pcXyEB
         Er3Da7YxYWTg6plfcWkzSwh+qdKihMHeM5Un5pkkF/jbHWFqwsOMmeq+mX1EnM580vZb
         avgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776112770; x=1776717570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TH4m/idJ4M3FjDEc3vL3oLYbFEZ5XJk9GPdaO6YXJ0Q=;
        b=FQakoytZsCoTcUCYnizq8SiACXuy4J5/IqXJOKgXyLThHVC7xy1KKKVgD5l72FjmQI
         pZ7yTf6P1utFI05h5z+Cy3yU76EmRvssSx7keLT5xc5BajCiI8bE/Rh1CHltjsNLIAhB
         74cpkevJzWEuW7sVbVVnfLMfmXtX+JrQ+bcX8rMUG9kSyrm3WWYW4cAoVDJYikjPZSvH
         rwd3hd3ohfJrhPw6t4/UDCCtOFFmjE1TumBmBfkovWci4zwBkbx2mUjTIWzMfFKJMdiW
         WWgPSpVNbZCUietcjaYdRi0j7UWkSl5adMoO1M+O74w6AtVbNZ8/OdrBQkwnWzKN0dGx
         kCnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/eYCtlWbHg04YSbAJORCNQcmRnAqMQtkkYfsySr0/C15xdoozVHOImhU6srslrJtq8UWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXZvOXa3HOPWNjWUFMVSbSAcDMB+ROCIk1pJXR5vVlzY9ajFe
	bYnQjYanBG648PTg/czWT1idc505zurxam1rQU4PP8fZkxiu59gEIDDd+tLqhEaGG8G/4C2xB/t
	3dKpbM9WaPGNPFlBNFhQ0x3MdVf0mPBhvygssL356
X-Gm-Gg: AeBDieun87zyRE+wPM4zv3/Ym8CXh0SBDF5NFnf/r+WLrbuFU2CjYt0EauBVuT819gA
	O4nr4cR/yYrhdtlQ+7ULwkVn+uZDvlvxKUA5KRZTH4csQM0+jLmAcwxVOOG51N0mzx3BWXAraTV
	m7JVoRwppbLAEYcdNC0lm+ZqfvK6tt1SeYUOHGSgHSMrNbVDXT8rilfUsUz9uCQw+8mF4+iUrFi
	6pA2W3eoqRoDmxAjRy18n/FWI9OWdXy4sZ8KyrvFI3rEq3TsVNWXE7bfZl+8eEbS8euyDaS6Ftt
	dp7SsK1WZj7l5QZDYIDfxb6RPP2PXV8a2LelMgXs4Zxci2gh/OYpkasOHjtlqKU=
X-Received: by 2002:a17:907:74d:b0:b9c:bc70:e928 with SMTP id
 a640c23a62f3a-b9d726577e3mr820713966b.25.1776112769834; Mon, 13 Apr 2026
 13:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153413.2469218-1-wusamuel@google.com> <2026040136-ocelot-simply-8981@gregkh>
 <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com>
 <2026040236-kiln-carat-bb6d@gregkh> <CAG2Kctpr7vBm_=Xz4H5FHYAfFxg=bDt35j6B4EprfUGio=Ftew@mail.gmail.com>
 <2026040357-undefined-gave-c98e@gregkh> <CAG2KctqOLeYm_NFUjGdXQcBo1KhSZpXFQxQdM-DQBV4Mn0ahTw@mail.gmail.com>
 <CAADnVQLELWyv0kuv8wK3FJVFdJPbp-tD8d3p2pgCiVrcw_cVNA@mail.gmail.com> <2026041315-oval-rut-cb8d@gregkh>
In-Reply-To: <2026041315-oval-rut-cb8d@gregkh>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 13 Apr 2026 13:39:18 -0700
X-Gm-Features: AQROBzB9ayPqL4YBuz2jmsJ-T4uaqkCVLTD0LdsQ1h-gNQThCOSm7u-eqI2Gpsg
Message-ID: <CAG2KctpNTvkDEOnJAnsnXOfqEkzrVQSUF5S2=-NVoXiO-Tfk2g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Support BPF traversal of wakeup sources
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Android Kernel Team <kernel-team@android.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 9:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Apr 12, 2026 at 03:48:58PM -0700, Alexei Starovoitov wrote:
> > On Fri, Apr 3, 2026 at 9:28=E2=80=AFAM Samuel Wu <wusamuel@google.com> =
wrote:
> > >
> > > On Fri, Apr 3, 2026 at 3:04=E2=80=AFAM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Apr 02, 2026 at 12:37:12PM -0700, Samuel Wu wrote:
> > > > > On Wed, Apr 1, 2026 at 9:06=E2=80=AFPM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Wed, Apr 01, 2026 at 12:07:12PM -0700, Samuel Wu wrote:
> > > > > > > On Wed, Apr 1, 2026 at 2:15=E2=80=AFAM Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:
> > >
> > > [ ... ]
> > >
> > > > > The data is fundamental for debugging and improving power at scal=
e.
> > > > > The original discussion and patch [1] provide more context of the
> > > > > intent. To summarize the history, debugfs was unstable and insecu=
re,
> > > > > leading to the current sysfs implementation. However, sysfs has t=
he
> > > > > constraint of one attribute per node, requiring 10 sysfs accesses=
 per
> > > > > wakeup source.
> > > >
> > > > Ok, as the sysfs api doesn't work your use case anymore, why do we =
need
> > > > to keep it around at all?
> > > >
> > > > > That said, I completely agree that reading 1500+ sysfs files at o=
nce
> > > > > is unreasonable. Perhaps the sysfs approach was manageable at the=
 time
> > > > > of [1], but moving forward we need a more scalable solution. This=
 is
> > > > > the main motivator and makes BPF the sane approach, as it improve=
s
> > > > > traversal in nearly every aspect (e.g. cycles, memory, simplicity=
,
> > > > > scalability).
> > > >
> > > > I'm all for making this more scalable and work for your systems now=
, but
> > > > consider if you could drop the sysfs api entirely, would you want t=
his
> > > > to be a different type of api entirely instead of having to plug th=
rough
> > > > these using ebpf?
> > >
> > > Almost all use cases want all this data at once, so AFAICT BPF offers
> > > the best performance for that. But of course, open to discussion if
> > > there is an alternative API that matches BPF's performance for this
> > > use case.
> > >
> > > I'm not opposed to dropping the sysfs approach, and I attempted to do
> > > so in the v1 patch [1]. I'm not sure who else currently uses those
> > > sysfs nodes, but a config flag should remove friction and could be a
> > > stepping stone toward deprecation/removal.
> > >
> > > [1]: https://lore.kernel.org/all/20260320160055.4114055-3-wusamuel@go=
ogle.com/
> >
> > The patches make sense to me.
> >
> > Patch 2 adds a bpf selftest and corresponding:
> > +CONFIG_DIBS_LO=3Dy
> > +CONFIG_PM_WAKELOCKS=3Dy
> >
> > and almost green in BPF CI.
> >
> > Except s390 that fails with:
> >
> > Error: #682/1 wakeup_source/iterate_and_verify_times
> > Error: #682/1 wakeup_source/iterate_and_verify_times
> > libbpf: extern (func ksym) 'bpf_wakeup_sources_get_head': not found in
> > kernel or module BTFs
> > libbpf: failed to load BPF skeleton 'test_wakeup_source': -EINVAL
> > test_wakeup_source:FAIL:skel_open_and_load unexpected error: -22
> >
> > We can still land it into bpf-next for this merge window.
> >
> > Greg,
> > any objection ?
>
> Yes, it is too late for 7.1-rc1, sorry, there will have not been any
> time in linux-next to add it.  Let's revisit it after -rc1 is out, and
> again, I feel that "walk all sysfs devices in bpf" is not the correct
> solution for a system-wide snapshot interface you want to have,
> especially as the one you previously added you feel is now obsolete.

Sounds good, when the merge window closes, I'll send out v4 with the
s390 errors and remaining comments fixed.

Regarding surfacing a system-wide snapshot of wakeup sources to
userspace, can you elaborate on the solution you're envisioning? My
understanding is that "walk all sysfs devices in bpf" is a canonical
BPF use case, especially in this scenario, where we see improvements
in every core metric.
