Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5FF2E6CC0;
	Thu, 16 Jul 2026 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191947; cv=none; b=HxIOTp12u0wsrO+gI2WvxvIIwXiEKNIrsFpDASINm+OGZnZgdgDap4VJ+owdvpVbgAF/vEDGePJe28mmMcv19J08W59ZU87h6aqCrSNL+5iJLuRqQAfidJh72L1+7X69++n9R/Wr5pzb07PrE5+Qs24eLoGmus1pMuLvhYP0TZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191947; c=relaxed/simple;
	bh=GVhS/6y2xfArShNGKYMwlux9vTyNUExIdKPMftJgdVg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ar+fiM9TGluSmDqTG/9HtPrC2nY+HCYNuP0UkcaslJbk64jBw+c/R6ufAKCsjdmAcvArtR3M274Hr4y9meYRmy8jP31cr5vrGs6Xq2hq7uXkFIxpXfLKRdCvMXfzrQQPaS+NybwhiQqU2NCQEmqR2HnrN7vjaLh3xmR6/S6M3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIA4+4iu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIA4+4iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4061F000E9;
	Thu, 16 Jul 2026 08:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784191945;
	bh=L/sQ74F1HneWByM/OpIR3WUHTgptraOruzwOj2X8Bl8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FIA4+4iu0Jfux4VS5/scuiUTfCBzLfI6AbkJ8feWN9AdqtsUoVxw/kovY/JCVGFdC
	 7jQUX8hxB2eq3TlpqROWiYRbFTp886T5w94jSux57itiqim+mHDzHnc2r+91BMUmBK
	 2voRoGsCY+eR1kfxmzSZqOemg5k+WA8wToQucYrfsXJMryh1lYGbW7tGH4kFRXyR8B
	 JuaFvDtiiYMCOQKtNEZnqSkj7+2HZPu+zlcDlydF6VawlK8tLh+HQAztZM/83nEaUq
	 JjMWMDB7IFPh+DRJeWl1aLyNI4xXoKilGvqguEC7d3xa1dxb1QNqbXo703IOvShGEx
	 XTvDxGUgMrSTw==
Content-Type: multipart/mixed; boundary="===============5599618507617188577=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7cce7d9ee2d24519db79c652aee2e4e562a8139dac923e5cefb4d5edfd4f6407@mail.kernel.org>
In-Reply-To: <20260716-execmem-x86-rox-bpf-v0-v3-1-4e76158c01c5@kernel.org>
References: <20260716-execmem-x86-rox-bpf-v0-v3-1-4e76158c01c5@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: dispatcher: allocate bpf_dispatcher->rw_image with vzalloc()
From: bot+bpf-ci@kernel.org
To: rppt@kernel.org,ast@kernel.org,andrii@kernel.org,luto@kernel.org,bp@alien8.de,daniel@iogearbox.net,dave.hansen@linux.intel.com,eddyz87@gmail.com,mingo@redhat.com,memxor@gmail.com,peterz@infradead.org,song@kernel.org,tglx@kernel.org
Cc: emil@etsalapatis.com,jolsa@kernel.org,john.fastabend@gmail.com,martin.lau@linux.dev,rppt@kernel.org,hpa@zytor.com,yonghong.song@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,x86@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 16 Jul 2026 08:52:25 +0000 (UTC)

--===============5599618507617188577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> index ea2d60dc1fee..79f0c222c583 100644
> --- a/kernel/bpf/dispatcher.c
> +++ b/kernel/bpf/dispatcher.c
> @@ -148,7 +148,10 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
>  		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero, false);
>  		if (!d->image)
>  			goto out;
> -		d->rw_image = bpf_jit_alloc_exec(PAGE_SIZE);
> +		/* d->rw_image doesn't need to be in module memory range, so we
> +		 * can use vzalloc.
> +		 */
> +		d->rw_image = vzalloc(PAGE_SIZE);

This isn't a bug, but for multi-line comments under kernel/bpf/ the opening
/* is expected to sit on its own line, so would this read better as:

	/*
	 * d->rw_image doesn't need to be in module memory range, so we
	 * can use vzalloc.
	 */

>  		if (!d->rw_image) {
>  			bpf_prog_pack_free(d->image, PAGE_SIZE);
>  			d->image = NULL;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29482648692
--===============5599618507617188577==--
