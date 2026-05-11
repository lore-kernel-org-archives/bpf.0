Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2799B43C05C
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517016; cv=none; b=t5BUajGRs9R8tXDyIicO39i/N7eU8H3SIzSUbWCH42KK2RwRkJNvFqBCMIkbjwTSq/fTXA32mIAnn7035zsEWNDp7+wtOe7xuC20irkDJ6pHF3Q9cVoeqHqFFAPjcbioQRoySnzzsCQia4hrn+PNX330CxNaLptYUgPWTfdGA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517016; c=relaxed/simple;
	bh=6tzXfK9OlCMPRyrfzdFcGRzJvHgVLvLHb3DXbBTdPsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ID7F9DeQhZELcUV6kPiiUP0TbF96H318vWoPyLgZovR6x54gz4Gb9PzhkEtcIVDrItNpZcTj4m8gfmRAlMFsd1ZKshU7AcQsVmtkPNx4P55NwC3OJmp36yYou5ZQJx6lL7Z2orGRqvslbVqHQxp2eO84NNaK6u1KF7UE963lhZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EMz6q8ge; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EMz6q8ge"
Message-ID: <d84a5f9b-f7be-43b8-9c1c-a452c8318d46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778517010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RF59Oi5kgNayDrcUxz5cqDUxgKBb2Cnxvihbp9AKmg=;
	b=EMz6q8geRk1rPbN30+R0VRaYItENBRvPON5kiJKqP0/yOARZrY2F4Qr+YVzk8/MLQOGIuU
	N09KybUub0i3qMkjf/ETKWygB+jj0HE5zcL7VmRuPFpIkgMOxHfixjVnJ0oXyglReoARJx
	2qu0oIyzpSibQSTu3S/UfULJnp0BlgA=
Date: Mon, 11 May 2026 09:29:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 04/24] bpf: Set sub->arg_cnt earlier in
 btf_prepare_func_args()
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260511053322.1883474-1-yonghong.song@linux.dev>
 <9807060ec039594f53533aceaf5808b667bbceed625575fa146871e3a05a4634@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9807060ec039594f53533aceaf5808b667bbceed625575fa146871e3a05a4634@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/11/26 8:19 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 77af44d8a3ad..a33a5b4122f8 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7880,6 +7880,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   	}
>>   	args = (const struct btf_param *)(t + 1);
>>   	nargs = btf_type_vlen(t);
>> +	sub->arg_cnt = nargs;
>>   	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
>>   		if (!is_global)
>>   			return -EINVAL;
>> @@ -8067,7 +8068,6 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   		return -EINVAL;
>>   	}
>>
>> -	sub->arg_cnt = nargs;
>>   	sub->args_cached = true;
>>
>>   	return 0;
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.

In v3, for the *main* program, we have the following:

                 /* if main BPF program has associated BTF info, validate that
                  * it's matching expected signature, and otherwise mark BTF
                  * info for main program as unreliable
                  */
                 if (env->prog->aux->func_info_aux) {
                         ret = btf_prepare_func_args(env, 0);
                         if (ret || sub->arg_cnt != 1 || sub->args[0].arg_type != ARG_PTR_TO_CTX) {
                                 env->prog->aux->func_info_aux[0].unreliable = true;
                                 sub->arg_cnt = 1;
                                 sub->stack_arg_cnt = 0;
                         }
                 }

Since sub->arg_cnt and sub->stack_arg_cnt is set here for the main program,
patch #4 is not needed any more.


> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25652623893

