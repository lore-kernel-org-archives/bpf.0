Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050853A168B
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762737; cv=none; b=ZTcwJsmBE3Pp4Yumgn5Lv+Yqjfcl2ftPHa7jRzcexYJtSr2ZqZj20qNET8CJ8IgFroisezrFsrloOB9FmO5ljQubHOj+K/M0lRo723NLbNi7vOZAnTqE91mI6GIY3cbAuRkHK+arHjrZU9dgWJEmuTp8Mx03HVze1Av6nd/g0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762737; c=relaxed/simple;
	bh=vQUaDSjRR/ZPalsjeMlNkmzGSegDha0gTz96+9tFb6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wrr9Js9eT5U3AYEZv3DFQjrcgyvE3bRYTHwt0KKEV+PCLWiruRHymqUj09i7peBO0bCpe2A/SSYVFF/MysMX5+c/bvzgPXWEMNL2n7iow28Uj5DSSo8lTLFCff/HarCgNFUQE+fNHGbz7BVotUuwMBy2ajFh3DQli0G5XBv/jrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PXJCYHb5; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PXJCYHb5"
Message-ID: <927ceffb-15a4-4aec-a3f6-0854f24e4bcc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776762733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvLMhhAiaRLnEwG9GWUhqNSYSfzhjAswX3TL1L1ilTo=;
	b=PXJCYHb5InGJhCKCFQXqsvOSUDauA52AZ2BItmDZ2Qhwt8zCGvbEYb++wwGB+mgXwoVT5G
	BoeTYDOhRYSYZW3Z0kc/79QqPfC9+RbMYQ7muqvZiR4DaOK2MaNR8E5Y74jXr3vy99weNo
	iN1DujVk89/UxpzGv6S7RzAVEyJ6oJ8=
Date: Tue, 21 Apr 2026 17:11:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Uninitialized Stack Variable / NULL Pointer Dereference in
 __sys_socket_create via BPF LSM hooks
To: Quan Sun <2022090917019@std.uestc.edu.cn>, daniel@iogearbox.net,
 bpf@vger.kernel.org
Cc: dddddd@hust.edu.cn, M202472210@hust.edu.cn, dzm91@hust.edu.cn,
 hust-os-kernel-patches@googlegroups.com, edumazet@google.com,
 kuniyu@google.com
References: <567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/21/26 2:32 PM, Quan Sun wrote:
> Our fuzzing found an Uninitialized Stack Variable vulnerability in the 
> Linux Socket Subsystem. The issue is triggered when a 
> `BPF_PROG_TYPE_LSM` attached to the `bpf_lsm_socket_create` cgroup 
> hook uses the `bpf_set_retval()` helper to return a value greater than 
> 0 (e.g., `1`). This bypasses the actual `socket_create` execution but 
> returns a success status back to `__sys_socket_create`, which then 
> accesses the uninitialized stack variable `sock` leading to a NULL 
> pointer dereference or potential privilege escalation.
>
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> ## Root Cause
>
> This vulnerability is caused by treating a manipulated return value 
> from an LSM hook as complete success in `__sys_socket_create` without 
> ensuring that the underlying object has been fully initialized.
>
> 1. `__sys_socket_create()` in `net/socket.c` reserves a pointer 
> variable `struct socket *sock;` on the kernel stack without 
> zero-initializing it.
> 2. It calls `sock_create(family, type, protocol, &sock);` to allocate 
> and initialize the socket object.
> 3. `sock_create` proceeds to allocate the socket internally and 
> invokes the `security_socket_create` LSM hook (which triggers 
> `bpf_lsm_socket_create`).
> 4. If a BPF program is attached to the cgroup LSM hook for 
> `bpf_lsm_socket_create`, it can call `bpf_set_retval(1)` and return `1`.
> 5. Because the BPF hook completes without an error code (< 0), 
> `sock_create` interprets this bypass as success and promptly returns 
> `1` (or a positive bypass value) back to `__sys_socket_create()`. 
> However, the critical variable `sock` is never populated.
> 6. The caller `__sys_socket_create()` checks if `sock_create()`'s 
> return value is `< 0`. Since `1` is not less than `0`, it assumes the 
> `sock` pointer is valid.
> 7. Subsequent socket operations inside `__sys_socket_create()`, such 
> as `sock_map_fd(sock, ...)`, attempt to dereference the uninitialized 
> `sock` stack pointer.
>

A similar topic to the one you reported before [1], and it seems Feng is 
working on this [2].

[1] 
https://lore.kernel.org/bpf/973a1b7b-8ee7-407a-890a-11455d9cc5bf@std.uestc.edu.cn/

[2] 
https://lore.kernel.org/all/20260408094816.228322-1-yangfeng59949@163.com/


If you really want to panic the kernel, you can see that the following 
hooks probably cause this problem as well:

- security_task_alloc
- security_inode_readlink
- security_task_movememory
- security_inode_follow_link
- security_fs_context_submount
- security_dentry_create_files_as
- security_perf_event_alloc
- security_inode_get_acl


