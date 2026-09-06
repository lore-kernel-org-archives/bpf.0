Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C01352010
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 04:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788667877; cv=none; b=YAogbogyaKgma56byXGGVcbRiCuGlQbqDEWAzrkNorqkK/MDwR5ihKsS3zjFFYZL51BqeHO3ODbYaTyDODstRrVedF1RyvxvrugmTukQWJuE6R5EPSk3oR0BbGMlb5/JbDRyTtSeEBdL4ZESlhG/6WIw44bx/w9OZN+W36TdBN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788667877; c=relaxed/simple;
	bh=f6XeczCf6wCTNuXJtGdyqt1oUUUmWLgrPizEzQNnjMw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YuAqZk+sdFg9pXGPjVLa0jIbXoJArZ98lh/+WbUnEkmOqt/o4J7f1kEIFR2SPw0ILNIHdiqTTvhFqJXWAJ5oYxpXXGFJ0AWXavNj6tBnK+amGo/ECs/IVM2Br/xqd052mz9dYfX1xDW88qGaD0LgYsfkSs6pDzJ8FRK3cKLF91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUeme0v8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUeme0v8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE2E1F00A3A;
	Sun,  6 Sep 2026 04:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788667875;
	bh=/aZSqQ14/j2SNevxq0xeZEm5FaOi7mJzupQamrfayIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MUeme0v8Dj3/y9XOH7zq9/W35DU+dGqBigQcvVGoaJ1LdKd+2pJ9aQfVQ8y/9snI1
	 L+NO7IZrOtm/YYZWECEDfGMqO+UDCVKkufS5VnJec8NHrHWTrh/obOF2J2X2aZIHQp
	 C/jIrg/vsVuxbZsvM+/+BLXgZvOup8cCfNR2gskaCPDlyJF6trn2CBZ78YnShMxS9D
	 lOYhzBVGY2+MSoYafAStBL/CYYKyC4pS0wLIv789aXDjOFgf3hOVv/cM2djBRp34qA
	 vMtElGK6seq3A3IdC1IMaasL6sWr4HhHFnHOVQeW6jqICdqD7BOgOTH8FoTghlQMSF
	 IcM+5wVBXaR1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19BAF39253D1;
	Sun,  6 Sep 2026 04:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 0/2] Fix bpf_loop syzbot report
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178866781589.1440290.5032083572007541945.git-patchwork-notify@kernel.org>
Date: Sun, 06 Sep 2026 04:10:15 +0000
References: <20260905014735.1452988-1-memxor@gmail.com>
In-Reply-To: <20260905014735.1452988-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Sat,  5 Sep 2026 03:47:32 +0200 you wrote:
> Needs Eduard's ack. Fix for the report in
> https://lore.kernel.org/bpf/6a9ad24c.b5d4176b.238c3e.0001.GAE@google.com.
> 
> Kumar Kartikeya Dwivedi (2):
>   bpf: Reject non-scalar bpf_loop iteration counts
>   selftests/bpf: Test pointer bpf_loop iteration count rejection
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/2] bpf: Reject non-scalar bpf_loop iteration counts
    https://git.kernel.org/bpf/bpf/c/c3fd8e5fd100
  - [bpf,v1,2/2] selftests/bpf: Test pointer bpf_loop iteration count rejection
    https://git.kernel.org/bpf/bpf/c/bde8901ea142

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


