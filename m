Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118036A35C
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453895; cv=none; b=EUsA1tlCQ1TkBh8gRpz/uFxOHEZjXd1TVBCeb8mZyAH2CaBheeeY1afBpf3UyZT+SQLz2fyp1GXdedgQ+QrNhZEZhbDzFSNCFOKYx7yayAmr3IGkHfzROjd9FZgI4qWOogooo+GR9hp2nq/4PSsA5VjBCUKInUWaupb8kEG7VoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453895; c=relaxed/simple;
	bh=n4LlqEmRvseGJndNGwhsbBvXwp8mKc+IpJkgJaEf/WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/1DZnjIpQQhVlD3ixar6TB3qr4l8x0Igz9cU5gdY/Bmvq+ySxlSTTvEG9zMjL1quvisYJPAFRWdNlpkMZ2JwN+hauLSQpmqCRiWaGf6+alQ6fasSM/kvvMOUkFpoymxptOAL7x6ZpxU+KWI1FiDtlPBOqDuAvBY6oiCCZ1gN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rne5uBgb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTsgfxYV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rne5uBgb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTsgfxYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782453892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQNfBFbN4th+uCR9QWm54BMEALVkoa98CcrxbCjanBc=;
	b=Rne5uBgbKUGV/SjsJMv03H8Z7whd+h3NM/ADqPPx9XdrF78O41o3qGUgPR4GA9IqE+FKSe
	bXLj45SA5F5Vr7iHMUK8+P1+Cm0ofjcS9c/sIeyO77SDIBt2542nRVMqXidqNrD6I3EfrH
	k3hzSDh2JOZKp6JbXstI2Nub/UrSqR0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-KRklNYeRNxKARgIiVi_Ulg-1; Fri, 26 Jun 2026 02:04:50 -0400
X-MC-Unique: KRklNYeRNxKARgIiVi_Ulg-1
X-Mimecast-MFC-AGG-ID: KRklNYeRNxKARgIiVi_Ulg_1782453889
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so3698195e9.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782453889; x=1783058689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQNfBFbN4th+uCR9QWm54BMEALVkoa98CcrxbCjanBc=;
        b=WTsgfxYVKlhIv9OP6tYenYuGyW/UD5E+hhJCY+Il5uMXy7Fak18pFUhWSRSvkfyIeI
         W63r/ejaItJuapDU5jnzpbNWm6d005Mfo7ZZ1GgsYfcvqmpA54ebLe2h3groCNoE6aNT
         O+FwL9lsnpjNgSDBTWpyYgRpsvcrB7VcGX8H5Ra7HzzD3aAnSTPr/H8QEBQ5Q3sMPBOb
         rSWLcQMokKByn9UfYCD/CcTnhvA3vUyB7pcxJYRgoih26ovMgIBc98nzxSY6ppleQWf2
         gGzzKt9hxwxMdGRFm1CcxvlLehf+n6f/6x+2okOyc7xBS857GHsbzaZyPhLa/fZIfpz/
         c9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782453889; x=1783058689;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQNfBFbN4th+uCR9QWm54BMEALVkoa98CcrxbCjanBc=;
        b=TQbXfo72SaHbKGo+bQRBWnl72POjEZT4ojZjJuarZOPltMsGgB0l2zG1o6PXzpgHtk
         X2FZa3RrYOmlj0NhwAe38NwL5yoJ0IIuEugU0gE4iB5MWzLsOIirr1tJYUtahAOPbPcm
         hmFNHnVPIWQfiGH3OVFNcKku8aTHh7xXFN8JRKNtyU51RRUGO/ymTZJPgrw/HRJq/+0n
         3pk6zOXLFU+tKfibeAr3RGvHisQlhwHd1+YFnmlcfOIw4HXcMi6o4Fof0idWP/mLhnN7
         GesOYPjKUg2ysm1pPXjtsIDkjySAIOxP9RGSH7EVayuEhlnloVUY7bjAqZ1u+m0ewq0I
         0RHw==
X-Forwarded-Encrypted: i=1; AFNElJ9WdO+K22UYH7NnzIR8DVEs4W4IWT7WkTG1LyUajkc58gRvWs+8w4ESNACSF7ApRDAKD1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0dIm+frw/0tvCAjJy5QxR3WqkL2rAim8wLGyBX7ERbnXIwKl0
	3Hks8PrO1KDhEigYccUItyQRKrfOZwOHLmBFA4f3J+7xHt1gDx8Z0lF7bcWJmJRjGlpCkcU1vLO
	G6E/DQ8TnaUHTPK9IDAqF/m9k+fyZqEINFqB/JYLuMTg/BbM1nKKs
X-Gm-Gg: AfdE7cmHu1u7Y1/e27XntAw1YpBV8MVhFJRnW2Wm7lH/Ogqk3wP0X3JRfMpfEynMrkr
	jStDHhJIGfT15XWkGJ0I5QmPv/MXAaUwUUtf4PS8gYo4k+lcQjHQP72oP/xwyst7XLbcyW6JA+u
	Vwkn6d6DR9L7VJcsIyUO/gmfqPxwRT7zLtvTg0plUybRUP+aSiakhcDrr+J6PWRebewnSgXQk0B
	I8Vd+cSDX1Y/7LuanLCaiCBeX8ql/OPLjOblRk1rSgD0KO6nc5KSP2F47Y96hAYnRa3d/hXVAq5
	BrUlthR37O94rRqBP9LZ5EBOvz+eAoqCSa5JrxQeGTAckLnDuRI+0pB8MJmUxKpT+lVlQdwNidH
	8SP4wz8uq37zOjvqcX+LbGXYx/Hw1C92UruDVcig+/3Bc+Q==
X-Received: by 2002:a05:600c:4512:b0:492:53e2:7712 with SMTP id 5b1f17b1804b1-492668856fdmr82781065e9.21.1782453889135;
        Thu, 25 Jun 2026 23:04:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4512:b0:492:53e2:7712 with SMTP id 5b1f17b1804b1-492668856fdmr82780365e9.21.1782453888590;
        Thu, 25 Jun 2026 23:04:48 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690168d5sm72260805e9.14.2026.06.25.23.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 23:04:47 -0700 (PDT)
Message-ID: <4f43e9aa-2444-407b-ae52-0f4bf889ec17@redhat.com>
Date: Fri, 26 Jun 2026 08:04:46 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using
 bpf_loop
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Michael Petlan <mpetlan@redhat.com>, stable@vger.kernel.org
References: <20260623112533.1151502-1-vmalik@redhat.com>
 <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com> <ajq98dm4gAwEzkMb@google.com>
 <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
 <93e70dc7-e52f-444e-b57e-09d149dc4808@redhat.com>
 <CAEf4BzYWdsBDQ3D41=+n_oCO68bVOtKuqQCqZOEVo=j7nK9Ozg@mail.gmail.com>
 <82252ae0-133a-45dc-9622-315236a437ad@redhat.com>
 <CAEf4Bza8vFSkuiD_Vd47-eGuDS40kKvTcHQR=V3OY=c505a9=g@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4Bza8vFSkuiD_Vd47-eGuDS40kKvTcHQR=V3OY=c505a9=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/25/26 19:55, Andrii Nakryiko wrote:
> On Thu, Jun 25, 2026 at 4:58 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 6/24/26 19:19, Andrii Nakryiko wrote:
>>> On Wed, Jun 24, 2026 at 3:27 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>
>>>> On 6/24/26 08:47, Viktor Malik wrote:
>>>>> On 6/23/26 19:10, Namhyung Kim wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
>>>>>>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
>>>>>>>> The loop for processing syscall args in augment_raw_syscalls has a
>>>>>>>> history of breaking with Clang updates, see e.g. commit 013eb043f37b
>>>>>>>> ("perf trace: Fix BPF loading failure (-E2BIG)") from Clang 15 to 16.
>>>>>>>>
>>>>>>>> Now, a similar thing happened between Clang 21 and 22. While the issue
>>>>>>>> is mitigated on the main line by a recent verifier update, it remains
>>>>>>>> broken on the 6.12 and 6.18 stable branches:
>>>>>>>>
>>>>>>>>     [linux-6.18.y]# sudo perf trace true
>>>>>>>>     libbpf: prog 'sys_enter': BPF program load failed: -E2BIG
>>>>>>>>     libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>>>>>>>>     [...]
>>>>>>>>     BPF program is too large. Processed 1000001 insn
>>>>>>>>     processed 1000001 insns (limit 1000000) max_states_per_insn 40 total_states 37941 peak_states 232 mark_read 0
>>>>>>>>     -- END PROG LOAD LOG --
>>>>>>>>     libbpf: prog 'sys_enter': failed to load: -E2BIG
>>>>>>>>     libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>>>>>>>>     libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -E2BIG
>>>>>>>>     Error: failed to get syscall or beauty map fd
>>>>>>>>     [...]
>>>>>>>>
>>>>>>>> The reason is that the loop is quite complex and the BPF verifier often
>>>>>>>> struggles to prove that it terminates.
>>>>>>>>
>>>>>>>> Fix the issue by refactoring the loop body into a callback function and
>>>>>>>> calling the bpf_loop helper. This should prevent future breakages of
>>>>>>>> this kind since the callback function has no loops. It also allows to
>>>>>>>> drop a few artificial checks to help the verifier, including the changes
>>>>>>>> introduced by 013eb043f37b.
>>>>>>
>>>>>> Thanks for working on this.  I encountered this issue before and never
>>>>>> found time to take a deeper look yet.
>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>>>>>>> Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
>>>>>>>> Fixes: 013eb043f37b ("perf trace: Fix BPF loading failure (-E2BIG)")
>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>> ---
>>>>>>>>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 157 +++++++++++-------
>>>>>>>>  1 file changed, 96 insertions(+), 61 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>>>>>>>> index 2a6e61864ee0..6d553ed3ac23 100644
>>>>>>>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>>>>>>>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>>>>>>>> @@ -429,15 +429,96 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>>>>>>>>    return bpf_map_lookup_elem(pids, &pid) != NULL;
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +struct args_loop_ctx {
>>>>>>>> +  struct syscall_enter_args *args;
>>>>>>>> +  unsigned int *beauty_map;
>>>>>>>> +  void *payload_offset;
>>>>>>>> +  int value_size;
>>>>>>>> +  u64 *output;
>>>>>>>> +  bool *do_output;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static long process_arg_cb(u64 i, void *ctx)
>>>>>>>> +{
>>>>>>>> +  /*
>>>>>>>> +   * Determine what type of argument and how many bytes to read from user space, using the
>>>>>>>> +   * value in the beauty_map. This is the relation of parameter type and its corresponding
>>>>>>>> +   * value in the beauty map, and how many bytes we read eventually:
>>>>>>>> +   *
>>>>>>>> +   * string: 1                          -> size of string
>>>>>>>> +   * struct: size of struct             -> size of struct
>>>>>>>> +   * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>>>>>>>> +   */
>>>>>>>> +  struct augmented_arg *augmented_arg;
>>>>>>>> +  struct args_loop_ctx *loop_ctx;
>>>>>>>> +  int aug_size, size, index;
>>>>>>>> +  bool augmented;
>>>>>>>> +  void *arg;
>>>>>>>> +
>>>>>>>> +  /* Bounds check for the below map access to help the verifier */
>>>>>>>> +  if (i < 0 || i >= 6)
>>>>>>>> +          return 1;
>>>>>>>> +
>>>>>>>> +  loop_ctx = (struct args_loop_ctx *)ctx;
>>>>>>>> +  arg = (void *)loop_ctx->args->args[i];
>>>>>>>> +  augmented = false;
>>>>>>>> +  size = loop_ctx->beauty_map[i];
>>>>>>>> +  aug_size = size; /* size of the augmented data read from user space */
>>>>>>>> +  augmented_arg = (struct augmented_arg *)loop_ctx->payload_offset;
>>>>>>>> +
>>>>>>>> +  if (size == 0 || arg == NULL)
>>>>>>>> +          return 0; /* continue */
>>>>>>>> +
>>>>>>>> +  if (size == 1) { /* string */
>>>>>>>> +          aug_size = bpf_probe_read_user_str(augmented_arg->value, loop_ctx->value_size, arg);
>>>>>>>> +          augmented = true;
>>>>>>>> +  } else if (size > 0 && size <= loop_ctx->value_size) { /* struct */
>>>>>>>> +          if (!bpf_probe_read_user(augmented_arg->value, size, arg))
>>>>>>>> +                  augmented = true;
>>>>>>>> +  } else if (size < 0 && size >= -6) { /* buffer */
>>>>>>>> +          index = -(size + 1);
>>>>>>>> +          barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>>>>>>>> +          index &= 7;         // Satisfy the bounds checking with the verifier in some kernels.
>>>>>>>> +          aug_size = loop_ctx->args->args[index];
>>>>>>>> +
>>>>>>>> +          if (aug_size > TRACE_AUG_MAX_BUF)
>>>>>>>> +                  aug_size = TRACE_AUG_MAX_BUF;
>>>>>>>> +
>>>>>>>> +          if (aug_size > 0) {
>>>>>>>> +                  if (!bpf_probe_read_user(augmented_arg->value, aug_size, arg))
>>>>>>>> +                          augmented = true;
>>>>>>>> +          }
>>>>>>>> +  }
>>>>>>>> +
>>>>>>>> +  /* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
>>>>>>>> +  if (aug_size > loop_ctx->value_size)
>>>>>>>> +          aug_size = loop_ctx->value_size;
>>>>>>>> +
>>>>>>>> +  /* write data to payload */
>>>>>>>> +  if (augmented) {
>>>>>>>> +          int written = offsetof(struct augmented_arg, value) + aug_size;
>>>>>>>> +
>>>>>>>> +          if (written < 0 || written > sizeof(struct augmented_arg))
>>>>>>>> +                  return 1; /* break */
>>>>>>>> +
>>>>>>>> +          augmented_arg->size = aug_size;
>>>>>>>> +          *loop_ctx->output += written;
>>>>>>>> +          loop_ctx->payload_offset += written;
>>>>>>>> +          *loop_ctx->do_output = true;
>>>>>>>> +  }
>>>>>>>> +
>>>>>>>> +  return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>>>>>>>  {
>>>>>>>> -  bool augmented, do_output = false;
>>>>>>>> -  int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>>>>>>>> +  bool do_output = false;
>>>>>>>> +  int zero = 0, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>>>>>>>>    u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
>>>>>>>> -  s64 aug_size, size;
>>>>>>>>    unsigned int nr, *beauty_map;
>>>>>>>>    struct beauty_payload_enter *payload;
>>>>>>>> -  void *arg, *payload_offset;
>>>>>>>> +  void *payload_offset;
>>>>>>>> +  long iters;
>>>>>>>>
>>>>>>>>    /* fall back to do predefined tail call */
>>>>>>>>    if (args == NULL)
>>>>>>>> @@ -457,63 +538,17 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>>>>>>>    /* copy the sys_enter header, which has the syscall_nr */
>>>>>>>>    __builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>>>>>>>>
>>>>>>>> -  /*
>>>>>>>> -   * Determine what type of argument and how many bytes to read from user space, using the
>>>>>>>> -   * value in the beauty_map. This is the relation of parameter type and its corresponding
>>>>>>>> -   * value in the beauty map, and how many bytes we read eventually:
>>>>>>>> -   *
>>>>>>>> -   * string: 1                          -> size of string
>>>>>>>> -   * struct: size of struct             -> size of struct
>>>>>>>> -   * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>>>>>>>> -   */
>>>>>>>> -  for (int i = 0; i < 6; i++) {
>>>>>>>> -          arg = (void *)args->args[i];
>>>>>>>> -          augmented = false;
>>>>>>>> -          size = beauty_map[i];
>>>>>>>> -          aug_size = size; /* size of the augmented data read from user space */
>>>>>>>> -
>>>>>>>> -          if (size == 0 || arg == NULL)
>>>>>>>> -                  continue;
>>>>>>>> -
>>>>>>>> -          if (size == 1) { /* string */
>>>>>>>> -                  aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
>>>>>>>> -                  /* minimum of 0 to pass the verifier */
>>>>>>>> -                  if (aug_size < 0)
>>>>>>>> -                          aug_size = 0;
>>>>>>>> -
>>>>>>>> -                  augmented = true;
>>>>>>>> -          } else if (size > 0 && size <= value_size) { /* struct */
>>>>>>>> -                  if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
>>>>>>>> -                          augmented = true;
>>>>>>>> -          } else if ((int)size < 0 && size >= -6) { /* buffer */
>>>>>>>> -                  index = -(size + 1);
>>>>>>>> -                  barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>>>>>>>> -                  index &= 7;         // Satisfy the bounds checking with the verifier in some kernels.
>>>>>>>> -                  aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
>>>>>>>> -
>>>>>>>> -                  if (aug_size > 0) {
>>>>>>>> -                          if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
>>>>>>>> -                                  augmented = true;
>>>>>>>> -                  }
>>>>>>>> -          }
>>>>>>>> -
>>>>>>>> -          /* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
>>>>>>>> -          if (aug_size > value_size)
>>>>>>>> -                  aug_size = value_size;
>>>>>>>> -
>>>>>>>> -          /* write data to payload */
>>>>>>>> -          if (augmented) {
>>>>>>>> -                  int written = offsetof(struct augmented_arg, value) + aug_size;
>>>>>>>> -
>>>>>>>> -                  if (written < 0 || written > sizeof(struct augmented_arg))
>>>>>>>> -                          return 1;
>>>>>>>> -
>>>>>>>> -                  ((struct augmented_arg *)payload_offset)->size = aug_size;
>>>>>>>> -                  output += written;
>>>>>>>> -                  payload_offset += written;
>>>>>>>> -                  do_output = true;
>>>>>>>> -          }
>>>>>>>> -  }
>>>>>>>> +  struct args_loop_ctx loop_ctx = {
>>>>>>>> +          .args = args,
>>>>>>>> +          .beauty_map = beauty_map,
>>>>>>>> +          .payload_offset = payload_offset,
>>>>>>>> +          .value_size = value_size,
>>>>>>>> +          .output = &output,
>>>>>>>> +          .do_output = &do_output
>>>>>>>> +  };
>>>>>>>> +  iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
>>>>>>>
>>>>>>> bpf_loop() is old and generally not recommended.
>>>>>>> Please use bpf_for() then the diff will be one line change and
>>>>>>> can scale to any number of args. Not just 6.
>>>>>
>>>>> Thanks Alexei, I didn't know about this preference.
>>>>>
>>>>>> One thing we should take care is to support old kernels.  The oldest
>>>>>> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
>>>>>> 5.17 and bpf_for (bpf_iter_num) was 6.4.
>>>>>
>>>>> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
>>>>> trace: Collect augmented data using BPF") so we should be good using
>>>>> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
>>>>>
>>>>> I'll refactor with bpf_for and will send v2.
>>>>
>>>> Or I won't. It turns out that just swapping the for loop for bpf_for
>>>> leads to -E2BIG from the verifier again. Looking at the verifier log, it
>>>> fails to find equivalence between states at the loop head:
>>>>
>>>>     [...]
>>>>     78: (85) call bpf_iter_num_next#84922 [...]
>>>> fp-56=map_value(map=beauty_payload_,ks=4,vs=24688,imm=112)
>>>>     [...]
>>>>     78: (85) call bpf_iter_num_next#84922 [...]
>>>> fp-56=map_value(map=beauty_payload_,ks=4,vs=24688,imm=120)
>>>>     [...]
>>>>
>>>> IMHO, the reason is that payload_offset, which points to the
>>>> beauty_payload_enter_map entry, gets updated in every iteration.
>>>>
>>>> This could be probably fixed on the perf side by reworking how augmented
>>>> args are stored but at this point, bpf_loop sounds like an easier and
>>>> more reliable approach.
>>>>
>>>> Let me know if anyone has objections, otherwise I'll send v2 of the
>>>> bpf_loop approach, with suggestions from Sashiko incorporated.
>>>>
>>>
>>> I'd still try to adapt bpf_for(), it's a much better code structure.
>>> You probably need to add a bounding checking/confirming `if ()`
>>> condition validating that offset at which you access map_value is
>>> always correct. And/or you might need barrier_var() before using i,
>>> because bpf_for() macro does bounds checking (check the macro itself),
>>> but compiler often will reorder instructions leading to verifier
>>> complaints.
>>
>> I gave it a try but wasn't successful so far. I think that the problem
>> is that while it would be possible to add an upper bound condition for
>> `payload_offset`, the verifier tracks the value of `payload_offset` too
>> precisely (as map_value(..., imm=X) with a concrete offset) and never
>> merges states with different offsets. And since there are multiple
>> branches inside the loop, each incrementing `payload_offset` by a
>> different value, the verifier seems to fork its state on each branch,
>> effectively leading to the amount of states growing exponentially and
>> hitting the jump limit.
>>
>> To me, bpf_loop sounds like a more reliable choice in this situation.
> 
> correctly verified bpf_loop would basically have to follow the same
> logic, so if it works with bpf_loop, it should work with bpf_for. 

Are you sure about that? My perception is that the bpf_loop callback is
only verified once in a single pass. On the contrary, bpf_for is a
normal loop, for which the verifier needs to prove that after some
iteration, we get to the state seen in a previous iteration (to prune
the state). Which never happens here because the offset to
beauty_payload_enter_map (the payload_offset var) is tracked precisely
and causes state forks on every condition inside the loop.

> Is
> it possible to share your bpf_for-based code in some branch to try
> locally? I'm sure it can be done one way or another.

The change is super-simple, I can as well share it here. It's just the
matter of using bpf_for with two additional suggested mechanisms,
barrier_var and a bounds check for payload_offset:

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 2a6e61864ee0..341d77a78949 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -432,7 +432,7 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 {
        bool augmented, do_output = false;
-       int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+       int zero = 0, i, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
        u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
        s64 aug_size, size;
        unsigned int nr, *beauty_map;
@@ -466,12 +466,16 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
         * struct: size of struct             -> size of struct
         * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
         */
-       for (int i = 0; i < 6; i++) {
+       bpf_for(i, 0, 6) {
+               barrier_var(i);
                arg = (void *)args->args[i];
                augmented = false;
                size = beauty_map[i];
                aug_size = size; /* size of the augmented data read from user space */
 
+               if (payload_offset + sizeof(struct augmented_arg) > (void *)payload + sizeof(struct beauty_payload_enter))
+                       break;
+
                if (size == 0 || arg == NULL)
                        continue;
 

Thanks a lot for the help!
Viktor

