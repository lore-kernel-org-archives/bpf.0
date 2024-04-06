Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C15C1BC46
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 05:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712380758; cv=none; b=mVgycdjMTTj6/ow1/IvfhkJIBMm172KQ1ZlIoPjpe/ozBiPVxyQcdRnBMvABJlPUsqimZX1riudo3Np8wn0PCdWzKtrkLjyIz9lPuTw+bwMvwoPhS5LKKGZgzCWn6KtXTVfQPUZ9skq91Y+tJ4AjaSne4zBNXpvkKfs3YltYs1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712380758; c=relaxed/simple;
	bh=k2NSs4cK+Bm4Qrs1VntDiYJq8I+I5/lWSP4xs5flUpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btVjtbECH0kFCsuv9OOasROqh+JQW5I1nj5+px+NoeCQsCDfpCAF3YIizDTVhM0QC9eeGNlDGmAXUVpI0v2U4T57+ThIYBf8hweUaXteDfOw+houT9RjiHoLkF2yV3JirlDwYT3wQBxHPk2xeMLbUe/QtfBsxDmZhmK1U/jiIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FLZL/GJL; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FLZL/GJL"
Message-ID: <fbb3102e-953c-4d4f-b781-3c677c33126a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712380753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdX4huv0L7kcRovvqjVvbFzQ6QYzizR0EprqJz845cg=;
	b=FLZL/GJL7EEsihMgHKG3q0hwIZa61VgAVWnzkCa6RWB6ALdHfD89bayR5pw9FeSzLuhHU7
	LvYOCk7VraeGUqeXu3FNHbNyPwAwSoPDagy2KpBgSlXzJiEO7in5QxISWoblYM66IQPOFV
	oR0FSnlJNqeLXcR/FTdhkyWmL66RlAY=
Date: Fri, 5 Apr 2024 22:19:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/5] libbpf: Add bpf_link support for
 BPF_PROG_TYPE_SOCKMAP
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20240404025305.2210999-1-yonghong.song@linux.dev>
 <20240404025316.2212069-1-yonghong.song@linux.dev>
 <CAEf4BzY-ekyrSs-Z7SXtWJtAgn4AoLfiVcYv6fip=9ay9a0obQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzY-ekyrSs-Z7SXtWJtAgn4AoLfiVcYv6fip=9ay9a0obQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/5/24 1:14 PM, Andrii Nakryiko wrote:
> On Wed, Apr 3, 2024 at 7:53 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Introduce a libbpf API function bpf_program__attach_sockmap()
>> which allow user to get a bpf_link for their corresponding programs.
>>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c         | 7 +++++++
>>   tools/lib/bpf/libbpf.h         | 2 ++
>>   tools/lib/bpf/libbpf.map       | 6 ++++++
>>   tools/lib/bpf/libbpf_version.h | 2 +-
>>   4 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index b091154bc5b5..97eb6e5dd7c8 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -149,6 +149,7 @@ static const char * const link_type_name[] = {
>>          [BPF_LINK_TYPE_TCX]                     = "tcx",
>>          [BPF_LINK_TYPE_UPROBE_MULTI]            = "uprobe_multi",
>>          [BPF_LINK_TYPE_NETKIT]                  = "netkit",
>> +       [BPF_LINK_TYPE_SOCKMAP]                 = "sockmap",
>>   };
>>
>>   static const char * const map_type_name[] = {
>> @@ -12533,6 +12534,12 @@ bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd)
>>          return bpf_program_attach_fd(prog, netns_fd, "netns", NULL);
>>   }
>>
>> +struct bpf_link *
>> +bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd)
>> +{
>> +       return bpf_program_attach_fd(prog, map_fd, "sockmap", NULL);
>> +}
>> +
>>   struct bpf_link *bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex)
>>   {
>>          /* target_fd/target_ifindex use the same field in LINK_CREATE */
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index f88ab50c0229..4c7ada03bf4f 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -795,6 +795,8 @@ bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_fd);
>>   LIBBPF_API struct bpf_link *
>>   bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd);
>>   LIBBPF_API struct bpf_link *
>> +bpf_program__attach_sockmap(const struct bpf_program *prog, int map_fd);
>> +LIBBPF_API struct bpf_link *
>>   bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
>>   LIBBPF_API struct bpf_link *
>>   bpf_program__attach_freplace(const struct bpf_program *prog,
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 51732ecb1385..015737439007 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -411,8 +411,14 @@ LIBBPF_1.3.0 {
>>   LIBBPF_1.4.0 {
>>          global:
>>                  bpf_program__attach_raw_tracepoint_opts;
>> +               bpf_program__attach_sockmap;
> leftover from the previous revision? please remove

Good catch. Thanks. will fix in the next revision.

>
> with that:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
>>                  bpf_raw_tracepoint_open_opts;
>>                  bpf_token_create;
>>                  btf__new_split;
>>                  btf_ext__raw_data;
>>   } LIBBPF_1.3.0;
>> +
>> +LIBBPF_1.5.0 {
>> +       global:
>> +               bpf_program__attach_sockmap;
>> +} LIBBPF_1.4.0;
>> diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
>> index e783a47da815..d6e5eff967cb 100644
>> --- a/tools/lib/bpf/libbpf_version.h
>> +++ b/tools/lib/bpf/libbpf_version.h
>> @@ -4,6 +4,6 @@
>>   #define __LIBBPF_VERSION_H
>>
>>   #define LIBBPF_MAJOR_VERSION 1
>> -#define LIBBPF_MINOR_VERSION 4
>> +#define LIBBPF_MINOR_VERSION 5
>>
>>   #endif /* __LIBBPF_VERSION_H */
>> --
>> 2.43.0
>>
