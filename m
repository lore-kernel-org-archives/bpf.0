Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ADF48167D;
	Tue,  1 Sep 2026 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283799; cv=none; b=uCg9i5bXIfJuEvXWOxPqqtz516Ctyru+UpkvqjwjTFAoBlBDAUUEU/mL4FQNEEd4+K3uVEdNOXZ+zL4G0P3CVY9OEplXV16NFTn1az2VmPYS9hCNMAyMbnqgyGLIpXmnCnbubC95AcLvWa9oInwc6NX/V9OmcsK4fS+er/zUKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283799; c=relaxed/simple;
	bh=w5XdkzyVSLTkF+iAw7JRVdLMw4O1EFjrO43Ght9Jykg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YwdEvgWD3UNeTPd1ekT+S8tarCpRKrWOM8EqD837g4SCHTqQou46JA5FSyUhx/t+VcNHyHGpwxwzqazBb7YjlUtC/rl7wdMwFV09lBgGtR7XOsLR1zNCfFvdgi67cPQD8LYZFT6YcKfEo+4TkFhr9ITkC5kNS01MQdTPg0MMkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhwPJyB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhwPJyB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316581F000E9;
	Tue,  1 Sep 2026 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283798;
	bh=m3t/5sl1ZXo4/LntQYZWlqlzIn+j3MPRvGQfZbv3b4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dhwPJyB5FHpRg5O/2R5cKZODJuxZpB0uVY2rTW1AJSl6ToHc9IpHr/P+ZolWGOHPv
	 dIIJIvxKHgi77Jgn5VUO0OSepdiXiSkzks9F8ug+WSrCQIThfF2q7SYpWs647nRMzi
	 ZgCUxdKkeG6n9nnK82xZ8j5z4UdkgNOmaJ08jP4pmm1EAHF6T1J6KGiT2GPX1+GAT/
	 YaovuvYw8t0Gt0H4Y2ASAF65PbxbSKNakhiM39VHFJ7Fetug7b1MsxTLFkUhkNb4NI
	 jKbZ8Mb2DZjp09bUH2YaY2rtjuO66nbqXAVNC5nlFwY7UTp3uRyDldTRXS/beGd+bO
	 NjG5F4bCT09HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 16/18] btf: Relocate inline BTF for modules
 with distilled base BTF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: linux-modules@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260901165757.801449-17-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-17-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:29:57 +0000
Message-Id: <20260901172958.316581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Kernel panic via unconditional btf_free(NULL) on error path
- [Medium] Memory leak of vmlinux.inline sysfs attribute data across module=
 unloads and reloads
- [Medium] Concurrent updates and reads of `vmlinux.inline` BTF sysfs data =
can cause an out-of-bounds read
--

commit aad19c968ab1d821749bb6d06563d7c786f0721d
Author: Alan Maguire <alan.maguire@oracle.com>

btf: Relocate inline BTF for modules with distilled base BTF

This commit adds support for parsing, relocating, and publishing inline BTF
for modules that use a distilled base BTF. It parses the module's inline
BTF relative to the original module BTF, rewrites the IDs and string
offsets, and ensures a failure to process inline BTF doesn't block the
regular module BTF registration.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 2ac1f1d396608..2f3e8cea7dfcd 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -6727,15 +6727,140 @@ __u32 btf_relocate_id(const struct btf *btf, __u=
32 id)
[ ... ]
>  errout:
> +	kvfree(module_str_map);
>  	btf_verifier_env_free(env);
> +	btf_free(inline_btf);
>  	if (!IS_ERR(base_btf) && base_btf !=3D vmlinux_btf)
>  		btf_free(base_btf);
> -	if (btf) {
> -		kvfree(btf->data);
> -		kvfree(btf->types);
> -		kfree(btf);
> -	}
> +	btf_free(btf);

[Severity: High]
Is it safe to unconditionally call btf_free() on these pointers here?

If btf_parse_split() returns an error, btf or inline_btf can be NULL before
jumping to errout. Looking at btf_free(), it immediately passes the pointer
to btf_free_struct_meta_tab(), which dereferences it without checking for
NULL:

static void btf_free(struct btf *btf)
{
	btf_free_struct_meta_tab(btf);
...
static void btf_free_struct_meta_tab(struct btf *btf)
{
	struct btf_struct_metas *tab =3D btf->struct_meta_tab;

Could this lead to a NULL pointer dereference and a kernel panic during an
error path?


>  	return ERR_PTR(err);
>  }
[ ... ]
> @@ -8958,32 +9104,26 @@ static int btf_module_notify(struct notifier_bloc=
k *nb, unsigned long op,
>  		btf_mod->sysfs_attr =3D attr;
> =20
>  #if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE)
> -		if (mod->btf_inline_data_size > 0) {
> +		if (relocated_inline_data) {
>  			char name[MODULE_NAME_LEN + sizeof(".inline")];
> =20
>  			if (strcmp(mod->name, "btf_vmlinux_inline") =3D=3D 0) {
>  				if (vmlinux_inline_attr)
> -					sysfs_btf_update(vmlinux_inline_attr, data,
> -							 mod->btf_inline_data_size);
> +					sysfs_btf_update(vmlinux_inline_attr,
> +							 relocated_inline_data, inline_data_size);

[Severity: Medium]
Could the concurrent update of this sysfs attribute cause an out-of-bounds
read?

Looking at sysfs_btf_update(), the new pointer is written before the new
size:

static void sysfs_btf_update(struct bin_attribute *attr, void *data,
                             size_t data_size)
{
	...
	WRITE_ONCE(attr->private, data);
	smp_store_release(&attr->size, data_size);
}

If a concurrent reader in sysfs_btf_kernfs_read() picks up the old, larger
size via smp_load_acquire(), but then reads the newly updated pointer from
attr->private via READ_ONCE(), wouldn't the subsequent memcpy() read
out-of-bounds past the end of the new, smaller data buffer?


>  				else
> -					kvfree(data);
> +					kvfree(relocated_inline_data);
> +				btf_mod->btf_inline_data =3D NULL;

[Severity: Medium]
Does setting btf_mod->btf_inline_data to NULL here cause a memory leak when
the btf_vmlinux_inline module is unloaded?

Because it's set to NULL, the normal cleanup path in btf_module_notify()
won't free it. Then, if the module is reloaded, sysfs_btf_update() will
overwrite the vmlinux_inline_attr->private pointer with a new allocation,
leaving the old relocated_inline_data stranded.


>  				break;
>  			}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D16
