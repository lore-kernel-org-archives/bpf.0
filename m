Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6660417BDE;
	Wed, 23 Sep 2026 05:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142995; cv=none; b=kjOYD9y9NCAocxhelU+DV7t7E27k7Z/67mVPs26RsxRHTbLHonSg14mqyDTWIPo4eg1myTsRxoUdDOehJG99erf6nWpACadfW8H4UJ7BVlqVz/Yx2CXMkQcsSoWruM5qvBchh2mPy8Rw9ySyIJzcEtZUNERI5FGGa21v41ZY7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142995; c=relaxed/simple;
	bh=LHRkgYMGYHd5TOTDuAxn9X2OHHqe/hwOFFY9csHvISE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rUx/TvPY+MboaKNwAOGF0vzDSosjofj7nH2WZL3MP+Y0yX0iCZsh6Sq9AcXQ4lNq/ZKwHxL1BWkbWU7sHAJI/x9EhAyagR3Ek2HhOqq/OUSuPFg3iByiAfcSzqzqAj5KCZyu+6KZqgEdqf4fp7WIbXNxYqj/4LxmwX6ZiIsrJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vob0Q6dl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vob0Q6dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B74C1F000FF;
	Wed, 23 Sep 2026 05:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142993;
	bh=xT1ze2th8t0zSVXqxp9TifWt62vsAFgys063Qr9/o4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vob0Q6dluHJEZ3CWumGMxEECkOmz6m6KwfZbpCDqhfG6hvMbIr9/F73eiMOzuXir/
	 spdzIN3+MKAMYIVwyRmq13JtSuXayvK+62+phI6UVGv8l70H1UbgqCdolbNWf62EKd
	 04jxX3otRT7Rj3v1bLO97jtc4ODsGtUSxNI4CYCJ4owUq3oGAVVaqIB0kKntgvN/Rz
	 XDKMYt8ZoZsL+F/vn+sjkoXU3K9+p0eYHZr1oh7W2rMw2dVKgY59ECl3PeFVRnMZyz
	 w7Um4BSlKiOxgwHKL+H7/88z3DXA8sG/UlnsYriPH7radK2KbwGsi+5sUeCOvf2buR
	 CLnxLwdzJf5rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/6] bpf: defer registrations until the vmlinux
 BTF is available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260923053948.30617-6-wanjay@amazon.com>
References: <20260923053948.30617-1-wanjay@amazon.com>
 <20260923053948.30617-6-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 05:56:32 +0000
Message-Id: <20260923055633.5B74C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] bpf: UAF in sysfs reader on module BTF alloc ID failure
- [High] bpf: data corruption via un-synchronized kfunc registrations
- [Medium] bpf: race condition causes transient BPF program load failures
- [Medium] bpf: memory leak of vmlinux deferred queue on alloc ID failure
--

commit 7468b94a7c4356b1f1498b95a9030eec1830ffa1
Author: Jay Wang <wanjay@amazon.com>
Subject: bpf: defer registrations until the vmlinux BTF is available

This commit changes the BPF subsystem to defer kfunc, dtor kfunc, and
struct_ops registrations until the vmlinux BTF is parsed. This allows
configuring CONFIG_DEBUG_INFO_BTF as a module so it doesn't need to be pars=
ed
at boot if not required.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 50eb7a95fd825..cbba20a908e9d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -6581,7 +6583,15 @@ struct btf *btf_parse_vmlinux(void)
>  	if (err) {
>  		btf_free(btf);
>  		btf =3D ERR_PTR(err);
> +		goto err_out;
>  	}
> +
> +	/*
> +	 * With CONFIG_DEBUG_INFO_BTF=3Dm, kfunc, dtor kfunc and struct_ops
> +	 * registrations for vmlinux made before the BTF was available were
> +	 * queued; apply them now, before the BTF becomes visible to anyone.
> +	 */
> +	btf_apply_deferred_vmlinux_regs(btf);
>  err_out:
>  	btf_verifier_env_free(env);
>  	return btf;

[Severity: Medium]
When btf_alloc_id() fails, the code jumps to err_out, which bypasses the ca=
ll
to btf_apply_deferred_vmlinux_regs(). Does this leave the items in the
btf_vmlinux_deferred_regs queue stranded, causing a memory leak for those
dynamically allocated deferred registrations? Also, since
btf_vmlinux_regs_closed is never set, would subsequent registrations contin=
ue
to queue infinitely?

[ ... ]
> @@ -8905,6 +9033,87 @@ static int __init btf_module_init(void)
>  }
> =20
>  fs_initcall(btf_module_init);
> +
> +#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
> +/*
> + * CONFIG_DEBUG_INFO_BTF=3Dm: the vmlinux BTF has just become available.=
  Parse
> + * the BTF of the modules that were loaded before it, and apply the
> + * registrations that waited for them.  Called from bpf_get_btf_vmlinux()
> + * once btf_vmlinux is published, with no locks held.
> + */
> +void btf_parse_deferred_modules(void)
> +{
[ ... ]
> +		err =3D PTR_ERR_OR_ZERO(btf);
> +		if (!err) {
> +			err =3D btf_alloc_id(btf);
> +			if (err) {
> +				/* btf owns the data now, btf_free() drops it */
> +				btf_mod->data =3D NULL;
> +				btf_free(btf);
> +			}
> +		}
> +		if (err) {
> +			/*
> +			 * The module is loaded and stays.  Unlike at load time
> +			 * there is no way to reject it, so drop its BTF.
> +			 */
> +			pr_warn("failed to validate module [%s] BTF: %d\n",
> +				btf_mod->module->name, err);
> +			list_del(&btf_mod->list);
> +			btf_module_free(btf_mod);
> +			continue;
> +		}

[Severity: High]
Could the btf_free() call above introduce a use-after-free window for
concurrent sysfs readers? The backing buffer btf->data (which was originally
btf_mod->data) is freed by btf_free(). Even though btf_mod->data is set to
NULL, the sysfs file for the module remains active until btf_module_free()
removes it. If there is a concurrent read to /sys/kernel/btf/<module>, can =
it
dereference the freed attr->private pointer?

[ ... ]
> +		/* btf->data is btf_mod->data now, the sysfs file keeps working */
> +		btf_mod->data =3D NULL;
> +		kvfree(btf_mod->base_data);
> +		btf_mod->base_data =3D NULL;
> +		btf_mod->btf =3D btf;
> +		parsed =3D true;

[Severity: Medium]
Here btf_mod->btf is assigned, which makes the module BTF visible globally.
Since this happens before the deferred kfuncs and struct_ops are actually
registered, is there a race condition where a concurrent BPF program load
attempts to use this BTF, but fails verification because the kfuncs are not
yet in the module's kfunc_set_tab?

> +
> +		/*
> +		 * Registrations are applied after dropping the mutex (they
> +		 * walk btf_modules); pin what they need until then.
> +		 */
> +		list_for_each_entry_safe(reg, rtmp, &btf_mod->deferred_regs, list) {
> +			list_del(&reg->list);
> +			if (!try_module_get(btf_mod->module)) {
> +				btf_free_deferred_reg(reg);
> +				continue;
> +			}
> +			btf_get(btf);
> +			reg->btf =3D btf;
> +			reg->module =3D btf_mod->module;
> +			list_add_tail(&reg->list, &regs);
> +		}
> +	}
> +	mutex_unlock(&btf_module_mutex);
> +
> +	if (parsed)
> +		purge_cand_cache(NULL);
> +	btf_apply_deferred_regs(&regs);
> +}
> +#endif /* IS_MODULE(CONFIG_DEBUG_INFO_BTF) */

[Severity: High]
Is it possible for data corruption to occur here due to concurrent kfunc
registrations? Because the btf_module_mutex is dropped and btf_mod->btf has
already been set, a concurrent module initcall could perform a new
register_btf_kfunc_id_set(). Since btf_mod->btf is no longer NULL, it would
bypass the deferral queue and proceed to btf_kfunc_id_set_add() directly.

If btf_apply_deferred_regs() is running simultaneously, both paths could
concurrently invoke btf_populate_kfunc_set(), which mutates btf->kfunc_set_=
tab
without synchronization:

kernel/bpf/btf.c:btf_populate_kfunc_set() {
    ...
	/* Grow set */
	set =3D krealloc(tab->sets[hook],
		       struct_size(set, pairs, set_cnt + add_set->cnt),
		       GFP_KERNEL | __GFP_NOWARN);
	if (!set) {
		ret =3D -ENOMEM;
		goto end;
	}

	/* For newly allocated set, initialize set->cnt to 0 */
	if (!tab->sets[hook])
		set->cnt =3D 0;
	tab->sets[hook] =3D set;
    ...
}

Would this result in double-free or use-after-free on the krealloc, or lost
kfunc registrations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923053948.3061=
7-1-wanjay@amazon.com?part=3D5
