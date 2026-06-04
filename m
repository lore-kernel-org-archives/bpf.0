Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69148AE0D
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591815; cv=none; b=jx/WDI3kADqWiCzy+UObVkubzYpRGAjXNhT31Xs5J/HbHZkR+iryfaWDEVafFulMXv+NFYoDOWIA+VgShHxEoagFyprcvUxceBGsoFIGp7E464IWVEkU5jELirGHTe1le8lHbKFBRyyE8KdMIfzSFJLNT79pzW445F92yCrPw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591815; c=relaxed/simple;
	bh=kkvo6MhlSHk+ISGzKuhp97T1TJwz7sd6nO/4fapoPis=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GjD/1W1YFaVSTxKoTIZuvRCWEUNNMBih5BoF7VNMNSd+Txt9/eQNX7d509UxBZrJs66drcI6w8xpWsMtEXEUh7v+k+RXn2fgLpfFam+MtFkN1dOzELYCnTcqA8uaPBA0GpePYXC4Nd3NYv7PhuqFabk3uqaV0KOfek2np/43zIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFuufTDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFuufTDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC1F1F00898;
	Thu,  4 Jun 2026 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780591813;
	bh=kUNGi2Zw15RLfVqGKK6LtPLijYUkAlPnOzC9+rmReLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fFuufTDBTM8zbmKXz7kA9I8Xm8JQRbgJOlSH5GLWxWn5R9NRKdGR5gO+ek0zV5ZaG
	 jbYR8ppp3naMHBauCyHAgAiVT7IwbKZ49TrBmoAF26BK5UZAKxHUg1D3g+oAH7kfjp
	 muQECnsSt7CTxoXAkRMO0tXNo5gj4EliOqFbvwuDWuYb11i8poYOFQkQsJhfI/xW0u
	 IOkeAJxE7T70Aa1yMOrkVtCNYunO+7gGlH5erfHBWHxiXIuCah2Bq8OuXlGyVBcGqX
	 u5PlIrot/M+YeJ+c9O/NpUC5aZNp2Xd5w2s+iVvHIiMxmXbbpW2oF1u2yToiFMqW4B
	 7K8aJojoKbCAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568423930A0F;
	Thu,  4 Jun 2026 16:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: clean up btf_scan_decl_tags()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178059181389.2942053.6754189044046675501.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:50:13 +0000
References: <20260603201822.770596-1-mattbobrowski@google.com>
In-Reply-To: <20260603201822.770596-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  3 Jun 2026 20:18:22 +0000 you wrote:
> Refactor the newly introduced btf_scan_decl_tags() to improve
> readability and maintainability. The current implementation uses a
> manual if-else chain and a magic number offset to strip the "arg:"
> prefix from declaration tags.
> 
> Replace the if-else logic with a table-driven approach using a static
> const array. This separates the tag data from the scanning logic, making
> the helper more extensible for future tags. Additionally, replace the
> magic number '4' with a sizeof-based calculation on the prefix string to
> ensure the offset remains synchronized with the search key.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: clean up btf_scan_decl_tags()
    https://git.kernel.org/bpf/bpf-next/c/fbd6dc50d9ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


