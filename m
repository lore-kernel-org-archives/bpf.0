Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752C44C89
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117539; cv=none; b=CHWOuu/4NZrcKctJ2VPYgvtKaIz4uWYa4pN4EGssfD09+Zjb1XR0J9qCl7JUGKsHaZAhiAoZEJjJL4iTysckpHjlKI29EKbwEQ5kIQRo0q5q0FQ33ynUojCKzEkMEXtxIV0O+7U/wgdBmyQQYVhfwAdN0BWjnjmyQTja/sA2E2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117539; c=relaxed/simple;
	bh=VtQBT66t2c1TD6mMlG56Go+Ca6yL4crmvVUH7JbH1bo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=shcLwYNDZGId5G8bFFK9nx6RgT/gne0YR+yPiovy2e1XziUAbf/2giTzaqiXTFVCkv4fuaGxjEa6zVNYwtwQYl8xurk8+VVBMpA156UNhGjj1kpCA8QbG+96EAUMwuaYepNvzWpbkihdD+5XErC0abbCQLrWPPs2P20+L2xu/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aS1FuKY0; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aS1FuKY0"
Message-ID: <f47e011b-6a02-40a1-aab1-f8c98b66d2d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711117534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TG5XExd178wk0rcdwkdD/DT5rtRSyEyBtmqTXjoUf+U=;
	b=aS1FuKY0cushN3PC9X3aD9HlDuxBTf+B6j6RNBVhn94TkeporcP4Al29KurfK1JowBCTNh
	O2vAp8CNRtG3NdxCgK1f+ZLNb8DEnLm2BqwT1dHJs7vgHzKQXJzbtEOc9S6G7styUOkCyV
	yGF1pfoRU5zw6tkSOKo1S3ZGVELadx4=
Date: Fri, 22 Mar 2024 07:25:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky test
 btf_map_in_map/lookup_update
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240322050716.357983-1-yonghong.song@linux.dev>
In-Reply-To: <20240322050716.357983-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/21/24 10:07 PM, Yonghong Song wrote:
> Recently, I frequently hit the following test failure:
>
>    [root@arch-fb-vm1 bpf]# ./test_progs -n 33/1
>    test_lookup_update:PASS:skel_open 0 nsec
>    ...
>    test_lookup_update:PASS:sync_rcu 0 nsec
>    test_lookup_update:FAIL:map1_leak inner_map1 leaked!
>    #33/1    btf_map_in_map/lookup_update:FAIL
>    #33      btf_map_in_map:FAIL
>
> In the test, after map is closed and then after two rcu grace periods,
> it is assumed that map_id is not available to user space.
>
> But the above assumption cannot be guaranteed. After zero or one
> or two rcu grace periods in different siturations, the actual
> freeing-map-work is put into a workqueue. Later on, when the work
> is dequeued, the map will be actually freed.
> See bpf_map_put() in kernel/bpf/syscall.c.
>
> By using workqueue, there is no ganrantee that map will be actually
> freed after a couple of rcu grace periods. This patch removed
> such map leak detection and then the test can pass consistently.

Please ignore this one. There is another patch with the same subject later but
with one more change to fix compilation error. The reason is I send this
patch but forget to fold a simple fix in. I waited for half an hour but
the email didn't reach me or mailing list. I do not know what is going
and thought it may have some issues. So I amended the fix and send
another one. It looks like the other patch appeared in the mailing list
too.

>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   .../selftests/bpf/prog_tests/btf_map_in_map.c | 24 -------------------
>   1 file changed, 24 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
> index a8b53b8736f0..5d389eb16295 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
> @@ -102,30 +102,6 @@ static void test_lookup_update(void)
>   	CHECK(map1_id == 0, "map1_id", "failed to get ID 1\n");
>   	CHECK(map2_id == 0, "map2_id", "failed to get ID 2\n");
>   
> -	test_btf_map_in_map__destroy(skel);
> -	skel = NULL;
> -
> -	/* we need to either wait for or force synchronize_rcu(), before
> -	 * checking for "still exists" condition, otherwise map could still be
> -	 * resolvable by ID, causing false positives.
> -	 *
> -	 * Older kernels (5.8 and earlier) freed map only after two
> -	 * synchronize_rcu()s, so trigger two, to be entirely sure.
> -	 */
> -	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
> -	CHECK(kern_sync_rcu(), "sync_rcu", "failed\n");
> -
> -	fd = bpf_map_get_fd_by_id(map1_id);
> -	if (CHECK(fd >= 0, "map1_leak", "inner_map1 leaked!\n")) {
> -		close(fd);
> -		goto cleanup;
> -	}
> -	fd = bpf_map_get_fd_by_id(map2_id);
> -	if (CHECK(fd >= 0, "map2_leak", "inner_map2 leaked!\n")) {
> -		close(fd);
> -		goto cleanup;
> -	}
> -
>   cleanup:
>   	test_btf_map_in_map__destroy(skel);
>   }
