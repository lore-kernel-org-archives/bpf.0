Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051A3C13E3
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902717; cv=none; b=DMO4mrkTB6E8Z7Hm244moNuqMtUmClnbQkbfDzkk4XvKHPRhrEVodmKT+sdXuCW3jcPSzzBwk3R6G5eC3XGh9Jx5abLuFXkkIjh4qTNvq5p14Nw925T2nkgadE9aqBAvATOJyuiLVeWz12VYmaNhIdSnKYMc151ir2VjEmlIj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902717; c=relaxed/simple;
	bh=C4RSpaljxgz9ck9DLpKyKQn84ey1xXzE5fy+mwxZT30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQnLLg/fdPuFUGEQbsau9SmPCtb1YpV/i/yViLBihVo7khvxF+bG/x5LtmJpNMh/FLWNEbsiPOa5VGPyunTR5pWnmgEVMw/X4Z7xZaeReManXmZgx1DTSG51jHQ1vw21JgCPVCthO88nTnW+fWqacPZz6bUE0J41qdgGKwEbDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iCBwrPOz; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iCBwrPOz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785902703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0tlFxTrd/+tW4EBqbHQI+10YL1gDs4/3VHY2K0901z4=;
	b=iCBwrPOzfiQVdDl8SZdNAEmJzMXVis/m7VsjNVxUpw16S0SOZ1QGzz6sm3U4e0VuGIhzrC
	410U8/PyN1uDw91wDpaDPb3W3DdgNsfXmG2BpKQxdoYOTjWhXHS6O2rShePC8FVfsatYNs
	J1v8gFD/Ev/RiN50cBlcHxsPil7Gyg0=
From: "Hui Zhu" <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v2 0/3] bpf: Fix UAF in bpf_trampoline_multi_attach/detach on update failure
Date: Wed,  5 Aug 2026 12:04:05 +0800
Message-ID: <cover.1785902527.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

This series fixes several use-after-free issues in the BPF trampoline
multi-attach/detach error paths, where ftrace direct-call updates can
fail and leave ftrace pointing at freed memory.

Patch 1 addresses two UAF scenarios in bpf_trampoline_multi_detach():
the single-point unlink failure path (old_image == cur_image) and the
batch ftrace update failure path. A new pinned_prog field in struct
bpf_tramp_image keeps the bpf_prog alive while ftrace may still
reference its image. bpf_trampoline_multi_detach() is made to return
void, since callers cannot usefully react to failures, and
bpf_trampoline_put() is taught to leak the trampoline when cur_image
was left behind by a rollback, so ftrace keeps a valid target.

Patch 2 fixes a similar UAF in bpf_trampoline_multi_attach() rollback:
when the register-path undo fails, ftrace still calls into cur_image,
so the prog is pinned on cur_image instead of being rolled back.

Patch 3 fixes the common __bpf_trampoline_unlink_prog() path, covering
both multi (bpf_trampoline_multi_detach) and non-multi
(bpf_tracing_link_release, bpf_shim_tramp_link_release) callers.

Hui Zhu (3):
  bpf: Fix UAF in bpf_trampoline_multi_detach on update failure
  bpf: Fix prog UAF in bpf_trampoline_multi_attach() register-path
    rollback
  bpf: Fix prog UAF in __bpf_trampoline_unlink_prog() on update failure

 include/linux/bpf.h      |  20 +++--
 kernel/bpf/trampoline.c  | 183 +++++++++++++++++++++++++++++++++++----
 kernel/trace/bpf_trace.c |   2 +-
 3 files changed, 183 insertions(+), 22 deletions(-)

Changelog:
v2:
Folded v1's two detach patches into patch 1.
According to the comments of Jiri Olsa, Pin the prog (pinned_prog) on
cur_image so it stays alive while ftrace may still call into it.
Make bpf_trampoline_multi_detach() return void.
Fix the same UAF in standard (non-multi) trampolines.
According to the comments of sashiko, Fix the prog UAF in
bpf_trampoline_multi_attach() rollback.
Leak the trampoline in bpf_trampoline_put() when cur_image is left
by a rollback.

-- 
2.53.0

