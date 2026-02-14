Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683F3EBF2D;
	Sat, 14 Feb 2026 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771074570; cv=none; b=pF52fEaZHOOXHBdBrw5UuDb4EZH2wsMLS3o8hOH9d8d4WyUtD88u46zjIBsyY1Txt5YBSFgWD38pMqZy1pvPy3CSDGknMI/nLQQKlONQ7rU0X3UEEA0i6XLZsCbJV3BI5f4o5CclBwNnL7zyFfidlbrqBCTshDfwZ0+CHke/kCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771074570; c=relaxed/simple;
	bh=qqVkKbbpS5aqSOAqslTjnEIqyeZKiJucjiO9bqg/BZs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=W1SWKAsXdTWCqDkVJ+qo2WDfbSVjO9QAlnS05Zc0gd7Nx66iApBCL48yLFUUD8eGdsJsFLVJT//UrWRZAAz0HiVEGBA+uPRTjaWTsoZL1VXs9UveikBg6k4T6lHW/TQNLF8ml9AB7WwgTzmMaGZbzxVf6rWusbUiDEr6Y8WnRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKH2B40t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKH2B40t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03CBC16AAE;
	Sat, 14 Feb 2026 13:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771074570;
	bh=qqVkKbbpS5aqSOAqslTjnEIqyeZKiJucjiO9bqg/BZs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=YKH2B40tkE2/poyzX5aC2hkUfHjTAtGlE5gyxtwWTNY2Vl/wiKI/fXWVQOiZNyC7X
	 YfvIrw5QFZYzzs8iORai7XxtsQ5mIhBGH2lAZR6C4emImf0bINhRKfsQPyfUocNHFB
	 JxSViF1cZEBudL2ZFk+J+R/8BlTPSOqS0uXDEp+a2HUoJdUO0eUeF4v9eJAbvA2Q8Y
	 piASD8xBK66Cs/tSh/d7vO+ZiudvTbkD0CkQ5MtEmjvVZlUpDVfgX5gwmod4BqXgfO
	 K++k3CRwvuziqjupZr1bZRsnAMj0mSmeW8gkR2x+0msMsMAvRHeMTg2doG4hUlj+jw
	 bzPcOYaXOSqbA==
Content-Type: multipart/mixed; boundary="===============4190754977872176744=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c58e67aaf6b28ce4682ee9dc5fe367295313d02c926fe34d04344751b783f71a@mail.kernel.org>
In-Reply-To: <20260214124042.62229-3-pilgrimtao@gmail.com>
References: <20260214124042.62229-3-pilgrimtao@gmail.com>
Subject: Re: [PATCH RESEND v7 2/5] bpf: allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,yangfeng@kylinos.cn,alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,chengkaitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 14 Feb 2026 13:09:29 +0000 (UTC)

--===============4190754977872176744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9309,7 +9309,8 @@
>  static const struct bpf_reg_types kptr_xchg_dest_types = {
>  	.types = {
>  		PTR_TO_MAP_VALUE,
> -		PTR_TO_BTF_ID | MEM_ALLOC
> +		PTR_TO_BTF_ID | MEM_ALLOC,
> +		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF,
>  	}
>  };

ref_set_non_owning() adds MEM_RCU to non-owning references when
the btf_record has a refcount field (refcount_off >= 0):

    ref_set_non_owning() {
        reg->type |= NON_OWN_REF;
        if (rec->refcount_off >= 0)
            reg->type |= MEM_RCU;
    }

For such objects, the register type would be
PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU, which has no
matching entry in kptr_xchg_dest_types and would be rejected by
the verifier.

Should PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU also be
added here? check_func_arg_reg_off() already handles this type
combination, and Alexei Starovoitov requested this addition during
v6 review:

https://lore.kernel.org/bpf/CAADnVQJdwqeoqi+mPjQjmNbUqz2RxAjq-dVsGb7c_MCqpqmwhA@mail.gmail.com/

> @@ -9473,6 +9474,7 @@
>  	}
>  	case PTR_TO_BTF_ID | MEM_ALLOC:
>  	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
> +	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
>  		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
>  		    meta->func_id != BPF_FUNC_kptr_xchg) {

Similarly, this switch would also need a case for
PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU to handle the
refcounted path.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22017669804

AI-authorship-score: low
AI-authorship-explanation: The patch went through 7 revisions with genuine maintainer interaction, uses natural technical language, and shows iterative human development.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Missing MEM_RCU type variant causes the verifier to reject valid programs using bpf_kptr_xchg on non-owning references to objects with refcount fields, making the feature incomplete for a subset of BPF object types.

--===============4190754977872176744==--
