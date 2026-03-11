Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A7248F64
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247704; cv=none; b=Vpe+7Oa5pw3tAMhD0bDQGB0SmhpfGmtIvgj7jKNyIX4SnDtETkKziAx32txzSQ5kq52UgP087nVUBgS62MYzs0XY6eO+0MHXHHYm6qjh87mTd03tBChCTVrTMY5ctPMSK5jldR6Afcy8rO9q4g680GjGMEYIe+cPV8XcOB/1WyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247704; c=relaxed/simple;
	bh=pReUkV4SeH2h8nTwfRbxzqo/vh4eG6ODjoHdvYJrUGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWEG3l5T3UQ6TJtjrYbuLo0LpghXPHX46jMnfnpDiTymC56kLjwX+VCL1a3gb6Zl3tVwHd/3ChzFC8BBdMQxR4NA9WKTJQAmcVVbT2ZE0O7K42b+VKOk/JraElS/J7gp2rgjRQar3seQQgmeQDlzXn31cGDxjjZpNH9gw1Ogytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EktCaX6l; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EktCaX6l"
Message-ID: <2bb9d226-8301-4a70-b7d9-325b57d584e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773247700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6ebaNTH3hH1rZowsBK/0/QCDARWB17fiDWIQEVw+ng=;
	b=EktCaX6lqFwu61VK7bRLPE4TX/iY16EKOAs7mZNbkBu7RB6/a8zpdqkORx5chlwiqeQlCA
	y0gvM3eVSG/RsXI3hzSKeBuZNzNZZz949d89AUUf4WY69GH+tyr4eKN00XI3V1At98ee4Y
	rZNZEAV2PJRGwNGnQmLKs7fu2fCK/U8=
Date: Wed, 11 Mar 2026 09:48:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add LINK_DETACH support for perf
 link
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Florian Lehner <dev@der-flo.net>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260304210212.235096-2-dev@der-flo.net>
 <c860945b84fb9b75ec9eb0299a4cab36c3afb69e9da90bab3d71c780e8cf18b4@mail.kernel.org>
 <CAP01T76=Am0SMkURBtcXKAm+uouMKR55ZbnzJC12heOwYuYs4w@mail.gmail.com>
 <CAADnVQKFpDhFUWnB+noVr6SEn9B3K1L0s3XY3v_cLsYq9ni1HA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKFpDhFUWnB+noVr6SEn9B3K1L0s3XY3v_cLsYq9ni1HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/5/26 7:59 PM, Alexei Starovoitov wrote:
> On Thu, Mar 5, 2026 at 7:39 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> On Wed, 4 Mar 2026 at 23:01, <bot+bpf-ci@kernel.org> wrote:
>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>> --- a/kernel/bpf/syscall.c
>>>> +++ b/kernel/bpf/syscall.c
>>>> @@ -3863,10 +3863,23 @@ struct bpf_perf_link {
>>>>   static void bpf_perf_link_release(struct bpf_link *link)
>>>>   {
>>>>        struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
>>>> -     struct perf_event *event = perf_link->perf_file->private_data;
>>>> +     struct perf_event *event;
>>>> +     struct file *perf_file;
>>>> +
>>>> +     /* bpf_perf_link_detach() may have already released perf_file */
>>>> +     perf_file = xchg(&perf_link->perf_file, NULL);
>>>> +     if (!perf_file)
>>>> +             return;
>>>> +
>>>> +     event = perf_file->private_data;
>>>>        perf_event_free_bpf_prog(event);
>>>> -     fput(perf_link->perf_file);
>>>> +     fput(perf_file);
>>>> +}
>>> [ ... ]
>>>
>>>> @@ -4075,9 +4088,13 @@ static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
>>>>   {
>>>>        struct bpf_perf_link *perf_link;
>>>>        const struct perf_event *event;
>>>> +     struct file *perf_file;
>>>> +
>>>>        perf_link = container_of(link, struct bpf_perf_link, link);
>>>> -     event = perf_get_event(perf_link->perf_file);
>>>> +     perf_file = READ_ONCE(perf_link->perf_file);
>>>> +     if (!perf_file)
>>>> +             return 0;
>>>> +     event = perf_get_event(perf_file);
>>> Could bpf_perf_link_fill_link_info() race with bpf_perf_link_release()
>>> here?
>>>
>>> After READ_ONCE reads a non-NULL perf_file, no reference is taken on
>>> the file.  A concurrent BPF_LINK_DETACH on another CPU can call
>>> bpf_perf_link_release(), which does xchg() followed by fput().  If
>>> the perf event fd has already been closed by userspace, fput() drops
>>> the last reference.  Once the detaching thread returns to userspace,
>>> task_work runs __fput and frees the file struct.
>>>
>>> At that point perf_get_event() dereferences file->f_op on freed
>>> memory:
>>>
>>>    Thread A (BPF_OBJ_GET_INFO_BY_FD)      Thread B (BPF_LINK_DETACH)
>>>    --------------------------------       --------------------------
>>>    perf_file = READ_ONCE(...)  [non-NULL]
>>>                                           xchg(&..., NULL)
>>>                                           fput(perf_file)
>>>                                           return to userspace
>>>                                           task_work -> __fput -> free
>>>    perf_get_event(perf_file) -> UAF
>>>
>>> The xdp and cgroup link types handle this by serializing
>>> fill_link_info and release under a shared lock (rtnl_lock and
>>> cgroup_lock respectively):
>>>
>>> kernel/bpf/cgroup.c:bpf_cgroup_link_fill_link_info() {
>>>      cgroup_lock();
>>>      if (cg_link->cgroup)
>>>          cg_id = cgroup_id(cg_link->cgroup);
>>>      cgroup_unlock();
>>> }
>>>
>>> net/core/dev.c:bpf_xdp_link_fill_link_info() {
>>>      rtnl_lock();
>>>      if (xdp_link->dev)
>>>          ifindex = xdp_link->dev->ifindex;
>>>      rtnl_unlock();
>>> }
>>>
>>> The same issue applies to bpf_perf_link_show_fdinfo() below.
>>>
>>>> @@ -4143,9 +4160,13 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
>>>>   {
>>>>        struct bpf_perf_link *perf_link;
>>>>        const struct perf_event *event;
>>>> +     struct file *perf_file;
>>>> +
>>>>        perf_link = container_of(link, struct bpf_perf_link, link);
>>>> -     event = perf_get_event(perf_link->perf_file);
>>>> +     perf_file = READ_ONCE(perf_link->perf_file);
>>>> +     if (!perf_file)
>>>> +             return;
>>>> +     event = perf_get_event(perf_file);
>>> Same race as bpf_perf_link_fill_link_info() above -- a concurrent
>>> BPF_LINK_DETACH can free perf_file between the READ_ONCE and the
>>> perf_get_event() call.
>> AI is correct, but is not proposing a fix, so I will try to be helpful.
>> I think we can add per-link spin lock, so that operations on the same
>> link are serialized.
>> You can do the perf_file replacement in release under the lock, and
>> call the rest of the stuff (perf_event_free.., fput) outside the lock.
>> On the show_fdinfo and fill_link_info side, you will under the
>> protection of the spin lock, read the perf_file and take a reference
>> on it using get_file.
>> Then you can release the lock and use it for the callback and fput on
>> the way out.
>>
>> Other cases are unaffected since they are already under lock
>> protection. I think a global lock is also an option, but I would lean
>> toward having a 4-byte spin lock in the bpf_link itself.
> I would just do a global mutex and avoid the complexity.
> fdinfo could be doing a bunch of work.

The following is an example using mutex lock:

https://lore.kernel.org/r/20240410043527.3737160-1-yonghong.song@linux.dev

