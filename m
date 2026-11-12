Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504873;
	b=v4GVNrHUL83Gf07RwijBfOEKwwEkvrgD1T0hBoXxSMixweGuiZ/ry/MAtdr3syEWLNLD
	 fjKTPALeN0da6D/D+vCCMvspp3CZOMO78O2FlKplEEQ2Cbiu7+EwgLGRpctT9RkSuTWaE
	 gQ6gdKfIGfaB6UKJtnMkignRPt8WZgUMBb5CX0aTTvz/q9OQazGVcMYXxIufESJ72EL8E
	 7UxDlSEgJSvEl+9TBboAyz1iRT32OvQmoMbQH0twCIAFqkYVrax+pcvwMA5lj0KrM/7RF
	 HvKpbaRp3DcKMYPlrJGe+iKPrj7Mnu87/cNnR1e5/5C7S8wtmZgahdVNCyqF7+rsuUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504873;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=K8BGRbxyU75zQ+k1MnxIjx8fccgD4YM1pBJW8tiaEpI=;
	b=5HnJ7Kj4jsKCHgDrCf8Na0AjCCwai1U4fm1Kx/7kU22/ZovC3dEAI6uexeA9piHKeWpw
	 ozyjRR2zto25V/u89rWtwsHSuhNKkT57g2Cl69+kqigpSdJmcFNizL7diEEA7xQ/r1cn1
	 yyRbNO5DOKwU1yMJAUpXlcVdgMRZ6mOnXzvBs618wYDtEgDc0OoVgFWm6VGPaVVSVcNin
	 mmqmg9vKcbCrLaZCJ7sb/rAtTtywJYTNkJtepXHd+PgyiLdBpso3WDCBZqRaSpnihM8Lf
	 MDa0CxLWwwMMXdz1nipDens8HUHRj2oRtnjksUns02iVXvkulb4FrgXKLaEplf2SvtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xv65GFMb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BA60A3826;
	Thu, 12 Nov 2026 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xv65GFMb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB72E1F000C4;
	Thu, 12 Nov 2026 17:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504873;
	bh=K8BGRbxyU75zQ+k1MnxIjx8fccgD4YM1pBJW8tiaEpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xv65GFMb8GLsNjt8BVsimrh4QJheLcctSAXDWAQ6Ydm3/3ecW6u/+vGEyG1J5aX/z
	 yiTLxlgZupN7PhjXHeo0sd2qpgxnh6XGIf1EYkipdWFsi4GZlWc9woWBB9LpOYTHqb
	 hRlYTNFNduJAQLkcnW8CSYFrAaeTWOZhe/pdUd+LpsBr51HLVlJDyHuGiBdbgMgh79
	 T0Vv3lNlUO+e2bvez2J9jOyaFkN5nJycHOzhS/9fRIZTzfqZdZB6ExVLVm1LBbTEkV
	 x6BEprrSZWlkn06IjwWxw66vTj5g4OgboL+Bl7SjfZlxcITOoKE50SPFu9IbQ0uMLM
	 7ovElad9ecJRA==
Date: Thu, 12 Nov 2026 07:34:32 -1000
Message-ID: <eb63bdf20dd6e2f09b0e7c81bc905878@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, liwanwu@kylinos.cn, usama.arif@linux.dev, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 0/6] sched_ext: fix kfunc, sub-sched, flatcg and idle-mask issues
In-Reply-To: <20261112130934.563321-1-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Tao.

On Thu, Nov 12, 2026 at 09:09:28PM +0800, Tao Cui wrote:
> This series fixes six issues in the sched_ext core, the scx_flatcg
> example scheduler and the CID helpers. The core.c fixes travel as a
> separate series.

There's one actual fix here (1/6) and the rest are rather vacuous. Can you
please think more through each change and whether it makes sense in the
context of actual usage? If these are coming from LLM scans, please don't
just follow the details that they surface. It'd help to actually use the
thing that you're producing patches for and think through the implications
of the changes that you're suggesting.

Thanks.

--
tejun
