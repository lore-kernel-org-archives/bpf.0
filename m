Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D9234994
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788053642; cv=none; b=MvoqHw1IxcflfbDmlW/20mLouS/tkhM7iKa2SRGH2n/GufSdLsqCmpCLxrAwjz1LyxoBMGJxrnHQMFu6+Z5JkkwCNln1PBp4lkMgM03U0WUlPxPLC7Q8mKvpho1pqiijTaLo5GEKL4mGTHK0x+RxDY06pSYv9GAuovhoJsAJchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788053642; c=relaxed/simple;
	bh=fJKEUxrz2DawVVxQpxx3RZExDceTVOaUwMjDq2fLUl4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P73Q0BaW09hpFdENkezN5y2RYdCU6RMdAdHN711kWAKRUNS0Wz2tQ8gvku0yVqpl2t5HT1RbZZpObefy/8mFkgUhWzZudhv+1mf+Kxt2oeTV4+QyGPZnsBW/9dHNSQXHfXxxa14vYTRuO/9dAEYnKHX0UY5OeIjR9Qg1EXgOrdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDTJdAht; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDTJdAht"
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4ab2d72ff13so937001b6e.0
        for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788053639; x=1788658439; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EjNsh4/6AAxQa92o+EZyYasRh19DxHWkIhMpXDG9Pm8=;
        b=sDTJdAhtl8YkHksFHjafOYNBjd5v1Rm0uAbPvEnihbCtMt6yTzZNE7iSkyq4yWBZfO
         Rr+agxkTpji3kcARArxXCsqhuqxc6LyphScguHge5ULijKHWczqLeFMNhkGET7zPbgt9
         yzIQclwguy0dSf/ep7pgMzO6IRYzqpAcKPOvAOcCEl6Hh8mP1udcFFJtiVoAAC4dadgt
         qPdlSz9BCKyUqCVLVgtCF1jW4QMmgqBDSlVx0wKmVLS1mwWgHkkvLBf+RsP4Pdi+Lwsc
         lgN3N5GLDOujwzB9XpuTR1V3LlCOxg8ZMISyceCk8BM84qw6UbGS1o3T/Uh7JxnxTFLu
         Ix6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788053639; x=1788658439;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjNsh4/6AAxQa92o+EZyYasRh19DxHWkIhMpXDG9Pm8=;
        b=MXn30fmz3i8T0Y+E1GlLE0E7lkziwJJwjQtqfE2/kFRUhe9/kl4FQZNsLWeaIUBBru
         06LFD4baZz1TgvN1gibaKQgOZS4gkFglTfuajocc22nARovdwlFpfqIhqthdxCXX1zld
         Y5SP2VrrYdsIH3pN4xMyU98cvWafSUOUlWSh0d/pITbU1ZIoJn8WHXx+lCakeP0Tp9/s
         OOWODGtr/gOhyIeweuzcOMGoyRD8VrPNxJxVaF40r95p7HjGL/PBRa8CSy2dafEl9gHK
         mX0DujcRGutosWTzS/3LhGWmynttmVQ4rFKos5B5/wy3wt3vdbBZoc0t9X3iKRJ+82dw
         VQLA==
X-Forwarded-Encrypted: i=1; AHgh+RoQrsx5OOAH+42qut5mJbTMNFrDzFqX+i98VjI9UmDSf3s11lLhoKiZtlrYOqQRmYTIe4g=@vger.kernel.org
X-Gm-Message-State: AFuF++nf6ZBx30wlpjVj19p/tgpo9Rucqhdvbi2m2P7xjEIlwf6vumei
	pEybm5wWLBEFg8uxj2jFvpnRxOrZo0KL39AVP+YId0Seyb8KHU2STEVpHIKoLWPf3Ik=
X-Gm-Gg: AR+sD10Zcq0Z4WhqyxAIuCUPiDqbSFUl76ZZYhn5SN2JiLNAGt1Zp+13OPAOQPGeHc5
	8sTELt4llpCwka62R6XqzS/xPZNPBg0RmurPTSXNMTk89yz+6QSxDyHrmQSFU9WtJeueXwEynLd
	ywQSUVCkDAktQvn9dr0c8YT9qhrLz0DLteA5o0Dlrg+4ziu347bIy4ZKaEW/kC7XrZhjirrLvrj
	ElUalCHkNtBFcqOzmq2kLl/Fn1ovvEkni2f8c9uxHvh8HeAE73G1Herg+0OH91avkBByjApGuXV
	yCmEiWrd30c4PiYOGi5u6pgrjDYpQJ5/1QNZ+FeGbjETBBaaROeAAt6C0jidoy3ajhhfGdPAqfG
	tviWQOGEgux7TX6wcATlURq5HciBv+Gjc3K0nja4ipYNqjsNEafi2SUmh54j1Q8qoTOxfaHmk8Q
	51tBb41iTAJv4oKXx2GAyAoxKLBC/siuhlLUQqzpwnO//Dly3KtStQimvZ59w2+NIpIB1PpW0OY
	nrfKKf4hLSUmHQSQljeV4jNKNqSbBcCFqUU1nTVZ22nJuezXkP+4s22/Noku2f19KPqTWk=
X-Received: by 2002:a05:6808:c295:b0:496:1ca:e437 with SMTP id 5614622812f47-4b3981215ddmr21595763b6e.12.1788053639515;
        Sat, 29 Aug 2026 18:33:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b3a19e693fsm4999080b6e.13.2026.08.29.18.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2026 18:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 30 Aug 2026 03:33:56 +0200
Message-Id: <DL1W44NTIQ1U.1BH6B0V44EFSA@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 12/12] docs/bpf: Document arena pointers in
 a by-value return
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260829061514.1690730-1-yonghong.song@linux.dev>
 <20260829061615.1700421-1-yonghong.song@linux.dev>
In-Reply-To: <20260829061615.1700421-1-yonghong.song@linux.dev>

On Sat Aug 29, 2026 at 8:16 AM CEST, Yonghong Song wrote:
> Section 2.9 describes the by-value return contract as scalars only, which
> no longer holds: a kfunc and a global subprogram may now return a struct
> or union whose members are scalars or arena pointers. Update it.
>
> Note that an arena pointer member is handed back as a scalar like every
> other member. That costs nothing: the program has to cast_kern() the valu=
e
> before it can be used, and the verifier allows that cast on any scalar, s=
o
> the member gives the program no reach it did not already have.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  Documentation/bpf/kfuncs.rst | 39 ++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 89dea6b0b024..ebe37c1fe9d2 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -581,20 +581,29 @@ against the arena. Larger accesses must verify the =
range explicitly.
>  A kfunc may return a scalar, a pointer, or a small struct or union by
>  value. A scalar or pointer of up to 8 bytes is returned in R0, as usual.
>
> -A struct or union returned by value must be composed only of scalars
> -(recursively), where a scalar is an integer or an enum; arrays of scalar=
s are
> -allowed as members. Its bytes are handed back to the program as the raw
> -contents of R0 (and R2), so a pointer field would be laundered into a sc=
alar
> -and escape the verifier's pointer provenance and reference tracking. A s=
truct
> -or union with a pointer member is therefore rejected at load time, and s=
o is
> -one with a floating-point member, which the ABI may not return in R0:R2 =
at
> +A struct or union returned by value must be composed only of scalars and=
 arena
> +pointers, where a scalar is an integer or an enum and an arena pointer i=
s one
> +carrying the ``btf_type_tag("arena")`` attribute. Those may be nested in
> +structs and unions and in arrays of any number of dimensions, in any
> +combination, as long as what the nesting bottoms out in is a scalar or a=
n arena
> +pointer. Its bytes are handed back to the program as the raw contents of=
 R0
> +(and R2), so a member of any other pointer type would be laundered into =
a
> +scalar and escape the verifier's pointer provenance and reference tracki=
ng. A
> +struct or union with such a member is therefore rejected at load time, a=
nd so
> +is one with a floating-point member, which the ABI may not return in R0:=
R2 at
>  all.
>
> +An arena pointer member is handed back as a scalar too, but nothing is l=
ost by
> +that. The program must ``cast_kern()`` the value before it can be used, =
and the
> +verifier allows that cast on any scalar, so a laundered arena address gi=
ves the
> +program no reach it did not already have. The result is confined to the
> +program's arena in either case.
> +

I think it would make more sense to support translation for returned arena
pointers as well, i.e. KF_ARENA_RET + the case you describe above. Like, an=
yone
who would use this tag in a struct being returned to the user would probabl=
y we
working with the kernel pointer into the arena.

I think permitting them in the verifier is a good first step, but it isn't =
all
that useful unless the translation is supported as well. Otherwise, the kfu=
nc
has to do it manually, which is a bit of a pain, esp. without access to the
program's arena's base addresses, which isn't always easily possible across
various program types.

I can look into doing this in case you don't have cycles, but overall shoul=
d be
fairly simple to plumb support.

> [...]
