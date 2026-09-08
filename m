Received: from mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629619F115
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841337; cv=none; b=Uxo0uo92Mmc/5D1xlLkP14vxgXVXB3DB6MTQp+cxKxmP3oineWWQGkHrsjWZOxgPZUQ7Ix3LJKICHwLGUDkqvJ4C5XEkVJlp10KDPKmOGIBllpvlpXnzKyBjk2+TFgSb+4EJQPRKh3IgLUOtPfocf+fN6+oVvxgeXwm49okMKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841337; c=relaxed/simple;
	bh=bnKRkk47SvHIJz59sxE+x9HK2wQVYN7MvVCH1vhQ4HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hD7LAXLpdlFXsgjWWDL4PTv9nIfzVDJQ9M0Eq6xBR9f99WlIpQlftkFfjN0AqWgTRw+1XSimTEWMGPQkw2M877jhk2xZ8MWWWGXRFEul334uVAoQMzgQ8C0/obqZATHi6y7aw86sSX7j/R+tkciW72iZOTAOxh5sLC6R1NZRiF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oKk8yEeb; arc=none smtp.client-ip=91.218.175.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oKk8yEeb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bnKRkk47SvHIJz59sxE+x9HK2wQVYN7MvVCH1vhQ4HM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788841332; v=1; x=1789446132;
 b=oKk8yEebclJRp4IEifGBZFmTvGuVJ/grcQp00SjdWue2VUG04fEkU1JlVkCETjwcaBcxEIni
 znZ0nNKSMWT/8jiCsjI+W8waYJucrpou78B+xTioqfjtoXcFMl+u0qUNvRF/3QqyipWc3xdU4RA
 YxhPHO4iBH64Os57CK7+52HQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8777f50b16d04ff4;
	Tue, 08 Sep 2026 04:22:12 +0000
X-Mizu-Trace-ID: 8777f50b16d04ff4
X-Migadu-Flow: FLOW_OUT
Message-ID: <5172948e-b5f8-4e17-88e5-55828795c75c@linux.dev>
Date: Mon, 7 Sep 2026 21:22:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 05/12] bpf: Support by-value struct and __int128
 kfunc arguments
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051023.3979415-1-yonghong.song@linux.dev>
 <20260904061833.EF9751F00A3E@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260904061833.EF9751F00A3E@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/3/26 11:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Incorrect buffer register resolution for memory bounds check in check_kfunc_args() due to confusion between BTF argument index and register slot index.
> - [High] bpf_kfunc_stack_access_bytes() incorrectly uses register slot indices to index BTF arguments, breaking stack liveness tracking.
> - [High] bpf_get_call_summary() incorrectly uses the number of BTF arguments instead of the number of argument slots for kfuncs, breaking register liveness tracking.
> --
>
> commit 225a338e077323b335756911c91748fab0c8ec13
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Support by-value struct and __int128 kfunc arguments
>
> A kfunc taking a struct or union by value is rejected today, and one
> taking an __int128 is accepted but mis-counted:
>
>    Unrecognized R2 type STRUCT
>
> Give the kfunc argument walk the same slot count a BPF-to-BPF call now
> uses: one argument register per eightbyte, so a 16-byte value takes two.
> The outgoing stack argument count at the call site follows the slots for
> the same reason. Similar to BPF-to-BPF aggregate handling, a kfunc
> aggregate argument only supports tbe composed of scalars.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 17e576c7b7572..030fb37c22ef1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -12792,29 +12904,34 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
> [ ... ]
>>   	/* Check that BTF function arguments match actual types that the
>>   	 * verifier sees.
>>   	 */
>> -	for (i = 0; i < nargs; i++) {
>> -		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
>> +	for (i = 0, slots_used = 0; i < nargs; i++, slots_used += nslots) {
>> +		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, slots_used);
>>   		const struct btf_type *t, *ref_t, *resolve_ret;
>>   		enum bpf_arg_type arg_type = ARG_DONTCARE;
>> -		argno_t argno = argno_from_arg(i + 1);
>> +		argno_t argno = argno_from_arg(slots_used + 1);
> [Severity: High]
> This change separates the BTF argument index (i) from the register slot
> index (slots_used), but does it leave other parts of the loop using i
> incorrectly?
>
> For instance, further down in this loop, case KF_ARG_MEM_SIZE uses i - 1
> instead of slots_used - 1 to find the buffer pointer:
>
>      case KF_ARG_MEM_SIZE:
>      {
>          struct bpf_reg_state *buff_reg = get_func_arg_reg(caller, regs, i - 1);
>          struct bpf_reg_state *size_reg = reg;
>
> Could this cause a kfunc memory bounds check to validate the size argument
> against the memory bounds of the wrong pointer register if a preceding
> argument consumed multiple slots?

Yes, this is a problem. Will fix.

>
> [ ... ]
>> @@ -14308,11 +14444,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   	if (bpf_is_kfunc_pkt_changing(&meta))
>>   		clear_all_pkt_pointers(env);
>>   
>> -	nargs = btf_type_vlen(meta.func_proto);
>> -	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
>> +	proto_slots = kfunc_proto_slots(desc_btf, meta.func_proto);
>> +	if (proto_slots > MAX_BPF_FUNC_REG_ARGS) {
> [Severity: High]
> This patch introduces multi-slot kfunc arguments, but were all places
> that map register slots to BTF arguments updated?
>
> For example, in bpf_kfunc_stack_access_bytes(), the register slot index
> (arg) is still directly used to index the BTF argument array:
>
> 	args = btf_params(meta.func_proto);
> 	nargs = btf_type_vlen(meta.func_proto);
> 	if (arg >= nargs)
> 		return 0;
>
> 	t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
>
> Could this result in looking up the wrong parameter or going out of bounds
> when querying stack accesses for kfuncs with multi-slot arguments?
>
> [Severity: High]
> And similarly, does bpf_get_call_summary() also need to be updated?
>
> bool bpf_get_call_summary(...) {
> ...
> 	if (bpf_pseudo_kfunc_call(call)) {
> ...
> 		cs->num_params = btf_type_vlen(meta.func_proto);
>
> Since liveness tracking uses cs->num_params to determine the number of live
> registers, could using the BTF argument count instead of the number of
> register slots cause the verifier to treat upper registers of multi-slot
> arguments as dead?

The same here. Will fix.


