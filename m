Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996713F445
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749832; cv=none; b=nt5goixkarzIsc6JLYg8YMuKRVExN87MYlMKhm3DPZxNUIw8BlYLm/lM/Oe9u3Z16t0J9HOaSqkqaI5wH8uPWqYnbj3eY34Qgpq67h9KOtUqTueLdYK7nJ89cWLWp0KVw/b93k5Doso3lfaJekIiFPvQRtdyBmSpGoCoWbxgjGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749832; c=relaxed/simple;
	bh=PbF2UlZV892Jxrsv7n/QNaCuvcvT+bdEwgeDba0rcjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WvlN8Oi1a4O8DmABIWhz8Hf6jE1DpGsroUl36BOUChjbp0Y52RFIKjdoU5Y9nnoqDh+aISdikKP5+DMoJheZ05nq5jq9go6cXzCpPEPgv3c2309YhPqw2+p9BHUpUqQwJ8zqe+s3MHnDiX7yydMHF8plkobR87tiSFeBavJfS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwiXDfvl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwiXDfvl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92CB4C433F1;
	Wed,  6 Mar 2024 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709749830;
	bh=PbF2UlZV892Jxrsv7n/QNaCuvcvT+bdEwgeDba0rcjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fwiXDfvlpQlGjUt62NAuwwDKSJswzGitGsNvpmH5JJsLFIOU1IdYtAoB1W3FFEwNl
	 Heo7Oc4/XqjTSTf8XTrWqufWL0CndVvbmOhLiJFh+unzTvqh+0lZ2KV0wut+1Z8bOI
	 LeK57dveh/uRc/EIjUKLKhOrsZ3f8pRkCC33dqADerQY8+AcoodtKAPCyEZKT4Y5FJ
	 7OGroKN89O9Ev4ImAbKnPPjsldWBbdcmHgAFepFtQ6e8s3tqS2Za9s0ZWIQc9YropM
	 vGNlDE99EDrTjhMl98e59+kIVa4QiumCHwSTfYpKNXdd1Zsu2vUEItWQ8lNBCg3ngh
	 UodUR2RADtwqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75D01D84BDB;
	Wed,  6 Mar 2024 18:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/2] mm: Enforce ioremap address space and
 introduce sparse vm_area
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170974983047.28981.6719841363638067454.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 18:30:30 +0000
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org,
 lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com,
 hch@infradead.org, rppt@kernel.org, boris.ostrovsky@oracle.com,
 sstabellini@kernel.org, jgross@suse.com, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  4 Mar 2024 19:05:14 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v3 -> v4
> - dropped VM_XEN patch for now. It will be in the follow up.
> - fixed constant as pointed out by Mike
> 
> v2 -> v3
> - added Christoph's reviewed-by to patch 1
> - cap commit log lines to 75 chars
> - factored out common checks in patch 3 into helper
> - made vm_area_unmap_pages() return void
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/2] mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
    https://git.kernel.org/bpf/bpf-next/c/3e49a866c9dc
  - [v4,bpf-next,2/2] mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
    https://git.kernel.org/bpf/bpf-next/c/6b66b3a4ed5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


