Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794395646;
	b=DsSrlqJls+dX2gXXyAHUQ61uYtCXct7OQ5TGLNoxPWeRgVelI3l8Eu0pymdEdIuTQRBq
	 iat+sEGsj5ht7NDPsqtJE5sQ8vbM64Q4q4/Wek561Nw+oKVjx/r/M15kKVlZuGyvtWdq7
	 03EsqfXvIYL26EEhm8bCdpTW2f83gTElVCookgoDFU7yD1qo7EF8S9b4E6M7sVsc0YvJZ
	 TPmF7ORsjGQWnkZzQCPQbkxAKZMoZ35/rwz2BWYR785DiI4FZFDQ/2/it3PoshOkKMzY0
	 LDMqpgePSCTQE2yhyPcZbdz6U2uBJP6VR9uvA+ck+rDIvNkMMjcuc1qzqD6yEpANH8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mHOHqKo8QZ8tygoF/waZBGgitEd88pKcDs+2m4qmZs8=;
	b=feTAO/+KTl3V8JfmGoLrD2caE5ablxezovF6xtLrStXl9kJr/GX6Wpn8f8VM/zLjMdH8
	 uC7pNq6xuxmtDZeBuU0S9S3IMbx2rky5HrtY1QzeS98oUR2n4y3mvxQIUjlB2PALXFIaf
	 JZM8Unbv3zZMG7Mh6CGbes2wq5DoLRLy2wtM5n7a/mxT6MMGyghVJPlsfIJlfceySm/ap
	 OQx9G371uSYX72padydD56DDiUzKH5hRsJiBhWkFVNghTA0zXzU7pTKxcgCbvCbNlx85f
	 GRrp4H+sck35zi33XJ/BBtKV5EpxpiSI7PTdsKNykNtCU1RT+Q6J6pIJHUvTadW2rPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zcGZHvhY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF06606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 11:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EF06606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zcGZHvhY
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-675617e81f9so3047250d50.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 03:14:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794395645; cv=none;
        d=google.com; s=arc-20260327;
        b=Vr3LpAlzjLp8zEdXWiY4dlSyp6Yxp8A5Ir4EaXuRyi/wPEsgyEQUeFQrgLJz9NVCGE
         /cd9cqgDH/PVD2lU4Ry9o2eIforSd9YJd97NLAQlEVdvGVMNv4dJo3x0vH3NQyanc6Ub
         h01KKKQWFfKrCgY88JfnyT4OIFQmpiToWm75yx0tOrYCrZ8J3LeZZZJmn1Vciu+TJKUW
         B7xO3oGPRI+SsEFGywNQcd6dG7BcycHuBiXr4MPxwJuyq5ffUmchS3uDiC6KNX6gBiX4
         L4ohEay6sJoPyV4spmXZ1GBWc3ETrkq6i+2eRLqcJtf1MoXI8Q785UVXKfZtswEoAdhf
         SNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mHOHqKo8QZ8tygoF/waZBGgitEd88pKcDs+2m4qmZs8=;
        fh=WrKpqwD9dMCXQwrfUXOBHfyppAxzUddeflV4Tt1AQno=;
        b=lPbA5tGlx6zenWAZ+Yh2vx1AtSEaqz8wqczgB8iaPLQukBqkSMjZejK25IyuF7J/PF
         WcQq2lI2BjrDkDB63oikRpfkCfnZCZpbnrJ0YJ0r7LjDizZAuVrOzI76gBNutToswVD+
         /DKUZy7Bq7Ys1PDioWQT04XJ2xYLx/rLMw8QIUMwilsfP1st9OYETOTaybterPqQUouQ
         lRsLs8xs0U/Ka/NObZskGrDfIrFDExNweff1cUOJKSIPP10h7yTDVgPGCYKHEYkoscow
         /JnJs7HO9eMQCaRi0kKrxOtXMXhLUqubt/OfCs0dADVtgtjg3diGSBU/SUQu4iZnbsw+
         ukYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395645; x=1795000445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mHOHqKo8QZ8tygoF/waZBGgitEd88pKcDs+2m4qmZs8=;
        b=zcGZHvhYqd0xVv4jlHB4fAUJEGZtKbq+0BHSZ1nM+wl0Wkm37hk1VXkb+VtGKk04Cs
         TBImeO09SCFQO63wnFEc34DQHZ84XNizGGGxDTFlRryN468HajSFRQzV3JdXIPdG2VE2
         8mRvP4wzHZXVmLdLbghPV4XK2cL8BA3ZJqed5v0Njyr5ug8+2bibuO9HAbhVM35zKkt6
         B4B2RHoEt6trB0xo3Yzbd7cuT3/3tDEfNiy1inN90Sc1559H6dCEhbAa72OLtINyJwuq
         +6VOb1iVLZGE4QNYuKrqPdYsVn7WWpFvgThSj77Yh4zUOV2YdNpBdpHwCmWlEu4Bk02t
         B9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395645; x=1795000445;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mHOHqKo8QZ8tygoF/waZBGgitEd88pKcDs+2m4qmZs8=;
        b=NhyioQ46erB6/3EefOocLiIAv7GpLcRMoLl6hMA3eoVS0bUCwnml+NogqBpTLK08Fc
         kvWou/xIRXic05/C5HssIVFC++3NcM4+CGNzwshiW2f6uS9aFS2GIFrPbRIrETGoew0X
         mYLgTT8lzi4wD21t3+OUjK4QOs9dA5DVJqxcEL0wP9HYEDKoEvdn6/LYf/el64wWMxAl
         54L5AtEyAIt548kcGRJeOp5Khh2P5lPHdmh2HXSUoCpoa7FnySDprd+Fxr7kJT3VqwJY
         pzjWeG2ayuWthuTBhVrZY/7NPr87Jvk3kUVWqUf4J+xRAKzotppWynItfAODg/YtQyJj
         bwIw==
X-Forwarded-Encrypted: i=1; AL+hErEGXyKdBWH+UC6Eh/g9ZVAuDUWAh0nMPtDLltNz0t84vOTHebn+s4oX4I/E3GmN94J5G+c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WgMfugzsC+A+dUrVQwjdqhNRygpZilv5ms4xa1gRQj5JRWXcf
	iYoHRNH+ycvWI/T71DmB03wdUcQXikYjFgWi6c0pjpIarGIn2oIImnXc3uC8+4FWj3km/NZ907x
	g9Qp8MJxezcmuRUYz+ODwM1FlSBIIDZc=
X-Gm-Gg: AYBFou1gxPZ+FBa+nPOFbr3jaG+xG7GjyyhKxjEGQRrkb7sM3ZlauL7r2035nRVy6Z3
	6gY7unK96ukjS+NiEzWrooqs2esoAbCVg1ZETqs1eTOoa1FNX8v4GwSES8X4JbCIm5Zi2KPV2rI
	ikmUyB2oiGHjoLMShmhCzMpn8tk88MtyVbBhkfafafVT1ze5Nncu57IT0zpjatB2YWn5X/V3nxh
	0lQopFKKtfqVUiCJehzAN06RvqxiVto6PILL0sJlykuOwpD7chjUanqhiYns7f8t1a0VGEiM9JZ
	RcKCRGa1yhlcNsbw8dyamB/319DvvpVL4ZKSsU8rfviFtBjF0np7lWCPGFs1Ij0JDfjZC8z7pRi
	3CxYb3xI3jj7vvVrrt8c2o1VLVD4qManu+Ezd8A==
X-Received: by 2002:a05:690e:4805:b0:67c:199a:5553 with SMTP id
 956f58d0204a3-67c67f1cfd1mr971848d50.37.1794395645145; Wed, 11 Nov 2026
 03:14:05 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110164046.454431-9-a.s.protopopov@gmail.com> <36f85a8b94e7329f1afbb7d5eef1eb2e4dd197b1fe5e46e1cb2f7ce7fb8b4912@mail.kernel.org>
In-Reply-To: <36f85a8b94e7329f1afbb7d5eef1eb2e4dd197b1fe5e46e1cb2f7ce7fb8b4912@mail.kernel.org>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Wed, 11 Nov 2026 12:13:52 +0100
X-Gm-Features: AclHuK9lt2mPP3Sai2X5X2QJizHmVBUPmEjH5jotVJ4cWUCwsV3ahxZEolFiyJE
Message-ID: <CAGn_ityCVUSj+omgfbTeug2rPOyLX_+Ci1CY1NJh1OK3Awonkw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/18] bpf: Add the bpf_scan_ir LLVM plugin
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, almagui@kernel.org, john.fastabend@gmail.com, 
	qmo@kernel.org, brauner@kernel.org, kpsingh@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, sashal@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 9:21=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Add the bpf_scan_ir LLVM plugin
>
> TL;DR: Nit only: with the plugin enabled, link-vmlinux.sh adds --emit-rel=
ocs
> to the .tmp_vmlinux1 link, so two existing comments (top-level Makefile,
> vmlinux_link()) now say the opposite; they should be updated.

yes, updated

> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index d5710e900bd4..f39e2d1f1400 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
>
> [ ... ]
>
> > @@ -89,6 +89,13 @@ vmlinux_link()
> >               ldlibs=3D
> >       fi
> >
> > +     if is_enabled CONFIG_CLANG_PLUGIN_BPF_SCAN_IR; then
> > +             if [ "${output}" =3D ".tmp_vmlinux1" ]; then
> > +                     ldflags=3D"${ldflags} ${wl}--emit-relocs"
>
> This isn't a bug, but two existing comments now say the opposite of what
> happens here.
>
> The top-level Makefile says:
>
>     # --emit-relocs is added by scripts/link-vmlinux.sh, for the final li=
nk only.
>
> and a few lines below this block, vmlinux_link() says:
>
>     # Only the final link actually requires the relocations.
>
> With the plugin enabled, the .tmp_vmlinux1 link also gets --emit-relocs, =
and
> on arm64 it gets it without --discard-none.
>
> Could both comments be updated to mention the .tmp_vmlinux1 case?
>
> > +             else
> > +                     ldflags=3D"${ldflags} ${wl}--script=3D${srctree}/=
scripts/bpf/fmodret.lds"
> > +             fi
> > +     fi
> >       ldflags=3D"${ldflags} ${wl}--script=3D${objtree}/${KBUILD_LDS}"
> >
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/429818=
85558
