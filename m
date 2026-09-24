Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D1445ACF
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241195; cv=none; b=K1Qm06h4t83WO5nfanO4vLynl1j1V28NZHC0wRiGZeoQ56vA9lzT1D8Y0Sk8M+k/j7HOUulAas/UH7pE6Ya+Yw4R0oj6RmQGK2A9h4AQOGQCitUOawwoDjd4q2fdrRi4eiIByLziTdV3LP64vBQyoGZcyQBp3atX+zFECX8eo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241195; c=relaxed/simple;
	bh=o16ZrPHUbPmW0jzniBp6He6NtuuoXiQqYgAHYnmGe7Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=njz1h5XDEsSWEnAwEAn7d22VK42A9b25u2gkyTTtCJvpEj83IWklsqFVd1U22tC5CG9q6Vb7U2WS5KxrzVBgNxou2LgoN3vAfQ5wb29Y1v/0tAjTCkhNx1lHXTO/fnaeSj5zBuqCjOj1qYO/N7D5st/kLNLxzet1XiLzsPMc28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg2y02GD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg2y02GD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637AA1F0089A;
	Thu, 24 Sep 2026 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790241192;
	bh=QWGFM+UJ5XqBiyWdMeNXFKnKTpkc6PO7iosx6vMCby0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Tg2y02GDAwtzfi/ZskdynOsBzStXZmexpN3B1FKZDkOtiwGgqMBFnaVO6qlCecRcK
	 M2zNr0XxJR2MBU+lWK3nJmw+WXPHclmKgh6zriUL+GGQcndy+0iY1TdGXDO4X4hn+X
	 KeX/nqpkNsfCl0BoMLy0m/ycoEQ3Uy0OpcB2+eitpeQ+Timt0aRhA7ad24/hZ7bmsw
	 lurIB14+xeiWJQ2P6gxOJlTXfEHycmvg5rGRf6wUVTmW8ccm0MdwKgU9UdbtsvanO2
	 AqL9BIogFrFjQN/ipwOGxmAONDKhStjhKYdDKflO+RGCDhgOHrHvI0g81Sshj3GnYH
	 8iyCfd0tobunA==
Content-Type: multipart/mixed; boundary="===============3213021827406192989=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <137d352e6b635833e3e69d9ef6215e7674b239c05ae0a7a0efb0e6b492669696@mail.kernel.org>
In-Reply-To: <20260924082607.2695649-9-memxor@gmail.com>
References: <20260924082607.2695649-9-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 08/18] bpf: Grow the verifier id scratch on demand
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 09:13:10 +0000 (UTC)

--===============3213021827406192989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b314b9425b86..3ff1d4f753d3 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8b7f2c283e5a..aebe2e6b2a3d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18898,12 +18903,13 @@ static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
>  			return;
>  		}
>  	}
> -	/* New id */
> -	if (idset->num_ids < BPF_ID_MAP_SIZE) {
> -		idset->entries[idset->num_ids].id = id;
> -		idset->entries[idset->num_ids].cnt = 1;
> -		idset->num_ids++;
> -	}
> +	/* New id; one that cannot be recorded counts as shared and is kept */
> +	if (!bpf_id_scratch_reserve((void **)&idset->entries, &idset->cap, idset->num_ids,
> +				    sizeof(*idset->entries)))
> +		return;
> +	idset->entries[idset->num_ids].id = id;
> +	idset->entries[idset->num_ids].cnt = 1;
> +	idset->num_ids++;
>  }

The comment says "one that cannot be recorded counts as shared and is kept".
With the old fixed array, once num_ids reached BPF_ID_MAP_SIZE, that was
permanent -- every subsequent new id failed to be recorded. But
krealloc_array() failure is transient, and bpf_id_scratch_reserve() leaves
cap unchanged after a failure, so the next call retries the same allocation
and can succeed.

Consider a scalar id X held by exactly two registers, with num_ids == cap
when X first appears in the idset_cnt_inc() pass of bpf_clear_singular_ids():

  1st occurrence of X: reserve fails -> X not recorded
  (a later new id Y: reserve succeeds -> cap doubles)
  2nd occurrence of X: not found -> reserve succeeds -> entries[] = {X, cnt = 1}

X now has cnt == 1 even though two registers share it. The second pass then
runs clear_scalar_id() on both registers. This is sound, because the cleared
state is cur, which keeps being explored, and forgetting a relation only
widens the abstraction.

It does silently drop a real scalar link, though: sync_linked_regs() no
longer refines the second register, so a valid program can be rejected with
an ordinary verifier error instead of failing with -ENOMEM. The outcome also
depends on allocation timing.

Would it be better to remember that a reservation failed during this pass
(for example a flag in struct bpf_idset) and then skip the clearing pass
entirely? That would make "is kept" true in every case.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35976322553
--===============3213021827406192989==--
