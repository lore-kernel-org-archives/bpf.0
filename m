Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4803403139
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283859; cv=none; b=TBCkCZ/x/Ibg7dXhftNhKnSM7ZHiPc2vmRZiEBpbyzZclwVx6l6+EZ7gnqravwdabQUTe5tOVqmqbZEPQ3pIOAFCY/Re48rLB0BPR9VydCTD9KLDmWQnovQGuc2roeRgd0vCkTHJ5PnXJfUjk8lW77MGENwvaWGjVZ2Vpv2M/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283859; c=relaxed/simple;
	bh=x7JBV1YxVrPj4/1vBdgzqqKO1DpryrChHhSxeL1cbvA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=joqdWzyTErKz8bh01PYmn7uWNkpTuowlbQxMx3GrCcuAzFtseW2b3X9ZI7oVlgIezjPgrv2n+5osMVanKuUVruLWXZr6IPjElhXoze3dZy8w97khvVNqt/LEugU6QiYKxpXHzTpYgZ8MfOVfdvKKSdESIwRXwfswcrok1pTr+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0XmpJfB; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0XmpJfB"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4863ee8474eso878416b6e.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781283858; x=1781888658; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+CzGFIuAycc3JTH3gFYPgt2Y0prLl/gqutaLhPH2tg=;
        b=h0XmpJfBN3aA8/I9MeOh7mZ22rIraPMCUXRe6Uo+/kmLDnY9rZbBQMd568HZA4h3ZQ
         gsbgQTr1ZOzAtsFlwOoeLGnJWH6s5sVqlCui/ppWHwNXmded1gzYe18b6n1ZkkjrsTay
         +8vWO01kLZCQk4QMFMae6yrQtiLSPg5vMOJ9QItqfoUxtoEMb430ANmT7CWRCtW7czJP
         EnjYHStfTfrmHOUUfMnKsZ9jHlCpUV3QX0DPhbceYjLSztdE4KUjdCSx9tIJdyEagyua
         hDl3djBwg5mRxvlSvSnk2gh+w3RuCKIi7bRW7FlM+BB4ZfoadunexQWEkMy64bKkT2+y
         JX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283858; x=1781888658;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+CzGFIuAycc3JTH3gFYPgt2Y0prLl/gqutaLhPH2tg=;
        b=VP3SDAZKzElAfswQIejhCeo6LHvg7JROAmJWs7hNm4MHSY7m1i/tF1sa9S4ia1bhi9
         /cuUUEOdJ8+982QNWsjd0cWE+VOQh7Iv+/gO2n2Bk41yB5klfnN6tG0qVC6oMqusx9pg
         xlfpP9rhwQXdr5w9pGc46OUA1ov1cJi0xUT/tSgyHPEVpoDUAhl+SsVlzScwBc29+aNA
         ZZyCCCQ792OUEkmDecJr5JizQXDmvUx7ro+mcxNv4m9ykPIPl1zgDI92P+yXWEQHKcYt
         ccxWouAKGlzbEhOtVxjHvdjsYC+veRM86rnGw6gfmhi4sMcNjoLQSO8m86z4RZImnSB6
         vxAg==
X-Forwarded-Encrypted: i=1; AFNElJ/J4rUkfCKBLLpLmj1gSchnHTSIGcmSLEBXzEBk1Sk7lWtUry581ppFPOe+mR8TVuKA9CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOEaFxo4Ukn03eJ6gH6PdBXhrgCYGf1w8Tyiz/mIdzp61jIOf
	wC3zLPzBirMhYhnL6npguUxrHVS0TQtMWogjJVdcr6sK0t/ZRAtZilD2
X-Gm-Gg: Acq92OFmPL6VkWDYoq+km2XRn6iY5R92WvgEGdnRZrb8BpSqhul0JpyQGJFkDeXfCAH
	KXMWd5m9Qlx9CPBmV1S1HiqL2FEgolFCu+3gqeRWc8f4EArkXOaev6KzLQIsSJkD/l2WAX7cQkZ
	4w8J1dOry6pMWSHZocE4B1+DGzYONhOs8yTXbA92bnUM8cPtDtfcOrrb9wOXEFiuBAzJATaXo2H
	Nuvfmhmt/jlxw2eeoiRukXeE+N8xD2W2Z1HuftAG+47oZZw/zabx/pVGiH+GAmYlrO6QsqzJfkT
	RmUmNJTGXnoIVmbhRa4IdhnCp+LmQBLSXTlZof5A0fWdPMvGl60NJNATommF06HXHu6OiNbj3wu
	MpaER1uhJz28sRboLRqc2yugFgXPAO7fI0jH9ECpkES5K3V6Mu3a1tccUVw2Vzu2GiZGKDQOzXz
	c2zdsqHbM4JYPWFpsOqGuFU5AbmQgQ3nsXhYtWDIJ1dfxhL2YM2UXNZCj074MKrY28seEq0rw3x
	R1ARj1v9/z2Sov+Nw==
X-Received: by 2002:a05:6808:c413:b0:486:a606:c6b5 with SMTP id 5614622812f47-4872f50eab1mr2764073b6e.23.1781283857489;
        Fri, 12 Jun 2026 10:04:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:18::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-487313bcf8asm1337937b6e.2.2026.06.12.10.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 10:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 10:04:15 -0700
Message-Id: <DJ78FEGKX5S8.1H2M4C8415L98@gmail.com>
Cc: "Zhenzhong Wu" <jt26wzz@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <kpsingh@kernel.org>, <haoluo@google.com>, <jolsa@kernel.org>,
 <menglong8.dong@gmail.com>, <eddyz87@gmail.com>, <stable@vger.kernel.org>,
 <mykolal@fb.com>, <tamird@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Shung-Hsi Yu" <shung-hsi.yu@suse.com>
X-Mailer: aerc
References: <20260611160749.391279-1-jt26wzz@gmail.com>
 <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com> <aivZ9jYGw6QRxLQQ@u94a>
In-Reply-To: <aivZ9jYGw6QRxLQQ@u94a>

On Fri Jun 12, 2026 at 3:18 AM PDT, Shung-Hsi Yu wrote:
> On Thu, Jun 11, 2026 at 09:55:55AM -0700, Alexei Starovoitov wrote:
>> On Thu Jun 11, 2026 at 9:07 AM PDT, Zhenzhong Wu wrote:
>> > Add a verifier runtime test for a branch pattern where a helper return
>> > value and a related scalar stay live across the same control-flow
>> > sequence. Rust/Aya-generated eBPF can naturally produce this shape whe=
n
>> > a match on a helper status keeps data derived before the helper call
>> > live across the same branches. Such code commonly uses the helper retu=
rn
>> > value in r0, where 0 means success, producing an r0 =3D=3D 0 / r0 !=3D=
 0
>> > branch shape.
> [...]
>> > +SEC("tc")
>> > +__description("helper retval linked scalar pruning")
>> > +__success __retval(0)
>> > +__naked void helper_retval_linked_scalar_pruning(void)
>> > +{
>> > +	asm volatile (
>> > +	"r7 =3D *(u32 *)(r1 + %[__sk_buff_data_end]);"
>> > +	"r5 =3D *(u32 *)(r1 + %[__sk_buff_data]);"
>> > +	"r7 -=3D r5;"
>> > +	"r2 =3D 0;"
>> > +	"r3 =3D r10;"
>> > +	"r3 +=3D -8;"
>> > +	"r4 =3D 1;"
>> > +	"call %[bpf_skb_load_bytes];"
>> > +	"r0 +=3D 1;"
>> > +	"r6 =3D 1;"
>> > +	/* success path keeps r7 independent; failure path links r7 to r0. *=
/
>> > +	"if r0 =3D=3D 1 goto l0_%=3D;"
>>=20
>> this exercises linked registers with BPF_ADD_CONST logic.
>> We already have such tests. Why do we need this one?
>> How is it different?
>
> BPF_ADD_CONST wasn't what was meant to be tested.
>
> The main logic is r7.id =3D=3D r0.id only happens on "if r0 =3D=3D 1 goto=
 l0_%=3D"
> fall through, and does not have such link otherwise. I only check tests
> added in commit c0087d59e504 ("selftests/bpf: tests for per-insn
> sync_linked_regs() precision tracking"), but it doesn't seem like such
> conditional linking was tested.=20
>
> The other rational is that this seem like a common pattern that is
> genereated from Rust-based BPF program.
>
>> > +	/* success path keeps r7 independent; failure path links r7 to r0. *=
/
>> > +	"if r0 =3D=3D 1 goto l0_%=3D;"
>> > +	"r7 =3D r0;"
>          ^^^^^^^ conditional scalar linking

Fine, it's a regular register linking without BPF_ADD_CONST.
Still the question remains. I believe:
"We already have such tests. Why do we need this one? How is it different?"

