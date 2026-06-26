Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037D26B973
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434700; cv=pass; b=ZdugsqV4G1eZ1oLDrkK71R4ha+qcZjWyE1L8CB3A3pbyWLGY7VVZ9DJyDmYC22KcGWDu0icfBgHRr+QGI2TzkgMRxBUvFBzOo5BdPrt58/ZKfHzystA81WcBVXOz9xGkZ7NXe0BkOMaC7f0DBVPIKDLilRfD5kk1X3QLTXfbFbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434700; c=relaxed/simple;
	bh=qDlaZCT/bRkhpcy3xTI5ru1VC2ZNdnSfV7CknniNyvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYENK+z/wytw4+vM+E5reugrJxv9pWSVjtCCaMig/WyNDdsKC5HCUBvaN+7qTnUxHg2R8qWbdIOzEUr5iea+IcCYR25DPDK6FsBVPaXqYtuxk5sLbam6wjhlaVj6xdy6gSZlv9N0gOL6TfXN2XPCKQ2YY0C/0SJvNJ6iIEEIo9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoIX4+VM; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoIX4+VM"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7fe4808741eso5760487b3.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 17:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782434699; cv=none;
        d=google.com; s=arc-20260327;
        b=Zk4ntWUvvlguWUXcz7yhmyViCf5hzQrzjHuIv6yYX7zWHfk+NW9ADAykKwfl5Fs+NU
         KzKYT9SULMQikB0tm1rsXWmovep74fbXZR3hWPeVGDadUWZfjZ0N50BPkG3R3QXJwtRD
         FfKB9H9lmlQeRW+SfvCY8GGDeJShO60xlejA8lWxBPYm7tE3VxVtuKC29HhfnL71GenY
         HK4T6BiZyoCc6xNP5RJZTHUcC8KO79q8tLGWGs/7w/623wdCLpSOEv7eiM2o5rWG9HKb
         m6AprBIuGGrsyGxUUGzaLVhjYErt5fArhOE6OM4JTuCg2TfSH/xLptVwHdRilT5d/m5M
         JvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qDlaZCT/bRkhpcy3xTI5ru1VC2ZNdnSfV7CknniNyvo=;
        fh=4Yx9Gv39zyfLFNJsQdQZD7jOrR9NtdlkEotsZ6QVorY=;
        b=UsZP05HdgCAITheIK9eqISuhfx4OZ9oy7L3e2SP8g/ydjFiAxj8DZx+DjxndwuzQtR
         mZ3dKnAe2/NAP1iGTm6nNAXQ7XRTa+pfrHi7bzxws+9vUAzGqrxpN3V5VF63yvypbQ6W
         5uYpwgFJV3skD5iUNl/9UfYhjUg41lcSf4hIZGHZXHZaU2QLbaa5psPnbvWrilu9zzXj
         vs4VxtZ2rAoZynWK4Vz8KzjtuzGHuH8HqYQubXEyZXT2oJO7bbfDA/lgvH23BslNHvZP
         OwO8FeZ08PYYQj+RiIy8AwbKenJ00AUh2NpcIt6wXnvHvck4gl5eL+VKO+78TPLiPJCi
         2QOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782434699; x=1783039499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDlaZCT/bRkhpcy3xTI5ru1VC2ZNdnSfV7CknniNyvo=;
        b=HoIX4+VMUcp9NOV1AfN64kImvHLusZ0yeKZlSIg7Zr5NshhZMx0xpz9bj5Uh1oMMpR
         vthFoY/GwjnfB704iKTsvgs8Nsm1dzvW/YxiVEl0HvAfZBKnoufqOgwTyLmlFLiP/I/a
         5e5E961abIzy+yyWCUpHl32FiTNxEJa+UntqsQc0n7C4Mas7w/5ldMVtoj1mikcQGRvt
         lmdu2uXBZEE1+1zFy/FhvCBMWroet+qZJUDQ7Evkl+I4OOOZRGLeShdRyTgWD3ZwXuTo
         CYZkJgdRsM0JoQ+I5WuH9uhR6DRPr/lROf/k4lCSd8pxg/TTh0LIdxolRwzgkwJZDYzs
         kFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782434699; x=1783039499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qDlaZCT/bRkhpcy3xTI5ru1VC2ZNdnSfV7CknniNyvo=;
        b=fqPfFlg+RoEHgnU+VYaKHRBrOzmfiPoN2yBj1Dfka7obTcOPGq5exeTRryN5lDfaRr
         5ggBwmEi2K2+pbuN1c5A2suEH4PerL6oPq86N9Cg5MaShuEqRCXDBy5FM13WOkQrWJmf
         2OPHT9ojNgkQnuf4sWS8qr8YrKUgRYzs/q/ZEOkYmWj4yACpAQKUfp8UgcdeJcwYIacL
         GSxsE1HIVUiaEp9qS0B1TS23Qxpeu0+qpXg6y8HEMWvvQ3Krjg3JQzaH/vi/sjxXupOH
         p4o6Lb22ie2rli+gac5TzhmWck9HxcUWa/3+z5v/Bflm4CBkVfCMLJWMZ6t3vzYh3Xa2
         vPSg==
X-Gm-Message-State: AOJu0Yy0QY5Zgx94Xg6RbIS91LDvVm5xkHYhYwEk2QfD7flo0dmlnSze
	nSVvVKxm78zQUXax4aL5fTie9OsCrqgUYv8Jf/ULElALUCGscIdSQZzFododsx+19HpBmwt5Ick
	vDfvv4l1LGoA4eKb0H6eY+w2z7bC28e8=
X-Gm-Gg: AfdE7cm2f59IeKiF9+q29f3xYK6l7cvNFIsMtQenMP9ramxzCBZbAka8rfqqImOXWe4
	Onudxcs4hj0zUuBw+KFo0wiE5g9s3cvBL8fJaNZZ/UlF/mlVWbY3KiI0/UXYM3HNGfdUc+p462r
	EZ0xKxtuqlrpMR81HDLEy7bABBKDl1VLTcrm5Ns5oqFQXo5JAaG1SYzfseZuDuVXdfdZ6teHo4I
	rb3Th7xpQKLFWqpzGkn+zxzwnHDDFrwCTSPmjtluyBmMYbzM8x6xUtWGpEt/QZThPs43vwFcWDS
	srU5VNGq21Nm4IOmGltTEZmHB0UKKxohXy19uFhM
X-Received: by 2002:a05:690c:c506:b0:7ff:ec2:ae84 with SMTP id
 00721157ae682-80a6c38aba5mr46790787b3.46.1782434698639; Thu, 25 Jun 2026
 17:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624072031.735846-1-sun.jian.kdev@gmail.com> <01858c50447df77199abbe570d3ce06288200721.camel@gmail.com>
In-Reply-To: <01858c50447df77199abbe570d3ce06288200721.camel@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 26 Jun 2026 08:44:46 +0800
X-Gm-Features: AVVi8Ce2U8kHbUxy6dShWRtgiFBkuNxyVGLKtEIwEDJCnvZ_KURmKrCP2zEl1Iw
Message-ID: <CABFUUZGoasydgU3M6_tsBw52o-+_Rb0bZugruirGhkdMjFW9ag@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Avoid eliding lookup NULLness for inner map templates
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	shuah@kernel.org, dxu@dxuuu.xyz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 2:53=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2026-06-24 at 15:20 +0800, Sun Jian wrote:
> > Commit d2102f2f5d75 ("bpf: verifier: Support eliding map lookup
> > nullness") allowed the verifier to elide NULLness of
> > bpf_map_lookup_elem() for array maps when the key is statically known t=
o
> > be within max_entries.
> >
> > This is not valid for array maps used as inner map templates. For such
> > maps, the template's max_entries is not necessarily the same as the
> > max_entries of the concrete inner map used at runtime. As a result, a
> > key that is within the template's max_entries can still be out of range
> > for the concrete inner map, and the lookup may return NULL.
> >
> > Do not elide lookup NULLness for array maps used as inner map templates=
.
> >
> > Fixes: d2102f2f5d75 ("bpf: verifier: Support eliding map lookup nullnes=
s")
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
>
> This was already fixed by commit:
> 53040a81ae57 ("bpf: Keep dynamic inner array lookups nullable")
> Please do not send stale patches.
>
> [...]

Sorry, I missed that this had already been fixed by 53040a81ae57
("bpf: Keep dynamic inner array lookups nullable").

I will drop this series.

Sorry for the noise.
