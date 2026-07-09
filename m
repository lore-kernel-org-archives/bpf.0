Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105D044999A
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626903; cv=none; b=SQABr0CqgkCW5v/vBQZUGg2om2yGAL00RWZUiw/4gW/KS8TXqXhg/Uh6Gh8qr7juX/FEFzxG2/HrJ0QvjvAK+GQ5rFSHKoKsJkSzMimxINs7xOrgoGyLrlbxb2PYhRsO7PzfQzovINEjr4z6f2IbVBN1v5Wl2JmbCicOR6a/o70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626903; c=relaxed/simple;
	bh=tu5B7qQIDTPnW/i0rxWfXCEXZ/pFQ4ga9iA5FCzX0Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZatQTe/ONu/X/dz7nMh36DsH+ZcNwWvWCncpoYbMXa4oypO7TntYXCJWF/X5s9xD4bo8acaVCZUaS2Z1Rmu6uZ8HgxEDltMFupwAtVtyutNY2uCKRIFBGbLlyr9RYFe/9nbvbkuk0M1xQoqhxGmMfTJdb9kxijqLe236BgUv/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ilH6iENW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ilH6iENW"
Message-ID: <24e9b4a4-2ddb-431c-8821-c260a6641255@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783626900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ADkbJHwXAoybo60wPzpMX11G3ZSo+o9NtfAAIE+fm4=;
	b=ilH6iENWQw0+OQ3f1f87LSo79NzXBwRmewFmCh+yuLHoRZZtI9zlPB7n0CZC5jQF3ma6kp
	d0HmOZ3WqQT0bPXysK8aduJ+2hgqCkxziWo1zx4ENNVJU/AkSfTIvyy6BbsUsiEarcAp8G
	wmmtKOFGKgh8j3kPoP6AhgCAlgVDJxE=
Date: Thu, 9 Jul 2026 12:54:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 09/12] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260708201025.2160583-1-yonghong.song@linux.dev>
 <b4271ab7b2a5eb033b22efc367ad93796a92d63f65b7f1acafc80f9ef24d55ca@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b4271ab7b2a5eb033b22efc367ad93796a92d63f65b7f1acafc80f9ef24d55ca@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/8/26 2:10 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> new file mode 100644
>> index 0000000000000..d4ecc19684cef
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> @@ -0,0 +1,96 @@
> [ ... ]
>
>> +/*
>> + * Run one program and check its result. The program returns 0 on success, or
>> + * 1..4 identifying which half of which aggregate (R0:R2) return value came back
>> + * wrong. A return of -1 means the program was built with an LLVM that lacks
>> + * R0:R2 16-byte return support, in which case the subtest is skipped.
>> + */
> [ ... ]
>
>> +	/* C variant (__int128): relies on LLVM 23 R0:R2 codegen, skipped otherwise. */
>> +	if (test__start_subtest("int128_c"))
>> +		run_prog(skel_c->progs.aggregate_ret_test, true);
>> +
>> +	aggregate_ret_int128_c__destroy(skel_c);
>> +
>> +	skel_struct_c = aggregate_ret_struct_c__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel_struct_c, "skel_struct_c_open_load"))
>> +		return;
>> +
>> +	/*
>> +	 * C variant returning a 16-byte struct by value: exercises the struct
>> +	 * branch of bpf_ret_reg_pair(). Also LLVM 23 only.
>> +	 */
>> +	if (test__start_subtest("struct_c"))
>> +		run_prog(skel_struct_c->progs.aggregate_ret_struct_c_test, true);
>> +
>> +	/*
>> +	 * Same 16-byte struct return, but from a global (non-static) callee:
>> +	 * exercises the compiler lowering a global struct-returning function to
>> +	 * R0:R2 and the verifier's global return path end to end. Also LLVM 23
>> +	 * only.
>> +	 */
>> +	if (test__start_subtest("global_struct_c"))
>> +		run_prog(skel_struct_c->progs.aggregate_ret_global_struct_c_test, true);
>> +
>> +	/*
>> +	 * Same 16-byte struct, but returned by value from a kfunc: exercises
>> +	 * the struct branch of check_kfunc_call() and the JIT RDX->R2 move.
>> +	 * Also LLVM 23 only.
>> +	 */
>> +	if (test__start_subtest("kfunc_struct_c"))
>> +		run_prog(skel_struct_c->progs.aggregate_ret_kfunc_struct_c_test, true);
> this isn't a bug, but the "Also LLVM 23 only." note is repeated on each
> of these per-subtest comments, and the run_prog() comment above already
> states that programs built without R0:R2 support return -1 and get
> skipped.  Could that note be stated once rather than on every block?

Ack. Will do.

>
> Related, do the per-subtest comments need to name the specific internals
> (bpf_ret_reg_pair(), check_kfunc_call(), "the JIT RDX->R2 move"), or
> would a shorter note serve here?

I guess I can rename these comments, function names themselves already have
enough information.

>
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> index c36bb911defa7..34d0a352e70dd 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> @@ -55,6 +55,15 @@ struct prog_test_big_arg {
>>   	__u64 b;
>>   };
>>
>> +/*
>> + * A 16-byte struct returned by value from a kfunc, returned in the R0:R2
>> + * register pair.
>> + */
>> +struct bpf_kfunc_ret_ll {	/* 16 bytes: R0:R2 */
> this isn't a bug, but the block comment already says the struct is 16
> bytes and returned in the R0:R2 register pair, and the trailing
> /* 16 bytes: R0:R2 */ on the next line repeats that.  Could one of the
> two be dropped?

Yes, will drop.

>
>> +	__u64 a;
>> +	__u64 b;
>> +};
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28973410219

