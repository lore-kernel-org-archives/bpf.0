Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794685064;
	b=zWhioaoWuSuu4Jgj+5TocBLceijUoqjZ1b4UobM7dbu3zVZxt5lV+nY5b8v/vR3/QIOU
	 45PYCldE6tLhKje7l1UmnebredQp95PSpazLwgZaTxmue4x6mwrr1d5pPdyPPiuRTmXj1
	 YoUSV8aewWl+qAnHyySWh+kXT+uPBnyM6eKPm86l45lACvvL1wtn9ev3XvqKFX51bFfa4
	 BNCHNp7Nx7/ua0bgiY2N3O11ZZUHCIjmKaFgRjnQJ3xHJEOvtjAZnBlsgxD4KOOhH1fbU
	 yPTr8r2tGYOnl1+4S38QR3xV1yv8fnofPoJsra6VS58Vf8fpMHZ4XJNrSG17nHRUtjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794685064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Qm8L7Av7rDoGKW93wTh1d8Eyes0SFJ+4i4nUVDeAz/4=;
	b=mpTGxilvsBxOaLsARTIcxoXnoUF7SNL1rzR1z/jKisvDqbnt15gO5NdEENt5arc3E11m
	 jbfF+ovXfHhFjrc5kcPBaxw4/STk+p3y+bLPwKWUuZ81bYz2NSGypDFZWB6TcR27z3Mm9
	 TCFz3JSdFg5GdDQ6BMOVavxIHunHa37vnZ1WpVBsQGMQCJKbJPQ11JBBWFnTTuKkm2bBD
	 hXkCPOhMKPXyRggniyJF7niIeY74LUpO8efMHpDjS51yIVoyjYYfCDZYBm4VZCRlmxR+N
	 MvsoAjRNGPZhqgvmjn2Z8SNAFzLPtrA3XdngYioBFa9zqWvULG7bnX1K1knKFxdnjEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JJL9OX6e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0050606A8A9
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 19:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0050606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JJL9OX6e
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ea5600c9cso41315316d6.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 11:37:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794685063; cv=none;
        d=google.com; s=arc-20260327;
        b=beQvjSfXg12yMrA6MNJN0ZebYFpxILDgOUOWxxqg56SRNmGe1VeRTnbEuSRjm/lcdt
         QtT0JXEW6XWDjLqJFMR0EAqqNdD85Wx6Kn3RgRHSCbWlFQ7tdpXjHC+hcJcJQJhIUztj
         SA3R7Zi1Q0QdlYJpYtCGEIa0Pmxes5GLiFsFZYaW0zv6hHXvdZ+OZlOlPi4PwMjMjp60
         nOQgBjT30aSnxMLhQWPgXwev79fCm9/WqF6YzqVYlM//CVSH0VnWYCWAeJUovgNkVty1
         iWiDe0qjU0k56OQC7BEWqFolGREeJsShe4rNvlpxa5UubqlsVQBD7njjSmNOjllZ+40p
         TQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qm8L7Av7rDoGKW93wTh1d8Eyes0SFJ+4i4nUVDeAz/4=;
        fh=GheExqJTH7N6zcLIqNH/G2Vw6y/RVk0i0QD0zEdvWA0=;
        b=iv/474dKGVKTwR53o875Ex/IMzwnuOmIQoQzTZgL7nd5vSPwXLMQUO85o9pAVIuJ3W
         DvOQ+QWhBVU9eaWta3ZZcs5y/eK6I8CIndmz7gISC1IluU/Hm6GtbsXL2eYEVfYOdita
         JlOz5l+DJ0j8WS4GpiRohnSJtFCxzuuCoHfIo9E18g6fU2cykqhlB4L3txlInu2pSd7g
         1mRqeIJO/j2qr6em8NVrkNi3iyDJE+LAT2lkpW/99JqC1Bhh/L/mFuhdvzxLrNojj4oX
         pUtritg1A+geH9PdoEBOZAGKgEjDFkX2m8I1QHSrJHIWcAdTx96anAa4HBHfyNO/QgXy
         m0Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794685063; x=1795289863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qm8L7Av7rDoGKW93wTh1d8Eyes0SFJ+4i4nUVDeAz/4=;
        b=JJL9OX6e1QQ15ZtshuMd2xPO3UavJ/zUpi1NPxVmnvOw11A+spvWruqthTCrNTBNbz
         NNyntpBDI+woFbpDM7ia68ixRDxE3i9xJ8iEC5UkMAdikuRD8mF8pWUKC8X3HQigyHVa
         e2u/W9vAinjaCud7f32aFz0N3AMbGDrHv2VcNQbcTESq+fnnqepaMjerPCamDgeq6GBh
         /pZMz+lKyEvnJYWrw1kuvJWOBXqgAHedQmGgUZHocpOJIOqLRyree5Wf0jnhgMKQa7YZ
         wMPyEVao9bGv2Sv3H80/GEy7T7uflQI6V04cF/8EJ5sW30723C3OWLhNhMu5NP787Lkt
         nmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794685063; x=1795289863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qm8L7Av7rDoGKW93wTh1d8Eyes0SFJ+4i4nUVDeAz/4=;
        b=aID4hX6HmV0dhHbU0S9pxJW3Z5xM6l/mUZdtJHIZ+adMu7KOxiTAzMFTYSE9bu6JRa
         q0ukPr/SCQ0+ufxL757znMt3KPkz4ul0RoeEO4HzkcMN99H3eI3oSwdVd3mOTiIOUiQm
         SrTkHoIEUF9sqo5l/AekadGmqVAFRjkVKtGww5ZEFEtP6RHXwlfNQesBzjimg37TpEX4
         sR2YSLF8ebtKtQC1xgf0Jvkgvj3Zi3D3yBOADyGl+N70SbmPKV42pD24vC+13w5YHbLB
         xcuEAWeD2VNj4vCJQkMFQJ0He9NDspLtmL7UAyJlnlHmHcm7A3dOy/MuetvvR6Uhtf6d
         kU2Q==
X-Gm-Message-State: APuU4Z+iQ0SwhVEafOx9MI2kjpz3Pl82eJ2Ak4IJh6jWlJmZg7pvch+H
	/LJCO0Mes/GJbK6lKj+OPgLdjSAmEEvb9F9RU1/BUlrBZZ4z//sTMLmfElbAZms1fTBa+IXgVoo
	baI/GRP1xTQNeEddCRosoXN4JChpMeZI=
X-Gm-Gg: AYBFou13DCAUbfpW2Qf3m2/B2mBPm3yElUZBS8MCjtZPuCDLbTcDxUTH6w55Gc/zgJO
	08c4RqcOdlfEtRutdwyBHV9CT7jDMla6iFhfTtkB3BbBOWeBdrsTaYO2ae2ofQM65V5KKsU3hY8
	NJGGmp4+UPDtkKNHqWnELouhmw4iwdVT7m4rKn1MBA+Z6t7eHhfm4p2TlV2zrn/6ZSbl1RlUrEz
	bVsrrfsoYLS4tIallOqzmbQmmWWLb7cUA8lcsOh+Dc5ErMZNBv9DuLB49CBeP4RMfYUJpEBGCH4
	/Ingpr4TgnsMcWNykoIJ4ePpqWfnckQ4ltki72kKu/zLFdjhCrrKF5zxbsY+MR0RoM+6e0QQFP7
	0ZMSJIKWQwpbsujdGdNRef+xLDAFQKRR9w7H5Pdj0YVbXw8OCq+inyiaPGFbM0lTWdi+EmzwRZM
	kMZ7TE9+OWnXWD
X-Received: by 2002:a05:6214:29e6:b0:91e:9174:1ca3 with SMTP id
 6a1803df08f44-91f139767cfmr147324986d6.13.1794685062896; Sat, 14 Nov 2026
 11:37:42 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com> <20261114051805.683966-6-alexei.starovoitov@gmail.com>
In-Reply-To: <20261114051805.683966-6-alexei.starovoitov@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sat, 14 Nov 2026 14:37:31 -0500
X-Gm-Features: AclHuK_2DLowkkpD0EJkWYGO3_hDjtG0WiReFJkvr6Kb2pLn59hnMcy1iNdDjl4
Message-ID: <CAEXv5_i17dJmGp3y_0U_f_xK9-SyC9M4GkLCx=pT=4VoXJ4abg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/11] resolve_btfids: Tag the functions that
 return errors
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, a.s.protopopov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 12:18=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> +/*
> + * The codes of include/linux/errno.h, 512 and up, never reach user spac=
e. They,
> + * -EAGAIN, -EMSGSIZE and -EINPROGRESS tell the caller to retry, to go o=
n or to
> + * wait, not that the function failed. Their numbers are those of the ke=
rnel, in
> + * asm-generic/errno.h. The errno.h of the build host can have other num=
bers.
> + */
> +static bool means_failure(int error)
> +{
> +       return error > -512 && error !=3D -11 && error !=3D -90 && error =
!=3D -115;
> +}
> +

Do we also need -EBUSY here as an exception? crypto_enqueue_request
uses it to mean the request was queued on the backlog (not that it
failed)
