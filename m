Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3F831F98D;
	Mon, 15 Jun 2026 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512281; cv=none; b=FsiacmTbnXc1f9Hgx+H9wb3dDGENv6GsWjCkbGif8zL1/qq8QCpkW4HFQZSobg8y6PGWofSHq558pG1mIPA5YdCqvFAingV7MoIiOHzw2hpHSQjzQjeZcausEBBODiBdEpT4PIwJlfAo9KFIIuMC4+K8b1fwFIBWOZcLQZsAp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512281; c=relaxed/simple;
	bh=fnHmn/L2U1Ki5jyeYPn/Pw0TmAC+tWw9ZL4zm2/qfBU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pz18hkhrVMEmZdh++wtL53+7fEZLJQ3whhMcPAeFNmKdeO2Q97vOaYHp+h4LgLuj3cJDWk6MQ60VwX8slV4XSwaQj5lrhbzO+0crxzgBu0m33ePYHCjQZO8KflOrn7CdKqY2NmOmfx8hWCsUM9/IiTafK1EL2gXzu0nxq53NOWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=UAJ9E4/i; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="UAJ9E4/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=XXpEe3YEYe37uv0l9jZeSvNRdfTtGE+zPc9xZXY5amQ=; b=UAJ9E4
	/iNM7hB26WwlFyTpj4FtYf1NLII6U0Q80tNjatsbl2+bDPGVUAHD6KYBk7/8kG7o
	exAXs1Yw1yaJqtnE25GlpbY+sibdWoVEUwvNKz+62AFSBaOUqkK8SmtQRePO3rL6
	m0gkM1vHWeYzxt7kGBBHUeJPBET0tbpiJKaPs=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQBXEMBFuC9qh8JwAg--.40355S2;
	Mon, 15 Jun 2026 16:31:01 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf 0/2] bpf: Gate dynptr probe-read kfuncs like helpers
Date: Mon, 15 Jun 2026 16:31:00 +0800
Message-Id: <20260615-f01-07-dynptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAES4L2oC/yXMPQ7CMAxA4atUnrHkVDSVuApiyI8DZkgtpyBQ1
 bsTYHxv+DZobMINTsMGxk9pstQe7jBAuoV6ZZTcG0YaPXk3YSGHNGN+V10N1ZbIaBwypqB4zMw
 zeR/LVKATalzk9ePPELXA5T/bI945rV8Y9v0D+xSaaoUAAAA=
X-Change-ID: 20260615-f01-07-dynptr-probe-read-cap-4dee7066bf5f
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Mykyta Yatsenko <yatsenko@meta.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781512263; l=2183;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=fnHmn/L2U1Ki5jyeYPn/Pw0TmAC+tWw9ZL4zm2/qfBU=;
 b=S9RIVsHssWpzqQ/h4Bly9TVd0QrCAtKD9IlNTFvHXfGyNYCtiLn4o+vSWFEHYkeo+IzW838pi
 b7d/Ib0Fk3LAMbdYzMUs9Ogwin2kDGYIPLzo4tuTK6rqOxEl0KRw/39
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQBXEMBFuC9qh8JwAg--.40355S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1fWF1xCFW8ZF4DWFyDJrb_yoW8trWDpF
	yvk34Y9r1kWFnrA343Jw47WrWrtw1kWr4fGF97try3Zr4qgrZ5ZrWI9FWUKrnxKwsFgr4F
	v3y2q3s3GF1UArDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjcIDcUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgQTA2ovr8QSdwAAsd

The dynptr probe-read kfuncs are registered as common kfuncs. That lets a
program with the generic kfunc privilege gate call
bpf_probe_read_kernel_dynptr(), while the legacy bpf_probe_read_kernel()
helper is exposed only with CAP_PERFMON and is blocked by kernel-read
lockdown.

Gate the four nofault probe-read dynptr kfuncs with CAP_PERFMON, and apply
the existing LOCKDOWN_BPF_READ_KERNEL policy to the kernel-read dynptr
variants. Add focused selftests that expect CAP_BPF without CAP_PERFMON
to be insufficient for bpf_probe_read_user_dynptr(),
bpf_probe_read_kernel_dynptr(), bpf_probe_read_user_str_dynptr(), and
bpf_probe_read_kernel_str_dynptr().

Bounded impact:
- Requires privileged BPF program loading with CAP_BPF.
- No unprivileged trigger, arbitrary disclosure primitive, memory
  corruption, privilege escalation, CVE, embargo, or security escalation is
  claimed.

Validation:
- The focused dynptr selftest loader exercises the CAP_BPF-only program load
  boundary for bpf_probe_read_user_dynptr(),
  bpf_probe_read_kernel_dynptr(), bpf_probe_read_user_str_dynptr(), and
  bpf_probe_read_kernel_str_dynptr().
- Unpatched bpf at 8496d9020ff37 ("Merge branch 'arena_direct_access'"):
  FAIL as expected because all four programs still load with CAP_BPF and
  without CAP_PERFMON.
- Patched with this series: PASS because all four same programs are rejected
  with -EACCES when loaded with CAP_BPF and without CAP_PERFMON.

Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Gate dynptr probe-read kfuncs like helpers
      selftests/bpf: Cover dynptr probe-read kfunc capability gate

 kernel/bpf/helpers.c                               | 32 +++++++++
 tools/testing/selftests/bpf/prog_tests/dynptr.c    | 66 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c | 75 ++++++++++++++++++++++
 3 files changed, 173 insertions(+)
---
base-commit: 8496d9020ff37a33c2a7b2fc84350fd03ffbde78
change-id: 20260615-f01-07-dynptr-probe-read-cap-4dee7066bf5f

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

