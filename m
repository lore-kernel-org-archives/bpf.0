Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9DF3F58E1;
	Fri, 26 Jun 2026 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476892; cv=none; b=aa2VqVgIsaznv5U0e4y5o+gzICjM+W9wa5Tg59KbqkYCpmG7eOBFLsi7Jsg4oRflYpIBAqd44rGEP8Ma6mAiCJAna1oMWByVL48sGnLPR+CtGEHTy5q4jr4w1fYwu3JlF8vEFJ/iItrJBDOJiibqN3vWojjexAnpBC/ojwC97mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476892; c=relaxed/simple;
	bh=UZvrNTC8xklzGDiWjn33bmvbqZk9LxvsG8vJIRO0nJI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YsnrqIZvqbZR37DAuSh2EoFyqS5ra19kf87uNWwpRhhA8KD+u769AAmXSwmK63eDDnMke1Dp9H3GS2V2jXNDQNp0M3MVWOWVLGFu7IvRG4jv358GlVZ/oIb2JgPpYCgNpNsgegksGkTOJTW4d1nbB+rxNXT9pvjoytitdpx7cbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqaifbfW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqaifbfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53551F000E9;
	Fri, 26 Jun 2026 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782476890;
	bh=NlXBKO7KHUQ+JjTeZUzwciQkKAjy936npcCI4XeBe2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AqaifbfWaitjxX00p3BoBnmeoCJ6DjpzxD3me3wgYyt7JUyWfACJBOsHQKmZVfWdP
	 v6jaZuqWyFEpxpZOgbTMTHusY68HNxz/KwLmxhJvQUd+HNpMAx8SNTaMkwxFaS4Qa8
	 r11nSrZCXiqJlypfhgrAq0P2yxMaJp0tHUKN3eY36IARzBWNlWqNRR7GUhOGCNvbED
	 E2/EHHe9/A2i/D5yRYeF02IkREgUJdm7BiKtcR2ZWb0vu44eprC5vYlSNEx9ry592b
	 JddXn1uBpY4T4OY7dkbmUun/p4ElTtNMBcyfGUanYd2RSyRIPIRlQppwkkxLU4v26g
	 TKsSf0YVCdSDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0FBE39389F8;
	Fri, 26 Jun 2026 12:27:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf: Reject offset refcount acquire
 arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178247687731.457674.9945546096682680522.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 12:27:57 +0000
References: <cover.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <cover.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org, vmalik@redhat.com,
 leon.hwang@linux.dev, davemarchevsky@fb.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Jun 2026 06:11:08 +0000 you wrote:
> bpf_refcount_acquire() is modeled as returning a refcounted allocation
> base, but it currently accepts PTR_TO_BTF_ID | MEM_ALLOC arguments whose
> offset already points at an embedded graph node returned from a list or
> rbtree operation.
> 
> At runtime the kfunc starts from the supplied pointer and adds the type's
> refcount offset. With a graph-node pointer, that starts from base +
> node_off, while the verifier treats the returned pointer as the allocation
> base. Reject non-zero fixed-offset arguments to keep the runtime operation
> and the verifier model aligned.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Reject offset refcount acquire arguments
    https://git.kernel.org/bpf/bpf/c/931a577fc79e
  - [bpf-next,v4,2/2] selftests/bpf: Cover refcount acquire node offsets
    https://git.kernel.org/bpf/bpf/c/0371fb57a0c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


