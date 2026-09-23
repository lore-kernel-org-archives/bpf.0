Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB6E3876BE
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205774; cv=none; b=JMEqLWRqx0IgE8ptbzm+p4ibAM9c/wpPbkpvyDHMXYHVWwrbm148k60OroUPiyobwiPcr6r5ReKdC/O2fwzRMQISnYjsUHmLHdMYsEQWd51xbNNDhdYlDCmYKcEuCu/A4TTJb3nk22Z+XMZVk1M4AnCYsks0LPPP5yYCVk17F0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205774; c=relaxed/simple;
	bh=dYGsuq+SJziMFd5RS0Z8dLtN9uvyFymjO/cvyMoAFbc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Fl+rQLp2rfA/lPj2h7Plb6c7fzxXFB5pIYwltb5FbnTCaEsPdbaMo07ccEllt7VbHLrZY5/0ik/Ivg9nO2ZPR3Y5mRqTtLOcV/B5Nk3hkvNq8iWAcMT+ZLWEQOOlUUU2e57Go4niZBl4IO7zkD7kAbFhlw9TmMt8shkkTJeZT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMhtuE0y; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMhtuE0y"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso799405a91.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790205773; x=1790810573; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dYGsuq+SJziMFd5RS0Z8dLtN9uvyFymjO/cvyMoAFbc=;
        b=DMhtuE0yzg3j8jE7wUcfF4NUAZBw6Y8B8ySDQPN6tLH1EPqrO75SGNxI0O+Vw3bA++
         C7eHGoJcyLi8YBaM3Ay71Ho7DgYIsAKoC17qtKu05fFLDz8Bn7BQ+oMWJXWKj9Bt6Xhr
         j/QWilnOaVX1EQUycRthBAtKtNw8sEomGquQa3KlepLfkXbkTaXclXe23+h5q3PznHcC
         S+1FLjGy6cuUEqy9ryK0gaDLo7OzTG/ifDpaJqbB0mIayh4agUJaaH9OePwOuMZiuT7T
         erYxIBDNu/XUbYDkncIqAVGMjSXB1IvPBfOWggcj37s4iH3RnWLRMr+fVsIcnBaNpqzs
         3CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790205773; x=1790810573;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dYGsuq+SJziMFd5RS0Z8dLtN9uvyFymjO/cvyMoAFbc=;
        b=fj1w0zfe9+792EBdtGvqmmbf9tMq8ygWCUF/mPsoY75SlvvChZ09FflcZDGKqg6wYc
         dMZEpsGYOOQnZeDg/P/xWvBrm87+H9zxf0CPjF6aV5LuicX54HEVmXFIyd3DzHP1bxjN
         loOI6DDs+krVq+xFVqaG1UDwIpjk6KshEFxphaOC/PdKl7KaAsFRZF8HER/IbxXuUlaG
         WqIRqN+xPS93xzGUeDHroz5kJd9SP42NPn6PcNsk1lkX8OvfsosQXkkBzIYgVtkHq7bL
         PmHLX0wpIXQQMzOg2AzLH2DIMuARku74inrDm9/3Hy3/uNx/88wJvFLfZGhY/Uy/C7Xq
         VT9w==
X-Forwarded-Encrypted: i=1; AKwUvBxCnR2Y2RiHj1J8djRG0WljI5f/SsWCcCA++B3AA3D8SqQCaShGhCXoWV/Zpf9LlX/puEY=@vger.kernel.org
X-Gm-Message-State: AFuF++kLHzSZxaLMfkkvDggTL8gxhYIofqq+5OWPpMH6d9TnYmQ50imy
	yBlIr0ptfrN5j+DNL+CGM78mF3oDPl+Cq4Zv0On12iWAXDcpuvh3PJ9C
X-Gm-Gg: AYBFou2iDE29SYsk9E5zNx2Uwj4QRuw0pIBApSU+kpqIOkEHeQP1g+megK7RFsMQJZW
	aO1KRpOqQk6Dg9u4W0q+ijC6FrY44A1h8YBFW9wWh/yeWEJM2IW4bgDK7UvdNxHGk+hqsW0f/qR
	AGrSHQ+YU1FSbkr9HGbHgHWwZVLJDrMkuDSVVi/3ZXTbnKrof57P14deG6lQSedeJTJcEIPK4s/
	GZEWGSFzjPr7qmeNXDZSr0cKIj/J8nkD3C/1kHG25aHnVJFBZlkSqlh/GA+SQGzpyIXKnfg0AVU
	VTaTNODRy44i3SM2qtm7sh59OAFsgukh7Ms8fRn6wD/W3GYq0I/PGFN41QRzMlrUt0ZXTT5jtRJ
	ac+jAzzcp8gWo0cl1+Mc+MBSrVS8Xl1/xVeo4EQTS4jR6tOYeyEcWGScbgJwi8JgPHhJKNYcFK2
	Ztsm1fXmM4E+HLnSu7CyOllzryjO3FOGHTzbhxoRxS4R2sw1GLK1g9o9CpyxeXpZaY3oBbU/yDr
	4gMdhg2jBv7Lm9GaRd0vG1BaMsduPLgNiAc1nIEuYPrfu+rbiysuH67fnJ2fVZoRgRcFXFlmBtw
	hwW5gwBtt4FSDg==
X-Received: by 2002:a17:90b:3883:b0:39e:6c6a:2093 with SMTP id 98e67ed59e1d1-3a098970abbmr578141a91.52.1790205772655;
        Wed, 23 Sep 2026 16:22:52 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09733f48fsm1267490a91.11.2026.09.23.16.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 16:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 23:22:51 +0000
Message-Id: <DLN2ZDTXXAB7.1R7UPYW6JRF5G@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
 <7eba4eb055e15d5c78f463d013fa98bb21d7b494.camel@gmail.com>
 <DLM6BVU1G0V3.29T5BPPZTZ77Z@gmail.com>
 <37e53199dfda608de30a31fc51d22ed2b25d6d2e.camel@gmail.com>
 <DLM8NP9S8A4E.1YIS9HRMSR62@gmail.com>
 <a9c4ebe0c1a08d7025179b1ec2297a4d975cd072.camel@gmail.com>
 <b3a29c0b77ada6a7eff101a5d8b4e83021a3052e.camel@gmail.com>
 <CAEf4BzaStrSG-hGERB8J=mt3agEq7d9L8+L9rsr4Z+=68gtA-w@mail.gmail.com>
 <DLMY4E5MYGQI.29MKOKECHM134@gmail.com>
 <DLN0OB4STWN9.1101L0OPX69QV@gmail.com>
 <d2ad6462af36f389b208ab17544ec760c27fb782.camel@gmail.com>
In-Reply-To: <d2ad6462af36f389b208ab17544ec760c27fb782.camel@gmail.com>

On Wed Sep 23, 2026 at 10:00 PM UTC, Eduard Zingerman wrote:
> On Wed, 2026-09-23 at 21:34 +0000, Alexei Starovoitov wrote:
>
> ...
>
>> Sorry, all I hear is a knee jerk reaction to a lot of slop.
>> yes. a lot of it is not needed, but invoke approach is no go.
>> As I said couple time [ip_start, ip_end] is not a single call insn.
>> libbpf patches do a bunch of unnecessary copy paste,
>> but that's because we didn't do insn_array support cleanly.
>> From libbpf pov bpf_cleanup section shouldn't be any different as
>> "one more section with pointers to instructions".
>>=20
>> Sorry, we're not doing new 16-byte insn. We can chat about it
>> during the meeting, but I feel it will be a waste of time.
>
> If you simply don't like 16-byte instructions, then yes,
> nothing to talk about.
>
>> New insn doesn't reduce amount of slop.
>
> It literally and demonstrably does, I listed the actions that are not
> necessary with this encoding in the previous email. No matter which
> llm you use more actions needed =3D=3D more code.
>
>> Ed's example 1k vs 2k is a counter example.
>> This is just one llm vs another. Both sucked and both slop.
>> Just different amount of it.
>
> Fwiw, it was not a one-shot. The verifier part is curated.
> The jit part is whatever codex decided to do with the original series.
> I stand by the complexity reduction claim.

I don't measure complexity in number of lines.
There is also llvm part that you're forgetting about
and dragging that new insn all the way.
