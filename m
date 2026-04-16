Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80A3E3C54
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353276; cv=none; b=CI117KQiOnFu/1evbOohBEyKqZnhJU0Uq3fPr7JuxTOnciiLy3hmFLSlzilWcTACSQXgFrijgUku+eADBg2foIfGEx6aJBuVfXs1WGwAgfdmmgqGBaIFtaiYN+UVCNXsMOpEcqlvAEO7jXtdVou9qjesk6mPl+LvNDjVsve53bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353276; c=relaxed/simple;
	bh=7VyO3HS+mnXywaYNOwAwlK6HR8nPUxKDc4l9deosOLw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=p0O/kW2KIDoy37Oezz8nEE3WjNW+z6fvc3tXNX+vXc33GB2kV552Lb13sg3AkAQsT0v/9BAtn1Ijl0JcZwVMbwlFogCqn95DLk6UQcn+6XorZ638FGzwDFylccVh4BwMeTvqkVIpBA4QgLKcOUKIKgR6owpcoO3dcer6S9wChoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3yRn2sf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3yRn2sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65404C2BCB3;
	Thu, 16 Apr 2026 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776353276;
	bh=7VyO3HS+mnXywaYNOwAwlK6HR8nPUxKDc4l9deosOLw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=u3yRn2sf/wA2S6qIrqGdc7d0H9Lk2YHRufBPS5Hx6bx8v5nhEdL5EZci5/kDvL5ZK
	 wQQ6SWJRzdo6LWA2C8ftgadMPwcPsvhEpL3E4ePYpu2sB2gAXa/Sbd2UfUDOekIM9v
	 kv1hFhYTPVQr5KtWBVhE7LIRTEx9KC2vidh1hNAOmAvZUGEFo8xE7x1XjpScBXgcKE
	 u9eyDuoZxcyDGDcB3QfDYdaPgruliH/3UuYvbrmdLWFSoaNtJ6H6DE/fpOhMYi1q8h
	 4tfMvp+5/eZoY/aelor4dMZ7rRK039HBKKEDq7nrz6At3E+18p4lkFRQBJEvrGHKAS
	 t9u6eJF4XRi6A==
Content-Type: multipart/mixed; boundary="===============5597813353016183454=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <451263a6d63199b763562e5e22e526b20e48f77a48b0701c47b12ecedf464bb9@mail.kernel.org>
In-Reply-To: <20260416143904.1220662-3-alan.maguire@oracle.com>
References: <20260416143904.1220662-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 2/8] libbpf: Adjust btf_vlen() to return a __u32
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,qmo@kernel.org,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 16 Apr 2026 15:27:56 +0000 (UTC)

--===============5597813353016183454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ceb57b46a878..dfe72235e5dc 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -2121,9 +2121,12 @@ static void *btf_add_type_mem(struct btf *btf, size_t add_sz)
>  			      btf->hdr.type_len, UINT_MAX, add_sz);
>  }
>
> -static void btf_type_inc_vlen(struct btf_type *t)
> +static int btf_type_inc_vlen(struct btf_type *t)
>  {
> +	if (btf_vlen(t) == BTF_MAX_VLEN)
> +		return -ENOSPC;
>  	t->info = btf_type_info(btf_kind(t), btf_vlen(t) + 1, btf_kflag(t));
> +	return 0;
>  }

The overflow check was added here for btf_type_inc_vlen(), and its
four callers (btf__add_enum_value, btf__add_enum64_value,
btf__add_func_param, btf__add_datasec_var_info) were all updated to
check the return value.

However, btf__add_field() increments vlen inline without going through
btf_type_inc_vlen() and has no corresponding overflow check:

tools/lib/bpf/btf.c:btf__add_field() {
    ...
    t = btf_last_type(btf);
    /* update parent type's vlen and kflag */
    t->info = btf_type_info(btf_kind(t), btf_vlen(t) + 1,
                            is_bitfield || btf_kflag(t));
    ...
}

If btf_vlen(t) reaches BTF_MAX_VLEN (0x00ffffff), the +1 produces
0x01000000.  Since btf_type_info() does not mask the vlen argument:

tools/lib/bpf/libbpf_internal.h:btf_type_info() {
    return (kflag << 31) | (kind << 24) | vlen;
}

bit 24 of the overflowed vlen bleeds into the kind field, silently
corrupting t->info.  Should btf__add_field() get the same
BTF_MAX_VLEN overflow check that was added to btf_type_inc_vlen()?

This was not found to be fixed later in the series.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24517220149
--===============5597813353016183454==--
