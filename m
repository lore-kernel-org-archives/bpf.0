Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442536C9D7
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775241906; cv=none; b=J8Zoh6L/+88lzQBobJpHuUaDQHmf4XskpN+b/zYFEx8q+PULZUR0LJSmaLaf/KltEXBcEzoGAlUrVv+9soqbHY71jVyFAl7lTh0FJeAVDC8bEx80FxXyVI7rzgivGgUKMtFEsMZOR/1CDabIZe+kL0G7USizvF+Ye5Stmh+gcoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775241906; c=relaxed/simple;
	bh=8EFCThHgsEQJhqquzEAKB4kGDYhafO76ETnsyUUV8BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKnj6AZ1fn6Zkg8eb09D2+DbwnRXndXZZ3uT0875jT2yPM9ZhoRvcf/v37OtARf2axyKXnndyG+NH6sRSAk9KB7asLttEu7C+xZXQmMdbttJGVTxmth8bEpPov3KBeuYyKxSem2srZyfr8OzK3ayVeWMwTaS1oEB1OxfltRqbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWUqhVnN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWUqhVnN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B506C2BCB2
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775241906;
	bh=8EFCThHgsEQJhqquzEAKB4kGDYhafO76ETnsyUUV8BU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PWUqhVnNleBoR7ZdBCi1GeG5AwFOaQJRIoFFmSfe+3PuoeJek4z1g6MI2wMFz1/hI
	 jJBa0JBd8qcK2n7lzWfJZvLL1bVD4yEBqAVeHeA0Bdmp3WORhbxEQPI8lW8UXzYKbc
	 5IXkX3pbj7B9U46PWCtWz67nfFcXyH+zD7i/puFuaWLPz51jczacDFthBuu9zoFG0B
	 Bi1/jg1/uLcZxqosRqWa4yNEAjkQwVsZ2JYCJhsZC5A04M3lpQX1jyK8ujD/G33OkG
	 oZ7xR5GX5WY4p8S08cc0tMix9vjznMq9enGg5x7h1RXprb00USUd1s7me0W2cxUo1D
	 W+dYkmYNJQUKg==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a05c388b27so42150236d6.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 11:45:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YxFMZthoBW/W79qcdfUIX+SNJHV1emQMEDa5lc4tYETz3WYL5iL
	nJw+poyGTx2XOnxUzMMeoSES+PTEt+JMJB4nVgO5QVvvXEqVmydnFFgLk6rtVvXqXpR5CAfK/yA
	y7C2BxepQV5pc3XibLcoOYdXudcUrarM=
X-Received: by 2002:a05:6214:450c:b0:89c:edc1:e073 with SMTP id
 6a1803df08f44-8a705387f45mr64841596d6.56.1775241905230; Fri, 03 Apr 2026
 11:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403042720.18862-1-emil@etsalapatis.com> <20260403042720.18862-5-emil@etsalapatis.com>
In-Reply-To: <20260403042720.18862-5-emil@etsalapatis.com>
From: Song Liu <song@kernel.org>
Date: Fri, 3 Apr 2026 11:44:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW52HBQAMf1odz1=SdGuRwLuDOPSh6r8sXLrN4kq+sbT4A@mail.gmail.com>
X-Gm-Features: AQROBzBDIsUaJ5y_em5I-Z9TCAWtgzIcvz9WG9ueM8typnJExBdOjk6ajtIBtJA
Message-ID: <CAPhsuW52HBQAMf1odz1=SdGuRwLuDOPSh6r8sXLrN4kq+sbT4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/9] selftests/bpf: Deduplicate WRITE_ONCE
 macro between headers
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com, 
	daniel@iogearbox.net, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:28=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> The WRITE_ONCE macro is identically defined both in bpf_atomic.h
> and in bpf_arena_common.h. Deduplicate the definitions by moving
> the macro to the commonly used bpf_experimental.h header.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Acked-by: Song Liu <song@kernel.org>
