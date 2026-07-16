Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC43C3F76
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238919; cv=none; b=Tme0e1TU8+EJq7qZVfDCcAX1s0iXTDI3hokU/H0VC2sebLR6TEA+ZiqhllLZQMCSZ1qXpXWpWKJSC52r6Pl511PlWTCmStPn4aPbNS/r/1j/Vk1r0bPlWImMOlvLjanx1xHkGpsvbMGIpJuqAZeat9mUm4ZyI8+CMH+S71MgCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238919; c=relaxed/simple;
	bh=Y7QT/z8tGhHeuhj94SZCfq0isVdadvA6fmfBR+qwY+c=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=aSWIEs9T/vIhNCVaP/PzwTdRmJQe6+ctO1cJYsHGcSIwkeuskCsqzR9IUvzvftS22loBtxi7WfRCNtiEbJidbctKmCewkZCTWLz+Cn+0UbbkUYQ0yuDfo7mE+dmrNRzKATLCzPlIUm5SH3SG+X2hxQMV4nhamfyxezRp62VHVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QEBsnEUc; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QEBsnEUc"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c2b2c9eccso51731121cf.2
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784238915; x=1784843715; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ESnqIrxhVsIPeRHe4fD4n3nEQ5qHjOKJcorrN5crBo=;
        b=QEBsnEUcN4vveLo9AfEJq73S+lQZb2EznLt8gWeiD1XX0ryM03nsfrd+5z9fiMyaR8
         V9a1iXEIdaaswM8ul+/SzOBmHVpE6cPU6xA+s92KWenH6yG9RBu54OcqIzwkQhwVXkh/
         X4qkY14xTDtpJwA9O0/q7H/yKv/jzhW1ZteGdHx49KfzxND+Y57cGthHRpFdklIPcSAr
         RiBRGl+ImotCRR7NzOxSWXGVM0/X44QG9WgbeGlPyt0Oa9XSGz+Cr7D4LgFqzrqeDypb
         /6/4O+HVXXE7GK3I137UBEdb8rYf0hjooFuIXndVKuNtA3kTHY2EJQMSSAixk3rS8a/d
         bFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784238915; x=1784843715;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ESnqIrxhVsIPeRHe4fD4n3nEQ5qHjOKJcorrN5crBo=;
        b=acweWbHf+7tYiMhyoViVa8gcp9p/8qadtrF8cikyKV9uNYsQR79Dk1Y3kpWe5prVpZ
         MBm8Kbp64z+u2aKOb+nbJ8HL5Fn/vb6Is5BsZMrm75vej6IA0D+KhecWMM9z3fzG2b0q
         /FWgTcT4FA8SXF2+kFMYl52g3i5q+D5my2SEZl3YYNObR5stMNoT0A7eR9F84UjwS8Fy
         1rl7NOpScCDqCZwzz4BPifrB4kI0IDzsFH9m91w/CyeEXAZjtziAUFcPP4iZofOUS2IM
         nWX87DrfWNAJdDIJQ45MEF5E252YJuYHAM7EteTykBL1wVaFRoIyt2rTmvG+qHHYOJ4l
         ucdQ==
X-Gm-Message-State: AOJu0YxiiF3RVq4uWJF1YSW4GHP5fvd2935Rw2UzL8awno0AfrTM/yko
	GLK95pnwrZF4ldOt76O+XBpodsrUu7PZa5++QXl2Bm+fZ3GG0HMSE1DlI6oVrjoGQNUsyAq/be7
	sjOU=
X-Gm-Gg: AfdE7ckXuXmNTuCuGOYynhHzAOcPIpu5JCm/8cW7OtApNc1xqlNeZ2o70wn5lkJuZih
	AfXni7EUdU3+Un3/Cq3xjEvLREbUMY/ZHWDBHIlXzlcDTTrk0BrJfhAoid6Ovp3iUTtOkkFCbOr
	Y3LRADrEtXwEAW57PE+6qVwRZysOXw1LQVATFgG6d27Dj+IK0fZZyheRj1pb7Af2ZTn/IrhyrK+
	0i4n1zHaE+qeRKurv7cjV53lzUz2/ey7PKp41SU52gfmy9Qy97ghtHJ1N5U+ttr4NiyEvdUVLkk
	115nUIAxG1R1KhbozZvL9uG4fQY9ewPrbCCW+YbKK+YnCD6tG/zas2CH+NIcyIQDVpX8IsD5Uga
	cp1gRiUX6KpsG0HKvSFmJrlb0p/UnA1ZNewqnhAQtKQoEvLxptNtq8Z6rrYq3q9bAk0dCynoRMn
	97yrsXnOvat3f1gdDpXTVoVhFAMBWdB4yCsDsJGLUaOCL6/9o=
X-Received: by 2002:a05:622a:281:b0:51c:7b12:5fe9 with SMTP id d75a77b69052e-51e424c1e45mr137041111cf.85.1784238914880;
        Thu, 16 Jul 2026 14:55:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56bf455sm226276746d6.13.2026.07.16.14.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 14:55:13 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:55:12 -0400
Message-ID: <cb9f84292a7f1d41ff8388d8c0c8c3d0@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260715_1900/pstg-lib:20260715_1853/pstg-pwork:20260715_1900
From: Paul Moore <paul@paul-moore.com>
To: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, David Windsor <dwindsor@gmail.com>
Subject: Re: [PATCH v5 1/3] security: rework inode_init_security xattr handling
References: <20260708000956.46138-2-dwindsor@gmail.com>
In-Reply-To: <20260708000956.46138-2-dwindsor@gmail.com>

On Jul  7, 2026 David Windsor <dwindsor@gmail.com> wrote:
> 
> In preparation for bpf_init_inode_xattr(), a kfunc that lets bpf LSM
> programs atomically label new inodes, rework how inode_init_security
> xattrs are managed.
> 
> inode_init_security receives the LSM xattr array and its count as
> separate parameters. For better compatibility with the bpf verifier,
> update inode_init_security and its callers to consolidate these
> parameters into a single context object: struct lsm_xattrs.
> 
> Also, add security_lsmxattr_add(), which claims a slot in the
> inode_init_security xattr array on behalf of the calling LSM and
> fills it with a copy of the given name and value.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  include/linux/bpf_lsm.h           |   3 +
>  include/linux/evm.h               |   9 +--
>  include/linux/lsm_hook_defs.h     |   4 +-
>  include/linux/lsm_hooks.h         |  16 ++---
>  include/linux/security.h          |  15 +++++
>  security/bpf/hooks.c              |   1 +
>  security/integrity/evm/evm_main.c |   8 ++-
>  security/security.c               | 108 ++++++++++++++++++++++++++----
>  security/selinux/hooks.c          |   4 +-
>  security/smack/smack_lsm.c        |  27 ++++----
>  10 files changed, 148 insertions(+), 47 deletions(-)

...

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 153e9043058f..647f7b88358b 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -68,6 +68,11 @@ struct watch;
>  struct watch_notification;
>  struct lsm_ctx;
>  
> +struct lsm_xattrs {
> +	struct xattr *xattrs;
> +	unsigned int xattr_count;
> +};

Please separate out the 'struct lsm_xattrs' related changes into a
separate patch from the security_lsmxattr_add() changes.  I know they
are related, but they are different things.

> diff --git a/security/security.c b/security/security.c
> index 71aea8fdf014..261f68e17cfd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -12,6 +12,7 @@
>  #define pr_fmt(fmt) "LSM: " fmt
>  
>  #include <linux/bpf.h>
> +#include <linux/bpf_lsm.h>
>  #include <linux/capability.h>
>  #include <linux/dcache.h>
>  #include <linux/export.h>
> @@ -1333,8 +1334,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  				 const initxattrs initxattrs, void *fs_data)
>  {
>  	struct lsm_static_call *scall;
> -	struct xattr *new_xattrs = NULL;
> -	int ret = -EOPNOTSUPP, xattr_count = 0;
> +	struct lsm_xattrs xattrs = {};
> +	int ret = -EOPNOTSUPP;
>  
>  	if (unlikely(IS_PRIVATE(inode)))
>  		return 0;
> @@ -1344,15 +1345,15 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  
>  	if (initxattrs) {
>  		/* Allocate +1 as terminator. */
> -		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
> -				     sizeof(*new_xattrs), GFP_NOFS);
> -		if (!new_xattrs)
> +		xattrs.xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
> +					sizeof(*xattrs.xattrs), GFP_NOFS);
> +		if (!xattrs.xattrs)
>  			return -ENOMEM;
>  	}
>  
>  	lsm_for_each_hook(scall, inode_init_security) {
> -		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
> -						  &xattr_count);
> +		ret = scall->hl->hook.inode_init_security(inode, dir, qstr,
> +							  &xattrs);
>  		if (ret && ret != -EOPNOTSUPP)
>  			goto out;
>  		/*
> @@ -1364,18 +1365,101 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  	}
>  
>  	/* If initxattrs() is NULL, xattr_count is zero, skip the call. */
> -	if (!xattr_count)
> +	if (!xattrs.xattr_count)
>  		goto out;
>  
> -	ret = initxattrs(inode, new_xattrs, fs_data);
> +	ret = initxattrs(inode, xattrs.xattrs, fs_data);
>  out:
> -	for (; xattr_count > 0; xattr_count--)
> -		kfree(new_xattrs[xattr_count - 1].value);
> -	kfree(new_xattrs);
> +	for (; xattrs.xattr_count > 0; xattrs.xattr_count--)
> +		kfree(xattrs.xattrs[xattrs.xattr_count - 1].value);
> +	kfree(xattrs.xattrs);
>  	return (ret == -EOPNOTSUPP) ? 0 : ret;
>  }
>  EXPORT_SYMBOL(security_inode_init_security);
>  
> +#ifdef CONFIG_BPF_LSM
> +static unsigned int lsm_xattrs_used(const struct lsm_xattrs *xattrs,
> +				    const char *prefix)
> +{
> +	size_t prefix_len = strlen(prefix);
> +	unsigned int i, n = 0;
> +
> +	for (i = 0; i < xattrs->xattr_count; i++) {
> +		const char *name = xattrs->xattrs[i].name;
> +
> +		if (name && !strncmp(name, prefix, prefix_len))
> +			n++;
> +	}
> +	return n;
> +}
> +#endif /* CONFIG_BPF_LSM */

More on this below, but this function isn't strictly BPF LSM related so
let's drop the CONFIG_BPF_LSM macro bracketing.

> +/**
> + * security_lsmxattr_add() - Add an xattr during inode_init_security
> + * @xattrs: xattr state shared by inode_init_security hooks
> + * @lsm_id: LSM_ID_* value identifying the calling LSM
> + * @name: xattr name suffix

For BPF you currently pass "bpf.foo" for the name and other LSMs would
pass their own xattr name, likely without a LSM specific sub-namespace
(for example, SELinux would be just "selinux").  In both cases the
'name' parameter always starts with a well known suffix as defined by
the 'lsm_id" parameter.

Since we are already passing the lsm_id parameter, let's do away with
the standard LSM suffixes, e.g. XATTR_BPF_LSM_SUFFIX, and just pass in
any additional name components.  For example, instead of passing
"bpf.foo" in the BPF LSM case, you would just pass "foo"; LSMs without
their own sub-namespace, e.g. SELinux, would pass NULL for the name
parameter as XATTR_SELINUX_SUFFIX is all that is needed.  While doing
this I would also suggest changing the name of the 'name' parameter to
'name_extra', 'namespace_extra', or something similar to indicate that
it isn't the full name, but rather an additional suffix beyond the
standard suffix associated with the given LSM.

> + * @value: xattr value
> + * @value_len: length of @value
> + *
> + * Claim an xattr slot in @xattrs on behalf of the LSM identified by
> + * @lsm_id and fill it with a copy of @name and @value. Callers can invoke
> + * this function from non-sleepable context.
> + *
> + * Return: Returns 0 on success, -ENOSPC if the calling LSM's slot budget
> + *         is exhausted, negative values on other errors.
> + */
> +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> +			  const char *name, const void *value,
> +			  size_t value_len)
> +{
> +	struct xattr *xattr;
> +	void *xattr_value;
> +	size_t name_len;
> +
> +	if (!xattrs || !xattrs->xattrs || !name || !value)
> +		return -EINVAL;

Sashiko raised a good point about xattrs->xattrs being NULL not
necessarily being a good reason for -EINVAL.  If xattrs is NULL, yes,
something has gone wrong and -EINVAL seems reasonable, but the
xattr->xattrs NULL case does seem like it should simply return early
with a value of 0 (see SELinux's handling of this case as an example).

> +	name_len = strlen(name);
> +	if (name_len == 0 || name_len > XATTR_NAME_MAX)
> +		return -EINVAL;
> +	if (value_len == 0 || value_len > XATTR_SIZE_MAX)
> +		return -EINVAL;
> +
> +	switch (lsm_id) {
> +#ifdef CONFIG_BPF_LSM
> +	case LSM_ID_BPF:
> +		if (lsm_xattrs_used(xattrs, XATTR_BPF_LSM_SUFFIX) >=
> +		    BPF_LSM_INODE_INIT_XATTRS)
> +			return -ENOSPC;
> +		break;
> +#endif /* CONFIG_BPF_LSM */

I like to avoid macro conditional code inside functions whenever
possible, and I think this is a case where we could avoid the conditional
block with a little work.

The LSM_ID_BPF macro is already defined as part of the UAPI so that will
always be available.  While BPF_LSM_INODE_INIT_XATTRS is dependent on
CONFIG_BPF_LSM in this revision, that should be easy enough to move
outside the CONFIG_BPF_LSM conditional in bpf_lsm.h.  Eventually we
should probably expand the lsm_id struct to carry this info, likely just
a permanent/local copy of the LSM's lsm_blob_sizes passed during
registration, but I can take care of that later; just make the
BPF_LSM_INODE_INIT_XATTRS macro always accessible now.

We should also probably record the xattr suffix/length when the LSM is
registered, but that can also be done later with the other lsm_id
additions.

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Combine xattr value + name into one allocation. */
> +	xattr_value = kmalloc(value_len + name_len + 1, GFP_NOWAIT);
> +	if (!xattr_value)
> +		return -ENOMEM;
> +
> +	memcpy(xattr_value, value, value_len);
> +	memcpy(xattr_value + value_len, name, name_len);
> +	((char *)xattr_value)[value_len + name_len] = '\0';

You'll need to add an additional memcpy() here, likely in a switch
statement to handle the different LSMs, to copy over the LSM specific
prefix.  It's a little ugly, but when we have things captured in the
lsm_id struct it will get a lot cleaner.

> +	xattr = lsm_get_xattr_slot(xattrs);
> +	if (!xattr) {
> +		kfree(xattr_value);
> +		return -ENOSPC;
> +	}
> +
> +	xattr->value = xattr_value;
> +	xattr->name = (const char *)xattr_value + value_len;
> +	xattr->value_len = value_len;
> +
> +	return 0;
> +}

--
paul-moore.com
