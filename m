Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C0368D40
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700244; cv=pass; b=mL46gDP7WGkN2hYXNt6QsR/n5QH4cQ3dGoPMe0M+rJQKHwIrvEQgye/TOidE1JaIkbRwZnq80Aop20k6OwCULaFobiK/08O9hdMN2VHbMfhhqW9Nbw2xrhi3B7aZ+UAenZ7QFWQ6UILXaFamvu0GdJ4Wd0xYZMvSoLl+CakEBt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700244; c=relaxed/simple;
	bh=s738RpUfllL7hET1bu850Mz/d374obk/RRGu/hOrYZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o83Z3Zz6QT5kWmU0raOz0O8XDEah7hRc7XVsz4Fy+CBwpmw0V7snJH4NU3lsUdE9kLcUeei9yyN196EwTjmI8+dRE+MHyPUouCoC84936aaBmSZWvc0oIzUrRyKwi/EZJpdA+ZtMCXSfaMU7e28CNPcqRpMUU9bhoeiNOhU6LL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7UarXwp; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7UarXwp"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698aa8d4dafso1145712a12.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 09:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783700239; cv=none;
        d=google.com; s=arc-20260327;
        b=gYp6zDQ3Wb2Yx61mkKg0eLYs/sj26wARv6fkXQg/zjgmoV1eZEzqwv6M+nj3FtlvO1
         YqJRzJYjQf0FQSaUhZFfdCbYoIP+JMvOToQCogMZIM84kNYHuwdIB14vr3NtV/Bf9XqX
         5ciJVAjyEaKbUBV65VRprjaBLX5JSAhSpxAxAVeziFORX1vk93JYJjuHXdJbtBuIde4m
         mLsWYIg63347g02qDCIJ0uWlzP/KyT6/MkQ8SGh1RbSSARnbixEOodPmPJbPjRl+js1b
         GCbJa8AmT9Y61nXuM7vQMKHIujFjLgmTpH1LdFYnNlwE2kA2EtmEQw8dZVC/yhNquwIh
         Afkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DYARVhf6/Vs7Op0OgefICS1l90epwG0lBtrCsJAaI+0=;
        fh=15nOAAnmJCZwYULjlhLt8D6QuzzLaHgN6Z7SrnelZU8=;
        b=bA8p6+7qtr4gxAXHpp7C28pWQPqiOe16bWgxDUN1iE/cyBoTXlfY1hBp+r0LZASF7W
         oAR/JpY/xdv6bV+WtY42glgKvIrqbuAHwS2MgMK1uA9r286VujCjZ/TRMjXmcUS75Vlh
         yFlmwXpoYSTKAlwV/KjPHPaUyvc7UaNfWvSqBQQHNcJs1ACMUKu1M5li1vBCeyrn9LhL
         i/ftzA02qxcrMFU1bxY0xqfcyxdwdY84UaL+rkclx8iH6Mry7IB2fZ7bXKQZqzPEFVgJ
         LLze0FcLRiqWFSUbZadC9DELMANaNPlUiwDJEYFKTyU6Cq/fqQhXIY9ZPrgJPp+2CDmI
         VjgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783700239; x=1784305039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DYARVhf6/Vs7Op0OgefICS1l90epwG0lBtrCsJAaI+0=;
        b=I7UarXwprqz+KUTt+6xXiR8V0K6O+RuWdNv24U6sFv1obdOMd+3RkLbGy1eNRUMta7
         3OU1td17xuSbrQZIvFQ1PcCWp66j0jS2Kq2RY0Y6sWcoH5u983898NR3mGHUuO77BkDl
         0TJQ9fSr/k/ZO6Jz6jVRI1xAh9Jj3G9ZyCnJ4RYEqFGBrB506h9vm2ukfHTnibu7BbKj
         DRHaeuK4lhqPXWcBAQ4sYeu59Y6b1C5zsTSJkS+EqoJygNRGX7hMdJZOYFkZ/nU3844y
         wv/S0XMj7USFieBjVDiYl3/xVbdGtyf+zRq+vvFe+RwwYDuYnPQJWiCH1qtv0AcubYVv
         3thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783700239; x=1784305039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYARVhf6/Vs7Op0OgefICS1l90epwG0lBtrCsJAaI+0=;
        b=OTbKi0AY1IyWWN8Stjuv22qFmjv27Lyr90FF+Q0qgE67qELvrlidgkDwCbvEZ6FKKk
         afX1js8KtxPSCLpzoVYvYtzH1/uo667OltU5Z8LI54UnF4c8u5JFzNhmaUzqro76VnkO
         Yo3pdL4yf5oJK5688nN4B8Y2lodle556YhnLIZxbhhyrB6i6LpqImqPcnJQ14fRu4B+L
         Al10H8pvsrit94tFHeHeSIH6zqHHQ2McXN0ZHfYj4COD5oqL63s9CkFG24IP2S+jxPlr
         WauYnTu99Rrw7UUAKy0N55u/jdCQKzUk35MWlTcSKfYVbr9x3E05lrk9wD3QThkEtnPz
         55xQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3H+vQHOMYsepNp3K62P/KFtTThVKRZIV7hcsPAmwnGcQfB6GasGm8J2y114/lX4K6pmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGh/PfplfctyzSosF0QL8CXF2+HYHCqnxmFZB2W/RVurfTg2IZ
	ZgGaJ5TKr1q12zCVSYvgxwfiM1DIpF6IevxAt4l7CcRYMr4xRnMaCxKxBBZ2VauOKs8bSaLN+0n
	F5zIRNl9vW0RzFMdo7Xo2M15S26nYtGlBJ9GEXGnE
X-Gm-Gg: AfdE7cmBmsbTj73ifXNPtrlRZnjNobS6Fqtg+8ksrVnD+uGCzS/ujg0xNkwR6KWGqF1
	wH9qZ5oBjTvNcPrmefuzkMq+6BG8XHccHrKgnUC0BdHqHrmFnYCpcOYMrzAinqNO8dH+wp2a+gz
	h6qxTFXOnzDfND86QB9lFZMV38UCOs2iBCO+4NoLIhW10ZfdCSlncGQiLHdQwT7iyFwCIRFy8f8
	N354vBLYR26Q3LZUypxkJsMS7SnVBNfpKqnMqAh+TT+ObXHNZpJRS3QeL8HLWf2BJN0mtQY6vE6
	lr7bx/wUpODMesGDuPj7gNjzsgViVnrW8z5L2VXryw+0pTypDS0QKvSpll5hJ7pgpwDVvLfxpa+
	TCoyz85/rwM61bpvSDpFbzqpAJTNcCikj2jN+9ciOrT1TeEUfJLZ6
X-Received: by 2002:a05:6402:3883:b0:69a:9ce6:ba09 with SMTP id
 4fb4d7f45d1cf-69ab44abd47mr5083839a12.19.1783700238489; Fri, 10 Jul 2026
 09:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alD1FJjR5r5n5Eau@linux.dev> <19e8e6f9-0d4c-4ae4-b519-603420619363@iogearbox.net>
In-Reply-To: <19e8e6f9-0d4c-4ae4-b519-603420619363@iogearbox.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 10 Jul 2026 09:17:04 -0700
X-Gm-Features: AUfX_mxWWvAt0t5YudKd1cAOJoDGSt7x1VGIJWlv6jWw7fSKrFHdnC0qoVMgGm8
Message-ID: <CAAVpQUDsd0=E5ZHDuUSxMkZh9jPZubzBDba+ECu5zsywoRDjEw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Ben Cressey <ben@cressey.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 7:32=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Hi Jose,
>
> On 7/10/26 3:44 PM, Jose Fernandez (Anthropic) wrote:
> > Hi all,
> >
> > Gentle ping. This has Reviewed-by from Jiayuan Chen and Emil Tsalapatis
> > and no outstanding objections since Jun 29. Is anything else needed for
> > bpf-fixes?
> >
> > On the automated review's flag about the pre-existing double-put on the
> > bpf_iter_tcp_realloc_batch() failure path (cur_sk/end_sk not reset
> > before seq_stop, so cookies can be re-put as pointers): agreed it is
> > real, and it predates this change. As Jiayuan noted, it is a separate,
> > pre-existing issue best addressed on its own; I kept this patch minimal
> > for stable.
>
> Given TCP, it would be good to still get an Ack from Kuniyuki or Eric and
> then we can ship it. Are you planning to also follow-up with the other pr=
e-
> existing issue finding?

Oh sorry, somehow I missed this patch.  Will look into it today.

Thanks !
