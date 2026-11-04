Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793767209;
	b=el4CKBR89lAU9faNYs1tu6DetzM3iUTlLGzVyXWenac6Oclb5k1k79A1tcD4cQkxUJQH
	 IrvmLvP1emYBF5zU3l5+XHflfiS3lys9hOqnp3Mig+uPD+sMNqmFV+8Uz1yjE8tl32MpB
	 RzA5uYyuKy23I25/cA1sP8ut9eylJAIe76ZS2q51nKmmzck0fa1o7Fy753ntT1fEy59ue
	 3ReZNTCMMNAjczrdfle57ffDgdeTYYfdphPS7TiUoWhU6V0TIP2QoZmM2OlQ7BejfpH7v
	 4Sy1EY+U3VhOEWgJdk8roLQEBi2bfyfkm/2cA0QtNdy5KHd7w116YzXGqmjk8xNam/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=8C3dgyhGRRaYxDVXie8yz8SBp5A94FjWF4QtWUN21Ok=;
	b=o+Yklg+iheWQq6j9M9U8544Gkq57PRWvWzSSr6XOysCmoi41YQMqdlbX+7nwLv5NMs+N
	 YCRD5n+vwLkIREzkGJ7Vp4LslUxJZcoLd6ooOh48ygNxnZptu+gpFc+XL3XCBHgHCIJeT
	 RyCQbRj1bzsckU1DV/K1ALYfjbF4BMMej6/DR1Ol9E+nXxn43sLpzFrAIkcU4G+5/yZvF
	 40T5thhw70sN5adGoXOuJwAyi6lgVc22q0e4FXYt/+bKcWm2ipUlEEqVZt1Tp736dVl8f
	 0qOab0aGEtYLAdeSf3TL2n8VVsFm30RbJuRp01A105oWZmXJ0gUqxmgpz9B5dH0FgZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQ+fePjf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84960606A31B;
	Wed,  4 Nov 2026 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQ+fePjf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E82F1F000C1;
	Wed,  4 Nov 2026 04:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793767209;
	bh=8C3dgyhGRRaYxDVXie8yz8SBp5A94FjWF4QtWUN21Ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JQ+fePjfd8Iu9YEJF7qaPhfy7JPKUlRPGnUphE2LWjCk/I4Cg/1QhVqXdUf2rQCK2
	 gffvOkSaraF0Yn+yUSDLmbakk70z6mykLvPPjiMZ4Jjz2G4/iw5ooMG9bD/wJZV96V
	 PmXxGndF/LCz0RZJ02UpSipW6yLgzY9sBjoA7/whl/dvWO4QzMnwMe5s7kDqomUNrx
	 ZYs9buvB0oO9gvuIZ2TUh4XDiPtZtnk/gNQmFNAOiaEH4JSZxK2LnfFpuL5EKtfIaj
	 VlQwFpv+EbhVE/2xeg2WsLdVYw3M6kl1BhwLfRaRW8t6Lmv7MD38/Fng3xCk+pQdXC
	 8Lv6O+ygzqp/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0316639D0C34;
	Wed,  4 Nov 2026 04:40:09 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/4] bpf: Follow up on the patch list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179376720780.2078713.18261982623536309974.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 04:40:07 +0000
References: <20261102-bpf-patch-list-followups-v1-0-ddc8ccf40f43@gmail.com>
In-Reply-To: <20261102-bpf-patch-list-followups-v1-0-ddc8ccf40f43@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 02 Nov 2026 07:32:10 -0500 you wrote:
> Alexei listed what the patch list series [1] still needed when he
> applied it [2]. This series covers items 1, 2, 3 and 5 of that list:
> 
>   item  problem                                           patch
>   1     the tests break with bpf_jit_harden at 2          2
>   2     the out-of-range test ignores the insn number     3
>   3     the comments on the aux data rules are gone       1
>   5     no test has a second patch with a jump            4
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] bpf: Document the aux data rules of patched instructions
    https://git.kernel.org/bpf/bpf-next/c/0d7ee4f7f3e3
  - [bpf-next,2/4] selftests/bpf: Run the patch list tests with bpf_jit_harden off
    https://git.kernel.org/bpf/bpf-next/c/3ca415720347
  - [bpf-next,3/4] selftests/bpf: Match the insn number of the out-of-range message
    https://git.kernel.org/bpf/bpf-next/c/e4a0f58aca0b
  - [bpf-next,4/4] selftests/bpf: Cover a second patch with a jump behind a barrier
    https://git.kernel.org/bpf/bpf-next/c/169699e9ebf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


