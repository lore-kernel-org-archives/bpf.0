Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAED433BF
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009608; cv=none; b=hK2JWKQ4YAWb0qNnqyAvtYlu6FPrBz+KFJUCzBN6u9FWUZz1MqiemLVTCMPg374gYQ8ILcv8GlYj14r/elnKIomXnfffWhiBoxqPEoHnYTwx8MXOdhKhwHFFYk30BoFUUQCaQp5FAiHMYyeklk/yIj1WJX3+aZZV9gNDodtcumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009608; c=relaxed/simple;
	bh=Gq2G9WmQB1sPfcnHKSskMF2yZQoskC/VEwYohApjYpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoH+tvGrPx0NeoCvMN0QHB9qApIR21bE+00Rmvq5IN0+4FX3ZXMZnQLhQPwtliybHK1Fw0PnCy1Yl4tqVv7Ze5x4Sf5+iuQkQTUTN8s7ZIhGdQrvF0RgEyZx/q01aYo0CM1w9Ic0w3FFNyUQ+Py4onDGTKXD34t9HINxoWXUc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TQoWKGhm; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TQoWKGhm"
Message-ID: <c8c7968e-79f8-47ec-b549-025af95ff895@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710009602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d301d2m3XDvxeh+akGWbgzGVsCoHY8gOYz/lNFtWHIw=;
	b=TQoWKGhm5C//gZsmffhD16ar/68c54m8RhVAk4AS48mThExV9bUk1xaI0fMQcyZX8JkrKm
	do+8Co52LJq5hID79B2DhSvmKbgeV5Y6VXkjzfcup4Fjz12fUCgL7WViZEA07dqSoFvGK9
	x/RXHxq5vvF3KEYVkf2PgK9GdntSGDs=
Date: Sat, 9 Mar 2024 10:39:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/5] bpf: Allow helper
 bpf_get_ns_current_pid_tgid() in cgroup and sk_msg programs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Yury Namgung <ynamgung@meta.com>
References: <20240307232659.1115872-1-yonghong.song@linux.dev>
 <20240307232705.1116787-1-yonghong.song@linux.dev>
 <CAEf4Bzb+=OyvTtqwu_q1ouY7dcNVm=uD5rpYohAqGdjFBQntKQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bzb+=OyvTtqwu_q1ouY7dcNVm=uD5rpYohAqGdjFBQntKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/8/24 5:06 PM, Andrii Nakryiko wrote:
> On Thu, Mar 7, 2024 at 3:27 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Currently bpf_get_current_pid_tgid() is allowed in tracing, cgroup
>> and sk_msg progs while bpf_get_ns_current_pid_tgid() is only allowed
>> in tracing progs.
>>
>> We have an internal use case where for an application running
>> in a container (with pid namespace), user wants to get
>> the pid associated with the pid namespace in a cgroup bpf
>> program. Currently, cgroup bpf progs already allow
>> bpf_get_current_pid_tgid(). Let us allow bpf_get_ns_current_pid_tgid()
>> as well.
>>
>> With auditing the code, bpf_get_current_pid_tgid() is also used
>> by sk_msg prog. So I added bpf_get_ns_current_pid_tgid()
>> support for sk_msg prog, so now for all places where
>> bpf_get_current_pid_tgid() can be used, bpf_get_ns_current_pid_tgid()
>> can be used as well.
>>
> If tracing can call both bpf_get_current_pid_tgid() and
> bpf_get_ns_current_pid_tgid(), can't we just add both into
> bpf_base_func_proto() and have them available for all types of BPF
> programs? If it's safe for tracing, it's safe for any program type, so
> why not?

Do we need any capability to control bpf_get_[ns_]current_pid_tgid()?
nothing or CAP_BPF or CAP_PERFMON? In my opinion, pid/tgid
is available to user space and there is no leaking kernel private
data here, so bpf prog should be able to use it in all prog types.
I will wait for a few days. If no people object, I will incorporate
this in v2.

>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/cgroup.c | 2 ++
>>   net/core/filter.c   | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 5a568bbbeaeb..375b92204881 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -2577,6 +2577,8 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>                  return &bpf_get_current_uid_gid_proto;
>>          case BPF_FUNC_get_current_pid_tgid:
>>                  return &bpf_get_current_pid_tgid_proto;
>> +       case BPF_FUNC_get_ns_current_pid_tgid:
>> +               return &bpf_get_ns_current_pid_tgid_proto;
>>          case BPF_FUNC_get_current_comm:
>>                  return &bpf_get_current_comm_proto;
>>   #ifdef CONFIG_CGROUP_NET_CLASSID
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 8adf95765cdd..d4e43303a66b 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -8344,6 +8344,8 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>                  return &bpf_get_current_uid_gid_proto;
>>          case BPF_FUNC_get_current_pid_tgid:
>>                  return &bpf_get_current_pid_tgid_proto;
>> +       case BPF_FUNC_get_ns_current_pid_tgid:
>> +               return &bpf_get_ns_current_pid_tgid_proto;
>>          case BPF_FUNC_sk_storage_get:
>>                  return &bpf_sk_storage_get_proto;
>>          case BPF_FUNC_sk_storage_delete:
>> --
>> 2.43.0
>>
