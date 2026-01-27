Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBA3624CA
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533812; cv=none; b=Zcq4NV+kgSlI6dlYauOnjyj60M2MwYi8cWWjvbxe8/JvjA9D5CXi5gFr9M1olfBeLSCQxpfNnquZZQR3WwauU6dZuEkwqatLBjRneu/0Il9hn+7X0ZoVkCPRzyAsGDMcqDSA6EpWp4V9ON41Z48Wu1yt3zbJ1V/rBE28FMnI9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533812; c=relaxed/simple;
	bh=+9pcbos8Bo8QN7vKTs8K3I3dKd1VPnLvNKqd0/e25Fk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=baFONkl6OAjKzkULwBLZPLHylczZm8epWl8ei3dYcIyCCGHvCTAmr2+5Ajx94NOU2tea4BdEXhKE0xAGKYPpWTyJVwjM/R5oR2VIII6ccOy1oBoM92gwMjz+vNWgOwr7UEQUNuq4AmIUVQlw2wxJeL+w38a2JOB2h+spN6Of5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz6oCPCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz6oCPCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AF2C116C6;
	Tue, 27 Jan 2026 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769533812;
	bh=+9pcbos8Bo8QN7vKTs8K3I3dKd1VPnLvNKqd0/e25Fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uz6oCPCqZy8nKjxhKEvNSoHL0tw2LelgLNiXs3gFoMMFdYVsZ32HPe6Hqs9VCL1Px
	 nvXmOwtBY5nvj2aqNg/UvxuyJhLoIT2XvftC668JreXMtWhyhf3IQsVDSRzp6lPDDR
	 fFzRAhPCUs0NwvctVjQrhrv12X4hLcudx1kVEBDrue2IWaA9GSkJnsbqz4m0h7Rqaj
	 rTh6jlb6E1X8Y5WfEpwsID5USc5dNN1T+7xa9vlpVJo4jaDgPmY2pXA0/F8w5HplmN
	 zYClI38X7dViUIJQ25bb8j3f32V8ProUSTANTI/qWwz10tuo6lG5MkOWS7iw1swRy7
	 Z1pSEWMLFnYRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBFD380AA58;
	Tue, 27 Jan 2026 17:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN
 control
 option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176953380636.941142.15593390985177857041.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 17:10:06 +0000
References: <20260127085112.3608687-1-mattbobrowski@google.com>
In-Reply-To: <20260127085112.3608687-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, roman.gushchin@linux.dev,
 zhouchuyi@bytedance.com, tj@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 27 Jan 2026 08:51:10 +0000 you wrote:
> Currently, the BPF cgroup iterator supports walking descendants in
> either pre-order (BPF_CGROUP_ITER_DESCENDANTS_PRE) or post-order
> (BPF_CGROUP_ITER_DESCENDANTS_POST). These modes perform an exhaustive
> depth-first search (DFS) of the hierarchy. In scenarios where a BPF
> program may need to inspect only the direct children of a given parent
> cgroup, a full DFS is unnecessarily expensive.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN control option
    https://git.kernel.org/bpf/bpf-next/c/752b807028e6
  - [bpf-next,v2,2/2] bpf/selftests: cover BPF_CGROUP_ITER_CHILDREN control option
    https://git.kernel.org/bpf/bpf-next/c/1456ebb291dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


