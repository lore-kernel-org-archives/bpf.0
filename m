Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB4136672;
	Sat, 21 Mar 2026 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774131226; cv=none; b=Os1psFE0mK1KrD9Z47eXSvJvEYMKJxPMgrV+jQ67nN0p39WAseERCbvL9B/VH2MmbgrZnBnvOH6sxEU5yJeoSY4mu3Yj2FmoVmwJtBc6ZOiDdHG1sML84G0OQA7y8GtB7QWJ4PicJnQHanXkak4Zyg8TZKcmKIbDF3UW1hy+ZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774131226; c=relaxed/simple;
	bh=kwkeyBmrv18phuth62zF+7Yjh8Ms9pKcy554mFefy3w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VHOqZvok7ko2gY4WJAqxHxfjFbtfFy2PjHzTsU/yP0np0z6MGQiiiF05LYBP4ZF+PSXf3rTFSRoNTNgSdvxcx4yfkfmvAXOvxQ0fNDcPzCLS3Sflpaq3X5hbKDUiNss+r4Ag2lBaqpx259sDvx7L6YNmB7e1nMVcDGdPCBWpt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s78mlUWj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s78mlUWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02773C19421;
	Sat, 21 Mar 2026 22:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774131226;
	bh=kwkeyBmrv18phuth62zF+7Yjh8Ms9pKcy554mFefy3w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=s78mlUWjo2b0JJyBn4xAPEeQtfpY8aN1a+Nw1ldo4/pa/QSw8HvWhWSVZdKx7PqnD
	 DRAOVZcrEu+WGk3BD+wMvQw+vx11jTxYwyCK0iXfs9mf5SHLisZkjwYV/wv/HdrmhO
	 6GhVrIOT0czBbQDHKSocnVtibhXNJYUui9HhaOeKm48Ll3m+Yp+4VX8tj+Gu8FN7sk
	 tp5EzUXBFrwmv7xuVoxJPxXZ8fso5rXT18r4PqoZo2VEhvkBBUNcblBzzTfWBmIr7a
	 nhzTGvSQNneY2AFSJiWVMmX+hNS3xCZQXqqnhcJl5sAWIZUox5LNgb3RjJVbV9JvHh
	 OxuNuL8zyD+NQ==
Content-Type: multipart/mixed; boundary="===============7003719102216081742=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <923f781f67dc846a8e61ed40f4ce45fc3ae71ba0db3ca3074a02153f33f5c887@mail.kernel.org>
In-Reply-To: <20260321214038.80479-1-varunrmallya@gmail.com>
References: <20260321214038.80479-1-varunrmallya@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add test for struct_ops __ref argument in any position
From: bot+bpf-ci@kernel.org
To: varunrmallya@gmail.com,keisuke.nishimura@inria.fr
Cc: ameryhung@gmail.com,andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,haoluo@google.com,john.fastabend@gmail.com,jolsa@kernel.org,kpsingh@kernel.org,linux-kernel@vger.kernel.org,martin.lau@linux.dev,sdf@fomichev.me,song@kernel.org,yonghong.song@linux.dev,varunrmallya@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 21 Mar 2026 22:13:45 +0000 (UTC)

--===============7003719102216081742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c b/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c

[ ... ]

> +SEC("struct_ops/test_refcounted_multi")
> +__failure __msg("program with __ref argument cannot tail call")
> +int test_refcounted_multi(unsigned long long *ctx)
> +{

Will this test pass without Keisuke's fix [0] being applied first?

The stub function has task__nullable as the second argument and
task__ref as the third.  prepare_arg_info() populates the arg_info
array in order, so info[0] corresponds to the __nullable arg
(refcounted = false) and info[1] to the __ref arg (refcounted = true).

In check_struct_ops_btf_id(), the loop that sets has_refcounted_arg
currently reads:

    for (i = 0; i < st_ops_desc->arg_info[member_idx].cnt; i++) {
        if (st_ops_desc->arg_info[member_idx].info->refcounted) {

This always checks info[0].refcounted (the __nullable entry, which is
false), never info[i].refcounted.  The __ref argument at info[1] is
never examined, so has_refcounted_arg stays false and the tail call
is permitted.

Since the test expects __failure, but the program loads successfully
without the fix, the test will always fail when run on a tree that
does not include the companion verifier fix.

This patch may need to be folded into (or applied after) Keisuke's
fix so the two land together.

> +	/* ctx[2] is used because the refcounted variable is the third argument */
> +	struct task_struct *refcounted_task = (struct task_struct *)ctx[2];
> +
> +	bpf_task_release(refcounted_task);
> +	bpf_tail_call(ctx, &prog_array, 0);
> +
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23389590355
--===============7003719102216081742==--
