Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDB161
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712102838; cv=none; b=Vgw0P/ialXfrUV75spgDpjh/F4CuOmFh6FBH35GjIzkFlPFbaPM1RcIaRA5/aknLltVyxnhdRQ6f+m3RPljBsWhD+SXJGscOKrjvLlvHIcNJBa6Qc5sAqLX8FSLDvzk4sCEODf/1aFFUOGayHG/1CeTHiMd2Qmp2ufKllPM2kMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712102838; c=relaxed/simple;
	bh=D/xFnrVD2iU4B/TGsAR0bWfXfqAc/0y01M5m4Ic5lOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYCe7oDTX4plC96bL5tWSGzg2qn9YRk3FHO4bqmbDhsvh4lptFhere4lxle3s8nCVr8fUXCmdRwzl9QAqlWhfHHIj6IKAznwQnsUNpdHeKjml2FCSCuvnojtgyKRZb0+rj6QgWlk9LiypcxHHIw9zQQ3XE44zb3H3FTur82HkTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YfXNQI+Y; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YfXNQI+Y"
Message-ID: <7bf0406f-962a-4bd9-9f5e-d530825fb8d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712102834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsPDjwW5fMv1Zl0OBZ7Dn69/LCFtpqrkq4Yym8IMq0E=;
	b=YfXNQI+YymIjb4T4tRhnqs5yRXQjyLPSJIw/D2f8RTxJSzgtewSips7g/c37xxp9Mbkzl2
	Uv93h6ULo2fvM2fqDS1/lnRvotunzEBpRE1JCAbfi4xZP+zqDdrTWiX6n8o0bjpJJjN4QF
	YbPmFqwluEq+1seUq2n7TsZkAHtoLVs=
Date: Tue, 2 Apr 2024 17:07:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/5] libbpf: Add bpf_link support for
 BPF_PROG_TYPE_SOCKMAP
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022203.656793-1-yonghong.song@linux.dev>
 <CAEf4BzZg3_D68dsb=SSasBewZ661rsZSusqoGtRQ6DDJUC-L4w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZg3_D68dsb=SSasBewZ661rsZSusqoGtRQ6DDJUC-L4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/2/24 10:46 AM, Andrii Nakryiko wrote:
> On Mon, Mar 25, 2024 at 7:22 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Introduce a libbpf API function bpf_program__attach_sockmap()
>> which allow user to get a bpf_link for their corresponding programs.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c   | 7 +++++++
>>   tools/lib/bpf/libbpf.h   | 2 ++
>>   tools/lib/bpf/libbpf.map | 1 +
>>   3 files changed, 10 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 8eb2cd4ef288..e1bb9ba3d1a5 100644
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
>> @@ -12507,6 +12508,12 @@ bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd)
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
>> index 51732ecb1385..2e5c3429b974 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -411,6 +411,7 @@ LIBBPF_1.3.0 {
>>   LIBBPF_1.4.0 {
>>          global:
>>                  bpf_program__attach_raw_tracepoint_opts;
>> +               bpf_program__attach_sockmap;
> we are now in 1.5 development cycle, for next revision please put it
> into a new section

Ack. will do.

>
>>                  bpf_raw_tracepoint_open_opts;
>>                  bpf_token_create;
>>                  btf__new_split;
>> --
>> 2.43.0
>>
