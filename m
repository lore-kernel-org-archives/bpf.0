Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403303A7580;
	Tue, 21 Apr 2026 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811944; cv=none; b=UUfpdnBC7QdELhB9231Kq96hseHsXHnebdty+WLoFtB206N+t5mrHOsTjS0BTRQBrYPt/Z/Cp35vLgR10aIwe1IQL58elQCtd853Tuy99UgnMUjd1MBKSsFoN4zA9ZF9lMCJ/oYxN29vYXHOo0vAOEmanld+9VlIxnguoSLNKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811944; c=relaxed/simple;
	bh=ZGmej5pdVLGzwTKJ/MVuh7ABN9ypk9m9cO3XcT8o8JQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VYRFBuCe4WE5MnUM5RSpkq98TOOcefxFNrLXnvqodTnkkkf+s4xGkNQ6PDutGk6rggkQNrW0fTa5Jrs9Cvyi65f7z2j7MAV1Wybh++WgPJnTPw1Rc87etGtfR3rehiaFg+kzEfDAsqPYbbDEudTW614SWi7Bb3kihtiC6p6PeqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU24hZQn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU24hZQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7962CC2BCB0;
	Tue, 21 Apr 2026 22:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776811943;
	bh=ZGmej5pdVLGzwTKJ/MVuh7ABN9ypk9m9cO3XcT8o8JQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XU24hZQnLc6rsRksZO80llGgpTP9BneMkLU/AznW3bcD4TNWRGBo2fzpdzLgVfSEw
	 E+53QNycyvmnQWcRAx+TZdMXK0zIP6iCvBen8rOAa7XKaS0WK7kW4a8ZwFFxdUW6mr
	 6nU8dsgjJNuxathi8EjRWxNLssVZPXOqu5FQR9697JE64NNo2m8LuA07NJV4CGpvo4
	 L0aERE8PtAPk1SUIgTBk8QTslH7LrL0vRPdExuLTzYk6G48g2qgPk5DZqOqeIBETIb
	 pRIIoiMEp+kx63GEAiIsyJSpUZ9XypEAaTcvhndJ+UOIIbeiETmqI22sQOpVJrivav
	 AQqsdjuLoN4PA==
Content-Type: multipart/mixed; boundary="===============0354082449293124802=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <682487c0e8bd32678ad92c5e94f18dd78e45d7b3132e11bc5c1a4d4285a05369@mail.kernel.org>
In-Reply-To: <20260421221016.2967924-2-ameryhung@gmail.com>
References: <20260421221016.2967924-2-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Unify dynptr handling in the verifier
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 22:52:23 +0000 (UTC)

--===============0354082449293124802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b148f816f25b..dc0cff59246d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1319,6 +1319,12 @@ struct bpf_map_desc {
>  	int uid;
>  };
>
> +struct bpf_dynptr_desc {
> +	enum bpf_dynptr_type type;
> +	u32 id;
> +	u32 ref_obj_id;
> +};
> +

This isn't a bug, but as noted by Mykyta Yatsenko in v2 review, the new struct
bpf_dynptr_desc could benefit from a comment explaining what the ref_obj_id
field is for.

While you mentioned in your response that comments for id, ref_obj_id, and
parent_id will be added in a later refactor patch (#6) since these fields
apply to all objects tracked by the verifier, the struct currently lacks this
inline documentation. Could this documentation be added now to help readers
understand the field's purpose?

Reference: https://lore.kernel.org/bpf/87ikb2tkta.fsf@gmail.com/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24749741787
--===============0354082449293124802==--
