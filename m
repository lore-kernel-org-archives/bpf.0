Received: from mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA439A04B
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702853; cv=none; b=fzonBIOCLaZKTeyZqZtk5nfWSLIRZb46Ms8xqRCtf33VuhWcP/RCDEyTC3uIUn7EShoFs8RjFL/J1AMmiIN76S9o1Uw/fJS1kVT6fnylkEeAlf9G5tkfe9NSFSoFPXPtfeG2lcBAkAE2KiTElKZLoMXha6BMTGc9AfI39DryJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702853; c=relaxed/simple;
	bh=Uv5zEHjMd+w1DdPtOHXhmJP+uV90Dqm5zdgq8vhBFeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EG5xgJSmr+kOdlgWOmPwzUtLD4jC0UJhn7kXYvuP1BAuV3oP4oXpqFHDBwvvHnkFKi3HDNspqICl/3RyTxHgTBw7yciDPLpQB8bC0HG6NpDSsMr1C+lKmwse9utkJzXxmNMbfcsEds6BPKxi45I7SbCIwfwJB7mNmWc9A7tma3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s06KT261; arc=none smtp.client-ip=91.218.175.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s06KT261"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Uv5zEHjMd+w1DdPtOHXhmJP+uV90Dqm5zdgq8vhBFeg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789702850; v=1; x=1790307650;
 b=s06KT261f1MZi/WzwJXikEW7R11WGZwOQSiFZIETpMtG1RmzcDXLDn+kIDqZGKDNeSGGyXyh
 bHZb476KDdJgNSHcWaZrNqQfRKz9qw0HKneJnsGIUrp5lU9Zx6tHAhwoCnAvN9iZITIRrtWMQL6
 Lrv3mIKd2UN/MgONLhVhTYTg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id adf1b5659ffe700a;
	Fri, 18 Sep 2026 03:40:50 +0000
X-Mizu-Trace-ID: adf1b5659ffe700a
X-Migadu-Flow: FLOW_OUT
Message-ID: <c2bed9c0-bd41-4045-ae25-2e3c9a8dbd8e@linux.dev>
Date: Thu, 17 Sep 2026 20:40:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 13/20] libbpf: Resolve the compiler's
 _Unwind_Resume to the kernel's kfunc
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260917055752.3932718-1-yonghong.song@linux.dev>
 <19251f166b31c6b7bc6212d2d9008f3f5b06ff7726b1d3c08c7f54467bb0dbc4@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <19251f166b31c6b7bc6212d2d9008f3f5b06ff7726b1d3c08c7f54467bb0dbc4@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/17/26 12:00 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git tools/lib/bpf/libbpf.c tools/lib/bpf/libbpf.c
>> index 613afae265199..ea1c09fa37939 100644
>> --- tools/lib/bpf/libbpf.c
>> +++ tools/lib/bpf/libbpf.c
>> @@ -8346,6 +8346,15 @@ static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_s
>>   	}
>>   }
>>
>> +/* LLVM terminates a cleanup landing pad with a call to _Unwind_Resume, the
>> + * base unwind ABI's entry point for carrying an unwind on once a frame's
>> + * cleanups have run. The kernel knows it as bpf_unwind_resume.
>> + */
>> +static const char *kern_extern_name(const char *name)
>> +{
>> +	return strcmp(name, "_Unwind_Resume") ? name : "bpf_unwind_resume";
>> +}
>> +
>>   static int bpf_program_record_relos(struct bpf_program *prog)
>>   {
>>   	struct bpf_object *obj = prog->obj;
> Is the kern_extern_name() mapping applied on the light skeleton load
> path?
>
> Looking at bpf_program_record_relos() below kern_extern_name(), the
> RELO_EXTERN_CALL case records ext->name directly without calling
> kern_extern_name():
>
> static int bpf_program_record_relos(struct bpf_program *prog)
> {
>      ...
>      case RELO_EXTERN_CALL:
>          bpf_gen__record_extern(obj->gen_loader, ext->name,
>                                 ext->is_weak, false, false, BTF_KIND_FUNC,
>                                 relo->insn_idx);
>          break;
>      ...
> }
>
> This means the generated loader program would ask the kernel for
> BTF_KIND_FUNC '_Unwind_Resume', which doesn't exist in vmlinux BTF. The
> kernel only knows bpf_unwind_resume per BTF_ID_FLAGS(func,
> bpf_unwind_resume) in kernel/bpf/helpers.c.
>
> For comparison, the direct BPF_PROG_LOAD path does use the mapping:
>
> bpf_object__resolve_ksym_func_btf_id() calls kern_extern_name() at
> libbpf.c:8824, but that resolution is deliberately skipped when
> obj->gen_loader is set:
>
> bpf_object__resolve_ksyms_btf_id() {
>      ...
>      if (obj->gen_loader) {
>          ext->is_set = true;
>          ext->ksym.kernel_btf_obj_fd = 0;
>          ext->ksym.kernel_btf_id = 0;
>          continue;
>      }
>      ...
> }
>
> On the light skeleton path, bpf_btf_find_by_name_kind() would return
> -ESRCH for '_Unwind_Resume', causing emit_check_err() to jump to cleanup
> and fail the load. If the extern were weak, insn->imm/off would be
> stored as 0, which the verifier would reject as an invalid kfunc call.
>
> The test added later in the series
> (selftests/bpf/progs/exceptions_cleanup_light.c) writes 'call
> bpf_unwind_resume' directly in inline asm, so it uses the kernel name
> and never exercises the mapping.

Indeed, later patch in selftests/bpf/progs/exceptions_cleanup_light.c
fixed the issue with bpf_undiwn_resume properly. So this is not really
a bug. But we can do better than this. We can change from ext->name to
bpf_unwind_resume in file selftests/bpf/progs/exceptions_cleanup_light.c
for this patch. This will make things easier to understand.

>
>> @@ -8807,17 +8816,19 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>>   	struct module_btf *mod_btf = NULL;
>>   	const struct btf_type *kern_func;
>>   	struct btf *kern_btf = NULL;
>> +	const char *kern_name;
>>   	int ret;
>>
>>   	local_func_proto_id = ext->ksym.type_id;
>>
>> -	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
>> -				    &mod_btf);
>> +	kern_name = kern_extern_name(ext->essent_name ?: ext->name);
>> +
>> +	kfunc_id = find_ksym_btf_id(obj, kern_name, BTF_KIND_FUNC, &kern_btf, &mod_btf);
>>   	if (kfunc_id < 0) {
>>   		if (kfunc_id == -ESRCH && ext->is_weak)
>>   			return 0;
>>   		pr_warn("extern (func ksym) '%s': not found in kernel or module BTFs\n",
>> -			ext->name);
>> +			strcmp(kern_name, "bpf_unwind_resume") ? ext->name : kern_name);
>>   		return kfunc_id;
>>   	}
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35188619605

