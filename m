Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A032D43C
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236431; cv=none; b=IVRC7pUnQhd0sxasE0iQ+Vbcb76rEOK01N/AtbnwzwjqD7uZlyIK5F/f0Jer3jwWpaqQggfTJnA6bAB3dVAC9BURqrC+ExDmx8Fq+bnxu6myFEB63G4q4GP72Itk5xedv5oO0TJIMNDed1ZigXF/LJJR6LEJIx4IUeJdOcHTjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236431; c=relaxed/simple;
	bh=MPM7tMrysfqhxFdsFB02wgIP94QCko05udW98oEoqOE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=L5qUSSgwsq8shGfXwNKWHa9cbI8ZNaWDwDSedYMUQIIlR2jxC6yegu5527kPOicGxB1NKNeNftv558Ta76NLPyRRcJUHHZizoZvBD4ea5qw5i73WdGEKdICgO2Q+rvnymZjL6NV4zbvpNxs3SsNXNIuuUPvJI6J0QfPpOxtMG2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cypx8Njz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cypx8Njz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8E1C2BC9E;
	Wed, 11 Mar 2026 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773236430;
	bh=MPM7tMrysfqhxFdsFB02wgIP94QCko05udW98oEoqOE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cypx8NjzvNucKZmVP2gi77AxHfoXTKAak5QjlbQS1QG1OF48nG35S8xzUtvfEzVeB
	 pVZV1OrgJ3z0NfLj1VtqeAdWlIxpJrKzFrFp/j0iPgLWStDMAGYoI2xX9sJWrq+2cy
	 9iYfYF1lmUr+VW2RfmU1Cyd623VNB2q43hsxIsFqWzx/6T993/lWS9c/ce50Cik+dM
	 k/ad3O1kKSUtncPA8vrR8d7jFJ7B/5xe8VcA4t5IMKD+iKNdVKX1jR7XfU7KNNk79/
	 TeviAsYIQGGsuiozyKAkVU83kaKppLGwPU48okP4/AoiPSyoDwWHd78m9n4ug4aKfM
	 xflIzw4k1XAsQ==
Content-Type: multipart/mixed; boundary="===============6698351429997486596=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <38b32432e05af72b358055df9c81e89e951cde03d94efbe32c28568a76c13057@mail.kernel.org>
In-Reply-To: <20260311130321.1055808-1-memxor@gmail.com>
References: <20260311130321.1055808-1-memxor@gmail.com>
Subject: Re: [PATCH] bpf: Release module BTF IDR before module unload
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,martin.lau@linux.dev
Cc: ameryhung@gmail.com,andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,grbell@redhat.com,haoluo@google.com,john.fastabend@gmail.com,jolsa@kernel.org,kpsingh@kernel.org,memxor@gmail.com,sdf@fomichev.me,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 11 Mar 2026 13:40:30 +0000 (UTC)

--===============6698351429997486596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1883,10 +1883,17 @@ void btf_get(struct btf *btf)
>  	refcount_inc(&btf->refcnt);
>  }
>
> +static bool btf_is_module(const struct btf *btf);

btf_is_module() is already declared with external linkage in
include/linux/btf.h:

    bool btf_is_module(const struct btf *btf);

and btf.c includes that header. Won't the static forward
declaration here cause a build error? GCC rejects a static
declaration that follows a non-static declaration of the same
function. Dropping the 'static' keyword from this forward
declaration should fix it.

> +
> void btf_put(struct btf *btf)

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22954450342
--===============6698351429997486596==--
