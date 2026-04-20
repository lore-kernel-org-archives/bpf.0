Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE639DBF5
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706665; cv=none; b=bT6bobK1l7rH+UBzYr0dqY02g7KTtXSbebQ6YHqtemkTC+E1X1LB6ZJ3DVVu94a+FEhGNQyK0/cQ5xXj3+yFzDx/vvLq3YpQBD+4MZEzmby67RGNoI+5jXttCjGeHaTOiUYli3fqSW+MCSo15uGVkiBcZSCdBqVseYQE5lZ0lHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706665; c=relaxed/simple;
	bh=NQ5ZFuCHvqMKcwAS9qFX3TGpzcwy85LgsrLQ4cWY9sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p5h36U+5DxyWqa4vxXrZraEd8Lz2vS6S2GNlj9J+grdZe/TtopX1FL1Tjx4Y3+i0eJaTDJ9LzZ3fe7qDcTa109ywlTos7w4+Y56yE4T81OwGGQj5T5NhNJ3NfIMkz62uYTuNgqxWmdfyPiq0in4oOqLM9XA8UtmEEg8HdGsMcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyDT5N4b; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyDT5N4b"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso30837135e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776706662; x=1777311462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T6GwOOrrq3hAkfT+p4YhB+2/KNTU+lqhJbGkNAV4yvs=;
        b=PyDT5N4bGoP6oR7PyZ+bjbZ/PvGXCtBdSUrOf+mYv4dZ4Izpezgiov7Ywiaa1qQPED
         wVBIyI0EX/G0G+QRmfjrrHeIh1woGdPhCo05pHgyEcU98FvIojqOFeyDgrBOjL1vddvp
         T3uz2URjB7/5PmDcB4IGC4pp2pYF10CtQyZiRQXVM3taUTgXb2mV6PO1gWye7CkVVO/I
         Envjwoq6dhbRf7RRAda5rF42WhrYxtxLHSHMlCFbTYiKbf7wnV6K9uJcvbb8ZEb7hhW2
         cdiXwWMB1G1+kNeAwSuhkAEQVm6zJlTd0vzw+PzOAJ6oqewP+6x/ARP6PiVFE1OQgXeg
         LB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776706662; x=1777311462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6GwOOrrq3hAkfT+p4YhB+2/KNTU+lqhJbGkNAV4yvs=;
        b=A9PbW9UcOr5uZwAXHnBzJt+KT0oT+g/phY0vDT3t3MLSOCLAuoCVFEq+XwqFLAT/kN
         XosE/Uvqs63/XNQdyRHCLJJEoFU0Zf56kH0003Qfnif8WZ764CyU2QazkQHu2iPk9tyU
         2h9Mr/RksIMw8cJwlVhkDHrkxjvhGd03i4DWXJubDKd4tfOl+pAKQOI+hwJULTzKahcO
         ntG6Z7UTGhGff8XbK2PBBJuJuRwymt4Oyf2T6gW9O2v1tCqvtomiwNp/HqPMcFPqC8pJ
         bTU2qqFFSxapMIn5BMnLsJg7LWzq1tufCGg94eybohge4Eqt7JXXlYySXW+QLhx82jxw
         CVug==
X-Forwarded-Encrypted: i=1; AFNElJ/jnXtcbUdWfUBQQLCZF17Qx8xOI+egIw9XRF/rfBAUs+yv9L+n+ZvhJjTnZ+ct+fJdYfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlf9tPSiChcX+qeMPndbcm5LAPkVMqh3+/tqVZ0vO8t8/99jRI
	yhjyFRx0dXZd0GeuBpBjnhqUq+W900RZxlJU6oehuH1AZZv/yoDJwU26
X-Gm-Gg: AeBDiet495vLeY9qiQ2hvt8rJ5ZLRpieGKGTHxZe12DR+RgeUNbWe4pt8DPwuOOqUtY
	7voOdM+IL0lYgz5poiE+IRlqjNadCV397RRxPs+J3Tdrgy1mcn5L7MbJWfVXZ/7ePizkGBIQOsM
	bO/duPWE0eLiYjSuPnMs9WxIyYSbUP926rZ0xe2DZxOtRKBaD3b2o2f54wyPKRR/AwvTwTgrGdy
	VMxdnKMyvRikm1kEt0TUQZNOqrzKry7NuUHkblOCyRUnEd4/wafo7YdGqRsCmKDck7MBHVLf2TE
	D7/zF855zzdn9CpdA2TIJe+wJdszo5bELhnGbo2rSx5WRAMEDjV0ctpHMMaTpH8D88mpmbzV/zc
	qGcZgcOA0s0zPUjtVK29RZEkeXoxICGIe604m3mI4CuL4EXNS420JCFzOY2qu1/LaX0n3hYkOm5
	NLzf713wB9R1NoBUPjaTVQhkA77IUArweE9/KESwe8m4vhm2rYRYs5jXRt9UcRdPMsht4fKw==
X-Received: by 2002:a05:600c:1385:b0:485:4eaf:eb54 with SMTP id 5b1f17b1804b1-488fb78260bmr196801305e9.20.1776706661960;
        Mon, 20 Apr 2026 10:37:41 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5432:2d05:ea5:f7f7? ([2620:10d:c092:500::6:8ffd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm314491825e9.15.2026.04.20.10.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 10:37:41 -0700 (PDT)
Message-ID: <a29a0db1-1beb-4e78-a499-81958dedf6ac@gmail.com>
Date: Mon, 20 Apr 2026 18:37:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] KCSAN: data-race in bpf_obj_memcpy /
 bpf_obj_memcpy
To: syzbot <syzbot+44044637ef892e79ca2b@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <69e63489.a00a0220.17a17.0005.GAE@google.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <69e63489.a00a0220.17a17.0005.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/20/26 3:13 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c1f49dea2b8f Merge tag 'mm-hotfixes-stable-2026-04-19-00-1..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10ec34ce580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d3740f7f69b18f59
> dashboard link: https://syzkaller.appspot.com/bug?extid=44044637ef892e79ca2b
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4ed91de40e47/disk-c1f49dea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7353bf53627b/vmlinux-c1f49dea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ab6db1fcd59d/bzImage-c1f49dea.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+44044637ef892e79ca2b@syzkaller.appspotmail.com
> 
> netlink: 676 bytes leftover after parsing attributes in process `syz.4.735'.
> ==================================================================
> BUG: KCSAN: data-race in bpf_obj_memcpy / bpf_obj_memcpy
> 
> write to 0xffffe8ffffa24c00 of 1404 bytes by task 6603 on cpu 0:
>   bpf_obj_memcpy+0x13c/0x1a0 include/linux/bpf.h:-1
>   copy_map_value include/linux/bpf.h:557 [inline]
>   bpf_percpu_array_update+0x1e1/0x2d0 kernel/bpf/arraymap.c:443
>   bpf_map_update_value+0x260/0x570 kernel/bpf/syscall.c:275
>   generic_map_update_batch+0x52d/0x680 kernel/bpf/syscall.c:2025
>   bpf_map_do_batch+0x25c/0x380 kernel/bpf/syscall.c:5689
>   __sys_bpf+0x6a2/0x7e0 kernel/bpf/syscall.c:-1
>   __do_sys_bpf kernel/bpf/syscall.c:6361 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:6359 [inline]
>   __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6359
>   x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> write to 0xffffe8ffffa24c00 of 1404 bytes by task 6604 on cpu 1:
>   bpf_obj_memcpy+0x13c/0x1a0 include/linux/bpf.h:-1
>   copy_map_value include/linux/bpf.h:557 [inline]
>   bpf_percpu_array_update+0x1e1/0x2d0 kernel/bpf/arraymap.c:443
>   bpf_map_update_value+0x260/0x570 kernel/bpf/syscall.c:275
>   generic_map_update_batch+0x52d/0x680 kernel/bpf/syscall.c:2025
>   bpf_map_do_batch+0x25c/0x380 kernel/bpf/syscall.c:5689
>   __sys_bpf+0x6a2/0x7e0 kernel/bpf/syscall.c:-1
>   __do_sys_bpf kernel/bpf/syscall.c:6361 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:6359 [inline]
>   __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6359
>   x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 

This looks like a design choice - no explicit synchronization for percpu 
data updates, for performance reasons.
 From the syscall side it's possible to use external lock. From BPF in 
NMI context torn writes risk is acceptable.

