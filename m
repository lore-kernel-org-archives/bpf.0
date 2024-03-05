Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4579DC2
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623486; cv=none; b=VHWJ6gi9Gjjz96GhuU/bw7HorZfD6tJWS1rFgBHFwOmp5FlHgKVeZ1UAliFVnMuc1E9+seNJZHSCOEYoUC22xMd1gZ3ZBh70X12P1eatgG9sxVhjfFad/evv+eI+xmrNXVT6nqPPV2dMWofYGo4R+oexBdEkQX4BkKaQcUywbrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623486; c=relaxed/simple;
	bh=dXFHzu3yYyoM+rgrS1hlDWzdsbl3W3ca7bgU3r+GxUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cri+T8AMJ/8oxbZv5Ar76KLa1RZ0aD0gep4b3fL4WKBTMbDuoCrD7ZyU5ciusR0bV2nhAkQvJQ39/Oz5ITtlCQPT9ssJ3BaMGbV0eyJ2w6PIlhZeSYPYuYPtmQm1yxORGYm/k8zXbz911CFS2JjQ4GDMnk2cauoX9nlXWbav0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QHVvluwu; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QHVvluwu"
Message-ID: <a6b6765a-6570-48de-8a2a-87fd890c80a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709623482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQ97KGcOnPJh+MnvZcWDgmlqSXZWFttlmTc/852d6l4=;
	b=QHVvluwurjxqK2e4X361sgmmvTk3s9pbM2huCrwvEj6pDb0HdQ/j3xMlDhvOoemJ3oUwau
	UlEX/lTLEZyaZTym+60fI5mcrxN8+YGJkIs67M2n/4yV+n7ajpUzrf9klW/wh77eyarvdi
	eOAGSauCOMhdWMlQSwzGjpeOES7dRGg=
Date: Mon, 4 Mar 2024 23:24:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Fix possible ksyms test
 failure with LTO kernel
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240302165017.1627295-1-yonghong.song@linux.dev>
 <20240302165033.1628421-1-yonghong.song@linux.dev>
 <CAADnVQK1RTkyT-87=43WuJk+69mO8eK58AXojRvCYFHKD8V3ow@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQK1RTkyT-87=43WuJk+69mO8eK58AXojRvCYFHKD8V3ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/4/24 9:37 PM, Alexei Starovoitov wrote:
> On Sat, Mar 2, 2024 at 8:50 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> In my locally build clang LTO kernel (enabling CONFIG_LTO and
>> CONFIG_LTO_CLANG_THIN), ksyms test failed like:
>>    test_ksyms:PASS:kallsyms_fopen 0 nsec
>>    test_ksyms:FAIL:ksym_find symbol 'bpf_link_fops' not found
>>    #118     ksyms:FAIL
>>
>> The reason is that 'bpf_link_fops' is renamed to
>>    bpf_link_fops.llvm.8325593422554671469
>> Due to cross-file inlining, the static variable 'bpf_link_fops'
>> in syscall.c is used by a function in another file. To avoid
>> potential duplicated names, the llvm added suffix '.llvm.<hash>'.
>>
>> To fix the failure, we can skip this test with LTO kernel
>> if the symbol 'bpf_link_fops' is not found in kallsyms.
>>
>> After this patch, with the same LTO kernel:
>>    #118     ksyms:SKIP
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/ksyms.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
>> index e081f8bf3f17..cd81f190c5d7 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
>> @@ -21,7 +21,11 @@ void test_ksyms(void)
>>                  return;
>>          }
>>          if (err == -ENOENT) {
>> -               ASSERT_TRUE(false, "ksym_find for bpf_link_fops");
>> +               /* bpf_link_fops might be renamed to bpf_link_fops.llvm.<hash> in LTO kernel. */
>> +               if (check_lto_kernel() == 1)
>> +                       test__skip();
>> +               else
>> +                       ASSERT_TRUE(false, "ksym_find for bpf_link_fops");
> I'm afraid LTO breakage is bigger than this.
> pid_iter program as part of bpftool is using bpf_link_fops too.
> I suspect that part of bpftool feature is broken on LTO kernel.
> We need to find a solution instead of 'skip' a selftest.

Thanks for pointing this out! Let me do some investigation on
how to resolve this.

