Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716673;
	b=kx/RDaDHMkh0zcII4jwQIAVrP2fKJDke3yqlMN2HdbUggpyNPUwBW29V1WJimrxkLota
	 gzYt7HQcLKsSYr8XDk7dRfnyd3S1eipwkzbpVGX0dl3kZ8NbHOTYWkjKWpCaWjcEM5rXW
	 l1JrS6MENx2aT9erdLKM68ut76mRcI2YO/FjRLFsfK4JI0Hdsub+ARvEFUNVEFPlSZaCW
	 TSg6BU1+rbBPJG5jfWVh8ehKkbrYaUOpZ1hXx8lSKi59vP4sIBwSdamM1dS0ts/f7H/WC
	 KhlxgJPIu5zD3A5s+6bOCiWAodsNKzIDy1L2Yeooh/T8ABv2Q1yxWPk74EnS8KAsamQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716673;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=kyCno0YF2wqPIAAdsCxncdDRe1RSuPSRu0+FBtFLEGY=;
	b=A24VUiBr5WkJj8wkH1GCOAxLe6m/lxHqy630+M8gJ4EOmMzpxaqha2+AGYx3WW+slhB7
	 jYbVM75U735GnRervhCkMfNsqEsifSV8NVJ6z4lnghICHVVuGikiih7Q0U7goaTwfSHzO
	 9rm5Az9Vn83Q/7eDQ2swgWTavDUMtg4NhDjJTS6z67xdPI1WmGFHQlNWLoxX+8x7s6ELM
	 qnc+9jQmklQfks5QeTfk4Ggz/3YCf91nvfbK9ct3H1dfda/84J5M4XpaB3sYP0KnoMzQJ
	 APTaAwWjfexlk6vxG8pVe16dIucqE/z28qZHFvARQj3Lq6ei7pUjZjoiQ/ZA7imElLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bfr+NFYS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD5606A319;
	Fri, 23 Oct 2026 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bfr+NFYS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA9A1F01825;
	Fri, 23 Oct 2026 00:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792716672;
	bh=kyCno0YF2wqPIAAdsCxncdDRe1RSuPSRu0+FBtFLEGY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Bfr+NFYSSVTbTN85zYznM5T9GO58XFRdN3RX73ZriInUEN3YUL4z/fV204y1WsVve
	 TU0CDIB7YmyU69/VrC4bHlfxn7AbM1ZyB88WBBgMl3tReLxckSa7mpg7/TFcr1qZ7h
	 2qhQMKtmEbDK+qOOf6lFz140zdjYYpQjj57sVr9wn8iyAw949oT6yOA7nYCq/6Uv3p
	 vWc1erP/dTmXjFGnM4K8p5QcGzMtvqEvnlgRAO8CWiRV+Q/JkNr8FydvnXamf79eF8
	 1AwEN/PfRmAD2HYiE9mMn+TGRD2FWLns5R7nQGuzCipyowmhmnnKrlqSsRdb3JGghu
	 8D5QzM1Eis/ww==
Content-Type: multipart/mixed; boundary="===============8304986485767963012=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a925a7a8362e8e9aa0270c2b252aedcc10694857db29c31f66d6f7c5ba89ac08@mail.kernel.org>
In-Reply-To: <20261023001603.560210-9-wusamuel@google.com>
References: <20261023001603.560210-9-wusamuel@google.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
From: bot+bpf-ci@kernel.org
To: wusamuel@google.com,corbet@lwn.net,skhan@linuxfoundation.org,rdunlap@infradead.org,viro@zeniv.linux.org.uk,brauner@kernel.org,jack@suse.cz,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com
Cc: wusamuel@google.com,kernel-team@android.com,linux-kernel@vger.kernel.org,linux-fsdevel@vger.kernel.org,linux-doc@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,llvm@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 23 Oct 2026 00:51:11 +0000 (UTC)

--===============8304986485767963012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms

TL;DR: KALLSYMS_QUERY_BY_ADDR may return BPF JIT symbol names that
bpf_jit_kallsyms=0 or bpf_jit_harden hide in /proc/kallsyms, possibly leaking
JIT image locations to openers with show_value.

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index aec2f06858af..7caaf3e421c7 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c

[ ... ]

> @@ -922,11 +923,142 @@ const char *kdb_walk_kallsyms(loff_t *pos)

[ ... ]

> +static int do_kallsyms_query(struct kallsym_iter *iter, void __user *uarg)
> +{

[ ... ]

> +
> +	/*
> +	 * The text interface shows zero addresses to openers without permission.
> +	 * A zeroed point query result is useless (and an address-to-symbol query
> +	 * would leak KASLR), so fail instead.
> +	 */
> +	if (!iter->show_value)

[ ... ]

> +	case KALLSYMS_QUERY_BY_ADDR:
> +		if (!karg.sym_name_size)
> +			return -EINVAL;
> +		addr = karg.sym_addr;
> +		/* Reject addresses that do not fit in unsigned long (32-bit). */
> +		if (addr != karg.sym_addr)
> +			return -ENOENT;
> +		if (!kallsyms_lookup(addr, NULL, NULL, NULL, namebuf))
> +			return -ENOENT;

Can KALLSYMS_QUERY_BY_ADDR hand out BPF JIT symbol names that /proc/kallsyms
is configured to hide?

kallsyms_lookup() reaches kallsyms_lookup_buildid() and falls through to
bpf_address_lookup() -> bpf_ksym_find(), which searches bpf_tree without any
policy check.  bpf_ksym_add() always inserts into bpf_tree
(bpf_prog_kallsyms_add() only requires bpf_prog_kallsyms_candidate() and
CAP_BPF).

The text listing of the same file goes through get_ksymbol_bpf() ->
bpf_get_kallsym(), which starts with:

    if (!bpf_jit_kallsyms_enabled())
        return ret;

bpf_jit_kallsyms_enabled() returns false when net.core.bpf_jit_harden is
non-zero or net.core.bpf_jit_kallsyms is 0.  bpf_get_kallsym() is the only
caller of bpf_jit_kallsyms_enabled() in the tree, so hiding the names in
/proc/kallsyms is now the only thing these sysctls do.  Commit af91acbc6299
("bpf: Fix bpf jit kallsym access") says so directly:

    It should only skip addr->name resolution for 'cat /proc/kallsyms'.
    That's what bpf_jit_kallsyms and bpf_jit_harden protect.

With this patch, a process whose open of /proc/kallsyms has show_value set
can call ioctl(KALLSYMS_QUERY) with query_flags=KALLSYMS_QUERY_BY_ADDR and
get back names like bpf_prog_<tag>_<name> (plus trampolines, dispatchers and
__cfi_ prefixes) for addresses inside JIT images.  That gives it an
address->name oracle for finding JIT image locations, which these sysctls
are meant to withhold from /proc/kallsyms.

The comment above the show_value check argues for matching the text
interface ("The text interface shows zero addresses to openers without
permission ... an address-to-symbol query would leak KASLR, so fail
instead"), but the code applies only the show_value gate and skips the
BPF-specific gate.  The uapi comment and the commit message both say
BY_ADDR covers "BPF JIT images", but neither mentions bpf_jit_kallsyms or
bpf_jit_harden.

This is reachable whenever CONFIG_KALLSYMS and CONFIG_BPF_JIT are enabled, a
JITed program loaded with CAP_BPF exists, and either sysctl hides BPF
symbols.  No later commit in the series changes kernel/ code to address
this.

Should the BY_ADDR path return -ENOENT when kallsyms_lookup() resolves to a
BPF address (for example, is_bpf_text_address(addr) is true and the address
is not in vmlinux or a module) unless bpf_jit_kallsyms_enabled() is true?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39878338337
--===============8304986485767963012==--
