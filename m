Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66DD221F03
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699978; cv=none; b=pEiHNXJ7CGygIYeOfB4CIcYwxsSASI9Vw6xZf6/4UKV3forEtYMKv/OIzGV4xulsrxZsO6eV0CkfJ8gUqPJEbeZOi/hd4AUjmPbETCvAPI/1wHhe9TnsJpBlvXdGIyrpJMk8fZpHDLg5/2ypCNsC7IuR3SjMcaI2bjgihx0mH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699978; c=relaxed/simple;
	bh=wf9E53pS+pa+ZiyOt5s2q1+5OrQHBtyxnOCqcXwUAEY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KHJSIK62ZR+1PPG+kNmZvkinwnlobupzHY+MaU15hjTegSrh6Sr3kv2dHTISdfuQhxMkuuLmlYHOj/Oq+2ezv4j2Eljra2+QRkDtu5oP3/2i0Pdp9gspZ5zU87A2pVCCpR1ZhvgwmZoENh5yIiksjnmworjygtIbDNfjzs96CwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OUq4eMJc; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OUq4eMJc"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769699974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVbbNBM8h2hLry9+PjA9Xnf//1plR69ceWUdZQzpcN8=;
	b=OUq4eMJc8eAdZ74vls9q8VxZhtpQjlW71HAqe06bfYZVmfblin6PvTAr9ovnnwAOqy2SHM
	24swlbe1CfBBQ96jm4P6At9i0DMhjw3nRRxbO665shByg8zcgEDx90niAclRdqcXz0KwLW
	/Khir5oloAjBwkPM0mh1F9tQ6FLJ5xo=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Jan 2026 23:19:19 +0800
Message-Id: <DG16A1T5EJWO.D9L79G1ZE8H9@linux.dev>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <puranjay@kernel.org>, <xukuohai@huaweicloud.com>,
 <catalin.marinas@arm.com>, <will@kernel.org>, <shuah@kernel.org>,
 <menglong8.dong@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Add bpf_jit_supports_fsession()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: <bot+bpf-ci@kernel.org>, <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
References: <20260129142536.48637-2-leon.hwang@linux.dev>
 <97fd7e67669f887badde4e276fc501a5969ff9dac703a6dccedda386dacd25f1@mail.kernel.org>
In-Reply-To: <97fd7e67669f887badde4e276fc501a5969ff9dac703a6dccedda386dacd25f1@mail.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu Jan 29, 2026 at 10:54 PM +08, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e7ff8394e0..6e0693ac72 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -24874,6 +24874,9 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
>>  	case BPF_TRACE_FENTRY:
>>  	case BPF_TRACE_FEXIT:
>>  	case BPF_TRACE_FSESSION:
>> +		if (prog->expected_attach_type =3D=3D BPF_TRACE_FSESSION &&
>> +		    !bpf_jit_supports_fsession())
>> +			return -EOPNOTSUPP;
>
> This isn't a bug, but other similar bpf_jit_supports_*() checks in
> this file include a bpf_log() message before returning an error. For
> example:
>
>   bpf_jit_supports_kfunc_call() -> "JIT does not support calling kernel f=
unction"
>   bpf_jit_supports_exceptions() -> "JIT does not support calling kfunc...=
"
>   bpf_jit_supports_arena()      -> "JIT doesn't support arena"
>   bpf_jit_supports_private_stack() -> "Private stack not supported by jit=
"
>
> Should this check also include a message like "JIT does not support
> fsession" for consistency with other similar checks in the verifier?
>

That makes sense.

Let me add the log message.

Thanks,
Leon


>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/214822=
97342
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit demonstrates specific debugging con=
text with actual test output and errno values, correct understanding of ker=
nel BPF conventions, and follows established patterns - typical of experien=
ced human kernel developers.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Minor consistency issue - missing bpf_log() e=
rror message compared to similar checks in the same file; does not affect f=
unctionality or stability.
