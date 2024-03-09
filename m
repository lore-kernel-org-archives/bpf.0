Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B01716FF30
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710010165; cv=none; b=Wb2Q/hGxFx9Ywp82jMIJJ+17LpYweqwIGqN0Y7bDfFRUAXRDPd5UasFovktXw+LN5bEOkutBHXJRhm6FqzejfJcZzUfyCz0euEBSD5sZuNf6iP0pIFmc9DCV2UrqifhMs5JtHmV57HNTq3gnyn+6aayF301LfLfYm7S0gnok5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710010165; c=relaxed/simple;
	bh=AtjnkuDPhyzJ9hv8tYsc3KfPD12AakcFBpK35eyJx1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQmYgrC0UsH8vNJs1dTZGqMWpn2OCYA05eu8EZkvkzXGAjB1U4MZL/0yFtf5ptszJHv0rfnkIOUfSgHF8nqFRCFXn7FVPx52Z1SmBqwtJ2WNkYRxjuwm231i3ffzjoDZTBiRDa+lmNv2BcKuLep5Kjs/rPtozm+OwkWkZrJrXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e2Xiw9oC; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e2Xiw9oC"
Message-ID: <dff48e21-8603-427f-a05d-b9bd5775ce09@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710010159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0m/FaUCbrdjYlnF9K07bFL4auVDCdDMNEmgwJGtOw4=;
	b=e2Xiw9oCylvWl+cMjHcJc1Ha2vqG7wnEg1se66474v2a1IjjOkmQsfNaZUSjBi7P3+kPnq
	TP/flfDhmNxiP5ZiyPqqRxff/eIhnZZfwmP1g6U9ZGdkDSgQRQm45IcIuIQ2/hNd8MTbse
	pwsdZFM6e3Z4lS1BMescsJCjvqfzKgk=
Date: Sat, 9 Mar 2024 10:49:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 3/5] libbpf: Add link support for
 BPF_PROG_TYPE_SK_MSG
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
 <20240305202211.3891663-1-yonghong.song@linux.dev>
 <CAEf4Bzb1TpvMU8V9PrO9j35H=z4j4bqvdVGE2JfF4gGzVnGGPA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bzb1TpvMU8V9PrO9j35H=z4j4bqvdVGE2JfF4gGzVnGGPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/8/24 5:01 PM, Andrii Nakryiko wrote:
> On Tue, Mar 5, 2024 at 12:22 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Introduce a libbpf API bpf_program__attach_sk_msg() which allows
>> user to get a bpf_link. The API makes auto-deletion easier and
>> also allows user space application easier as link based APIs
>> are used for all programs.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c   | 8 ++++++++
>>   tools/lib/bpf/libbpf.h   | 3 +++
>>   tools/lib/bpf/libbpf.map | 1 +
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 97b573516675..b3982bb3f979 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -149,6 +149,7 @@ static const char * const link_type_name[] = {
>>          [BPF_LINK_TYPE_TCX]                     = "tcx",
>>          [BPF_LINK_TYPE_UPROBE_MULTI]            = "uprobe_multi",
>>          [BPF_LINK_TYPE_NETKIT]                  = "netkit",
>> +       [BPF_LINK_TYPE_SK_MSG]                  = "sk_msg",
>>   };
>>
>>   static const char * const map_type_name[] = {
>> @@ -12280,6 +12281,13 @@ bpf_program__attach_netkit(const struct bpf_program *prog, int ifindex,
>>          return bpf_program_attach_fd(prog, ifindex, "netkit", &link_create_opts);
>>   }
>>
>> +struct bpf_link *
>> +bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd,
>> +                          enum bpf_attach_type attach_type)
> Why do we need to allow users to override attach_type? Why can't it
> come from bpf_program's expected attach type?

The interface is similar to previously used bpf_prog_attach(), but you are
right that this may not be needed. Let me double check.

>
>> +{
>> +       return __bpf_program_attach_fd(prog, map_fd, attach_type, "sk_msg", NULL);
>> +}
>> +
>>   struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
>>                                                int target_fd,
>>                                                const char *attach_func_name)
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 5723cbbfcc41..c8448f05e8d6 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -786,6 +786,9 @@ bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd);
>>   LIBBPF_API struct bpf_link *
>>   bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
>>   LIBBPF_API struct bpf_link *
>> +bpf_program__attach_sk_msg(const struct bpf_program *prog, int map_fd,
>> +                          enum bpf_attach_type attach_type);
>> +LIBBPF_API struct bpf_link *
>>   bpf_program__attach_freplace(const struct bpf_program *prog,
>>                               int target_fd, const char *attach_func_name);
>>
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 86804fd90dd1..c59986c6dbc5 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -410,6 +410,7 @@ LIBBPF_1.3.0 {
>>
>>   LIBBPF_1.4.0 {
>>          global:
>> +               bpf_program__attach_sk_msg;
>>                  bpf_token_create;
>>                  btf__new_split;
>>                  btf_ext__raw_data;
>> --
>> 2.43.0
>>
