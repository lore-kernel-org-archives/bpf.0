Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133723AB87
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759680; cv=pass; b=qqaDqAPzH2ibUN2oCGLSYvXlb8RMR7D1xHKZzZmYvaDYrrNZm5T92chLoKgX2M/ZWmXR3ahMxEbN70GMQZbn80EqI3/dDa7MuOkbfqz3u47kvZ4ISRJBJGt4WzCJwOszmgt8PNOqUKwMbVnHWIte4daAfo5AGj0JHtT6TsiwdWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759680; c=relaxed/simple;
	bh=1YLiTEnVHvMgUpdCU7V5v6JTYZoJ3FZdq3r8tGrTvek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czh2d2arMN3n6tn/unzOx40JFx5k0o6yufbDBbC9h02rbt+YAV3fTq20tCkS/GwEsrY1Q7vzzu6JwtUgqrcnuu6rC5n3UFgopj7Bfj7N3QHyN62GBFEGBgqUm9KnNN49YAsfVdweli6+1Auv+wU3TD/Lq6FND1i8UFyVKwdLFoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHgNuuHE; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHgNuuHE"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439c944bb62so1943501f8f.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 17:14:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772759677; cv=none;
        d=google.com; s=arc-20240605;
        b=ED3HF7IxOgGVHXjRjMQxPthDtap0rpInqFdQ5HOgC92Zl6yaZKke2YGoYAPXZeb5ZP
         fsp5JQMWwFXJnqE1RBVKA2XABOjEOTpSAfdKo9AkGwRX7qxacKK9N9Q5KCuqsIKY/2lp
         bNlXXvPY1LJlZlaBj/NMn2/QaVApfRUVNeYcwFSuTILtK+du11KudaW9s7/kecIA58eR
         0RXPZHe2Wu/wUKFjrevASwVAlpWindWHCNuUQ3TyXMy3vtFKf614qs8gq4wmTnwTiYTe
         SBoN/WUbXJq+7evv+f3bntoMkktaIBzF0pWJjSlF3UHsGT3hYN7UTksynktndJaFA55W
         kChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nhv1QpN0u/cUbWQVMWf9fBisQsOocrhCIE8u365Oi1E=;
        fh=vGfLSBsp1PnXwlZvhAOwwYt8+fiMVPAA0oGp//ROPYA=;
        b=ClTc3ncL+h5VGZrR3MDESQf5W9aD6ruMNoIZ9x/qkE6UTL1mbkTi3vVhtMt0NC7JGR
         1FTqXuhMIs/fQelIu4Q6+ah07icoiRSBthrKLnKTo+FpJd4pOjlK3RWv9tWS0GPbm2Pz
         Fwwgb29FeRlnpsEU1Artkc+Gja6Q/IYRe+svKw+53MTUnjPTRTwKivnheOMU9Mnajgge
         1T6R95HeHtIWHT+/9wd0/ZF99Eb7qDCVJ68ROYWyMLOX/aJYZE64YpXzUQfhOAL9F7uX
         gSC4QuB+oMBVttNL5ETi1AVbHkDmLSEsEPn00YFklNfQKuNOqdU7zqgsAR86d5U3AYXa
         +mfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772759677; x=1773364477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nhv1QpN0u/cUbWQVMWf9fBisQsOocrhCIE8u365Oi1E=;
        b=OHgNuuHESuZ9WWIG9ANU4TdvxMlfhnVTEWWiRiE+/+zY4GAJvMDvtCrw1eI3oFDqCk
         TkwqDA8+24DJQ2CVQWMkb+kWvfbjhgfDZpbBeJFxar98RU0vqw4ZndYvzkNFlALE/vbE
         HCr30lohvOKKYi6mo/K7SJeedk663xncrWPiTM4yFwejtZEN/aVAuWBTwswGiukb7L4X
         ceQ+X9co2Fn58nWwAN2BIJsNdNhoji4OxQGWSdGmYYZcCH8FEnIYZ6otYDGD8KxtlFa5
         VoKRJ2DDUe5FFoMOX66d+5GRf+ojxDXVKaHBBD0PLarDbMkWtNuCEBVDLLqTE8UrvEUN
         iomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759677; x=1773364477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nhv1QpN0u/cUbWQVMWf9fBisQsOocrhCIE8u365Oi1E=;
        b=qW5oaYaUNYTqF3y2AfvVd4WUFndJ81LIeJU4biyCA2gs87jt+qVDOokrAQZkqXEv8F
         bAEvCxVecfT34FqnXBQB7lMYno6gG5VeUmH2dk8Xxurl/J1z8Dm4gWrQXPyC0K6E5OK3
         4JqEwIYFSOOmCBIBHyZtQbbPoQqUQn4sQCJkJ/3JJqRyoHhRRrabOCzCSmF3utjqCUhj
         XKovK7JAMUY1eoS/k9sq+zKirjAMxw7PltlzEMGuRRKaIbwxXhsXDIwXZXBr93G9YLiz
         V/EURp5l7k+LPyYazGUgjHjOGjNY/fVKPGqb9oorfnuqxgRY/da0oy8fb9ip2I/K0Brx
         eo7g==
X-Forwarded-Encrypted: i=1; AJvYcCXP46/CnvvX3T+rnmRrvF7b4Zp0bOWCJbTJ/r8/zdOAyK73RSBujx+bLMyCClUi2t22J1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWpwd/9qkfU6Y0UHT7kHuY4S0anWbKtLDyohgrUEN1y2rtiB1I
	ZLSR3LatVCkPH6UOqHnwvHhB0NiiiJqTqiUM5tz1JmahejrK+0h5PlcArm0wPbYq0Lz8dQIBc1f
	7z0JVmT2nbuHETglJJQ6KFR2nL9a8Scw=
X-Gm-Gg: ATEYQzyx5eY7zBnkEeJ3jezgNv5+ZM03JCYdqIrmdFUD3gBGHjYNeCdezjJFkt5ajVd
	+3UeQ6jLhxwvTmMGLOMX8gA8k4JOOosRdqBT8dC5XsENpH4RE1ODFRbtEfQds4xkmm8ZURcdAqE
	kdIjwJ+4gtbikB/d2YflB+ocSmolhb6SwNUk6oxK1bg65eab0PFJUxjbFJKGjsSni1yo84V1LGS
	4lX6g2fBtz6fpbXXav5+t4t19wrKto08Y8WvUNB3ky7lQLr/QBRHDlX4IzvJJLGnoQpxWhIOapc
	pZzyYktYHAxYjRDJYhJhEmATaY5RkCRkaP8Og5NNmfTdSyouEAwWg/7BYn6mW5HBxq7SDl5JkIA
	n6yBunYqUGKKMHIBrEDR3lXjuSg==
X-Received: by 2002:a05:6000:2c08:b0:439:be4b:6873 with SMTP id
 ffacd0b85a97d-439da89d87amr446776f8f.55.1772759677447; Thu, 05 Mar 2026
 17:14:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302071434.311395-1-sun.jian.kdev@gmail.com>
 <aagWYyrrwUt-poL1@mail.gmail.com> <CABFUUZEdbCMrNyp4kEO7A4KZPn5TKi48+tQvaaYaYuJj5FQ7gA@mail.gmail.com>
In-Reply-To: <CABFUUZEdbCMrNyp4kEO7A4KZPn5TKi48+tQvaaYaYuJj5FQ7gA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Mar 2026 17:14:26 -0800
X-Gm-Features: AaiRm52sM61k2krgFio6NQqIohp-pT9tpjaZ4-8nyVLAjS7g73fSblwwIKZRkbU
Message-ID: <CAADnVQJfDYiBHa4f3p_7MpURE_a33+atRbjbcpZ0VmrKFaKkqA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: skip verif_scale_pyperf600 on -E2BIG jump
 complexity limit
To: sun jian <sun.jian.kdev@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 4:49=E2=80=AFPM sun jian <sun.jian.kdev@gmail.com> w=
rote:
>
> On Wed, Mar 4, 2026 at 7:24=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail=
.com> wrote:
> >
> > On Mon, Mar 02, 2026 at 03:14:34PM +0800, Sun Jian wrote:
> > > verif_scale_pyperf600 loads pyperf600.bpf.o, a large scale case produ=
ced
> > > by partial LLVM unrolling.
> >
> > This is a known issue with LLVM 19+ [1] and this test is already
> > skipped in CI [2, 3]. I don't think ignoring the error is the proper
> > fix here.
> >
>  Thanks for the pointers. Agreed =E2=80=94 since this is a known LLVM iss=
ue, I'll drop
> this patch.

It's been failing for too long.
Pls do a minimal change to its source to workaround this 8k limit.

pw-bot: cr
