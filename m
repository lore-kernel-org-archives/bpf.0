Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2838E5FB
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024371; cv=none; b=mJwKXt4WHdKJ2p58GzLFcSniqkrss47MbtmzgkfrEkvmXsOA7BMq0TRUvc7F5aNJU+89USwVYBoSEQxEKlQ5nxy/dv2fv1mcc4AZdpG/onQ4H/XM6YnXfyfDgvOOgYFQmawO6/weCzxl3DUo5XFWO3ShpHs2yQlOMezIWBql8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024371; c=relaxed/simple;
	bh=TPtQecFLt3bKgAlUJv6uA3jD+8ENnPfJf8K8C1mKZj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgAcmnTU+Sd0ruf0arixepExOPKzwqUc6ur4EeaciBeBbbscpHFQz9eACjlqwq5xvYarDEwy/+su0YHhUTXYemG7Rgmry1NTltrxLxpd2tAu+U5LAn12FL0/yaEH+vz2n+x5FAfMM+6vqmlhwJYup8hMhTyN19jJlWQA2/k2Eac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqYQ6DDi; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqYQ6DDi"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-389e4330e32so5499781fa.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 04:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772024369; x=1772629169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXh8nJgWerBQSiJBvjtEBHO2Vkt5cQS3cW38XI+++O8=;
        b=nqYQ6DDiWVc67vqdI61Zj2cHS+dB1g38yS6o1FNobtwqz9VaHtyv10HkSVjum4l+a/
         546iFR9sQyzU+S/r5NUMQJMCeVTE+VZDhnrtvBurHFs4+UGi9lJeh87oe5oyjd1yZbOA
         QGl8a0OuccWN2/Tu6RaEcaO4t6qFTq+JBh9UvVg4LX2FJ++qU8uLOaBvitfkkdpxgzyf
         kGFRhL8glJ3zHIYy4PvdzDBGNQqYfhVTbaUiL7UQ+X1Z5ESLPKdJo/CRokGBuxxctMFa
         ZqzOdZf3+QAQdTCWira8tIkgJtu8ns0zIpLGwFRMPPMSptee6uFDfmCTQzIlnRLKpfci
         z4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024369; x=1772629169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXh8nJgWerBQSiJBvjtEBHO2Vkt5cQS3cW38XI+++O8=;
        b=NW1u03WCx8lz+FZUm41iG9brgfYjNwa6I8TqCvqbPrEyw2ZC3WaDV9Sab+Qd8jsLrp
         8ECXpDtealHnHqolslr1RO4d88IcObJCH4aKV15HC4UJwQlVq8GjsjLcqM44E/BZZ5CX
         BDu9L93MsKgQQyvFPT2DLaNzB6irdw/as1FI4ZcW/+ybM3r/rXM0XZPSwOTHPUECGmYX
         lAeohiC4evPFhX5wxerNk+exLvaFKPPwKHqo8R7CJvDUM6RDu7n72xbVeC5kgDjkhgPQ
         mPdyTPKNQP2Z88bnU1/Hlo2WLAmxp5t/+9M+wjJo0nBb/isNFUeTwk/xBTBE1gC2nuf+
         42kA==
X-Forwarded-Encrypted: i=1; AJvYcCWGGHYa8uD6wVdK8T6ydtRb4x5oh19Oda7+n9VcKaVqSRapEhHhzNGiexXVlo3kTZl4hhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiab1xNQFmSQki2EDq6tGtNLWtkleM2k1Co3tbCRhIVaTEn+3f
	m9Tqv0BCIgn76huOkeQjQE9QL0Brg9V7KmSjU6k2QTfx8Ojyr6mYhXFaDoh/KA==
X-Gm-Gg: ATEYQzy2Bp8fAyBG1N9fG1TuuF4L8Ws2mCcUBXmeaoTsy9HZlHQFV5c7xPtIyX9Mb+w
	IR+oT6jbrK6ctL8z5eSOnPJyufxSyhgkhvL7j1+DY/+hMp0TrHr1pmzhviLfaBDyR8zSsUY4FSQ
	HMdqoa6nK99MEDxKyHY22gcHb2sCIpTWgB5qf2cGEvPEY+YxLiZEfUdm+hPzRvzgJ62NEsjxPJ6
	ZjUYEwoF/1qQ/gk4TwN002/THPkHwfMtf/uFM2Vj0c4W6BBonLNhQkeOaqKnirWELlnlmtNbH83
	CbXd1O/tm3viiCeC+r/hNNz6DBO/uZ3ypLKW8gzHl04XddTluxEVMGnz04hJ00mSuDlt9f+5fgP
	A0+DfkRawfCmTlSZTo+slS4k1R275cbKhkCO9TQGvy92uN8F/YezMvA4uzMeNVfPWUGe7Utp2mm
	44HQ/ljwD4leozR69n2AF3Q37IlQI/LcLiP5pRR6D9CsZEe8yrbfQT1OkioralyWLtZpD+JZZbr
	LrbfrWVU00omTWULcxB8g33WtLT1QnAgfwmgaoUUz1PVSVjPnf2GC1UlQ==
X-Received: by 2002:a17:906:f59a:b0:b8e:d04e:e4fc with SMTP id a640c23a62f3a-b9081a0cbefmr898192366b.22.1772017948488;
        Wed, 25 Feb 2026 03:12:28 -0800 (PST)
Received: from [10.112.148.141] (82-132-214-161.dab.02.net. [82.132.214.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084ee4d63sm508858366b.62.2026.02.25.03.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 03:12:27 -0800 (PST)
Message-ID: <22073d2a-31ea-46c2-bb4a-b771b2fcf8ee@gmail.com>
Date: Wed, 25 Feb 2026 11:12:24 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] selftests/io_uring: add a bpf io_uring selftest
To: Ming Lei <ming.lei@redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 io-uring <io-uring@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Xiao Ni <xni@redhat.com>,
 Caleb Sander Mateos <csander@purestorage.com>
References: <cover.1771327059.git.asml.silence@gmail.com>
 <7cc147a959ac068c55dae4f540e38e9e4ab121e0.1771327059.git.asml.silence@gmail.com>
 <CAADnVQK0RaOA9ZYZdYyQxOzLde9MR8HpMM0SexcW59A9u7X2Jw@mail.gmail.com>
 <84e2f3ad-28f0-4e9a-804f-2647cba9b30f@gmail.com>
 <CAADnVQLSEoZ0V1m5j3ggX0o0gzVKyiDHL=J6F0wRXB8qk-MCGA@mail.gmail.com>
 <591a7f0e-7b78-42f1-9486-163249f5e306@gmail.com>
 <CACVXFVPx5AcC9y9xVPCaahDeumNGm4TSkkfhsJ8w+wmW52JQ4w@mail.gmail.com>
 <ed7b85d0-38d0-413c-a28a-f3b0d1a72a13@gmail.com>
 <CAFj5m9L_WPH_du4GMVYGBdYA_NX1kbGtJpAP0hbfuEjuk5faZw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAFj5m9L_WPH_du4GMVYGBdYA_NX1kbGtJpAP0hbfuEjuk5faZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/25/26 08:41, Ming Lei wrote:
> On Tue, Feb 24, 2026 at 12:30 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 2/23/26 15:23, Ming Lei wrote:
>>> On Sat, Feb 21, 2026 at 6:35 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>
>>>> On 2/20/26 17:45, Alexei Starovoitov wrote:
>>>>> On Fri, Feb 20, 2026 at 3:41 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>>>
>>>>>> I had such examples, but selftests is not the best place for that.
>>>>>> It can use abstractions, and I want to make them reusable instead
>>>>>> of people copy-pasting from selftests.
>>>>>
>>>>> Sure, but please still post them as extra patches so it's easier
>>>>> to see what's the end result.
>>>>>
>>>>> Also please reply to that thread:
>>>>> https://lore.kernel.org/bpf/CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com/
>>>>>
>>>>> It's not clear to me whether your io_uring+bpf setup will work
>>>>> for Xiao's use case.
>>>>> I don't think we need 2 ways of doing it.
>>>>
>>>> We discussed this with Ming on the list before, that's one of the use
>>>> cases I target as well, there is no reason why it shouldn't work. The
>>>> difference is that this approach gives a flexible framework for
>>>> extensibility and covers a good bunch of other needs, which is exactly
>>>> the reason I moved from a BPF opcode approach, while Ming's proposal is
>>>> more specific but argued to be a way easier to plug into ublk servers.
>>>> If you ask me, we need a solution that covers a broader spectrum of
>>>> use cases, but I guess it all can be argued in either way.
>>>
>>> One big drawback of  Pavel's approach is that it needs a totally
>>> different userspace
>>> implementation for using BPF, which is just hard to use in existing
>>> io_uring applications.
>>
>> Not really, it depends on how you write it. If you need to rewrite CQ
> 
> I meant SQE has to be allocated & built in bpf prog, then it is inevitable
> to move application logic into bpf prog.

But that's what I'm saying, you don't need building sqes in bpf
to augment it with BPF checksumming / etc. I can elaborate when I
get some time, but to give a short example:

# bpf-prog.c:

unsigned csum_jobs;
unsigned regbuf_idx_to_csum;

loop() {
	if (csum_jobs) {
		kfunc_regbuf_do_csum(regbuf_idx_to_csum);
		csum_jobs = 0;
		...
	}

	// proceed to the default submit / lopp implementation
	// you'd expect from normal io_uring_submit_and_wait()
}

# user-prog.c

ring = create_ring();
load_my_bpf();

sqe = get_and_prep_sqe();
// normal submit+wait
io_uring_submit_and_wait();

cqe = get_cqes();
if (cqe->type == ...) {
	skel->bss->csum_jobs++;
	skel->bss->regbuf_idx_to_csum = idx_from_cqe(cqe);
	// use bpf arenas, io_uring regions for the real tning
}

// queue more sqes if needed

// this will do csum'ing and followed by submit+wait
io_uring_submit_and_wait();

> If the logic is complicated, it is one big thing.

The implementation above would be simple enough. And on top,
someone could try to do BPF submissions to cover cases like
you had with group request ordering (forgot the actual name).

> raid5 is a great example with complicated fast io code path, I'd suggest someone
> or Xiao or Caleb, try it. Compare your approach to the bpf opcode and draw
> some useful conclusions.  Code should be more convincing.
> 
> For bpf opcode approach I believe Xiao has already built an example.

It might be entertaining, but I wanted to stress that it's not
a blocker for my work. It can handle the use case with registered
buffers, but I aim at a more wider range of applications, which
wouldn't be covered by the opcode approach. And that's the reason
why I moved away from opcodes, it wasn't flexible enough.

-- 
Pavel Begunkov

