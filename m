Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6F220F38;
	Sat, 28 Feb 2026 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772264611; cv=none; b=AwUD6c/RIrRDmIqz5/BbzZmB0HjadPUfo90oAGIqVkIXFpf9fBryXpyrR0UTTI92FBT0tCyK149K9YCE90fUmJCL9Tuv4cX3+3qEWutI0Hhu8plXh1BrNnmTViRzus6d9sKcHIGDvuriXjGdqLILbOVfO5ZUUkOEnyrk+xuxLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772264611; c=relaxed/simple;
	bh=H1bpnLDJ/oRCoESIr3ahRspZCq3AqInXncUTkTvEyiI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=usRnFICyUPOu2AuZ2Fl80d330ZwRnsij2Wb/6CR7QweCTyPOkIFaehLuzu15d7IVEQQq9SNf52sV/oe6vr5Uzdot3D3dj1BSe13b/0yDW4vO3GN3PCMgqxzuWUj/rgwOPLXWugizoDuD+hi3U3WE10WWp4fuDxwFgkcYn3nZBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePQ/ijWx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePQ/ijWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2F8C116D0;
	Sat, 28 Feb 2026 07:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772264611;
	bh=H1bpnLDJ/oRCoESIr3ahRspZCq3AqInXncUTkTvEyiI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ePQ/ijWxyphGRf9XAOiBJ1iabWRnVVkEkHvSwr6InyCDmGxEjK1ewktX1DQsriTvZ
	 VStUb9in+vtbPYGbpJrRJjtbkbSa02xTyRvpj7A7BRUOLztcEOxzR9ci1GzcJhwWJo
	 wu6XONFy4UB1I1viTy84cFQOG2WR3DkfFXx6kEfuLQ8FHdFXgShO3EeH+HAwcDr5nB
	 dNDw7MTsA/w0GEYpYXV3hehhSXMj1OxY58S0PRjlrLRffUdf6DXxdi9J2PBiY7Dfdj
	 EwerzJNAujQR3Hj6nMGh7MD6AloMzVfnnzNlgHV1mpNdwxqzg4gqnQVs4bg0AxLaes
	 N2KC6tFCWJbDA==
Content-Type: multipart/mixed; boundary="===============3304529628171439076=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <37025e89615d78e40004a517cac185bf6c8d9e023831c1650b8fa4abf9bf648e@mail.kernel.org>
In-Reply-To: <3a788ec239e9f9590897b43d21995e3a3532d916.1772261955.git.zhuhui@kylinos.cn>
References: <3a788ec239e9f9590897b43d21995e3a3532d916.1772261955.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Use bpf_core_enum_value for stats in cgroup_iter_memcg
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,inwardvessel@gmail.com,roman.gushchin@linux.dev,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 28 Feb 2026 07:43:29 +0000 (UTC)

--===============3304529628171439076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The change adds runtime enum value resolution for:
> - node_stat_item: NR_ANON_MAPPED, NR_SHMEM, NR_FILE_PAGES,
>   NR_FILE_MAPPED
> - memcg_stat_item: MEMCG_KMEM
> - vm_event_item: PGFAULT

The commit message lists "memcg_stat_item: MEMCG_KMEM" but this patch
does not touch MEMCG_KMEM at all.  The prior patch in the series
(fa0721ccce66 "selftests/bpf: Remove kmem subtest from
cgroup_iter_memcg") already removed the MEMCG_KMEM usage entirely.

Should this bullet be dropped from the commit message?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22516077164

AI-authorship-score: low
AI-authorship-explanation: The stale MEMCG_KMEM reference left in the commit message after restructuring the series is characteristic of a human forgetting to update text.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Commit message lists a MEMCG_KMEM change that does not exist in the patch, causing a mismatch between the commit description and the actual diff.

--===============3304529628171439076==--
