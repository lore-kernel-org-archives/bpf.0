Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070525B090;
	Sat, 19 Sep 2026 05:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789796479; cv=none; b=n4mEE0+7x+U253QX1J8kSWa+emhi1z0SkZzmKLBoG2Rvi38uyVZLF31xBHl38i5YmvmiHtRk4gce4QbTU9OSGk6x64EEl9NWJ3zreYOxOA1n24RYcnNrpnrYqRLUham+N2TqLtHyfslLR56SMybgsXwGAJzEdZyejKlztB++dVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789796479; c=relaxed/simple;
	bh=PL/D+o+ZESzAdUsIYaJLQtexbMp3AjWc6YEvF6S2s5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U6xvUgAzAY3CYQZMFkDZ/bNZkXHrzX2MgT93YpNlScjCZmaVKdiD8VPflNOxjZvBn6Da9CCGXItfNPtxGHxufuKGMhZYJvthEFz2MxH8ipsc2gAV5tGsQZGQooiYp+e/RTqXq9zRhSsS7XW/Le0BkidBCQF/Kd5KejHeQjusEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK87OeS1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK87OeS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898421F000FF;
	Sat, 19 Sep 2026 05:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789796477;
	bh=bjZmcNI5FA7SBAJaHY0Qr8fU0zq6hfuv3Cg60N7CNgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gK87OeS1RUggbbzZc2Jkz4vZLAKBi0iTBNwGQcRnHv3/5vT4Ymt9WPxJbYxfpaQDN
	 h/3/DfsaZHdOHub02OanVF4c5Q50qevNNUhHdAopP7npqmxF6ssCl9Behg/vDvX93h
	 ysItBqRRUBB5R1g8KQD0JOyQm0tUlWDYvFfX/dh4FG51CdtfSaXkVWRLPBatFtZs/k
	 5g7JX5D5Cj5KJKsvONsTMe8j6kXy7/EEGsgNXkACeczY2olHMVtjUwLTjJYima37Qv
	 9WdZUoNt4255DLQOPjUKah0edVwBoJNeZAl1r/xwj49QZqCC+3EFxZJKOvEIIGAcaH
	 MPS35lAdirDAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9393E3924440;
	Sat, 19 Sep 2026 05:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/15] bpf: A common way to attach struct_ops
 to a
 cgroup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178979641040.1277927.5226384464308914139.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 05:40:10 +0000
References: <20260917200542.3689605-1-ameryhung@gmail.com>
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 17 Sep 2026 13:05:26 -0700 you wrote:
> Hi,
> 
> I am continuing Martin's work to support attaching struct_ops to cgroup.
> 
> At LSF/MM/BPF 2025, Martin presented [1] the need for a new interface
> to extend tcp_sock operations instead of adding more BPF_SOCK_OPS_*CB
> enum values. The need for predictable ordering when attaching struct_ops
> to a cgroup was also briefly discussed.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/15] bpf: Remove __rcu tagging in st_link->map
    https://git.kernel.org/bpf/bpf-next/c/012089512144
  - [bpf-next,v4,02/15] bpf: Make struct_ops tasks_rcu grace period optional
    https://git.kernel.org/bpf/bpf-next/c/5db69b0fbdc8
  - [bpf-next,v4,03/15] bpf: Add bpf_struct_ops accessor helpers
    https://git.kernel.org/bpf/bpf-next/c/3668bc410260
  - [bpf-next,v4,04/15] bpf: Remove unnecessary prog_list_prog() check
    https://git.kernel.org/bpf/bpf-next/c/1ef6cb2cc587
  - [bpf-next,v4,05/15] bpf: Replace prog_list_prog() check with direct pl->prog and pl->link check
    https://git.kernel.org/bpf/bpf-next/c/c6dde091dc12
  - [bpf-next,v4,06/15] bpf: Add prog_list_init_item(), prog_list_replace_item(), and prog_list_id()
    https://git.kernel.org/bpf/bpf-next/c/4d71b3e0821f
  - [bpf-next,v4,07/15] bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
    https://git.kernel.org/bpf/bpf-next/c/2ef54525d2fc
  - [bpf-next,v4,08/15] bpf: Add a few bpf_cgroup_array_* helper functions
    https://git.kernel.org/bpf/bpf-next/c/e176821b68d8
  - [bpf-next,v4,09/15] bpf: Add infrastructure to support attaching struct_ops to cgroups
    https://git.kernel.org/bpf/bpf-next/c/369d9dcd8fb8
  - [bpf-next,v4,10/15] bpf: Allow all struct_ops to use bpf_dynptr_from_skb()
    https://git.kernel.org/bpf/bpf-next/c/6d4ce907665d
  - [bpf-next,v4,11/15] bpf: tcp: Support selected sock_ops callbacks as struct_ops
    https://git.kernel.org/bpf/bpf-next/c/5ac77ae32940
  - [bpf-next,v4,12/15] bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops
    https://git.kernel.org/bpf/bpf-next/c/3bb54768fe3e
  - [bpf-next,v4,13/15] libbpf: Support attaching struct_ops to a cgroup
    https://git.kernel.org/bpf/bpf-next/c/6bad848e3f70
  - [bpf-next,v4,14/15] selftests/bpf: Test attaching struct_ops to a cgroup
    https://git.kernel.org/bpf/bpf-next/c/ae7b5234fa8b
  - [bpf-next,v4,15/15] selftests/bpf: Add test for bpf_tcp_ops header option hooks
    https://git.kernel.org/bpf/bpf-next/c/d7399d91417b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


