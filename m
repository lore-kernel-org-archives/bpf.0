Received: from mta0.migadu.com (out-250.mta0.migadu.com [91.218.175.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC88370AD7
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765358; cv=none; b=Y8ElBHe4gn6mDdszxouEc8IS5e+svqMYT4xeJBFC36RFlL4//WdSnHyKknEbuIpm/v7ryBAy44BooTYeaBq5UheCh95F361IuBKqVy8OJO+nZehmF9DNVWLcXs4tPlPMTVv6P/tDapScTwVxMAIsaw+W7TMzSP8LzC3QHhl0eoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765358; c=relaxed/simple;
	bh=brB0Ej4oEC/D3NIjXkupym/SZhHaRuyz8kTu6uk2aCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOaxLsVrJmS1ml5u3SqBasRXGTuqcvhgznRIpVHMBiVL1EiOqKYWd2bT2QfI11kF3vahGjYouhpmKNz3jb2hgJNC3NZT1/BWudlppz86EYWVg6vb9PboMBR1esrY0Go1K34WPn3wGfmNHYldvMJY8pfT8G2wNMK2+99K06r0bqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NXLyN7sJ; arc=none smtp.client-ip=91.218.175.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NXLyN7sJ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=brB0Ej4oEC/D3NIjXkupym/SZhHaRuyz8kTu6uk2aCY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787765328; v=1; x=1788370128;
 b=NXLyN7sJ3P0yHWVWK2MDR8911z9/TMw2DWQbh4JGrinm6Nv6ECUQhUahP28K0c8F597RL7lA
 55gobyS3GTnWaoAYSuqrK1/egCcQHoTLbtEg5MZupSR9bYLfuZOdQy5haXm3ByRmuuxRX+LY+gO
 dLutPjc4gIEFHOzQmNGAWuTw=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:2cdc)
	by smtp.migadu.com with ESMTPS id 097dab9261c31e5f;
	Wed, 26 Aug 2026 17:28:48 +0000
X-Mizu-Trace-ID: 097dab9261c31e5f
X-Migadu-Flow: FLOW_OUT
Message-ID: <60851aa9-9483-4fcc-9013-0679d191d001@linux.dev>
Date: Wed, 26 Aug 2026 10:28:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 03/10] bpf: Add btf_type_is_arena_ptr()
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260825205427.1322594-1-yonghong.song@linux.dev>
 <bf7b20c25763c95f0438bd265d8a3abb1871c527882e6e7f0944be76f88d90f7@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <bf7b20c25763c95f0438bd265d8a3abb1871c527882e6e7f0944be76f88d90f7@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/25/26 2:59 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Add btf_type_is_arena_ptr()
>>
>> Simplify btf_scan_type_tags() and added a new helper
>> btf_type_is_arena_ptr(). No functional change.
> This isn't a bug, but could the changelog use the imperative mood
> consistently (e.g., "Simplify ... and add ...")?  Also, could it explain
> why the helper needs external linkage, such as noting that a later patch
> calls it from verifier.c?
>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 89d5a5c4f1171..ddd0f4f32d24b 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -235,6 +235,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>>   				    u32 field_mask, u32 value_size);
>>   int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec);
>>   bool btf_type_is_void(const struct btf_type *t);
>> +bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t);
>>   s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
>>   s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p);
>>   struct btf *btf_get_module_btf(const struct module *module);
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 47d43eb983a50..280530d25886c 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -3523,6 +3523,22 @@ static int btf_type_tag_walk(const struct btf *btf,
>>   	return 0;
>>   }
>>
>> +bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t)
>> +{
>> +	if (!btf_type_is_ptr(t))
>> +		return false;
>> +
>> +	for (t = btf_type_by_id(btf, t->type); btf_type_is_modifier(t);
>> +	     t = btf_type_by_id(btf, t->type)) {
>> +		if (!btf_type_is_type_tag(t) || btf_type_kflag(t))
>> +			continue;
>> +		if (!strcmp(__btf_name_by_offset(btf, t->name_off), "arena"))
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
> This isn't a bug, but since btf_type_tag_walk() sits right above this and
> is still used by btf_find_kptr() and friends, could btf_type_is_arena_ptr()
> be expressed in terms of it rather than repeating the modifier/type-tag
> walk?

Okay, will have more information in commit message.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405

