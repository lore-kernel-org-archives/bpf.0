Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B38F332637;
	Tue, 16 Jun 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629097; cv=none; b=GMDFHF/QqgHj0c6UioZNamEx+k9YjOvaFm4dDlFad5/bhXflRdtxCARUfyCoGjJ8fM3+mtfW9GapjTX/PqzO1Fur3Wp16SX9Aj1T54QBKUYZm1wdp6JiSTIT+0sV0rvVzfobvPezeoaJdWdUTchDLI5r14dGy+rF50Twn5A5x74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629097; c=relaxed/simple;
	bh=I1tZMP+mPvdhMwhM5zszm9Zo3eB8aZqikSghsJIhhOw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uKCgQQ1B1JFzT61AVE1I8V4/gMyYR4zuFVkCLWyO2sFQFyHW/8Nub1cX1K3Thp2O5BihdvtGYY6nFvfBctkkmb0PwIB2tnDtOIBkOFTBDTe2kcNRxoWvk/pVNWO8aVKOTBO1XnmOnMdXVKsWDthOJcPxOoCUwhOYK6eUmFZFZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=SCC4V3F4; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="SCC4V3F4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=FKciIDidIunA4WWPY4okzzywVAc+s2gTjjuVLSN+lbY=; b=SCC4V3
	F410PIDTtTKTn4gaNxSQkkxRCs8OA4DqYbGwAjIptvrcj1jcA3U/zge5EGD8zwu4
	dqFH8y6zb5WHdtYXlQF272/06T7EekfpuzlkZcdpSfW5d4qTFtFLX8HCq0LDAiAb
	E3X7ZYBcS3sUWe8bVrOWuHpNkoxooTaVxZTek=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQBneJ2VgDFqKUxPAg--.57407S2;
	Wed, 17 Jun 2026 00:57:57 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf 0/2] bpf: Fix stack slot index for Spectre v4 nospec
 checks
Date: Wed, 17 Jun 2026 00:57:54 +0800
Message-Id: <20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJKAMWoC/yWNywrCMBAAf6Xs2YUkkCr+injIY6OrkoRsKoXSf
 zfqceYws4FQYxI4Txs0erNwyQP0YYJwd/lGyHEwGGVmNWuLSWnUGqW78MRcpFJAeZWOnCOtSNp
 ab1yI9nSEEamNEq+/wQV8TXD9S1n8g0L/pmHfP1EIRMeHAAAA
X-Change-ID: 20260615-f01-11-stack-nospec-slot-index-e155b2acd587
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Luis Gerhorst <luis.gerhorst@fau.de>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781629079; l=1575;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=I1tZMP+mPvdhMwhM5zszm9Zo3eB8aZqikSghsJIhhOw=;
 b=VUps/GOoTZRevQ8PQBV6imO53lQhahbMspktgu3dqXj151VEbFPK6UId2Hr0qiZ8VbQqyawIf
 uogspxawJjTCVrKADpVcpwyrz35eSZvVtO7dX5fs2WH8tS4LTJG1ThX
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQBneJ2VgDFqKUxPAg--.57407S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4Dtw1DuFWrtw1xJF1UZFb_yoW8Xw4xpa
	4v9F1Sqa4DGFy7GF1ay3W0gryrWr1kGr47Xr1Sqw1UZF4FgryxGFZaga4UXw1Fyas3XayF
	vFW3Xr90kayUAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1U
	M28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxV
	AIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv
	8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II
	8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl
	c2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU8TqcUUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgUAA2oxd6sIBAABsO

check_stack_write_fixed_off() uses one byte-indexing scheme when checking
whether a fixed-offset stack write needs Spectre v4 sanitization, and another
scheme when recording the write into slot_type[].

For sub-8-byte writes this can make the sanitization check look at bytes that
are not overwritten by the write. A zeroed lower half-slot followed by a write
to the upper half-slot can therefore miss the nospec barrier for the second
write.

Use the same stack-byte index for the sanitization check and the slot update,
and add a focused verifier selftest that expects both half-slot writes to emit
nospec when the loader has CAP_BPF but not CAP_PERFMON.

Bounded impact: this fixes verifier/JIT Spectre v4 mitigation emission for a
fixed-offset stack-write corner case. No architectural verifier memory-safety
bypass, exploit chain, CVE, embargo, or security escalation is claimed.

Fixes: e4f4db47794c ("bpf: Fix pointer-leak due to insufficient speculative store bypass mitigation")

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Fix stack slot index in nospec checks
      selftests/bpf: Cover stack nospec slot indexing

 kernel/bpf/verifier.c                              |  3 ++-
 .../testing/selftests/bpf/progs/verifier_unpriv.c  | 23 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)
---
base-commit: e4287bf34f97a88c7d9322f5bde828724c073a6b
change-id: 20260615-f01-11-stack-nospec-slot-index-e155b2acd587

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

