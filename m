Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C2FC1B
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 05:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710306089; cv=none; b=K2TbOQM/PiTQTP5+taKGArxseLkM5k1A9mcvGa/VXprPKuLAgL49p2JZpqXS/9X09/rar4uUS2TyiaZQCi7xw4LujcsB7/grOO1SBPAvL+1s99GEo6duGpdxZXbl4C2nHC4CYyy8VSORQFyQnpMCtlpN6nVODO6zVLRzyDf6RUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710306089; c=relaxed/simple;
	bh=xQ/b7Ow66I6XXeB1QWWNYCCdMeXnDTn2Xa9RXDvwGwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqAlu8AiNJt1p2uRXGWJQ1uDij2EgEluZT3bw1cBcBLXfZiAZwh607B5aSQm/oEjkO2hAftDj7Cewi9TlEBxgtAVSUKT2eKweLiCTaxn7ASuKff+nDBjuuPqXDj/ZyLfxX7E/cHebi+JjUOvzVA/UjYx+eXF+YQQ3qr+Z8KPPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AojcqBgP; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AojcqBgP"
Message-ID: <76b5b5be-25bb-4fd8-8f4c-4e5fede3484f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710306084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvmxq42j0Fqt3eeQA58NaM0ei0XALv3ZA/tTXFVm+/Y=;
	b=AojcqBgPrOSNCevOCP/VvGLS0a+EiSa2BjoIJoSQskO7Z6fIhuzrwdRl/9687w+KvP7dEn
	Uv0w+WEMrk1TsInUY828/Rk8NQzwTnQ2G6D6Q1Z9EqGHbFuV2RapxUWI18d1scG5H+dmwS
	C8vey+WtcV/a2+WqqTx9UNQbi9ay/FY=
Date: Tue, 12 Mar 2024 22:01:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpftool: Fix missing pids during link show
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240312023249.3776718-1-yonghong.song@linux.dev>
 <c73285ba-57db-4f08-8e77-01c66c98379c@isovalent.com>
 <53e1eddb-b003-4ae7-be13-55727d03b27f@linux.dev>
 <CAEf4BzZ-itSprx8AOWAyPbZ6FBLBhz_HKWSyyLWszg40Pi3MRw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZ-itSprx8AOWAyPbZ6FBLBhz_HKWSyyLWszg40Pi3MRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/12/24 4:11 PM, Andrii Nakryiko wrote:
> On Tue, Mar 12, 2024 at 8:24 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 3/12/24 7:01 AM, Quentin Monnet wrote:
>>> 2024-03-12 02:32 UTC+0000 ~ Yonghong Song <yonghong.song@linux.dev>
>>>> Current 'bpftool link' command does not show pids, e.g.,
>>>>     $ tools/build/bpftool/bpftool link
>>>>     ...
>>>>     4: tracing  prog 23
>>>>           prog_type lsm  attach_type lsm_mac
>>>>           target_obj_id 1  target_btf_id 31320
>>>>
>>>> Hack the following change to enable normal libbpf debug output,
>>>>     --- a/tools/bpf/bpftool/pids.c
>>>>     +++ b/tools/bpf/bpftool/pids.c
>>>>     @@ -121,9 +121,9 @@ int build_obj_refs_table(struct hashmap **map, enum bpf_obj_type type)
>>>>             /* we don't want output polluted with libbpf errors if bpf_iter is not
>>>>              * supported
>>>>              */
>>>>     -       default_print = libbpf_set_print(libbpf_print_none);
>>>>     +       /* default_print = libbpf_set_print(libbpf_print_none); */
>>>>             err = pid_iter_bpf__load(skel);
>>>>     -       libbpf_set_print(default_print);
>>>>     +       /* libbpf_set_print(default_print); */
>>>>
>>>> Rerun the above bpftool command:
>>>>     $ tools/build/bpftool/bpftool link
>>>>     libbpf: prog 'iter': BPF program load failed: Permission denied
>>>>     libbpf: prog 'iter': -- BEGIN PROG LOAD LOG --
>>>>     0: R1=ctx() R10=fp0
>>>>     ; struct task_struct *task = ctx->task; @ pid_iter.bpf.c:69
>>>>     0: (79) r6 = *(u64 *)(r1 +8)          ; R1=ctx() R6_w=ptr_or_null_task_struct(id=1)
>>>>     ; struct file *file = ctx->file; @ pid_iter.bpf.c:68
>>>>     ...
>>>>     ; struct bpf_link *link = (struct bpf_link *) file->private_data; @ pid_iter.bpf.c:103
>>>>     80: (79) r3 = *(u64 *)(r8 +432)       ; R3_w=scalar() R8=ptr_file()
>>>>     ; if (link->type == bpf_core_enum_value(enum bpf_link_type___local, @ pid_iter.bpf.c:105
>>>>     81: (61) r1 = *(u32 *)(r3 +12)
>>>>     R3 invalid mem access 'scalar'
>>>>     processed 39 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 2
>>>>     -- END PROG LOAD LOG --
>>>>     libbpf: prog 'iter': failed to load: -13
>>>>     ...
>>>>
>>>> The 'file->private_data' returns a 'void' type and this caused subsequent 'link->type'
>>>> (insn #81) failed in verification.
>>>>
>>>> To fix the issue, restore the previous BPF_CORE_READ so old kernels can also work.
>>>> With this patch, the 'bpftool link' runs successfully with 'pids'.
>>>>     $ tools/build/bpftool/bpftool link
>>>>     ...
>>>>     4: tracing  prog 23
>>>>           prog_type lsm  attach_type lsm_mac
>>>>           target_obj_id 1  target_btf_id 31320
>>>>           pids systemd(1)
>>>>
>>>> Fixes: 44ba7b30e84f ("bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c")
>>>> Cc: Quentin Monnet <quentin@isovalent.com>
>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>>    tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>>>> index 26004f0c5a6a..1eb756f8d02e 100644
>>>> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>>>> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>>>> @@ -102,7 +102,7 @@ int iter(struct bpf_iter__task_file *ctx)
>>>>                                      BPF_LINK_TYPE_PERF_EVENT___local)) {
>>>>               struct bpf_link *link = (struct bpf_link *) file->private_data;
>>>>
>>>> -            if (link->type == bpf_core_enum_value(enum bpf_link_type___local,
>>>> +            if (BPF_CORE_READ(link, type) == bpf_core_enum_value(enum bpf_link_type___local,
>>>>                                                     BPF_LINK_TYPE_PERF_EVENT___local)) {
>>> Looks good, thank you! Could you please just realign the
>>> BPF_LINK_TYPE_PERF_EVENT___local argument on the next line properly?
>> Will do. thanks.
>>
> We can fix it up while applying, so don't send another revision. We
> are waiting for trees to converge, so applying patches will be delayed
> a bit.

Thanks!

>
>>> With that:
>>>
>>> Tested-by: Quentin Monnet <quentin@isovalent.com>
>>> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
