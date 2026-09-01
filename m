Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD3488748;
	Tue,  1 Sep 2026 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283495; cv=none; b=CFnbTyJibAviYi3ZPS9mfNu6T6ZZwyLWB2LE1l78mkpJ8ROWFHUImKXoargTRWrrRhBSG/Ol3dXigb3t1IijJfqwrk8D+zRMcFGy2lOkUqx+r0rjX9E/Hxazq40d4fPKLB89XR2+UXq6+WmZzV7SLHrBDVIc6eLJ03Us/QvH170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283495; c=relaxed/simple;
	bh=GU67VSfBNMggnQM/n+nO3RghpdMKKYMApESbIVWskkI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtlgSFemOYxthnrUAOu49ekdClQiYUSu0f/rTbwCyox7CiYh9ky0Wmq/ViTtn1smeDs15cmTjFJI41c78Nujfe2A5LKeGuMrg5ab/avzncoEgMjWXIs6+dey9wBx3jvtcwJyD8xudzSb8vMasySG4I9ms8QWutqvaOMrJfMdwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoBGn52l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoBGn52l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DF01F000E9;
	Tue,  1 Sep 2026 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283493;
	bh=PneaKwYmvSis+ERzA3fmasCeV+E0lJ5vEVfHPVNVaIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CoBGn52l8iMEVUf0WxgKUCISTSVoMwpVej3bGCr5PcBR2qKp689sFiK3x7br52F+j
	 Ash30JErB6nnUcZ0uaiPijJD9GaAyhzXBnnmetoLKamslL1QKeuoDNkpd/R+rXXAe6
	 fMUkGvYh088MuMVuCAPPUQcMjQFNYaftJc4eX0rkka7hNsUaRO7KhlB/XCPXLWnqNU
	 rFpJWdZoPdHIwNore+1DRM6kqHsTV1Yy/4gDv7rMqv7x7s3aa0BQYdalazTxr/5tUY
	 OhOdGKyCJnMUBcGTXNo5HKEb97W7jdzJndknx4cphh4MIRoPKRHoWL1RG/PXs4huoq
	 RyMRmX/qvxFmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 15/18] btf: Support
 CONFIG_DEBUG_INFO_BTF_INLINE=m
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: linux-modules@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260901165757.801449-16-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-16-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:24:53 +0000
Message-Id: <20260901172453.A9DF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unsafe lockless call to i_size_write() causes seqcount corruption =
on 32-bit SMP systems.
- [High] TOCTOU race in sysfs_btf_kernfs_read allows out-of-bounds kernel m=
emory read on module reload.
- [Medium] Reloading the btf_vmlinux_inline module permanently leaks the pr=
eviously allocated BTF inline data.
- [Medium] Unconditional dereference of btf_kobj->sd can lead to a boot-tim=
e kernel panic.
--

commit 79f9afc658508547f1298b89f81b2e99fe704e3c
Author: Alan Maguire <alan.maguire@oracle.com>

btf: Support CONFIG_DEBUG_INFO_BTF_INLINE=3Dm
   =20
Allow vmlinux BTF inline info to be delivered via a loadable
module btf_vmlinux_inline.ko; this reduces the vmlinux binary size.
A kernfs representation is created for vmlinux.inline which loads
the module on demand.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 3e5890aed2dba..2ac1f1d396608 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -8736,10 +8738,82 @@ enum {
>  };
> =20
>  #if IS_ENABLED(CONFIG_SYSFS)
> +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
> +static struct bin_attribute *vmlinux_inline_attr;
> +#endif
[ ... ]
> +static int sysfs_btf_kernfs_open(struct kernfs_open_file *of)
> +{
> +	struct bin_attribute *attr =3D of->kn->priv;
> +	size_t data_size;
> +	int err;
[ ... ]
> +	if (of->file) {
> +		struct inode *inode =3D file_inode(of->file);
> +
> +		if (inode)
> +			i_size_write(inode, data_size);

[Severity: High]
Does this code call i_size_write() locklessly?

On 32-bit SMP systems, calling i_size_write() without holding inode_lock(in=
ode)
can cause seqcount corruption. This can lead to infinite loops in i_size_re=
ad()
and a potential denial of service when unprivileged users concurrently open=
 the
sysfs file.

> +	}
> +	return 0;
> +}
> +
> +static ssize_t sysfs_btf_kernfs_read(struct kernfs_open_file *of, char *=
buf,
> +				     size_t bytes_requested, loff_t offset)
> +{
> +	struct bin_attribute *attr =3D of->kn->priv;
> +	void *data;
> +	size_t data_size;
> +
> +	data_size =3D smp_load_acquire(&attr->size);
> +	if (offset >=3D data_size)
> +		return 0;
> +	if (offset + bytes_requested > data_size)
> +		bytes_requested =3D data_size - offset;
> +	data =3D READ_ONCE(attr->private);
> +	memcpy(buf, data + offset, bytes_requested);

[Severity: High]
Can this TOCTOU race lead to an out-of-bounds read?

If a module reload triggers sysfs_btf_update() between the smp_load_acquire=
()
of attr->size and the READ_ONCE() of attr->private, the new data pointer co=
uld
be read while still using the old, potentially larger data_size. This might
allow a local user to extract out-of-bounds kernel memory via the memcpy().

> +
> +	return bytes_requested;
> +}
[ ... ]
> @@ -8755,7 +8829,18 @@ struct bin_attribute *sysfs_btf_add(const char *na=
me, void *data, size_t data_si
>  		err =3D -ENOMEM;
>  		goto err_free;
>  	}
> -	err =3D sysfs_create_bin_file(btf_kobj, attr);
> +	if (data_size > 0) {
> +		err =3D sysfs_create_bin_file(btf_kobj, attr);
> +	} else {
> +		struct kernfs_node *node;
> +
> +		node =3D __kernfs_create_file(btf_kobj->sd, attr->attr.name,

[Severity: Medium]
Is it possible for btf_kobj to be NULL here?

If btf_kobj failed to allocate during btf_sysfs_init() and sysfs_btf_add() =
is
called with data_size =3D=3D 0 for vmlinux.inline, this unconditional deref=
erence
of btf_kobj->sd could lead to a boot-time kernel panic.

> +					    attr->attr.mode, GLOBAL_ROOT_UID,
> +					    GLOBAL_ROOT_GID, data_size,
> +					    &sysfs_btf_kernfs_ops, attr, NULL, NULL);
> +		if (IS_ERR(node))
> +			err =3D PTR_ERR(node);
> +	}
[ ... ]
> @@ -8775,6 +8860,17 @@ struct bin_attribute *sysfs_btf_add(const char *na=
me, void *data, size_t data_si
>  }
>  #endif
> =20
> +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
> +static void sysfs_btf_update(struct bin_attribute *attr, void *data, siz=
e_t data_size)
> +{
> +	if (!attr)
> +		return;
> +	WRITE_ONCE(attr->private, data);

[Severity: Medium]
Does this overwrite attr->private without freeing the previous allocation?

When the btf_vmlinux_inline module is reloaded, this appears to permanently
leak the previously allocated BTF inline data pointer.

> +	/* Publish data before its non-zero size makes it readable. */
> +	smp_store_release(&attr->size, data_size);
> +}
> +#endif
[ ... ]
> @@ -8872,6 +8968,14 @@ static int btf_module_notify(struct notifier_block=
 *nb, unsigned long op,
>  				err =3D 0;
>  				goto out;
>  			}
> +			if (strcmp(mod->name, "btf_vmlinux_inline") =3D=3D 0) {
> +				if (vmlinux_inline_attr)
> +					sysfs_btf_update(vmlinux_inline_attr, data,
> +							 mod->btf_inline_data_size);

[Severity: Medium]
Does this bypass assigning the data pointer to the module's tracking struct?

Because btf_mod->btf_inline_data is left NULL in this branch, the newly
allocated data won't be cleaned up when the module is unloaded, further
contributing to the memory leak on module reload.

> +				else
> +					kvfree(data);
> +				break;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D15
