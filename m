Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7690010A1D
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710308534; cv=none; b=XvxALkgrGfgvMULOWtjnXYP0sPkwFOe38y2KDTn426zKrMC8ScDB3I/7I64sPXv29zl9+Dq8gBU7MBaPbV7a7HlxtwKZUGApcnBZTab14f/iZV6+z9ddC36KA1UMpv+lrr+2CNGiOAumScv+I7ILVUdvx1EAYBxiy/p9meBO5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710308534; c=relaxed/simple;
	bh=LK3JPLHHcWQqUTtJ9SsnmfPpRWEf1gEHCUvOkVswq9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=px+dc9MJAX7UutoCRnVF4Vq7gjUKOCi4L4O0rHfaKTuAFxVptbVuyR5BZGl5lAeK2cppxDirn2eFGW400o4qZZmOlS/FfSZd8zNzNpzuXA0/DdkBg6R350lKNHyugWUwSX5K5ooNAOYRzAjCylaGgch7KRnfZ0CouymDN33RfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmh1FHjd; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmh1FHjd"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-609f359b7b1so67811797b3.1
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 22:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710308531; x=1710913331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jYo5CzrMczP00LzjQRtbtlKxInAIZNKzChAtT90XBE=;
        b=nmh1FHjdtdOXZ/O8HQuJqmExwoCmuWkcb8HwBTpyuU7EJkjqSUO2QuKsbzu2mgFMeW
         bOCPcOLUYCPJJBppK2yH7ZgmFkwyfGLCIs6GZrdZ1LMjPbwkyD9aKYmw7gkpLd21FTP5
         ybxJ7GFDHFJDnjWAW+ao0XJH7wwZcGb4QavpSqxjo3gqw1Orj94XNCxc9bjs8iUMqdH2
         7HpAT8jmnT8a2TmVRi60/DnjTztGu7y/EVv4cn+mdVezZnJhSV5vMBguEDQiYu/q5t4C
         t/d/bnL+aog0L4wOTLutxfN6hddszobLR+zbWhliZv9n0j6yFqYIj3lhjvD8v4Vb4MNE
         KjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710308531; x=1710913331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jYo5CzrMczP00LzjQRtbtlKxInAIZNKzChAtT90XBE=;
        b=dDCfaBVml+m44RrZvMZhDl0g4DyeTs9Wv1QusSvI0UJ4Y+fzT3qdFOhYcWCJv2uww5
         8ZogTQIkqh56zC8k00+aPrFKPkJOdaCsADQvmXo/tm8LibFG8rXa9qSIOia01QJouA0Y
         rPlkHvqUChR8mex+lfNon9K7/vFXIa74fBlIrEaruSJA4XrDo/XFdi8Fa6eeCL2si0CW
         BqHC7v9InykOfKaS9iDP7yxgni0HEM8ocZkFXh5Aw6M/9w//CbczuxE6mPblY+MLKEKP
         ha3Rl2QookGkLyAF/jHuSDXwEcsx1a2BNf86dl8jKZXI70amAIlYthDHcnm/2DIVTdUO
         waeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmeVUgo5WNlptwp3rtlDKnaaUSRgCXCeEDcmuNcIaDl7Giei0ObRajNRbofKWTGEaxQb2UCxNirxxUFqGraec/cZFc
X-Gm-Message-State: AOJu0Yyzd6HZOujwqj77gftRnptgSzMRM5z0orf+AEDtknAvZ+4tYmAH
	yPElDzlXDm8CBP/Y2LtNl0cW3n8hTPWoMIrSYAyDdqUetutbbBtb
X-Google-Smtp-Source: AGHT+IE0qlIZ5CFmSI6g7hD+kT55roxlB/6IgKmVS4LGqGIbIKuiPChLGOjhMLm9EUt5sEpFLcZXSQ==
X-Received: by 2002:a81:ad03:0:b0:60a:10c7:3932 with SMTP id l3-20020a81ad03000000b0060a10c73932mr1519625ywh.35.1710308531240;
        Tue, 12 Mar 2024 22:42:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a9ce:8a39:867c:8f30? ([2600:1700:6cf8:1240:a9ce:8a39:867c:8f30])
        by smtp.gmail.com with ESMTPSA id g15-20020a81ae4f000000b0060989fa64dfsm2301873ywk.12.2024.03.12.22.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 22:42:10 -0700 (PDT)
Message-ID: <c999d7ce-4c49-4b4e-9e4e-07ed4efc7b79@gmail.com>
Date: Tue, 12 Mar 2024 22:42:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Content-Language: en-US
To: Andrei Matei <andreimatei1@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <olsajiri@gmail.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 lsf-pc@lists.linux-foundation.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Oleg Nesterov <oleg@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <ZeCXHKJ--iYYbmLj@krava>
 <23f9790d-4ab1-4edb-9262-6f982413b3e9@gmail.com> <ZedT8S-GjNOry5LZ@krava>
 <CAPhsuW5_6vkL58Efm3qL9G9W+7i=XVicoLXT6_G+T7TLx=zQJg@mail.gmail.com>
 <412c987b-b1c4-4761-83e4-d46c78a255be@gmail.com>
 <CABWLsevYANVb8TmOF69qtXeEjk6=NVQmsObrFG8r+oqSRMBxpw@mail.gmail.com>
 <097cc830-7a73-4fb8-9c97-b3b337a25f99@gmail.com>
 <CABWLses3HSLcYYHp64nb4CLxq9t7tifh9VzpSAnjnDDAGvr1UQ@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CABWLses3HSLcYYHp64nb4CLxq9t7tifh9VzpSAnjnDDAGvr1UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/12/24 18:32, Andrei Matei wrote:
> On Tue, Mar 12, 2024 at 1:16 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 3/8/24 07:43, Andrei Matei wrote:
>>> On Thu, Mar 7, 2024 at 6:02 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/5/24 15:53, Song Liu wrote:
>>>>> On Tue, Mar 5, 2024 at 9:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>>>>
>>>>>> On Fri, Mar 01, 2024 at 11:39:03AM -0800, Kui-Feng Lee wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2/29/24 06:39, Jiri Olsa wrote:
>>>>>>>> One of uprobe pain points is having slow execution that involves
>>>>>>>> two traps in worst case scenario or single trap if the original
>>>>>>>> instruction can be emulated. For return uprobes there's one extra
>>>>>>>> trap on top of that.
>>>>>>>>
>>>>>>>> My current idea on how to make this faster is to follow the optimized
>>>>>>>> kprobes and replace the normal uprobe trap instruction with jump to
>>>>>>>> user space trampoline that:
>>>>>>>>
>>>>>>>>       - executes syscall to call uprobe consumers callbacks
>>>>>>>>       - executes original instructions
>>>>>>>>       - jumps back to continue with the original code
>>>>>>>>
>>>>>>>> There are of course corner cases where above will have trouble or
>>>>>>>> won't work completely, like:
>>>>>>>>
>>>>>>>>       - executing original instructions in the trampoline is tricky wrt
>>>>>>>>         rip relative addressing
>>>>>>>>
>>>>>>>>       - some instructions we can't move to trampoline at all
>>>>>>>>
>>>>>>>>       - the uprobe address is on page boundary so the jump instruction to
>>>>>>>>         trampoline would span across 2 pages, hence the page replace won't
>>>>>>>>         be atomic, which might cause issues
>>>>>>>>
>>>>>>>>       - ... ? many others I'm sure
>>>>>>>>
>>>>>>>> Still with all the limitations I think we could be able to speed up
>>>>>>>> some amount of the uprobes, which seems worth doing.
>>>>>>>
>>>>>>> Just a random idea related to this.
>>>>>>> Could we also run jit code of bpf programs in the user space to collect
>>>>>>> information instead of going back to the kernel every time?
>>>>>
>>>>> I was thinking about a similar idea. I guess these user space BPF
>>>>> programs will have limited features that we can probably use them
>>>>> update bpf maps. For this limited scope, we still need bpf_arena.
>>>>> Otherwise, the user space bpf program will need to update the bpf
>>>>> maps with sys_bpf(), which adds the same overhead as triggering
>>>>
>>>> That is true. However, even without bpf_arena, it still works with
>>>> some workarounds without going through sys_bpf().
>>>
>>> Anything making uprobes faster would be very welcomed for my project.  The
>>> biggest performance problem for us is the cost of bpf_probe_read_user()
>>> relative to raw memory access. Every call to this helper walks the process'
>>
>> "raw memory access"? Do you mean not going through any helper function,
>> reading from a pointer directly?
> 
> Right.
> I recognize that, as long as bpf runs "in the kernel", one cannot simply
> dereference a user-space pointer since the kernel is a different virtual memory
> space (*). Still, I wish there bpf_probe_read_user() were faster.
> 
> (*) Or, is it indeed a different memory space or is the kernel's virtual
> address space mapped into every process? Did this change through KPTI? I would
> be curious to read a good resource on what exactly it means to switch from
> user-space to the kernel and back, if such a thing exists.

FYI! This is architecture dependent. AFAIK, with x86 platforms, kernel
can access the memory of the user space directly if it is in a
process/task context. But, you should not relies on it.

If you look into bpf_probe_read_user(), it eventually do something like
"rep movsb" on x86 platforms. Access user space memory directly with
some extra checks. So, the bottleneck here can be the extra checks and
memory copying. If you access small chunks like what you said bellow,
the overhead of checks could be expensive.

> 
>>
>>> page table to check that the access would not cause a fault (I think); this is
>>> very slow. I wonder if there's some other option that would keep the safety
>>> requirement for the memory access -- I'm imagining an optimistic mode where the
>>> raw access is performed (in the target process' memory space) and, in the rare
>>> case when a fault happens, the kernel would somehow recover from the fault and
>>
>> I am not very familiar with this part. I read the implementation of
>> bpf_probe_read_user() a little bit. It does what you mentioned here. It
>> would cause page faults, however, the handler will skip the instruction
>> leaving the counter non-zero. By checking the counter, it knows the
>> instruction is not completed, and returns an error.
>>
>> I am curious about what your access pattern looks like. Does it access a
>> large number of small chunks of data? Or, does it access a small number
>> of big chunks of data?
> 
> My access pattern looks like a lot of small reads. Some of these reads could be
> done at the same time if we had a vectorized API (i.e. some of the pointers are
> known in advance); for others there are data dependencies (i.e. we need to
> dereference a pointer to know what we'll want to read next). Specifically, the
> use case is a debugger of sorts which uses BPF uprobes for poking around in the
> target process' memory, rather than the more traditional ptrace-based
> techniques (ptrace being very slow). This debugger needs to walk a lot of
> thread stacks by following stack pointers or by using DWARF unwind information,
> and then it further reads data structures from the target process' stacks and
> heaps, chasing pointers recursively.


A related information. You may already know that bpf_probe_read_user()
can fail if a page fault happens.  A vectorized API probably doesn't
change it. It is a limitation of non-sleepable BPF programs. Sleepable 
BPF programs should be able to overcome it.


> 
> 
>>
>>> fail the bpf_probe_read_user() helper. Would something like that be technically
>>> feasible / has there been any prior interest in faster access to user memory
>>>
>>> A more limited option that might be helpful would be a vectorized version of
>>> bpf_probe_read_user() that verifies many pointers at once.
>>>
>>>
>>>>
>>>>> the program with a syscall.
>>>>>
>>>>>>
>>>>>> sorry for late reply, do you mean like ubpf? the scope of this change
>>>>>> is to speed up the generic uprobe, ebpf is just one of the consumers
>>>>>
>>>>> I guess this means we need a new syscall?
>>>>>
>>>>> Thanks,
>>>>> Song
>>>>
