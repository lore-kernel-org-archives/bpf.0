Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB0421CC5C
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200459; cv=none; b=jlHmVNUpCKm7Xawmxt07IPjeYVBiWXnjeXQO31HESh7KI1liMEABWOvE2kZqq41wC3TcbJkwKiguTZy+ktmeP0WPyn19g1ptxXz3K0ixIEkFEdSKa01LO6xWmFWahu4S7luTAtq+d/woEMFhbQzoVincbCrU+yvJzShhXVxk5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200459; c=relaxed/simple;
	bh=Rv4a/ZwuMlprBGTkGl25aJZb/pq+nkMSU8+X4N67UUY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=R0l/bR3QWuUmELlRX7kxp6XlvvNA5oHwReRIWF4KdHWcbh24IHf9tfCKmr96YKbj2OtkftOabk19J4C+cPWs1kyLIaqo8hJllFPxTLT6gNvobrLMlW/vqX17NKs1hFpA2Wim8rdk8eiFBkeZrMnePmxbJ+lm9pKQ3H1GzFm6tnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=SJpS0fhj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="SJpS0fhj"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84a652535dcso2021371b3a.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 18:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785200457; x=1785805257; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SvwuWo6QBd0znbzB9xca22veiRMAvnRdnxWbmn1rCUk=;
        b=SJpS0fhjRLahTw6PEwFzqkGmtFxEf6CJ90QW94DFzba0T7qOA7se/g6PLiPiAds0P2
         sJ5S8xBiejFhzOMvytENOkvC+MxVeWUBY8CfENClt4jyt00u02ax/+fcy7Mr/PsLzQ7Y
         yu+FX5wYiGHl4/f3yG0bK/TIKAIDG34y58FFXxgrQqOADNKeuz4QlPGA1lwnVnZwWQEH
         dD9kib0exkbtx1J31bTN51mj2f1Rjk09axuJluy7HDRXG7kZ19EURrpCmEGyFtx8ZEHg
         kmNNXgcZTlv+w6AXWEboCA8WcnksNRXbE8tQCZxEIC8W5Z/dp7KEPSlvc2oFnfdxvenL
         H7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785200457; x=1785805257;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SvwuWo6QBd0znbzB9xca22veiRMAvnRdnxWbmn1rCUk=;
        b=g1+PQfdRDCa7q6u3ZUuL8bRgXaELdZd+mcVtBLzmQY+TqADg8V5mUVHe8xVpoNWSKO
         n2Y4/6/HlzMUwpPZaMQWkV4XTkWLlsb4f1gT/4XA00DE6BoLHYt+kVqSu7YYnxwK+5VN
         /oaH073dJNMLVW1v594HEflBzya0QLOp1MNmSlevabDsXiOHYc7O43W56TJ5CxYr+9rW
         QAZq7vGn8nmtGdctBoYd7t31izroWevXLfP8nHJ2dkXK62T3MqD/6ND2iEMgCvXG540j
         1VSkLXV+sCs+z6SHHiRrHHVx7FXYF8Okq79s8heDKgRew48LD9q1lFngU8OnzCzxYF/Z
         Y7eQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDjRhf3hQmyePheUhhpIRlSi4D8Eqyx6Q8FAzEvLISEeHiwR4oLwuhZBwI6Mf5d2oHvfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/OUGAOVDlqd20po+c3PXEEVOM08vr+NCwIhKGjoAklmRDXNx
	IzfBg0G6+V1QHEDN9zxbVu/6/m/L4QvqdpMaI1W0JvbbBfba7+dqLYAOxUQAvsvus4k=
X-Gm-Gg: AR+sD13LKAjKyZMf038Dfw8ce5lfgKK4Ij/C5iM7RRKJQhBDh3xTdKsVgU6rQUF436K
	owz+qnSjFSkOlkc7fHvmNjYRk/xLQd4v5KNI495DLTLOu7qtA0zWtit2JzP1rqJ44rVZgZRGND7
	rj8+z/ocpKrv6vj4L6AdvpZcE7DH7H+JuGSDSgsCgwZejuMH7N96xnvqH2xn3ye07rxex08CQv8
	QiPj4ceopYianG98IiYmZ4Jhx+vE3P/jP7OrUUJkaVOzeAjGUZoMDmIJKyOKE/SaK7jFWzxN09e
	59peuNqNxItGyrDPuexWExSYuOiYUX7fyAhU9OJj8DiiusrwPYZXVXhiFm3EaBPf/7q+fwj71uw
	7nzmzyzXQt1QQRLxMWIiLPTV2riu4qOokd+vv3gdIy22h38dkj1IWceOq8rAOF7Ac8UGK5usnXW
	ydLQVb4YdCvTtcmD2MQr4e4YU8YDVyXjY=
X-Received: by 2002:a05:6a00:1486:b0:845:c662:2be with SMTP id d2e1a72fcca58-84e932ee091mr202766b3a.42.1785200457053;
        Mon, 27 Jul 2026 18:00:57 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53258428sm3756444b3a.12.2026.07.27.18.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 18:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 21:00:55 -0400
Message-Id: <DK9SQVLBF4SG.2FDO076LD2E0M@etsalapatis.com>
Cc: <linux-rt-devel@lists.linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: arena: allocate the fault-in page
 outside the lock
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>,
 <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
 <20260727062521.376231-3-jiayuan.chen@linux.dev>
 <20260727064257.01BD81F000E9@smtp.kernel.org>
 <9a961b42-d095-4052-a749-dfabb9a45bf3@linux.dev>
In-Reply-To: <9a961b42-d095-4052-a749-dfabb9a45bf3@linux.dev>

On Mon Jul 27, 2026 at 4:00 AM EDT, Jiayuan Chen wrote:
>
> On 7/27/26 2:42 PM, sashiko-bot@kernel.org wrote:
> [...]
>>> @@ -489,55 +490,97 @@ static vm_fault_t arena_vm_fault(struct vm_fault =
*vmf)
>>>   	kbase =3D bpf_arena_get_kern_vm_start(arena);
>>>   	kaddr =3D kbase + (u32)(vmf->address);
>>>  =20
>>> -	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>>> +	page =3D vmalloc_to_page((void *)kaddr);
>>> +	if (!page) {
>>> +		/*
>>> +		 * Preallocate outside the lock so the allocation can sleep and go
>>> +		 * through reclaim (both memcg and global), the way do_anonymous_pag=
e()
>>> +		 * does. Under arena->spinlock only the non-blocking allocator is
>>> +		 * available, which never reclaims.
>>> +		 *
>>> +		 * This has to be the sleepable variant: VM_FAULT_OOM below is only
>>> +		 * meaningful if the OOM machinery was actually engaged. A failure
>>> +		 * from the non-blocking allocator engages nothing, so the fault
>>> +		 * would be retried forever.
>>> +		 */
>>> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>>> +		new_page =3D bpf_map_alloc_page_sleepable(map, NUMA_NO_NODE);
>> [Severity: High]
>> Is there a potential Denial of Service vector when BPF_F_SEGV_ON_FAULT i=
s set?
>>
>> This unconditionally preallocates a page using
>> bpf_map_alloc_page_sleepable() before checking the BPF_F_SEGV_ON_FAULT
>> flag later in the function.
>>
>> This allocation can block, trigger direct memory reclaim, and invoke the
>> OOM killer. Only after this expensive allocation does the code lock, che=
ck
>> the flag, return VM_FAULT_SIGSEGV, and discard the page.
>>
>> Could this allow an unprivileged user to force severe memory pressure by
>> repeatedly triggering page faults on unallocated addresses?
>
> Once VM_FAULT_SIGSEGV is returned, the process gets a SIGSEGV and by=20
> default is killed,
> so this isn't a realistic DoS.
>
> But, I think it's worth moving the "arena->map.map_flags &=20
> BPF_F_SEGV_ON_FAULT" check before the allocation.
>
>
>>> +		bpf_map_memcg_exit(old_memcg, new_memcg);
>>> +		if (!new_page)
>>> +			return VM_FAULT_OOM;
>>> +	}
>>> +
>>> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
>>>   		/* Make a reasonable effort to address impossible case */
>>> -		return VM_FAULT_RETRY;
>>> +		fault_ret =3D VM_FAULT_RETRY;
>>> +		goto out_err;
>>> +	}
>> [Severity: High]
>> This is a pre-existing issue, but does returning VM_FAULT_RETRY here
>> without releasing the fault lock cause a lock leak?
>>
>> The memory management subsystem strictly assumes the lock was released
>> if VM_FAULT_RETRY is returned. Retrying the fault will leak the read loc=
k
>> reference, and if any thread subsequently attempts to acquire the mmap_l=
ock
>> for writing, the system could permanently deadlock.
>
>
> Yes, it's true. arena_vm_fault() never touches mmap_lock, so returning=20
> VM_FAULT_RETRY violates the contract.
>
> '''
> do_user_addr_fault()
> {
>  =C2=A0 =C2=A0 fault =3D handle_mm_fault(...);=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 // call arena_vm_fault
>  =C2=A0 =C2=A0 ...
>  =C2=A0 =C2=A0 if (unlikely(fault & VM_FAULT_RETRY)) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D FAULT_FLAG_TRIED;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto retry;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // lock_mm_and_find_vma() will=20
> call mmap_read_lock again !
>  =C2=A0 =C2=A0 }
>  =C2=A0 =C2=A0 mmap_read_unlock(mm);
> }
> '''
>
> I think I should fix it as a separate patch with high priority ?

Please do, I think it makes sense as a separate patch targeting the
bpf tree while this patchset can keep targeting bpf-next.
