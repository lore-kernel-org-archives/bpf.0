Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453899;
	b=mM2sTSyQ0dCpb/EnY5Q37IayfECSWXyIHWQhVne6hR2Uo9dME7Po2E59qOs7TbLb/VrI
	 hXdckTp9LkZmMrE4lgQKh51lG4mC+CPzyk9Uw6RFtgTMpge58jhrdPTzBEwMqqtvjU3A7
	 VU1XnZmwTcz5i2FTGV7UYXs8ec+2aHvocyX99qr4fKwpZ4qsZ/5bwMsKTpqOJpWbPJKxz
	 Cl8zwF1xPG1+FeUO8XebCWgy8mtBF6loIPx+Ghjr5FTnKAO/qN7cNV83ZThAc+qAnc80t
	 Cs3OCqSRGXh68zpHQfbkmVJi8A4NaeQomJ3X139V9ofm0A6IlI958lLI48mBKT8IbdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453899;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sea389r7QNIe0tGj1KM6zedtIgXrndN4T9rt7442krs=;
	b=QIshKyvpg04Lj51WiYy6xVVOrvEPAbt5M6TC9/KROoRi7BcpkdsSb2rL1IKCOi3KUTaq
	 S6usQMl308vIdfxvlREH9++rKFOcwFvMiFjww6rY3luoCxhgTs/jEI8Qrw2hDaonnnpA2
	 84ORA2QJTofXKS7PrmdEIsAE+y4Z+a8pYTAmtJq46Xp33GZkb/paHKW3le4gz34IQyWnW
	 7HkoLzNqUupP9Nni567AYnIUhYh7uUECzX8n1noPwqBs/5AI/ilEdAH/ovIkImws+gfnU
	 8Gr1sJV3l1fK+7GtpykL5LeQ7KpGZg7wZDU6EpM38T7vv6HHSUpea0fkMsomLQHuSVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChDBZKzs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF070606A31C;
	Sat, 31 Oct 2026 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChDBZKzs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9242A1F00919;
	Sat, 31 Oct 2026 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793453898;
	bh=Sea389r7QNIe0tGj1KM6zedtIgXrndN4T9rt7442krs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ChDBZKzsOygyco4QgTXIWsEiiozkSqI7z/rptCRx1RCxYCKQJDOWMgruv0hHeK2Or
	 ODlrATVDS0eh96OymOlZLp65wwqbtLS/XlYrSLWfGgxtX4Rb7t4y3VUHRQlKrS/wxT
	 ndXDcqD+K0jHzKmJh6jcI1IXqv3mCxacEoWWCb6YzOM7xrvFZZRbXghX0tC6JtzYm4
	 5a8/Jg8r+kdsH/jBs70nawPV7d0ZSDuF/F2XSH69KlI3+d/PROxNlDwZ24DtmPg/u4
	 dmPUsIPljGBXf3vWfWsnMlc9fMQ3Fh/h7T231tZ6qHwFm1ut9AB1pd4mNHFUO2HfX2
	 GfFj9xYC2dG7Q==
Message-ID: <sashiko-outbox-191982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 10/13] bpf: defer kfunc and struct_ops
 registrations until first BTF use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>, bpf@vger.kernel.org, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alan Maguire" <almagui@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, "Nathan
 Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org, "Arnd
 Bergmann" <arnd@arndb.de>, x86@kernel.org, "Hazem Mohamed Abuelfotoh" <abuehaze@amazon.com>, "Bjoern
 Doebel" <doebel@amazon.de>, "Martin Pohlack" <mpohlack@amazon.de>, jay.wang.upstream@gmail.com
In-Reply-To: <20261031130959.23472-11-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com>
 <20261031130959.23472-11-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 13:38:17 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] bpf: propagate st_ops->init() error in bpf_struct_ops_desc_init()
- [Medium] bpf: premature btf_idr publication of vmlinux BTF before btf_app=
ly_deferred()
- [Medium] bpf: missing bpf_get_btf_vmlinux() in cgroup_bpf_prog_query()
--

commit ee51b32030c948007ccf4ba129182f790083514d
Author: Jay Wang <wanjay@amazon.com>

bpf: defer kfunc and struct_ops registrations until first BTF use

When CONFIG_DEBUG_INFO_BTF_LAZY is enabled, this commit queues kfunc set,
dtor kfunc, and struct_ops registrations made before vmlinux BTF is parsed
and replays them synchronously inside bpf_get_btf_vmlinux() before publishi=
ng
btf_vmlinux. It also triggers vmlinux BTF parsing from btf_get_fd_by_id() a=
nd
BPF_BTF_GET_NEXT_ID so kernel BTF IDs are allocated before IDR lookups.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a7bb780743fb2..a5b1cd63a1e43 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6930,17 +6930,54 @@ struct btf *btf_parse_vmlinux(void)
>  }
> =20
>  static DEFINE_MUTEX(btf_vmlinux_lock);
> +/* CONFIG_DEBUG_INFO_BTF_LAZY: the task applying deferred work, and its =
BTF */
> +static struct task_struct *btf_vmlinux_builder;
> +static struct btf *btf_vmlinux_new;
> +static int btf_apply_deferred(void);
> +static void btf_drop_all_deferred(int err);
> +
> +static bool btf_vmlinux_building(void)
> +{
> +	return in_task() && READ_ONCE(btf_vmlinux_builder) =3D=3D current;
> +}
> =20
>  struct btf *bpf_get_btf_vmlinux(void)
>  {
>  	/* Pairs with the smp_store_release() on the parse path below. */
>  	struct btf *btf =3D smp_load_acquire(&btf_vmlinux);
> =20
> -	if (!btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> -		mutex_lock(&btf_vmlinux_lock);
> -		btf =3D btf_vmlinux;
> -		if (!btf) {
> -			btf =3D btf_parse_vmlinux();
> +	/* with CONFIG_DEBUG_INFO_BTF_LAZY any call may be the one that parses =
*/
> +	if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY))
> +		might_sleep();
> +	if (btf || !IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> +		return btf;
> +	/* the registrations btf_apply_deferred() applies see the new BTF */
> +	if (btf_vmlinux_building())
> +		return btf_vmlinux_new;
> +
> +	mutex_lock(&btf_vmlinux_lock);
> +	btf =3D btf_vmlinux;
> +	if (!btf) {
> +		btf =3D btf_parse_vmlinux();
> +		if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY) && !IS_ERR(btf)) {
> +			int err;
> +
> +			btf_vmlinux_new =3D btf;
> +			WRITE_ONCE(btf_vmlinux_builder, current);
> +			err =3D btf_apply_deferred();
> +			WRITE_ONCE(btf_vmlinux_builder, NULL);
> +			btf_vmlinux_new =3D NULL;
> +			if (err) {
> +				/* nothing saw it: drop it with what was applied to it */
> +				bpf_ctx_convert.t =3D NULL;
> +				btf_put(btf);
> +				btf =3D ERR_PTR(err);
> +			}
> +		}
> +		/* a lazy parse that ran out of memory is retried by the next caller */
> +		if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY) || btf !=3D ERR_PTR(-ENOME=
M)) {
> +			if (IS_ERR(btf))
> +				btf_drop_all_deferred(PTR_ERR(btf));
>  			/*
>  			 * Order the parsed BTF contents and the globals the
>  			 * parse populated (e.g. bpf_ctx_convert.t) before
> @@ -6949,8 +6986,8 @@ struct btf *bpf_get_btf_vmlinux(void)
>  			 */
>  			smp_store_release(&btf_vmlinux, btf);
>  		}
> -		mutex_unlock(&btf_vmlinux_lock);
>  	}
> +	mutex_unlock(&btf_vmlinux_lock);
>  	return btf;
>  }
> =20
> @@ -9302,6 +9339,10 @@ int btf_get_fd_by_id(u32 id)
>  	struct btf *btf;
>  	int fd;
> =20
> +	/* kernel BTFs get their ids while parsed, before they are published */
> +	if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY))
> +		bpf_get_btf_vmlinux();
> +
>  	rcu_read_lock();
>  	btf =3D idr_find(&btf_idr, id);
>  	if (!btf || !refcount_inc_not_zero(&btf->refcnt))

[Severity: Medium]
Can a concurrent caller of btf_get_fd_by_id() or __sys_bpf() (for
BPF_BTF_GET_NEXT_ID) observe and pin btf_vmlinux_new via btf_idr while
btf_apply_deferred() is still mutating it or rolling it back on -ENOMEM?

In kernel/bpf/btf.c, btf_parse_vmlinux() allocates the IDR entry before
btf_apply_deferred() runs:

btf_parse_vmlinux()
	err =3D btf_alloc_id(btf);

Both btf_get_fd_by_id() and the BPF_BTF_GET_NEXT_ID case in __sys_bpf()
call bpf_get_btf_vmlinux() and ignore its return value before querying
btf_idr without holding btf_vmlinux_lock.

If task A calls btf_get_fd_by_id() and its bpf_get_btf_vmlinux() attempt
fails with ERR_PTR(-ENOMEM) (for example, if task A is killed or hits a
memory limit during vmalloc()), bpf_get_btf_vmlinux() leaves btf_vmlinux
as NULL and releases btf_vmlinux_lock. Because btf_get_fd_by_id() ignores
the error, task A proceeds to idr_find(&btf_idr, id).

If task B concurrently acquires btf_vmlinux_lock, runs btf_parse_vmlinux()
(publishing btf_vmlinux_new into btf_idr via btf_alloc_id()), and enters
btf_apply_deferred(), task A can find task B's unpublished btf_vmlinux_new
in btf_idr and increment btf->refcnt from 1 to 2 via
refcount_inc_not_zero().

This exposes btf_vmlinux_new to userspace while btf_apply_deferred() is
still mutating kfunc_set_tab, dtor_kfunc_tab, and struct_ops_tab via
krealloc() and sort(). Furthermore, if task B's btf_apply_deferred() then
fails with -ENOMEM, the rollback path in bpf_get_btf_vmlinux() assumes
nothing else saw btf:

	if (err) {
		/* nothing saw it: drop it with what was applied to it */
		bpf_ctx_convert.t =3D NULL;
		btf_put(btf);
		btf =3D ERR_PTR(err);
	}

Because task A holds an extra reference, btf_put(btf) will not drop
btf->refcnt to zero or call btf_free_id(btf), leaving the aborted vmlinux
BTF in btf_idr while a subsequent caller parses and allocates a second
vmlinux BTF.

[ ... ]

> @@ -11009,6 +11131,9 @@ int __register_bpf_struct_ops(struct bpf_struct_o=
ps *st_ops)
>  	struct btf *btf;
>  	int err =3D 0;
> =20
> +	if (btf_defer_reg(st_ops->owner, BTF_DEFER_ST_OPS, 0, st_ops, 0, &err))
> +		return err;
> +
>  	btf =3D btf_get_module_btf(st_ops->owner);
>  	if (!btf)
>  		return check_btf_kconfigs(st_ops->owner, "struct_ops");

[Severity: Medium]
When __register_bpf_struct_ops() is deferred until the first
bpf_get_btf_vmlinux() call, could BPF_PROG_QUERY with attach_type
BPF_STRUCT_OPS fail with -ENOENT if invoked before vmlinux BTF is parsed?

Normally, built-in cgroup struct_ops (such as bpf_tcp_ops registered in
__bpf_tcp_ops_init()) are registered during initcalls via:

__register_bpf_struct_ops()
	btf_add_struct_ops()
		cgroup_bpf_struct_ops_register()

which populates cgroup_struct_ops[cgroup_atype].type_id.

With CONFIG_DEBUG_INFO_BTF_LAZY enabled, btf_defer_reg() defers
__register_bpf_struct_ops(), leaving cgroup_struct_ops[].type_id as 0 until
bpf_get_btf_vmlinux() runs btf_apply_deferred().

If a user reads the struct_ops type_id from /sys/kernel/btf/vmlinux (which
decompresses raw BTF via btf_vmlinux_data() without calling
bpf_get_btf_vmlinux()) and invokes BPF_PROG_QUERY with attach_type
BPF_STRUCT_OPS, execution reaches kernel/bpf/cgroup.c:

bpf_prog_query()
	cgroup_bpf_prog_query()
		cgroup_bpf_query()
			__cgroup_bpf_query()

In __cgroup_bpf_query():

	if (type =3D=3D BPF_STRUCT_OPS) {
		u32 type_id =3D attr->query.type_id;

		atype =3D find_atype_by_struct_ops_id(type_id);
		if (atype =3D=3D CGROUP_BPF_ATTACH_TYPE_INVALID)
			return -ENOENT;

Because neither cgroup_bpf_prog_query() nor __cgroup_bpf_query() calls
bpf_get_btf_vmlinux(), the deferred struct_ops registrations have not been
applied yet, so find_atype_by_struct_ops_id() returns
CGROUP_BPF_ATTACH_TYPE_INVALID and the query fails with -ENOENT instead of
succeeding with prog_cnt =3D 0.

> @@ -11034,6 +11159,93 @@ int __register_bpf_struct_ops(struct bpf_struct_=
ops *st_ops)
>  EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
>  #endif
> =20
> +static void btf_free_deferred_reg(struct btf_deferred_reg *reg)
> +{
> +	list_del(&reg->list);
> +	if (reg->kind !=3D BTF_DEFER_ST_OPS)
> +		kfree(reg->data);
> +	kfree(reg);
> +}
> +
> +/*
> + * Called under btf_vmlinux_lock, by the task that parsed the vmlinux BT=
F and
> + * before it publishes it, so that nothing sees the BTF without its kfun=
cs
> + * and struct_ops.  bpf_get_btf_vmlinux() returns the new BTF to
> + * this task, so the registrations are applied as if they were made now,=
 and
> + * any they make in turn (a struct_ops ->init() may register kfuncs) too.
> + * They run in whichever task needs the BTF first, with the locks it hol=
ds:
> + * they must not load modules or take locks that users of the BTF hold.
> + *
> + * Returns -ENOMEM if memory ran out, which may be only because that tas=
k is
> + * being killed: the caller then drops the new BTF with whatever was app=
lied
> + * to it, and the next caller starts over with the queue intact, as for =
the
> + * vmlinux BTF itself; a struct_ops ->init() then runs again with the BT=
F of
> + * that round.  Any other error of a registration is only logged.
> + */
> +static int btf_apply_deferred(void)
> +{
> +	struct btf_deferred_reg *reg, *tmp;
> +	int err;
> +
> +	list_for_each_entry(reg, &btf_deferred_regs, list) {
> +		/* a going module's exit() runs before GOING drops its entries */
> +		if (!try_module_get(reg->owner))
> +			continue;
> +		err =3D 0;
> +		switch (reg->kind) {
> +		case BTF_DEFER_KFUNCS:
> +			err =3D __register_btf_kfunc_id_set(reg->hook, reg->data);
> +			break;
> +		case BTF_DEFER_DTORS:
> +			err =3D register_btf_id_dtor_kfuncs(reg->data, reg->cnt, reg->owner);
> +			break;
> +		case BTF_DEFER_ST_OPS:
> +#if defined(CONFIG_BPF_JIT)
> +			err =3D __register_bpf_struct_ops(reg->data);
> +#endif
> +			break;
> +		}
> +		module_put(reg->owner);
> +		if (err =3D=3D -ENOMEM)
> +			return err;

[Severity: Medium]
What happens if a struct_ops ->init() callback fails with -ENOMEM while
registering kfuncs during btf_apply_deferred()?

In-tree struct_ops ->init() callbacks such as bm_bpf_init() in
fs/binfmt_misc_bpf.c and bpf_io_init() in io_uring/bpf-ops.c call
register_btf_kfunc_id_set() and return its error code.

When btf_apply_deferred() replays BTF_DEFER_ST_OPS while
btf_vmlinux_building() is true, register_btf_kfunc_id_set() runs directly
against btf_vmlinux_new via btf_populate_kfunc_set(). If memory allocation
fails with -ENOMEM in btf_populate_kfunc_set(), it jumps to label end and
frees the entire kfunc_set_tab on btf_vmlinux_new:

btf_populate_kfunc_set()
	...
end:
	btf_free_kfunc_set_tab(btf);
	return ret;

However, in kernel/bpf/bpf_struct_ops.c, bpf_struct_ops_desc_init()
discards the -ENOMEM return value from st_ops->init(btf) and replaces it
with -EINVAL:

	if (st_ops->init(btf)) {
		pr_warn("Error in init bpf_struct_ops %s\n",
			st_ops->name);
		err =3D -EINVAL;
		goto errout;
	}

As a result, __register_bpf_struct_ops() returns -EINVAL instead of
-ENOMEM to btf_apply_deferred(). Because btf_apply_deferred() only aborts
the round when err =3D=3D -ENOMEM, wouldn't it log a warning, free all queu=
ed
entries in btf_deferred_regs, and return 0, causing bpf_get_btf_vmlinux()
to permanently publish a btf_vmlinux whose kfunc_set_tab was wiped out by
btf_free_kfunc_set_tab()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031130959.2347=
2-1-wanjay@amazon.com?part=3D10
