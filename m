Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516126;
	b=O1uFM39f0vX7gTI1u2mcyxngGaneAQiaghswEyCHArUhoRmTRFd0Zul69tEHmaNP9B0f
	 71tsSTxQCQlSOHuBERS30ZiSD0VKbEJ6eCaGPXNSbepgEIEtG2dBa/vnKlL8E35pFwiy7
	 KtYd0h7635g/2nSdtWdmfSPmmqVmL9AMWUcM44S4QNvCBRfS8v3B/LT3CnlprywRx8Gvv
	 XzB8TNtIfrGHRDrzsPfUufJls3OLwkci68t8ySZUCqSSNrstPDf8kbe9tZV02ZbvlyrH/
	 ZWRmr4Dg3jVrZSibujyQ4xWRSVuNcg0RoNnpJdmn3ge8aDN+vmcMDvY+i1xljcYcxUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516126;
	h=Received:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date;
	bh=WmttQryXnibWlRJiZPUojQhvGDcV+ijgulX9csVBoUI=;
	b=PlKXfsQ8wzTB3riK9oIlZ8EcS7V89K/tQE8Eup8/NkPg26zRHvRyLzXKKEY+kZ+7rZkc
	 XEIr8M7YSBX/8u6rcAwqRMQ2i6ITjyZyd4A+EsvVa2KtKS1axtyydwvIc+pwpVJb97+e/
	 4tRpCJCQXknnydeuKOr4QNO/8Peow9SjoDQ1i3m/XFwmsWrRiDKyH9/4fkeA1ols4BdYN
	 phZMJkLBcFw0DgJr/w+nGHjgqQKqTH6iV86EVnOlXWA1eJjEdRuCgWDdKf6Qlfbw16E1/
	 CZOUpINss/GeASlUnBkfqss8DjVjPs46FD/3jK/uYAM+PJBxkLJasnfdJls1ci1PXQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE45606A31B;
	Tue, 20 Oct 2026 17:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06841F000C9;
	Tue, 20 Oct 2026 17:08:45 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============2184321447331015808=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <443e1351eed4f46cf6c202e5f1130b189e9c5eb09cfcffd24d752c6ec73d450c@mail.kernel.org>
In-Reply-To: <20261020161907.2115379-4-vineet.gupta@linux.dev>
References: <20261020161907.2115379-4-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v3 03/12] bpf: Prepare linked scalars for relations narrower than 64 bits
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 17:08:45 +0000 (UTC)

--===============2184321447331015808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Prepare linked scalars for relations narrower than 64 bits

TL;DR: Commit message only: regs_exact() now also rejects states whose linked
scalars share a base id in old but not in cur, a stricter infinite-loop check
the changelog doesn't mention.

> bpf: Prepare linked scalars for relations narrower than 64 bits
>
> Two scalars sharing an ->id are always related by full 64-bit equality
> today: reg == base + delta over all 64 bits (this is true for
> BPF_ADD_CONST32 as well, which implies upper bits to be all zero).
> Sign-extension needs a genuinely low32 equal only relationship kind
> with bit 31 supplying upper 32-bits.
>
> Today the following 2 relationships exist
>
>   #define BPF_ADD_CONST64 (1U << 31)
>   #define BPF_ADD_CONST32 (1U << 30)
>
> Model them differently as
>
>   enum bpf_reg_link_kind { BPF_REG_LINK_NONE, BPF_REG_LINK_FULL,
>                            BPF_REG_LINK_ZEXT, BPF_REG_LINK_SEXT };
>
> So BPF_ADD_CONST64 becomes BPF_REG_LINK_FULL and BPF_ADD_CONST32 becomes
> BPF_REG_LINK_ZEXT with the exact same semantics as today. But this paves
> the way for a future BPF_REG_LINK_SEXT in the same framework.
>
> The implementation needs to change as well. Today the above 2 bits are
> shoe-horned into ->id, needing masking and OR'ing to get ->id and kind
> bits: with more types and bits needed, move them out into an enum
> bitfield of its own. To avoid growing the storage (and stay within the
> 1K allocator bucket), borrow 2 bits out of ->map_uid, 31 -> 29, which is
> still far more ids than a program can generate.
>
> ->id becomes a plain identifier, so check_scalar_ids() loses its "compare
> the compound id, then the base id" dance in favour of one check_ids().
>
> With the kind out of ->id it also leaves the idmap key, so regs_exact()
> and regsafe()'s explore_alu_limits arm have to compare it explicitly.
>
> One case changes behaviour -- old {r2.id=A+delta32} against
> cur {r2.id=B+delta64} was accepted and is now rejected, correctly, since
> alu32 and alu64 deltas diverge in sync_linked_regs().
>
> Clearing a link is no longer just ->id = 0: any stale ->link_kind needs
> to be cleared out as well. And given this needs to be done in the newly
> added kernel/bpf/scev.c, it is moved into bpf_verifier.h as
> bpf_clear_scalar_id().
>
> The helper also zeroes ->delta, which the open-coded clear left behind.
> Unlike ->id that field is inside the memcmp() prefix state comparison
> uses, so a leftover value could keep two otherwise-identical states
> apart; clearing it can only help pruning.
>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

The changelog lists only the delta32/delta64 mismatch as a case that changes
behaviour.  Is that the only one?

regs_exact() also changes.  It used to run check_ids() on the compound id,
so old {r2.id=A, r3.id=A|BPF_ADD_CONST64} against cur {r2.id=B,
r3.id=C|BPF_ADD_CONST64} built two independent idmap entries (A->B and
A|flag->C|flag) and was accepted as exact.

With the kind moved out of ->id, the same pair now maps A->B and then A->C,
and check_ids() rejects it:

    return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
           rold->link_kind == rcur->link_kind &&
           check_ids(rold->id, rcur->id, idmap) && ...

regs_exact() is reached through regsafe(..., EXACT) from the infinite loop
check in bpf_is_state_visited():

    states_equal(env, &sl->state, cur, EXACT)

so this is a stricter comparison than before.

Could the changelog also say that regs_exact() now enforces base-id
consistency for linked scalars, which the old compound-id idmap key did not?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39458500836
--===============2184321447331015808==--
