Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F11264619;
	Thu, 29 Jan 2026 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769655017; cv=none; b=MY+9n9yQaxJQcBkI0CD1X8wsTYcUQjRIjdiyIODclp7pJzhxHGHRG1OW2zbxOAu5rNsYmN0Xk+MeNJ7JQjlcQF68aNDn8RubmNJds52NjttbzMhYLtezjV26yen2rvDrzOn4zDevcQAr05y0yBOVkHvaEiW942ePVRTkYG7SemE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769655017; c=relaxed/simple;
	bh=RMbQZGd6MTe6Yx7WbbqH0wbPl9UJbr0uWhS7gdlb8C0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o1NhEPuPS1r5PlgK4q5AOQHK24SkuWKSwi9U+LC2PaQEnZQTIA1gN9JxLe8an7N4dvF8G9iO1poz1UDMRD9UfxpvoJDQKbN3rDIogO4NCnoK+e7OUXsSZh7HtUceHjNWRgCW69YQmTm4+xTOhcZYiT08+4EgyUYHXgivnDNj+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPi8ku3e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPi8ku3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB5CC4CEF1;
	Thu, 29 Jan 2026 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769655015;
	bh=RMbQZGd6MTe6Yx7WbbqH0wbPl9UJbr0uWhS7gdlb8C0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EPi8ku3eubNO0/BSRi76+WTFhWErjj+ovjRm9fdtfymmrnndbYv1xKFC82qtfsjSL
	 6I83F6799B0lf1gWDrNKHGSHGxZUs+TjgRZMR5VFAdot41FSaPTPQXg7HHk/TV1SHz
	 2CXzc0VQuxGllQgXJ3SwKKRCFEumKcK28aYBy0fNAEFJtIG5j6p+MpZkZk76lUOlI3
	 EUqPquramASa+dc89Y/HOZTnERvESmr5zS7rxbwkozZWYfL0FG3nlST1zT0rdnp8hR
	 0g1AQyFwPKYqctURD9AU0yCsRvqB5J6Jv0HQySlTcXNNHyTiWMr20hWH7PwiolvRUk
	 82aeMVL9nxtgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBF7380AA61;
	Thu, 29 Jan 2026 02:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Fix verifier_bug_if to account for
 BPF_CALL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176965500835.2326292.18318567298833649268.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 02:50:08 +0000
References: <20260127115912.3026761-1-luis.gerhorst@fau.de>
In-Reply-To: <20260127115912.3026761-1-luis.gerhorst@fau.de>
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, isolodrai@meta.com,
 memxor@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 27 Jan 2026 12:59:10 +0100 you wrote:
> This fixes the verifier_bug_if() that runs on nospec_result to not trigger
> for BPF_CALL (bug reported by Hu, Mei, and Mu). See patch 1 for a full
> description and patch 2 for a test (based on the PoC from the report).
> 
> While working on this I noticed two other problems:
> 
> - nospec_result is currently ignored for BPF_CALL during patching, but it
>   may be required if we assume the CPU may speculate into/out of functions.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix verifier_bug_if to account for BPF_CALL
    https://git.kernel.org/bpf/bpf-next/c/cd3b6a3d49f8
  - [bpf-next,2/2] bpf: Test nospec after dead stack write in helper
    https://git.kernel.org/bpf/bpf-next/c/60d2c438c1bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


