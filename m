Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33CC337105
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790918; cv=none; b=YbTqPLbE/fj3cVVAkes0gTW1lViV9tx56BwMU08cr0IQ0CK5V8u9qv+7g61e+vVUG/PzxvWsnjCasHlE/da70rqns5A8VYTOb5vVyAt536zpZo2u2o8j5zXX+PCbXpdpPhyx7N+ZdWZMxZuETTokf5WDPaw2sZAt3Kv1hkP6VEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790918; c=relaxed/simple;
	bh=+QiWrVPGmrUsmtVToRcnMohfq+JwGEO7Dv8cND2PGLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkDpSC/KzVfLqwnl/tPj1jr5VhIr9++b9h6HAXsPfUJThJ+dhbZJzlk5Sl4chrJFJpJEl8UBi3Z0Q/9UaS8I35u6VoU6hSoYqvohGxyHEl9H07SNQ/fG+THnqo35UiSBnsvH010EHCXgJ+7bwM40GybRSxXiw/I/Ibuqxj4pwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izjOE03K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izjOE03K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D191F000E9;
	Mon,  3 Aug 2026 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790915;
	bh=sb1aiAcRHM/Gf14lRpQj1VeiIN45XxW4vD1PE/JJcJc=;
	h=From:To:Cc:Subject:Date;
	b=izjOE03K9I+UeACRm4A69SJfs8ZlTqTWL0VTBS4stPqH8j0D85kXSqKcdsFflIvC2
	 gPhA4wfqbIMsGneake73NuXAV3Aqs0watCRyyZ5hZL7pp0KzdzIUzOPwUUXPh6yxGZ
	 bNkQdbvblh+ujT6QRBrSe/KED3OBlRSvJHQRz+jbThVPyEr/OPBUXJ/P7Vk2dJd9vn
	 uSYwjKQMRcxsnfRROZZg28CzcAWzldGwfFT+Mrv9uyD/PoQvmBkSVV4mACtvk11WAx
	 thU31KvDTWPFhUsltkAW3iy7Eb4JhTfdVTeyeSwv8/i7u827DdjzjQHNYn7ei1as+k
	 1ba7hz0fi9p+A==
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
Subject: [PATCHv3 bpf-next 00/12] bpf: Disable preemption in stack map code
Date: Mon,  3 Aug 2026 23:01:37 +0200
Message-ID: <20260803210149.296496-1-jolsa@kernel.org>
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
v2: https://lore.kernel.org/bpf/20260729083807.1588544-1-jolsa@kernel.org/

v3 changes:
- pass flags rgument to callchain_finalize [sashiko]
- renamed err label to out in bpf_get_stackid_pe [sashiko]
- used scoped_guard in bpf_get_stackid [Leon]
- replaced trace->nr modification from *_pe helpers with length
  argument (new patches 11,12) [Andrii]

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

Jiri Olsa (11):
      bpf: Factor stackid_init function from __bpf_get_stackid
      bpf: Factor stackid_fastpath function from __bpf_get_stackid
      bpf: Factor stackid_new_bucket from __bpf_get_stackid
      bpf: Use stack id functions instead of __bpf_get_stackid
      bpf: Disable preemption in bpf_get_stackid
      bpf: Factor callchain_store function from __bpf_get_stack
      bpf: Factor callchain_finalize function from __bpf_get_stack
      bpf: Remove trace_in argument from __bpf_get_stack
      bpf: Clear buf on error in __bpf_get_task_stack
      bpf: Avoid changing callchain in bpf_get_stack_pe
      bpf: Avoid changing callchain in bpf_get_stackid_pe

 kernel/bpf/stackmap.c | 313 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
 1 file changed, 205 insertions(+), 108 deletions(-)
