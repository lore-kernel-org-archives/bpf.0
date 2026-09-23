Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABCF415F00;
	Wed, 23 Sep 2026 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145690; cv=none; b=GO2kbRirEh12DD3zA8l8sNiuOYbKIrzWOjf7nZxjCJPgIUQqy54LlASZx+ZcYFbm1bO2a6LCR9jXtuA0dzv4fLYmiiQwsK8FjCfFzJaAPfkpMrOy1/2QTwkLjUXX4RQ2OrLOOiV3S7ocq2rAlcl1u0d2uu9Ca/XDPWYXGhjxCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145690; c=relaxed/simple;
	bh=vMRciAZ175VWO2J32cGUF/F9D7Trztf0tZEVIb+di+o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EGKrXTQ6++sHHH1KNb0nrDPU6IDeOPx5ldC6dwieutRI8NETEDbvNgCUIoSU14ncVZyBKEZck5iWVzdUTCtVj9eIseuyhYP8smgjXC9pn/81o4GW9HBxsFyqm1E6QWAixjoQ5JUcF6m3NSToLOPQgSjiePhoFvJmUYsVaT+t6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh4AQ26O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh4AQ26O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C8A1F000FF;
	Wed, 23 Sep 2026 06:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790145682;
	bh=2W4NE5J+KhZtrDQBDt/XwIKj7xSOG+lvJrpx1ZfD3WE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Kh4AQ26OksIbGC0k1FMrdRH1tU4dxQXllArQlHmZTRMDpXMRnanD2BWVhKMZQwcE3
	 hbpz1OqO+DqS6dTie61sfkqtqxMkCbbcKs/vEKtqt/pNjMofBp07CzWuMkSvCpzN5H
	 7fnatDP5xuirLARW53rk9INT2Cy61r5x+LUsT6zdUdI8PalaBJskEabFe9Clt/9Grr
	 4JpYlA4YmzCMozxuAOIuv5zOUyG0g2M5kcmcXR0HW271DHdGHXE4M7FMC80BJVIamb
	 JW7xOe4A66iM+uR1omSSG1LZsHQuqjjQYfWO8m/+mrMpRh5UT0ljTGJAgJbMnSb4NU
	 kCPbicPsDU8nA==
Content-Type: multipart/mixed; boundary="===============0426560887140224341=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f0a28d1ffadcd0dbc3209da34afb902c4911ad9e31cd90a1b640d4c1592cf11d@mail.kernel.org>
In-Reply-To: <20260923053948.30617-6-wanjay@amazon.com>
References: <20260923053948.30617-6-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: defer registrations until the vmlinux BTF is available
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,martin.lau@linux.dev,yonghong.song@linux.dev,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,mcgrof@kernel.org,petr.pavlu@suse.com,linux-modules@vger.kernel.org,arnd@arndb.de,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 06:41:19 +0000 (UTC)

--===============0426560887140224341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 0bf10811fe53..3b99d6386dec 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 50eb7a95fd82..cbba20a908e9 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -8792,11 +8857,55 @@ static int btf_vmlinux_module_coming(struct module *mod)
>  	smp_store_release(&btf_vmlinux_raw, data);
>  	return 0;
>  }
> +
> +/*
> + * The vmlinux BTF is not available yet and must not be loaded from the
> + * module notifier (that would nest a module load into a module load).  Keep
> + * the module's BTF for btf_parse_deferred_modules().  The .BTF data can be
> + * exposed in sysfs right away, it needs no parsing.
> + */
> +static int btf_module_defer(struct btf_module *btf_mod, struct module *mod)
> +{
> +	int err;
> +
> +	btf_mod->data = kvmemdup(mod->btf_data, mod->btf_data_size,
> +				 GFP_KERNEL | __GFP_NOWARN);
> +	if (!btf_mod->data)
> +		return -ENOMEM;
> +	btf_mod->data_size = mod->btf_data_size;
> +
> +	if (mod->btf_base_data) {
> +		btf_mod->base_data = kvmemdup(mod->btf_base_data,
> +					      mod->btf_base_data_size,
> +					      GFP_KERNEL | __GFP_NOWARN);
> +		if (!btf_mod->base_data) {
> +			kvfree(btf_mod->data);
> +			return -ENOMEM;
> +		}
> +		btf_mod->base_data_size = mod->btf_base_data_size;
> +	}
> +
> +	err = btf_module_sysfs_add(btf_mod, mod->name, btf_mod->data,
> +				   btf_mod->data_size);
> +	if (err) {
> +		kvfree(btf_mod->data);
> +		kvfree(btf_mod->base_data);
> +		return err;
> +	}

The comment states the .BTF data "can be exposed in sysfs right away,
it needs no parsing". For modules with a .BTF.base section (split BTF),
is this accurate?

btf_parse_deferred_modules() later calls btf_relocate() which rewrites
btf_mod->data in place (btf_relocate_rewrite_type_id() and
btf_relocate_rewrite_strs() modify btf->data directly). The sysfs file
exposes unrelocated BTF until that runs.

Can userspace tools reading /sys/kernel/btf/<module> between module load
and vmlinux BTF arrival get type ids and string offsets relative to the
distilled .BTF.base (which is never exposed), making the data unusable?

Also, can reads that overlap the btf_relocate() in-place rewrite get a
mix of pre- and post-relocation bytes, since sysfs_bin_attr_simple_read()
reads attr->private/attr->size with no synchronization against
btf_parse_deferred_modules()?

Does treating btf_module_sysfs_add() failure as fatal make sense here?
A few lines below, the non-deferred path at kernel/bpf/btf.c:8984
deliberately ignores the same failure as non-fatal:

    /* not fatal, the module BTF is usable without the sysfs file */
    btf_module_sysfs_add(btf_mod, btf->name, btf->data, btf->data_size);

A transient -ENOMEM or unexpected -EEXIST in sysfs_create_bin_file()
costs the module its BTF entirely instead of just its sysfs file.

> +
> +	list_add(&btf_mod->list, &btf_modules);
> +	return 0;
> +}

[ ... ]

> @@ -8905,6 +9033,87 @@ static int __init btf_module_init(void)
>  }
>
>  fs_initcall(btf_module_init);
> +
> +#if IS_MODULE(CONFIG_DEBUG_INFO_BTF)
> +/*
> + * CONFIG_DEBUG_INFO_BTF=m: the vmlinux BTF has just become available.  Parse
> + * the BTF of the modules that were loaded before it, and apply the
> + * registrations that waited for them.  Called from bpf_get_btf_vmlinux()
> + * once btf_vmlinux is published, with no locks held.
> + */
> +void btf_parse_deferred_modules(void)
> +{
> +	/* Pairs with the publication in bpf_get_btf_vmlinux() */
> +	struct btf *vmlinux_btf = smp_load_acquire(&btf_vmlinux);
> +	struct btf_deferred_reg *reg, *rtmp;
> +	struct btf_module *btf_mod, *tmp;
> +	bool parsed = false;
> +	LIST_HEAD(regs);
> +	struct btf *btf;
> +	int err;
> +
> +	if (IS_ERR_OR_NULL(vmlinux_btf))
> +		return;
> +
> +	mutex_lock(&btf_module_mutex);
> +	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
> +		if (btf_mod->btf)
> +			continue;
> +
> +		btf = btf_parse_module(btf_mod->module->name, vmlinux_btf,
> +				       btf_mod->data, btf_mod->data_size, true,
> +				       btf_mod->base_data, btf_mod->base_data_size);
> +		err = PTR_ERR_OR_ZERO(btf);
> +		if (!err) {
> +			err = btf_alloc_id(btf);
> +			if (err) {
> +				/* btf owns the data now, btf_free() drops it */
> +				btf_mod->data = NULL;
> +				btf_free(btf);
> +			}
> +		}

[ ... ]

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
> +			reg->btf = btf;
> +			reg->module = btf_mod->module;
> +			list_add_tail(&reg->list, &regs);
> +		}
> +	}
> +	mutex_unlock(&btf_module_mutex);

Can try_module_get() on a MODULE_STATE_COMING module guarantee the module
image outlives the registration?

The deferred registrations are created from the module's own init routine
(register_btf_kfunc_id_set() / register_btf_id_dtor_kfuncs() /
__register_bpf_struct_ops() call btf_defer_reg()), so they are queued
while the module is still MODULE_STATE_COMING.

btf_try_get_module() at kernel/bpf/btf.c:9128 deliberately refuses to pin
COMING modules:

    /* We must only consider module whose __init routine has
     * finished, hence we must check for BTF_MODULE_F_LIVE flag,
     * which is set from the notifier callback for
     * MODULE_STATE_LIVE.
     */
    if ((btf_mod->flags & BTF_MODULE_F_LIVE) && try_module_get(btf_mod->module))

tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c exercises this
check because a refcount on a COMING module is not a lifetime guarantee.

If that module's init then fails, kernel/module/main.c:3208 does:

  fail:
    mod->state = MODULE_STATE_GOING;
    synchronize_rcu();
    module_put(mod);
    blocking_notifier_call_chain(&module_notify_list, MODULE_STATE_GOING, mod);
    ...
    free_module(mod);

free_module() (kernel/module/main.c:1417) never waits for the module
refcount and goes straight to free_mod_mem(mod). The pin taken above
does not defer the free, so btf_apply_deferred_regs() then dereferences
reg->kfunc.kset / reg->st_ops in the freed module image and writes the
freed per-cpu refcount with module_put(reg->module).

[ ... ]

> @@ -10335,8 +10574,183 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
> +#else
> +static int btf_struct_ops_add(struct btf *btf, struct bpf_struct_ops *st_ops)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif

Is the new btf_struct_ops_add() stub reachable?

Preprocessor structure in kernel/bpf/btf.c:

  10421  #ifdef CONFIG_BPF_JIT
  10536    static int btf_struct_ops_add(...)        /* real */
  10553    int __register_bpf_struct_ops(...)
  10572      err = btf_struct_ops_add(btf, st_ops);
  10577  #else
  10578    static int btf_struct_ops_add(...)        /* NEW stub */
  10582  #endif
  10591  #ifdef BTF_MODULE_NOTIFIER
  10670    return btf_struct_ops_add(btf, reg->st_ops);
  10752  #endif /* BTF_MODULE_NOTIFIER */

The stub's only reference is inside btf_apply_deferred_reg(), compiled
only when BTF_MODULE_NOTIFIER is defined:

  kernel/bpf/btf.c:8706  #if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES) || IS_MODULE(CONFIG_DEBUG_INFO_BTF)
  kernel/bpf/btf.c:8707  #define BTF_MODULE_NOTIFIER 1

With CONFIG_BPF_SYSCALL=y (btf.c is built), CONFIG_BPF_JIT=n and
CONFIG_DEBUG_INFO_BTF=n (or =y with CONFIG_MODULES=n), the stub is
defined and never referenced. CONFIG_BPF_JIT is a plain bool with no
default (kernel/bpf/Kconfig:46), so =n with BPF_SYSCALL=y is an ordinary
configuration.

This produces a -Wunused-function warning, which is a build failure with
CONFIG_WERROR=y.

> +
> +/*
> + * CONFIG_DEBUG_INFO_BTF=m: registrations made before the BTF they apply to
> + * is available.  Registrations for vmlinux wait in btf_vmlinux_deferred_regs
> + * until btf_parse_vmlinux() applies them; registrations for a module wait in
> + * its struct btf_module until btf_parse_deferred_modules() does.  Both lists
> + * are protected by btf_module_mutex.
> + */
> +#ifdef BTF_MODULE_NOTIFIER
> +static LIST_HEAD(btf_vmlinux_deferred_regs);
> +/* Set when the vmlinux BTF is parsed; new registrations apply directly */
> +static bool btf_vmlinux_regs_closed;

[ ... ]

> +/*
> + * The vmlinux BTF has just been parsed; apply the registrations that waited
> + * for it.  Runs under btf_vmlinux_lock, before @btf is published, so nothing
> + * can observe a vmlinux BTF without its kfuncs and struct_ops.
> + *
> + * Applying a registration can queue further ones: a struct_ops ->init()
> + * registers the kfuncs of its hook.  Those must not go through
> + * bpf_get_btf_vmlinux() (we hold its lock), so the queue stays open until
> + * a pass applies nothing new, and only then are registrations applied directly.
> + */
> +static void btf_apply_deferred_vmlinux_regs(struct btf *btf)
> +{
> +	struct btf_deferred_reg *reg, *tmp;
> +	LIST_HEAD(regs);
> +	int err;
> +
> +	if (!IS_MODULE(CONFIG_DEBUG_INFO_BTF))
> +		return;
> +
> +	mutex_lock(&btf_module_mutex);
> +	while (!list_empty(&btf_vmlinux_deferred_regs)) {
> +		list_splice_init(&btf_vmlinux_deferred_regs, &regs);
> +		mutex_unlock(&btf_module_mutex);

Can this introduce a circular lock dependency?

btf_apply_deferred_vmlinux_regs() is called from btf_parse_vmlinux()
(kernel/bpf/btf.c:6597), which runs with btf_vmlinux_lock held by
bpf_get_btf_vmlinux():

  kernel/bpf/verifier.c:21184  mutex_lock(&btf_vmlinux_lock);
  kernel/bpf/verifier.c:21187      btf = btf_parse_vmlinux();
  kernel/bpf/verifier.c:21197  mutex_unlock(&btf_vmlinux_lock);

The new mutex_lock(&btf_module_mutex) at kernel/bpf/btf.c:10724 creates:

  (A) btf_vmlinux_lock -> btf_module_mutex  [NEW]

Two pre-existing edges close the cycle:

  (B) cand_cache_mutex -> btf_vmlinux_lock
      bpf_core_apply() kernel/bpf/btf.c:10269  mutex_lock(&cand_cache_mutex);
      bpf_core_apply() kernel/bpf/btf.c:10270  cc = bpf_core_find_cands(...);
      bpf_core_find_cands() kernel/bpf/btf.c:10165  main_btf = bpf_get_btf_vmlinux();

  (C) btf_module_mutex -> cand_cache_mutex
      btf_module_notify() MODULE_STATE_GOING kernel/bpf/btf.c:9001
          mutex_lock(&btf_module_mutex);
      btf_module_notify() kernel/bpf/btf.c:9015  btf_module_free(btf_mod);
      btf_module_free() kernel/bpf/btf.c:8810  purge_cand_cache(btf_mod->btf);
      purge_cand_cache() kernel/bpf/btf.c:10092  mutex_lock(&cand_cache_mutex);

Both edges (B) and (A) are taken by the same thread:

  CPU 0: BPF_PROG_LOAD with CO-RE relocations    |  CPU 1: rmmod <module with BTF>
    bpf_check() -> bpf_check_btf_info()          |
      -> check_core_relo()                       |
        -> bpf_core_apply()                      |
           mutex_lock(&cand_cache_mutex)  [10269]|    mutex_lock(&btf_module_mutex) [9001]
           -> bpf_core_find_cands()              |
              -> bpf_get_btf_vmlinux()           |
                 mutex_lock(&btf_vmlinux_lock)   |
                                        [21184]  |
                 -> btf_parse_vmlinux()          |
                   -> btf_apply_deferred_vmlinux_regs()
                      mutex_lock(&btf_module_mutex) <-- BLOCKS [10724]
                                                   |
                                                   |    btf_module_free() -> purge_cand_cache()
                                                   |      mutex_lock(&cand_cache_mutex) [10092]
                                                   |      <-- BLOCKS

Both waits are plain uninterruptible mutex_lock(); there is no trylock,
timeout or bounded retry, so the two tasks hang permanently.

Required config: CONFIG_DEBUG_INFO_BTF=m (the IS_MODULE() guard at 10721)
together with CONFIG_DEBUG_INFO_BTF_MODULES=y, which supplies the
module-BTF entries that edge (C) frees. That combination is supported and
explicitly exercised: DEBUG_INFO_BTF_MODULES is 'default y' and 'depends
on DEBUG_INFO_BTF && MODULES' (lib/Kconfig.debug:428), and the final
commit 2f5aab95d2b8 states it was 'Tested with ... =y vs =m, both with
CONFIG_DEBUG_INFO_BTF_MODULES=y'.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a7b73bc146a8..b6f094d5306a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21160,12 +21160,14 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
>  /*
>   * Returns the parsed vmlinux BTF, NULL if the kernel has none, or an ERR_PTR
>   * if it is malformed.  With CONFIG_DEBUG_INFO_BTF=m the BTF lives in the
> - * btf_vmlinux module; the first caller loads it and parses it.  May sleep.
> + * btf_vmlinux module; the first caller loads it, parses it and then registers
> + * the BTF of the modules that were loaded before it.  May sleep.
>   */
>  struct btf *bpf_get_btf_vmlinux(void)
>  {

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35824427607
--===============0426560887140224341==--
