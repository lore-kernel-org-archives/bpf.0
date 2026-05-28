Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AC352021
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974453; cv=pass; b=HuryhEsbbOw52gsB9kz6wiOQKAjrgJzTorGExwzT5AQ0vQkPC7kjSQftMr/YyoVq6iTrjwXmatI+VIBbd4br+aRemuBdU8u/Jc0VEKWFPQG+TjamX+uCcl5gBooYe1reGiRqSNFQrtX69i3HqijlNSjj2DqDnPbe9lhtKvfxU4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974453; c=relaxed/simple;
	bh=doRGNSl+JRMvhI+mexfOV/FktFb7ko4VJp5Tr8m1gg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYYmu52Lc5/kInpZcdQ3f7NXoBylwmQCPN1Bh70Y2BM84HD1EPvTCEysxJpAaUOdrdk7R+v/7ZexoF1+O8BM0EcSsMN3jLYA7Fj8WYwTzzAp0vKEy0weFEVll7q7uOFQuoJFPIs2/PYsvHzajQR/4N6Edud9h1rxk6CWixiJzlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKfFiyed; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKfFiyed"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-516d78ba1adso4221cf.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 06:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779974451; cv=none;
        d=google.com; s=arc-20240605;
        b=Xr8hOzGFw6fAbu6sgQHZP2RfSi/Nbdc48DlNxZ6X1W+CpYhqgG2lWMUoYKoytR30P0
         q2PU0cCtz7po1vVeJb+oFFV3qEBmUKX+8/+oJFu3Bcii5NcfjAkLC3c5m17BI/5GZn31
         B9fxeuj3vBqwXVmjZcAnEDP0AyV2mQDtoUvAMytaRU3szoCMKQ2J4x5QLMtD7x5kLbM/
         gg3AtZGOuRcU61/iCOW1+ecsPU4J7fXTXFEAcJHfgbHCrCFIQSuRCXYQL5fhKnz1XWLw
         9TRZTnNowePC2rdaAZG9G69XS/FwBwzIhGx8m7dhiNSOjUdcF5/1fdWQtSRQQwYyBX5D
         fwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bVIvtekCCz2sDbkbLvNpEsNZ2RPanGuWqkWHrLbqD/o=;
        fh=UfW2p2qKNMkovIu/84q5JiYOCKiIvbD0j2afY5AYL1s=;
        b=DHTAAZjCyqFV9MCN4II1BM+dyDQvNnR5QXtgzAOguIBdYFIy2XjCZy3otBJNdsfTSJ
         SUR3YpuJrfiu2hmvsn1213KPDwmRWTv59uNnyLykFUG8BssZqJs1uAEQ1xacASBN5OO0
         8VYlG+50U+MQSIwCx0MfzIhVNaRtMu5jXBWriFwNRe2NjJCWGJk6OOect/Hotnx56DYn
         5/EvY/1VgKKulUu39gX6rKk3LNH35vcnVVsUyHmyn04X/Z7gbQfUsag3tEYim+3bfhka
         jUQPqbiYNRXCa5hfpwwZWiFk6PNBZTjL8UWAC0rwfHZkAay28+09RptavC8Yih5iX/ec
         XN2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779974451; x=1780579251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVIvtekCCz2sDbkbLvNpEsNZ2RPanGuWqkWHrLbqD/o=;
        b=NKfFiyed1NpjzEk5cKYX5h5D8N50kGSt9SbV7gDczD4BJsVp7ZvK7858LtmxgNcmWw
         t45+QxwFtwTfXQ4Txgz31vPxlhn611qVbpO+/sEZ4orcET1qe2HGVOdxc64hNqAijj1z
         dXAoHH4CIgwUHVYg2C/zg6qDJUHWsYQM1M/1q9C240DHcuhtrrzaX7ePnMLrcWMKROd4
         EbYz1dCCniBLcJFvKzjURTATtwU+NsYdD+JBZquGMbJXyljYclQBJIjPr8vKGSWbi5XX
         MQ+suc1vJcVvNv/3aGGaPxMO51ZY0bVwCDsffgZDraUpXAmGSssBakkGepjPbpTahosE
         G0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974451; x=1780579251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVIvtekCCz2sDbkbLvNpEsNZ2RPanGuWqkWHrLbqD/o=;
        b=rUGjTaprb6jzJnxtJ90q6wViyuEeL4yQR/8KVKc4InnpZwby9i2ro8B6/ZRx0IxDV0
         B6kgViOLwa5B8Pqz5pFCfbMBfjD+PsO/p5Jp62V66gdmXqdlYZdImzFbztgCnwM2pvu6
         tMmMZLfkVLDtb9/g+Dc41/DFZncA5kWCRODjlaKZ/G+kzcb3D5W8eivot/N8A/jYMNSa
         TibN6jgNFAP581pT4VVorR3D5eiu0oeDXkXGLhMo5UYbhzSjNVHd7zyK8N+yDQZfM5uv
         LjlYUjWfp+mLX+6SS2a2QwzyRjwbffxcYJnKeD17RK6175ygUALY569n5oUAiSZlmtr/
         D/hA==
X-Forwarded-Encrypted: i=1; AFNElJ8RFk+t8BmcVD/uTF4DySV2zesrghBhEFVXW8kiUnYbvhtzXfJzE0l2rk+6XDISnnT6mgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWcEmCQ7/TGUw48mwzuPNdpnFMML7ltvIOudmeiN194Aigwb6r
	yVNGv7Nq5nClk6/TSP+gsZ/gg3jdU/wuEzFCMJ4JZVsq3v4OyeqVAW1l6CgO2OXxrXzkRGl5oAT
	7OCrNZswmGRy8s8OHqdGuAgbFhPWQZKcfwbE6mYhA
X-Gm-Gg: Acq92OHnOj9GgKR0aFGKPtB7LOPmVgweO97VVlDKYmRkTysATYOIlQ8xnR1I9UzmB3j
	AssgwtC3jLpeaVZTYDpr/+vP5b3iPZ67NETcTbT/CS5mDsMnqCchyLLDJwGP7ClcHgXuof6TNPv
	r0Tmz9Yz5ebUpfN75Z4675b68MAX76xfklbOQN1oaBEn7kjt4mY6uaZAyglVJIyxobwwIuFjA/x
	14L1Bq9r++MvE6fj92XCXcgvVc8ZDlJjUGAyPJEMpfQuY1qmDp8T1b5Lv90PJs73MHRJdS7sI28
	LEqDizd9dEQianvCQV15qsZBZTcLehK0WSY6FhA3+PtQjXOLM4tS4CReiRYrN8GG
X-Received: by 2002:a05:622a:588d:b0:510:fa1:73c5 with SMTP id
 d75a77b69052e-51720c148d9mr6767901cf.16.1779974450621; Thu, 28 May 2026
 06:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
 <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com> <34b18a3e-50c0-4b0c-8ee6-d7a291619231@linux.dev>
In-Reply-To: <34b18a3e-50c0-4b0c-8ee6-d7a291619231@linux.dev>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 28 May 2026 21:20:14 +0800
X-Gm-Features: AVHnY4Ly9tBoka2LFYS2KTGQrglvyFosDs5Do3AvNO7tPh98ZxORc7T-1s-cUUE
Message-ID: <CADXeF1HRe=U7aWx2yx6RFZ_uH-mMbdsxMheofr2tMD9wae46oQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 1:43=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 25/5/26 15:21, Yuyang Huang wrote:
> [...]
> >
> > Feel free to let us know your thoughts.
> >
> I believe this is a user space issue instead of a kernel bug.
>
> I tried to use mmap() memory as uattr that got -EFAULT instead of crash.
>
> [................] /* mmap() memory */
>              ^ tail 40B as uattr
>                     ^ 56B offset for copy_to_user()
>
> Thanks,
> Leon
>

Thanks for testing this!

There are some discussion in the original thread:
https://lore.kernel.org/all/CANP3RGfZTXM_u=3DE_atoomPZXutoQJ02nOMkCCR-YBZbO=
m2suWA@mail.gmail.com/
as follows, which might answer your question

> > > If the uattr indeed has less than needed space, then for
> > >          if (copy_to_user(&uattr->query.revision, &revision, sizeof(r=
evision)))
> > >                  return -EFAULT;
> > > the kernel will return -EFAULT to user space.
> > >
> > > Maybe userspace didn't handle the return code properly and causing
> > > user space corruption and segfaults. This shouldn't be a kernel issue=
.
> > > Maybe I missed something?
> >
> > That's not how that works at all.
> >
> > copy_to_user() will only fail and thus EFAULT will only be returned if
> > the memory area copy_to_user() is trying to copy into isn't
> > owned/mapped by the user (or perhaps is read-only protected, not sure
> > about this last one).
> >
> > Because memory is mapped in (at least) 4K pages, the memory after a
> > user buffer is almost always still valid memory.  It might be unused,
> > or it might be something on the stack - like a return address, or it
> > might be on the heap - metadata tracking, or a different memory
> > allocation perhaps entirely.

You might hit the same case as maze@ mentioned in the thread.

To trigger -EFAULT, you likely positioned `uattr` at the very end of a
mapped page immediately followed by a protected page

Could you share the test program you created so we can verify?

Please check the test program I shared earlier in the thread (where
uattr is stored on the stack); the BPF syscall returned 0, but stack
corruption occurred.

If you think my test program contains a bug, feel free to let me know.

Thanks,

Yuyang
