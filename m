Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5F1552FD
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777080051; cv=none; b=DP/f3/NO+BsleL2sywQbZlsOXjBjQ+zZ631iCiUUtGu+A7Fw8HEwwJeVZivdWo40DJfdkkdurAfKcR12a6VVOWek/VtBhpn2SGkpUSywhDa7WCc5Gja4bwLwkhDLAcLjmoUCYSOePJ0O+2f11O1lswef1eNZmvPOD5FPK9HpdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777080051; c=relaxed/simple;
	bh=BgCy6Ciqv8ABbZBF1Q1TprXq48P0PClHHW+XyTykqjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YocWL8eufNu0moMoyHulrip9vALdggFeW6NHRGr3wc9Fx0vHF1X5KbzT6wLSAMPo1W99bi0RMy+Mc4vDTRcw0dJ8UPmAnuIZZNlDGvbRHu64TPgH2pYl5mEkHd0dbPzg1Ldr059ICtviVzrPXrYfDIWmabQ1mQiA/pq90BbO8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeRlx8zY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeRlx8zY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A39DC19425;
	Sat, 25 Apr 2026 01:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777080050;
	bh=BgCy6Ciqv8ABbZBF1Q1TprXq48P0PClHHW+XyTykqjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LeRlx8zY3ZHsCYi1cm7ull7wIVlNopKntIP1V1ffdYJ4D5n4IYxqyeqjAVn8ilW28
	 EE2WWcoPq/po+/vYyT+BKmpnSYMCSu6wmecYqgmk1XWgDiaI6mNGUUC5Hv+WkOG6XV
	 h8IOTmqEv/4n0O+sVCpZKO+5rV8ibmar+uaPe3YoVaw8gk0yQEGzjqX4Bp4/6NCn1X
	 bvrPswsf40n8E6NalibEtWDPrNLe5gXZhwO9D7Esznvi5O0Mlp/QTbXull6pMcjb62
	 htDbqci7RoQVCpfyY+mYC5RlG5YcJZ6OQiOSR/JynNKJr25YBH/Sp0CV4S8L3awC6U
	 Br6tyH57ptXbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BC238119C3;
	Sat, 25 Apr 2026 01:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] bpf: replace min/max fields with struct
 cnum{32,64}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177708001080.1784660.11845788937933158065.git-patchwork-notify@kernel.org>
Date: Sat, 25 Apr 2026 01:20:10 +0000
References: <20260424-cnums-everywhere-rfc-v1-v3-0-ca434b39a486@gmail.com>
In-Reply-To: <20260424-cnums-everywhere-rfc-v1-v3-0-ca434b39a486@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com,
 harishankar.vishwanathan@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 24 Apr 2026 15:52:41 -0700 you wrote:
> This RFC replaces s64, u64, s32, u32 scalar range domains tracked by
> verifier by a pair of circular numbers (cnums): one for 64-bit domain
> and another for 32-bit domain. Each cnum represents a range as a
> single arc on the circular number line, from which signed and unsigned
> bounds are derived on demand. See also wrapped intervals
> representation as in [1].
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] bpf: representation and basic operations on circular numbers
    https://git.kernel.org/bpf/bpf-next/c/256f0071f9b6
  - [bpf-next,v3,2/4] bpf: use accessor functions for bpf_reg_state min/max fields
    https://git.kernel.org/bpf/bpf-next/c/b93f7180f0bc
  - [bpf-next,v3,3/4] bpf: replace min/max fields with struct cnum{32,64}
    https://git.kernel.org/bpf/bpf-next/c/bbc631085503
  - [bpf-next,v3,4/4] selftests/bpf: new cases handled by 32->64 range refinements
    https://git.kernel.org/bpf/bpf-next/c/4c0710ab011e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


