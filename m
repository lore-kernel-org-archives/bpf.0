Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713B40A938
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374527; cv=none; b=fLwYpYga9JEYlJTWc9HO48/BsZdxiSDHWXeXf5GPjKnmRI8K9WbhisIRvphLkFV7TtNcfVlLgY8se2cSNSeoxP4lp2vF7RY2eRZn+TVBqJ5gD56g0ddmP4MJlwqQHlV4PmW/QkK55D7SnmuDxLg1qdCGyAkGMX33Qksbr/grxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374527; c=relaxed/simple;
	bh=MdoJFsNnX0Y0oiWLXih8tQDIq0nchZ2MyAPQDCXdd1o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mZasvMUnRQTaPH8JQtvFQW1T/KTfHnEfy+AidQtdBpuYOGCcJ48nKtF/koQNd9x7Kk5rjX4J7H4VIcWwNas2/oMIuiTA3D0UgRS2lUDcz8IX5w4kvyzE8cMxW/GN6Set94Khe8I75GmofV4WZRCascU+2/5pqHDIF5y3x7CgUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO8Yz163; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO8Yz163"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B781F000E9;
	Mon, 10 Aug 2026 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786374525;
	bh=gDV0uXvibmfdOdSvQXisi+xIAy2p5ppLvC8O0qUZD5g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cO8Yz163q/TA/XnGhY/m23uzLNzmjo6RD3Y5+RNeD8hv0tequEpeZcE18KoMbkN3M
	 Iy7O8tEAr66xY8bE5IndOCVDyUxe/nYEgn1kVAn9MVIJC6g7zSYm2F5uD5EXTuOXNQ
	 uUUAUst4daRaFLJAS/MzBgedJb/RRh1tY8UelVomcYSwG/ccjPH6MdpW38AtiiIvK9
	 1FyCc8LE2LBBio2xbT+53fcKuPV/RSAuFqf0V7bXOLrfQKtiDkK5r/g0OpHc/WVahe
	 bkQ1aLFCYVINIo5FE49t7km8ckDy1lMVs3DN3/Dj+l8DYcgiH0WR85TDIROUw9KWZD
	 1yrVlZAlnZucQ==
Content-Type: multipart/mixed; boundary="===============3936142447207662803=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <84bd0041b0a35b87b15d9b00696b5abe1f16c340d2a02255e65e6758a03d4dc1@mail.kernel.org>
In-Reply-To: <20260810134346.466004-1-daniel@iogearbox.net>
References: <20260810134346.466004-1-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/6] bpf: Derive the atomic load register in one place
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: eddyz87@gmail.com,puranjay@kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 15:08:44 +0000 (UTC)

--===============3936142447207662803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 4edba8182db1b..15d83684c6e94 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -414,6 +414,30 @@ static inline bool bpf_atomic_is_load_acq(const struct bpf_insn *insn)
>  	       insn->imm == BPF_LOAD_ACQ;
>  }
>
> +/*
> + * Given an instruction @insn, return the number of the BPF register that a
> + * BPF_ATOMIC reads the value at its memory operand into, or -1 if there is
> + * no such register. That is the register a BPF_PROBE_ATOMIC has to clear when
> + * the access faults. Like bpf_atomic_is_load_acq(), @insn is not assumed to
> + * be a BPF_ATOMIC here.
> + */
> +static inline int bpf_atomic_load_reg(const struct bpf_insn *insn)
> +{
> +	if (BPF_CLASS(insn->code) != BPF_STX ||
> +	    (BPF_MODE(insn->code) != BPF_ATOMIC &&
> +	     BPF_MODE(insn->code) != BPF_PROBE_ATOMIC))
> +		return -1;
> +
> +	switch (insn->imm) {
> +	case BPF_LOAD_ACQ:
> +		return insn->dst_reg;
> +	case BPF_CMPXCHG:
> +		return BPF_REG_0;
> +	default:
> +		return (insn->imm & BPF_FETCH) ? insn->src_reg : -1;
> +	}
> +}
> +
>  /* Memory store, *(uint *) (dst_reg + off16) = imm32 */

This isn't a bug, but could insn_def_regno()'s BPF_STX arm (and the
similar switches in const_fold.c and liveness.c) call
bpf_atomic_load_reg(), so the mapping really does live in one place?

The helper is bit-for-bit equivalent to the BPF_STX arm of
insn_def_regno() in kernel/bpf/fixups.c:

	case BPF_STX:
		if (BPF_MODE(insn->code) == BPF_ATOMIC ||
		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
			if (insn->imm == BPF_CMPXCHG)
				return BPF_REG_0;
			else if (insn->imm == BPF_LOAD_ACQ)
				return insn->dst_reg;
			else if (insn->imm & BPF_FETCH)
				return insn->src_reg;
		}
		return -1;

The same three-way mapping is also open coded in
kernel/bpf/const_fold.c and kernel/bpf/liveness.c.

Since the changelog's stated goal is that the derivation should live in
one place, it is a little surprising that the in-tree duplicates are
left alone.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31395992453
--===============3936142447207662803==--
