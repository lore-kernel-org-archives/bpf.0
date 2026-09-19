Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E40A35A398
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789849292; cv=none; b=ZxrQJkpmshT5VHIay5b3BYbFOD22pVRZMXpL66GphKp6GiqabIM6vYrjFbvxIdhrk8s1Yz0O3Lj93DzpXH3mFLy/EEK88bDdEW6I8uzg24Ldrhu7fk/EaOWhwZR71Er/SiCylHjlrpRw82GptJGMvWTnBnyU3EC4zwjacwQ4lPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789849292; c=relaxed/simple;
	bh=rEtCl5sgoZTyZ///u5kOKg4LnuFvMgKjvt7EO8a+lbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0K7IsvW5qC1phgUQ/fC3vA/oMVx0RUaqda91Yb5S4TT/bqNuwyE9QF8YOKVBxzcIOee13hKOX6p5t0F7N/zvAqzENkIhEVj+TekTAtTTRNvG49GGxWVeh1guDTFnVhQUwSvCrNBkPv6JtCl6iWa7g2DsSpjmVSdukKTlYnjGgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tAR7oR5t; arc=none smtp.client-ip=91.218.175.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tAR7oR5t"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rEtCl5sgoZTyZ///u5kOKg4LnuFvMgKjvt7EO8a+lbA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789849288; v=1; x=1790454088;
 b=tAR7oR5tNX5XJCr5sgKf1T9DldqpYlwKpVbQ1xmYgW+SPBQ1PMHmtiRc48GcOritJsOs09KJ
 EsDSmXiB3M+vWfmd6tcv/Rj+MGMUcv8cgjFd0C03myX9ImN8tnTTc/s2OY5NP2TvfihgXgQ2ayR
 ik+RRPVQajtayogKIJyaIfSc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ef98fdf98670cb9d;
	Sat, 19 Sep 2026 20:21:28 +0000
X-Mizu-Trace-ID: ef98fdf98670cb9d
X-Migadu-Flow: FLOW_OUT
Message-ID: <5e04d0f0-52d7-4e78-a608-7acae44f6908@linux.dev>
Date: Sat, 19 Sep 2026 13:21:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 15/20] libbpf: Collect .bpf_cleanup records
 and pass them to the kernel
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044317.3291712-1-yonghong.song@linux.dev>
 <20260918050054.BAFFB1F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260918050054.BAFFB1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/17/26 10:00 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] bpf: empty cleanup range check in bpf_prog_collect_cleanup_info() only catches offset 0
> - [Medium] bpf: bpf_object__init_cleanup_info() rejects valid objects with 0-sized .bpf_cleanup sections
> --
>
> commit a645d3bd249aceee4909edcc78e5fe4247fd3432
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Collect .bpf_cleanup records and pass them to the kernel
>
> Parse the compiler-emitted .bpf_cleanup section and hand the resulting
> table to BPF_PROG_LOAD.
>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 27f2eec13f76f..1b8b978e7b7b9 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> [ ... ]
>
>> @@ -4852,6 +4890,221 @@ static struct bpf_program *find_prog_by_sec_insn(const struct bpf_object *obj,
>>   	return NULL;
>>   }
>>   
>> +static int bpf_object__init_cleanup_info(struct bpf_object *obj)
>> +{
>> +	Elf_Data *data = obj->efile.cleanup_data;
>> +	Elf_Data *relo = NULL;
>> +	size_t i, nrels, nslots, nrecs;
>> +	struct cleanup_raw_rec *recs;
>> +	int *slot_sec, ret = 0;
>> +	size_t *slot_val;
>> +	const __u32 *vals;
>> +	bool native;
>> +
>> +	if (!data || obj->efile.cleanup_shndx < 0)
>> +		return 0;
>> +
>> +	native = is_native_endianness(obj);
>> +
>> +	for (i = 0; i < obj->efile.sec_cnt; i++) {
>> +		struct elf_sec_desc *sd = &obj->efile.secs[i];
>> +
>> +		if (sd->sec_type == SEC_RELO && sd->shdr &&
>> +		    sd->shdr->sh_info == (Elf64_Word)obj->efile.cleanup_shndx) {
>> +			relo = sd->data;
>> +			break;
>> +		}
>> +	}
>> +	if (!relo) {
>> +		pr_warn("%s present without relocations\n", CLEANUP_SEC);
>> +		return -LIBBPF_ERRNO__FORMAT;
>> +	}
> [Severity: Medium]
> Could this reject valid objects if the compiler emits an empty 0-byte
> .bpf_cleanup section?
>
> If the section is empty (e.g., exceptions were optimized out), no relocations
> are emitted and there is no corresponding .rel.bpf_cleanup section. However,
> bpf_object__init_cleanup_info() requires the relocation section to exist if
> .bpf_cleanup is present.
>
> Would it be better to return early if data->d_size is 0 before checking for
> relocations?

I think it is okay, as you mentioned, there will be one error message later
when relocation section checks.

>
> [ ... ]
>
>> +static int bpf_prog_collect_cleanup_info(struct bpf_object *obj,
>> +					 struct bpf_program *prog)
>> +{
>> +	size_t i;
>> +	int j;
>> +
>> +	for (i = 0; i < obj->cleanup_rec_cnt; i++) {
>> +		struct cleanup_raw_rec *raw = &obj->cleanup_recs[i];
>> +		struct bpf_program *owner = NULL;
>> +		struct bpf_cleanup_info ci = {};
>> +		__u32 fields[CLEANUP_REC_FIELDS];
>> +		void *tmp;
>> +
>> +		for (j = 0; j < CLEANUP_REC_FIELDS; j++) {
>> +			size_t idx = raw->insn_idx[j], final;
>> +			struct bpf_program *p;
>> +
>> +			/* The end of a range is exclusive, so it may name the
>> +			 * instruction just past the last one of a function,
>> +			 * which belongs to the next function or to nothing at
>> +			 * all. Ask about the last instruction the range covers,
>> +			 * the way the kernel does.
>> +			 */
>> +			if (j == CLEANUP_REC_END) {
>> +				if (!idx) {
>> +					pr_warn("%s: record %zu is an empty range\n",
>> +						CLEANUP_SEC, i);
>> +					return -LIBBPF_ERRNO__FORMAT;
>> +				}
>> +				idx--;
>> +			}
> [Severity: Medium]
> Will this check catch empty ranges emitted by the compiler at non-zero
> offsets?
>
> If the compiler emits a .bpf_cleanup record where begin and end are both 5,
> the check for !idx evaluates to false. The code will then decrement idx to 4
> and look up the program for the previous instruction.
>
> If this empty range is located at the start of a function, looking up the
> previous instruction will fall into the preceding function, potentially
> triggering a spurious "spans functions" error or silently accepting invalid
> records.

Good point. Will fix this corner case.

>

