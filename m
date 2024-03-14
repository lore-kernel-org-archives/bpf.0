Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC55763E4
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448829; cv=none; b=V4LGFXLq4joCHgd95Ia+8LUqfNMvGsdBgu03eFmBA2P9HGmTTfO66kKG7B9sYS2ErLQgVKgz2SnXQTIyMlTJKLojose48Xo7O80bU30l8h3quftBzA5DMJty8lUWRrRVhdBFld+QYLqmc7sPNC1mDVYukts7LMrqn4sTf7a0imA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448829; c=relaxed/simple;
	bh=c3m9MDMaIC5KqWMMqprFeD5Fsa+hmlljbI13FGafO68=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fbaHZ8cRlZo7oxBYEUGv3cfNX7wSmmLtchdNMoOAQMvjjscUeFuQ9mRXAHHRAFWeRUorNBU+bOaHJ4OQ8d9cvvzuK2uLuJFSS8KC+OFgvVuxOGNIeoa4GvcqOfijnaCSf8e7cCzidnKFFS1zYVOBnRw7/tQl0UuOXmbVTCCtdmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlRCc+Hq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlRCc+Hq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42927C43390;
	Thu, 14 Mar 2024 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710448829;
	bh=c3m9MDMaIC5KqWMMqprFeD5Fsa+hmlljbI13FGafO68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZlRCc+Hq05Q15YkAZrFkzSSxclruzgwQnahjVe9MtTVsCkAR9qifQohv03Sn85Xem
	 893IqPT5/AwEDuky5n03G1IA+WvATO6bL1QaU6D9DGJEDm/S1DiIcEog+RqtdHVu7k
	 J/XU+GNjPN9yu/ghqeDnRy6CT5yffAcV8LlkioEsn9G3AQfDek5l8kHJRuyoH9+Dpo
	 WF4d5poe0u6vR+1FEz69Wpul1Fii9PbgDoSmAncy8ywdeHXfLe7EAXEY22h7+gfoO9
	 SNGJ9qpyRKk4PS5uNedlUSbHrHhKQaBkUmlWFAEZhiyAPIT+87wfP16Owq36+GzRSz
	 aWiu/vm0oVDNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E532D84BB4;
	Thu, 14 Mar 2024 20:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpftool: Fix missing pids during link show
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171044882917.16494.10963082346560946802.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 20:40:29 +0000
References: <20240312023249.3776718-1-yonghong.song@linux.dev>
In-Reply-To: <20240312023249.3776718-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 quentin@isovalent.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 11 Mar 2024 19:32:49 -0700 you wrote:
> Current 'bpftool link' command does not show pids, e.g.,
>   $ tools/build/bpftool/bpftool link
>   ...
>   4: tracing  prog 23
>         prog_type lsm  attach_type lsm_mac
>         target_obj_id 1  target_btf_id 31320
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: Fix missing pids during link show
    https://git.kernel.org/bpf/bpf-next/c/fe879bb42f8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


