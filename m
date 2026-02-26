Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3203603FB;
	Thu, 26 Feb 2026 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130281; cv=none; b=saVnwP97NYtQ/aiUH43hgFHcjXqrngHeiP1l6IUU4Q5jQkPWoyszpHnE4BxaMo+sAiesATyCHAEbQJ4TeMUiG2TQvuiWQtSOa9VtC3714DZpKDcR3+krcYPOSFPc3gJKqtDyCKRM7SQU9nPMeNoMr7mSYllRe4hd7+/j+KxXlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130281; c=relaxed/simple;
	bh=mKTHi5E7UwTvjBozYLBiG7CTZ0b9UNERTOxVerYAAkk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bd5RUYD7QLxU3Gf7FQbQEzO/Po/NahzIvfc0MzYOqPNaGMwt2G50MrAtjaV3mkrPiRr6kzKbv3t98J5eKQOttAL+aibb0XZV/xz2SaDNZgQqdDlOmdZbeUR6HdSQTwd+kkI0zL+KvKFJ6UUnfo/tnlTqcon4iEHXbrKAoaCwNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRSUGP6K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRSUGP6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B54DC116C6;
	Thu, 26 Feb 2026 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772130281;
	bh=mKTHi5E7UwTvjBozYLBiG7CTZ0b9UNERTOxVerYAAkk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lRSUGP6KxCJ0p/QfCWDqRV6w0c+xh8Mcg+TGn+QXz4vtjcsv6ptts7xLieFJ6znM0
	 zG6bZ+iWo6PMDjTjs7OnMc0fcoYr50N75pnklRDNFD2Fv6XUXnVuNANKu2/v+cfy61
	 Is7UoP17uf407It/vYP9O3iMSk2ZQQQsfT/eW+CVRBaTIRZ5/7MSU/vvnkwluCEmR3
	 tFJlC7YqjjhixP8vc98sGFVevP28W/5kxAtgubXs8svXspAa05D0zOQe9/seHifACu
	 oMZOcmQopos00w8771aDVpnhH/G8Hr4oZYxO13RKCKU5JHvDT15OQ4uu4/Hvc5hdkt
	 SugYY3tUUUNPg==
Content-Type: multipart/mixed; boundary="===============3745467539212864191=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <718f3550455f60bf9a61d4a1a0c01a40c1845521102043e89c0a425f3e2cabc1@mail.kernel.org>
In-Reply-To: <20260226173342.3565919-3-andrey.grodzovsky@crowdstrike.com>
References: <20260226173342.3565919-3-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next v2 2/3] ftrace: Use kallsyms binary search for single-symbol lookup
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,linux-open-source@crowdstrike.com
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,jolsa@kernel.org,rostedt@goodmis.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Feb 2026 18:24:40 +0000 (UTC)

--===============3745467539212864191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 827fb9a0bf0d..cfa0c7ad7cbf 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c

[ ... ]

> @@ -9270,6 +9279,19 @@ int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *a
>  	struct kallsyms_data args;
>  	int found_all;
>
> +	/* Fast path: single symbol uses O(log N) binary search */
> +	if (cnt == 1) {
> +		addrs[0] = kallsyms_lookup_name(sorted_syms[0]);
> +		if (addrs[0] && ftrace_location(addrs[0]))
> +			return 0;
> +		/*
> +		 * Binary lookup can fail for duplicate symbol names
> +		 * where the first match is not ftrace-instrumented,
> +		 * or for module symbols.  Retry with linear scan.
> +		 */

Is "or for module symbols" accurate here as a separate failure case?

kallsyms_lookup_name() falls back to module_kallsyms_lookup_name()
when the vmlinux lookup fails:

kernel/kallsyms.c:kallsyms_lookup_name() {
    ...
    ret = kallsyms_lookup_names(name, &i, NULL);
    if (!ret)
        return kallsyms_sym_address(get_symbol_seq(i));
    return module_kallsyms_lookup_name(name);
}

So for a symbol that exists only in a module, the fast path finds
it through module_kallsyms_lookup_name() and succeeds if
ftrace_location() confirms it.

The only module-related failure case is when a vmlinux symbol with
the same name shadows the module symbol in the binary search, but
that is already covered by "duplicate symbol names where the first
match is not ftrace-instrumented."

The same phrasing appears in the commit message:

> If binary lookup fails (duplicate symbol names where the first match
> is not ftrace-instrumented, or module symbols), the function falls
> through to the existing linear scan path.

Would something like "for duplicate symbol names where the first
match is not ftrace-instrumented (including cases where a vmlinux
symbol shadows an ftrace-instrumented module symbol)" be more
precise?

> +	}
> +
> +	/* Batch path: single-pass O(N) linear scan */
>  	memset(addrs, 0, sizeof(*addrs) * cnt);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22453951811

AI-authorship-score: low
AI-authorship-explanation: Domain-specific kernel expertise with precise empirical benchmarks and standard kernel patch conventions consistent with a human developer optimizing a real-world bottleneck.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Misleading comment and commit message claim module symbols cause fast path fallback, but kallsyms_lookup_name() handles module-only symbols correctly via module_kallsyms_lookup_name().

--===============3745467539212864191==--
