Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C938D400;
	Wed, 13 May 2026 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716554; cv=none; b=r+z9Bg6mE4ZTNIjlsfQNx+mkMn06MS2N8QH6xbPx32YlvLavLBe+EJfSWpPh6AsMbXJquU9A6UX3a+bzauTkJlgfyxgnhqxVZ4gfP7MKpKFDAvQqxQoV2MSSmbcq2lMnc74RtCMOaegCKxr8BTMnJ8+i8gG5QxGn65uP9ZdLyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716554; c=relaxed/simple;
	bh=wji2MdgcTyHZfE/7Bjx5jqsRridfdB/rTzrCaSZVFQ8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=C6VQZcQg1H9J1gHBsStcW706QW48HWcwz/kYA36reUPT7jpHNQBeNA/zizdXcO3hiLhBx6VDgjdq0R3ruykLWXoyADXHgVAUw29zZKooWU/7mEp+NaH9d34oYbzgXKhIHSckZnMSIKti4jwRZfnqUz1tXwQHvYUaKswNPkAY2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBkS+qDm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBkS+qDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE921C19425;
	Wed, 13 May 2026 23:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778716554;
	bh=wji2MdgcTyHZfE/7Bjx5jqsRridfdB/rTzrCaSZVFQ8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rBkS+qDmpKZ5HUKCjGWZTHBSgF6aVQVPJPQb6t7GQcnjJEXCviq7cx4erW6TiVBoa
	 3TQfeG/KYQEuLMpP0kKlY0Qbagvfh3NRsUwMp5iG3zeiJp/5Sl9Lbt1P/1jQMVmdto
	 kP8WTxeBFo4GbnDC+wc6wTaUHNZihGstEV9wII1aFKEj6fTj+cAqxD9MT50FA5cFtw
	 cbqNg53+7agjVkewQQwFrGTbwEix+/o3N8BcZQtN7oGm1Wsev3X54DAkEvLDq2TTua
	 IbBd0TXS6ich/xYX2gwM4gsMGpuMGSRAQeuBd/8mzb+oIr8OZ8jQnaLEKMo29mhJRh
	 Bank9P2ULxJTA==
Content-Type: multipart/mixed; boundary="===============5681978247099584604=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a183ee082f0d56ee7664ad0d13cf7b7169ed2b6da743cb332f619fb360689ada@mail.kernel.org>
In-Reply-To: <20260513232055.1681859-1-cmllamas@google.com>
References: <20260513232055.1681859-1-cmllamas@google.com>
Subject: Re: [PATCH] libbpf: fix UAF in strset__add_str()
From: bot+bpf-ci@kernel.org
To: cmllamas@google.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com
Cc: kernel-team@android.com,linux-kernel@vger.kernel.org,cmllamas@google.com,andriin@fb.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 13 May 2026 23:55:53 +0000 (UTC)

--===============5681978247099584604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> strset_add_str_mem() might reallocate the strset data buffer in order to
> accommodate the provided string 's'. However, if 's' points to a string
> already present in the buffer, it becomes dangling after the realloc.
> This leads to a use-after-free when attempting to memcpy() the string
> into the new buffer.
>
> One scenario that triggers this problematic path is when resolve_btfids
> attempts to patch kfunc prototypes using existing BTF parameter names:
>
>  | resolve_btfids: function bpf_list_push_back_impl already exists in BTF
>  | Segmentation fault (core dumped)
>
> Compiling resolve_btfids with fsanitize=address generates a detailed
> report of the UAF:
>
>  | =================================================================
>  | ERROR: AddressSanitizer: heap-use-after-free on address 0x7f4c4a500bd4
>  | ==1507892==ERROR: AddressSanitizer: heap-use-after-free on address 0x7f4c4a500bd4 at pc 0x55d25155a2a8 bp 0x7ffcef879060 sp 0x7ffcef878818
>  | READ of size 5 at 0x7f4c4a500bd4 thread T0
>  |     #0 0x55d25155a2a7 in memcpy (tools/bpf/resolve_btfids/resolve_btfids+0xcf2a7)
>  |     #1 0x55d2515d708e in strset__add_str tools/lib/bpf/strset.c:162:2
>  |     #2 0x55d2515c730b in btf__add_str tools/lib/bpf/btf.c:2109:8
>  |     #3 0x55d2515c9020 in btf__add_func_param tools/lib/bpf/btf.c:3108:14
>  |     #4 0x55d25159f0b5 in process_kfunc_with_implicit_args tools/bpf/resolve_btfids/main.c:1196:9
>  |     #5 0x55d25159e004 in btf2btf tools/bpf/resolve_btfids/main.c:1229:9
>  |     #6 0x55d25159cee7 in main tools/bpf/resolve_btfids/main.c:1535:6
>  |     #7 0x7f4c78e29f76 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>  |     #8 0x7f4c78e2a026 in __libc_start_main csu/../csu/libc-start.c:360:3
>  |     #9 0x55d2514bb860 in _start (tools/bpf/resolve_btfids/resolve_btfids+0x30860)
>  |
>  | 0x7f4c4a500bd4 is located 13268 bytes inside of 2829000-byte region [0x7f4c4a4fd800,0x7f4c4a7b02c8)
>  | freed by thread T0 here:
>  |     #0 0x55d25155b700 in realloc (tools/bpf/resolve_btfids/resolve_btfids+0xd0700)
>  |     #1 0x55d2515c426c in libbpf_reallocarray tools/lib/bpf/./libbpf_internal.h:220:9
>  |     #2 0x55d2515c426c in libbpf_add_mem tools/lib/bpf/btf.c:224:13
>  |
>  | previously allocated by thread T0 here:
>  |     #0 0x55d25155b2e3 in malloc (tools/bpf/resolve_btfids/resolve_btfids+0xd02e3)
>  |     #1 0x55d2515d6e7d in strset__new tools/lib/bpf/strset.c:58:20
>
> While resolve_btfids could be refactored to avoid this call path, let's
> instead fix this issue at the source in strset__add_str() and avoid
> similar scenarios. Let's simply check whether 's' is already within the
> strset data buffer boundaries, and return the offset directly if so.
>
> Fixes: 919d2b1dbb07 ("libbpf: Allow modification of BTF and add btf__add_str API")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

The existing Fixes: tag points to commit 919d2b1dbb07, but the bug is
actually in strset__add_str() which was introduced by commit 90d76d3ececc
("libbpf: Extract internal set-of-strings datastructure APIs").

While the vulnerable pattern originated in btf__add_str() from 919d2b1dbb07,
the code being fixed resides in tools/lib/bpf/strset.c which was created by
90d76d3ececc when the string set functionality was extracted into a separate
module.

Should this use:

  Fixes: 90d76d3ececc ("libbpf: Extract internal set-of-strings datastructure APIs")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25832614669
--===============5681978247099584604==--
