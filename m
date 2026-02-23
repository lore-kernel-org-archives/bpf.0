Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6E21CFEF
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855055; cv=none; b=WUUyNe/8SSFZFg2G4wfKS5Xkd1OWIfzw/+MdKTUAv+bKvdUDjMRcr9YBviATvfjgE6gj1tJW/c7yYykEDo7RxkQK7kUaYh77wcC6S18xmlzmoN2pCdoZsTpDUEiLZbvXsFlvFJeZO3vtaWf2RFBdfOvvvvk68btPRqGaxY7acFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855055; c=relaxed/simple;
	bh=hpD4A2LbjbCNjsrw5tSp/djcEzocZv9CkhaFRtwPCt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/rGzvRY0ZGmTSvrnk3T/3SuGjf63LAOlGMBxES67hYGHkLWQ6F6t7NyDfSxjHNuRTHRDeDrSNp0erQHTKbUKnMcOWWcl8jle8fJzuVLQmqV5/lUWyJn9mkOtXwqWw18YKJprwfmeUaUs8cZt4YmvRSPAPs8Shi5MgEgXAKq16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuvwByZs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuvwByZs"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43622089851so4393296f8f.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 05:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855053; x=1772459853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJsnTs9wOOva+W/dlyKuzUXHIrF1f8WEp0sW62KqpBk=;
        b=WuvwByZsY8hBRI6F1GcVQSZGWV5xGylfgjm0Xso/pKVV6ot/m99eOBJXgUQr4hWGjA
         NO7OfYiSD/j/UrGtSUtCoP1IOOzm8gIM+dwi2JFmOUl0iWcLlVvdK0S1SOcsVtknQZ6D
         C2JD5tG9umYnbNnc0jdQ3UqhV1W8Wewj4X2yUSKmD0pmRQ8iUJDYSdkf/uoAgeS1REPj
         VTWYFeVMV9ocac7s1YsMGrnzpnBwMGSNTv0P2koULf+iZMYGHVdi4N0mDl6xLdEe9Prb
         tXiaQX+dwHvE9jnOBQlfTMAYzcpv8w+nAorcHeVxe2++qTiH4dadzkz4cAJzRbgcbEiv
         jWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855053; x=1772459853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJsnTs9wOOva+W/dlyKuzUXHIrF1f8WEp0sW62KqpBk=;
        b=WD028iiHmwLi5SjyueFqFWacxJHFbyv0wvkKScNDiJ19fmSjNebZU/Q5A0PbhgjJpu
         5VimzaBFXcrNxKAJe91DJWhtO1Ju5QzVS/lRbaV9/rEjMZJjABrwmVV9Nkec2twID7EW
         OKPAVal6mCRe5j1geB59QXHetfUsvCGLdxRgkApKTaAi+RZWR3XlZwH45+ocltQP3zSq
         QhyNaLITqZ3RNNcOEAdd6euI9eeoPYS2/ZvdGpyFfbegRSCn+K7SAIpkC/pqLoNIZaur
         +eWIrs1TI3HkIZBJnEbej5iFCwQ+alCM/oTz2+A3m4jK4ajVrIOmWR5QCGcpBL1uv8wL
         eLtw==
X-Gm-Message-State: AOJu0Yz10rA0Fa2ovNJx4leZgv3RKsE93w4NW13tUkZ9tCYOHyo4YgeQ
	vGR3Gdyu+s4qzo+X/ZarO3hmFxkNL4llK0u91Nv5hJ6zG8ouWgRj8V3b
X-Gm-Gg: ATEYQzxOm2kTO/Cnbe6Z2BVhqEHVMkUULEVfZfRttp7qDErfmecCWtmGfhTk3fyNQ8q
	xVXyH8Y/TZbR/vcOtQ39+xF5K0GHT49pRtkXgj2hRqKkEkyk/qGpYr/CR7MZAbYGJBXNenK13/l
	KWjumE9sA2svE7kq3xeMvggwBdVsQgKArTaPxeUapv4+yPp9LOMY3YQLkW8pBF0Ar2EQSju9woa
	ab83hq8/Cemv+W7zZ39PFz6Q04CsKgEs534YXynVPaTgBqiK7/OYcAckJBDh0T0wA9uPitdQrJR
	AEqarnH3YTXHXd5Tzr2Cu6O0jG84TrjMg2kn7SdHOqtids9aFJ66kxRy9e+rngb5Mlh4L6zBmzV
	DIWEg1R5p47m7PEgpHEJqDLCrlsrDvwHaNLhvsv6lgfVtekbaWBTJJJNyhRMX98EfsyWmHCUkp8
	TM6BbajSQulgwAyijgVWvJ8z7A5IBwKB+izcijeapD4wxyIISReTS6f1osVyrW
X-Received: by 2002:a05:6000:2407:b0:435:bd00:cb4 with SMTP id ffacd0b85a97d-4396f15b2a4mr14095895f8f.23.1771855052654;
        Mon, 23 Feb 2026 05:57:32 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:e583:8b63:e8f2:1472? ([2620:10d:c092:500::4:5d16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f6csm21443781f8f.7.2026.02.23.05.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 05:57:32 -0800 (PST)
Message-ID: <260229af-3ea8-43c3-bfd7-fe6b3471e75d@gmail.com>
Date: Mon, 23 Feb 2026 13:57:31 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/2] libbpf: Add bpf_program__clone() for
 individual program loading
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <CAADnVQJFHzGQX0xh5pSVm1AKH=ONM4NYRnv=+qdWOAW4PmrVQg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQJFHzGQX0xh5pSVm1AKH=ONM4NYRnv=+qdWOAW4PmrVQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/26 22:48, Alexei Starovoitov wrote:
> On Fri, Feb 20, 2026 at 11:18 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> This series adds bpf_program__clone() to libbpf and converts veristat to
>> use it, replacing the costly per-program object re-opening pattern.
>>
>> veristat needs to load each BPF program in isolation to collect
>> per-program verification statistics. Previously it achieved this by
>> opening a fresh bpf_object for every program, disabling autoload on all
>> but the target, and loading the whole object. For object files with many
>> programs this meant repeating ELF parsing and BTF processing N times.
>>
>> Patch 1 introduces bpf_program__clone(), which loads a single program
>> from a prepared object into the kernel and returns an fd owned by the
>> caller. It resolves BTF attach targets, fills in func/line info,
>> fd_array, and other load parameters from the prepared object
>> automatically, while letting callers override any field via
>> bpf_prog_load_opts.
>>
>> Patch 2 converts veristat to prepare the object once and clone each
>> program individually, eliminating redundant work.
>>
>> Performance
>> Tested on selftests: 918 objects, ~4270 programs:
>>   - Wall time:   36.88s -> 23.18s (37% faster)
>>   - User time:   20.80s -> 16.07s (23% faster)
>>   - Kernel time: 12.07s ->  6.06s (50% faster)
>>
>> Per-program loading also improves coverage: 83 programs that previously
>> failed now succeed.
> Wait what? How is that possible?
Thanks for asking. Take for example verifier_unpriv.bpf.o object,
all progs fail to load on the system veristat, the errors are:
```
libbpf: map 'map_prog1_socket': failed to initialize slot [1]
to prog 'dummy_prog_loop1_socket' fd=-2: -EBADF
...
libbpf: map 'map_prog1_socket': failed to initialize slot
[0] to prog 'dummy_prog_42_socket' fd=-2: -EBADF
...
etc
```
I understand this is due to the libbpf trying to initialize
all PROG_ARRAY maps during object load, regardless if the corresponding
program is loading or not (currently only 1 program is
enabled at a time, so object that has those PROG_ARRAY has no
chance to succeed)
This root cause is the only reason for all 83
improvements.

This is not intentional, but it sounds like a nice side-effect,
so I mention it.

Is this something we would like to address in libbpf?

