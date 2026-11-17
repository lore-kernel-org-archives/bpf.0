Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914095;
	b=onqMJsbfvFc/WoUvfcg1UJfvlPOwlQ8f2Xkonw88IumAMD71O/HAL4sqKWoNtt14Q5LC
	 SJcL9IfDenks0yCx+RSwkRtJBKMkppU7zYacenmNr4Aej9aIkWEEORZ/pW9sfOj4sEyOg
	 ACXCxMEjqTQibfTEB6c2XRd/1d+5zYg4HpzsPPyKroUzEnLvOkh2kLPSzYseQF4n+qthU
	 AzE4jzxiZct/JNf0SzprgktpgWJUJBLSWD2/U7L3XzndQgqDPXRwou5PedqfUWXwdsijC
	 OiJ8EFwoo3lpflJwoYEBJlETgUiW521KY4e2XoJrDpF4OQATcnAVOWNHZMKtt7laheA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914095;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=6YWTMS8olwbe+NdhLHm3e8T6gYXMU1tTD6sXec2cb60=;
	b=aNajh/za1x/f7s9mcgFbVqrxbz0dbYRCuhrfyv7x85Ijqib5wyeWP94iSmU+NnkXECGf
	 pQ56dOQw0xVihWAVTbi5yHzlRl7kQawH2AuWtFtt/PsSd3WshpZR0xcReVmATeJC9kioZ
	 NM7ZfsObK6/g2X7gJrC173+0ziIt3qRuADW5ezWl4XiC+uyfrt+meYrPvUToz0hyCWfco
	 Vz+lW4GBfJqLXP2pKuAKGgAtFWyuv8Q4ll1wcP+SNMkhz0sSfPMWwjuB95ZLZhEWCIlo/
	 8IKYrEHZbkpq0x5X+IlCBFMl48td0Bac6yLHDsGnA1dq+bgBXPlO+no00SNIR3KxkeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKFPQHpd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E308606A31C;
	Tue, 17 Nov 2026 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKFPQHpd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EAC1F000C4;
	Tue, 17 Nov 2026 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794914095;
	bh=6YWTMS8olwbe+NdhLHm3e8T6gYXMU1tTD6sXec2cb60=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QKFPQHpdbjoKd81tpHCEHbbYf0AewUfOCMHj0vqvj14CC46BubTwGbJ8Nax5vmMdx
	 d7GcoWkYWL9WrWfq+4ytBFK6LmV0wqDXveKe+rvShonYIFZQ5FI0kHmLQcPjvGL4D1
	 miNHeImiF4QiT3MdR3TZQIu2t9GXwS13o9SsJZWTCkp3E23unck6Wbr68QZWj4qER3
	 1hxnnFwNEC1vlD1lpPWp+nwulj6hCEjefjFpfpogsu5v3+wyjU9Ty51pw0RESX9rUA
	 x9Bu7R5Vttk/T4px77whzc/kPKi9l5XCVccpZw4LP+GI97Oaa+F6OzkLvBFY4e4Ykw
	 USee4YwEiHHKQ==
Content-Type: multipart/mixed; boundary="===============3794039846956546039=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2969e017a13f38b2f802a4d14a4ce565eada4a0da9d5e5bcb7b75be7b67dc670@mail.kernel.org>
In-Reply-To: <20261117103028.4105609-2-arighi@nvidia.com>
References: <20261117103028.4105609-2-arighi@nvidia.com>
Subject: Re: [PATCH 1/3] bpf: Allow importing memfd pages into an arena
From: bot+bpf-ci@kernel.org
To: arighi@nvidia.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,tj@kernel.org,void@manifault.com,changwoo@igalia.com,joshdon@google.com,vineethrp@google.com,yepeilin@google.com,zhiw@nvidia.com,ltrager@nvidia.com,balbirs@nvidia.com,skolothumtho@nvidia.com,himadrics@protonmail.com,royfru44@gmail.com,bpf@vger.kernel.org,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 17 Nov 2026 11:14:52 +0000 (UTC)

--===============3794039846956546039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow importing memfd pages into an arena

TL;DR:
- bpf_arena_import_memfd() may run in another task via bpf_task_work, mapping
  a victim's memfd into the caller's arena without CAP_PERFMON
- Commit message memcg accounting claim may be wrong for memfd holes

> bpf: Allow importing memfd pages into an arena
>
> An arena can only map pages it allocated itself, so its memory can be
> shared only with the BPF programs and the user space that map the arena.
>
> Teach the arena to map pages that it didn't allocate and add a sleepable
> kfunc for syscall programs that imports the pages of a memfd, or of any
> file on tmpfs or hugetlbfs:
>
>   int bpf_arena_import_memfd(void *map, void __arena *addr,
>                              u32 page_cnt, int fd, u64 off);
>
> The folios are pinned with memfd_pin_folios(), like udmabuf does, and
> mapped at addr. Whatever maps the file then sees the same pages as the
> BPF programs, for example a VMM that maps it into a guest.
>
> Each import is kept in an interval tree with its pages, which belong to
> the file, not to the arena:
>  - bpf_arena_free_pages() over any of them releases the whole import:
>    the pages are unmapped and unpinned, the data stays in the file,
>  - they are released when the arena is destroyed,
>  - they are not counted in the arena memory usage,
>  - the arena mapping raises SIGBUS on them (SIGSEGV with
>    BPF_F_SEGV_ON_FAULT): user space accesses them by mapping the file.
>
> The file must be open for reading and writing and the LSMs must allow a
> shared mapping of it. It must not be append-only or sealed against
> writes.
>
> F_SEAL_SHRINK is not required, unlike udmabuf: a file on tmpfs, such as
> a VMM memory backend, can't be sealed. If the supplier shrinks the file
> or punches a hole in the imported range, the arena keeps the pages it
> pinned, which are no longer the file's.
>
> While its pages are imported, the file can't be executed, as when it's
> open for writing.
>
> The pins aren't charged to locked_vm: like the rest of BPF memory, the
> pages are accounted to a memory cgroup, the one of the supplier that
> allocated them (hugetlbfs pages come from the hugetlb pool). Pinning
> them adds no memory, but keeps it from being swapped out until the
> arena releases it. Only a program with CAP_BPF, or a BPF token, can
> import pages.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
>

Doesn't memfd_pin_folios() allocate folios for any holes in the range?  A
memfd that was only ftruncate()d would get every page allocated by this call
(shmem_read_folio() for shmem, a pool allocation for hugetlbfs).

arena_import_file() has no bpf_map_memcg_enter() around memfd_pin_folios(), so
those shmem pages look like they are charged to the memcg of the task running
the syscall program, not to the supplier or the map.  They also stay in the
file's page cache after the import is released.

The changelog says "Pinning them adds no memory" and that the pages are
accounted to "the one of the supplier that allocated them".  Could it describe
this case instead?

---

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index aff231922e11..799a8cf1ee72 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> +static int arena_import_memfd(struct bpf_arena *arena, long uaddr, u32 page_cnt, int fd,
> +			      u64 off)
> +{
> +	int ret;
> +
> +	if (off & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	CLASS(fd, f)(fd);
> +	if (fd_empty(f))
> +		return -EBADF;
> +	/* BPF programs read and write it like a shared mapping, which needs the same */
> +	if ((fd_file(f)->f_mode & (FMODE_READ | FMODE_WRITE)) != (FMODE_READ | FMODE_WRITE))
> +		return -EPERM;
> +	ret = security_mmap_file(fd_file(f), PROT_READ | PROT_WRITE, MAP_SHARED);
> +	if (ret)
> +		return ret;
> +	return arena_import_file(arena, uaddr, page_cnt, fd_file(f), off);
> +}

The fd here is resolved with CLASS(fd, f)(fd) against current, and the
FMODE and security_mmap_file() checks run with current's credentials.  The
kfunc is KF_SLEEPABLE, and the verifier treats bpf_task_work callbacks as
sleepable, so a BPF_PROG_TYPE_SYSCALL program can call it from one.

Can this run in the context of a different task?  For example:

  bpf_task_from_pid(victim_pid)
  bpf_task_work_schedule_signal(task, &val->tw, &map, cb)
    cb()
      bpf_arena_import_memfd(&arena, addr, n, victim_fd, off)

bpf_task_work_callback() runs cb in the target task, so victim_fd is looked up
in the victim's fd table and security_mmap_file() is checked against the
victim's credentials.  A read/write memfd held by the victim (a VMM guest
memory backend, for instance) would then be pinned and mapped into the
caller's arena, where its BPF programs can read and write it, and copy it into
ordinary arena pages that the caller's user space maps.

bpf_task_from_pid() and bpf_task_work_schedule_*() need no CAP_PERFMON, while
other ways for BPF to read another task's user memory (bpf_copy_from_user_task,
the probe_read_user paths) do.  The commit message only says "Only a program
with CAP_BPF, or a BPF token, can import pages".

A bpf_wq callback runs in a kworker, so there the fd is resolved against the
kthread's file table instead.

Should the kfunc refuse to run from async callbacks, check that current is the
task running BPF_PROG_RUN, or require CAP_PERFMON (KF_PERFMON) or a
ptrace_may_access()-style check?

[ ... ]

> +BTF_KFUNCS_START(arena_syscall_kfuncs)
> +BTF_ID_FLAGS(func, bpf_arena_import_memfd, KF_ARENA_ARG2 | KF_SLEEPABLE)
> +BTF_KFUNCS_END(arena_syscall_kfuncs)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44067070819
--===============3794039846956546039==--
