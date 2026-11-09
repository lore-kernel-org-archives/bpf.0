Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207971;
	b=5pPJh8NA7K+92T3Ihd5BX51Z9QHxfIiv2Fc8qQOf05C+JksBOACEvIQIP5wf0XUvhjSL
	 ZNJ4Mglu+0tcePHZWG8eUmvxuudRhS7UO5FBnxOZwsHInORRiqNuI0WqXe9xdrHWQa/Sb
	 ixd9oMAuZrSZ1Z/sKAjPMqYlK+jjv8LCLpiZdkKrwi4mLy5pof5OkOwLzaN+SyDnTkD8n
	 s1gAF2wu9nNz72NG3iwbSvJphGCms+0TYyJcwUxmp58r8xOWnctrlv5a0TOxnvrjNi7Mx
	 pqg1ooDZ5yXyAwrJMwYMyMMc62k7ZdJe4/qCkCdm/vVg3D7YRrh0oH/q1PMgJfoM6cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207971;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a95y8aSKz++4h1LuwQsejlcsQS9skrV6KZI0mprESRU=;
	b=oO1yRYmkZ/ltq3aUsTe9O1ArpBycPkDgNltOstVJaCGH0Q5UPpYVSkE1jbva9X5riflP
	 jUvrx9VFjE8TCfpKRwp/yUmOINC6TG6nZRPiVqZjfZ4wzng/m0f+QTdIB+IquRvlw73av
	 b9aOVIMcOZg02YbAyGCQvKIHJK4gWgexRBi7K/N5d/5v/RODju3JAiXskooJE/I57kwQe
	 RhF/OzoC9+qUlU4dEe9BsymFx4ITU7JG+7tUFNojJb8vF29JkwMRUEVYlE1uKCOybBm1R
	 m/PvjE6CYR+tA0Lqg/C8XiZdo1uBjT22KPBNFabZcy6wTW55pTQcVZDy9c3oJKu9FKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNQnUiRd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4614606A322
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNQnUiRd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0471F008A1;
	Mon,  9 Nov 2026 07:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794207969;
	bh=a95y8aSKz++4h1LuwQsejlcsQS9skrV6KZI0mprESRU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HNQnUiRdVw5RCP1T9OSOj6j4+tKeFNPy0JL2PPcDBtW+FJAKvRRDSzeEhz1TokIWC
	 7M1UOoXMpUub1oZnoBxQCf0hZeLOEx3S3AUlu2VTAtXNigofjgfFS0Bkpe6V88KQBr
	 NZ0+TTDh3e+HjYmuOCtB0LWDrEmO/H0hdYJFVtKEOQN4q56Te2DzZVzg2Cc40ObbPU
	 9vTI1yYmRarj0RODDq1xmeUKgCayx0D+tx68troCCywf7Qvf49c+hyqBU5e7zHuX3i
	 jS19TqpMWYfCPBpxrSRc3mu5+crgtu1VUjvYbIbMkrEVoSIhpUB01F17MOrWvFX3m8
	 JCJdiVTjA8glw==
Message-ID: <sashiko-outbox-204525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 22/26] bpf: Remove scalar ids from regsafe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261109064715.2382452-23-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
 <20261109064715.2382452-23-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 07:06:09 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: alpha-renaming of struct_ops ctx_arg_info ref_id in
  check_ids() [1]
--

commit 4ddf1d7e2a622751a128b84cb218611e091c605f
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Remove scalar ids from regsafe()

This commit removes check_scalar_ids() and the scalar ID comparison logic f=
rom
regsafe(), as scalar registers no longer carry IDs.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index b606763496552..48359e789faad 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -58,7 +58,7 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bp=
f_idmap *idmap)
>  		return true;
> =20
>  	/* a name of what the caller has, see BPF_INHERITED_ID */
> -	if (((old_id | cur_id) & ~BPF_ADD_CONST) >=3D BPF_INHERITED_ID)
> +	if ((old_id | cur_id) >=3D BPF_INHERITED_ID)
>  		return old_id =3D=3D cur_id;

[Severity: Critical]
This problem wasn't introduced by this patch, but can check_ids() [1]
map an unrelated reference ID in cur->refs[] to a struct_ops __ref context
argument's fixed aux->ctx_arg_info[i].ref_id during refsafe()?

In do_check_common(), the verifier acquires a reference for each __ref
struct_ops context argument and stores the literal ID in
aux->ctx_arg_info[i].ref_id, while BPF_REG_1 (PTR_TO_CTX) keeps id =3D=3D 0.
When the program later loads that argument from PTR_TO_CTX, btf_ctx_access()
populates info->ref_id from ctx_arg_info[i].ref_id, and __check_ctx_access()
checks whether that literal ID is still in env->cur_state->refs[]:

kernel/bpf/verifier.c:__check_ctx_access() {
	...
		if (base_type(info->reg_type) =3D=3D PTR_TO_BTF_ID) {
			if (info->ref_id &&
			    !find_reference_state(env->cur_state, info->ref_id)) {
				verbose(env, "invalid bpf_context access off=3D%d. Reference may alread=
y be released\n",
					off);
				return -EACCES;
			}
		}
	...
}

Because ctx_arg_info[i].ref_id is a normal ID below BPF_INHERITED_ID and is
not anchored to PTR_TO_CTX, refsafe() -> check_ids() allows alpha-renaming =
it.
If an earlier branch keeps the initial context reference (id =3D 1) and a l=
ater
branch releases id =3D 1, acquires an unrelated reference (id =3D 2), and r=
eaches
the same pruning point with PTR_TO_CTX still live, check_ids() maps cur_id =
=3D 2
to old_id =3D 1 and prunes the second branch.  If the code after the merge =
point
reloads the __ref argument from PTR_TO_CTX, the second path uses or releases
the already-released context object, causing a use-after-free, double free,=
 or
reference leak.

[1] https://sashiko.dev/#/bug/linux-3dbabad3-179e-4dd4-a907-20f15cf47b12

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109064715.2382=
452-1-alexei.starovoitov@gmail.com?part=3D22
