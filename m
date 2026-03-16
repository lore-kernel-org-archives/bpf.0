Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38839FCAA
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678612; cv=none; b=joYnvHkMS1fiXlrf1wtifO3Loh7eovSYoZd5frBBGOjn1tWM3G8OAEFZNtfFBQqbaoEzsNKdf9C7EhaXnkRPH2cPu6BxCJSsF4MBkckQ/t+jSf106zBqR7KgH/WmmmP/hThztD5rWtHqeJ1blh3pFEY2qVA98fKBgxq4DgPWkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678612; c=relaxed/simple;
	bh=ziYcAO2yc+pCt0ISGSPEhiytanjxbVb5/TKd8TNp8yA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OO0eqcqbwX3jn81gw2+9i/5crdHBPTm3GqQhvqrRJugH0o8aeODJ4j1IFgCYnWy+cLDXnOarVmzgYsjNauYX5lsmos82qKzsHvqeg4Udy4LtcjYZ//aGq3cUrishU7PqIFDtQtx+H0mM0ygGSoHtXOz8UMMpX8APDDlA4N8O/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngZjtRQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngZjtRQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8610EC19421;
	Mon, 16 Mar 2026 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773678612;
	bh=ziYcAO2yc+pCt0ISGSPEhiytanjxbVb5/TKd8TNp8yA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ngZjtRQsbiOMEy6G6J6y0Lnm/Qka8Jk0e5JEQlaQ5+uRmUdnKyD6X3o+FiETzhZ3C
	 bRcVqg4XOzBZ/E/9wXM5vAQ99xdBiylX7jIJojVHUCLPwcGhhnJfkarJ5EyP18IRNR
	 EdGS+XW02wx1aVgMfg56YICFR1PzN5c3C5qL3heIDMqZYyRPZELqSxgDLSe+D9s7kr
	 KXl/J5+n8TNCPR9q07P6kLbGR5KEf8YMfa7ffDsx+oVcUSJsDZVAcnO+6sgWv8eL6j
	 TlszgPEnrnFqJ8RNQq9dAR/TvtovsSHb2IRrwXH8n5C0i8VHVL+ZlF7o2k9yrmZjC/
	 oqcKjJm2BrTNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2663808200;
	Mon, 16 Mar 2026 16:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] s390/bpf: Zero-extend bpf prog return values and kfunc
 arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177367860555.2746981.1494722972104099788.git-patchwork-notify@kernel.org>
Date: Mon, 16 Mar 2026 16:30:05 +0000
References: <20260313174807.581826-1-iii@linux.ibm.com>
In-Reply-To: <20260313174807.581826-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, hbathini@linux.ibm.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 13 Mar 2026 18:46:25 +0100 you wrote:
> s390x ABI requires callers to zero-extend unsigned arguments and
> sign-extend signed arguments, and callees to zero-extend unsigned
> return values and sign-extend signed return values.
> 
> s390 BPF JIT currently implements only sign extension. Fix this
> omission and implement zero extension too.
> 
> [...]

Here is the summary with links:
  - s390/bpf: Zero-extend bpf prog return values and kfunc arguments
    https://git.kernel.org/bpf/bpf-next/c/202e42e4aa89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


