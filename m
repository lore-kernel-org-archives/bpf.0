Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49263B6BFA
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537637; cv=none; b=cvA3D1NjSMZchS8NAlc5UIBWE5N4cFf0YLOuuA+kczwK4oze4OrOnWxmwGOdmEYTaSTAD4jdNHyjkULAP+5JV1yjp6f0T1fdybYojTFNSpyS2e+uHLD8DVlqIK+kMKDh8UZlLOWaDNfRUWcS8gHStBY3zN7VM5inwHDRyLwNfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537637; c=relaxed/simple;
	bh=ZJDmvIT/dUIrUmVUCSaTbBArs3z0iJPFUsFC+M/KP9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HabOh0i6i6qdTf80V2Zm3D/48MoT9tRDWi53LtyGyXWHNqrxc1oUosMQJ1A9rHJtw6XxYThnA2YVS6CBDcJpsI0vdKiU2aUX6wbFnqU5bxeHPp9Fq/064nrRBPHea0/SV9jyl0juhA67uYZUg/xCUA7LnBHjK5hBMbfsIB813cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0LKOgVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0LKOgVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DD81F00A3A;
	Mon, 20 Jul 2026 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537636;
	bh=GK6ilRzpLgTLZh0DWBDUqcsFNsnKSCEygaGLLuOqa4o=;
	h=From:To:Cc:Subject:Date;
	b=m0LKOgVuiFe5Mp9U9kjUmv7NnU4uxu/poCXkPMOKUbQAsv0w6TxwGI6VGuAfxBHWq
	 8fta5hkpadyDkVY961bBwoIShxlgBlJyp1UDfPvri02jqoeBHqPD5Z5mEPq9FHa8GX
	 Nd9pBt0BYcHUO9DteKatyjtvvOx45gYsTHPBCY8JnhPX6zeYZCPkSIWroteLvoOV+B
	 V3H4jCSKSj6BT2g+ZzZu0xpdQLehMllDzsyKD96VViSHNTD8dF7rj9y9AkLIuAo+Lu
	 53xf/1PXHt9Yg/pwcJiR+VEUxGAay+Vopy8q82bHQTEGxFoYn1OUVa87wU0c0LTQO6
	 7TisKxc4ZeLng==
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
	STAR Labs SG <info@starlabs.sg>
Subject: [PATCH bpf-next 0/9] bpf: Disable preemption in stack map code
Date: Mon, 20 Jul 2026 10:53:42 +0200
Message-ID: <20260720085351.655075-1-jolsa@kernel.org>
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


[1] https://lore.kernel.org/bpf/CAEf4BzZwvAUgLwz-M0Y_NJLTmedyY9U6s7LrSmn751hQdTP4Uw@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@linux.dev/
---
Daniel Borkmann (1):
      bpf: Disable preemption in __bpf_get_stack

Jiri Olsa (8):
      bpf: Factor stackid_init function from __bpf_get_stackid
      bpf: Factor stackid_fastpath function from __bpf_get_stackid
      bpf: Factor stackid_new_bucket from __bpf_get_stackid
      bpf: Use stack id functions instead of __bpf_get_stackid
      bpf: Disable preemption in bpf_get_stackid
      bpf: Factor callchain_store function from __bpf_get_stack
      bpf: Factor callchain_finalize function from __bpf_get_stack
      bpf: Remove trace_in argument from __bpf_get_stack

 kernel/bpf/stackmap.c | 292 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 198 insertions(+), 94 deletions(-)
