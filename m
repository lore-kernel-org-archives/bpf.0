Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31153CC9F6
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587224; cv=none; b=OxEmdQeOA6rRpRFey5bOL7UEa7RZECDOgNTrbo+eesM0q2zWyCZDxuqaY29BZl1MT9RisXzZNRxeAg4XuXg7QhZgafNDppc58AsX9XZUTcbUw85kNcxqU1KzV6Z3yWiuSCQ8XNdykkGoACDEsw0N/HzcOS8d1WsZYdnrejsNd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587224; c=relaxed/simple;
	bh=C0wXq3j+N/6haQJOFIbUMeu+f05UKHzQFBepjFSIbEM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aOuul30kDatjCwn67RIbXBmfGYwfthz+ZwyPRQjyxmDM8zCA673Z1fQJzy7c7cwr9Nh9IB0V0rSfvWOZSTEUsQSmhpGmBQTjg7/BFgr0LNK3IEWGuYg3LpI82kuDs6zDyrmi3t2omP66VxHWxr5GZDDVBp6pRWZGqNxYeO6XMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=BJcG5FQ9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="BJcG5FQ9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf52d15d88so22138515ad.2
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 15:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784587222; x=1785192022; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tu8EcgI78LfxdoMkjWb+kElLdZgYsXJHqeLWZerSVaY=;
        b=BJcG5FQ9zukPiPFKviOY6VDoNMeF+xWrGv3Fw7B6gkkZj5TgxjE5G/vNY5j4AvGWYm
         HJV+nsdis6+Nku627KkW73ojub9xpVneMyT7Y1FX1QDx3hMty23T/bNIh9djtl4yMg8i
         PHRGI/Gd9zOHI6UGQI2bP1iQvfiXR+rg2M7knqUF5X+5YHf7SeQIbBHqNLwXBvefKeSs
         ZctnrYduCGOZz1VYMA9bQ/fVXOcJsLvD2+H9oDi3r48ZuX1EXbMxPkBRE25qWtUErJty
         u7C+euKWk4d/A57OeDYiEAJEXhPV0iIV0sNS9kRKDYUEBch7FyLfTRgEjStFd/HcozIu
         Hjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587222; x=1785192022;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tu8EcgI78LfxdoMkjWb+kElLdZgYsXJHqeLWZerSVaY=;
        b=poQyAfaEb6VjD4qWn8we3KFHRrhZLEYE2TdKODNO+NYgemeAlD91CqA7vJq/FHUQQ2
         KQlVDN2TaPtABcduodTXHtya+ul5VcbJTAVVLfVlk48olxhDC1q4A//DH28LWmEOMr98
         BQIjn2c0C467wLXK32C/A4iAne/hbK6y41Di0q3pMI/K039zxuBr5X5/cgp1c07Nx6K0
         n9OPG+czUnBtBTddmHc5ESRTxao/mDZRSKeyGMlXfiJyihkeyFucC4wXbMLX+6zlXEzs
         iwGaT/lpe94+I0DDqS58G3C84LhaH37ngb83hOZdTb2VTvQbuKcTQXC1iVBvMV4gWfjI
         v/Qw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5uXLzNlUsnD+6oCc4ajIPvqwPs4eldmHzlT+Uyrfaz8++DtvGqFaLlzW3/gnnkdtHjAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj08s5TrnF/tGSzqM0F8b6+C4ZtkuyinNqtbtFYPRUve0nG39a
	/4qi8Qp5i32oUjNqnBDHWm04wrpwhmp5ltLuki1r8IGN6goFydNgpKtzQeVKjl33JG8=
X-Gm-Gg: AR+sD139rLyEGTgxLX03Soda/T8/VN5x+ntpxbs+416fm+xhtu2m0ueNnC0EtKdhWBT
	JtSMFGcRwlkLBp22phfFhV/iMBJl/3oNwwvexq1Z9PiKdzmwm6ToZiBUd9ZZ0Ir5bl5DsfPdAXV
	aS54efH7EKzA6o8/U0ImvWB5mdt4k5lND59/dmWeLZNCjVdz7yK+DMedlQGnTaMLY+8e+hyz2SE
	tQTJ3d+kHFk7pxIA+S5s/9QS0L+q4waPOG+GJZlNjbQz2wkAwMsIUMvGgw0JwOLfoxmFwQwYZAV
	7LGwl5Vk5v0QFJTOm2NX4AAoS8/7Hq2FRx1WomU2WL+bR7jlxCQPiczfgWUrJ6khvTGCINRceRn
	p7FH0IJFuylZDTVuGC+GyubZRcrDqmYX5WB7S917pkDD7XHX673tv8O2Jn3mqPhW4SHww4I0Wud
	rkmmQeNP0kYP/jzPsMkOGOxXGOL/eHgCo=
X-Received: by 2002:a17:902:ce81:b0:2cf:4505:6bcf with SMTP id d9443c01a7336-2cf45056c42mr136417925ad.29.1784587222057;
        Mon, 20 Jul 2026 15:40:22 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34729df7sm65042845ad.63.2026.07.20.15.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 15:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 18:40:20 -0400
Message-Id: <DK3RDFC9SO44.1OJVOVUORD00J@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Fix is_tracing_prog_type() to
 cover fentry/fexit/fmod_ret
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260719113551.1294284-1-memxor@gmail.com>
 <20260719113551.1294284-3-memxor@gmail.com>
In-Reply-To: <20260719113551.1294284-3-memxor@gmail.com>

On Sun Jul 19, 2026 at 7:35 AM EDT, Kumar Kartikeya Dwivedi wrote:
> The is_tracing_prog_type() predicate currently skips fentry, fexit,
> fmod_ret, and also raw_tp attach type in BPF_PROG_TYPE_TRACING, due to
> oversight.
>
> Fix this by tightening the check, and moving predicates checking for the
> restriction closer to the point of use. This change might affect
> existing programs using them in unsafe contexts, but in such cases, it
> is recommended for users to switch over to bpf_res_spin_lock instead.
>
> Make appropriate changes to selftests to adjust to the change in error
> messages and added restrictions.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Overall makes sense, nits below. For the bpf_map_update_elem edge case
Sashiko brought up, can't we carve out a check in the verifier specifically
for this edge case (tracing program calling the helper with flags that=20
cannot be proven not to include BPF_F_LOCK)?

> ---
>  kernel/bpf/verifier.c                         | 48 ++++++++++---------
>  .../selftests/bpf/prog_tests/linked_list.c    |  6 +--
>  .../selftests/bpf/prog_tests/map_btf.c        | 19 ++++----
>  .../selftests/bpf/progs/map_in_map_btf.c      |  2 +-
>  .../selftests/bpf/progs/normal_map_btf.c      |  2 +-
>  .../selftests/bpf/progs/refcounted_kptr.c     | 10 ++--
>  .../bpf/progs/refcounted_kptr_fail.c          |  5 +-
>  .../bpf/progs/verifier_helper_restricted.c    |  4 ++
>  8 files changed, 50 insertions(+), 46 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bb6e16668d0d..3fe2410c7ce3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -207,7 +207,7 @@ static int release_reference_nomark(struct bpf_verifi=
er_state *state, int id);
>  static int release_reference(struct bpf_verifier_env *env, int id);
>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
>  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
> -static bool is_tracing_prog_type(enum bpf_prog_type type);
> +static bool is_tracing_prog_type(struct bpf_prog *prog);
>  static int ref_set_non_owning(struct bpf_verifier_env *env,
>  			      struct bpf_reg_state *reg);
>  static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bp=
f_reg_state *reg);
> @@ -7089,6 +7089,12 @@ static int process_spin_lock(struct bpf_verifier_e=
nv *env, struct bpf_reg_state
>  			val, lock_str, spin_lock_off);
>  		return -EINVAL;
>  	}
> +
> +	if (is_tracing_prog_type(env->prog) && !is_res_lock) {
> +		verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");

Should we change the "yet" phrasing? Are we ever planning on
implementng BPF vanilla spinlock support for tracing programs?

> +		return -EINVAL;
> +	}
> +
>  	if (is_lock) {
>  		void *ptr;
>  		int type;
> @@ -12317,6 +12323,10 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
>  				verbose(env, "allocated object must be referenced\n");
>  				return -EINVAL;
>  			}
> +			if (is_tracing_prog_type(env->prog)) {
> +				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n=
");

Same here.

> +				return -EINVAL;
> +			}
>  			ret =3D process_kf_arg_ptr_to_list_head(env, reg, argno, meta);
>  			if (ret < 0)
>  				return ret;
> @@ -12333,6 +12343,10 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
>  				verbose(env, "allocated object must be referenced\n");
>  				return -EINVAL;
>  			}
> +			if (is_tracing_prog_type(env->prog)) {
> +				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n=
");
> +				return -EINVAL;
> +			}
>  			ret =3D process_kf_arg_ptr_to_rbtree_root(env, reg, argno, meta);
>  			if (ret < 0)
>  				return ret;
> @@ -12966,7 +12980,6 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  			    int *insn_idx_p)
>  {
>  	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
> -	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
>  	struct bpf_reg_state *regs =3D cur_regs(env);
>  	const char *func_name, *ptr_type_name;
>  	const struct btf_type *t, *ptr_type;
> @@ -13044,10 +13057,8 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  		return err;
> =20
>  	if ((is_bpf_obj_drop_kfunc(meta.func_id) ||
> -	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_ty=
pe(prog_type) ||
> -	     /* is_tracing_prog_type() for now doesn't cover non-iterator traci=
ng progs. */
> -	     (prog_type =3D=3D BPF_PROG_TYPE_TRACING && env->prog->expected_att=
ach_type !=3D BPF_TRACE_ITER
> -	      && !env->prog->sleepable))) {
> +	     is_bpf_percpu_obj_drop_kfunc(meta.func_id)) && (is_tracing_prog_ty=
pe(env->prog)
> +	     && !env->prog->sleepable)) {

This was already the case, but the way we split the terms is confusing
and AFAICT there's an extra pair of parentheses. Can we do:

	if ((is_bpf_obj_drop_kfunc(meta.func_id) || is_bpf_percpu_obj_drop_kfunc(m=
eta.func_id)) &&
	    is_tracing_prog_type(prog_type) &&
	    !env->prog->sleepable) {
	}

and maybe add a predicate about drop_kfuncs to clean up line 1? We have
many similar precicates already.

>  		struct btf_struct_meta *struct_meta;
> =20
>  		struct_meta =3D btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
> @@ -17769,9 +17780,11 @@ static int check_pseudo_btf_id(struct bpf_verifi=
er_env *env,
>  	return __add_used_btf(env, btf);
>  }
> =20
> -static bool is_tracing_prog_type(enum bpf_prog_type type)
> +static bool is_tracing_prog_type(struct bpf_prog *prog)
>  {
> -	switch (type) {
> +	switch (resolve_prog_type(prog)) {
> +	case BPF_PROG_TYPE_TRACING:
> +		return prog->expected_attach_type !=3D BPF_TRACE_ITER;
>  	case BPF_PROG_TYPE_KPROBE:
>  	case BPF_PROG_TYPE_TRACEPOINT:
>  	case BPF_PROG_TYPE_PERF_EVENT:
> @@ -17802,14 +17815,6 @@ static int check_map_prog_compatibility(struct b=
pf_verifier_env *env,
>  		return -EACCES;
>  	}
> =20
> -	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
> -	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
> -		if (is_tracing_prog_type(prog_type)) {
> -			verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n"=
);
> -			return -EINVAL;
> -		}
> -	}
> -
>  	if (btf_record_has_field(map->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK=
)) {
>  		if (prog_type =3D=3D BPF_PROG_TYPE_SOCKET_FILTER) {
>  			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
> @@ -17817,12 +17822,11 @@ static int check_map_prog_compatibility(struct =
bpf_verifier_env *env,
>  		}
>  	}
> =20
> -	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
> -		if (is_tracing_prog_type(prog_type)) {
> -			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> -			return -EINVAL;
> -		}
> -	}
> +	/*
> +	 * Restrictions on using BPF list,rbtree,spin_lock is checked later upo=
n
> +	 * use, since rejecting accesing map containing them in programs is too
> +	 * conservative.
> +	 */
> =20
>  	if ((bpf_prog_is_offloaded(prog->aux) || bpf_map_is_offloaded(map)) &&
>  	    !bpf_offload_prog_map_match(prog, map)) {
> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
> index c3d133c6a00d..702268422673 100644
> --- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> @@ -59,12 +59,12 @@ static struct {
>  	TEST(inner_map, pop_front)
>  	TEST(inner_map, pop_back)
>  #undef TEST
> -	{ "map_compat_kprobe", "tracing progs cannot use bpf_{list_head,rb_root=
} yet" },
> -	{ "map_compat_kretprobe", "tracing progs cannot use bpf_{list_head,rb_r=
oot} yet" },
> +	{ "map_compat_kprobe", "calling kernel function bpf_list_push_front is =
not allowed" },
> +	{ "map_compat_kretprobe", "calling kernel function bpf_list_push_front =
is not allowed" },
>  	{ "map_compat_tp", "tracing progs cannot use bpf_{list_head,rb_root} ye=
t" },
>  	{ "map_compat_perf", "tracing progs cannot use bpf_{list_head,rb_root} =
yet" },
>  	{ "map_compat_raw_tp", "tracing progs cannot use bpf_{list_head,rb_root=
} yet" },
> -	{ "map_compat_raw_tp_w", "tracing progs cannot use bpf_{list_head,rb_ro=
ot} yet" },
> +	{ "map_compat_raw_tp_w", "calling kernel function bpf_list_push_front i=
s not allowed" },
>  	{ "obj_type_id_oor", "local type ID argument must be in range [0, U32_M=
AX]" },
>  	{ "obj_new_no_composite", "bpf_obj_new/bpf_percpu_obj_new type ID argum=
ent must be of a struct" },
>  	{ "obj_new_no_struct", "bpf_obj_new/bpf_percpu_obj_new type ID argument=
 must be of a struct" },
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_btf.c b/tools/tes=
ting/selftests/bpf/prog_tests/map_btf.c
> index 2c4ef6037573..1313f680fcda 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_btf.c
> @@ -7,6 +7,7 @@
> =20
>  static void do_test_normal_map_btf(void)
>  {
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
>  	struct normal_map_btf *skel;
>  	int i, err, new_fd =3D -1;
>  	int map_fd_arr[64];
> @@ -15,12 +16,10 @@ static void do_test_normal_map_btf(void)
>  	if (!ASSERT_OK_PTR(skel, "open_load"))
>  		return;
> =20
> -	err =3D normal_map_btf__attach(skel);
> -	if (!ASSERT_OK(err, "attach"))
> -		goto out;
> -
>  	skel->bss->pid =3D getpid();
> -	usleep(1);
> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.add_to_list_=
in_array), &opts);
> +	if (!ASSERT_OK(err, "test_run"))
> +		goto out;
>  	ASSERT_TRUE(skel->bss->done, "done");
> =20
>  	/* Use percpu_array to slow bpf_map_free_deferred() down.
> @@ -55,6 +54,7 @@ static void do_test_normal_map_btf(void)
> =20
>  static void do_test_map_in_map_btf(void)
>  {
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
>  	int err, zero =3D 0, new_fd =3D -1;
>  	struct map_in_map_btf *skel;
> =20
> @@ -62,12 +62,11 @@ static void do_test_map_in_map_btf(void)
>  	if (!ASSERT_OK_PTR(skel, "open_load"))
>  		return;
> =20
> -	err =3D map_in_map_btf__attach(skel);
> -	if (!ASSERT_OK(err, "attach"))
> -		goto out;
> -
>  	skel->bss->pid =3D getpid();
> -	usleep(1);
> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.add_to_list_=
in_inner_array),
> +				     &opts);
> +	if (!ASSERT_OK(err, "test_run"))
> +		goto out;
>  	ASSERT_TRUE(skel->bss->done, "done");
> =20
>  	/* Close inner_array fd later */
> diff --git a/tools/testing/selftests/bpf/progs/map_in_map_btf.c b/tools/t=
esting/selftests/bpf/progs/map_in_map_btf.c
> index 7a1336d7b16a..eb4d009b8a62 100644
> --- a/tools/testing/selftests/bpf/progs/map_in_map_btf.c
> +++ b/tools/testing/selftests/bpf/progs/map_in_map_btf.c
> @@ -41,7 +41,7 @@ char _license[] SEC("license") =3D "GPL";
>  int pid =3D 0;
>  bool done =3D false;
> =20
> -SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> +SEC("syscall")
>  int add_to_list_in_inner_array(void *ctx)
>  {
>  	struct map_value *value;
> diff --git a/tools/testing/selftests/bpf/progs/normal_map_btf.c b/tools/t=
esting/selftests/bpf/progs/normal_map_btf.c
> index a45c9299552c..90ac1ec365b9 100644
> --- a/tools/testing/selftests/bpf/progs/normal_map_btf.c
> +++ b/tools/testing/selftests/bpf/progs/normal_map_btf.c
> @@ -29,7 +29,7 @@ char _license[] SEC("license") =3D "GPL";
>  int pid =3D 0;
>  bool done =3D false;
> =20
> -SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> +SEC("syscall")
>  int add_to_list_in_array(void *ctx)
>  {
>  	struct map_value *value;
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/=
testing/selftests/bpf/progs/refcounted_kptr.c
> index 61906f48025c..9a783693ce08 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> @@ -921,11 +921,10 @@ long rbtree_wrong_owner_remove_fail_a2(void *ctx)
>  	return 0;
>  }
> =20
> -SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +SEC("?lsm.s/bpf")
>  __success
>  int BPF_PROG(rbtree_sleepable_rcu,
> -	     struct file *file, struct kobject *kobj,
> -	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
> +	     int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
>  {
>  	struct bpf_rb_node *rb;
>  	struct node_data *n, *m =3D NULL;
> @@ -955,11 +954,10 @@ int BPF_PROG(rbtree_sleepable_rcu,
>  	return 0;
>  }
> =20
> -SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +SEC("?lsm.s/bpf")
>  __success
>  int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_lock,
> -	     struct file *file, struct kobject *kobj,
> -	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
> +	     int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
>  {
>  	struct bpf_rb_node *rb;
>  	struct node_data *n, *m =3D NULL;
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/t=
ools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index 024ef2aae200..c47fc9d8e27f 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> @@ -127,11 +127,10 @@ long refcount_acquire_list_node_offset(void *ctx)
>  	return 0;
>  }
> =20
> -SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +SEC("?lsm.s/bpf")
>  __failure __msg("function calls are not allowed while holding a lock")
>  int BPF_PROG(rbtree_fail_sleepable_lock_across_rcu,
> -	     struct file *file, struct kobject *kobj,
> -	     struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
> +	     int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
>  {
>  	struct node_acquire *n;
> =20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_restricted=
.c b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
> index 889c9b78b912..a87792353dfd 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
> @@ -87,6 +87,7 @@ __naked void in_bpf_prog_type_kprobe_3(void)
>  	call %[bpf_map_lookup_elem];			\
>  	if r0 =3D=3D 0 goto l0_%=3D;				\
>  	r1 =3D r0;					\
> +	r1 +=3D 4;					\
>  	call %[bpf_spin_lock];				\
>  l0_%=3D:	exit;						\
>  "	:
> @@ -110,6 +111,7 @@ __naked void in_bpf_prog_type_tracepoint_3(void)
>  	call %[bpf_map_lookup_elem];			\
>  	if r0 =3D=3D 0 goto l0_%=3D;				\
>  	r1 =3D r0;					\
> +	r1 +=3D 4;					\
>  	call %[bpf_spin_lock];				\
>  l0_%=3D:	exit;						\
>  "	:
> @@ -133,6 +135,7 @@ __naked void bpf_prog_type_perf_event_3(void)
>  	call %[bpf_map_lookup_elem];			\
>  	if r0 =3D=3D 0 goto l0_%=3D;				\
>  	r1 =3D r0;					\
> +	r1 +=3D 4;					\
>  	call %[bpf_spin_lock];				\
>  l0_%=3D:	exit;						\
>  "	:
> @@ -156,6 +159,7 @@ __naked void bpf_prog_type_raw_tracepoint_3(void)
>  	call %[bpf_map_lookup_elem];			\
>  	if r0 =3D=3D 0 goto l0_%=3D;				\
>  	r1 =3D r0;					\
> +	r1 +=3D 4;					\
>  	call %[bpf_spin_lock];				\
>  l0_%=3D:	exit;						\
>  "	:

