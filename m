Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC63ECBF7
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077185; cv=none; b=f/Sen/U2jQtIUcJC//U0PdjGTrHGZJyusVc+thBbWK/PbYreJaD/MMw4hBrvXBOM+uD9kyOa/xWM2SBi9kC36c89V18nUDCdTHHiqgx5stC5wAXXqkXToYDOWgY3UIwBon5BqZHG6FKh5BfcHgfIk9xbRaJThOZS11dKXKYQPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077185; c=relaxed/simple;
	bh=NERabj5m4gDnVtXCFk2aZUnGbJgtAqwV4vs/cR0Tfu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aznYNpzQ9eJZkccWnl3psYLZOwH3w76Kn6z+CRwow0lVC3OxRbBKtHKZ9Z51qPZNX8qdgMA6ZWcCEJ1D8Nok3h+AHzFXx+RwbaW/LmCo1rppPKTEhedHvkEOeCaRNGSBq12Or6bWXoUsVbJqXtrQ0IOjlTgogKq1RUvjZx5HNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnwbOreO; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnwbOreO"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd7aab92dfso230900185a.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773077183; x=1773681983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8jXCW9TlCZ3hHSi9kSS7Ek8EU10bJr55LqLcA1zyr+4=;
        b=VnwbOreOrdyAIE0pP4dCr/nGFQm/SLVnYu9/LSL/ICNeBIyK+MnpEczCcclBUCAsEj
         u+BeXSaxWmKZB1fuePzxLpg0itBgfEIxTP/fM3y/Sk6L9yuVIpLPxUiAsLHIZfv6LA2B
         NOZBCt1H/5uFMIlCG7qcpLE07cIKW3LOd8iVgdtH0Buef9cczeumDD8DRGoUH4Fpo6mw
         Ct7EzbPfju9PCmDBfmO2ugpoIHT55jAebsNy9WEnaLLOgh2hZRLsX2X0fMgGeqIwid2W
         jZqOLMXb5xy1eWxSw9cJle6tQEosPN1Fx4uXp6JcsKIfCrlDRUlcQKoI8buIsgXXi17E
         AgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773077183; x=1773681983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jXCW9TlCZ3hHSi9kSS7Ek8EU10bJr55LqLcA1zyr+4=;
        b=NpbRCbgdq/W9S2oiy5pxN5+kGSCMM5EAF6RsqUSv19KnGGAoYePozwFmAnFTB0sHFo
         fpMnMBkwf8TdjD+W0lPk33tE70q/G/+0r6LISYUCdk2eCJcRbUk7SIMPUYYxmTuBAFoB
         9laM8mbuCCGf2F2Rvj1LvLWxh7/S1XeqN7Jtc73c9qBGbB2+wf1bgVTwDQ+BTGQ7i3SN
         02q9Yp2ZTExwoYgojWBrPgxoE9Zx1vH8iZB1Ax8Lv50tke6aUc92Rf83cOKt7D57d5Ce
         T3rBNV+jufnXT/ZmcERM7jYjeT6aY1HhLpA8dLP9iMqa7NoFytGdTE7eZmi1kS4zLroT
         fDFA==
X-Gm-Message-State: AOJu0Yx5yPxNs0WhteQZcGOj5lut/ihFK0+8LJR4gHT7+9UC2zfpxql9
	1xt6noy9c445oOdqiiJngGsflfFPuLPbUgTaH83HryKXKC4RaKfcxKyu
X-Gm-Gg: ATEYQzwlyWtQPxDrExutUxKKP4+5Cb+um+y5wav72Xmk48I5s8Jkei/w1XXBcJbSjiU
	7MXdiWje0FOPVbQl0QLeGczdZ6NIsG8r/cinpbece6e/m2UJ8qd0sPElOErxL1csFb5JcLxWEbP
	c7U5Q84MNjVT0bTlMUiT9f7E8sPMVavf7yhqTRs9pWCaXGVT4iLDk++VHKLX7/ct+1+UK3XmhZb
	ALjDYw5HnVN6tN2vDCRflUE/Sg57KH47wtbImeVdQbxsRfkMNvxUYyF6jw3pYtg8G0XJ/xwXYd7
	c4BWO3RFO43p78QgCi2XyStqk3fia+cCNG89HBPpcL/+JveuPzH7Qt8ABDdLUNFRz2L42gRkIyf
	eoAhTXzgO6ANIWROumVOT/cWTGTYEUANuGGIx7ReYJn26ZRpPZS6UgVNUW4WktrfrCXulhx50QG
	3843Dxx7QfiIvrKb2/pS2YG4ZLCeEbppiL5Jk51w/fkuc=
X-Received: by 2002:a05:620a:414a:b0:8b2:1fa8:4684 with SMTP id af79cd13be357-8cd93b4cec5mr56470085a.2.1773077182874;
        Mon, 09 Mar 2026 10:26:22 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd90aae370sm114447185a.28.2026.03.09.10.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:26:21 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:34:49 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>
Subject: Re: [bpf-next v8 0/5] emit ENDBR/BTI instructions for indirect jump
 targets
Message-ID: <aa8EuW4fcwOXnIP7@mail.gmail.com>
References: <20260309140044.2652538-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309140044.2652538-1-xukuohai@huaweicloud.com>

On 26/03/09 10:00PM, Xu Kuohai wrote:
> On architectures with CFI protection enabled that require landing pad
> instructions at indirect jump targets, such as x86 with CET/IBT eanbled
                                                                  ^ enabled
> and arm64 with BTI enabled, kernel panics when an indirect jump lands on
> a target witout landing pad. Therefore, the JIT must emit landing pad
           ^ without
> instructions for indirect jump targets.
> 
> The verifier already recognizes which instructions are indirect jump
> targets during the verification phase. So we can stores this information
                                                   ^ store
> in env->insn_aux_data and pass it to the JIT as new parameter, so the JIT
> knows which instructions are indirect jump targets.
> 
> During JIT, constants blinding is performed. It rewrites the private copy
> of instructions for the JITed program, but it does not adjust the global
> env->insn_aux_data array. As a result, after constants blinding, the
> instruction indexes used by JIT may no longer match the indexes in
> env->insn_aux_data, so the JIT can not lookup env->insn_aux_data directly.
> 
> To avoid this mistach, and considering that all existing arch-specific JITs
                ^ mismatch?
> already implement constants blinding with largely duplicated code, move
> constants blinding from JIT to generic code, before copying instructions
> for each subprog.
> 
> v8:
> - Define void bpf_jit_blind_constants() function when CONFIG_BPF_JIT is not set 
> - Move indirect_target fixup for insn patching from bpf_jit_blind_constants()
>   to adjust_insn_aux_data()
> 
> v7: https://lore.kernel.org/bpf/20260307103949.2340104-1-xukuohai@huaweicloud.com
> - Move constants blinding logic back to bpf/core.c
> - Compute ip address before switch statement in x86 JIT
> - Clear JIT state from error path on arm64 and loongarch 
> 
> v6: https://lore.kernel.org/bpf/20260306102329.2056216-1-xukuohai@huaweicloud.com/
> - Move constants blinding from JIT to verifier
> - Move call to bpf_prog_select_runtime from bpf_prog_load to verifier
> 
> v5: https://lore.kernel.org/bpf/20260302102726.1126019-1-xukuohai@huaweicloud.com/
> - Switch to pass env to JIT directly to get rid of coping private insn_aux_data for
>   each prog
> 
> v4: https://lore.kernel.org/all/20260114093914.2403982-1-xukuohai@huaweicloud.com/
> - Switch to the approach proposed by Eduard, using insn_aux_data to indentify indirect
>   jump targets, and emit ENDBR on x86
> 
> v3: https://lore.kernel.org/bpf/20251227081033.240336-1-xukuohai@huaweicloud.com/
> - Get rid of unnecessary enum definition (Yonghong Song, Anton Protopopov)
> 
> v2: https://lore.kernel.org/bpf/20251223085447.139301-1-xukuohai@huaweicloud.com/
> - Exclude instruction arrays not used for indirect jumps (Anton Protopopov)
> 
> v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweicloud.com/
> 
> Xu Kuohai (5):
>   bpf: Move constants blinding from JIT to verifier
>   bpf: Pass bpf_verifier_env to JIT
>   bpf: Add helper to detect indirect jump targets
>   bpf, x86: Emit ENDBR for indirect jump targets
>   bpf, arm64: Emit BTI for indirect jump target
> 
>  arch/arc/net/bpf_jit_core.c      |  37 +++-----
>  arch/arm/net/bpf_jit_32.c        |  43 ++--------
>  arch/arm64/net/bpf_jit_comp.c    |  86 +++++++------------
>  arch/loongarch/net/bpf_jit.c     |  58 ++++---------
>  arch/mips/net/bpf_jit_comp.c     |  22 +----
>  arch/parisc/net/bpf_jit_core.c   |  40 ++-------
>  arch/powerpc/net/bpf_jit_comp.c  |  47 +++-------
>  arch/riscv/net/bpf_jit_core.c    |  47 +++-------
>  arch/s390/net/bpf_jit_comp.c     |  43 ++--------
>  arch/sparc/net/bpf_jit_comp_64.c |  43 ++--------
>  arch/x86/net/bpf_jit_comp.c      |  68 +++++----------
>  arch/x86/net/bpf_jit_comp32.c    |  35 ++------
>  include/linux/bpf.h              |   2 +
>  include/linux/bpf_verifier.h     |   9 +-
>  include/linux/filter.h           |  15 +++-
>  kernel/bpf/core.c                | 142 +++++++++----------------------
>  kernel/bpf/syscall.c             |   4 -
>  kernel/bpf/verifier.c            |  45 +++++++---
>  18 files changed, 233 insertions(+), 553 deletions(-)
> 
> -- 
> 2.47.3
> 
