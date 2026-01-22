Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB913C0883
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117302; cv=none; b=Wwl2Z4dCej0g+qXB4ge0PXugzcKPPUqxAFsWvI20Vla4tS97kc5jvW2+Vk1wHpUdpQ/kGy09nwgxF8Wm+m3unmsPnzjoZZNvfml4swOA/UxVeFZGjPbvjhtAvc9OAUrn8wgYTYeqIt8exu+m/l6uYQ2pztrQTie5c7YTmHWs0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117302; c=relaxed/simple;
	bh=lqMtq74LqEMpeRrst1Zwf/b9YGce6Q/qFp14tV0qKc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNhg6QgRLq5q7g0RUeocLLxAxjIhgeqQvSaZHeCZnn0/UwQoypXdRhoMk0n++zP0uZ9d5RxaYIS5Gmx5tUQfjASY/N4JOwnS03+r2dvAl4tmdkFderpFLV0Tb3qQEubJqhh3typfzBIR6yEmz4Ri1WMjExPI6JUP9mOgw4/zFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pV8c8sNA; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pV8c8sNA"
Message-ID: <4a41cc0f-e409-478f-ad71-103de63cfacb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769117293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1sh+9KhIreTIihfzat2Ijx895fJhZ1M1Yv78rApw7o=;
	b=pV8c8sNASHy2vzhH2AKUoiRbtgtzc6VATnqzCtwwjsTq/QzQi7+ejqSd4mP9/OhOz0ahLq
	VNAt2Vp2g4c7fks2GhM2VmN4zFjqvdlwhRzgbaOkG8spf7x+7sBNkWTDrPFDL67yTHsfhJ
	2azgoYks9CkWNhJmt3MbG8elxkfi/r8=
Date: Thu, 22 Jan 2026 13:28:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Fix xdp_pull_data failure
 with 64K page
Content-Language: en-GB
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>
References: <20260122162616.3578898-1-yonghong.song@linux.dev>
 <20260122162621.3579387-1-yonghong.song@linux.dev>
 <CAMB2axP_AaoiZB9BSQ3Mz_M0e0t1S-y3u8KnBx1FY1nCq3qN6Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAMB2axP_AaoiZB9BSQ3Mz_M0e0t1S-y3u8KnBx1FY1nCq3qN6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/22/26 1:18 PM, Amery Hung wrote:
> On Thu, Jan 22, 2026 at 8:56 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> If the argument 'pull_len' of run_test() is 'PULL_MAX' or
>> 'PULL_MAX | PULL_PLUS_ONE', the eventual pull_len size
>> will close to the page size. On arm64 systems with 64K pages,
>> the pull_len size will be close to 64K. But the existing buffer
>> will be close to 9000 which is not enough to pull.
>>
>> For those failed run_tests(), make buff size to
>>    2 * pg_sz + (pg_sz / 2)
>> This way, there will be enough buffer space to pull
>> regardless of page size.
>>
>> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>> Cc: Amery Hung <ameryhung@gmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../testing/selftests/bpf/prog_tests/xdp_pull_data.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> Changelog:
>>   v1 -> v2:
>>     - v1: https://lore.kernel.org/bpf/20260120210930.2544950-1-yonghong.song@linux.dev/
>>     - Use pg_sz to simplify buff_len calculation.
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>> index efa350d04ec5..35f0eb5b43f3 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>> @@ -114,12 +114,14 @@ static void test_xdp_pull_data_basic(void)
>>   {
>>          u32 pg_sz, max_meta_len, max_data_len;
>>          struct test_xdp_pull_data *skel;
>> +       int buff_len;
>>
>>          skel = test_xdp_pull_data__open_and_load();
>>          if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
>>                  return;
>>
>>          pg_sz = sysconf(_SC_PAGE_SIZE);
>> +       buff_len = 2 * pg_sz + pg_sz / 2;
> Thanks for fixing the test. Just curious if there is an issue with 1.5
> pg_sz as suggested by Alan?

Yes. It works fine with 1.5 pg_sz too. I picked '2 * pg_sz + pg_sz / 2'
as for 4K page, 9000 will have 2 frags and I intend to maintain
2 frags for the tests.

>
>>          if (find_xdp_sizes(skel, pg_sz))
>>                  goto out;
>> @@ -140,13 +142,13 @@ static void test_xdp_pull_data_basic(void)
>>          run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1025, 1025);
>>
>>          /* multi-buf pkt, empty linear data area, pull requires memmove */
>> -       run_test(skel, XDP_PASS, pg_sz, 9000, 0, 0, PULL_MAX);
>> +       run_test(skel, XDP_PASS, pg_sz, buff_len, 0, 0, PULL_MAX);
>>
>>          /* multi-buf pkt, no headroom */
>> -       run_test(skel, XDP_PASS, pg_sz, 9000, max_meta_len, 1024, PULL_MAX);
>> +       run_test(skel, XDP_PASS, pg_sz, buff_len, max_meta_len, 1024, PULL_MAX);
>>
>>          /* multi-buf pkt, no tailroom, pull requires memmove */
>> -       run_test(skel, XDP_PASS, pg_sz, 9000, 0, max_data_len, PULL_MAX);
>> +       run_test(skel, XDP_PASS, pg_sz, buff_len, 0, max_data_len, PULL_MAX);
>>
>>          /* Test cases with invalid pull length */
>>
>> @@ -154,7 +156,7 @@ static void test_xdp_pull_data_basic(void)
>>          run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
>>
>>          /* multi-buf pkt with no space left in linear data area */
>> -       run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
>> +       run_test(skel, XDP_DROP, pg_sz, buff_len, max_meta_len, max_data_len,
>>                   PULL_MAX | PULL_PLUS_ONE);
>>
>>          /* multi-buf pkt, empty linear data area */
>> @@ -165,7 +167,7 @@ static void test_xdp_pull_data_basic(void)
>>                   PULL_MAX | PULL_PLUS_ONE);
> We should also change these two cases above to use buff_len to make
> sure we are testing the right logic in bpf_xdp_pull_data().

Sure. Will do. Replacing 9000 with buff_len for those two cases
works okay too for both x86 and 64-page arm64.

>
>>          /* multi-buf pkt, no tailroom */
>> -       run_test(skel, XDP_DROP, pg_sz, 9000, 0, max_data_len,
>> +       run_test(skel, XDP_DROP, pg_sz, buff_len, 0, max_data_len,
>>                   PULL_MAX | PULL_PLUS_ONE);
>>
>>   out:
>> --
>> 2.47.3
>>
>>

