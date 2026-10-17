Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1F492E58;
	Sat, 17 Oct 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792249388; cv=none; b=cCVjdAph4a8/W9nrWeU72xD6f/56OEkVkh3thqFTzugXFz90nnz6Eqpn2bVKIQZqVgEqmJhmjZPKH+KzxKaFTpR8jlnIlN8QI2GHrfun2tAjOU+S8lpzHfmlLC/tcF994Jnh1KyuoPzvH9x0kH6Q2iAYEgyiFGGgDG/HWQbigH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792249388; c=relaxed/simple;
	bh=gZOae9APRUH71a/WqvD95xUM7X68MkXq1He8J8UPveY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c3oYRhxjC3ko98J76QyNeMBmlUuN3bTf8pwVv7aWjqmieWYauqqaE7a4qqXF87QuNJ/1UiO896xrI7xI6bESy27Sh7i4FjWCGJ+9/bEFbSknMZQGfeTQtuY9GMQhwzyiGYA0ZYhU3b17HFHgaM8F6h9VyakNDoFFE5j6lIF0n4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnP3ohgB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnP3ohgB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327401F000C5;
	Sat, 17 Oct 2026 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792249386;
	bh=gZOae9APRUH71a/WqvD95xUM7X68MkXq1He8J8UPveY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EnP3ohgBsqJkBlb2/EQOvdPof1CgBJzBijrxObfq9ceTRQhLotATPFiCMRlsoyMYN
	 M4t9Ov8vXmLHKa6s6RcdY3nJkVhOezbx2so9/PHx10DgoDfvYfmt7A29fdVIKtn1v1
	 k6mQW4XUZnBcKga+/M3fs+cgYMd1QtsP9SPD8XWtxpoaNQ3/OKyZ585hXfMz0qE8E3
	 qTwYS7bwjf89E4GoQ9YI/681D3zOakR/Omi2kM0OjEtDvzOaU2cbhUEIj2U6xzqL96
	 9UbiTD4a8+0a0n4rjjfizmgnQKjcZ5uadSGuL1vxSDeWNcIevKNyPefHi/HvXXsdT4
	 y4DZbCoEjZlcw==
Content-Type: multipart/mixed; boundary="===============8909347412145933439=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d8f51a15d54c296421230d26a3c7b1bb535c9bd98e15eb52dd36344c3690c053@mail.kernel.org>
In-Reply-To: <20261017142649.51047-6-leon.hwang@linux.dev>
References: <20261017142649.51047-6-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 5/6] libbpf: Add bpf_link_create_log API
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,shuah@kernel.org,kuniyu@google.com,liuhangbin@gmail.com,mkarsten@uwaterloo.ca,masashi.honma@gmail.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 15:03:03 +0000 (UTC)

--===============8909347412145933439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Add bpf_link_create_log API

TL;DR: Commit message only: the rationale for adding bpf_link_create_log()
instead of extending bpf_link_create_opts is vague ("it seems not proper") and
one sentence is self-contradictory; no code issues raised.

> libbpf: Add bpf_link_create_log API
>
> Add a new API to accept the log opts, instead of extending the existing
> struct bpf_link_create_opts.
>
> In the struct bpf_link_create_opts, it seems not proper to append a
> tailing common log field prior to those variant length fields.
>
> Add a new API to avoid breaking the struct bpf_link_create_opts.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

This isn't a bug, but could the changelog say more concretely why a log
field cannot be added to struct bpf_link_create_opts (for example, the
trailing union growing for future link types), rather than "it seems not
proper"?

The sentence "append a tailing common log field prior to those variant
length fields" also reads as self-contradictory, since "append" and "prior
to" point in opposite directions.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39042048581
--===============8909347412145933439==--
