Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939D309EFC
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159254; cv=none; b=lB/6B+kVY+Ml2S8XOrGTiynttPDDs9IQTtIqkXMIBWyZ18wzmL6B0BVWl4gUSozJfiTrmIZc/xwOK+Ppf06LPc3OUzwq8QmcZy682euC2bQQyyL3cElQobieGgEctG7az+ce9eRjmG39VzZ4bjSsX8FzezrSIm7mjdr4Ytg6W1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159254; c=relaxed/simple;
	bh=X9KKDKqTsgvutrS/8YRIx3oeYk/ZYi39fRI1AQeO8pc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Tp/ykBq0zGbIXp/aX9X7FXut9cFTnQyEUr0kBuUDvSleZE67U9BT9pQIhuaT1aJaWeojr0OBm5d9hSHiRaIWVIBrEziGcBF4uX4FLPdpJnT8iyg84tJtzXMUoZ/lWYbL9Q4Rj/Svtr8bPRt/V6F7DtIRZdB9zKhD68ss5yg0Fww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eol9rEVh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eol9rEVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D86AC2BCB0;
	Sat, 25 Apr 2026 23:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159253;
	bh=X9KKDKqTsgvutrS/8YRIx3oeYk/ZYi39fRI1AQeO8pc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=eol9rEVhon+Hxdg30HFdNHjThvw6PmGp4x+B7/Kbf1GMSUz5+NL3KmBGy4fGmsKP1
	 HC5HD28NXi0Ka2bRR8polexpzDV9jEfXahOyDuVHbDstkYuzLc0tPnFCW5Deu4+anR
	 a6ijcO/n3aP7h2xMcUVLu549TN7yBiE/iupgyhipBtD46ly7LKknO8wjLlAcjITmzd
	 7HKR3zdc18c7yvxDD1uN05kXIHPWagE+5p/GsrUsL7KonSw8e/7EXxa2yVEJZuiCn+
	 0kic9fcoK7ZhoRW9gav4AEtnKadjjtzT1fZ2ZFey++gHUw0l6iBgn4XmZPLh1dC5KT
	 RtahpqbsssJIg==
Content-Type: multipart/mixed; boundary="===============3638917884155175547=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cbe38c19690a27094f622c637388fab76c18c5c1d9356b8702acac37abe4a9a5@mail.kernel.org>
In-Reply-To: <20260425-cnum-range-within-v1-1-2fdca70cb09d@gmail.com>
References: <20260425-cnum-range-within-v1-1-2fdca70cb09d@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: range_within() must check cnum ranges instead of min/max pairs
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 25 Apr 2026 23:20:53 +0000 (UTC)

--===============3638917884155175547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: range_within() must check cnum ranges instead of min/max pairs
>
> states.c:range_within() must be updated to properly check if
> cnum-based range in an old state is a superset of a range in the cur
> state. Currently it makes the decision using min/max accessors:
>
>   reg_umin(old) <= reg_umin(cur) <= reg_umax(old)
>
> This is wrong for cnums that cross both UT_MAX/0 and ST_MAX/ST_MIN
> boundaries. Consider cnum32{base=0x7FFFFFF0, size=0x80000020},
> which represents values [0x7FFFFFF0, ..., U32_MAX, 0, ..., 0x10].
> Its projections are u32_min/max=0/U32_MAX, s32_min/max=S32_MIN/MAX.
> A register with range [0x100, 0x200] (which lies entirely in the gap
> of the wrapping range) would pass the min/max check despite having no
> overlap with the actual cnum arc.
>
> This commit replaces min/max comparison with cnum{32,64}_is_subset()
> operation. The operation implementation is verified using cbmc model
> checker in [1].
>
> [1] https://github.com/eddyz87/cnum-verif/
>
> Fixes: bbc631085503 ("bpf: replace min/max fields with struct cnum{32,64}")

The Fixes tag points to commit bbc631085503, but that commit exists in
bpf-next/master and is not in the ancestry of the current branch
(patch-series.local). The current branch is based on a grafted commit
e06021ed87b0 that contains the same cnum-based code with the same bug.

While the Fixes tag is semantically correct (the bug was introduced when
min/max fields were replaced with cnum structures), the referenced commit
is unreachable from this branch. Should the Fixes tag reference the grafted
commit instead, or is this patch intended for a different branch?

> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24942703368
--===============3638917884155175547==--
