Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B746139281D;
	Fri, 19 Jun 2026 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885086; cv=none; b=VNzPq9puAMh0iAhP+hxO9lkC0jNdXamBTvpYimTP7uYAHjaQJrzbibX1rImNGyc4W6IrxNf4HygDY4omZK47InOna/mKgyA/Hwj1v8XORecEZsxqpHOpHdsRxhRMRsjJTIozQn1T+rALnbpOiRhXrAv7/AJakX04AHudyrrbVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885086; c=relaxed/simple;
	bh=AWGRdUn+QrNPrSS9cyunDWoLmJppNzNik8yj+cbLGBk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Li+GxzWs4DH9DobhDHCfB2yVGmXJ1KLukMtX9VlNQhwPrtodDsPZYJGnMDtKrUE/15cuaMkDKdMQby/1CwxNMtalZRFOsLcFlOEpmgcvgMZ4UMNKxlReBYLXl1rzkTlI6bSqtgyXExI09Bf8rekH1NfkJbGYxbu7HrIQcbVrmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=aOR2KZmi; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="aOR2KZmi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=logjK88Xidj1vtikb38Lg8v1FqKh6ehsDKZ6dbrriOw=; b=aOR2KZ
	miJXaS6w5Aq/lOQFRdGEaMFDFyNevtk4a2UGxBlRCrS9/i3IWe/VKimqfdL4g/0h
	nIDD8+nEFPRy24bN/SPHX6k6Mb+gWlIMPQokdAnAsWsQaiOdWnSNqw5Fe8F3p5Mx
	RpZa+1ioZGnJRjlO3hOlqdqjjG6qBiiZg2jp8=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQCn8o+RaDVqIeaPAg--.58650S2;
	Sat, 20 Jun 2026 00:04:33 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next 0/2] bpf: Require CAP_BPF for pseudo-BTF ksym
 loads
Date: Sat, 20 Jun 2026 00:04:26 +0800
Message-Id: <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-0-f950f69fe60c@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIpoNWoC/yWMQQrDIBAAvxL23AW1REy/UnpQs9tuD0bUlEDI3
 2va4zDD7FCpCFW4DTsU+kiVJXXQlwHiy6cnocydwShjldUTstKor5grrfOCoXEPMPqMITOObuT
 JkY/GOuiLXIhl++3vcAaJtgaPv6lreFNs5x2O4wttp2+aigAAAA==
X-Change-ID: 20260619-f01-13-pseudo-btf-id-cap-bpf-585f98eac268
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Hao Luo <haoluo@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781885074; l=1056;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=AWGRdUn+QrNPrSS9cyunDWoLmJppNzNik8yj+cbLGBk=;
 b=ar4O2pWhwPUWwkTnTXiZn7FeaEenVL7qTuNxMO0cmTE35sqStXkjt5LKNIcPGiGpbX2q7wJDi
 o9EjgPv+J2UB0S3fZBlf3ki8y9p59UVLV3Zl+9ieTwuPAQXbclYxeE2
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQCn8o+RaDVqIeaPAg--.58650S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4rJryrGr4rGryfCry3Arb_yoWDZFbEkr
	s3uF9xCrWIkF1SyF9rCrn7ZrWrZw48Cry5AFy7KFW7t34vqr13KFs2qF1xAry2yF4xJrZx
	uF43Zr92vw1fCjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbg8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28E
	F7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwV
	AKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6x8ErcxFaVAv8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wrylc2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8Ww4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7V
	Uj8wIDUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQQDA2o0b7D6BwABs4

BPF_PSEUDO_BTF_ID resolves a BTF id for a kernel symbol into a concrete
kernel address before the main verifier pass. A raw ldimm64 using this
pseudo source can currently reach kallsyms resolution without CAP_BPF,
and verbose verifier logging can print the rewritten immediate.

Require CAP_BPF before pseudo-BTF ksym materialization and add focused
verifier selftests for both the no-CAP rejection and the CAP_BPF-allowed
case.

Fixes: 4976b718c3551 ("bpf: Introduce pseudo_btf_id")

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Require CAP_BPF for pseudo-BTF ksym loads
      selftests/bpf: Cover pseudo-BTF ksym load capability

 kernel/bpf/verifier.c                              |  5 ++++
 .../testing/selftests/bpf/progs/verifier_unpriv.c  | 32 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)
---
base-commit: a3847994b4d20c0701ccc54fe110920ea78e73dc
change-id: 20260619-f01-13-pseudo-btf-id-cap-bpf-585f98eac268

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

