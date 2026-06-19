Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD0199FAB;
	Fri, 19 Jun 2026 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880353; cv=none; b=XMTJQrb2nTPcxw4ruqi60p1O9V4ayqbVCIFBIXLg9C8PWFNtCeDftF/E0TfnB3vcofsuO5MZQdINdWfSa6liNgHc0Vxfv8vtGKEhJb8jvov3jRHsOngjuGwEYYZ03rDVkSqNsdzx+74xbzWlrvLAp7pAgXZiBkDfNuYTfIwJ3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880353; c=relaxed/simple;
	bh=HZYtIN99QUMpwWbR0YMLaPxpVqFz501Kae/OHpH5Qoo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JNAom4InsLYN6BKUPT8xOmr+anGlHilf/eFM7g2uBnoenhQyHUVmSS1EWAUvGZEVKfM+7eUBQcZP6KjTUtTBqjZHNHEj+8yGuNMSZZmqN3IERVnnpNxn+nJ3R5fDt5Ph3c2kv4N4OlcSg9CW1paCPrTxFBivns2DuSckFpePy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=eNJ43H8R; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="eNJ43H8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=p/RpG1xo+BzvHjS6CfSoS6N987u53c6qZ7G1BRtJzKY=; b=eNJ43H
	8RPSX96MxFJc0WmcmbEZeZxhPa+paGnB9EEAIY1HTvA0uhX6tZBOZDTrZOqe0oaG
	IWTubQubWV4xXKP/kKlrKNfCogriKrPk9/SU29czLJtR/f1vY/Y7eyFbmjEhcRxh
	EV80IP6iVjY8N+GHriLGahdNKJiCICGEsQ8Z4=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQAnsbsMVjVqxDGLAg--.41554S2;
	Fri, 19 Jun 2026 22:45:32 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next 0/2] sched_ext: Mark scx_bpf_cpu_rq() nullable
Date: Fri, 19 Jun 2026 22:45:31 +0800
Message-Id: <20260619-f01-14-scx-cpu-rq-ret-null-v1-0-3b4281cdf0da@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAxWNWoC/yXM0QrCIBSA4VcZ57oDajmpV4ldbO5YxjDzaAhj7
 55blz8/fCswJU8Mt26FRF/P/h1ayFMH9jmGB6GfW4MSqhe9NOiERHlBthVtLJg+mChjKMuCisx
 Vn/VoZ22gATGR8/XA7zBFh4FqhuF/uEwvsnm3Ydt+Hrydk4gAAAA=
X-Change-ID: 20260617-f01-14-scx-cpu-rq-ret-null-2e79535acd57
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781880334; l=1187;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=HZYtIN99QUMpwWbR0YMLaPxpVqFz501Kae/OHpH5Qoo=;
 b=840HAMU3V+Qh7+51VQZEXF2RKAHCY47oR7hY2QbtdNDtil5WpxojBujk0ZHfwhzhfeZCf7RXY
 xN+gBjv4lNaB4CVY33cKdqrqMApxy5UDPZ7hGiZGmA/zxAalpJql4xd
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQAnsbsMVjVqxDGLAg--.41554S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4UXr4UKF4DWw45Wry5CFg_yoWkZFc_Zr
	4SyF9rXrnrua1Uua9rGFs5AryfCa10gr45CF18X3ZxG3y8Aw4DXF1kJF15uryFqw43GrZx
	ur4rZ3W8Cr1xWjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GrWk
	Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
	I20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxE
	wVAFwVW5XwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUIKZXDUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQYDA2o0b7DnAwAAsi

scx_bpf_cpu_rq() can return NULL for invalid CPU input or when no SCX
scheduler is active, but its kfunc registration does not advertise the
nullable return to the verifier.

Add KF_RET_NULL to scx_bpf_cpu_rq(), matching the nullable metadata already
present on neighboring SCX accessors, and add a sched_ext selftest that rejects
an unchecked direct runqueue field read.

This fixes a regression introduced by 6203ef73fa5c ("sched/ext: Add BPF
function to fetch rq").

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      sched_ext: Mark scx_bpf_cpu_rq() as nullable
      selftests/sched_ext: Cover scx_bpf_cpu_rq() null return

 kernel/sched/ext.c                                 |  2 +-
 tools/testing/selftests/sched_ext/Makefile         |  1 +
 .../selftests/sched_ext/cpu_rq_ret_null.bpf.c      | 27 +++++++++++++++
 .../testing/selftests/sched_ext/cpu_rq_ret_null.c  | 38 ++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)
---
base-commit: e4287bf34f97a88c7d9322f5bde828724c073a6b
change-id: 20260617-f01-14-scx-cpu-rq-ret-null-2e79535acd57

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

