Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5C5E3AF
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135416; cv=none; b=aRz/31pGUH+obGuHW0JVKrhx0K9WUcbOsR7O3aLzYCEaEIlGlskspE72h6odGD5/2CAnClppuOoveg/u6/VqUwmNLEYWU8Sb+ZPnf3gSM4mo0aJK3dEYCYrDjjjFh10Tm3wnd5d05F4UwmT8oMigIE4cYbcSwa7YaevtzP4Xbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135416; c=relaxed/simple;
	bh=/1/HNBY05kqHbegOjMsoOgs8qF3+TLtUcoDp1+/X7xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uu5fDmRBbwBcKZRw1QfkCqFJ3njyY2/iRs3KMDc3g8LkVFjUW0SofYagTl/xzORRs37cryyjD132GCJVAvZTk+p7f+12LiS+AKiFYi2NZXvRcwQoOhDpYc6HBwn2lc4oLdLu+CpCnafVM60NaKLOMLvRHYWnW+BN4WmQSvLa9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WAZd6fge; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WAZd6fge"
Message-ID: <3c052b53-021f-46ae-b26e-108bf3bdf565@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711135412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw65dILsnAqJZU7RUvEDxKiAX3kOBz8ms20tiz0fXXs=;
	b=WAZd6fge6LjD6s09fCMTBE0yag0VwLPsyKCjNz2SaPb9xE3jKtGLb/4ht2FrNYke3zfpiR
	cd39T9Jznm1JKjb0ADpbOYPnaJdy1SBWn5JCQvJ44jaxCHib4EP9aF/Q37d9WDwaeeZasm
	bjliz9M8aj/ULrYQA4VBxgiyx4OBMMs=
Date: Fri, 22 Mar 2024 12:23:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/6] libbpf: Add bpf_link support for
 BPF_PROG_TYPE_SK_{MSG,SKB}
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240319175401.2940148-1-yonghong.song@linux.dev>
 <20240319175417.2941417-1-yonghong.song@linux.dev>
 <CAEf4BzaYVG7dRMwrLWndem5XZr_r5doz+k3GHg8zsVuQ9HQhLg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzaYVG7dRMwrLWndem5XZr_r5doz+k3GHg8zsVuQ9HQhLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/22/24 11:48 AM, Andrii Nakryiko wrote:
> On Tue, Mar 19, 2024 at 10:54 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Introduce two libbpf API functions bpf_program__attach_sk_msg()
>> and bpf_program__attach_sk_skb() which allow user to get a bpf_link
>> for their corresponding programs.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c   | 14 ++++++++++++++
>>   tools/lib/bpf/libbpf.h   |  4 ++++
>>   tools/lib/bpf/libbpf.map |  2 ++
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 7d413415d0d5..1b8e1f47a5e6 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -149,6 +149,8 @@ static const char * const link_type_name[] = {
>>          [BPF_LINK_TYPE_TCX]                     = "tcx",
>>          [BPF_LINK_TYPE_UPROBE_MULTI]            = "uprobe_multi",
>>          [BPF_LINK_TYPE_NETKIT]                  = "netkit",
>> +       [BPF_LINK_TYPE_SK_MSG]                  = "sk_msg",
>> +       [BPF_LINK_TYPE_SK_SKB]                  = "sk_skb",
>>   };
>>
>>   static const char * const map_type_name[] = {
>> @@ -12493,6 +12495,18 @@ bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd)
>>          return bpf_program_attach_fd(prog, netns_fd, "netns", NULL);
>>   }
>>
>> +struct bpf_link *
>> +bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd)
>> +{
>> +       return bpf_program_attach_fd(prog, map_fd, "sk_msg", NULL);
>> +}
>> +
>> +struct bpf_link *
>> +bpf_program__attach_sk_skb(const struct bpf_program *prog, int map_fd)
>> +{
>> +       return bpf_program_attach_fd(prog, map_fd, "sk_skb", NULL);
>> +}
>> +
>>   struct bpf_link *bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex)
>>   {
>>          /* target_fd/target_ifindex use the same field in LINK_CREATE */
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 7b510761f545..4a2c04a9c6c3 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -784,6 +784,10 @@ bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_fd);
>>   LIBBPF_API struct bpf_link *
>>   bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd);
>>   LIBBPF_API struct bpf_link *
>> +bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd);
>> +LIBBPF_API struct bpf_link *
>> +bpf_program__attach_sk_skb(const struct bpf_program *prog, int map_fd);
>> +LIBBPF_API struct bpf_link *
>>   bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
>>   LIBBPF_API struct bpf_link *
>>   bpf_program__attach_freplace(const struct bpf_program *prog,
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 86804fd90dd1..11a1ad798129 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -410,6 +410,8 @@ LIBBPF_1.3.0 {
>>
>>   LIBBPF_1.4.0 {
>>          global:
>> +               bpf_program__attach_sk_msg;
>> +               bpf_program__attach_sk_skb;
> same suggestion, it seems like having a more generic
> bpf_program__attach_sockmap() or something along those lines would be
> better?

If we will have one link type, I think we should have one attach API
as well.

>
> please also see what changes need to be done in bpf_link_create() API

Will do.

>
>>                  bpf_token_create;
>>                  btf__new_split;
>>                  btf_ext__raw_data;
>> --
>> 2.43.0
>>
