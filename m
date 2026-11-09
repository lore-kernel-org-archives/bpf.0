Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246144;
	b=SBkoY4LMKMhViWx0wRjw2VIecvMUWw0cF2d9oLJYfSDf7qo1RvkmHQVDWXseATYVajqe
	 O7jTZYiMt9unCFipYDnpxI1sB3dnhQIdMoB+knKLqPsolP3bu5adzHxiYfSmh5Wf1tACr
	 c9+1hgX9QjvY11fVvzs3yQcS/cmY9hpvCTFLrP7e618WJd/4m4MkJID1eOCArWpRPKxZG
	 V2AY2eXfkl38Lzuf9H788dOLOr82dT5NrGkHFjYMat+2SEg8R9D9O6PcS9LQnuSI1OOFk
	 2NhOAmZUxE3NIgpHUMv9fpVJMttHiW1xEtKjI3jcGnVVjIPzHz5XRmRY+1+fMl8hp+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246144;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=6ChZe84x7sVjm9A6TFZ6cSlzwGuFiV3GL0YrphOjBdQ=;
	b=JrwH5izniPiFL/gPVMgXjhqUqQK6AFbifKrsAZNYHx6vfwU7WswPr4xPfyCdL2nR6xuW
	 3fV/XUnBNIsD8forIA5XDKCOxR5Im+dayfMiveCbMn05e2/u11PLtxdDU4BNu/qpdSe0O
	 +RXv0lRPxxb57z/Ag6zBc7YiAL/0GRUAzwRgkMslDEnkLI5Tvb+6xbCYz6vZqmdklpE4g
	 EZvPqXqGLpPspIOQKhtc4BJicRY9Vnigec2LHyrEdYS+kLo+uOC6T3IdwIXSeKRNc3CDD
	 GEc1q1UMQDxjpIBE2Mn3QeAfATyfOvf2ZtLouCx6+vV+ybAf1tueCW7lhAfPobPQ0HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HApx3L8o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76425606A332;
	Mon,  9 Nov 2026 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HApx3L8o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4DD1F008A1;
	Mon,  9 Nov 2026 17:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246144;
	bh=6ChZe84x7sVjm9A6TFZ6cSlzwGuFiV3GL0YrphOjBdQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HApx3L8o7rVPRgYCXupVmX6EX0H4jvTf6lThKE9An+ycYvTL5X3sghbXAJuK6mUNX
	 YVNaDrAelvhKfjZujHEXuKZGdfrlHLhhnvPa0y4UG2Rx2fVTGstj3e15kemMftvHqV
	 1hxt/M6RjFBHBUcZe1be5ewVYutLDbGvFDFNfazSAdJvppTzELjExl8xjntQ5Ut8GM
	 9rbhmMkBE4mWlalmIC91SD1bF4M84dkcayLVyVFfKyZhQsyZ346dGy3HEQWIk5MH0t
	 Xrc4n7ubcglagmKNW/aomw3eE+5wzXEFpVwvJr2Y/RBwYnf4AH8jIFTEjZzI9ClG+q
	 sCAWvMHitTCZg==
Content-Type: multipart/mixed; boundary="===============6861997353970064917=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <342114bded17116917aae775b31c3c68a484d0c3e49e1b27c74131a6ba236ca7@mail.kernel.org>
In-Reply-To: <20261109170550.141443-19-a.s.protopopov@gmail.com>
References: <20261109170550.141443-19-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 18/18] bpftool: List and show fmod_ret targets
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 17:42:23 +0000 (UTC)

--===============6861997353970064917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: List and show fmod_ret targets

TL;DR: Nit only: bpftool.rst adds fmodret to the OBJECT list without a
matching *FMODRET-COMMANDS* line like the other objects have; suggests adding
one.

> diff --git a/tools/bpf/bpftool/Documentation/bpftool.rst b/tools/bpf/bpftool/Documentation/bpftool.rst
> index f38ae5c40439..2c64c22a5026 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool.rst
> @@ -21,7 +21,7 @@ SYNOPSIS
>  **bpftool** **version**
>  
>  *OBJECT* := { **map** | **prog** | **link** | **cgroup** | **perf** | **net** | **feature** |
> -**btf** | **gen** | **struct_ops** | **iter** }
> +**btf** | **gen** | **struct_ops** | **iter** | **fmodret** }

This isn't a bug, but fmodret is added to the OBJECT list without a
matching *FMODRET-COMMANDS* line.  Every other object in that list has
one (*MAP-COMMANDS*, *PROG-COMMANDS*, ... *ITER-COMMANDS*), as set up by
commit 6585abea98ae ("bpftool: man: Add missing top level docs").

Should a line like this be added after *ITER-COMMANDS*?

  *FMODRET-COMMANDS* := { **list** | **show** | **help** }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42662799554
--===============6861997353970064917==--
