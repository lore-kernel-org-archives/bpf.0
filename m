Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26847AF43;
	Thu,  4 Jun 2026 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589164; cv=none; b=gL2tSkU3mXFL4XQNto3lXEGkBoSmi3yfWt4xPnS8nLMDEStU9fHWFmsXEA39wJ0z2HGdPbx+hEqOnSbyOvgmHXMG4sypu/6onCmY6TtGuqWEnLiuhAQopuq7EPLuXURsUU3yeSEJV/jGq1M2RN8vZreqjo2SaVhT7+e6xjXr+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589164; c=relaxed/simple;
	bh=0Gpso7Ih3X1MIAxILMhdqlbD7MJ/a0w844L5xxMVMgM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oUwBuBb3UI7rK1vjhGgsEwZT8gfVi+18W6UbcKNX6JIknn0x1hYPgdhGeqibYmfDVjHXXXrWcC7agklNc5JxmMjauZAjaF5r80NijFZ29T3Xc7hKi4oYGt/DrcHjDc+wyiA8Ji08v6ZvypCBGkua9t7zUZDRI6NgFi1C7s99S0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG4rHRAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG4rHRAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70811F00893;
	Thu,  4 Jun 2026 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780589162;
	bh=tFI+vg21765H+Ng7GBsTiEh4IHM4SBeB/+qW8xf0hrc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LG4rHRAS1DRmDdZPwWHZLVHdEBzs9JSa9nBoOD4Lwj3xw7VmxejIvRya90L+v/7HB
	 WuwZweVG1IhSQCtUrSjHxd10EUk1fYhIepDOX7CF0ZlF9JAVcmE7rfpvNO1653eHiD
	 ajBr93iWThUsphn9SQ9O0bhw90D9v/tXkNbrIWdDZlE2CivVdViNMrNYw/0qqKB5DZ
	 tuSwl+3KLylLlzXoZ7nkFo79R0fdmXavslnTemxYsvLOcpcLwSu37SPIHCqVh4j8dr
	 y+9wEPBJAvifg8OXTF//hui2gEtz9gS6KIsfnijhG4RHphr0Tupwj2yt6LLv3AYplO
	 +mogG2DZvirsA==
Content-Type: multipart/mixed; boundary="===============7636103166405731731=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <33bdc65e1275627edd897b94dd6a4a6ed33b24b2614950d9bf89a7c267da19c0@mail.kernel.org>
In-Reply-To: <20260605-arena-direct-value-v1-v2-1-a92cb281e376@gmail.com>
References: <20260605-arena-direct-value-v1-v2-1-a92cb281e376@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Add arena direct-value one-past-end reject test
From: bot+bpf-ci@kernel.org
To: random6.xyz@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,emil@etsalapatis.com,graypanda.inzag@gmail.com,random6.xyz@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 16:06:01 +0000 (UTC)

--===============7636103166405731731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit fe93bf61d92a97b713eb292a1ccbae1cef5b23f1
> Author: Woojin Ji <random6.xyz@gmail.com>
> Date:   Fri Jun 5 00:23:42 2026 +0900
>
>     selftests/bpf: Add arena direct-value one-past-end reject test
>
>     BPF_MAP_TYPE_ARENA supports direct-value pseudo loads, but unlike array
>     maps its map value_size is zero and the valid direct-value range is the
>     arena mmap size, max_entries * PAGE_SIZE.
>
>     Commit 3ac1a467e376 ("bpf: Fix off-by-one boundary validation in arena
>     direct-value access") fixed arena_map_direct_value_addr() to reject an
>     offset exactly at the end of the arena mapping. Add a regression test
>     that loads a BPF_PSEUDO_MAP_VALUE with off == arena_size and verifies
>     that the verifier rejects it with the expected offset in the log.
>
>     This is awkward to express as a verifier_arena.c failure program. For
>     arena globals, libbpf handles the relocation as RELO_DATA and sets
>     BPF_PSEUDO_MAP_VALUE from that relocation. The second ldimm64 slot is
>     derived from the arena-relative symbol offset, so a C-level __arena
>     global cannot make that immediate equal to arena_size without placing a
>     global one past the end of the arena.
>
>     Use a userspace raw-instruction test instead, following the existing
>     selftests pattern used for direct map-value pseudo loads, so insns[1].imm
>     can be set to arena_size precisely.

Emil Tsalapatis suggested using inline assembly in the BPF C file
(verifier_arena.c) instead of creating a userspace raw-instruction test.
The commit message explains why the userspace approach was chosen, but
could inline assembly address the limitation with libbpf relocations?

Reference: https://lore.kernel.org/bpf/DJ0DRM980L8V.3MR51HBLAVAEP@etsalapatis.com/
"Can't we still use inline assembly in the BPF C file to do so? I don't
see why not." - Emil Tsalapatis, Thu, 04 Jun 2026 11:46:39 -0400

>
>     Assisted-by: ChatGPT:gpt-5.5
>     Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
>     Cc: Emil Tsalapatis <emil@etsalapatis.com>
>     Cc: Junyoung Jang <graypanda.inzag@gmail.com>

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26962723906
--===============7636103166405731731==--
