Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ECA2D8378
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276747; cv=none; b=nyQMFnT+vzVbGG84W6Tc8o6sdKXikg5cpKm8+auIXz9smgWD37WSoUUe435SpxddtZdhcN3KYCije56BlIieByS67hXIdxpQjGOeto4Kg8FFiw9SwegyjyKUiN9tov28j0BXWCb0cQVQI8vJZ3KTz4LPDAY1WbtWVV0PhJTjHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276747; c=relaxed/simple;
	bh=voQLvckIkJzkb4rTethDLss0rurjppMwVLV4hrYSiiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4wPbuvu2JYfp0H6exd9XlAspzyglcI4kJ8tO4rcjcWH4JU27/qCvlnz4frWr3Oc7adS2l5XFpywvsgu2Dojj/lhjK29/WxPP7dxZVVtPxFTaIsi7Ct9dW5/R7a7EoGcCoM8X8UgozqBWOkXmD7sKqLzzkI6M+CpRfxo38q1/9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryPk6V4p; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryPk6V4p"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so7781338eec.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 11:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776276746; x=1776881546; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C271EoITCL0CMSCappHhm5qKCGcKdaqAjj4Be8M/ZZQ=;
        b=ryPk6V4p23xU61UeVBaUKTI3AQPGvPLY7Ty41VIEhmASt9+K2sBPXHd/XQPDKzaOH/
         F+xvNE66BIcrh+HpWCkiFfeU20PGSHtYYRAZoeE8rUFtRY0RfBqDOg+iW4I7fxmCHZ55
         dn0t1H8n4lGUKevjfoVh/kPQ0KNRUtivzUjoFFqSmbVZA+QS/6kPKf21mggUveTHh8nf
         iyjvlo05+zF2nOzax7XYOZ/vILhuY2fDjR5RC1LyPMPeGxT2iFHYNQ2I6A7Md43TgzdX
         Qqej+IW7SWw2C2SGRlCFZ7keEbLkFLBowbMoKbchT8HnhIETWRgZHNZk2YE7Zf5DcNLA
         NiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776276746; x=1776881546;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C271EoITCL0CMSCappHhm5qKCGcKdaqAjj4Be8M/ZZQ=;
        b=lxf/lSOy0uE2GBNzsV6xBF8eSoqfN0UtU/Deub4jrHtNsOcIKSN/D1dFLYOIgTyOre
         6U4CuCnju9bdvv2RtAA7/OgqQj8pM7XYUtgfSAYUjsanPNNVRDymPeUP11e/gXVzsFHq
         9Byp/+VM7c4wsn5ra9/TqZE6x/J/WuqdVRh2HulEp5hJXUArtrUppIcKb8OWS1zneSt/
         1SQ5F4J2PheUMktfLBtAyb8nks7x8ouOkxt/MkaxZM25W11LEXArgeUGLWitgs9vtxtv
         4kuQx6UySiVpsCW2oUbPttV46OZgXFgldM7na+skvQ4StmzvVR/cZRWqeqQsWmi3T4XJ
         EAeA==
X-Forwarded-Encrypted: i=1; AFNElJ90XV9mY7jNr0+JDljcuRuX5HOw+qNJleVOE9Dwm3NA3rs87PCcl5Hj5DIH5f9E16wBU2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo8g4SnMFAYpjIJSG6kdY2cSlTqB21VM6XDJiNsZQnvLhrnpeL
	2sdVjWxEom/N+mmIBly4Gtvk2tEm8UMOmrC1m/psm0IfYzvNwOg9kFID
X-Gm-Gg: AeBDietaqS+l6yjQ/EFImAhhNYVHRWo/8jIjmWelxse499eViQ8dEaSvxMoUgU+6lhk
	SRJxgNUoooOmpI1nl/tUNCu2nAan1E04/OAUkt4vRAtfvgd8tt11dkE2LDAeFU4H+xtted682DD
	mCvOH5hGH8MxYZNZTjSvB4+ED16+wGfEzeIhWc/vyVUDpFb0rMKnPas/mw71c/SH0NB2J6ZDOI6
	muRgHySAxOvzVXtRG1fzIXismwQiUgYwZ3kq8d+UotJZxwxifgAgPDt5fApQMbPGbGr4KdqWOyQ
	PL7D+PxqioWCPrt0fj4xzKG/rMmCWlRKCodvnL7+mMSRYgWj7VW4ySxfxUHs9MpMjW1tmY13uOC
	AahMG+EvoZhhPTbhcynJH4G09QZnFUY8M65AlhF3/wZg9HpmptkNxzc7IgwtDcPi0ZPTjUE3PCi
	R69HJtUqLqhQs5754mAajARrgBAkk6kkiXhlQs5FDCJ8f8CXBj5QNPkhYM1oZC9DlDFTFpuPbOb
	/fXtQ==
X-Received: by 2002:a05:7300:3722:b0:2df:7fe3:96a with SMTP id 5a478bee46e88-2df7fe30d71mr361058eec.0.1776276745746;
        Wed, 15 Apr 2026 11:12:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21dc:2944:7f23:f4d7? ([2620:10d:c090:500::cdb0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c10a9a3sm4344814eec.2.2026.04.15.11.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:12:25 -0700 (PDT)
Message-ID: <e055c5e1112e42c03c929282b95d5ec2b31295e4.camel@gmail.com>
Subject: Re: [PATCH 1/2] bpf: deduce_bounds_64_from_32 tightening with
 circular range logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: Helen Koike <koike@igalia.com>, paul.chaignon@gmail.com, 
	shung-hsi.yu@suse.com, andrii@kernel.org, yonghong.song@linux.dev,
 ast@kernel.org, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
Date: Wed, 15 Apr 2026 11:12:23 -0700
In-Reply-To: <CAM=Ch07+xVRHvRJBqQukCrU-br=HHyFWbdjbP+vOB6XKaOOYag@mail.gmail.com>
References: <20260410124035.297632-1-koike@igalia.com>
	 <16990d86263fb24079e6f0b476a8854ec2366932.camel@gmail.com>
	 <CAM=Ch07+xVRHvRJBqQukCrU-br=HHyFWbdjbP+vOB6XKaOOYag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 12:19 -0400, Harishankar Vishwanathan wrote:
> On Wed, Apr 15, 2026 at 3:12=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2026-04-10 at 09:40 -0300, Helen Koike wrote:
> > > Unify handling of signed and unsigned using circular range logic.
> [...]
>=20
> > Hi Helen, Harishankar, Shung-Hsi, Paul,
> >=20
> > I think this algorithm is correct and covers all cases discussed earlie=
r.
> > I also prepared simple correctness check using cbmc in [1].
> > It shows that for any valid input register state deduce_bounds_64_from_=
32
> > does not loose any values (check_soundness() function in [1], which val=
idates).
> > It also shows that there exist invalid input register state,
> > such that deduce_bounds_64_from_32() "fixes" it to be valid
> > (check_invalid_preserved() function in [1], which produces a counter-ex=
ample).
>=20
> IIUC, this patch enhances the new deduce_bounds_64_from_32, while
> also having the property that it "maintains invalid input register states=
".

It enhances deduce_bounds_64_from_32, but it does *not* maintain the
invalid stays invalid property. It can be adjusted to provide a signal
when 64-bit and 32-bit ranges do not intersect.
In any case, I see that you handle this situation already in [1].
Therefore, I think we can proceed with this patch as-is.

[1] https://lore.kernel.org/bpf/20260415160728.657270-1-harishankar.vishwan=
athan@gmail.com/T/#t

>=20
> > Now, the question is whether we want check_invalid_preserved() to hold.
> > Harishankar is working on an extension to simulate_both_branches_taken(=
)
> > checking for additional cases of invariant violation.
> > Disagreement between 64-bit and 32-bit ranges is one of such violations=
.
> > The logic in deduce_bounds_64_from_32() can be extracted as "intersect"
> > function producing a signal describing if intersection actually exist.
> > So, the question is for Harishankar, would you like to have such
> > "intersect" function?
>=20
> I  think using the new reg_bounds_intersect() "intersection checks"
> introduced in [1] to exit early in sync is still useful because
> the other sub-sync function might still "fix" the bounds
>=20
> [1] https://lore.kernel.org/bpf/20260415160728.657270-2-harishankar.vishw=
anathan@gmail.com/T/#u
>=20
> > [...]
