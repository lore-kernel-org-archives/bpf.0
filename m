Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933409;
	b=M7oO9c36QN88wFvCKt/ptzYZCpNpE1qBnv9PZO9Pfc1bX+NWq3kMz1srx521+Ph1rZzJ
	 /Qiu6uQKbUGjNew9ch9/t/wgnXUo5IXNMEZq7v4Xdj5FlgFuPjOELZQ5U6FBVcziSJr1s
	 9nooJEUKqhVHWDY+HJPfs8sZ/K6Uy7bNQSBrPkbZSov8aPQmgnVv0jL826HOmVtXPwPcE
	 uywAEQN3iUTPjVyS4nagV/dq/aVcf3PwjACm/dN8KHH1zfQbEOeRNDo9vRtD/h9iRRxd4
	 LQMwqRb8qSUN0hzRa9ls1oJhJJwJ9de0bS4MRp2ynDZUIqT4rN/rokMe/8G2aFi1ajg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ZeHUsE+SloKGZb0nWVK8kl1QgbF4g6Bp+EeRtt1tz5o=;
	b=wIoImDejS8bzvFdIq4H6P6I4GDtj5Mdre1loKHpjBHZiNaGdtOB/KT+o9tp5KU2xn9E7
	 4C833Z1t0kGaWDFFXCw96pkCdEB5zPiNwP72xMOvb0joXHlSKxje6CRL0KTGa6YSW6ksi
	 LEePlR7wydBUWVvyBHmfPbCTP6pIf5bPaYe1eetkcNgGOadJ2vzlT7GXaOHDxs0SabgO6
	 t+iJQGR9pT0O4JLIbnVV5axrCY8u1cVYFVJkyxWIzWHeuKuXv42oVA2gxFhIsSXWhEEKu
	 LX7/p3wQyVE6E8lT00dsFnM7ttBS3/c2Sdyd07X/glaXTtT9Bn2y252wRGaA0HoACUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtvFSfZ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D707606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtvFSfZ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7571F008A1;
	Fri,  6 Nov 2026 02:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793933409;
	bh=ZeHUsE+SloKGZb0nWVK8kl1QgbF4g6Bp+EeRtt1tz5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gtvFSfZ9m+fLuKM1/9rEZM2ceQdcH9suvfvMXHObJ5lNiG3MvbO5N9FMXzhbbhzSY
	 h8GnvcBDY7v2P+YJBpU8PIvOgCcu7aJgQNyx6lvKRcbqh//VIQhImw3y7RmppZ2wrU
	 vD+Mvb9GYvbLTKzXWP22OzccUKnp8HqCT/nXCJEIRekkf+jMsOZYOG5nKv5UhsPtEO
	 LLWpO1bx3uz8Ev0vF8GTnp6XWw4cZBk6HJKSb/unesxhKY8PQVBW5YCbCVLMB/Ak5d
	 mdyxmwIXL1tcJIDG+kFV9RdULXW/7G6VM63RNhsZG/WLZjcMb7qbRYmfDKbuvzw0aj
	 Xm3dzzi7TkiKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D81B3391B1BF;
	Fri,  6 Nov 2026 02:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf-next 0/8] bpf: Add user memory kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179393340767.310219.12502983957867843799.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 02:50:07 +0000
References: <20261105102343.311331-1-jolsa@kernel.org>
In-Reply-To: <20261105102343.311331-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
 linux-mm@kvack.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 ljs@kernel.org, john.fastabend@gmail.com, nierro92@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  5 Nov 2026 11:23:34 +0100 you wrote:
> hi,
> BPF programs have no supported interface for creating or removing private
> anonymous mappings in the current task. This limits use cases that need normal
> or executable memory in a live process, such as replacing a function or
> changing environment variables.
> 
> Although bpf_probe_write_user() can write to user memory, it disables page
> faults during the copy and therefore cannot handle memory that needs to be
> faulted in.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf-next,1/8] bpf: Honor const on generic kfunc memory arguments
    https://git.kernel.org/bpf/bpf-next/c/e4d6d6a27b82
  - [PATCHv3,bpf-next,2/8] bpf: Add user memory kfuncs
    https://git.kernel.org/bpf/bpf-next/c/0efac50f3e2e
  - [PATCHv3,bpf-next,3/8] selftests/bpf: Add get_procmap_info helper
    https://git.kernel.org/bpf/bpf-next/c/ec727e9c353f
  - [PATCHv3,bpf-next,4/8] selftests/bpf: Test const kfunc memory arguments
    https://git.kernel.org/bpf/bpf-next/c/2af3f3c9be70
  - [PATCHv3,bpf-next,5/8] selftests/bpf: Test user memory mmap kfuncs
    https://git.kernel.org/bpf/bpf-next/c/3c670f43767a
  - [PATCHv3,bpf-next,6/8] selftests/bpf: Test user memory page exec
    https://git.kernel.org/bpf/bpf-next/c/2c9e3611035a
  - [PATCHv3,bpf-next,7/8] selftests/bpf: Test bpf_copy_to_user kfunc
    https://git.kernel.org/bpf/bpf-next/c/4058fb465383
  - [PATCHv3,bpf-next,8/8] selftests/bpf: Test user memory kfunc errors
    https://git.kernel.org/bpf/bpf-next/c/5b1e4e8b4664

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


