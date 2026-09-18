Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8A3BB138;
	Fri, 18 Sep 2026 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742199; cv=none; b=Ka/y1FHvE6MxB/5RoMKCHQFrQ25jZC244UW3/151CuQMoNoeouNk8WZmOVj98raVtN0fuAHLlVnoVAJH6ZE61enFgfOkV6P+aUpH+bZ2bdIhDuHkNNx2wtMtR1EnoECA6Y5rqTWevFzwI5Ga7RXyGJWPRmhzaNRtGqg60iwvgZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742199; c=relaxed/simple;
	bh=XRKgRLZGoiA4AKB7jnw/P9eV3f9O4BqfOKxhqxlfDY4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qUi3vr20kuaoGZM3q2nguNElra+7bEV1pGqw3a9e4UhXDJpSBVBlRLeQKvEvvixnId6mVOrHgpthhKindYKmIfT3k2djXvKML568yPMkU5Iy8PnJ0x2ltik9yoqr20C9lfCy5p4BZ/OfzRrujZKkIwrVslAv7qO/Q+ziKociur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPkbxp3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPkbxp3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FC31F000FF;
	Fri, 18 Sep 2026 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742197;
	bh=WjVfs8qTNBrB/D3OacnguDihU7OuPlCzMGTvdv4MHYA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UPkbxp3fGuG6BMe9mZzqqiwcubZg5zyteypZqxXXPpDhwC0nFiPtqtHae+e32h1SI
	 6lZ88BHqer2H/xlCxUmzohKbUFQXI03uZ2GFq6micz8WLcAEty7DyCpKuVst7xyiWZ
	 U9uWFnorF4uodW/b2Ui4qLZFW8Tn8iPjXXOVaR2UqXhdbmQXGr2U+IA1MRSv0ghK+m
	 jUj2yaa6tzk9HuAGH99o/7ViPHuDgg4+tZ624Ht2+6w4UpMWLloBMka3Ebf8cAbtp9
	 oThlalCpeYgRphdQzqZKRDic/6BZO5QWvJBxJtaSwcOik9ca/qgm5q7qxIr9sWyQSz
	 rcUrJnoBcQTfw==
Content-Type: multipart/mixed; boundary="===============0526606943701778729=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2b6908175c7fee960d1db94820dd61d11ba182feb41d5aa76b00cf059d4d3671@mail.kernel.org>
In-Reply-To: <20260918131757.42802-2-tasos.papagiannnis@gmail.com>
References: <20260918131757.42802-2-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v9 1/5] mm: Add copy_remote_mm_str()
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,david@kernel.org,akpm@linux-foundation.org,andrii@kernel.org,ast@kernel.org,brauner@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kpsingh@kernel.org,ljs@kernel.org,matt@bobrowski.net,memxor@gmail.com,song@kernel.org,sun.jian.kdev@gmail.com,utilityemal77@gmail.com,viro@zeniv.linux.org.uk,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 14:36:36 +0000 (UTC)

--===============0526606943701778729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/util.c b/mm/util.c
> index bf0513d1d3d08..75c0fc2061aa0 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1061,6 +1061,66 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>  	return res;
>  }
>
> +/**
> + * copy_remote_mm_str - copy a string from a remote address space.
> + * @mm:         the remote address space
> + * @addr:       start address to read from
> + * @buf:        destination buffer
> + * @len:        number of bytes to copy
> + * @gup_flags:  flags modifying lookup behaviour
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destination),
> + * not including the trailing NUL. If @len is zero, return 0 without accessing
> + * @buf. Otherwise, @buf is always NUL-terminated. On any error, return
> + * -EFAULT.
> + */
> +int copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +		void *buf, int len, unsigned int gup_flags)
> +{
> +	if (unlikely(len == 0))
> +		return 0;
> +
> +	return __copy_remote_mm_str(mm, addr, buf, len, gup_flags);
> +}

The documentation says "The caller must hold a reference on @mm" but
doesn't specify which reference count. Should this clarify that the
caller needs an mm_users reference (mmget/mmget_not_zero) rather than
just mm_count (mmgrab)?

The implementation takes mmap_read_lock_killable(mm) and accesses the
address space through vma_lookup() and get_user_page_vma_remote() in
__copy_remote_mm_str():

mm/memory.c:__copy_remote_mm_str() {
    ...
    if (mmap_read_lock_killable(mm))
        return -EFAULT;

    addr = untagged_addr_remote(mm, addr);
    ...
    while (len) {
        ...
        vma = vma_lookup(mm, addr);
        ...
        ret = get_user_page_vma_remote(mm, addr, gup_flags, &page, &vma);
        ...
    }
    ...
}

An mmgrab()-only caller would race with address space teardown in
__mmput()->exit_mmap() once mm_users reaches zero.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35351393336
--===============0526606943701778729==--
