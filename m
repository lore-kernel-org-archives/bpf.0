Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D0F364953
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776404113; cv=pass; b=jTiq3gIIVyWTCYoIUv4qKVeJOZAOPkh+TeY5nLwIbTc5PLuoVP00TFAYLTlxpVX8o0vafOU3Y6IhJ0zY8Av1ySCq/a6DfEkHwc3prnHq7VG6xqR6SvW8MPPBnV30YOvek8QqU6tT2jkOgHSISrVfZJyJ4vfsTTN+CQkgbsHNFfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776404113; c=relaxed/simple;
	bh=50s7fcy8/Kqsaj4FGqPFPdwBls7hCrivowg3g/rScB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+j83aG/82Q7BkfVDBrpHdOn9SEQyIluZTrL6I1fTQ+fy239rcjl84M1x92mEtTud5AvYyQ71gke4nNEWAaGilTYBVIKcOmL3vAMRPfMHNqb7X90U9eXSgsPAO9x0shkNjENaIWxzKhbYXmgQHYbZOwuyMk0tX3RMrhBCugGth4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnR5LLG+; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnR5LLG+"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-956948531a1so63582241.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 22:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776404110; cv=none;
        d=google.com; s=arc-20240605;
        b=g/+Ce1A+H0vUEHt1YRvDx44kxvmFpmgGm9xSoxaxmz+sPph+GhFIXFwwKvntiFQKCZ
         D1OnN2CZ4NRuAhtUmRYmJej2cemEVp0sF+UDPCEgNuYg0eBkHG+kvd0Zm+cQZiqnCm1l
         vMHUz8vFxVXnUYPL8B1qLyNHKGd51nYuBQwooZeUvFIkTA8VSD6Duk8ShEY4XY9Vef+5
         DRoEhuCwhDL6j+rjQ+k039zYu0OKB5XJQOUQXOHjO+Dzv6XBNQ5wtMNtI4ATR/0GjXaW
         KnF5/cbmXG1iDXJw5YPDN925gu1c0G2fpVXB+xXoINFOuzbUhIsgp9wIriWFLJK0IcbJ
         bxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M6gMictNnhp/3KZH1OWsfIxe5alsdMVS2juZ1n6qw9c=;
        fh=ypw/5fet4CANHeQUz+kfgabEvSoH35hHHOlcI8B0sBI=;
        b=JRA3UlEOCE4W1V/MZoMIYXgl4jJh1Pk5K7l0h9vnIJpNbPjVHmCxEYWS8ZA5y+ydmf
         bH+S1O3gg8McKR1NT//4opomWmjSjSFRbWwAgu3RGzjbeuX8cXUB2HRYJVORijx0vGqr
         3rSMkArp668Y4C0vBMcn7amB2Ajvz0RZWabmH7Dfgx5uwmCJ/7UHVA+5a1B1WN7/4xhj
         MDntP/bNnSV8kA3kQVk/daHsylfWY25vuYGofUhQEPbBexOnGNlga+uJf/2K3Hl8T1e9
         6SVLdmcKfYi4Ic9UnqONs7MRsy4nwxp86s94V9oWeVg87XaBvfPvnCXw65hbm2TmX62R
         PmqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776404110; x=1777008910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6gMictNnhp/3KZH1OWsfIxe5alsdMVS2juZ1n6qw9c=;
        b=NnR5LLG+jSVkV4Dp39RwK3iQCGup3Yrpwi9BWJHHmcGc/hp6SoLYkl3nzh5LilMM2Q
         t96E4LCtpkg9lQC1tgQTrikbCpbASZ+jCGvEwOJuNcvQvE1EkEpy5dAjZ33WOkOnzRgg
         BaK7gZxYXVMHelNntsswLKvW3GmNFfEiptwrvGHnovhU+44PlDS6JC6LHtOIlliCBiyn
         9rC+6gmJ+M4FxWnYmXXyjK0Ys4F0jEoeAqIzLRyUlyVTZ4PyfRGYCspIS6rBJvzauW5j
         SaePsvDggdMP3puycAUDibhHTmnzSe12XMlVy6S87WgVYdDwxZS3MajGV5v9jLj23Oqb
         sFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776404110; x=1777008910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M6gMictNnhp/3KZH1OWsfIxe5alsdMVS2juZ1n6qw9c=;
        b=qEGOBW6LMVxp18D+VXQ4/EYFGbYBJzkVFZA7E2XwB2AguBr2QJeN56qKf1qYpvT/la
         E0h3SYmTEhq8cX1rqFZwVOhCWCkf4sxXjAs6xNogkGC7Om/0zhfEqvYb7V4uF2s1d1FH
         ECEGcHVroNflMQgeurMW5O4Y7GPVQEtBeIDYrwAdYWJ+ODWHyLniHDNhAn5dSsm+R0d5
         F3YKc7xIiYz7463+WD0Jx2bX0yDGY712jD/cfKuGir6Z0wwNM195cMp1i1hT1PFDoBgq
         F6VSmlGBgng07zDn4jcL1Gkk4YvtIILoXOtjUo2y5GoH6we5wOo7uMvQ9nzSL8fVGkE0
         OQfw==
X-Gm-Message-State: AOJu0YwfQrZ3gq52kMjb8fvTWZByMugQ8sesjVR+6oWyoBr+Ee0E7ZEr
	JhNzBeDIT0lb58nFSiE3ZJ7YeoXJrFG0HcgcunN0taWoEssryvv5K/sOJX9QRpNJ+AeXhKFTBck
	WFIYRpLFbeNTJSFVJTs33zDTIeZwwBwE=
X-Gm-Gg: AeBDietCUQ7Z06d69fKCDB8QkML/BTxzJZSe7B1nI1NTILUMuV0C3p7n7X4qLyAH1aE
	if9Pm/Lo94UVQuvtEnS22XASU0wBeZPBt9gse0g3hZK2Jx3pYZMRWHYJMRjVS2Qa4h4lL+19IOm
	FXSTS+/mGX/DzNztX2M8GnEMfIwS680K0sSQ3+Drnb+O5tvpPRdBah/u0n+XyRfpInadMGu0C5O
	Lbsruc1LRlcMzjqF6c3hWLmc1pYpY76oB3h4dYiJ87YNXYKDOyvNie3+KdtsD8bAeNvpOynXr9n
	fHpeEM5FQkvx5Sb4hymRrzXUenHgDtzDIi0kST6RZ7NNGFr9Yq5F
X-Received: by 2002:a05:6102:6052:b0:602:8c16:b24c with SMTP id
 ada2fe7eead31-616f806992emr405659137.19.1776404110393; Thu, 16 Apr 2026
 22:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
 <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com> <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
In-Reply-To: <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Fri, 17 Apr 2026 01:34:53 -0400
X-Gm-Features: AQROBzBiw6F5Ia9PMEYW6e9Ge391yqft04fhK7Ailnxz3savajGbx3dqpD0Yqbo
Message-ID: <CAM=Ch07jcncdAA1D-uh66OuVXnROF72k8gunJy2cSMuvJNP+nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 7:33=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2026-04-16 at 19:13 -0400, Harishankar Vishwanathan wrote:
> > On Wed, Apr 15, 2026 at 9:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
[...]
> In general, I think it would be nice for the parts of reg_bounds_sync()
> to have the following properties:
> - valid register remains valid
> - invalid register remains invalid

Here do you mean "valid" in the sense that there is a concrete value
across all domains? If yes, reg_bounds_sync() already holds the
first property.

As I understand, the second property is a bit nuanced as you have
referenced below.
Assuming "invalid" means there is no single concrete value common
across all domains. One way to check that is the intersection check,
if any of the input domain pairs have empty intersection, the input is inva=
lid.
But it is also possible that the pairwise intersections say "true" but ther=
e
still doesn't exist a global intersection across all the 5 abstract values.

> What I don't like is that we go through all the trouble to intersect
> the ranges and still have an incomplete result, because we still don't
> know if all ranges intersect at some common point (that's true for 5
> arbitrary sets, here we have connected domains, so maybe there are
> some additional constraints that make pairwise comparison guarantee
> common intersection, but that requires additional reasoning).

We were thinking about this. You are right that the
pairwise comparison does not guarantee a common
intersection point. We have counterexamples showing that.

However, no pairwise intersection (in any of the domain pairs) guarantees
that there can be no common intersection point.

> Could you please comment about the witness idea?
> Suppose reg_bounds_sync() is modified to preserve the properties I
> described above, would it be sufficient to check two candidates:
> tmin and tnum_step(tmin) to identify a register in an invalid state?

IIUC, your idea is, if there is a witness, it should be one
of tmin, tnum_step(tmin).

- I don't think tmin, tnum_step(tmin) works, because you might
need several applications of tnum_step from tmin to reach umin.

- Assuming tnum_step(umin) to reach the first intersection of umin
with the tnum (let's say x), x might not intersect with the s64.

-  I think one of tnum_step(umin), tnum_step(smin), smin, umin works
to find the common intersection point among u64, s64 and tnum.

- But even then that particular intersection point must also intersect
with the u32 and s32 (when mapped to those domains). That
complicates the reasoning.

Also how would you ensure property 2 described above
in reg_bounds_sync()?
