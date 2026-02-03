Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796E221ABB9
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145215; cv=none; b=JApT/rD8fYhpIeHokrP6Cc/9UDPTbaCZ4WZwDm3jVuhAe/MZsqZ5UyVHCkJZi2GaSPBb8wpRuOgMrDKuLLCgOrRBTu40hTmE7/Ft51heioaKwNX+ew+rPuSFHAhM3rOwCjSQsbD0guYOKsTyzXGnhXAaCQmSTEdGWki4ZKML6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145215; c=relaxed/simple;
	bh=sMGKJG5rKxkW7gGZyh5wvSSNQCSNFs1DxEHUfFXdMLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U7mN4v91KA2uPpEpS7VLcYldm8Fuf7/URuDkeeohrP5eUYm/HE/ih5mJhYZ5Hufzh4NH5SncPDElBOzRB5EcMPr41DmHMaz7Xck5tygTc8FQZhXJk2V4lkRuu/YIxoKL4/aMTz493gN6geuBEndGfB9Wer8sG7X04IY6lzadMN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doNjpkPb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doNjpkPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB84EC116D0;
	Tue,  3 Feb 2026 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770145215;
	bh=sMGKJG5rKxkW7gGZyh5wvSSNQCSNFs1DxEHUfFXdMLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=doNjpkPbCbZg6O7E/es8+yzTBSIaxNCmmpyKSekOzm8VUEuSv0uoLuMlNt/0r1Ryv
	 Q/enWDDIo6ovZ81VDim/JjqbcEXC8brISTpc7ao/Wt//BUufHsm0ZZQ96MOy5ucnSO
	 fNSlXE0d+NLtgfBaH6xJGY3fjIUyOJDHoSDsM0v2G8iHoBYqNQOugzTzBV3nDxBsAr
	 rU5MeGI5WvVRmMeSWRyS+1BlJ1KX75YVyQiJfAYUK+CWglW98w6cWKT96NN9WiO54s
	 PgsSwZ/6PpWCYuOd+u1ySVbF3FmJAmMU++4iyfjoIuXPAKispHRRnalPILdkWTp4nY
	 N1e0xkrazMzqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90E4C3808200;
	Tue,  3 Feb 2026 19:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] bpf: Add bpf_stream_print_stack kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177014521113.1603915.14756525369374819853.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 19:00:11 +0000
References: <20260203180424.14057-1-emil@etsalapatis.com>
In-Reply-To: <20260203180424.14057-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@kernel.org,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Feb 2026 13:04:20 -0500 you wrote:
> Add a new bpf_stream_print_stack kfunc for printing a BPF program stack
> into a BPF stream. Update the verifier to allow the new kfunc to be
> called with BPF spinlocks held, along with bpf_stream_vprintk.
> 
> Patchset spun out of the larger libarena + ASAN patchset.
> (https://lore.kernel.org/bpf/20260127181610.86376-1-emil@etsalapatis.com/)
> 
> [...]

Here is the summary with links:
  - [v2,1/4] bpf: Add bpf_stream_print_stack stack dumping kfunc
    https://git.kernel.org/bpf/bpf-next/c/63328bb23f26
  - [v2,2/4] selftests/bpf: Add selftests for bpf_stream_print_stack
    https://git.kernel.org/bpf/bpf-next/c/954fa97e215e
  - [v2,3/4] bpf: Allow BPF stream kfuncs while holding a lock
    https://git.kernel.org/bpf/bpf-next/c/9ddfa24e1674
  - [v2,4/4] selftests/bpf: Add selftests for stream functions under lock
    https://git.kernel.org/bpf/bpf-next/c/4d99137eea48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


