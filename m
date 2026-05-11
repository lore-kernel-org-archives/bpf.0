Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CFE406273
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514063; cv=none; b=rNfBbc1boD3Bena/tikyboHF7wUM5ODID9hfSk5O9rXs57T+0leK5Auis0MhOHXqB104CFO0MdaqAv6zApIP+sjqamlBNpsTJwPTxOM0ercAbhkR3D3XujRuFEW7ilRtC9nxS8/y57hX+P5SqmlA5yTMtJ5rbd7l/yjaGzudjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514063; c=relaxed/simple;
	bh=JDqSfGJkZxGbxPvKCPooa6jHPSSrGbTwXaM1tjnk6Fk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iJHIuwcEJNklSp1rB8BY31w4+NU4TGPU2+a7/AUnNUQQhUjPSnYmgCSCvjJo4uBrqsDSB4b+uySYuyfGBQpG+ZL79iyYv5iUXrmiymzYweh9OKyEsXcdWHrSv7zRmB56LkvC1fRYA/pyT7a7YsJwaF9FaloL9ewdTMvz80jWCFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv9bR2A0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv9bR2A0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAECC2BCC9;
	Mon, 11 May 2026 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778514062;
	bh=JDqSfGJkZxGbxPvKCPooa6jHPSSrGbTwXaM1tjnk6Fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jv9bR2A0uQSgyDDVyrul+uusFR1Dn49olVreFWAGORRN+BRcckuM324putqBXM+/2
	 mQzIPrlrkpwj2rZzWJxzGXEFrEV1aHxyjVg5W89p3HVHrBcprgowb4EiC2p/+m2EaS
	 ZqB4lPKr7Rw7aEfmxrlUAv+tBJAHTmnFOlhyghl3GVa3YXNqCxeX7JLhV80GFR0wgE
	 JEWQzUkdJ/8cf2zqA278IRM2lXQ6nggUvvdMNyMKdFlAnQDsEufSfdoTZWDl2OtbgU
	 WAhgHKVWq2HXRztaEfsmO/ND4AeOEv7gA8pvNvDS5D72jCECVkBShKqteTBs+NKxEB
	 RjG7A/Uay/FCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE7839302E8;
	Mon, 11 May 2026 15:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v10 0/3] bpf: Fix call offset truncation and OOB
 read
 in bpf_patch_call_args()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177851400930.2299654.13767981329926141065.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 15:40:09 +0000
References: <20260506094714.419842-1-tangyazhou@zju.edu.cn>
In-Reply-To: <20260506094714.419842-1-tangyazhou@zju.edu.cn>
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com,
 emil@etsalapatis.com, puranjay@kernel.org, xukuohai@huaweicloud.com,
 qmo@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  6 May 2026 17:47:11 +0800 you wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
> 
> This patchset addresses a silent truncation bug in the BPF verifier that
> occurs when a bpf-to-bpf call involves a massive relative jump offset.
> Additionally, it fixes a pre-existing out-of-bounds (OOB) read issue
> in the interpreter fallback path.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v10,1/3] bpf: Fix out-of-bounds read in bpf_patch_call_args()
    https://git.kernel.org/bpf/bpf/c/4314a44564eb
  - [bpf-next,v10,2/3] bpf: Fix s16 truncation for large bpf-to-bpf call offsets
    https://git.kernel.org/bpf/bpf/c/58a8f3e2501d
  - [bpf-next,v10,3/3] selftests/bpf: Add test for large offset bpf-to-bpf call
    https://git.kernel.org/bpf/bpf/c/344a00712ce1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


