Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5A970818;
	Sat, 20 Jun 2026 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970443; cv=none; b=DMUSdepVqlR68Uh60GO0ikcO0qoR8L5NswHWgnbGDej3HoolVGiIxqjbaTjHWhYwldoMIEZmlEXvYmJTLFZYDVIRnnOaYpB1xFAAzceumJsRwxRyHobMflsdTs3MQHeY28tVLiVrio5AB8kfW9QGcRHCUNWPMJWaO7XYIadgNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970443; c=relaxed/simple;
	bh=c1ZxSKRcHiaox6YeJRrtknih2uUYDTIj5peP+zd1sF8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R0XPCMCOM5AiyYT1kcxMvDlMMzzaZdKN7CTlnyH2QZVLPA7k3hFM3ePmv/K5fo/eYEyhKtZ0neolf6F0wDyMLWDRiBkF+QChHC3jJWh59vVcqcgUb+l6A2PsnP+pUaonhiplgMytszGAYvDVY2OjK1H8NsEufhPzk8gP46lQDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=d/M+qReR; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="d/M+qReR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=z/mTYN9Iwoh9TDKa2PE8H0fySLhVFJyk4E3fYGKRD7w=; b=d/M+qR
	eRe/y//0dXKCM/FzPCqxoLW5MgFkmKEfoisW7rwNxhtd3Hz8RLLP2isVO7DuHCSV
	2Tev2MM1lXiyxYUUhHkgrqN0y77rqC19IU+xo1ZThblBXPIXSBswNdsDAesIEdC8
	W7DZ2VrBF0FSxQba2cc1aonhSpN8gT2T2T2UA=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCHY5v_tTZqCNRtAg--.19521S2;
	Sat, 20 Jun 2026 23:47:11 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf 0/2] bpf: Mark bpf_get_kmem_cache() as nullable
Date: Sat, 20 Jun 2026 23:47:08 +0800
Message-Id: <20260620-f01-16-kmem-cache-ret-null-v1-0-c146154a2816@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPy1NmoC/yXMTQ6CMBBA4auQWTtJW9L6cxXDopQZGYVKWjAmh
 LtTdPne4lshUxLKcKtWSPSRLO9YQp8qCL2PD0LpSoNRximnz8hKo3b4GmnE4ENPmGjGuAwD2tp
 f2RruLrWFAkyJWL4//A7txND8Z17aJ4X5YGHbdkfl3meDAAAA
X-Change-ID: 20260617-f01-16-kmem-cache-ret-null-53a9f52fd835
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781970433; l=1097;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=c1ZxSKRcHiaox6YeJRrtknih2uUYDTIj5peP+zd1sF8=;
 b=X0MCjmb0E680coVAwrwYKH8xuNkA9PER1RgIIkNPhoy18Esc1QbFXKiLqyDNsqr3491RNggKQ
 uNymIQBHIU5BDDgyphlXeGgH4UIxoKDPRHUodDq0iMeaK0x3wJolQoX
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCHY5v_tTZqCNRtAg--.19521S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWftr1Dtw1fJr13Jr4DCFg_yoWDtFX_Xa
	1FyF9rAw4Iqa1IkFy5Cry8ZrW8Cw48Ary3CF4qyry3J34Yva17ur4vqF1Yv3sIvF48Krs5
	ur4aq3s2kr17ujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_XrWl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjzSoXUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgIEA2o1wh2yXQABsp

bpf_get_kmem_cache() can return NULL when the supplied address is not a
valid kernel address or when no slab is found for it. Its kfunc
registration does not currently advertise that to the verifier.

Add KF_RET_NULL to the registration and add verifier coverage for the direct
field-read case. The selftest rejects a read of s->size after
bpf_get_kmem_cache(0) without a null check, while the null-checked variant
remains accepted.

The issue dates back to a992d7a397912 ("mm/bpf: Add bpf_get_kmem_cache()
kfunc").

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Mark bpf_get_kmem_cache() as nullable
      selftests/bpf: Cover bpf_get_kmem_cache() null return

 kernel/bpf/helpers.c                               |  2 +-
 .../bpf/progs/verifier_kfunc_prog_types.c          | 29 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
---
base-commit: 76f62d237538b456354a44e796a541cde03c6e28
change-id: 20260617-f01-16-kmem-cache-ret-null-53a9f52fd835

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

