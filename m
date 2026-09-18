Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF67409277
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751826; cv=none; b=eOQbO7SlMEpIGVNOaYyVJOKcB0y/fuSmWGGZmAMMUKdji/wzwFna892gFcWvECuB45FHVI8ScYy6jf1MNAHOxrbyNeqtK68fIkxEQD6vWn6uYQnIVCQM9250Mkgok5xUtZ2CNtP7qGyBJMZJZCgyJtwB1hm2hnxFraN9nuU0Ois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751826; c=relaxed/simple;
	bh=FC+J2nnTsNyL6d+MVl1xUFNbXOkL885LTAtWT4IA1Og=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H1QJOLeW5BLdcQl+dBLzyjAs/nGeGwmzUVPe8ZCAdGtFJodfLLhvjp+yJCyFBKZRYB3jV/1MqXvrubdAeWUZRL4jV3vR3nB0ewfspFY8MYuoekBH1ek3zhjzygnlOZHFWzr5M8o/Uv7/HZmoSHY6qi249wnh1SM/PUZxOsxstjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYywX+6n; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYywX+6n"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so5972185e9.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789751823; x=1790356623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8+9gHHUNm+QzgZ7ujErtwBqxlaIHdYd4jhT07sdaN/g=;
        b=GYywX+6nkNnC+/tOYP3Aqy/ortUXjvvxJnHduAYfTWkIuxRZ3WFXmbjYFTWwRi9FZF
         YEJB1/LSFN9PTfVW9JHhwSQNlewnj4I/88PAPOGlyd4dPJgsySxSK68dhmLmglxCauE0
         yPuqSWYWhKk9vu2okkaHjL1xWU5cEfjMp9qAL5fmdfAzg54n64CJfOCq6eRdn4tP7Nt8
         AlvHpP+Uvcatyfiy30CzDWcE4XXcLnoPCFClDazdBCgOdKZ2ExbEkiIvpD0zZXfM/evG
         o8Rlz8wFygRNuLv6UY4clT7hjapv0rA2wlGNNc0qAKSam/OXXdiHwtFITMekBA1g043A
         UMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789751823; x=1790356623;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8+9gHHUNm+QzgZ7ujErtwBqxlaIHdYd4jhT07sdaN/g=;
        b=Eh4mJKZTR2s14vhy+kOIbX2raMewi5NHyBseFaPyjbM3XHtCucpoFYn675+jkRtTpV
         0niUJmga9Q+/pxdQDU5f9f7++Fz+BsL+4YKbBjTYotpRMqjbIRiWSoNqLAWO4FSLeIHZ
         WghC/860NXFeHBQYC+8AatPoh351xPCkgqI9kA2S+2+HCvLMDMjEi/no12q4QW2orREz
         qyssLoWkcHGxvZgJSrT8JzbnPSLOm7FgFIK67w1Puodguhbh3OlTp3rxggoOE6Oz10O9
         ochccRENHHdB3KAmdCcw7cFTx6NK+gU8DeX5YBtEbmgULKQy2j/fUQhVyNXPa5wmDDnd
         VBBQ==
X-Gm-Message-State: AFuF++nkqnTeeBbbE1hY7V94u/UxDc8bOTnu8QqZgxjhFxGTmnTOTz+t
	ez7KYO00C59VmjcgjDHDO5cpdaoIGSfGpirYBtYS61zf+lAgWaJQqpWj
X-Gm-Gg: AYBFou1B7G11UCgfr9qVBDR1jqMm31nbU7rWAMMiekZcBt23vNBHH0vtDMOwuP4FMvb
	TMxQGxFS/ti0tAFTTmlq/jie3oL8Me7+DRCYE7StL8sjgY2u1FYtqKAL323HsACta4wOgQf3mnM
	AL8MVyXJFZfrSriiQ0fHQJPxDRQEJF09n28FA+YS9a5XOC1Nyqmq05StBJmG3WyeEwEuTCA5iSf
	JBIdvQ1TK4yJnxGmtGppiPGmMG0DZ3u4YBFNhD64U+hzGq7KeKkJVPGDzl5y/V6Fv+0fqJCtg9b
	sTBJxKvuIyuCExXaDQdu96p6FCBcpYwte6gigDUMQDPFOR9ns1r7sQtTh1S8BlaV1f4/bIuJGfw
	FfbXE2TEYSwRkkoe3erUSRth8VivBt5DD0JEcPE7ex4Hq2wwIt+IcMFKUiidc6RbTljCCbm10Mj
	VX5ZNwirma/tU0QZiRY2OuEu12szBI92d1PMuqGET1/9cSogwKI2aQeZEPp+kSKP70wv5ijEGoX
	YCogpbSicBJDIEygnYlFP/e0IPwF74rKla4
X-Received: by 2002:a05:600c:1d16:b0:49f:bc8a:b103 with SMTP id 5b1f17b1804b1-49fc55c5361mr48390995e9.0.1789751822550;
        Fri, 18 Sep 2026 10:17:02 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:a888:e521:9904:1dbd? ([2620:10d:c092:500::6:24b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7cba562sm44764855e9.2.2026.09.18.10.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:17:01 -0700 (PDT)
Message-ID: <d6051bf7-24a9-456c-a445-1e0be35d5e5a@gmail.com>
Date: Fri, 18 Sep 2026 18:17:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] bpf: Fix task work round ownership race
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Yun Lu <luyun_611@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org
References: <20260918080014.54012-1-luyun_611@163.com>
 <e530342b-8f21-43c9-a3bb-695e6b63c019@gmail.com>
Content-Language: en-US
In-Reply-To: <e530342b-8f21-43c9-a3bb-695e6b63c019@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/26 5:50 PM, Mykyta Yatsenko wrote:
> 
> 
> On 9/18/26 9:00 AM, Yun Lu wrote:
>> From: Yun Lu <luyun@kylinos.cn>
>>
>> This series fixes a race in the bpf_task_work scheduling kfuncs and
>> adds a regression test for it.
>>
>> A task_work callback scheduled for a task running on another CPU can
>> complete before bpf_task_work_irq() regains control after
>> task_work_add().  The callback's cleanup releases ctx->task, so a
>> concurrent map value deletion that publishes the FREED state makes the
>> resumed irq_work handler call task_work_cancel(NULL, &ctx->work),
>> dereferencing task_struct::task_works through a NULL task (RIP at
>> task_work_cancel+0xd, RDI == 0, CR2 at the task_works offset).  The
>> same cancellation is reached when the deletion wins before the
>> callback runs and the callback's bailout path drops the last ctx
>> refcount, clearing ctx->task.
>>
>> Patch 1 gives each scheduling round an ownership count: the irq_work
>> scheduler, the published callback and an asynchronous canceller hold a
>> reference while using this round's task/prog/work, and only the last
>> user releases them, before the ctx can be reused from STANDBY.  The
>> count is zero based with the STANDBY -> PENDING transition acting as
>> the zero-to-one gate, so a finished round cannot be revived: a
>> canceller either pins a still-active round (ctx->task guaranteed
>> valid) or declines to cancel.  Separate irq_work objects for
>> scheduling, cancellation and deferred destruction avoid reinitializing
>> an irq_work that may still be queued or running.  FREED remains
>> terminal and the scheduling path stays atomic-only, preserving NMI
>> safety.
>>
>> The race window between task_work_add() and the SCHEDULING ->
>> SCHEDULED cmpxchg is only a few instructions wide, so the fix was
>> verified with a deterministic reproduction that widens exactly this
>> window with a debug delay, while scheduling cross-CPU and deleting the
>> map value concurrently: without the fix the kernel panics reliably;
>> with it, all interleavings complete.  A 900-round stress test rotating
>> through ctx reuse, deletion after the callback and deletion right
>> after scheduling also runs clean, with no leaks reported by kmemleak.
>>
>> Patch 2 adds a selftest that keeps steady pressure on the
>> interleaving: it schedules cross-CPU, deletes the map value at
>> different points of a round, uses READY/DONE handshakes so scheduling
>> errors cannot be missed, and tags every callback with a generation so
>> a late callback cannot satisfy a later round's assertions.
>>
> 
> I could not reproduce the kernel crash on my computer, the test is also
> very flaky:
> 
> ./test_progs -t task_work_race
> serial_test_task_work_race:FAIL:round ready unexpected error: -5 (errno 2)
> #513     task_work_race:FAIL
> 
> Could you please share a bit more on how to repro the crash, feel free to
> share your config, arch, any details on how you run it.
> 

I've got a repro:

[  139.522974] BUG: kernel NULL pointer dereference, address: 0000000000000758
[  139.523087] #PF: supervisor read access in kernel mode
[  139.523155] #PF: error_code(0x0000) - not-present page
[  139.523207] PGD 101bdf067 P4D 0
[  139.523254] Oops: Oops: 0000 [#1] SMP
[  139.523302] CPU: 0 UID: 0 PID: 784 Comm: test_progs Tainted: G           OE       7.3.0-rc2-g961768eff0dc #3 PREEMPT(full)
[  139.523418] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  139.523492] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  139.523630] RIP: 0010:task_work_cancel+0xe/0xa0
[  139.523814] Code: 48 89 df e8 b4 e6 b8 00 4c 89 f8 5b 41 5e 41 5f c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 d6 0f 1f 44 00 00 41 57 41 56 53 <48> 83 bf 58 07 00 00 00 75 0f 45 31 ff 49 39 f7 0f 94 c0 5b 41 5e
[  139.524037] RSP: 0018:ff4aee5680003f80 EFLAGS: 00010046
[  139.524106] RAX: 0000000000000005 RBX: ff140371450c0d00 RCX: 0000000000000003
[  139.524199] RDX: ffffffff950bd6bb RSI: ff140371450c0d08 RDI: 0000000000000000
[  139.524293] RBP: 0000000000000022 R08: 0000000000000000 R09: 0000000000000000
[  139.524383] R10: 0000000000000000 R11: ff4aee5680003ff8 R12: 0000000000000000
[  139.524475] R13: 0000000000000000 R14: ff140371450c0d18 R15: ff140371450c0d08
[  139.524572] FS:  00007f7ce77be640(0000) GS:ff140371e457b000(0000) knlGS:0000000000000000
[  139.524672] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  139.524746] CR2: 0000000000000758 CR3: 0000000101862003 CR4: 0000000000771ef0
[  139.524847] PKRU: 55555554
[  139.524894] Call Trace:
[  139.524926]  <IRQ>
[  139.524956]  bpf_task_work_irq+0xaf/0xc0
[  139.525056]  irq_work_run+0x91/0x110
[  139.525137]  __sysvec_irq_work+0x1d/0xa0
[  139.525219]  sysvec_irq_work+0x64/0x80
[  139.525277]  </IRQ>
[  139.525310]  <TASK>
[  139.525378]  asm_sysvec_irq_work+0x1a/0x20
[  139.525436] RIP: 0010:default_send_IPI_self+0x39/0x50
[  139.525574] Code: 04 25 00 d3 5f ff a9 00 10 00 00 74 10 f3 90 8b 04 25 00 d3 5f ff a9 00 10 00 00 75 f0 81 cf 00 00 04 00 89 3c 25 00 d3 5f ff <c3> e8 21 fc ff ff bf 00 04 00 00 eb e6 cc cc cc cc cc cc cc cc cc
[  139.525785] RSP: 0018:ff4aee56802bfc80 EFLAGS: 00000206
[  139.525844] RAX: 00000000000000fb RBX: 0000000000000000 RCX: 0000000000000000
[  139.525931] RDX: 0000000000000023 RSI: ff140371e457b000 RDI: 00000000000400f6
[  139.526020] RBP: ffffffffc0200988 R08: ffffffff976aa170 R09: 0000000000000002
[  139.526107] R10: 0000000000000000 R11: 0000000000000000 R12: ff14037140800700
[  139.526189] R13: ff140371416bcc00 R14: ff140371450c0d00 R15: ff140371428b42c0
[  139.526271]  ? 0xffffffffc0200988
[  139.526320]  arch_irq_work_raise+0x21/0x30
[  139.526369]  irq_work_queue+0x28/0x60
[  139.526405]  bpf_task_work_schedule+0x2bf/0x2e0
[  139.526467]  bpf_prog_971652e63b55a6ac_race_sched_work+0x1a1/0x257
[  139.526539]  trace_call_bpf_faultable+0x15c/0x2e0
[  139.526602]  perf_syscall_enter+0x16e/0x2f0
[  139.526652]  ? trace_syscall_enter+0x5d/0x90
[  139.526792]  trace_syscall_enter+0x5d/0x90
[  139.526841]  do_syscall_64+0x1cb/0x290
[  139.526892]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  139.526953] RIP: 0033:0x7f7ce80a0cfb
[  139.526997] Code: 0f 1e fa 31 c9 e9 a5 fc ff ff 0f 1f 44 00 00 f3 0f 1e fa b8 27 00 00 00 0f 05 c3 0f 1f 40 00 f3 0f 1e fa b8 6e 00 00 00 0f 05 <c3> 0f 1f 40 00 f3 0f 1e fa b8 66 00 00 00 0f 05 c3 0f 1f 40 00 f3
[  139.527210] RSP: 002b:00007f7ce77bddd8 EFLAGS: 00000202 ORIG_RAX: 000000000000006e
[  139.527304] RAX: ffffffffffffffda RBX: 00007f7ce77be640 RCX: 00007f7ce80a0cfb
[  139.527395] RDX: 00007f7ce8056ea1 RSI: 0000000000000000 RDI: 0000000000000080
[  139.527485] RBP: 00007f7ce77bde10 R08: 00007ffe01a1c0bf R09: 0000000000000000
[  139.527585] R10: 00007f7ce7fd7f38 R11: 0000000000000202 R12: 00007f7ce77be640
[  139.527678] R13: 0000000000000016 R14: 00007f7ce8050230 R15: 0000000000000000
[  139.527766]  </TASK>
[  139.527791] Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)]
[  139.527932] CR2: 0000000000000758
[  139.527989] ---[ end trace 0000000000000000 ]---
[  139.528059] RIP: 0010:task_work_cancel+0xe/0xa0
[  139.528121] Code: 48 89 df e8 b4 e6 b8 00 4c 89 f8 5b 41 5e 41 5f c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 d6 0f 1f 44 00 00 41 57 41 56 53 <48> 83 bf 58 07 00 00 00 75 0f 45 31 ff 49 39 f7 0f 94 c0 5b 41 5e
[  139.528306] RSP: 0018:ff4aee5680003f80 EFLAGS: 00010046
[  139.528356] RAX: 0000000000000005 RBX: ff140371450c0d00 RCX: 0000000000000003
[  139.528449] RDX: ffffffff950bd6bb RSI: ff140371450c0d08 RDI: 0000000000000000
[  139.528519] RBP: 0000000000000022 R08: 0000000000000000 R09: 0000000000000000
[  139.528580] R10: 0000000000000000 R11: ff4aee5680003ff8 R12: 0000000000000000
[  139.528649] R13: 0000000000000000 R14: ff140371450c0d18 R15: ff140371450c0d08
[  139.528753] FS:  00007f7ce77be640(0000) GS:ff140371e457b000(0000) knlGS:0000000000000000
[  139.528849] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  139.528922] CR2: 0000000000000758 CR3: 0000000101862003 CR4: 0000000000771ef0
[  139.529006] PKRU: 55555554
[  139.529043] Kernel panic - not syncing: Fatal exception in interrupt
[  139.529755] Kernel Offset: 0x14000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  139.529938] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

>> Yun Lu (2):
>>   bpf: Fix task work round ownership during cancellation
>>   selftests/bpf: Add task work round ownership race test
>>
>>  kernel/bpf/helpers.c                                  | 123 ++++++++++--
>>  .../selftests/bpf/prog_tests/test_task_work.c         | 283 +++++++++++++++++++++
>>  .../selftests/bpf/progs/task_work_race.c              | 125 ++++++++
>>  3 files changed, 503 insertions(+), 28 deletions(-)
>>
> 

