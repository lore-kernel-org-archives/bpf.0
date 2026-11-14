Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794658799;
	b=mFEQ9wnrXoAZsBF+as5aIv+XOapQmEchXo7/iElnxN1O0RdnR/gKr2c3E7/JWlL0GwZq
	 5Ow131iDVOxvm1RqmXU9g+p1g1T1qVacCsD9mNB22nBtPHQRAZLCfP4qPZTjdoIYqjkFU
	 tDVOEKrVFRIu+bbV+RdutOEsRnPPpcWgT/paRgeDMkxUGhceu6P62XErwWFfeKEKrRw5a
	 vEC6QzEV+ohLnRXSfC0YJvZmuabfxQzC9KAa3ihAWIrO1pgGG8q6aiPvn1RMixD3qj78F
	 CAnBKnMt+P1nlQ+hW5YAJN/NYVgeMvVuXhFCi0ITRcXEhpyOmLbzV7FUE19lE4ceffQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794658799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
	b=DXYoNixqLBYGFi0stNXCubYjM0hRo+ml5RNM/H5+fEx8YVT2DfPh2MKP9I3Arfe+F1hY
	 lGUGECvrsbdmYUaw4VOH9pL87LNpGY76/phNIWEyCP/B1GoRl38BN7m5PC7jw2Gz8HtPW
	 FvlnVsMI7PLZC7JIBGoILMesbR2zJMeMH9VZFdSo6tM8PjoVk3xe1op7mzfHWnKeYWmya
	 c6uo+Cz6WBePMAn0T6dvzT3IL93F0VXSOPEo4IajERiAmcYp7inY07oqgI9VcyzAR0vgT
	 ns0h9mLS9w8FS+LZ0RfzLvp9hgXchek9O66faprIy6uYLiBeRnCz4qVRe6/75dNqPhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zvg2B30u;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702E606A334
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 12:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3702E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zvg2B30u
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b58cb69927so3350409a12.0
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 04:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794658797; x=1795263597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
        b=Zvg2B30uBzOFFo54OpfHCzqSK6TOyxTRmwNZV7t2nfrBwunaCrRH+5tI09/jIosXZS
         GdYk6iMfyO0nJ3moVzjaSKnXCCWxcV1Ye+R/4YjiwdwGG8ofIv4PWH24MjP/VV4CkNiq
         nSM7j6UNEdEDdNWpjUjn43q9YL/wt1IFltOrsPhL2VYrn8g/yyR7Uz6PFelA0j1tolIT
         QTqiv37OCVMy+5oEwlNBsw2cKiejzgZGAC7AZW2QPAu9cR2dMcfIteYf8vq02JyCIN53
         /PYiFz/vA+fp7KPo0fCiRfu55fCeLd5qLFIcUMGbAUVH1mkivaDzQTprXnn5n1PDT9pn
         6ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794658797; x=1795263597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
        b=YvPgaJCgTe/hTDxvP9c0Q+Nb9KjaDiiVHvI9P3jaWIE8ROOG4XttBYTUDdJ2Xog8p6
         JL8N+xaSBu9ypcDK/LNArTtFNGY+jR6mc3TJbJoQ+IWD6Clo3KudalNBvHQdGE+RSSlU
         YlZo6p1M27hJCv2YMId32bx7mpiG1NwX1X81X/arOX3m1/wP2QNiYwL8iNOgrUHzi5y0
         PHk2jDVJBQw8KwwShFZX554ju7Lp8AMranAzmvJKclsz1FCn17/OHEnF2ZHJhSTU3NL1
         7KEyEXHwSHUWiCWstUvDao8WmEpKHySO/qR4RWDNrCyohRfRSc6gsWtuoQ1Io/cZJ3f0
         mDrQ==
X-Forwarded-Encrypted: i=1; AL+hErGCD/MrxQGd/YZHwF4jgcGis8SBQaDGN3V16vP8FS+F/9/VmOSPtTN6tfrwsm17JseZwoA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7JY1Ret7iXBRMF2eftOsTDYFgh9Sga1UC+SZxyen/+7jnppth
	sHR3xMdvUerT+veH8nPsTmpzVXDytCLHuu9lJQ0M+0kdGeuNHR/+HN9o
X-Gm-Gg: AYBFou3ZEZfAOkWg3C/uFiLR+69HixyJKCafF6tt3Bod/r9tGsYb/HJd0QeUwbt8O1N
	mlX5CLZK7zDQIZoi29qQeM+apeiLWdhXYXnAt7lT/83U82gZn+VFWH0rudzWfPpyZb9dM+xkeTx
	+3kdOndxsF6UllONqIjGHfzHrM29hVKapH6RE5oxW/e56A2wzkp1TiCxx1NnvFZpqZXXwnvbp1Q
	NHrGKJGrYF/ysipImLdyGhkr175s8Jr5wvBwRPY5PjxQLkOZ1egNGoyIbWqCs87EJaXKbPpyXXm
	m9delJ4mdyZKp6dV40xIRn2Hlxz62/fqvj9imjILAPpnmTogYe97cpYX/wlEKdFcoWVPYIO+QIh
	Gp0y3ZO0xkjo/4nH3CVadUjLhhBG6FAaftGTIEfHEH2680WTbDn5CU2WW7pRW5mEntKWFk5c+uF
	jf8ok+4KLfnn++UG9jXqIekGANFDmlgNy7CIvmIPirKWYBGxvXUb/ngX0WjegEPtkbbP6Xuut/w
	UIfXJw+p5/qavBu/Q6GIPbKupISSlsV3tgCHWy7iY9LzXcFBUTJoauZlnK2fnu4mpDGJdnk5wEt
	D0dJmldvmJmJvniOJ8M2BYaal6i8akLO4ARO8aqDo6NWfCDkbQnRkacD/1dJI+4IlwJQ0G6oy1S
	MOE5Q7dvZuuSS
X-Received: by 2002:a17:906:1001:10b0:c41:4512:560d with SMTP id a640c23a62f3a-c5096387b02mr309942166b.16.1794658797424;
        Sat, 14 Nov 2026 04:19:57 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b5ac2asm211518966b.55.2026.11.14.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:19:56 -0800 (PST)
Date: Sat, 14 Nov 2026 13:19:56 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	bpf@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 10/12] ovl: take freeze protection when storing the uuid
Message-ID: <avhR7DbNbVDCyPDO@amir-ThinkPad-T480>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <20261114-work-fs-frozen_writes-v1-10-f5ae61c898b1@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-work-fs-frozen_writes-v1-10-f5ae61c898b1@kernel.org>

On Sat, Nov 14, 2026 at 11:47:17AM +0100, Christian Brauner wrote:
> ovl_init_uuid_xattr() stores the persistent uuid in an xattr on the
> upper root. That happens after ovl_make_workdir() dropped its write
> access to the upper mount and before ovl_get_indexdir() takes it
> again. So a freeze of the upper filesystem that lands in between lets
> the mount modify a frozen filesystem.
> 
> Take write access to the upper mount around the xattr update.
> 
> Fixes: d9544c1b0d9e ("ovl: store persistent uuid/fsid with uuid=on")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/overlayfs/util.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 521717209b2e4..67aa7b71e9c83 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -829,8 +829,12 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
>  
>  	/* Try to store persistent uuid */
>  	set = true;
> -	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, uuid.b,
> -			   UUID_SIZE);
> +	res = mnt_want_write(ovl_upper_mnt(ofs));
> +	if (!res) {
> +		res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID,
> +				   uuid.b, UUID_SIZE);
> +		mnt_drop_write(ovl_upper_mnt(ofs));
> +	}
>  	if (res)
>  		goto fail;
>  
> 
> -- 
> 2.53.0
> 

