Received: from mta0.migadu.com (out-106.mta0.migadu.com [91.218.175.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA4E1D5AC2
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732815; cv=none; b=ggB9mg4PH8aE75ErUwk87c1CfC2igdQqxSRQkiA8/QppgFsl4e2BZPxzY8T9H4dfRpTCSpd8ysTL8zA8qaaYSKFGhtAyuemME6M2asdDZwBZvx4Ob4g9VycWx3XFZ7W4mKEAEDu6u3FczE9rkktjAnJLFbfMi/ondrs0fsjAl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732815; c=relaxed/simple;
	bh=seDjijRTruW0BDpKnTvgVE+bgIiSNBjnYfeVa9xKU9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4UW928wVy0+d1KAOR+ByPHueQ/+stTbdXxD81OTFcY0fFgoPB1EqXj677M0J5xwD5KySA0Xb1iMBvgytomdkAnPNxlfaKliPmvvzccu+jfYII2O5c0GGZr93jplkpokZJtBXwe9EAwT0jRJnACb/Dx4HMRx9r6Etr/BwSWR47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SwR0G54E; arc=none smtp.client-ip=91.218.175.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SwR0G54E"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=seDjijRTruW0BDpKnTvgVE+bgIiSNBjnYfeVa9xKU9A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790732811; v=1; x=1791337611;
 b=SwR0G54Euwtr9yhS/qv8V8eLDoO5Q8bSfhHo8Ir+Gkh5ZGmzRBViaVASrA9ySQ5dfcITIJR4
 tMcqsQpCXGLGaOdA9QhCqNDqpjzb+1FtLl2ktodtwzz5q2dbDV6UqipK6VukRW98frzUv3ymIPh
 lyRqxMhsr/Ov9Td+5N4KTBJI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2b507fd204d77976;
	Wed, 30 Sep 2026 01:46:51 +0000
X-Mizu-Trace-ID: 2b507fd204d77976
X-Migadu-Flow: FLOW_OUT
Message-ID: <9d4aebc7-47a7-4de2-9feb-a47df40c5999@linux.dev>
Date: Tue, 29 Sep 2026 18:46:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 20/22] selftests/bpf: Add __set_global() and
 __ret_global() test tags
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260929001746.3256138-1-yonghong.song@linux.dev>
 <d9813f2fa7409b21b9688959b70d04f46ceb1da43f0ded88a921acaee62df4e3@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d9813f2fa7409b21b9688959b70d04f46ceb1da43f0ded88a921acaee62df4e3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/26 5:52 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> index f3dbc3b59bff..9afa163fac5a 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
>> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
>> @@ -93,6 +93,11 @@
>>    * __failure         Expect program load failure in privileged mode.
>>    * __failure_unpriv  Expect program load failure in unprivileged mode.
>>    *
>> + * __set_global      Set a global variable of the program to a value before
>> + *                   executing it.
>> + * __ret_global      Execute the program and check that a global variable
>> + *                   holds the given value afterwards. The variable has to
>> + *                   live in .bss or .data and be four or eight bytes wide.
>>    * __retval          Execute the program using BPF_PROG_TEST_RUN command,
>>    *                   expect return value to match passed parameter:
>>    *                   - a decimal number
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
>> index 25eeb1c1248b..2492841f7a49 100644
>> --- a/tools/testing/selftests/bpf/test_loader.c
>> +++ b/tools/testing/selftests/bpf/test_loader.c
> [ ... ]
>
>> +static int find_global_var(struct bpf_object *obj, const char *name,
>> +			   struct bpf_map **map, __u32 *off, __u32 *sz,
>> +			   bool *is_signed)
>> +{
>> +	static const char * const secs[] = { ".bss", ".data" };
>> +	struct btf *btf = bpf_object__btf(obj);
>> +	int i, s;
>> +	__u32 vsz;
>> +
>> +	if (!btf) {
>> +		PRINT_FAIL("no BTF for object\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	for (s = 0; s < ARRAY_SIZE(secs); s++) {
>> +		const struct btf_type *sec, *vt;
>> +		const struct btf_var_secinfo *vsi;
>> +		struct bpf_map *m = NULL, *iter;
>> +		size_t slen = strlen(secs[s]);
>> +		int id;
>> +
>> +		bpf_object__for_each_map(iter, obj) {
>> +			const char *mname = bpf_map__name(iter);
>> +			size_t len = mname ? strlen(mname) : 0;
>> +
>> +			if (len >= slen && strcmp(mname + len - slen, secs[s]) == 0) {
>> +				m = iter;
>> +				break;
>> +			}
>> +		}
> This isn't a bug, but could the map loop here be replaced with
> bpf_object__find_map_by_name(obj, secs[s]), as veristat's
> set_global_vars() does? That would tie the map to the DATASEC by its
> section name and make the comment about the two lookups not agreeing on a
> size unnecessary.

Will do. Thanks!

>
>> +		id = btf__find_by_name_kind(btf, secs[s], BTF_KIND_DATASEC);
>> +		if (!m || id < 0)
>> +			continue;
>> +
>> +		sec = btf__type_by_id(btf, id);
>> +		vsi = btf_var_secinfos(sec);
>> +		for (i = 0; i < btf_vlen(sec); i++, vsi++) {
>> +			const struct btf_type *var = btf__type_by_id(btf, vsi->type);
>> +
>> +			if (strcmp(btf__name_by_offset(btf, var->name_off), name))
>> +				continue;
>> +			if (vsi->size != 4 && vsi->size != 8) {
>> +				PRINT_FAIL("'%s' is %u bytes, only 4 and 8 are supported\n",
>> +					   name, vsi->size);
>> +				return -EINVAL;
>> +			}
>> +			vt = btf__type_by_id(btf, btf__resolve_type(btf, var->type));
>> +			if (!vt || !(btf_is_int(vt) || btf_is_any_enum(vt))) {
>> +				PRINT_FAIL("'%s' is not an int or an enum\n", name);
>> +				return -EINVAL;
>> +			}
>> +			*is_signed = global_var_is_signed(vt);
>> +			/*
>> +			 * The map is found by the suffix of its name and the
>> +			 * section by its own, so nothing so far has made the
>> +			 * two agree on a size.
>> +			 */
>> +			vsz = bpf_map__value_size(m);
>> +			if (vsi->offset > vsz || vsi->size > vsz - vsi->offset) {
>> +				PRINT_FAIL("'%s' at %u+%u is outside '%s' of %u bytes\n",
>> +					   name, vsi->offset, vsi->size,
>> +					   bpf_map__name(m), vsz);
>> +				return -EINVAL;
>> +			}
>> +			*map = m;
>> +			*off = vsi->offset;
>> +			*sz = vsi->size;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	PRINT_FAIL("no global variable '%s'\n", name);
>> +	return -ENOENT;
>> +}
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36502848904

