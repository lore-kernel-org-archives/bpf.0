Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D03615B0EC
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776612040; cv=none; b=M54YKO4+wi0TA/kR2ZlhtBkp/n9bDtwLheCp+kwr9Wruf+XglU4TqBfKIW2EJUNUvwyKm3CXT1dpZ+sr5fAy2y5EnAMp2Boe99XQtGtT6jnqpJtbsxo7ccH4JcoUNYtq6qHtsF9iSbixGzD7yT9ywvX3KKfDvI5F/OgfuBp738U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776612040; c=relaxed/simple;
	bh=QF/q6JT6BRmno7nDq2nhSWfg0vKoVJAFXwvCISFAask=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=niIxIJd3HiYcUSn5C1QqENpnpVPCT9P5rTdsWi9fCbuz0rOSagKq5jU9bxx0vNxBBEWpWxuwkroskmE2VC39DO1FvlC23Exz28FR9Eo5ttLlYVLB4bHTGnDWebE9pXdlLUOmdfZy4XijxbF+kt+uNMVZT3AbLtnDlPxRQNzsPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hgwvl9uV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hgwvl9uV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4386C2BCAF;
	Sun, 19 Apr 2026 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776612039;
	bh=QF/q6JT6BRmno7nDq2nhSWfg0vKoVJAFXwvCISFAask=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hgwvl9uVRiBlRzmJe9/9LNB833mjXaQ0Y3QOZqzwZA4thRRA/ts2dZ8xxp2SXAXG9
	 AVvDhoaDc4zXiF6S0YmEmiIzgTp5iw7kI0EdiHXepFskrcvULs9ZTvtg0T4UodH4sD
	 Ee1HwT8oroWK12St7K5by1TVS6SQJY9RoQfFJzUp1lNB7xJI0i57g6r3fbkChtDCZq
	 C7wTCk2w96BzGA2QRX1INg68rQC35yYv3k0v+s4wuWD/pKee4rLE8NVgAw0HkN5eKb
	 w/fmNtOndJNXA0TQ5DifY1GjeiZZx+c93L/9ADNlkWDpiiTzV/56GJH2JnqIhJd9hY
	 yOpT7tY0LYWzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD38380CEF9;
	Sun, 19 Apr 2026 15:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/1] bpf: Refactor dynptr mutability tracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177661200533.792430.5113320175620829361.git-patchwork-notify@kernel.org>
Date: Sun, 19 Apr 2026 15:20:05 +0000
References: <20260414191014.1218567-1-ameryhung@gmail.com>
In-Reply-To: <20260414191014.1218567-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, yatsenko@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 14 Apr 2026 12:10:14 -0700 you wrote:
> Redefine dynptr mutability and fix inconsistency in the verifier and
> kfunc signatures. Dynptr mutability is at two levels. The first is
> the bpf_dynptr structure and the second is the memory the dynptr points
> to. The verifer currently tracks the mutability of the bpf_dynptr struct
> through helper and kfunc prototypes, where "const struct bpf_dynptr *"
> means the structure itself is immutable. The second level is tracked
> in upper bit of bpf_dynptr->size in runtime and is not changed in this
> patch.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/1] bpf: Refactor dynptr mutability tracking
    https://git.kernel.org/bpf/bpf-next/c/31f61ac33032

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


