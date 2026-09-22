Received: from mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EED279DB1
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 03:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790047669; cv=none; b=Jt2eZbu+re4gM2de5l4Ymne+FIuGMsosP0kR8eg+K2aUNMclb43QNZxMx/zKv1G408EseGT9ywQi3kMbCKHEknNpIANWYv7SC45UDATMv8q8gvv4nDQcht7AvP5Z4vFtiHOifgjFxUHuTHJLU5DQLQJlZUPPuYkP0EMsjJV7588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790047669; c=relaxed/simple;
	bh=FnTNP1fUED7n5LzLoxov25ozmkS2mzGjKa6GiHz6/H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R76+1v9NpFwYuwvfZCvz410iy5UFO9fty3UHbxXL9zgPNN8w5p/uwXsfhalCg0NshimA1sk11A7BHO0kS/f3k4CXsxT5Z52T/XZJ/nD6jAZJcOWhZyplFt8i3fYjkLKgDhF9hj5BrFSpqJU8fW9qLtiIsp90PEzHh79mrRXKSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rgGPm/D8; arc=none smtp.client-ip=91.218.175.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rgGPm/D8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FnTNP1fUED7n5LzLoxov25ozmkS2mzGjKa6GiHz6/H4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790047665; v=1; x=1790652465;
 b=rgGPm/D8sESiwphhnOaTuu5WEfJarb3b9i3CBu0kRAcUXmVXgJHD16wlpgRu9rfp8HASylpB
 rhzFOB203IUYaqiB/syuF+RkPaO31gmGqGJsZFJqK2r7A4XbTD8BqRhcqnWP1z/gn3w+5BDZmY5
 IWNaHKCt3qWoScYqEk6cJN1o=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b155b9dff6e5614e;
	Tue, 22 Sep 2026 03:27:45 +0000
X-Mizu-Trace-ID: b155b9dff6e5614e
X-Migadu-Flow: FLOW_OUT
Message-ID: <164117df-3f7b-47ef-8fa3-ee32ee4cfdf4@linux.dev>
Date: Mon, 21 Sep 2026 20:27:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 01/20] bpf: Accept the compiler's exception
 cleanup table at program load
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260921210038.1715324-1-yonghong.song@linux.dev>
 <f9dfcec80a2e1ed0d2362a2580f24da70dae6b2f4a734c59a806d2c33c2028b3@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f9dfcec80a2e1ed0d2362a2580f24da70dae6b2f4a734c59a806d2c33c2028b3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/21/26 2:56 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Accept the compiler's exception cleanup table at program load
>>
>> LLVM 23 added exception handling support for BPF with the .bpf_cleanup
>> section ([1]). Rust code compiled with panic=unwind runs cleanup code
>> (Drop glue) when bpf_throw() fires, and the LLVM BPF backend emits that
>> section from the landing pads the frontend produced. Plain C cannot
>> generate .bpf_cleanup unless inline asm is used. The Rust compiler does not
>> *properly* support BPF exception handling yet, but the kernel can support
>> the table today, and inline assembly is enough to test it.
>>
>> Add the UAPI to carry the .bpf_cleanup table into the kernel. BPF_PROG_LOAD
>> grows cleanup_info, cleanup_info_cnt and cleanup_info_rec_size, and struct
>> bpf_cleanup_info describes one record as a triple of instruction indices:
>> the half-open call-site range [begin_off, end_off) and the landing_pad_off
>> the frame resumes at. check_cleanup_info() validates the table a program is
>> loaded with, so the rest of the kernel can rely on it.
> This isn't a bug, but since the table is freed at the end of bpf_check()
> and nothing reads env->cleanup_info yet, would it help to say here that
> later patches in the series are the consumers, rather than that the rest
> of the kernel can already rely on it?

Okay, we can say:
   the patches, which follow the CFG walk, the unwind walk and the JITs,
   are its consumers.

>
>> Link: https://github.com/llvm/llvm-project/pull/192164 [1]
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
>> index 0e8b3ccc7a5b..17af0a414d74 100644
>> --- a/kernel/bpf/check_btf.c
>> +++ b/kernel/bpf/check_btf.c
>> @@ -407,6 +407,153 @@ static int check_core_relo(struct bpf_verifier_env *env,
>>   	return err;
>>   }
>>
>> +static int cleanup_insn_subprog(struct bpf_verifier_env *env, u32 off)
>> +{
>> +	struct bpf_subprog_info *info;
>> +
>> +	if (off >= env->prog->len)
>> +		return -1;
>> +	info = bpf_find_containing_subprog(env, off);
>> +	return info ? info - env->subprog_info : -1;
>> +}
> This isn't a bug, but would a name like cleanup_off_subprog() or
> insn_subprog_idx() read a little less like an action here, given it
> returns a subprog index?

Will change cleanup_insn_subprog() to cleanup_subprog_of().

>
>> +
>> +#define MIN_BPF_CLEANUP_INFO_SIZE	12
>> +#define MAX_CLEANUP_INFO_REC_SIZE	MAX_FUNCINFO_REC_SIZE
>> +
>> +static int check_cleanup_info(struct bpf_verifier_env *env,
>> +			      const union bpf_attr *attr,
>> +			      bpfptr_t uattr)
>> +{
>> +	u32 krec_size = sizeof(struct bpf_cleanup_info);
>> +	u32 i, nrec, urec_size, min_size, prev_end = 0;
>> +	struct bpf_cleanup_info *krecord;
>> +	bpfptr_t urecord;
>> +	int ret = -EINVAL;
>> +
>> +	nrec = attr->cleanup_info_cnt;
>> +	if (!nrec)
>> +		return 0;
>> +	/* Disjoint ranges, so no more records than instructions. */
>> +	if (nrec > env->prog->len) {
>> +		verbose(env, "cleanup info has %u records for %u instructions\n",
>> +			nrec, env->prog->len);
>> +		return -EINVAL;
>> +	}
>> +
>> +	urec_size = attr->cleanup_info_rec_size;
>> +	if (urec_size < MIN_BPF_CLEANUP_INFO_SIZE ||
>> +	    urec_size > MAX_CLEANUP_INFO_REC_SIZE ||
>> +	    urec_size % sizeof(u32)) {
>> +		verbose(env, "invalid cleanup info rec size %u\n", urec_size);
>> +		return -EINVAL;
>> +	}
>> +
>> +	krecord = kvcalloc(nrec, krec_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>> +	if (!krecord)
>> +		return -ENOMEM;
>> +
>> +	min_size = min_t(u32, krec_size, urec_size);
>> +	urecord = make_bpfptr(attr->cleanup_info, uattr.is_kernel);
>> +	for (i = 0; i < nrec; i++) {
>> +		struct bpf_cleanup_info *rec = &krecord[i];
>> +		int sb, se, sl;
>> +
>> +		ret = bpf_check_uarg_tail_zero(urecord, krec_size, urec_size);
>> +		if (ret) {
>> +			if (ret == -E2BIG) {
>> +				verbose(env, "nonzero tailing record in cleanup info\n");
>> +				if (copy_to_bpfptr_offset(uattr,
>> +							  offsetof(union bpf_attr,
>> +								   cleanup_info_rec_size),
>> +							  &min_size, sizeof(min_size)))
>> +					ret = -EFAULT;
>> +			}
>> +			goto err_free;
>> +		}
>> +
>> +		if (copy_from_bpfptr(rec, urecord, min_size)) {
>> +			ret = -EFAULT;
>> +			goto err_free;
>> +		}
>> +		bpfptr_add(&urecord, urec_size);
> This isn't a bug, but with this being the fourth copy of the
> rec_size-check / tail-zero / copy_from_bpfptr preamble in this file
> (prepare_btf_func, check_btf_line, check_core_relo and now
> check_cleanup_info), would it be worth pulling the common part into a
> small helper parameterised by the record size and the bpf_attr offset?

I will skip this for now.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35656368472

