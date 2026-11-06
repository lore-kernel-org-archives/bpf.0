Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001812;
	b=sNEfEjMtDiBaTNjis+6RJ3S55rzLx4X48YzxgecI9xJo3WVtpgLegU4VGijItF/H0bdn
	 aUdOXRqvmmBRbj3omHVu3fwe78dzj4NXa5AQtRDioi3SuLQgfGvWoDIdYYBSy/+s0ooDk
	 FQO5wC1N1f3fOFgWIoOwdEFdtj003ONVGHRPie/G6XOV/2sVi/37CRtpnBhJ3g9zWVyjg
	 YLGLZBQZLP3dVRWS2Sf1ZiDjmgCdLFMxOd0xOSzc6nsF60CUA92MQ2ZH0o8uWPB9Pxorm
	 SaqR1bnDWDE6clltzQAWP3zXti5jsnvhpgC1UU0JqxjvJrJW4lM/5725sHblPi7OSqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001812;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=qyD4/QNMYslZrvex6UggevvD+mzpPjAON1auD7GtOww=;
	b=JHDiayJlIjfdFvEI7it5Qq+/v1f7t+VY4gk5tHZq7h7RqaJIA/2B1kL9pOFhfcE535hE
	 pUfvvPF6/mPb9xdygEPxoOiKuTVezkzHLYkuRhWGJ8rNDYzM31kApzgT5w8gtbdf0YyDk
	 4FIni9Fvw2AyqUcKGXgRdh/VpLKX3gsjc23YFrWOJg7tlKE2A7oG+a6FhwwsKuOiegBB0
	 ao66KbQIyHCMoS/j/ijGzGwTRecmhpUjluTSroJLqVjA+5W9qLCzQqSpjh96/YqbJGP00
	 ZnupHSv/431pvmNBpfty1Rk9wOkD8gv5DtFfxpEonnnFAhi2liEOBLyJz1Q5niv9kJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZliuqbHi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A34606A33B;
	Fri,  6 Nov 2026 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZliuqbHi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B231F0089F;
	Fri,  6 Nov 2026 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794001811;
	bh=qyD4/QNMYslZrvex6UggevvD+mzpPjAON1auD7GtOww=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZliuqbHiTp4hOSJgd46BNKEuRxFQO284wkTv506CQdYNSwWaaJRqaXucF1FnJ0Tvd
	 p60pHUuXDzNqoCqgfF9IbpGd5UUfhPyXvnooGQF9uP1A/VP4JxZZLYukx5fxe1V3AO
	 rc+nl0xTJ9xcRNkgusW54Ye/pPaJ7YDkixLe6uw1ufkR32J0pZfLLQB0cjeOvFxbbN
	 yq1kqaIh5y5PRg5wWznDqOJJcLjqcXbqWz1VY5fZS9NfvUnkSjXpRNSl6miNtu6a8L
	 YxVo+JjQ39XqfQBq79TayWqteqDNaD0Xa8NsBiD/9VsyIPRZtEDoyb6OExwx3DfdC9
	 JH3hymS34yBOg==
Content-Type: multipart/mixed; boundary="===============1506488348552457952=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <82dc259cd905abb5ad4fcbb8151553fb8680d4d71b1e52babd3e2d588a90656b@mail.kernel.org>
In-Reply-To: <20261106210314.1767267-15-a.s.protopopov@gmail.com>
References: <20261106210314.1767267-15-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v1 bpf-next 15/18] resolve_btfids: Tag fmod_ret candidates as targets
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 21:50:11 +0000 (UTC)

--===============1506488348552457952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Tag fmod_ret candidates as targets

TL;DR: Nits only in resolve_btfids fmodret.c: duplicated alias-walk code in
mark_traceable_function(), its unused bool return, and possibly obsolete
section names (.meminit, .cpuinit, .devinit) in section_cannot_be_attached().

> diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/bpf/resolve_btfids/fmodret.c

[ ... ]

> +static bool mark_traceable_function(struct elf_function_list *list,
> +				    Elf64_Section shndx, GElf_Addr address,
> +				    enum ftrace_site_kind kind)
> +{
> +	size_t left = 0;
> +	size_t right = list->nr;
> +	size_t first;
> +	size_t i;
> +	bool found = false;

[ ... ]

> +	if (first != SIZE_MAX) {
> +		while (first && list->functions[first - 1].shndx == shndx &&
> +		       list->functions[first - 1].value ==
> +						list->functions[first].value)
> +			first--;
> +		for (i = first; i < list->nr &&
> +		     list->functions[i].shndx == shndx &&
> +		     list->functions[i].value ==
> +					list->functions[first].value; i++) {
> +			list->functions[i].traceable = true;
> +			found = true;
> +		}
> +		return found;
> +	}
> +	if (kind == FTRACE_SITE_PATCHABLE || !left)
> +		return false;
> +
> +	/* The nearest preceding function owns the call site. */
> +	first = left - 1;
> +	if (list->functions[first].shndx != shndx)
> +		return false;
> +	while (first && list->functions[first - 1].shndx == shndx &&
> +	       list->functions[first - 1].value == list->functions[first].value)
> +		first--;
> +	for (i = first; i < list->nr &&
> +	     list->functions[i].shndx == shndx &&
> +	     list->functions[i].value == list->functions[first].value; i++) {
> +		if (!function_contains(&list->functions[i], address))
> +			continue;
> +		list->functions[i].traceable = true;
> +		found = true;
> +	}
> +	return found;
> +}

This isn't a bug, but mark_traceable_function() has two near-identical blocks
that walk back to the first alias at a (shndx, value) pair and then loop
forward over the aliases.  The second differs only by the
function_contains() test.

Could the walk back use function_at(list, shndx, list->functions[first].value),
with one forward loop that takes the containment test as a condition?  Then
the two copies would not need to be kept in sync.

Also, this isn't a bug, but is the bool return of mark_traceable_function()
meant for something, such as a -v count of unmatched ftrace sites?  None of
its callers in mark_relocated_ftrace_sites() and read_ftrace_site_range()
read the value, so could it return void and drop 'found'?

[ ... ]

> +static bool section_cannot_be_attached(const char *name)
> +{
> +	return section_prefix(name, ".init.text") ||
> +	       section_prefix(name, ".exit.text") ||
> +	       section_prefix(name, ".noinstr.text") ||
> +	       section_prefix(name, ".meminit.text") ||
> +	       section_prefix(name, ".memexit.text") ||
> +	       section_prefix(name, ".cpuinit.text") ||
> +	       section_prefix(name, ".cpuexit.text") ||
> +	       section_prefix(name, ".devinit.text") ||
> +	       section_prefix(name, ".devexit.text");
> +}

This isn't a bug, but are .meminit.text, .memexit.text, .cpuinit.text,
.cpuexit.text, .devinit.text and .devexit.text still emitted anywhere?

In include/linux/init.h, __meminit is now either empty or __init, and the
__cpuinit/__devinit annotations were removed.  Neither vmlinux.lds.h nor
scripts/module.lds.S places these sections, and modpost lists only
.init.text and .exit.text as init/exit text.

If they are gone, could section_cannot_be_attached() be reduced to
.init.text, .exit.text and .noinstr.text?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42294987431
--===============1506488348552457952==--
