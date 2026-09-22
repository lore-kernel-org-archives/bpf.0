Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5C3DD862
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078394; cv=none; b=tR2DifK7DHZN+P7nyzL+t57RJYBbOomAPtckZheSSNkK1yE1w+dKv1417IArqbUsdxP22E45/hsFrxtzvw5L8AxnqAme0nt/6IrsfWeHYbhVuJvGpmAKywfiFnIb4LroA2WJRKglQYquZL94Ku4qERd/ON3PLX6nI0kA0iz9guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078394; c=relaxed/simple;
	bh=ltIXjdHSHbXrIluiH2t5l6e2w3+uQNNoXjyQbtTWAGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umjGdrjU2lnMNPM8vfDhagn+Kr5DHnMkMFFn5jTqfvFUjht617L5jEm9UJmkXfcu+Xf51oHymkqkOqf884EifcItRszdCH1LzokuN5gkrLYQHafnQJ/J+SeCwwccQIPeSHVy4IYSU86EwOIHn6rbHoH+N5Iju1cC6w357EiYj0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSDIhWBo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSDIhWBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB4E1F000FF;
	Tue, 22 Sep 2026 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790078392;
	bh=U/4f3vMAbMGxRuWBKZ6lNkidlXHZlgpXjRME41IC4UY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WSDIhWBoj6431m8qUAm3Qi//ZlPmj+qJaMBWflyqkWQ/jWGEgvCBnYcrz153WA5Tf
	 kJ8frT9RdBM7wfNegVzlkTkBZoMfEyrSbDOjplcqFQWh1H5kRzuK87wjflwilo6P1T
	 XkLCBPSktPBPqON6ymPKuBPks7zDVwIEaDVxmhOW89H3vIjytDBz7KJcg4ttAd9w9N
	 UUF2PkE9QkFWufwJesxY1L1tEQAjYzkufvK+2MftHVl4czZinKWkVACKSgn1vTC7YQ
	 tTk6XT8+9Z1VBhhLOMZ83JpjnFuwmrd+QlsjLPKBkhIdzwCd75+dPR0Ep9mRj5UOXR
	 8AR4xhZaCqEkQ==
Message-ID: <5af8a42e-ce2f-443c-bdad-2e989dcc1a9b@kernel.org>
Date: Tue, 22 Sep 2026 12:59:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump LOC_PARAM,
 LOC_PROTO and LOCSEC
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, andrii@kernel.org,
 jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
 song@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, yatsenko@meta.com
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-10-alan.maguire@oracle.com>
 <a53eaf9758d1110ad7a2211b55533ffd470e083f.camel@gmail.com>
 <53e01dce-efdc-4e8f-8510-e23cba17c429@oracle.com>
 <f03d6246dca7a772e44bc31c98e7950d64ee55d3.camel@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <f03d6246dca7a772e44bc31c98e7950d64ee55d3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-21 14:46 UTC-0700 ~ Eduard Zingerman <eddyz87@gmail.com>
> On Mon, 2026-09-21 at 19:47 +0100, Alan Maguire wrote:
>> On 18/09/2026 21:51, Eduard Zingerman wrote:
>>> On Wed, 2026-09-16 at 08:41 +0100, Alan Maguire wrote:
>>>
>>> ...
>>>
>>>> +static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
>>>> +{
>>>> +	const struct btf_loc_param *p;
>>>> +	__u32 i = 0, vlen;
>>>> +	__u64 value;
>>>> +	bool negative = false;
>>>> +	char regs[32] = {};
>>>> +	char num[32] = {};
>>>> +	const char *op = "";
>>>> +
>>>> +	if (!t || !btf_is_loc_param(t)) {
>>>> +		snprintf(str, sz, "<invalid>");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	p = btf_loc_param(t);
>>>> +	vlen = btf_vlen(t);
>>>> +
>>>> +	if (p->flags & BTF_LOC_PARAM_REG) {
>>>> +		__u32 nregs = (p->flags == BTF_LOC_PARAM_REG) ? vlen : 1;
>>>> +
>>>> +		if (nregs > vlen) {
>>>> +			snprintf(str, sz, "?");
>>>> +			return;
>>>> +		}
>>>> +
>>>> +		switch (nregs) {
>>>> +		case 2:
>>>> +			snprintf(regs, sizeof(regs), "r%u, r%u",
>>>> +				 p->values[0], p->values[1]);
>>>
>>> I agree with Jiri regarding the register names. It's not a huge table,
>>> e.g. [1], 20 lines for x86 ~> 100-200 lines that would not really
>>> change to handle all architectures that have BPF jits.
>>> And it would be very convenient for those using the tool.
>>>
>>
>> Yeah, it's doable, it's just that it is more portable when done in
>> pfunct; we can use dwfl interface to get register names [1]. With
>> pfunct changes in that tree we get output that is either arch-independent
>> (standalone BTF) or when combined with ELF info from vmlinux
>> gives us the arch-specific register names, containing function etc.
>> To see the inline site for ip_send_skb for example:
>>
>> $ pfunct --inline_sites -f ip_send_skb --elf vmlinux /sys/kernel/btf/vmlinux.inline
>> 0xffffffff8201f241 [ip_push_pending_frames+0x31, .text +0x101f241] ip_send_skb(struct net * net [%rbx], struct sk_buff * skb [%rax])
>>
>> (above does not need DWARF at all, just BTF + ELF info, so will work with a
>> debuginfo-stripped vmlinux)
>>
>> So for me the tool to reach for in understanding the raw BTF is
>> bpftool, whereas to apply the arch-specific transformations, locate the
>> absolute addresses etc I'd use pfunct. But that's just me; I'm happy to
>> go with the consensus here. Given the current library support, I think
>> maintaining per-arch tables in bpftool (rather than introducing a new
>> library dependency) would be the way to go if we do add it.
>>
>> Quentin, what do you think? Are per-arch tables for registers in bpftool
>> ok from your side? Thanks!
>>
>> Alan
>>
>> [1] https://github.com/alan-maguire/dwarves/blob/0da899665b04f16c3f68c0b736834a15e045c3c9/pfunct.c#L95
> 
> Adding dwfl as an (optional?) dependency for bpftool and reusing the
> same code as [1] might be an option as well.
> 
> ...


If we decide to go with arch-specific transformation, I think I'd rather
go with local tables rather than adding a dependency, unless it turns
out to be necessary. But Alan's argument makes sense to me, bpftool
prints the literal BTF encoding, and resolving to per-arch instructions
is probably best left to pfunct.

Quentin
