Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50038236F;
	Wed, 12 Aug 2026 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502572; cv=none; b=c0Gxbl6V54SorSlaY96XX6YJWJP38qGkiC3RdT2oo45+ECgE/T2HgP1qtL1oZcdd3GfDCWrRa2vgQEZCIVlC8RWfvoVyZhc/Q1a8QZErwhUnamvPZSysfEAUUxRTRQ0JBGh5Is4SQUXURuS73WcGCd/OLFuFoe7McNt1KDquybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502572; c=relaxed/simple;
	bh=gZe4ioSSoKe0VS+oOT6mUzyyl61rL0y7ZiYWmD86WYo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m6CEQI/x09E/cTIxxkavMguyPvDL9MIxlI8L7UvwKGy2bVqR4SEzvbPucB8LxseH+otKydKYIkZ0GaPXzc5TRa5SdZ17aLB9WIkZ8aXAFeSoc9ECrhd9BDJmiOUUt7D1YVKqaxI+NojN4SsWT8YaskyffKS5PDFuWbdzdw1LIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1UzmOTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1UzmOTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F08B1F00A3A;
	Wed, 12 Aug 2026 02:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786502570;
	bh=0E4itMYrnMg6HZu7tfeJC80MNuIdYagzenGxwnL6/JI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=U1UzmOTWQqRHdNMsnhgOkDyt74SxPoeRNIddEO2y833uftnuO3W/YJjoo1kHakYd4
	 yXXALJBcv0Xl8FPzcoy3LLDhw1g9wU/STPqu+Sb7j12aBPCcTcZqtlnF6dm0UOtI7b
	 pRD4zj/oZ5pkGkV51uu+kq8r6Sd2AK+vNtRC+CDPw2wQULHHzwU1cJqIE7ptwd+YOz
	 0C13g4CIWwusVXH76pSIjLJCCRLm5+A22oXtBoGxB8cW0/3k+wvjmGtrE2os5zLUgv
	 AtqOY+JUdeI2EW4eYCvpdTqMWufbk+rHwi6mBgxzfuygEq7M/S7imv6qq3pUOL5tbs
	 5xd278rdUCNeA==
Content-Type: multipart/mixed; boundary="===============6214243008240976249=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a248ad0a8b239160d3576f7cb38793ef025319eb72e8ed58d60ce11038136748@mail.kernel.org>
In-Reply-To: <20260807134209.3794735-2-tushar.vyavahare@intel.com>
References: <20260807134209.3794735-2-tushar.vyavahare@intel.com>
Subject: Re: [PATCH net-next 1/5] selftests/xsk: add UMEM users refcount and centralize socket teardown
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com,andrii@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 02:42:49 +0000 (UTC)

--===============6214243008240976249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c

[ ... ]

> @@ -1701,12 +1717,71 @@ void *worker_testapp_validate_rx(void *arg)
>  	pthread_exit(NULL);
>  }
>
> -static void testapp_clean_xsk_umem(struct ifobject *ifobj)
> +void xsk_delete_socket(struct xsk_socket_info *xsk)
>  {
> -	struct xsk_umem_info *umem = ifobj->xsk->umem;
> +	struct xsk_umem_info *umem;
> +
> +	/*
> +	 * Callers must serialize teardown for a given xsk/umem pair.
> +	 * This helper does refcount-based lifetime management only.
> +	 */
> +	if (!xsk)
> +		return;
>
> -	xsk_umem__delete(umem->umem);
> -	munmap(umem->buffer, umem->mmap_size);
> +	umem = xsk->umem;
> +	if (!umem)
> +		return;
> +
> +	/* Delete the socket handle when available, then drop UMEM reference. */
> +	if (xsk->xsk)
> +		xsk_socket__delete(xsk->xsk);
> +	xsk->xsk = NULL;
> +
> +	/* Mark this socket as cleaned up to prevent double-decrement */
> +	xsk->umem = NULL;
> +
> +	/*
> +	 * Teardown may walk the full xsk array, including slots that never completed setup but
> +	 * still carry a preinitialized umem pointer. After a partial-setup rollback, the last UMEM
> +	 * ref may already be dropped.
> +	 */
> +	if (!refcount_read(&umem->users))
> +		return;
> +
> +	/* Always decrement refcount for this socket's UMEM reference */

This isn't a bug, but does this comment still describe the code below it?
The early return just above it skips the decrement when users is already
zero, and three lines down the comment explains why that can happen, so
"Always" might not be the right word here.

Also, could the other comment blocks be trimmed? The four comments in this
roughly 50-line function mostly restate what the line below them does
("Callers must serialize" above an if (!xsk) check, "Delete the socket
handle when available", "Mark this socket as cleaned up"), and the
neighbouring helpers in this file carry no comments at all. The one
non-obvious point (why a slot can be reached with users already at 0)
might be enough on its own.

> +	if (refcount_dec_and_test(&umem->users)) {
> +		if (umem->umem) {
> +			int err = xsk_umem__delete(umem->umem);
> +
> +			if (err)
> +				ksft_print_msg("xsk_umem__delete failed: %d (umem still busy?)\n",
> +					       err);
> +		}
> +		if (umem->buffer && umem->mmap_size)
> +			munmap(umem->buffer, umem->mmap_size);
> +		umem->umem = NULL;
> +		umem->buffer = NULL;
> +		umem->mmap_size = 0;
> +	}
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c

[ ... ]

> @@ -117,12 +117,13 @@ static void __exit_with_error(int error, const char *file, const char *func, int
>
>  #define exit_with_error(error) __exit_with_error(error, __FILE__, __func__, __LINE__)
>
> -static bool ifobj_zc_avail(struct ifobject *ifobject)
> +static bool ifobj_zc_avail(struct ifobject *ifobj)
>  {
>  	size_t umem_sz = DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE;
>  	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> -	struct xsk_socket_info *xsk;
> -	struct xsk_umem_info *umem;
> +	struct xsk_socket_info xsk = {};
> +	struct xsk_umem_info umem_info = {};
> +	struct xsk_umem_info *umem = &umem_info;

This isn't a bug, but would declaring struct xsk_umem_info umem = {}; and
passing &umem directly read a bit more plainly here? The conversion to
stack allocation introduces umem_info for the storage and umem as a
pointer alias on the next line, but the alias is only used four times
(umem->mmap_size, umem->frame_size, and passing umem to two functions),
three of which the patch already rewrites. This struct T *p = &local;
pattern doesn't appear anywhere else in xskxceiver.c, test_xsk.c, or
xsk.c, so it's not following a local idiom.

>  	bool zc_avail = false;
>  	void *bufs;
>  	int ret;

[ ... ]

Commit message question:

>     selftests/xsk: add UMEM users refcount and centralize socket teardown
>
>     Shared-UMEM lifetime can be torn down from multiple setup and cleanup
>     paths. Mixing manual UMEM free/unmap in one path with helper-based
>     teardown in others makes ownership easier to violate and can leak or
>     double-release UMEM during error handling.
>
>     Track UMEM ownership with a refcount_t users field. Initialize it to 1
>     in xsk_configure_umem() and increment it for each additional shared
>     socket. Introduce xsk_delete_socket() as the single teardown helper: it
>     deletes the socket handle, clears state to prevent double-decrement, and
>     releases the UMEM when the last reference drops.
>
>     Replace testapp_clean_xsk_umem(), clean_sockets(), and clean_umem() with
>     xsk_delete_socket_batch() and xsk_delete_all_ifobj_sockets() wrappers at
>     all call sites.

This isn't a bug, but would it help to explain why this refactor is
needed rather than walking through what the diff does? Two of the three
paragraphs describe which function sets the counter to 1, which helper is
introduced, and which three helpers are replaced by which two wrappers.
The opening paragraph states that mixing manual and helper-based teardown
"can leak or double-release UMEM during error handling" but doesn't name
a concrete path, and there's no Fixes: tag, so it's not clear whether an
existing bug is being fixed or the change is preparatory for the
shared-UMEM tests added later in the series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31554903166
--===============6214243008240976249==--
