Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297AF3FB043
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369886; cv=pass; b=pxI7i8nIU2Urspdmtl5hgRdcaCu7lRf0QtCS3pN/QPkIcx7rDAz6xqDxYUXnmwVbiczbSZXzRbwDWsVUfC0j9Celt9BgkKMW3nk+9LE6iqmueqFqitfx2MHLA6rRAMtUgXuiGE30LdAi0BNx4TO9WHgmRIHEt+x78CRpyF58tuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369886; c=relaxed/simple;
	bh=E1n0jm9MFEcal142mViLeWqQcIxG66U3otOZkgtm4mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSLOi8idaj5AZ9JEK1meURh/X5OUB5b7txnja+fdgsVmVb1OM0rr/JrLETo3sEspR62acm50fO2gGU/Yi4PfViHk75Hlz/pzfanYRMPQFu37vqKlIyb2Dg1P1wO90cp1Cdd9j6EJlrTQ7ptcMzD9eD/zJVDQR1kblDLRWvX4y6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9I+NXn3; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9I+NXn3"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so3049680a12.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774369883; cv=none;
        d=google.com; s=arc-20240605;
        b=U/76qzYXOR/suLjvXFNfVuIlpQ/jYSowikrddqZhcilux6PQqrAr45uNQeaz47ueYb
         0lnJSnaBe2rRoLA6OZMsQ018wxDBecbOxRxtTg3dv7Uze+ESyWnGeehmKJcLu4Lu2SJF
         I7KLpinNps5ZgGiFcrjl5Oz+C7uV6yrLiE/Cs82fGnpcBnUpWL0LBrdWPisGNJXH9nxn
         QEMa7DZIFpwba65Erjmjoo69KSHrqKa2ThUv9X6gihPcn5lKaVWf56QR/X8c6XOU6M4a
         +pKJpHiGvxLkV8CET49G2W/iyAbxM7+5lQC3LRoUU2frYrHLVD3DY+YrVWS5NVdTSJTG
         zwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E1n0jm9MFEcal142mViLeWqQcIxG66U3otOZkgtm4mM=;
        fh=QqEopT2NOVPJxkVUUO8NH/7Y8GNWxuEjYofRGrWiVQs=;
        b=ER/Hhzh9DU60DmPC5uJ5RXsKQ781bBC+Yc1mX5rED3UrClUqqYO+cQF4YWQt9T7/YY
         LcwOCTQC+syp/A7lqhBPlHBeSiIxD66PElmRop/0ySK0PhXxW28AAGkxKEDR0ktdo2L/
         rWTpDqxlJimI/6KiPvrrvhadlYmi+m++5bCeGP7s8TkFc/edgJZp3Txrxvvvtc46nlxN
         lZGmDjK/XeGwQ77AKR20bsIH2ZYwwQoRsxavh6lCadx2DU4OGNcDQUsXoJEkaHS5OKSh
         /D/CqqHdVWerWbD+MIkpfOt38Djtot/NZM+cKNRoLiaU/kAkfZleXvSEpU9Jy30EEzr6
         5UJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774369883; x=1774974683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1n0jm9MFEcal142mViLeWqQcIxG66U3otOZkgtm4mM=;
        b=e9I+NXn3WNy3Bt4ayYOmjMCjBHnS1Xef1WJaaEGJYHlgjykZX6g2vOzLTLXLLWGPlU
         mzmW3UYBo9E1sJn+PerP3zfMn0ajAEXTLHpV+DJd0PmeCGtUxKc+R9UoKp6B/eqARP9r
         9JdJm2y9S/GwguZtE2PP/0bQafXEkwDdG6rwokSluZvOeaJij9QxJkSmqF0OfebcAokW
         MvRv6jYhbf0CfswXpre7iJvjwDWtm/CYyOg0MOtyVsN+K39a7m0Cq2lMHvQhlA5wb5EW
         MrmQnCv35z6I8EGGKI2WfSEvcRE1igQeDlW6747oJ2Qlv6TRwLLZgmvxEqMiIf28h89H
         6xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369883; x=1774974683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E1n0jm9MFEcal142mViLeWqQcIxG66U3otOZkgtm4mM=;
        b=MgY4QuCGKMIL04Pz0zlJmF08NCSqwWSHjMtq+T5N5PDvTXFgmqdiQUbkKm+4+qG97I
         UWdjh34fsNyN6+rNDEuI9iTZdk2uYBiLwzBkUEdIxdoNPB/fGcRRU87qE9YrYqyWbkzh
         BSG41MUDa5xIq1H2H3eTC3YOxgGeiCKtiA5A1TR6+pnrj3tvMTqT85d/cDOibMDuTzwu
         khZL0JTLZUw2rmCFpwPWurw/FvNm95KhWf72Yvpq9ChO0GBU2xSjhtM4tq5LPXPBjbtA
         WQ+x2BDe+cf9yJxap7nsgTv65OoCHCspzTwgQsMRE8ZPMZjy/kEdBjCOviIvbanl6KXZ
         Jorg==
X-Forwarded-Encrypted: i=1; AJvYcCWwBWBo2zzK+b3Hfwi90uLLw774JyuNbfa+mkD+LrTcXDKvp0rLlFMMQ3Q5eX5dU9C7Mn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeYzRr9GlDJShfonjyUD8F80GMvJ4yTW2Jn7Nb6InGLzHIoQly
	4CkHkweGA7BlqqSske7d8GYCelwC/KzrznUTzYKcpNZxH4J2mH9hCwVyslInLT37JdlxSPoa5/G
	HUfe/FsTjqHQtPuejPvG5TUVNCE0sEKQ=
X-Gm-Gg: ATEYQzyVpgUCUI5rijnkldZinATIDU/i+zEH/6LeSuSSrQpY0ZUoedkIaatFD+Pk1HY
	P//cWHyMlPVfj3+qz/xrMFLRgnZvpZO53uWnjupjjdhcceqQLHzU4KzrTJNBTs8nvRO1TjURts2
	X2moXfEA1yFHsI7y9MF5H69tOsXDNQeBaYzhSvgVgwP5hHzHXWmGhgw3ZqobB0My41Zbi3K4N0h
	C/Y8dmjV1ahDsWz7+Vj/IvIgnWV4lotGpvng3/cEsEVGZhxVs89CZWjDHmoxO4uTsPcpixKueE6
	pKupe1j2D+ZDIjJngGRBKawQhR3P1NLAMyQICMhfa68qRbzE8+gzWkrWvUWhAFpRFRLLhmDDFVt
	WPSWl3vgObtad77Jp1eufRK8J8g==
X-Received: by 2002:a17:907:3d04:b0:b97:dc00:fbc5 with SMTP id
 a640c23a62f3a-b9a54240a7cmr3046666b.36.1774369883169; Tue, 24 Mar 2026
 09:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324040535.work.851-kees@kernel.org> <202603232224.C1555BF@keescook>
 <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com>
 <D53376BA-4772-486B-A18A-6858C1732723@kernel.org> <CAADnVQLA3K6v_+_7-+BDVEeZ2N=6229FL6Ko=3ywDWsPVOPLcg@mail.gmail.com>
 <202603240919.D248D71B48@keescook>
In-Reply-To: <202603240919.D248D71B48@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 09:31:09 -0700
X-Gm-Features: AQROBzASv0QmnTOBiLnFwggIWYp4faS2JWWpkEK-CmA9ksB48jHotIISoc63fGQ
Message-ID: <CAADnVQK+hMnUkv5TfOGfiVR+nf59bBX+zaHOvcp5zSZTpdJB_Q@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:23=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Mar 24, 2026 at 08:38:48AM -0700, Alexei Starovoitov wrote:
> > On Tue, Mar 24, 2026 at 8:28=E2=80=AFAM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > >
> > >
> > > On March 24, 2026 7:42:04 AM PDT, Alexei Starovoitov <alexei.starovoi=
tov@gmail.com> wrote:
> > > >On Mon, Mar 23, 2026 at 10:25=E2=80=AFPM Kees Cook <kees@kernel.org>=
 wrote:
> > > >>
> > > >> On Mon, Mar 23, 2026 at 09:05:39PM -0700, Kees Cook wrote:
> > > >> > While the original strncpy() would have copied a full 16 bytes f=
rom an
> > > >> > overlong name (producing an unterminated field that the syscall =
rejects),
> > > >> > but this wasn't a reachable state. This replacement will instead=
 always
> > > >> > truncate to 15 bytes and keeps the NUL terminator, which should =
have no
> > > >> > behavioral changes with the present code and avoids potential is=
sues
> > > >> > with future over-long string literals.
> > > >>
> > > >> Hm, I got a failure report, but it *seems* unrelated? But nothing =
else
> > > >> fails that way recently, so I will try a v2 with the "unterminated=
 at 16
> > > >> bytes" behavior restored and see if it passes...
> > > >>
> > > >> test_progs_no_alu32-x86_64-llvm-21:
> > > >> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job=
/68300440546
> > > >
> > > >Don't fix what is not broken.
> > >
> > > strncpy is broken. ;) This is one of the 6 remaining uses of strncpy =
in the kernel. But it needs a v3. I'll add explicit rejection of over-long =
strings and validate that the bpf test was a flake, as suggested in the oth=
er reply.
> >
> > Don't. it's not a kernel.
>
> This is a very terse reply, so I'm not sure what you're trying to tell
> me.
>
> Do you mean to say that this header is not used by the Linux kernel
> build? If so, that's a misunderstanding. I found this case due to 0day
> complaining about it after I removed the kernel's strncpy implementations=
:
> https://lore.kernel.org/all/202603240325.rd8gRV6s-lkp@intel.com/
> https://lore.kernel.org/all/202603241330.vmNnBWvZ-lkp@intel.com/

skel_internal.h is dual purpose.
In that case it's used by "kernel light skeleton".
but mainly used by "user space light skeleton".
I guess it's a grey line whether it can be considered kernel or not.

> (I had originally ignored tools/ since normally the files there are not
> included in kernel builds, but this didn't seem to be the case for this
> BPF header.)

And please keep ignoring it.
It's not broken. Don't fix it.
