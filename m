Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973BF366
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190417; cv=none; b=tTIbXxNG3CwCozkKojS24NROrMwNzlNcmVSiYTUbCAyllPbqM6V1HPiU+Y5LmGMYgFh3g9T1q5ntFZ2HXHVOgKP8sUphvHeIXCN/gVVcANuM2ZiVK1Y346hmG6uiN+COgFCWakENU0t5N2tbfoiMLykuCv5oCrCsD2CNcfGIkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190417; c=relaxed/simple;
	bh=J2cJVREpMd0J6pYYq5Qen9CfrkiKoC3VyVuCmbEiNpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhXyKJQf4w5fmS3Jo3AqqfrI+lOMMAUZpvbWkMHgZ7rWjcVtCxnFDJnatUi0nu72uAQoSkj8nWcYjHWu0BzhWhqR4GkLtgb8yLLaByjDKV1NmRQDL0f0zSDf+sIpdjJQNIXXfRi9yylMcZ8CSzJT4GLrNRw2Lq6WZyRjSxm3vv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1qdhpoX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1qdhpoX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016A0C433F1;
	Thu,  4 Apr 2024 00:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712190417;
	bh=J2cJVREpMd0J6pYYq5Qen9CfrkiKoC3VyVuCmbEiNpU=;
	h=From:To:Cc:Subject:Date:From;
	b=r1qdhpoXkhQok2ZPufjdKrQYyAfdGzx0jWQEXfxS+oRvBBhsAyes47ozOLugT0KbP
	 AWHp7PCRFAPGw2jEyCqwh8VwNiU+TFVexP9hS3mlqp/a93YbeQNmTw8a38dV1WCln/
	 CLe1lih2DwM3mpFa6GPLKq6jcIAiz2eWtwQ+Qo3jnkmtDewn2OgCGAXi2EaMpBfBFP
	 uM+lMCwjM4tla3CBt4sDeLvdwP5LpUrS3ASrc0BeTfSAXESQQuPyhxlofmeaE+JHJq
	 lHeV+O/b7Oy5DNrj8rAt5dC0a6WjJ8ZgojvgnnJlpgh5tOWMD9Vj8kLIHKeAPpXDEq
	 mzhCPJi23RuZw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 bpf-next 0/2] Inline bpf_get_branch_snapshot() BPF helper
Date: Wed,  3 Apr 2024 17:26:38 -0700
Message-ID: <20240404002640.1774210-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement inlining of bpf_get_branch_snapshot() BPF helper using generic BPF
assembly approach. This allows to reduce LBR record usage right before LBR
records are captured from inside BPF program.

See v1 cover letter ([0]) for some visual examples. I dropped them from v2
because there are multiple independent changes landing and being reviewed, all
of which remove different parts of LBR record waste, so presenting final state
of LBR "waste" gets more complicated until all of the pieces land.

  [0] https://lore.kernel.org/bpf/20240321180501.734779-1-andrii@kernel.org/

v2->v3:
  - fix BPF_MUL instruction definition;
v1->v2:
  - inlining of bpf_get_smp_processor_id() split out into a separate patch set
    implementing internal per-CPU BPF instruction;
  - add efficient divide-by-24 through multiplication logic, and leave
    comments to explain the idea behind it; this way inlined version of
    bpf_get_branch_snapshot() has no compromises compared to non-inlined
    version of the helper  (Alexei).

Andrii Nakryiko (2):
  bpf: make bpf_get_branch_snapshot() architecture-agnostic
  bpf: inline bpf_get_branch_snapshot() helper

 kernel/bpf/verifier.c    | 55 ++++++++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c |  4 ---
 2 files changed, 55 insertions(+), 4 deletions(-)

-- 
2.43.0

