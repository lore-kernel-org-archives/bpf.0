Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B8422522
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233624; cv=none; b=i4v5f2xuiNPM44da67U0ezo02A+7JwBtkj1dtXPgzvK7dU+2c3lTKIDEtlHjKLofSlFg/HAoUr9nvlr0cjJ9XrdEwlxAA+vLL3IeqrfUivkGzV35OT3YTd7qffcHh/VZFGZ2jsJ//u0Ys+j/salZtPSpQRdgcZcsCDa95/ekXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233624; c=relaxed/simple;
	bh=fSy2bFU6GAk6z5ZL2rJh0ddr4lBF44OoZjZB4arg5Sk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHhkOVHxn+4fM2sKqvjpaEON2WsXjn3pR9JKlFp0zOc9ahxkf1Gidz0M/vrXuGbErGtufIBKs1V+l2eCMI6nnWsD8k9UNVSedX/OuEiYQXC9yIjQdd3cMP9qMPlQzjvnY2Wx3qO0QhFNHQCDuq6DuZKLx/MRW95WxOTFj/LlWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvZNxhm6; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvZNxhm6"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85f0fc1fd8eso873736b3a.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233616; x=1790838416; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fSy2bFU6GAk6z5ZL2rJh0ddr4lBF44OoZjZB4arg5Sk=;
        b=gvZNxhm6X/Ho40VGWUzqu8Cdr1Da/XA1GMZqC9Hy/XiIzhGECzDdrhLUbNFXH2evJT
         XcZ16gDPw0lBqhC8aUvspTisogSd9VUTJl78AlA0P5kolGuqPh8Iesd9bF7b+sx2v61/
         vMy0NjLtnqd3hg+3ZV7nEjR+QKtego5hLYzZlhcDbScT8gRs375gfT1NFDE4zUwYJxW7
         9xZy01cG19s/jQrTT/1zHHzL/9iX/mM1MxY01BemIAB/26vnhJSgu+hQWVL0BL6JIu18
         a46XiggZZ0B417q3E+uQ31hpxGjn4Da6+s2MsZ4JDtaj6B72+jKK4z2wblqwGbcIn/gr
         aIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233616; x=1790838416;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fSy2bFU6GAk6z5ZL2rJh0ddr4lBF44OoZjZB4arg5Sk=;
        b=MDFxZL3igKMVEsWcmzRuzqBvHEFMid+FEaGGSThSzXPmNMUO6rGSxWkIi4/DYxoMLh
         h1ORuToLqYoNGZmWwYmQklM8U57A+mOnKHd/DnZC3IDpuA9j/kUpYfn6m/usINWWk66E
         CqRpY0tTg1y+dSUUmgPlTQVB8A04iPEGH251cghgv4+tvXbB3VHzeqspNbutEzuXJWtF
         3kQaHFMuty8ZvLupVXwd1K16UmJGoO1SqJ4ddf/+X5/jsCOoEx3AoFj+gVlUL3QSsfzT
         zc+7XVyZC/DeMDmND/wUksZUogvNT/GzkKL0rdUHoNVDngKqx2+qlzuv1bKYx5yUZIiA
         zpjA==
X-Gm-Message-State: AFuF++myPVQC/iXiiy/3y0T5/cj5PFYYonotf1QLtHPTSuToefKO3/o8
	996B7OIbi/GnoNBJ43fgtKIwWVrYs+45aoifs/X9TpOp6d1uYeuvLUf5
X-Gm-Gg: AYBFou05WHZ9Yzpe0c8zdJVByel5//u5J0VLD5oo0U0MyBSnWnD1Ng4ehM9QVdw/6f9
	g1VerMacJj7Fo8ysg7i1eoY3hd4srCfini4LfGT/+2RaC6M6ivVahrswmnRUFsqsn52tiNTiHXn
	7hcAVHaZRT+e64zYqewnOdiWfaH9O0WcKGpDJOPWxXwX+ZZKZIcIuIwA7xNrN1xWIoTEvF5YzXn
	HjL/YVVCLTMbOBFnioVsZfRJz8bwMWMjzEo9b11C+VBLuStDO4Cfz16bVHneXQ5cc2Lswv8TETi
	8McFTOS3fqMlip1QTC6tU+fQxIVMTUXuVtgZ+vQZ9yELks4f0qsvrNBG7SSDh17x3qvIbz+blb7
	uD2ZkeygxzYl4bpHGaYfjffjD7YQIR7784mt7dSZ/VfmpzOqbYxmYYkz65rLhfJnoi2kX0tr/5B
	AH7jL+KTl9bg0nuUQPnDmPeyAoE0PFKWxeVGzP1ekCYZYp9rLNE/y/xqZqRiH9cTLoCvl+hVzFl
	cco+MLoHRYems6w5SExTWY00xs=
X-Received: by 2002:a05:6a00:340d:b0:878:391d:b217 with SMTP id d2e1a72fcca58-87e9d001107mr1322001b3a.60.1790233616005;
        Thu, 24 Sep 2026 00:06:56 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0fc5casm2368187b3a.53.2026.09.24.00.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:06:55 -0700 (PDT)
Message-ID: <78e6ad2dc979983bd65514166fa0020729a4147d.camel@gmail.com>
Subject: Re: [PATCH 0/3] selftests/bpf: Fixes for out-of-tree builds
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Ricardo B." =?ISO-8859-1?Q?Marli=E8re?= "(SUSE)"
 <ricardo@marliere.net>,  "Nico Pache (Red Hat)"	 <nico.pache@linux.dev>,
 ihor.solodrai@linux.dev, nickolay.lysenko@gmail.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, Emil Tsalapatis
	 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Yonghong Song
	 <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Andrii Nakryiko
	 <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
	 <martin.lau@linux.dev>
Date: Thu, 24 Sep 2026 00:06:52 -0700
In-Reply-To: <DLM25PIKJTE5.1Q1IO5PAM6VBD@marliere.net>
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
	 <6f95ec90-194a-4304-9673-c7bb50065223@linux.dev>
	 <d3a251acf5131bea732e23bbd135a5fdebec9ad6.camel@gmail.com>
	 <DLM25PIKJTE5.1Q1IO5PAM6VBD@marliere.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 15:31 -0300, Ricardo B. Marli=C3=A8re (SUSE) wrote:
> On Mon Sep 21, 2026 at 6:04 PM -03, Eduard Zingerman wrote:
> > On Mon, 2026-09-21 at 14:40 -0600, Nico Pache (Red Hat) wrote:
> >=20
> > ...
> >=20
> > > Given your series was defferred, and there is a "rewrite" coming, wha=
t would
> > > be the best approach to working together (between us three) to get th=
ese
> > > fixes in that series too.=20
> >=20
> > The, "rewrite", as you call it, had landed today.
> > So the series in question can be re-spun.
> > Regarding your patch on top of it, it appears you can just post is sepa=
rately.
> > However, I am inclined to be confrontational towards changes like this =
one.
> > The purpose of the selftests makefile is to run selftests as appropriat=
e
> > for current tip of the kernel tree using a very specific kernel configu=
ration.
>=20
> Ideally, if a Kconfig symbol is needed and the kernel under test does not
> have it, tests are skipped. But with BPF they were simply not built,
> rendering the tests useless for anything other than in-tree vmlinux with
> tools/selftests/bpf/config*.
>=20
> > Main users of this makefile are BPF developers and BPF CI.
>=20
> But they shouldn't be the *only* ones, IMHO. Enabling distros to build an=
d
> run the tests is also valuable to catch regressions in their kernels, don=
't
> you think?
>=20
> > Support for distros customizing the makefile is a non-goal.
> > The "PERMISSIVE" change done enough damage already.
>=20
> It's ugly, I agree, but what damage has it caused? I see that it's going =
to
> be reverted anyway, but I would appreciate if you could elaborate.

It's the first time I see a makefile that builds stuff not fully but
90% of it and returns success. The damage is the need to maintain it
going forward that already cost some time.

Do you have a list of kernel configs you had issues with?
