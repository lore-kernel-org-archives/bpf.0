Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1351DDF8
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666706; cv=none; b=n00cRJ9bvzBHKaPs5T7sINJHOLN6tOWnI7uxleCBupgaC79Jg2kuBzRlLPembt/2tEqegvKHfZguIyhGRGku7ILd5CVXJOr5u8NfjtepF0Qh0FTSN1cQSx3jB8J2EGky4TvY5ItEKLJe6ynrTuRVwVgwtf974cmTvGpRvTyrWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666706; c=relaxed/simple;
	bh=e9aVYnTOnGcN6zrtSN5qfXGhaQWyaZFsu9FTctZ/nRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqVkH7KhiRXjUquT7llNHtYjURWI1xM3qDHIlcDTFM4MbNlWb3lSQpLsnpH1vZulwKNRY96L+rYQgg8q/WuKmGoNUHyxJfaE27eS0+1zvfYAQ6c9PBZxbh3r6N9wGkCpqCisA1S8XaJ2z89xh3nJ2eOJYf34ZoFML9uCycmrRL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i9vCIiMn; arc=none smtp.client-ip=91.218.175.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i9vCIiMn"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e9aVYnTOnGcN6zrtSN5qfXGhaQWyaZFsu9FTctZ/nRg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789666700; v=1; x=1790271500;
 b=i9vCIiMnfNHBabvgWZFr5EPZfM8vipPZ33wBMz15I0vrrlseHwVmClAYlmnn+pTmWQYYJNOn
 UJyuklgJuhwrN5s+4WtQ/uYgoISrp2zvF2VHHWna75RiazVGKaUJxuKwUJyh/hHbXY1nA6JsLtH
 WawZ8oJvIALlFIRxzwmH+lf8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1fea18a0aeb1f819;
	Thu, 17 Sep 2026 17:38:20 +0000
X-Mizu-Trace-ID: 1fea18a0aeb1f819
X-Migadu-Flow: FLOW_OUT
Message-ID: <a8e31e06-8288-46c0-9f6c-9052e1d9707e@linux.dev>
Date: Thu, 17 Sep 2026 10:38:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 3/4] selftests/bpf: Test btf_dump rendering of
 decl_tags
To: Alan Maguire <alan.maguire@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
 <20260917012037.1396254-4-ihor.solodrai@linux.dev>
 <e4b680e7-5829-42c2-add1-f2b5199ff7b6@oracle.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <e4b680e7-5829-42c2-add1-f2b5199ff7b6@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/26 3:30 AM, Alan Maguire wrote:
> On 17/09/2026 02:20, Ihor Solodrai wrote:
>> Cover the decl tag rendering the previous patch added. One subtest
>> builds a BTF with every shape that renders, plus two that must not:
>>
>>  - a named record with both forms of tag
>>  - a typedef'd anonymous record, whose attribute precedes the declarator
>>  - a union
>>  - a record that also carries the derived packed attribute
>>  - an anonymous record inlined at a member
>>  - two records whose tags are added in reverse target order, which is
>>    what pins the sort: without it the earlier record loses its attribute
>>  - attributes on a var and on a func, which btf_dump never declares
>>
>> A second subtest appends types and attributes to a dumper that has
>> already run. Its last phase adds an attribute for a record emitted two
>> dumps earlier and checks nothing is rendered for it: an attribute is
>> part of the type, and btf_dump emits each definition once.
>>
>> A third covers members. A member attribute and a record one share a key
>> in the index, so it checks they do not leak into each other's position,
>> over a function pointer, an array and a bit-field - declarators the
>> attribute has to follow rather than precede.
>>
>> A fourth covers typedefs, including a typedef of an anonymous record
>> carrying three groups at once, binding to the member, the record and
>> the typedef.
>>
>> Switch test_ctx__dump_and_compare() to compare_text_to_expected()
>> while we are here.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> Small suggestion; while this test is great at exercising the btf dump
> internals, adding a bpftool btf dump test to prog_tests/bpftool_btf_dump.c
> might help illustrate the change end-to-end (if you're planning this
> as part of the work to eliminate the push/pop attributes feel free to
> ignore). Thanks!

Hi Alan. Thanks for taking a look.

Yes, that's exactly the plan. btf_dump.c contains tests for libbpf btf_dump
primitives, and bpftool_btf_dump.c is for bpftool format c.

So more tests coming soon, no worries.

> 
> 
>> ---
>>  .../selftests/bpf/prog_tests/btf_dump.c       | 343 +++++++++++++++++-
>>  1 file changed, 342 insertions(+), 1 deletion(-)
>>
>> [...]
>>  
> 

