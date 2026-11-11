Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431121;
	b=HGTgD980q9pURAuxCSvs2lSsv75qbSWQNwyU0CmgZsjZkydQWg0UE774Rw7yt7R6HpFU
	 F5sOj0VlPwpWcw+QkNcMNdPEIGs1iogcvcyvdqh2E0lOzxMLdwKfPUlO1PMfH7IwaIDW6
	 YPfzhyS6cX1i2E6FLYzWfoHYVdqDyOfQjxdSptxOUn30MvS95WA6DM7cvFb6O0ljVA0FF
	 weVadRNzPM3IX9r1456nY58bAyp8rBCAqWXV2R58TIVHY5J4ttCEPLTWCOyasEMXMKnbz
	 P6kZTdjMACistztl44soY98pbWDYv5goa0VbPnkW21QrZOM+2Qp2yXIoboMEeKY8L2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431121;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=tNQqBz5+70EcbhvGfYXqJhYoHMclm4qNDJckCYhqgXk=;
	b=4+59Fhe9at/SIjQEifKDE3v2v/GqCoBe9Iqz6MBPNt4Sh1U91gFuTceRTtIARLLFBcUt
	 ekBSL+nFgJbQ055VuCe0T7WmS5whPxHQG8xFmMk7sQUAcdx5tefoBjuQlQbhO+NOp8lCc
	 WEa4JDRMRqg451eRGnAiJxRKramh0DdXVVY9GoPHPQ4ecccS/S6nJwl++j4kzeQJ0TJek
	 ar7uxsic9Vmi8tvP/vH4l46980aFtVBWqRYviJNELEOCv3gcy88NE1KyxvWdeEAn6ver7
	 0kZKeoVvK1Eg9Ix+iQyYp7Rzs1rgra6R4L/0pmfem0b0cWc5IZ7u/K0ngRz+bCUeDFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c2XAXk1/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E47606A321;
	Wed, 11 Nov 2026 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2XAXk1/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD6E1F00A05;
	Wed, 11 Nov 2026 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794431121;
	bh=tNQqBz5+70EcbhvGfYXqJhYoHMclm4qNDJckCYhqgXk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=c2XAXk1/1FlgcmzpXfA2mwLgpAVBySudM21S5Eky4Xj28kPHbLydAHh32loGW2D8a
	 AiNWmQBSKEuI8d679u+FUaCA1M+Age94YqR3IK0TU1eOn1czVjbuc0pnSwvhFWbdjW
	 DN5wjSdCyZx795hFTyZMx92BP8bR1SvYzbNpbAbd1GtNRW0dpeGA60O+c4f7JS7tkk
	 KAhQZAt7Tf6saoTzFtACDSCw09t1F3Gs7meWuz4VzMYTYdU+ctzuAzZxLL44JU6cGK
	 Bx5/LiEIijFTXKsvej4SY5GVJuEChrIY8DWX7ROFO4w3aiMI/8IIYVImtSQbcWtyHz
	 6kq/eRUmej2Cw==
Content-Type: multipart/mixed; boundary="===============2866188785818237921=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8be73886579dc58a6363e72f540c0f28a12e0fe089ebde311b28919a47714ef7@mail.kernel.org>
In-Reply-To: <20261110125001.4167503-9-cui.tao@linux.dev>
References: <20261110125001.4167503-9-cui.tao@linux.dev>
Subject: Re: [PATCH 8/9] tools/sched_ext: scx_userland: Check dispatch buffer slots before inserting
From: bot+bpf-ci@kernel.org
To: cui.tao@linux.dev,tj@kernel.org
Cc: void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,liwanwu@kylinos.cn,devnexen@gmail.com,zhaomengmeng@kylinos.cn,emil@etsalapatis.com,yphbchou0911@gmail.com,mingo@redhat.com,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,cui.tao@linux.dev,cuitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 21:05:20 +0000 (UTC)

--===============2866188785818237921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> tools/sched_ext: scx_userland: Check dispatch buffer slots before inserting

TL;DR: Commit message only: the sentence explaining when the dispatch buffer
overflows is garbled (two sentences run together, stray indent); the review
asks for a rewrite. No code issues raised.

> tools/sched_ext: scx_userland: Check dispatch buffer slots before inserting
>
> userland_dispatch() pops up to MAX_ENQUEUED_TASKS pids from the
> dispatched map and inserts each task into the global DSQ without
> consulting scx_bpf_dispatch_nr_slots(). The kernel's dispatch buffer
> holds 32 slots against MAX_ENQUEUED_TASKS (4096), so a single
>    full dispatch round overflows it long before that many tasks
> pile up between dispatch rounds the insert past the buffer limit aborts
> the whole scheduler. Every other tools scheduler that loops on
> scx_bpf_dsq_insert() (scx_central, scx_qmap) checks the remaining slot
> count; scx_userland is the odd one out.
>
> Break out when the buffer is exhausted and leave the remaining tasks
> queued for the next dispatch round.
>
> Fixes: cc4448d0856d ("tools/sched_ext: add scx_userland scheduler")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

This isn't a bug, but the sentence explaining when the overflow happens
looks garbled.  It reads as two sentences run together:

  "so a single
     full dispatch round overflows it long before that many tasks
  pile up between dispatch rounds the insert past the buffer limit aborts
  the whole scheduler."

The second line also has a stray three-space indent.

From the code, userland_dispatch() pops pids from the dispatched queue and
calls scx_bpf_dsq_insert() for each one.  Each insert from ops.dispatch()
goes through scx_dsq_insert_commit(), which calls
scx_error(sch, "dispatch buffer overflow") once
dspc->cursor >= sch->dsp_max_batch.  Since scx_userland does not set
ops.dispatch_max_batch, dsp_max_batch is SCX_DSP_DFL_MAX_BATCH (32).

So the scheduler aborts once more than 32 pids (31 if
dispatch_user_scheduler() also inserted the usersched task in the same
call) have built up in the dispatched queue between two ops.dispatch()
calls.

Could the sentence be rewritten to say that directly?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43092548483
--===============2866188785818237921==--
