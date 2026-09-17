Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008F4DE713
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648207; cv=none; b=aKdTuzm9B8BskQ9anZ8KutcSxNz4CrBsQ7Eyft/2Drha8sfqtuTWbXyfDDR4oZqfmlbBjzrxwsWY0GdaIV0imDRlAc6yFW8SxPxw5ttQ0I9yAZCra1Bdbr7deNsO/jW/gibIZqcmrSvTzOWyTRZow70So3gpi0C3cboBuI7Cp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648207; c=relaxed/simple;
	bh=NiBLOa+Ivz/MGMdtQtUORvBhVtPqCwg0j5rxwwVjFZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBNki5kegvaOXByhCXVSHKio7Fu1q2WvlpvmwbfbVRGRvwz6XKwHtQiXZNS5f6sYHDwSTj7e8cOBVTMqJrDrC/v6ESp4bGyn7yQJDxBB2HLQ7dvc7hEk5lp0sh/FMon7JcWZEwoqfArZKGdMiXyHriKGNFORfMHaPkU6VoovtJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gU+5HCb6; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gU+5HCb6"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so4893625e9.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789648180; x=1790252980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dtz+Uqi8FvhezfQGwgUreP+CufNocr9p+NqbDN0Xcok=;
        b=gU+5HCb6NEhmBQLVaLIqnXzYCbuW3y+9zP3j/sbrylZD7lHYyFw9pFNkQiORNKn2+9
         ecpocjM18AVXqhmb2SxpKUeXm8j+Y5YY0eqe95Ju9PSzoqQDNVvagBBBRiHmAyaNxoSO
         yrF2knA4eFqyBkfUVMqfIAaC170alJV/Ke3NfGe5vcT8LsMUz1AkGiyw4nqOt58DrBeH
         edFMUx8EXzNK34fToowfRsGPhAcUCtwcD78tvPUV2sxZL80o7IO0qH+1j5wD8x1fouxk
         3I6nNpgWk3sZfc3RW+iF7VrURE/zt9+KM6ybjY5XT/davL5nsM4B5Uuztt8JxBvsRJbA
         86GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789648180; x=1790252980;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dtz+Uqi8FvhezfQGwgUreP+CufNocr9p+NqbDN0Xcok=;
        b=0f86/lDqQmuwipAcsoIW7ZHaSFujAPw9yFe6BD+8kVJD/q860T9vJkZ1gG3oATZjWE
         ji17mHSiFyzW28SvzyE+2DqKa3IWwHnXVa4nURaGAHO7zrMO0YNsXzieP8kBFd/KacMo
         IVcsh4utBXitJ1JI5o13J/I7G2Ax74MRx7eJYN3/o+Ju6TKpUJGhjvNocnWUGgGmVzWw
         yqqNsQJ/uOR7LzgIKNjMIvL3MEbCdl1EnQEt6we8LTdnZKfRuL69Lc3y9y130DxQBof5
         k8iIQdUX2wFYF7d271J9p5KV8JMKZJ5lSp/SVx2XIilyp8lviAzekFM6Ld0ua8Gl/Yal
         a2kg==
X-Forwarded-Encrypted: i=1; AKwUvByGzZU9phtHoov0/nvloPLxER8AKpvg9fvaDCSdy3R80SKzE52FjoVoGNgqVANtc2ASDGw=@vger.kernel.org
X-Gm-Message-State: AFuF++l7o25N0cl2lFo9alfMvMxIlrtKcjKHtl3+u7Odt6rTlthSPm9t
	ZmGKTajcIVz3EuLRh9EFf8REtoWLqeTdxwDMEsLUPTOyxwI9wdR5mbeL
X-Gm-Gg: AYBFou1eY55aMbxxD5JK4tSeixTBMud/LtnRdI2zKjcd8WQsIdiGpnenm8DjRk9i0Vz
	MNhfFuMCxs4tvcdxXQabusdZCB1Y0kg897q8myNjceZUOC0PmoWMaWhW26EYkmJ8wgKTGxklvvi
	HhVMOWBnYVyd33yKI009YSKbFpdKaTe2mSRUYHLvSockWxN3LjMW3fAhQoKLIFRVXSJ0x8/0+x2
	mE8Pde+hAELtUTNGTIHJ+jNWiriwGPAZ1AwpTZ8XoVcwOrB/eJ2VCs40+7IqBa6aBvZvw3rpaEg
	ljxgeM6tpIbAGAKBXBtIcFNCWisSDXEpjxqA4MSgf+LXuVcSSnSVl+OLKFe03vyymlEPVAo2Jcm
	fnDmU9XaImO+J6lgXIGflV+e/txBia5T3rmGeyQ8WBVzU0QN94hqf1Pqpvh9ppL0D48jVPWyHhh
	hPiW1+W3mUojusARjt/XuNDaf6Gx5E4WDTiy3DuHb8nrq8Tr33T9POEMOsemmZBMjH0pZCWjkxA
	mBCSnfb8zollhaf8+J2J5QRhskuNrG4pFFn
X-Received: by 2002:a7b:c35a:0:b0:49f:bcb7:8e9 with SMTP id 5b1f17b1804b1-49fbcb70a1bmr64001725e9.9.1789648179633;
        Thu, 17 Sep 2026 05:29:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1ce79csm82621135e9.0.2026.09.17.05.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:29:39 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:29:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, wine-devel@list.winehq.org,
 linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] file: make struct fd_prepare const and kill its err
 field
Message-ID: <20260917132937.5a15904e@pumpkin>
In-Reply-To: <20260917-work-file-fd_prepare-v1-4-b87534ca49f3@kernel.org>
References: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
	<20260917-work-file-fd_prepare-v1-4-b87534ca49f3@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 11:09:45 +0200
Christian Brauner <brauner@kernel.org> wrote:

> FD_PREPARE() releases the fd as soon as the file expression fails. The
> fd either holds the descriptor or the error. The separate field is
> redundant. Make fd and file plain members and struct fd_prepare simpler.
> 
> Callers of FD_PREPARE() get a const pointer to the guard. Simplify all
> users as they can now easily access the trivial struct.
> 
...
> @@ -191,35 +175,39 @@ static __always_inline struct fd_prepare __fd_prepare(int fd, struct file *file)
>   * was allocated. If fd_publish() was called the fd and file are
>   * published and cleanup becomes a nop.
>   *
> - * @_fdf: name of struct fd_prepare variable to define
> + * @_fdf: name of the const struct fd_prepare pointer to define
>   * @_fd_flags: flags for get_unused_fd_flags()
>   * @_file_owned: struct file to take ownership of (can be expression)
>   */
> -#define FD_PREPARE(_fdf, _fd_flags, _file_owned)			\
> -	struct fd_prepare _fdf __cleanup(__fd_prepare_cleanup) = ({	\
> +#define __FD_PREPARE(_guard, _fdf, _fd_flags, _file_owned)		\
> +	struct fd_prepare _guard __cleanup(__fd_prepare_cleanup) = ({	\
>  		int __fd = get_unused_fd_flags(_fd_flags);		\
>  		__fd_prepare(__fd, __fd < 0 ? NULL : (_file_owned));	\
> -	})
> +	});								\
> +	const struct fd_prepare *const _fdf = &_guard

Since the struct is only written by its initialiser, can't it just
be 'const' ?

David
