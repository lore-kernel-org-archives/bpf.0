Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C8358234
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199841; cv=none; b=IU4e55lktZFpnJnzVnSz96JPU6eDD3NV7G13zKN6cOvf3UZRRw8X14E7Cr7W4IObr5kPNipNQyTS8l87ftLnrW2c0++Kxq5MsGQ2Klxa+VeC/R7TaHRsR4M8U1oi5tJMVrML9VvtQTUwuoUx7cV4yvsLsvL/RICfy8O0V2x7FtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199841; c=relaxed/simple;
	bh=GXge6vdMGNwk84kOx8nDeoZizR+y0wwQi9kA+vNioaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=posiE7vizJpGY1GmglNzCg/gwqt+tR5+DRMY0k8GKSZGkZlNS2UDYCDOrpgyCCJ0og/XlzjZ/H3zHcl/qlNx0iijClLBuhOyOGXZ2jdt5zBF/UkQ5ShG3R+UQXw6LxyUcJQ4T1WB8RkN+JRuHIXAVCBksm7SB1+sylo4kY48R7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CDwZrxx4; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CDwZrxx4"
Message-ID: <e4196303-0631-4a08-a544-ade179d41ef8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710199836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJbTACPNN7dp7eOjevBRzcdn8jxMId+sJfGAu/VKb3o=;
	b=CDwZrxx4G55tdnLYxiqd2lLNgllenc7lIC/QdoajBQJ7YUTC3UtRZbLPN8QJwCK7VWSyIb
	61yHl3WkZrEyaISoGTN7o56OoP2JxYvFX1SrsS7o+U3CFs0obAaDJuxG26D9lxfPc7yt/A
	8sbSzNitG6J/CCGHJX0TUuBwvHLOhgc=
Date: Mon, 11 Mar 2024 16:30:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpftool: Fix missing pids during link show
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Quentin Monnet <quentin@isovalent.com>
References: <20240311214116.2123875-1-yonghong.song@linux.dev>
 <CAEf4BzYU0R=HxFk0h_4rHdfCD=9hX-8NRSr=eGiND_3p=8Syvg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYU0R=HxFk0h_4rHdfCD=9hX-8NRSr=eGiND_3p=8Syvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/11/24 4:13 PM, Andrii Nakryiko wrote:
> On Mon, Mar 11, 2024 at 2:41 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Current 'bpftool link' command does not show pids, e.g.,
>>    $ tools/build/bpftool/bpftool link
>>    ...
>>    4: tracing  prog 23
>>          prog_type lsm  attach_type lsm_mac
>>          target_obj_id 1  target_btf_id 31320
>>
>> Hack the following change to enable normal libbpf debug output,
>>    --- a/tools/bpf/bpftool/pids.c
>>    +++ b/tools/bpf/bpftool/pids.c
>>    @@ -121,9 +121,9 @@ int build_obj_refs_table(struct hashmap **map, enum bpf_obj_type type)
>>            /* we don't want output polluted with libbpf errors if bpf_iter is not
>>             * supported
>>             */
>>    -       default_print = libbpf_set_print(libbpf_print_none);
>>    +       /* default_print = libbpf_set_print(libbpf_print_none); */
>>            err = pid_iter_bpf__load(skel);
>>    -       libbpf_set_print(default_print);
>>    +       /* libbpf_set_print(default_print); */
>>
>> Rerun the above bpftool command:
>>    $ tools/build/bpftool/bpftool link
>>    libbpf: prog 'iter': BPF program load failed: Permission denied
>>    libbpf: prog 'iter': -- BEGIN PROG LOAD LOG --
>>    0: R1=ctx() R10=fp0
>>    ; struct task_struct *task = ctx->task; @ pid_iter.bpf.c:69
>>    0: (79) r6 = *(u64 *)(r1 +8)          ; R1=ctx() R6_w=ptr_or_null_task_struct(id=1)
>>    ; struct file *file = ctx->file; @ pid_iter.bpf.c:68
>>    ...
>>    ; struct bpf_link *link = (struct bpf_link *) file->private_data; @ pid_iter.bpf.c:103
>>    80: (79) r3 = *(u64 *)(r8 +432)       ; R3_w=scalar() R8=ptr_file()
>>    ; if (link->type == bpf_core_enum_value(enum bpf_link_type___local, @ pid_iter.bpf.c:105
>>    81: (61) r1 = *(u32 *)(r3 +12)
>>    R3 invalid mem access 'scalar'
>>    processed 39 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 2
>>    -- END PROG LOAD LOG --
>>    libbpf: prog 'iter': failed to load: -13
>>    ...
>>
>> The 'file->private_data' returns a 'void' type and this caused subsequent 'link->type'
>> (insn #81) failed in verification.
>>
>> To fix the issue, do a type cast from 'void *' to 'struct bpf_link *' for file->private_data
>> as in this patch, and the 'bpftool link' runs successfully with 'pids'.
>>    $ tools/build/bpftool/bpftool link
>>    ...
>>    4: tracing  prog 23
>>          prog_type lsm  attach_type lsm_mac
>>          target_obj_id 1  target_btf_id 31320
>>          pids systemd(1)
>>
>> Fixes: 44ba7b30e84f ("bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c")
>> Cc: Quentin Monnet <quentin@isovalent.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>> index 26004f0c5a6a..96ffcc4f0e67 100644
>> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>> @@ -100,7 +100,7 @@ int iter(struct bpf_iter__task_file *ctx)
>>          if (obj_type == BPF_OBJ_LINK &&
>>              bpf_core_enum_value_exists(enum bpf_link_type___local,
>>                                         BPF_LINK_TYPE_PERF_EVENT___local)) {
>> -               struct bpf_link *link = (struct bpf_link *) file->private_data;
>> +               struct bpf_link *link = bpf_core_cast(file->private_data, struct bpf_link);
> bpf_core_cast() (i.e., bpf_rdonly_cast()) is newer feature, so relying
> on it in bpftool will make PID printing not work on older kernels that
> generally do support iter/task_file iterators.
>
>>                  if (link->type == bpf_core_enum_value(enum bpf_link_type___local,
> the problem is that we dropped BPF_CORE_READ() here and went with
> `link->type`. Should we restore BPF_CORE_READ(link, type) here and
> solve the problem, while also supporting this feature on wider set of
> kernels? Quentin?

Good point. Using the latest fancy feature might not be the best way as old
kernels won't work and this is a strong argument. I will change
to use BPF_CORE_READ in v2.

>
>>                                                        BPF_LINK_TYPE_PERF_EVENT___local)) {
>> --
>> 2.43.0
>>
