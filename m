Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DFF139D1F;
	Wed, 27 Mar 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557037; cv=none; b=vEJxAmZ4CMAx3kLQFTPzXJBM9W0tFRUMDFynFe7UZamrGSWsorHyLBM779g+TspUSAjS3h+2nLTs/5G27gnZktJDspLg+Fn4XMHIfblbraGZ9qecD6cteDe7ednJivDzBVdlxzMeClNvbPKuIf/umJw4YcMeFDLDR+3yptUVCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557037; c=relaxed/simple;
	bh=3r2GdWJyaKfFcnANbvchFIN7KbuZq69dsR3O+aW8wpY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4gdEdjwlYnl7GXchfiswbH2e4H0cFgWg7XHEnx413IurYpnyJgidMg+8MZkvI4ylIlHGnRw94wG8WB0TI64uMhv6Z2OYvrpZ4mCMjKWeZ/kyje2tM3nvIOYmZiyPOZq5H3ZDM0D0SZYZCtLHBGM6VvHcWRNCechPCM7WY+y/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuFky6Ka; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuFky6Ka"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85805C433F1;
	Wed, 27 Mar 2024 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711557036;
	bh=3r2GdWJyaKfFcnANbvchFIN7KbuZq69dsR3O+aW8wpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fuFky6Ka/i1qcOzcPj8bTRjvnBEZ/X9McH3zktrcdb29GNYie3YryohlRgS6RWnEq
	 Sbr/sM3R5YwZojxFednFZVs0DsBrKaQFY3etD1cc7YEmUfzshSmZZplG1DRleZ1+C5
	 CWZYBdjcihpYAppl1EkIQHR2q6VmsfzRjvh+ap5Y1PYEcy9vUvjhYGMym8a2HNsQ15
	 b7U/WQvwN8yLTZn6xl0Y9IqllgXIJbtdkbyBVTmro5wRv+8VZsUG0+tn9dPjmh5fjj
	 3+OB2uO2UTCHKfOfRCg+zMkY2ZvPrhMuT7IDYLJhhXABxaDMtMDDIUKwmvvqteuoOn
	 /rUGmoxblHGug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7421CD2D0EB;
	Wed, 27 Mar 2024 16:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] bpf,arena: Use helper sizeof_field in struct accessors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171155703647.16147.8985215906993391479.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 16:30:36 +0000
References: <20240327065334.8140-1-haiyue.wang@intel.com>
In-Reply-To: <20240327065334.8140-1-haiyue.wang@intel.com>
To: Haiyue Wang <haiyue.wang@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 27 Mar 2024 14:53:29 +0800 you wrote:
> Use the well defined helper sizeof_field() to calculate the size of a
> struct member, instead of doing custom calculations.
> 
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  kernel/bpf/arena.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1] bpf,arena: Use helper sizeof_field in struct accessors
    https://git.kernel.org/bpf/bpf-next/c/45a683b2d815

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


