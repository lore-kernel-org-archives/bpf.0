Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B93D4109
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317156; cv=none; b=JfdMq/BSumEDiChBxfDELv5ktFHxB0jU35fwkHHgmhMrfx84PCemRjV4V9ytWUtyCwauc0nhMlDkF0JxrkShnBDxQXFBrGRrNO7KnLRIiy2QNAhd7L9W0VcikIV+l3TBoe5l8DXJ23ccIvPU7wN9cADtFbXAMi3O+3+1VMAT6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317156; c=relaxed/simple;
	bh=yDsqQH5BbiO+PW6zzUX2oUUyXOo83ndu0xMlDz0uCHM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jnpcy+B0R/r32c1DKWEHodVISkiGSbF0FgGrRbMBKBvB0X0XJVdppnU5zWlV1FeUZaAbyzhCZ2Q7P8tURw5wdZMlDpbTPBOaogeDQrUHzIiqFXzZHn1qt6rO3M5AfN7+oSEQC6f8tGfuueCsj7TLMw0RC9RlD+DFkHSwVfwJBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=gNjVDkLa; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="gNjVDkLa"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb39f64348so317486385a.0
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 14:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772317154; x=1772921954; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgUvB7vchkbEExheWs0hP4qVVuHRRrf4mV32RUQg+58=;
        b=gNjVDkLaskYBiaTKcWpjprc4lBdhxWBwQZzPik/wDvijrAOW+BVffXTsgGDbT9wW+N
         r867rQOe4152DbAPl+n5ZP22Yz33YpunpyJSxDY8X65clixVQfv9yzi97Vf6iXP8WSFj
         PUJvxLhlPM4oW/gNSwFm9BR/X5POrh/NETBbadh9ib3tF02ogq+AJ1nYQ5wawCsnP9vS
         RwsGQxKqkMl/6Q2Q9E2GIQbY0dyGKYF/8jZ3e8lqK3jRA24DFJxHrnBLHfbramnUB+uG
         jZbZUZxkGgdmyT+p4nCr5ujF7nLjp3mVtFydQLzuRmzcbytAXJUaFdFOQMW949+okzZD
         VI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317154; x=1772921954;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgUvB7vchkbEExheWs0hP4qVVuHRRrf4mV32RUQg+58=;
        b=M2zRkxx1lpSK5t34rRmBCj6tTG7AFg0RRB8WNdqHljWhWIGHr9ZO79/WAbt0TwZPJT
         EqVzebDzITXyXm8TUx7OzDNUMt3VYel1n0TyGNKquMG1WoTRcmam9U+FLU1KxMJGxLI1
         0z2uNDEAb3t8d19AXSkgb5P6aQiuMxf3Hk99d8zEzvcF6QqSOx8KbT+YAxsXsre0Xjd3
         9GpltSyzg42xW6cRx5T8GKyWmkzhTabc1A42rfe5oBRV0FOZms5urXKJKa3Vf1WlAUak
         eDdYVhLaT5L4Wqkd9H+p5SsxA19sPUn57BXyYpAWdnfQ4oIluDwEgLNy/oaMV609Jclm
         YHdg==
X-Forwarded-Encrypted: i=1; AJvYcCVLu0N+1Tkm6yjctQrrGXVEKXDj8xP42WMMBCglGncvMTEUgIqgi5MZW5LIzZW9/oILuLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwusnpeKrZ8+zTQ4tyuNL2XQHOeLeAV6b5bWsLjCEFpDSPBgJ6g
	28UEJJdtGKVwSvk1aZ7ioSNYW170/chrWpX13TbCPKK5F5H3DUIFGBYC8pZQQjJQ2ky8t6KUNnx
	PxB7b4rQ=
X-Gm-Gg: ATEYQzx3yQfGTMmyEIxF7qFnrO6H1CpJthh/MwXcHlD7/OhFB+HcqFtSVBt+IuoREc+
	YX3FTZNtWJ9mzJloPN7lL2CHjehqb1CMKOqmy4HQpCF7hzFbiwFneWZsWMY+oI3j9Mj/WKeH9jd
	FEht6mGPJqK7suH5skKoysFherHBzbcZnuR1hDZVbRIwXJhCBwbBChOnnaJnlowdlSV2UT+H/J6
	nFZ4AKDRKSgJYwirZonZhIgOqVLwxZKgNNDJt3rVCKVFHydWg+yW3c90bUMHOPuFugg8SbMB91K
	Lij2OZxHgAVVQ/HrDjd5ctH3CdXuuXJ8XCEMSTzyeuCJOAEwkgGxubn5SeHNHfUEh7ndE7LDpfn
	UYGovBs5ngpE6yvLCUG9xjffaJwCbCxat8AjBHHz/oXONexS32jS5cxCbYtn4V/XfVytRxi3z+g
	aM1gr0Cp3cGl65HvY4FFvKuyUrChWqXXD5ZQ==
X-Received: by 2002:a05:620a:2849:b0:8cb:4d64:e972 with SMTP id af79cd13be357-8cbc8d70f45mr790715885a.9.1772317153551;
        Sat, 28 Feb 2026 14:19:13 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f9905sm783702585a.28.2026.02.28.14.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 14:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Feb 2026 17:19:11 -0500
Message-Id: <DGQXZVBSVEUP.35P5G9QOL9EAT@etsalapatis.com>
Cc: "Hui Zhu" <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v3 0/3] Fix test_cgroup_iter_memcg issues found
 during back-porting
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, "Hui Zhu" <hui.zhu@linux.dev>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "JP Kobryn" <inwardvessel@gmail.com>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <cover.1772261955.git.zhuhui@kylinos.cn>
 <DGQWV6Z1YV14.1I11KQX54LSOQ@etsalapatis.com>
In-Reply-To: <DGQWV6Z1YV14.1I11KQX54LSOQ@etsalapatis.com>

On Sat Feb 28, 2026 at 4:26 PM EST, Emil Tsalapatis wrote:
> On Sat Feb 28, 2026 at 2:11 AM EST, Hui Zhu wrote:
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> While back-porting "mm: bpf kfuncs to access memcg data", I
>> encountered issues with test_cgroup_iter_memcg, specifically
>> in test_kmem.
>>
>> These patches are my fixes for the problems I encountered.
>>
>
> Nit: Could you be a bit more descriptive about the series' contents?
> Cover letters normally focus on what what the patch does - for example
> the issues being found during backporting is not pertinent to the patchse=
t=20
> itself, because the issues are still present on bpf-next.
>

Also, responded on v3 instead of v4 sorry about that. Comments and
tags still apply since the only delta is in the commit message.

>> Changelog:
>> v3:
>> According to the comments of JP Kobryn, remove kmem subtest from
>> cgroup_iter_memcg and fix assertion string in test_pgfault.
>> v2:
>> According to the comments of JP Kobryn, added bpf_core_enum_value()
>> usage in the BPF program to handle cross-kernel enum value differences
>> at load-time instead of compile-time.
>> Dropped the mm/memcontrol.c patch.
>> Modified test_kmem handling: instead of skipping when nokmem is set,
>> verify that kmem value is zero as expected.
>> According to the comments of bot, fixed assertion message: changed
>> "bpf_mem_cgroup_page_state" to "bpf_mem_cgroup_vm_events" for PGFAULT
>> check.
>>
>> Hui Zhu (3):
>>   selftests/bpf: Remove kmem subtest from cgroup_iter_memcg
>>   bpf: Use bpf_core_enum_value for stats in cgroup_iter_memcg
>>   selftests/bpf: Check bpf_mem_cgroup_page_state return value
>>
>>  .../testing/selftests/bpf/cgroup_iter_memcg.h |  2 -
>>  .../bpf/prog_tests/cgroup_iter_memcg.c        | 38 +++++--------------
>>  .../selftests/bpf/progs/cgroup_iter_memcg.c   | 18 ++++++---
>>  3 files changed, 22 insertions(+), 36 deletions(-)

