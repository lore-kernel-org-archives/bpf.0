Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610554;
	b=fEqlrFhyMmReRur5+2plCN4woxzBSXgLRH/7LA+6AU/253DTWsVsrBgADUXCT1Yj/TO4
	 cvC/DZsYsezERDGhwtCdNLAC8Vp6qMHtIu+kmOPDEkEiSA6EDZ+g5Hn/V4UW7btTTi6mG
	 D0LJi9DIzwgBnl8yhFhCRktYI72NBsPp3OIcHxBwExILLsOrvd6Mt3deB34ojQXdowiZP
	 dpIg2EULUSs+3KwvbcH01ZQxsshPrv6rOM9J4r8vlRlHRA0gm9rEguVX39G+puo0mCyr0
	 sws7ZN7WIouQSAxnbG+C4IbVawE7jkmPxJK8msBBz3oCJ4z5rAPBA9xh3EVz8eHYlnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610554;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=KN3BAQQz6V4aWs3TRbBIzGlNzQXPAP/3NN2RobaOAEE=;
	b=zxCeSbP0hzMqacB75PoePZi38buWIDrC8WVxO99/B0g44g6sY+qEQ4yg/5ft9T/W2jtV
	 X9/zjYchkYvFsTHaG5NwuOz6nu4i7vLFjX3O5yxH/+kyypiMf2xCRxjEbwcFVXhR9lA+f
	 6B7NsTEhuFIAvlUBYkxQojbTN5V8RVzbx/8726pAhJGJpQzyceBG/pW6tHVZjebN6Hu9L
	 6BxW5JGBZY5QwcEnelekz/5WATTvqLaK09szve7YsR/GoWpUAE/qkGiBJfslhwa4sRzgY
	 T/IprHqfxCg9dm6+TLjDgbfFD6Yvx8/Pr0sMAUYhbQvUvX33+h+YnfeKHcpisTfnPaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zr/r1yff";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA19606A890;
	Fri, 13 Nov 2026 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zr/r1yff
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4053A1F000C4;
	Fri, 13 Nov 2026 22:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794610554;
	bh=KN3BAQQz6V4aWs3TRbBIzGlNzQXPAP/3NN2RobaOAEE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Zr/r1yffsWfgcq3GiAScelw76p+OkyQYD2uH4hI/pcXZT/7E7x2Do+HBZm7e8OFNx
	 c1oIKY+cvZEYv2sTZiX8+jnO5YqRpoKeiMbazqRw1aa4yUaQNbK7Mb95zvfQKKK1ig
	 mxTFsa/RQhH/hCyvaswWfMYIpbiYkjjf2EiN/QQuWlfHGZB+EWhPT+tIC3Q4Mu5j8o
	 t3lv1MPLpzLCUm09+TGX/ieOrJzoVKxT/z452fFm5NUzwDYL01fzfKWTbIMccvSMuj
	 9FGL0SOXawyhCSF1WGLngab9+y6SU5rYrE3XlyC8yaZy7Xut3XdxIC/7rV4CX8ZWVe
	 haNQtCPugcyAw==
Content-Type: multipart/mixed; boundary="===============8280819268335858825=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2f27a1ffca14cd87a744c447c5fded67459c1497ebafe05350f4721ef994c3f0@mail.kernel.org>
In-Reply-To: <20261113221248.3535369-14-wusamuel@google.com>
References: <20261113221248.3535369-14-wusamuel@google.com>
Subject: Re: [PATCH bpf-next v3 3/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME ioctl to /proc/kallsyms
From: bot+bpf-ci@kernel.org
To: wusamuel@google.com,corbet@lwn.net,skhan@linuxfoundation.org,rdunlap@infradead.org,mcgrof@kernel.org,petr.pavlu@suse.com,da.gomez@kernel.org,samitolvanen@google.com,atomlin@atomlin.com,viro@zeniv.linux.org.uk,brauner@kernel.org,jack@suse.cz,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com
Cc: akpm@linux-foundation.org,pmladek@suse.com,david.laight.linux@gmail.com,wusamuel@google.com,kernel-team@android.com,linux-kernel@vger.kernel.org,linux-fsdevel@vger.kernel.org,linux-doc@vger.kernel.org,linux-modules@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,llvm@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 13 Nov 2026 22:55:50 +0000 (UTC)

--===============8280819268335858825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> kallsyms: Add KALLSYMS_QUERY_BY_NAME ioctl to /proc/kallsyms

TL;DR:
- KALLSYMS_QUERY_BY_NAME may scan BPF ksyms quadratically in one syscall with
  no cond_resched(), possibly cancelling the speedup
- module_filter may return -ENOENT for init symbols that the unfiltered query
  finds via the ftrace section

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c

[ ... ]

> +static int kallsyms_find_name_other(unsigned int sec, unsigned int *idx,
> +				    const struct kallsyms_name_query *q,
> +				    struct kallsyms_sym_match *m)
> +{

[ ... ]

> +	do {
> +		if (sec == KSYM_SEC_BPF)
> +			err = bpf_get_kallsym(*idx, &m->addr, &type, m->name);
> +		else if (sec == KSYM_SEC_KPROBE)
> +			err = kprobe_get_kallsym(*idx, &m->addr, &type, m->name);
> +		else
> +			err = ftrace_mod_get_kallsym(*idx, &m->addr, &type,
> +						     m->name, m->modname,
> +						     &exported);
> +		if (!err && !strncmp(m->name, q->name, q->cmp_len))
> +			return 0;
> +		(*idx)++;
> +	} while (!err);

Is this loop quadratic in the number of BPF ksyms, with no reschedule point?

bpf_get_kallsym() restarts from the list head on every call and walks
forward to the index:

    list_for_each_entry_rcu(ksym, &bpf_kallsyms, lnode) {
        if (it++ != symnum)
            continue;

So one ioctl that scans the BPF section without a match does n(n+1)/2 list
steps inside a single syscall.  Every exhaustive query gets there, since
even a query whose matches are all in vmlinux or modules still scans the
ftrace, BPF and kprobe sections on the call that returns -ENOENT.

The uapi comment tells users to keep calling with pos + 1 until -ENOENT,
and the libbpf user later in this series (822e9da9a9b7 "libbpf: Resolve
typeless ksyms via KALLSYMS_QUERY_BY_NAME ioctl") does this twice per
typeless extern, once for the exact name and once for the "<name>.llvm."
prefix.

With read() of /proc/kallsyms the same getter cost is spread across
syscalls, because seq_read fills at most one seq_file buffer per call.  Here
all of it lands in each call that reaches the BPF section.  On hosts with
thousands of BPF programs and trampolines, does this cancel the speedup the
commit message describes?

On kernels without ARCH_HAS_PREEMPT_LAZY, or with ARCH_NO_PREEMPT, it is
also a long run with no reschedule, whereas kallsyms_on_each_symbol() and
kallsyms_on_each_match_symbol() in this file call cond_resched().

Would a helper that walks bpf_kallsyms once from a start index be better,
or at least a cond_resched() in this loop?  ftrace_mod_get_kallsym() has the
same restart-from-the-beginning pattern, although its lists are usually
small.

[ ... ]

> +	if (karg.module_filter) {
> +		len = kallsyms_copy_str_from_user(bufs->module_filter,
> +						  sizeof(bufs->module_filter),
> +						  karg.module_filter);
> +		if (len < 0)
> +			return len;
> +		if (!strcmp(bufs->module_filter, "vmlinux")) {
> +			end_sec = KSYM_SEC_VMLINUX + 1;
> +		} else {
> +			first_sec = KSYM_SEC_MODULE;
> +			end_sec = KSYM_SEC_MODULE + 1;
> +			q.modname = bufs->module_filter;
> +		}

Can module_filter return -ENOENT for a symbol that the unfiltered query
finds in the same module?

When a module name is given, only KSYM_SEC_MODULE is searched.  But
/proc/kallsyms also lists entries for a loaded module from the ftrace
section.  ftrace_free_mem(), called from do_init_module() for the module's
init text, runs allocate_ftrace_mod_map() when any ftrace_ops is registered,
and ftrace_mod_get_kallsym() returns those entries with
strscpy(module_name, mod_map->mod->name, ...).  They appear as, for example:

    ffffffffc0a01000 T foo_init [foo]

and remain until the module is unloaded, because ftrace_release_mod() frees
the map then.  After init, mod->kallsyms has switched to core_kallsyms, so
these init symbols are no longer in the module section.  That gives:

    BY_NAME("foo_init", module_filter = NULL)  -> match, sym_module = "foo"
    BY_NAME("foo_init", module_filter = "foo") -> -ENOENT

The uapi comment says the ioctl finds a symbol "in the entries of
/proc/kallsyms", so the filtered result does not look like the unfiltered
result limited to [foo].  kallsyms_find_name_other() does not check
q->modname for the ftrace section, so extending end_sec alone would not be
enough.

Should the filtered case also search KSYM_SEC_FTRACE and skip entries whose
m->modname differs from q->modname, or should the uapi comment document that
module_filter only covers the module's own symbol table?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43520044354
--===============8280819268335858825==--
