Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B33D6CB6;
	Thu, 24 Sep 2026 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217595; cv=none; b=nc0JaTpwPvBY65QgmSjia6hQQ3DzHqbCv5q9BWmlqPS++GQjZJnI4iNPAuCkpGuo1d02kBFffmmXSh4AtIWnBq7WhCKu7YxPoUYegKDN3Vd9kjID/dY6Hb14ADTfxFJ1NwuW+aUvBBaTE1Nq6lhjOAgFL8yhK+qZnLzgG/pCBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217595; c=relaxed/simple;
	bh=kzpHYxlSC/Rh8HYGr3GyeEu+QlLEvOP1LNHGRcsKLCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6X4x1+kQvbJqgr2HECd3Qp/hM2vv2Vcidv8dUtnZmFssUqJHbnT7b/1Go1x6DDoL/lrd0PggJpOxcPo7K1P3O8o6iLU0GSKZmETANJ3TjsoBgU0M4G7rVfNFPmtcy+k9QsqpQPJoSkN2An/g+qvrp8rbH5sSzpGG8UDUW4zsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hwr9KpMV; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hwr9KpMV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790217589; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=ntFrnbFKVOPPVdZ3Ykel3pjZPpOGPr9Y+tWrYXhQKOE=;
	b=hwr9KpMVO3P71T2+8xisG4dxtKPjm0uPh/F0xIqsoEzqGbk6lirK63YHu+qHVPFQlYNMpka+kISjJiKQU67fJ2YQ8NUx67NU5tYdGTjmUYKy0P3Wg69HIMW84SV4EAJiyJiPNakSuf9oCIxCd3GYqyMDMGD0lA2RaOGxY4TKCVQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBYFZuB_1790217578;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBYFZuB_1790217578 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 10:39:48 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	shuah@kernel.org,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] bpf, riscv: Add support for indirect jumps
Date: Thu, 24 Sep 2026 10:39:36 +0800
Message-ID: <20260924102938-gotox-v2-style-question-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923130856.1157-1-cp0613@linux.alibaba.com>
References: <20260923130856.1157-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Thanks for the reviews. Patch 1 is a plain wording fix and will go into
v2. For patch 2 I need your input on one thing before I respin: which
form of the #endif comment you would prefer.

Patch 1, on the comment above bpf_prog_update_insn_ptrs():

> This isn't a bug, but could the comment say "shift ctx->offset[] by one"
> rather than "shift the linfo array by one"? The jited_linfo was already
> filled in by the bpf_prog_fill_jited_linfo() call above, and it is the
> JIT's own offset table that is being rewritten here.

Agreed. Fixed in v2.

Patch 2, on the #endif marker in verifier_gotox.c:

> [Severity: Low]
> This isn't a bug, but does this newly introduced multi-line comment
> follow the BPF subsystem style guide? The subsystem guidelines
> explicitly require that multi-line comments have the opening '/*' on
> its own line, rather than beginning text on the same line as the
> opening marker.

I would rather collapse it to a single line, but there is more than one
way to spell it:

  a) 89 columns, clean under scripts/checkpatch.pl --strict:

#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 || __TARGET_ARCH_powerpc || riscv64 */

  b) 101 columns, keeps every macro name verbatim, but checkpatch then
     reports "WARNING: line length of 101 exceeds 100 columns":

#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 || __TARGET_ARCH_powerpc || __TARGET_ARCH_riscv */

  c) or a short marker that does not repeat the condition at all:

#endif /* gotox-capable arch */

I lean towards (a): tools/testing/selftests/bpf/progs/ otherwise only
uses single-line #endif markers, and "riscv64" matches the guard, which
is __TARGET_ARCH_riscv && __riscv_xlen == 64.

I will send v2 with the patch 1 fix and whichever form you pick, together
with any other feedback, so please let me know if you would like anything
else changed. If nobody has a preference, I will go with (a) in a few
days.

Thanks,
Pei
