Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF13E00A0
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419745; cv=none; b=HNbDtUo1V7xv5h1qpzDJScOY5nz9acqjOEIghVGHW5pdjee5drJdPyMEsTq4ygzL5d/OUnukOANvPx6oEGCIUOgfvvse/LXTpeqanA92rFhdpIO2OYvhaKdW4R1rz3MpNfU6RIDdTdkuxRQqesmjsTTK9iR2bmEMm8Kt3LFPQgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419745; c=relaxed/simple;
	bh=VnnYlecLaLwHXRISSV7NLIvrUi+L9CcBQ3+Tx4ZEDw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5bshz8zEPeSfrn1qCvL94dJfMZfXdnhssTROoQuqZIpTR8O2S4mePBTuBJsFYicEjzTOigqT9GQdnry7xwmJEARZSWPCRiYbm/IqC9SCOgqdphW7Lcy+RSfDN9ZkE7ntq5xLMjJ/lmbiR6DalqLDwyzpmhFLVh0+QafqyRQuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fmRNCLtb; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fmRNCLtb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783419742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STGqFQ6c0/W7YnxQ28Rkz97qioLVzpiO3UkQvXf2pcA=;
	b=fmRNCLtbgyAM5WXbEMwjP8Kzakn9gOCsUjH+4b178aE0C1+4yAmX3DTfldW1rh/G8xLTMi
	UGW7zRYQiCU7y+5Kdf5cuRJ2Uu6zfFcqq9K8ohQB3A1oAyYi4vcYtIEKhVYmT7NHTXcYrp
	xptfN5MbNx1vtgNE9s8DWvxNiY3sTWA=
From: George Guo <dongtai.guo@linux.dev>
To: yangtiezhu@loongson.cn
Cc: chenhuacai@kernel.org,
	hengqi.chen@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kernel@xen0n.name,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 02/11] LoongArch: BPF: Support internal-only MOV to resolve per-CPU addrs
Date: Tue,  7 Jul 2026 18:22:11 +0800
Message-Id: <20260707102211.342727-1-dongtai.guo@linux.dev>
In-Reply-To: <bcdfd520-8f88-b8d9-37e1-52e0368d40d3@loongson.cn>
References: <bcdfd520-8f88-b8d9-37e1-52e0368d40d3@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> How to test? Did you test under !CONFIG_SMP?

Good question -- here's why skipping the $r21 add under !CONFIG_SMP is
correct, not just untested:

1. $r21 is unconditionally zeroed at the earliest point in boot,
   regardless of CONFIG_SMP:

     arch/loongarch/kernel/head.S:75
       /* GPR21 used for percpu base (runtime), initialized as 0 */
       move  u0, zero

2. The only other writer, set_my_cpu_offset(), lives in
   arch/loongarch/kernel/smp.c, which is `obj-$(CONFIG_SMP) += smp.o` --
   i.e. not even compiled into a !CONFIG_SMP kernel. So on !CONFIG_SMP,
   $r21 stays exactly 0 for the kernel's entire lifetime; nothing ever
   touches it again after head.S.

This also isn't a LoongArch-specific judgment call -- it's exactly the
pattern x86's own upstream JIT uses for the identical instruction:

  arch/x86/net/bpf_jit_comp.c, insn_is_mov_percpu_addr():
    EMIT_mov(dst_reg, src_reg);
  #ifdef CONFIG_SMP
    /* add <dst>, gs:[<off>] */
    ...
  #endif

Thanks,
George
