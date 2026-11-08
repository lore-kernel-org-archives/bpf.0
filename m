Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163806;
	b=5J4o9heak445fFDcHDWx+pdn7K5OvpeOm9AahtvtlZOEdzJG151x9p6VXSmxauJu+HmI
	 4RP0GvsCLcuwqVL6DtLhG96xg7sYBON0EAjXERphEiSK2mIjlU7WlLdr6nuYU5dLhDYUS
	 2IJUDnSw2R6lKCdK5SM78zPmfyY4kA2Hdll5i0eyvVomHXYpstwK0PfGzgkLYN6olorPU
	 r4fTkqPYrHx8qrSvrBN5wDtQ7830gH11HF4iFVpGgL28QIJ4Mti6Cw3rrkdWwhlr5am1D
	 qTCFO/K7TGsjgc+2MDk0jbCJWhHmvPZ5nnkKpBwNtwXYzgfDDhR7JBzsaDE6/sTuR3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=UzyOryuR0hJpCOnvOng5NHXgErXXx3V/9QMZ6jcPEzg=;
	b=jYfI3e995wrbc3INu7F/b3Eat8os976BrXAI8ae8NO2v6EK4zE+O4NPpWYlWfSbKsTvH
	 KqnZIDPa4dy9H2c6fUfCGSwctHk1eIAJwS2h5dPyBOq//AwE1zE6iMrrumx+6toFvE6Ua
	 Uicm3XZnBOMNErAvOWzcbgdNAjTXtrDpsv65Ax4dklycPfKY/f2EO2m730v3Iqbhm5fBz
	 1ZMZbiBFfImz7hawOBXFb60RwMXoNwEXulzHu/FjIGIXGgj2abR2q/Ay7Dyd5KSaGV8FE
	 10uF6nSxYY4EEKChL77eA3pkRtryabNk3pUetTOWY+LfJbe8pIIrwinApEp0x0k+O5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HBHs/g1t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E7606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HBHs/g1t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEB81F0089F;
	Sun,  8 Nov 2026 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794163806;
	bh=UzyOryuR0hJpCOnvOng5NHXgErXXx3V/9QMZ6jcPEzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HBHs/g1t7OznIRzerJlBQqeN9jBPaoErB39Sw5R2XQwiQHszuD6sO8KIhEathqZhI
	 oyY87Th4bpBeef6lgCPaWPPNy0EUkQ3QlZSEM6NqTTT/CP9BMf0zME0ZnikPU+Z4YR
	 kEsBZ/XVS5SFJqyTIR7WRsmFPRyuModm2iX+MPMuLAjGvM7d93KF3z2okG9cr8GTx1
	 hp9nuLcnAak1zfP/oqZ8J98y/Lu45kT+ElWf0SEifCGNhxZ+fO8NGt7/IwKQ+eX6fH
	 Cw8TMiE9dnOxNYiFgOYTLZTplgChIx4nQBsePxPvaKKhTL8tBzPGJWr2uQikVRWJgu
	 0oaxVPaT8J/Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20FBE380821F;
	Sun,  8 Nov 2026 18:50:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] selftests/bpf: Don't include <linux/ptrace.h> in
 BPF
 progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179416380493.1666345.8032685838291433805.git-patchwork-notify@kernel.org>
Date: Sun, 08 Nov 2026 18:50:04 +0000
References: <20261108163710.1881321-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261108163710.1881321-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  8 Nov 2026 16:37:10 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> BPF CI cannot build the selftests on aarch64 since its image has new
> kernel headers:
> 
>   CLNG-BPF [test_progs] freplace_attach_probe.bpf.o
>   In file included from progs/freplace_attach_probe.c:4:
>   In file included from /usr/include/linux/ptrace.h:188:
>   /usr/include/aarch64-linux-gnu/asm/ptrace.h:96:2: error: unknown type name '__u128'
>      96 |         __u128          vregs[32];
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Don't include <linux/ptrace.h> in BPF progs
    https://git.kernel.org/bpf/bpf-next/c/a0a0c785cbca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


