Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673A94734CC
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520277; cv=none; b=VtEjuRqDC3fcOHnv2mpGtUOwVZp0WhbleGmgA//3fSAvEWk8S+gyAQQJOopHPXcxd8iPbhe4Ete/EFKeFIoeZCcVpTKyIJ8I7hH+4wZFKhUru2tl9g8WNT5NQeNBaDir9iy6/fRrTRbfP/MoX09MKMds55OGtQhhnSS55MmiwY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520277; c=relaxed/simple;
	bh=y+Gm2Zb4ZTJQuxUPMfbAigy8wm7XYn8GQpGlVEeAowU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GllxOXtaMuu04OAnyffmxo5A/aC5t7kFUIDQRg3Ty0Ez6qzNOs3IdW7pFnmgoH+/9zdxlHqtx9q3kH64n2kuEOVRQh31nJBR4XWojsqolk8EdH3kSxoNu5kDdt+QgwefRgs4mXD9av1Se/us8aY0Qp2QXq06YnJY1FU+m8iXN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4P5VTqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4P5VTqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D3C1F00A3D;
	Fri,  4 Sep 2026 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520275;
	bh=hFQu8OgskRPu6+EtVQcq1dF8uzogK3JLLyaFBJwTkD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R4P5VTqmo8/UPyESLJ5MCRv9rp1fRUp0fNfC+7bL5ftPATi5RNSp+BReb3MRu/nXW
	 tLEU2Fv//QTOg6kj/aU8rrDm+R3OMvNtIKm4dVSixuU1KUQfs50g/eY0g9fz4urLb9
	 yvwOPu5EUhZXykpcCeRLqbIFgnrjTKP0FSbELVFbFNDk+2HEcOhOjxzWH3YmHOI5ih
	 TxIg6DCimvY8YhiafGYqKW5+lwoDndFleLWIo5mEXJSrHP1pK66zn4G3aI1LHu8gRu
	 XvaE0Oa6rGXG+SEGQgN85ld1cfZUmu4NjQCcg2pfOdwCi26uyI547lm+N1+gdGAGKb
	 uDNHjAGqxjDzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198833811A58;
	Fri,  4 Sep 2026 11:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/8] bpf: don't infer non-NULL from a pointer with an
 unbounded offset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178852021565.200410.13716301907669096570.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 11:10:15 +0000
References: <20260904083325.2083493-1-eddyz87@gmail.com>
In-Reply-To: <20260904083325.2083493-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, memxor@gmail.com, npc@anthropic.com

Hello:

This series was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Fri,  4 Sep 2026 01:33:18 -0700 you wrote:
> reg_not_null() decides that a register holds a non-NULL value by
> looking at its type alone. For pointer types that allow arithmetic the
> type only guarantees a non-NULL base, in case of an unbound offset
> the runtime offset value might still add up to NULL.
> Consider the followng program:
> 
>   r6 = bpf_map_lookup_elem(map, &0);  /* present */
>   if (r6 == 0) return 0;
>   r7 = bpf_map_lookup_elem(map, &1);  /* absent, NULL at runtime */
>   r8 = r7;
>   r8 -= r6;     /* pointer - pointer: unknown scalar, -r6 */
>   r8 <<= 1;
>   r8 >>= 1;     /* any non-negative offset is accepted by */
>                 /* check_reg_sane_offset_ptr() */
>   r6 += r8;     /* verifier: map value;    runtime: zero  */
>   if (r7 != r6) return 0;
>   *(u8 *)(r7 + 0);  /* r7 is inferred non-NULL, both are zero */
> 
> [...]

Here is the summary with links:
  - [bpf,1/8] bpf: don't infer non-NULL from a pointer with an unbounded offset
    https://git.kernel.org/bpf/bpf/c/67b529f521a6
  - [bpf,2/8] selftests/bpf: no non-NULL inference from unbounded offset pointers
    https://git.kernel.org/bpf/bpf/c/6752b90ccfb3
  - [bpf,3/8] bpf: don't resurrect a scalar id dropped by collect_linked_regs()
    https://git.kernel.org/bpf/bpf/c/73a98f96811e
  - [bpf,4/8] selftests/bpf: check the linked regs cap for the compared register
    https://git.kernel.org/bpf/bpf/c/bc412b3fb185
  - [bpf,5/8] bpf: don't predict JMP32 pointer vs zero comparisons
    https://git.kernel.org/bpf/bpf/c/e51179a4e098
  - [bpf,6/8] selftests/bpf: check that JMP32 pointer vs zero jumps are not predicted
    https://git.kernel.org/bpf/bpf/c/836b2fe544a5
  - [bpf,7/8] bpf: mark the zero register precise for a register-form NULL check
    https://git.kernel.org/bpf/bpf/c/6aed0134d3cd
  - [bpf,8/8] selftests/bpf: no non-NULL inference from an imprecise zero register
    https://git.kernel.org/bpf/bpf/c/6b31560c6bc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


