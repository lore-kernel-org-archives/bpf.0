Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A71501F42;
	Fri, 25 Sep 2026 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378614; cv=none; b=JTC2VwDUgAhDQcXsedyHnAuX49Oc+vkDmqNgz5b1pQwy3s8gP8esgE4NSN8qVG6QGAGIPcV0L1svtAlcuUmnvsGSTq1JR07jKNWouofgRTPoTPQ9MsWGa5aNVak5PtM+lcAguHZ0K6FP26tdsdp62OM8TIF5DWGC2r7ArQgOLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378614; c=relaxed/simple;
	bh=hAv8jObxcnBjDqNNkur8eLPjra5P2CLP93A4UwLEFY8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Fa9xJNnATs8U4mMPqdSZmtbEPTWk49ajrzZjWbPEzrtGJMPhLa2VCSlgUFh2PyA6DSLmthBbE2RJ3yq60sNnFQ/UnXKsH/xdj02n3lwe3icUxZd65ARrMcYhlkWn5zsDlsGaCxtckdB+SZ7lK6HkHTw0gijEC7/VI9DGaXzDHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTJOWn/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTJOWn/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2451F000FF;
	Fri, 25 Sep 2026 23:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790378612;
	bh=T/V3bcMjnEkcmmP/Kea8r2y7gjY8RFSsV8yWMux5xC4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eTJOWn/qxtRae3QC6gK2WO25Iq9BtVruL5Pk6FDiTm350GWkVbu66+8TKRO8J/Nls
	 10npCbI3X8ER3TEPt3O2A+EHF5AWdEmavfYBQkaTU7oiI69VQmKcdpIg+CtcnXZXta
	 rgiaZnf7IX8lbeCRc3lMYLb8y8jfkQuiX5n3xarDlOboSADXaF7Rvja/hoVtac93XV
	 Sj10FsX2mKqq6Z1bQT1ZUQl2rKrbG2jfRUQ5Dp+vztw51VxGZl/oh25UgIJrM26QCa
	 M6rgL7kfyf6iaMW3+UqDT1jNpCpI+D0/3ZlM8sgUpuDRKbJxEiiYyq07sK4O4mbtuf
	 AeY40gRYg+h0w==
Content-Type: multipart/mixed; boundary="===============6271081575194733281=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3541dcaa6eba351d0e66f2c324b2919453a7ad4f1a29170d8ce9b4435feeb0d8@mail.kernel.org>
In-Reply-To: <20260925224229.1850-8-wanjay@amazon.com>
References: <20260925224229.1850-8-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next v3 7/9] bpf: expose deferred .BTF.base module BTF in sysfs from module load
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,mcgrof@kernel.org,petr.pavlu@suse.com,samitolvanen@google.com,linux-modules@vger.kernel.org,ojeda@kernel.org,rust-for-linux@vger.kernel.org,arnd@arndb.de,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 23:23:31 +0000 (UTC)

--===============6271081575194733281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1dae1c9b53fe..64583fb1f380 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -9165,8 +9175,14 @@ static int btf_module_sysfs_add(struct btf_module *btf_mod, const char *name,
>  	return 0;
>  }
>
> +/*
> + * Called with btf_module_mutex NOT held: removing the sysfs file waits for
> + * readers to leave, and a deferred reader may need the mutex to get there.
> + */
>  static void btf_module_free(struct btf_module *btf_mod)
>  {
> +	WRITE_ONCE(btf_mod->gone, true);
> +	wake_up_all(&btf_module_wq);
>  	if (btf_mod->sysfs_attr)
>  		sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);

[ ... ]

> @@ -9221,15 +9237,57 @@ static int btf_vmlinux_module_coming(struct module *mod)
>  	return 0;
>  }
>
> +/*
> + * sysfs reader for a module kept aside with a .BTF.base section: its .BTF is
> + * split against the distilled base and only becomes valid split BTF against
> + * the vmlinux BTF once relocated, which rewrites the buffer in place.  So
> + * first make sure the vmlinux BTF is loaded (which parses and relocates the
> + * kept modules), then wait until this module's BTF is published.  The size
> + * does not change: relocation only rewrites ids and string offsets.
> + */
> +static bool btf_module_published(struct btf_module *btf_mod)
> +{
> +	/* Pairs with the smp_store_release() of @ready after btf_mod->btf is set */
> +	return smp_load_acquire(&btf_mod->ready);
> +}
> +
> +static ssize_t btf_module_sysfs_read_deferred(struct file *filp, struct kobject *kobj,
> +					      const struct bin_attribute *attr,
> +					      char *buf, loff_t off, size_t count)
> +{
> +	struct btf_module *btf_mod = attr->private;
> +	int err;
> +
> +	if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux()))
> +		return -ENODEV;

[ ... ]

> @@ -9393,8 +9454,10 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>  			if (btf_mod->btf)
>  				btf_free_id(btf_mod->btf);
>  			list_del(&btf_mod->list);
> +			mutex_unlock(&btf_module_mutex);
> +			/* off the list, nobody else can find it now */
>  			btf_module_free(btf_mod);
> -			break;
> +			goto out;
>  		}
>  		mutex_unlock(&btf_module_mutex);
>  		break;

Can btf_module_notify() deadlock here during MODULE_STATE_GOING?

The MODULE_STATE_GOING notifier runs from
blocking_notifier_call_chain(&module_notify_list, ...), which holds
module_notify_list.rwsem for read. This patch moves btf_module_free()
outside btf_module_mutex, and btf_module_free() calls
sysfs_remove_bin_file(), which waits uninterruptibly in kernfs_drain()
until every active reader has returned.

This patch made that reader btf_module_sysfs_read_deferred(), which
starts with:

    if (IS_ERR_OR_NULL(bpf_get_btf_vmlinux()))
            return -ENODEV;

If the vmlinux BTF has not been loaded yet, bpf_get_btf_vmlinux() calls
btf_vmlinux_data(&size, true), which calls request_module("btf_vmlinux").
That waits (UMH_WAIT_PROC | UMH_KILLABLE) for modprobe.

modprobe's load_module() calls prepare_coming_module(), which calls
blocking_notifier_call_chain_robust(&module_notify_list,
MODULE_STATE_COMING, ...) and needs down_read() on the same rwsem.

If a writer is queued on that rwsem, new readers block once the handoff
bit is set. Writers come from register_module_notifier() or
unregister_module_notifier(), called for example from kunit_init() when
kunit is modular, or from a module exit that unregisters its notifier.

The resulting cycle is:

  rmmod X (GOING, holds rwsem for read)
    -> kernfs_drain waits for the reader of /sys/kernel/btf/X

  reader of X
    -> request_module("btf_vmlinux") waits for modprobe

  modprobe btf_vmlinux
    -> down_read(module_notify_list.rwsem) waits for the queued writer

  writer
    -> down_write waits for rmmod X to release its read side

Everything stays in D state until the reader gets SIGKILL. Meanwhile
every other module load or unload also stalls on the notifier chain.

Before this patch, a deferred .BTF.base module had no sysfs file until
btf_parse_deferred_modules() had relocated it. No reader could block, so
the drain in GOING could not wait on a module load.

The new code conflicts with the rationale stated in btf_module_defer():
"The vmlinux BTF ... must not be loaded from the module notifier (that
would nest a module load into a module load)". The GOING notifier now
waits on exactly that nested load, through the reader.

Possible fixes: do not trigger the vmlinux BTF load from this reader
(serve -ENODEV/-EAGAIN until the BTF is published, or only wait when
btf_vmlinux is already set); or remove the sysfs file in a way that does
not wait under the notifier chain (for example,
kernfs_break_active_protection() in the reader around the
request_module()/wait, with the btf_mod lifetime guarded separately).

Also, this patch changes the lock ordering that affects a comment
elsewhere in the file. The comment for btf_vmlinux_regs_mutex justifies
the separate mutex by saying that purge_cand_cache() takes
cand_cache_mutex under btf_module_mutex. That was only true through
btf_module_free() on the GOING path, which this patch moves outside
btf_module_mutex (as shown above).

The remaining purge_cand_cache() callers, in btf_module_notify() COMING
and at the end of btf_parse_deferred_modules(), already run without
btf_module_mutex. No btf_module_mutex -> cand_cache_mutex chain is left,
so the stated reason for the ordering rule is gone.

The ordering that matters now is kernfs active reference ->
btf_vmlinux_lock/btf_module_mutex, which comes from the new deferred
sysfs reader. Should that comment be updated to reflect the current lock
ordering rationale?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36198628965
--===============6271081575194733281==--
