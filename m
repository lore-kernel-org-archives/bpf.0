Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636E2DC76A
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789526871; cv=none; b=unOUwRy/wx87CX4ozyKwj/zJLt8RinRZBWFVAoh788MS3W1MiJQrfPzgh5eWqIqc82h1vAM7o7ok7uaobggCmeR4IkcaSZIgQFPoTLg1AeVNEf2xf4ozjzp7StGYBhXE9lvsjldRikI4qRTMJxvw/+vk8KXvv978wrnL+pC9ts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789526871; c=relaxed/simple;
	bh=wtd/03GFBPFtGkGnsixWJf5NJHyKunU5GA2TDNHK0mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB+yrcSZn83lOAMzhkN6hRZDkvOVJzWwrNTYPwHfcAiMDw8OKeHrAM1r4JQrzOB7sMVNvDZnVNtbS75WHNLcB/8UOhXWRGammhE0HKFVRs+YD30iR8AxTtW3xCWRV5Gvvcn78SoLBsDtObvHGo5xtDY6pJJF8QwKp9ql0HPAor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RGu+ljKB; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RGu+ljKB"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2507a618e1so7848466b.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 19:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789526868; x=1790131668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mbykP5/XyMLit0cz7WlaiYBiK+Q7B+6nW+jCiDoN2jo=;
        b=RGu+ljKBP9wNG3OcqNpozO6PC5+kywiVNgKNjvEyQiE49UT9HpgXcc95WzG8Tyiu8a
         w3dzAuehRb/Q+hGTF8Q/zlwIkFgwh3+EzAfisDwVVwQfdqWIlPvxp2sl5G8pO+fQrysU
         E0YL6ka8QN6PVR9miZ5h960ExhRhIMUcKG8bbrlHU+T2WoIpXT02DQ7aqY4IujbIHKVq
         o8Enajtze0H5VSF2k5J/oBJJx3GxqQIhDIEJQg36FZhpssHVKJWqbNoJ666r82V/BzoF
         IIKaa3AaMooqR/Gwdp5s2z0Zc/Y9zuvZMuaw14ggmIIH1MVBRiQ+3oQk+LGg4H8OeYqk
         hHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789526868; x=1790131668;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbykP5/XyMLit0cz7WlaiYBiK+Q7B+6nW+jCiDoN2jo=;
        b=SjLTcNxOijJ2ac6xpwazIta0r+7NngnCh/DjoxDeQ3mp9osOCcUvjIJz+JUHlLIBcN
         TCDTbEM738qdcvjWf4TCB0YqH3EfCT1iNI+boAlxxLyWtWgQhigKGKXiFPKb9pNXEy27
         75Xzo5fFfkld+PyEG2BCUgzExI6WyownWbbGvJrNYcURni2FREJPNTye4uuvbgwSWli6
         rNLiOa2MK/1I8rE7EGnunowVU2gSgYqj7wvxtch8vjJMTReF5gSslrZjkdMTFP39D8Qn
         XrCeN/ObVsOrRLNVgLszAfnRXupN0pNoEEKUraQA4s/DZjOiDmSlkoot5hsd6pypVbT+
         +r9g==
X-Forwarded-Encrypted: i=1; AKwUvBxVDvIi1hUF5P4y76gIDhfPG5jDsqFmuIfoFIHeLMxjPEDjBmivg4kpYHmLkQQub39CZSM=@vger.kernel.org
X-Gm-Message-State: AFuF++kO8TR/cKWv+xjxxZ/0h3JInk+cV4jLievDthVM3tVL40+grhJR
	P6xNXJ9qg1T2n+2mLhQfwYYerFb36nSJ6bUG0iU3+3vHciJnrKd5oIbGclaTEUD+GAU=
X-Gm-Gg: AYBFou1LAVOFQiGPT0iszmwxUY9eMQcOlKVKdOVzlSoir/kX5dQGVs2uoT0BCUeGByI
	rM/NWpTfSyPQfjoepYCM384EpFGWpd7hUVLoYbJO2YJ23/hjE/ZAZrS6QC8bFmFs3IIlQeGdvV5
	0M0mVJs65cQwZeLGWqTgsy9+y40KXAEn6q/uzcs0jQv8FHcUwuri57LnO9rkeF2eiOOcmFT7YJj
	Lbym8wcDqAa+fwNZsLRNIcHPdCJCmpMXz9AqVJ0Xs9xRXzTe8M8jbIV+BRHOsl/B5S/Lx6J6AiI
	PdRXkOKObOzDniJiPoo9i7wt88z/VSe+VxPqeLa36M4jFmAiDODukDiL2jorZxBrOZoogLoLTPp
	qaVzGOFbDMb7LDgkTL4A7x8uzlaxxk+KEoxGi1rL/78AfeTt1iljKiSkbNSV+Qs//KBs3huNsuP
	AM6TIkfpXgXNeG2vuBn/n26xAoaap26MAo2lBkDiKNDeix5Of+Cbrsv/DW0JoxfOg2xV+FFA==
X-Received: by 2002:a17:907:3f99:b0:c29:cfce:1933 with SMTP id a640c23a62f3a-c29e530d7c9mr41736766b.2.1789526868385;
        Tue, 15 Sep 2026 19:47:48 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8fd37sm3839675ad.3.2026.09.15.19.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:47:47 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:47:43 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, brauner@kernel.org, dwindsor@gmail.com, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, matt@bobrowski.net, 
	bpf@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH bpf-next 1/8] ocfs2: Copy the xattr name in
 ocfs2_initxattrs
Message-ID: <aqoCVQ78KOo2GZ8S@p15>
References: <20260915150739.284189-1-daniel@iogearbox.net>
 <20260915150739.284189-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915150739.284189-2-daniel@iogearbox.net>

On Tue, Sep 15, 2026 at 05:07:32PM +0200, Daniel Borkmann wrote:
> ocfs2_mknod() and ocfs2_symlink() ask for the security xattr up front
> through a struct ocfs2_security_xattr_info, so that they can size the
> transaction before setting it. ocfs2_initxattrs() duplicates the value
> since the array security_inode_init_security() hands is freed on return,
> but keeps the name pointer as-is, given so far every LSM stored a string
> constant there. bpf_inode_init_xattr() places the name in the same

Typo? I am not familiar with BPF, but I only found inode_init_security in
include/linux/lsm_hook_defs.h.

> allocation as the value, which security_inode_init_security() frees on
> its way out. Copy the name alongside the value and free both together.
> This is the only special case wrt xattrs in the bpf_inode_init_xattr()
> context.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: ocfs2-devel@lists.linux.dev
> ---
>  fs/ocfs2/namei.c | 2 ++
>  fs/ocfs2/xattr.c | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index e9c7774ccf91..e24f0e337a56 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -480,6 +480,7 @@ static int ocfs2_mknod(struct mnt_idmap *idmap,
>  
>  	brelse(new_fe_bh);
>  	brelse(parent_fe_bh);
> +	kfree(si.name);
>  	kfree(si.value);
>  
>  	ocfs2_acl_init_release(&acl_state);
> @@ -2068,6 +2069,7 @@ static int ocfs2_symlink(struct mnt_idmap *idmap,
>  
>  	brelse(new_fe_bh);
>  	brelse(parent_fe_bh);
> +	kfree(si.name);
>  	kfree(si.value);
>  	ocfs2_free_dir_lookup_result(&lookup);
>  	if (inode_ac)
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 35bcbb0ff607..d83840b6bed9 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -7524,8 +7524,9 @@ static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array
>  				    GFP_KERNEL);
>  		if (!si->value)
>  			return -ENOMEM;
> -
> -		si->name = xattr_array->name;
> +		si->name = kstrdup(xattr_array->name, GFP_KERNEL);
> +		if (!si->name)
> +			return -ENOMEM;

The ->name is a constant string (i.e., XATTR_NAME_SELINUX). We can refer to
ext4_initxattrs() => ext4_xattr_set_handle(), which also uses '=' to assign ->name.

Thanks,
Heming
>  		si->value_len = xattr_array->value_len;
>  		return 0;
>  	}
> -- 
> 2.43.0
> 
> 
