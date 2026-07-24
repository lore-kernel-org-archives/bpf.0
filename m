Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8842376B
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889829; cv=pass; b=oMKxLehAMcIrqsM1cJQSoJuqkuXH9PxxePemO/cP/z4shoUp+1yFPUq4P9a2AL2Z5OyXp4MT3NN84rGa+pxE/FbsI+Na+r0cnswlLifdyUZD5m3DZPwHX6/I9YlEgOs2b60qOl4fM3xy5zx9neQX6UX+ixawRve9EMAZtw0zNt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889829; c=relaxed/simple;
	bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7lwIYK2yhzP7Vmd4SMwif1siQpHxtJCDmBe/lqIzPPBjXynGhB1/KbGLD68PFVxF4v9o7FlbR28bshmDC+UIM9G9DaJ1eB0b2JawBScfymaNj+XqjfAMd4HfIWKQQvSOOoRne49SlPhks3rKEN2GnwFzhhjJ1avPZrtztVrEq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYo0u6g+; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYo0u6g+"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69edc72e513so46409a12.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 03:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784889826; cv=none;
        d=google.com; s=arc-20260327;
        b=eVtIYtwLsvcD3WuDgX+SiVOms3GdX6EVW2Jcd6p7JKatp745rUAIOxTzKlz8qaFAEW
         meazY8Sjv4Up4bOMTGKDHNdmEX/9XVYnoxUaspuYuRvZY7T6uGWOWTeafpSOcE+cwCHp
         eEI0dGdjsEiXNXJtr97t9LJD6P70cxlGSmPJHrjL9pLFgISSvTk9QDKYFtu9VFGUnrTL
         yYZcpj06MXzED0MZhw69/SRupMPmHfziA+6Xyb0FMwi6LQKh9mQR5funkVft6rV2ojTx
         swPApyya+DQxdkqkETjNoALcGntenysuFoNmUUgjrGNauSyrD0vLW3MsbPTezKF5wZr7
         cfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
        fh=bkaEavAhAZRxJkIyvVj3DlP68KKraVSHvVrNBUuXC7A=;
        b=mtKC67F3ew1z8shA45yC8W/1VwV69d0x1R8Cm8rVpvEH5lqDV3dRkOAss3oOgLNVo+
         UE47fLY1wnvDSGGCQXHctxAYntFb+LiqIaWFQG/Vs68bCMa7xAcTcOZAJc9XW7g9QoWC
         pYiBjDEJbQ9+QWutPEjrqFvbA3lzMDtgrYKr/EzfWl88GkHBMIX+yidHlEkDGiUJ+rXB
         H/yPxZdLfS+9bFtuI4jcnfyvK9/4sU7z24ekr160+ZXvCZ1At0WLY6wFmY4qdqrV1Mhb
         EYid40kLDGjmlm+I3jvrsqYy1iZBSNz4zmrpWhpI23GjD7eVaWlPOsByBSwZOmgtjA0A
         6/9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889826; x=1785494626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
        b=VYo0u6g+ZlXejTwgeQp1hmpxlhdOFiBh6LXBNM0GcuKMaUaryc+CKy1SYV7Y6aVf5u
         OmtnTh4pEK2MQa2pDJNXPwQx2WQcuWP32aEh+4HI8nvdWWRjFRuKwvXs8JZd+oW01z37
         pFboOTUKL2TTNboj4DJbg0hWde29+5nRB9CD8bLNqGDFZn2mMc/Y4CWLGP7fxaizMpim
         OFGtDvF0BmAG+Rr/THtJNktOtKlPuRCs73C6pXRZWHbJrku67qLx0Cfk3PTtdYyiBNVQ
         iu6KfeilKMz5Yyr+tQAnY1rQwKEnzErvvBooA2j8X8C9vFD7AzQexU+tsG87gdHrJW9+
         54WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889826; x=1785494626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
        b=FFiHuMXpCMCjGA799d74WB0Yr30L2hm62N5GGT2y09YhkPcmyIgqKjnZze/2caEaCk
         F3Z4GtsFjmr9zm3+Pp5UZ8aPaYe4p0ArlQ8tEl6swB7+US1qyJBgl6McM/P1dKEOyV5R
         Kh3ifTD8TRWegvzo4vWJI0dYG/NevyrVOmCpPoTcyY+mJuahGxURyZAVWsY8cnVoIuUR
         YFB45PdcXctp9Sai79NtxymvT7QqTv3oo9ZFL4OGzSZPtLLxX+3sgB1B+ZfAq3TVsvV0
         qVdCG6LiUreLv0ZocCyM2dZ32cx2KwwohrFPf7PB8HcadT4yqu7KaS/ubACIDhnbWfnD
         jfIw==
X-Forwarded-Encrypted: i=1; AHgh+RorkPKzcsSQc2jQVCkg0AXGWWEnygLBTUbMjxo5Moenr2f6migq/Zyg1AIxThEgWA+9LqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjE1qqGJ81mrgDylADad5B6B8/oYxX2wD2S785OqbCjoFL0n6e
	/d7pH3i2qjH3/teAH5GJOxzIwiJpMGoHZIJ8LBiZ/6AxC9j5aN3z+HxbB7EzbfzXiKyjeaDB0rN
	MXoh0GG/feNUQAYnfkWlKZi8+1oBEvOs=
X-Gm-Gg: AR+sD10cX3h52ySDsQk30xHtEyCUm3bx0f29m+WmovhXieN1ZswwMOjHb7qOe2TOCYz
	2ceyikpAu7le5h5LJdB+Mf9S7kJEl/6Ar3h34ah6vHV65Jtf+jMmr4K13utMZRYNSf/kjmF9iH4
	XRxVbHBIxhdWHfQJP5QcM5QsFaJ2L7DcuR2voPA8xr4PSnKwtRf9u1l2kglWdArUnkOu6ZRVlIM
	eHOFCyrHI51EYk/ghLrKCtQO17E+rXeM/YvCZ9DC6MkeKqCngZSKMHNbkPxAR4KU3i1/fIFqvwW
	ihPPgF/1dR+RzY8=
X-Received: by 2002:a05:6402:5388:b0:698:81d7:b812 with SMTP id
 4fb4d7f45d1cf-69f8ddc0d34mr814454a12.3.1784889826059; Fri, 24 Jul 2026
 03:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
 <20260723162602.3275661-1-nicoyip.dev@gmail.com> <20260723100030.3eee6d51@kernel.org>
 <87ldb0lo8t.fsf@cloudflare.com> <CAAo+4rV_5B-KOQgPL3BC3WKGa_otkEUXD=wDjCig9M0Se-mYtA@mail.gmail.com>
 <87fr18lmzo.fsf@cloudflare.com>
In-Reply-To: <87fr18lmzo.fsf@cloudflare.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Fri, 24 Jul 2026 18:43:34 +0800
X-Gm-Features: AUfX_mxnlnSFi_yV1t_Ui--j4AHwdWK1tce35HMxRExxAoQFSSo6xtrsHUCb3QU
Message-ID: <CAAo+4rVrB-Lv4MfaaH9sbosbOPFJQy0_UaDcbu9tLUFoGtWnvw@mail.gmail.com>
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 6:07=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
> You need to resend v1 with "PATCH bpf" prefix for bpf CI to pick it up.

No problem, just resent as "[PATCH bpf v4]".

Best, Chengfeng
