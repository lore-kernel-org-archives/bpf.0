Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285F38E130;
	Thu, 26 Feb 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134215; cv=none; b=MggJ/DTXMbcctZnNNnOiv7LdxW6F1yE76k9gdWiB1Xw5ePT6ARTphJXIlCnhEKYydpoap1GgST7NDjzj9EXk9qHtj6GqjJy0xvAxhsJCltzARs2AiXfHTCLJUknpoANzH00BafeS4OU3Dnbat6/6nJhTiK7/8Wk9nYF/3mmgAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134215; c=relaxed/simple;
	bh=0G8qPDzKVsdPsC890ZJhECY9NPwV1vP0d0SMSHyL+0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j7PyE+ZAoHrB+brITd6Gr89TVUS/ASOGs7QT1dIImzPlPV1LrgvmgO1Rq7WfIT+WfIDby+WBuW17DHtNthxOGxxILrSIKYlY02VAK5oq/u3fUhneFd3VNM5ZV6skzg60xEDUflaBhPef3H7HdQILlECdW+H38646WKDs4yDCqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTX7g73A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTX7g73A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B268C116C6;
	Thu, 26 Feb 2026 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772134215;
	bh=0G8qPDzKVsdPsC890ZJhECY9NPwV1vP0d0SMSHyL+0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jTX7g73A4+N56R2BHzV0jM7WboiGHSUWY8s5TGOA3BsWlDmDc2EgIiEU3oogwsy7O
	 KhnMF5JNdDkAbszu4lDnXkza7kEPxt/9+Jkrq07LcJCPrp73EqQj/rxKAWtPv2+BhK
	 6IpSNU/HbUGyBR85Vxy6YWvg+03Zd4AGerH9kUtjZaZA5kd+PNm94/R7zlaRIwY6OY
	 YnnwDJaFiHEXN21PPE5UrUsIV4lAd74kAB5Yyd3bUucpSAIewEjVjAYQZWf+q4U+w/
	 M+du33p55g1RHoIMrnSasWUkVPlCOQWwXiTiFWqWp+T5j1R/Nta61LVzC0eITczhCq
	 2qEdJn3SbHReg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D333931090;
	Thu, 26 Feb 2026 19:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] arm64: bpf: Force 8-byte alignment for JIT buffer to
 prevent atomic tearing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177213421954.1808439.8748044844634571383.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 19:30:19 +0000
References: <20260226075525.233321-1-tabba@google.com>
In-Reply-To: <20260226075525.233321-1-tabba@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 puranjay@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 xukuohai@huaweicloud.com, jakub@cloudflare.com, jpb@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Feb 2026 07:55:25 +0000 you wrote:
> struct bpf_plt contains a u64 target field. Currently, the BPF JIT
> allocator requests an alignment of 4 bytes (sizeof(u32)) for the JIT
> buffer.
> 
> Because the base address of the JIT buffer can be 4-byte aligned (e.g.,
> ending in 0x4 or 0xc), the relative padding logic in build_plt() fails
> to ensure that target lands on an 8-byte boundary.
> 
> [...]

Here is the summary with links:
  - [v3] arm64: bpf: Force 8-byte alignment for JIT buffer to prevent atomic tearing
    https://git.kernel.org/bpf/bpf/c/ef06fd16d487

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


