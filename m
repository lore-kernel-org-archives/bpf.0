Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB22ED860
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332073; cv=none; b=V4JWeLJmvdiHSf4EIgrkkAYFIjDR9UASBw30GjkpH2srFjbwx+9Y97ZUpgAxkasWotdVyO2qBgIKnLJ0QclwFtxmfF8eo6NqZY4CNwT/EC6/aOGqGr0cncb39LBplC5X+VBd6Wr8RRRVt66eMi+J/S5qNdruBy0JfI/2bBfcMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332073; c=relaxed/simple;
	bh=9t5Zd58/mYelk9nkWFiE6OxH8Zzt1xWHLjUQOKWlSdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIRINlPL2BzVbF6KmPeWeT2mNRYbLBA7PxpBqzBiD3dZ2NvnhbXJTomnn2heIXDqQzufPN9492jpDLbrxjhzaTaF7rbZKD/Z00X+t7VzhSOO5TCJjub5cTfuQ0HUO01PNkeCMe5RVxLNLhOmz2+5vPcFkmlnUm8XQ9xVp/o/3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0eUPF6Y; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0eUPF6Y"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4600cbb06deso891204f8f.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780332070; x=1780936870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ev8L0thi6+rD5Jd4KVXxfdxSrwuvhN7/Epr+Jso/B0=;
        b=K0eUPF6Ym2yXPdZdEVEgyZeMdNU9etAbIV1W7RCjg23ZXEZ+4P8KAcDNIUFbM+tLpd
         P8+yEQgfQvUAJK1AkUf7ySmnYCAwOOd6aW9kFkS3JY7IHXuhfwwPi0Dq1zFfsP1C/JtY
         dYYGOISFeW8YjN8DM5cwoOwzKYmb9Rrf4T23Jfu60chBLXltXJUjGPcpTOzVG1JY8Qa6
         iVoBe/Uu0WV2fjVTXuvTiKsZD/jDXNBPK/VZGkHj3xXclgUCAUta/453QTKKCMdbvqfj
         wiFKiY0qkAQTR2a2TGe22XyAmfcKhbaNY77/QZLI4yIN212StcbMZ5Gaw7LHSCR+w3yX
         ZxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780332070; x=1780936870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ev8L0thi6+rD5Jd4KVXxfdxSrwuvhN7/Epr+Jso/B0=;
        b=MDC8kf9C3XjebbL1YgPjrRGoVAygIWOdmrJApBVYAKsBPjQKLR2R2hZlbjIqdMzWXc
         Fi5+8HMUezWXe0+MGxrDxQKDqdBKj5RfCE+WMSGH/zeXxmcIrKxXSQcT2AXqPlwCj9jA
         wWTDv/ZaFli3dLAkwjUY04m/i7O+h8xyk/8lTzQ/MSDrmZ/8oz9VtQWxdL0OB9jE9Kam
         nxbvic7w0kjNUHOgCN3MERggyOgIxfguiDnAl896V3kVQNKsCqJJ0PQvBBLovaNlD2r8
         yajlm0otuPOqqZcr4v4mVwahD8W139qMD+UoE3smFj2fZsyL5sK3QiMyq3F+Ss/RZO7N
         Hh6A==
X-Gm-Message-State: AOJu0Yzrfl8wLN7/cgci1Mrqb0S3iqEMgHMbQIeBbwZZheK728POnNAC
	RWBUhinFZiXHlmFtZcY0JKvUqShYPWviEjBXkrH94fAu9lFpZrgG7Pw17Z6Bjv/z
X-Gm-Gg: Acq92OHFF1N1jUK+rmj/BtqYPU19KKSLVFMZ7PGUfGmZsZpq3biodX9qfA6/Ep0TRV/
	RriZyF0g6Y9WeTyyGQaHymVaEZC5pAzf5PygdRF/oWtTUn1DQDeIsMXVuub+NZhaIf6djT9cu5s
	UcwcpIOzWoGTNd/KYGXCPqWymbFxSwFLNWcSNuzt6EMMZqQTAoPlnmLgDzsWtoj2jlTTsgWLoXW
	9YaMER99TtWbGeE5XNDl4gSjaOsai7lIJGyjo1vdOy2XHiGPPKKRtG3SFu7Ka62BE+/U3d/snvl
	PZEgUtutDfEOrD3nv0yHnOugm/XoaQVfHUeEhwxvWTa11TZupZeXFmGRFEjDu9XKuAcI4lYP+gg
	DXF0a4w8HKVkJmaqHDwA6DUsrSzqBiIkIQlk7Hta+DWZZycIcGRupOEzTVxFkEpg29rJjyBYNd1
	7/ONnwPnVi4vx7jVxd59rcCEGarRr8zNP9SaYr1QJkOSmUR4/Jn8cXtmO5esm/TsyedjlWk8Hkh
	HiNemOlSXirxb/b3g09dg==
X-Received: by 2002:adf:e104:0:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-46018cdd153mr361359f8f.5.1780332069651;
        Mon, 01 Jun 2026 09:41:09 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm26190647f8f.18.2026.06.01.09.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 09:41:09 -0700 (PDT)
Message-ID: <84f0160c-24eb-42b5-8692-549415c80c52@gmail.com>
Date: Mon, 1 Jun 2026 17:41:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 08/11] selftests/bpf: Add basic tests for
 resizable hash map
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260528-rhash-v5-8-7205191b6c57@meta.com>
 <20260528184115.AC1441F000E9@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260528184115.AC1441F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 7:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing file descriptor validation for `bpf_program__fd(prog)` after retrieving the program via `bpf_object__find_program_by_name()`.
> --
> 
> commit 85c8ece43292fc1ae20a51c42265be508a83ec61
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> selftests/bpf: Add basic tests for resizable hash map
>     
> Test basic map operations (lookup, update, delete) for
> BPF_MAP_TYPE_RHASH including boundary conditions like duplicate
> key insertion and deletion of nonexistent keys.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
>> new file mode 100644
>> index 0000000000000..69686bf69ba57
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
> [ ... ]
>> +static void rhash_run(const char *prog_name)
>> +{
>> +	struct rhash *skel;
>> +	struct bpf_program *prog;
>> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
>> +	int err;
>> +
>> +	skel = rhash__open();
>> +	if (!ASSERT_OK_PTR(skel, "rhash__open"))
>> +		return;
>> +
>> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
>> +	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
>> +		goto cleanup;
>> +	bpf_program__set_autoload(prog, true);
>> +
>> +	err = rhash__load(skel);
>> +	if (!ASSERT_OK(err, "skel_load"))
>> +		goto cleanup;
>> +
>> +	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
> 
> [Severity: Low]
> Does the file descriptor returned by bpf_program__fd(prog) need to be
> validated here? 
> 

fd should be valid after rhash__load()

> Since prog was obtained via the manual lookup API
> bpf_object__find_program_by_name(), should we verify the fd is valid (>= 0)
> using ASSERT_GE before passing it to bpf_prog_test_run_opts()?
> 
>> +	if (!ASSERT_OK(err, "prog run"))
>> +		goto cleanup;
>> +
>> +	if (!ASSERT_OK(opts.retval, "prog retval"))
>> +		goto cleanup;
> 

