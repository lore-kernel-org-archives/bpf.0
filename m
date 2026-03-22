Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C637E30F;
	Sun, 22 Mar 2026 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774146396; cv=none; b=ReeVg/Lbj/S+YAapCagBiScm1NpDcZWb1HTxIHesk/aDULP3kYxrblraMsT0GqWeopermYx9WHSyheHSl8O9mlFOLEsUCYRZS2vySxTOVdD6p6li8izD4W3zw6ov0VmSTp0CtqLiwqGnGdvTd3Le4CPhPwBM/6cc8IHEAXzAtrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774146396; c=relaxed/simple;
	bh=4b4Etkege9OuIa+NLmVfx9XW/rjguhYd053gW25s+f0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EZdnlUyOSdCVdOTZSxLP/KIn3Pjvo9GvHQrvN7omshNuYRrn8YumhpesWHDS8aFXp9texBR8cHzgbENjvyyu88S9p1ui0AhU5zfra8tJ9l6GQ3fI7VqQoDSJ+Uve2Vk/VjxrpZD92o3NQZJGoBA6SqUKT/AKYzo3c3ER3LRdeM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omDg/ew1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omDg/ew1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9A0C19421;
	Sun, 22 Mar 2026 02:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774146396;
	bh=4b4Etkege9OuIa+NLmVfx9XW/rjguhYd053gW25s+f0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=omDg/ew1B/3T9euyYM+m4qesco9pn8VGkh8qG9e3lbttkcwrtm1SsyNexDpkh/0JG
	 9cLX1Vck4NNWMlkJ2EmLCl3adqo7nZ5eslMoJnmrE6ryF3duWpQLw1ZaP/mdBPQgPs
	 uz4HA1eNUU+iRLhwCblcWzjgQeaKQI51JRbngvpKsyqHFkrOaRcjkQjU8VsIllgRiC
	 lxnPh9mXaYd/AOFDTitvxOzl3zItFnxnSYg9n6r2l4JJohvZBssgShTse1arFnlsOV
	 xHUFwRPcEzTB3dakxF/6B5b+3vCTBbZPcNp5rRY7Sd0tGgdVazAD5kuqLVc8czWqI0
	 0UJMjkiNZaWfw==
Content-Type: multipart/mixed; boundary="===============4421140977929886089=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e3b343793849491757c2745b3d6d23a079bf9c0d6c32ba32874aee826911167d@mail.kernel.org>
In-Reply-To: <20260322014402.8815-4-piliu@redhat.com>
References: <20260322014402.8815-4-piliu@redhat.com>
Subject: Re: [PATCHv7 03/13] lib/decompress: Keep decompressor when CONFIG_KEEP_DECOMPRESSOR
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,linux-kernel@vger.kernel.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,kexec@lists.infradead.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:26:35 +0000 (UTC)

--===============4421140977929886089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
> index ac862422df15..39df02bcbc66 100644
> --- a/include/linux/decompress/mm.h
> +++ b/include/linux/decompress/mm.h

[ ... ]

> @@ -92,7 +93,14 @@ MALLOC_VISIBLE void free(void *where)
>  #define large_malloc(a) vmalloc(a)
>  #define large_free(a) vfree(a)
>
> +#ifdef CONFIG_KEEP_DECOMPRESSOR
> +#define INIT
> +#define INITCONST
> +#else
>  #define INIT __init
> +#define INITCONST __initconst
> +#endif

The INITCONST macro is defined here in the kernel path (the #else
branch of #ifdef STATIC), but the pre-boot path earlier in this
header only defines INIT:

include/linux/decompress/mm.h:
    #ifdef STATIC
    ...
    #define INIT

Should INITCONST also be defined in the pre-boot path for
consistency? The individual decompressor files (decompress_inflate.c,
decompress_bunzip2.c, etc.) all include this header and are compiled
in both contexts. If any of them later uses INITCONST for a const
array following the pattern in lib/decompress.c, the pre-boot build
would fail with an undefined macro.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============4421140977929886089==--
