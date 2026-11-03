Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714920;
	b=vCTBIbGKojfXE/JVtf/R2Ovui4idzCek9c/RXilL5AuwRTUbkPpRdnKu2C0L75WCVmEj
	 9S7M+taVNpAwRGoQAEwJ3TOjhPeOawza/+vtoR+dOfSepmfc0LsFPHQvhYNoYsWOZtAxd
	 TQmy8CawYcPLUYmedAIwCv+Jh1SFic2I2fJf6MHV3SH0no5T8lsqcAn+NciFoH8UaC+DH
	 oB2tsah2W8N+Hpg/bE9GhkZpEv3L3wYMeFV3WXMa+Dm0Uuwo2c7RNs5D2NfFPqN6SKjfN
	 KJNtOXug4Lq/7gTT4gXbvV/n1h7M0B+69z0XhIdX8t/1QIe2HpgvGBgRzQKu4KvQhNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714920;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=GW4jNKSFkrIJojKRL03BKJJ0vArMXf9a33X3OQmyHwo=;
	b=samHG1Rt2ErYj+VIiQJ9Pd4bxyVzNTrZM1b6Pf7KhFZjp3qWC8y7EfDqcNIQocSESS4I
	 mYGtaFE9fVhvRNOJa60d+Q3IZuZwD9sYcIsYM+TlJawG7MrU1rV5jReLXD/yFC05w1qBs
	 AwJ2E9w6iUL21zhFb9LiTGtUruuqZYhtqoeEnqZPML+U+FHhi0SklpxLsQ2Zxt3ZluWv8
	 CKvhIrgZbmShHFgAYEnH2Uy8hqWOTAMUr86eYpH3Ct30hxExfzm+mXdp7wNwBYgcYAX91
	 Y11uTyDNpJUfB+bs3XDrqW2jCcaqJXMX72LKu9eVPNHdnrMTC7yLdryZxPIKqAi6xsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hkm6aidd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B320D606A324;
	Tue,  3 Nov 2026 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hkm6aidd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A401F000C1;
	Tue,  3 Nov 2026 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714919;
	bh=GW4jNKSFkrIJojKRL03BKJJ0vArMXf9a33X3OQmyHwo=;
	h=Date:From:To:Cc:Subject;
	b=Hkm6aidd6s7Yk75CVd2ehH+dRuCUedYYt+7CUtp2PSdCAsqxeBOGogh95aHxi1/Ka
	 TTto/vhKjmqgBl7RLDxC8kKZqO5oU58YvRsc5hh8B+JgQco+yMmHUS9xWcd0uU5T9v
	 8chOxVnSsin1FAKga6BuIUYVCnjWd7XIfRS6tF5usaTk9MFD8J+7HKeZB54B2YqeJ9
	 81olxp6DgeaLj0jzDCJWFNbxyxIA4bfTwPuSteR52npj5Vb5+XTTEooISUUbBZVH15
	 UyKkCNUYfB07hECHaNh1Dw9hsK7S/LITIUE01JfZ6GM8aWOn1ys6YeYI7SkGq26S3J
	 4on8VGgcOfW9Q==
Date: Tue, 3 Nov 2026 14:08:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Qiliang Yuan <odys.yuan@gmail.com>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <aunq4v24N-Gzx_n3@sirena.org.uk>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WeDHvYUxQTGNZO5s"
Content-Disposition: inline


--WeDHvYUxQTGNZO5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/fixups.c

between commits:

  ec274bb4665c2 ("bpf: One may_goto time slice per prog invocation")
  1ddffb57b3623 ("bpf: Emit timed may_goto for JITed progs only")
  1ddffb57b3623 ("bpf: Emit timed may_goto for JITed progs only")

=66rom the bpf tree and commit:

  a7a767c66a2e2 ("bpf: Queue the rewrites of bpf_do_misc_fixups()")

and likely others from the bpf-next tree.  Given the nature of the
conflict and my total lack of familiarity with this code it seems
vanishingly unlikely that I'd be able to do a sensible merge here,
instead I will hold the bpf-next tree at the version from next-20261102.
If someone could help me out with the merge here that would be very much
appreciated.

The conflict is:

diff --cc kernel/bpf/fixups.c
index a656634fa9e46,ead78713e04f4..0000000000000
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@@ -1804,47 -1776,24 +1776,68 @@@ static int may_goto_expand(struct bpf_i
  }
 =20
  /*
++<<<<<<< HEAD
 + * Timed may_goto. All may_goto of a prog use one count and one timestamp=
: per-cpu memory of the
 + * prog, set in the first insns of the main prog, and by the callers of a=
sync callbacks.
 + * @reg holds the address. It is a register that is dead at the may_goto,=
 or R0 that is saved at
 + * @save_off in the stack.
 + */
 +static int may_goto_expand_timed(struct bpf_insn *insn_buf, int off,
 +				 struct bpf_timed_may_goto __percpu *tmg, int reg, int save_off)
 +{
 +	struct bpf_insn ld_tmg[] =3D { BPF_LD_IMM64(reg, (__force unsigned long)=
tmg) };
 +	int cnt =3D 0, jmp, tail_cnt =3D save_off ? 6 : 5;
 +
 +	if (save_off)
 +		insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_10, reg, save_off);
 +	insn_buf[cnt++] =3D ld_tmg[0];
 +	insn_buf[cnt++] =3D ld_tmg[1];
 +	insn_buf[cnt++] =3D BPF_MOV64_PERCPU_REG(reg, reg);
 +	insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_AX, reg, 0);
 +	if (save_off) {
 +		insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
 +		insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, reg, BPF_REG_10, save_off);
 +		jmp =3D cnt++;
 +		insn_buf[jmp] =3D BPF_JMP32_A(off >=3D 0 ? off + tail_cnt : off - jmp);
 +	} else {
 +		jmp =3D cnt;
 +		off =3D off >=3D 0 ? off + tail_cnt : off - jmp;
 +		if (off =3D=3D (s16)off) {
 +			insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, off);
 +		} else {
 +			insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 1);
 +			insn_buf[cnt++] =3D BPF_JMP32_A(off >=3D 0 ? off : off - 1);
 +		}
 +	}
 +	insn_buf[cnt++] =3D BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
 +	insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
 +	/* AX is the argument and the return value */
 +	insn_buf[cnt++] =3D BPF_MOV64_REG(BPF_REG_AX, reg);
 +	insn_buf[cnt++] =3D BPF_EMIT_CALL(arch_bpf_timed_may_goto);
 +	insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, reg, BPF_REG_AX, 0);
 +	if (save_off)
 +		insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, reg, BPF_REG_10, save_off);
 +	return cnt;
++=3D=3D=3D=3D=3D=3D=3D
+  * The offset of may_goto at 'idx' once the patches queued in front are a=
pplied.
+  * The patches that a forward may_goto jumps over aren't queued yet, so i=
ts
+  * offset stays as it is.
+  */
+ static int may_goto_off(struct bpf_verifier_env *env, const struct bpf_in=
sn *insn,
+ 			u32 idx)
+ {
+ 	struct bpf_patch_list *pl =3D &env->patch_list;
+ 	u32 tgt =3D idx + insn->off + 1;
+ 	int off =3D insn->off;
+ 	u32 k =3D pl->cnt;
+=20
+ 	if (off >=3D 0)
+ 		return off;
+ 	/* all queued patches are in front of idx */
+ 	while (k > 0 && pl->patches[k - 1].off >=3D tgt)
+ 		off -=3D pl->patches[--k].len - 1;
+ 	return off;
++>>>>>>> bpf-next/for-next
  }
 =20
  /* Do various post-verification rewrites in a single program pass.
@@@ -2125,36 -2050,43 +2097,53 @@@ int bpf_do_misc_fixups(struct bpf_verif
  			goto next_insn;
  		}
 =20
 -		if (bpf_is_may_goto_insn(insn) && bpf_jit_supports_timed_may_goto()) {
 -			int stack_off_cnt =3D -stack_depth - 16;
 -			/*
 -			 * AX is used as an argument to pass in stack_off_cnt
 -			 * (to add to r10/fp), and also as the return value of
 -			 * the call to arch_bpf_timed_may_goto.
 -			 */
 -			struct bpf_insn tail[] =3D {
 -				BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1),
 -				BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2),
 -				BPF_MOV64_IMM(BPF_REG_AX, stack_off_cnt),
 -				BPF_EMIT_CALL(arch_bpf_timed_may_goto),
 -				BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt),
 -			};
 +		if (bpf_is_may_goto_insn(insn) && timed_may_goto) {
 +			u16 live =3D env->insn_aux_data[i + delta].live_regs_before;
 +			int reg, save_off =3D 0;
 =20
++<<<<<<< HEAD
 +			/* a register that is dead here holds the address of the count */
 +			for (reg =3D BPF_REG_0; reg <=3D BPF_REG_9; reg++)
 +				if (!(live & BIT(reg)))
 +					break;
 +			if (reg > BPF_REG_9) {
 +				reg =3D BPF_REG_0;
 +				save_off =3D -stack_depth - 8;
 +				stack_depth_extra =3D 8;
 +			}
 +			if (!tmg) {
 +				tmg =3D alloc_percpu_gfp(struct bpf_timed_may_goto,
 +						       GFP_KERNEL_ACCOUNT);
 +				if (!tmg)
 +					return -ENOMEM;
 +				prog->aux->timed_may_goto =3D tmg;
 +			}
 +			prog->jit_required =3D 1;
 +			cnt =3D may_goto_expand_timed(insn_buf, insn->off, tmg, reg, save_off);
++=3D=3D=3D=3D=3D=3D=3D
+ 			/*
+ 			 * Two 8 byte slots, depth-16 stores the count, and
+ 			 * depth-8 stores the start timestamp of the loop.
+ 			 *
+ 			 * The starting value of count is BPF_MAX_TIMED_LOOPS
+ 			 * (0xffff).  Every iteration loads it and subs it by 1,
+ 			 * until the value becomes 0 in AX (thus, 1 in stack),
+ 			 * after which we call arch_bpf_timed_may_goto, which
+ 			 * either sets AX to 0xffff to keep looping, or to 0
+ 			 * upon timeout. AX is then stored into the stack. In
+ 			 * the next iteration, we either see 0 and break out, or
+ 			 * continue iterating until the next time value is 0
+ 			 * after subtraction, rinse and repeat.
+ 			 */
+ 			stack_depth_extra =3D 16;
+ 			cnt =3D may_goto_expand(insn_buf, insn->off,
+ 					      may_goto_off(env, insn, i),
+ 					      stack_off_cnt, tail, ARRAY_SIZE(tail));
++>>>>>>> bpf-next/for-next
 =20
- 			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
- 			if (!new_prog)
- 				return -ENOMEM;
-=20
- 			delta +=3D cnt - 1;
- 			env->prog =3D prog =3D new_prog;
- 			insn =3D new_prog->insnsi + i + delta;
+ 			insn =3D bpf_patch_list_add(env, i, insn_buf, cnt);
+ 			if (IS_ERR(insn))
+ 				return PTR_ERR(insn);
  			goto next_insn;
  		} else if (bpf_is_may_goto_insn(insn)) {
  			int stack_off =3D -stack_depth - 8;
@@@ -2762,86 -2630,49 +2687,102 @@@ next_insn
  			stack_depth_extra =3D 0;
  		}
  		i++;
- 		insn++;
+ 		insn =3D &prog->insnsi[i];
  	}
 =20
+ 	ret =3D bpf_patch_list_commit(env);
+ 	if (ret)
+ 		return ret;
+ 	prog =3D env->prog;
+=20
  	env->prog->aux->stack_depth =3D subprogs[0].stack_depth;
  	for (i =3D 0; i < env->subprog_cnt; i++) {
++<<<<<<< HEAD
 +		int subprog_start =3D subprogs[i].start;
 +		int stack_slots =3D subprogs[i].stack_extra / 8;
 +		/* an invocation begins, see bpf_timed_may_goto_save() for async callba=
cks */
 +		bool main_prog =3D tmg && !i;
 +		/* only a helper calls it, in a loop that ends when it returns 1 */
 +		bool loop_cb =3D tmg && i && subprogs[i].is_loop_cb && !subprogs[i].is_=
called &&
 +			       !subprogs[i].is_async_cb;
 +		int cnt =3D 0;
++=3D=3D=3D=3D=3D=3D=3D
+ 		int slots =3D bpf_jit_supports_timed_may_goto() ? 2 : 1;
+ 		int stack_slots =3D subprogs[i].stack_extra / 8;
++>>>>>>> bpf-next/for-next
 =20
 -		if (!stack_slots)
 +		if (timed_may_goto ? !main_prog && !loop_cb : !stack_slots)
  			continue;
 -		/* We need two slots in case timed may_goto is supported. */
 -		if (stack_slots > slots) {
 +		if (stack_slots > 1) {
  			verifier_bug(env, "stack_slots supports may_goto only");
  			return -EFAULT;
  		}
 =20
+ 		cnt =3D 0;
  		stack_depth =3D subprogs[i].stack_depth;
 -		if (bpf_jit_supports_timed_may_goto()) {
 -			insn_buf[cnt++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
 -						     BPF_MAX_TIMED_LOOPS);
 -			insn_buf[cnt++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth + 8, 0=
);
 +		if (timed_may_goto) {
 +			struct bpf_insn ld_tmg[] =3D {
 +				BPF_LD_IMM64(BPF_REG_0, (__force unsigned long)tmg)
 +			};
 +			int count_off =3D offsetof(struct bpf_timed_may_goto, count);
 +			int timestamp_off =3D offsetof(struct bpf_timed_may_goto, timestamp);
 +			int owner_off =3D offsetof(struct bpf_timed_may_goto, owner);
 +
 +			/* R0 has nothing at the entry */
 +			insn_buf[cnt++] =3D ld_tmg[0];
 +			insn_buf[cnt++] =3D ld_tmg[1];
 +			insn_buf[cnt++] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 +			if (main_prog) {
 +				insn_buf[cnt++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_0, count_off,
 +							     BPF_MAX_TIMED_LOOPS);
 +				insn_buf[cnt++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_0, timestamp_off, 0);
 +				insn_buf[cnt++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_0, owner_off, 0);
 +			} else {
 +				/*
 +				 * The time is up, but the helper would call the function again and
 +				 * again. End its loop. The verifier has seen that: the loop can end
 +				 * after each call.
 +				 */
 +				insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0,
 +							      count_off);
 +				insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2);
 +				insn_buf[cnt++] =3D BPF_MOV64_IMM(BPF_REG_0, 1);
 +				insn_buf[cnt++] =3D BPF_EXIT_INSN();
 +			}
  		} else {
  			/* Add ST insn to subprog prologue to init extra stack */
  			insn_buf[cnt++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
  						     BPF_MAX_LOOPS);
  		}
- 		/* Copy first actual insn to preserve it */
- 		insn_buf[cnt] =3D env->prog->insnsi[subprog_start];
- 		ret =3D bpf_adj_moved_insn(&insn_buf[cnt], cnt);
- 		if (ret) {
- 			verbose(env, "insn %d cannot be patched due to 16-bit range\n",
- 				env->insn_aux_data[subprog_start].orig_idx);
+ 		/* jumps to the first insn of the subprog skip the setup */
+ 		ret =3D bpf_patch_list_insert(env, subprogs[i].start, insn_buf, cnt);
+ 		if (ret)
  			return ret;
++<<<<<<< HEAD
 +		}
 +		cnt++;
 +
 +		new_prog =3D __bpf_patch_insn_data(env, subprog_start, insn_buf, cnt,
 +						 BPF_PATCH_MOVE_TARGET);
 +		if (!new_prog)
 +			return -ENOMEM;
 +		env->prog =3D prog =3D new_prog;
 +		/*
 +		 * If may_goto is a first insn of a prog there could be a jmp
 +		 * insn that points to it, hence adjust all such jmps to point
 +		 * to insn after BPF_ST that inits may_goto count.
 +		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
 +		 */
 +		WARN_ON(adjust_jmp_off(env->prog, subprog_start, cnt - 1));
++=3D=3D=3D=3D=3D=3D=3D
++>>>>>>> bpf-next/for-next
  	}
 =20
+ 	ret =3D bpf_patch_list_commit(env);
+ 	if (ret)
+ 		return ret;
+ 	prog =3D env->prog;
+=20
  	/* Since poke tab is now finalized, publish aux to tracker. */
  	for (i =3D 0; i < prog->aux->size_poke_tab; i++) {
  		map_ptr =3D prog->aux->poke_tab[i].tail_call.map;

--WeDHvYUxQTGNZO5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrp6uIACgkQJNaLcl1U
h9D/dwf/TxBkxeOE292IKzieXhiCZd7qa1kCnY1pHpU4YFnZK1YDki/ecsD6rGKx
nqoF990Y/y53gmu35lf59HvNjkM2Tyn+AV/16PB/K4nv0aPJ4IBFvR75ZYZS7rdm
AiGmBpmTGz/hDv70Wf+cZ0vg6zaHqDaHyM1aMDjKn0th6NoL4iE1HW3amlymtcWV
VnusbvXEbqbTG40umv1jJrcOKzXBE9KLoCPSV1246fBkFK8xKrCKS4uwUgK0i9op
DEHrb38zmL4ouTpabc4X1MevVYg9cbcYIj55L0q7AvyBdUDX+6PgKsHlHsnkWx9s
owBetpoMg36icaRXeO0vN7l1o/F16A==
=dHLG
-----END PGP SIGNATURE-----

--WeDHvYUxQTGNZO5s--
