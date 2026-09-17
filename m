Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492E4E4C35
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661184; cv=none; b=jKGHqsKhUNrz2jzq878SbXQTIQ26Zvtkajpxug5l8iYZ9P9znpvKbOqNb3BnP3wYF3dwloJsC7sAMoNj975IOapBWmAVE7v6q+bpDydDWiIwRlhN+hL2YqdQefFuJTuX6ssBwMAYX6j/tQ1cLD0gdnPIyhjbOKgbwZAk9rI/P9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661184; c=relaxed/simple;
	bh=4lYMxAnxYgtT0+GbzpV2JdL2Ry7TLbUvlnz6WRSBqCQ=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=b43D3k1mirNUQkimnDMh+3il7r4E3QGOST+g+74nGXqcdLQXqXogHobjlUFfuqC7KRBHGk4WzbZjaEAq2THBDxyYV5XSfttcN2jqi5wS5Mg8/YKuQSj/gcR0+A1Q3TO1TLIFvYNUgFh1yxZICDp9PGFWIHRHLiQnLWalzJnUgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZxpXr3FO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZxpXr3FO"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-939f5f82829so84853185a.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789661181; x=1790265981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zb/rJ/ij4dBANOQDlvdvkPcPAUB1WlQ7k+q4Vg9N9w0=;
        b=ZxpXr3FOLFqSkMECl/XIfpPaUiDbrFWrSQXn75+GuGyk9jrnu2NHi6SmyUOCHJr9ZO
         XzBhrk3Z63EAu5x7xJbLClih/kApzHO96tdUsOFyisiCeJ/Au0WRvNyih/heW73V8jw/
         Pdf3ytQKeILDaGSLLXjz6/l1f41yENpLCH9OWhT2WWJHZC9IrNjKjfWWN5WbdGS9VTPI
         4ovoAzvtJR4RYa04HwzS2gEKauTqA6EF3/4zIQxy39RjcQ34qD0uIJ5Ld6OSqMqgjyXi
         YBtyomh/IttJdEHfQXxHqU3xYV208z1JRQgAS6UPmayVuNfm8SUMIYRqAO8mdZ6PHW5x
         eSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661181; x=1790265981;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zb/rJ/ij4dBANOQDlvdvkPcPAUB1WlQ7k+q4Vg9N9w0=;
        b=RbanEft2d18yfDtefTXvOBAeYVDZKyAG3RCuwjgAct3MHoII0w7EpB1vZf/TFiHixE
         0v/gYLYzqSXP3d2mrA+AfY6UsScouv/oJ6smePng2q855SRiinCaYMfrNgxm40tM1EJY
         bHjO0EWW/GbFSug+p3CzNmTi8URf5XsXHU6n5YKBFjdMTUIeTM0xVBWe+ub8EUG7SfEE
         ZI+rQnHw60LL1hXvhxbVXiVGoPrGC5A8HLThoF3Hnhr/gdrnlXNf9WMT3Tte87diLU2W
         PDuRLLEKINe/64lvRp3SFTcOhIViwpa/6dCihPlORECKiwsa/Lp1zoIboXBfP6IUsXZO
         QIow==
X-Forwarded-Encrypted: i=1; AKwUvBzGf8Kn64pWB2q6XkHAG+GE92YHwa4cWW/0ggknrCDhCAMC/2EFZjpdIMx+XsvbT3KsYbs=@vger.kernel.org
X-Gm-Message-State: AFuF++kMJ/ZGaC4FNfGsVSHUhzzlf1VqUb51+BCx7T4YlrgB3RKMTcq3
	XQpNYNauIMBbkWxPc9F4sYglPz60nQ2fwV9g6QNyRTd0Iqpm/keu+UH/2X3ymLcPJkCU03KlUCf
	IstL8uQ==
X-Gm-Gg: AYBFou3dY98j84nj78FPWd3TqI55q7RBMDpfo+PyqgnYhiSmP2fvBLM4yAzaQ/tNF/X
	cIgbLUl4qANu+JXoigeU4EClCsRTvaa2pNDVzZpu5tKIfuhNkhkp9RJLfWvqBSuXz2mEV2Z3Jc6
	TX89n3sNCuUsPA9L7x5HDdAMr1CYNmrnY93w/SscRf+/0iYQxNTd/FdevCS/mtzfQm7auRrnMFz
	nP5H680KNSGx0D7vW9/jrippvmcFJm4/3+XaK1v7tMF5z8qHQ9BW0NFwmTHTWJ+bFMb1csLPvTz
	85Xiz+GRuhPOsh8kAYI41rldn/83dHp7c0+IQqSZ4+rFqsUD+PEcbSYbrHajiPJiACujsgg/gg/
	q+6D1X+s5S2KA+y9YtRA6el+yGg4i02bbbWz5maAa53X+K8bXYVxY+puZ/jTxY2MkTE6LTkDEZR
	XbiuXXw1iPlR+qXoZfP/zgNVWFra7OhoOr3U3mJQNiGfIhyPzJMJqGtys1oDBJcyeEdzLtIBgdx
	HkyJTAVvQXxr03mtA68nUO9FDZFdzqfJqvuTVu5
X-Received: by 2002:a05:620a:600d:b0:939:3f4f:7254 with SMTP id af79cd13be357-93bc62a52eamr546059185a.14.1789661179793;
        Thu, 17 Sep 2026 09:06:19 -0700 (PDT)
Received: from [10.99.118.151] ([72.159.227.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81cefa3bsm493113685a.34.2026.09.17.09.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 09:06:18 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, bpf <bpf@vger.kernel.org>, <linux-audit@vger.kernel.org>, "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, <yonghong.song@linux.dev>, <tglx@kernel.org>, <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 12:06:15 -0400
Message-ID: <1a0b01e5cd8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <73701ffd-213e-4842-8b40-f719c1eeaed4@iogearbox.net>
References: <ff563467-0bab-43ec-a46c-a4167bc12473@linux.ibm.com>
 <73701ffd-213e-4842-8b40-f719c1eeaed4@iogearbox.net>
User-Agent: AquaMail/2.7.0 (build: 200700061)
Subject: Re: [BUG] audit/powerpc: WARNING at kernel/auditsc.c:1995 (__audit_syscall_entry) during BPF kselftests (test_progs)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On September 17, 2026 10:03:59 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> Hi Venkat,
>
> On 9/17/26 3:01 PM, Venkat Rao Bagalkote wrote:
>> Hi all,
>>
>> IBM CI has reported a kernel warning triggered in __audit_syscall_entry() 
>> on a PowerPC 64 (ppc64le, POWER9 pSeries guest) system while running the 
>> BPF kselftest suite (test_progs).
>>
>> Environment:
>>
>>
>> Kernel version: 7.3.0-rc3-g238650ef6c7c (PREEMPT)
>> Architecture: ppc64le (POWER9 - IBM,8375-42A pSeries / phyp)
>> Workload: BPF selftests (tools/testing/selftests/bpf/test_progs)
>>
>>
>> Problem Description:
>>
>>
>> During syscall entry processing (system_call_exception -> 
>> syscall_enter_audit -> __audit_syscall_entry), the kernel hit 
>> WARN_ON(context->context != AUDIT_CTX_UNUSED) at kernel/auditsc.c:1995, 
>> indicating that the task's audit context was not reset to AUDIT_CTX_UNUSED 
>> prior to entering the new syscall.
>
> Hm, based on the trace feels somewhat unrelated to bpf, but were you able 
> to bisect in
> case it can be reliably reproduced? Which tree is this, linux-next or 
> bpf/bpf-next?

Thanks for the report Venkat.

Unfortunately due to some unexpected family medical issues I'm not able to 
look into this very closely at the moment (triaging mail on my phone), but 
the related audit code has been fairly stable lately so it seems a bit odd.

I do know that Thomas Gleixner (CC'd) did some work recently on the syscall 
entry code (audit related commit below), perhaps that may be a place to start?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f25517010ddd3f8080d7e06b9b1cb1b64b73772

FWIW, I haven't seen this in any of my testing on x86 or ARM, have you seen 
this on other arches besides Power? Also, as Daniel already mentioned, more 
information on the tree would be helpful.

While I don't have access to a Power system, I'm CC'ing Ricardo Robaina who 
also works at IBM/RH and has experience with the audit kernel code. If this 
appears to be specific to Power, he might be a good resource to help 
diagnose and develop a patch.

>
>> Trace:
>>
>>
>> [ 1371.387510] ------------[ cut here ]------------
>> [ 1371.387528] WARNING: kernel/auditsc.c:1995 at 
>> __audit_syscall_entry+0x50/0x1b0, CPU#17: test_progs/49616
>> [ 1371.387539] Modules linked in: dm_verity(E) dm_bufio(E) reed_solomon(E) 
>> livepatch_sample(EK) tun(E) vrf(E) 8021q(E) garp(E) mrp(E) stp(E) llc(E) 
>> veth(E) bonding(E) tls(E) rfkill(E) nft_fib_inet(E) nft_fib_ipv4(E) 
>> nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) 
>> nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) hvcs(E) 
>> hvcserver(E) pseries_rng(E) vmx_crypto(E) sg(E) drm(E) fuse(E) 
>> drm_panel_orientation_quirks(E) xfs(E) sr_mod(E) nvme_tcp(E) sd_mod(E) 
>> cdrom(E) nvme_fabrics(E) nvme_core(E) ibmvscsi(E) ibmveth(E) 
>> scsi_transport_srp(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E) 
>> [last unloaded: bpf_test_modorder_x(OE)]
>> [ 1371.387607] CPU: 17 UID: 0 PID: 49616 Comm: test_progs Tainted: G        
>> OE K     7.3.0-rc3-g238650ef6c7c #1 PREEMPT
>> [ 1371.387616] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [K]=LIVEPATCH
>> [ 1371.387620] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
>> 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
>> [ 1371.387626] NIP:  c0000000003e70d0 LR: c000000000352080 CTR: 
>> c00000000000cf00
>> [ 1371.387631] REGS: c00000000beafaa0 TRAP: 0700   Tainted: G      OE K     
>> (7.3.0-rc3-g238650ef6c7c)
>> [ 1371.387637] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48002824  
>> XER: 20040084
>> [ 1371.387650] CFAR: c00000000035207c IRQMASK: 0
>>               GPR00: c000000000034958 c00000000beafd40 c0000000020eb200 c0000000345f4800
>>               GPR04: 00007fffe2a31184 0000000000000081 000000007fffffff 0000000000000000
>>               GPR08: 0000000000000000 0000000000000001 0000000000000001 00000000000000dd
>>               GPR12: 0000000000000000 c00000002e99b300 0000000000000000 0000000000000000
>>               GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>               GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>               GPR24: 0000000000000000 0000000000000000 0000000000000000 c0000000345f4800
>>               GPR28: 0000000000000000 00000000000000dd 00000000000000dd c000000138e0c000
>> [ 1371.387710] NIP [c0000000003e70d0] __audit_syscall_entry+0x50/0x1b0
>> [ 1371.387715] LR [c000000000352080] syscall_enter_audit+0x90/0xd0
>> [ 1371.387722] Call Trace:
>> [ 1371.387725] [c00000000beafd40] [c000000000937050] 
>> selinux_task_getpgid+0x80/0xa0 (unreliable)
>> [ 1371.387735] [c00000000beafda0] [c00000000beafde0] 0xc00000000beafde0
>> [ 1371.387741] [c00000000beafe00] [c000000000034958] 
>> system_call_exception+0x448/0x480
>> [ 1371.387749] [c00000000beafe50] [c00000000000d05c] 
>> system_call_vectored_common+0x15c/0x2ec
>> [ 1371.387757] ---- interrupt: 3000 at 0x7fffab74cbf0
>>
>>
>> Please let me know if additional logs, config, or repro details are needed.
>>
>> Regards,
>>
>> Venkat.

--
paul-moore.com



