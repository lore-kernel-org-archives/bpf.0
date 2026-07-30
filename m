Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8262B3C1F4B
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445805; cv=none; b=IiF3hlmu4DW9Qu3zwNtimvhOJ4SFPGpuHmKHfi3dzYn0X55Ducz3t9Kvld3RuoH1NuOaWWiW1nO+VSAZU/UfJr8CA5YhMGTxvWzWK4zibs5Jzoipkl4jElxM9smTR5YWZhXit9/IeRgN/ZzirvYJtGwOI/KLUChX3oDvzdIV1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445805; c=relaxed/simple;
	bh=h4gAl5X4nGE0SU+Gh3X/MeeFPIcUPYTfpNfqjtezBaA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=fMphIFiSTnxGV/99ePsjteW4ir/t6mNVjqTwumCXcCae2AzfXpCmYGBWFdV11WCPbuXwGI/P2S911JiiLuW0j8ao6QU2nePn/bLio73jiA4h/hvgg3ZZh5yE2l06hGhl2vWazhONqyxWfB7fZPUS3p9GUmViQdxEnkybMaQTYs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fczzRw2g; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fczzRw2g"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e533aacf2so17566185a.2
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785445802; x=1786050602; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMLsf+LQaJK9TyVbvhOADIYNpgfmalBwRgJCFWQKWPY=;
        b=fczzRw2g8JaX6smDaTZ1xAWIookwAoR0D/4mwj9qfdsvrT7xHZK7cUCTG/iaRkHggR
         P3+FocISR0RAqycHZjKdHWOKhym2LY4kDNpJitfSn1SLsP0xJldbL6dnOQiOH+Ui8UO0
         0s0iikmvOL5UJp8pwQK+3zogN5R8tgZiWKl76qP7zUMCexyqTjscuP09H47el/A5LOPQ
         bLAyklxxIuDg1PEhhjAUarpxLsz/dzQ2nx+5CRrhHNyoAb765r33FrSBLNFCzRh86N+G
         hs6CfIpW2mf0Oi0YshQ5vbz8SdmW0ePcRjHnZpBqKUUGsXip8dYktnA8REVJHQrMq9lN
         Y3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785445802; x=1786050602;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lMLsf+LQaJK9TyVbvhOADIYNpgfmalBwRgJCFWQKWPY=;
        b=F53jI0/C0pltUzLXSZrdWI2ZvZSwhihbt9UTfj91/PmoJ9gFqqxXUV5pT7gP+uqnMW
         TX8aSBZOwTPvhIVJASFKOfRzyuKlk0huysuSsSmxhS8LlObCxtF+vW2scxEV9KKBjtEk
         oIjbzPZAEu8885lDtm1h3lTVe0GcssyX6gcGsFHnXjLMXWLh0p7ZH4VpdOjp2kOx1dVb
         fYPyU62Da5qdvgGwgq0E3tvr6tzef51wGsEuMuJBExq/i7iphoLDrv8Hsr6Pddw2+SL/
         25YgyOpsaGecFfy3aKqM9y98COOuZYSy9xC7UkG2OHREhEzjFogbkDQIjakcHxTbKlUq
         mw9A==
X-Forwarded-Encrypted: i=1; AHgh+RomeqwVig96RpaGW2DJh+eSzESeTytF6b1u4iln/7r1ENl5qIMGhaa9dUbakgq+O9f116s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpClPiiFvq5FJFpsbCgUvtqOm8SpamxpUX5JcYrIr6chSE+ZY
	eLbZNq7Ka0eK7QtDC93h5GlLd/ZN9Kacu7+L+V1FcH1cj1yZzaGcFc0gcJ9XkdMuTg==
X-Gm-Gg: AR+sD11adawf9Yf3qH4tFuruGymyQur/G3xIzSydMvGL7RQ2zH6aHfUeuXq1fcIB45m
	btm/SOwEEyg/GVDd6eyed2WddVWWY7Onn41mbVUhZUnDq/lt1HoSdIg6SeUib/hGtNSvHij9Fut
	a6CLxaFP94oUByxOtci91KCullogkpLNwigbp/ANw+TIXOd38Fo4am0BpttIVAszpnuvVkJFaRg
	UjZSovxV8We+DuS5i2B1YTYDaPKGZiS5q9yCPtFP3pUvIkPRHV7zbufgr8gPcg1gfYr6t9nA0dG
	KzYIMok8+iGwGBOuYz3VC/qb6DMyt8KVx9IB2xKdXySynhUzS73nz8Wzh99mSDqQtQIOfaBsdj5
	H10fR6xlGDOvjbUle/ptS9JKZVsuwWI2SeBA89qUVjEZtTj7KGL9QuYdXvy6UYH+R5pm+N0IPof
	4WnyHTWQaIqEHAabesAYRmE9qrPaM/+B+eN83sJUjYEO9nxjXgyTwI3FzrwgEy5pTEHmU3U3csi
	WiDB+DjS8QWQEaIEEUDSqSiTr+M8au1LcO9TPKycm5I
X-Received: by 2002:ac8:7e81:0:b0:51c:1d18:2fe9 with SMTP id d75a77b69052e-52b3836970emr48411021cf.5.1785445802045;
        Thu, 30 Jul 2026 14:10:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9083fdbc35fsm1954776d6.24.2026.07.30.14.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:10:00 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:10:00 -0400
Message-ID: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260729_1758/pstg-lib:20260730_1437/pstg-pwork:20260729_1758
From: Paul Moore <paul@paul-moore.com>
To: Carlos Llamas <cmllamas@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, linux-fsdevel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, "open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, "open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
References: <20260730181008.3654413-1-cmllamas@google.com>
In-Reply-To: <20260730181008.3654413-1-cmllamas@google.com>

On Jul 30, 2026 Carlos Llamas <cmllamas@google.com> wrote:
> 
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
> 
> Do the SBLABEL_MNT check before the inode security is initialized.
> 
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8d6945edae7a..09a12eb8652c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2980,6 +2980,10 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	if (rc)
>  		return rc;
>  
> +	if (!selinux_initialized() ||
> +	    !(sbsec->flags & SBLABEL_MNT))
> +		return -EOPNOTSUPP;

If we're moving this check, we should probably just move it to right
after we assign 'sbsec' at the top of the function.  The calls to
inode_mode_to_security() and selinux_determine_inode_label() aren't
doing anything useful in either the !selinux_initialized() or !SBLABEL_MNT
cases so let's avoid the unnecessary work.

>  	/* Possibly defer initialization to selinux_complete_init. */
>  	if (sbsec->flags & SE_SBINITIALIZED) {
>  		struct inode_security_struct *isec = selinux_inode(inode);
> @@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  		isec->initialized = LABEL_INITIALIZED;
>  	}
>  
> -	if (!selinux_initialized() ||
> -	    !(sbsec->flags & SBLABEL_MNT))
> -		return -EOPNOTSUPP;
> -
>  	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
>  	if (xattr) {
>  		rc = security_sid_to_context_force(newsid,
> -- 
> 2.55.0.508.g3f0d502094-goog

--
paul-moore.com
