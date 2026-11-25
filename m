Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628237;
	b=MHDnkQfGhYaQb/ATHrdzhyECjUQKqqBvqMd5TLdyG9YNwymR7SJyMLF12sDC1WDDSB6K
	 riaxzgPrSQQ7HAmWVIdpKocZ9N+Ht9k8VJH92iq6oamlZMW6zD+8WLnZJgmB3YQYsJaH/
	 I0BBSzPxmSAmWQSAdql2yFomVj4btqieIp3tZHr4y8pKeeq8xyx90hiepfFEIVjA83Xho
	 UlnS5/RN8Ir3EcY3c7ntSc4isWgZvZmTsYQ3yntmY2Wo3jmUeHOygyipQ4h6qY8SKG0oA
	 ofjwf2q9IOrhQILu2A+BRDVBIcsYBb4fiLjO1mfWfIwyracxpjZdCrTbjY18r8gcKEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628237;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=707oSugDWKcGNdpb61B13OdTY7iXKL0r2rtiSV0QnJU=;
	b=2gVbBDLSXw9PPZzHK7aWuZnXQ8ZYICcBHIjQnduTlarb17RaMJtwONQX6Po4NJjXVkvk
	 LIgbUSY17WawtBhwyFOtQaYQFJEyt4Z1gHcBc+AxG1qJBAPfjFLO9TtHisKTvVwMT5nyr
	 0DO3r1G2ZdLneBBKx8ID5cuN0f1woOMos0tj7zb+afTjduGZPd4OjMW4RCTYhHCxZ8aXG
	 TyhMv+Iz7yt5J4JCLW/Ii6s6Ey4J0SZIWDjxCz9Sn8mLHtIxpV+vjLT/ShpZd8rwhZI8e
	 gwzHCyRNgvw/wVO+P48Xl+oqMfSz5A9UkuQnp66Nq71wJFBMLB3K547ulwvpPdbbN3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMMEVJRd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E16606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMMEVJRd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FBE1F000D1;
	Wed, 25 Nov 2026 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628236;
	bh=707oSugDWKcGNdpb61B13OdTY7iXKL0r2rtiSV0QnJU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NMMEVJRd3XUOvTRSlokNGq57h6cuqq95I5vzHwk2pQmvWCs68N4vELcMyuhxuXVXt
	 PuTiTN9eHRwMgNKSNiOPT/hpwe/ecKxXzelNhpfclmhv0Epoqbjf8km7901jMr3gPf
	 lXXucdL+bIP5jolel7Cze66cmPDPIYWcvAfWdEVk2HcMcAfemQm2ucW3KbFwi04pDm
	 C22131UxI7Bns8fbuWeJlPK2Kb48twwSPy8JJZTdMsQgr23zNmreuoq05hypQ3the1
	 qoeYzRzVq9TvrPZoW3/jmKaBK2L9yT4hHkqEil2r5TbbgnxcGy/+jsUBmBQ5zp/Vj+
	 ock7mXydIBDGw==
Content-Type: multipart/mixed; boundary="===============5020704080212289720=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <6e880549d5435c9db53cca8cec1d8602617f20acb6d762f0ba9ce1a8838613e3@mail.kernel.org>
In-Reply-To: <20261125165845.45806-6-almagui@kernel.org>
References: <20261125165845.45806-6-almagui@kernel.org>
Subject: Re: [PATCH v2 bpf-next 5/5] Documentation/bpf: Describe CO-RE relocation of function arguments
From: bot+bpf-ci@kernel.org
To: almagui@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: andrey.grodzovsky@crowdstrike.com,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,mason@kernel.org,bpf@vger.kernel.org,almagui@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 17:37:14 +0000 (UTC)

--===============5020704080212289720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Documentation/bpf: Describe CO-RE relocation of function arguments

TL;DR: Nit only, in the documentation: the libbpf overview example assigns to
two different undeclared variables (mm and vma) in its branches, so it may not
show how to use the result.

> diff --git a/Documentation/bpf/libbpf/libbpf_overview.rst b/Documentation/bpf/libbpf/libbpf_overview.rst
> --- a/Documentation/bpf/libbpf/libbpf_overview.rst
> +++ b/Documentation/bpf/libbpf/libbpf_overview.rst

[ ... ]

> +    .. code-block:: C
> +
> +      struct bpf_func_args___new {
> +              struct mm_area *vma;
> +      } __attribute__((preserve_access_index));
> +
> +      if (bpf_core_type_matches(struct bpf_func_args___new))
> +              mm = (struct mm_area *)ctx->vma;
> +      else
> +              vma = (struct vm_area_struct *)ctx->vma;
> +

This isn't a bug, but the two branches of this example assign to different
variables, mm and vma, and neither is declared.

Should both branches assign to the same variable, or should each use its
own typed pointer, so the snippet shows how to consume the result?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45664233836
--===============5020704080212289720==--
