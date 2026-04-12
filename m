Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4D37AA9F
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776005064; cv=none; b=suAgFxk74AdnOmaSNfWR72q0vkfA58hd3smFcly1VX/IaPBInRMM+rb1G8nCl3FfD3H81RRJhYjYJ9j0qnAEs8PBsCbjb0WeV75lhq0dSml7qIxtn0JRybB7NhH/N1xliDHxMXAFc6rgGhGF2bLZd2y7M0d3r2aiTj4BasSWZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776005064; c=relaxed/simple;
	bh=/nCRtNYxoZUYPfzdp8TLSIX5a618XNShqOfdA/yrPRE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dUZyF3FaGUrImGnDMzYr8kb3v2xI1nNoRx6TFJDxm25+MTCWGCUSptlbwi3UkrO9AVryBQ2L1aQo5VL7uZJiOIvkU0fx/i7ff96zHw3fN0KTcl7tSaWxhAr5OG9TjGAaMHHNCdW106kuwsmcxcxELYcXRKdc6wXBOU22VYdR+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKDgvdGK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKDgvdGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0039DC19424;
	Sun, 12 Apr 2026 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776005064;
	bh=/nCRtNYxoZUYPfzdp8TLSIX5a618XNShqOfdA/yrPRE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MKDgvdGKQ/H+Nmhui+cTRkYw8pMSe2kS6PnAxOFL7upEw497/Yvkx+w9UIauYfsMj
	 Gn/d0XIRKbEsdKN05OwI3QDVG0KY2VbHEld6XXKkqHS8aVwFuLauDeyNfbPVgWXV4E
	 YWAcg2GVjJHFUA2Y1xLjnDRWw1yyxA1ckxxyKJT9x0omCBczVEaZ3FDLt08+xYQSK8
	 erQtO5XNIKJa3hrWbKrRWHCxetF873I+NOGDI+WNFKgHWRqbFnMDl7YVSnZufzJjPH
	 7a/IqJTtuDiC7OpPoQZkKcYuNFjE5vGDZru/fT5VQvxk9wixJZQn74HXBinvdkG1PN
	 FRQt6j7wPslVQ==
Content-Type: multipart/mixed; boundary="===============4407331058983604824=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ceb9ec96d5e0353e930f0b529e90a886d0c09b419c81b1cdcf7a8a1edddce57c@mail.kernel.org>
In-Reply-To: <20260412140715.30423-5-alexei.starovoitov@gmail.com>
References: <20260412140715.30423-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/6] bpf: Move state equivalence logic to states.c
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,memxor@gmail.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 14:44:23 +0000 (UTC)

--===============4407331058983604824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> new file mode 100644
> index 000000000000..3a4a7f6d861e
> --- /dev/null
> +++ b/kernel/bpf/states.c
> @@ -0,0 +1,1552 @@

[ ... ]

> +	return 0;
> +}
> +
> +/* Find id in idset and increment its count, or add new entry */
> +
> +static bool regs_exact(const struct bpf_reg_state *rold,
> +		       const struct bpf_reg_state *rcur,
> +		       struct bpf_idmap *idmap)
> +{

This comment appears to have been separated from its function during
the move. In the parent commit, it sits directly above idset_cnt_inc()
in verifier.c:

    /* Find id in idset and increment its count, or add new entry */
    static void idset_cnt_inc(struct bpf_idset *idset, u32 id)

idset_cnt_inc() stayed in verifier.c (now without its comment), while
the comment ended up here before the unrelated regs_exact(). Should
this stale comment be removed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24308676856
--===============4407331058983604824==--
