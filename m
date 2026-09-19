Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E132B13E
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789845079; cv=none; b=er2iJOFZ2Q/kd7qTqbQqNUOaZSNJ269NLnU7C0csaEVCBHjapVYgTttd0+uXxRw2RzpHMOOOnXN+htNjYUW+I6LI/4iifvdqQuo+ktYUpQxmBe5+K+Bd0iY6p2gIlCR53VdydbsvFrWx3JXPZ0vEb26mDp5pn3TOINo72vfsyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789845079; c=relaxed/simple;
	bh=ORrMOnEXwiJk/HlHpPYMFy4WiMP36judxpk9MKu9BIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LZ/TqegT+MCsWo5nVw/fjHCfR2l/zAC2r3eezNVY09v7EceFveapqlQlVIXUPKS9cGESBDOeeRGVt/dej1dmAySM5UFCnJrJXli8FEd5Q5rkFtd562KesZAKvH4GsMpJ91jzip9NLBDMZSQsxL3fmM9mvMsC3MoPuPEr/44pfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOjPnmR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOjPnmR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DA21F000FF;
	Sat, 19 Sep 2026 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789845077;
	bh=9ol5Vu5YsJvDkWfV/I2dwE+pXfGpBdxD8aKNO2bM2ik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GOjPnmR+12wqLpYDZodMfv1tZFaJiNIpqQG5XLm1t/qsoag5VYn2Bx0rxEGQceo+S
	 NYRomQ7K6liytRrIeaFA73tH4pA8tmoFSnvW2Op/hui0jjszPdxxLUc+g5Mbj8Ziri
	 SuH/Ei4nurfbanvGjqCmyMsNoKxYTyhzMGRXiipAl3U1FD/ru/qB+ofdSzoPDCASxG
	 F7S9/BIdycbmBM7QHJJCSsERFCebm4vuYehJDMR8uAa74s4sPUsRhfg27vqXrqky5o
	 2VMLq/3I0Kz4mJ0VEJvRuGtPQlSFEU7jn9N0W/GBRHgGrakAoJv9PSRY4DeLU61YHf
	 FR0XuyR2o27vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A7B392447A;
	Sat, 19 Sep 2026 19:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/8] BPF LSM xattrs at inode creation support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178984501015.1442212.3395320981643068842.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 19:10:10 +0000
References: <20260915150739.284189-1-daniel@iogearbox.net>
In-Reply-To: <20260915150739.284189-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, brauner@kernel.org, dwindsor@gmail.com,
 john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org,
 matt@bobrowski.net, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 15 Sep 2026 17:07:31 +0200 you wrote:
> Many in-kernel LSMs store security labels in extended file system attributes
> (xattrs). For these LSMs, atomic labeling during inode creation is critical:
> If the inode becomes accessible before its xattr is set, it is briefly
> unlabeled, which can disrupt LSMs making policy decisions based on file
> labels. Existing LSMs solve this by setting xattrs in the inode_init_security
> hook, which runs before the inode becomes accessible. BPF LSM programs
> currently lack this capability, and this series addresses this gap along
> with BPF selftests. Thanks!
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/8] ocfs2: Copy the xattr name in ocfs2_initxattrs
    (no matching commit)
  - [bpf-next,2/8] bpf, lsm: Reject writes into the BPF LSM program context
    https://git.kernel.org/bpf/bpf-next/c/c42da1d3ba9d
  - [bpf-next,3/8] bpf: Support passing context output arguments to kfuncs
    https://git.kernel.org/bpf/bpf-next/c/806fc431e0a3
  - [bpf-next,4/8] bpf, lsm: Let BPF LSM provide xattrs at inode creation
    https://git.kernel.org/bpf/bpf-next/c/ff0d1c0915d1
  - [bpf-next,5/8] bpf, lsm: Mark the BPF LSM hook overrides noinline
    https://git.kernel.org/bpf/bpf-next/c/3479e396eef4
  - [bpf-next,6/8] selftests/bpf: Test that the BPF LSM context is read-only
    https://git.kernel.org/bpf/bpf-next/c/e5d960cfe1d3
  - [bpf-next,7/8] selftests/bpf: Add verifier tests for the __ctx_out plumbing
    https://git.kernel.org/bpf/bpf-next/c/2757e9e53900
  - [bpf-next,8/8] selftests/bpf: Add tests for BPF LSM inode init labelling
    https://git.kernel.org/bpf/bpf-next/c/90dd01b6c1f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


