Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00A282F12
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778982300; cv=pass; b=IcCzbuomZVeCsDPZ9qy2CUqJLTkwClJV7D5s9PeHMrIXjbrvqUDaUYFpTiRdG/eaeV1Ad2uoD6lDi48Ssem4ikzDcVXAYaGjNK3nmLEy/Gd4q3yU4kNdGA5/xJPbC4R0Ip2OHvm3uEMhtkgbz8p5MlpGaQ5lcqClorhoRzToqhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778982300; c=relaxed/simple;
	bh=NEDl5DMoo7jrjGwiAq57+R3NM7H6fAc/K4famdkSEsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcP+5pxoP3yGQbIZELPv2GTL0nnNVS2lAWS7ZH001yqd+lZGo6c1UgoToy+NNDXzbOn6jxye2r2cpbqM4cAqDmQrZ1eICfg3xiDHjKs1kN+Oq1R+EME5+PaAUJOf7IGoChitOyHobV9PgBoU5OXIQsWv+h1MKmxuJcsv1CQ1z6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njybb0mN; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njybb0mN"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8f97c626aaso248328166b.2
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 18:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778982297; cv=none;
        d=google.com; s=arc-20240605;
        b=k/GPFS6cu0ajavTwNveol0JxVkK7sIC9Y7HZTVxT4STJcYJg9SCEz30XksxSTCzOYz
         eXXjjyOgFif6cnygf6Os+EhKsYPToT8GymGFc4oxpV+lAm8eIqGNdhr1hQzXNqSMztmc
         eGM7uiOBr3Wx9B2ND3mjtStBuNQqLbZrpnSCNjnkv4xYE6mQK3hlzFDyIdexHyAEH2XJ
         WD/wqAR9ZHVBmPSUUJvKgGkU5y9JKAtuCrtB4B8Yk4iD9oahbkBGiCcXe4IrQm/3qHk9
         Ztx2QE2Mp+zAY7xC7WcPErNhq457hPGKs0KZu7N4uhunyF56Jo7td+EqZYHqPzmaGkwN
         yaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nGV3pUFeUKLiEnY2yH7vsWpwkbUOOPZyrYebt0Swvic=;
        fh=YCk6NYLv0a5GiW7ok5zwNvEnZHOnsFYC9qcmhO9KnTM=;
        b=Z+jfu0BKQyv1uV/U5jYP0wkThJwoftYWCunTQB477CLXh+3IGQ9Oy770ccQOgjplfi
         Zb/d6ZrKHcU79hKSGzhn27bxfmZjce6VOU73TDoFw5ROdq3vecOIDNPlXV5R5iWyBaN0
         r3QU4E+Y55KnWQvRMYDS1TdgAufdeMqHDwFra8LvHCy2it+0AGBQKWZyaX89iQCqaF5W
         mLYrYo/8OmqiaUC2BIxVMx4nshON8+4YuWLEp7i0W7YcP4ZFne2p6wDWMVMtW87xUVNC
         iZ2iEYpyQ17/rCuv2cusKivyiORAwnB8nSGoWeKemnaHtKVu2LJcWZ4jrk0d4g3mYsuN
         eKDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778982297; x=1779587097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGV3pUFeUKLiEnY2yH7vsWpwkbUOOPZyrYebt0Swvic=;
        b=njybb0mNQnQepO0/TiC+vUoH89+vWTZ6cNk7WwUSkNU/3YCbA7EJCqPb1dJkvzUTkD
         OVRohXHGvZeZw/qyl6+0jP7nsyXo6Bu48zF0MI8+1ESn/GkX/lDvsB2bk+7tZHRqqCXs
         p55WMfiobBlWmB8Q1eElCsf79u5zlEIb9UmP44JJBvZk4Lhusv+9v3RqPOM88Dc2q9NN
         zOlUHyCQ/0tTrzMZgkewhvKE3Yshn4h154n2iovPMaNq0ifOyZnkUgN1ZwBdKRZy1f2C
         uTzcqcStqTU5d5P61Dl1XnQrtv0PTEsppRLdoxXxhLK5kke6H0qHL3hWuTnF49pr9WXc
         LqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778982297; x=1779587097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGV3pUFeUKLiEnY2yH7vsWpwkbUOOPZyrYebt0Swvic=;
        b=sOebK4elPEqcAdsGmCbK70VIp7Zvk2ooxs9Ts3hXkciphXIVRW/vGTDuTQ5svhf+Bg
         f1twzEHVBcItFmmlS2P62m+SMLF8xOSon4upOseWHbKUmHCnYPzyOFZJOhXKshs8/HX5
         pQcr26SqeRlVNNjz9yp+PwTUYmMORxUZFnaCpHbO7d5KlPPadw2gB0j3uAdF2/fcQ7i8
         1X70VaBE6kol5eyxlw152RGB3gUwPQScj+gFgCIJXyjtsnh3MqK1ZSKzFih2PYzN8gON
         afy6Yy+ScQggaYyKg30pMZLsXGOSe61ezcJJ4SeQTePLMX5D1f4OuMGrEBQmtTm0FmEz
         HBEw==
X-Forwarded-Encrypted: i=1; AFNElJ/RZRzjw7yHYd5DnlhzIWinPMMim1hXi4i0wF7MYEb84De5t7yjq2Ztzk3EApWxxQr0n2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/fJ/PHMAKTDu3suU2kbfs+j8ud2c4bonn+gWK1LQGGH8JVgHU
	SFDFi0EmKrL8pZCRcXrWEcs5dUrWSY5S1KvB3mLEsGaAFIv88xX4fTuuGkRI4DpnhfBVCg6pvW+
	ABRSm2h98xYfREkcMFiAiYr5Vb7PAXLA=
X-Gm-Gg: Acq92OFzWgzLK4Yl6o8R+kY22U95yqgGDHC7ZwavvR1b5m7gPqWj26nHFWEORi8D/RN
	3CepOtq3LUbnzmXZZ/xk1d/E+a6qEbkJKmSD2KejE2EORzbp8jBb1a1l+JWTIxHaUlmzOj/caIl
	+VBWxnJG+ki5E7/+PhSTLaGNct02ZuVFGJ47ueL01vP0gDenB9GnF8tOiuR1tnfygWPY7qtm0hb
	lA4FqECHd3w1e0gch77CGZEquogI65xnS2MhKFyau/nITgfXkuyAuA+L/HBFACyUpaQc7eWhzRZ
	/W8m9iFij2bz/j9r3/CzCtvT0y3MUEGfODQ1KsRmOAv8pqVoTmO7VVpArWM5NwhjiRJhMHCXuHY
	4v8FWyD0B77YhwSXaslwHzbjXb/nYIIqDM4EiezekLtYIel8=
X-Received: by 2002:a17:906:6a04:b0:bd5:7c2:70cb with SMTP id
 a640c23a62f3a-bd517a9ea73mr524298266b.49.1778982296944; Sat, 16 May 2026
 18:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515014958.1186132-1-yonghong.song@linux.dev> <177898201164.476559.9152177315116491592.git-patchwork-notify@kernel.org>
In-Reply-To: <177898201164.476559.9152177315116491592.git-patchwork-notify@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 May 2026 18:44:45 -0700
X-Gm-Features: AVHnY4KmlDr13NkRi5eo3drI5vdon69dRYKeoJV6UwUNe_BSKcuuOHqIcXUSruQ
Message-ID: <CAADnVQKqO-avv9rOM_kk1gktHQQODVxz=sPH-gSFG0VNh08Wtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Validate outgoing stack args when
 btf_prepare_func_args fails
To: patchwork-bot+netdevbpf@kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 6:39=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
>
> On Thu, 14 May 2026 18:49:58 -0700 you wrote:
> > btf_prepare_func_args() sets sub->arg_cnt before validating arg types.
> > If validation fails (e.g. unsupported pointer type in a static subprog)=
,
> > check_outgoing_stack_args() is skipped because btf_check_func_arg_match=
()
> > returns early. For static subprogs, check_func_call() ignores non-EFAUL=
T
> > errors and proceeds with the call.
> >
> > This causes the callee to read stack arg slots that the caller never
> > stored or not initialized, potentially dereferencing NULL caller->stack=
_arg_regs
> > or getting no-initialized value.
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf-next,v2,1/2] bpf: Validate outgoing stack args when btf_prepare_=
func_args fails
>     https://git.kernel.org/bpf/bpf-next/c/4286f5deee14
>   - [bpf-next,v2,2/2] selftests/bpf: Add test for stack arg read without =
caller write
>     https://git.kernel.org/bpf/bpf-next/c/ef1b54e0db67

bot is confused.
First 5 patches of v3 were applied. Not v2.
