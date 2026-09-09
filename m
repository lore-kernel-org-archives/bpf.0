Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712E3CC9EA;
	Wed,  9 Sep 2026 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938023; cv=none; b=Nabs996vYBCMgVnWqY1LV906nfPyY65F/NYswLXRx8O3Cg1bi16ePIps1UmxomAxr/mAYUw1UILwSa58ovcqtSiH8KBLK0HemaKU79bwRpBqiXOIWK/OlaHpU0CWlib04bHxPCUw+iQmpYZVUstl8oV3VvEjHP0c5AydpTfZSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938023; c=relaxed/simple;
	bh=Ssk9mUUzos+JDrmkHL4lJsU/IbXVQBId/C/DYWkjmXk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K8BCZrhO8hxbHo4++I+mCwKVJor/+Y4Ge21ZSo9YqAIepeRLDaAMCTRum85vmTNspoQ0POSCNa9OpBbHduzgXc4VigA2cPbjSvkVCaf+4SKVODrZfMOwGMH0WXIb2wk9lGUZtV61A6MBWTGeq3pCvFR1cw/tKJ1VLmgMcQqw7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zqloceJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zqloceJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862811F00A3D;
	Wed,  9 Sep 2026 07:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788938021;
	bh=upgrqiWmmptNwRwOA3u/+mWTxD1ZWFED978NfkXjrlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=zqloceJ2NnoaNE/z83IdujWffVPp8pbfyTibAAG0UTAIRpMMogdYsCLyWxAEbhWVf
	 kEM95mtlRnyAiIK2/P28HpJrG1/JqtVkm3j225uxEhLMeJqsk3fnN+WEOST/EUFgbC
	 6CIUcYv03CtwRV33TShPygrqR12zpf3/4ymb8jr4=
Date: Wed, 9 Sep 2026 00:13:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: linux-mm@kvack.org, liam@infradead.org, ljs@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, Hajime Tazaki
 <thehajime@gmail.com>
Subject: Re: [PATCH] mm/nommu: Reject wrapping ranges in access_remote_vm()
Message-Id: <20260909001341.6a7c3556259f7cf9a79c1da7@linux-foundation.org>
In-Reply-To: <20260909064231.18693-1-tasos.papagiannnis@gmail.com>
References: <20260909064231.18693-1-tasos.papagiannnis@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 09:42:31 +0300 Anastasios Papagiannis <tasos.papagiannnis@gmail.com> wrote:

> The NOMMU implementation of access_process_vm() rejects address ranges
> whose end wraps around, but access_remote_vm() bypasses this check even
> though both functions delegate to __access_remote_vm().
> 
> Move the wraparound check into __access_remote_vm() so it applies to
> both entry points.

lgtm, thanks.

> This is originally reported in [1].
> 
> [1] https://lore.kernel.org/bpf/4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org/

Ah, bpfbot scored one.

Sashiko might have found more issues in there:
	https://sashiko.dev/#/patchset/20260909064231.18693-1-tasos.papagiannnis@gmail.com

I'll optimistically cc Hajime Tazaki, who has been doing some NOMMU
work recently.

> Fixes: f55f199b7d76 ("NOMMU: implement access_remote_vm")
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
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

