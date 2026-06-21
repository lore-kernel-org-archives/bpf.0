Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D6020468E
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782055796; cv=none; b=fGG4rLdMSB+v+bH2/7BBrAEYx37YxAcdA9fKB+aAtdAV326ij0/+yNg5pyivuGRXzWUlPB3HS1WOGDc/W0NRZKLAXndqHGVhW0wOVEZRIbxtZQw5xlybhQQS5Nb47vqDo5Hb7oADjno0Xi3O0p8m7qGdA+WvL3AR0/xBqyWf8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782055796; c=relaxed/simple;
	bh=1Racw4w+oifLSUHts8BIdTiEtrNJ4IXDU36qL7nY0m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkAGhvd2/lW3rBaLHuOuAW7Q6ejMZCZxHcf1U81C5/efxMVAT2hjp9GdpE/ZXtXUhe/vaPxwIIBZWIPAj+EjfQE6jn+6F+9WHx1mymQVvXfOhUzUSUNHW7wr+sXLkfjWsDVkLrmNK+c2tMkaq1x/RHRM0v7JJ9AkN/2cDfCK+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dMOkSt88; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dMOkSt88"
Message-ID: <9256454d-6323-4eae-8a0a-e6bcecc92098@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782055792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXtKB3DTP74Zpe4GVVilAwVpiIeTH2RKfVxLjuajtz8=;
	b=dMOkSt88ufSbC5yRSuaHOsQ6mk10TNjonZi45PqbJGJ7ITnLR9eZE1TkqDl+p3v7jhWq1M
	1dvWi+wZVHInyrz6UYDdleqdA8r0LvSZOt87Q+6ipAvs+4PE7S9rLtnrxm9Qqd49muevJO
	muGxCzETCRS0Ltjy+4EoxSdWq41UKrk=
Date: Sun, 21 Jun 2026 08:29:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Preserve scalar zero spills for
 var-offset stack reads
Content-Language: en-GB
To: Woojin Ji <random6.xyz@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org
References: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/13/26 4:16 AM, Woojin Ji wrote:
> Variable-offset stack reads currently lose the known-zero fact when the
> loaded byte comes from a spilled scalar constant zero rather than from a
> STACK_ZERO byte. This series teaches the var-offset stack read path to
> preserve that zero fact while marking the contributing spill slots
> precise, and adds verifier_var_off coverage for the new behaviour and
> the pruning-sensitive negative case.
>
> I don't have a confirmed deployed-program regression, so this is targeted
> at bpf-next. I did confirm the pattern is reachable from normal C codegen
> with a small helper-based BPF C reproducer: clang 22.1.6 -O2/-O3 can
> produce a spilled scalar-zero plus variable-offset stack byte load pattern
> that the unpatched verifier rejects and the patched verifier accepts.

Could you share your C code to desmonstrate patch 1? We can then check
whether the pattern is common and whether the code can be easliy worked
around with source code (e.g. barrier_var() etc.).

>
> Changes in v2:
> - Rebased onto bpf-next.
> - Split verifier and selftests changes into separate patches.
> - Added bpf_bt_set_frame_slot_mask() instead of open-coding a slot loop.
> - Kept the new eager precision marking on the variable-offset read path.
> - Added verifier log assertions for the zero result and mark_precise trail.
> - Added sub-8-byte spill coverage with STACK_ZERO and STACK_MISC neighbours.
> - Cleaned up inline asm formatting and local labels.
>
> Tested with:
> - make O=../../out/kernel olddefconfig
> - make O=../../out/kernel -j$(nproc) kernel/bpf/verifier.o
> - make O=../../out/kernel LLVM=1 -j$(nproc) bzImage
> - ./test_progs -t verifier_var_off -v
>    Summary: 1/30 PASSED, 0 SKIPPED, 0 FAILED
> - ./test_progs -t verifier_spill_fill -t verifier_live_stack \
>    -t verifier_search_pruning -v
>    Summary: 3/127 PASSED, 0 SKIPPED, 0 FAILED
> - veristat -o csv verifier_var_off.bpf.o
>
> Assisted-by: opencode:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> ---
> Woojin Ji (2):
>        bpf: Preserve scalar zero spills for var-offset stack reads
>        selftests/bpf: Cover var-offset stack reads from zero spills
>
>   include/linux/bpf_verifier.h                       |   5 +
>   kernel/bpf/verifier.c                              |  55 ++++++--
>   .../testing/selftests/bpf/progs/verifier_var_off.c | 148 +++++++++++++++++++++
>   3 files changed, 198 insertions(+), 10 deletions(-)
> ---
> base-commit: 7bfb93e3475be9de894f1cecd3a727d3e1649b03
> change-id: 20260610-bpf-stack-var-off-zero-v1-34ad1bc3b533
>
> Best regards,
> --
> Woojin Ji <random6.xyz@gmail.com>
>
>

