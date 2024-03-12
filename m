Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67F137C3A
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263764; cv=none; b=a3UoqtlVWrKePyVjwtcC5QQQM3+Vvp3IxFWPkJeCQuDtlnr5LWcMgqKWhyOJB9WmJGOj0Mw4Qlx4nZgyakNboZaMDC95BAaAPWZE7w930Yif0ERGfMdnQW1ADLaXRrCYC5xX7tNwz8jB3eLax3UoLpkiVEpFIiBXmGOD/FHSLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263764; c=relaxed/simple;
	bh=RUe5m4EEhKMkFZ8gaaQP+ne5G+pt7oLAs7FRN/D/DsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7XPeWcPHvaVy9/wjKcxcsoiZpaCQjVxhw9M6Tour0LAMr0zqVvj0lrLuDkqtxcKADOzhfutC5O6hvTp50+lAsirdbhZI4L+2HlYjbn0vzMyzSpNaVpGUYA+YgixV9jgkeRFkQykjDwUjRZ4sbI/LIVlVm0/RX4dGIb25eJcYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Atzm4z9y; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Atzm4z9y"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a1bf69a3a5so1973751eaf.2
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263762; x=1710868562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gSfhfXmzN7W5ozoJ9i9I4/FllRNGXl+jkzJKizkbu0=;
        b=Atzm4z9yuK2eM+vz0TFFZIiUq7PZtXF9X3TKIl1YLR4AunJW2aTE1LPLByhxDqRPC9
         gUpO4fuqm72H986rT9x5I7o69DGyop7VHwa0wJqwKN0aY0m8gHz4PdeBeM/CGTX6kXMO
         VhPErWbreHG1fWi1PxCvtAiTRIq78elRwCdwtbAiic+piBUt866CSp0MHJ5R9matDaD7
         ZeB6Rvd7aHoYEfYSuN4tHd7xNeHZPfqgMfPx3kjIY+hrWiV4xcQydED8FdO8qrWXyODm
         QtXTRl1piBToRwn1PPvoRz1WG8Z+pUGLXrsPbZwLhu5s49jOF37SjtYJO0cCeol8lWjS
         xdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263762; x=1710868562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gSfhfXmzN7W5ozoJ9i9I4/FllRNGXl+jkzJKizkbu0=;
        b=KWxPmfN97al5zq6mtuIlX331PfF2Jf/3hjIlRA7n0t9wSTYHkZzuiXqmYLGcoH+tdZ
         1SgDEUWyy9vop4cPQAXvz+vuDm5SNHsDHpo211Gx5bnWLyoqr5t21PnQvV0RgYIv9am5
         3NwZJtBs3Ip4J5EXCmoUratyAacKPXNLt6MDwa3RxPRmPZZAw4hPUUGiEuMNScrj5pus
         Pu39ZsNr3HTiirk6gCE7gUgSTzUM29eiC3PkX/8HTWXFAWZNtA+IwQ7zuhJsehvMd2O9
         jZR17+Y5jb+zqWJ90EJjBxIDrDzmOQta1b8TKSMxZDlHYh9SRKmpXnsJe1A/07SisFOq
         Ek5w==
X-Forwarded-Encrypted: i=1; AJvYcCW4ArYS+i/YIDxBB1idYzi+aLFBn8cHa0erRMzRa3CCAdr10uoC/FUefPX71yGoM26N6MYoblSgCF3LFL7YPeq9aMsB
X-Gm-Message-State: AOJu0YwN0mZo8NCIZz29lDdliQ2Pvb6qjZy6BwF08MXtlMKMbS9XcvXI
	00WL4aA1/vwsb+syf91WzpY0dLZMOyEZomYj70YhT/iNHez+qEJO
X-Google-Smtp-Source: AGHT+IEq96bZ2kPTUQ2uP4z/wMCDPG8XLpKm/7E1VAl19HPCQvCYH2rorluEQPqZzzFXQKWiMlmnBg==
X-Received: by 2002:a05:6358:1209:b0:17b:f464:e14b with SMTP id h9-20020a056358120900b0017bf464e14bmr2707445rwi.13.1710263762321;
        Tue, 12 Mar 2024 10:16:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:b4ae:c2f4:b38f:1540? ([2600:1700:6cf8:1240:b4ae:c2f4:b38f:1540])
        by smtp.gmail.com with ESMTPSA id b8-20020a0dd908000000b00608a5d25dc1sm2021881ywe.77.2024.03.12.10.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 10:16:01 -0700 (PDT)
Message-ID: <097cc830-7a73-4fb8-9c97-b3b337a25f99@gmail.com>
Date: Tue, 12 Mar 2024 10:16:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
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
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CABWLsevYANVb8TmOF69qtXeEjk6=NVQmsObrFG8r+oqSRMBxpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/8/24 07:43, Andrei Matei wrote:
> On Thu, Mar 7, 2024 at 6:02 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 3/5/24 15:53, Song Liu wrote:
>>> On Tue, Mar 5, 2024 at 9:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>>>
>>>> On Fri, Mar 01, 2024 at 11:39:03AM -0800, Kui-Feng Lee wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2/29/24 06:39, Jiri Olsa wrote:
>>>>>> One of uprobe pain points is having slow execution that involves
>>>>>> two traps in worst case scenario or single trap if the original
>>>>>> instruction can be emulated. For return uprobes there's one extra
>>>>>> trap on top of that.
>>>>>>
>>>>>> My current idea on how to make this faster is to follow the optimized
>>>>>> kprobes and replace the normal uprobe trap instruction with jump to
>>>>>> user space trampoline that:
>>>>>>
>>>>>>      - executes syscall to call uprobe consumers callbacks
>>>>>>      - executes original instructions
>>>>>>      - jumps back to continue with the original code
>>>>>>
>>>>>> There are of course corner cases where above will have trouble or
>>>>>> won't work completely, like:
>>>>>>
>>>>>>      - executing original instructions in the trampoline is tricky wrt
>>>>>>        rip relative addressing
>>>>>>
>>>>>>      - some instructions we can't move to trampoline at all
>>>>>>
>>>>>>      - the uprobe address is on page boundary so the jump instruction to
>>>>>>        trampoline would span across 2 pages, hence the page replace won't
>>>>>>        be atomic, which might cause issues
>>>>>>
>>>>>>      - ... ? many others I'm sure
>>>>>>
>>>>>> Still with all the limitations I think we could be able to speed up
>>>>>> some amount of the uprobes, which seems worth doing.
>>>>>
>>>>> Just a random idea related to this.
>>>>> Could we also run jit code of bpf programs in the user space to collect
>>>>> information instead of going back to the kernel every time?
>>>
>>> I was thinking about a similar idea. I guess these user space BPF
>>> programs will have limited features that we can probably use them
>>> update bpf maps. For this limited scope, we still need bpf_arena.
>>> Otherwise, the user space bpf program will need to update the bpf
>>> maps with sys_bpf(), which adds the same overhead as triggering
>>
>> That is true. However, even without bpf_arena, it still works with
>> some workarounds without going through sys_bpf().
> 
> Anything making uprobes faster would be very welcomed for my project.  The
> biggest performance problem for us is the cost of bpf_probe_read_user()
> relative to raw memory access. Every call to this helper walks the process'

"raw memory access"? Do you mean not going through any helper function,
reading from a pointer directly?

> page table to check that the access would not cause a fault (I think); this is
> very slow. I wonder if there's some other option that would keep the safety
> requirement for the memory access -- I'm imagining an optimistic mode where the
> raw access is performed (in the target process' memory space) and, in the rare
> case when a fault happens, the kernel would somehow recover from the fault and

I am not very familiar with this part. I read the implementation of
bpf_probe_read_user() a little bit. It does what you mentioned here. It
would cause page faults, however, the handler will skip the instruction
leaving the counter non-zero. By checking the counter, it knows the
instruction is not completed, and returns an error.

I am curious about what your access pattern looks like. Does it access a
large number of small chunks of data? Or, does it access a small number
of big chunks of data?

> fail the bpf_probe_read_user() helper. Would something like that be technically
> feasible / has there been any prior interest in faster access to user memory
> 
> A more limited option that might be helpful would be a vectorized version of
> bpf_probe_read_user() that verifies many pointers at once.
> 
> 
>>
>>> the program with a syscall.
>>>
>>>>
>>>> sorry for late reply, do you mean like ubpf? the scope of this change
>>>> is to speed up the generic uprobe, ebpf is just one of the consumers
>>>
>>> I guess this means we need a new syscall?
>>>
>>> Thanks,
>>> Song
>>
