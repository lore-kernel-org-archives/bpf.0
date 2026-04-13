Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9231F9AF
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090351; cv=none; b=U0TsH1O+BLIIDKc/zloor/rPiAyZuahrcj+FknwDHQ/VvTpgifJROZir9HzemqMjFRllceen8xwhqKfiFLf0AisIINsFCkrsKdIqfoWTlv3VHCdiKWAQNierr81yHVM0zxARH5ScRqaPIdK4iGeM6AaPpPuFZlZcSgMySYoDfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090351; c=relaxed/simple;
	bh=BmTcxKQ1Dh00PvlGta9EXFSanXaeKqx0+FQL8Bz4jfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AB0Swu4eMvkXb/xdQP9xGVIlceuRJcr5r4S8bNw9QwA9IBAV5azSmckzTThTyKsFdQD4cL0GNHNkvsQU+tZh4cZVaiV9lt3LA83yab49FMR/uheTZ21mVKKgVB03y1rSJGnQ/X7pwiJV6lmeM39PvrX6JrLaGiouMFIh/whhUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S3lYEs/x; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S3lYEs/x"
Message-ID: <4469c49f-34e3-4d23-9aa2-953b390c416a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776090347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6LQEWzZKJkl1BmRalKD0CS13HMWsUH3JZpA8k6wYdw=;
	b=S3lYEs/xSTfM4HOgaKNaRalAT/VW+7bqYViNnbjLy+VakoaFvY6Dy3WUg6787Mj/Ee2N+X
	ai+iWbr2BBYj9qvsuNH4kMLB+6l3RmhU2sSAymUCRXiHqImy7wgHoa2Hm9GTs1fl6ZFQDK
	0ySDhTMB9XIuNL9KKyBgh1xZuvj85cM=
Date: Mon, 13 Apr 2026 07:25:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 03/18] bpf: Refactor to avoid redundant
 calculation of bpf_reg_state
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260412045842.255098-1-yonghong.song@linux.dev>
 <fb261f110faa13eb0dddaf0197a670f8bb9716c8ba8c0537766bdf2cb4c17600@mail.kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <fb261f110faa13eb0dddaf0197a670f8bb9716c8ba8c0537766bdf2cb4c17600@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/11/26 10:31 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6469e71cd1fa..4c67a15c73e1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -8374,11 +8355,10 @@ static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>    * read offsets are marked as read.
>>    */
>>   static int check_stack_range_initialized(
>> -		struct bpf_verifier_env *env, int regno, int off,
>> +		struct bpf_verifier_env *env, struct bpf_reg_state *reg,int regno, int off,
>                                                                       ^
>
> There's a missing space after the comma between *reg and int.  The
> forward declaration earlier in the file has proper spacing, but the
> definition here does not.

Ack. Will fix.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635

