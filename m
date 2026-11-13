Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794591657;
	b=dQPij/PmHlFI0+C0zxasZerq7FaIktG++nPPysWe8AlQWvtcLXtZriGlZLtNxJhZXYh5
	 vVRJe1hd/+CmvIyTPDi4ZUQgPDE5fRxoWgCpqlGjbsg018sYyoWFr+uuRbuCIcgbJGiUn
	 J0GB+8uuhPHKjQZKSc6vz/rbIuVnplnH/HokQJj244TbhhWmsTzgzY8oHqzcdcrwAHx8j
	 XLMYnzhKl/0e0MWzVUaYZnxi+V4UZcp7ZPDCvb8BGQ2sdrDeDbfgkvqf2aHvl/nBtIeK7
	 WZCOCLW+rPZ3WYIW06Z29x1klxIqYIUh4h+O+rXl4IMTaY/5N8Owns/gGueEWto+hGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=aTsfJL3Fjl6wj8r3f4NqIO8QlG5kearlzOuXsxbj/LM=;
	b=WXlwo7nSVssbIsFAdzj0QypmryzOLAoHRK9r5mv5MUITkqb/PuMtD7DqwkaE9AlaEVM4
	 YUc1Eii40/pxmEvOGIr3ts//u9o1HomCODx7gQet3+7AgnF4AWGYDvCZNbkkzkKwt65Vi
	 3+864H8ql1p9lZhPkH91Wk1RKJMNJhacecJbSl8pI/FfdLmQHFPqtmM0rdON0gDtNrO7S
	 biUeAC8Sy8dI0JaNYCFRBwW73Ss5pwL3GD40xdEnRtjBJGgMh9N1yEFefN+PGolN4fPye
	 IWzTEm7uDc/IPVoMahqzW9XWgVoAAEARkaFnJIPoccZOVUStUGRmZq+5ZEIOUjeoK0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4Rzv+Og;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83E60703C5
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA83E60703C5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4Rzv+Og
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so1814963a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 09:40:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794591655; cv=none;
        d=google.com; s=arc-20260327;
        b=bS3Y27qvEmkLJHj7op1HJh9XHdT0NQg4w1iOjK9ZjJ7PSd4nf9XhAkXZ8seLd5zDwv
         etGoKSNrVikXImDWk78OiIEEQV9xI9bS7M3wWGeWfUqDUYRKfEbgfNBHq3ut8RBZkMSM
         0jkTy2gy5csdsBDABpwFMZXw8PmZK2STTyajCcRKKtIbB75EPfKOBVhd1KCBS+07zPnd
         RlK6StW9lcRA+A87qhXOc4y13rzNJpm1q6Rg8df6DMIYiuX6z+ENI5PLNjl7V2vjhRnJ
         5ZUW8Ym45w9gxMsrMxjseNcX+RsChjUOpyJFlxAmk0huZ+R9uzEJCXyDkyubAHmTwI/Y
         59lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aTsfJL3Fjl6wj8r3f4NqIO8QlG5kearlzOuXsxbj/LM=;
        fh=PrZkkWZ+PKgTDEMveb8wPS4rk8eWPNB/nwBatzwX+BQ=;
        b=PvTkBzhMUQ1F08a0GhZfPif01WkQ8ZKpXoCSVjyxs7wG6WMnRRhGFf9qC5tAPXnsLJ
         aexAS0+oiGw0LCg4QeY7XPB4PwJwlAgJciVSglgOgiHtuEF4qtKtMhTFOXCbBg8WoDL6
         DbWLwrNr5fFSRg72+i1I3QJ/fMDGRv/+5xja2sxF+BpOflccSIjRDSqX6cC7I9hcg7oF
         Xbx8CxqRDeyxwEvoaY2afWYUZDe/itkNv4WHT4UO+cFyX3H5dxhTHqNipD+KdUeHLFct
         gdTZaHoTkrSJ2m/yI8kd3YjAv/pAUgphNN7iA3iqXO9XMkgr/+IbircLZhnFn94iHKFD
         fruw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794591655; x=1795196455; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTsfJL3Fjl6wj8r3f4NqIO8QlG5kearlzOuXsxbj/LM=;
        b=B4Rzv+OgmVdQHu4oJh52XnWUQXyObDL2qSwELgYm6bSBy27hzqLEH+Olx7/6Swgyig
         spbFBD8IesAJU5bpws5ADa4pY8viZbT7IhfaXlA56KJ6TDb8qcyBoJWlbIcuqIGwSq6h
         DQufYlYdxRh90I8ijl7Ipx6X5rH4stremZF8sLwqs5S2zYuTzRE5Vl9D/YWCDCJRMhVP
         yyoxANPOnT2SDDdyKphWzSNDgWWvyhKwc2xoqOOK3xThcAO6dltUnQcbQCShFKGFBbja
         SVks3rZWsSqu1BdtKI+z6LJUMCLsJcFuaZjmeAPNXnrbyQxz/F0RckGFGCU/GJ5kDRHR
         cXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794591655; x=1795196455;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aTsfJL3Fjl6wj8r3f4NqIO8QlG5kearlzOuXsxbj/LM=;
        b=QVNkDGoY4bO/467NdJTlx/hY+Ly6kjf5p09c+CCgmwpkcq4+oStsfuQR1C5uKUtSZR
         58dVwNIJOqlQtczyvVvgUCvawJSM9/mPdffkSsTR3W8mP9P3Ebue43X456UCTEaMZmBl
         lxcG5npI3jQJ0bmDIWvxkXe1yDMHG4POjmy4oPBm1OILHHvVcKeCEjgolgDyx/w6RXT+
         7sw27eQAPJejjy7ysXfBadg8j0YuPGGEdlYP78JEJxFtDA8DLPBbJH7IERdAm8ywp+mg
         ubpJSg0ke/SeQYW25/b5SroXmfUTu0zxp4LIppF2RKWvdPUPPKxsCZOsYpZ/+RYrQkW0
         U4Rg==
X-Forwarded-Encrypted: i=1; AL+hErFEk9w8PY3ses6JA0x+4WfMe5ZgLD66oEnZ3CvpszPygmPabTbUkD1R9a856a33iXhUOjg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yHKAADj3IOBA6JnOjzDOVx03HfHc4IgtKpNFYtp3Yp1VWtlka
	v4lVyNdEy4WBTKE0jm/I3ogikburCsX5I5O46yo3uMZF5QQEiRxxyilaH61U/HAS8E4Fedf1u5V
	EiiNAj8z1Plyi14cIq1CN2WkJ7dkeD8Q=
X-Gm-Gg: AYBFou02Flc4GtqpbHhIPLeJupQypeTYTGB7UuXg85IG1qcTbvlmWM0qwNSixszHBjz
	usM5TmEqcQzBB04qlz51pYZRn1Ogws11BHUzkk3kmepod5gc6Bqr4b2DufjtMfWeURyKkVLC0wH
	mF0I8kyryA/6DecVtexhy57+UPQtNDUo6sBg2ccWk63fPRmH8CLNdTI7vXIsNVLFXJu0C6uCts5
	ontjBX+VryIC6V7G5PX26tKWIhoh44sMUps94hCAeavHvQq5ySj33jaQQuzWNz4A58F1zC+KuKi
	yPwkFQmGmZW+ee/F/ZocKqsrqDtJZmhdh21b7eM/GGkuOrwiH74BPEXWB7JRN6Aw/kLIz7idWei
	1HbB0iQA2guqsEJM6ji4FN0Rzpa+XLUbs9kPorg==
X-Received: by 2002:a17:907:3cd6:b0:c41:cf68:bbcf with SMTP id
 a640c23a62f3a-c5096399d37mr295805066b.32.1794591654892; Fri, 13 Nov 2026
 09:40:54 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-i386_bpf_jit_wrong_code_20261028-v2-0-1dd0b03072a3@gmail.com>
 <avdKWKhsV6dcZ02W@google.com>
In-Reply-To: <avdKWKhsV6dcZ02W@google.com>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 13 Nov 2026 12:40:43 -0500
X-Gm-Features: AclHuK9DHBXdCNLb2CbpUETFiX9UBlNHVVtYQ5vnqxH4CRZp4OwPMstms9PtKpw
Message-ID: <CAJZwKkiBQJZofwpps43SUGT05Hb4oOHZtv1+J6n_30wqOO-LCA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/2] bpf, x86: Fix i386 JIT signed ALU32 DIV/MOD
 and MOVSX
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Wang YanQing <udknight@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Yonghong Song <yonghong.song@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Nov 14, 2026 at 01:35:20AM +0800, Kuan-Wei Chiu wrote:
> IIRC Alexei mentioned previously that he didn't think anyone still
> cared about i386 JIT, so the i386 JIT patches were not merged?
> Now we are seeing more i386 JIT patches. If we really think no one
> cares about this platform anymore, maybe we should remove it to avoid
> receiving more patches that we don't plan to merge?

Agreed that the i386 JIT should not get more work than it needs, and
that is what v2 is cut down to. v1 added support for new instructions,
which Alexei turned down, and all of that is dropped. What is left are
two instructions the JIT already accepts and compiles wrong, so a
verifier-accepted program can run with values outside the range the
verifier proved.

Whether to keep the JIT at all is the maintainers' call. As long as it
is in the tree, these two patches are the minimum to close that gap,
and I don't plan to send more for it.

Thanks,
Nicholas Dudar
