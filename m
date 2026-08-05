Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776A3C98A2;
	Wed,  5 Aug 2026 04:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905531; cv=none; b=ag2wsGdgEyAsqSf8BIZW9YSBviBNmkL9KboWB9obuycVRGxFvM0QxebwYwaCUssCRBnGNNXvUGRSJTNB3eDIR+/tdVoQYfgbDBe04vkBco9M0Pk5TOXA26txqKYtqTDQ7vvJnboMveP8fNq+bYyZPT441rzboHLh9SzWEL16v6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905531; c=relaxed/simple;
	bh=a4LUF3bZanmHEmDrZRMZii8KQBsQI6+5hs/8LRILiWc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=obJZPlbqDVUqJ1ZhR/iZ6n5cjO/p0EP7+k7sMb1QS5mIEr9WE6KCSDXlhvwV08TofH6wRcwmzX0q8ooe2FyjvJhaw+PeALLw2ANLR8UQSjqCUkt7vYm0TF5d3FBglO4wLFn2OoYCKeAifGZcFI40MsUJm62HliF9gx4bSJKelBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glcAtbWZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glcAtbWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DCD1F000E9;
	Wed,  5 Aug 2026 04:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785905529;
	bh=e2gYLi2+JcnvzNRIfLeCuPf+IA++maWIxe9ndk3VeMs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=glcAtbWZKA0ROq08BmG8712HMwn5NeMyPl1SXSxoHIOD/c8aaJ/pRk913f3KqMMUe
	 FxjgDANgvOgyOZKZeg1tRoJWk99dIZ90gvIjEYQ4pEpp21/4tTQOM/mEEM1z39++rS
	 QghBYRtkEkH/fUNLHTU4rJHH0bwsYcx54JnoqF9OCd08tUD2VKioVuK+WFk03TYjJN
	 ll61g9NLopRmI8fmy+kXp8XKoyyV9hE9AkRFLz88RApiKHfY4ocM9tdA9Dbm7VjpoX
	 wGEULaJ6j5zKBoWJNKHwO0RqT9YbCiG8i+/Yy14kFWo4eIQfpFMKCdc1m+VV09wfOl
	 4z9lh+eILcEdw==
Content-Type: multipart/mixed; boundary="===============3405158989766790260=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <00b5f983aa8501c2b8244c108cd9abe61f1e900cdef765f7e7cdf4f012cc6bea@mail.kernel.org>
In-Reply-To: <20260805035342.349421-1-pulehui@huaweicloud.com>
References: <20260805035342.349421-1-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf v5] bpf, cgroup: Fix storage null-ptr-deref after replacing prog
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,andrii@kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ameryhung@gmail.com,pulehui@huawei.com,pulehui@huaweicloud.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Aug 2026 04:52:08 +0000 (UTC)

--===============3405158989766790260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit c953408b860e553dc6831c7b95e870d0d1ef878d
> Author: Pu Lehui <pulehui@huawei.com>
> Date:   Wed Aug 5 03:53:42 2026 +0000
>
>     bpf, cgroup: Fix storage null-ptr-deref after replacing prog
>
>     Syzkaller reported a storage null-ptr-deref issue after replacing prog.
>     This occurs in the following scenario:
>     1. prog A, an empty prog, is attached to a cgrp.
>     2. prog B uses BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE and calls the
>        bpf_get_local_storage helper.
>     3. link_update is called to replace prog A with prog B.
>
>     The reason is that __cgroup_bpf_replace fails to alloc and assign the
>     required cgrp storage for the incoming replacement prog. Consequently,
>     the new prog inherits an uninit storage, leading to null-ptr-deref panic
>     when kick the new prog.
>
>     Fix this by rejecting link update with -EPERM if new_prog's cgroup
>     storage is incompatible with link->prog.
>
>     Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
>     Reviewed-by: Amery Hung <ameryhung@gmail.com>
>     Signed-off-by: Pu Lehui <pulehui@huawei.com>

The commit message says "Syzkaller reported" but there's no Reported-by
or Closes tag. Two public syzbot reports exist for this exact issue:

  - syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com
  - syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com

Both reports contain KASAN null-ptr-deref traces at
____bpf_get_local_storage, and the public C reproducer matches the
described 3-step scenario exactly.

Should the commit include Reported-by and Closes tags so syzbot can
auto-close these reports?

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4355ccb78a9c..5cc9b2d92fd5 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30973728779
--===============3405158989766790260==--
