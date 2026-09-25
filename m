Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415A50C2A0;
	Fri, 25 Sep 2026 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379287; cv=none; b=kB0JgAclM+5TKd1E6qbxM1IWsI+SCdA1d2MwL28fBy1U8ftbr7+vaX9XtqGp9G53lfiPnOt5mWr3MJ3sh4f0dx1wV3X06HNUhc/WBAQWxzrPMCVokOt8iW5/udNqfKhQfHKArCr6AHZxGB+G1nYS0BLQmSBDnNyQJN4IKkNUP2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379287; c=relaxed/simple;
	bh=CcMrxf6lrryW/pFRFWK9ccgGvsFilRUpEYa/K1cJVUc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cHJ0SMebkvG88wXY/8MG4+kYVhJby3gqgxVlD5ggrjNXLufwVKst+kiCzo6LeySVK7oKjRtbT1ExaqqOd0CEjH/SCYok7T/CnRL8HxfLS6rfsmkTtM/WictSasAd1fyo0fpVncaLzGxBd34cUTDRECjX495fqT+GKTO+E/V0id0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mexv/lT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mexv/lT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285431F00893;
	Fri, 25 Sep 2026 23:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379285;
	bh=n5eEs5F9HiUQD8VsPqDIqa3bfkFMV+hAZeJ9L9iCbyw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mexv/lT/kvyKBi37+74iahAYNURidHUayWMA5v9Uys+1C9jGu+BL8ntRuoqkrPnDz
	 o+JaFQQ4zcgG/ne5d4Z8PpMbm4dkm6HG17rwSyDYlOcE6xO8wm/DboBPSzQoIpaWDH
	 fnBVcv0GHGQ8C9rjGC26dy8C2JARZ+GGlugOhXBvxb2hUxcx7bqZ2XyW7I+IYnHOjl
	 GuAkNK0wX4rjGlLDtjKyfbUQikiLiNuIDq1Toq2j8mz2uFbwC4n4Ke6fc+8McbpzrX
	 +ppOvD7xBlt3hNIYEhDfWu9INcrFMt+VEz0UYmyPYYBHuEeAN0bqhaKqtV3mwHs8y0
	 EgpW1HcDke27g==
Content-Type: multipart/mixed; boundary="===============4335689557760220973=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6190890bf058dd560c895a769a114cf36530d1b8a9521fb55434566217882eb4@mail.kernel.org>
In-Reply-To: <20260925224229.1850-6-wanjay@amazon.com>
References: <20260925224229.1850-6-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next v3 5/9] bpf: defer vmlinux kfunc and struct_ops registrations
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,mcgrof@kernel.org,petr.pavlu@suse.com,samitolvanen@google.com,linux-modules@vger.kernel.org,ojeda@kernel.org,rust-for-linux@vger.kernel.org,arnd@arndb.de,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 23:34:44 +0000 (UTC)

--===============4335689557760220973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1dd7f9650ae8..207954b5754a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> +#ifdef BTF_MODULE_NOTIFIER
> +/*
> + * The queue has its own lock: it is drained under btf_vmlinux_lock, and
> + * btf_module_mutex must not nest inside that (purge_cand_cache() takes
> + * cand_cache_mutex under btf_module_mutex, and CO-RE fetches the vmlinux
> + * BTF under cand_cache_mutex).
> + */
> +static DEFINE_MUTEX(btf_vmlinux_regs_mutex);

Does the lock ordering explanation match the actual code?  Looking at
the earlier patch 806240f10744 ("bpf: fetch the vmlinux BTF where
kernel types enter a program"), both CO-RE callers now call
bpf_get_btf_vmlinux() before taking cand_cache_mutex:

kernel/bpf/btf.c:bpf_core_apply() {
	/* candidates are kernel types: load the vmlinux BTF, outside the mutex */
	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux())) {
	...
	mutex_lock(&cand_cache_mutex);

and bpf_core_find_cands() uses only bpf_peek_btf_vmlinux() under the
mutex, which takes no lock.  Its comment reads "Callers fetch the
vmlinux BTF before taking cand_cache_mutex."

So the btf_vmlinux_lock -> btf_module_mutex -> cand_cache_mutex ->
btf_vmlinux_lock cycle described here does not exist in this tree.

The separate lock is fine. Could the comment and commit message explain
what actually prevents btf_module_mutex from nesting under
btf_vmlinux_lock, or point to what the next patch adds that would
create that constraint?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36198628965
--===============4335689557760220973==--
