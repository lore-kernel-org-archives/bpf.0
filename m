Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379D427FBE
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412710; cv=pass; b=W8ioIm9m8czfvrFjBMUhtLVHxwMQYel6X9KsAZAjUQMeQvIGXyIC949jOV1ukQ8TNi6YndtGYznFm1qiQXETFG4iio5ZOKaGCxLEEsrJ+GMTw21Pl026xSiMDIwX2tSjM5zHFxDBkXUiD1GS74H1ByCAeMMtKDB1Mqv3ZTSvyWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412710; c=relaxed/simple;
	bh=JAEnd7RTYfgtqTDPsV5I82Kbf/tGt183J2FPTli0shQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9Mo4W0CVbz45PZz7lP/1PK2iEJTNnBAnaMNX6eWu7UCbQ9RkbwZgbBjFawezTBYP/llw2t3iy2/8zJ/dddxZNDAEJ6InFHeMY7UQNx044Fg9rkDSx2/i/7t7EkRVAIM1pY/SbI6AL/x4d5JlSljMj9S16brs5HFYXiMAwqhoG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnNGPZLy; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnNGPZLy"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b28d9537bcso97463b6e.0
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 15:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791412708; cv=none;
        d=google.com; s=arc-20260327;
        b=G3I98CzyjiZtWgW/VjTZjXAUZ6UCrMaV2dDu1Tk/ZeiNco8Gwlz0BLiaAG+fd33aIJ
         bT5r8+1JBk3LoS7R4QCKnVFN7rBeWRYKhVf0SuzsCjijQEp1rOGCHAxgr8ixQ2oYeDD2
         CUzc9SzUl508E72MTkEdCgyPLn/Pxk19RZSP+QHDulAnWfnSR0WkxS3Fvu5DXQKj0fwf
         YPheHvUN3kctvg8lv3JwRXRkvEd0wK0AybMi3Afx2nSH6UkGvj5r322bRUdRVKQZkdra
         fpZgX6sJUwzupuUhuahvegXABzMPDs1oo1v7ONsHHfREyUQzs2F24hwaRxzvJii/3NDA
         sDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0radvBLf82v1mE7u1BEv9JCaS3DV3MO4aUccMt6BE4A=;
        fh=wrZbEjerBvvraez/ohYKBPQNSycMI8HWhuWQYkqYzQg=;
        b=f0OGEbKaF68SIZajEitD06wj7QlfZMuABUfXnTyooJfW2xEQ9NMu5yLLjcTM57T5nW
         0ZpYXTpr1MrZ03TNZBmQFVByCM32s0eH3JgGS4J0Rjt71QphYF/AqhhxhJoLS1INGKlu
         nEawN7ZnoyzBIqekxjxc6wzbYtmUBcvnZa0peXaXp5sKvqySspUPhhppsdsotktBgfwn
         TtY3/XaSIjTJIFdGr1/G2kXAkLH5HgLD9vW4/r9RymZ6oEr6ElMfZOj84zPXao8B75Yh
         canQoj8WYZQgNNj5C7M217lK/tX0HT6vQBje/SPia60gIpP8Q8UNDSH+4heOJ/wiRIQX
         UmBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791412708; x=1792017508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0radvBLf82v1mE7u1BEv9JCaS3DV3MO4aUccMt6BE4A=;
        b=LnNGPZLy/Y/UNQxwmR4rR0/zvX0pcv0HbRGP305xVXBB/Jk0pplrAuPiBRpf4xpj+E
         Z8QwMlZjEKRsNA4ZDwnFejcuUr0KaxJ+PgUjzBedrUeMktRX97GWzPlfyUuVLilFkqBa
         mgmgO69Ol9pCSKNxptiRWTxMrUt1bZsgGo3TsrDpONIGIOOXAxGVwcRu7DHjYk+2eT8d
         q/aN1gCp/AlG8c0DVHJY3rD1PjH7RIl/tjrFrNDecbCPhAsqsRwc9LlpPSa0peBzqnzt
         Y/pCDUKspi7UqzxUlwt9pLBQlR04yZxF7q5lyc7tzlkXK8H6+USe8U589Ht9b1Ogd79h
         9I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791412708; x=1792017508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0radvBLf82v1mE7u1BEv9JCaS3DV3MO4aUccMt6BE4A=;
        b=sDh3fjln4oXb9JrbQLBIec6nqKLjQPHdPtf/a3yxZGZRsq0l3+bSuEBh+az5J4W5pP
         06drg4aoMve5HIWRERLz/qmzdOdmXogkp+ugHDUtQjD7BRd0fLTI42y1ObYbPquNicfQ
         3HpTg1nSdMypYQ3qCnIkBVF54JMLOadk0MKDmMkEYku00r7UGKoJLXlMvT8S/A5yWq7j
         HnT7pNRbgGYn9jOio5bKWH1k3ipyVPIJ2abXQ2Zc10mOk/rvjfB7/vtjwOzKWxsgsVzh
         swZqNaJ0r3Q0P1rWm55cKUvZQe5G3jy2bD98s9dpOXRkWm8R4N4sv5E43fQK0cZZHOte
         qjZw==
X-Forwarded-Encrypted: i=1; AKwUvBxQVIwPXrbhVRXUNK1Vi0kY7KB4U/L9/5sxG5XodXUNUGgLW8vakdgfT4JcIVNq1ta4JDk=@vger.kernel.org
X-Gm-Message-State: AFuF++lElzU/z0vRe3AUIrEn1w7a1+so93RZCMrYmv+RERfbkUyhPs/j
	zMRLfZvFC0iz3LmTlU7igIF01yIgnJEN+jsNXGBa8xa5oyV25hrIwTQPKJO9e4W/f3/BtsQrflC
	fnp/rA71hzvStnKq/hRLWRF6Z2qoc/dY=
X-Gm-Gg: AYBFou0DE0KmKGHfgae3Qf7aZsGPUe3IKC2xoUSx113GUOUE2DrXo6Cy5bhwkUcNwat
	Ih7M8fjsV7+24zsbIm/ydyprf/aOjTEpRLR/aTfYWDzZDv0do6NLs8EGD9Q4WxaUtsQ5cNL4SSX
	/rG5lHOD+sdBEw63cgE0atJtK+iteJ5vQ8NVUZNQ4MAMxGki76In7SA/I2+MCtgOlLNZ79pWNrF
	ZA+7KkMfTJSDKRW0w9tUwWRgyPKlERlbZXNhXVodxriyV0hA4tqJf8DAPNqHQZmSxZHZsbvxDmf
	I4450e+ArCnJmNkGUb2RF1B7JC4it2QcW2DlflU9aiN88YZtOvRzPa4=
X-Received: by 2002:a05:6808:1a21:b0:4ca:9850:4dd8 with SMTP id
 5614622812f47-504b57bbd0emr473506b6e.10.1791412708033; Wed, 07 Oct 2026
 15:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-6-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-6-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 15:38:15 -0700
X-Gm-Features: AclHuK_lWBEeBv6ps7ou-Z4Pk4-NURj4G_TRRW1ryhPrH584Hce6fOGQe4jabJ4
Message-ID: <CAMB2axM17PR+6k9jyW+J+599in1zbnrV=vRxx_qBwYBmShF28Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 05/10] bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG()
 after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> BPF_CGROUP_RUN_PROG_XXX() macros guard __cgroup_bpf_run_filter_XXX()
> with cgroup_bpf_enabled().
>
> However, even when no SOCK_OPS prog is attached, callers still
> initialise struct bpf_sock_ops_kern (memset(), etc.) or evaluate
> BPF_SOCK_OPS_TEST_FLAG(), which loads tp->bpf_sock_ops_cb_flags
> from a cold cacheline near the end of struct tcp_sock.
>
> Similar to bpf_tcp_ops, let's check cgroup_bpf_enabled() before
> BPF_SOCK_OPS_TEST_FLAG() and struct bpf_sock_ops_kern setup, and
> rename BPF_CGROUP_RUN_PROG_SOCK_OPS{,_SK}() with __ prefix.
>
> Since all direct callers of tcp_call_bpf() pass 0 and NULL for
> nargs and args, they can be folded into the new tcp_call_bpf()
> macro.
>
> All callers of tcp_call_bpf_{2,3}arg() check BPF_SOCK_OPS_TEST_FLAG()
> and do not need the return value.  These are replaced with the new
> tcp_call_bpf_flag() macro.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
