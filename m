Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216625A2C6
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771027233; cv=none; b=EgTkLkAAtEPN7v/D7ChfE0/7f4i8b+WY0pXUsmUGhHu/Xn/Q/DQS46lTH6F5/g/A1l7priiJDa0NrKOlxUREUF/3xrg9fLJixUas7FXxwWfKvjWOm9izVUjdsPaRcGyW54rD2ePtUdR/89G8k5Vf86JDYSH12n0/BexVnxkp+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771027233; c=relaxed/simple;
	bh=d4E+JLPjI4JaJNeC/yiuj5JJA3WGrMjSyJ9SJUT/YX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ItgWc2Q8wr25ZjiVs0hdn/JhwCZP61r5WN5QF5ZTA/FbVzJ7+uNajaFXTvbF0969ihmM2rcfH8ipbuJ6lttKCSzcUrMeL9feIFN4vSVHNAK2guzaI0tQLBjNP6ix6K8e5swr0kRJ5FgxUYyGTbY++VRz0TVVus4rvp+GV+Tuduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss+ve1iV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss+ve1iV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCB3C116C6;
	Sat, 14 Feb 2026 00:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771027232;
	bh=d4E+JLPjI4JaJNeC/yiuj5JJA3WGrMjSyJ9SJUT/YX4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ss+ve1iVT9OMrHZCS2NxmMKLbNw2nxW/h/85CABNDs9Oz7z1kT+2qTFdKPentC1aY
	 wMInsQhCeHW6+dZmYSWj9bYYtw3tf9DFWumbOKxjOtNr2Ho00IzJVJYZ5EPQ2TQmKS
	 w32vYe40dVnbldFianZTmbdP4W0q91wi5JRppJqdnkssny00agOnbkmfqo4jz8V4mw
	 Y/QFc3grkKsHtbtE4hwszCEgz5M0WuqBWT1FZBN+qO+wC1eyz6s0QLJ4EFLY2uv3Ho
	 qkzC6fJ+rt6bjQytSiPo5lv/xob8pul9gg+TRaKwmpQkqaJ1A0rXRNqLY5YpPbGfDP
	 iUvCUMVR+yW4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8515E3811A44;
	Sat, 14 Feb 2026 00:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Add a map/btf from a fd array more consistently
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177102722613.2619276.3609779526315798436.git-patchwork-notify@kernel.org>
Date: Sat, 14 Feb 2026 00:00:26 +0000
References: <20260213212949.759321-1-a.s.protopopov@gmail.com>
In-Reply-To: <20260213212949.759321-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, dan.carpenter@linaro.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 13 Feb 2026 21:29:49 +0000 you wrote:
> The add_fd_from_fd_array() function takes a file descriptor as a
> parameter and tries to add either map or btf to the corresponding
> list of used objects. As was reported by Dan Carpenter, since the
> commit c81e4322acf0 ("bpf: Fix a potential use-after-free of BTF
> object"), the fdget() is called twice on the file descriptor, and
> thus userspace, potentially, can replace the file pointed to by the
> file descriptor in between the two calls. On practice, this shouldn't
> break anything on the kernel side, but for consistency fix the code
> such that only one fdget() is executed.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Add a map/btf from a fd array more consistently
    https://git.kernel.org/bpf/bpf/c/b0b1a8583d8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


