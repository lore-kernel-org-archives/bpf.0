Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCC466B5D;
	Mon, 21 Sep 2026 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982326; cv=none; b=Ecz9bagrGzxdM46sqf1iYKX/ameLAkNGwxG2fVlrJ3g7E4avz+u+PV35KD1eFt8miADmuuRkvKtrDMcTc2SS1Vh4CM416MY9xXot3BjuRAxpR4UCa+0pTzTg2BP4L5PBnV4eIDaLwSB1rIVXMP87jDXuzUcMnx14r8uVBCtDQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982326; c=relaxed/simple;
	bh=M3YNqZv7Rj2cNHhRw0bbWEXOvW1Hlm0yXo9EMlWxcWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unis6hXQcJ4qDtmuCggy9mYHHJQU6Zr97lBICT8Yz/VP78v9CipHbH8XzpzVkPluqDgRd2xkLIf148HKp8Qw+8NUf+7GXl0G0omdgtkuEg3jgeIXPokalPN5UI/G4yqyr/+HcKNmEmQwKqPEb6D5Rsrkr+qa7YTPEl6o/+2vy/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltKaN1Qb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltKaN1Qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B59D1F00893;
	Mon, 21 Sep 2026 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982325;
	bh=N0MiER8RYhVkIA1RjZC9BLbY30DUHMjy0iqH4TYOSLM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ltKaN1Qb/SvJXa7F3Rn0ZUaLaOj12NrP5flLg46ILcFFNoIyL1wEcNVC5D6U9muhj
	 TZkysgnLax6/gETgWT9LIAr4g/TwGwCslxfJMS8QuUl8Ae8LoJPdHuj09ohqUDDCkz
	 RJKfrPYIwZdGedacHTWem6aAyvclC9qfSQkjIVRgoslCzbz3pPSxAIRYeY/vCZ6jHm
	 C3Ls/sKLncKKm8q+nyVeYIkvwEJqVyhfF62giZW4HINE8XvYF+CNGMZXYz8b1DKJGx
	 nslDmysgh2u213DbwUgbNbG+QkJFINJxaQ2ptsIPUNIveRudZamynUzBfNntevywu5
	 rpn6jnDotHYLQ==
Message-ID: <79618b75-d958-4b88-a9d8-23fedab8f898@kernel.org>
Date: Mon, 21 Sep 2026 10:18:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 0/2] bpftool: Consume ring buffer maps with
 event_pipe
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260921073556.99421-1-hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260921073556.99421-1-hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-21 16:35 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> Extend map event_pipe to consume BPF ring buffer records, with plain and
> JSON output and focused tests for records, shutdown and invalid arguments.
> 
> Changes in v5:
> - Suppress cpu/index completion after selecting a ring buffer map by id,
>   name or pinned path, using _bpftool_map_guess_map_type(). Keep the
>   existing suggestions for perf event arrays and unresolved map types.
> - Rebase onto current bpf-next. No other changes from v4.
> 
> This addresses the v4 review:
> https://lore.kernel.org/r/a89e2e325b87c215e0fb6e4a24284922d7656cfc0e2a247f0c8c1cd823764c23@mail.kernel.org
> 
> Built bpftool and reran all 18 ringbuf subtests against it in an x86-64
> VM; all passed. Also checked completion against live ringbuf and
> perf_event_array maps by id, name and pinned path, plus unresolved maps
> and already-specified selectors with mocked output.
> 
> v4: https://lore.kernel.org/r/20260919110721.1230756-1-hi@tychen.cc

Looks good to me, thanks for this.

Acked-by: Quentin Monnet <qmo@kernel.org>
