Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F425A2DD
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645723; cv=none; b=E7wCyhcu55TmwTk1wb4OvAScXjWgo6JEZeSFbmHTAur8QbPlPyuv7sHudzTpeuxnZKkwXs5YhJUlxheo/cCl7huYZ4IOBWQjA8M+ykrTi+vfVgzCAmDbRTpH4QKSzimsPbSo8cxA2m9z3JqoWNAnOkCFvzupKenMGsZT8fYFeVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645723; c=relaxed/simple;
	bh=wF4a5XCN7BhbxfkEHkpWjAFyz60QuRYbQuj//qQ6XsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWkYbHQ3u9tuvPE2V+SOYIOP9CtItCzBIZa9r2E+GSSvFL3mfauo09e1Fuymq6bmr/2fmw+tqKgsIl1fgKvg4lXOvmOmUmhvLZRBFfs5sS+QpbPZKH+mXUyBeIFHthzMEywFPRe/lbJdrOvmDCbdReSw0T3w6m/sSAbN4P40eq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z6saqbWf; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z6saqbWf"
Message-ID: <97357814-57e9-498f-894f-4c5dc4e3d0ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774645719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xT0uV5CfqKcw7v6+0IOl/XINuIhJBi3OtG4lhSJ3HNc=;
	b=Z6saqbWfHMIpgSkEUl3ZqjsHfnSmsruSEmgk5JkP1S363X9Fuuqepy1si0CttQ4gofXYQB
	Haj2hBw1gT2q/QPp10IN6d0zFqyXDWbg0coIh26TZpPhy6t5XG87pgVyHcJfqGbJUUE6DF
	+VoKFTn7acGEHouFQOjcumxJdbXZQs4=
Date: Fri, 27 Mar 2026 14:08:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <CAADnVQ+iXJK46cFcGN-Ta8KGxe7Y+m_DxgWNS=QC-gOWT=WxCw@mail.gmail.com>
 <b040711c-0fd1-475f-b807-e4e0b4324f6e@linux.dev>
 <CAADnVQKVEYhFXGXJ0u6TWQDe4t=zmq_tLpGKe2n_pOYT-J58qA@mail.gmail.com>
 <21e5333c-0b57-46ce-99c8-f6c414270e70@linux.dev>
 <CAADnVQ+bj2z0kzLcGTJ62NJgReTvqEu8fn6=7=bn+WKmfe9iTQ@mail.gmail.com>
 <676332b5-1f7f-4c8d-b41e-e2dbbc1d7e4e@linux.dev>
 <CAADnVQLUTNoa4qXW357CU5e2hP+DpxM=QYK2ZuWHR_aLbmb7Hg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQLUTNoa4qXW357CU5e2hP+DpxM=QYK2ZuWHR_aLbmb7Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/27/26 2:00 PM, Alexei Starovoitov wrote:
> On Fri, Mar 27, 2026 at 1:55 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 3/27/26 1:48 PM, Alexei Starovoitov wrote:
>>> On Thu, Mar 26, 2026 at 12:13 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>
>>>> [...]
>>>>
>>>> The above works, and the question now is if we like this mechanism
>>>> more than current setup with explicit enums.
>>>
>>> Got it. Thanks for the explanation.
>>> Your approach does sound a lot better than explicit enums.
>>> Make a proper patch out of it.
>>>
>>> If we do this can we remove <counter><line> approach everywhere
>>> while at it and only use named ?
>>
>> This crossed my mind too. I'll try to *replace* the suffixes and if
>> it works fine submit that.
>>
>> One inconvenience is that with named suffixes BTF_ID() macro will
>> have to accept an additional arg (the list name), but I think
>> that's ok. We already have to pass struct/func everywhere too.
> 
> and that name has to be unique.. I think it's fine.
> I'd do such change, and reuse all of BTF_ID macros.
> So that only BTF_SET_START line will differ.
> 
> The overall diff stat shouldn't be big ?

Depends on whether we are refactoring BTF_ID, or just adding new
BTF_ID_NAMED set of macros.

Refactoring would touch every single BTF_ID usage, and that's
pretty invasive:

$ grep -r 'BTF_ID(' --include="*.[ch]" | wc -l
307

$ grep -rl 'BTF_ID(' --include="*.[ch]" 
fs/bpf_fs_kfuncs.c
include/linux/btf_ids.h
kernel/bpf/bpf_lsm.c
kernel/bpf/bpf_struct_ops.c
kernel/bpf/btf.c
kernel/bpf/cpumask.c
kernel/bpf/crypto.c
kernel/bpf/helpers.c
kernel/bpf/verifier.c
kernel/trace/bpf_trace.c
net/bpf/test_run.c
net/core/filter.c
net/core/xdp.c
net/netfilter/nf_conntrack_bpf.c
net/sched/bpf_qdisc.c
tools/include/linux/btf_ids.h
tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
tools/testing/selftests/bpf/test_kmods/bpf_testmod.c

