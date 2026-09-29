Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213893438BC
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641633; cv=pass; b=Z2fNFbjYhPTrUMszByd0iMI+JaoWGUPVyWSLteCO2AvBl8pgM4qote2PvcC0WAFAc/LbdFBVZjukobcSssRP+6Vai/hw3EClW4jyDFXlpTV0jlkv02mTbdyk+ZKS7jkKxyxqQDZgor9iI2nc1UAJjtXHBk8DRl1drt5GfmA9AyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641633; c=relaxed/simple;
	bh=oedB+msz1/RbWTTJI/j8Ob89ZiVihiju6Zoh5FNSFPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJCqzN1ZSh3ThoBxKM/+gRCctxPdVZnVp/OPfgaKm3hxLJaqmaMpCwBIBYaKpj/q74PxvBF9YcbisqlGy3Qip6kpwZo0x3RQMUnhIqmB7EUyCyApcQjVWvWfcx2p52te2rE4X/eOBSt7/AGYN7LcebTaQyFo7SgPwrPYQ4aPMfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqMkzJHR; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqMkzJHR"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0b25dso22978225ad.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 17:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790641631; cv=none;
        d=google.com; s=arc-20260327;
        b=Yf8prXNMOP/vmq14ZyDCBb2tgwQP4sdMo6rjpIu9nsXIQzCx0UcD0YHXkzNmVq5PJR
         Ylu47vEXdNAJ/Yoe8EubtK9larS4ux3Q5Np8adF4TK20Cw7Mv5K+3oaCAWY5XzpCUTTW
         Kmn+DuKJRYb3HBFzl5k3+mxzwlpcz84n3MBcZTqZOnjKPZJAo76gRCFEmpf6Bjk3waqc
         xF9KvPvqx2vf4LCmKm8g8i5ygFNGhOlUefxCoeXS7YftwIry0nKgYbHbh/268HuqmlCe
         yYHjw5D/mpm/pbVGN5bbJG73NbIKUr7SlDGJFkLChKmGNheo9jbaqnXoCQroF5hbQLB5
         KGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=evfNHQW86Cj5VxAsvpF7erfdox+HUI7X2p1VfXog5vE=;
        fh=c0y8Y/I2ezuM6SCFlm0ak5to//W79zppIXSNp0kr2os=;
        b=EoinM9swf8l1WxuI+5xTS114L7BDDWUlSZmU1CtwbW/+wpGVFGJDa658n/L6SYGyPt
         +GPYJGU+9UquHIGAG43TVaMxwzQB48iBfQ9hnWDJ/OBxolh7bAuDzRiWKBJAMs7y9wTP
         yl6Y2mkINrOCP9qFNRZrLhHziVE7S5eaktKY/cgeKGLr0RzYnyaK/4ZDNGsx3SKiNYPx
         PDG9l74eFLVwuNX0cmc/C+H6SNZ0+EkoFj+I15XMrYn+VQH1GaFF7ziHrUSnndi7YPC8
         uAq8YMpjY1+gJwTx9c12/oKd+70eJ6sQYWPfC2HOjWbG3/ZfhPZrqmAF270qfgxGSRTV
         R5OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790641631; x=1791246431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=evfNHQW86Cj5VxAsvpF7erfdox+HUI7X2p1VfXog5vE=;
        b=eqMkzJHR6ieWUMsumPxX+FoMW4HbGfMIXljhQ2oy011tIPyxc+Ri88AVttjHEPpSvW
         KEoa5PQgVgdjq+2j2XI4TIXbckCzfx0GGKjkEOn5KoMrjLwV2QrdWKnW8KZJCsq40bsQ
         NXPgDzxrRrUo5A2Eb9zCbeou/cSFtISiawXc3yQPqq4p5fX9eJ7Z0Jm8j9tHrgsNSNaD
         zGf2DWzbmg9Uqbaa7eL1+3gpmHCpgGw1Q5hOj8lVjIWFz02PV6BAOsxwRSprSnsVM2qw
         /sY9cYSYYBTzHvBuGNn1wT7Ftbf6es1oHhajjhE7eH9qVKEiEK/T9VZutqxC3jcj+15f
         RlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790641631; x=1791246431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=evfNHQW86Cj5VxAsvpF7erfdox+HUI7X2p1VfXog5vE=;
        b=zCD0CSi0sdVFudK0OaFggxzddbwIhiw7y4Q8TU8JwxBP58viQfrXq0Mcmsu4Rp9is3
         ssGPdi7sfDtkVi0srGhVR39i5pMa8/0d05UFMH9RiM6kJO5hk1UE5B8bgprUHZrk8ir8
         JdvKJ3XdZvvlPETZh+W79jaaX9yWatjfGxvsKqpDdVH5WZKjzecAzhGAW3hBCHEB2aqB
         1w7INqoGpIwVhraUjErjYvxvSwNcNmUQpo4jOHmRa+acN+mHal4XXPoBrires+YHuVr2
         raprhdaoKtZldJNkiRidtklilOTlIiscSww6IfwyWjUFz3eJAjRjeAI0Rotkd3s+zAq9
         1XdA==
X-Forwarded-Encrypted: i=1; AKwUvBzNV5P6nbayHQBFQ+y/kg/IR7sjP7dTqb/xbNNt4+VOM4N/x6ACNLQSGTwF9liY8vggnX8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9WTdaqYo6LY/Mc4TI9H2wgEvwwG0OETi+a5rH3qCfQgmCnAqd
	bpiTWvTOq03Y4LOgozJ3TJOWR0rhD1WWILngwH0Pu3eY0yZ6W3kEM4raLrOVgzlU/fdgoGVQDPk
	ER1gFulVh0gcNWqHnHZ3OucEhrce9a8o=
X-Gm-Gg: AYBFou1+RRCjUmMuyY9EgSiCeC5Ffj18N3wrVG7CGX66/HjVUCkiuN1Su08zPldBEIk
	2D14bp3LYZdxzciqsMK+I4DPz389xYXYbDhFrHhsZtAjA3ESz7DTVSGtCFehUgogxVQHBCWU7ar
	awmufoP9a8tI5b+jzjFs1D16SATLAfPhpwTXV9AIKuBL3uS2U3sUJYRaFChFgqRgOM6sW1l5qW6
	Q61fQmy40biKhX/lLUn5djlghG+s67xOYA4iY6FFEypKT5fsnk+0xV/fhWpl5p71UNb04rOPf9J
	vxrs4r4A7cJFOcT2cNPUw3O4eEGN5YjJ11u5qBc1DAdgkNbGcdwJlCIqbESV+Ndfb2llcLNYA0x
	4vsFhIMurRJfki5Q4AKB/PYd0MtUunJ7kEI5T
X-Received: by 2002:a17:903:2f82:b0:2df:9ac9:bcd5 with SMTP id
 d9443c01a7336-2df9ac9be4fmr79405115ad.50.1790641631214; Mon, 28 Sep 2026
 17:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928231441.4037097-1-vineet.gupta@linux.dev> <4e178583-b510-457f-94bc-e0e201698371@linux.dev>
In-Reply-To: <4e178583-b510-457f-94bc-e0e201698371@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 28 Sep 2026 17:26:59 -0700
X-Gm-Features: AclHuK8Wia5st71WEpOkvxm5_4apACucCGaXw7j9PK_Be6EwbPI_fD9sXSXcg8s
Message-ID: <CAEf4Bza13wjYrDRLok6VPf-Q=HsmuBvn9ac7BNE70baTZ49PCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix linked_externs with bpf-gcc
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:01=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 2026-09-28 4:14 p.m., Vineet Gupta wrote:
> > test_progs-bpf_gcc fails to build:
> >
> >    prog_tests/linked_externs.c:17:23: error: 'struct linked_arena' has =
no
> >        member named 'arena'
> >
> > Several problems, all from bpf-gcc not supporting address_space(1).
> >
> > First, the arena variables are declared with __arena, but that macro is
> > for pointers -- it marks the pointee address space. The one that carrie=
s
> > placement is __arena_global:
> >
> >    #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FOR=
CE_ASM)
> >    #define __arena        __attribute__((address_space(1))) __attribute=
__((btf_type_tag("arena")))
> >    #define __arena_global __attribute__((address_space(1)))
> >    #else
> >    #define __arena        __attribute__((btf_type_tag("arena")))
> >    #define __arena_global SEC(".addr_space.1")
> >    #endif
> >
> > __BPF_FEATURE_ADDR_SPACE_CAST is a clang predefine. Under clang the two
> > are interchangeable here, since address_space(1) both places the
> > variable and is what btf_type_tag would have described. Under bpf-gcc
> > __arena is only a BTF type tag, so the definitions land in .data, the
> > arena map gets no initial value, and is_skel_data() in bpftool does not
> > emit the typed arena member -- hence the build error. Note this is
> > distinct from skel->maps.arena, which comes from SEC(".maps") and is
> > always present.
> >
> > The extern declarations need __arena_global too. Without a section, gcc
> > does not place an extern in any DATASEC, so it stays a free-floating
> > extern VAR rather than an entry of .addr_space.1. test_relink() only
> > walks that DATASEC:
> >
> >      id =3D btf__find_by_name_kind(btf, sec_name, BTF_KIND_DATASEC);
> >      ...
> >          ASSERT_NEQ(btf_var(t)->linkage, BTF_VAR_GLOBAL_EXTERN, "var_re=
solved");
> >
> > so relink_arena would report OK under bpf-gcc whether or not the linker
> > resolved anything -- it would not be testing the allocated-section path
> > this test exists for.
> >
> > Second, placement alone is not enough to run the test. Dereferencing an
> > arena global needs an addr_space_cast, which only clang emits:
> >
> >    clang:                                  bpf-gcc:
> >      r1 =3D 0x0 ll                             r1 =3D 0x0 ll
> >      r1 =3D addr_space_cast(r1, 0x0, 0x1)      r2 =3D *(u64 *)(r1 + 0x0=
)
> >      r1 =3D *(u64 *)(r1 + 0x0)
> >
> > so the verifier sees a scalar and rejects the program:
> >
> >    4: (79) r2 =3D *(u64 *)(r1 +0)
> >    R1 invalid mem access 'scalar'
> >
> > Guard the program bodies and skip the skeleton subtest, as
> > arena_atomics.c already does. The variables stay unconditional so the
> > arena is still populated and the skeleton still has its member. The
> > fallback bodies reference the externs without dereferencing them:
> > 'used' is ignored on an extern, so an unreferenced one is dropped and
> > .addr_space.1 loses it again.
> >
> > With this, bpf-gcc reports:
> >
> >    #217/1   linked_externs/skel_arena:SKIP
> >    #217/2   linked_externs/relink_arena:OK
> >    #217/3   linked_externs/relink_maps:OK
> >
> > with b_val present in .addr_space.1 as linkage=3Dextern, same as clang,=
 so
> > relink_arena covers the same path in both. clang still passes all three=
.
> >
> > Fixes: 34354db1b148 ("selftests/bpf: Add linked_externs test for extern=
s in allocated sections")
> > Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>

thanks for the fix and testing, my bad with __arena_global and GCC-BPF
build failure. applied to bpf-next, one step closer to green CI!

> This fixes the current GCC BPF selftests build failure on CI:
> https://github.com/kernel-patches/vmtest/actions/runs/36498905340/job/109=
187331070
>
> nit: The commit message is kinda too long. If you'd like it to be read
> by a human, try making it shorter :)
>
> Thanks!
>
> > [...]
