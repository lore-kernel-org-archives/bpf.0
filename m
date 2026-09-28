Received: from mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384D376A1A
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566093; cv=none; b=Yl+mEratNLCXiVxDoSBvU6KKcHR714kUN54FR8Ta49gk2uVVmcdktHGN1xkr3dkr1dB7NIiMab20Wbex6QVYk+5fC6D+n+8HvA4nQJtyZtsO6LxqjS3dER0eWN8nIMmr6hqKQ0C3Iib9xOCFUzayFvP4qr/zjLcP0dU6C/5KM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566093; c=relaxed/simple;
	bh=bXG3K6wMt4deNnlkV76PufRbzKqmhatztOtmm1/gzhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6ioOg0zcScjhDXiEs5mxCseeFWCP7ETYM+BghyxBwDC+bfVsB4tdqiDVgCUGObhCaYkabOIjgXj2s/c4bKuht1NwPigmXj+qZ0/nI6TQEmtrCvCvSPJdWgCWRqbFM4xXf7TMWbWVhrmV1lT32EmvViWMTZ4XcsiL4b8EWwB0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u4YKmVrj; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u4YKmVrj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bXG3K6wMt4deNnlkV76PufRbzKqmhatztOtmm1/gzhU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790566087; v=1; x=1791170887;
 b=u4YKmVrjJuV/SZi8uOtqSlS1bPJfe9i9kI11LxLg1odohqaFYKnEnFgBN8NQAbhYhdYuPa4N
 8zfnPXPTMxeMxgZZYnkxCZQRoqc02VJqdLxlCC1SIHekdb0229LgGBPRKN5IYNbiiTP0dzs0wcr
 /l5YtIQDJhvnABrYLzKpKs9c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5452234aa663155b;
	Mon, 28 Sep 2026 03:28:07 +0000
X-Mizu-Trace-ID: 5452234aa663155b
X-Migadu-Flow: FLOW_OUT
Message-ID: <0b83c451-1704-4630-9086-1f4e7a652619@linux.dev>
Date: Sun, 27 Sep 2026 20:28:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 15/21] libbpf: Collect .bpf_cleanup records
 and pass them to the kernel
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260926050123.2220977-1-yonghong.song@linux.dev>
 <3b553c5ab29803b0aa25087a5a5b0e1d15bfce01166bfa8e97aad8e704cce09f@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3b553c5ab29803b0aa25087a5a5b0e1d15bfce01166bfa8e97aad8e704cce09f@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/27/26 1:39 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 7eb15a013a83..4e9584fff264 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> [ ... ]
>
>> @@ -4915,6 +4953,249 @@ static struct bpf_program *find_prog_by_sec_insn(const struct bpf_object *obj,
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
>> +	Elf64_Shdr *sh;
>> +	bool native;
>> +
>> +	if (!data || obj->efile.cleanup_shndx < 0 || !data->d_size)
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
>> +	/*
>> +	 * LLVM leaves sh_entsize unset, so this only bites a producer that
>> +	 * declares a record size -- which is the one able to tell us it means
>> +	 * something other than three 4-byte fields.
>> +	 */
>> +	sh = elf_sec_hdr(obj, elf_sec_by_idx(obj, obj->efile.cleanup_shndx));
>> +	if (sh && sh->sh_entsize &&
>> +	    sh->sh_entsize != sizeof(struct bpf_cleanup_info)) {
>> +		pr_warn("%s record size %zu is not the expected %zu\n", CLEANUP_SEC,
>> +			(size_t)sh->sh_entsize, sizeof(struct bpf_cleanup_info));
>> +		return -LIBBPF_ERRNO__FORMAT;
>> +	}
> Should sh_entsize == 0 be explicitly treated as 12, so that wider
> records (if necessary in the future) end up being easier to reject?
>
> This design question was raised by Kumar Kartikeya Dwivedi in v5:
> https://lore.kernel.org/bpf/DLMGMYOHSGFW.24JML4GSMTV2K@gmail.com/
>
> The current code accepts sh_entsize == 0 (LLVM's default) silently, but
> treating it explicitly as 12 would allow future tools to cleanly reject
> wider records by setting sh_entsize to a different value.

Okay. This is not a bug, but rather to have better code to have
explicit 'entsize' size and then check against size of bpf_cleanup_info.

>
>> +	if (data->d_size % sizeof(struct bpf_cleanup_info)) {
>> +		pr_warn("%s size %zu is not a multiple of the record size %zu\n",
>> +			CLEANUP_SEC, data->d_size, sizeof(struct bpf_cleanup_info));
>> +		return -LIBBPF_ERRNO__FORMAT;
>> +	}
>> +
>> +	vals = data->d_buf;
>> +	nslots = data->d_size / sizeof(__u32);
>> +	nrecs = data->d_size / sizeof(struct bpf_cleanup_info);
>> +
>> +	slot_sec = calloc(nslots, sizeof(*slot_sec));
>> +	slot_val = calloc(nslots, sizeof(*slot_val));
>> +	recs = calloc(nrecs ?: 1, sizeof(*recs));
> This isn't a bug, but could the relocation loop fill recs directly
> (with sec_idx initialised to -1) so the slot_sec/slot_val scratch
> arrays and the copy loop go away?

Good point. This will make things easier.

>
> The relocation loop could write straight into recs, using sec_idx = -1
> as the 'no relocation' sentinel and checking alignment while the byte
> offset is at hand, the way bpf_object__collect_rodata_relos() checks
> (sym->st_value + addend) % BPF_INSN_SZ inline. That would leave one
> allocation instead of three and drop the copy loop.
>
> Also, is the 'nrecs ?: 1' needed? d_size has already been checked to be
> a non-zero multiple of the record size.

Will do.

>
>> +	if (!slot_sec || !slot_val || !recs) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +	for (i = 0; i < nslots; i++)
>> +		slot_sec[i] = -1;
>> +
>> +	/* One relocation per 4-byte field, naming the section it points into. */
>> +	nrels = relo->d_size / sizeof(Elf64_Rel);
>> +	for (i = 0; i < nrels; i++) {
> [ ... ]
>
>> +	for (i = 0; i < nslots; i++) {
>> +		struct cleanup_raw_rec *rec = &recs[i / CLEANUP_REC_FIELDS];
>> +		size_t field = i % CLEANUP_REC_FIELDS;
>> +
>> +		if (slot_sec[i] < 0) {
>> +			pr_warn("%s: field %zu has no relocation\n", CLEANUP_SEC, i);
>> +			ret = -LIBBPF_ERRNO__FORMAT;
>> +			goto out;
>> +		}
>> +		if (slot_val[i] % BPF_INSN_SZ) {
>> +			pr_warn("%s: field %zu offset %zu is not instruction aligned\n",
>> +				CLEANUP_SEC, i, slot_val[i]);
>> +			ret = -LIBBPF_ERRNO__FORMAT;
>> +			goto out;
>> +		}
>> +		rec->sec_idx[field] = slot_sec[i];
>> +		rec->insn_idx[field] = slot_val[i] / BPF_INSN_SZ;
>> +	}
>> +
>> +	obj->cleanup_recs = recs;
>> +	obj->cleanup_rec_cnt = nrecs;
>> +	recs = NULL;
>> +out:
>> +	free(recs);
>> +	free(slot_val);
>> +	free(slot_sec);
>> +	return ret;
>> +}
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430

