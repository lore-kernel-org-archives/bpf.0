Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795349506;
	b=GJnjExmVrE5CQ4aHkzZ89YC7sb2vVGgYKBE8XXtCNtKQGXkqP+zHNYrFw3R3ZbNgy3gI
	 zIRxZF0TGNqwuGrbq//FaTBysWNmWFUlZCcXeADpGe/DlvT/8nHaMCIkNlOQaZAD7hFwQ
	 KGQdVJG+F8Wvv1WPrmty9mu5ZlazQunR/BMKWKqxoP8zGclPaGAo9FhKj5e+c3Ar0bUrk
	 bF5WurLFNr86SDjwENoTwBSmCgTC1b9v+v3ZLsqcm5e9YiWvnY6zDWf2lzhk5WsCLlZAF
	 WloWGxQcY+vMLdOcDz6lpekpj6mo84uqGV697tYpBtI6WwNmN2G1x+leuwujdB95YHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795349506;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Scxt2bxPMpmJegVzDY+zbW96DUs8I1ZtPCY9jVPIzOY=;
	b=imdcaL8tdo8jqmhdes+2LcXJbF0PiL4y6IpFCH0eU0OKPBNMy3W++k0DJx6o4da/lB7q
	 k1w/bVDl75ZM+6Nc1BhJfo2pZprkQmXCfcCkX85yIcpLY8xLrGsjDiCJLaun8OzFN+EiI
	 lE9Stuv22/MLz6sZGbRK8CbCGxu15oc7xjCoD3/5Z5ysO0WzXjoy0Oyjowngic0hKy+ta
	 5rUEBWIZa/XnSq3YUDihjce6lGOSe6OBh4puAr8jgui93Y7RFuJaz2KvLQxkR8uLeNhnP
	 8wMaAlTMLV3VmK4dMlnO9BLPmsZ4cDpaKzJFtcnjdjFK19Pb+uGxmS1kMCbu0eFlc7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6NAaqDB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F32606A320;
	Sun, 22 Nov 2026 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6NAaqDB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099241F000CF;
	Sun, 22 Nov 2026 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795349505;
	bh=Scxt2bxPMpmJegVzDY+zbW96DUs8I1ZtPCY9jVPIzOY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X6NAaqDBIYomkTnNPDzKiggb5q9M/IB/C11ejZZTHpvxYa+yzO6UIGjAQR1sz6TSx
	 Gg5on042Cs+NAbkKHXBoTzx748cNZWPkdKp0XNBuBBW633CWtBicxdOmDl+kPqHdS1
	 wbjchU0FNQKkqLixHCJNG3uH4JhxLhl77VkvVnldRGNneBNWY6Pc0Gh22VrEC6DB02
	 buAZnPWcqujAZrFIJJkAd0Ixku7F8lSX+IN67gFlIZMEp2/XmV6KOzE/oCq+6RTWPR
	 Tzyut9bOg3i5fL98lwR9BWKzcz3gd/yxHU1zCQTV413VhQLEUTKNDb7erB+q6FpEU3
	 dDmWvq0Z/6qOg==
Content-Type: multipart/mixed; boundary="===============7908190949905685822=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f2ca7638ded85a06d7e9dd498cf248e741e95134694bc1ee9de25ac91782918d@mail.kernel.org>
In-Reply-To: <20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-v3-2-1f94ae9a884a@pm.me>
References: <20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-v3-2-1f94ae9a884a@pm.me>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: test arena allocation after a short mmap
From: bot+bpf-ci@kernel.org
To: fadouse@pm.me,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 22 Nov 2026 12:11:43 +0000 (UTC)

--===============7908190949905685822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: test arena allocation after a short mmap

TL;DR: Test-only nit: the comment in arena_mmap_alloc.c claiming an
offset-zero allocation can return NULL looks inaccurate, so the first
allocation's result could be checked instead of ignored.

> diff --git a/tools/testing/selftests/bpf/progs/arena_mmap_alloc.c b/tools/testing/selftests/bpf/progs/arena_mmap_alloc.c
> new file mode 100644
> index 000000000000..3854afbebc45
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_mmap_alloc.c

[ ... ]

> +SEC("syscall")
> +int alloc_beyond_vma(void *ctx)
> +{
> +	void __arena *page;
> +
> +	/* A successful allocation at offset zero can return a NULL pointer. */
> +	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	page = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);

This isn't a bug, but is the comment about offset zero accurate?

arena_alloc_pages() returns the full user address:

    addr = clear_lo32(arena->user_vm_start) + uaddr32;

For pgoff 0 this is arena->user_vm_start, which cannot be zero since
arena_map_mmap() sets it from vma->vm_start.  The kfunc return is treated
as an unknown scalar by the verifier and the JIT does not truncate it, so
"if (!page)" is a full 64-bit compare.

The offset-0-looks-like-NULL behavior seems to apply to nullable kfunc
arguments (see progs/arena_kfunc.c), not to this return value.  Also,
prog_tests/arena_mem_usage.c asserts ASSERT_OK_PTR() on an offset-0
allocation.

Could the first result be checked like the others, for example with
"if (!page) return 4;", so an allocation failure here is distinguishable
from a VMA-bound regression, and the comment dropped or corrected?

> +	if (!page)
> +		return 1;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45018621389
--===============7908190949905685822==--
