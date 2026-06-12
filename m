Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F52389100
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303855; cv=pass; b=Ec0747CZkukMi3HEvcSCfOZWUOUMtEyeUpUhTWSfEiKW5IqEFz0YsZOmzpu4Z178SsZB/1/mjpGsBPbgUO14hoCNdvnIr59axl976kjPL16RMLSu73ClJ3dR8b/wUugw74s77NI31QbPs70p9v4oVX+8dsxlUg5T4a8JTlZ68Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303855; c=relaxed/simple;
	bh=upxYdsljs1Q3FobyTQ4N3L2JqmWumXD9D4kqsVO1Mn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeyvkcLSlHxW54csG0bnkh99soJZ7PwoWKwvpDW/Z8HzUQurzLhghFe6GJNBZkeKfVoGKpv2XTzxuupmkydckDNsNKQV9JfuCbLhbOV99ICHCJPar16mduJ43q4Ov8kPwVie27SpGzjA7lTzmV0VuSth1nP+GNjA+qW3A46sDHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCYTY5sb; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCYTY5sb"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51778077b28so15497061cf.1
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 15:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781303853; cv=none;
        d=google.com; s=arc-20240605;
        b=GxDuBuz6zt90ODBQHS5DsjjwdZXY+EQUrQpvbBthFQy53x/RMc8HRqsECTYoH/E4a/
         jgnPl3ILR0uKs/EhyPHQ/5Z0kx0VPE8TSFZCrilSpr+hFJTFtp4R7ukRAaMipxzUAAbp
         ENfuofL3Lfrd3q5ex3mejacXIiuvdGlbyZlN8/NK9eGKWBq/PEOuYuXwYsUlzGn3Wc1v
         NYfsjphfj/EUrxp7kbxMuiir65hNxfuXLwfm/wdDSPdLnFM7BjzHH8twIm/k9GJgHQ2A
         /bQoqRJvm+V+dr/voKxG3JxqiYovsC3t/ZMmlYzWfHh52mBD/tlUjubIH2rVQLeMIttF
         bN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rBRAHcebZQ7InUHNMGol8uXlGZUk31ysomU2l/3gZBk=;
        fh=fasCMz1cCqW68EhiD5+wNKOYwk7DeThMxe74/5vaSqU=;
        b=jgGqUWWpFePO/HHIM/9AoqYAP5MB65Qyu5dZ+ojanBL5GWyHe5m7HrRVtimM8cWd1M
         S5zuUD77Knqg7R2GAYXoKlfSQ0jwgsfm7AGTol6yc+7l4y1Fy20MtXr1fEbB67HzTg43
         ytysNSp9i6pUFY1IME2DQwgBZMOLORcbcxHfQQeTAcI2kHn92GzpsTKM1MJo5/sNkhNV
         d1a0ZgKoLHn/0/eId3Fr/NFsgmzkOgnjgYPgf5s60gHPb+qRmFKP1JeaRLaWhuJoz0I0
         tZmxUJ5f/IWaFwX9W2Mkghj/N94MCKpN/meRexc6AOKLYQ84erMgLjy5I6fZtK0TWtIv
         vYzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781303853; x=1781908653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBRAHcebZQ7InUHNMGol8uXlGZUk31ysomU2l/3gZBk=;
        b=iCYTY5sbSdPsbXX+Ikcrb9lffX5RC17UTN2t8Qd58+V+9775DZeBZm+lXP7o0z7Hsg
         KWVt1wz0AZQGE1FJBzyJg24wDt14s/XlozKQxDoFiIJA8g+reTnWQic0brbTyC6+L1sP
         AB7WjHqBEXIuMzLNmlg6f5YLdjdEnt1ywIOKpHcWhScdcdsLTafMz8hS+3fmNii5whyR
         rr6Wm+cMJOXnKEK5naMDICLrAgM4XlWHR0t2WfCddk/Rr00O/6bHIdBbGTcZw/DC363s
         TjZ6Su/15uokHWnJjqqSnVCWQZqOln0+NaMpR2NpNRMeKC79XbhCRVCZuo3bDkyStq83
         Bl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781303853; x=1781908653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rBRAHcebZQ7InUHNMGol8uXlGZUk31ysomU2l/3gZBk=;
        b=W2pFwQEiSDOkflMY4xUFdoNPEr0xGYxUe6Cnr8LNWLYm8bvmrR5FsXIIquSIVqS3zA
         kXmhJxA9IT8eQamuuhN4OkjRzakt3/+Q4B9NUF9SKINGGWslwKnkSNh7nqMQwqJPBkpM
         4dFHSL6jFESEVn3vTN+/l5nBNAAkqtiJ81kPMc2nCXCiMonJUFT3ISvZ50ewdTbXLohw
         AjFY1ka0P8e6XWT8ybfts7iqJmXzXXa3lfZI19bKXuZcRVk3FCwWAmbjQpSoBmpKVrr+
         10rKd4WbcnpfBoG9okS23QoAfrro1HF8ZoKu8tBDAh0niGw9lERb0hFGdeT/d28vtUyA
         3mrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xJHdB0VgWK/fyGt5SKNnUtBOFterWMl0Shw46Qr+d6yftbQ/Lka+jd7kHq0O3Rm1zWVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbsT0qEkOcfJRA2Zwl1Oc43IJdFNZLV/XNWJygCxH+W8p+v79+
	bg6BU+uplNNyco/qmFX/8dkfU11DfSnLa3j8iw6pg0b3+kHxIq2shrK6Lxt4BkI2ZLrhjdp1ZHl
	fdkRHV5OlW432zdbCQPNdOKmoDRniIou5PIN7VzMHvg==
X-Gm-Gg: Acq92OFaUwzFcSHf4SUPFhUt7m45ddQrDP5u4eaMgGSO06yixoQEOdi1iTG+GKHfdbb
	GAxQKoP2muvTaP0wnFrMVPWWCssvI14oGPhO0EPFuOTK8deMh1VdBfiEwk+2A+6w9c5gkwbvGS4
	ZxQR2DhtDztMC0a5nd1KT2TqQcTMeYVkAPvULULq+44liXwJy0uXUXNSN876EMX0sswlAvCwYtw
	JNQTImDM3oftNJnj1u7Ai2w2mUmDH3T81cQCe/khMYBsZCZL4Hx8zLhuZnQaxkzI1A+F5t1nDtl
	LyFAdeYb5aMNkN7MU/yw/ozKOZoXgt6lTDzZjw86AoSc/fI3N02Kp/zGnVFYf1ZZf9xXGE5+pU5
	fdx5n0lst
X-Received: by 2002:a05:622a:5147:b0:50f:bb77:a084 with SMTP id
 d75a77b69052e-517fe48d46bmr70305501cf.25.1781303853375; Fri, 12 Jun 2026
 15:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
 <20260526-seccomp-combined-v1-1-304b1cc3ad24@hill-daniel.co.uk> <CAAFS_9HpxOgHn+qfzSpLjV4Mj_CURiwxFOaK9GO0DdBg8xgNYw@mail.gmail.com>
In-Reply-To: <CAAFS_9HpxOgHn+qfzSpLjV4Mj_CURiwxFOaK9GO0DdBg8xgNYw@mail.gmail.com>
From: clubby789 <clubby789@gmail.com>
Date: Fri, 12 Jun 2026 23:37:21 +0100
X-Gm-Features: AVVi8CfgjBSgYWbftHOxOIpBd0igqwxLIi0I8C044rd7QU4om_B4hew3bdGZkvw
Message-ID: <CAO1UbGemPgHNj1VYONQGx3HJbMMmORctF=jQbGPGUFQYGch7qw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] seccomp: Allow using `SECCOMP_MODE_STRICT`
 with `SECCOMP_MODE_FILTER`
To: Will Drewry <wad@chromium.org>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 8:25=E2=80=AFPM Will Drewry <wad@chromium.org> wrot=
e:
>
> So I have two concerns here --
>
> 1. By layering, STRICT becomes subject to FILTER RET behaviors.
> 2. If we did want to layer them, it would be ideal to separate the 'upgra=
de'
>     decision from the access checks and make the layering path explicit.
>
> If you are running a legacy binary that uses STRICT in Docker, then I
> understand the goal, but there are userspace options.
>
> I think it's hard to want to open the door on changing STRICT without
> a good reason to work through all the implications that come with it:
> cross-checking every SECCOMP_MODE_FILTER reference, sorting
> out thread sync interactions, ...
>
> That said, this change could be streamlined and look for ways
> to minimize any potential implications.
>
> Am I missing something or overstating it?
>
> Thanks!

Thanks for the review - I'm currently working on a new version which
addresses some of the implementation
issues. On the semantics side:
The current version runs strict checks before filters. I think it
makes more sense to run filters, run strict checks, then return the
filter result (assuming strict checks were survived)
Since the strict checks logically work as another filter layer,
documentation says
> Synchronization will fail if another thread in the same process is in SEC=
COMP_MODE_STRICT
So refusing to sync threads which are using both modes seems the most
reasonable.
