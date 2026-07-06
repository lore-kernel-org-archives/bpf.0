Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C127EFE9
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334805; cv=none; b=fx7Xn/WTZKsCDoYdHn0I/sK/lYkq8zQNsqiYldimyd7x6vqdEAkF10mjSxmQT/i5EoGIIMlgJ3gofyZsJnbzFzCdKiQeEc+G0/3d835G5pb+jf0HuzwIqgFGLJaDkfzV5iNwcX3a+cXBftgQ3FTWv+st6NKXYtJjs+rRHdi6odw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334805; c=relaxed/simple;
	bh=yuzFjppwp9KNN3wCQo7F2CNPrgflTNWPoxGurw2XavY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFbsEPy1vI/UPVs1ccuErl+3quA+M5WLX3HAtEAbPNIyokaASHaVAomOOY5AY6ujt4yJSY3nbt/T/MNaf7/0mFGgaKDnHQ0CFdHpDNMQVJimg3GPw2Sq0LfDzYjVmcqGIycFL0F2+R/YyErASq7pgSdFqCTQFVcH/KZd/oNrYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fU1ax5eH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAzAE9f4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fU1ax5eH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAzAE9f4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783334801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sFi86kewc62Xc/M6TiWgR/UEUFUb7kK5SqGbMztc0I=;
	b=fU1ax5eH2cwCSl1BCUabqQdMWpPCmx8pqz4mcxrWC917SeSdlr/akf6Kjw/exDMNbXHG6Q
	fNxFv+oUZbHxkH8oZvYWQKX6CTbF0myOacipeJj5Qo1RSz9Pye5AMMJ69Jn+S/nrW2JhaP
	01cpebUmZACe+OpOGyKyfcllm8uV7y4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-26Z3nuUpN3K23rOHOLg67Q-1; Mon, 06 Jul 2026 06:46:40 -0400
X-MC-Unique: 26Z3nuUpN3K23rOHOLg67Q-1
X-Mimecast-MFC-AGG-ID: 26Z3nuUpN3K23rOHOLg67Q_1783334799
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bb6a4336so24296125e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 03:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783334799; x=1783939599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sFi86kewc62Xc/M6TiWgR/UEUFUb7kK5SqGbMztc0I=;
        b=WAzAE9f4e9vtqFrfA8wklcrF8ZlqpwBM1Vhudrb+doXw47D97Yf3H/neJfmFq/DGy0
         9DUcCnQZnSkSKZl3ht0TkXHNg4Xi5tbP+Dux4/2tKgpYNa30BkPh4rUlAz8E5CDpR5Gv
         0cI/MPvZGLg11t/bg5lwE/5lyI1HJHN7/yKoeHAEYTocItu4Otmo5Ow15mlVkDM/IW1B
         L7lSWZj20fEjCOCKY7I6VUmVHiCd33r8RnOie5sbnTOGaM7CvI+mV1DYDHRwdtp9EGRZ
         qdwJk5kyw6PBCCP1XiCxlpXVYvkXxaEtXsITqT4vdXScLsOrgPTy5lITQjzCFrkKa1Nf
         x6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783334799; x=1783939599;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sFi86kewc62Xc/M6TiWgR/UEUFUb7kK5SqGbMztc0I=;
        b=itHDIptoLfr6g2IDT9gLNvYTTUyKeaXU5EFOxbdDuMuJJeio0liHmHQ8TK8aLA4nmS
         7/1nKe48B7ARAcX8hPzvH7dpMMxuuxQAGCoISmfMoD5C8yzRLuGqpibnlhWIuWLRem6c
         sIP2KCQdA5orFkBkLjSyyUq69gtp4W3gcwk1bojC8XWZuP+XZgoj9ZBztoc7SURmPitH
         pVzshDKgZkolIjNRSQ3fHt55La4RF0ackn1KjrD46l8CSXwIDuw7PPJ2ZCOA4jo5Id2p
         o+/MEdWwCWLLbJwdVNCEsaoXyUNTiPH40TYcCKIJw24bA59yfk3qrOwZW/pmVOu0u5QJ
         BhQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQhki97SojgaRRe4ztWfAottFVR06u3xYJUjYPCqgnNRjyvw62ktXl/M+Mngg3bJakbCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4xM8WcSXkQEyfiCSLgtZVoxsN9TaBYSgcKHIWm8/bpuFsvLa
	7+DC7hD7XfNaBXEp1D5aqNEpPMhkuMdU9bpfH6WPvcnmeFjj1gLoPtOM5QVkgYa5GM55qbI95W9
	3CxtsDhp0U6If2KiPlvVubux75Iwa9Y0kfiSalrNlRXNhQyhy2OlM
X-Gm-Gg: AfdE7cki70oIcZ9gyZGn6jGSz7Y38rnFJjZVsjo6V+4EmyCcne/gRv45Wh2u16A9ev2
	d5heryBa1a1/w+jmcbA+uPKI8YwOMpiwBnUeLPJw6j0WM1x9lpTpmi6nzsj7yDQ97tW6EMf/Lm1
	RYrFg0KfWdUsQuKmb4R9bW87yVTzNW2//gZWu0HYCSnvi/n4phUVZgKNizAY4ZbF1zOuG9GFvmH
	2H6o8v62O4EbhONNdpBIyerA8UsRSD7buHdfLJa3Wmap89gUlZLufuGjCuAENVvAM3/el8qfKzw
	RBX2fXHNIRrwqDu/ZzcqShAV+BX1lIq3klUwmIpMA5/oTYcnEIMwsAwR/eVKVE/9jLl5GaQVZGh
	Xb5bW8hviiD8Xw3R414zIsGrs5ezd9nU8avu7bNTk4uNswg==
X-Received: by 2002:a05:6000:1885:b0:462:fdf2:3a50 with SMTP id ffacd0b85a97d-47aae2c5e48mr12673050f8f.32.1783334799391;
        Mon, 06 Jul 2026 03:46:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1885:b0:462:fdf2:3a50 with SMTP id ffacd0b85a97d-47aae2c5e48mr12672991f8f.32.1783334798903;
        Mon, 06 Jul 2026 03:46:38 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm24722915f8f.37.2026.07.06.03.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:46:37 -0700 (PDT)
Message-ID: <9aedb40b-6c09-43bb-becd-57fbdb4d73b0@redhat.com>
Date: Mon, 6 Jul 2026 12:46:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf trace: Refactor augmented_raw_syscalls using
 bpf_for
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Michael Petlan <mpetlan@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
 stable@vger.kernel.org
References: <cover.1783070132.git.vmalik@redhat.com>
 <8ceb8f3323d0742163c42c343eb9d26843fe9e9b.1783070132.git.vmalik@redhat.com>
 <akhKyjlsSg82XN2Z@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <akhKyjlsSg82XN2Z@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/26 01:50, Namhyung Kim wrote:
> On Fri, Jul 03, 2026 at 12:32:15PM +0200, Viktor Malik wrote:
>> The loop for processing syscall args in augment_raw_syscalls has a
>> history of breaking with Clang updates, see e.g. commit 013eb043f37b
>> ("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 to 16.
>>
>> Now, a similar thing happened between Clang 21 and 22. While the issue
>> is mitigated on the main line by a recent verifier update, it remains
>> broken on the 6.12 and 6.18 stable branches:
>>
>>     [linux-6.18.y]# sudo perf trace true
>>     libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
>>     libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>>     [...]
>>     BPF program is too large. Processed 1000001 insn
>>     processed 1000001 insns (limit 1000000) max_states_per_insn 40 total_states 37941 peak_states 232 mark_read 0
>>     -- END PROG LOAD LOG --
>>     libbpf: prog 'sys_enter': failed to load: -E2BIG
>>     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>>     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2BIG
>>     Error: failed to get syscall or beauty map fd
>>     [...]
>>
>> The reason is that the loop is quite complex and the BPF verifier often
>> struggles to prove that it terminates.
>>
>> Fix the issue by replacing the standard for loop by the bpf_for macro,
>> which uses numeric BPF iterator. This should prevent future breakages of
>> this kind since the verifier has much easier job proving that the loop
>> terminates.
>>
>> Small adjustments were necessary for the loop to make it work.  The main
>> problem is that the verifier has sometimes problems with bpf_for loops
>> that use a carry-over state, such as the `payload_offset` and `output`
>> vars here, since the verifier tries to track their values too precisely
>> and cannot prove loop convergence. To resolve the issue, we (1)
>> explicitly recompute `payload_offset` in every iteration and (2) use a
>> trick with adding a global zero to `output` to help verifier forget its
>> precise state and use a range instead.
>>
>> In exchange, this also allows to drop a few artificial checks to help
>> the verifier, including the changes introduced by 013eb043f37b.
>>
>> Finally, to keep backwards compatibility with older kernel versions
>> which do not have bpf_for (i.e. numeric iterators), fall back to
>> standard for loop in such a case.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
>> Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
>> Cc: stable@vger.kernel.org
>> ---
>>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 54 +++++++++++++------
>>  1 file changed, 39 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> index cbdd5ce19a2f..60babc06f381 100644
>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> @@ -429,6 +429,8 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>>  	return bpf_map_lookup_elem(pids, &pid) != NULL;
>>  }
>>  
>> +u64 ZERO = 0;
>> +
>>  /*
>>   * Determine what type of argument and how many bytes to read from user space, using the
>>   * value in the beauty_map. This is the relation of parameter type and its corresponding
>> @@ -439,12 +441,13 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>>   * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>>   */
>>  static inline int augment_arg(struct syscall_enter_args *args, int i,
>> -			      unsigned int *beauty_map, void *payload_offset)
>> +			      unsigned int *beauty_map,
>> +			      struct beauty_payload_enter *payload, u64 offset)
>>  {
>>  	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>>  	s64 aug_size, size;
>>  	bool augmented;
>> -	void *arg;
>> +	void *arg, *payload_offset;
>>  
>>  	arg = (void *)args->args[i];
>>  	augmented = false;
>> @@ -454,6 +457,12 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>>  	if (size == 0 || arg == NULL)
>>  		return 0;
>>  
>> +	/* bounds check for the verifier */
>> +	if (offset > sizeof(payload->aug_args) - sizeof(payload->aug_args[0]))
>> +		return -1;
>> +	barrier_var(offset);
>> +	payload_offset = (void *)&payload->aug_args + offset;
>> +
>>  	if (size == 1) { /* string */
>>  		aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
>>  		/* minimum of 0 to pass the verifier */
>> @@ -464,11 +473,13 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>>  	} else if (size > 0 && size <= value_size) { /* struct */
>>  		if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
>>  			augmented = true;
>> -	} else if ((int)size < 0 && size >= -6) { /* buffer */
>> +	} else if (size < 0 && size >= -6) { /* buffer */
>>  		index = -(size + 1);
>>  		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>>  		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
>> -		aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
>> +		aug_size = args->args[index];
>> +		if (aug_size > TRACE_AUG_MAX_BUF)
>> +			aug_size = TRACE_AUG_MAX_BUF;
>>  
>>  		if (aug_size > 0) {
>>  			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
>> @@ -497,11 +508,10 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  {
>>  	bool do_output = false;
>> -	int zero = 0, written;
>> +	int i, zero = 0, written;
>>  	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
>>  	unsigned int nr, *beauty_map;
>>  	struct beauty_payload_enter *payload;
>> -	void *payload_offset;
>>  
>>  	/* fall back to do predefined tail call */
>>  	if (args == NULL)
>> @@ -513,7 +523,6 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  
>>  	/* set up payload for output */
>>  	payload        = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero);
>> -	payload_offset = (void *)&payload->aug_args;
>>  
>>  	if (beauty_map == NULL || payload == NULL)
>>  		return 1;
>> @@ -521,14 +530,29 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  	/* copy the sys_enter header, which has the syscall_nr */
>>  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>>  
>> -	for (int i = 0; i < 6; i++) {
>> -		written = augment_arg(args, i, beauty_map, payload_offset);
>> -		if (written < 0)
>> -			return 1;
>> -		if (written > 0) {
>> -			output += written;
>> -			payload_offset += written;
>> -			do_output = true;
>> +	if (bpf_ksym_exists(bpf_iter_num_new)) {
>> +		bpf_for(i, 0, 6) {
>> +			written = augment_arg(args, i, beauty_map, payload, output);
>> +			if (written < 0)
>> +				return 1;
>> +			if (written > 0) {
>> +				output += written;
>> +				/* guide the verifier to forget range of `output`, which
>> +				 * helps to prove convergence of the loop
>> +				 */
>> +				output += ZERO;
>> +				do_output = true;
>> +			}
>> +		}
>> +	} else {
>> +		for (i = 0; i < 6; i++) {
>> +			written = augment_arg(args, i, beauty_map, payload, output);
>> +			if (written < 0)
>> +				return 1;
>> +			if (written > 0) {
>> +				output += written;
> 
> Woundn't it also need '+= ZERO' here?

IMHO no, the verification of standard loops doesn't suffer from the same
problem as the verification of bpf_for.

Viktor

> 
> Thanks,
> Namhyung
> 
> 
>> +				do_output = true;
>> +			}
>>  		}
>>  	}
>>  
>> -- 
>> 2.54.0
>>
> 

