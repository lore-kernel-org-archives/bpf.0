Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760411;
	b=nukiH/LNhe8xKhhAvn+WaCGQWDXIYxgoGTQrRVvUvmB5Mto1aZoqDZah+oMFPzVOBIpX
	 xfRW/bhtT7R08JBkAEtM0zDxQ/sbwV0/DTgMRkpVAuUPBneM/gg3CQFwIdBAkt7yEWgti
	 w5tvU+K1a5AkHDW004CbXgMCwERjGFaqX/P4fffZuTeJXXVJTkpAX6as+53IWL4sFkwkh
	 0303JFoYCcNSVWKvAaFAdBCMJMnZtcYyChhcV97QooMERjODxngoC8aWbQarvf2fPxlqc
	 AKc4Ga16nsszNfCmrezEe//7w/WaiWPKQeUiLYxM1ho4DqIXzhYzLnitXahyWKVJ9Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PcfCubSNUxJgEf/1hhF244cDfFf6tJ8Nkez42tmLWWM=;
	b=j39D1Su5NjJNw6YCxuErHR/+Gne7vOq59uH2ikm94y9hyFL809JXZCYvZrzpWh9RPLcF
	 OmCaRCZ5Oq8goarEVLMCSUlUk4TZIAcD6vmsV6FiO71AuhNDaI10fyWUcjCMDg7IGZUZt
	 Pf8KDlh953OQThnz+n7mYYOj8+ARKPBTt/e17zoVadmirAbWU9M3DOWMiRN5vyWBRvhdM
	 Rz6I3ULP/jKs/hSb22Aoo+4jigRQ0edI8iIIMqA9L8naJZ3t8BrA4sNLtfSJCi+5m/WLo
	 nb9sghywkuCPuxQxckT4TG13LTgTBh30v+QJs+LdAyCCKZ4Gri8SN4lbjTsAtcGkSDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAE24rwW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34853606A326
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAE24rwW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795171F00893;
	Fri, 27 Nov 2026 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795760410;
	bh=PcfCubSNUxJgEf/1hhF244cDfFf6tJ8Nkez42tmLWWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aAE24rwWZkpSIa/8Fj4QTmr08jBgG4A1EuhyOwCBKtx+jtqBMY72sD0AoMwrXEhZT
	 SFXvIe4Y1oJt20lUb6gtp8VZ1iRodf9OgMAa/7BBA9ja/oUdvm6L46kyBwMh4MN7BA
	 /c8f9k9Kx+ClWvVb9DgBInUe376vsBVzBgy4fMHg6ZHBuXDqnggRpYumC7NGRIn0pH
	 FWOlrPV8SLAKZRkZz5tG9oz6BWaWxJGq/hnbZFQStuDeOSPDSeDAN01+H/FbYP11kR
	 4aT3CvaKBPuS6pN/H9j2KEup2mo2q80dNLRvFFhAzSjR5JyiPv3AAz8xqhlqqa9MgH
	 ufewUXmDsAJzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717A53803232;
	Fri, 27 Nov 2026 06:20:10 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/4] bpf: Fixes for calls,
 struct_ops and bpf_throw()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179576040899.781390.13687454584482283022.git-patchwork-notify@kernel.org>
Date: Fri, 27 Nov 2026 06:20:08 +0000
References: <20261126030342.4013902-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261126030342.4013902-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Nov 2026 03:03:38 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> These patches fix bugs in the verifier. Each refuses what was allowed:
> 
>   patch  refused now
>   -----  ------------------------------------------------------------------
>   1      a stack that is over the limit with outgoing stack arguments
>   2      recursion without CAP_PERFMON
>   3      a reference that the caller of a struct_ops prog does not take
>   4      fexit and fsession on a subprog that throws
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] bpf: Count outgoing stack arguments in the combined stack size
    https://git.kernel.org/bpf/bpf-next/c/84b738acee7b
  - [bpf-next,2/4] bpf: Require CAP_PERFMON for recursion
    https://git.kernel.org/bpf/bpf-next/c/0d6bb3033868
  - [bpf-next,3/4] bpf: Fix reference leaks in struct_ops programs
    https://git.kernel.org/bpf/bpf-next/c/163a692345e5
  - [bpf-next,4/4] bpf: Allow only fentry on a subprog that can throw
    https://git.kernel.org/bpf/bpf-next/c/e16e7782115d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


