Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9C3C10B5
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936413; cv=none; b=BRr1b0kkonIbfL0lhNkri7E/9Hsh7K78/iLPzvhemOqQV6ezL5kdU4jFecmM1yqv+PKz+Su0pS7U1iIADLQ4/0y3qF0+BXoXdYTnmq1ZnKCOafivhISF7CerJnq6Sjk8rUDsTYOP0z2rUuG0/rnC5bzRbB7VL6XNwvxR9QhH9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936413; c=relaxed/simple;
	bh=34Ot9wYWvNaaM3Ws87gW7++rG8gZ0EbQcB3Wt5hfwQ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VrESptWn9RTjo2lNzqEeuwQrPUofO/4keko/Q3oDsTS4MOojWdXw6vc4BMEc68MW1SsvJLvirm2gJCdhmd1Nd5b8FE3i6j5wvDq1y9Of/kp8Ju0TeU/PEy0WJ61OL2XRXEsRst/6cNAkFflBDuLrVjdQskxKic51pysLz+tMXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IieV1+P2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IieV1+P2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C691F00A3A;
	Wed,  9 Sep 2026 06:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936409;
	bh=EvtWaVRb0K18u8fo46oX8uTZAz0ONandh0wnuzuBMZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IieV1+P2eZgOGHD7OSNV/cWFWgJq5gWh0fBisFuJD7H2VVpX60zYal4O+eds/cZ2U
	 TWQyyhh8T5t2yqg5d4jruyEObmUmVmW4KKXTJh8X/lX1KfS9m07ge9CdOLElCF3ZMF
	 b8ToTpXCFaYkH4bUNrNrXm0uMxHt2MfreDQ831WTKPO6qUzgw4Gh/8ExuQA1EvE2fg
	 wxFehFXDLw5TGRi2vxKCZHJOJzhu9TLLkVM8BL7aHNY9igUvStzstk1MlaiveJVCce
	 cQ9JtPkP3V23karZu/JJKmJHTlzIQFsTM7ZjXKJn1VJfY0EIgsJH05VpKQ06C2JnWa
	 8kPHdQSSKBQDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 07/12] bpf: Prepare kfunc arguments for the
 JIT from an ABI description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909062559.4007404-1-yonghong.song@linux.dev>
References: <20260909062522.4001896-1-yonghong.song@linux.dev>
 <20260909062559.4007404-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:46:48 +0000
Message-Id: <20260909064649.55C691F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Stack buffer overflow in `bpf_jit_plan_arg_moves` and `kfunc_abi=
_slots` due to undersized arrays based on maximum arguments rather than max=
imum slots.
--

commit 180655f49c406c35435ba5ebc05f2900a3c56656
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Prepare kfunc arguments for the JIT from an ABI description
   =20
The previous patch refuses a kfunc argument of more than one eightbyte.
This patch allows up to 16 byte kfunc arguments.

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 00ad8b63aa477..01b52d0259d18 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
[ ... ]
> @@ -1248,6 +1248,38 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, =
bool in_arena);
> +
> +/* The JIT's scratch register, in place of an argument slot. */
> +#define BPF_JIT_ARG_TMP		0xff
> +
> +/* Every argument slot moves at most once, and the scratch goes out and =
back. */
> +#define BPF_JIT_MAX_ARG_MOVES	(MAX_BPF_FUNC_ARGS + 2)

[Severity: Medium]
Since arguments can now take up to 2 slots (for 16-byte arguments), could t=
he
maximum number of slot moves actually be up to 26 (24 slots + 2) instead of=
 14?

> +
> +struct bpf_jit_arg_move {
> +	u8 dst;
> +	u8 src;
> +};
[ ... ]
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index c673b02d55a65..d4bd2ba9aadee 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -3287,6 +3287,100 @@ bool __weak bpf_jit_supports_kfunc_ret_reg_pair(v=
oid)
> +
> +u32 bpf_jit_place_args(const struct bpf_jit_arg_abi *abi,
> +		       const struct btf_func_model *fm, u8 *pos_of_slot)
> +{
> +	u32 i, k, nslots, slot =3D 0, nregs_used =3D 0, stack_off =3D 0;
> +	bool on_stack =3D false;
> +
> +	for (i =3D 0; i < fm->nr_args; i++) {
> +		bool align16 =3D fm->arg_flags[i] & BTF_FMODEL_ALIGN16_ARG;
> +		u32 pos;
> +
> +		nslots =3D btf_func_model_arg_slots(fm, i);
[ ... ]
> +		for (k =3D 0; k < nslots; k++)
> +			pos_of_slot[slot + k] =3D pos + k;

[Severity: Medium]
Will this overflow the pos_of_slot array if an architecture adopts this API
for BPF trampolines?

The callers currently size the array based on MAX_BPF_FUNC_ARGS (12), but=20
slot + k can reach up to 23 because some arguments can require multiple slo=
ts.

> +		slot +=3D nslots;
> +	}
> +
> +	return slot;
> +}
> +
> +u32 bpf_jit_plan_arg_moves(const struct bpf_jit_arg_abi *abi,
> +			   const struct btf_func_model *fm,
> +			   struct bpf_jit_arg_move *moves)
> +{
> +	u8 pos_of_slot[MAX_BPF_FUNC_ARGS];

[Severity: Medium]
Does this stack array need to be sized for the maximum number of slots
(e.g., MAX_BPF_FUNC_ARGS * 2) instead of the maximum number of arguments?

> +	u32 nslots, n =3D 0, s, back;
> +
> +	nslots =3D bpf_jit_place_args(abi, fm, pos_of_slot);
[ ... ]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 94c359351bb69..2b8df8c7f098c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -12172,6 +12172,58 @@ static u32 kfunc_proto_slots(const struct btf *b=
tf, const struct btf_type *func_
>  	return slots_used;
>  }
> =20
> +static u32 kfunc_abi_slots(const struct btf_func_model *fm)
> +{
> +	const struct bpf_jit_arg_abi *abi =3D bpf_jit_arg_abi();
> +	u8 pos_of_slot[MAX_BPF_FUNC_ARGS];

[Severity: Medium]
Similarly, does this stack array also need to be sized to accommodate up to
24 slots rather than 12 arguments to prevent an out-of-bounds write in
bpf_jit_place_args()?

> +	u32 i, nslots, slots =3D 0;
> +
> +	for (i =3D 0; i < fm->nr_args; i++)
> +		slots +=3D btf_func_model_arg_slots(fm, i);
> +
> +	if (!abi)
> +		return slots;
> +
> +	nslots =3D bpf_jit_place_args(abi, fm, pos_of_slot);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909062522.4001=
896-1-yonghong.song@linux.dev?part=3D7
