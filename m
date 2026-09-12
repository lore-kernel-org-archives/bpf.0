Received: from mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3F722D7A9
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789180462; cv=none; b=W3kQJ8pPuAsAwA18bCsq5zbRGoPrb+OZvKZyEmxk+nhr7c7EkzmduklMzfrZkHdGmXJifh+Unh4SqoAE9p383YGpvrrChKJorD79jcW+egqLvp2xi4QxUTjguLx+yiR7vvZgNdgRKnGghzIHlIHM9ed/nQa7akEI7OsVLJuEPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789180462; c=relaxed/simple;
	bh=zSQjQvhYOnGzd7hAHQuCLG2FK3IiuJqAjJQXsA/SV0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t89iwDLwgdO7Gb6QerY77OwJwZMNlbDwmijBt4NUyhHuisfmC8bF71E2TDBpis0Njk3re3HkMYHzcQzQNzXVUKlmNiFYEPIIdUI+OKx+18PRhxA0MZzCfBQt57j6U0HKZ8pX7C80AMm/1fzdt237uZnIMU1AR/d40QjeJsQysN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gu+OiJpN; arc=none smtp.client-ip=91.218.175.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gu+OiJpN"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zSQjQvhYOnGzd7hAHQuCLG2FK3IiuJqAjJQXsA/SV0k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789180457; v=1; x=1789785257;
 b=Gu+OiJpN2Y4aAJimyke5Wz7QRMHHuqlPGo1mOy0/7ki/0w/3YanZiZ4Tet4GXL3KxqsjiWGn
 mF+SuMExHtl5hKJiT/9pjHpzmQG2FhlUg1ywQUdS41eGJ85Ect93ale97zeifVNljmp66R7y2OB
 Rlms/X6pxEitNY1ywe0BdOH8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2018c4a972a27159;
	Sat, 12 Sep 2026 02:34:17 +0000
X-Mizu-Trace-ID: 2018c4a972a27159
X-Migadu-Flow: FLOW_OUT
Message-ID: <649ddc23-81b1-40e0-87aa-ff0821a33c34@linux.dev>
Date: Sat, 12 Sep 2026 10:34:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add xdp_shrink_frags
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260911135711.109338-1-jiayuan.chen@linux.dev>
 <20260911135711.109338-3-jiayuan.chen@linux.dev>
 <20260911144631.A7A4C1F000FF@smtp.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260911144631.A7A4C1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/26 10:46 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Type punning a byte array into a struct pointer violates strict aliasing rules.
> --
>
> commit 7d6829eaaf619b188a1baf1e3f7bf91fc5a0a765
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> selftests/bpf: add xdp_shrink_frags
>
> This commit adds a BPF selftest for XDP that shrinks fragments and
> triggers a page_pool leak on a generic XDP path. The test exercises
> test_tun, test_veth, and test_veth_tx to cover different data path
> behaviors on 4K pages.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
>> new file mode 100644
>> index 0000000000000..ee8f9034a2684
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
> [ ... ]
>> +static void test_tun(struct xdp_shrink_frags *skel)
>> +{
>> +	__u8 head[74], frag1[2048], frag2[2048];
>> +	struct ethhdr *eth = (void *)head;
>> +	int tap_fd = -1, ifindex, err;
>> +	struct netns_obj *ns = NULL;
>> +	struct iovec iov[3];
>> +	ssize_t n;
> [ ... ]
>> +	memset(head, 0, sizeof(head));
>> +	memset(frag1, 0x41, sizeof(frag1));
>> +	memset(frag2, 0x42, sizeof(frag2));
>> +	eth->h_proto = htons(ETH_P_IP);
> [Severity: Medium]
> Does this code violate strict aliasing rules by type-punning a byte array
> into a struct pointer?
>
> When test_tun() executes, it accesses an object declared as an array of
> characters (__u8) through an unrelated larger struct pointer (struct ethhdr *).


I don't think there is anything wrong with

     struct foo *ptr = (struct foo *)binary


it's a pretty normal thing to do, and other tests in the same directory 
do exactly the same:

     prog_tests/xdp_context_test_run.c

     __u8 pkt[...];

     struct ethhdr *eth = (void *)pkt;

     struct ipv6hdr *ip6 = (void *)(eth + 1);

     ....


Not sure why the AI complains about this one.


> Since this code is located in a test program running in user space (under
> tools/), standard -fstrict-aliasing rules apply.
>
> Could the compiler assume that eth does not alias head, leading it to reorder
> or drop the write to eth->h_proto entirely during optimization?
>
>> +
>> +	iov[0].iov_base = head;  iov[0].iov_len = sizeof(head);
>> +	iov[1].iov_base = frag1; iov[1].iov_len = sizeof(frag1);
>> +	iov[2].iov_base = frag2; iov[2].iov_len = sizeof(frag2);
> [ ... ]
>
