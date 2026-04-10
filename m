Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABBC226D02
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 04:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775793884; cv=none; b=qDBubneBX++p01MWFjvVu5fhPs44fL742fuxGS/VySqB4nVhwJMaHSPg2gzOqHRpNtrrRLhiUF2bxZQdhsua+fIMiIrD1H+TDb75vpYBP1yAEgZiH4UsJC70QytCoDCzRqsNIYTks4RERnW3ejPfmnhXuE+MhiB4/5Va8fvRDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775793884; c=relaxed/simple;
	bh=gl9nmVDlyz8oBak6KlhuL1HWTd37LvEr8V4XYLBQIgY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cS2XivFnEWSH/XdNN1mhqJgQAkOKn8mVIfUv3HjFxVUe0e56RaC4NWOv2Z/0LBc94pRkmB5hXRcGquoKcqAknAnht8WEHIjyLCdL3qBix5ri+0X48Ml6oNCM4GTGoLc22e+pEZv3dPp8JPFWtrtOj8E/aCICX/98rbXByL2VjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+duHyHt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+duHyHt"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82c70e4654eso754517b3a.2
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 21:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775793882; x=1776398682; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZxBxTgMJAXgrjNNPClrjaOjnYh56jmNWEiqGnCFg5rI=;
        b=i+duHyHtqv/1Vir0zmTbmg2rglOJtlJdd4HsUfFCAWmMif1jZC71xMjd94U+lUALzt
         AsvtakjYNwl3bbq7e7EoM3YzaKaj0jmFUg/RM2Xw25kBf7SOrJbjvbSrUnl0puCfS8Pt
         5E1U5zWs8NYO9rfGSJHpYdW8o10LaxT3f7+WMZrBe0dOKUJybko+Aq/l7mRI1C7Co3rn
         JKIL8Z2hEDHrmJMVXTKI+TVZBOZMSLa/sGf7q77VMam8rj7vjuoOOBLOYzDlNSGSUPtU
         +bl4COniGyhmp1IFQRvhrGgB2IQ3b2YbXUag32cDZr8g4w5fqLYQ671Zv4EMRhUcBoSI
         kSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775793882; x=1776398682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxBxTgMJAXgrjNNPClrjaOjnYh56jmNWEiqGnCFg5rI=;
        b=hvM+KwJfNc1tgyiKndm35axXJro8RtLTSnrKcG6RXdmlQBIDmZ3CUBs+NA9jub/hU3
         2xIamlZoRVv7LklUIgJvg9qMTuCh3Hjic72dFanoSplsBzbF4yA61sBWF2faqldRsqGy
         rU+dz6mwEwuclldAI2F5eiSGiGlj4AkuIhTI4XuSjy9VCHUQieyIlkduVsGF+cMgcGU3
         /qI7lNQaB5W+FXQnRHTrsUg2ZjiXi3t8x7oRy/qwajVPAnMph/omn8Zg9LyS6cMcqOS1
         qerWuPOfE6xNMbntyzE570p9NdISrE7hoEvppXAePp+Al8QnVTG8k0QdP4+jmuL/WU12
         bvmg==
X-Forwarded-Encrypted: i=1; AJvYcCX95L1uOvgK5LHnbKc7DLVxOhBb6f4UcnVdm1Iky9317nWvHY49NsGTGmaAhnP5iZm1K7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GyWTd5LWxqc9aXZ1rQ/+hFPdeONU8s/CDB5/O/ILps9sC7nX
	vBLINb4I9bWrFmvmb2fm/ZmQZuF+scSv88XUGyFSqY9/eR8JRDLzscTp
X-Gm-Gg: AeBDietUUQZiDZg4devwZWvz7HV2Wte+MRrm6a/JxyNTgpQURXhDnAxhpHqZvA+PrUy
	Qcf8fjR5448NWvwhY9oXkuLIpk9mkxGdmGT2SrEm9ajGTF2f3nDD1KAUIeYoxq0u0FBhxluRLwa
	DjgVzbJEUGGLbYhITIl3VQEB62Qpq+Ffan9etfdEhpl7dxA/zQFGzZGAewmQ8Y9Z9ddEkGjmt4n
	tjJmK20ym30FdlHTRC+U2z6zLYmXs2Ml6sEAeqdze8YcgV6/JeigpLnLVPwNqdGhCUADGFodn4W
	hXLEbKTCF+SK5g0j1rx8HwbE0bHlTW5MIf+LxmbvY3ql8G88A2MieEvLGyDXtW2MkhM91C5B5Iu
	QAPcRDtJPFQuwKiE1hPb6PggeGRO6DYVwXs+y4FbPmolFJoJ4xikSb5/dKnEAl1OcbwLhPrwWfT
	3DoUoyV8SqKDtJ6NaqzbPxYdw0Gc0/EmkIpSx985J6wsIwPatWRa6a
X-Received: by 2002:a05:6a00:a24b:b0:82a:6f69:7f7b with SMTP id d2e1a72fcca58-82f0c316879mr1831408b3a.37.1775793882037;
        Thu, 09 Apr 2026 21:04:42 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e182csm1119222b3a.45.2026.04.09.21.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 21:04:41 -0700 (PDT)
Message-ID: <57c439dabd29e7a1abd3f84b499cd407571781ab.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/13] bpf: save subprogram name in
 bpf_subprog_info
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Date: Thu, 09 Apr 2026 21:04:38 -0700
In-Reply-To: <95b6b794090c7d1b35fa0040db3573cb6fdb0d9d566c313a14c942f029cbb56b@mail.kernel.org>
References: <20260409-patch-set-v2-2-651804512349@gmail.com>
	 <95b6b794090c7d1b35fa0040db3573cb6fdb0d9d566c313a14c942f029cbb56b@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-10 at 01:50 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 15f7f9f35be9..410939d7b325 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -664,6 +664,7 @@ enum priv_stack_mode {
> > =C2=A0};
> >=20
> > =C2=A0struct bpf_subprog_info {
> > +	const char *name;
> > =C2=A0	/* 'start' has to be the first field otherwise find_subprog() wo=
n't work */
> > =C2=A0	u32 start; /* insn idx of function entry point */
>=20
> With name added before start, the comment claiming start has to be the
> first field is now inaccurate.  Looking at find_subprog() and
> bpf_find_containing_subprog(), the binary search accesses the field by
> name (vals[m].start), not by raw offset, so field ordering doesn't
> actually matter:
>=20
> bpf_find_containing_subprog() {
> =C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0while (l < r) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0m =3D l + (r - l + 1) / 2=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vals[m].start <=3D of=
f)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l=
 =3D m;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
 =3D m - 1;
> =C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0...
> }
>=20
> Should the comment be updated or removed to avoid confusing future
> readers?

Comment does not seem to be accurate indeed.
I'll move the field and update the comment.

>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/242217=
79050
