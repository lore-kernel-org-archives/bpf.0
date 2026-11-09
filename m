Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265211;
	b=PLwN/xQEy4pnSWdLC2GtQzPM6Best2zWj/otuj2irmrvIkTVbpXj91SbUUe1wjl0j3wP
	 Me1u/pXVefgUQcr5hw9fFu2nR9dkYFBdw+6T0WzuiZlou0aRyifIrVm/xvK1OIDewQ+GX
	 fBiDgbq391umCDRe+ZujW8vULspu6PI5QIA1Js7gBjmJpv1e8L+usuwtaRwKLorC45Hbk
	 qItrYmmYFsDoqkrcMHk8s4/aFD96h2kpLoCAOXqKUEzz2Q73o8jiPsP9XgLZi6hIb56fJ
	 VWyL+2aZC35SylnxtwnDlFOHkgh+vJZlJ7QHl83/oDdKDd+rPE/kmP2LLCL5uuNfGng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265211;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fSm6RWRIHhMCklVSLN9b1sPg5Gcw6uv4Dw7npTL/Ly8=;
	b=1RRoFam1tjSMjFLg703vgP4cOPoiBPm9sE8+ffvJmLkR8j7uDRJhceqrQN7wcEMPkh39
	 jiborzYoGchE5YsrucVRTTT/fJC4c6gJI9T0qv7LkiTRr/1uyy2zfHPiwmpfvfIi5OWC8
	 Zarcv+Ayy4+Td/Jzn1OrXU0uDch2GD/570lQvZDneheqZDknKGe02gquI1PIV8IRZkQzs
	 tG8vR+LuhlIoKUkWPvVZ2Gt5Bok3f9V/ZEgX3I4c1Tg1UTMe7MJMos4vhurFARa53p7Lb
	 gSuwvw23zvZfJ5vilP+DRJxBL46UileqNbpZ1mDMn3SG2czv9tBz8kywJ5kA0RsSNMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8MnCexl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC2606A32A
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8MnCexl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A842F1F0089F;
	Mon,  9 Nov 2026 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265210;
	bh=fSm6RWRIHhMCklVSLN9b1sPg5Gcw6uv4Dw7npTL/Ly8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U8MnCexlQiYn57OzAwCUsCQnsi2SymTn1RUAA1x7TIKk8eXJ/1dgBIITdGIlqx2xB
	 ocHNNMAvEAGSRb0QruT/6dHLk5YnMst83mEfyoqa+1gj/Tx4M6qm8ZuV/ylM2nxR+z
	 Pk3F64ugrSpL3QBiYDEWTkVq3OVdbdTUS9t0TCxNGzK1k3onSHhRQ0s2DHwoKtTN0D
	 zmIbHJrYbd5NIXRjreE99Erjqy7MtF78WiblhKhnH7SgD3/iBaIwkT8I8uZBAs/XcO
	 /nSJAh5eNsw9OMIx7dYlcB+sLKfKRdkB7Ked7wQBsA1IHmk3lF4qgd9Z13tjtUNysh
	 Re/0n14H6Xsmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B343391AF99;
	Mon,  9 Nov 2026 23:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/6] Fix ring buffer callback consumption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179426520918.3532311.3624579682488216373.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 23:00:09 +0000
References: <cover.1794253561.git.memxor@gmail.com>
In-Reply-To: <cover.1794253561.git.memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon,  9 Nov 2026 20:47:26 +0100 you wrote:
> Commandeering some patches from Tamir for libbpf ringbuf callback
> consumption fixes. See commit logs for details.
> 
> Tamir Duberstein (6):
>   libbpf: Honor zero consume bounds
>   libbpf: Prevent NULL callback crash
>   libbpf: Reject overwrite callback use
>   selftests/bpf: Test ring buffer consumption with a zero bound
>   selftests/bpf: Test the ring buffer consumer with a NULL sample
>     callback
>   selftests/bpf: Test that callbacks reject an overwritable ring buffer
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/6] libbpf: Honor zero consume bounds
    https://git.kernel.org/bpf/bpf-next/c/40edacd47993
  - [bpf-next,v1,2/6] libbpf: Prevent NULL callback crash
    https://git.kernel.org/bpf/bpf-next/c/c0628a0659b6
  - [bpf-next,v1,3/6] libbpf: Reject overwrite callback use
    https://git.kernel.org/bpf/bpf-next/c/f756eedb24d4
  - [bpf-next,v1,4/6] selftests/bpf: Test ring buffer consumption with a zero bound
    https://git.kernel.org/bpf/bpf-next/c/c82153312a0a
  - [bpf-next,v1,5/6] selftests/bpf: Test the ring buffer consumer with a NULL sample callback
    https://git.kernel.org/bpf/bpf-next/c/21f96738feb7
  - [bpf-next,v1,6/6] selftests/bpf: Test that callbacks reject an overwritable ring buffer
    https://git.kernel.org/bpf/bpf-next/c/249c9bb9f3ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


