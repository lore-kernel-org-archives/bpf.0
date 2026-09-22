Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E828C009
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040662; cv=none; b=gV4hqn1Z5WQUrtH+BZTAWzAAK06/wQvenYeztxZvRpanLQSIRr8pnNa8KqDHvo1bFiTE1Te8RiFJaWhkxs7VOFLgj2U5NEpMAWdJIJMy3Gq3v3zqfLmO3o6NC6Zl92BOyyowaAFPMDKrd4wAf1zPThc+ODRqI5pF2gEHxYRjsz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040662; c=relaxed/simple;
	bh=kRve9lIyA2wfqIKecmesAAAtIguTqGXaldo0qwmebKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cJIDsg1XDLoioEm43Gm5jDSgAi0Fa4miTBGsa3rMJUlwINcC0WWwx98G1RY94maTP8UAZpU2lSWhNlfMBixbMIfrdusK8SGbZ8CikHmMCkCkGyU40woIyNzWMeoKhF85J8i5ofnAh1OJcriAZRRexO8pzWm7sjCaoknq4RMa5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/A+dkFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/A+dkFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF101F000FF;
	Tue, 22 Sep 2026 01:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040660;
	bh=mon8H04TccavTGifG6fhQKYHTRSgBn490ZI8BhJL+hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X/A+dkFxCPpWILSs0ITOJY1UhllQGGfC1UJUaVMsx1TGy5DN9jY3l6yWujm+eeaQd
	 SF1QYTlNzQAvTOOPzgSW0N8wKZlddBvjp9PI8h9JN8PPcoTASoKeJtMbnZ+FU45R+e
	 vxcRnXqH7Rm5IEiMRnkAgOBarzolhsgAXjRK350Pumc9xRid9Wa4jYhaB0loNYBLLU
	 H4kF6Z/jAfFykngrxvuqVHIKllx2cePyq5xdrcLeusIk5VsfUIxtgNQoRUZuVyPajn
	 9ipyLaIQiOj/J4vwIg03UL0LZrd+FUsEcoV/v8niJL+El1gqzpb/Z0mTCgbzfVKOYZ
	 uqev70I89SyyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 10/17] bpf: Recognize pointers to functions in
 read-only maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922011323.1298619-11-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
 <20260922011323.1298619-11-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:31:00 +0000
Message-Id: <20260922013100.6DF101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: verifier incorrectly rejects valid programs and triggers WARN=
_ONCE when reading uncalled function pointers
- [Medium] bpf: map user state is not restored on JIT failure, breaking lib=
bpf log reloads
--

commit ac5645576aa732578e623a1ca8af9bcff7aa9194
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Recognize pointers to functions in read-only maps

Compilers put pointers to functions into read-only data: tables of
functions, struct ops, vtables, where they're mixed with sizes,
alignments and other data. Rust vtables are like that.
Let callx call through them.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 868350977f0cb..273f74068068c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -3029,6 +3029,11 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
>  			map->ops->map_poke_untrack(map, aux);
>  		if (sleepable)
>  			atomic64_dec(&map->sleepable_refcnt);
> +		/*
> +		 * The program that didn't load is not a user of the map. libbpf
> +		 * loads the program again to get the log of the verifier.
> +		 */
> +		cmpxchg(&map->user, (unsigned long)aux, 0);

[Severity: Medium]
Will this properly clear the map's user state if the BPF_MAP_USER_PATCHED
flag was set before a failure?

If jit_subprogs() sets the BPF_MAP_USER_PATCHED flag, map->user becomes
me | BPF_MAP_USER_PATCHED. If a failure happens afterward, this cmpxchg()
strictly expects map->user to equal aux, which will fail to match.

This can leave the map permanently locked in the patched state, causing
libbpf's subsequent reload attempt (to obtain the verifier log) to fail
with -EBUSY.

>  		bpf_map_put(map);
>  	}
>  }
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 2add8001c3ec3..e568b9b790b5c 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -1285,6 +1289,57 @@ static int jit_subprogs(struct bpf_verifier_env *e=
nv)
>  		cond_resched();
>  	}
> =20
> +	/*
> +	 * The addresses of all functions are final. Replace the offsets of
> +	 * functions with them in the maps of the program, see
> +	 * resolve_func_ptrs(). The program must be the only user of such map.
> +	 * From now on no other program can use it, see bpf_map_claim().
> +	 */
> +	for (i =3D 0; i < env->func_ptr_cnt; i++) {
> +		struct bpf_func_ptr *ptr =3D &env->func_ptrs[i];
> +		unsigned long me =3D (unsigned long)prog->aux;
> +		u64 addr, old, new =3D 0;
> +
> +		/* pointers are sorted by map */
> +		if ((!i || ptr->map !=3D ptr[-1].map) &&
> +		    cmpxchg(&ptr->map->user, me, me | BPF_MAP_USER_PATCHED) !=3D me) {
> +			verbose(env, "map '%s' is used by another program\n", ptr->map->name);
> +			err =3D -EBUSY;
> +			goto out_free;
> +		}
> +
> +		/* it's the address of the value of the map whatever the offset is */
> +		err =3D ptr->map->ops->map_direct_value_addr(ptr->map, &addr, 0);
> +		if (verifier_bug_if(err, env, "no value of map '%s'", ptr->map->name))=
 {
> +			err =3D -EFAULT;
> +			goto out_free;
> +		}
> +		addr +=3D ptr->map_off;
> +
> +		if (ptr->xlated_off !=3D BPF_FUNC_PTR_DELETED) {
> +			subprog =3D bpf_find_subprog(env, ptr->xlated_off);
> +			if (verifier_bug_if(subprog <=3D 0, env, "no function at insn %u",
> +					    ptr->xlated_off)) {
> +				err =3D -EFAULT;
> +				goto out_free;
> +			}
> +			new =3D (unsigned long)func[subprog]->bpf_func;
> +		} else if (verifier_bug_if(ptr->used, env, "function of map '%s' offse=
t %u is removed",
> +					   ptr->map->name, ptr->map_off)) {

[Severity: High]
Does eagerly setting ptr->used =3D true in check_func_ptr_read() lead to a
verifier bug here if the function is never actually called?

If a program simply reads the function pointer from the map but does not
invoke callx, check_func_ptr_read() still flags it as used. Since the
subprogram is never called, dead-code elimination can remove it.

When jit_subprogs() later evaluates the deleted but "used" pointer, it
incorrectly triggers a WARN_ONCE and returns -EFAULT, rejecting a valid
program.

> +			/* the program that reads the pointer might call the function */
> +			err =3D -EFAULT;
> +			goto out_free;
> +		}
> +		/* else the function is dead code, nothing calls it, the pointer is NU=
LL */
> +
> +		old =3D (u64)ptr->orig_off * sizeof(struct bpf_insn);
> +		if (verifier_bug_if(cmpxchg64((u64 *)(unsigned long)addr, old, new) !=
=3D old, env,
> +				    "map '%s' offset %u changed", ptr->map->name, ptr->map_off)) {
> +			err =3D -EFAULT;
> +			goto out_free;
> +		}
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922011323.1298=
619-1-alexei.starovoitov@gmail.com?part=3D10
