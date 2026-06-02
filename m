Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB4318EC7;
	Tue,  2 Jun 2026 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423631; cv=none; b=aHqkTLcDUJN79mfEf6swBc/R25bkwDrr20h5xau1xRWaJkl7KmFFT4M8c63bA/uRdK8hYpROMsx4t+0/B5ORhD7wZsaP9Seqp53ZsFtaEIDomHVy7nC2LoIkWwcgmM3lfbGWdVzIu/nrQgOQzIaofM8Nwcx3ZOUdHAvWik4jU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423631; c=relaxed/simple;
	bh=OGD51iUUcdjLYmtrRnDKMhV6wAGiWl9aowZnjw3Ixco=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oX8MI/tXwW4Bw69AMhHz49GEAilKyuoGRiyTfa0WYoT10rtvvZtbIgPxHqjh7miQHq1+vEImk/j2JPg1QB/XV3ShOD3WJ4knqAfU2+bUpZT/QXEHh7HfvRT83iER7kLUNTo+5/FCfK2WA2VyRdwAXCGKrpNqZcY0unyyHnKT2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeE+vQpL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeE+vQpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1862A1F00893;
	Tue,  2 Jun 2026 18:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780423630;
	bh=4jJh0cKSE8u/V+ixT1FKdXTK909m+SXyrHFFpR9tr/0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JeE+vQpLg7X+LCjLIiT1xe60qhbDh3q8L27y6ld3Re1FGnLeSOv+8oXt9BxyzH9rI
	 wCqgF2zdgrt+0UdZ33Oub/4PHm/oPpuzqqiLGExqpCgNZdmuem8eyXAXZlC3WDXT3Q
	 jxIOale1rxo9yhLFCxs0BwJr0efojbuiqOGRr9mzyax3SmRB4wIaYi6qzmHaF1m9Lm
	 KGMzTpHmhg+fsTYH9RjR4kJ0QythkI/JNA24CyPjdb3JEVv/OG0V9Pbd9Azu4lS/Pu
	 6OLInwv48KQWyLWS4ksU11Lf19rLpL7nm5eosFGBfXDr2WIO1Gqls9HfyiW1SH0c0W
	 G9Y/YhRHhDp9g==
Content-Type: multipart/mixed; boundary="===============2905697061831733873=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d6910a31663ac3d869938f85fe1dd523be21d30ebbde644222275122cf4e678@mail.kernel.org>
In-Reply-To: <20260602074012.416289-1-daniel@iogearbox.net>
References: <20260602074012.416289-1-daniel@iogearbox.net>
Subject: Re: [PATCH vfs/vfs-7.2.xattr v3] bpf: Add simple xattr support to bpffs
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,brauner@kernel.org
Cc: alexei.starovoitov@gmail.com,bpf@vger.kernel.org,linux-fsdevel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 18:07:10 +0000 (UTC)

--===============2905697061831733873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/fs/xattr.c b/fs/xattr.c
> index 09ecbaaa1660..a7abb39f0041 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1689,6 +1689,39 @@ static void simple_xattr_ht_free(void *ptr, void *arg)
>  	simple_xattr_free(xattr);
>  }
>
> +/**
> + * simple_xattr_add_limited - add an xattr object, charging per-inode limits
> + * @cache: anchor for the hash table
> + * @xattrs: the header of the xattr object
> + * @limits: per-inode limit counters
> + * @new_xattr: the xattr object to add
> + *
> + * Like simple_xattr_add(), but also accounts @new_xattr against @limits so
> + * that a later removal or replacement of it through simple_xattr_set_limited()
> + * decrements counters that were actually incremented, rather than underflowing
> + * them. Use this instead of simple_xattr_add() when seeding initial xattrs
> + * that share a namespace with the limited set/remove path.
> + *
> + * Return: On success zero is returned. On failure a negative error code is
> + * returned.
> + */
> +int simple_xattr_add_limited(struct simple_xattr_cache *cache,
> +			     struct list_head *xattrs,
> +			     struct simple_xattr_limits *limits,
> +			     struct simple_xattr *new_xattr)
> +{
> +	int err;
> +
> +	err = simple_xattr_limits_inc(limits, new_xattr->size);
> +	if (err)
> +		return err;
> +
> +	err = simple_xattr_add(cache, xattrs, new_xattr);
> +	if (err)
> +		simple_xattr_limits_dec(limits, new_xattr->size);
> +	return err;
> +}

Does simple_xattr_add() accept three arguments here? Looking at the existing
simple_xattr_add() signature in include/linux/xattr.h:

int simple_xattr_add(struct simple_xattrs *xattrs,
		     struct simple_xattr *new_xattr);

The in-tree function takes only two arguments with a single struct
simple_xattrs pointer. However, this new code is calling it with three
arguments of different types:

err = simple_xattr_add(cache, xattrs, new_xattr);

where cache is a struct simple_xattr_cache * and xattrs is a struct
list_head *. The existing implementation uses a rhashtable internally
(struct simple_xattrs contains struct rhashtable ht), not a separate cache
and list_head pair. Won't this fail to compile due to the argument count
and type mismatches?

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4b703c90ca9..434ba91401c6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -31,6 +31,7 @@
>  #include <linux/static_call.h>
>  #include <linux/memcontrol.h>
>  #include <linux/cfi.h>
> +#include <linux/xattr.h>
>  #include <asm/rqspinlock.h>
>
>  struct bpf_verifier_env;
> @@ -1918,6 +1919,8 @@ struct bpf_mount_opts {
>  	u64 delegate_maps;
>  	u64 delegate_progs;
>  	u64 delegate_attachs;
> +
> +	struct simple_xattr_cache xa_cache;
>  };

Is struct simple_xattr_cache defined anywhere? Looking through
include/linux/xattr.h, the VFS simple_xattr infrastructure defines struct
simple_xattrs, struct simple_xattr, and struct simple_xattr_limits, but
there is no struct simple_xattr_cache type. Embedding an undefined struct
by value would be a compile error. Are the VFS xattr headers expected to
provide this type?

> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 8b6601367eae..5ee49199eb22 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -154,6 +154,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  			  char *buffer, size_t size);
>  int simple_xattr_add(struct simple_xattrs *xattrs,
>  		     struct simple_xattr *new_xattr);
> +int simple_xattr_add_limited(struct simple_xattr_cache *cache,
> +			     struct list_head *xattrs,
> +			     struct simple_xattr_limits *limits,
> +			     struct simple_xattr *new_xattr);
>  int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name);

Following up on the previous point - this declaration references struct
simple_xattr_cache in its first parameter, but that type is not defined in
this header or anywhere else in the tree. Won't this create an incomplete
type that causes compilation failures when the function implementation
attempts to dereference the cache pointer?

Looking at other simple_xattr functions like simple_xattr_get/set/list, they
all take struct simple_xattrs * as their first parameter rather than a
separate cache pointer and list_head. Was there a separate patch series that
introduces the cache-based API that this depends on?

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 25c06a011825..c3f79b5a2f8c 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c

[ ... ]

> @@ -762,22 +822,147 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
>  	return 0;
>  }

[ ... ]

>  static void bpf_destroy_inode(struct inode *inode)
>  {
> +	struct bpf_mount_opts *opts = inode->i_sb->s_fs_info;
> +	struct bpf_fs_inode *bi = BPF_FS_I(inode);
>  	enum bpf_type type;
>
> -	if (S_ISLNK(inode->i_mode))
> -		kfree(inode->i_link);
>  	if (!bpf_inode_type(inode, &type))
>  		bpf_any_put(inode->i_private, type);
> -	free_inode_nonrcu(inode);
> +	simple_xattrs_free(&opts->xa_cache, &bi->xattrs, NULL);
>  }

Does simple_xattrs_free() take three arguments? Looking at the in-tree
implementation, simple_xattrs_free takes two parameters:

void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space)

But this call is passing three arguments: a cache pointer, a list_head
pointer, and NULL. This appears to be the same API mismatch - won't this
fail to compile?

Similarly, throughout the bpffs xattr handlers (bpf_fs_xattr_get,
bpf_fs_xattr_set, bpf_fs_listxattr, bpf_fs_initxattrs), the code is calling
simple_xattr functions with an extra leading &opts->xa_cache parameter:

simple_xattr_get(&opts->xa_cache, &bi->xattrs, name, value, size)
simple_xattr_set(&opts->xa_cache, &bi->xattrs, name, ...)
simple_xattr_set_limited(&opts->xa_cache, &bi->xattrs, &bi->xlimits, ...)
simple_xattr_list(inode, &BPF_FS_I(inode)->xattrs, buf, size)
simple_xattr_add_limited(&opts->xa_cache, &bi->xattrs, &bi->xlimits, ...)

where bi->xattrs is a struct list_head. However, the existing VFS functions
expect struct simple_xattrs * as their first parameter (a structure
containing an rhashtable, not a list_head). For comparison, fs/kernfs/inode.c
uses simple_xattr_set_limited like:

simple_xattr_set_limited(xattrs, &attrs->xattr_limits, ...)

with just the struct simple_xattrs pointer. Are all these calls expecting a
different API than what currently exists in fs/xattr.c?

[ ... ]

> @@ -1068,6 +1266,7 @@ static void bpf_kill_super(struct super_block *sb)
>  	struct bpf_mount_opts *opts = sb->s_fs_info;
>
>  	kill_anon_super(sb);
> +	simple_xattr_cache_cleanup(&opts->xa_cache);
>  	kfree(opts);
>  }

Is simple_xattr_cache_cleanup() defined? A tree-wide search doesn't show any
definition of this function - only this call site. Won't this cause an
undefined reference at link time?

All of these issues appear related: the patch adds a cache-based simple_xattr
API (struct simple_xattr_cache, simple_xattr_add_limited with cache
parameter, simple_xattr_cache_cleanup) and calls it throughout the bpffs
xattr handlers, but the VFS side (fs/xattr.c and include/linux/xattr.h) only
partially implements this API. The struct simple_xattr_cache type is never
defined, simple_xattr_add_limited's implementation calls the two-argument
simple_xattr_add with three arguments, and simple_xattr_cache_cleanup is
never defined. Does this depend on a separate VFS xattr rework that hasn't
been included?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26835946342
--===============2905697061831733873==--
