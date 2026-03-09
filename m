Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184438F255
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074412; cv=none; b=bHDrMOSJGc6uizLOk2XJJsTb7Bl8GYJT8yP1pkF/r4muhkIlgmqNdbB/GT28zXO/A7li2ZtfztuZ8Z6ycJZHJFjj7AHug3lqmVtvU5rGb7Y69JNNz9mEKCo47wRVn18A2KheETqx7T6xtsHdz6wE7NbuDDRlNfTOBG3Wg9MKsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074412; c=relaxed/simple;
	bh=v+ZxqTvptCd2qmaMOzq9ZpVkAQtfJWqrrTNkV/EIsUI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LAvJk7fuZ3PcT6aARKaNWGKQvk7OJLlqOFOn9U6N2mdNJw6BWnA9D5rIUSQd3izCnrLnsEech232UrRce0g2sng76TJ3ezlXnxHPpaWCHha9MreaBXkR2n027tMfRQEEoDHxtRvodwakPWMKCLmPHzbQSk9jrj7h824wV1nvEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVM02r7P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVM02r7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326B4C4CEF7;
	Mon,  9 Mar 2026 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773074412;
	bh=v+ZxqTvptCd2qmaMOzq9ZpVkAQtfJWqrrTNkV/EIsUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nVM02r7PZnSlFYvlRbZMqyT4Kk9NNCV7Ex9VThAEyEZffXQGCLD5zXlaEWFE3Vo1w
	 w3i/dIq8GYGxc4zwvj6Ndf91YfJfrlFEhN8usyhl8z/jfU7EP+8bguQBguRbFudcwU
	 TX8Y1Hhe0e+V+BcdsVl28BGuzQbAiwiO3WfCS0CQ8lrfS39twASK9MIS/AgIEDHnQ4
	 reOZF6STUuSJdd7lLSBP32XtYYJ2irJoAkf0xid1E296YLVsBmSApXp+t1oP2gKIEQ
	 dB33eYFgcB8m9GkoMQueprYSplQJ8ZFBuMw3/XAlUDyKcKeoyUh1cgeC99cepWMEek
	 sIdEq7KNMO/qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F4D3808200;
	Mon,  9 Mar 2026 16:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] Always allow sleepable and fmod_ret
 programs
 on syscalls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177307440955.1304519.617035769418322296.git-patchwork-notify@kernel.org>
Date: Mon, 09 Mar 2026 16:40:09 +0000
References: <cover.1773055375.git.vmalik@redhat.com>
In-Reply-To: <cover.1773055375.git.vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 shuah@kernel.org, leon.hwang@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  9 Mar 2026 12:23:55 +0100 you wrote:
> Both sleepable and fmod_ret programs are only allowed on selected
> functions. For convenience, the error injection list was originally
> used.
> 
> When error injection is disabled, that list is empty and sleepable
> tracing programs, as well as fmod_ret programs, are effectively
> unavailable.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Always allow sleepable programs on syscalls
    https://git.kernel.org/bpf/bpf-next/c/16d9c5660692
  - [bpf-next,v3,2/3] bpf: Always allow fmod_ret programs on syscalls
    https://git.kernel.org/bpf/bpf-next/c/20c2e102a2f3
  - [bpf-next,v3,3/3] selftests/bpf: Move sleepable refcounted_kptr tests to syscalls
    https://git.kernel.org/bpf/bpf-next/c/fcec7c66d681

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


