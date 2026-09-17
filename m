Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B884E4310
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647775; cv=none; b=JApHB2DhYiW/Cd9vfe0rPRjItx/jsf7wJwJdxOvq360L4NkOMtIxtGSoe/MBNIXZM5Wly4KxpQXZzAMaKY0xCFuXec6Qf6sS/TQbCccW413GxFEpjfQVTpN2qJ23tQVzJfxarmrxVMDPjEhXRmHAlX24eMumh24cCkVbW3XrH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647775; c=relaxed/simple;
	bh=OJmskDiFOgBotmQnXQAOWrnTyjAq3r/ZPkOzXCktDOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrNiSLHyK8LXTwf0T0t9ZKI/RvnySbVe+AHSkbSTVgpAsFEM7ai5P7u0Psi/71bni5yHdxFE3LZ0NL8QBgAFOSYdobAc13ZvLFUaMtHHh8prs0GtovSFX3llKbLfZhl25yM/soCnUGNPw2yMGYVUICHnsHcFxmzX3ho8tvn8Sqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8MWUiGW; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8MWUiGW"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso7274975e9.3
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789647757; x=1790252557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p0zmU2W+3BnffNO8O4v0JPRgPOvlhktXL05mpLnU1xo=;
        b=W8MWUiGWkLnPE3LZwZMs+M6hjewk3bifMXlRxyzDreqvti1vU2oOe8kuHIJilh+a4j
         avmi0gE2ouNHVuMutBqsR46ibWdW2hMSUIg+O7ewEblQDSqXn5oywiAzmcEOAAbnHJh9
         CowIX7j0Z9oM0FI7AJhmCimPMAgxALlDijVAFCnLuHoqmAoi4nozpd09gBGC/BiDrVMP
         v8CWYPOQj7wYPLWd3xvspz5rrIP7ZmsQlXq/fr57voEYreoEfZ0jpBHODcwFTuLtahTp
         5Ork4vvRYVxbjDbbXem88rlm5er/r+K8QtAMln4o0OqF8zBcjtvMGd0fo9MP/8kOij+L
         7TVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647757; x=1790252557;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0zmU2W+3BnffNO8O4v0JPRgPOvlhktXL05mpLnU1xo=;
        b=s7mPCEYzNkFC495dCQnxMlfXMxJsno7FhYoaURXhv/9G9yf7DXb6lwTdlBY+5q628E
         bJBMloR9MKe2/DLCpYR34yaaoAxr1D9T/RrGAmcmTNKAngWqvwThzY6CGVY1ttLnuH3Q
         qz2wkZMBnEQZ2Y7QqEWkFLYn4PsVYydx0UZcFIFTmzjeVCRq7yIiTzCnqM1Sjs6zpNIo
         gUmrMgVO54KZB79l3AIx9IWfukh9Yeb8vJI7AJCIvwShW09KkZKp5bzb6u8HPmHoZYA3
         PFNTEzsL1BSeV2Stis/2S7ErejyUFSUavoRV3JMbZaGflw0gOpjBFz9z9SVxDBIX1EhM
         lRkA==
X-Forwarded-Encrypted: i=1; AKwUvBypDroCJ0YtayGkZX083AV92My6B7TS+kpvbGVIx//jTe0Ig5hUvbYcscZ3ELUUwBFqOfE=@vger.kernel.org
X-Gm-Message-State: AFuF++mHv1XnBIdPVeJweP8cmtABm4f6lkgVacGXgiGp39VRJcFr+El3
	RsPN4jfERcfUtuyPrn+T3wkIE1UDuaMzAnu5l5FV+a28aidZAa0r1orj
X-Gm-Gg: AYBFou3VtpIRqWgwB6JzwMxqkz5sgi2Tz9ixl8n9A3BCaBo2PYhZ0oju4I6sxuPjiIq
	daoz+mMg/GZ995NR3Hf1iAMSIj88uHAZYJ1EqHJburINBZRR5pBmgPeVtOYYQLyXiqZWf9Au8YR
	5AfyHy5QYyu9t/aL5bvvTBrhlr/1cCMNQ/foCE1BxbDVXxNH0fDBbxLDO5GYWs2Gh9Mb2Euvb8v
	wRSmao0wlHm1oDT8MujMZ6diSS1ekqw+ZSc4WDQUKul1LXEYWO4klS9r7Av9fblwRxwJVcABchU
	j21XONDUIJb5FKJgRkTLY+O4+1YckhwXAF8hVDodQ9nG3KX3z5EQxxTYK/ptZNsNXrRJvI7M9mQ
	TmBgtMNeMsG2M+Pddo58cqj6dre70dMOs0BBxdbGBhjm5nFI5nP70OJijImYPJzNrYucH+gKX7Q
	qjcD64ildONKVA/Zcj719eD17EUO6twxqbeMHOr7KbwYv7nJnMORnLYMnwWe5YzIb4tAOtbH+CS
	mCezy6+YuE9ZSoG3MwU5aoPzqVImw0IZxC6
X-Received: by 2002:a05:600c:4ed4:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49eac462571mr73688225e9.2.1789647756735;
        Thu, 17 Sep 2026 05:22:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7678sm15969081f8f.2.2026.09.17.05.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:22:36 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:22:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, wine-devel@list.winehq.org,
 linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] file: declare the FD_PREPARE() variable with
 __cleanup() directly
Message-ID: <20260917132231.26314015@pumpkin>
In-Reply-To: <20260917-work-file-fd_prepare-v1-2-b87534ca49f3@kernel.org>
References: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
	<20260917-work-file-fd_prepare-v1-2-b87534ca49f3@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 11:09:43 +0200
Christian Brauner <brauner@kernel.org> wrote:

> The whole CLASS_INIT() detour isn't needed. Use __cleanup() directly and
> give the destructor a private name.

It also makes the code enormously easier to read.

David

> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  include/linux/file.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 2b864f457211..926cc58d0b7f 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -146,9 +146,6 @@ struct fd_prepare {
>  	struct file *__file; /* do not access directly */
>  };
>  
> -/* Typedef for fd_prepare cleanup guards. */
> -typedef struct fd_prepare class_fd_prepare_t;
> -
>  /*
>   * Accessors for fd_prepare class members.
>   * _Generic() is used for zero-cost type safety.
> @@ -160,7 +157,7 @@ typedef struct fd_prepare class_fd_prepare_t;
>  	(_Generic((_fdf), struct fd_prepare: (_fdf).__file))
>  
>  /* Do not use directly. */
> -static __always_inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
> +static __always_inline void __fd_prepare_cleanup(const struct fd_prepare *fdf)
>  {
>  	if (unlikely(fdf->__fd >= 0)) {
>  		put_unused_fd(fdf->__fd);
> @@ -199,10 +196,10 @@ static __always_inline struct fd_prepare __fd_prepare(int fd, struct file *file)
>   * @_file_owned: struct file to take ownership of (can be expression)
>   */
>  #define FD_PREPARE(_fdf, _fd_flags, _file_owned)			\
> -	CLASS_INIT(fd_prepare, _fdf, ({					\
> +	struct fd_prepare _fdf __cleanup(__fd_prepare_cleanup) = ({	\
>  		int __fd = get_unused_fd_flags(_fd_flags);		\
>  		__fd_prepare(__fd, __fd < 0 ? NULL : (_file_owned));	\
> -	}))
> +	})
>  
>  /* Do not use directly. */
>  static __always_inline int __fd_publish(struct fd_prepare *fdf)
> 

