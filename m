Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A446221FCD;
	Tue,  9 Jun 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017394; cv=none; b=uO/1ekJTqkNTqRBzKi7iqT1sFXCC064onQgE5KpzLEb9R/uIVzEtnSmQKdPq+rcMhTe3YwqUpfu7tx8xLuuwKVGpT/SDg1pyF9FQjEMmdQ7nuGd9z6g2fap01F7z5BCB25M14YKgTkm+hlaJ0PaSARWa1vUqaTtRI/akr/zj3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017394; c=relaxed/simple;
	bh=uS9T9xrOQ3uW4fa8o3RrPf4daIkGaOyuEJA/jDxFn34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TDN5zsLhM+Fy2s36cSlpSglPuQpemNOmk+uNQrvOmN2UvL/BVWnetb+tTnL9V7hc4TuSVGW2BizjdyioTVev1arz8tcAYtxnlhukjRRwAQLTVofyGLQMVCjB2i/pAVuACyxuzan2NWAhUJXCiqeWUkePfY4ELYwxf8gerwm5a8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=fE0BNuAO; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="fE0BNuAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=pAk+e+7kZwHmPhyCNpULaOB0zFbkRzaLPt8ftiq2Ggk=; b=fE0BNu
	AOPiioA7n2p8P+Hef2PGYE6zUV9VD32H4Fh54ocaMnmpSh7P99iMU1slFTyu/4e9
	tFW4x3Izcx0CIGsNJ3fOovRF0AkPB3IRecwqzQuJ3WZ/6JXlb9QP2UxwCllk6hik
	rQl9itBUXrWloIpusDfqAVbWcPacgQbCLhkxk=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXcporKyhqMNgjAg--.44237S2;
	Tue, 09 Jun 2026 23:03:07 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next 0/2] bpf: Fix gotox target validation against CFG
Date: Tue, 09 Jun 2026 23:03:05 +0800
Message-Id: <20260609-f01-02-gotox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACorKGoC/zWMywqDMBBFf0Vm3YFxwGj7K6ULHxM7LhJJogTEf
 zdt6fJw7zkHRAkqER7VAUF2jepdgfpWwfju3SyoU2FgYkOG7mipRmKcffIZh9Wik5yQWxbDraG
 umaC4axCr+dt9wv8Fr98St2GRMX2ycJ4X/nHvJ4MAAAA=
X-Change-ID: 20260609-f01-02-gotox-bpf-next-272e6276085d
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781017389; l=1537;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=uS9T9xrOQ3uW4fa8o3RrPf4daIkGaOyuEJA/jDxFn34=;
 b=Rbvm7bam/fLZ8qgZpwM+xDgQBCblCII8eZcdfMdFHZWy3uMBuesVW/6EyHrT84jB8i7/Vbc4b
 Rc4gborFieYC35jSH8H54VPyXpbRq0iVisMMD78PVSSNqIFsx2GPqWz
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCXcporKyhqMNgjAg--.44237S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1kuFWDGr4fKF1UZrWrZrb_yoW8XrWkpF
	y7XF13trW8JFZ2g3W3tF47XryrWrn5Gw1YkF4xJw1Iyw1rGF95JrW8KasxZFZ8ta4rZw4r
	WFy0vF1fCr4kCrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x0Jjoq2NUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgUNA2onzACf5wAAsw

For gotox, CFG construction models the indirect-jump target set in
insn_aux_data->jt, but do_check() later follows targets from the runtime
PTR_TO_INSN register's own INSN_ARRAY map. If the same gotox can be
reached with PTR_TO_INSN values from different maps, do_check() can accept
a target that CFG did not model.

On x86, that can transfer control into another subprog without a matching
BPF call frame and crash when the program is run.

Fix this by rejecting gotox map targets that are absent from the CFG jump
table built for that instruction. Add a regression test covering the
two-map cross-subprog case.

Validation:

  unpatched bpf-next b9452b594fd3:
    F01_02_LOAD_FD=5 errno=0 (accepted)
    SELFTEST F01-02 gotox-cross-subprog: FAIL

  patched bpf-next b9452b594fd3 + this series:
    F01_02_LOAD_FD=-1 errno=22 (Invalid argument)
    gotox target 14 from map id=2 is not in the CFG jump table
    SELFTEST F01-02 gotox-cross-subprog: PASS

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Fix gotox target validation against CFG
      selftests/bpf: Add cross-subprog gotox target coverage

 kernel/bpf/verifier.c                              | 26 ++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c | 73 ++++++++++++++++++++++
 2 files changed, 99 insertions(+)
---
base-commit: b9452b594fd3aecbfd4aa0a6a1f741330a37dab7
change-id: 20260609-f01-02-gotox-bpf-next-272e6276085d

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

