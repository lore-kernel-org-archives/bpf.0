Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9F233926
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580522; cv=none; b=kvtgKODKNIxhh2WwzLueZdsTtc00AIkji8iD8wFPissnU005jKJdCpRqrU44Bc54cBw57nNUS5x+0xASlCMG9fgASpg1UjJE6icXK0SP10t1qSFlj+Z4x/S6TiycEUkycvKnoGoinwVBn6snVLpGvgTEpmp6iOsR5jOXZ7g0Qek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580522; c=relaxed/simple;
	bh=R2+iHlLZbiwb138n7wrByBzlnnLHuQk6NP3lI+onXgI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JphglxPGZSAjOPm8m0LJlnpWudvaohsHw5FArA004e0TSYR/RVzOe2O4+O9N58UIU7OIDyrYAd9yNrY+jy4ys/y1rI1DoAm9hxUtdOhanydLuUwWzY89r28kFbvQGApiRosiStD8/uJEm8IIpsBPbg5rMM++p7X2Veu87Qyv/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHFn2x7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHFn2x7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D5E1F000E9;
	Thu, 13 Aug 2026 00:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786580521;
	bh=N0J/TFkFLquQOGJa76Y/PCNVUBByD/Mys4gRBCA2GBI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GHFn2x7suwRy0QXE8Hr/zFXx0vtn0CUewKTh75DDnxE2BRuF2mwuy38NNGnBk4BNp
	 D9P2ZDPAXlzjCWlhy/oGc77Bi24KY2pdBpMMKHlsCE+6PTnp582W4fbS1yHqwbL+XT
	 qBofY2BMtj5appJYv5bh6q8qg2HMFKbr1A52tL3ANk/ZxYtfZy5KisUMirXoOLemDq
	 VMAx8PoTpgaRStkSEnIH55jLjk1f+9/Q/PrvGfqe8kiLCgi+y7to9WliX8LPHIeJva
	 WxlMWyNvkyBXiI2j1FxzUn7oeRxv7xl4JYsY1Dwv7V5bihotXeWlNQw5wv2IU2bQNO
	 QOKhd5YOhXPGQ==
Content-Type: multipart/mixed; boundary="===============6238353480896353928=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3afb88687dc4a621f698d8fd49e961dcfb79a9b2b27fad8b6832664195bb2185@mail.kernel.org>
In-Reply-To: <20260812231506.3558128-1-memxor@gmail.com>
References: <20260812231506.3558128-1-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Fix func_info_aux desync after dead code elimination
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 00:22:00 +0000 (UTC)

--===============6238353480896353928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Fix func_info_aux desync after dead code elimination
>
>     The verifier keeps per-subprogram metadata in three parallel arrays:
>     subprog_info, func_info, and func_info_aux. Dead code elimination can
>     remove whole subprograms, and adjust_subprog_starts_after_remove()
>     shifts subprog_info and func_info to close the gap, but leaves
>     func_info_aux in place. From that point on, func_info_aux[i] no longer
>     describes subprogram i.
>
>     Shift func_info_aux together with func_info so the three arrays stay
>     aligned after subprogram removal.
>
>     Reported-by: Sashiko <sashiko-bot@kernel.org>
>     Link: https://lore.kernel.org/bpf/20260808064523.DE3E71F000E9@smtp.kernel.org
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This looks like a bug fix for func_info_aux array alignment. Should this
include:

  Fixes: 51c39bb1d5d1 ("bpf: Introduce function-by-function verification")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31651414371
--===============6238353480896353928==--
