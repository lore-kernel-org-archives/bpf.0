Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453867;
	b=M/VQjVXVCzdEbLWY/S5ORVyFLAyNjQFDLtcKbDSj5sYGp8Jrhfuga+q5bvwMi9JO51I+
	 I2B7+BtSMIgcGdEXfsiukyoa1dy7QsohQ96syQ/K7QJ9Vg2zHu7MrCu37F0iIQKe6BrJ4
	 /qqCLbKWARJdPVj4ccKC9BhbvMHWUWIqGWUQkEh0P6GLYwR0h+YwCzeKcBIGFpVrAvPMy
	 fk5hqtog3Nk4IHOZ/+TFPSokUCtoL16OB42dhuvpt06ZVIymadQS8QEfK67/O6foaCYWu
	 pBJGIGwxM6WQWcCYXT9oOkH2LqAmGLQ8AE3Q9rG3p8WfHmrZr4Dt2ypXDw41o5OARJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=reLu0xQA8FLqqGz8ZHz4SlAvBNfLvWfysLu2HEWzZeo=;
	b=FIc4fpNyumvZAszTBqA6erE/NciosX6xVBEtKAvBC2Ne6juYWpWoNTCaWEMeW3oiwTi1
	 39FwnQ2bDhiHBS5xXUvwY9v4SngASaWRFQKdIgpY7Cy+MOmQVX8D+VEIub8gvdx2DuTgo
	 9Qlpo23iEEew4Q0llImKucWyocL0rsgm8lTPzfKnzzpITguFqddW/6FgBu3PfWCH1Bly/
	 n1BtS/tz/jNuFtqZAkI1VG2QtoFnDipGvsfEnLAdNYyFrkm3Af8zpqRO+fo/kOgqGSdJ3
	 +LOxR/1vwLp1DE0WOFpT+Mj6kDcW7gHhfE/Wxockt8+LbRPGdiZn1AdExvCeRTePQVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQnBJbN0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21469606A31A;
	Sat, 31 Oct 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQnBJbN0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E354F1F000C1;
	Sat, 31 Oct 2026 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793453867;
	bh=reLu0xQA8FLqqGz8ZHz4SlAvBNfLvWfysLu2HEWzZeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MQnBJbN0l/ahabnh/gPVxN0vG9Tvmd1iQdTe1wbVDQsrV3gYspM6N/zWSwVeCZkPw
	 dlpniNXhwavNTyTcXgM7wgRE4R3KAa3RWTeZuodHoHLP2Al5yT5vpgmEjEpFE3BGEj
	 rMIkk4TzaCszn37iYatRtdwzV7l2x1+eZX1U+ZF5N9/Sfe3BcIHscuB3nLXsJrhW0d
	 2DqWcoBn5QUhrQ9FQH8budo+GPSqEl/owB0h0JBrocYtKeIqI1wHHUSpSKBX0OB0h8
	 0zSDFazsbWKU/PPw3Z1VHDz5hYuzAsdyt53ef8we0xkLBsr8RSRPxDFp91qMjME6pw
	 bqbU0HvzEWdxQ==
Message-ID: <sashiko-outbox-191981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 11/13] bpf: keep module BTF until the vmlinux
 BTF is parsed
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
In-Reply-To: <20261031130959.23472-12-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com>
 <20261031130959.23472-12-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 13:37:45 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] bpf: NULL deref in btf_parse_kept_modules() after inline sysfs fai=
lure
- [High] bpf: UAF of btf_mod->data in btf_free_rcu() after kept module unpa=
rse
- [High] bpf: premature btf_idr publication in btf_parse_kept_modules() cau=
ses UAF
- [Medium] bpf: btf_parse_kept_modules() drops kept inline BTF on -ENOMEM
- [Medium] bpf: drop kept module BTFs in btf_drop_all_deferred() on vmlinux=
 BTF failure
--

commit c77c66110b385c53a4bc18e94bea01ef20eb7416
Author: Jay Wang <wanjay@amazon.com>

bpf: keep module BTF until the vmlinux BTF is parsed

With CONFIG_DEBUG_INFO_BTF_LAZY enabled, this commit keeps in-tree module
BTF and inline BTF unparsed when a module loads before vmlinux BTF is
parsed, exposing their sysfs files immediately and parsing the kept module
BTFs under btf_vmlinux_lock when vmlinux BTF is first parsed.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a5b1cd63a1e43..631f5a32ec174 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -9395,6 +9398,149 @@ static DEFINE_MUTEX(btf_module_mutex);
>  static void purge_cand_cache(struct btf *btf);
>  static void btf_drop_deferred_regs(struct module *owner);
> =20
> +/* /sys/kernel/btf/<module> and <module>.inline */
> +static void btf_module_add_files(struct btf_module *btf_mod, const char =
*name,
> +				 void *data, u32 data_size)
> +{
> +	char inline_name[MODULE_NAME_LEN + sizeof(".inline")];
> +	struct bin_attribute *attr;
> +
> +	attr =3D sysfs_btf_add(name, data, data_size, false, NULL);
> +	if (IS_ERR(attr))
> +		return;
> +	btf_mod->sysfs_attr =3D attr;
> +
> +	if (!btf_mod->btf_inline_data)
> +		return;
> +	snprintf(inline_name, sizeof(inline_name), "%s.inline", name);
> +	attr =3D sysfs_btf_add(inline_name, btf_mod->btf_inline_data,
> +			     btf_mod->btf_inline_data_size, false, NULL);
> +	if (IS_ERR(attr)) {
> +		kvfree(btf_mod->btf_inline_data);
> +		btf_mod->btf_inline_data =3D NULL;
> +		return;
> +	}

[Severity: High]
Can this trigger a NULL pointer dereference when btf_parse_kept_modules()
later parses this module?

In btf_module_keep(), btf_mod->btf_inline_data_size is set to a non-zero
inline_data_size before calling btf_module_add_files(). If sysfs_btf_add()
fails for the .inline file here, btf_mod->btf_inline_data is freed and set
to NULL, but btf_mod->btf_inline_data_size remains non-zero.

Later, btf_parse_kept_modules() passes btf_mod->btf_inline_data (NULL) and
btf_mod->btf_inline_data_size (non-zero) to btf_parse_module():

    if (inline_data_size) {
        inline_btf =3D btf_parse_split(env, module_name, inline_data,
                                     inline_data_size, btf);

which calls btf_parse_split() -> btf_parse_hdr() with btf->data =3D=3D NULL=
 and
btf->data_size > 0, dereferencing hdr =3D btf->data.

Should btf_mod->btf_inline_data_size also be reset to 0 here (and if the
first sysfs_btf_add() call fails above, should btf_mod->btf_inline_data also
be freed and cleared)?

> +	btf_mod->sysfs_inline_attr =3D attr;
> +}

[ ... ]

> +/* Undo btf_parse_kept_modules() of a round that is not published */
> +static void btf_unparse_kept_modules(void)
> +{
> +	struct btf_module *btf_mod;
> +
> +	lockdep_assert_held(&btf_module_mutex);
> +	list_for_each_entry(btf_mod, &btf_modules, list) {
> +		if (!btf_mod->data || !btf_mod->btf)
> +			continue;
> +		btf_mod->btf->data =3D NULL;	/* the kept copy */
> +		btf_put(btf_mod->btf);
> +		btf_mod->btf =3D NULL;
> +	}
> +}

[Severity: High]
Could btf_free_rcu() read freed btf_mod->data memory after
btf_unparse_kept_modules() runs?

In btf_apply_deferred(), after btf_parse_kept_modules() sets up
btf_mod->btf in place over btf_mod->data, an earlier deferred
BTF_DEFER_ST_OPS registration can populate btf_mod->btf->struct_ops_tab via
__register_bpf_struct_ops() -> btf_add_struct_ops() ->
bpf_struct_ops_desc_init(), storing st_ops_desc->type =3D btf_type_by_id()
which points directly into btf_mod->data.

If a subsequent deferred registration in btf_apply_deferred() fails with
-ENOMEM, btf_unparse_kept_modules() sets btf_mod->btf->data =3D NULL, sched=
ules
asynchronous destruction of btf_mod->btf via btf_put() -> call_rcu(), and
resets btf_mod->btf =3D NULL.

If the module unloads (MODULE_STATE_GOING) before that RCU grace period
finishes, btf_module_notify() sees !btf_mod->btf and calls
btf_module_drop_kept(btf_mod), which immediately frees btf_mod->data with
kvfree(). When btf_free_rcu() -> btf_free() -> btf_free_struct_ops_tab() ->
bpf_struct_ops_desc_release() later executes:

    arg_info =3D st_ops_desc->arg_info;
    for (i =3D 0; i < btf_type_vlen(st_ops_desc->type); i++)
        kfree(arg_info[i].info);

doesn't btf_type_vlen(st_ops_desc->type) dereference the already freed
btf_mod->data buffer?

> +
> +/*
> + * Called under btf_vmlinux_lock by the task that parses the vmlinux BTF,
> + * before that is published.  Parses the kept module BTFs in place, olde=
st
> + * first so that ids follow the load order as without
> + * CONFIG_DEBUG_INFO_BTF_LAZY; in-tree module BTF and its inline BTF nee=
d no
> + * relocation, so sysfs serves the same bytes before and after.  A module
> + * whose BTF fails validation cannot be refused any more: it stays loaded
> + * without BTF, and its files go away; an invalid inline BTF loses its f=
ile.
> + * Returns -ENOMEM, with this round's module BTFs freed again, if memory=
 ran
> + * out.
> + */
> +static int btf_parse_kept_modules(void)
> +{
> +	struct btf_module *btf_mod, *tmp;
> +	void *inline_data;
> +	struct btf *btf;
> +	int err;
> +
> +	lockdep_assert_held(&btf_vmlinux_lock);
> +	guard(mutex)(&btf_module_mutex);
> +	list_for_each_entry_safe_reverse(btf_mod, tmp, &btf_modules, list) {
> +		if (btf_mod->btf || !btf_mod->data)
> +			continue;
> +		btf =3D btf_parse_module(btf_mod->module->name, btf_mod->data,
> +				       btf_mod->data_size, NULL, 0,
> +				       btf_mod->btf_inline_data,
> +				       btf_mod->btf_inline_data_size, &inline_data);
> +		if (!IS_ERR(btf)) {
> +			err =3D btf_alloc_id(btf);
> +			if (err) {
> +				btf->data =3D NULL;	/* the kept copy */
> +				btf_free(btf);
> +				btf =3D ERR_PTR(err);
> +			}
> +		}

[Severity: High]
Is it safe to publish btf into btf_idr via btf_alloc_id(btf) before the rest
of btf_parse_kept_modules() and btf_apply_deferred() have succeeded?

In btf_get_fd_by_id(), the return value of bpf_get_btf_vmlinux() is ignored:

    if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY))
        bpf_get_btf_vmlinux();

    rcu_read_lock();
    btf =3D idr_find(&btf_idr, id);
    if (!btf || !refcount_inc_not_zero(&btf->refcnt))

If task A's bpf_get_btf_vmlinux() fails with -ENOMEM, task A still proceeds
to idr_find(&btf_idr, id) while task B is inside btf_apply_deferred() ->
btf_parse_kept_modules(). Task A (or a deferred struct_ops ->init() callback
calling bpf_find_btf_id()) can grab a reference to btf_mod->btf from btf_id=
r,
raising refcnt above 1.

If task B then hits -ENOMEM on a later module or deferred registration,
btf_unparse_kept_modules() sets btf_mod->btf->data =3D NULL and calls
btf_put(btf_mod->btf), and bpf_get_btf_vmlinux() frees the unpublished
vmlinux BTF via btf_put(). Because btf_mod->btf->refcnt > 1, btf_put() does
not free btf_mod->btf or remove it from btf_idr, leaving a live BTF object
with btf->data =3D=3D NULL (which crashes in btf_get_info_by_fd() on
copy_to_user(ubtf, btf->data, btf_copy)) and a dangling btf->base_btf
pointer to the freed vmlinux BTF.

> +		if (btf =3D=3D ERR_PTR(-ENOMEM)) {
> +			btf_unparse_kept_modules();
> +			return -ENOMEM;
> +		}
> +		if (IS_ERR(btf)) {
> +			pr_warn("failed to validate module [%s] BTF: %ld\n",
> +				btf_mod->module->name, PTR_ERR(btf));
> +			btf_module_drop_kept(btf_mod);
> +			continue;
> +		}
> +		btf_mod->btf =3D btf;
> +		if (btf_mod->btf_inline_data && !inline_data) {
> +			if (btf_mod->sysfs_inline_attr)
> +				sysfs_btf_remove(btf_mod->sysfs_inline_attr);
> +			btf_mod->sysfs_inline_attr =3D NULL;
> +			kvfree(btf_mod->btf_inline_data);
> +			btf_mod->btf_inline_data =3D NULL;
> +			btf_mod->btf_inline_data_size =3D 0;
> +		}

[Severity: Medium]
If parsing a kept module's inline BTF fails with -ENOMEM inside
btf_parse_module(), doesn't this permanently drop the module's inline BTF
and sysfs file instead of rolling back the round?

In btf_parse_module(), an error from btf_parse_split() on inline_btf (such
as ERR_PTR(-ENOMEM)) is logged and cleared to inline_btf =3D NULL, returning
the main module btf with inline_data =3D=3D NULL. btf_parse_kept_modules() =
then
treats !inline_data as a validation failure and removes
btf_mod->sysfs_inline_attr and frees btf_mod->btf_inline_data, even if the
round fails with -ENOMEM and is retried later.

> +	}
> +	return 0;
> +}

[ ... ]

> @@ -11206,8 +11349,13 @@ static int btf_apply_deferred(void)
>  			break;
>  		}
>  		module_put(reg->owner);
> -		if (err =3D=3D -ENOMEM)
> +		if (err =3D=3D -ENOMEM) {
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +			guard(mutex)(&btf_module_mutex);
> +			btf_unparse_kept_modules();
> +#endif
>  			return err;
> +		}
>  		if (err)
>  			pr_warn("failed to apply deferred BTF registration for %s: %d\n",
>  				reg->owner ? reg->owner->name : "vmlinux", err);

[Severity: Medium]
What happens to kept module BTFs if btf_parse_vmlinux() in
bpf_get_btf_vmlinux() fails with a non-ENOMEM error (or btf_apply_deferred()
were to return a non-ENOMEM error)?

In bpf_get_btf_vmlinux(), when btf is a non-ENOMEM error pointer,
btf_apply_deferred() is not run (or fails) and btf_drop_all_deferred() is
called before publishing the error pointer to btf_vmlinux. However,
btf_drop_all_deferred() only frees entries in btf_deferred_regs and does not
call btf_module_drop_kept() on kept entries in btf_modules, leaving their
unparsed data buffers and /sys/kernel/btf/<module> sysfs files around until
module unload. Should btf_drop_all_deferred() also drop kept module entries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031130959.2347=
2-1-wanjay@amazon.com?part=3D11
