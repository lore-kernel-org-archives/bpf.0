Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE682FE066;
	Tue, 27 Jan 2026 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483328; cv=none; b=LPvzkLiJgf0AMF5yzHBs1gWpt7ZBUirYsfUmLz1YoRzn196HXKybpOG2xkkbYWqheLwC3Kvh7nJ5uNuQ0Zq+qqK1izlmCBrSRAMy2RRo2NC6Z5S5T+ywnNGlO2UlYpc9YWsvdjnZENb/DPCzQiWGie5q96SlXD5akOKn9RQkwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483328; c=relaxed/simple;
	bh=a1b2aQXIN/L4Gpj6LgmmhuqN9Jndua/2+iFvK7cxtm4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uCeSUrcXzYLalJq/K038mZ5Y/RcEIbGaqZOJYQbQv/SFXs0scUymp/s7ykAZMwFa5OO+O6CcoJbIe3TMClyZcDfhl1TSSnrP2+btZzmQ63OVUG46gd9D3fUyI3VaucYtoC6N/25cmHSQWq9+in14OQrtkwuov+ZdKPMFcx8IImk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCPou7q1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCPou7q1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086F5C116C6;
	Tue, 27 Jan 2026 03:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769483328;
	bh=a1b2aQXIN/L4Gpj6LgmmhuqN9Jndua/2+iFvK7cxtm4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nCPou7q1yCRL/sE6p9zB2mYkYKoj0vOtiQSCMZUm3fqaSOmbkvzp5MFtEgoPU9DMn
	 F/34Yq/g/vvKQMr+MnjGywNw4OK81VMcC+jDZxiYiQqyayzQvDlqNlk6jONjXq3JjN
	 wztf5vgNBxFy3gDSQIRZO7ub0xIuVKa1mBZcaPbxFBUQdNiYXBptO23EDbnUDW2Eno
	 0AFylcn2M7CkjN3vzwYDjwcs2p0V0aCOETMXaDobluGElrW8KA6VAYeh6Yoy4yf4Al
	 I5aGZFdppBptp6WZ34YJlAuBLuxu7U64EkCGejj8pctl8pf+nCOO53kTZPYr0M1Rms
	 N/4FeGmH2o7iA==
Content-Type: multipart/mixed; boundary="===============7709352325939003635=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <51757d82f7eb33e5988562b54a6c0ae11ae6a4275b2b3150189cdeed2bd96c29@mail.kernel.org>
In-Reply-To: <20260127024421.494929-3-roman.gushchin@linux.dev>
References: <20260127024421.494929-3-roman.gushchin@linux.dev>
Subject: Re: [PATCH bpf-next v3 02/17] bpf: allow attaching struct_ops to cgroups
From: bot+bpf-ci@kernel.org
To: roman.gushchin@linux.dev,bpf@vger.kernel.org
Cc: mhocko@suse.com,ast@kernel.org,mattbobrowski@google.com,shakeel.butt@linux.dev,inwardvessel@gmail.com,linux-kernel@vger.kernel.org,linux-mm@kvack.org,surenb@google.com,hannes@cmpxchg.org,akpm@linux-foundation.org,roman.gushchin@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 03:08:48 +0000 (UTC)

--===============7709352325939003635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 69988af44b37..7b1903be6f69 100644

[ ... ]

> @@ -307,12 +308,23 @@ static void cgroup_bpf_release(struct work_struct *work)
>  					       bpf.release_work);
>  	struct bpf_prog_array *old_array;
>  	struct list_head *storages = &cgrp->bpf.storages;
> +	struct bpf_struct_ops_link *st_link, *st_tmp;
>  	struct bpf_cgroup_storage *storage, *stmp;
> +	LIST_HEAD(st_links);
>
>  	unsigned int atype;
>
>  	cgroup_lock();
>
> +	list_splice_init(&cgrp->bpf.struct_ops_links, &st_links);
> +	list_for_each_entry_safe(st_link, st_tmp, &st_links, list) {
> +		st_link->cgroup = NULL;
> +		st_link->cgroup_removed = true;
> +		cgroup_put(cgrp);
> +		if (IS_ERR(bpf_link_inc_not_zero(&st_link->link)))
> +			list_del(&st_link->list);
> +	}

Can this code access st_link after it has been freed?

Once st_link->cgroup is set to NULL, if another CPU concurrently closes
the link FD, bpf_struct_ops_map_link_dealloc() will see st_link->cgroup
as NULL, skip the cgroup_bpf_detach_struct_ops() call, and proceed to
kfree(st_link). Then the bpf_link_inc_not_zero() call here would access
freed memory.

The race window is between setting st_link->cgroup = NULL and calling
bpf_link_inc_not_zero(). During this window:

  CPU 0 (cgroup_bpf_release)     CPU 1 (close link FD)
  ---------------------------    ---------------------
  st_link->cgroup = NULL
                                 bpf_link_put_direct()
                                   bpf_link_free()
                                     bpf_struct_ops_map_link_dealloc()
                                       if (st_link->cgroup) // false
                                       kfree(st_link) // freed!
  bpf_link_inc_not_zero() // use-after-free

Would it be safer to call bpf_link_inc_not_zero() before modifying
st_link fields? That way, if the link is already at refcount zero,
the loop would skip it; otherwise, the held reference would prevent
the concurrent free.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21382620878

AI-authorship-score: low
AI-authorship-explanation: The commit is authored by a known kernel maintainer with a consistent, human-like technical writing style and appropriate kernel development patterns.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Use-after-free race condition in cgroup_bpf_release() that can cause kernel crash when link FD is closed concurrently with cgroup deletion.

--===============7709352325939003635==--
