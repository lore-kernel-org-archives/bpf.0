Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C731B87C9
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021965; cv=none; b=as4zyGEAf4NaVJWFyHjJW2QVVQ2EWvMsTXTH1vXFdDsOK2sizONrfS3idhlgElxbq4k+FSMMs79tnZXSz6rnR0QKfU/6KBPzEU2PoNveX7rJlR/UGMvFKtW7CL9+bxJz9b/ngv4RZ+d+ZVRyuIzLXjouMO0IGFuFuBNBBqS9uq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021965; c=relaxed/simple;
	bh=Z2FVXRnIbE7p/tyiKf6hDfKyvNxJBvoyDYvcJo4QjMg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JKvbr1zLGfO4vAMD4kYopHZycExVDhNbBTVhLyz1d4fkq0rMEvTNAOucCTs+r2MNxDCUDFxZs5Qhf51O5YJZ9j01uPeuIWikDz1y7/RpMUddWJ00HgzNQoGuaLSJaEKxP7JzMgAnwXojpzqexTJSorMeHCV0LZBRQqQrPw19lyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCB25Jdl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCB25Jdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E05C19425;
	Fri, 24 Apr 2026 09:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777021965;
	bh=Z2FVXRnIbE7p/tyiKf6hDfKyvNxJBvoyDYvcJo4QjMg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lCB25JdlgW5OsF8zVgwl2gu582//aSCzHG3Npntrla6j0UvlMC6xuurf0+cdTMT/l
	 EoabOyB+r5o+NJVUBJwAev7zCGMdYFe9PU/sPKtmDD8fj8n6+yTMl8eEplDkhe3s7B
	 2E7YZInrs2B6UkvnYqHdAzwerzaHGPa2Lc49pqE8+4PTua4X/3mFtMDnPIlnob9Gew
	 063OlzHecBCw9CJV7dCsh1me6CezvS8LIE6wjO+7Pm+f6KWh04qK3uMBT+PV6Q9yqY
	 1IPtdKxxDw60kMrMuhRQCU9wRPT7GCQ+x0FK5T/5aPSpMILirZ8R3JpwaND6TMGJrS
	 ot2hh9JryN50w==
Content-Type: multipart/mixed; boundary="===============0361180916456202118=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6578efe1e2d2932d3c590871f0aa9d65e3bdada9d5234297c627b33506c7b1e2@mail.kernel.org>
In-Reply-To: <20260424-cnums-everywhere-rfc-v1-v2-3-57091924c9d7@gmail.com>
References: <20260424-cnums-everywhere-rfc-v1-v2-3-57091924c9d7@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: replace min/max fields with struct cnum{32,64}
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,shung-hsi.yu@suse.com,paul.chaignon@gmail.com,harishankar.vishwanathan@gmail.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 09:12:45 +0000 (UTC)

--===============0361180916456202118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b91d2789e7b9..34900247efba 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2031,340 +2029,17 @@ static void __update_reg_bounds(struct bpf_reg_state *reg)
>  /* Uses signed min/max values to inform unsigned, and vice-versa */
>  static void deduce_bounds_32_from_64(struct bpf_reg_state *reg)
>  {
> -	/* If upper 32 bits of u64/s64 range don't change, we can use lower 32
> -	 * bits to improve our u32/s32 boundaries.

[ ... ]

> -	}
> +	cnum32_intersect_with(&reg->r32, cnum32_from_cnum64(reg->r64));
>  }

The comment on the function still says "Uses signed min/max values to
inform unsigned, and vice-versa" but the implementation is now just a
single call to cnum32_intersect_with() that projects a 64-bit circular
number onto the 32-bit subregister. With the cnum abstraction, signed
and unsigned views are derived on-demand from a unified representation,
so the cross-domain signed<->unsigned deduction described in the comment
no longer happens. Should this comment be updated to describe the actual
operation (e.g., "Project 64-bit range onto 32-bit subregister range")?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24879978534
--===============0361180916456202118==--
