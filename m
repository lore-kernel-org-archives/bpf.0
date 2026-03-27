Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C92C11D7
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649245; cv=none; b=qRnGRFn32ri5y9mppNxx9fh20ck8OseNBznMnXYEedW8m66TjkSpC7b8if11393aLWkSIEtoP5bT8epSCHGA2wiCcEiMO96Yorsqpr8bhk5SOEIJuXTqOnkswK3/EMJcDeJPdPFL7Ztx6Z9Nc213+X4Ck/wQOihbO6OmWSEWyL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649245; c=relaxed/simple;
	bh=co94zFq2yiofqdjSbS+n7crs8KJg9H8fm7pS3uo16T0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=poMUPn4yOEyyCiCU5d2lH+lRZogKpVKiRXVREMuCC22eGKDLU8ksEcdLUboFpf1oDNd/LQEjYlIGbgul0Hx4QE5oS/EW+qnN4ydPW5OvolYJKdhFlkTIp7jrtEvAKonXP8OVO2y5AHYZm6ah2fxFZqC8ITrn1UKx2MLj2lyjySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm9u+erd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm9u+erd"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b04d051664so22149325ad.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774649243; x=1775254043; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=co94zFq2yiofqdjSbS+n7crs8KJg9H8fm7pS3uo16T0=;
        b=Tm9u+erdvSZb6CuTnQNnEOnPwUcA2d3Yc+JPyjydBKcPgXHcrJM+kNcOv6l75BUmqu
         hw/xmiAr0g7q9XVIRzMI21MdXniClSejhmeCC/bHxWvpGEvhWvvfNX9PO49tMFfah/0g
         MvwiF+1Edt9QXelN27mHh0iL3vZBpVeewOCnr3P4XacpXTq0JpOWgI2QTBySgHXqnLDj
         fBIPjDB/HSehW/Razj2AEX/818iy6oWYPxrqQcFcv5OICqhsMNLMniEumP7BU6wDmyxN
         DqRs3SU/Dgbr3e3fEktYO3jl6m6LZo1MnevdiHpg/rfHlM5Y6grop1W2k+zF1ssXf+o5
         /nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774649243; x=1775254043;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=co94zFq2yiofqdjSbS+n7crs8KJg9H8fm7pS3uo16T0=;
        b=Xcvff6EyuS7qcyJkGnYVtrZmhS0leywx7yh6X0rAt2/KQM2+jHv/Vq4FusB8ypyDkc
         sZogav0pDn6Uri3BYn1wizx36cHP90UvlFFC8DF1ID20tkWPCX4M0AFeawxXm0Umzvpc
         oi0672jUrd8d59tlbUdv3PF/ZDzzqXD1Rjo5zXv1gqTVQlVqL6TqN6rLcOIXiG4jZnwh
         h9cMJAv2wesVgKDKmbw5oo2iAF2HSuRulP72VwcDcSOwxzEJGbn2qJliZbF4wXWo2nK9
         5VxYHigDrcptEJXHjQzJ5ADGxVErVR9lm5bJhj0xJ+z7N4Jqe4xCkjg3FfEai3qsEJo9
         fBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFaXShtvjNoM8oX+kCvBa5p48ervOyeH/cTRo593PZdCNBPLjNZy1RWw9dryulLjaZ0h8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Pri5TJrPwV+0sGX60379kVA+81XGLRhu+9Lu+r8EFbybQMqL
	wKIOq6KwxlTgsfQRsbFAQMyUKaAzgip8mLlGgpgAC2SVqzOnbC173yaf
X-Gm-Gg: ATEYQzzoDCtobpBJaOy16196pYwZdkZMFTCtB/cRKQJfcN00i4W9/l+AGx0904U3TOJ
	J/BobUFl2CfoECkWBqkcttnQEhJ1dACh28kE8HSXH/dtLBEdmOvx0F8+nLHIrlkSfq1660nU5dt
	DS1dPxktbYcQ+IUwPTx0AEKntDub2TKdd6p2zvXo+f2shc3jfgAJ/CBo+iEsaLKvSPUEcm4pI31
	ENbDLZwkhBlvZPgfE60dyHjBHS4OmB1Rs7bDvL/azbi4OG8eVN8NmKXQpzVuvAl7UysSw65Z46l
	3z25vA8DSmCUX3sApyq7qb3OiBagCHH855spXIDyVWePAseWOoaoxp4DglxYNey3XBvyGL4VPRG
	eYLKp6gpq6NmXxUbcrsyRtsJpvP+bKmBYP97ib1Yw7syt9FRcvWMnqQCl++i8ZTT8RyS41Fa+wE
	UQh98dZPxc1MPwaza+yDpTA648j+9sq0Aet3hNUKOr9ryrbS1HmwU=
X-Received: by 2002:a17:902:ea05:b0:2ae:c916:511 with SMTP id d9443c01a7336-2b0cdcaaa2amr44814395ad.24.1774649242832;
        Fri, 27 Mar 2026 15:07:22 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427663acsm2933035ad.46.2026.03.27.15.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:07:22 -0700 (PDT)
Message-ID: <65caf5fe141fca586d8efeab1b2b0e6dc3243561.camel@gmail.com>
Subject: Re: [PATCH 3/4] selftests/bpf: impose global ordering for test
 decl_tags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, cupertino.miranda@oracle.com
Date: Fri, 27 Mar 2026 15:07:19 -0700
In-Reply-To: <53f77737-1d56-46ac-8408-32d7e411b0fd@linux.dev>
References: 
	<20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
	 <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
	 <53f77737-1d56-46ac-8408-32d7e411b0fd@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 15:00 -0700, Ihor Solodrai wrote:
> On 3/26/26 10:39 AM, Eduard Zingerman wrote:
> > Impose global ordering for all decl tags used by test_loader.c based
> > tests (__success, __failure, __msg, etc):
> > - change every tag to expand as
> > =C2=A0 __attribute__((btf_decl_tag("comment:" XSTR(__COUNTER__) ...)))
> > - change parse_test_spec() to collect all decl tags before
> > =C2=A0 processing and sort them using strverscmp().
> >=20
> > The ordering is necessary for gcc-bpf.
> > Neither GCC nor the C standard defines the order in which function
> > attributes are consumed. While Clang tends to preserve definition order=
,
> > GCC may process them out of sequence. This inconsistency causes BPF
> > tests with multiple __msg entries to fail when compiled with GCC.
> >=20
> > Co-developed-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> > =C2=A0tools/testing/selftests/bpf/progs/bpf_misc.h |=C2=A0 60 ++++-----
> > =C2=A0tools/testing/selftests/bpf/test_loader.c=C2=A0=C2=A0=C2=A0 | 174=
 +++++++++++++++------------
> > =C2=A02 files changed, 130 insertions(+), 104 deletions(-)
>=20
> The change makes sense to me overall.
>=20
> I am thinking with all this non-trivial parsing and sorting, maybe we
> should have some smoke test for the test_loader itself?=C2=A0 Extend
> prog_tests_framework.c maybe? And then make that run first on CI?
>=20
> wdyt?

So far the only part of the test_loader.c that has selftest is
prog_tests_framework.c:test_prog_tests_framework_expected_msgs.
Which checks __msg_not() processing, as it turned out a bit tricky.
Specifically for the ordering, I don't think any smoke tests
are necessary, if order is wrong lots of selftests will fail.
