Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9C15AAAA
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084189; cv=none; b=m8h2PZhi1/EcL/FQLCibligM2DHUZJ4sJX8fq2Z9uWrhsQZpzM8NqGfOP3vzhT7Sb74DlXcRoCbIR1fSMp/ceZioGWuJTpvsKFTDR6wfTyfF6eO+uvyle1dI+74aCLPloaij74WWM5DKbP6GFYrrb7gUmM52hKX4//fte3ivwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084189; c=relaxed/simple;
	bh=gKNlCx3HThapNXjWTL/QFKMAycc1MD7oliVbY3+AbOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHfQZF4Wvnex2t+4GMlfYK9K6+xQ5+rog0wWccMBChRpYdS4ae8vG0tolmFC/qnsp4jrv4pX35ePDjn/1rbRVadO2r/aaC8iQ+p/9MKeMjGtXK5vgoPteuNXLA78Vd1I2YyyXi+l/5ZhhbIHmabnkPl8zBMYll1FZvvS3NsPpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h1epThm5; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h1epThm5"
Message-ID: <635a4cbc-0d7b-438b-8de6-6df1bec99539@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712084185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3XnAHDVrQkIn4EHrviHIWervRc2u4AGdrqh05A1rSM=;
	b=h1epThm5MxHsFuJVtu8B+D+RoVcBua/jWizW7Wj4MLKF15va+ho3JXvO67q/I72LbfyHxT
	Y6bQ+YPqsLkqZjU3MP0XEFZQiqRe6NeVe6WQNpRhRnID6XjrLluNgGoS3/cHLEqy3X1IbG
	AndRe9cDO9Cb+LJ+y9YtcGJRb8JJE1s=
Date: Tue, 2 Apr 2024 11:56:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: Add some tests with new
 bpf_program__attach_sockmap() APIs
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Sitnicki
 <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022219.657808-1-yonghong.song@linux.dev>
 <2befbceb5be18eeee6f3376a1bf5b2d795beec53.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2befbceb5be18eeee6f3376a1bf5b2d795beec53.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/2/24 6:17 AM, Eduard Zingerman wrote:
> On Mon, 2024-03-25 at 19:22 -0700, Yonghong Song wrote:
>> Add a few more tests in sockmap_basic.c and sockmap_listen.c to
>> test bpf_link based APIs for SK_MSG and SK_SKB programs.
>> Link attach/detach/update are all tested.
>>
>> All tests are passed.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> As far as I understand patch #1 there are several error conditions
> that are not covered by these tests:
> - update link using program with wrong expected attach type;
> - bpf_program__attach_sockmap() _after_ bpf_prog_attach();
> - creation of a second link between same prog and map
>    (if I understand 'link && link != progs->msg_parser_link' checks in
>     sock_map_link_lookup() correctly).
>
> Are these important enough to have a dedicated test?

All these are missed. I can add them in the next revision.

>
> [...]
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>> index 63fb2da7930a..b4b38f92b864 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>> @@ -131,6 +131,40 @@ static void test_skmsg_helpers(enum bpf_map_type map_type)
>>   	test_skmsg_load_helpers__destroy(skel);
>>   }
>>   
>> +static void test_skmsg_helpers_with_link(enum bpf_map_type map_type)
>> +{
>> +	struct test_skmsg_load_helpers *skel;
>> +	struct bpf_link *link, *link2;
>> +	struct bpf_program *prog;
>> +	int err, map;
>> +
>> +	skel = test_skmsg_load_helpers__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "test_skmsg_load_helpers__open_and_load"))
>> +		return;
>> +
>> +	prog = skel->progs.prog_msg_verdict;
>> +	map = bpf_map__fd(skel->maps.sock_map);
>> +
>> +	link = bpf_program__attach_sockmap(prog, map);
>> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
>> +		goto out;
>> +
>> +	err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_MSG_VERDICT, 0);
>> +	if (!ASSERT_ERR(err, "bpf_prog_attach"))
>> +		goto out;
>> +
>> +	link2 = bpf_program__attach_sockmap(skel->progs.prog_msg_verdict_clone, map);
>> +	if (!ASSERT_ERR_PTR(link2, "bpf_program__attach_sockmap"))
>> +		goto out;
> Nit: should bpf_link__detach(link2) be called before 'goto out' ?

Yes, we should do this although it will auto detach when test_progs exists.

>
>> +
>> +	err = bpf_link__update_program(link, skel->progs.prog_msg_verdict_clone);
>> +	ASSERT_OK(err, "bpf_link__update_program");
>> +
>> +out:
>> +	bpf_link__detach(link);
>> +	test_skmsg_load_helpers__destroy(skel);
>> +}
>> +
>>   static void test_sockmap_update(enum bpf_map_type map_type)
>>   {
>>   	int err, prog, src;
