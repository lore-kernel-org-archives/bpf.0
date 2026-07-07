Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAD3822B4;
	Tue,  7 Jul 2026 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410250; cv=none; b=mZh/XbFvltWf5bfWdlDN1BVk39h/rvDjlVjnJea17Jx8lKiDVqifvJ1t7nb7RPB4x2pF5pd+WKzkjTWDdd+hucJWnm3SxSLLv9Kl2ctcZcgdiAmIWEXFiJ1HBbZruQJzE9OnttvRgar7RyK2rPaOP7JReojvg/bTt9ArYZ683o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410250; c=relaxed/simple;
	bh=BBbfLvqDID8YchNfmZFe5VebhTs5Ud+J4xYQBvqnNsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZfhrnbDZOiYMWW3OLpjBKzz6pli3dvlnfQSDgUUJnWv5HPBS0UPsNZBBO7kVTo7Q9mU5/F6UwCbcQ96grX43oOkcPkdOgZ6feV2rJdgSMSKgVF1N2Nh+eZmgFEMXy4jZU/Me/ulR1URnmFRtFk+Y6LMK70CnwvT2PVBtzfLf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=H+NIDraq; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="H+NIDraq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FK4/rcWvQ8+adjapmlBy/smcwe3DTACtgrBRR6QInAM=; b=H+NIDraqfUXLGAaKkCbMst0Kyz
	s7yK64RLQV8duGC8U5s0ERoBcVdAjRQgmT/XdCATS/b2nGM3iQCVYrfyOlOJGpNOCQ+G9Cpn6pJYH
	RJyvzlPIkOMN4cocqlcSATqwMgqjHnCC7XiDnZ8du1cq1NhvA/HCw6Bw783apC9oFF77KVnT38DPr
	OwVT/vJktv4twV4TkWo5n3qZ/eMSUYjX3PHwbpcoQQubRFengiT9l0vCRFvJoEIXg3hUGhEHOEfGQ
	fKG7wuFeAs1zHc/wL0TiWTeWfqtMMQkm4UUmZDZz9tELloS2yzhL0pCNVHjycd1kSbu8MXsAmFFTk
	pIm+ToQQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wh0TI-0000Va-0Q;
	Tue, 07 Jul 2026 09:44:00 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wh0TG-0005K2-21;
	Tue, 07 Jul 2026 09:43:59 +0200
Message-ID: <4d09e590-9b03-4025-b334-ea2351770b57@iogearbox.net>
Date: Tue, 7 Jul 2026 09:43:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6] bpf: Fix use-after-free on mm_struct in
 bpf_find_vma()
To: Puranjay Mohan <puranjay12@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260630032543.3165720-1-sanghyun.park.cnu@gmail.com>
 <CAEf4Bzby1M8OPRomzEq-xvciK-Zq2zoL0AoSn=iSR02t=wdNOg@mail.gmail.com>
 <CANk7y0g+tk_C9jF6c0420NDEyeM7LYgYyoCkKxy1utB46GnDUw@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <CANk7y0g+tk_C9jF6c0420NDEyeM7LYgYyoCkKxy1utB46GnDUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28053/Tue Jul  7 08:24:37 2026)

On 7/6/26 1:28 PM, Puranjay Mohan wrote:
> On Wed, Jul 1, 2026 at 8:48 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Jun 29, 2026 at 8:25 PM Sanghyun Park
>> <sanghyun.park.cnu@gmail.com> wrote:
>>>
>>> bpf_find_vma() reads task->mm and calls mmap_read_trylock(mm) without
>>> holding a reference on the mm. On a foreign task, a concurrent exit_mm()
>>> can free the mm_struct between the lockless read and the trylock,
>>> resulting in a use-after-free. mm_struct is not SLAB_TYPESAFE_BY_RCU.
>>>
>>> For the current task, task->mm is stable. For a foreign task, pin the mm
>>> under task->alloc_lock and release it with mmput_async(), mirroring commit
>>> d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded task_vma iterator").
>>> Use spin_trylock() instead of get_task_mm() so BPF context does not block
>>> on alloc_lock. Reject irqs-disabled contexts and !CONFIG_MMU on the
>>> foreign-task path because dropping the mm reference is not safe there.
>>>
>>> Race:
>>>
>>>    CPU0 (BPF program)                  CPU1 (exiting task)
>>>    ============================        ==========================
>>>    bpf_find_vma(foreign_task):
>>>      mm = task->mm
>>>                                        exit_mm():
>>>                                          task->mm = NULL
>>>                                          mmput(mm) -> frees mm_struct
>>>      mmap_read_trylock(mm)
>>>          // UAF on mm
>>>
>>> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>> Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
>>> ---
>>
>> Puranjay, PTAL, I think you've been fixing similar issue in
>> bpf_iter_task_vma_new(), would be nice for you to check this fix as
>> well. Thanks!
>>
>>> v6:
>>>   - Restore bpf_iter_mmput_async() because bpf_iter_task_vma_destroy()
>>>     still uses it.
>>>   - Keep the direct mmput_async() call in bpf_find_vma(), but guard it with
>>>     CONFIG_MMU because mmput_async() is declared only for CONFIG_MMU builds.
>>> v5: https://lore.kernel.org/bpf/20260630023443.3026627-2-sanghyun.park.cnu@gmail.com/
>>>   - Replace bpf_iter_mmput_async() with mmput_async() directly as suggested
>>>     by Yonghong.
>>>   - Add Yonghong's Acked-by.
>>> v4: https://lore.kernel.org/bpf/20260610024637.343364-1-sanghyun.park.cnu@gmail.com/
>>>   - Use [PATCH bpf-next] subject as requested by Alexei.
>>>   - Add the missing BPF maintainers/reviewers to Cc.
>>> v3: https://lore.kernel.org/bpf/20260609105216.3536839-1-sanghyun.park.cnu@gmail.com/
>>>   - Drop get_task_mm()+mmput(); mirror d8e27d2d22b6 with alloc_lock
>>>     trylock + mmput_async(). (Yonghong Song)
>>>   - Reject irqs-disabled contexts on the foreign-task path.
>>>   - Reject foreign-task path when !CONFIG_MMU: bpf_iter_mmput_async()
>>>     falls back to mmput() which may sleep, and bpf_find_vma() can run
>>>     in non-sleepable context.
>>>   - Shorten the foreign-task rationale comment and trim the changelog body.
>>>   - Fix the v2's whitespace damage.
>>> v2: https://lore.kernel.org/bpf/CAOrxSK5_7e4114VyfEU9htGi+UneuNt88fGVKOAa3_ZenPOFkA@mail.gmail.com/
>>>
>>>   kernel/bpf/task_iter.c | 36 +++++++++++++++++++++++++++++++++---
>>>   1 file changed, 33 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>>> index fc5f463ca529a..1d56193caf5e4 100644
>>> --- a/kernel/bpf/task_iter.c
>>> +++ b/kernel/bpf/task_iter.c
>>> @@ -760,6 +760,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
>>>          struct mmap_unlock_irq_work *work = NULL;
>>>          struct vm_area_struct *vma;
>>>          bool irq_work_busy = false;
>>> +       bool mmput_needed = false;
>>>          struct mm_struct *mm;
>>>          int ret = -ENOENT;
>>>
>>> @@ -769,14 +770,38 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
>>>          if (!task)
>>>                  return -ENOENT;
>>>
>>> -       mm = task->mm;
>>> +       if (task == current) {
>>> +               mm = task->mm;
>>> +       } else {
>>> +               /*
>>> +                * Foreign task: pin task->mm against a concurrent exit_mm().
>>> +                * Use trylock on alloc_lock instead of get_task_mm()'s
>>> +                * blocking task_lock() to avoid deadlocking the target task.
>>> +                */
>>> +               if (!IS_ENABLED(CONFIG_MMU))
>>> +                       return -EOPNOTSUPP;
>>> +               if (irqs_disabled())
>>> +                       return -EBUSY;
>>> +               if (!spin_trylock(&task->alloc_lock))
>>> +                       return -EBUSY;
>>> +               mm = task->mm;
>>> +               if (mm && !(task->flags & PF_KTHREAD)) {
>>> +                       mmget(mm);
>>> +                       mmput_needed = true;
>>> +               } else {
>>> +                       mm = NULL;
>>> +               }
>>> +               spin_unlock(&task->alloc_lock);
>>> +       }
>>>          if (!mm)
>>>                  return -ENOENT;
>>>
>>>          irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
>>>
>>> -       if (irq_work_busy || !mmap_read_trylock(mm))
>>> -               return -EBUSY;
>>> +       if (irq_work_busy || !mmap_read_trylock(mm)) {
>>> +               ret = -EBUSY;
>>> +               goto out;
>>> +       }
>>>
>>>          vma = find_vma(mm, start);
>>>
>>> @@ -786,6 +811,11 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
>>>                  ret = 0;
>>>          }
>>>          bpf_mmap_unlock_mm(work, mm);
>>> +out:
>>> +#ifdef CONFIG_MMU
>>> +       if (mmput_needed)
>>> +               mmput_async(mm);
>>> +#endif
>>>          return ret;
>>>   }
>>>
>>> --
>>> 2.48.1
> 
> Thanks for this, it looks good to me.
> 
> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

Applied, thanks! Could either you or Sanghyun look into the pre-existing
sashiko-reported issue as well?
