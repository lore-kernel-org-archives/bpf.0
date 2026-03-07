Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FA1CAA6C
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847348; cv=none; b=sny821AkzApCGsC8TPAcPtwXLaFZMQFfIfrfNd/Yv6OfdDzKA0j83p9tJJnBAp97LQ/wM6QITFnL22aNroMDohDLj28H4415u8HhFJ9DrlKEb+KLJWRDpI0wyz/0lrlE4pdvGaynf155DiabS7KDSc+ZRq7wi77E7FzMfwkhnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847348; c=relaxed/simple;
	bh=II6MJMmotRnOYf82HcvcR9dZWZspA/b+FQJpO394r+I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Maj2XCHa4oMesRedoqcZTUGzrBXojpEdiH8P/M22iCgHtl/glxN5zo6VMd2mv98k2y9UtylNA2F/lXzQiDAPQOHfiawhYw/ddUJN2P0Yj2nkrVqz46istEXh5OnyeM/9QtJJnMKscbGe9rQnQw6Lx4CqKJ/lQH3So0C+ti8Ua2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw08dH2K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw08dH2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D04C4CEF7;
	Sat,  7 Mar 2026 01:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772847347;
	bh=II6MJMmotRnOYf82HcvcR9dZWZspA/b+FQJpO394r+I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Jw08dH2KHIont/fJ4TIpxVz+AfgctzuD5ULZVEGJ1HhWgCs0/3OgNFcVv5kA82yX3
	 D0l9bcdnzbrmLZd7NWSu/tgiZOh8Jp4SPHuuAaQ4p0Ja9lzQem2nZd7EL/UiOgq8zu
	 0GSwd8gg4zLRb1GpRdqs9zRpn1EKSLUjzeQt42ppBNsDgKSQSQJJCk06yp3sPHwBYA
	 8Gl3/Vaw5gD8x6HiLDQAcfxMleqiprnuv6SiL0pOYwK0Wdkk2zycGnSrmmlpvyo7Vr
	 UfVvwZBuyYsXn3rAWtW/ByvBeRhtTIGuC/NXva3EUkrY8NzsxHLXDkDVyI/f2cP3y/
	 llHTxqWLjAztg==
Content-Type: multipart/mixed; boundary="===============6270796918947518156=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <15fca35ac582a44314e22a1d2fba11832355fe6f00635b1da7aded6e48dc35d2@mail.kernel.org>
In-Reply-To: <20260306-bpf-32-bit-range-overflow-v3-1-f7f67e060a6b@gmail.com>
References: <20260306-bpf-32-bit-range-overflow-v3-1-f7f67e060a6b@gmail.com>
Subject: Re: [PATCH bpf v3 1/3] bpf: refine u32/s32 bounds when ranges cross min/max boundary
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,shung-hsi.yu@suse.com,paul.chaignon@gmail.com,emil@etsalapatis.com,arighi@nvidia.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  7 Mar 2026 01:35:47 +0000 (UTC)

--===============6270796918947518156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Reported-by: Andrea Righi <arighi@nvidia.com>
> Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
> Closes: https://lore.kernel.org/bpf/aakqucg4vcujVwif@gpd4/T/
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Should this have a Fixes: tag? The 64-bit version of this
refinement was added by commit 00bf8d0c6c9b ("bpf: Improve
bounds when s64 crosses sign boundary"), which explicitly noted
that the same logic could apply to s32/u32 ranges but did not
implement it. This patch fills that gap.

A Fixes: tag pointing to that commit would help with stable
backports:

Fixes: 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign boundary")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22788511420
--===============6270796918947518156==--
