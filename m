Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7641B4138
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 04:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769748068; cv=none; b=EBsOXA46PSvqcbHK5/dMkBek1AMpF3w4Pa38V3J2z+YqPsFmAl52Bd3s2CqP0Ov+DGU1vu1/X2NsUfG0ZvljRaq5QbB2dd4srhtvryEl495t0LLVCxEmMCCCQtj6xhhO3Wg9KWyyI6Z7Elyj0Zc0vRBTKpk/4mC7Jd9/k5QVWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769748068; c=relaxed/simple;
	bh=1Cyos39adMrdgVLY0jZzM0tZluNimrJHAEGHgnHbxB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjgKjHGZBRHFctxaESxT/sC0sNO1C+5UZ1lXkEtFHI7F4bLWJaajc72uhaTRLEAADj4aK40ihN55qCWoWIvO928stwb8cvX40hDVJIUlwIm9Ou8ZnFr13UtuGD/yFQMuhiLNFDE+DMTLUZa5WXlqg28FJ6Z/nYsQoB6bo+TsWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ddkrTBKh; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ddkrTBKh"
X-Forwarded-Encrypted: i=1; AJvYcCUSRAXx3XNN6RauV9jzCX+6pTeYRsSn/TzG0lFqIjivceRaH0Humb4lnqW2obAiSwkvch0=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769748064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poUS4vM9rHYGHWvOUpUh/Id1h6SEo5+dkcFnRx9fiFc=;
	b=ddkrTBKhPbXQ+/xhRCqwHxA99d4ThCsUtNZxsv7WIqpf5TmU+vibni+KFpq9cTvbksl0bH
	lhIyADu9ch3URVtwSyT82oAmmJsfoSlSeuUfdklRZd8/4BohBO3vDMFJnhTQKyzZMa1jYF
	Fsl5jF26SZhLYmIYhmyZ1kAuxr9SLFQ=
X-Gm-Message-State: AOJu0YwxjxBgGHplT0hlVbJuQBGgzRiihH+Sg4n4qv5ixxXtwJnVBgSJ
	CF9iSE7D0vzcItkIfDNAi5J5woOqynUiERy8E0YXw9eCv3YQkAN1fx6DPo49T5vQreb/XapmSSD
	SSAdtzxcKG4yveINfDdwquYeDMDXGewY=
X-Received: by 2002:a05:6102:2920:b0:5f5:2e63:f571 with SMTP id
 ada2fe7eead31-5f8e24e04f3mr566640137.19.1769748062182; Thu, 29 Jan 2026
 20:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129215340.3742283-1-andrii@kernel.org>
In-Reply-To: <20260129215340.3742283-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Thu, 29 Jan 2026 20:40:51 -0800
X-Gmail-Original-Message-ID: <CAGj-7pXkzS1sioE9t_wXZK=w0O-FDK3k4n6oEsruhnc1X_0=rQ@mail.gmail.com>
X-Gm-Features: AZwV_Qg5dfk2ht8JupIDFXTqsdxMg36LioUN_5yZDOZCUGFX3Rv7JHpElpOR8RI
Message-ID: <CAGj-7pXkzS1sioE9t_wXZK=w0O-FDK3k4n6oEsruhnc1X_0=rQ@mail.gmail.com>
Subject: Re: [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
To: Andrii Nakryiko <andrii@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com, 
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 29, 2026 at 1:53=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_loc=
k or
> per-VMA lock, whichever was used to lock VMA under question, to avoid dea=
dlock
> reported by syzbot:
>
>  -> #1 (&mm->mmap_lock){++++}-{4:4}:
>         __might_fault+0xed/0x170
>         _copy_to_iter+0x118/0x1720
>         copy_page_to_iter+0x12d/0x1e0
>         filemap_read+0x720/0x10a0
>         blkdev_read_iter+0x2b5/0x4e0
>         vfs_read+0x7f4/0xae0
>         ksys_read+0x12a/0x250
>         do_syscall_64+0xcb/0xf80
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>  -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
>         __lock_acquire+0x1509/0x26d0
>         lock_acquire+0x185/0x340
>         down_read+0x98/0x490
>         blkdev_read_iter+0x2a7/0x4e0
>         __kernel_read+0x39a/0xa90
>         freader_fetch+0x1d5/0xa80
>         __build_id_parse.isra.0+0xea/0x6a0
>         do_procmap_query+0xd75/0x1050
>         procfs_procmap_ioctl+0x7a/0xb0
>         __x64_sys_ioctl+0x18e/0x210
>         do_syscall_64+0xcb/0xf80
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>  other info that might help us debug this:
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    rlock(&mm->mmap_lock);
>                                 lock(&sb->s_type->i_mutex_key#8);
>                                 lock(&mm->mmap_lock);
>    rlock(&sb->s_type->i_mutex_key#8);
>
>   *** DEADLOCK ***
>
> To make this safe, we need to grab file refcount while VMA is still locke=
d, but
> other than that everything is pretty straightforward. Internal build_id_p=
arse()
> API assumes VMA is passed, but it only needs the underlying file referenc=
e, so
> just add another variant build_id_parse_file() that expects file passed
> directly.
>
> Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for=
 /proc/<pid>/maps")
> Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Tested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
