Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC113A24A
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741942; cv=none; b=j+J/x/NKgHKVv1o/TkY4jf6SuFoqEM1kPwMKZI3xFYf9PA8GMivVncst+wf8umDdDjB59zO0y84+UsV42vQZKHTFTvJskT5IHAjw4RD+R1pH3DSSnRhSk9/tuVAYT36hGsgFKsnD+5hh0c8FzCXG8JHbhH5stKACs1WGydrzK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741942; c=relaxed/simple;
	bh=a2h325s6mCISuYH1DqYyyIpbJ3ezamrQpkSHPoYkj+M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a8Mj1+qvo1LrDneelnvB+0hsvzKZjxWXstVGDAbXV8eDbdrLhRqcq97LZWiLcg1w9YepYL4g7QG6zg7eqUQnSkzMF6sL97TxXYAVbGIrD4+32+Ymp3yzIQ49Vw7AS6lBGt39FU5aMLfgiFmFEr8imE8tTwD7+S6gp06h58Ncajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf1aea97fso240373739f.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 12:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741940; x=1712346740;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74gSyGe2u5NLrtHEKMkfIuxKfdeVAtqYmdtlLuPRQU4=;
        b=ap6kKDpI5vBWzhS6ALxadCt/6752q/Qn8iU6V7dApDg92UQkCwC/RBPI3Q1E53TSTM
         yiSSNR3Tn2QKK/b5fGRuVQUCLYSdR5QAbVXYJDlF9clHG7ffC4MgCCZzquJ9ksQuNnfl
         R9iH08Bp1oUKnYxpq5j7zoFP4HerVUAKTM+JnnkHh6AXnzNv0MS8LYkA/WYp524JJZHj
         WKZHqYp3vCAGByp0LJwzE9mQWCTL0gIGnfJK+H/YAo1tZcoJBafl2Sm8pZYJUG91iiCF
         BmwESkr1HeIUXaCOryfAnoy/4jOqZ1P+dJ0Kyx+k7W/phV4r2W2ulDckvCsYoOxVRn4m
         sxVw==
X-Forwarded-Encrypted: i=1; AJvYcCVMJFzBLN+Ykfcdbqo8+GaxoNmjiiPUsExV3SfHTdG4hXijM8nxEhKTrDhK6dVkfMqsEd792rpW9ZL9KdLkC/KK763z
X-Gm-Message-State: AOJu0Yzj/1pjBIAENkdRfj2Kg6qjtgzeuLrwlmHcBml26Qvu6sARjzkc
	kP7DW/5ybeAREwCBrLRR/zslGNDWAVNkoTetBjQuJFR56WS+LrtuQQI7FS+iCTRPoRwhtvsPei/
	IMuzc2Uz53lXKrX8UIkFfi1F5qTIUzvkYTV2h3g5ANs48+drF5kqIF0U=
X-Google-Smtp-Source: AGHT+IGCtHUORaSZfV0tUiYNH5gfEYgXqK6+I05PpkJI/5BHzGng1u9nSPWYpIPkqxFFVmqGSo2E+SymcJs/SrH1jbzOlPWE2zh/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3206:b0:368:c21e:3898 with SMTP id
 cd6-20020a056e02320600b00368c21e3898mr208846ilb.3.1711741940029; Fri, 29 Mar
 2024 12:52:20 -0700 (PDT)
Date: Fri, 29 Mar 2024 12:52:20 -0700
In-Reply-To: <000000000000f9ce6d061494e694@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000486e1f0614d1fa5f@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in trie_delete_elem
From: syzbot <syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kernel-team@meta.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	patchwork-bot@kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    317c7bc0ef03 Merge tag 'mmc-v6.9-rc1' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=121ddb95180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=603bcd9b0bf1d94dbb9b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15af8b0d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1590903d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eea0b23c3f68/disk-317c7bc0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/440f7aea55b5/vmlinux-317c7bc0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ecb91ede16f9/bzImage-317c7bc0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_trie.c:448
 trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_trie.c:448
 ____bpf_map_delete_elem kernel/bpf/helpers.c:77 [inline]
 bpf_map_delete_elem+0x5c/0x80 kernel/bpf/helpers.c:73
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run96+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
 __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x6a5/0xa30 mm/slub.c:4377
 bpf_free_used_maps kernel/bpf/core.c:2723 [inline]
 bpf_prog_free_deferred+0x390/0xc70 kernel/bpf/core.c:2761
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Local variable stack created at:
 __bpf_prog_run96+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420

CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.9.0-rc1-syzkaller-00178-g317c7bc0ef03 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events bpf_prog_free_deferred
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
