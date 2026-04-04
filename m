Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC701A6805;
	Sat,  4 Apr 2026 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775278180; cv=none; b=JFkijmKWyJtXz9AvP5TWkwDYtXoEOcmOxjl9akF4+IjEuHcCSewNAfymPU+mq9BJBcREir9JOj+f/rnBGpOJ3+/KlLqgbn+cPERylIyplKZc8FVrdFu6l9VZBfj+EsGk0g69R7rg0F4YfZeQrEtDIsBpHbK76KlJPkynTendBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775278180; c=relaxed/simple;
	bh=LnjjVxNBjPlnWJQFiNPQ8QstC8L1YggXA7KURllJHAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWcqReuxUrCOiWOXOifq3YFWrBtRPXirn4wfJU774n4Tz7S1L7NQ+nSBUD6o1zl4+2rzPv+67OPlhsfrIk/dEDfCe64L7HBO3MZOtJfuDOR44lQhL88U20HFu3K5VgQspTc6g9wq+PdwUvV6KoYNofeeUrXy0+YZk66nmK53qPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rz2coO4m; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rz2coO4m"
Message-ID: <1fcda49a-caeb-42b9-9727-d1ab3d07d84b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775278166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSbfng6RnKdSh/B9gSzWzLmAs5ma6HeXfw5GARvlTmU=;
	b=rz2coO4moPYuj45FUlfUbXfolNa/un4a9zW1etH/v7k1HNCTpGE6B8e37ysy+DOE6ox3RL
	wZ9DWelkwLDcwOy0B/yci+LkEfjXa6q/y/7zKM/yuQRBWut0EkL00vyo2lQsTG6M9fl8N+
	JUqJ2d7F223Pl8JGyIivcDSWEiHdTJ0=
Date: Fri, 3 Apr 2026 21:49:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 1/9] bpf: refactor kfunc checks using
 table-driven approach in verifier
To: Chengkaitao <pilgrimtao@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAAWJmAYxbEX0M3JFJn11WOfvRoLrxnuXtkDp5omt-FJYwc8mpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/3/26 10:41 AM, Chengkaitao wrote:
> On Tue, Mar 31, 2026 at 1:05 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Sun, Mar 29, 2026 at 7:05 AM Chengkaitao <pilgrimtao@gmail.com> wrote:
>>>
>>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>>>
>>> [...]
>>> +
>>> +/* Kfunc family related to spin_lock. */
>>> +static const enum special_kfunc_type bpf_res_spin_lock_api_kfuncs[] = {
>>> +       KF_bpf_res_spin_lock,
>>> +       KF_bpf_res_spin_unlock,
>>> +       KF_bpf_res_spin_lock_irqsave,
>>> +       KF_bpf_res_spin_unlock_irqrestore,
>>> +};
>>
>> I think it's a step in the wrong direction.
>> I'd wait for Ihor's BTF_ID_NAMED cleanup.
> 
> After reading Ihor's messages on the list, if I understand correctly,
> our two approaches seem to target different problems. What Ihor's
> work appears to achieve is the ability to remove the entire enum
> special_kfunc_type. My goal, on the other hand, is to replace many
> scattered func_id == special_kfunc_list[...] comparisons with a
> table-driven approach.

Hi Kaitao,

I appreciate your efforts, however after a quick pass over the changes
you propose (both here and in the new series) with respect to BTF_ID
macros and special_kfuncs_list, I don't understand what problem you're
trying to solve.

The inherent complexity is in the fact that the verifier must know
when a particular BTF id identifies a specific kfunc, or whether it
belongs to some pre-defined set of ids. This is why
special_kfuncs_list and other BTF_ID_SET/LIST-s exist.

And so there is no way around defining those ids and sets *somewhere*,
and so far BTF_ID_* macros did a fine job of that, all things
considered.

AFAICT your changes simply move around the same definitions from
functions with if statements to constant arrays with a runtime search
on them (which is slower by the way). What is the benefit of that vs
the current implementation? We still have to maintain those arrays in
the same way we have to maintain the is_foo_kfunc helpers.

Your newer proposal [1] takes the same idea to the next level, by
introducing an entire new BTF kind, new ELF sections and a bunch of
macros that are no less complicated than existing. And all of that
just moves the same arrays "upstream" to the .BTF_ids section. Again,
I fail to see any benefits to that complexity. Having differentiation
between LIST and SET, and having to mark START and END is not a
problem that needs solving IMO.

The work I was discussing with Alexei [2] is targeted: get rid of
constant enums that mirror existing kfunc symbols by making BTF_ID
internals a bit smarter. And the benefit is clear and simple.

If you could explain what exact issue you're trying to address with
your BTF_ID refactoring patches, maybe we can try converging on a
reasonable approach to it.

Thanks!

[1] https://lore.kernel.org/bpf/20260403170900.58659-1-pilgrimtao@gmail.com/
[2] https://lore.kernel.org/bpf/21e5333c-0b57-46ce-99c8-f6c414270e70@linux.dev/


> 
> That said, once Ihor's solution lands, my approach would no longer
> be applicable as-is. So I have been thinking about an alternative,
> please see the patch linked below for details:
> https://lore.kernel.org/bpf/20260403170900.58659-1-pilgrimtao@gmail.com/
> 
>> Kaitao Cheng,
>>
>> also please start your part of code reviews.
>> Your patches are not going to be landing if you don't code review.
>>
>> https://lore.kernel.org/bpf/CAADnVQ+TKKptnNB25V3=bcdybh5G6c2DyW2sYtXvyRaVnPN8MA@mail.gmail.com/
> 
> I will do my best to carry this forward.
> 

