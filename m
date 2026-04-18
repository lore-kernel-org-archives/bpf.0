Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C31826B973
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473902; cv=none; b=riaFybhRBWj4P/fXGxoVzzKyuypnD5lJ72d6eFZK7VgLYV43TB49MO9rL03Joe85Td816J8NvXFRjUWMxN2k6BwORAwoifqda2O4AYbUEpGpZqk0cboL2OCkz6tghDABhxTFLo9jx41VpVsd5OhdkvJQiHYItf1KfKm5sRnwP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473902; c=relaxed/simple;
	bh=BRemmLmkDe+dCVbPVFBVMiHZkXyv6LOGjYv+4CuuJb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kjJ7ueyhM1A3UVnKKgm1nKYD5BhHWDHqEZjCfMb32HhaLjmAdfZZtTC4LwY0xM3UqbMIA7tnSu3ldf+LDZjKp0Qu9oYj2d3LYcgaqk+wiJhzfue6Uo2VCAyet3CcgcL/t9S6aP81QsD0LUojYkQ8fk9W2pSJcf0o0Di85pYo/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhmVui8z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhmVui8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F156C19425;
	Sat, 18 Apr 2026 00:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776473901;
	bh=BRemmLmkDe+dCVbPVFBVMiHZkXyv6LOGjYv+4CuuJb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DhmVui8zxelpjBwF+MCooMFlL0/Qnt/5/MPVLZoQT/oSi7Dht1krOvMcs2IDv4AMs
	 /brLmJ+/x3OX1WK8yeFdwPBTfcZN76yZV3hs05UF5l7IqXUswPzt3rodAGvgFn9nCs
	 45nf1Zyo+MGG7giioAIsGbAkdL9gMK0Bq1XP3tBinPWBTPH8KL0/iULhv+boUwSByL
	 SdFTkJAL6OYVWFH0PdEkiyjI6fegtTxMoWAmqU5SfxqIM+MbqrGF8ocxMVp436HfK3
	 oNbiCEsnh3i97XQjUBrUZbsj3+uOjDY1IbS5BPSjypMm2RE8yyVjrh4fMcgnoVbI7q
	 c+U2cLFh41NoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 bpf-next 01/28] ftrace: Add ftrace_hash_count function
Reply-To: sashiko@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417192502.194548-2-jolsa@kernel.org>
References: <20260417192502.194548-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 00:58:20 +0000
Message-Id: <20260418005821.4F156C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] ftrace_hash_count() is declared under CONFIG_DYNAMIC_FTRACE but def=
ined under CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS, leading to potential li=
nker errors.
--

commit 62c46ea6c0c10abc0df16b7c684809496d439e2f
Author: Jiri Olsa <jolsa@kernel.org>

ftrace: Add ftrace_hash_count function

This commit adds an external ftrace_hash_count function so the hash
count can be obtained outside of the ftrace object.

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 28b30c6f10314..9d9ae1bc692ae 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -415,6 +415,7 @@ struct ftrace_hash *alloc_ftrace_hash(int size_bits);
>  void free_ftrace_hash(struct ftrace_hash *hash);
>  struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_has=
h *hash,
>  						       unsigned long ip, unsigned long direct);
> +unsigned long ftrace_hash_count(struct ftrace_hash *hash);
> =20
>  /* The hash used to know what functions callbacks trace */
>  struct ftrace_ops_hash {

[ ... ]

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b2611de3f5943..57ab01fd00bda 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6288,11 +6288,16 @@ int modify_ftrace_direct(struct ftrace_ops *ops, =
unsigned long addr)
>  }
>  EXPORT_SYMBOL_GPL(modify_ftrace_direct);
> =20
> -static unsigned long hash_count(struct ftrace_hash *hash)
> +static inline unsigned long hash_count(struct ftrace_hash *hash)
>  {
>  	return hash ? hash->count : 0;
>  }
> =20
> +unsigned long ftrace_hash_count(struct ftrace_hash *hash)
> +{
> +	return hash_count(hash);
> +}
> +

If a kernel is configured with CONFIG_DYNAMIC_FTRACE=3Dy but=20
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dn, will this result in a linker e=
rror?

The declaration in include/linux/ftrace.h is located under=20
CONFIG_DYNAMIC_FTRACE, but this definition in kernel/trace/ftrace.c is plac=
ed=20
inside a CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS block.

Code built-in to the kernel (like BPF or tracing extensions) that attempts=
=20
to use this new API could compile successfully but fail to link on=20
architectures that do not support direct ftrace calls.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417192502.1945=
48-2-jolsa@kernel.org?part=3D1
