Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A41FF7C8
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100634; cv=none; b=SZ0hFxtVDtRpj3Tm0TJq0gbPax2o3v6+YQtyMy3y8o89yP57v+W6MSsmnPi7NsFfHQjfUejdVmHCC+QduJXVieqVrEcWTCZfgE2NzFdRh6JO6k4/TEtBOIKRAeh0eAX77koStK7L/Gp0pZK9UzAeLJ+4sgeTnuRa9OfxG2YauEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100634; c=relaxed/simple;
	bh=PfayTowN7w4HoZoTSua7B4tt/Fk3/FeChSz1UDCOAJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eLV3nKPUMp7k6ucIpk/mfnDsOOgxxths5GICy2t/pyd7eYuj/UoLMfuz1Wm3A62A8fieLhzcTbDOJ9LLc6A1zXcy9Nnj5hpoB2zAAQqLxc/pQy4Xkfb+HjDR+mhDr01ByMFnAb6JY8Ra10ftqouQKnc+DRfWmCAp094nLz7jzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvvPCdg9; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvvPCdg9"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304df7ff4c2so1323335eec.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780100632; x=1780705432; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sdDMvHhMz/g/MI+qEwlb3xGernzVYgJZ+zhnMTwNbsI=;
        b=RvvPCdg9GO1aghH1yRhCzd0GVcjVUUdIj647krAHa+QoppFPebGZzgCTKY9mg+tAan
         njP0VBvfFAjPJsQ4uckWUaW8wwVZRvwu4FzyM1VXxyl8aGDleS1U9WFI/3ytoOMHsACa
         /6wjj7P+0igx43Ai4dSI48eT5gUjAgdFQl5WFeKLSqxHx4151gr8O4v5Qm2pFc4PvypD
         odHQeYGWNe1Qy0K6ujO6Xlm7FHC3YoPAeW0F/1IaE14tfWoMVGrGx8vNVAdar0R32CY2
         p62k/QVroVJzZRxAIy7mIMjylCGfv3TsOQU0vOv8TtbYuPmEmNP+nrHHYyUU4KRcJsF8
         JVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100632; x=1780705432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdDMvHhMz/g/MI+qEwlb3xGernzVYgJZ+zhnMTwNbsI=;
        b=Gduec4Gjtz/R2nsgt7B9eNoARzJSIvCdckmSlJo/CtLGCtwSc6gZoqL86wYBiDd+YE
         O7/MgFOH2SnekSUHGgF4FAHDRWgT30DsajWUsVs7rV+GUNfVuJE811O9zKX+nNn9gV6w
         hm5xJwwvHbCGMP1s3urAbCouyp7+LXEko/TiakfL8llL3zSp+GNp1Nu5sthibWOeWr3W
         jC2cWudZ87JhWkE0hcNyDwfXd10zaiW60SJSjb5iuIOgF3jXO2HJ7Jbp0E5PFBVoSK4g
         gEco1Inlec+zqObVNlANfjXMhutKmhvCSWzKi75LWj8Bb9Vi1h/a9OxVOWGFGzYaTSpu
         lBSg==
X-Gm-Message-State: AOJu0YyqIbMpZjXw2EXXGT+NSrrSn+tshsvNw/qkfCR9Lb5YcFzlobkk
	vAcpAKXQ9k4Wcf74wa2wx892r/bPr8MF833oGVn2UZ8qfapm838322Hn6EWQZoRg
X-Gm-Gg: Acq92OEkT9XFez61gLQx49jsC9w1jG1QuHkXUkg3IVrGm2x0sVauUwjdnYBEzTeHiER
	folcPffCRhSRs8GHDPGgz0CiJZDmciKhMpZp3TYVOEX9MF3hs2mppAppTFqG8EQWeA2hp0A89n8
	KMe/AtxyZL0mvqU9T54CI1E4quj+YE4pcM4ttYJlMW/1ttkwkDX+3KAPhJYWZsqVGbeEwYaqAb9
	E//uFELmq5dtj6PsIr1t1mM2laPwYfWjb5jgMEe4pVZkDa7m/ZVzJcD6kq6tMrYSlINk7XhHlyf
	T4enzH4lN2lhYrueVYEkwjZtQcTpFQmcfisC9V9731+TtA9dHsi+/a1c31OPMe+Q15Pf4wRxNJN
	z329csYDC3aezt8LlGgN0IzISF/kZOPgC4q4B2YVaGhtRLArd9pCWZXCwPOnHGyo91Pvuf19AYH
	nDgOiODb8wlfrLH2EZO5Iyg+76u0V8O8U7Themq1qkD7axZVI0+8PDpyq7w31n7Cd04NFovgMi1
	4ROEJvNywkXcPk=
X-Received: by 2002:a05:7300:2388:b0:2f4:d190:37bf with SMTP id 5a478bee46e88-304eb1f59aamr2470877eec.16.1780100632077;
        Fri, 29 May 2026 17:23:52 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8f2b:7:7f47:9f95? ([2620:10d:c090:500::1:217c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f316sm2656861eec.19.2026.05.29.17.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:23:51 -0700 (PDT)
Message-ID: <1dfde1acae77ab6f20468b84a7d67412d5bbaf91.camel@gmail.com>
Subject: Re: [PATCH bpf 0/2] bpf: fork state when comparing sign crossing
 ranges with zero
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, zhuyifei@google.com
Date: Fri, 29 May 2026 17:23:50 -0700
In-Reply-To: <14c9e9e95a07b6de94a142394c69b81d6587998b.camel@gmail.com>
References: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
	 <14c9e9e95a07b6de94a142394c69b81d6587998b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 15:44 -0700, Eduard Zingerman wrote:
> On Fri, 2026-05-29 at 01:13 -0700, Eduard Zingerman wrote:
> > YiFei Zhu reported [1] the verifier regression after switch to cnum
> > based scalars representation. When the following sequence of
> > instructions is processed:
> >=20
> >     1: ... rX setup with [negative, positive] bounds ...
> >     2: if rX =3D=3D 0 goto ...
> >     3: if rX > C  goto ...
> >     4: ... code relying on rX being in range [1, C] ...
> >=20
> > The cnum-based implementation only infers that rX range is [0, C]
> > at instruction (4). The pre-cnum signed/unsigned ranges based
> > representation could always deduct from 'rX !=3D 0' that
> > umin bound is 1.
> >=20
> > This patch introduces a workaround forking the verifier state when a
> > register with sign-crossing range is compared to zero.
> >=20
> > [1] https://lore.kernel.org/bpf/96c4a1aa4333d10b882a9b5093d2d982f9f106e=
3.camel@gmail.com/T/
> >=20
> > ---
> > Eduard Zingerman (2):
> >       bpf: fork state when comparing sign crossing ranges with zero
> >       selftests/bpf: test fork on zero comparison with wrapping ranges
> >=20
> >  kernel/bpf/verifier.c                              | 71 ++++++++++++++=
++++++++
> >  .../testing/selftests/bpf/progs/verifier_bounds.c  | 68 ++++++++++++++=
+++++++
> >  2 files changed, 139 insertions(+)
> > ---
> > base-commit: e42e53ae23b7d41df22ccd7788192bf578f24da2
> > change-id: 20260529-cnum-split-at-zero-3c03db9234d3
>=20
> I don't know why CI misses it:
>=20
> https://github.com/kernel-patches/bpf/pull/12235
>=20
> But I see two libarena tests failures with this series locally:
>=20
> File                 Program                    Verdict  Duration (us)   =
Insns  States  Program size  Jited size
> -------------------  -------------------------  -------  -------------  -=
-----  ------  ------------  ----------
> ...
> libarena_asan.bpf.o  asan_test_buddy_oob        failure         879905  2=
09739    4158          3931           0
> ...
> libarena_asan.bpf.o  test_buddy_alloc_multiple  failure         269851  1=
10341    2774          3897           0
> ...
> -------------------  -------------------------  -------  -------------  -=
-----  ------  ------------  ----------
>=20
> Investigating.

So, the gist is: suppose there is a loop:

  for (i =3D 0; i < SUFFICIENTLY_LARGE; i++) {
    x =3D ... range [-127, +128] ...;
    if (x !=3D 0) {
      ...
    }
    ...
  }

With this patch-set the 'if (x !=3D 0)' would pile up an additional
state on the jump stack (second half of the range), compared to
master. Because the loop is verified till the exit the additional
states would accumulate on the jump stack. Which means that
SUFFICIENTLY_LARGE can always be picked such that the program verifies
on master but fails to verify with this patch.

Two test cases in libarena_asan hit this wall because they have
large-enough bounded loops (the loops are declared with 'can_loop',
but 'zero' is declared with 'const', hence the trick doesn't work).

Remaining options are:
- explore a simple constraints engine
- revert cnums
- accept the possibility of such regression

I'll work on the constraints engine over the weekend.
