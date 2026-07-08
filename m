Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7273EFD07
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545052; cv=none; b=Qh86FKcI4fqoRixYdZm6vR4grFDaf6Skq5PtA2PLPsn4u+7EslMTLmOYsT88PESWrkp2GNuw1Tn4rE67Ennek4ep6YHHRyKzYfrIhq3IC/SU9p3DbnrwzKanwMJJkSoxfCDBhEo2jEPsjR27oFa6yuC0lW1USCmqhD+dAR9Ozf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545052; c=relaxed/simple;
	bh=hdyZcd/tqMetxTTfbHYfbvouRNRmZ+6IrImPwZ8f7q4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CvllF0D96TjXx58qhVuaPXHH/4ZwMB9UVQHd5NbXCkmhMrip/Ar/eQGFv7xR8DCAit8FGRANAD6XtH58HIlc7Lj//PQoItX0glwux/EbXsHOzEdabk7/KSVWFppHJ8mBAcf4qoDoGu46JSMBP0Qo19/qXzLZSZHryKI5LJhbvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRPZgVt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRPZgVt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F2D1F000E9;
	Wed,  8 Jul 2026 21:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545050;
	bh=dknYcM2jnp0suajKepACZpTvKt+Djci/MX2dHNiuIXo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MRPZgVt/0nINDWygr9ZlqrGd3G3CaM3VGnHnS9Cf5cP9SpREWvYfTjT47Oxem+v8D
	 t/bbUJqxM8NIfJiUtRU861COyEmRXchVXNYTmgtMXmKzOU22rGa9mb7n020m13/iVY
	 7W2dfok9ZcMmNqy14eZEEN7e7L7MwTNG5vlNxf+JAdny8sG0c5/HtJIFvgiAwjPhv7
	 0+L70GE7zJdiMjT+SMeW59R+osrO17cbL12JEQfD5ehUfPq5Edkwh8WRpn2QQCt3aL
	 g0BacgnraYiaYFgWGQvONfc5ruY/l2PUn+CVy7nhksaWDmuBSzA+i8jw8IiJih9vzk
	 Wp/uwWwNWDWCA==
Content-Type: multipart/mixed; boundary="===============4089524383825238931=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cd4ca66299d6e7a8e4bdf2a524e302fe057d819303c82a9535b63279be52631a@mail.kernel.org>
In-Reply-To: <20260708201000.2157684-1-yonghong.song@linux.dev>
References: <20260708201000.2157684-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 04/12] bpf: Track R2 of register-pair returns in precision backtracking
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 21:10:50 +0000 (UTC)

--===============4089524383825238931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> A function returning a value larger than 8 bytes (a struct/union, or an
> __int128) uses R2 as a second return register alongside R0. Previous
> precision backtracking only treated R0 as a return register at a
> call/return boundary, so marking the second half of such a return precise
> would trip the "unexpected regs" checks in backtrack_insn() and reject a
> valid program with -EFAULT.
>
> Handle R2 like R0 in the three boundaries where a call defines the return
> registers:
>
>  - static subprog exit (BPF_EXIT): R2 is a return register, not a leftover
>    argument; clear it before the args check and propagate its precision
>    into the callee.
>  - global subprog call: a global subprog returning >8 bytes also sets R2;
>    clear it before the args check.
>  - kfunc call (BPF_CALL): a kfunc returning >8 bytes (model ret_size > 8)
>    also sets R2; clear it like R0.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a fix for the R0:R2 register-pair return handling that
went in earlier in this series, where backtrack_insn() was not updated to
treat R2 as a return register.  Should this carry a Fixes: tag?

  Fixes: ec219322a9a7 ("bpf: Add verifier support for 16-byte returns in R0:R2")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28973410219
--===============4089524383825238931==--
