Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C17454707C;
	Sat, 26 Sep 2026 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383716; cv=none; b=aVCTTAosQZ/hhavfUhGdoP7hY9Djs/JEe7qV/9aIakIAHo5lciUrl5/wsnoV9iQ0t9XJ7ihFWv7xFvjEtIKuPuXu3DjZIdVUOb1AD06WMpfB91oaM/fUys4U6wKe/gSwJ3GVpQVH591/wDmytgu7RLX/nGpzsnLU+iiK95o48o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383716; c=relaxed/simple;
	bh=kV2SxQvU2RCE03UZeNW+WczE4uMmi4tQoKcN24Pv9wE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F8WWnTmkjg1nisz0lJSUZAbHdiFHu0mmYZ4/Lm7BXGmPkoN+7ZJpKTbXVlHm6q77eEiIw0rX6/LN8zqP3PG9G+qPh0EQAiOm0letlzt4s8eqB9O8MpSODpCjG9DkvB3VYRqwObU31ol31IAyKMpxgwb35P3RGAmPaDyV0snya+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kskks+Tl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kskks+Tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415951F000FF;
	Sat, 26 Sep 2026 00:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383715;
	bh=sDMlYFN1ZYQqp0Zn3AzXcmxDlXJCZyJLYKmF9HGp54M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kskks+TlbPJ3QM0G9NVMxVhNIUvW1jtjDUjXxaLrZcz1xA0EXP9cZdEjXPL7KCalR
	 3Ez8LGVLri9ncrzpnFJHQBkkGpyPELPM/3tXUhQpZWHX9eRK6vuQnYE672SyJxiOrK
	 8ZhWk+9T1hG0YpkSfqgnIw1wimdCIPRd7zS1ml8XgiQC20L90lmtFbyNPz8UOwncnW
	 jIiSwjJx7VRsmmp1RhD3PIOL+fgtVqM49bK5SX0BrkHGvB0CbNOU/pgiEKlevyaZ/w
	 E1aiwLwjL1vTwQ0lMxsY8KqCtWyyaYiz6UYmics199LSBzF61ESGj1+v9YzaeT3d+U
	 Qyaigcah7r3/Q==
Content-Type: multipart/mixed; boundary="===============1513375797936626188=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f0270d46b72ba20afbb472d2bb4e2392a70d79e9be7783b50a7d5970759b1f63@mail.kernel.org>
In-Reply-To: <20260925-ksyms-tune-v5-1-1f75ad0c321c@gmail.com>
References: <20260925-ksyms-tune-v5-1-1f75ad0c321c@gmail.com>
Subject: Re: [PATCH v5 1/3] kallsyms: Match compressed tokens on the fly during binary search
From: bot+bpf-ci@kernel.org
To: jim.cromie@gmail.com,akpm@linux-foundation.org
Cc: ljs@kernel.org,kees@kernel.org,david.laight.linux@gmail.com,masahiroy@kernel.org,olsajiri@gmail.com,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,bpf@vger.kernel.org,jim.cromie@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 26 Sep 2026 00:48:34 +0000 (UTC)

--===============1513375797936626188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> kallsyms: Match compressed tokens on the fly during binary search
>
> kallsyms_lookup_names() runs a binary search across kallsyms_names[],
> a packed array of ~130k encoded kernel symbols.  For each of the ~17
> comparisons in the search, it currently decompresses the candidate
> symbol into a temporary buffer on the stack before calling strcmp().
>
> Comparing raw tokens directly in compressed space is impossible.  The
> BPE token table assigns values by frequency, not alphabetical order
> (e.g. token 0x05 might expand to "zebra" while 0x42 expands to "apple"),
> so comparing raw token values scrambles lexicographical order.
>
> However, full string expansion is equally wasteful: roughly 16 of the
> 17 binary search steps fail within the first two characters.
>
> Introduce kallsyms_strcmp_symbol() to compare ASCII queries against
> compressed tokens on the fly.  It walks kallsyms_token_index and
> kallsyms_token_table incrementally, matching characters directly and
> bailing out on the first character mismatch without expanding subsequent
> tokens.
>
> This optimization:
>
> 0. Avoids decompressing non-matching tokens, short-circuiting ~94% of
>    binary search character expansions without adding any tables in
>    .rodata.
>
> 1. Drops the 512-byte namebuf buffer from the kernel stack in
>    kallsyms_lookup_names().
>
> 2. Cuts unindexed lookup latency by ~530 ns (~14% faster) while leaving
>    sequential address ordering and kallsyms_expand_symbol() streaming
>    invariants intact for /proc/kallsyms and table walks.

This isn't a bug, but could the changelog say how the ~530 ns and ~14%
numbers were measured, such as which selftest and roughly how many
symbols? The ~94% figure seems to come from the 16-of-17 binary search
steps estimate mentioned earlier, which is a share of comparisons rather
than character expansions. Could that be reworded to match what it seems
to come from?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36204745600
--===============1513375797936626188==--
