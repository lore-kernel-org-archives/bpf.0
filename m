Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794801560;
	b=oeo8sdwQMcIjyu4sZ1StodAt22te+7ZCHccFX0ud7ugKCdDhqkTQ91nMVbamCX4Ui0ol
	 MRVr/NzN/3c07YcqxfNd++RgvFSKQ5dx+4+TvQ15jUiOoF4HLaBauf3LHpNsV5bH8Qk0s
	 zskW+z39GmcJtD6fMt35gVy2T39Mb6eJPNKwr+0VvUhQjXVwTHDbE/z25m72kqZCrtV5Q
	 BjDkL9WDRC48y99F9wkVQHchq4hij+qM5+1JT59ipUuq59/TOaYucC3loiLH69l4aDbPl
	 VIAO7TE18oPorQ2rtoGcr7hBOM/hGFWGCAtZ60ye47h+kpVhi8YK8SfocGjrJ96083g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794801560;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=M24YBwVdljW6Z4M0m6edrEfk574WlBb978Drz2g4Ie8=;
	b=VcLy+/htGGgUkYmaUXi9AhNPGF3ydtt0J5mwmCokQ4AkJ9yh/MLwrRoT5kKYLFFIrIP4
	 JvfNtCGIzCmhaFAEq1zrnD6QPcXqqKBiBmhhBFRQbyVtwgUZS5NOum1BgxiFDkJhkqxqH
	 LLkch3yvWl/wzarKrtrwmgTO7t1dsM9fUTRf3vEq2hYhUZLRbHE0OA7kvpeXEAeQz/67S
	 opoc3a7JI9Zqonvb7nsASjrQz3r/sfLy+esSbJVqFgbc/Y4973S5E/DVDH8GUOd7aqDL2
	 OhBFK2BuQagU1Kw5XVpOH67KyEcCyQgmO9wrX5NuALGAgbJMK2PuT45X6vRmfm1+mwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4029606A8A2;
	Mon, 16 Nov 2026 03:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4029606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Axj9GTf_pqTgAgAA--.27060S3;
	Mon, 16 Nov 2026 11:59:15 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxJs2Mf_pqKNE0AA--.64529S6;
	Mon, 16 Nov 2026 11:59:14 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Allow unaligned access in jit_insns/tail_call
Date: Mon, 16 Nov 2026 11:59:07 +0800
Message-ID: <20261116035907.4215-5-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261116035907.4215-1-yangtiezhu@loongson.cn>
References: <20261116035907.4215-1-yangtiezhu@loongson.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxJs2Mf_pqKNE0AA--.64529S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1ftw47Wr13XFyxKw4UGFX_yoW8WF4Dpa
	4ku34ktF1xWF1Fqw47J39FgFW0ka4DXFZ5Kw1YvrWFywnrJr97XFyxKFWYgr93urW8Zw1f
	Zwna9Fs8Wan5CFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jrPEfUUUUU=

On architectures that may lack CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
such as RISC-V and LoongArch, the verifier rejects test_tail_call due
to a misaligned 8-byte load (BPF_DW) from the packet pointer, which is
triggered by the architecture-specific NET_IP_ALIGN offset variation.

As this test focuses on tail call rather than alignment enforcement,
set `.prog_flags = BPF_F_ANY_ALIGNMENT` in `bpf_prog_load_opts` to
bypass strict alignment checks on architectures lacking efficient
unaligned access.

Before:
  $ sudo ./test_progs -a "jit_insns/tail_call"
  ...
  6: (79) r3 = *(u64 *)(r2 +0)
  misaligned packet access off 2+0+0 size 8
  ...
  Summary: 0/0 PASSED, 0 SKIPPED, 1/1 FAILED

After:
  $ sudo ./test_progs -a "jit_insns/tail_call"
  ...
  Summary: 1/1 PASSED, 0 SKIPPED, 0/0 FAILED

Fixes: a9fee553d3db ("selftests/bpf: Extend the JIT instruction tests for arm64 encodings")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/prog_tests/jit_insns.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
index 4110b1ff6ff8..bdde6caa871e 100644
--- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
+++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
@@ -3620,6 +3620,7 @@ static void test_tail_call(void)
 		{ (~0ULL << 32) | 2, TAIL_FALL }, { ~0ULL, TAIL_FALL },
 	};
 	LIBBPF_OPTS(bpf_prog_load_opts, lopts,
+		.prog_flags = BPF_F_ANY_ALIGNMENT,
 		.log_buf = log,
 		.log_size = sizeof(log),
 	);
-- 
2.42.0

