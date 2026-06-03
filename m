Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3D45348A
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530527; cv=pass; b=jJC6LILZ66kRKDNAGqyegeT7o+SXXb04Ss7eu3J0mGZfQg6WUOrogHHgZTR3S91ArCUrwoXORLzbdRev1Umv6MxFKzoH6XaUNe/gD1THpBadF4sgvWNGqes2RtpLmA8wcJxdhLtXJgiwPsZaOS1EjV+qKV09pXjPTaVVZn1JTKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530527; c=relaxed/simple;
	bh=f6Hzh8wLZoswfxk2b8mpTTJKEEdA2RpquJ9Y4az24uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAxMPiFHQdhYMkfLaRh9RoYS8Gkd3cVQCytIPOn8VzIj+9vpLp8OrfU7vetlF2ugQr7Z1FJZSWalJ+t9DfoBI4hFqX/uTEes3Jwt7zaQReu2kBJIvt+m6G91XNpSO8GPxZ6ZozwtRMeWWcLv2RdyNXAOC3FS44Hq++/5XOh46dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YprLbVfg; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YprLbVfg"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so11062366b.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530523; cv=none;
        d=google.com; s=arc-20240605;
        b=djHtdjM9MDcNR8MLTa/4d0aRBH7E9AVVWhqIsA3vVBhSF/EthWyILUIaFpSyNp/4Kq
         qkdX9VLTX+h3NR/VzB8bWmqnCBkfjGcfdrW28/iscUbHy+N5PAp9kZztVoDf0BTiasUK
         sQ82reJb/146Bv6SofYId3xgH5ni5YGewIQlUjCMq0yhoJ/nbwWJI3iWlU5+ompxXIOC
         3SQcbi2V0wjmbg+LlBAas5A1tKVsff0IOi6wCK7AOzlnFW+thTUkA8wspTvTgJ+tVdw1
         F5J/DwM8bawmiThJlqTxzZauHadYM+F/fS8PHOGtgmG6R0fF2cXiUM69a15j3FO4tJC7
         HxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UrZvLJ0+QctbH+SbOVRfngHn4+RjcqJmVgAZ6B0SozY=;
        fh=E7CD5xVHnx6rzK1AUkQxJwtXX7Bex0CXXADU6Lg89Vg=;
        b=BbMnJUhOz2wvDd1r4qxxM56yhDmglYlNfUlbSxVHEr0tQbkB8TN9qGB7nSAe2v4ZBz
         rDQXWfxFPSGu3YD7cO0qyio8oaSiqP8GFZmpTCFfNJvcFpPrzxJJNaBDLWoTuyQvZZZO
         ETmCJxdQmfmC9enLpPhucHrmSGys7jBTohwoReoOZSiNVuwKs9wFHqTfK+/pGNsavvFO
         j2RpqiZSCTzv5fFia4/cd1/4baaginl0KqZiYZ+9CvoM3OvOv0/ZEVz7p4Rv1ekCjD95
         WTqTJJ08yAvBgSfwi2OtKMgQ4EkypIoVE4iVm2bIWDousit4GETovu9cBzDdf3gT2mcQ
         dwcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530523; x=1781135323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrZvLJ0+QctbH+SbOVRfngHn4+RjcqJmVgAZ6B0SozY=;
        b=YprLbVfgdAD6Tfkc+W3A53M9nVysDkfrHJ9TL0MhOeHR52wMXq+eQ9sGxHee8wpxRl
         sSXvxR30g35gFvbSO1wxrfNHMTI9OhsgXSE/x38H3EpHSBwbm+ICFOW8zAtDRP2RZ9pl
         LpEChdRYDFyokUyD7jfTFx/8EUTIcE9NUyUMXIxZlPjkVsOVMA64Y3thSB9OFOQM6zkv
         Irfnhf02F74upAJ2L3OMiZLlpyX4REgMzrJ6XQMF9Ov5yeEstrSgAez+4R8AixNxhowZ
         NaEq7gTWbxQd1yPcX14oy7ISTK0GSwHFQOf17V6TEjAmSifUxtdJo0lLkBKRVHYiGyYL
         kF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530523; x=1781135323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UrZvLJ0+QctbH+SbOVRfngHn4+RjcqJmVgAZ6B0SozY=;
        b=XOrVx0q4s27QQlLEzNDa0cHb04k2iYmIQQ0CBq7D8fYAcq5rrwPtDN+YQ2hURuT0zl
         AsyjIt8j0PLhKsDgKPL9HwBmnBy8xiqKvaJro+uvkqMz9WtxhMXYNWbz7Jxv9eDAhbUL
         W6BMn4QgsdB/siVDuulmqPf/zq0xKgufyrmXdoZ7iS3yzvPEv95X/uar5PTnNMitxAtl
         Vi45gjrK5Q9PlbrhIXj9aZK3WLvMBiUluqNpU9FULNi7Zu9O30NBtMdxLCiLT0aesXqZ
         o6VwfWDKIgM2tE3nsusLN/cYWl2BKSVnH0TI0hXIKGxBvlmK77gWPxb2rFEdhgibsZGI
         IwsQ==
X-Forwarded-Encrypted: i=1; AFNElJ83k0j6EwwrZI1xEXVSn2uVmGg8hJ0MPbGvumF7No18aqHFjbiDbYyI5kf43svB0yX9Okg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/dB4L/vchavVUp2K8fapJYgrw7xwtd+GU4BAdk63vX9fl8MA
	SwBwADnqEVXRekC7BZFeiC1w91yjSe1ZvpBulKsQpq+NRW5NNknk5P7MgkUh+GEyz+xJ4IAPMOx
	LxcV/E/vDjfsPINE3GlZqxZ2BqrstdyE=
X-Gm-Gg: Acq92OGyAcnyczX8KgefrFxZxuXcTdk5t/BuxCwOg1IsYrYHudu4lCuDshBHfMnWUwt
	CwqaDid4LJxlgnNXePVP6R2KNjFAwicIibyVSgiUGefMLw3ujij+S+M5DaV8eEHZFGRjb9eDl/L
	dU4q+ynxysp3PynqiGNmV+pTRNWFr13auYgF8/3Gd7mpESXAeMsoHFRaq12ig+oxCFKTk9EYndp
	Fe7QDnzNdmPzDZB9u2Xyff3ocmK3DDVXGkHhFA/e2jgHDONaO+uRJ4cra0IxF/4uovRpjZEXiF2
	XrRy+ni/CG15FBrV46th6d0rT6voJxAf8TjcCDEI8k6NVk3oRdtP4i/b4jJM0K5RoOps+QnJFO0
	=
X-Received: by 2002:a17:907:7f9e:b0:bec:f0bb:66f5 with SMTP id
 a640c23a62f3a-bf0b2bd07f8mr322742566b.30.1780530522749; Wed, 03 Jun 2026
 16:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev> <20260601221805.821394-14-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-14-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:48:01 -0700
X-Gm-Features: AVHnY4Iu0b0fxJL4EJQE7HKjF47Z2WnKGySX7L4rJ75qadJJeFQdPJkrrK014PE
Message-ID: <CAEf4BzYBHWKiTRF-Mf8ghPVPdWrpN79MjG_eBQ0DybeH90i5_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 13/14] kbuild: Drop decl_tag_kfuncs and
 attributes from pahole flags
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:19=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> resolve_btfids now emits all kfunc-specific BTF annotations for the
> kernel: the "bpf_kfunc" and "bpf_fastcall" decl tags and the
> address_space(1) type attribute on arena kfunc return/arguments. These
> were previously produced by pahole under the "decl_tag_kfuncs" and
> "attributes" btf_features.
>
> Drop both from the pahole invocation.
>
> Note that "decl_tag" (generic source __attribute__((btf_decl_tag))
> annotations) is a separate feature from "decl_tag_kfuncs" and must be kep=
t.
>

logistically, this pahole flag drop should go in the same commit as
resolve_btfids change that adds all of its functionality... which
probably requires merging few patches, but given all my ranting about
not doing "ensure" pattern, it's unavoidable, IMO



> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  scripts/Makefile.btf | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index e66e13e79653..a1812985a61a 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -14,9 +14,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)      +=
=3D --skip_encoding_btf_inconsis
>  else
>
>  # Switch to using --btf_features for v1.26 and later.
> -pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j$(JOBS) --btf_fe=
atures=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,con=
sistent_func,decl_tag_kfuncs
> -
> -pahole-flags-$(call test-ge, $(pahole-ver), 130) +=3D --btf_features=3Da=
ttributes
> +pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j$(JOBS) --btf_fe=
atures=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,con=
sistent_func
>
>  pahole-flags-$(call test-ge, $(pahole-ver), 131) +=3D --btf_features=3Dl=
ayout
>
> --
> 2.54.0
>
