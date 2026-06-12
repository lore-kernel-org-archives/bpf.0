Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8BC3672AF
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303846; cv=pass; b=RL8Z78SFb321t714fjkcGweSI1hvzrFbcahMmGPlFZOFBgvL7vJrC1NUmrJizuZ5PZ/R1QUAtv83lrFx1SkJY0Op+kSRqKbjjGRlg5NPpX1rLlk+rMTBYJ7tEH7/VIcYQW4mQykJPmycnDWSrAAyP4kzSOqqdWx9LJdooNZv4Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303846; c=relaxed/simple;
	bh=shUFY6eR6Kw5Jk/HnGXs1qKYsFlLO2yzvOdsRkuoJPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCbVM3dLO2bWFzAzL94vz06+iTS/yfajor1UDJV5+x7AcHTXzdZ0n42fmg3Bt7H2zdbR3Cb8FymouJX8K9e31piMiYDVDTM9Cn0UDJBwguSktW7xIloM6jc8zyVoxT+U6vAkQN0OAKx/nWKkyqqD1u0pZY1OaspjY6izq5EJAhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=TaShrjAj; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="TaShrjAj"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa5f11deb2so1580643e87.3
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 15:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781303844; cv=none;
        d=google.com; s=arc-20240605;
        b=G8UjLnrmGXELGtbpw2gd++qc0PjO62GhXi2PYP/Azl0EMDR+ri1d2a/Vgb+NsjWQHo
         gnrM+jFebwXeYvfxUKzSYLhfIc8zTEaTMirTVsKzJV8qBORrzMNczvSC4Fs+Nul+Ffhj
         D0pQAqITYDfcTHBWg49YJlsq6RqIgWqQbZjzdQ8ukII1HLbkYaQrJyAQs6b/fTpu94vY
         Tzz0kwWHD229TitPkUrspihtpkrwxbYWbThKk4hMtTvwvsqhS1quiXGYDnIsLeIuinOf
         4J4iHJ/afWI4NioHvH46YNPslhoWo+bVElrDRObON5hj8kjGRPiHrjKOr4cUc1bZrhdg
         FK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qRDSVPYX4+J1umfJso5OGIHxT/OMTh7WFNoojXu+zAc=;
        fh=MSKF0fHpmqxTYNMJo6+Kk/lt0TmwhFY8RmhxLPDCO/U=;
        b=AuxTpn6g7UzNBw1dZ1H6QK50VKTrhZ4kQzImLwc8sJw5zls0IUUA797sGguGFls4cp
         rvablWU076BUqt/m7FfbfWN8h1txNFTNf03CI+cM3ehWQB2KlgJt/I3TuHju4rc8RiZW
         S5L9nWljpblwpeSKlLZ0WeZHREnz/dajJj23ShZwC6ul4/iEDWU/q6UxdkCUi3KRk1rK
         YfTaU/jRdPo79SykrLkF2F1cLFvAONScABvfD4/Y5oe/3D0wdapv2qcWZvqKJZBAV1Gl
         7aGQrAS+sVXgpCXCTtOV7z9vmpX4EYyCYTBMZWtH1PiXdEONrKCku/AdpW05+Qte6ZNL
         LxQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1781303844; x=1781908644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRDSVPYX4+J1umfJso5OGIHxT/OMTh7WFNoojXu+zAc=;
        b=TaShrjAjgi5eEEKjZwZIK9g8dYI3HAYovmptN2gJS7+AFEB2LY9o+uYTZij3Lu8iwk
         61FPviWA9esTk0MX67f7B1HcwKuc8Kj3gX8DXPLTDVP1BmT9QwBE3Mumw/Dv43vYUTfb
         lJzyHkLOjyWc0pEYGrk9aVQBFfa1kTNv3pKwQF3pFIwbLYWf2FA2npmu26a/FOMuxds0
         M9ORl4ESEikx53mGD9PSJy3JEm+TGPQ9+hPbhbnRNKzPJjv85RGiVhu/pPJ5r6mYwQ+y
         D4STn9oyv+CDFtVWVHN5JsQyBAa7sCAkoXV/ru+5EOeAVPa5pWf8dFaf3mCGqTyCamDB
         A19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781303844; x=1781908644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qRDSVPYX4+J1umfJso5OGIHxT/OMTh7WFNoojXu+zAc=;
        b=JpgZ4pAebQHZE/UKaZfrfMMp8iDzDBOWxZLfhJWcp6gYPrVkvAameENeRhP8Xtsk/F
         v0+3vxzJ2m727otf5Xm0qVwcycBW2ISdvI+c2Zi1kY8pLWHjBLUh2AkKDSlR4Er5ypCu
         4g10ktDB3OqlVJbmlAjTShDWrrZNtAmFxrdFiAcpjWXkTidaLJSYkEKY+v3znWb2ssys
         SpV4P+6/7oxgNZnD/Gd0/Hnv+uK8P9/+bYQud0lardWAGxFSieOdpy87ls8PLBfuZmXv
         fzurlYrWmMqrC/pxWi7xG9NhiU1V3rpOLND4kvEiX/s7ne80sJxVwFUSZuWXLaYyCliX
         DhYg==
X-Forwarded-Encrypted: i=1; AFNElJ/vnfxZnH1pWXLuotucXqKjj4RaBXSigGVuJ8ZfK43r3a4QvhTOnHctILTtPMReqbymAow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF1zIzC0Plkpw1Ghq7VL+lvs7Bb2RJTut3Luh+mAyPnY0bwKnA
	1NC1z0zHp3qaubjDwz/zswli1kH5zvEejxPYcukzZcFlHJUtV/zhpV0UB6+szipGrlCEgKnWW48
	IbHvWvuGzp+kp1sKoMVAhlwWbV2/4gLqay6CbmA02
X-Gm-Gg: Acq92OErmRao5hGA68CnKQhklsg0XJrY0xSJIkzC5Bzcdt/DtuyKirO5enJAMl5iFGo
	D18fmZkYqATJrZD6gJCYgSLptOUzLN1tfsAyiw1jlsLdgPySJku0n6tdKFU9HlwYxhouRKhYjnH
	hI/mekq2DYizzrYzi+Rf0dEkmZNdXpoYbCY1KFfQI6wvXazMGLZYciYbkzYhRAVV+GxgCAIm6CW
	0QobqgprvXZhC7iusGx0REDmoUjptUfqFnaVSG7imfBxf04N8MlFLEX0lVT/egzXlRytVS1zQnf
	6EXh
X-Received: by 2002:ac2:596c:0:b0:5aa:6e3e:6772 with SMTP id
 2adb3069b0e04-5ad2db5c247mr1075245e87.29.1781303843459; Fri, 12 Jun 2026
 15:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
 <20260526-seccomp-combined-v1-1-304b1cc3ad24@hill-daniel.co.uk>
 <CAAFS_9HpxOgHn+qfzSpLjV4Mj_CURiwxFOaK9GO0DdBg8xgNYw@mail.gmail.com>
 <CALCETrUArQBzUS2mAhYxDS-unze_gnQ7efv1qeBke-ux=2KdkQ@mail.gmail.com> <CAO1UbGcJEhwtHcxy5zcc8cH=YjfSDiDa2o-o8o+LMbkmL7WFcQ@mail.gmail.com>
In-Reply-To: <CAO1UbGcJEhwtHcxy5zcc8cH=YjfSDiDa2o-o8o+LMbkmL7WFcQ@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 12 Jun 2026 15:37:11 -0700
X-Gm-Features: AVVi8Ceyq6egGC6bWwlZ6FOzqJh71mRJI4TuVDzpkA7OZy5VNWaUOs1BEOkAoEI
Message-ID: <CALCETrXrAs5R_u-Y=1qCg2PvW=xx=hMZovBBv9UmKPkVCedv9Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
To: clubby789 <clubby789@gmail.com>
Cc: Will Drewry <wad@chromium.org>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:02=E2=80=AFPM clubby789 <clubby789@gmail.com> wro=
te:
>
> On Fri, Jun 12, 2026 at 10:24=E2=80=AFPM Andy Lutomirski <luto@amacapital=
.net> wrote:
> >
> > I wonder if It would be reasonable to have the kernel do this on
> > behalf of the user program that's asking for STRICT.  The
> > implementation would probably be trivial.
>
> I experimented with this approach after the initial AI review, but it
> turned out surprisingly complex,
> requiring a decent amount of refactoring to allow installing
> kernel-resident programs.

Maybe so.  But there is a function bpf_prog_create (as opposed to
bpf_prog_create_from_user).

> The filter
> itself is also rather complex (mostly due to needing to account for
> BPF jump sizes, which differ
> as different configs (uprobe, uretprobe, SECCOMP_ARCH_COMPAT) have
> different logic., and I'd worry about
> keeping logic synced.

Perhaps you and your AI could elaborate?  What are these jump sizes?

In any case, I think the actual issue is that the STRICT filter's
failure case doesn't quite correspond to any of the FILTER actions.
So maybe it's too complex to be worthwhile.

--Andy
