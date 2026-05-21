Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483B32E134
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345052; cv=none; b=eVMZbKLfjTvpSzYIsQvtBOREt/TF/GjgNSOxi7KvfRzGbB1ItyV8aqrg3QbqnFZNlw1OFaaDtQzgeszYzV5V3kpHaciRrHUd4TMTZx2iwCbHHPxDGU6RsG9XYaU1lkc1lXvzg0t5c3oDDEF2+7sizVGcmqsiAUpBWRebGfyLR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345052; c=relaxed/simple;
	bh=8R0vctU7z4EQZbfy1owVGxzrU5Y0GCb3Axo7exyTG6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePoOowX1KicHsXjAEvbdD97/8lyAs3dnMMoqaaBCEdIUrT7DPd5xPAZgh4pT0Ivc02i3xiaDItVMtCq0GhPwBm0E1/nGD51CxrjZISozdcj3Zb5SQjs6xiKaRyYJUOPm+q9zXA1ElFpkW9dZPRy7Cah/mqzf9XGhMuDDDYSQT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wN8a4GRa; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wN8a4GRa"
Message-ID: <e3161bcf-92e6-4d85-9e80-a6b081d44f62@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779345038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oWXMI+artQUT3BERACb5g1lLwEqc2ryF+PiR5qEMqIQ=;
	b=wN8a4GRavA48KI1TPyKp/odiEc3L06Z02eFOccaPR+FcudhtLR1xmwJ6dR/g/753lGtriz
	abDZOh8HHhgbPWyqye/vaVBo30K0NgdrPIH3vXX1MKXLnEcpJvbBaKirDzxkHUMwGbuHr6
	iYwWzSlpsaJawH4uKlMFeFOplUOeh/I=
Date: Thu, 21 May 2026 14:29:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 3/8] bpf: allow non-owning list-node args via
 __nonown_allowed
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
 martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, skhan@linuxfoundation.org, memxor@gmail.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260521032306.97118-4-kaitao.cheng@linux.dev>
 <96cd744d0a5a8756cb0c1e31e95fbe682956b97226e2159120785feb01013e53@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <96cd744d0a5a8756cb0c1e31e95fbe682956b97226e2159120785feb01013e53@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/5/21 12:08, bot+bpf-ci@kernel.org 写道:
>> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
>> index 75e6c078e0e7..3a9db1108b95 100644
>> --- a/Documentation/bpf/kfuncs.rst
>> +++ b/Documentation/bpf/kfuncs.rst
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8dd79b735a69..f3cf8d85bea0 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
>> @@ -12244,6 +12249,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>  			return ret;
>>  		break;
>>  	case KF_ARG_PTR_TO_LIST_NODE:
>> +		if (is_kfunc_arg_nonown_allowed(btf, &args[i]) &&
>> +		    type_is_non_owning_ref(reg->type) && !reg->ref_obj_id) {
>> +			/* Allow bpf_list_front/back return value for
>> +			 * __nonown_allowed list-node arguments.
>> +			 */
>> +			goto check_ok;
>> +		}
>>  		if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
>>  			verbose(env, "%s expected pointer to allocated object\n",
>>  				reg_arg_name(env, argno));
>>  @@ -12253,6 +12265,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>  			verbose(env, "allocated object must be referenced\n");
>>  			return -EINVAL;
>>  		}
>> +check_ok:
>>  		ret = process_kf_arg_ptr_to_list_node(env, reg, argno, meta);
>>  		if (ret < 0)
>>  			return ret;
> 
> This isn't a bug, but the multi-line comment doesn't match the BPF
> subsystem style. The BPF guide requires multi-line comments to have the
> opening /* on its own line for files under kernel/bpf/. Should this be:
> 
>   /*
>    * Allow bpf_list_front/back return value for
>    * __nonown_allowed list-node arguments.
>    */

This file uses this comment style extensively, so I followed the
existing convention here.

> Eduard Zingerman raised a related nit in v10 RESEND: the check
> '!reg->ref_obj_id' appears redundant. Would type_is_non_owning_ref() be
> sufficient here?
> 
> Reference: https://lore.kernel.org/bpf/0419643c9a04bf0824066742e52e3f197b43909b.camel@gmail.com/
> 

Sorry, I missed that. If needed, I can fix it in the next version.

> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26204125015

-- 
Thanks
Kaitao Cheng

