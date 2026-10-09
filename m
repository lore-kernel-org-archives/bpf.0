Received: from mta1.migadu.com (out-242.mta1.migadu.com [95.215.58.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6D3B775A
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565471; cv=none; b=Pz8QXIVcT2TjaCB0UQPNwx7IE7HlmgaPDrQXvtkdToXSXgwSXeOBH/J4T3VgW60mf0kF1ntyz9RSw1OlRf8v5GMDiTt+eRDmL1wcM6EOEz/8UgV+qcfbOHKWoql69JGb3VZJC7QxRqAea4qktxannSzEyEcBik4AZPjo3vgPdPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565471; c=relaxed/simple;
	bh=91wR6FXsFf3LicI1P/Q/VfvmtIfJiP+UYiuZiGtXSx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YycZ3m+/eigDCq4vIerD93TKinEbodZKJFrT1CpWoww3YKVFSl8WzsCZ6+dG7hmsKR/SnihelAe/87orTL8odOgPn/AZnKRDFHFiSiWdeSPjbDtus1D89xL4OlgigWSt/SmhjzT613Xu8CSJAUTbIl15njdcfsWNhpQ1CW8h2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K7MfXqxE; arc=none smtp.client-ip=95.215.58.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K7MfXqxE"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=91wR6FXsFf3LicI1P/Q/VfvmtIfJiP+UYiuZiGtXSx4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791565466; v=1; x=1792170266;
 b=K7MfXqxEVGeTQa1RX5PNGz5wRHmAfUwMb+uquDH26RCQyFxxvd8FycOaVLrEltzFejORt4jo
 p6DPU8hnM5vxvuVQTw78qyqtLKXQ/QLx9i5vth94rkn25Ep35KZr3MkznivCgHeco5/ffstbblI
 SE6B6HyRNGu851ygN2gCI6mY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f5abe29e5e7bc4b5;
	Fri, 09 Oct 2026 17:04:26 +0000
X-Mizu-Trace-ID: f5abe29e5e7bc4b5
X-Migadu-Flow: FLOW_OUT
Message-ID: <741a2407-5d2e-44e4-b6a4-241089693a90@linux.dev>
Date: Fri, 9 Oct 2026 19:04:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: Test by-value __int128 kfunc
 arguments at an odd slot
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261009064211.1239307-1-yonghong.song@linux.dev>
 <18d9233ff61909ba7ef175caaa63248c2e70abfb0fe7d56a4fdb350d43eaa44c@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <18d9233ff61909ba7ef175caaa63248c2e70abfb0fe7d56a4fdb350d43eaa44c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/9/26 9:48 AM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Test by-value __int128 kfunc arguments at an odd slot
> TL;DR: On arm64 with an older pahole, the two new kfuncs lack BTF, so
> bpf_testmod.ko may fail to build or load, losing all bpf_testmod selftests,
> not just the new ones.
>
>> On arm64 the first two kfuncs get BTF only with the pahole patch
>> "dwarf_loader: Skip the argument register the arm64 ABI leaves as a hole"
>> [2], in pahole master after v1.32. An older pahole finds the argument
>> after the __int128 in an unexpected register, x4 rather than x3, and
>> leaves the function out of BTF, so the tests fail to load there.
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> [ ... ]
>
>> @@ -1763,6 +1786,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_deep)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg)
>> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd)
>> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd_many)
>> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_stack_hole)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_pad)
> Is the failure on arm64 with an older pahole really limited to the two new
> tests?

Yes, we use the latest pahole in github. Note that latest pahole is
also available to CI.

>
> Both bpf_kfunc_call_test_i128_arg_odd and
> bpf_kfunc_call_test_i128_arg_odd_many are added to
> bpf_testmod_check_kfunc_ids, the module's main kfunc set.
>
> With no BTF FUNC for them, resolve_btfids only warns ("no BTF func for
> kfunc ..." in collect_kfuncs() and "unresolved symbol ..." in id_patch())
> and leaves their set8 ids at 0.  With CONFIG_WERROR=y, scripts/Makefile.btf
> passes --fatal_warnings, so bpf_testmod.ko would fail to build.
>
> Otherwise, at module load bpf_testmod_init() calls
> register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set),
> and __register_btf_kfunc_id_set() checks every entry:
>
>      for (i = 0; i < kset->set->cnt; i++) {
>          ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id), ...);
>          if (ret)
>              goto err_out;
>      }
>
> btf_check_kfunc_protos() does:
>
>      func = btf_type_by_id(btf, func_id);
>      if (!func || !btf_type_is_func(func))
>          return -EINVAL;
>
> Id 0 resolves to btf_void in the base BTF (btf_relocate_id() maps 0 to 0),
> so this returns -EINVAL.
>
> That would reject the whole set, bpf_testmod_init() would return the error,
> and bpf_testmod.ko would not load.  test_progs then prints "Selftests
> relying on bpf_testmod.ko will be skipped", so every bpf_testmod-dependent
> selftest on arm64 would be lost, not only the two new ones.  The same
> configuration worked before this patch.
>
> Could the two arm64-hole kfuncs go into a separate kfunc set whose
> registration failure is tolerated?  Alternatively, should the commit message
> say that bpf_testmod.ko as a whole needs the newer pahole on arm64, rather
> than "the tests fail to load there"?

There is no need to test with old pahole. Rather we should use latest pahole.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37897160282

