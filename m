Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D73C1F41
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583548; cv=none; b=DnX2WmW5xWxHApBUw6yaj+g4ddvOMdCXaUWwwg1pBrZVobwo9qZ7pYmHoNjYO6YRt4ewDz/800NLehZcNc1siYengiM9WXLtd/GAAT8opWr7AnTTX2uva7EXhzXP8kxB/YfCnCtT42fQf0R2tOQ0GGirbsdBYQ6j9hI7mdTKxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583548; c=relaxed/simple;
	bh=CyIezXkQ/VhGdmEm4GlYfaMqz4teeTTJEP2eJp8jI2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cd08cTOjnEyogXEqaKlReK7ko4434bhzO2EMkEAmsuxQEIvbSFgc9bOzpby80ZB0vRx3zwLCIyaE4sD0kJZVPJGjOBGAfrPuHdF5HHLRSz81JpcJMNsslzo8XZqsBJ3Hs/kEUa6pg5SPQ9EZbSOQZW/TE6CaXZVWLqbrG6xwCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hWSF0rQ/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hWSF0rQ/"
Message-ID: <d9eaffaa-6bbd-4af1-97cd-e5e37917c526@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781583544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrUSZAQ1rnGB4qjnMvjNJy2mIoSq6793b2K3Eamsp5E=;
	b=hWSF0rQ/T3L10AU2l/hxyOea5z+cyOCB+j5p6lpAT4d84ncCtwpON5zWRNiBFwfkURnYNm
	n2bQ03IvXGHwBZdH9EtQ7OQEhQ2lmnARGxq5XTrGusabA91gmnWtov3GEDEjVHk3MPcsq7
	XweF8sos73u5Zt3VzJZp6KaL3CdmuVo=
Date: Tue, 16 Jun 2026 12:18:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 11/12] selftests/bpf: Add test to verify
 xlated insns for global percpu data
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260615152646.27639-1-leon.hwang@linux.dev>
 <20260615152646.27639-12-leon.hwang@linux.dev>
 <DJ9XY0Y2D2R8.16S9E0QFFMLQS@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DJ9XY0Y2D2R8.16S9E0QFFMLQS@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/6/26 05:29, Alexei Starovoitov wrote:
> On Mon Jun 15, 2026 at 8:26 AM PDT, Leon Hwang wrote:
[...]
>> +	ASSERT_EQ(ld_imm64_xlated[0].code, ld_imm64_raw[0].code, "ld_imm64 opcode");
>> +	ASSERT_TRUE(ld_imm64_xlated[0].dst_reg == ld_imm64_raw[0].dst_reg, "ld_imm64 dst_reg");
>> +	/*
>> +	 * The xlated instruction has the map ID in imm and the offset
>> +	 * in the next instruction's imm. The raw instruction just has
>> +	 * the offset in its imm.
>> +	 */
>> +	ASSERT_EQ(ld_imm64_xlated[1].imm, ld_imm64_to_u64(ld_imm64_raw), "ld_imm64 off");
>> +
>> +	mov64_percpu_reg = BPF_MOV64_PERCPU_REG(ld_imm64_raw[0].dst_reg, ld_imm64_raw[0].dst_reg);
>> +	ASSERT_MEMEQ(&insns[idx + 2], &mov64_percpu_reg, insn_sz, "mov64_percpu_reg");
> 
> If the point of the test was to check that percpu_array_map_direct_value_meta()
> computes 'off' correctly then it failed to achieve that goal.

It was to check the 'off' and the mov64_percpu_reg insn.

To avoid relying on the insns loaded from ELF obj, use raw insns to
check the 'off' with a percpu_array map:

	struct bpf_insn raw_insns[] = {
		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
		BPF_EXIT_INSN(),
	};

	skel = test_global_percpu_data__open_and_load();
	exp_off = offsetof(struct test_global_percpu_data__percpu,
struct_data.nums[6]);
	raw_insns[0].imm = bpf_map__fd(skel->maps.percpu);
	raw_insns[1].imm = exp_off;

	prog_fd = bpf_prog_load(...);
	err = get_xlated_program(prog_fd, &insns, &cnt);
	idx = find_percpu_ld_imm64(insns, cnt);

	ASSERT_EQ(insns[idx + 1].imm, exp_off, "exp_off");

Would this achieve that goal?

> It checks that map ID is correct which is a pointless test.
> Either make it a real test or drop this patch.
> 
No map ID check here.

Thanks,
Leon

