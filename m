Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD1A125A9
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 13:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C997AC433CA;
	Thu, 29 Jun 2023 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688046020;
	bh=TxOavPXw+8POPkiDSt/eNo8WZ/YgJm9JsoHOlxWJYCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fOyr7gHwteA20BDlO0GXWre7OPGnaGlWDIgkQvZiZUyCmFLicskorC/pRCqnSLrNV
	 Da2pqGmWcLrGrp/j5MZsEUqcgZVu2CgVQDBdh846NLIn4wQl7cTr+ju6iHjQ86llcE
	 nXbIhv2aoY8Oe0snNIh4DFBhQ3+Md0uAo9/mSNmeki2kd6oN4xvpD2yboqiNZPZd8A
	 YOMzKyJ7CXa72WFmeZUwDvQTMFEyIGamFbcjPq+rvEvEgjU40Z87IHYaGjs2vA4mcN
	 dDVf5+jJNKCRRQP1+u24UsFLU/QeU6/FLQ3cuGswqtQ9ZpmKztC32EQ8elZPEJozFl
	 YGobldzaj9itQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD9D5C395D8;
	Thu, 29 Jun 2023 13:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] lib/test_bpf: Call page_address() on page acquired with
 GFP_KERNEL flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168804602070.32686.5893039361315012662.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jun 2023 13:40:20 +0000
References: <20230623151644.GA434468@sumitra.com>
In-Reply-To: <20230623151644.GA434468@sumitra.com>
To: Sumitra Sharma <sumitraartsy@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ira.weiny@intel.com,
 fmdefrancesco@gmail.com, drv@mailo.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 23 Jun 2023 08:16:44 -0700 you wrote:
> generate_test_data() acquires a page with alloc_page(GFP_KERNEL).
> The GFP_KERNEL is typical for kernel-internal allocations.
> The caller requires ZONE_NORMAL or a lower zone for direct access.
> 
> Therefore the page cannot come from ZONE_HIGHMEM. Thus there's
> no need to map it with kmap().
> 
> [...]

Here is the summary with links:
  - [v4] lib/test_bpf: Call page_address() on page acquired with GFP_KERNEL flag
    https://git.kernel.org/bpf/bpf-next/c/da1a055d01ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


