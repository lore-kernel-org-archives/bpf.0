Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809682;
	b=a7DeGSgSnxwwy6ehmSBuVMy2qpfUfK6k0K9luf2ckTsXbn6om5iJ1No33HnZnl0uxdSN
	 Hhi3XVdEcN+dbi8NyT1PVgH74AjAV14DojcMkSMEslZfQgALH1zFLpp6SOgxWBDEp1Wz2
	 w45kJd89hTMXdX3/e2i0/cIcrtcvtgEocdy2xkPw3zqejcb47QPW47zVbTO6hETIiGKQc
	 dtThm+UrhGvZzJK+uqDmnaNulrBTsa+/6LOGkaXD2oH/yM5V35iBEmzXgS+rTYyWMxjJJ
	 562zF8hy5ClRw9EwFbJI5zfapDc1d73y3zrbbyV7Ri8Ocr46YJLPI/ZPdRZxsT/mLlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809682;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l63yL3eRnJBEZsi1Tf33qYt3sr9UjVgALa9ew2RPHaY=;
	b=QPk3byyaZiGg+tv85XTeA6xWdNd9ige27H4ugKZ0K3vrZJhksOwLZ8tOnpZJMXs9T17H
	 XataqOodzPcZ5JCjqDsVeRq8PrgCgDxEpjjmexZx/uH6KC9Fu/jlVcQ6YDmw3l44GOm2b
	 t6u/2qoXzSC5EKHcWwUZu8Xu70Py+iAmPwM3NthMl8XAI0EuJ2WazMGuWpsxjrCN1phvK
	 mMvfhXONEQodtXFuPIYzAfAcMeuH6C7KTDqLK3FuXfH4qQjFod7Q6iiJLdlKjkX4Vsz1B
	 nsgf97QooutBU6VaJyqmqJPXbZhy0GK5F+aCzk9CzSdA3XMn45CQftpmUFTVumNYv6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmAakqAh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E0606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmAakqAh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6377D1F000C4;
	Mon, 16 Nov 2026 06:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794809681;
	bh=l63yL3eRnJBEZsi1Tf33qYt3sr9UjVgALa9ew2RPHaY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RmAakqAhqro0C5WVnvoW0TpD9ubQ2xD6e6GWxR/XtiA92M0AReRUo09YdkT+o71o4
	 E0fltGn/uY/q/1Fz1uujEoZDxRrsXhUuTFkDYWa0ANHUhZvMex3D7rvkPWp1eEzCCq
	 Rgm2dHINRKtRfTxqRgy3S0Ca0dxERdU4GlCqD0QplY/Pc7CLngGk0XBicA1xyFZZMI
	 rMw/6lpNlf+1VzOFqgsmWCBNvllWQJpm19sCDy6rje/sRNSZmHJIsSAlJsNZdwMN9b
	 hn0OSR1xo60ohJgBDYqKo1Ddy89Rt2NvAN5cmht4oxnCOCrI2ti+zPKH+EO/ZeGKUP
	 s9xpwBOUMRTBg==
Message-ID: <sashiko-outbox-216249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 10/21] bpf: Remove the limits on tables of
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116055638.4171529-11-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
 <20261116055638.4171529-11-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:14:40 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: dangling func_set_index entry on alloc failure in
  mark_reg_func_set()
--

commit 6c238cf296ed857f2bdb0c90315601a5bb923f5c
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Remove the limits on tables of functions

This commit removes the fixed limits on function pointer sets, read
targets, and total function pointers across maps by indexing sets in a
hash table, collecting read targets in a bitmap, and dynamically growing
the function pointer table.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f4e2a9f9f7873..e29eb7d7162b6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -7179,49 +7161,39 @@ static int cmp_u16(const void *a, const void *b)
>   * Equal sets have the same number, so registers are compared as they ar=
e.
>   */
>  static int mark_reg_func_set(struct bpf_verifier_env *env, struct bpf_re=
g_state *regs, int regno,
> -			     u16 *subprogs, u32 cnt)
> +			     const u32 *subprogs, u32 n)
>  {
> -	struct bpf_func_set **sets, *set;
> -	u32 i, n =3D 0;
> +	struct bpf_func_set *set;
> +	u64 key;
> +	int i;
> =20
> -	sort(subprogs, cnt, sizeof(*subprogs), cmp_u16, NULL);
> -	for (i =3D 0; i < cnt; i++)
> -		if (!n || subprogs[n - 1] !=3D subprogs[i])
> -			subprogs[n++] =3D subprogs[i];
>  	mark_reg_func_ptr(env, regs, regno, n =3D=3D 1 ? subprogs[0] : 0);
>  	if (n =3D=3D 1)
>  		return 0;
> =20
> -	for (i =3D 0; i < env->func_set_cnt; i++) {
> +	/* sets with the same hash have keys in a row */
> +	key =3D (u64)jhash2(subprogs, n, 0) << 32;
> +	for (; (i =3D bpf_index_find(&env->func_set_index, key)) >=3D 0; key++)=
 {
>  		set =3D env->func_sets[i];
>  		if (set->cnt =3D=3D n && !memcmp(set->subprog, subprogs, n * sizeof(*s=
ubprogs)))
>  			break;
>  	}
> -	if (i =3D=3D env->func_set_cnt) {
> -		if (i =3D=3D BPF_MAX_FUNC_SETS) {
> -			verbose(env, "more than %d sets of functions\n", BPF_MAX_FUNC_SETS);
> -			return -E2BIG;
> -		}
> -		sets =3D krealloc_array(env->func_sets, i + 1, sizeof(*sets), BPF_VERI=
FIER_GFP);
> -		if (!sets)
> +	if (i < 0) {
> +		i =3D env->func_set_cnt;
> +		if (!bpf_table_next(env->func_sets, i) ||
> +		    bpf_index_add(&env->func_set_index, key, i))
>  			return -ENOMEM;
> -		env->func_sets =3D sets;
> -		set =3D kzalloc_flex(*set, subprog, n, BPF_VERIFIER_GFP);
> +		set =3D kvzalloc_flex(*set, subprog, n, BPF_VERIFIER_GFP);
>  		if (!set)
>  			return -ENOMEM;
>  		set->cnt =3D n;
>  		memcpy(set->subprog, subprogs, n * sizeof(*subprogs));
> -		sets[env->func_set_cnt++] =3D set;
> +		env->func_sets[env->func_set_cnt++] =3D set;
>  	}
>  	regs[regno].func_set =3D i + 1;
>  	return 0;
>  }

[Severity: Medium]
Can a failed kvzalloc_flex() here leave a dangling entry in
env->func_set_index pointing to an uninitialized env->func_sets[i] slot?

bpf_index_add() inserts key -> i before set is allocated, and
bpf_table_next() grows env->func_sets via kvrealloc() without zeroing the
new slots.  If kvzalloc_flex() returns NULL, mark_reg_func_set() returns
-ENOMEM without initializing env->func_sets[i] or incrementing
env->func_set_cnt.  When round_is_dropped(env) is true, do_check_all()
ignores the error and starts a new round that reuses env->func_set_index:

kernel/bpf/verifier.c:do_check_all() {
	for (;;) {
		bpf_flow_new_round(env);
		ret =3D do_check_main(env);
		ret =3D ret ?: do_check_subprogs(env);
		if (!round_is_dropped(env))
			return ret;
    ...
}

Looking up key again in the next round will find i in env->func_set_index
and dereference the uninitialized env->func_sets[i] pointer.  Allocating
set before calling bpf_index_add() (or freeing set if bpf_index_add()
fails) would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055638.4171=
529-1-alexei.starovoitov@gmail.com?part=3D10
