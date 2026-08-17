Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040B3B42FE;
	Mon, 17 Aug 2026 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960256; cv=none; b=r0dSMUsDXWR9kNCibTtSm0HqkCQlEKUAHML4ZJYFYskCPBbYa3c6xxe8OWYRDHH44zaGHyQLrQz+xiiewlhWgr7i5erQgucbK6hvFDRtiEwXnojl5m0Ww509KIabMXQzE6GahiwVHQEZ9dbe/493MnlLsr10jCe1e36jYBHVmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960256; c=relaxed/simple;
	bh=JLLbgujZYkj0BnDfaWwCyG3HeAkP3glyBlfiCcRUOEI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VJp3yuKpv8yr4WS/CcMSQU6/KIdM/FKJ0uW3n4xBq72vsyDnm2aJyWy44hOoBUdk5+LfKgl3XXDq99VsYMstQqKYgfWF9wgbNWUGzVA1uQfbuDGtI4pOBRtPVs4GWuq1FgD48TZx6EdFOACFpoCpgONx2nCDI79KmUHcB5ssYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR7PiKsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR7PiKsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C2F1F000E9;
	Mon, 17 Aug 2026 09:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786960255;
	bh=d4wSjGZxS0+NFOIGm6UI/84mWN7jIGcu12O+oKPrv/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IR7PiKsWticzhEUcKhDkLs6pBH7DAklzVuAzeArT4mwQ2k7MbiDeeJzq77MNAkUq7
	 C3/+7HFfuaK8Wo9yS0yKbBm+61Is/h5gRygXtYkNZh5LwI0x9E9TZXuBDSuXDbAmAH
	 8UaoOLfouqkvHBtSZjJZd5561Ok3qxsu9GZx5AYFi+ElN/etEYID83O0wCYZeJXe2+
	 EhL2QfoUVzk6UGfcILITnnw0S/vcQLZ2hIuSTrZQVggG6QPaG9Koku3b/cCYWwXRsh
	 GfCQvH5EQ2zbT0XjXbRYDwGrVlfAw+eLhVIktN516Btq4BQEL+8E7rW+v7oHWu6X7H
	 hrhf1izNgSw0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D098239253C6;
	Mon, 17 Aug 2026 09:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] bpf: Reject negative optlen in cgroup
 getsockopt
 hook
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178696020739.1047534.3951933136786792330.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 09:50:07 +0000
References: <cover.1786448307.git.zirajs7@gmail.com>
In-Reply-To: <cover.1786448307.git.zirajs7@gmail.com>
To: Junseo Lim <zirajs7@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 rhkrqnwk98@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 11 Aug 2026 23:19:06 +0900 you wrote:
> A cgroup getsockopt BPF program can set a negative optlen after the
> kernel getsockopt handler has run. For TCP_ZEROCOPY_RECEIVE, the
> kernel-buffer hook did not validate the lower bound and the negative
> value could reach copy_to_sockptr() as a size_t.
> 
> Patch 1 rejects negative optlen values in the kernel-buffer hook.
> Patch 2 adds a test_progs selftest that reproduces the issue through
> TCP_ZEROCOPY_RECEIVE.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Reject negative optlen in cgroup getsockopt hook
    https://git.kernel.org/bpf/bpf-next/c/1b5aacd5b241
  - [bpf,v2,2/2] selftests/bpf: Exercise negative optlen in cgroup getsockopt hook
    https://git.kernel.org/bpf/bpf-next/c/6b0835ac79b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


