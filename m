Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E71DDC38;
	Sun,  6 Sep 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788705082; cv=none; b=JZ8aFdH+qafgVbhqGzCjP0Vq9N6i3ywt+c0c8/tzgaPIOYFUBDTruCrkIJ0+mqkDRNRrMEAnOt+u8GjG3kM9WBQc0NdYdkviDRMMhiLt49Ry+MmZx2ldJg+ioMX8NQ6F4whYdl4b5ELnEeWVrFwzqlAEkvlJ6VTgVSe2rgrmCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788705082; c=relaxed/simple;
	bh=BzWbu2+U/DEd/hSFzWAF6Vzz6t06QyVp25PH6QIXFWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ouB579YW77HyX/po+PtiFoLZGME6RnR2+Ppbjq7sok4dckfGWVRCmhPqp1F4m7mBDdsxlEp7eFGuD0isY17xXyhpvX+VHz5GjiaqIUy7e3Xb2Y1BGsAJ8uqer8+Irl3qGULKZMU3zaaJQcYrJiBMmnd32CZ0SHG7SdZiI6pKACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqYhMKZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqYhMKZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF641F00A3A;
	Sun,  6 Sep 2026 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788705080;
	bh=phI0pFUU/TbdwawklPiQe1XCuRfE6yBbtcnr3EzdFHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CqYhMKZKeD4ZYmsZULDapZBRn+eDyRt0PWZBhFrOvp9gaa3qIqGUYw3KcpIdNUaF/
	 NjaQWiVtizwgr7tmUdWWoj4N3SDS943FA2Z+Drp8Yw9PL42lTR+0l/vcF4ZLUmxmfT
	 niSTUPzbVDz3c+PF0Y0vFUqwZN3mz8/8VTsT4mOjStirxmRgvxF0x43lAFWNHRTtSG
	 ZlyLq9bBTvVNEKQ6yRiYpnODvYLu/ckXUANx7cTH2qgF1Uft5kPzEvNgfDRyq3a/EM
	 yLDB1+fch5xmC4RfYgf5qYgHxBCCuXAJ//nIuvK13Xtuy0Ym5LYaRF7yGAaSz6wdn8
	 PD6G/p+Exyn6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A9E39253F7;
	Sun,  6 Sep 2026 14:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] Add bpf stack arguments support for RV64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178870502013.1578634.1317677297595952017.git-patchwork-notify@kernel.org>
Date: Sun, 06 Sep 2026 14:30:20 +0000
References: <20260905085857.14143-1-pulehui@huaweicloud.com>
In-Reply-To: <20260905085857.14143-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, jiangfeng@kylinos.cn, bjorn@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, puranjay@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat,  5 Sep 2026 08:58:54 +0000 you wrote:
> Implement bpf_jit_supports_stack_args() on RV64 JIT to allow bpf
> subprogs and kfuncs to pass and receive more than 5 arguments.
> 
> Tested on riscv64 QEMU with LLVM main [1]; BPF-to-BPF and kfunc
> selftests pass.
> 
> [1] https://github.com/llvm/llvm-project/pull/189060
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] riscv, bpf: Remap BPF_REG_0 and RV_REG_TCC
    https://git.kernel.org/bpf/bpf-next/c/f80a09c486e7
  - [bpf-next,v5,2/3] riscv, bpf: Add BPF stack arguments support for RV64 JIT
    https://git.kernel.org/bpf/bpf-next/c/ba754185f902
  - [bpf-next,v5,3/3] selftests/bpf: Enable stack argument tests for RV64
    https://git.kernel.org/bpf/bpf-next/c/7687f1cbbaf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


