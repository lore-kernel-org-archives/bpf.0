Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286242;
	b=P670ZSzEss0DQoT3c7qMBXWHF1/0db5QVFfH6ivvwqg2h+IHo125VyPPgheXZAIy/VUN
	 vND81+JxzSnPD0bzsqlYROsa15lvs5/mhMcmdmMp16b5VHFktHxAkiNHIzqGcZ4Ma0Rg/
	 0gZaAniULYmrV6F/9tjPbhiwJiuqPL+2K00YrJ1iUiw4I4SXGglrAx7IjO1Mfnzue6jqT
	 jrzykZB9Z8usOwT8yvl+C3pqC0lNz5SQQz5ZCCzS9H6gwq7rYpS/22fkjpJXEPQSQlWiM
	 PTYUYaUsdfVJwznDQzPloy4FvB4C/SwKPYtz/SMxMkBSaME7MlUES+3L6fpfpXFvNuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286242;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Zvo9XaPjJsmBZWuGvKozSh3F0TMQxR/9F0L4lHpZs0s=;
	b=qt1dkfsh075O3lydSrSM+4uLylXPjcU7qy2Sn5DrUcKdwVtK7UXqbiZ8bWgD9zTJ2oDe
	 iBYPfIRltW8lq75GQCfVWU6gGmT6/nqtf07H3Vq1l9iX3en95Pe79Zjs8nrFDgmCE4Qc/
	 bIy9igLrumfzUQe0AS9EO00sgnGnv6O8GtigA8gF8NnYD8hrVQJ2gmsvSbRsD7oSzBNy3
	 0IzhvdSeHfGAjhfkXJLW9pHIDhpWNxOBairCFlv9oMB2KQzFGtXAyVFoZRY4hiiW72Xdx
	 al4h7TdLaVymu5wNA2FULRKnOAFDVRwoHA9e+CV5BR2jjnWHw/2Ku/imVwB9K2ngFbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZwe9snt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA58606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZwe9snt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C301F0089F;
	Tue, 10 Nov 2026 04:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286242;
	bh=Zvo9XaPjJsmBZWuGvKozSh3F0TMQxR/9F0L4lHpZs0s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hZwe9sntBUGqeJzJSzN7X6PW6vUTa1C7j+jsc98a+JTUPfswcAn1mp3bux3YGOtuX
	 QPB8U+6ej0GsTTLP0D9l61XA49mIe/iWvtQV3y0QXE3BugNAUwCowOQFE8n7mfipv+
	 +UG2/9P3V+qfVShb7lp6ON24LYJGRUWaYZGLvP8rs/yfX7EynumrbNDC3iOQp9vGm7
	 mj4M2CQQvSRi9T9SrEPx0+J77XRBnMvCQh3kIATl2Hoa/F2wXJThstnjpvhBTfS9Em
	 nM3zujhgWSNWglErK3f2adhfi9ptPxlcQvagN8Svcc6OBPcc7Rju5HQMSKT2OZCaiC
	 htEUh6LM0QKLQ==
Content-Type: multipart/mixed; boundary="===============4537776757504593532=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a82b3b211fb09657299bca56e2a5fef683950834f05b7518c60fd759046d2ce0@mail.kernel.org>
In-Reply-To: <ddfc2cdff980669823aa44380dee237e36b648cf.1794269507.git.memxor@gmail.com>
References: <ddfc2cdff980669823aa44380dee237e36b648cf.1794269507.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 20/20] selftests/bpf: Test bpf_kthread_attach_cgroup()
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,shakeel.butt@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:50:42 +0000 (UTC)

--===============4537776757504593532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test bpf_kthread_attach_cgroup()

TL;DR: Commit message only: it names cgroup_exit(), which was renamed
cgroup_task_exit() and no longer empties the cgroup; cgroup_task_dead() does.
The test's polling itself looks right.

>     selftests/bpf: Test bpf_kthread_attach_cgroup()
>
>     Move a thread into a cgroup before its start and into another while it
>     runs, and check through bpf_get_current_cgroup_id() in its body that
>     each move took effect by its next iteration. The thread populates the
>     cgroup it is in, which cgroup.events reports, and the cgroup it left is
>     empty again; after the stop the second cgroup empties too, once the
>     thread's exit has left it, which the test waits for since kthread_stop()
>     returns before cgroup_exit() runs. The test's work directory has
>     controllers enabled for its children, so a move into it is refused with
>     -EBUSY, the constraint cgroup.procs enforces; the check needs a domain
>     controller enabled there, since threaded controllers alone leave the
>     parent able to hold processes, and is skipped otherwise. Nonzero flags
>     and a task that is no BPF kthread are refused as by the other control
>     kfuncs.
>
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

The changelog says the test waits "since kthread_stop() returns before
cgroup_exit() runs". Is that the right function to name?

In this tree cgroup_exit() was renamed to cgroup_task_exit() by commit
16dad7801aad ("cgroup: Rename cgroup lifecycle hooks to cgroup_task_*()"),
and it now only runs the subsystems' exit callbacks:

    void cgroup_task_exit(struct task_struct *tsk)
    {
            ...
            do_each_subsys_mask(ss, i, have_exit_callback) {
                    ss->exit(tsk);
            } while_each_subsys_mask();
    }

The step that empties the cgroup, css_set_move_task(tsk, cset, NULL, false),
which clears "populated" in cgroup.events, is in do_cgroup_task_dead(),
reached from cgroup_task_dead() in finish_task_switch().

The polling itself looks right.  Would it be more accurate to say that
kthread_stop() returns before cgroup_task_dead() unlinks the task from its
css_set?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755601621
--===============4537776757504593532==--
