Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB853ACA60;
	Mon, 21 Sep 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974075; cv=none; b=G0NjBloXo4uuu3BCiBBt0PcTp2VTnTrbJ20XcVPKId7daeZmKBsKgL57iVn4zLIy/AmogVqFHcncZ2SIri34+/3RbJQ/J+RD3UjHO+GJZ5aA0bk4PQw0FoFtmSpPHYv+RbIvlBsaYmDCsAi1rLO81n8hDYJjkRt87xell9uPERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974075; c=relaxed/simple;
	bh=8uKZ2h9aFeBSVaGeVI4oZYCHFvta2ndx/uBNjfFsYM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k7dls4rP9FnpVJSK6utOV57Qv20dOyYNp2ZTnExjvy29wCatatK3Wo04VY0VSAgezAFB634BPOk8wrrwGc3wMslBTEoFqdHlgkWRLXvPlK6aeqtzooLpOknKImpdlUcCAUXlAHSyeus5b3imnovznvRSamY2k/tSHQqiXgeK4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0fJ9EKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0fJ9EKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3F01F00893;
	Mon, 21 Sep 2026 07:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789974073;
	bh=i78DpXU6G1P6U4iTP5gmX5SRaeIRgR1YaUqQ+TZuQSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m0fJ9EKuEOApABqdpECx+B0q8OocMmr/FLt2AthD34JiaM11GD+aTrxDCpHVGyIM4
	 m6XwioEK/PAGKvQxZcI14MOiFhkJa/vQJ4N8LDA96DoEBeA9jgvE6FySzjWEMrEI7M
	 0otTHvecRE5IIGSEYybo2kC0ExJKmpE6Adsiu9MLzYwHIOGEq+p3vmn8n1tKoX1ETW
	 NcmMzdjNfbadpRqunWbRKD/cI+3vd1lWwDrog6jhV16oTLEJ9bcdHwwo3U2BWaj+tm
	 7ZsgR0rP6gAbD8Xfu9CE72IVjenPXYyBW9taNAFLXAU3j1CuyrKK1bBm9YgMk2MazH
	 1qvBjGR/Le7sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BC3926266;
	Mon, 21 Sep 2026 07:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v13] mm/bpf: Add bpf_proactive_reclaim kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178997400515.2390936.16367635369472910068.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 07:00:05 +0000
References: <20260921030854.17858-1-hui.zhu@linux.dev>
In-Reply-To: <20260921030854.17858-1-hui.zhu@linux.dev>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev,
 akpm@linux-foundation.org, andrii@kernel.org, eddyz87@gmail.com,
 ihor.solodrai@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, david@kernel.org, baohua@kernel.org, geliang@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, zhuhui@kylinos.cn, jp.kobryn@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 21 Sep 2026 11:08:54 +0800 you wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> BPF programs can observe memory pressure on a cgroup, e.g. refault
> stats via bpf_mem_cgroup_page_state(), but cannot act on it:
> triggering reclaim requires writing to memory.reclaim, which BPF
> cannot do.
> 
> [...]

Here is the summary with links:
  - [v13] mm/bpf: Add bpf_proactive_reclaim kfunc
    https://git.kernel.org/bpf/bpf-next/c/48ea1ba704aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


