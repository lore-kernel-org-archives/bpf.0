Received: from mta0.migadu.com (out-201.mta0.migadu.com [91.218.175.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF02BEFE8
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644575; cv=none; b=PCwMphke5kLdGMLtC4HALEBHH5Ao9lfs49M7+ecNxRgm8MVs3+YYuIJcUKbYWNon+HIINVw1AM89tzFyh8vDIsT7YSIbQOZpHjPjeF1so2ZwaKeoUohsS6GYVdx64ZadrOnARXIqP6OzamnVtnSzuOo4qDdp79SOdncM3lrUhJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644575; c=relaxed/simple;
	bh=9l0T37n85VnUFGicMvB2/8RjyiT0WfTI6QrRnRgfeVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXslLsWqLJYm77NJGfMeMlYFzPbtXyS5/5b/VaHRnWM9PEBeUbUMos1iG8qNCcHtE+4T74l9ZijrNI0Ttr8Z2ZH8shp1Cul8rmiP+OkI3CU3ns8YPNrPK+Scn6ejg+82wzpx3RdXLGwgBLEf5DvgV9MS0Me9HT8WGxwOq/RmbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vESOTVns; arc=none smtp.client-ip=91.218.175.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vESOTVns"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9l0T37n85VnUFGicMvB2/8RjyiT0WfTI6QrRnRgfeVE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786644571; v=1; x=1787249371;
 b=vESOTVns1B/IRollaqKkWX2B3M63LV06Gtv3hq4FkeGKvkqRLJ/OmjSnczvSbPOcBpslEYbx
 Hnh8AT0ab/u47NDtnK2WNz8UIXNl/GJc1Nh+fatxW6PlS18cNH3nKBoAIu/pYteo7wjMf1kt0j6
 rCYvePJHShDQu/56rzFjg2J8=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2d:e3e3:185d:58c3:4c79:68c] (2600:381:1f2d:e3e3:185d:58c3:4c79:68c)
	by smtp.migadu.com with ESMTPS id 09610130ad318d88;
	Thu, 13 Aug 2026 18:09:31 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <be5f36a4-a592-40d8-b3e2-935467d96b20@linux.dev>
Date: Thu, 13 Aug 2026 11:09:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 06/13] bpf: Reject callbacks returning more
 than 8 bytes
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
 <20260811000942.2381774-1-yonghong.song@linux.dev>
 <db5893ed20101addde654bc51b0e54fc0e6cbed1.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <db5893ed20101addde654bc51b0e54fc0e6cbed1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/26 2:41 PM, Eduard Zingerman wrote:
> On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
>> A callback handed to a helper or a kfunc (bpf_loop(),
>> bpf_timer_set_callback(), bpf_for_each_map_elem(), ...) is invoked
>> through bpf_callback_t, and an exception callback is invoked by
>> bpf_throw() through
>>
>>    u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
>>
>> Both prototypes yield a single u64 in R0, and neither caller has any
>> notion of a second return register, so a callback returning a value in
>> the R0:R2 pair would have the upper half of its return value silently
>> dropped.
>>
>> Reject both at load time:
>>
>>   - check_ld_imm(): a callback is materialized as PTR_TO_FUNC by an
>>     ld_imm64 pointing at its subprogram, so the subprogram's return
>>     convention can be checked where the callback pointer is created,
>>     before it ever reaches a helper or kfunc argument.
>>
>>   - do_check_common(): an exception callback is not referenced by a
>>     PTR_TO_FUNC, it is named by a BTF decl_tag and verified on its own,
>>     so check it as its frame is set up, next to the existing "cannot
>>     return void" and single-argument checks.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> The code itself makes sense to me, but do we really need to check this?

Okay, I will remove this patch. The verifier has some definition for callback
function with returning R0. If callback function (prog) intends to return
two registers, the return register R2 will be ignored.

>
> ...

