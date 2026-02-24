Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72C2874FE
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959278; cv=pass; b=j4fg/gUoMUvdPNSkJe6DPJeXNB4oozxLYI26i4Ji3Cgfh4vJMdQTb9GsT54U0sKGXM7MPuD34YUP+s7ug7r4fJYg3ltPWSNk0Rz88KwtmcqNlJMArhBqY92np8W85Ro73yKHww1rRAdzaQ4XCC84tOMUS9VSd5vHCRTqr6Uux98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959278; c=relaxed/simple;
	bh=7kYf38Y4iDvXs4qp/u1OTPuMQjxxHFTdTFxvoFrFL6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahoPp+kZFIz6M0fEqJ+DGalymQm8KX0m8ZOPhPp3ToG/fESjIcBNUl5eWQiaQvmdHobEHZSAXkzCz7AGzAolk0+Xtph6OeAhcA+xXcW67oQ1ENTOVprtn89JkFowv/hEyUWo4vNFVkkoo+sxIR8l8UgSwwV1Emn8uThmiEXc5+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqEtMT1U; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqEtMT1U"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso49753235e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 10:54:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771959275; cv=none;
        d=google.com; s=arc-20240605;
        b=GFjKbz6G0uQ7/tdEjGLx92tSgUO1L5tKBE95HesCV2iRebN+xHOdXws0n6mwZ2k5Ut
         oxXQqFW3JpmO8aZXfR01l8vMleFn2GsX/chm3WC4BhhuhjAQ/BihczyaFdFtyYTgar0r
         y5OK3qBtkXo1blV13CqsNb9LWs7RmV0VD96H1U2JqMIinKpmNaNAI/3lS5JVRVIW8NRw
         yTaO/mE8SF6UVFjXjIHhOG9E2p5Gj+IS3Upgn9tXf8bZzW/PnbjP/cxU8VATaugAaFst
         Q71vsSUZscdHtK3DjFTsuTYKcV+Hl2aKmYmufTw5Hg4TevLHTCep8ZPp0O0BLhCUKD1l
         8onA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Awv8DIrGI3H+149gY23xflspKap2W3xjFpbUA2/4mB8=;
        fh=MoUuIqK9nO1RD5HGcdqkBSKsXOBeIkx/adii4Lg76Wc=;
        b=Ul5m4rPfXdwjQP3oAwWdxI415IgeC5VGzh5Kxlh94dH0meiaFZF76itLSetOxYQ3X1
         MsbIO4i9yHXQY0BBxGQY4MT6vb/9u80wdFbqiX+rZMEV0T0Q7vjGzGnk0VE89fXDPX/1
         kINRauCk1WhC5g53gDyeTyrNWqJkpNCjo3m+FLNZFi09YyNMkA1sGvIHmnEKE8FxHqv/
         VmnY8oWm/GKDdIJ8+uEHAKdGFJ9qqREp0Aj9BYI0g0x9WzHOhYCdC6m5vIiRKX16AuJt
         6LbPjCGzNMS3zKYEdHN4CY0l5fDBBv2lzZdHFnjxvdUNpB8qts9+qGtXIi/2SCmisZLQ
         ZTQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771959275; x=1772564075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awv8DIrGI3H+149gY23xflspKap2W3xjFpbUA2/4mB8=;
        b=XqEtMT1UZogTul118yxGK82rSH+IerVaL7U3kCILbA1RhWmBhFFqG7cMyJjSb7SMSQ
         p00tl2CLmOxDqHshEmNEWFJm+CtIe8X2nTVdypIB59pw0+mNysZeoqcbHzlOAtwNOT4B
         7na4+1NXLRsiIkCCizzaWDnnB19hrI6RPe2PP+ABoFNIzVXivFWg1dz8l8F/QzgqmGPq
         cgr6JL3Ngl0YJ1d6m0ocnuv6vqNayzUOiZjXHTrNP7nIHRCF2FvZGutXtbnr7cvlOiya
         ZFiQn8snY09EBf7Z8ZaQIROcI57N+r+eJlGszk8n55tsoqRi50/Eq+jgPX16+F6f8IK9
         H6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959275; x=1772564075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Awv8DIrGI3H+149gY23xflspKap2W3xjFpbUA2/4mB8=;
        b=u9PVXRhbVL3M1ouASSYTa90wZdRhKhZjmm0R/Z0cSsa1FaBENhvydICRHviZEq1qHk
         6Qc/j9fAuchfYqdcQnphUfkPq/W0W1E3Wxg5/JCgY7H1qF+s4gp5B4tuFvKdLK2klKL8
         GkctKMz3rtGnubR7b8ruetjv22R3bKR6HPTN+vOrr69PeQw8xhpHLcpljZ46773pb9RZ
         GCEkOpQhvF4yjFOAN4yCal6p1Auzo6Q4MmV1kL6if00/rxSvuUZu907sj/0t639dUf8T
         vTQK0G2jYpyK3sNKnAav3XSM8B2qBYauDkifNdgFXfUvrQxns6x3v0pBYoX8/UnvTU6U
         Vvkg==
X-Forwarded-Encrypted: i=1; AJvYcCW75pfVGiu8/WU8QwCBgmhAwMJBbMtXevqIg0OiPN/PTJjhoUDLiyF4SNRZGhYpVM0zQRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnJnOKh8iAsRCxW1Yk8YOgfZil+TxbxOnvxP5FDJg+vDTHtdB
	Mu+JIQonTRHCDeD21V8ngpo1M+Y/b2tn3SYTLscfy2kRtQxRjIE9x5XRUp0ZqkGDmV1SBC+fcYZ
	0lWIqqg1tYxKQ6wrLdrlYRPx+xisPk0xgjA==
X-Gm-Gg: AZuq6aIt2R5q8TrOe+ua5JpGIOd1L+WFoOhKv1yh27hmQR05wNL/8MxvMDUuiHaJ/t8
	1dciVE6Zj1oH0VEmgkte4iurL42935Bt/AJDofCXBDo53dql6bVwPWZvCCmDII0a0Lu8nRADLfr
	/iT3lJ7LXaq0HSXarWdfS9MKwaaSe7E0qeUy1ScG6z7jX1vvYACvCWCGxrC6PQyAP0VFfljtCZC
	yapIXlJxcnatwhLWjycV4EHe0y4XyzlNoyAjwa5jCtHDLc+TncE5qDDp69WAuk1ePyu70/FkVud
	Y68TR3Po4YMSQrS+zl7s4V13MEunCxWanv949sC7jFeQdSryfTcVL+NQmlCsMaDYC4Dr3cmY72d
	6mxMz+4O6
X-Received: by 2002:a05:600c:3516:b0:483:7783:5373 with SMTP id
 5b1f17b1804b1-483a963588bmr202767075e9.23.1771959274710; Tue, 24 Feb 2026
 10:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771850496.git.asml.silence@gmail.com> <9c8d6af7-8546-4409-91fe-85f92a08f503@kernel.dk>
 <d808f483-3c0f-4323-8faa-0b7d49c539e3@gmail.com> <a7e1f667-04ba-4fe5-b21e-8c47e68213d3@kernel.dk>
 <b22117fa-84ba-4f9d-982a-bbaaae35eebd@gmail.com>
In-Reply-To: <b22117fa-84ba-4f9d-982a-bbaaae35eebd@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 10:54:23 -0800
X-Gm-Features: AaiRm52xt7HwXOCplnwma6vUI16c-1jXs8eUh34rEsu8lfdznaOE6C0yI8ppUzM
Message-ID: <CAADnVQ+8VM8-G3X1UT8_t1tt5=62fxqknHPND40JNsQ51P_XVw@mail.gmail.com>
Subject: Re: [PATCH 0/3] extra io_uring BPF examples
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 7:06=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/23/26 14:39, Jens Axboe wrote:
> > On 2/23/26 7:32 AM, Pavel Begunkov wrote:
> >> On 2/23/26 14:14, Jens Axboe wrote:
> >>> On 2/23/26 7:11 AM, Pavel Begunkov wrote:
> >>>> NOT FOR INCLUSION
> >>>>
> >>>> Alexei asked for extra more realistic examples. This this series is
> >>>> based on top of v9 of the io_uring BPF series and implemented as
> >>>> selftests. There could be more, but I stopped with 3 that should
> >>>> give an idea how it'll be used:
> >>>>
> >>>> 1. A QD=3D1 file copy program that show cases state machine handling=
.
> >>>>
> >>>> 2. A BPF program rate-limiting the number of inflight io_uring reque=
st.
> >>>>      That's a good example of what users asked for before but seemed=
 to
> >>>>      be too niche to be plumbed into the main io_uring path.
> >>>>
> >>>> 3. A toy example of how BPF can interact with registered buffers.
> >>>
> >>> Let's please keep examples in the liburing side, where they can be
> >>> with the documentation too.
> >>
> >> I got you a liburing example
> >>
> >> https://github.com/isilence/liburing/tree/bpf-ops-example
> >
> > Right, but that's just the nop thing, which isn't really interesting
> > outside of doing basic verification of yes indeed the kernel side works=
.
> >
> >> but need to sync with the selftest. I think I'll rather keep the rest
> >> into a separate repository instead of adding all helpers to liburing,
> >> which will inevitably do similar things but deviating in API and
> >> internal details. And it's simpler on dependency management instead
> >> of requiring libbpf / etc. for liburing. I wanted a space for
> >> misc io_uring bits that doesn't make sense to keep as core liburing
> >> anyway.
> >
> > liburing should have support and documentation. It's not that hard to
> > check for libbpf in configure and either build the support or not. Once
> > various feature support ends up being fragmented in the ecosystem THAT
> > is a mess for users, I'd much rather have it consolidated and deal with
> > it on the liburing side.
>
> What kind of support do you mean? Installation, removal, other BPF
> management is all on the libbpf side, e.g. skeleton open/load/etc.,
> and with it generating new structures for each of them, I'm not sure
> how to make it into some generic API whether it's liburing or not
> instead of making users to fill in the gaps, nor I think we should.
> As for figuring out right helpers and abstractions for BPF program
> writing, it'll be a gradual process, and I'd rather have it
> separately, it's not like I can reuse liburing for that.

The cp and ratelimiter examples make sense to me.
The 3rd one with xor kfunc is a conversation starter.

Since liburing already has "cp" in examples/
I have to agree with Jens that "cp" as bpf prog should be there as well.
Spreading the examples across github and kernel tree won't work well.
We learned this lesson with samples/bpf/ long ago.
