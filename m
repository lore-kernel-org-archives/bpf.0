Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854531E98EF;
	Tue, 28 Jul 2026 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203151; cv=none; b=q5xu5/uYwEIIkr3BLkHtBsHqDuqcItvAwdpGvALS09kUPAE6jOVLQThifSBkdBzHYXxu4wocLV8VLkXUxTog1Ij3fh77OXFjYGuQJt55fUOowecCK1WLIV0gIskLXyK+BypFGf8UM0zpH+AABzJ1AVwf0Urzr0ZPp2DOeiZnhq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203151; c=relaxed/simple;
	bh=O/C87FucK+IAlWuWpimpknUKpQL15g+DGE4O+vzbCj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f2GPCBWgqvdWoLR5S4vxn0E8+4Pt/ziJ8HKInIHTQQsof1ksVTePAXKGfK2NxdgWRsclYFc7B9diQETzILejGBySNgR8XUKHEqNzMvoMDwHhvr7AGsyyEzlLK7L8FZOop+0obRAUd0e5FyuFQ+bZJLw0fD2NN18cCkZzjQXoy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4T1J/abA; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4T1J/abA"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rDrwXcOVQjSTQyGbLDwyQS7Zm3fOF83WkRfEeAy/+lw=;
	b=4T1J/abAw63FsZst9dAx24jri0Tn4gAJlXQhNuxP2K0z8TJurp5mJEKM/KiCPbC25jwmoDDpm
	+q/+WAKljPNFXhY7KiDgpLIWyJ0l7N9D836GWyNx6CKHclHJZ9sQ2Kuji2JJpY2n3tP2SRzURId
	dkhXVX8VSyGtO32Up5t/9Lw=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h8J2w36njzpT0b;
	Tue, 28 Jul 2026 09:36:24 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 67C4740538;
	Tue, 28 Jul 2026 09:45:39 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 28 Jul
 2026 09:45:38 +0800
Message-ID: <db71c3a2-43d9-458f-8cbf-e682338a33d8@huawei.com>
Date: Tue, 28 Jul 2026 09:45:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v6 3/4] bpf: Fix potential UAF when reading bpf link
 info
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Pu Lehui
	<pulehui@huaweicloud.com>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amery Hung
	<ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Mykyta
 Yatsenko <mykyta.yatsenko5@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song
	<yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Jiri Olsa
	<jolsa@kernel.org>
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
 <20260722072326.1545677-4-pulehui@huaweicloud.com>
 <CAEf4BzYFQ6wiDwz=3pyvDpr_UcSAOTygMq9pPVsJ=15CaGbA2Q@mail.gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <CAEf4BzYFQ6wiDwz=3pyvDpr_UcSAOTygMq9pPVsJ=15CaGbA2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/28 7:15, Andrii Nakryiko wrote:
> On Wed, Jul 22, 2026 at 12:19 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> In bpf_link_show_fdinfo and bpf_link_get_info_by_fd, link->prog is
>> accessed without holding any locks. If the prog is concurrently replaced
>> via bpf_link_update, the old prog can be freed, leading to a potential
>> UAF issue.
>>
>> Before dereferencing the prog, both normal RCU and RCU Tasks Trace read
> 
> no, either one is enough (and that's why we wait for RCU and RCU Tasks
> Trace grace periods, to make sure that both kinds of accesses work).
> This paragraph is misleading, just drop it.

ok

> 
>> locks would normally be required, as BPF_LINK_TYPE_ITER supports both
>> non-sleepable and sleepable progs. However, as commit 57b23c0f612d
>> ("bpf: Retire rcu_trace_implies_rcu_gp()") clarifies, an RCU Tasks Trace
>> grace period implies an RCU grace period, so holding only
>> rcu_read_lock() is already sufficient.
>>
>> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Reviewed-by: Amery Hung <ameryhung@gmail.com>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   kernel/bpf/syscall.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 6db306d23b47..cad986807d53 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3471,9 +3471,10 @@ static const char *bpf_link_type_strs[] = {
>>   static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>>   {
>>          const struct bpf_link *link = filp->private_data;
>> -       const struct bpf_prog *prog = link->prog;
>> +       const struct bpf_prog *prog;
>>          enum bpf_link_type type = link->type;
>>          char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
>> +       u32 prog_id;
> 
> can be read uninitialized (if link->prog is null), initialize to zero

will send new

> 
> pw-bot: cr
> 
> 
>>
>>          if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
>>                  if (link->type == BPF_LINK_TYPE_KPROBE_MULTI)
>> @@ -3490,13 +3491,20 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
>>          }
>>          seq_printf(m, "link_id:\t%u\n", link->id);
>>
>> +       rcu_read_lock();
>> +       prog = READ_ONCE(link->prog);
>>          if (prog) {
>>                  bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
>> +               prog_id = prog->aux->id;
>> +       }
>> +       rcu_read_unlock();
>> +
>> +       if (prog) {
>>                  seq_printf(m,
>>                             "prog_tag:\t%s\n"
>>                             "prog_id:\t%u\n",
>>                             prog_tag,
>> -                          prog->aux->id);
>> +                          prog_id);
>>          }
>>          if (link->ops->show_fdinfo)
>>                  link->ops->show_fdinfo(link, m);
>> @@ -5535,6 +5543,7 @@ static int bpf_link_get_info_by_fd(struct file *file,
>>   {
>>          struct bpf_link_info __user *uinfo = u64_to_user_ptr(attr->info.info);
>>          struct bpf_link_info info;
>> +       const struct bpf_prog *prog;
>>          u32 info_len = attr->info.info_len;
>>          int err;
>>
>> @@ -5549,8 +5558,12 @@ static int bpf_link_get_info_by_fd(struct file *file,
>>
>>          info.type = link->type;
>>          info.id = link->id;
>> -       if (link->prog)
>> -               info.prog_id = link->prog->aux->id;
>> +
>> +       rcu_read_lock();
>> +       prog = READ_ONCE(link->prog);
>> +       if (prog)
>> +               info.prog_id = prog->aux->id;
>> +       rcu_read_unlock();
>>
>>          if (link->ops->fill_link_info) {
>>                  err = link->ops->fill_link_info(link, &info);
>> --
>> 2.34.1
>>
