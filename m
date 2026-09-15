Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E684AF158
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491213; cv=pass; b=nO6v4miygkwPcffJJ8TyW/fMANKk0Z9VVIOA3PHCN+iFEQXRVP10Qy4FEb4eJZTBbY2sr/TMzjPZr+ID4mKUpBsiBn2NpUdC24upF3hDzF9vPWt6P6E0VAeeFnxi0YgQfoBAmtLzKoWAUROC6tNPVkpxSPdkMIR8PQW982qUex8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491213; c=relaxed/simple;
	bh=8hiFmlyrGd2F3wxapBNxIaX7W5L2Ouq4sM8CP6qd4FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzycbO7PhMtWggBSUV5dC3myZrqTvmssEQWkd66nyXYAWdOBpGd/7f1m6znTcmybBeKJgtdZ52Eg4585xHKdDOEaLKxwP+sM7kIXO/lWbTNYrQ96i48VyLJ/IJG1ik+puyNa4n8uuub3Vu/yi9LlSZRgGgbdtJClvJw+s96IMEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qS+S4pGw; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS+S4pGw"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f70553dso11898066b.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 09:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789491210; cv=none;
        d=google.com; s=arc-20260327;
        b=bA03zKQyFC76NoyoOsFRg9fSb0B+pxvTECORSkMvqjDdsDPo75EKQfWyy9KKFWqRIg
         OyrqTsECv1SQ2uFrpEzdtd+0Ssv8Ew3syzPOnipbRb8cenzCGNdw1BgZYGalHgSnaPpp
         spzk2OkonsmfEleMFUQRoqH3D/l6Qz85YYXCJzwvtnuH2HKS/OOadaXkwNaPSAYhOyyK
         1iv4PCOefu1PTTy4C0BNoY2j5G4fQDjvFz7cbb1n0w/Q8OaWsYCAYtos6NYdHURjrT7E
         zaJX4j2zUrYoAcY8yp/h8iaaxsrGy9K+qEmESIo1ZiQZ8H19+aT9QseBtgk9ubVuerC6
         cpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tdsr3ba5NiA2sUranbYpQ+z39cmPBvOyds1BGjoA95Y=;
        fh=Z7vfaMqTDPhrGOC5uAsUKKmXnKJd622tFSQcicnk51c=;
        b=BinCDD7LtWuL/I3lq5fzr7LXFfQrAnpqdt9QRJLRrd0OcEqGJlbZoZ3s0DArDerVGd
         doXQ/Hd5ix+JBnHECD7EZIdHgpPD/a/YTry59xCv9nS3GMWtX/hu1pbkQV1B8PqqBja9
         n5s4ot5vzjM0YIM37TiXBqXBnLTAK491a0mUaSaoP0TeLAi5MYxm/tt+3Dj3JUxVcInA
         5kmCciinUYr0GZPNdUoczn8A9XbnXjJFVXYW5XTDhiC/lODFMaWfaqq2Hg1zdA6iSz6j
         97Q8LqUDZ3i8f3KvFhcvGDRnWOOwDRo/T5lWaERbDrf9RPjBifxVtkSkVSdpu1dM2ca4
         7M4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789491210; x=1790096010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tdsr3ba5NiA2sUranbYpQ+z39cmPBvOyds1BGjoA95Y=;
        b=qS+S4pGwFP3wB+HZ6Gl3LhWeyM5mqnXh79xSDZJGUUIBDmWU+U8Oh3EIHwdJ1nc7qn
         76Pp5shxs+Fl7BwH1jHxRHSKoJCv29DA2GNQtp+lG05OALQ1OAq7gkFj0W4qs2yKrGMd
         adEYRraG1M2ZlaLSWbnKH9H8Kq1245EJIg6ktKympA0Q+I2gMFHCCokRFsnuOgxgm6QX
         5NyvtbXpNMb2wBeDL1wJz+rVou4zPV309jkJyIMWgVz1ODKFdtmHCJP9Dn/FKBkuBkVO
         rTziJf9Ij40ExgRGb2NtAEMAFsBFrkfpnmAqkIKyQi9/m3XEqD2XdTwO7HOdxITOZwnk
         8rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789491210; x=1790096010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tdsr3ba5NiA2sUranbYpQ+z39cmPBvOyds1BGjoA95Y=;
        b=NhtWBwcva3aKvEADzdC7zXcX2YOvGNE5bYHGR3VidMYQtVWT6QAUx2tmv8JKYZkUg1
         4h52Sgq+dIpVfgxDRSNHaBG+I+v8nq4UBlJemiWI45sIeD+uuTZcUJbZbvBzvD/D5pzr
         ZHQ8ww94eCNbwXFERLq9MllkyFRN3Cq8HN6oTl0XuRd4mvwulz+qPXwJGJzb4YXcLVlJ
         TxuxFuN0IGqotgl/+Sb7BIVVDrSj6Wve5apu/4MU/MS0hB3aeTr0zkXjR3jM2fMkuzBK
         2q1GTYRBcSHLhSPXiiN7Zg7eOJEX5c4gK3wmoDoK56eX+fU5+dXDep4k+lIx+JSvSQID
         n5Zg==
X-Gm-Message-State: AFuF++nnTGeYJVWUd1c6YSOchwoJG4egcpsHi0WkfyNrWlvZbW5NxFYY
	cf5vecXYSwWgQkGVoTzE9/RHjKMAvfl1zuv9EFqxzfkldlU9z7vqUz5ewPUVR9BDA4Xnfd/RToL
	6bMAxCuVFZPkRIx+3U7r23TUcCqgHpFg=
X-Gm-Gg: AYBFou2Gm+711PS2b4L60Tj9g2yv+z0LKVD3ZeeN95CAHljM9MqyxMcwE8ROWP5mUuG
	djfx9hrbO+N3W9e22X3Ikx65YMlFo25STZe0Q3x9Y3NcLV8sEzvWdl29kQ7Fopcor+nj9bxmxz7
	oJ4FYKV3zuaKjp5YQabn9LaZcvlWJ6TIybkRXXhF/D3/KwW8LbhexmO3qiSxnviR8C7oI2BOU9e
	lcYLIHD1PAitp3Ow01AwdNz7WD505oyfAp2tyGhCqJaBBDzg+OUIhrbbVnYugrYAsTALzfhvjbe
	W9uAx/EcnPzYC1Y5nh91olSdKgbzaRKZ3Cbi6N3cDiHK/EjozQ/qKukwhJXGw6wFo7ol73k=
X-Received: by 2002:a17:907:1c16:b0:c26:227f:5f7 with SMTP id
 a640c23a62f3a-c29b87d864fmr551357566b.46.1789491209730; Tue, 15 Sep 2026
 09:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915154248.3612028-3-puranjay@kernel.org> <a696904c51d47023b4dfabcf0a246ec9ed057a0dc8a286a21f042819b8568f05@mail.kernel.org>
In-Reply-To: <a696904c51d47023b4dfabcf0a246ec9ed057a0dc8a286a21f042819b8568f05@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 15 Sep 2026 17:53:15 +0100
X-Gm-Features: AcwNN1VwQluCIKHuel74dopkIP6TcQoG0OftwzykZL7CDUVrHXGJ_QR5XW6bc_c
Message-ID: <CANk7y0irwNsAcDWF5WAxhR-v7L_xwLj058HGUQgHd2SKFn+wcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] selftests/bpf: Add tests for bpf_call_rcu()
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	harry@kernel.org, paulmck@kernel.org, martin.lau@kernel.org, mason@kernel.org, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:51=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/call_rcu.c b/tools/=
testing/selftests/bpf/prog_tests/call_rcu.c
> > new file mode 100644
> > index 0000000000000..c2d266aee8eac
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
>
> [ ... ]
>
> > +void test_call_rcu(void)
> > +{
> > +     if (test__start_subtest("run"))
> > +             test_call_rcu_run();
> > +     if (test__start_subtest("chain"))
> > +             test_call_rcu_chain();
> > +     if (test__start_subtest("two_heads"))
> > +             test_call_rcu_two_heads();
> > +     if (test__start_subtest("teardown"))
> > +             test_call_rcu_teardown();
> > +     if (test__start_subtest("hash_map"))
> > +             test_call_rcu_bad_map();
> > +     if (test__start_subtest("iter"))
> > +             test_call_rcu_iter();
> > +     if (test__start_subtest("inner_map"))
> > +             test_call_rcu_inner_map();
> > +     RUN_TESTS(call_rcu_fail);
> > +}
>
> This isn't a bug, but would renaming test_call_rcu_bad_map() to
> test_call_rcu_hash_map() (or renaming the subtest to "bad_map") keep the
> name/subtest pairing consistent?  Every other subtest string here mirrors
> its helper's suffix - "run"/test_call_rcu_run,
> "chain"/test_call_rcu_chain, "two_heads"/test_call_rcu_two_heads,
> "teardown"/test_call_rcu_teardown, "iter"/test_call_rcu_iter,
> "inner_map"/test_call_rcu_inner_map.  Only "hash_map" is paired with
> test_call_rcu_bad_map(), so grepping for a failing subtest name doesn't
> land on its implementation.

Yes, that is a typo from me. Will fix it in v5
