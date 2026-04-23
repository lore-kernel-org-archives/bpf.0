Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A62D34D90E;
	Thu, 23 Apr 2026 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776986782; cv=none; b=t1Qk+yO+gOk7AmM8yqr4T3shRPocj1O0WYHWnfJmMkRdOA3XQuSg7Ka9GNGm3dZZ4mWgJFFPxK+5DW2sCWHUP78kFz/HdH0HCAaT7ZjMx2zDdGKm01yIbkxm1l3dQeZS3ibVjbTo/4sDwzeERxtPx1+ukRdSVTaZf1I9bUUXWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776986782; c=relaxed/simple;
	bh=vMJQBa5zmzOAcaZtVAWU6wleEYJ5jJl9bsl9eKfiVzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5uMr2ZfidaZh9CAcW9xie0wOLU1t6GG4Fmt4fZlFt+lGxVv9PIG6YLNX+O+CmvuJaVuhYZoPa3YePut9swGq9jvIBf8KZtqCKB9JIscyUdaf0bczxkB5ut2QEYZsXPfEfHag1MqZFfUQkNANRdfWiQrtQLR9d4VsbzPGle6rqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q85Pf2c3; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q85Pf2c3"
Message-ID: <a739cf27-a65a-40da-830d-edda27bfa6b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776986777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bycuOgk3I1MKhMIM80x+6ULtiN6q6gNeSnWYfwMp2UQ=;
	b=Q85Pf2c3c+FeYg1SoeAxmKVmNYmFRy5EPFvL8r7Ld8slAdmuqei/5BBGZqFglkUiiMOy2Z
	MfYNQ15FZq4HzXDe2ZfGA8LHPBweQJSLvIaxmRuqJ+WAfrUrugHSRImkzObKBglbNmpvwG
	3wrJVtgivZKCi5yjrw0ltpfsKWcwbgY=
Date: Thu, 23 Apr 2026 16:25:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 1/9] bpf: refactor kfunc checks using
 table-driven approach in verifier
To: Chengkaitao <pilgrimtao@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, leon.hwang@linux.dev,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, memxor@gmail.com
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Chengkaitao <chengkaitao@kylinos.cn>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20260329140506.9595-1-pilgrimtao@gmail.com>
 <20260329140506.9595-2-pilgrimtao@gmail.com>
 <CAADnVQ+xS4ti=cSqAnG4ePmjEZXUb-8Ss9cjkWiiWgtv-_NNVQ@mail.gmail.com>
 <CAAWJmAYxbEX0M3JFJn11WOfvRoLrxnuXtkDp5omt-FJYwc8mpg@mail.gmail.com>
 <1fcda49a-caeb-42b9-9727-d1ab3d07d84b@linux.dev>
 <CAAWJmAYNS-NaY-57Pt=GC5qSpbfJLKwydVXfem6ckwgFW9aTnw@mail.gmail.com>
 <82148eb1-f270-48f1-8900-e0becc6384e8@linux.dev>
 <CAAWJmAZQHmgKXgr0xN5sHWUGyu43xLyg4eG7yBrMDi7YALrKsw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAAWJmAZQHmgKXgr0xN5sHWUGyu43xLyg4eG7yBrMDi7YALrKsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/9/26 7:53 PM, Chengkaitao wrote:
> On Wed, Apr 8, 2026 at 2:41 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 4/4/26 3:38 AM, Chengkaitao wrote:
>>>
>>> It pushes us to untangle messy verifier safety cases and make them modular,
>>> so they can be expressed as parameters to BPF_VERIF_KFUNC_DEF
>>
>> Again, I agree with the premise that verifier safety checks could
>> become more modular where possible. But I think we should first
>> separate two questions:
>>
>> 1. What kfunc properties should be declared centrally?
>> 2. Where that declaration should live?
>>
>> While I'd like to answer (1) with "all of them", I am not convinced
>> the answer to (2) is .BTF_ids or BTF. A better C side declarative
>> representation would give us most of the benefit here without making
>> the BTF tooling more complex.
>>
>> Here is how I think we should move forward:
>>
>>   1. Your bpf_list_* work is orthogonal to BTF_ID refactoring, so it's
>>   reasonable to first focus on landing it without changes to generic
>>   kfunc handling.
> 
> There is no consensus on whether the patch below should exist at all.
> [PATCH bpf-next v9 1/9] bpf: refactor kfunc checks using table-driven ...

Hi Kaitao,

I think this refactoring patch should be dropped from the series.
For now use the established pattern with special_kfunc_list, and don't
introduce new _impl kfuncs.

> 
> Should we drop it entirely, or limit its scope to the is_bpf_* helpers
> that contain a large number of btf_id == special_kfunc_list[*]-style
> checks—for example by reverting to v8 or an earlier revision?

I don't think "reverting to v8" will work. Since you've sent v9
significant changes to the verifier.c have been landed, so you have
some rebase work to do anyways.  I suggest you minimize unnecessary
refactoring in this series, and focus on bpf_list_* api extension.

pw-bot: cr

Thanks, and apologies for slow reply.


> https://lore.kernel.org/all/20260316112843.78657-2-pilgrimtao@gmail.com/
> 
> cc: Alexei Starovoitov, Emil Tsalapatis, Leon Hwang, Mykyta Yatsenko,
>       Kumar Kartikeya Dwivedi
> 
>>   2. I plan to send patches (soon) for resolve_btfids, and then for
>>   BTF_ID macrology to eliminate the enum + array pattern. You are
>>   welcome to join the discussion and review / test the patches.
>>
>>   3. After all of the above lands, we can come back to the general
>>   BTF_ID / kfunc handling discussion. If you are interested in
>>   developing this further, I suggest to re-think the approach and come
>>   up with a "single kfunc metadata definition" that doesn't require
>>   significant changes in .BTF_ids section layout.
>>
>> A slightly off-topic comment: the usage of `_impl` pattern for kfuncs
>> should be considered deprecated. Any new kfuncs that work with
>> verifier-supplied arguments should use KF_IMPLICIT_ARGS mechanism.  So
>> the `bpf_list_add_impl` in your seires should only have one version:
>> `bpf_list_add` marked with KF_IMPLICIT_ARGS flag.
> 

