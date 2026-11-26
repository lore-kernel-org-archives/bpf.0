Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726811;
	b=IippqUbKy0K3+cyACZjPr4sicBE2PeD9wiP5NrbgvZuAJ8XM8Bg+vKwJbSOiK1ItjnNf
	 bw3FooxsCfX3+4l3lOAH9fPbx2ByPPg6jIQXdRa6zZ5EgBlP/lukAduVTwgPL6h9ZVGpp
	 tkoxbbllm2E7K1++P4KdQicZJe5HBN6SU5tCKkE+3FfLN6KnqHCEiSRZvSLD28700t93E
	 AGSnH1YJ8YCjdLxkWM8/NuGhvZnHLSCi/H3goWE0n6/ORtmjbr/8ONXXGDA0Y/avnEkyH
	 J80qt7aGIUg/yTaFkxAtidk8GQkva6Ew6m2wmaBw9BdXGo7mZi985Io3yxVGFSRIUcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726811;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=NoDfeyGoIklTM5RSCeaDwUrWwnDmdTAsi1A/C5VilLQ=;
	b=0Q5PwxxZbaEHBMcPblB5wYI2EDfbxzo8sELq89nMzauhiJ2mC7k06pqvzkued6xqo2iX
	 ttX1H628pVhWmzsBErKT6JtuC2yeustfmJHriWLT7QNwe+h4P95tKeB0Fbdf4/xZYmXgo
	 pmX9wCOQowVtkxKX3ijrpt3lheO+o5ltOJ9wYtoe03uRXz+b5AIP6Qj7gZ2/y6lRbQRTy
	 IW8FiEVL8nHXAy0mu+tBsImM1Z4bXptgEqr4xZxyejYJ7zrK9M1Vgw1/zKCLjiNMh/ucb
	 nn0rVfOAGmxSITR7eRDO+GUnltlgc5P8MME2oqRen/EG5Z6lb8scagvSnyGv/yB7OJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4uaAQBg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FDC606A685;
	Thu, 26 Nov 2026 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4uaAQBg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE5F1F0089C;
	Thu, 26 Nov 2026 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795726811;
	bh=NoDfeyGoIklTM5RSCeaDwUrWwnDmdTAsi1A/C5VilLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f4uaAQBgTi3dI3blYNcGL7fXhmNA9jU1odNDZ/we7aKrNBDO/wDhfhJFClrNN3YWz
	 psxQaGZweHSPC4q5rfRgMQH4yoCn+yzrZ/krKZ+/irz2PTjyYY0qG/l1nm4SuPkKdF
	 OnS6otpA2EYyf1Oy3oD4SMyWGIzAqfiVrFoaW9MQaiUk8NOdjeJC2WCo8FAWNxT5jt
	 nhb6d+X5Q/g4zIfppODf276LobVmCpiH1VcSdufEupaNe2b0ZH/1UOEfBdEDfATaLP
	 +o5OGnn2TQWKfsAlJ3iRVLfX3XCKdmTGITZfd0fzzb1D/FWbG5MEqyxxOZegO5xGPo
	 daH+/64lIF6gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34C0A3803326;
	Thu, 26 Nov 2026 21:00:11 +0000 (UTC)
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
Subject: Re: [PATCH v2] selftests/bpf: Fix kallsyms parsing with long Rust
 symbols
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179572680975.617567.11224872814677124875.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 21:00:09 +0000
References: <20261125-selftests-bpf-rust_sym-v2-1-6cf5cff663e6@marliere.net>
In-Reply-To: <20261125-selftests-bpf-rust_sym-v2-1-6cf5cff663e6@marliere.net>
To: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29_=3Cricardo=40marliere=2Enet?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Nov 2026 08:03:18 -0300 you wrote:
> load_kallsyms_local_common() reads /proc/kallsyms with a 256-byte line
> buffer and stops parsing at the first line sscanf() cannot handle. Since
> commit b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to
> 512"), symbols may be up to 511 characters, and on CONFIG_RUST=y kernels
> some mangled Rust symbols (e.g. drm_panic_qr helpers) overflow the buffer.
> fgets() splits such a line, the remainder fails to parse and every symbol
> after it is silently dropped.
> 
> [...]

Here is the summary with links:
  - [v2] selftests/bpf: Fix kallsyms parsing with long Rust symbols
    https://git.kernel.org/bpf/bpf-next/c/dc0049f3860a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


