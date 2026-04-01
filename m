Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747972EDD6B
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066356; cv=none; b=MkIfwOn8wi2neDapdrXggswFq2qa4jOM4aeTplYw1RZcGn8d+7SjftuQaU5Y3OgJeXVTwLE0rSfnRJhSXDT42A6fIyBlUi0YJwt0SK94Jt5tirCoW1epfm0dDB9b+EVrdHgwbyh6XtWV2Xtv8ozPTAdKvJNdj7BDhrue8SYwoTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066356; c=relaxed/simple;
	bh=klZfHNebcMrnNEzlQuQyI2EfsZX9F6GgXmJo9o+Xg8g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Jm8FkcQhq3FQ4bONjIbsSk911Cxb5YudoJjandsNDF0vaAfQrIwFuHrKPa3hPCRQK8PBtxhPLViypOnI6yryFM337yWEjwezN5BUzhywWt4DUFWE4pLYma0WwPMp2Nm0Yn6ZjFpHQPZqBFZDDLFidMQGQ680Ft8D46nx9AOPROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCRttWxr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCRttWxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C182CC4CEF7;
	Wed,  1 Apr 2026 17:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775066356;
	bh=klZfHNebcMrnNEzlQuQyI2EfsZX9F6GgXmJo9o+Xg8g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cCRttWxryc7ZuoknFtT4c0P+CychxKhPoEWvx3WfAC9SbdP5XbiAk4e2JNx7EDQCm
	 WODhijaHnSzK+ET/XQnn7atCE2IiKhABLpV0nujrHNpreSUDaxFfZEXXeadfQvzkSG
	 iklxWqvUTgSBi6Pf9FouV548U/HPsfrbP1ah4xrqXY3BAQcTskCT2FPMzMi5lJVdvG
	 EbVekq9hzCw8oOH/6dCj9LaveySWvJ6LkfPBzrktuZugRZMwuyTnMZu2lSZHFR+gkW
	 2q+cNiQsP0a3N5yUW+dMATAS4qbZN/NxUfBotzG4DK8ga77R9wShP7IHJ1fg1vpGBS
	 Prs6vt/1SiUHA==
Content-Type: multipart/mixed; boundary="===============8873681574554380312=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3ac88e05c887d679301e873b3968ebb41deaee08f9f41d7f225cd2268c7fc133@mail.kernel.org>
In-Reply-To: <20260401170115.495836-3-vineet.gupta@linux.dev>
References: <20260401170115.495836-3-vineet.gupta@linux.dev>
Subject: Re: [PATCH 2/2] bpf, doc: Improve MOV* documentation ...
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: bpf@gcc.gnu.org,jose.marchesi@oracle.com,ast@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Apr 2026 17:59:15 +0000 (UTC)

--===============8873681574554380312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> index fd688c5d3f04d..ac61d3be7af21 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst

[ ... ]

> +``{MOV, X, ALU64}`` means::
> +
> +  dst = src  (e.g. r1 = r2)
> +
> +``{MOV, K, ALU64}`` means::
> +
> +  dst = (s64)imm
> +
> +e.g. r1 = -4; r5 = 9282009
> +
> +``{MOV, X, ALU}`` has zero extension semantics (upper 32 bits are zeroed)::
> +
> +  dst = (u32)src
> +
> +e.g. w5 = w9

Should the example for {MOV, X, ALU64} be placed outside the code block,
matching the style used by {MOV, K, ALU64} and {MOV, X, ALU} just below?

As written, the RST literal block renders "(e.g. r1 = r2)" as part of
the formal pseudo-C definition.  The other two entries place their
examples as separate paragraph text after the code block, which keeps
the spec definition distinct from the illustrative examples.

Something like this would be consistent:

  ``{MOV, X, ALU64}`` means::

    dst = src

  e.g. r1 = r2


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23861455083
--===============8873681574554380312==--
