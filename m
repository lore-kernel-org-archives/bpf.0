Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6747126E;
	Fri,  7 Aug 2026 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104318; cv=none; b=Xkz84JL7Rp7HmPB8cOI2yIK4VIEq40c+xyJbE2oozmmjEiIFgaLAwk041sueiUGrA5vKn3pNeULDw4HrLfPJovcuCmzClGboUo7VxF07ksRqDo7HoycG/DedGL3SQwBvaqBau/j/O8icfk6tP1NO/P54aroScngnn8ywq7CrQcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104318; c=relaxed/simple;
	bh=HK6bB4RkZza2taxtADNDumCDoarmnE8s+VqYqci2C58=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Tnikz+MKQ9FvWBF2GCInAgv6sl6iqNUj6QGRX3aTWx6q4LzdUbAd07B1ndN6RMvFgLgnTLM7SIAPszEmLX0i86zEAy6Si54talE22bqY4e2E+oxId4+J5KkgWqBgxUA25+QcUn/q3xkl45mOwBKabvug0y8YIJQEjfJTXB/HmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYRf1KHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYRf1KHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06AB1F000E9;
	Fri,  7 Aug 2026 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786104302;
	bh=F0O/vwyOjW5BLxgWiK5+3RNrPEmfvU3SX8V2SAxQeOQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OYRf1KHI4u5lJ6+DZBVlBCjL8CjI+4UavWzL7Dt6dU9Y2Cj55oiua+Y8w3PwAL59V
	 7qKTYzi5TGIkrniSuTLJL8gVkq0q1E2ww3Lq5DMUSRogHmWZYkp3CY6Tg3rVp1WS2g
	 RjNBszkfq19YZiP2pUluL7DeuEne5r/qF6U2NYs6JfUnjuMFE+B9rHCE9smS14WnSp
	 MtnxUBAP765WkOipKfAJI/mPepfSUqobechd6FLWs9O7u/x/Ez7Oxe3jSePUdw7vug
	 rUdS8oILKczyyPoJNxruK35Mhy2nRJ8LZpo6ozTjumLpA+Y+qN9ULmNK8DDTMxbxqz
	 RCBw2Dv5yKCeg==
Content-Type: multipart/mixed; boundary="===============6802785607849162190=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5eb10995ebf94dd2c526d65efb472e748e8edf47ab7a7c660b3128011739b151@mail.kernel.org>
In-Reply-To: <20260807104403.1013064-1-pulehui@huaweicloud.com>
References: <20260807104403.1013064-1-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf v6] bpf, cgroup: Fix storage null-ptr-deref after replacing prog
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,andrii@kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ameryhung@gmail.com,pulehui@huawei.com,pulehui@huaweicloud.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  7 Aug 2026 12:05:01 +0000 (UTC)

--===============6802785607849162190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Syzkaller reported a storage null-ptr-deref issue after replacing prog.
> This occurs in the following scenario:
> 1. prog A, an empty prog, is attached to a cgrp.
> 2. prog B uses BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE and calls the
>    bpf_get_local_storage helper.
> 3. link_update is called to replace prog A with prog B.
>
> The reason is that __cgroup_bpf_replace fails to alloc and assign the
> required cgrp storage for the incoming replacement prog. Consequently,
> the new prog inherits an uninit storage, leading to null-ptr-deref panic
> when kick the new prog.

Is the description "inherits an uninit storage" precise?

Looking at the code, the storage array is not uninitialized in the C
sense. When prog A (which uses no cgroup storage) is attached, both
pl->storage[] and item->cgroup_storage[] are explicitly initialized to
NULL. When compute_effective_progs() copies pl->storage into
item->cgroup_storage via bpf_cgroup_storages_assign(), it copies the
all-NULL array.

So prog B inherits the previous prog's storage array, which is NULL for
the map prog B needs. The distinction also explains the broader case:
if prog A used a different storage map, the inherited pointer would be
non-NULL but belong to the wrong map, leading to a cross-map
out-of-bounds read rather than just a NULL dereference.

Would "the new prog inherits the previous prog's storage array (NULL for
the map the new prog needs)" be more accurate?


> Fix this by rejecting a link update if new_prog's cgroup storage is
> incompatible with link->prog.

Does the commit message capture the full scope of what this fixes?

The message describes only the NULL case from the syzkaller reproducer.
However, cgroup_bpf_storages_compatible() compares map pointers per
stype, so it also rejects the case where prog A uses map M1 and prog B
uses map M2 for the same storage type.

In that case, item->cgroup_storage[stype] would point to M1's live
storage, but prog B's bpf_get_local_storage() would return M1's buffer
while the verifier sized accesses against M2->value_size. Since
bpf_cgroup_storage_calculate_size() sizes the buffer from the owning
map, this would be a cross-map data disclosure or out-of-bounds read,
not just a NULL dereference.

Would it be clearer to mention that the fix also blocks the wrong-map
case to prevent cross-map access?


The commit message opens with "Syzkaller reported" but includes no
Reported-by or Closes tags. Two public syzbot reports match this issue:

  syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com
  syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com

Both are titled "general protection fault in bpf_get_local_storage" with
KASAN null-ptr-deref at the same location. The reproducers match the
3-step scenario call-for-call.

Should these include the standard syzbot attribution tags so the reports
get auto-closed?

Also, BPF_LINK_UPDATE calls that previously returned 0 now return
-EINVAL. This is an intentional trade-off for a less risky fix, but the
commit message does not mention the uAPI behaviour change. Might that be
worth noting?


> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4355ccb78a9c..5cc9b2d92fd5 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1018,6 +1018,20 @@ static void replace_effective_prog(struct cgroup *cgrp,
>  	}
>  }
>
> +static bool cgroup_bpf_storages_compatible(struct bpf_prog *old_prog,
> +					   struct bpf_prog *new_prog)
> +{
> +	enum bpf_cgroup_storage_type stype;
> +
> +	for_each_cgroup_storage_type(stype) {
> +		if (old_prog->aux->cgroup_storage[stype] !=
> +		    new_prog->aux->cgroup_storage[stype])
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  /**
>   * __cgroup_bpf_replace() - Replace link's program and propagate the change
>   *                          to descendants
> @@ -1056,6 +1070,9 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>  	if (!found)
>  		return -ENOENT;
>
> +	if (!cgroup_bpf_storages_compatible(link->link.prog, new_prog))
> +		return -EINVAL;
> +
>  	cgrp->bpf.revisions[atype] += 1;
>  	old_prog = xchg(&link->link.prog, new_prog);
>  	replace_effective_prog(cgrp, atype, pl);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31172497940
--===============6802785607849162190==--
