Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC849B209;
	Fri, 25 Sep 2026 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342441; cv=none; b=drUD+cdOzc7BXE72tY9LZU5/+JK9XWoh4ux5Q5iOrBwmz6+U1/uGkalUU0Cq36k8TdRnNkhjhTvfiEFoXU+DNStSruAzFaWELbL7V2TaRFXF89Iz7acBnzxxXX8G2myQRJcUmaOCufCol1X9jQrDIB77FmdlqHU4TjagU2UlK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342441; c=relaxed/simple;
	bh=F/OhDoVZ2kxMDJVc7u5XfigG07bMhBj9po7CRptv/S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuCHc5Mlh7j6ovMsIT7nGAeiIkp+jaezwaQZleQkYB2elrjk69ygK9CTMBueZ5ci088rKim5PebsU3D3dZ/1zj+vnMwB5gsdLjk+tRuhG+YpARIMpc6SNJbWjwjnpGEzzO/uLylfGv/2KqrYKfaPXy5r9l9rsxE8cV7LQckiZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/uR9vXh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/uR9vXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A261F000FF;
	Fri, 25 Sep 2026 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790342437;
	bh=NR172yVIih/zfu1yzA8kSDN8MpChBZ8zgP9NIckvtHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a/uR9vXhx9AxJeRoIXw2P+Xo6eJbkLGU0etqDWBpGV6MBGmZwlfcngoU3R65Wk3WS
	 bd8L7pSd2vcI1dis8rUXnt4RbrloYsbagJ+yfzBE7KCHCp3er4QWjxUiX6Hn3pwmEW
	 UqN4/BCOWololLqxWTfKi5vfkHJjQJ4h4N6A2mArBTp4v8vQlwCyCfl7KPFLOD95IA
	 fOE5cVENbX9+0ZBd8PGw6PXoFkC3errgcJRbeWIAdb5wEk8hWH+D3ikmwjuHONzroA
	 9X6snFPs4dIFUezVArlndAMhAtJRvm3s0VkU6oNc+KQmmxw5Y+Bv3mp2Tw4IhBy+Rd
	 g44fFDKG+cCEA==
Date: Fri, 25 Sep 2026 14:20:33 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam@infradead.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/nommu: Reject wrapping ranges in access_remote_vm()
Message-ID: <arZzn0bwWqp7xTE5@gremlin>
References: <20260909064231.18693-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909064231.18693-1-tasos.papagiannnis@gmail.com>

BTW always feel free to nag if you're not getting review! Something things
get missed. (Though I'd say wait at least a couple weeks before doing
that!)

On Wed, Sep 09, 2026 at 09:42:31AM +0300, Anastasios Papagiannis wrote:
> The NOMMU implementation of access_process_vm() rejects address ranges
> whose end wraps around, but access_remote_vm() bypasses this check even
> though both functions delegate to __access_remote_vm().
>
> Move the wraparound check into __access_remote_vm() so it applies to
> both entry points.
>
> This is originally reported in [1].
>
> [1] https://lore.kernel.org/bpf/4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org/

Probably better to drop this big and make this a Link: tag.

>
> Fixes: f55f199b7d76 ("NOMMU: implement access_remote_vm")

Cc: stable I think?

> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

Seems reasonable to me! So:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/nommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 498e01ee40b0..ed44510e3770 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1674,6 +1674,9 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  	struct vm_area_struct *vma;
>  	int write = gup_flags & FOLL_WRITE;
>
> +	if (addr + len < addr)
> +		return 0;
> +
>  	if (mmap_read_lock_killable(mm))
>  		return 0;
>
> @@ -1727,9 +1730,6 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, in
>  {
>  	struct mm_struct *mm;
>
> -	if (addr + len < addr)
> -		return 0;
> -
>  	mm = get_task_mm(tsk);
>  	if (!mm)
>  		return 0;
>
> base-commit: 0d9ff90a5422cc7509258aaaba1e7481df4d332a
> --
> 2.55.0
>

--
Cheers, Lorenzo
