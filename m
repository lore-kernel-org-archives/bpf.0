Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373D3D3CF8;
	Fri,  5 Jun 2026 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698621; cv=none; b=t3v3s8FUjDlh56cuU3K+YNtaAarpSX0Ne2EUBoI7NuIvPDvnsaTh6TYeXx8NKuiv4g46PCR5Mc/MF7mRtScJpCjk7UEeOJAZ2g9jC5sfNPIjJtUpwd2rkDmRqN/DsRAYnhLRW64PXJZo1rylsQ5yNmouYWD4mBic27IcykmN28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698621; c=relaxed/simple;
	bh=/lYMwPcXsR+2/afDRC2AERPA3E7ppRzKmGNnnlXuF3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FoPSY/uckr8vi/V84S23tg6hnt1sDgI8RqVUJDP/eMZ7BlJVM89QtRz+Zfx/dGeSmrX9qpzwaVOxGp7RYEXZFUEa1vyFTGSQctI1y4iATvpd+QT9HxERWii8sGengYXnKvaTdh1XGZlxUPjw674hVCZDW736lycXcaUoVec1Fos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C17zHcxJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C17zHcxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7A81F00893;
	Fri,  5 Jun 2026 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780698619;
	bh=k2evM8lg7461P8glitJFOWtpS9EOiM0mWqmyJIjtRdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C17zHcxJCl6mzSw4f0VPcgukFXi1nM4sfH8mEl8PtpgWGM8VaoOGCVwN5ZkCPPsDX
	 oACjE3HfFfYyJdPa+sFICMAO85u6Sr6LitMCTMEfdVDH2xArCWPNqRqevDWoLLRXWy
	 HV71lwAL/TxAlyAYspM12I6W6P+G+T5h5rY5aBBN+iQFk278iqItsoz5tSNf1f9irA
	 lOrfmZ8+YPWHCq0L8vkBAu+WGA91sL9YbwH+6ZrgvybYfxGZw2YMm1gmKDVqzDs4nq
	 xFC2yhn3SQMpNebhXSPaYFPvAgotggMQKCQe0dxtrB+PK8MLVaiFdSWqsds6L1e5dq
	 Dx7o2wSExzONA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568183930C04;
	Fri,  5 Jun 2026 22:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Check tail zero of bpf_map_info and
 bpf_prog_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178069861989.3943503.12161707984746673273.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 22:30:19 +0000
References: <20260605155249.20772-1-leon.hwang@linux.dev>
In-Reply-To: <20260605155249.20772-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 yuyanghuang@google.com, kpsingh@kernel.org, davemarchevsky@fb.com,
 sdf@fomichev.me, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Jun 2026 23:52:46 +0800 you wrote:
> Check the tail bytes of bpf_map_info and bpf_prog_info due to padding
> when getting map info and prog info via BPF_OBJ_GET_INFO_BY_FD, which
> was discussed in the thread
> "bpf: Check tail zero of bpf_common_attr using offsetofend" [1].
> 
> Links:
> [1] https://lore.kernel.org/bpf/20260518145446.6794-2-leon.hwang@linux.dev/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Check tail zero of bpf_map_info
    https://git.kernel.org/bpf/bpf-next/c/e2a49fdb1bee
  - [bpf-next,v3,2/3] bpf: Check tail zero of bpf_prog_info
    https://git.kernel.org/bpf/bpf-next/c/786be2b05980
  - [bpf-next,v3,3/3] selftests/bpf: Add tests to verify checking padding bytes for bpf_[map,prog]_info
    https://git.kernel.org/bpf/bpf-next/c/d47e67a487bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


