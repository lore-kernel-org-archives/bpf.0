Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0E33F590
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627594; cv=pass; b=eSaMp388Om1rkKEJH1anCq1wVWulDoWnzbdgdYXiu6t8xmtaBomTYhxcuvUK39lDmFJCCdSlb6boq8qEJPogZLVU0hS1YkWBA7y/LXsumSUEwu3VsIsrPX1xGIbd0oCYZLcJ7aL+Srn4zX2FUsS+nj4D1ppaSZjFxdXpp4doYHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627594; c=relaxed/simple;
	bh=uuVxpM7LF5kw2WNIv6qy7jHXWY4BosGrwNU6w0pJ0Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kat+/HBMeVCXRCTNZMLuCuwj8EObcKQjc5EKn5f5vXEFy6O5VVDpWFqgvcD8QzD4Dyi6O/aZSOqJ08noa3qylGCv91xAFwWSbIxdULpPQs88iqzkCWeUwhSRYrYV0WQVrNHTdm9veS0gvH9kw+tu5CQ9phtC73Tn8LLq2VNovH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYlP4bMk; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYlP4bMk"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9358bc9c50so320259266b.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 09:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774627591; cv=none;
        d=google.com; s=arc-20240605;
        b=cFkmpeH4rSaaP9Cmq6gCuEn0V0uPvBNjaTS50Leq5uoaR+GDPnzBZScmQY53FUGZw9
         O8yvyB8jP412hwh8AmNbRBaEAXE/gHJ6BT7eMXd0lniPgRhO52KIJHooFy4sK5aHbvMN
         SFdtywMp+AWg+Q5oXl2JOjXR1zFPSl6o7y5s14uwfPxiUHatupYpxDmJPtGBH6m3XfDz
         T5/E9JtW4olbsc+c1KHDvIYXTuaseyNhZ9p0a9t3rhQUP0Ruy48HRmvivE6NGdVQRAtD
         +uhnN/ILhShFwrwGgFYg+12e+U9IS4WVZAUFmy/zuWSiRxS4oK+2hS2RJQywqBY6RQir
         kQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uuVxpM7LF5kw2WNIv6qy7jHXWY4BosGrwNU6w0pJ0Po=;
        fh=EjhJQBTpynizqvVvYsjZOwidWJQ2BqpBCRgG890X4Rg=;
        b=Nea3f6OUQtcRG10tLJzYZ5Z8gkP6AY5+TKozwJu4hv1BPkjmF8L3F1UCq+b8yP8wwy
         9k4pKp+XHDgVxAh4yIp3Of+5zB2iGjhHBdILhGPtIG3vWOStCLYbZAXMF3wLIOBwVAth
         ZTRfYmFxvCD2mq7ypkxnlApCi+63vqAdOOojmA31gdWS8V2AiEIgid5llQwpAOdrCUG/
         KZRTOQft04FeRe7gjBef+SvzU3JxA+LrYem9xSl3a390N8sUf6ybmRVgOC9cZ9JvZUJu
         484GMNcZX95VybyCMk9biQwLbQDgnGCwQ+inXEpRu++dU8E8p5eIFiq9nVd9UP09LLK7
         nBFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774627591; x=1775232391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uuVxpM7LF5kw2WNIv6qy7jHXWY4BosGrwNU6w0pJ0Po=;
        b=qYlP4bMkKM9Qf7EfTyvUfZ1aTSvR2JRE7PR/6xgrAmcjQeeB5Vr8zxh/lFYvBjh3bK
         Q65snC1o9YMW9vyTgHxLURaex/iEZARuynQJpkogPxiFZdE4GQqLjom12LWNWP1JBldI
         n7aofixE3VfuB1V/LYnWkOmfIYEzVdflGZLMbuTexF9J3ndI941e7d8iYtzocqiqTfg8
         OuBvvK6w1dORkoqlOXciD0QwfyDqOM+fXPnef/gUtrjtkBIiW5z7Wq5WP+QTpT2O6tg4
         aKwOcb1LFXVR9AjEt2VAWxvL29tcVAAluuZfFgKhQwRKJ8yNNDyA/iTqEfb6PZC59KYa
         QIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774627591; x=1775232391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuVxpM7LF5kw2WNIv6qy7jHXWY4BosGrwNU6w0pJ0Po=;
        b=SYmW+b5KpdRBzzC9glXQ7EYlSDxvk3z1ZMxjf6cPzI2wd1pKUYzuAHqA/ZqlWcd/3H
         hd+V6wK7S1RwIWoyArXbdVAT74/3yXTsSEqYiLjzB9aYPjRI+cVGEalw+X8HOr6sV55v
         ulaHco6AHAWytaZssac6F0uNfkZHo50F9PBmSD/fCn4h2yMnI4iCeK4Z/oaRM0ol0CGC
         MCRLkK7laqP0x4i0Bukay1YJlgB37V74xa3vUGUMkvO0lePYCYTOreLgb2kWISMWDqY+
         kKzaWyl+3lMJNP6JoZ41sXtpacBy8PunE4GrsOAm4v/6goyPt8WqNuuPGyesQBYTOxKJ
         iWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL/FVaprM/j0bgyAGSSCncqQQdxKyTOuWgAY6Bia5oZMheFq9Edu8PKBvXkkKB4iafH9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0w/esj7a91CpGOnN8Sz1/f+4AJ7IUhJh4vRGPbsJ4UdCLpmk7
	0ODfyZzlzREJqFOvOrsRYlnL3HkruznsD37akLgijk8hvGwNycvb7GbR3aoYpFMDwbe7WmnhrtV
	SNr1ql5DXGfxg5HYxIEypz4RxSk7lpJw=
X-Gm-Gg: ATEYQzzeVzc6/T38EbYXL+meOAo+rHAH75glf8CaGBUhpTrQoa/rp3G0Ms7HhAAKX6P
	b9G9KC1mqksJaATwK65+wLOkhoB1Z46uvfnerTKCWo2YjX1NrjI6hRxD8xh2XyjwKIzReNUOSyZ
	6kv51b6uAldCXyFMBxXfWUDp0wjbTZsiMU/QB13kgJ7AE9+Jjh/YqARcO+iWJSfhdMBz2irl/Q8
	86B8x7hzvaBAGfx+PlpwyEzAJn9Z59Q30pUlK0K0PcRDxOD7fYkdbhM/6+/mpBbqKsGSs+jnw0n
	8BFtSGN/voZ668NHROPIt8WV/XnJrzuPB2xuNgw=
X-Received: by 2002:a17:907:9c07:b0:b93:81e7:8454 with SMTP id
 a640c23a62f3a-b9b503017c0mr202275066b.6.1774627590602; Fri, 27 Mar 2026
 09:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327141616.1961457-1-hayatake396@gmail.com>
 <20260327141616.1961457-2-hayatake396@gmail.com> <CAADnVQLh76CWYJCJXgOst43FcJOrPP2Y0wcwGPX71QqmiD+7pA@mail.gmail.com>
 <CADFiAcLvdjE7zwqf-hpH01jnbxtnWQNoj4+zBwK0+RU80-k9bg@mail.gmail.com>
 <CAADnVQLR6Y94wKo1G_4w0-xTPdR8ws38oGu3xfHOXxNKcqjyWA@mail.gmail.com>
 <CADFiAcJtjVHYVQeYJ_znVsjiJkEBmLfOafp5srY0HQMGwVtiQQ@mail.gmail.com> <CAADnVQ+0EwaJXgS1WSDf12+Ds2Uxbh9KMpDcyq+gyZjcQ_6+dw@mail.gmail.com>
In-Reply-To: <CAADnVQ+0EwaJXgS1WSDf12+Ds2Uxbh9KMpDcyq+gyZjcQ_6+dw@mail.gmail.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Sat, 28 Mar 2026 01:06:19 +0900
X-Gm-Features: AQROBzC8MI29tPLHd2U4dUVGpUgNYaq_j3Fxz59f6kM9vlrisGKIzkfQq4eQSvs
Message-ID: <CADFiAcJFy-n5Zz+Wj1dWEH0WcK+PhKXi7cbvdsLnPhMXRcVktg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on
 non-IBT JITs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Sorry about the top-posting.

That makes sense, thanks. I agree perf can provide visibility into which
BPF programs are running, including tail-called ones.

What I am still unsure about is packet-level / structured-data
observability. My use case is closer to xdpdump-style debugging, where I
want to inspect packet-related context from specific XDP leaf programs
in a live pipeline.

That feels harder to express with perf alone, so I am trying to
understand what the preferred direction would be for that kind of use
case in tailcall-heavy XDP deployments.
