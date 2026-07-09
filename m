Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D2D3AEF3F;
	Thu,  9 Jul 2026 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577428; cv=none; b=YgfSmaPHzIuAiUipopncxt0EqgjJDsx0OxOd/OTeXc9jr4oYCwUJM22KAt09nEZIv+LB6Ix9MiY8TsM1jAFGxQxC/sIeGtzkL9pSPK6Bw9iQ1FZo7yFyht7L3Nkud/K0PLJSxCB+C8qocRChKJPPSjpUeD/j1JkrLBKzaijb6o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577428; c=relaxed/simple;
	bh=bPNDwOPiG035eOhcU96ZHW+msToVj63qNu1NAkkev/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kdH5hnxHRiyBp1GX5we76yNpej5uQwXZYvBxS24GiVsrizyB1zx6ymZ9QvkJfzSxf0G3vr086KxMjet0QBi/uRm6mS+RmDf94nGcg3SU8tWrVGJXKeW0zz7nQOT74q5WklOUDD/pthdElkOgky2+rHre2T8grr7tgqtCUfEvu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvV2K3sz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvV2K3sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FC61F000E9;
	Thu,  9 Jul 2026 06:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783577427;
	bh=CIkNwZ7nMFY7uLeY/M03JlFvrLKir84WY7ubj1DL2fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JvV2K3szCZMYts06IDRE3HcRW1XFl0gZtOWwM3QfdWYa8IkSRGrsvMbYoq3klrp1D
	 ssHUlUe5dDb8WtUb8RKdpDsygvYkHYB14M+gWnpGYoRXVwJhEIuDCB4YO+QXk6lZi0
	 8TqjttqJKJ/2QwhiFPxO9Weba33LAfpONDqgyZZQeCwR6GL6ar4Ns/6H29uZYNBT8h
	 TmZdF3/Ud8AFNeClhUxRx633pAbCtXguXGbXJa8JvDEhPsL5i9kMl+CJedsEkOMSyr
	 wOamvGUPSY3B/MLA/VyXZEcYYN11gMk3sn+czf7eUhPtk/S3zHzsjQ8Kv49pmDAQ2q
	 4k1EjQ0Ri+NdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199313938EB4;
	Thu,  9 Jul 2026 06:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7] bpf: Fix use-after-free on mm_struct in
 bpf_find_vma()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178357740590.3266297.8223176580830669953.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 06:10:05 +0000
References: <20260708072106.199637-2-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260708072106.199637-2-sanghyun.park.cnu@gmail.com>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: yonghong.song@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, memxor@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, emil@etsalapatis.com,
 puranjay@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed,  8 Jul 2026 16:21:04 +0900 you wrote:
> bpf_find_vma() reads task->mm and calls mmap_read_trylock(mm) without
> holding a reference on the mm. On a foreign task, a concurrent exit_mm()
> can free the mm_struct between the lockless read and the trylock,
> resulting in a use-after-free. mm_struct is not SLAB_TYPESAFE_BY_RCU.
> 
> For the current task, task->mm is stable. For a foreign task, pin the mm
> under task->alloc_lock and release it with mmput_async(), mirroring commit
> d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded task_vma iterator").
> Use spin_trylock() instead of get_task_mm() so BPF context does not block
> on alloc_lock. Reject irqs-disabled contexts and !CONFIG_MMU on the
> foreign-task path because dropping the mm reference is not safe there.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
    https://git.kernel.org/bpf/bpf-next/c/47b079e2117a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


