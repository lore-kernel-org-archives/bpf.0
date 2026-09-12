Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0223D2A1;
	Sat, 12 Sep 2026 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789234869; cv=none; b=ofbiMBIU64VsyKnqY+MQnZE3fpWS05OZmKCEjQsscEwBKTzIAlgzvmFt2LOlgAMJw6FnonJaAHLyc6t/XapOQ+fZTaFSJanMVFL1VzJjNUnwzFNFJOz3B+ngqg1DCdDTlDCnWhVylujl2KBbUEaWhk3xZ3cgWTq2hEyP2QUaW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789234869; c=relaxed/simple;
	bh=/3vm0CrjPuS1I13bKYI6wxx2yU6Gr2naIR3rtHWpZrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=naSkakWNVfCPkoOKSthLi5++Dk6JWr3Y9wI9wexECuFN8ZhGT5MyOPWeIKNL8YQiqZVh6LAN9VLE0Kb9D9O89am5BqEh+tLUWjvIJMXXGDbL+sJRUiVLLrOvLlahefRLbjbF/wzyX83dGDC08gjOsd292Qi6jdycuAJtSa06u1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwoOzG0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwoOzG0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E08B1F000FF;
	Sat, 12 Sep 2026 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789234868;
	bh=myxu1NzFnSxk8F2JiB56Zcv6tF00GXTkShtY/BNnREQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EwoOzG0tiQN/OYenvPudQplw/TeMMGRbGFBcdjZQzw8ua3dhBZRqgEhnDgCIirsWu
	 UsPNEvtf8ElYRgyBhAWxceAY04f6/CK/C3MVhluPVM1PamN5UhTR3c9ubqroaAb/tm
	 DaF0tn9jINcckmDWZcwpWoVCxP3Y8TJnnKW33pVRA3H7xIMEXTFxblWRHF1wjDx6z8
	 +tlDCbACpEsc0L2gBBpsHNZb4A+YOy5m/8MOzja8i3TU87VRZiW/yJFGg2lkLKqyol
	 L29PNVuOiOE0gsLUlQKzYVc+p1C+zwlMm3wiITXbyDFPyhleodLYbaBmvkvc9iEBYK
	 vkDaJPpsXZNGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939CB380820D;
	Sat, 12 Sep 2026 17:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Avoid soft lockup in
 __htab_map_lookup_and_delete_batch()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178923480439.3574165.8332617208173960322.git-patchwork-notify@kernel.org>
Date: Sat, 12 Sep 2026 17:40:04 +0000
References: <20260909-b4-htab-batch-resched-v2-1-0cb529d8f95a@toxicpanda.com>
In-Reply-To: <20260909-b4-htab-batch-resched-v2-1-0cb529d8f95a@toxicpanda.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, brianvv@google.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, jose.fernandez@linux.dev, paulmck@kernel.org,
 riel@surriel.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 09 Sep 2026 17:51:04 +0000 you wrote:
> From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
> 
> __htab_map_lookup_and_delete_batch() has no rescheduling point. The
> batch count bounds how many entries are copied out, not how many
> buckets are visited, so one BPF_MAP_LOOKUP_BATCH call can walk the
> map end to end. The empty-bucket fast path is worse: it stays inside
> a single rcu_read_lock() / bpf_disable_instrumentation() section for
> any run of consecutive empty buckets.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Avoid soft lockup in __htab_map_lookup_and_delete_batch()
    https://git.kernel.org/bpf/bpf/c/85136bf22404

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


