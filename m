Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BBE344025
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645229; cv=none; b=A5aCz2ITphJ9/eK29L6FOF7Z5tfh961TGeO85UOU1+Ic/EkD9FTU81/UfVlm3/PXgXCSAEZFyjA/ZwF4dZvgZ5iOgP2A0jtoifcIfaJpM21jWAZhY+iIZWBLtvVG6kct1N45SIliIOoPlXJjNxgf8lJBz+wYlBbv5yZPpzsnFrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645229; c=relaxed/simple;
	bh=v2MQ58gf4aLY4+iJPsd/XP/SejUNE2l604U85f/fXxM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gY7UF+lLbpWb22zTayMwGNTsvTXFgjgt08YwwPJw+kJtc0ktITO99t1h6NR9RhkR2Ps4zWnuuIE5npWMawv2hN2jgrykjkGlomqaCv1yapc79ez6MNjiHJv/9chsc0/HNt+XC6H8XGIShGuY1GVso9gGaVlLxBBn4qd6J2BfJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWhUk/bL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWhUk/bL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C4C1F00898;
	Fri,  5 Jun 2026 07:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780645228;
	bh=4c4eRFf7gh8wcjrEIxjoJYCoiQYih6TPFpDQgEex+nI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JWhUk/bL/6VwY9unDpc5w38KdRDZQ4qm9Eu+50p/yDdMlXgk5RDz3SdvRi2GBJNXT
	 XjmLGLciFZtz5qD1tuQz5xEoK1mr2bA3QOsLG5RbZHOVNCKyrhDyGe0Mp7/yeTht32
	 ONQBpVGRPFDww2kHSRsPzDx7jUkoOfccjZOf4f7TPQujodaYGhkf5jnc9KBtlrV6vr
	 OsJnDWHXIoyL0uwUx5IiuUpsUl0Qc0t8quQAR+Rdq/Bt4HIwdEt2b7qLmuNUjSDflz
	 xkWx6PAYHrYCDP8kXzxwr7RcWZgOdmyUhtMlc0oCgu3ZHzCCZgtfssISlgAIqGy2sq
	 pn0GZyJGtxnow==
Content-Type: multipart/mixed; boundary="===============8194649317624388510=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2f754b761f54d3706f15d91eb8666f58f18e4557f0b386b990cb4e178d609e7a@mail.kernel.org>
In-Reply-To: <20260605063412.974640-2-memxor@gmail.com>
References: <20260605063412.974640-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/17] bpf: Add verifier diagnostics report helpers
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 07:40:27 +0000 (UTC)

--===============8194649317624388510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> new file mode 100644
> index 000000000000..a6684adc0c31
> --- /dev/null
> +++ b/kernel/bpf/diagnostics.c
> @@ -0,0 +1,110 @@

[ ... ]

> +static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env,
> +					    const char *first_prefix,
> +					    const char *next_prefix,
> +					    const char *text)
> +{
> +	const char *prefix = first_prefix;
> +
> +	while (*text) {
> +		const char *line = text;
> +		int prefix_len = strlen(prefix);
> +		int text_width = BPF_DIAG_TEXT_WIDTH - prefix_len;
> +		int len = 0, last_space = -1;
> +
> +		if (text_width < 1)
> +			text_width = 1;
> +
> +		while (line[len] && line[len] != '\n' && len < text_width) {
> +			if (line[len] == ' ')
> +				last_space = len;
> +			len++;
> +		}
> +
> +		if (line[len] && line[len] != '\n' && last_space > 0)
> +			len = last_space;

When a word ends exactly at the column boundary, can this wrap it one line
too early?

After the inner loop, len can equal text_width with line[len] pointing at
the space that separates the fitted content from the next word. The revert
guard only excludes '\n', so a boundary space still satisfies
line[len] != '\n' and forces len back to last_space.

For example, with a text_width of 10 and the text "aa bbbbbbb cc", the loop
stops at len = 10 (line[10] is ' ') with last_space = 2, so len reverts to 2
and only "aa" is emitted, even though "aa bbbbbbb" is exactly 10 columns and
fits.

Would also checking that the boundary character is not a space avoid the
early break, e.g.:

	if (line[len] && line[len] != '\n' && line[len] != ' ' &&
	    last_space > 0)
		len = last_space;

This looks cosmetic only, affecting the layout of verifier log prose rather
than correctness. The same code is present through the end of the series.

> +
> +		verbose(env, "%s%.*s\n", prefix, len, line);
> +
> +		text = line + len;
> +		while (*text == ' ')
> +			text++;
> +		if (*text == '\n')
> +			text++;
> +
> +		prefix = next_prefix;
> +	}
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27000182395
--===============8194649317624388510==--
