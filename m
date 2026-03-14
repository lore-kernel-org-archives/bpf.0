Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA431A9FBA
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 02:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773455605; cv=pass; b=nqFCFG/4dyjpX1FEtSGqyVp0iRUSFLVzX+0ddldQekJpxHihOsUV76Toxpsi3WygLBW3qPHoTXxCa/Z6Ukw6o1JrtROSqVNmxF+nY2k3SS3ZPlwOirXWVvpKFJ2jgSP9fvVGf6YMuQj1X1X06gtrBV6pX7TKTqlSN8kS+UQlTD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773455605; c=relaxed/simple;
	bh=vKDPGdTwegxJWvSAPocWRbgA366ZW3x1QY7yGfL1ZwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+H4CovdqYyUxlke85gzazv9ufqv9sL1BXp1cJmjbewzO/5AYtY4XuxzpS6OxLBsnLKvNZ7dUr8d26ffVEqQkRi2CA82utfX0HVBkSJ6km6kPpO7LZCHua1prRoD+V6hBEpG/jdn5GhQArfZIGtVYmDFqNJmSuYkfp1BIMPHG5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHRFX+4I; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHRFX+4I"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38a76ba6a78so18984241fa.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 19:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773455602; cv=none;
        d=google.com; s=arc-20240605;
        b=aOXr8m0a8AEMTOjNzYm7XShKJ0oK/6evjE/ONhXttgfoRWB+C4c0jnE/Dud2DzT5wR
         RuWp0l2OYaNfxRplM0T89jce7mYaW7eHhksKoA6p2nm7ah7TRLIve0DhscIt8b5EXry6
         udOcfxKAVPv2UMSLLpUMnQVdkqlCqcrFgaXiga/ov5aPw4NEmiNouDZcle+0IFw9IunY
         5QRhc2i1Zy5siiOJy3Np0RPd0m9P7cr4Um1S6gw/i3PhbNiLdAuLV0Ei6uJoMk3RTM2X
         yEfPZrNUHGOby5d+1bdANIlA3kqe+DN/iaYfz8LOcewXx4KrVOyus7Lhp5gZvyB7FNru
         VJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h7hoANZMO/fIW4B5rx5MOjrfxc4bWU0fpLY9qHlcpl4=;
        fh=bC3mWDr1SSZnIGbOv7Kp75UKSq0Og/t735TDjTBRkNE=;
        b=HzY7CGiyNOjLXDLKU+ktRlZKkMkJnRqqRI0lzLutNXRtS4Xcs0luISPivzAmySs8Mv
         WDbEZY4p+A9pboi8fu4vcYPZ6JtHM3NrhCjOAHwZjTti7K1FVhXT2bSK3TkInhvUX0ck
         mJ31pfJoGcj9mQnmM60Ujl6HRXnosJbRZ/nb550un8H1V8sDINTSdSyHmNfis8T9tTS9
         fBH530/hoW7q1linGojqs+BNH+MDH2TS8Ov/r2HxcnXL9jaxSqXazr3z+3uLag+GlR+D
         /cCBpi2r9bpq+R0FdWisnDRJG82c8I1/cJPZSbwbg22fUh6JAUJBeFWXcTzkdTz6bfrR
         S0+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773455602; x=1774060402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h7hoANZMO/fIW4B5rx5MOjrfxc4bWU0fpLY9qHlcpl4=;
        b=JHRFX+4IkkSn8I1WQEI9G4gd3mG71TM9nHuJFh3G9m4KzrM2lP4lsiYnGiN7US+WkE
         kWdVxq7LlcqmkmB4li+EpM5tnKulhpzxgvqRBHTt8C4j62MEixom+73WXsuHEzj3SpaL
         dpWC8b6FHwRZpzp3M1PYoBJCLoNaQEE32ooKg9J34Tgb/Vaf0t/r7RqJLh6FmVPAdsEt
         TZ7N2RRab7/HOx2c5VAO5Ixk8MGakqD5foet/fghRM9QOmRBL5WK6LIc/MwD4V5CNUsj
         TWsnILBbGxuibECzwAdiEB8xdV7dPpu+B/G3NUhgU2iO1DuHE5FiL9243CFymDk8q2/z
         Un8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773455602; x=1774060402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7hoANZMO/fIW4B5rx5MOjrfxc4bWU0fpLY9qHlcpl4=;
        b=qSyH0rjNJXSeq6Fpw+JQFMTwvmx/FLAFR3jwBUZQr03D2BS79mw8baxvBIR4Xr54GS
         a3tBtl1grmMULrEWZJlRVFhnwh/fO2kQLlIqeZPjZOIgpyolSNFRuhm0FSJd1wVAaay7
         /bWKPZOAKWVZ00GbzK44JfsM8+B9tPjw1L8dP+Tlxj52HVVc8Tdrvh3IWhBaQ0oOeDcI
         1XwDfEgBGK+ioE5eZU+dNL8I7h0uR8R9ZAlENx0KGFXPn/UqT9/xeZbKZM5A8PCSMs4r
         nsvmhENQ/tYldaUVxRIOjLYVoMyxsV3cxVobsLwMtNQJXsAp2j8MSOuwTh40VFqTdbB2
         58ww==
X-Gm-Message-State: AOJu0YyjC5YFoKTSeUqfGgvzW1eEMKoxsWsIJASWPAq7jjuDRSVCDOA+
	Nveu4HrkWP9bq0GgCKHyuR5GkqDI8fAm8IRIc4An/7T/0ZA8cTYZ2YxuYpgLjUQnYdC4aCCuJ+c
	MqYqeRouBgOFNrmfmKDJCX//uD3tTB6Y=
X-Gm-Gg: ATEYQzwNebMaZiZ55QxoVxW4WphSkKt5+cEYKG+gZHMi8FlboZCxZsd+0NMZ2PZdDyz
	rb09Rw44Q6eQdm2vT+4iZKhBYOjzjd201kjajKJ0/O/ff8f0eokz495UbenMunsGIrkZMrt1vWo
	Y/1uPfGewSl0LoD+Ep+mECu3iAjUPmVSh9moBexrAK7pubBqamCIrOHjSGdoSVv83rdxXlYpThj
	f+OY8I5QXt+0gXQU75E9YfcsUS5qMk8r+pxvQWIwlJ8Zs5ihIm8sCgBI85QyCksbfOPv0j27hmC
	eNF4Fu4uGR5fOZB/qjiHBWStXOAO/y1DEA2t0Wr5QA==
X-Received: by 2002:a2e:b8d2:0:b0:38a:42ec:9f84 with SMTP id
 38308e7fff4ca-38a89665c8cmr16872121fa.4.1773455601804; Fri, 13 Mar 2026
 19:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313075318.11847-1-danjwade95@gmail.com> <20260313075318.11847-3-danjwade95@gmail.com>
 <CAMB2axOspp-6cAeH_a9AjuixJ+OgtzxmXyLRPvM3T-w02CSArQ@mail.gmail.com>
In-Reply-To: <CAMB2axOspp-6cAeH_a9AjuixJ+OgtzxmXyLRPvM3T-w02CSArQ@mail.gmail.com>
From: Daniel Wade <danjwade95@gmail.com>
Date: Sat, 14 Mar 2026 13:03:10 +1030
X-Gm-Features: AaiRm51Q5vr_jAgywZgsFh99IUsIV5k-fPk32PA9RGtCQp1mRZZAxl5ABRGVVVo
Message-ID: <CAMn7ay9vu6ZJPUYmz=T7tg6p4feR8Gg0v4e7jZEF2qoZqg_dAw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add tests for
 maybe_fork_scalars() OR vs AND handling
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Mar 2026 at 07:48, Amery Hung <ameryhung@gmail.com> wrote:
> I think the proper multi-line comment styles mean something like below
> instead of the netdev style you were using in v1
>
> /*
>  * r6 is -1 (current) or 4 (pushed)
>  * pushed path: r6 = 4, within value_size=8
>  */

Thanks Amery. I have updated the comment blocks in tests 2 and 3 to
match this format and just sent v4 to the list with the Reviewed-by
and Acked-by tags included.
