Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A652CCD8;
	Tue, 29 Sep 2026 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703149; cv=none; b=no7yHzqz2KheC5EcW9De5UDm+b522425ieR1z4FZD8LaeItpnApMGXD/rW98pxL6CZjg6Edc/GWrBGZpsUJLa5ZQcnPxHGssoOajA1M3FYsFpe0EcL+EfFggfZze78D5qt+aHNsesEh3NKHfCg7cu0OwGR6OvGN7yDHrSxZyhx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703149; c=relaxed/simple;
	bh=3TZ8g5UCZHMa88MVXJ635FkC/44FvB2ynhkEJHzRIzk=;
	h=Date:Message-ID:From:To:Cc:Subject; b=u2k+/b9RscTeiX6nwXTYhNfbE7WS17Q3qZcaZjxDMe2ZqY/FRYEhGZFhYoWauo3fqaCpvcpCoNkMy7+mB13Ss84gwox3hurGfsQiAswW7VBv8eD7K2dfEaVmYJ9qwBZqPl9BxOaBHHYFDyAviGudtoIAwF8iRnccj9tu+nboUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P47vVT9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P47vVT9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634121F000FF;
	Tue, 29 Sep 2026 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703147;
	bh=CINuwoEbhNpzdGEObXiChmnQ1GyrltWXLggIbeowDI0=;
	h=Date:From:To:Cc:Subject;
	b=P47vVT9XU43/wBQnCRmW3o3kuVH4HCZ3ebQ3TrRphxPJdAo2zC2EOtzCgS3UHP/2v
	 QIkZTWFJuuJczCCu5EvAwr7qat9zMUgQiXOGPFs8U9gf9QNuGGRQxP5K0slqeKMqAh
	 AtI63pDZqioG9RZG3vUIm7Qrv6LS85QFt8K2N1cwZn45qu351cerwsZLQiRUqr7ARw
	 Zn4kJaeyTmEC6fIc5mdLLHquOqpvRiqHXoghNdn+GXEbWKXhviKRKPWKZMJ/LYcUFM
	 sIB4QIG8A+enV3D1Yig0ZD5uD0A98zfv/KHLYHV0xxoxW6YK27H8xl9eo7x4PMQYQm
	 S+ZW/84nb7HMg==
Date: Tue, 29 Sep 2026 07:32:26 -1000
Message-ID: <7c139810be5ffc9764ed4236efc28794@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.4] sched_ext: Work around pahole 1.32 dropping
 scx_bpf_task_set_lazy_resched() from BTF
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

With clang and pahole 1.32, x86-64 vmlinux BTF lacks
scx_bpf_task_set_lazy_resched() and sched_ext fails to initialize:

  sched_ext: Failed to register kfunc sets (-22)

clang describes the lazy argument only after the prologue moves it into a
callee-saved register, which pahole 1.32 rejects as not being the argument
register. Released pahole is affected whatever the eventual fix. Keep the
argument on the stack with barrier_data() so that its location names no
register. OPTIMIZER_HIDE_VAR() would fix x86-64 but break arm64.

Fixes: f8e5a4e3f3be ("sched_ext: Add lazy preemption support")
Link: https://lore.kernel.org/r/20260925213619.2187751-1-yonghong.song@linux.dev
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -10136,6 +10136,11 @@ __bpf_kfunc bool scx_bpf_task_set_lazy_r
 {
 	struct scx_sched *sch;
 
+	/*
+	 * clang's register locations for @lazy make pahole 1.32 drop this kfunc
+	 * from BTF. Keep @lazy in memory so its location names no register.
+	 */
+	barrier_data(&lazy);
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
