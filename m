Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD053DAAB7;
	Sun, 20 Sep 2026 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789886148; cv=none; b=BobAHPmNxzf5DHrBSxJG+NCBrsH2ZNU+sOpOgTaKBf6P8kfZt9Q4jaQxtQI+mHER4ny/d1fCTDjYKapoiNmJQqQyeCh2LwWNOmSZnDMDt634LTtLHE5tPpiJ1P/OEhOZmiCMOB/LgrevZ5I+DZLwRxuWU6vTz5LIDQ6pgJxanzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789886148; c=relaxed/simple;
	bh=zSF55hS3q/SJNC7yFH6HrIYbq31cI9ptu08+ta1ExNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D28g+wlp9TtYXEESinquc+26jL/A3A1VM1b7pEjtMNm7eOKZOvBGLiucD61t/wTOasJFEXuw1ezsFTpzBtUMNgw2MNdWayb6H1UK3gcqxX71TSiTqCehrnrF63dpR3MlEmiM52rpal0UsXCdX0BskPMKx1B0Ah9s9lr4d7Igba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nQqRutNC; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nQqRutNC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kx
	GFilB66s9lUEG9qn0jnmGK1L8xbq/9GQy8z7tSmII=; b=nQqRutNCeLeZpqr8Iy
	iZ6Uq3NwaMpoFDaNuzE/wr65RJob9o6jLFv53sMuNwrIaT8HojFAKswpUQ+kY6ik
	hcfZ8KTG+USGhXPRcM1jxbEPrloQ7ePSPlZaOu9tZS/92wKxZ0vx/WxUb9tuCTQs
	XOWxj+O0IY3ezfVLhd64H5JqM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3F8OCfq9qG42sBw--.49698S2;
	Sun, 20 Sep 2026 14:34:43 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	jolsa@kernel.org,
	ihor.solodrai@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Reject bpf_skb_output() from return-side tracing
Date: Sun, 20 Sep 2026 14:34:41 +0800
Message-Id: <20260920063442.499577-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F8OCfq9qG42sBw--.49698S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr48KF1UJw4xJw1UJr4xWFg_yoW5GFWrpF
	4DCrZ8Cr1kJrW2yr4xZa1rZryYywn5A3yYkFWDtw1FvwsxZrWrtr1UKanIv3W5uFyUG3sF
	qF40vayqyr4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jerWrUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8gRHv2qvfoSOQgAA39

From: Feng Yang <yangfeng@kylinos.cn>

BPF fexit programs run after the traced function returns, while their
context still contains the original function argument values. A traced
function is free to consume an skb argument before returning, so the
pointer seen by fexit can already be stale.

The verifier checks that the first argument to bpf_skb_output() has the
BTF type of struct sk_buff, but that does not establish its lifetime.
bpf_skb_event_output() then dereferences skb->len and can trigger a
use-after-free.

Do not expose bpf_skb_output() to tracing programs which can run after
the target: fexit, fexit.multi, fsession and fsession.multi. Keep it
available to fentry and other tracing attach types where it is already
supported. fsession must be rejected because the same program runs on
both entry and return and the verifier cannot prove that a helper call
is entry-only.

Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Closes: https://lore.kernel.org/all/9d61b891-2d52-42b9-bc1a-ad963ccb675d@std.uestc.edu.cn/
Signed-off-by: Yun Lu <luyun_611@163.com>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/trace/bpf_trace.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 29260951aa87..cdede3926e5d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1339,6 +1339,20 @@ static inline bool is_trace_fsession(const struct bpf_prog *prog)
 		prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI);
 }
 
+static bool tracing_prog_may_run_after_target(const struct bpf_prog *prog)
+{
+	/* The target may consume pointer arguments before these programs run. */
+	switch (prog->expected_attach_type) {
+	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_TRACE_FSESSION:
+	case BPF_TRACE_FSESSION_MULTI:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct bpf_func_proto *
 kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1730,6 +1744,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	switch (func_id) {
 #ifdef CONFIG_NET
 	case BPF_FUNC_skb_output:
+		if (tracing_prog_may_run_after_target(prog))
+			return NULL;
 		return &bpf_skb_output_proto;
 	case BPF_FUNC_xdp_output:
 		return &bpf_xdp_output_proto;
-- 
2.43.0

