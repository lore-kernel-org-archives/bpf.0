Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C62E414;
	Mon, 27 Apr 2026 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315420; cv=none; b=juw6zZPQoaQue9wgFWBrB50C31WCGD1RgBd7GfRpAsKdpHqYmWTpmMH/u6boKVcQo43mpaCBx168YiBktnL0XRQDqaAqkz+oAt6vk3E3rpJbQuhOVUdP77IuGt/oO4FUf0SVlsGI43C1zlga0qYmAJVGKzctRv9xLaatPKISwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315420; c=relaxed/simple;
	bh=YNWnzejcMeSQ0wSbEGkFtXtYmtMb1yUlJsY+y1UvjAU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ORtxUFtb+daB4fQRaVnHNWPFrRmaeLUgNakEGjb/bavgVG3YByfFWQd+TiLOMlP97tnHn4JzpZsdyqXAAApx19Tq2fSxfJMHfOWgakwU1hhPKkX5YSqrKFxskQIQhGLoEe1UwdSLbf+++O5pB/F/O+Jha7ak9UFx/Wm11pgCDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etMhv87u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etMhv87u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EACEC19425;
	Mon, 27 Apr 2026 18:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777315419;
	bh=YNWnzejcMeSQ0wSbEGkFtXtYmtMb1yUlJsY+y1UvjAU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=etMhv87uUKkHkPh3fCaFz9Ef98Ni/18sb14CHkC4Ey8ZR0Xnx3RxZdzRSNlawpUEd
	 JL9I10pa2fvBYEpexT9U8w66/T/L1mwXxHBkXSZ/V9QESRgldBZg2+4zgzNH8D3cdr
	 yjqt5XEloSf0/R26B0hIj/sBmvYrPO86XexIgPrEUaBBK3SbWSV/BpQvCjpf9eSbRY
	 6RJSud2wN1zbtcTvy6rqA84Ys8tWb67JSpO8WmI/FlQMq+chGtwdeSjXFlvPOGtsaf
	 7UeMZCZUjjYYidleGqFPZeA8kXIM2TdZEmTvjrQApwYA+cQRKIVLKCHLzwE4cLk+f5
	 AY8OyfGGH05ow==
Content-Type: multipart/mixed; boundary="===============1942307117977074095=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <af50d188f6bc2de81fe3c321b26a645a9425ba9f2644cb6f8525d5bb637385f9@mail.kernel.org>
In-Reply-To: <20260427165906.84420-2-kaitao.cheng@linux.dev>
References: <20260427165906.84420-2-kaitao.cheng@linux.dev>
Subject: Re: [PATCH bpf-next v10 1/8] bpf: refactor __bpf_list_del to take list node pointer
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Apr 2026 18:43:39 +0000 (UTC)

--===============1942307117977074095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2575,12 +2577,16 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
>
>  __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
>  {
> -	return __bpf_list_del(head, false);
> +	struct list_head *h = (void *)head;
> +
> +	return __bpf_list_del(head, h->next);
>  }

This addresses an unaddressed review comment from Emil Tsalapatis in v8.
The code reads h->next before __bpf_list_del checks if the list is
initialized. If the list is uninitialized (h->next is NULL), a NULL pointer
is passed to __bpf_list_del.

While the function will eventually initialize the list and return NULL without
dereferencing the NULL pointer:

kernel/bpf/helpers.c:__bpf_list_del() {
	if (unlikely(!h->next)) {
		INIT_LIST_HEAD(h);
		return NULL;
	}
	...
}

this is counterintuitive - passing a potentially garbage value that is later
ignored.

Emil suggested moving the init check logic into the top-level kfuncs
(bpf_list_pop_front/bpf_list_pop_back) to ensure the list_head passed to
__bpf_list_del is always valid. You can also just init the list and return
NULL in that case - we know it's empty.

The same issue applies to bpf_list_pop_back() which reads h->prev before
the initialization check.

Original comment from Emil Tsalapatis (Thu, 19 Mar 2026 12:17:50 -0400):
https://lore.kernel.org/bpf/DH6W7K2SLPYB.PCO7FQ6CR1YZ@etsalapatis.com/

"The new code reads n _before_ we check if the list is initialized. So the n
we are passing from the caller may well be NULL. However, __bpf_list_del()
will in that case now a) call INIT_LIST_HEAD(() to properly set up prev/next,
b) call list_empty() on the newly initialized list and exit without ever
reading the NULL passed by the caller.

This is kind of counterintuitive: We are passing essentially a garbage value
to __bpf_list_del that we thankfully end upi ignoring. Can you move the init
check logic into the top-level kfuncs to make sure the list_head we're passing
to __bpf_list_del is always valid? You can also just init the list and return
NULL in that case - we know it's empty."

This issue remains unaddressed in v10.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25009536772
--===============1942307117977074095==--
