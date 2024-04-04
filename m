Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560571B40
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271643; cv=none; b=PMNACsu4mu6ox2M2tkSzLs1qkCGzc1QgNgreepmkzM5mkSaE2Oqt2i5o4iKeB4OivQxVpX95DcsUuyVVQ1Nt3tx/uOmRf8g5TYuLsTGjpLzpMFMUUpO7t5EfNjkZGxiaf9J7t6FXP0adpumzBZT/Rgeb4oLwEewaDK/nfLifJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271643; c=relaxed/simple;
	bh=Ni2poidsIzmbkm/wPP2sGIcy8BhxI4UKVBCjVJkpG7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q95WzByQLS9suoYFFSZVKYmLSAkz+g9FnHMf0WBXC9+KHf5D4q08lNkuzDAIzr6IHcH9cXgefAL7qF7O5vezKbEE+dHunxkFrpsLdo0u85fnXE2QDwQjge/SwZVO4AvUrhx5SLiRzJO+VTfX5csLLKCkwwFTBWJz/iMrZb893vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gykj9oKr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gykj9oKr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E190C433A6;
	Thu,  4 Apr 2024 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712271643;
	bh=Ni2poidsIzmbkm/wPP2sGIcy8BhxI4UKVBCjVJkpG7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gykj9oKrkpTd4SgVM3yWJV2n8Dh28kq1RhRF1ncAZ/nnZ7IPG+eBjQPEPeWEFCyfA
	 Tw5QNXpALydhH7dH8xDnLCM6944rEax3RvY9YkF6VlN13ZyBbknDff+bcvzX+TdLmo
	 m5ZUjP1im8dzhU6L6eSkAciwIcFpZ3t6sj10EaZ1LH4GGbz3q/Z9FP25uESc3Bp8/v
	 Dne+884JvMNMyThUZz89qLU6A3+6cwYmV0uNJ1v9//NofLrCCLuxlcpamz2YOrYAzb
	 7HcpE0V2425nzxQ9S7Xf4z5Wkzs1aty4gHwkYynBYB3A8+v3w8PpE4bSPoHBA+5RiF
	 6zQUy/EfLhbvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F124C395F6;
	Thu,  4 Apr 2024 23:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5] bpftool: Mount bpffs on provided dir instead of
 parent dir
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171227164338.30433.16284662614628507134.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 23:00:43 +0000
References: <20240404192219.52373-1-icegambit91@gmail.com>
In-Reply-To: <20240404192219.52373-1-icegambit91@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  5 Apr 2024 00:52:19 +0530 you wrote:
> When pinning programs/objects under PATH (eg: during "bpftool prog
> loadall") the bpffs is mounted on the parent dir of PATH in the
> following situations:
> - the given dir exists but it is not bpffs.
> - the given dir doesn't exist and the parent dir is not bpffs.
> 
> Mounting on the parent dir can also have the unintentional side-
> effect of hiding other files located under the parent dir.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5] bpftool: Mount bpffs on provided dir instead of parent dir
    https://git.kernel.org/bpf/bpf-next/c/478a535ae54a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


