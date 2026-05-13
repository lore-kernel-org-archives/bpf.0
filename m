Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339A175A68
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716611; cv=none; b=LcQd3ih+O6EBK8C/aL9PDXKeVHHIluo1ozrVE1cO3UYNcNeGp97yHw7ESjXSicTtiZqvMOYhpLo1qalm59vUogyqQe0IEUijOpOc2g7rGcNm0dedDVNCxUUrhGn0RrxaRcU8NmJiFS9AXzcf5C++78iImp+KILtJTCQjSYZJehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716611; c=relaxed/simple;
	bh=nlZMr1gpUTtPJyugqWyzw6M+m+J01GltKN2OMPSKbuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/CsSPbgyr7RxGaTcNNTeeMScFySKhVI7jhrT4FMd+NXCYtvJQiGuL0FBWT0n4cPCgF77xfSkYq+F3qxghgwQn+3W8RVnX0xjntuJJ27Xhhm3FENF7Hm739zQFOcLX7Hae9sr55oQa2lcYbNJFxKwQhGtvXshkQQJpQeqwNwFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHdipIcu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHdipIcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40146C19425;
	Wed, 13 May 2026 23:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778716611;
	bh=nlZMr1gpUTtPJyugqWyzw6M+m+J01GltKN2OMPSKbuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bHdipIcuSLL80tExQ9jB0LQkfw1AI4Gi7cquwWlhGfqPuzXlVJGA/s70yaSqNNTJ6
	 25VArj86Apf3vSboCQQMe5xmJfTFNAIk56H+CBMcjUfxElV41xHSULLn5UfLDUQGS5
	 oAyiD4B2YNBqeLArlIrEbeNx6zlwRZKNcd2ESOpmdfYqzm4kbs8oDGX9vv+I0AhWyP
	 mH+o0fPrNuay/4YJ13bLdYSfb7DbUqnyiAUOAjeXrg4DAroqb7QJ0mjH0PyTIPPxTr
	 NoZKWqhUf1ZUJZhImRqCig5q6UCpB1L4YleowrPGfee0N6QJqNhN5VqnVNRTS+xM8i
	 b32o9QNjd73aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v14 4/8] bpf: Add syscall common attributes
 support for prog_load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260512153157.28382-5-leon.hwang@linux.dev>
References: <20260512153157.28382-5-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:56:50 +0000
Message-Id: <20260513235651.40146C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The log attribute merge logic in bpf_log_attr_init() incorrectly=
 relies solely on the presence of log_buf to detect log parameters, ignorin=
g valid requests from bpf_common_attr and bypassing conflict checks.
--

commit 1f52aae509f179f0117e37fa0cdfc161beb16d35
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add syscall common attributes support for prog_load

This commit allows BPF_PROG_LOAD to accept log parameters from either union
bpf_attr or struct bpf_common_attr. The merge rules are designed to use
complete log tuples from either side or return an error if they differ.

> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 1b1efe75398b7..fd12ad5a0338d 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c

[ ... ]

> @@ -827,16 +827,36 @@ void print_insn_state(struct bpf_verifier_env *env,=
 const struct bpf_verifier_st
>  }
> =20
>  int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_siz=
e, u32 log_level,
> -		      u32 offsetof_log_true_size, bpfptr_t uattr)
> +		      u32 offsetof_log_true_size, bpfptr_t uattr, struct bpf_common_at=
tr *common,
> +		      bpfptr_t uattr_common, u32 size_common)
>  {
> +	char __user *ubuf_common =3D u64_to_user_ptr(common->log_buf);
>  	char __user *ubuf =3D u64_to_user_ptr(log_buf);
> =20
> +	if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common, common=
->log_size) ||
> +	    !bpf_verifier_log_attr_valid(log_level, ubuf, log_size))
> +		return -EINVAL;
> +
> +	if (ubuf && ubuf_common && (ubuf !=3D ubuf_common || log_size !=3D comm=
on->log_size ||
> +				    log_level !=3D common->log_level))
> +		return -EINVAL;

The commit message states that if both sides provide complete tuples but
they differ, it should return -EINVAL.

If a user wants to query the true log size, they can set log_level > 0
with log_buf =3D NULL and log_size =3D 0. This is explicitly permitted by
bpf_verifier_log_attr_valid().

If both attr and attr_common omit the log buffer but provide conflicting
log_level values, will this bypass the conflict check since both ubuf and
ubuf_common evaluate to NULL?

>  	memset(log, 0, sizeof(*log));
>  	log->ubuf =3D ubuf;
>  	log->size =3D log_size;
>  	log->level =3D log_level;
>  	log->offsetof_true_size =3D offsetof_log_true_size;
>  	log->uattr =3D uattr;
> +
> +	if (!ubuf && ubuf_common) {

If the user sets common->log_level > 0 to query the true log size but
omits common->log_buf, ubuf_common evaluates to NULL.

Does this cause the condition !ubuf && ubuf_common to evaluate to false,
silently ignoring the valid attr_common request and falling back to the
legacy attr?

Additionally, if both sides provide perfectly matching log buffers, but
the legacy attr is too small to receive log_true_size (where
offsetof_log_true_size is 0), would the code fail to utilize the
attr_common capacity and silently drop the log_true_size output?

> +		log->ubuf =3D ubuf_common;
> +		log->size =3D common->log_size;
> +		log->level =3D common->log_level;
> +		log->uattr =3D uattr_common;
> +		log->offsetof_true_size =3D 0;
> +		if (size_common >=3D offsetofend(struct bpf_common_attr, log_true_size=
))
> +			log->offsetof_true_size =3D offsetof(struct bpf_common_attr, log_true=
_size);
> +	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512153157.2838=
2-1-leon.hwang@linux.dev?part=3D4
