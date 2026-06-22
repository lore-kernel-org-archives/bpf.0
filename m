Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4233F584;
	Mon, 22 Jun 2026 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162620; cv=none; b=HPo4Ntk74wzpplWFDI342zeliR4B94+BnkmZIQ2sKVlhMyVt2I+wy+l3drJ8mgyjmhw0o5w7UwqvUcK2+kRDGvpcbHGwpS9pdUe+SlB67q/OuYS4s3yEa1kzqRA640fhiKLy3InOGuIyh75+LMabE0l/DaIsjHWe4RDC2mDZ5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162620; c=relaxed/simple;
	bh=HcFegEhVNR+E/ge+9AuFbSNyakCe+Pr5Llhx7lvqHMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qHMoHrj06kWtkprwtN1V41HEaTi4uFO1zlUX8XU2FdDaJHKfVMQyT2vqEcdS5D/dMWyKOLMrdGrefW3V0GM7MZ5oOkztCNxqg1h9cS/mzDri1LjkeLX1deznlf19+O9cmE0nVf/g0f67Y2zwfYEozkR7P9+5dQUjKIVhiupUV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAhsrSIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAhsrSIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F8D1F000E9;
	Mon, 22 Jun 2026 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782162619;
	bh=CNPeUApeajVrZo0HmkpSj/ccXFYjrNTsb2OxaAG9zgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UAhsrSIR/NjnATlEpvagIBTTCzfia2tf23hWlpdFghy9f1CuTasXcBjruC34UsML7
	 62vUTLpqxcsBxDVRUlVSvtpH4buzEKW7eKz5s+QYT+K38bHRUWzOoRDWiAO9F3ZvVT
	 ZpJbJylEdju+Cuy70UWxDtyEo4x0R4OToLK1SQfrtesv0/u4qnJl9wT2FSGDMsytai
	 0LRl598aMjj7zPSh8zUu/ZSagzvoeG/nZhxhTImCDfJ40wfxQmtaURSghWx1K3zKdi
	 oW47MA+Zofh4TAVvZUeOyt4F5R7h9ypWOuGXylcy2gl5PU80yS7MIspyMoWtvoz3Qe
	 mSJXGqXTjF+uQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19E3F3930922;
	Mon, 22 Jun 2026 21:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Preserve pointer spill metadata
 during half-slot cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178216260973.1421185.11806680434807271549.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 21:10:09 +0000
References: 
 <20260617-f01-06-half-slot-pointer-spill-v2-1-42b9cdc3cf64@mails.tsinghua.edu.cn>
In-Reply-To: 
 <20260617-f01-06-half-slot-pointer-spill-v2-1-42b9cdc3cf64@mails.tsinghua.edu.cn>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 17 Jun 2026 23:20:20 +0800 you wrote:
> __clean_func_state() cleans dead stack slots in 4-byte halves. When the
> high half of a STACK_SPILL slot is dead and the low half remains live,
> cleanup converts the live low half to STACK_MISC or STACK_ZERO and clears
> the saved spilled_ptr metadata.
> 
> That conversion is safe only for scalar spills. For a pointer spill, this
> metadata clear lets a later 32-bit fill from the still-live half avoid the
> normal non-scalar register-fill check and be treated as an ordinary scalar
> stack read.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Preserve pointer spill metadata during half-slot cleanup
    https://git.kernel.org/bpf/bpf/c/3a354149bcea
  - [bpf-next,v2,2/2] selftests/bpf: Cover half-slot cleanup of pointer spills
    https://git.kernel.org/bpf/bpf/c/8816d94303f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


