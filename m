Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C723A9DB1;
	Wed, 25 Feb 2026 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020052; cv=none; b=TIt4h0bJLQVBctNJfHOqQ6XDzyrBxGac9MNgiVWk5qjfDtA9eWzU3fzzEKcX4Ykey6pB5+N1VcUiwUucEUzTAwhUx8oHONpn7zPl1KvtFB0wgQUd8QF0/1cdI9gn6qo/NWi+1qORZkO2IrEu4ossUNcBeFy6bn4Y9hkDaA0gFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020052; c=relaxed/simple;
	bh=Y2tURQ/ugst/cYXgMI7R0Xlrghwci9DQtOCQ7z9uWlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUd48ePZ8iWrJ5N2YeFQpZem99nCrR6MhMkjkVP+ZiBieGRiQabYCmK7hYaOPCsomhEFVGEyOWObbsRIcyEVZmeuZgTzOHXJnInaUlxKiEKWEHHL8/2Ywimy1XIlBw2673HLCpqnYTpLWpjUpOyjzguX4HM1ZYSfkWdxAKZy1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 038AD1A0460;
	Wed, 25 Feb 2026 11:47:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 7698E20010;
	Wed, 25 Feb 2026 11:47:26 +0000 (UTC)
Date: Wed, 25 Feb 2026 06:47:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <jolsa@kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-open-source@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next 2/3] ftrace: Use kallsyms binary search for
 single-symbol lookup
Message-ID: <20260225064723.53bcce3e@fedora>
In-Reply-To: <20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com>
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
	<20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xw5asezhocjfh86or7tfxz96m4tqj5aq
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7698E20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1808afTpgJlNX5j9nUH8blSilRFwCNl1X0=
X-HE-Tag: 1772020046-408120
X-HE-Meta: U2FsdGVkX19wOTwBSJcdcwarCOu1IQoy4WqJk4Z1o18tuby9DFzatcZz7X0Lvj3jpmEVnJwcS2AbZX37U5KhcTIdpj8MyhqJsdbdzJ0v40mpCVYbOwbyEs+bWy/YNgYHRbGdYttNAuOogpJH7FgnIC3hADbKh2+Oq+kx06wTUtN/peDMwlIAXihxlmyQCfUvBHL063Fj1xmCHuQH2KCZGsr+OJYXhGdvY9XazazwN2ZdY8WLR72NXv1zMEs81XEknaHdRCzOXrV52XQrF//evnqOlXH4D8DRFzlLIztTqUFQ5xH2oJjj7piPkoBZ1fUapbnEHvCAvLDT+Bs7cs6rloKwuV0+fwXk

On Mon, 23 Feb 2026 16:51:12 -0500
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> When ftrace_lookup_symbols() is called with a single symbol (cnt == 1),
> use kallsyms_lookup_name() for O(log N) binary search instead of the
> full linear scan via kallsyms_on_each_symbol().

So this patch looks like it should go through the tracing tree, not bpf.

> 
> ftrace_lookup_symbols() was designed for batch resolution of many
> symbols in a single pass.  For large cnt this is efficient: a single
> O(N) walk over all symbols with O(log cnt) binary search into the
> sorted input array.  But for cnt == 1 it still decompresses all ~200K
> kernel symbols only to match one.
> 
> kallsyms_lookup_name() uses the sorted kallsyms index and needs only
> ~17 decompressions for a single lookup.
> 
> This is the common path for kprobe.session with exact function names,
> where libbpf sends one symbol per BPF_LINK_CREATE syscall.
> 
> If binary lookup fails (duplicate symbol names where the first match
> is not ftrace-instrumented, or module symbols), the function falls
> through to the existing linear scan path.
> 
> Before (cnt=1, 50 kprobe.session programs):
>   Attach: 858 ms  (kallsyms_expand_symbol 25% of CPU)
> 
> After:
>   Attach:  52 ms  (16x faster)
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  kernel/trace/ftrace.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 827fb9a0bf0d..bfd7670669c2 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -9263,6 +9263,19 @@ static int kallsyms_callback(void *data, const char *name, unsigned long addr)
>   * @addrs array, which needs to be big enough to store at least @cnt
>   * addresses.
>   *
> + * For a single symbol (cnt == 1), uses kallsyms_lookup_name() which
> + * performs an O(log N) binary search via the sorted kallsyms index.
> + * This avoids the full O(N) linear scan over all kernel symbols that
> + * the multi-symbol path requires.
> + *
> + * For multiple symbols, uses a single-pass linear scan via
> + * kallsyms_on_each_symbol() with binary search into the sorted input
> + * array.

The above is fine.

>  While individual lookups are O(log N), doing K lookups
> + * totals O(K * log N) which loses to a single sequential O(N) pass
> + * at scale due to cache-friendly memory access patterns of the linear
> + * walk.  Empirical testing shows the linear scan is faster for batch
> + * lookups even well below 10K symbols.

The above is unneeded for a comment in the code and just belongs in the
change log.

-- Steve

> + *
>   * Returns: 0 if all provided symbols are found, -ESRCH otherwise.
>   */
>  int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs)
> @@ -9270,6 +9283,21 @@ int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *a
>  	struct kallsyms_data args;
>  	int found_all;
>  
> +	/* Fast path: single symbol uses O(log N) binary search */
> +	if (cnt == 1) {
> +		addrs[0] = kallsyms_lookup_name(sorted_syms[0]);
> +		if (addrs[0])
> +			addrs[0] = ftrace_location(addrs[0]);
> +		if (addrs[0])
> +			return 0;
> +		/*
> +		 * Binary lookup can fail for duplicate symbol names
> +		 * where the first match is not ftrace-instrumented,
> +		 * or for module symbols.  Retry with linear scan.
> +		 */
> +	}
> +
> +	/* Batch path: single-pass O(N) linear scan */
>  	memset(addrs, 0, sizeof(*addrs) * cnt);
>  	args.addrs = addrs;
>  	args.syms = sorted_syms;

