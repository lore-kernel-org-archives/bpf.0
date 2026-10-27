Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793081602;
	b=1rMqDhmSWbkzHOEz4MdPJFV17z/G9NERsklzHnYQv4raImNMer5G4J80sEUhEL2RfvE6
	 JLx8kii/Rn+AJSeP5FTjFbEoncpa4loBuM00tbFPSqIEbUcNATSqkibxU6NyBgjHjOawp
	 kP/3bpKx9YpV1gneQFwRvzBNaf3a+JfvbTSCXuaVwez+jKajYh7RV2ZWbxHWLnvaJq2ub
	 odBRIUpyWxA3mSyvu+3q58rseMtfFmUy6hhe6fhOk3M8Ndp1ns81rsy/ORcSPRyDfWFGc
	 PjhJG7+8LXwAmOrM8iwpnH61aBno75ln7M8GTgwAOug8fUe28dcbaFImicm2OXxDJNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081602;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=eTQcM35wkXRP7x9YE5akwcG87yvqzUVbNdPulhmBNkU=;
	b=b1kJ7oZFDn51l9XY8mKCVPFbOyz82JxcGH2bNMvTRce+hn3qodPBRJpG2bQD6YZTYZWJ
	 K+g1Ou0/eQWiqetb7yS8CdKJjMrJOLVC8gNDZ2C1BL6VEe1Xk9dex0PTDnvJ1T5SSg/GA
	 Czc0vJZ6YKXoIIXJXq0F4QHwEJ/gaD8sahuJL+w8kSlh73tMAvpLIW9UTh6ikSgyEl/xJ
	 y9UfshT9fzTXI/mBr0papYNy+gl8c4RYWvPsNgpkd8m/7zrbPWCzmbWm5wTHXf4HgIGEw
	 QW8LOdfthCx4JZJXW3Px3Jx3Ggr+LPVoKXvhFy5IcLc5PSH1nSWrNaeZkXHMI31KdNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b="aYhjWkm/";
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78FE606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 06:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E78FE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=aYhjWkm/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=eTQcM35wkX
	RP7x9YE5akwcG87yvqzUVbNdPulhmBNkU=; b=aYhjWkm/wV6k29MmN7ShwDEehI
	wpcSZVCk9O3NX7nbTwPnjtZpdMJlDmODv2MnVzUqgWSx6YDQMW9OFwB1/acMSLJe
	BVpFJH6YwAkWEsNzNLbsvsex3eRa+uEZz510Dco3Q1plCkCoaPHNMZq4Nbi53gDZ
	oQ+XLVB/yTUGUQmRk=
Received: from localhost (unknown [222.195.81.103])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCXASbzQOBq_t9OAA--.1181S2;
	Tue, 27 Oct 2026 14:13:07 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf 0/2] bpf: Fix stack argument precision propagation
Date: Tue, 27 Oct 2026 14:13:01 +0800
Message-ID: <20261027061303.1754535-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:3pYKCgCXASbzQOBq_t9OAA--.1181S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWktr4DJrW8ZrW7ZFyfCrg_yoW8Aw1Upa
	s5C3WaqFykAF1Skan3Zr48uFWrXan5Ar1UJr4xJFy7AF15KFn5tF47Ka1Yya45JrsrZ342
	qw1jqwsxWa15AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjxUyq-5UUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

This series fixes two omissions in scalar precision tracking for BPF
stack arguments.

State comparison already uses precision marks on outgoing argument slots,
but state reuse does not propagate their dependencies to the current
path's ancestors. Earlier checkpoints can therefore fail to distinguish
scalar argument values later used as memory offsets. The conservative
all-scalars-precise fallback also omits argument slots.

Patch 1 includes stack argument slots in state-reuse precision propagation
and in the conservative fallback, including slots owned by caller frames.
Patch 2 adds nine load-only tests covering the sixth and seventh arguments,
caller and nested frames, acceptance and rejection controls, and fallback
log checks. The tests construct instructions and BTF directly, so they do
not require compiler support for emitting stack arguments.

Built the kernel, modules and complete test_progs with BPF_STRICT_BUILD=1.
On x86-64 KVM, all nine new tests and 246 existing subtests passed, covering
verifier_precision, verifier_spill_fill, verifier_subprog_precision,
verifier_scalar_ids and iters. The unmodified base fails six of the new
tests as expected. Three existing compiler-dependent stack-argument groups
were skipped with Clang 20; all new tests ran.

AI assistance was used to prepare the patches, tests and descriptions.

Xu Yunxiang (2):
  bpf: Propagate scalar precision through stack arguments
  selftests/bpf: Exercise stack argument precision on state reuse

 kernel/bpf/backtrack.c                             |  11 +
 kernel/bpf/states.c                                |  14 +
 .../bpf/prog_tests/stack_arg_precision_reuse.c       | 300 +++++++++++++++++++++
 3 files changed, 325 insertions(+)

base-commit: 195a3519ff27bff5575e05b5086e38ee92715776

