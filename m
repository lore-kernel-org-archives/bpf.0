Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB22ED16D
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511077; cv=none; b=RIVeGRy17N4ryG2J5vQKX+cg5WWYgqFx/0fMSsAC1BXQOpC/rW9tPScGXd0rlbUgRL6WIAN7lQjUtgdEdVpxv7BEHOtH+1HGkh24Ty6yQ5eqQXnerjuibzGSqi5ZzJN8Gyahh86iMGVjs9ihp+Eqft98eRKn172d2JnlJv/ZeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511077; c=relaxed/simple;
	bh=1n5ilJ4462ZX19EAr5QpwS0/AuoSMAJRYZZn1KHuohc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=T+YmSibzTxerxBi7uYve+bSmc3urIo9u+laRgNv14UOIWZAhZPXzJ97K3BrGpqdAJZdDJzf/zUISBAhEpriL9dMByIeV6QCdNTf40L2fjbsrPCSX++6TuzwpS9fsY0w1MSxYmxgRMfFeOQtQDUfQe1Y/UfeEjMh/GcR95AC29QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jt27CldZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt27CldZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C7E1F000FF;
	Fri,  9 Oct 2026 01:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791511075;
	bh=33iuv/iAVzU3x/sZJ9QltwdiQJmP+LClOEAxqfl3X2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jt27CldZ2Ol9RLNzNenlz+kGSLDThXR4mW/5OltILdKGMhsMAXIuuGyXNVRF8MjSK
	 DxjhH7dVQ6MWygMcdovLhe66w1PTOA1Z1ede2mq15ACPqQdZNCo0/UBt6BzoHSGVf4
	 wkT+5QT6aRXJosVGAdRlkAvqSrUzUjzKVDj8uM9E5azJxxxO0fM2i1pu9hps2/i0Z8
	 9wPuQDegmxeKMrC3VLDFa+HbpVNoyh0JMHfo2zuNmg8qpjXOCn0U3f92E/Z/uxuR3I
	 6j78XGSFEd1qnMZwRStihpXsTH0A1u470PnrHzVn4ahiy4yyRLIksXxrM7XVCy5v9b
	 KJjgFvRGeP3Pw==
Message-ID: <sashiko-outbox-164714@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Drop the on_enter recursion
 check of task_local_storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-selftests-bpf-task-ls-recursion-v1-1-c3a3e3c41f8c@gmail.com>
References: <20261009-selftests-bpf-task-ls-recursion-v1-1-c3a3e3c41f8c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 01:57:54 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: incomplete fix for flaky task_local_storage recursion test
--

commit 93ecb8817313103c1cdb556cb288695d3d3c939c
Author: Qiliang Yuan <odys.yuan@gmail.com>

selftests/bpf: Drop the on_enter recursion check of task_local_storage

This commit removes the recursion misses check for the on_enter program
in the task_local_storage test to fix test flakiness. It prevents failures
caused by preemption-induced spurious misses when other tasks trigger
sys_enter on the same CPU.

> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c =
b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> index 5b2b56cc3a4f3..c03ea94325d9e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> @@ -138,12 +138,6 @@ static void test_recursion(void)
>  	ASSERT_OK(err, "get prog info");
>  	ASSERT_EQ(info.recursion_misses, 2, "on_update prog recursion");

[Severity: Low]
Is this exact-match assertion susceptible to the same preemption-induced
spurious misses that this patch aims to fix for on_enter?

The on_update program is an fentry program attached to the globally shared
bpf_local_storage_update function, which also executes in a preemptible
context (rcu_read_lock_dont_migrate()).

If a task is preempted while executing on_update, its prog->active recursion
counter remains elevated on that CPU.

If the preempting task (such as another selftest thread running in parallel)
calls bpf_local_storage_update, the fentry trampoline will check the elevat=
ed
recursion context, increment the program's global recursion_misses counter,
and abort before the test_pid filter inside the program is evaluated.

This spurious miss could randomly push info.recursion_misses above 2, leavi=
ng
the test flaky.

Would it be safer to relax this check to
ASSERT_GE(info.recursion_misses, 2, "on_update prog recursion")?

> -	prog_fd =3D bpf_program__fd(skel->progs.on_enter);
> -	memset(&info, 0, sizeof(info));
> -	err =3D bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
> -	ASSERT_OK(err, "get prog info");
> -	ASSERT_EQ(info.recursion_misses, 0, "on_enter prog recursion");
> -
>  out:
>  	close(task_fd);
>  	task_ls_recursion__destroy(skel);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-selftests-=
bpf-task-ls-recursion-v1-1-c3a3e3c41f8c@gmail.com?part=3D1
