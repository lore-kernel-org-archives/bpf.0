Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997543;
	b=LFZhPlU6KPkYW2Jtt4RhEuVXghfDlRdNRc+8B0ewdHGe5i0KxBg+7vU3IOZ75YuuVe0l
	 Bl6//AJoxhECi7MD/2qygJLaXAhB1fuRYbxkDGyXmCXKfARk0jTRnY80+6DUcaPAsVGjf
	 qV3qUHNEnVuTP6FgE0FAQqN17AfIorjrzEuOnqZWItKO3FYhASrn/bzBPr8CEJG+1VvcV
	 s/dr8DrdoCoIEGT8aMb16kFn+GXX95JNjcrcnfEhDVqAMIKlEH0GTDUXFRJDKsm2KEvM8
	 uMsxp4GTHXVgtZoCXZU2ncH65lA/HTBPNGZrYgk31AaX1uqEwwbFc61OCZSQJweHU7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997543;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+FuEkIeTPR7Fdxw4saV5qCNIsV+lc+Y/t6vPBUzB+6s=;
	b=pLQG8Va0EUtB7marHroB42mrzF09z6Lg0nzyv/m7Do6B7zzcU4jbMKWePa6gqBwtB5nc
	 CVWUwuvYKPOWOP1jmcgkuU+eL+oa9zdx4LeUs35x+cK9C68LRgwT6hWgOC9CLVv/+wCJa
	 A7VDHxsstU6ZT5mOj687vDHgRcaldemQzJYdFly+Iqwm1aSsGZCv+BRTahSlNV8wpmQRz
	 IhngW+VwG3HHR+9dKS+BWD6GVbkwK9j5bIQomGupp0PJPot8HKPJOjJiH7zhLWzlVZ1t8
	 eXOm3xtO2s+oi6uWOZi1ldFlD+h8Imu6PpWK8hySXKNSg51AUe7038ziskOzco2t5+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsKFxuTA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E14606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsKFxuTA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89541F0089F;
	Fri,  6 Nov 2026 20:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997542;
	bh=+FuEkIeTPR7Fdxw4saV5qCNIsV+lc+Y/t6vPBUzB+6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FsKFxuTAs327vpjRXRLUoEk5fMxjbkWakzxcgE8rpNe+diCzhkqmwT2X+fqBGEo8N
	 OX2aL3UkRLZxqHoXIGj9i0x4wYVUyL8UqZCQqNLgnPPUdXcfDp9XGjVNVgYB1u+QSM
	 Sq4U2yuxrqye/mgsxjXgfJHEgYFex3zPvQLiXpEcACrlvrdk19TBzEcXwlWjYWLBDX
	 yfyiM5PfjQEK1HgRvisQLeG0RozI0QSJKHudlEGGOQKRQXK8Z7vMHpZ1LcqV2/7I4M
	 D+fMUgfYUdxxGr8pcmjsO2QZ9XyBT58+Fx5kXxQmuW3or62iAyvbE53aJuS2kdwEAQ
	 l6j/EN9QHjhNA==
Message-ID: <sashiko-outbox-202249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 5/7] libbpf: Implement
 bpf_gen__struct_ops_update_elem() for light skeletons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Nayyar" <sidnayyar@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261106-lskel-struct-ops-v1-5-a4486ffc79cb@google.com>
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
 <20261106-lskel-struct-ops-v1-5-a4486ffc79cb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:39:02 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] libbpf: wrong prog_fd[] stack index in
  bpf_gen__struct_ops_update_elem()
- [Low] libbpf: module BTF FD leak on error path in
  bpf_gen__struct_ops_update_elem()
--

commit 54b2859f2dcde10dc15af7a3b316556b814dfd0e
Author: Siddharth Nayyar <sidnayyar@google.com>

libbpf: Implement bpf_gen__struct_ops_update_elem() for light skeletons

This commit adds bpf_gen__struct_ops_update_elem() and calls it from
bpf_object_prepare_struct_ops() to close attach_btf_obj_fd, copy callback
program file descriptors into kern_vdata, and emit the map update for
struct_ops maps in light skeletons.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index aaa491463521a..6dcba83dcc098 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -1573,3 +1573,61 @@ void bpf_gen__init_kern_struct_ops(struct bpf_gen =
*gen, struct btf *btf,
>  		}
>  	}
>  }
> +
> +void bpf_gen__struct_ops_update_elem(struct bpf_gen *gen, int map_idx,
> +				     struct btf *btf,
> +				     struct bpf_struct_ops *st_ops)
> +{
> +	int attr_size =3D offsetofend(union bpf_attr, flags);
> +	const struct btf_type *type;
> +	union bpf_attr attr;
> +	int key, zero =3D 0;
> +	__u32 i;
> +
> +	/* 1. Close attach_btf_obj_fd (upper 32 bits of st_ops->type_id_off) */
> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
> +					 0, 0, 0, st_ops->type_id_off));
> +	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0));
> +	emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 32));
> +	__emit_sys_close(gen);

[Severity: Low]
Does this leak attach_btf_obj_fd if an earlier runtime check fails and jumps
to cleanup_label?

When the target struct_ops type is in a kernel module,
bpf_gen__init_kern_struct_ops() stores the module btf file descriptor in the
upper 32 bits of st_ops->type_id_off before map creation and program loading
are emitted.  Because gen->cleanup_label only closes stack file descriptors
and fd_array map file descriptors, any emit_check_err() failure before
reaching bpf_gen__struct_ops_update_elem() leaves attach_btf_obj_fd open.

> +
> +	/* 2. Populate prog_fd into kern_vdata for all callback members */
> +	type =3D btf__type_by_id(btf, st_ops->type_id);
> +	for (i =3D 0; i < btf_vlen(type); i++) {
> +		struct bpf_program *prog =3D st_ops->progs[i];
> +		int prog_idx, off_slot;
> +
> +		if (!prog)
> +			continue;
> +
> +		prog_idx =3D bpf_program_idx(prog);
> +		off_slot =3D st_ops->kern_func_off[i];
> +
> +		/* R2 =3D dynamic kernel member offset from off_slot */
> +		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +						 0, 0, 0, off_slot));
> +		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0));
> +		emit(gen, BPF_JMP_IMM(BPF_JLE, BPF_REG_2,
> +				      KERN_VDATA_MAX_SIZE - sizeof(__u64), 2));
> +		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -E2BIG));
> +		emit_check_err(gen);
> +
> +		/* R1 =3D kern_vdata_off + offset */
> +		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +						 0, 0, 0, st_ops->kern_vdata_off));
> +		emit(gen, BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2));
> +
> +		/* R0 =3D prog_fd from stack (stack_off(prog_fd[prog_idx])) */
> +		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10,
> +				      stack_off(prog_fd[prog_idx])));

[Severity: Medium]
Can stack_off(prog_fd[prog_idx]) read the wrong stack slot or go out of
bounds when obj->programs[] contains subprograms or non-autoloaded programs?

bpf_program_idx() returns prog - prog->obj->programs, whereas
bpf_object__load_progs() skips subprograms (such as functions in .text) and
non-autoloaded programs, and bpf_gen__prog_load() stores each loaded
program's file descriptor sequentially at stack_off(prog_fd[gen->nr_progs]):

tools/lib/bpf/gen_loader.c:bpf_gen__prog_load() {
	...
	/* remember prog_fd in the stack, if successful */
	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
			      stack_off(prog_fd[gen->nr_progs])));
	gen->nr_progs++;
}

When any skipped program precedes prog in obj->programs[], prog_idx does not
match the program's slot in prog_fd[], so the generated loader either writes
the wrong file descriptor into kern_vdata or emits an out-of-bounds stack
read that the verifier rejects if prog_idx exceeds the prog_fd[] array size.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lskel-stru=
ct-ops-v1-0-a4486ffc79cb@google.com?part=3D5
