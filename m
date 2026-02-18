Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68250338936;
	Wed, 18 Feb 2026 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456821; cv=none; b=Udp5j8r3HOhFV6tfNFuqdgG8RKDh2Cxwy5Rj1i7Jy1qpAM61jfuLcGhDqwWPuUBg0f6l1MHFnOWT+Zy2PLlnJMM4mudu7uajrZh02uma6oVtr01vvAEKrVVZTaTb2LprCRRqhxzM/IBxHGJ2sJ4yU5MLPl44lcb8JgxVcjX3mjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456821; c=relaxed/simple;
	bh=fXcdiPdkHdTo10MS9WFhdGIm35nAuVGjC1fUrTMYIjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KFP5Wz2Sb7fi9a79BQSJRbsrKugc6p5LWBdJWzJS8Qfii4dE9TqRT/c7Aj1f2azXyj/SMo1lfV7/Dks7OZn2hzH8Q2NmSjvxpZ+5Kt01/WWb7c8gBlbJzMsMtFMU6+02JbDZz0Q72iMxtO7JzGSfoBlacJWR10y/ND2mDxF47E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eboXJwRY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eboXJwRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456F5C116D0;
	Wed, 18 Feb 2026 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771456821;
	bh=fXcdiPdkHdTo10MS9WFhdGIm35nAuVGjC1fUrTMYIjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eboXJwRY59wxYiUElBFA5z0MwTIAOFmChtRuLiOdYbfeSfK9cHAR4WtfYY3iBuRK+
	 pv8Q9U5qrBsSre1m8QSLmFjLDo5r+e6Y1chVMpQtI5AolhQUmSeQh4B4Y4/6Z/Cr8W
	 Xh3/Wh0b1Ie3+MHMs8aTSlfViy5EQE/LTyWz0lRL/XwrcAnbcSNGfB/gXMsz5D87At
	 xutEsJqXYH33a30dqFowbSflXkv3qbyq8uhk6xp1WSKyrYh08B6yxsL5S7y1tLU0rc
	 rBhY8OU691gxoaHSpq7uEDIEW1WIx5CHyecZC9sNic0QgVD9Gzmg8jY0bVscmMQFXb
	 1BBrvOny2TB5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C21A7380CEE0;
	Wed, 18 Feb 2026 23:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: Remove hexdump dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177145681236.1592777.16534879070223816061.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 23:20:12 +0000
References: <20260218-bpf-sft-hexdump-od-v2-1-2f9b3ee5ab86@kernel.org>
In-Reply-To: <20260218-bpf-sft-hexdump-od-v2-1-2f9b3ee5ab86@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 yatsenko@meta.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Feb 2026 13:01:44 +0100 you wrote:
> The verification signature header generation requires converting a
> binary certificate to a C array. Previously this only worked with xxd,
> and a switch to hexdump has been done in commit b640d556a2b3
> ("selftests/bpf: Remove xxd util dependency").
> 
> hexdump is a more common utility program, yet it might not be installed
> by default. When it is not installed, BPF selftests build without
> errors, but tests_progs is unusable: it exits with the 255 code and
> without any error messages. When manually reproducing the issue, it is
> not too hard to find out that the generated verification_cert.h file is
> incorrect, but that's time consuming. When digging the BPF selftests
> build logs, this line can be seen amongst thousands others, but ignored:
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: Remove hexdump dependency
    https://git.kernel.org/bpf/bpf/c/1e5c00912695

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


