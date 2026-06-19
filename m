Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858E27727;
	Fri, 19 Jun 2026 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880358; cv=none; b=HIIjtJlRWJ4JZ1KuM5pNyiLOQvwhADTVsYlotnIjrDyUKDAaXNYuKON5dFL/A8dUW16Smyqg4PIGLd0+cZYxHp/fZu1E+Iz6T2IYuyYaF+pFboAF7Xp9J71Kj4ielUy4jsV4EzPd7FVjZq0IMzFzAB7IuGvbUOf0xMkYDCBoyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880358; c=relaxed/simple;
	bh=TFk0MfznjCmyIteitfG9pMgEuBCZtq/YkYT56XbC+CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dCeql2bKxgFoGpxuAkLDQepY97D00LF8f2cYeT47kcnGPoj3JLaTblh0aGtcDzOysnxfiDX3qd3+xmGkLteouCkHBZbrPStSds0niEcCFBsjpko1L+sMdglLuqXJPs+rIV+Q3I5nKV1WsLzDftIu9LOktV9DvjGNpqHtlGQWYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Wd6XSbTE; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Wd6XSbTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=k1XdGtRaEIWXqE6Xs298BuLMDQ3U+fa
	YOCgVLLTfqDI=; b=Wd6XSbTEMjmDGIj1T36GuYZmqqlrwHRgG2XRtbZQiMY11cu
	XImukSf/jVd9XmLMSEGywuS2KUlALBr6uOIMN+H8GApFoQKKxm0uH9mmwBwupXhp
	X6sF6XQogzI/hpO/UC1BwqvzDoOks43ynQ7dvWROxsXhCRIX6opAKbk4MbLI=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQAnsbsMVjVqxDGLAg--.41554S3;
	Fri, 19 Jun 2026 22:45:32 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Fri, 19 Jun 2026 22:45:32 +0800
Subject: [PATCH bpf-next 1/2] sched_ext: Mark scx_bpf_cpu_rq() as nullable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-f01-14-scx-cpu-rq-ret-null-v1-1-3b4281cdf0da@mails.tsinghua.edu.cn>
References: <20260619-f01-14-scx-cpu-rq-ret-null-v1-0-3b4281cdf0da@mails.tsinghua.edu.cn>
In-Reply-To: <20260619-f01-14-scx-cpu-rq-ret-null-v1-0-3b4281cdf0da@mails.tsinghua.edu.cn>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781880334; l=1369;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=TFk0MfznjCmyIteitfG9pMgEuBCZtq/YkYT56XbC+CA=;
 b=EetAIW627OzjrXjBDGjy2GYzJBE26Wpl7U9/dqd47jiSHOJ5/GRW1G8z6+XHwAo1SE+1hMbzA
 Y3cyS0dTzc3CnzEFCdc5v7mWp4C7DiOAnuHBjblkDDzmj6Oc7aoc6MV
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQAnsbsMVjVqxDGLAg--.41554S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF48CFWUAw1fCF4kKF48WFg_yoW8Gw1DpF
	srWr9Fkr18G3ykGa9rGr4rKrW5Aw1kJw4xuw1DArWIkw43X3Z5X34Syr12qr93uFn3tr1q
	qF10vrWfCr1j93DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xryl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0hSdPUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQMDA2o0b7DnBAAAsg

scx_bpf_cpu_rq() can return NULL when the calling program is not attached to
an active SCX scheduler or when the requested CPU is invalid. Its kfunc
registration currently advertises only KF_IMPLICIT_ARGS, so the verifier does
not mark the return as PTR_MAYBE_NULL.

Add KF_RET_NULL to the registration, matching scx_bpf_locked_rq() and
scx_bpf_cpu_curr(), so BPF programs must check the returned runqueue pointer
before dereferencing it.

Fixes: 6203ef73fa5c ("sched/ext: Add BPF function to fetch rq")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 65631e577ee9..dbe1fe1ac465 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9787,7 +9787,7 @@ BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_now)

-- 
2.34.1

