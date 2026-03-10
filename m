Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31523271EA
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169213; cv=none; b=TC/gLudJPfeg8Of3iO+KXI4HqKjpjwJV0pCvXXEViGpsjbdxEhEfm3PHNyjHIziQ1LoFFzUjt448OBqM0AIPQpDy7pqpRCd1yQnDDjkmMERC+Kwjlo7a8l6ALkIdKj/VgCCKyiCSlVuIBJk7ICcreCf2bS24IFfdKWPZjwnVPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169213; c=relaxed/simple;
	bh=ZcLOYMcnkjcp9lfNnGvpo+v48nwwHA6zoCq7zHqNQ+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CjSRGicYGLGDUssrrWR+PdceGIRzhfKpN79+H67PXMAhEdSTBLTWkWqnkesCQEyjTT4oTsPzR3Pm/ZEKxoXpnxUXPlMv/9at+Jwz9Iq+T9+HY0Q2cXCJoYIZgHCGcf+nvbFzVxEdfXvdBEOH+6a5t7cRpz/qeje7pZ751v94k2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG1IjS6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG1IjS6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D68C19423;
	Tue, 10 Mar 2026 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773169212;
	bh=ZcLOYMcnkjcp9lfNnGvpo+v48nwwHA6zoCq7zHqNQ+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oG1IjS6ICeEQpDnC7zPVFTZ6rX6CczoGOlR8ghKe9VPd23AeV7QSWgsDVymVaxr2Z
	 j4L+2aSzmcYM19nNg3c7zlxTu8+0GMRZINx956wcrbg6ssV9qNtkFQYEhfvLxvjBpi
	 zyJtwcEdYoCFBW4Xy/6hHlz/cFGD/eLV5zevkyTuWElGfz326qg/7ZdcoPYEm0Si+n
	 JG75E/VygDIQPevU3HmuXLNVU0M9/koF/uPz5Kg1fWp3PCUN2rmTK3Z2jc6piHU6Po
	 5lv8C2OKWv9X63v+hAG7kzXD2AGhaLel6eDKQEljHLA4a/3XDwo7bYq6ZBBtgkcv11
	 QnCdTAH+ma18g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFB63808200;
	Tue, 10 Mar 2026 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] bpf: Reset register ID for BPF_END value
 tracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177316920929.2465788.13381300920337627222.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 19:00:09 +0000
References: <20260304083228.142016-1-tangyazhou@zju.edu.cn>
In-Reply-To: <20260304083228.142016-1-tangyazhou@zju.edu.cn>
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 glapt.pro@outlook.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  4 Mar 2026 16:32:26 +0800 you wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
> 
> This patchset fixes a register's scalar ID issue for BPF_END operations
> reported by Guillaume Laporte. Please see commit log of 1/2 for more details.
> 
> ---
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Reset register ID for BPF_END value tracking
    https://git.kernel.org/bpf/bpf/c/a3125bc01884
  - [bpf,v2,2/2] selftests/bpf: Add test for BPF_END register ID reset
    https://git.kernel.org/bpf/bpf/c/ea1989746b77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


