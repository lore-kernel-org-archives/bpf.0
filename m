Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A2360EC3;
	Fri, 19 Jun 2026 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858830; cv=none; b=nx62sOpnElHJzpsCA6BRZTn3w4Pr5iteG81s33d5vLH752Zf32givcndAfMtSDmPDOEfDY9sq/liagftimGBXhIyH/hReK+lGh6iJgGOU6MtU3L6QV+rYrrVtqsU+NY8JoYdrjNNush7NUXMW5oKF3Jp7LtEiZQdJ7ceVyhdKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858830; c=relaxed/simple;
	bh=uLbnRyBCl+G21HT2eocAtnU8YiIX8TjALWLHBtpMqCU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qW7c+DKJ7WhBDFt+Z2oNQzQurXPKml7iTI+YZpWYNaQoTt0X+ABfUu/M6q4Rzn8fMGV4hBJ75DBHpO+TqxX4cX1odiuAlixlBYmcYSmIDdjZnYyfmtsyzP9zdjUOZ9KSbcSf0JXmX8sktI9fBSzNHOOOVgwvV9diC1nAlzl9RHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiLRXS0M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiLRXS0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD8C1F000E9;
	Fri, 19 Jun 2026 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858828;
	bh=jyoGc1besgldATEc9nvVUvFEnZ3Cn41D/3HcNcb6WyA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KiLRXS0M1J/JAWkSlj1cwUtDxJLny5d9y55r7mYb8IIO44qkT7iGtlOB7qOLB8Mqg
	 DU2fPfy2lqXjFniygwws1tT5e6jFxmDBZalgyNJuIXTCLq44nGBpEr0oa0eL1IFUHd
	 iQm+VN9jXi4RpSjvMFVMbovyoGAFwXxFsGhALpr5a1KgCUvCh4+GfAczUv3E3iON0q
	 fMzAMPGoQge9xNHuaT8VIr8urP15lEZpb/0EteGeJHoadTgERhdybZscIOrfAUr9an
	 vLIq0LEwY59kB8mBKNoQnmGMMd60ODAOW0d1XwkchCwSccZhUVUT3j7Giyzo4jOs/X
	 1ywiiMxuMxzBw==
Content-Type: multipart/mixed; boundary="===============6665164561341181599=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <23e064af54162c9bcf55ac486982924d38ed28b8193903c003523f65166a124c@mail.kernel.org>
In-Reply-To: <264dd4a10d3abdd037e01ccc6da44e5a5758dee2.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
References: <264dd4a10d3abdd037e01ccc6da44e5a5758dee2.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover refcount acquire node offsets
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: chenyy23@mails.tsinghua.edu.cn,john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,vmalik@redhat.com,leon.hwang@linux.dev,davemarchevsky@fb.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 08:47:07 +0000 (UTC)

--===============6665164561341181599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Cover refcount acquire node offsets
>
>     Add regression coverage for bpf_refcount_acquire() on graph-node-derived
>     pointers.
>
>     The accepted case pops a list node and normalizes it with container_of()
>     before acquiring a refcount. The rejected cases pass popped list and rbtree
>     node pointers directly to bpf_refcount_acquire(), which must fail because
>     those pointers carry non-zero fixed offsets.
>
>     Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

This adds coverage for a verifier bug where bpf_refcount_acquire() did not
require its argument to have a zero offset, so graph-node-derived pointers
from bpf_list_pop_front()/bpf_rbtree_remove() carrying a fixed node-field
offset could pass the type check. The companion kernel fix that rejects
those offset arguments tags the commit that introduced the kfunc. Should
this selftest commit carry the same tag?

  Fixes: 7c50b1cb76aca ("bpf: Add bpf_refcount_acquire kfunc")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27814304568
--===============6665164561341181599==--
