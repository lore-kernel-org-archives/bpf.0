Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1E378D8B;
	Tue, 22 Sep 2026 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121087; cv=none; b=bHsfFmyTTsr/scqzkBMC11cThMKVGg24Ywi6LUCU28qmuN/H3vPsgzrbaRO5yLsl7OeyIVTKnDLAlB+55IaCdiodvaFbavBot+7I0O3sm5d8No9G4Nzdm+CsCb/37Kjc1plsx3ys+oFjANsv+m7pr9ml43GLlMTM6lquy4t43zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121087; c=relaxed/simple;
	bh=EWnN7TGAoOMKxBwQ5BC7UQDZw94y0isDXpjj2yfbpj0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jp6W1KGVEjR92vIXoRQflxuu0TJsGuTUh0GFG4I8gLsNGy5pC+C9T5dvKXygi63PWcvKIk9r1nyQzbtIoOD+RUS6Vcx14GraXp6Ujm7Xp3aAqE+yPB+52K+1Nnza7K2fiyG8Wcz6wORMuDDdXYPrLjUk+1TQhSJpYYW9+6FLcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED5IIdrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED5IIdrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4DE1F000FF;
	Tue, 22 Sep 2026 23:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790121086;
	bh=o/qkaM9uNu14Mm40qezBhcFOumMShI5Kb9WsB98xHJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ED5IIdrvqg8EkaWUiEtEoynm+1OErj7FDHaCIakOGA4R49JH91T5GcVC3IrExqEA2
	 tOrwDr9glPhlOYGkiQNqC3SyCR7BgQ0J9IIberzU3GMkd4busyNp8JmRRkiUJNaFnp
	 L8NAx986n/LLIo3PROsf4W7LZ2g8cSfyfS8tkF5y4EEZsuJzTvvIDypXFPlkdNXZnV
	 T++phynQ6oCinq2N9dLKO09wbgp2oZfKmbGxGFdFQ2yIktue9F8jG+4CvXDU3Bymap
	 cSiG6WzgrMf9DzgAyAxRMs52RQvsX3+WjNIoBQfZ8vc1YGG5AKAIj8e5DR1B3xMvgL
	 NEgkFUpDN7DsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1997B3822D65;
	Tue, 22 Sep 2026 23:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] bpf, mips: Add signed div/mod support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012101689.134796.18001774666321300872.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 23:50:16 +0000
References: <20260911213340.3767930-1-main.kalliope@gmail.com>
In-Reply-To: <20260911213340.3767930-1-main.kalliope@gmail.com>
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: tsbogend@alpha.franken.de, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, philmd@oss.qualcomm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 11 Sep 2026 17:33:37 -0400 you wrote:
> The MIPS JITs do not interpret the insn->off value that selects signed
> DIV/MOD semantics, so negative operands produce unsigned results.
> 
> Factor div/mod emission into helpers, add the missing signed uasm
> operations, and decode insn->off in the div/mod emitters. On MIPS32,
> use signed 64-bit helpers for ALU64 operations.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf, mips: Factor out div/mod emission helpers
    https://git.kernel.org/bpf/bpf-next/c/a2710072ddec
  - [bpf-next,v4,2/3] MIPS: uasm: Add signed div/mod and sign-extension emitters
    https://git.kernel.org/bpf/bpf-next/c/668508db5ecb
  - [bpf-next,v4,3/3] bpf, mips: Add support for BPF_SDIV and BPF_SMOD
    https://git.kernel.org/bpf/bpf-next/c/47c26a8570d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


