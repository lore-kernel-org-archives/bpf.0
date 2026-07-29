Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A84028F5
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314294; cv=none; b=Gz92HsnzDqddEizTs0oCTv59SsdFoH3d4Be4drKnV3wEXu9LBYwCyJnsUxBb3lj8C0PyPcvnXFxlF01Bno07AoxecVBatPfvoU3Y62+UsyM1Ca+r97nPOOm8r9MK+TR3HBz3O2pFx+no9M3F3TwxHkJX1nR0clJuVgZ2PxRYVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314294; c=relaxed/simple;
	bh=6uR74TMYPnVZPDUH/4XjrJpq7mHm6fOnhEFkF+97A+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tl2n0Fk4DwoRDkE1SZCopjusoXQuUuD6KqF6fXFhPOLj/kGIZ15/ULDMlH4G+/JTZADLd9gliE7RX7mKVSGrLRSxKHkI5ZJh1pihAouyaWfdf0OUZ8KDMTJjzwU4rvV1KnJSGOGT3DpEds/+9X83FHzms916qq5kfvz64f5+tOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LopinOBE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LopinOBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6E81F000E9;
	Wed, 29 Jul 2026 08:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314293;
	bh=kUAdAbBi9/MsYZ2oVTaHiuh4yI8+GJ1qlwkf7tGIQS8=;
	h=From:To:Cc:Subject:Date;
	b=LopinOBEmQ0VgQAf8RvJ0mZBj0Tq2LePIh7Isd0tXov1dEh2qwcn/eoAvyOYiEGAC
	 tiXInJmp17IOq2B8aNfdbzy1j8hisCVVHi2pA9uUlyZpClF6313T3qAY6NvLyWnt8K
	 1Yh4AetLgVMr/DTPx/lRJofyfJLYsR1AS1QEj2c/zpzv/qW7lam4+sOzsvsjD9S1hK
	 r30LzoLWqJZ8f8c+VBgr9xBFuHyJPcXFBpdtMDmjKsXXg24Q0MfZ8NMPAczo1przBq
	 DpwGxp7UQafORQecEETjLMVgXgQzrNV3dyyFwuGp44sS0WPGNNbzgqu0RV1ZQK6O4S
	 tRsK9HVr/d59w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCHv2 bpf-next 00/11] bpf: Disable preemption in stack map code
Date: Wed, 29 Jul 2026 10:37:56 +0200
Message-ID: <20260729083807.1588544-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we need to disable preemption for get_perf_callchain and keep it disabled
as long as we are accessing its returned trace entries buffer.

This patchset refactors both bpf_get_stack and bpf_get_stackid helpers as
suggested by Andrii [1] before applying the actual preemption fix.

Note the initial fix was sent by Tao Chen [2], but there was no follow up
on this since February, hence this post.

thanks,
jirka

v1: https://lore.kernel.org/bpf/20260720085351.655075-1-jolsa@kernel.org/

v2 changes:
- removed several unused functions arguments [sashiko]
- restore trace-nr value fix in bpf_get_stack_pe [sashiko]
- kept rcu locking together with preemption disable in __bpf_get_stack [sashiko]
- clear buf on error paths in __bpf_get_task_stack [sashiko]


[1] https://lore.kernel.org/bpf/CAEf4BzZwvAUgLwz-M0Y_NJLTmedyY9U6s7LrSmn751hQdTP4Uw@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@linux.dev/
---
Daniel Borkmann (1):
      bpf: Disable preemption in __bpf_get_stack

Jiri Olsa (10):
      bpf: Factor stackid_init function from __bpf_get_stackid
      bpf: Factor stackid_fastpath function from __bpf_get_stackid
      bpf: Factor stackid_new_bucket from __bpf_get_stackid
      bpf: Use stack id functions instead of __bpf_get_stackid
      bpf: Disable preemption in bpf_get_stackid
      bpf: Factor callchain_store function from __bpf_get_stack
      bpf: Factor callchain_finalize function from __bpf_get_stack
      bpf: Restore trace->nr value properly in bpf_get_stack_pe
      bpf: Remove trace_in argument from __bpf_get_stack
      bpf: Clear buf on error in __bpf_get_task_stack

 kernel/bpf/stackmap.c | 302 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 206 insertions(+), 96 deletions(-)
