Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72163A71B6
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291312; cv=none; b=Amyqj1zo8ATkyYh9nGOfkB4C+6VVavXtXuJ47pO/3YMTZznJcd6QARpC5gZAM7BrQX8I1MSynS7jmxseFIYi0w9y8TvaTrSZeqJh7nxqicdtGX3cQragh4379BHab70u6aghI4Oo2GzOr9djsUHU0Ed98DxuH/YcTkp68zyTUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291312; c=relaxed/simple;
	bh=X+VcqjVk5xe1IGzIBlKN5MD3fYQxuB+IlK0MfxlaRAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CcOph8zgjVeaZOJbykfcsPTnGcuu1nfRCmPXaAvXh+n3jKYzauU/QtOHKHLyfkIsP3dSoR2KXXygagNVhniaIqsXIK/MAVLnaOJpX5b6LZ0pVKAcET0R2Jznzt13Ey8vEVamUF7ynLj8iU+oWXjT65fsVVUyEt9BtnEfPHTpb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUMwy0Gx; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUMwy0Gx"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1363fe80fe8so2070316c88.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291311; x=1781896111; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yqOZsjAHJ/FhXXRO1KhYqWotlbjaQ4fmexWXcigXZYU=;
        b=hUMwy0GxzaDj0IZLFCS4ed/cJfKZ+ehMdAu84PCx8Cn2yEJgySQyNXDvuq7fex17Ct
         c+MgsMU0hhn4t7ne4Lb2sYc7whaAhR616edO2BO+nMylyXXl+wzj59Wu/RzQEM9rio6v
         eGkGZWP0ioPLbgr7N/r9rT41ToRquSgDWfKyPORVeIMsRnDc9W4Se6HrYTYqYb03ROF5
         Sit89C4udewPtTy1CZ7KUy6vvrrnq0dDjzHOHXB3lMEPWN9UpeV0ieNXMpPm9mwzyYwq
         X0mo7fjR6ZTMJP3ucXCX8GJkVFwG6MYjhg9jVObu2q/sPkMyAIjBXnTpxOggmxSC3xO0
         nIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291311; x=1781896111;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqOZsjAHJ/FhXXRO1KhYqWotlbjaQ4fmexWXcigXZYU=;
        b=ePF6JU964MiApbRbdshW1gPIv8mcoqRznANws6rslnCsIwilam1aN1P9a/EhiOvdyG
         M3tjNtK3uGqzCYBCfJ9qzNq4ovJfPeqUSATvrdok1TfSlxJoI23cSrRDAhhdfCUmvG7P
         HunD4Hl7Z0KD04AMmIRrvr7tcwmuGX4T4HA8nQOpJAq/lfxIWC4peEpSsd6j8cIOKZBO
         UFddk5UwjL8Rzj9EpXHmf7Vi7A9OrhCMmjScq7m9JmDt0S6cCnwYesn7WBbpB2TFQyFy
         RCk9t5ZQ8c2Qxn/NLeRO+WMUGP/aIcynZz1A8typhDBGTOuOLp26ABpsE65glf57mHX8
         7k9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8xv3gs3W5sLPa/prOv0WqD9oLtHpLcvBba3Lj5NAu3jvgBxR42kPCSvHgK+Wz9S6dl03Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjaMXnH5sVu3/ASLuEdlMG+5mL8MY1lPYz9LpqL9SGh0JaoeZ
	jvIfdk+7thldkjbHqAZ45qy4CxlSZTJrVjCbcOln97LZJxKLakMHTilSmqqWVa0l
X-Gm-Gg: Acq92OG1H3jB/6s7DwRlMwfx2mbxnpRysYbs188RorREHe760/d41ClIW5aOcuixn8H
	4kr6ADP/6rj0FXl5zYhaiqdh8wzpA8XU9dkgZgJpLlK4BCvsKV/2UWafdPuSAFgc4MNl6/vAgyp
	kkrkHG/XL3OiD2hX/y8/pIPuWLmbW+Tpsj6/ymVXhaaOJwqdCwtSFGVlZ4I6LLGu84uMQGGHVFj
	b4bw9V3wco+rDObdneR1jlBejbusEZ/1gahgmjF3p6Fw/yXEtBd16vbxfhRWnS95oozbw4Dn/2a
	9AeQyoE46/VnDsBXxA6nxbn2RCxACpZxrQn9X1HwyXPLubjKz70zOfCtM9dw/Y/RD8xQu3YC7mD
	mTgSbaO+DrWFBUp6Do8sWTA6mFg2QYTFbKinQ9Nnop+YKjACnUss5ao8gWlz5TiRbYXlnhq/ER+
	6aoHHUuYeOvb8JeA809YMB/y7YpJHuBcrflp3MV0yliesGV2Wbds1XRfBENdgMGOWe5FxlAnYZ6
	Ej/Ylw=
X-Received: by 2002:a05:701b:2906:b0:136:ff02:d00b with SMTP id a92af1059eb24-1384bb7b5b2mr1017612c88.25.1781291310399;
        Fri, 12 Jun 2026 12:08:30 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8f06:d707:6dd3:c26? ([2620:10d:c090:500::2:9c4f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b96d6c4sm3246219c88.9.2026.06.12.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:08:30 -0700 (PDT)
Message-ID: <7a5c9c3e8ef2cb86b7ae38fb4593e7337e9962c0.camel@gmail.com>
Subject: Re: Proposing a change to cnumXX_normalize
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hugh Coleman <htcolema@uwaterloo.ca>
Cc: yanze.li@ubc.ca, bpf@vger.kernel.org
Date: Fri, 12 Jun 2026 12:08:28 -0700
In-Reply-To: <8c297913-c48b-4d50-a253-039037c21e53@uwaterloo.ca>
References: <8c297913-c48b-4d50-a253-039037c21e53@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-10 at 19:21 -0700, Hugh Coleman wrote:

Hi Hugh,

Sorry for the delayed response.
CC'ing mailing list in case people have some additional opinions.

> I'm a research assistant working with a PhD student at the University of=
=20
> British Columbia (cc'ed). Broadly, we're working on formalizing the=20
> soundness of the eBPF verifier in the F* programming language.

Nice to meet someone from Vancouver here.

> So far, we have been able to prove the soundness of the "circular=20
> number" operations you implemented earlier this year in `cnum.c` and=20
> `cnum_defs.h`. However, we were a little surprised by the implementation=
=20
> of `cnumXX_normalize` (specific emphasis added):
>=20
> static inline struct cnum_t FN(normalize)(struct cnum_t cnum)
> {
>    if (cnum.size =3D=3D UT_MAX && cnum.base !=3D 0 && cnum.base !=3D (ut)=
ST_MAX)
>    //                                                        ^^^^^^^^^^
>      cnum.base =3D 0;
>    return cnum;
> }
>
> To us, the natural requirement that this function should satisfy is=20
> that: `x` is a concretization of (the cnum) `C` if and only if `x` is a=
=20
> concretization of `normalize(C)`. That is, `normalize` should faithfully=
=20
> preserve the domain of possible values. However, as written, this=20
> normalization function doesn't quite do this, as the condition checks=20
> for `(ut)ST_MAX` (0x7fff...) rather than `UT_MAX`. In particular, this=
=20
> means that it sends the empty cnum to the unbounded cnum. We're=20
> wondering if there's a reason it was chosen to be implemented this way.

In theory, the normalization function is unnecessary, if something
hits a full circle, then the primitive functions shouldn't be
sensitive to exact starting position.
However, I wanted a representation for an for empty cnum w/o adding
more fields to the cnum structure, and I picked the { UT_MAX, UT_MAX }
pair for this purpose. Which added a requirement for normalization.
The idea is to guard for is_empty() at relevant operations and to
apply normalize() to the results of the operations that can produce a
{ UT_MAX, UT_MAX } as a legit full-circle value.

Hence, normalize(EMPTY) is not supposed to be called ever.

> We would propose changing `(ut)ST_MAX` to `UT_MAX`, so that this=20
> function has the "if and only if" property described above.

I vaguely remember one of the test cases ending up sensitive to
preserving { ST_MAX, UT_MAX }. It was an intermediate result which was
further narrowed by some operation and that narrowing was not precise
enough if the intermediate result was normalized to { 0, UT_MAX }.

However, if I simplify the normalize() function to:

    struct cnum_t FN(normalize)(struct cnum_t cnum)
    {
         if (cnum.size =3D=3D UT_MAX && cnum.base !=3D 0)
                 cnum.base =3D 0;
         return cnum;
    }

I don't see any selftests failing at the moment.
So, maybe it was a deficiency of some of the non-final versions of
other primitive operations, and the ST_MAX condition can be removed.

> Accordingly,=20
> since `cnumXX_add` and `cnumXX_negate` depend on this behaviour, we also=
=20
> propose corresponding patches to these functions. (In fact, we can=20
> entirely eliminate the need for `normalize`.) We see this as an=20
> advantage as it simplifies the implementation of `add` and also=20
> eliminates a potentially surprising property of `normalize`.
>=20
> We are not ourselves active kernel contributors, but if you agree with=
=20
> our assessment, hopefully the attached .patch file can be of use to you.=
=20
> We would also be happy to share the F* soundness proofs for these=20
> amended operations.

As for the patch itself, it seems it just inlines the normalize()
calls in-place, so I don't see why it's needed, tbh.
normalize() is not an externally visible function.
Shouldn't it be possible for the proof assistant to do such inlining
on it's own?

Best regards,
Eduard Zingerman
