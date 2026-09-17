Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27097503900
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661413; cv=none; b=sTOE9V37Mt8jTYNsEi3pK9KOWw16J+U+yYSnFzMDgtu4JL6/0vHxOXKBdca49pHkyGdNJNQ2nYwB6rmMIO/aPeW6HZR6oWJQ819HIQbaX68a/ElLnEXEtOlNuytpU2XbLXLFUZs+OGcyH+DRDNRRACIc88KqnqGiwAiKGALgsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661413; c=relaxed/simple;
	bh=EjPvWnSaCenx04HB+kr2d3cFNBadfJup92wCJonnztI=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hWvPAw9Muxt7iG9HwLS8I6pvAB5/RVqTNF2CP7R8OLx8gsyOESxZl4nrWEpPrxSegTu9BsQe0Uq9QmhE/jV9QFASXG3szaOkimOZ4hrK05pDKyYQK1GAmHj6MvTUwNmGuSNwTXKh/VKBM4+T+Oy0vlhglZ6s3QDcZ6qG+1pR8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IYqhOyh4; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IYqhOyh4"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-52fb769ca17so8107041cf.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789661410; x=1790266210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PovAW1yhJdf58+Zr5M8cxohYcmOHlAy4fb+9VSn+dn0=;
        b=IYqhOyh4iEzwY31dUqnG972l3DXjMjTFon/MwR5BVmJMv1orgySb/VZoXrxxr4iMDY
         jtluvY4F1Og8Gvu7y/endVOHvwJT3gwUdWRaiJCq/h8K/LZpJyz8QOHA6YUaxt0YZY+s
         dAjg214Wy2bP0e3UY0SYcFCnRZVmeBAaGMpd8R3ZE0YRnLaZ4996R0v2MY8EzM5W4a/o
         BK2/oMvk1OVgoTdV6QmxnyUenRMX0HnxKjGhYS1Rjz/JLYSuskxJpvLBmNOBzCsX0a0W
         eTnFk/zPH4RVyJgC7dXgGA9jcFVyN7ns+vlgWMBH5y5IX20VPY7McxY7zKeGzfCeI4if
         wHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661410; x=1790266210;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PovAW1yhJdf58+Zr5M8cxohYcmOHlAy4fb+9VSn+dn0=;
        b=0w+7lcoreG5uq5vXdaDb5ZDAV0ceA+wAXADWJ2FWrydQ+K33PePRCDdhMAC/z/dg9M
         4yAbnDO3jjX2rkMOQrsG/mfOKRV8nZVqsheevJqVoYHXWp6N07e34RB8yOS/Z4hoT4Xn
         9R4lHRNCbNdVYkWmc6wSouK+pwdOyCbWqgF7YBNjriZCC1ngOA2f8x1APmE0nDMwkZ2b
         s6Lxo04Mm1f/k5/5FXSX1wtzclNQS8cyqdaGN9tAWBR8OLOaQQo+GS825kMqn441DhmN
         u031ZrXZIGQ7niDMLuK1YP5z3iLnvmNjQXDnc6iUBhsInDWb2GKVljvDCLzx0/Eze+iS
         GFxg==
X-Forwarded-Encrypted: i=1; AKwUvBwj9Xb4d522YJ5FH+b+MhVyqjV4YLHCkwGrbJCPFEl4+OhV9unPmMWS8rgkJ/Wsa5GJ4YA=@vger.kernel.org
X-Gm-Message-State: AFuF++kBYjN97Ls/IzvphM8KJ+ZPrag/YxTuAbU7Afc+cNuaOms3D8xK
	HNJSmZ1+mtEuBhwW6RZy0lX6cD+toC3AZ+6igbOxDSXulJOt2XN0cH3i6dANsWVdWg==
X-Gm-Gg: AYBFou3vbUoP/gB2QrHjKYB7LWlRyxk27KShzC/Rt56y77/sxdnbTd25lflu37S/t+1
	CAhcmXbUAvUtJGAkz672mXXGtAuuB9jo359ev+SyfxLZ8rxM3GAssrSZetlj8XEj4MXGwJOwFVJ
	hFILP/U9uC5+oUu8oXO3HH7Q4eP97bzCAeu76FRndDAJn9rgfr+UVyHtFZT4kI8PIwckwFh3mcs
	vTCXT3jdVrO+A6u/vtI+wHTXLh8m0bvbNLuAMnVPKpaPArlsfpOTiXJWehV3ssafSA4zsBBJ2LF
	d6Be0OB1SyPglm3zwa18MOXetfh5a2ob63sCK5zQ+Dm/4m7qHQmBayi844l7FKyvUx9m6n9LZmq
	wQU+nSsrc2AbK/kyvoUBlKNbnYPOFLGTksYDWjvDmZFO67W1tjQ59VBAt0KsLNSmQuX6I7wmmII
	G11hLh9ZqeC5hn2DXPTmZ9+0SvBj90Hrett9IE+kda6ygvaIG85j3nG0FyW+UxJcFRN7uoRM7mP
	cZAKOBBWfAydahQOkWRqL7TvOcn6B0XUX5qyrXt
X-Received: by 2002:ac8:7d44:0:b0:52f:b1b6:a4aa with SMTP id d75a77b69052e-5327edf9c51mr125939161cf.4.1789661409717;
        Thu, 17 Sep 2026 09:10:09 -0700 (PDT)
Received: from [10.99.118.151] ([72.159.227.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620dc734sm54943111cf.30.2026.09.17.09.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 09:10:08 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, bpf <bpf@vger.kernel.org>, "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, <audit@vger.kernel.org>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, <yonghong.song@linux.dev>, <tglx@kernel.org>, <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 12:10:06 -0400
Message-ID: <1a0b021e330.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <1a0b01e5cd8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <ff563467-0bab-43ec-a46c-a4167bc12473@linux.ibm.com>
 <73701ffd-213e-4842-8b40-f719c1eeaed4@iogearbox.net>
 <1a0b01e5cd8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
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

[NOTE: correcting the audit mailing list address to audit@vger ...]

On September 17, 2026 12:06:18 PM Paul Moore <paul@paul-moore.com> wrote:
> On September 17, 2026 10:03:59 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> Hi Venkat,
>>
>> On 9/17/26 3:01 PM, Venkat Rao Bagalkote wrote:
>>> Hi all,
>>>
>>> IBM CI has reported a kernel warning triggered in __audit_syscall_entry()
>>> on a PowerPC 64 (ppc64le, POWER9 pSeries guest) system while running the
>>> BPF kselftest suite (test_progs).
>>>
>>> Environment:
>>>
>>>
>>> Kernel version: 7.3.0-rc3-g238650ef6c7c (PREEMPT)
>>> Architecture: ppc64le (POWER9 - IBM,8375-42A pSeries / phyp)
>>> Workload: BPF selftests (tools/testing/selftests/bpf/test_progs)
>>>
>>>
>>> Problem Description:
>>>
>>>
>>> During syscall entry processing (system_call_exception ->
>>> syscall_enter_audit -> __audit_syscall_entry), the kernel hit
>>> WARN_ON(context->context != AUDIT_CTX_UNUSED) at kernel/auditsc.c:1995,
>>> indicating that the task's audit context was not reset to AUDIT_CTX_UNUSED
>>> prior to entering the new syscall.
>>
>> Hm, based on the trace feels somewhat unrelated to bpf, but were you able
>> to bisect in
>> case it can be reliably reproduced? Which tree is this, linux-next or
>> bpf/bpf-next?
>
> Thanks for the report Venkat.
>
> Unfortunately due to some unexpected family medical issues I'm not able to
> look into this very closely at the moment (triaging mail on my phone), but
> the related audit code has been fairly stable lately so it seems a bit odd.
>
> I do know that Thomas Gleixner (CC'd) did some work recently on the syscall
> entry code (audit related commit below), perhaps that may be a place to start?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f25517010ddd3f8080d7e06b9b1cb1b64b73772
>
> FWIW, I haven't seen this in any of my testing on x86 or ARM, have you seen
> this on other arches besides Power? Also, as Daniel already mentioned, more
> information on the tree would be helpful.
>
> While I don't have access to a Power system, I'm CC'ing Ricardo Robaina who
> also works at IBM/RH and has experience with the audit kernel code. If this
> appears to be specific to Power, he might be a good resource to help
> diagnose and develop a patch.
>
>>
>>> Trace:
>>>
>>>
>>> [ 1371.387510] ------------[ cut here ]------------
>>> [ 1371.387528] WARNING: kernel/auditsc.c:1995 at
>>> __audit_syscall_entry+0x50/0x1b0, CPU#17: test_progs/49616
>>> [ 1371.387539] Modules linked in: dm_verity(E) dm_bufio(E) reed_solomon(E)
>>> livepatch_sample(EK) tun(E) vrf(E) 8021q(E) garp(E) mrp(E) stp(E) llc(E)
>>> veth(E) bonding(E) tls(E) rfkill(E) nft_fib_inet(E) nft_fib_ipv4(E)
>>> nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E)
>>> nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) hvcs(E)
>>> hvcserver(E) pseries_rng(E) vmx_crypto(E) sg(E) drm(E) fuse(E)
>>> drm_panel_orientation_quirks(E) xfs(E) sr_mod(E) nvme_tcp(E) sd_mod(E)
>>> cdrom(E) nvme_fabrics(E) nvme_core(E) ibmvscsi(E) ibmveth(E)
>>> scsi_transport_srp(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
>>> [last unloaded: bpf_test_modorder_x(OE)]
>>> [ 1371.387607] CPU: 17 UID: 0 PID: 49616 Comm: test_progs Tainted: G
>>> OE K     7.3.0-rc3-g238650ef6c7c #1 PREEMPT
>>> [ 1371.387616] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [K]=LIVEPATCH
>>> [ 1371.387620] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202
>>> 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
>>> [ 1371.387626] NIP:  c0000000003e70d0 LR: c000000000352080 CTR:
>>> c00000000000cf00
>>> [ 1371.387631] REGS: c00000000beafaa0 TRAP: 0700   Tainted: G      OE K
>>> (7.3.0-rc3-g238650ef6c7c)
>>> [ 1371.387637] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48002824
>>> XER: 20040084
>>> [ 1371.387650] CFAR: c00000000035207c IRQMASK: 0
>>>       GPR00: c000000000034958 c00000000beafd40 c0000000020eb200 c0000000345f4800
>>>       GPR04: 00007fffe2a31184 0000000000000081 000000007fffffff 0000000000000000
>>>       GPR08: 0000000000000000 0000000000000001 0000000000000001 00000000000000dd
>>>       GPR12: 0000000000000000 c00000002e99b300 0000000000000000 0000000000000000
>>>       GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>>       GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>>       GPR24: 0000000000000000 0000000000000000 0000000000000000 c0000000345f4800
>>>       GPR28: 0000000000000000 00000000000000dd 00000000000000dd c000000138e0c000
>>> [ 1371.387710] NIP [c0000000003e70d0] __audit_syscall_entry+0x50/0x1b0
>>> [ 1371.387715] LR [c000000000352080] syscall_enter_audit+0x90/0xd0
>>> [ 1371.387722] Call Trace:
>>> [ 1371.387725] [c00000000beafd40] [c000000000937050]
>>> selinux_task_getpgid+0x80/0xa0 (unreliable)
>>> [ 1371.387735] [c00000000beafda0] [c00000000beafde0] 0xc00000000beafde0
>>> [ 1371.387741] [c00000000beafe00] [c000000000034958]
>>> system_call_exception+0x448/0x480
>>> [ 1371.387749] [c00000000beafe50] [c00000000000d05c]
>>> system_call_vectored_common+0x15c/0x2ec
>>> [ 1371.387757] ---- interrupt: 3000 at 0x7fffab74cbf0
>>>
>>>
>>> Please let me know if additional logs, config, or repro details are needed.
>>>
>>> Regards,
>>>
>>> Venkat.

--
paul-moore.com



