Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F73054EC
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371656; cv=pass; b=sc09wMzxAYTOFCHEZAcjrjDCilebrkBRrRsIcj+7l9rTK3R9bb3mV+x5rlWdiK8mpxtoEguUIOwu5j+kmh7pAV1g/YtQGETShlD/s087lFJD+8aknL8zAluU9kfElQCIsNCQ0y6WAfxf7HP8YZda5z9AyMcs1/s5J/glJN8Pz5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371656; c=relaxed/simple;
	bh=cCeGrpp3YPG6a/+1tm/i3cFlh/JE4YhZaEOOEx1Pny8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MROQTrmvKdHNlaARI5MhRbTOHST6wziPpMgDm9EdxRwJYicljNPMZmUkvFUjklR2CskUoI7CuKinvUZto0tHqJgw73v05s2DwDSf/oVrJqSfI/xD5Ov2EuQLcjBUsQeQ5q8yJ0SYQL8yBDh8eXI0b/NUHb+O25khiJ/qT5P2ZrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AawkkdUU; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AawkkdUU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48538c5956bso16207325e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773371653; cv=none;
        d=google.com; s=arc-20240605;
        b=ZTvP3xAVK7TXAMbA7wb2EPHCqiF7e4QhKSIbXdcYoj8DliWOcurvecctBjPT+acoAl
         iv3Ui/LAA2xltB8V63piNeLvw6sDDPpxinaxuIQFc/JpBDAdn4aTsBJ9XBDOQQcCq2Gd
         quTc/f8l97KYfU6Y2/oubyKxP3O8so5yOpPrLtuvb0tP4Zw6AkZhdKfeMGvWd5qBe2Rk
         3O2+2iOsZKAQD6xBypM8pnrbAWCcsexvMDkOZNh8EBwMiRHmvaTMA7l8uPyNSGVT8/MO
         xVHUj5Iw9yEcVWK8fy8ugFd+JMMstTXcDrC3wxveppPbVllV7T2U7aDDOn2bDcK1P1mI
         Tpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Tn7ZDa5eMrcuTUsN7VHa/qVPGe0ZZA4f+wAskafgFo=;
        fh=clCOKZ0BsyiMX0DE+7F4+70++GV4DUBIrS8bknUzuGM=;
        b=EdSbw7O7wjoUn7gwKDrt8jUA3dJguR/luPUtmjw87j01k5CE6+BJk9Sj/jBRPKjOXz
         PiL9bVgQmEAwlpMHNSeqVWTweD9yvvH2PNfWq7azv1vEN1gXyngAxNnKXuI3+PzAxCKQ
         Zp1zT/NM+9eIZwHoaOzqi9gxXwTzgyCynao9Sl+k7VokalpgdILtZ7yxWuNkS+TuSD9F
         +L6inYIOeHGMr9bHqygiJ3n4RAWrsSfFEF+BAk3dXqB1LwynjR/nKayRGmfQ/VMH86aK
         bQx15NQaQGZqC25DW4KZNOuiCvAGQ2AAwCK1LLViT2v8UysPcr+goIra0VJ+O9bFJtg/
         UxNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371653; x=1773976453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Tn7ZDa5eMrcuTUsN7VHa/qVPGe0ZZA4f+wAskafgFo=;
        b=AawkkdUUzw62IJpxbQuo89IWHzCR/d9YXD447eqRR2WpvFKYuGd8S0VS6h52FCh2kk
         8ue7VOjqPxjpofHwFcVL2tX7r06ERmnjU0r7oLw1SlNV2z+F07Jozeaox+jQaBVovrwj
         2y8rfmicQjTz/msgoMgQAzaHWxoErn98vw2nGs3nHX8+DA/1V7iWMdSmgcYEb3Bp7uDF
         2DAwpNyeYW/mWh+xNWKv9ibJn87qAlIzgisyb/hx+tWrhqFMbUOcxI823YZ/sODqAHM7
         P/soIuqbf8laHa4u38vUBuYGTHV0tgDaRKskmxZnWq/pUBLR3QI1EjguO3BZpo5LUk9e
         YBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371653; x=1773976453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Tn7ZDa5eMrcuTUsN7VHa/qVPGe0ZZA4f+wAskafgFo=;
        b=Yk+4MZwhKXDGxHlCLyfhlovpdqUdgNQZJL+IPZsh2eFQnHr52YYIbIEVrtOsKHthNG
         dpMuRVHbIjcp8rYaMX8oeeZ6A9RqYG7BR/+M9IBFPmEEVPuVIbIpYwI77tNb8Utd/jjk
         1tpi8B7wjTgrjDTNmKgQx7+PkN5XcDvirZMNuRV54sh6VARPh+5N4SgN68z+woIwXOuI
         wU8Hq3Il/WNXsXsY4/NRNLED1gl72JqHiHYd6CD4Au7H6zFDMWUhVGPUl1hfN3KzhZNY
         4NSHET/lr0lYNPITJtc3+zmk1GPay+KYiClIDayyeid7L6qRr18K9raTBeO7s8N+zJLQ
         2kQQ==
X-Gm-Message-State: AOJu0YzSbt0mxleny/NBQcWbOHz+733GldgfdXF229qPb6/2iDamSpq3
	aoTFbAhSxlbdt5Pz+2yiYQf7sa7ybmumpiLL5OqWCCrr4Q1/2vbYJ2Slwix+MQH3HAKssmulq8v
	EmtJ+vxC+PsELw70VbAEpUUcZF2CiO1uU8w==
X-Gm-Gg: ATEYQzxU3kQdp8yYKFGXe6iLd28dMH3uEco0fvQ/i0v19OJcJSK9Q2LkBCHfEILyMjr
	ylqRLk/RYyupjUuKILkDAM5+UcG5gcq0LSwrObjpwYAWnxNlP/9enQSv5CO/voHO3ePsqFBeY2b
	Uw4bb1MCJElQiVoM94g7O9DvjDPkvWvixP+K/sVJzqSpRHe7fufiZTSeh00rV6QKkWKQq8/u0Kg
	fT8aDyYzpjN7/5gcpaNU0i42ruIlFuDxViSSQW+59UXGWnPyRSnKWKTBZ57iAbtetgmLq4OlQoV
	cewNfjJTmkvyyg1OCG75loI1LuaQuMs6053N7W5S6X9laVQoybyPnsIlypr4WG/Mfmc=
X-Received: by 2002:a05:600c:2295:b0:483:a2b0:d210 with SMTP id
 5b1f17b1804b1-4854f56d693mr69411045e9.7.1773371653093; Thu, 12 Mar 2026
 20:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312112643.22659-1-danjwade95@gmail.com> <20260312112643.22659-3-danjwade95@gmail.com>
In-Reply-To: <20260312112643.22659-3-danjwade95@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Mar 2026 20:14:02 -0700
X-Gm-Features: AaiRm52U3KiwujDO0O2N3OXbgNslXyBH7Pa2WOWXCQRwFEXYjs5cvqRqkD7JAgo
Message-ID: <CAADnVQL1N9HLNsuJu-hcVPPE-jREOCsau-sicXi4koehnSd0vA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add tests for
 maybe_fork_scalars() OR vs AND handling
To: Daniel Wade <danjwade95@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 4:31=E2=80=AFAM Daniel Wade <danjwade95@gmail.com> =
wrote:
>
> Add three test cases to verifier_bounds.c to verify that
> maybe_fork_scalars() correctly tracks register values for BPF_OR
> operations with constant source operands:
>
> 1. or_scalar_fork_rejects_oob: After ARSH 63 + OR 8, the pushed
>    path should have dst =3D 8. With value_size =3D 8, accessing
>    map_value + 8 is out of bounds and must be rejected.
>
> 2. and_scalar_fork_still_works: Regression test ensuring AND
>    forking continues to work. ARSH 63 + AND 4 produces pushed
>    dst =3D 0 and current dst =3D 4, both within value_size =3D 8.
>
> 3. or_scalar_fork_allows_inbounds: After ARSH 63 + OR 4, the
>    pushed path has dst =3D 4, which is within value_size =3D 8
>    and should be accepted.
>
> These tests exercise the fix in the previous patch, which makes the
> pushed path re-execute the ALU instruction so it computes the correct
> result for BPF_OR.
>
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_bounds.c     | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index a0bb7fb40e..541d70fa46 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1200,4 +1200,106 @@ l0_%=3D:  r0 =3D 0;                              =
           \
>         : __clobber_all);
>  }
>
> +SEC("socket")
> +__description("maybe_fork_scalars: OR with constant rejects OOB")
> +__failure __msg("invalid access to map value")
> +__naked void or_scalar_fork_rejects_oob(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D 0;                                         \
> +       *(u64*)(r10 - 8) =3D r1;                          \
> +       r2 =3D r10;                                       \
> +       r2 +=3D -8;                                       \
> +       r1 =3D %[map_hash_8b] ll;                         \
> +       call %[bpf_map_lookup_elem];                    \
> +       if r0 =3D=3D 0 goto l0_%=3D;                          \
> +       r9 =3D r0;                                        \
> +       r6 =3D *(u64*)(r9 + 0);                           \
> +       r6 s>>=3D 63;                                     \
> +       r6 |=3D 8;                                        \
> +       /* r6 is now either -1 (current) or 8 (pushed). \
> +        * Current path: r6 < 0, branch taken, exits.           \
> +        * Pushed path:  r6 =3D 8, branch not taken.              \

Small nit.
Please use proper kernel comment style in any new code.

pw-bot: cr
