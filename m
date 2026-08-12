Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470447A882
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556462; cv=none; b=KGbil9daN1uo3/Ij4Q+7d/aDatKrAjmcIEChNhZB6wtaZvriA5fM0jEy+OpG9ueH8JCrg4/yIxeZVGZHtUOtkCHWlH7RQQZEBdW5eVre3mUssNovvStAxfphT3OfIqtpccZJSoPG4v4/QQ7/dX9VyRklqlAMxmc/JpjpS3WfOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556462; c=relaxed/simple;
	bh=tsY/zdxxPmF42smN4ZZ4umBldUwO/J1J6hw5HQHB43I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SzT3GacKOhCGIBObTZTsjOrL2LTmfNNGSFd2oeuOnHK7b7dJvyhLVAGdOnPwWQaakV/HVtW1UxpKVWZtgWZnKYm1jXyhoCZVj3xF8V67U2R0ucKmywjJPk1ym5YxyoGgoiUe0lebWJAO0weS8thQrPZveOWdkK5gMGSQxVvgJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6hQ0UUQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6hQ0UUQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EE71F00A3A;
	Wed, 12 Aug 2026 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786556460;
	bh=QiZtiXvkoPxUB1Zdf+lmVsZcv3zCX3H++XisgoJn0g4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m6hQ0UUQrn5HDNDpviwYr91mNNb7q1H4gl5ioiA4MiGnmEuCopI0IviO56usYF2wM
	 K0hzJrhfOI6ZbNQSFsJjLniT/KM+xgrY8ysyppgFBtTNxVIRnbj0ggAul8WAUz0MUl
	 AOYkn8cJuBMSxZnHhuZ9oIiRMraCE6TIpDN754E5gGyTMV2/kPEl8z86WMN1OlRqcg
	 lTc6oORmtPnBDpw9tNkYQw5RVhQ/x983MBCRfoRAJo04uLRi6riIUtD4B3NQnuCNrk
	 lY1iw7c/Yzmxrn9FHyYl6W0oHGTptAqW+stKH8t5eQi1HPbl6x0bFpVxkTx2jWmJg1
	 b2e0hN0mYjjPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1976E380AAD1;
	Wed, 12 Aug 2026 17:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Derive the atomic load register in
 one
 place
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178655641590.2027635.10078603120321203085.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 17:40:15 +0000
References: <20260811131600.506721-1-daniel@iogearbox.net>
In-Reply-To: <20260811131600.506721-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, eddyz87@gmail.com, puranjay@kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Tue, 11 Aug 2026 15:15:55 +0200 you wrote:
> check_atomic_rmw() open codes the mapping from a BPF_ATOMIC to the register
> it reads the old value into, the BPF_STX case of insn_def_regno() open codes
> the very same mapping a second time, the const folding and the liveness
> transfer functions a third and a fourth time, and BPF JITs need it as well
> to know which register a faulting BPF_PROBE_ATOMIC has to clear.
> 
> Add a small helper so that all of them can share it. No functional change.
> The BPF_LOAD_ACQ case is there for the JITs, which do walk all instruction
> classes. const_reg_xfer() loses its explicit BPF_ATOMIC mode test since the
> helper checks class and mode itself; the BPF_PROBE_ATOMIC it additionally
> accepts cannot be seen there as it is only set from bpf_do_misc_fixups(),
> that is, after const folding has run. arg_track_xfer() keeps its mode test
> since that also guards the stack clearing next to it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/6] bpf: Derive the atomic load register in one place
    https://git.kernel.org/bpf/bpf-next/c/41c5dbb4be3c
  - [bpf-next,v3,2/6] bpf, riscv: Clear fetch destination on faulting arena atomic
    https://git.kernel.org/bpf/bpf-next/c/1519f488e8ce
  - [bpf-next,v3,3/6] bpf, x86: Clear fetch destination on faulting arena atomic
    https://git.kernel.org/bpf/bpf-next/c/cf92a108601a
  - [bpf-next,v3,4/6] bpf, arm64: Clear fetch destination on faulting arena atomic
    https://git.kernel.org/bpf/bpf-next/c/ea3f20cb5918
  - [bpf-next,v3,5/6] bpf, s390: Clear fetch destination on faulting arena atomic
    https://git.kernel.org/bpf/bpf-next/c/cc3e12330599
  - [bpf-next,v3,6/6] selftests/bpf: Add arena fault tests for atomics with fetch
    https://git.kernel.org/bpf/bpf-next/c/611a9f0d3dca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


