Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE14582D8
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240174; cv=none; b=uBXINqF8ATt09VjHvixeYrJxfrMB75+E/mrYnFRT4Nzo7yIfjfg062iR9tOgIjR33VyFEIKXTVR7/ODBf2mJHo7WygWxECpyCJvtoII4UZon5dgp3mneZoaCfENMpxhy/QVi0PMOoT1RTvbM3JdeTfWSTgchwADL4Ql/clcEVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240174; c=relaxed/simple;
	bh=1GCGviX25TYqPRHmTXuQNh5HBCz3fk4sZ7dXrthU7dQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=lTmfRJ/P2BkW6Dx21wVSjDGwLhdloXEjsy3f52wwoYOwTgJEtiZk9dKwuYzrYlyH9Xe8ahmzsh/vFYl10y70Gapg4MRlwvTskFWBOkUuqoo3rr9S3wmikNrN9sv01v9RoipP0IphYAXzuDEcp/o9my/8lUgSCjk6DMmDi7KVzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhZt8NDj; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhZt8NDj"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fccd4c3f36so916452a34.3
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789240170; x=1789844970; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=freJdhpvvc4lgT92WOat9fEScu2yTzyuoW03t35i2eQ=;
        b=FhZt8NDjXrdi6tISEa9SYo4gqM1/jGO2MvoWBBC6wDz2S6N9F47dAod3GVVuWm82Kj
         T5xiOa3ZaqSAhvZJf9Qk54dg3UNSnAECVZE1Zx1M53y+EQqxvTC3jNUBuYxLjpdCTJKW
         zCbzsS6bgAlpAuubvK+sU0l7m7bRB9v7yauhEf4W75YPa9kkCHUuXMKs/Ib2DMA/zexW
         pk7TsrTTegv8Rubpb1MS7ihp3DLh16UnF92u4oA5OxXcF56NulYd8TLKRdviQy23eS9N
         EoAG6QSnevuVPi4Jdc52AoTjgcdr2oBDQ9p5zUm1pnK++oUpMrLUJRQxjcAI6Tu89+jV
         wsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789240170; x=1789844970;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=freJdhpvvc4lgT92WOat9fEScu2yTzyuoW03t35i2eQ=;
        b=Eip7t2VT0cVLQ6wJ2d/X9l6yISj8yUgymjxIsHfVSk5cU5yF74YOmIDNbFnutG+RWJ
         MyVJQfkGBN/8VWviMA8qWOvvGCIbh5JLd/+K0/LSVsJJIU7r2+RhX8QmXGfTmJDVUA+7
         7SYDDqK3oKtT7boUKqvcypH0+oykc9XzRS7/XJMQFsqsvyKI8MbN82sOdNeJLZs7beYV
         oZIgeW9mn6W2UWWltrfDuzc6T2OT3WGOM4V1rY83oluNhdYYKtFGLVOJFOBRVxJ+9EA1
         WvLRMWFtk7bEjxWwYnSoMA7SYYNsfrTnMVP6/AdS3m6L14UUy3IWKd4cso9n902zylpo
         Wf2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxfYIA+mdtqArQynbrnYv9FgJ7Qru9wf4NgRkZMraJuK48A/TTp95B4jLD2eQs8bAo7KCk=@vger.kernel.org
X-Gm-Message-State: AFuF++lLIIz7pA2ZMyR7A8H6PnjXhXQjudgHRywUQm43EXXha+AYsQHV
	cbNh2O3ciuCaeoFU/4Z2ErmGUchsXLQRvhTcFKHxM/iX9UtlK39v0Sqq
X-Gm-Gg: AYBFou1131CGz5TIJbYC2PfrdGiieEzlQbZDIZjpaMVRzFKVqhrkh0x2lSSVPjqCLDb
	H1XlVuuBhF5zTjJntWccq3UDFzoOhhG/7ij5N5Uuz26DRVWJSAx3iXBM8kbg928truwRiF+D+FZ
	YFHSP8RmurzYHvSqRBV9YiaKg/GxrLJ3viJ9sauFaGEpaL7oC4alA2/wAGjE4aGROvssIkx+n9D
	AquYX7Wf5Pv/BR9adNiqW/WfxBSg82dPanMEC2TeHA4KG7cfhcPPTA/rkXCnHdiRcyhEOfmJ6Ne
	TAnyMyTNLyZFwTy2IdWyFJUPsa9eLA9aJ+3W0UGLxCfuhGoeBJNSciX8iF+cbRG5mCtUd7EvZOA
	zEyArKx3L2a58v1iyih/NXxZtQzp3qxiWGg6BIR1PjzRaj7OhJz6gDY5N9sZSP1AOI6YsmMQTjj
	aJMAaZUchybS41QJz+wd6EgG/4WCnVLbMfG1PTQDL95BCRVjzkFihQGJI4pabvzgh4B2byMD1KX
	a4lon6r36nWH+/GhvGp+2wByjTOYoTKKc6baWDYd12GjtUTvmHCL+QM37euit9xb16ujDOY/7fN
	gg==
X-Received: by 2002:a05:6830:82c3:b0:7f6:ec23:7956 with SMTP id 46e09a7af769-803fe1bd730mr16167290a34.2.1789240170442;
        Sat, 12 Sep 2026 12:09:30 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-805c4808b18sm2163754a34.5.2026.09.12.12.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 12:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 12:09:28 -0700
Message-Id: <DLDKPDWY833W.1QJX9MTD6SZG5@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <john.fastabend@gmail.com>, <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 07/13] bpf: track low-32 scalar equality
 across sign-extending movs
X-Mailer: aerc
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-8-vineet.gupta@linux.dev>
In-Reply-To: <20260910164635.459558-8-vineet.gupta@linux.dev>

On Thu Sep 10, 2026 at 9:46 AM PDT, Vineet Gupta wrote:
> The zero-extending mov records that dst shares src's low 32 bits. A 32-bi=
t
> sign extension shares them too -- it keeps the low half and fills the hig=
h
> half from bit 31 -- so the same link applies, with a different rule for
> rebuilding the high bits:
>
>   r6 =3D ...              /* full 64-bit unknown */
>   r7 =3D (s32)r6          /* 32-bit sign-extending mov */
>   if w6 =3D=3D -1 goto ...  /* taken: r6's low 32 bits are all ones */
>   ...                   /* r7 is -1, not deduced today */
>
> Add SUBREG_SEXT alongside SUBREG_ZEXT, and sext_32_to_64() alongside
> zext_32_to_64() to drive the reconstruction. Both work from the base's
> 32-bit range, which is what a 32-bit compare narrows.
> coerce_reg_to_size_sx() cannot serve here: it reads smin/smax, which
> straddle after such a compare and collapse to the full field range.
>
> tnum_sext() is the counterpart to tnum_cast(). Unlike a tnum_range() over
> the new bounds it keeps the known low bits.
>
> The enum has room for the third value, so bpf_reg_state stays 80 bytes.
>
> Unlike the zero-extending arm, a self-mov can form a link here, but only
> when src is already linked: r0 =3D (s32)r0 is how a sign-extended int ret=
urn
> lands. On an unlinked register there is nothing to link to, and minting a=
n
> id would leave the register describing itself.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---
> v2: was RFC 5/6.
>  - no forward declaration (Eduard)
>  - src renamed known_reg (Eduard)
>  - sext_32_to_64() and tnum_sext() rather than reusing
>    coerce_reg_to_size_sx(); the sync path needs the base's 32-bit range,
>    see the cover letter
>  - tnum_sext() keeps the known low bits a tnum_range() would drop (Eduard=
)
>  - a self-mov links only when src already has an id, narrower than the RF=
C
>
>  include/linux/bpf_verifier.h |  1 +
>  include/linux/tnum.h         |  3 +++
>  kernel/bpf/log.c             |  2 ++
>  kernel/bpf/tnum.c            | 15 ++++++++++++
>  kernel/bpf/verifier.c        | 47 +++++++++++++++++++++++++++++++++---
>  5 files changed, 65 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index f1b01059c5da..920c9490ecc8 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -53,6 +53,7 @@ enum bpf_add_const {
>  enum bpf_subreg {
>  	SUBREG_NONE =3D 0,
>  	SUBREG_ZEXT,		/* high bits are zero (32-bit zero-extending mov) */
> +	SUBREG_SEXT,		/* high bits repeat bit 31 (32-bit sign-extending mov) */

If my earlier suggestion to model SUBREG_ZEXT as add_const32 with delta =3D=
=3D 0
works, then sign extension could be:

enum bpf_add_const {
       ADD_CONST_NONE =3D 0,
       ADD_CONST_32,    /* delta was added with a 32-bit ALU op */ /* works=
 as ZERO_EXTEND when delta =3D=3D 0 */
       ADD_CONST_64,    /* ... with a 64-bit ALU op */
       SIGN_EXTEND_32, 	/* delta has to be =3D=3D 0 */
};

and if we really want to we can track movsx 8 and 16 too.
Which might be an overkill.

