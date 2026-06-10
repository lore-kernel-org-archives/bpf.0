Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B8165F1A
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109670; cv=none; b=KAIeKCHrYdiBdHqFX4JIbbLi5o1ummUFS30NeZbKEdyA7ROWonsG5IT02yANcvIj8ihuM4eqCPoOvRPReU4pJn139CXuaqO8JcyKHvhlr5xBjFYeo/E4LyAYOoVa3dpT8Jy7BBk3kdyyupf1NGYBWQvTdmuNp1IfcIaxufALKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109670; c=relaxed/simple;
	bh=sMlFZ+DIk3rgITvqAV0wZLMEoCVHWN+Zd7pFr80mZIg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IOCT2qREXDPQpJQUdTKP5gLt2ZcPsO3ucsdjVooISMGpC8IKe58/9kv+NH07pLLsSx4An22l2SW1yn6LXIkdJDiY7CaQynxZIM75rzTIiXJ4K7uZrZAgqRff8puust1WGTbbvNlriLnJUyp852e1ujOiXorHzIxB6fwgVlqd0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8Wdp86+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8Wdp86+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523B21F00893;
	Wed, 10 Jun 2026 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781109668;
	bh=c53ie+LjcCfCiVn6za2HA1UFLBsSRph21DPsGU5BrYA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=E8Wdp86+W90I8iuSk5z3zVQ5Z7u8O1iVXKUzpbF1CokuEK+Fpxg06jpsHdVQELfIc
	 yOoMEdaygk0xa0ktts8lhyZxxkltMqhaza2MQeiQczwTehcpE/lRUyA1/6PUtkv9Bi
	 1zZpnrhvWHzJBrL6iSEepNs9RMmEtNrCxNZgxwjgmlXf+XuBVVFX5GHhNTbLdnjJ37
	 mpp3hDKTyuhR1X9EQ0i2vOUfi+dsCPL+nzY9wonFtmweGfIzABpDw/82MfqyjZdVou
	 YNZnY9PBPjqSztaqXeYs/mKxKObz2YBJenGJ+HZCaDkfqe4PWeiSjSF5VE6eNy7+Mx
	 buf3TwLerqo3A==
Content-Type: multipart/mixed; boundary="===============1414888445444349159=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6103c8e74c0e49f1b025b2887d6b05c766d712b4efcf2a6c08ea3573d542ddc2@mail.kernel.org>
In-Reply-To: <20260610155225.1221740-1-utilityemal77@gmail.com>
References: <20260610155225.1221740-1-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add cgroup kptr NMI deadlock reproducer
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,bpf@vger.kernel.org
Cc: memxor@gmail.com,utilityemal77@gmail.com,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Jun 2026 16:41:08 +0000 (UTC)

--===============1414888445444349159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Exercise the path where a cgroup kptr stashed in a BPF map has its
> destructor invoked from NMI context when the map element is freed.
> bpf_cgroup_release_dtor -> cgroup_put can take sleeping/spinning paths
> that are unsafe to enter from NMI; the destructor must be deferred
> instead of run inline.
>
> The test stashes a cgroup kptr from a syscall program into a HASH map
> with BPF_F_NO_PREALLOC, then drives map element deletion from a
> tp_btf/nmi_handler program firing on PMU cycle counter NMIs raised on a
> pinned CPU. Each round:
>
>   1. Creates a cgroup and stashes its kptr in the map.
>   2. Removes the cgroup and waits for css_free_rwork_fn to fire for
>      every subsystem CSS (tracked via an fexit program), so the kptr
>      drop hits the window where the bug reproduces.
>   3. Arms the NMI program (gated by an "nr_cgrps" counter) and waits
>      for it to delete the stashed element.
>
> After REPRO_ROUNDS iterations the test scans /dev/kmsg captured from
> the start of the run: bpf_cgroup_release_dtor appearing in any splat
> stack means the destructor ran inline from NMI and the fix has
> regressed. The task variant only proved no hard hang; scanning kmsg
> catches the bug even when the inline path does not actually wedge the
> CPU.
>
> This fails and causes a kernel splat prior to commit a3a81d247651
> ("bpf: Cancel special fields on map value recycle") in bpf-next/master.
>
> Runs on x86 only: relies on PMU cycle counter NMIs and the
> x86-specific nmi_handler tracepoint.
>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

This reproduces a bug where a referenced cgroup kptr stashed in a map
has its destructor run inline from NMI context on map element free.

The eager free of a referenced kptr on map update/delete came in with
commit 14a324f6a67e ("bpf: Wire up freeing of referenced kptr"), which
added bpf_map_free_kptrs() and wired it into the update/delete paths via
check_and_free_fields(). The kernel fix referenced here, a3a81d247651
("bpf: Cancel special fields on map value recycle"), carries that same
Fixes: tag.

Should this reproducer also carry:

  Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27289488363
--===============1414888445444349159==--
