Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B03F5BC3;
	Wed, 23 Sep 2026 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202711; cv=none; b=coQas42B0C3VKzas5JWCqUGwsq0jax4q+G7+g4V/+IP14U0DfhjNWgtZA/37gxeo+2pRzJ+fDB307tkd5z1yEzgJwZN4BKCjGKKclioggx7n79E8LuAbWkNQ3y7qUKC+3MVxIdDEFTksgms1H5jZEVkLDPDsyDjItz3zYnTuOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202711; c=relaxed/simple;
	bh=1olb2SLyI2jGvEFdZ4YPqLde3W2sQjrM/CpA+6qyNj8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tmiEh1ZueoXMas9ug2zAiDrUMjGYLigoXZ4jHO86LeON4cdvV1yqtxVLYeo+rdIPC0KMxHwSVkVIbFrUo1JkILvV6Cy1gTWlvJcG+HptkawpvXK1a+6ONQOIADFU9cmGKVwWkb5C+cgTxTimHa0ZC37SgYlUk+Ih3fnvTGXXfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V003OB8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V003OB8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814D61F000FF;
	Wed, 23 Sep 2026 22:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790202710;
	bh=1olb2SLyI2jGvEFdZ4YPqLde3W2sQjrM/CpA+6qyNj8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=V003OB8lyfUOumABHRG51GM9iZ5G4k+mq7pyAtyXrJGrx2MhN/cn+RGZs3tbEq1Ir
	 84KgN9kEyLmsVecgPsu0TbFvu6a5OgPjDKDsGVO0UQmHzMzQlZ+SzKwwR/uuvZAIGe
	 Qrf06NPW9Lq4jtrFF5BZmiOQXli4bbXK9sn7cxhNQR3oaSUym1ptkOl2HOjDBjvmhS
	 qtpUTmC9/QE6yTcP8Lg8R8cprrB1V1BimzQRXllxyyjZfyY/j8zXW+FNolOSpFtlAu
	 vUIIWKdFoSBEy0zST8IUYt05fe5RUxXdF6DprY/mFhtQw3UIrWRrJSI3ifWektMZoA
	 k1OO0hYmtXe2w==
Content-Type: multipart/mixed; boundary="===============6013470548475510875=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7110cc1be75809dff29a0cbc63e093ddffcaed6d07ef99e319cca4eb5fcb240e@mail.kernel.org>
In-Reply-To: <20260923213719.224838-2-kuniyu@google.com>
References: <20260923213719.224838-2-kuniyu@google.com>
Subject: Re: [PATCH v2 bpf-next 1/8] bpf: tcp: Convert deny-list for bpf_{get,set}sockopt() to allow-list.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,cleger@meta.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 22:31:47 +0000 (UTC)

--===============6013470548475510875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: tcp: Convert deny-list for bpf_{get,set}sockopt() to allow-list.
>
> Currently, four bpf_tcp_ops callbacks are not allowed to call
> bpf_setsockopt() and bpf_getsockopt().
>
> However, the deny-list is fragile, and when a new callback is
> added, we might re-open a can of worms. [1][2]
>
> Let's convert it to allow-list.
>
> Note that it can be written as offsetof(,X) <= moff <= offsetof(,Y)
> but clang can optimise to similar code anyway.
>
> Link: https://lore.kernel.org/r/20220929070407.965581-5-martin.lau@linux.dev/ #[0]
> Link: https://lore.kernel.org/bpf/20260421155804.135786-1-kafai.wan@linux.dev/ #[1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

The changelog body cites references "[1][2]", but the Link: trailers are
labeled "#[0]" and "#[1]". Nothing is labeled [2], and nothing in the
body cites [0].

Should the body say "[0][1]" instead, or should the trailers be
relabeled "#[1]" and "#[2]"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35924977907
--===============6013470548475510875==--
