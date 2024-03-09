Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2964836E
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709942691; cv=none; b=NnpX8wDomBT7U78TVdDYAmH84WzO3/KwHXIOTSPGrHAe9T4/askSMZQBjAVWllb0WdnJEJyNlEANfvZxZ/ZpoqatsskrbzGKeaShXYthgN5tDHNTV977n8/7Xe9bHGngrxKvLD5GrZCghxMoQC8kX3JFUKWmmidgfA/R23OsNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709942691; c=relaxed/simple;
	bh=ODy2J85YKLzDB8bH97wmW29wek0RPwFHEjk1waRoUf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0hK+noPLzNtp9aMl1aTAcJ5PUNa8M+2nLuPu9rxFa9ewyc9bynSXXzhWoBULbeK72fNIHN2wOnmmjL/HMrut7UojqVueacGI8moOYLjO99Sh1D00hFt8czdo7P4aDeLlxgNf9ACSGoGVYxhcOLWy2iAYIwvNPuSh2g/ePYTAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AYKYbXlZ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AYKYbXlZ"
Message-ID: <ff89127f-2c2c-42db-948f-74d524243fc4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709942686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KO7R+RQhqQop540c9zRooIFQapEF86a1tlckoU4bej8=;
	b=AYKYbXlZJLANFCspUX45wQHaN2r+3/bQ9ML/6mFzRrxGb6eCuJ/miAUmeaqPcS+nRAbLOQ
	ewlQ8ijKWKPrxtZuqSJJOjXfrD+qQek+7Dgt1ZRflCGTDx5FlEwJek8nA6lJl6VeXlCmnW
	kOKK2RNNiekMqJHJxG+9FgMk+uAjg5I=
Date: Fri, 8 Mar 2024 16:04:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add a cgroup prog
 bpf_get_ns_current_pid_tgid() test
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Yury Namgung <ynamgung@meta.com>,
 bpf@vger.kernel.org
References: <20240307232659.1115872-1-yonghong.song@linux.dev>
 <20240307232721.1117597-1-yonghong.song@linux.dev>
 <83a6001f-8ed4-4e31-92bd-282c34e6782f@linux.dev>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <83a6001f-8ed4-4e31-92bd-282c34e6782f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/8/24 11:08 AM, Martin KaFai Lau wrote:
> On 3/7/24 3:27 PM, Yonghong Song wrote:
>> Add a cgroup bpf program test where the bpf program is running
>> in a pid namespace. The test is successfully:
>>    #165/3   ns_current_pid_tgid/new_ns_cgrp:OK
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../bpf/prog_tests/ns_current_pid_tgid.c      | 54 +++++++++++++++++++
>>   .../bpf/progs/test_ns_current_pid_tgid.c      |  7 +++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c 
>> b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
>> index 847d7b70e290..a307303e01ee 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
>> @@ -12,6 +12,7 @@
>>   #include <sys/wait.h>
>>   #include <sys/mount.h>
>>   #include <sys/fcntl.h>
>> +#include "network_helpers.h"
>>     #define STACK_SIZE (1024 * 1024)
>>   static char child_stack[STACK_SIZE];
>> @@ -74,6 +75,50 @@ static int test_current_pid_tgid_tp(void *args)
>>       return ret;
>>   }
>>   +static int test_current_pid_tgid_cgrp(void *args)
>> +{
>> +    struct test_ns_current_pid_tgid__bss *bss;
>> +    struct test_ns_current_pid_tgid *skel;
>> +    int server_fd = -1, ret = -1, err;
>> +    int cgroup_fd = *(int *)args;
>> +    pid_t tgid, pid;
>> +
>> +    skel = test_ns_current_pid_tgid__open();
>> +    if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open"))
>> +        return ret;
>> +
>> +    bpf_program__set_autoload(skel->progs.cgroup_bind4, true);
>> +
>> +    err = test_ns_current_pid_tgid__load(skel);
>> +    if (!ASSERT_OK(err, "test_ns_current_pid_tgid__load"))
>> +        goto cleanup;
>> +
>> +    bss = skel->bss;
>> +    if (get_pid_tgid(&pid, &tgid, bss))
>> +        goto cleanup;
>> +
>> +    skel->links.cgroup_bind4 = bpf_program__attach_cgroup(
>> +        skel->progs.cgroup_bind4, cgroup_fd);
>> +    if (!ASSERT_OK_PTR(skel->links.cgroup_bind4, 
>> "bpf_program__attach_cgroup"))
>> +        goto cleanup;
>> +
>> +    server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
>
> nit. This binds to ADDR_ANY. Regardless, it is a good idea to create a 
> netns for this subtest. It will be one less thing to worry about when 
> removing "serial_" from this test eventually. The same for the subtest 
> in patch 5 also.

Good point. Will do.


>
>> +    if (!ASSERT_GE(server_fd, 0, "start_server"))
>> +        goto cleanup;
>> +
>> +    if (!ASSERT_EQ(bss->user_pid, pid, "pid"))
>> +        goto cleanup;
>> +    if (!ASSERT_EQ(bss->user_tgid, tgid, "tgid"))
>> +        goto cleanup;
>> +    ret = 0;
>> +
>> +cleanup:
>> +    if (server_fd >= 0)
>> +        close(server_fd);
>> +    test_ns_current_pid_tgid__destroy(skel);
>> +    return ret;
>> +}
>> +
>>   static void test_ns_current_pid_tgid_new_ns(int (*fn)(void *), void 
>> *arg)
>>   {
>>       int wstatus;
>> @@ -102,4 +147,13 @@ void serial_test_ns_current_pid_tgid(void)
>>           test_current_pid_tgid_tp(NULL);
>>       if (test__start_subtest("new_ns_tp"))
>> test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_tp, NULL);
>> +    if (test__start_subtest("new_ns_cgrp")) {
>> +        int cgroup_fd = -1;
>
> nit. no need to "= -1;"
Ack. My mistake. Will change.
>
> Other patches lgtm.
>
>> +
>> +        cgroup_fd = test__join_cgroup("/sock_addr");
>> +        if (ASSERT_GE(cgroup_fd, 0, "join_cgroup")) {
>> + test_ns_current_pid_tgid_new_ns(test_current_pid_tgid_cgrp, 
>> &cgroup_fd);
>> +            close(cgroup_fd);
>> +        }
>> +    }
>>   }
>> diff --git 
>> a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c 
>> b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
>> index aa3ec7ca16d9..d0010e698f66 100644
>> --- a/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
>> +++ b/tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c
>> @@ -28,4 +28,11 @@ int tp_handler(const void *ctx)
>>       return 0;
>>   }
>>   +SEC("?cgroup/bind4")
>> +int cgroup_bind4(struct bpf_sock_addr *ctx)
>> +{
>> +    get_pid_tgid();
>> +    return 1;
>> +}
>> +
>>   char _license[] SEC("license") = "GPL";
>
