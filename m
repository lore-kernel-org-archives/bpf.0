Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF463672A1
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341151; cv=none; b=Jsd+JhZYxagrINUOJgxP04FGwGggJMwsSKw6AatljQbi2aS8BIrwimGS2mKtpgeo5z4GfF569Sbjoz662BV8AKXUVxadSo8QGEDlWy1n7JINBxdFNT8Ippn+8SWQzsU0h/VjNd8LQ2SJz/dYXWgLxlMuJK4L2eW5q/1Dvu+APm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341151; c=relaxed/simple;
	bh=fCLxqN4XC6hcsmdW/8CroMit0ecvQEEiGeyAaA1Cnkg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GaH4qub2PZmLsRKoF0uebkZk17ucc0F9O+6ItHnJgk2pdo3QnAfCo3ptTKKa1TOt2BrKDrrRO19Osx/ILPBbklEFWi0cYFBJmHhJ9LicO88Wbyn+5m5jg9Ln9HGG2DvHev0lDopNrwDgcTP4POWYMxZKxvLdQYzCJzW6JTQ7fh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mI0waB55; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mI0waB55"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304d555293aso6485032eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780341149; x=1780945949; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCDe5uAmb1EI99FF7hYaxgI5S0blXyTXr4GwwILHnoU=;
        b=mI0waB55LjSh0LXJRMU13Mwh+IAFtBRyOfs6diIsMdpyBnMKeRnox/Az5CYouuJass
         Oxg0lNhnVjI/mtBhRuRdct7Sw1r5M8jwO1bsmMtzJcruG3FQ3kXZVXPZQ3/hlWYcU9kr
         XojkAdCTaYMofsnV42zsuhXasvyeinAYFfWG09k0GlFLEuqWlvXELCNYVf6+qeUhEbfP
         y+U0yE//xREeoC/1+REiAFv95QatdrKIRMilrLetrs4TRNibUkNV3UQ95ceUGrgKDZHd
         ecQNNdFkA9gDMLpWLFskFgC5uNIQNXJhxej5YELTT+s+JfbOLs9IjLZX4Fv5NwD2FnbV
         venw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341149; x=1780945949;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCDe5uAmb1EI99FF7hYaxgI5S0blXyTXr4GwwILHnoU=;
        b=ebJ9SrsolbXRYT0wfPY0bgikb+879QLMmO92p8NrhCUAmndC8/rpZwmVFooCwF+wD4
         twN3kcmx0adZajPhS86vKKFIFEiwPLd+jOO/sWUN2Zqtw+HeYrxyDc8u5bgNYcvMp+4y
         dGgvmthDRLPB6HYcjCp555iOZ4870xnK+4/P+1GZQGSzeemzmZnJAgvxP6qm7sykNkNU
         yfWnitfZMZylmMmEL4lD0/OMS8mEQy0sqfQDm9l1jyAH9GUEduYZC81evikU6vcXie7o
         d9PS98rMUzCkRZT4cRF4c4GYqdt68OIlTzfLpTGpIe1bc+jO4gIYEcSxx2PvoosmBqHE
         OLYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Mhc+8dvK5YxL5gpIshw4WuY0s7Z4XrzBTbzbF91p5oaRnyQXLunHdp+aO3XLh2KRm/6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkb5HIIKbbRcXub0yS7nnNxYgFg5Vko0xx8Lc7d6X+79VIbSOm
	fA+hWF+rP5D9z7sKX99fyuI3JR6JyOo2hToa8BAPZnbxrPG3g2w9CXwiJzajzXq1iRJyJWchI46
	P8VDB3enLioXE
X-Gm-Gg: Acq92OGoW9vsYs9j0g2GcxZyl0FyaFTgSXCyXK30EmGMPkiUcTtZDlAJHHslxsMFjRk
	2TKE+MUA5V3ooC0r5oavuNPAMM5bH5HBKe6jJx5roN3AF8Vy6h8Zawi0EnaCL2V5OU1mzX3PYGi
	d58G1csukjQtxPyXefhrRkDfBjLOb+bJdhrhM8+QgiZ/Yim3WWxj7eD/vdML7mOwTvghTHYEITw
	zhz28SYeFSiF1rc+RG/bAuw7gM4N8Pycq1SEe391OHgoZkK0c6V0inhKxKAZKmx3vHLORZsZrl3
	UYq/bVRQK6BQ6doypGJ5qpTGKax3zRCivxl+CPz2HKj7voY6mKJift6nXWD3nrQHZkACZulMLs8
	x2mDufzGfo3E79U130gw5gQ8J/AI5chDpBnB2qNp8Vx0akyfY56X1t8cUks0dG/FDmePyfHQ1Pa
	EjaJrwRCdgADNgtLk=
X-Received: by 2002:a05:7300:5714:b0:304:1fb6:88fd with SMTP id 5a478bee46e88-304fa693196mr6191995eec.29.1780341148819;
        Mon, 01 Jun 2026 12:12:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::649e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5cf1c7sm9706315eec.29.2026.06.01.12.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 15:12:21 -0400
Message-Id: <DIXY9HEXZK4K.3NF0E685YW1X1@etsalapatis.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC bpf-next v3 2/6] bpf: compute loops hierarchy
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
 <20260527-better-1m-reporting-v3-2-b3ede0588a75@gmail.com>
In-Reply-To: <20260527-better-1m-reporting-v3-2-b3ede0588a75@gmail.com>

On Wed May 27, 2026 at 3:29 AM EDT, Eduard Zingerman wrote:
> Add an analysis phase computing the loops hierarchy to the bpf
> verifier. The algorithm is based on the paper:
> "A New Algorithm for Identifying Loops in Decompilation" by Wei et al,
> adapted to be non-recursive.
>
> Record the loops hierarchy per instruction:
> - The field insn_aux_data->loop_header records the innermost loop
>   header containing it.
> - The field insn_aux_data->loop records additional information about
>   the loop if this instruction is a loop header (at the moment it only
>   tracks irreduciblity of the loop, additional information will be
>   added later).
>
> Subsequent patches use loop header entries as sampling points for
> callchain profiling, for better error reports when the 1M instruction
> budget is exhausted.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Nits below.
> ---
>  include/linux/bpf_verifier.h |  10 +++
>  kernel/bpf/Makefile          |   2 +-
>  kernel/bpf/fixups.c          |   5 ++
>  kernel/bpf/loops.c           | 196 +++++++++++++++++++++++++++++++++++++=
++++++
>  kernel/bpf/verifier.c        |  10 ++-
>  5 files changed, 221 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5cbad3b64130..d0a1fb135cbf 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -656,6 +656,10 @@ struct bpf_iarray {
>  	u32 items[];
>  };
> =20
> +struct bpf_loop {
> +	bool irreducible;
> +};
> +
>  struct bpf_insn_aux_data {
>  	union {
>  		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
> @@ -742,6 +746,10 @@ struct bpf_insn_aux_data {
>  	u16 const_reg_map_mask;
>  	u16 const_reg_subprog_mask;
>  	u32 const_reg_vals[10];
> +	/* index of a loop header of the innermost loop containing this instruc=
tion, -1 if none */
> +	s32 loop_header;
> +	/* additional information about the loop if this instruction is a loop =
header */
> +	struct bpf_loop *loop;
>  };
> =20
>  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF prog=
ram */
> @@ -1608,4 +1616,6 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env);
>  int bpf_fixup_call_args(struct bpf_verifier_env *env);
>  int bpf_do_misc_fixups(struct bpf_verifier_env *env);
> =20
> +int bpf_compute_loops(struct bpf_verifier_env *env);
> +
>  #endif /* _LINUX_BPF_VERIFIER_H */
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 4dc41bf5780c..787d183ba5b4 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -fno-=
gcse
>  endif
>  CFLAGS_core.o +=3D -Wno-override-init $(cflags-nogcse-yy)
> =20
> -obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o cnum.o log.o token.o liveness.o const_fold.o
> +obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o cnum.o log.o token.o liveness.o const_fold.o loops.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_iter.o map_iter.o task_iter.o prog_it=
er.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o bpf_insn_array.o
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 12739add2dda..57294524dab8 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -450,6 +450,11 @@ void bpf_clear_insn_aux_data(struct bpf_verifier_env=
 *env, int start, int len)
>  			aux_data[i].jt =3D NULL;
>  		}
> =20
> +		if (aux_data[i].loop) {
> +			kvfree(aux_data[i].loop);
> +			aux_data[i].loop =3D NULL;
> +		}
> +
>  		if (bpf_is_ldimm64(&insns[i]))
>  			i++;
>  	}
> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> new file mode 100644
> index 000000000000..aec11248d048
> --- /dev/null
> +++ b/kernel/bpf/loops.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/slab.h>
> +#include <linux/bpf_verifier.h>
> +
> +struct dfs_state {
> +	u32 traversed:1;
> +	u32 next_succ:31;
> +};
> +
> +struct loops_dfs {
> +	struct dfs_state *state;
> +	int *dfs_pos;
> +	int *stack;
> +};
> +
> +static void mark_irreducible(struct bpf_verifier_env *env, int h)
> +{
> +	env->insn_aux_data[h].loop->irreducible =3D true;
> +}
> +
> +static int mark_header(struct bpf_verifier_env *env, int h)

Maybe a more descriptive name? Not sure what we are marking the header
as.

> +{
> +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> +
> +	if (!aux[h].loop) {
> +		aux[h].loop =3D kvzalloc_obj(struct bpf_loop, GFP_KERNEL_ACCOUNT);
> +		if (!aux[h].loop)
> +			return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +static int assign_header(struct bpf_verifier_env *env, struct loops_dfs =
*dfs, int n, int h)
> +{
> +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> +	int *dfs_pos =3D dfs->dfs_pos;
> +	int err, nh;
> +
> +	err =3D mark_header(env, h);
> +	if (err)
> +		return err;
> +
> +	/* Don't encode self-loops, otherwise can't reflect loops nesting struc=
ture. */
> +	if (n =3D=3D h)
> +		return 0;
> +
> +	/* Make sure that loop headers up the chain are sorted by dfs_pos. */
> +	while (aux[n].loop_header !=3D -1) {
> +		nh =3D aux[n].loop_header;
> +		if (nh =3D=3D h)
> +			return 0;
> +		if (dfs_pos[nh] < dfs_pos[h]) {
> +			aux[n].loop_header =3D h;
> +			n =3D h;
> +			h =3D nh;
> +		} else {
> +			n =3D nh;
> +		}
> +	}
> +	aux[n].loop_header =3D h;
> +	return 0;
> +}
> +
> +/*
> + * As described in "A New Algorithm for Identifying Loops in Decompilati=
on" by Wei et al,
> + * adapted to be non-recursive.
> + */
> +static int compute_loops_in_subprog(struct bpf_verifier_env *env, struct=
 loops_dfs *dfs,
> +				    int subprog_idx)
> +{
> +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> +	struct dfs_state *state =3D dfs->state;
> +	int start =3D env->subprog_info[subprog_idx].start;
> +	int *dfs_pos =3D dfs->dfs_pos;
> +	int *stack =3D dfs->stack;
> +	int i, s, h, err, cur, stack_sz;
> +	struct bpf_iarray *succ;
> +
> +	stack[0] =3D start;
> +	state[start].traversed =3D true;
> +	state[start].next_succ =3D 0;
> +	dfs_pos[start] =3D 1;
> +	stack_sz =3D 1;
> +	i =3D 0;
> +	do {
> +		/*
> +		 * The algorithm should be very fast in practice,
> +		 * guard against pathological inputs, just in case.
> +		 */
> +		if (i++ =3D=3D 1024) {
> +			i =3D 0;
Nit: Maybe=20

if (!(++i % 1024))

?

> +			if (signal_pending(current))
> +				return -EAGAIN;
> +			cond_resched();
> +		}
> +
> +		cur =3D stack[stack_sz - 1];
> +		succ =3D bpf_insn_successors(env, cur);
> +		if (state[cur].next_succ =3D=3D succ->cnt) {
> +			dfs_pos[cur] =3D 0;
> +			stack_sz--;
> +			continue;
> +		}
> +		s =3D succ->items[state[cur].next_succ];
> +		if (!state[s].traversed) {
> +			/* Case A:  start -> ... -> cur -> s [unxplored] */
Typo: unxplored -> unexplored
> +			state[s].traversed =3D true;
> +			state[s].next_succ =3D 0;
> +			stack[stack_sz] =3D s;
> +			dfs_pos[s] =3D stack_sz + 1;
> +			stack_sz++;
> +			continue;
> +		}
> +		/* 's' is fully explored at this point */
> +		if (dfs_pos[s]) {
> +			/*
> +			 * start -> ... -> s -> cur --.
> +			 *                 ^          |
> +			 *                 '----------'
> +			 * Case B: 's' is in the current DFS path.
> +			 */
> +			err =3D assign_header(env, dfs, cur, s);
> +			if (err)
> +				return err;
> +		} else if (aux[s].loop_header =3D=3D -1) {
> +			/*
> +			 * start -> ... -> ... -> s -> ... -> end
> +			 *           |            ^
> +			 *           '---> cur ---'
> +			 * Case C: 's' is explored, not in the current DFS path,
> +			 * and not a part of any loop.
> +			 */
> +		} else if (dfs_pos[aux[s].loop_header]) {
> +			/*
> +			 *                 .----------------------.
> +			 *                 v                      |
> +			 * start -> ... -> h -> ... -> ... -> s --'
> +			 *                       |            ^
> +			 *	                 '---> cur ---'
> +			 * Case D: 's' is explored, not in current DFS path,
> +			 * but it's innermost loop header is.
Typo: it's -> its
> +			 */
> +			err =3D assign_header(env, dfs, cur, aux[s].loop_header);
> +			if (err)
> +				return err;
> +		} else {
> +			/* case E */
> +			h =3D aux[s].loop_header;
> +			mark_irreducible(env, h);
> +			/* can also mark 's' as reentry, but no need for now */
> +			while (aux[h].loop_header !=3D -1) {
> +				h =3D aux[h].loop_header;
> +				if (dfs_pos[h]) {
> +					err =3D assign_header(env, dfs, cur, h);
> +					if (err)
> +						return err;
> +					break;
> +				}
> +				mark_irreducible(env, h);
> +			}
> +		}
> +		state[cur].next_succ++;
> +	} while (stack_sz);
> +
> +	return 0;
> +}
> +
> +int bpf_compute_loops(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> +	int i, err =3D 0, len =3D env->prog->len;
> +	struct loops_dfs dfs =3D {};
> +
> +	dfs.dfs_pos =3D kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
> +	dfs.state =3D kvcalloc(len, sizeof(struct dfs_state), GFP_KERNEL_ACCOUN=
T);
> +	dfs.stack =3D kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
> +	if (!dfs.dfs_pos || !dfs.state || !dfs.stack) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> +	for (i =3D 0; i < len; i++)
> +		aux[i].loop_header =3D -1;
> +	for (i =3D 0; i < env->subprog_cnt; i++) {
> +		err =3D compute_loops_in_subprog(env, &dfs, i);
> +		if (err)
> +			goto out;
> +	}
> +
> +out:
> +	kvfree(dfs.dfs_pos);
> +	kvfree(dfs.stack);
> +	kvfree(dfs.state);
> +	return err;
> +}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3d569e36128c..2b3584712ad2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19627,13 +19627,17 @@ static void log_program(struct bpf_verifier_env=
 *env)
>  	u32 insn_cnt =3D env->prog->len;
>  	u32 i, j;
> =20
> -	verbose(env, "Program dump (scc? insn#: live_regs_before):\n");
> +	verbose(env, "Program dump (scc? loop_header? insn#: live_regs_before):=
\n");
>  	for (i =3D 0; i < insn_cnt; ++i) {
>  		verbose_linfo(env, i, "    ; ");
>  		if (env->insn_aux_data[i].scc)
>  			verbose(env, "%3d ", env->insn_aux_data[i].scc);
>  		else
>  			verbose(env, "    ");
> +		if (env->insn_aux_data[i].loop_header >=3D 0)
> +			verbose(env, "%3d ", env->insn_aux_data[i].loop_header);
> +		else
> +			verbose(env, "    ");
>  		verbose(env, "%3d: ", i);
>  		for (j =3D BPF_REG_0; j < BPF_REG_10; ++j)
>  			if (insn_aux[i].live_regs_before & BIT(j))
> @@ -19791,6 +19795,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
>  	if (ret < 0)
>  		goto skip_full_check;
> =20
> +	ret =3D bpf_compute_loops(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +
>  	ret =3D bpf_compute_scc(env);
>  	if (ret < 0)
>  		goto skip_full_check;

