Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5343BDC3;
	Mon, 24 Aug 2026 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582125; cv=none; b=g4SK0bcfRkpki+ooAZJfHOfiosUEyxiEQ+DvKGNFroCzBd3gXjL49QjNPKsXwOVBT+hAip8rr/YvuUhLK9T0lgv8EKHqJK4Oppt8Y2fQcsJQsmd2dMm8jbPWqVtGmIv5o8LDWS8I5unm/dte68xe3nExSTEC89z3zib58HMySyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582125; c=relaxed/simple;
	bh=NuMmPVSl+S48uTClGrt9ommsw0duYo2BohynE3KNl68=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WawhfZMltjMB5UI8He9qHWcWn/RfaG6dP7ardXacolHEhT+T7REL2prtQhVEiJPzSssjIOKiwyZKUGjzVsCqvycwo1WvxKoAkAUnotYXfBI1HLH2I2s0YfAh15/Mc2ge0WljfxnPhpVDJpKF54TQsOKAnL6a+6RV7f7vBt9Bp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqATZfzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqATZfzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A7E1F000E9;
	Mon, 24 Aug 2026 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787582124;
	bh=2WMmtJu/2UOOaE6PUR17ouJqPmznFOIm67LxVWuCpD8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aqATZfzNxf5FXN2+F7SqD1zMVgSvBeoqubFsfASBRT+iQHfBpNTUd6VrPxX9u+Hva
	 PBTGpWR/mk0KGAzC1gh4Us+VNvaQqVCOJLLOimDZukwiA2tX3nvTicJRLkInJe/DGu
	 bH9sOKXM6byNvIFVmoEfzMpOloKajOExJwKKX2L+9xtnQEMpYgzKY/wdf/UZhFcyLn
	 WZcWKvbFrH+QNiF3WlAQ6zB8sHL6fh15WhS70ObYfCpDUeWVXblK/MMq1I7tnxhtfH
	 MC3b0UkCcnb+FbdWCUmR5wXrASEHEz8eswZ76lbZ236PIODrJ7HjdHRxPoeKK5VH8E
	 F2wokgjoWcbug==
Content-Type: multipart/mixed; boundary="===============2031590001535275581=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0610a5be7e77a201576eb392be5a60e7a18f83ea3ce3d830ddb16630b853a282@mail.kernel.org>
In-Reply-To: <20260824134016.2006188-4-chenyuan_fl@163.com>
References: <20260824134016.2006188-4-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v4 3/3] bpf, arena: check range_tree_set return in arena_free_pages and arena_free_worker
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 14:35:23 +0000 (UTC)

--===============2031590001535275581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arena: check range_tree_set return in arena_free_pages and arena_free_worker
>
> arena_free_pages() and arena_free_worker() now handle range_tree_set()
> errors. arena_free_pages() aborts the free on error, and
> arena_free_worker() moves range_tree_set() before PTE clearing so that a
> failed tree update leaves the PTEs intact instead of freeing pages that
> the arena free tree does not track.
>
> Also check the range_tree_set() return value in arena_alloc_pages()'s
> error path, which restores the unpopulated tail of a partially allocated
> range; log a warning instead of silently leaking the virtual range when
> the tree update fails.
>
> range_tree_set() is failure-atomic (it pre-allocates the node before
> touching the tree), so on -ENOMEM the range stays tracked as allocated
> and the pages remain mapped and accessible. A failed free is therefore
> retryable, and arena_map_free() reclaims any retained pages at map
> destruction; aborting the free avoids clearing PTEs for pages the arena
> free tree does not track.
>
> In arena_free_worker() a failed tree update used to leave the span in
> the drained list, where the second loop would still flush TLB entries,
> zap user VMAs, and free the span itself: the free request was dropped,
> user mappings were destroyed for a free that never happened, and the
> pages stayed mapped until map destruction. Keep failed spans on
> arena->free_spans instead and retry them on a later worker run; only
> spans whose PTE clearing actually ran are flushed, zapped, and released.
>
> Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

This looks like a bug fix for error handling in the arena code introduced
in an earlier commit. Should this include a Fixes: tag pointing to:

  Fixes: dc11a4dba246 ("bpf: Recover arena kernel faults with scratch page")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32736729475
--===============2031590001535275581==--
