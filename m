Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F56C2AD1E
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077247; cv=none; b=DJ8YQkcIguiOmmawiIDCm0dLmZjU77eXQ+NRI7sMbtNp5atgwJtAyZi4kr/R0DLaYGcBgfXHJkzikFnw4YmlLGVXbLoMKxUxij/lHppNMevF57gMfmWLAcpZHfl0eW+eDeUkQ9aL1EPn2sni3ijUCKdEzBIP5BckVJWgRWh/BF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077247; c=relaxed/simple;
	bh=8WGidp2+o7OAPMmYKcgetxE57A5skajZUGxwI9N2KgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cnu+hmKQqwizH658ukPGAXa5B3thkiW0Z6rKj/SmDnKtGuyQPTXQ+j03GwvaWRZmLzOz0Lptov5KoTg1VLMAXxPo8Wh+nWzLNXBpf81d3Gc9eCfwYGb6ikxD7YXEky2/vKEY0JrZ/J7c1MqNpuB5QMDx3qsjV4Wpe9P4RlW3hPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX18R6MK; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX18R6MK"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61448d00c59so29201787b3.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712077245; x=1712682045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDPhNjh8MN0xcsxYPOrVYubvSKhJkMnk3hhlgVfW984=;
        b=ZX18R6MK5Tph7IBPHc008W7cUwYnVqSzReZBQ6Zii2x5YwVdckX22dg5sQ7kOzYR+k
         s6PQlhB95s+Ez7+nrEJcnQP2wdGzoIatJh2LIQiJdXNZnI40C9TAoTLxw95re2ILVi17
         8dwFuBGfIWXB4FIloie4bRFvjECaF1cKfUWCDtvZRh9umlP40XkljFLs+0Z8n8JnMcCe
         z3DRyfNqQ2puZ/UT+YfKv1AxHPrVbLY5pI75sb5tWJUNoefj6DOSZUmm+k8vbeAD6Jh2
         1kmyad1rW365EsBG+v0k/gP5WG/FjEtxuCzP8RXKfLT83znhaLVHpDB+4OWWH53eFPhK
         07yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712077245; x=1712682045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDPhNjh8MN0xcsxYPOrVYubvSKhJkMnk3hhlgVfW984=;
        b=Q6jUHN0AJ2Kb30kBtXM5xN3uF9QnFJCCDJ3SM1SRSsIUVawN8CgX4eM9d+XLkNqf8j
         PHDbeZS8RtTLtOjKpAoKMODAqxQonieKN2xpneZNbeLq0MQL2pyU2M6XK7rawodENERf
         fO2hRiEWEb3wg8dphL7d6VBY8qLybzkvzj/zAQmfSwMR9MU6omaraSQuP/vPa1nA4IgH
         RHN2HneE6vN8tkOqOhVUD1DPDoiS0EBbXWa1202aY6ECxa3UH31mvv7HXhaNySGA9D9t
         BgDopex1s9e2UKnMCFmD3fN79ZsoFn5Pfzi91FkDOkZwNS6TryAnPd6DNToGAn4z1Cex
         pVYg==
X-Forwarded-Encrypted: i=1; AJvYcCVsaB3W28B/yTpgjtZCpsztkzp54HHi8gdKpnVgOk2kz3w8HQP5zrEh5U/r71kP9yKzHuKO8pj6JMPIEgYlRDMpJB+i
X-Gm-Message-State: AOJu0Yz/jTQepUE/OMBGNbKEpOGcXXsUHDjR7eG+LwtsxVRlPyO/E3Vs
	oKtcTWmT1y3N/J1JnLEJl7vRqwGS0GV6slHKSdWpfjpLRk6LG+Qs
X-Google-Smtp-Source: AGHT+IHV789qOROkPcitB6JwL+Qv5L0SA+QMuaQq2PcGeBWBs+iyPYDZRlBuc4yDG0Z88exswOlH2w==
X-Received: by 2002:a0d:e88e:0:b0:615:10f8:124a with SMTP id r136-20020a0de88e000000b0061510f8124amr3878781ywe.29.1712077244915;
        Tue, 02 Apr 2024 10:00:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f74e:a682:a411:777d? ([2600:1700:6cf8:1240:f74e:a682:a411:777d])
        by smtp.gmail.com with ESMTPSA id i15-20020a81be0f000000b00608876ed731sm2871310ywn.126.2024.04.02.10.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 10:00:44 -0700 (PDT)
Message-ID: <cf7c6aaa-123b-43b2-8c7b-2c1e2b2dcb67@gmail.com>
Date: Tue, 2 Apr 2024 10:00:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Make sure libbpf doesn't enforce
 the signature of a func pointer.
To: John Fastabend <john.fastabend@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240401223058.1503400-1-thinker.li@gmail.com>
 <660b62aed55f5_801520863@john.notmuch>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <660b62aed55f5_801520863@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 4/1/24 18:43, John Fastabend wrote:
> Kui-Feng Lee wrote:
>> The verifier in the kernel checks the signatures of struct_ops
>> operators. Libbpf should not verify it in order to allow flexibility in
>> loading different implementations of an operator with different signatures
>> to try to comply with the kernel, even if the signature defined in the BPF
>> programs does not match with the implementations and the kernel.
>>
>> This feature enables user space applications to manage the variations
>> between different versions of the kernel by attempting various
>> implementations of an operator.
> 
> What is the utility of this? I'm missing what difference it would be
> if libbpf rejected vs kernel rejecting it? For backwards compat the
> kernel will fail or libbpf might throw an error and user will have to
> fixup signature regardless right? Why not get the error as early as
> possible.

The check described here is that libbpf compares BTF types of functions
and function pointers in struct_ops types in BPF programs, which may
differ from kernel definitions.

A scenario here is a struct_ops type that includes an operator op_A with
different versions depending on the kernel. All other fields in the
struct_ops type have the same types. The application has only one
definition for this struct_ops type, but the implementation of op_A is
done separately for each version.

The application can try variations by assigning implementations to the
op_A field until one is accepted by the kernel if libbpf doesn’t enforce
signatures. Otherwise, the application has to define this struct_ops
type for each variant if libbpf enforces signatures.

Does that make sense to you?

> 
>>
>> This is a follow-up of the commit c911fc61a7ce ("libbpf: Skip zeroed or
>> null fields if not found in the kernel type.")
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   .../bpf/prog_tests/test_struct_ops_module.c   | 24 +++++++++++++++++++
>>   .../selftests/bpf/progs/struct_ops_module.c   | 13 ++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> index 098776d00ab4..7cf2b9ddd3e1 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> @@ -138,11 +138,35 @@ static void test_struct_ops_not_zeroed(void)
>>   	struct_ops_module__destroy(skel);
>>   }
>>   
>> +/* The signature of an implementation might not match the signature of the
>> + * function pointer prototype defined in the BPF program. This mismatch
>> + * should be allowed as long as the behavior of the operator program
>> + * adheres to the signature in the kernel. Libbpf should not enforce the
>> + * signature; rather, let the kernel verifier handle the enforcement.
>> + */
>> +static void test_struct_ops_incompatible(void)
>> +{
>> +	struct struct_ops_module *skel;
>> +	struct bpf_link *link;
>> +
>> +	skel = struct_ops_module__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +		return;
>> +
>> +	link = bpf_map__attach_struct_ops(skel->maps.testmod_incompatible);
>> +	if (ASSERT_OK_PTR(link, "attach_struct_ops"))
>> +		bpf_link__destroy(link);
>> +
>> +	struct_ops_module__destroy(skel);
>> +}
>> +
>>   void serial_test_struct_ops_module(void)
>>   {
>>   	if (test__start_subtest("test_struct_ops_load"))
>>   		test_struct_ops_load();
>>   	if (test__start_subtest("test_struct_ops_not_zeroed"))
>>   		test_struct_ops_not_zeroed();
>> +	if (test__start_subtest("test_struct_ops_incompatible"))
>> +		test_struct_ops_incompatible();
>>   }
>>   
>> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
>> index 86e1e50c5531..63b065dae002 100644
>> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
>> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
>> @@ -68,3 +68,16 @@ struct bpf_testmod_ops___zeroed testmod_zeroed = {
>>   	.test_1 = (void *)test_1,
>>   	.test_2 = (void *)test_2_v2,
>>   };
>> +
>> +struct bpf_testmod_ops___incompatible {
>> +	int (*test_1)(void);
>> +	void (*test_2)(int *a);
>> +	int data;
>> +};
>> +
>> +SEC(".struct_ops.link")
>> +struct bpf_testmod_ops___incompatible testmod_incompatible = {
>> +	.test_1 = (void *)test_1,
>> +	.test_2 = (void *)test_2,
>> +	.data = 3,
>> +};
>> -- 
>> 2.34.1
>>
>>
> 
> 
