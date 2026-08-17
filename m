Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3012D877A;
	Mon, 17 Aug 2026 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947058; cv=none; b=OvJ4RMuUOsxQUvUyW8Ur9tWT2Mxmh9fk0GXeclDmoKA0r9QTbdkK9EGlGQBLqy8lCqpgds1XI0ZFVQDq1RCdyjDbPF83KoZYUNHfWe+mekl5ttuI7QO97NVoQDvHehAzKeNElFYGybRzY27Fr35npee7jjQH9HiPgVd/8/ZXHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947058; c=relaxed/simple;
	bh=z8Uw3Duh3X8qeTuHcYeMzC8JCMaVnutpbIRENeLUksg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pMaRsglkYasyVquWBvqunS/qGwBYBlDIaIdyWD8VnViOFc3z8K6syvJELMIAw8eiJ5addZcAkFoMCOvD6nMGqCBZ31Jygr19yUafXArBd8xakLnPh9fVngsgdc5FC+nMgG6ng32Iwvn4Bsqd3OydGaiPjomjl24oGGu/9q5jIy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFvo3u5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFvo3u5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9B61F000E9;
	Mon, 17 Aug 2026 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786947056;
	bh=KTNc8zlfPvo0IY7fy5eeSMyBAOXaauYiOrVU9hygqEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RFvo3u5qDmIkhLGNwTswnEE3ER4TxgBKSptLl55Uh1hPVzPxfjSUUk+BD3wePcz4x
	 rh82v09AWcNjDALTSpCUI/CmfTjc/UpAvlwaqdpuphrH315PiPwF5F3ipACbp89D/F
	 gkcSJZlYWCvPbhAOXGSDEcmkFXvacIf7DSKoJVxNVScvm/IKBu/uyixCKbSuwFCt/a
	 cpDHiLECL+fw6lHMgkmLg3BwuWC1H2FXbnwZgIFp1KMkdozkGazpwZnyBIPQpFX0YO
	 5Twza/LijCdbHzzTf4f+PunDvIQJ6oHSdyNbRcAC+CiNxVPHG0rjuvYnflp1ZM3wJe
	 Qru57LYaecHfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F03924FEE;
	Mon, 17 Aug 2026 06:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Reject mixed arena and ordinary
 atomic paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178694700889.956230.17270434718736434381.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 06:10:08 +0000
References: 
 <20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
In-Reply-To: 
 <20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Sun, 16 Aug 2026 10:56:32 +0000 you wrote:
> Atomic RMW instructions use a single aux pointer type to select their final
> instruction encoding. The verifier currently records that type only for
> PTR_TO_ARENA, allowing a second path with an ordinary pointer to reach the
> same instruction before fixups rewrite it to BPF_PROBE_ATOMIC.
> 
> Patch 1 records the destination type for every atomic RMW path so the existing
> pointer mismatch check rejects incompatible uses of one instruction.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Check pointer type for all atomic RMW paths
    https://git.kernel.org/bpf/bpf-next/c/4bc49ae344d6
  - [bpf-next,v2,2/2] selftests/bpf: Cover mixed arena and stack atomics
    https://git.kernel.org/bpf/bpf-next/c/5ab9fbeca8f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


