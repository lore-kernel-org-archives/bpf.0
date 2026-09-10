Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705B329E5D
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 05:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789016488; cv=none; b=TV5l401IEfpAzpsiyclMXkJlUkLOd0VhmOaUlC844lsCsK3y0HwYMdkO8eE3phDeYdf7pwz6bjIw+laLs9KVk+QcynY1+lj4HW1z46QfXNCerREGcIRDlS6dS8qLD4umQrREHMXM7SGCnTWIpLzg2uJK/H5KPjFwLt2oR/wWtbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789016488; c=relaxed/simple;
	bh=gRUtaVWOWxFlJ+VS3FKcWDUPIs+M9zsArx3Nv7lMeT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ed7Iz3/uwQ1lEsuNFxFJhP97ZbzA13xC79BREjwLIFfP5cMCpWwYjPSS0J8BaVgv4R9CZLFtyVn0msqqQ9gJ+1WKewPbeI1XHDFGVjp1grqSMhDFnjL1GRoGqAGbhvsRLPXE1NSBhd+RfS4aRRHj2vIO7uYAqJOydnZgGy7JfVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHQnnhs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHQnnhs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A8E1F000FF;
	Thu, 10 Sep 2026 05:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789016487;
	bh=hwenWM6AMZglNltYB0m8OvjvNYE7rUwd2aakNm2iWpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UHQnnhs7eQYCKP726ivbS5K85II9xMQF1cOTrs5yQh4RLAvWPDhesMcHGSKQMwBtx
	 NRbuhUKPxrabJO4P6LPcyBtOdhPD2x0kF44tCkL57cyAi7EBfcJ+GjqbFLyYJxRBA/
	 ok9cR1eLnFyOCB8ka0hoNmYOzyQ3tN7o9zFiFMK58CLdqhX377ZWSrt+4yfowe711i
	 a4pUU/Zv5j6S4iHEf3R6crA2ly2CLLVRXt6xUvoRxk6Nqp9m3DnN5GlYRuPKD3cb1X
	 BuZeP96ht9YhYbq4UxMqMylNv6ObLGunu3U5l/RYT1C/6ivZ0sLNLAVGMm/3P0BQnM
	 vllvBk9beu5MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Preserve escaped dynptr slice ancestry
 on subprog return
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910044006.2279547-2-xyx2021@mail.ustc.edu.cn>
References: <20260910044006.2279547-1-xyx2021@mail.ustc.edu.cn>
 <20260910044006.2279547-2-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 05:01:26 +0000
Message-Id: <20260910050127.31A8E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A subprogram can return or spill a memory slice (PTR_TO_MEM) d=
erived from a local dynptr backed by its own stack frame, leading to a stac=
k Use-After-Free in the caller.
- [Critical] Creating a local dynptr from a referenced dynptr slice via bpf=
_dynptr_from_mem strips lifetime tracking, allowing use-after-free.
--

commit 670ebab06aaf35b7713f2c4efe3dba56988a2162
Author: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

bpf: Preserve escaped dynptr slice ancestry on subprog return

Before freeing a callee, reparent surviving PTR_TO_MEM slices of every
dynptr with a parent to that parent. This preserves the lifetime link after
the local dynptr disappears for both reference-owning dynptrs and dynptrs
constructed from referenced objects.

Link: https://lore.kernel.org/r/20260829040712.B1B511F000E9@smtp.kernel.org

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 72a3f5998dd27..ee41b7386f752 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -800,6 +800,39 @@ static int dynptr_ref_cnt(struct bpf_verifier_env *e=
nv, int v_parent_id)
>  	return ref_cnt;
>  }
> =20
> +static void reparent_dynptr_slices_on_func_exit(struct bpf_verifier_env =
*env,
> +						struct bpf_func_state *callee)
> +{
> +	struct bpf_verifier_state *vstate =3D env->cur_state;
> +	struct bpf_func_state *state;
> +	struct bpf_reg_state *reg;
> +	int i;
> +
> +	for (i =3D 0; i < callee->allocated_stack / BPF_REG_SIZE; i++) {
> +		struct bpf_stack_state *slot =3D &callee->stack[i];
> +		struct bpf_reg_state *dynptr =3D &slot->spilled_ptr;
> +
> +		if (slot->slot_type[0] !=3D STACK_DYNPTR ||
> +		    !dynptr->dynptr.first_slot ||
> +		    !dynptr->parent_id)
> +			continue;

[Severity: Critical]
This is a pre-existing issue, but does this logic leave a gap for local
dynptrs backed by a callee's stack frame?

Because local dynptrs have parent_id =3D 0, they are skipped here. This see=
ms
to allow a subprogram to return or spill a PTR_TO_MEM slice derived from a
local dynptr into the caller's state.

Since prepare_func_exit() only prevents returning PTR_TO_STACK in R0, could=
 a
PTR_TO_MEM alias created via bpf_dynptr_data() escape and allow a stack
use-after-free in the caller?

[ ... ]

[Severity: Critical]
This is also a pre-existing issue, but does bpf_dynptr_from_mem() strip
lifetime tracking when used with referenced dynptr slices?

If a program reserves a ringbuf dynptr, gets a PTR_TO_MEM slice via
bpf_dynptr_data(), and then passes that slice to bpf_dynptr_from_mem():

kernel/bpf/helpers.c:bpf_dynptr_from_mem_proto() {
    ...
    .arg1_type =3D ARG_PTR_TO_UNINIT_MEM,
    ...
}

kernel/bpf/verifier.c:mark_stack_slots_dynptr() {
    ...
    parent_id =3D ref_obj->id;
    ...
}

The new dynptr's parent_id is incorrectly assigned 0 because the slice's
parent_id is not propagated. Could the resulting local dynptr be accessed
after the original ringbuf reservation is discarded, leading to a
use-after-free of referenced kernel objects?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910044006.2279=
547-1-xyx2021@mail.ustc.edu.cn?part=3D1
