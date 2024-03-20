Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5131210FE
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919829; cv=none; b=CyTcMRFuXFP/WOuU4i7lDKphwV8pr0zU39XoHzpZ7hdpstQVxOrRAP31W7UqZP8btqJfblW6m3dSlc85zIU+aHTGCGI2tdGeHxWq/7fy/6lIV5x8gMAo89+2abP3+mhNuKRyeGcWWKtx0i3mWWxpZUoE8+T5ziqco/wSBeUvHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919829; c=relaxed/simple;
	bh=2ROv1GJ5AGVwHAmuJlmT49x+qPwpZZF2PlyQYtwg5dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d71ZxuwppZC96lEWyo9F5YebsVK58SiLe7qJAR2Tqa6Q0G4RVI5p7bXdjtD4TEXjnpWLzbruvfNdBSVTRcIuaYuPKFV6rYkEAw27DhjVL7Jnx8A4Qwugj0HdoSNT8ZCWJ0kIuMjkps+FlNFxqh0grKlL5RxCYkIzs/6Vrv/FPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42K7UOJq005451;
	Wed, 20 Mar 2024 16:30:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Wed, 20 Mar 2024 16:30:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42K7UOVc005448
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 20 Mar 2024 16:30:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dd264bf7-821b-4cf4-802b-60ae3c7b83bd@I-love.SAKURA.ne.jp>
Date: Wed, 20 Mar 2024 16:30:24 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness
 <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <000000000000e40a2906072e9567@google.com>
 <ab273ae2-80ec-45da-910a-e74298c71d50@I-love.SAKURA.ne.jp>
 <CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_zxJQ@mail.gmail.com>
 <596aad11-ee69-4ef1-b945-7b67a9fb22d7@I-love.SAKURA.ne.jp>
 <CAADnVQL6Q3k0+-5X3Xjov7W_xESxkmVXcsCxQRWitQvhTBsf7A@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAADnVQL6Q3k0+-5X3Xjov7W_xESxkmVXcsCxQRWitQvhTBsf7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/03/20 16:12, Alexei Starovoitov wrote:
> On Wed, Mar 20, 2024 at 12:05 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2024/03/20 15:56, Alexei Starovoitov wrote:
>>> This has nothing to do with bpf.
>>> bpf never calls printk().
>>
>> Please see the Sample crash report in the dashboard.
>> bpf program is hitting printk() via report_bug().
> 
> Exactly. local_bh_neable is simply asking for a splat.
> _this_ bug is in printk.
> It's a generic issue.

I can't catch. printk() is called due to report_bug().

If the reason report_bug() is called is that spin_unlock_bh() is bad,
this is a bug in sock_map_delete_elem() rather than a bug in printk(), isn't it.

> 
> sockmap bug is orthogonal.
> It's already being looked at.

Then, can we expect that this bug is also fixed shortly?

> 
>> -> #0 (console_owner){....}-{0:0}:
>>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>>        console_lock_spinning_enable kernel/printk/printk.c:1873 [inline]
>>        console_emit_next_record kernel/printk/printk.c:2901 [inline]
>>        console_flush_all+0x810/0xfd0 kernel/printk/printk.c:2973
>>        console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3042
>>        vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2342
>>        _printk+0xd5/0x120 kernel/printk/printk.c:2367
>>        __report_bug lib/bug.c:195 [inline]
>>        report_bug+0x346/0x500 lib/bug.c:219
>>        handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
>>        exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
>>        asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
>>        __local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
>>        spin_unlock_bh include/linux/spinlock.h:396 [inline]
>>        __sock_map_delete net/core/sock_map.c:424 [inline]
>>        sock_map_delete_elem+0xca/0x140 net/core/sock_map.c:446
>>        bpf_prog_2c29ac5cdc6b1842+0x42/0x46
>>        bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>>        __bpf_prog_run include/linux/filter.h:657 [inline]
>>        bpf_prog_run include/linux/filter.h:664 [inline]

