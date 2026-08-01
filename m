Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0ADEEA8
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785571400; cv=none; b=llxTQ0nHHBj7zM5JXXQ+BBmK/o0ly3UHzZvyiMa2dpgj+hLO956TQ/5O9KTvAoNhk59jWzu2m/FY4DO1si5qqp5SQVG6UPD6en4WlLlYqTvwgOub6yNbKJO68ZGqiDvoQGfcPmXG0DnTNcXePedTHS2cyyQES8VI5pwRzPsFTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785571400; c=relaxed/simple;
	bh=KB9uU0Hp2R5ojVpR30iiD1eP/1V5Zx441nyxZBy6Q2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UI5bWSnBkC7ac6CKqOsjZ6e6SAenpyIpW31jYBFW+0WvfdrqlRhkqgCCnSzmYA7MpPqxBnyhMQwQYpkDYjLOY9pQGbevAtI9p+7m9AMVIZ25F3/UUWwnU3TuKsK9KTCqKivZMCvF/2W9McXOA0N36Y05p/wU6qcqa9D1Ie6TUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eagx0jzi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eagx0jzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9C51F00AC4;
	Sat,  1 Aug 2026 08:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785571399;
	bh=D/eCNB429xJFm78UDlLx/QVl9HnWdW6hQv1QD7oUNhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eagx0jzi/wdRBQ0MDkdY1S1qBaoCZ76xhp0ZTCn4mRqcLCWAoKbSgu9pMHvpB/YQH
	 W2CjL6/wZQWyq8oEEm5lEyKJTxaU3l2fy2VIhQ0hcbzlGqLFh2gN204oLIYGkFToUP
	 ipHhp6f9pG7PbS3yV3pU9G5/xq2gg3vd2XyNrU6eLw4vklsC/mLaUYXoAxOdjDQQZ7
	 08MaDRS3GtrZXga5FIJ6vILd8zhgQBcGMRQAa1m3RzGM9X0VRty723tckid6if5hkq
	 8PZ8Cy+8kX5pc8IRRZAJNySckPyuoYmdZj7yBL2o80vAoR9sUb6g9w0HUr3HXav1PV
	 aBPaCZmlljD0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 02/18] bpf: Unify const map ptr argument
 checking for helpers and kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260801074633.1595644-3-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
 <20260801074633.1595644-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 08:03:18 +0000
Message-Id: <20260801080319.0E9C51F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Latent NULL Pointer Dereference in process_map_ptr_arg
- [Low] Incorrect error reporting for non-adjacent object and map arguments
- [Low] Misleading error message when a map contains both a timer and a wor=
kqueue
--

--- Patch [2]: [PATCH bpf-next v3 02/18] bpf: Unify const map ptr argument =
checking for helpers and kfuncs ---
commit 28f78cdb3fca90eedfb38c316b9b1e6ce726d4a2
Author: Amery Hung <ameryhung@gmail.com>

bpf: Unify const map ptr argument checking for helpers and kfuncs

This patch refactors the verifier to use a single process_map_ptr_arg()
function for validating constant map pointer arguments in both helpers and
kfuncs. The new logic attempts to dynamically derive the bound object name
from the map's BTF record and computes the register numbers relative to
the map argument position.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 616194f25dfb7..4a5b542192106 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8274,6 +8274,44 @@ static int get_constant_map_key(struct bpf_verifie=
r_env *env,
> =20
>  static bool can_elide_value_nullness(const struct bpf_map *map);
> =20
> +static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg,
> +			       argno_t argno, struct bpf_call_arg_meta *meta)
> +{
> +	/* Use map_uid (which is unique id of inner map) to reject:
> +	 * inner_map1 =3D bpf_map_lookup_elem(outer_map, key1)
> +	 * inner_map2 =3D bpf_map_lookup_elem(outer_map, key2)
> +	 * if (inner_map1 && inner_map2) {
> +	 *     timer =3D bpf_map_lookup_elem(inner_map1);
> +	 *     if (timer)
> +	 *         // mismatch would have been allowed
> +	 *         bpf_timer_init(timer, inner_map2);
> +	 * }
> +	 *
> +	 * Comparing map_ptr is enough to distinguish normal and outer maps.
> +	 */
> +	if (meta->map.ptr &&
> +	    (meta->map.ptr !=3D reg->map_ptr || meta->map.uid !=3D reg->map_uid=
)) {
> +		argno_t obj_argno =3D argno_from_reg(reg_from_argno(argno) - 1);

[Severity: Low]
Does this incorrectly assume the bound object strictly precedes the map
argument in all function signatures?

If a custom module kfunc interleaves arguments (e.g., passing a flag between
the object and the map) or if the map is passed on the stack, this arithmet=
ic
will yield the wrong register or a negative value.  For instance, if the map
is the first argument, it might calculate negative registers and print
garbage like fp-1992 in the verifier log.

> +		struct btf_record *rec =3D meta->map.ptr->record;
> +		const char *obj_name =3D "workqueue";
> +
> +		if (rec->timer_off >=3D 0)

[Severity: Medium]
Can this unconditionally dereference rec when it is NULL?

If the verifier processes a kfunc that takes multiple map pointers (e.g., i=
n a
custom module), the first map passed is tracked in meta->map.ptr. If that f=
irst
map is a simple array or hash map without any special BTF fields, its record
will be NULL. When the verifier processes the second map argument and it
mismatches, it will hit this check and crash due to a NULL pointer derefere=
nce.

[Severity: Low]
Will this produce misleading error messages if a map contains both a timer =
and
a workqueue?

A BPF map value can validly contain both a bpf_timer and a bpf_wq, meaning =
its
btf_record will have both timer_off >=3D 0 and wq_off >=3D 0 true.=20

If a user calls bpf_wq_init() but accidentally passes a mismatched map, this
conditional guesses the object type purely from the map's record and priori=
tizes
the timer field. It will incorrectly print an error about a timer pointer
mismatch, which would mislead the user who was explicitly working with a
workqueue.

> +			obj_name =3D "timer";
> +		else if (rec->task_work_off >=3D 0)
> +			obj_name =3D "bpf_task_work";
> +
> +		verbose(env, "%s pointer in %s map_uid=3D%d ",
> +			obj_name, reg_arg_name(env, obj_argno), meta->map.uid);
> +		verbose(env, "doesn't match map pointer in %s map_uid=3D%d\n",
> +			reg_arg_name(env, argno), reg->map_uid);
> +		return -EINVAL;
> +	}
> +
> +	meta->map.ptr =3D reg->map_ptr;
> +	meta->map.uid =3D reg->map_uid;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801074633.1595=
644-1-ameryhung@gmail.com?part=3D2
