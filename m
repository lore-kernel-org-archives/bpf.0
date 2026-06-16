Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF6250C06
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584435; cv=none; b=RlWjTH/rA62B9dR3tNUozgoaABwdGK7LWkVlwIf4DsXS9Av+/3NpQTG1rIahQao9XQ/SwGHSjqoWhaBZT7OeSqKNkYEKrz0gv/nLhRVhNfNY/N1WzxnNwLg0ooC6WVAiu8F181yR4UUC2f5wQfSfZnpKQpDtugcbSxFjFAl+pJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584435; c=relaxed/simple;
	bh=LUKEtGqgxTHViq6iBN8Jg2duqnbgRJYePDpTCKI4HrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSdE93/SbPVXCPe5oFNSsJC6C88+IOj3zS75sTU01WSFuGqY8E2f8pGUJxLvJ69XaZpRf2oIFWSLci3jmSROxHdrTwyeIVbUZ2S0ilX6IDso/fw5NZA3yx6Ex4ZmnkzWuwSgcOclILnn1FLLXUwVTH42mvPVrrsXlfcUJMx77is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ft8/ERt5; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ft8/ERt5"
Message-ID: <b1efbbb0-d2ea-4050-aef7-e35db35bd8d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781584431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Gq0+z1rQrdFQFlUMw8WzxC/rc8erTBIXTVTj5Az1WQ=;
	b=ft8/ERt5YZeIoJPxdApVC4NzHxWQvvl4MECoVLr2tnBDD1p5in2moBAac77BQNpA88Zm2X
	KTBocwtr1LScgPRSqjo+FMk7U9UEaZXYugT1HPqfqmXsHgpoPtcz1MSUvySzIZ/6acYFle
	vvAsLFKyP4xD08dGHYPDHiEqnyLkGN0=
Date: Tue, 16 Jun 2026 12:33:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 11/12] selftests/bpf: Add test to verify
 xlated insns for global percpu data
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20260615152646.27639-1-leon.hwang@linux.dev>
 <20260615152646.27639-12-leon.hwang@linux.dev>
 <DJ9XY0Y2D2R8.16S9E0QFFMLQS@gmail.com>
 <d9eaffaa-6bbd-4af1-97cd-e5e37917c526@linux.dev>
 <CAADnVQLnnSrHDbw4OQCPrXz38wZ15PC1HuS1-aSB7LZxOQhd1g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLnnSrHDbw4OQCPrXz38wZ15PC1HuS1-aSB7LZxOQhd1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 16/6/26 12:23, Alexei Starovoitov wrote:
> On Mon, Jun 15, 2026 at 9:19 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 16/6/26 05:29, Alexei Starovoitov wrote:
>>> On Mon Jun 15, 2026 at 8:26 AM PDT, Leon Hwang wrote:
>> [...]
>>>> +    ASSERT_EQ(ld_imm64_xlated[0].code, ld_imm64_raw[0].code, "ld_imm64 opcode");
>>>> +    ASSERT_TRUE(ld_imm64_xlated[0].dst_reg == ld_imm64_raw[0].dst_reg, "ld_imm64 dst_reg");
>>>> +    /*
>>>> +     * The xlated instruction has the map ID in imm and the offset
>>>> +     * in the next instruction's imm. The raw instruction just has
>>>> +     * the offset in its imm.
>>>> +     */
>>>> +    ASSERT_EQ(ld_imm64_xlated[1].imm, ld_imm64_to_u64(ld_imm64_raw), "ld_imm64 off");
>>>> +
>>>> +    mov64_percpu_reg = BPF_MOV64_PERCPU_REG(ld_imm64_raw[0].dst_reg, ld_imm64_raw[0].dst_reg);
>>>> +    ASSERT_MEMEQ(&insns[idx + 2], &mov64_percpu_reg, insn_sz, "mov64_percpu_reg");
>>>
>>> If the point of the test was to check that percpu_array_map_direct_value_meta()
>>> computes 'off' correctly then it failed to achieve that goal.
>>
>> It was to check the 'off' and the mov64_percpu_reg insn.
>>
>> To avoid relying on the insns loaded from ELF obj, use raw insns to
>> check the 'off' with a percpu_array map:
>>
>>         struct bpf_insn raw_insns[] = {
>>                 BPF_LD_MAP_VALUE(BPF_REG_1, 0, 0),
>>                 BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
>>                 BPF_EXIT_INSN(),
>>         };
>>
>>         skel = test_global_percpu_data__open_and_load();
>>         exp_off = offsetof(struct test_global_percpu_data__percpu,
>> struct_data.nums[6]);
>>         raw_insns[0].imm = bpf_map__fd(skel->maps.percpu);
>>         raw_insns[1].imm = exp_off;
>>
>>         prog_fd = bpf_prog_load(...);
>>         err = get_xlated_program(prog_fd, &insns, &cnt);
>>         idx = find_percpu_ld_imm64(insns, cnt);
>>
>>         ASSERT_EQ(insns[idx + 1].imm, exp_off, "exp_off");
>>
>> Would this achieve that goal?
> 
> Hmm. There is nothing like that in the patch.
> What are you talking about?
> Some future improvement to the patch?

It is future improvement to the patch. Sorry, it is too far from the patch.

> My question was about the patch you posted.
> What was the point of it?

The point of the patch was to check that
percpu_array_map_direct_value_meta() computes 'off' correctly against
the 'off' encoded in ELF obj, and a mov64_percpu_reg insn should be
added after loading the prog.

Thanks,
Leon

