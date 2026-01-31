Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A033AD85;
	Sat, 31 Jan 2026 05:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769837611; cv=none; b=KZE6aJJtMteTmAZsp0Mx9sx1WVPAoh5MdNAmkiKg2sFKir0XXNFnnA9poroI7QZ29ojThrGMb+KSvjXyaqADHHQDYC2tF49BpTR7pjcNT8HXfrkvzApiCdGDen9QYCJdDxqvPzd/9kSg/MNhUdxrzkV9mKtm8yTOtXyzJMk+xhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769837611; c=relaxed/simple;
	bh=G6rQUjN8y070jnUXkby5RuDLkqDOPA3sfYijguPiotw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uO2433pGzWUzMBNd1bIDruBu+5xJ26thXq7fbOE7w2FOtS6PF6G/XzJ/729f/mS00mSOUJIyD6i40hnSsfddjHiiIfd8Ipdo4SEPuI2o1g2eet96JW4BY3jREkvA/atoiuwYPzXfTpF/9jqgYwJP3NtUziNFcb/XXTecgU7aAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyyFerQh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyyFerQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB6BC4CEF1;
	Sat, 31 Jan 2026 05:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769837611;
	bh=G6rQUjN8y070jnUXkby5RuDLkqDOPA3sfYijguPiotw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=SyyFerQhhNPuiK7hGeXWHO2q+ae3B94f9i/AWIzAHeeuTv3EGJPzxuw+fIZ9UARUW
	 u7YcWLDWqMsgz+1zr2UdXZvtKnbzdqgc/v5W0EJtTdCnxGJTC1ZOyfUIF73Ybl+YLy
	 /4NDyDJXhkPIZLloL6qI6aJb5CmMh+i6dBUsswZ8phgptFJmL3KxMo5RnaVbp5eEKZ
	 rDojEUHderUTkFh3VbKOdYfLQJMMwfgBSCvv0aWbFCSRbOwuiDrD9085+NvHRoQ7gH
	 hjpkK/rWuiLI0LneswDOCAQ/jJn+8KsIRmhsjddQ1yrU6CVtnQnY11Gy+OMApfrldX
	 k+MaLT+XIVNyg==
Content-Type: multipart/mixed; boundary="===============2288734686524084231=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <978ac9073e0fadb08c40399bbff7d78cfa4a826ef98911fd654318a9ef9725b4@mail.kernel.org>
In-Reply-To: <20260131050920.2574084-3-ameryhung@gmail.com>
References: <20260131050920.2574084-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 02/16] bpf: Convert bpf_selem_unlink_map to failable
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 31 Jan 2026 05:33:31 +0000 (UTC)

--===============2288734686524084231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 82de4fd08a55cc944c23c9ae889ed792870964d9
Author: Amery Hung <ameryhung@gmail.com>

bpf: Convert bpf_selem_unlink_map to failable

This commit converts bpf_selem_unlink_map() to return an int (always 0 for
now) in preparation for changing bpf_local_storage_map_bucket::lock to
rqspinlock. It introduces _nolock helper variants and extends critical
sections to ensure atomic link/unlink operations.

> Remove the selem_linked_to_map_lockless() check as an selem in the
> commom paths (not bpf_local_storage_map_free() or

This isn't a bug, but there's a typo here: "commom" should be "common".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21539340647

AI-authorship-score: low
AI-authorship-explanation: The commit demonstrates deep BPF subsystem knowledge, contains a human-typical typo, and is part of a coherent patch series - all indicators of human authorship.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor typo in commit message (commom should be common) - no functional impact.

--===============2288734686524084231==--
