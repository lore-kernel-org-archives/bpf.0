Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2763845D5
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661681; cv=none; b=M8aI/3TpTK/fbHybZ8IyN6yYbjmJr2v9YQU+9tUNv5l0/5xtkWAZnmz8qycetZQjgNQxqZ0RC1wQ5B0BU09UQ5jH+2ryvPo0QS2B79cxuIajKdP1sry8GPU2iUFiHKFa1BeM8G4GXroy/Xl7SFTvwnfKQGWfF674onxpl5/tmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661681; c=relaxed/simple;
	bh=b/wSKf+/5peQcVEUihfgYh/ZR0rG670OFTpAaObQ89Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PeNx5B5PMUn42ZFWAleFG8Qn4+hUXIUohlOXzsgANNMGSBvdRsc6kxs621NkkGaiCg7AE3HBYKtp8XHwOh6O7kmtGMNjE8jv/DLjvM1tb+aZwEdsVFIhsqGWrsnusyImPp4c4uUy4ANLcRWfFROW70jYyCndi43avhx1sYgAleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMfIcwbQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMfIcwbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8552C19425;
	Wed,  4 Mar 2026 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661681;
	bh=b/wSKf+/5peQcVEUihfgYh/ZR0rG670OFTpAaObQ89Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=RMfIcwbQCCI3bxpHt2xCrYSdSXzAqv+vCFNyy/mxc4B18iT/us0EY7Kdp3M8nmrVE
	 QVX7lpAnkEGPoQ8VpZApmYPeuWXqxqWRZT35uHaPqsmmsoG5zZfkxNkEuf3FTc5SzH
	 olQzM7hDe0GaE8GmszdyeFnNNnvM+qMU4CEEe2RsqYASVhFrfcyEyQlYWVH/B9dhZS
	 t/mM3yLv+SMDkwd4izxW5DECeQ2uNY7Eml5Bbu9ITjFmMNQgMdyBUKepz6ivy/yY75
	 hzipaDzhkjEm3eH9Noky1+3euzbtf6mNgSzk6EsVfvMpyxHAQS5f3PJ0W7zkvuUZge
	 BUihg0qV8j1ag==
Content-Type: multipart/mixed; boundary="===============2208256736185863179=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c860945b84fb9b75ec9eb0299a4cab36c3afb69e9da90bab3d71c780e8cf18b4@mail.kernel.org>
In-Reply-To: <20260304210212.235096-2-dev@der-flo.net>
References: <20260304210212.235096-2-dev@der-flo.net>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add LINK_DETACH support for perf link
From: bot+bpf-ci@kernel.org
To: dev@der-flo.net,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,dev@der-flo.net,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 22:01:20 +0000 (UTC)

--===============2208256736185863179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3863,10 +3863,23 @@ struct bpf_perf_link {
>  static void bpf_perf_link_release(struct bpf_link *link)
>  {
>  	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> -	struct perf_event *event = perf_link->perf_file->private_data;
> +	struct perf_event *event;
> +	struct file *perf_file;
> +
> +	/* bpf_perf_link_detach() may have already released perf_file */
> +	perf_file = xchg(&perf_link->perf_file, NULL);
> +	if (!perf_file)
> +		return;
> +
> +	event = perf_file->private_data;
>  	perf_event_free_bpf_prog(event);
> -	fput(perf_link->perf_file);
> +	fput(perf_file);
> +}

[ ... ]

> @@ -4075,9 +4088,13 @@ static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
>  {
>  	struct bpf_perf_link *perf_link;
>  	const struct perf_event *event;
> +	struct file *perf_file;
> +
>  	perf_link = container_of(link, struct bpf_perf_link, link);
> -	event = perf_get_event(perf_link->perf_file);
> +	perf_file = READ_ONCE(perf_link->perf_file);
> +	if (!perf_file)
> +		return 0;
> +	event = perf_get_event(perf_file);

Could bpf_perf_link_fill_link_info() race with bpf_perf_link_release()
here?

After READ_ONCE reads a non-NULL perf_file, no reference is taken on
the file.  A concurrent BPF_LINK_DETACH on another CPU can call
bpf_perf_link_release(), which does xchg() followed by fput().  If
the perf event fd has already been closed by userspace, fput() drops
the last reference.  Once the detaching thread returns to userspace,
task_work runs __fput and frees the file struct.

At that point perf_get_event() dereferences file->f_op on freed
memory:

  Thread A (BPF_OBJ_GET_INFO_BY_FD)      Thread B (BPF_LINK_DETACH)
  --------------------------------       --------------------------
  perf_file = READ_ONCE(...)  [non-NULL]
                                         xchg(&..., NULL)
                                         fput(perf_file)
                                         return to userspace
                                         task_work -> __fput -> free
  perf_get_event(perf_file) -> UAF

The xdp and cgroup link types handle this by serializing
fill_link_info and release under a shared lock (rtnl_lock and
cgroup_lock respectively):

kernel/bpf/cgroup.c:bpf_cgroup_link_fill_link_info() {
    cgroup_lock();
    if (cg_link->cgroup)
        cg_id = cgroup_id(cg_link->cgroup);
    cgroup_unlock();
}

net/core/dev.c:bpf_xdp_link_fill_link_info() {
    rtnl_lock();
    if (xdp_link->dev)
        ifindex = xdp_link->dev->ifindex;
    rtnl_unlock();
}

The same issue applies to bpf_perf_link_show_fdinfo() below.

> @@ -4143,9 +4160,13 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
>  {
>  	struct bpf_perf_link *perf_link;
>  	const struct perf_event *event;
> +	struct file *perf_file;
> +
>  	perf_link = container_of(link, struct bpf_perf_link, link);
> -	event = perf_get_event(perf_link->perf_file);
> +	perf_file = READ_ONCE(perf_link->perf_file);
> +	if (!perf_file)
> +		return;
> +	event = perf_get_event(perf_file);

Same race as bpf_perf_link_fill_link_info() above -- a concurrent
BPF_LINK_DETACH can free perf_file between the READ_ONCE and the
perf_get_event() call.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22690413273
--===============2208256736185863179==--
