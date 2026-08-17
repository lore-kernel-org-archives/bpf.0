Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2B31F9A5
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 05:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943062; cv=pass; b=QU06oMwAbassW5q57+v3e/unCcmRgqe5DPopgYW+mDV5RTRAsLU/4l++F67Zw/Sn92dH0X0X2SinRQAUyqewz05xW0/IyNQAsht7C3R9qRcP/+Tr4eywXJbsSQau87Cb8ZELAYcf9FMwrKUZh58+6EdgZcDwdrLnYz+6KhnqbeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943062; c=relaxed/simple;
	bh=brKc3HDtzMk0jiLRdR2Mwqde23sdTiLahmxeYEVbpOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evQWim/rxowBSsZGnRgF5FhySWnLKVauHDDUpNIWTS0FlqXNb/k8oGPmwgxWauXJlhCj/S664oZFrZa4VnSWfZYjIVLUUJvLN/oubLgbWaIz+3u+3YS63mAKeIx+PAsRwfC5V/MTknD+oN/xkOf5NwYxgR8ljMpcuGMe33AaQSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufGoLhQO; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufGoLhQO"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc11a30a259so1872670a12.3
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 22:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786943061; cv=none;
        d=google.com; s=arc-20260327;
        b=XvVmVjgk39lwEiGZEJUuVgypSUkzWnSEpcERqtIzEg9NgciCmGR8/P5579ELAJn4NJ
         MktdB+nPWKgvORSGVgwbcgRotLgQ3YT38xcFaFx72epJNOnFtQ+PPrPcrZrgKNRWxhkL
         PWGEqZd+mQLQNYDJQG7p5vKSsjO1iY3SaietLDt591dHRVUqG/o25ajiqF3HPFMYV1Kz
         W0B9gMgxBk35ucxCeJbGy3ka76wlPFOOnyllU1cc0QBx8CcQgvxvZLWGwExjjiAR8be8
         E2JhE5P9/WlbSN097KmKd36TuZk6D9D1OP7HwbSBkouLZ5cfqFwFeYfLo+Ky6faFPvGz
         4pOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=brKc3HDtzMk0jiLRdR2Mwqde23sdTiLahmxeYEVbpOw=;
        fh=8SCXAc49H9bNbmr+ZZI5qQQ4N05zYFOw6f9On5GhiCU=;
        b=leEYQHPatchm+bgkGcDImwzqMpP5AGrKd9hC9DxawyxKuOs4qj34wpk5qYVYUhHNMk
         0vqsxbvAHXrJXh6AVoto316gULT/45JanPE19ColXQE0cXfCya+rffllDFzPi7TyWd/P
         GxhTmCwT+uwmfFhX6bJrAmZEt2uGXMLVfZ6IyVpp99nCMiE40rJckw8KZ6DdqZEW7es7
         QADGb6WaqaS26+ew19LwJ+SuPN/AEqzdJUXjnwcqzsjA/ugpxwcZCYwfzk/HhcrsDAsg
         WAHt8/2iYKZjFwrnBG1EEanO4wJgvZkgNQIUCvmO2s4+A3AsG+brDP6Y8lxvpQVOzkWX
         c3Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786943061; x=1787547861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=brKc3HDtzMk0jiLRdR2Mwqde23sdTiLahmxeYEVbpOw=;
        b=ufGoLhQOZShPrW82jVdtbRtmuCTj9YCinSYVAoZtpHqp3J9IO5xVlM/rqyz4lx3Wap
         00lwZhlwhMih9vccL3fjc/1KuaMzLJjvLYkErvusq5Z7ZTZ79An1+TPB2mhoTAVw4I/M
         9p9wv3SMDWZliYcMDpP1kKWTBNiPHby81nngcYfSxmz9hnz4m6e1VzXwJP6YJcEij/4k
         9t/nlqXW/VjdkcNVFWOqMsDPlSrE6wYeuDYnNoqorwtIkrl5SQa0dlXI4K9pABgJqEKs
         0syLQ4x5OJULI6TYs8669DHASkkWGnq3Z6VT6aK2oZQv/Bzw0wBgWPhIOkGIC6IyWks1
         LEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786943061; x=1787547861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brKc3HDtzMk0jiLRdR2Mwqde23sdTiLahmxeYEVbpOw=;
        b=LeqJT9zCqUV7Bo0LcCG19Nl6eCXY3wuChFrMMSUpt/OmNKUw4RtE1mSFLev7qcd8A/
         xy30WjKYUrmIGQshOg4nmOmQA7m//yyWGuyKOklk0pbT72io88Z20ipTaqdr6Gykk1Ov
         /Il126rDN+bPtyen8Y65lCjQ8KBPzDhNndC3/+LhEdy71+v5FJ4jQhu/gxuGK1fR127t
         ZFuE/BX9121WAk28kvp/6mLZo7T43wgddSgePt426zN53YqJX1Q7DfP6XFxlVPMa2stk
         eVGDUf4smpdzApV6OT7Q4hT9TknngmLJCkXBB/Mz935IAv2qbr/fqgep12BpL3GaHKxY
         yc9w==
X-Forwarded-Encrypted: i=1; AHgh+RqHYsU5eHBt5mZrjIQSIFH/xiSYWYj3C2SAKnY7u6QSqHU8L+ki5fgJrhAb0NdCWfxj31I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9a26dIUn+vmkl/7ZVxcm8vpU7ak6GBkdOqQO0aDwb8H4Y3dj
	mDwDHF+MRyeK3tm8HrgM0x028THobZUfoC8jpU5bm/w5uM1VoUJGtTyY48eldc/CjB78p7reYd+
	yLHhCvnquwPpIAz9pbLjGEvFg/J4y/mK+h8lJ2atg
X-Gm-Gg: AR+sD13ZcA2YLrxp5W6yiwOjx6u3EbEJ3ZqnLa/w3S404v/MJ3zhUuL+ALaY/bEY1eg
	6Cq4/JwymmJBH5yEWezLEpCd0n1rT7oGybslCq/KQUFsoz9kYzckIiMW1UV3jx7aIg2jhaQuHhz
	UUI3+MpXn0wbz8e1a18TPvOKfUrPF5OEAR7PR+SDwROO3EshYQGZ89NGh/hRYH4q7hwW52u5fqe
	Qn3vivJuDs+qg7ARl3DB2kZeXvc8f36ZFc8mBtDUDg0MjPuOAaewwOI/bUoOlP258gks4+Kqhrn
	zxQ2M4lDAyRSQwJZWC8j0mhKVqRSymUzrdurw5d9YA4LtveE1ttcp8hn2Ka7wN5jQ48EtSMGY4T
	S4iQri0gqJ60BkYtjQMbmZjslNHQJh6/GxqXu1hG7nXeayu+8xmgt9Hc4C7wqt7yBKbc=
X-Received: by 2002:a05:6a21:9981:b0:3c3:a140:9392 with SMTP id
 adf61e73a8af0-3cc7177a8e5mr19421702637.0.1786943060377; Sun, 16 Aug 2026
 22:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812091654.244752-1-zirajs7@gmail.com>
In-Reply-To: <20260812091654.244752-1-zirajs7@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 16 Aug 2026 22:04:09 -0700
X-Gm-Features: AcwNN1UsPd-ngtIs5v2NvwK3PN-7a-ZlMOROwWseAnhzc5-QwQ6SAZKKnaGk3_I
Message-ID: <CAAVpQUCLKnN_aa4aCrufQukjuCcvZFUFy0hfPXOiGGLQw7bLAQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX
 getname hooks
To: Junseo Lim <zirajs7@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Sechang Lim <rhkrqnwk98@gmail.com>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 2:17=E2=80=AFAM Junseo Lim <zirajs7@gmail.com> wrot=
e:
>
> _bpf_setsockopt() and _bpf_getsockopt() call sock_owned_by_me() for
> full sockets, so these helpers expect the socket lock to be held.
>
> BPF_CGROUP_UNIX_GETPEERNAME and BPF_CGROUP_UNIX_GETSOCKNAME run BPF
> programs without acquiring the socket lock. A program attached to
> either hook can therefore trigger the sock_owned_by_me() warning by
> calling bpf_setsockopt() or bpf_getsockopt().
>
> Disallow bpf_setsockopt() and bpf_getsockopt() for CGROUP_UNIX_GETPEERNAM=
E
> and CGROUP_UNIX_GETSOCKNAME.
>
> Fixes: 859051dd165e ("bpf: Implement cgroup sockaddr hooks for unix socke=
ts")
> Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
> Signed-off-by: Junseo Lim <zirajs7@gmail.com>

Makes sense, probably no one calls getsockopt/setsockopt() at the hook.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
