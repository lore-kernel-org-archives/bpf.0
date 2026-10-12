Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D054AF679;
	Mon, 12 Oct 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822821; cv=none; b=FHTCmJ6TvtyoMLmUyy2r8FniLQcC5RkYF/NQzT46TQrzdUXl02Fy4OY910y8pYs3DmqBS8b96zNWYgd1V6oQAZGPNZNpyNpYIkwyye/ldSS30NAbKCbeOFYAcQiglY1pDvdjzY0YJPqmosrRhUYbXNvIumy5p23X8upRqsNbizQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822821; c=relaxed/simple;
	bh=k/bLWMyo1MfdY38bfB6FeVYLTuUFGWf52fDcfjOarFI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IDQHiX8ut65dztLYHTOUPAdaE2J11o6KQQNEf0lrOjncmXa65wpBYdnaGUUoDOuYSKGvJhub72jDyfT0I4Npn5IjfjzytwJUEuvKsz4ZtYSqoiadQFAnq98pFdeH7lSckCY+Qjlef3KzUoZ4tmQ4AlCEr/nE3Rx7umIfWvEQyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVCnjLQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVCnjLQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7ADE1F0089B;
	Mon, 12 Oct 2026 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791822819;
	bh=2DrFPHb/Fo1ylluShOQcMbUKXa3rzjizd/SdjXA1biM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VVCnjLQfpX31M9l8MjNB3Hdnkz0t0z58FwGToTrm36hA3X1ymN8cRvexjEpeIhv+9
	 lkfcSM1leYwVByMdzD9IL1TDJewRKtPjNnq3AzOFpO/8vyeB9CcCf+a1ZsEbJvhVS2
	 d8HQxJQGOBoy47YuZibor+cnGHYlcb+vozj5IkQ8n+mEUWoJgUM3s7B1QUZp+aXfto
	 tAW1YAeTnVRFtg8q9BODeZPjsXxHU2XDBE35nnpKZSR8MldGQkWC6GY8OQNf+Up0J5
	 Inozfx7NqGvbFE2QBa/11rNvl3WyjGD2otLUdTqh847VjP9tXGXraN43Iu3XVjh4T4
	 HBJoB528dkWSQ==
Content-Type: multipart/mixed; boundary="===============7230923938768893541=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c25b0427c6767cbd93957b11c0b85088c4d0a8e7f5f303b3e69f24c092a93a09@mail.kernel.org>
In-Reply-To: <20261012154024.29423-15-leon.hwang@linux.dev>
References: <20261012154024.29423-15-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 14/21] bpf: Add tracing_multi link info support for bpf progs
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,yatsenko@meta.com,avinash.duduskar@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,jordan@jrife.io,rongtao@cestc.cn,eyal.birger@gmail.com,pulehui@huawei.com,tanjingguo@huawei.com,malin89@huawei.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 16:33:36 +0000 (UTC)

--===============7230923938768893541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add tracing_multi link info support for bpf progs

TL;DR: The new -EINVAL in tracing_multi fill_link_info may break existing
userspace, e.g. bpftool link show, when querying links with bpf prog targets
without func_btf_ids; it may stop listing later links.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 8b1a52350cfd..39c911917ae2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> @@ -3725,9 +3726,13 @@ static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
>  	info->tracing_multi.attach_type = tr_link->link.attach_type;
>  	info->tracing_multi.count = tr_link->nodes_cnt;
>  	info->tracing_multi.btf_obj_id = btf_obj_id(tr_link->link.prog->aux->attach_btf);
> +	has_progs = !!tr_link->tgt_progs;
> +	info->tracing_multi.flags = has_progs ? BPF_F_TRACING_MULTI_TGT_PROGS : 0;
>  
> -	if (!uids && !ucookies && !uaddrs)
> +	if (!uids && !ucookies && !uaddrs && !fids)
>  		return 0;
> +	if (has_progs != !!fids)
> +		return -EINVAL;
>  
>  	if (ucount < tr_link->nodes_cnt)
>  		err = -ENOSPC;

Does this new -EINVAL break existing userspace that queries a tracing_multi
link with bpf prog targets?

A caller written before this change passes ids, addrs and cookies, but has no
way to supply func_btf_ids.  For example, the bpftool already in the tree does
a two-step query in do_show_link():

    if (info.type == BPF_LINK_TYPE_TRACING_MULTI && !info.tracing_multi.ids) {
        ...
        info.tracing_multi.ids = ptr_to_u64(ids);
        info.tracing_multi.addrs = ptr_to_u64(addrs);
        info.tracing_multi.cookies = ptr_to_u64(cookies);
        goto again;

On the second call, for a link with prog targets, has_progs is true and fids
is NULL, so this check returns -EINVAL:

    if (has_progs != !!fids)
        return -EINVAL;

bpf_link_get_info_by_fd() returns before copy_to_user() when fill_link_info()
fails, so the caller also never sees the new flags value that would explain the
failure.

do_show_link() then prints "can't get link info: Invalid argument", and
do_show() does:

    err = do_show_link(fd);
    if (err)
        break;

so "bpftool link show" stops at the first such link and does not list the
links after it.  Any other tool that only wants addrs or cookies for this link
type would hit the same error.

The reverse direction also fails: a link without prog targets and a non-NULL
func_btf_ids now returns -EINVAL for a request that would have succeeded
before.

These queries worked before this commit.  The check looks like it is needed
only because ids now changes meaning, and carries prog IDs when has_progs is
set:

    put_user(has_progs ? prog_id : btf_id, uids + i)

Would it work to keep ids as BTF IDs and return the prog IDs in a separate new
array, or to fill only the arrays the caller asked for, the way ids, addrs and
cookies are already optional one by one?

The commit message does not mention this behavior, and no later patch in the
series changes it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38273555988
--===============7230923938768893541==--
