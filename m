Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9525742F
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769625121; cv=none; b=hAwGFORS9AbzPhFuySS1rmQajFkzHgamiiKCvmQrUfmOUyJuFvbthnishJ0FZoEqeRVfL+sU9TsceTpzpgU+G6DxSGnoWKjwxCoxkL9QsHrhiWCV/gwi7JmoQpQk+XYMoBWF3dT9ZnpQsWBfI/JpLWBZCvTGSYwNRYihfzG86iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769625121; c=relaxed/simple;
	bh=3dWg42ZrPACJiyNOeDxatkh0EH8GzeFbVbMY2uhpCMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLOAMKGcJ0IrwmA++drRyiKPG8zg37FEbC0lhKHKIxzsyl1nG7Tyc3mWd++YOM/1e2rZ9JxnhFlrCrdMF1OWTIFe98+KHZd/4iVPtAvyPAnwKnOLhdCvW134VvIbPWnL3N4hhpbdVyVsf9APmMTzMIc/ufvSpyO82LG3bawG+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/4W7Cnh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/4W7Cnh"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432d256c2e6so166738f8f.3
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 10:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769625118; x=1770229918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOpcbsJqzx5BFg4CCMHidiY0+KPvr9io+iqkXaknWDA=;
        b=C/4W7CnhZDXZ0VyuM0dpyoHJzObJ1flBKqhdfMxHy6EGNCO2PrtBnqDB1YIX+FB8YG
         ZyNu1VC9vy+M1JJz3Azy8hfYGDBLEe00oslFq963gZUbZhFb2Tr2cFkKrC6ReIpXXQMT
         lWewgoHPpoBUf22uuusOfyPY5Uzn4mpgukXtIoMYTa48oEOWomNDmnimRJ6hD7+gr68C
         AP6GrzzJl5mvrsSy40MFNdE8NcGo3xvxW5FOnYeCKXQg1n6RLx32qjr6dooqfCxoYzRh
         pFjwrfc7vcRKQrOW6sd4zWR3qSbfg/e8hv6UIxRFu8M8nOdbJkw7F1Z7yz65RobuoIFK
         Obcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769625118; x=1770229918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOpcbsJqzx5BFg4CCMHidiY0+KPvr9io+iqkXaknWDA=;
        b=aeNfE0WjQpLmbf87xNZfbV2clQyssTSsWwR679eSNA43LtnxqdRkQ7uk3q+X1eYAJm
         1hCGd6V62arO3R6RKUFW973Gt7JFlkZhC5kwxJLlbs6+1zKxRadwm9JaJqnvt64F8kkF
         uYGZuOV5l7JaYz+r76sscaB/abP3CZ87p0NJqeUjHRxBoSUp3lcmkDykJmKN5x/+SGog
         9ilEsnqgUfMotjagrR2mOpWS3DitIvQ8xT4FwrER2xKs43Gl4G9HUHDO0NdBl8wiNbX/
         Qg4c5UadPQ3BzkC9zVzKYSucWcwdetCi6ze+qndvUKWjrZqPEVHoQ5Y6GeprU7m3Pgqe
         nMvw==
X-Forwarded-Encrypted: i=1; AJvYcCV6uObSOzG//j/nyiYYhi0ZlY/uNkqiw6U/M9kdfWFw9/0SfK2+aGTprrzJNBxVfus2Dn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLAXr/GZmYwfUURicaT0ZJDfl9mDjKJUNEmk7f/91ypMkdPhoy
	fVUotbxobmHWvP9GHL2DFyET33S43hxAQm7p0Iko19HBEli5LyyExIOS
X-Gm-Gg: AZuq6aJxPerFNbnV+nlksGl/heXGSMCEXmcehrfChgBTo3IwV4ER0yOz2rQRI1zEG/r
	eUC9KEMX2LZORPHQKv7UQ6rR/qkvfr4nCvlzJ2a4XHJPGGov0EBfeOgyZ3zWaRh4xuyzDm6yuMn
	AozrBegMbdOWRLd1RtmEGeeHTiKyq55nbRiNwY/EkXo3Ew2Iy+5WPM15YBFLU+t2Y59w/TKbh83
	1r0Ci3pKNT9gACB6NmlHCQUJSiFqT/APTGpiSf2QC0ncHPr/kNJK7rnk0gJtQYHKyJbrwAD4ETb
	YNVs1++yAtYejiPQ0zpWF/avr4MzPhXNPuxcZJRKs73/ffJQe2eqLWsGgTxzGLL8zVe1TvBg39V
	OxBAny7vMWRcwNdYCotQJk6543mMGnwZWLY6TiRIZo56lXXbwJqCovR2tTeEZzs7qrAPBBgXHZv
	298uA8MT983N6Nq1X1FDCX3f5/eLzGucXdvDmhwfnBRFtqUKM8oeg=
X-Received: by 2002:a05:6000:22c9:b0:435:9882:234e with SMTP id ffacd0b85a97d-435dd1d8e62mr7603797f8f.59.1769625118064;
        Wed, 28 Jan 2026 10:31:58 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:c307:95a:6dc8:83a5? ([2620:10d:c092:500::6:f1cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4762sm8554622f8f.6.2026.01.28.10.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 10:31:57 -0800 (PST)
Message-ID: <344199c5-b5f8-4032-8457-a18b62581806@gmail.com>
Date: Wed, 28 Jan 2026 18:31:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Remove xxd util dependency
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, kpsingh@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260128150435.85074-1-mykyta.yatsenko5@gmail.com>
 <44ec77f8-0d77-4ec8-b225-f58307fea951@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <44ec77f8-0d77-4ec8-b225-f58307fea951@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/26 17:29, Alan Maguire wrote:
> On 28/01/2026 15:04, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> The verification signature header generation requires converting a
>> binary certificate to a C array. Previously this only worked with
>> xxd (part of vim-common package).
>> As xxd may not be available on some systems building selftests, it makes
>> sense to substitute it with more common utils: hexdump, wc, sed to
>> generate equivalent C array output.
>>
>> Tested by generating header with both xxd and hexdump and comparing
>> them.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 2c2f68a171ed..bbcd2101c3d7 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -720,9 +720,13 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
>>   	$(Q)mkdir -p $(BUILD_DIR)
>>   	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
>>   
>> +# Generates a header with C array declaration, containing test_progs_verification_cert bytes
>>   $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>>   	$(Q)ln -fs $< test_progs_verification_cert && \
> I think we can remove the symlinking here too. It was a workaround for the fact that
> xxd derived the name of the variable to assign from the filename, so we could not
> use $< directly as a result. It would use underscores etc when
> representing the path; i.e. something like path_2_test_progs_verification_cert.
>
> Newer xxd had an option to provide an explicit name, but we needed a workaround there
> since we couldn't rely on the fact xxd was new enough.
>
> Now since we don't care about xxd we can dispense with the symlinking step.
>
>> -	xxd -i test_progs_verification_cert > $@
>> +	(echo "unsigned char test_progs_verification_cert[] = {"; \
>> +	 hexdump -v -e '12/1 "  0x%02x," "\n"' test_progs_verification_cert | sed 's/0x  ,//g'; \
>> +	 echo "};"; \
>> +	 echo "unsigned int test_progs_verification_cert_len = $$(wc -c < test_progs_verification_cert);") > $@
>>
> After removing symlinking we would just need to change to using $< above instead
> of test_progs_verification_cert I think; following changes on top of your patch
> seem to do the trick in tidying this up:
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index b8bf51b7a0b0..a3ea98211ea6 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -23,7 +23,6 @@ test_tcpnotify_user
>   test_libbpf
>   xdping
>   test_cpp
> -test_progs_verification_cert
>   *.d
>   *.subskel.h
>   *.skel.h
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index bbcd2101c3d7..f559f792c1be 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -722,11 +722,10 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
>   
>   # Generates a header with C array declaration, containing test_progs_verification_cert bytes
>   $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
> -       $(Q)ln -fs $< test_progs_verification_cert && \
> -       (echo "unsigned char test_progs_verification_cert[] = {"; \
> -        hexdump -v -e '12/1 "  0x%02x," "\n"' test_progs_verification_cert | sed 's/0x  ,//g'; \
> +       $(Q)(echo "unsigned char test_progs_verification_cert[] = {"; \
> +        hexdump -v -e '12/1 "  0x%02x," "\n"' $< | sed 's/0x  ,//g'; \
>           echo "};"; \
> -        echo "unsigned int test_progs_verification_cert_len = $$(wc -c < test_progs_verification_cert);") > $@
> +        echo "unsigned int test_progs_verification_cert_len = $$(wc -c < $<);") > $@
>   
>   # Define test_progs test runner.
>   TRUNNER_TESTS_DIR := prog_tests
> @@ -902,8 +901,7 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)                   \
>                                 *.BTF *.BTF_ids *.BTF.base               \
>                                 no_alu32 cpuv4 bpf_gcc                   \
>                                 liburandom_read.so)                      \
> -       $(OUTPUT)/FEATURE-DUMP.selftests                                \
> -       test_progs_verification_cert
> +       $(OUTPUT)/FEATURE-DUMP.selftests
>   
>   .PHONY: docs docs-clean
>   
> I'd suggest doing something like the above, but I tested both ways and it works
> well so
>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
Thanks for taking a look, you suggestions make sense, I'll apply them.

