Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EF13C9BA
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479635; cv=none; b=opuMKrwpHMuK61Ql25kryZbgQS+t9knC9qODpozRvLE3ZezRtalV8x4TWPENajV9A6zoJ9sXUGv8teM/yvv7IB4cSZjI2lkru4TVwL6qMCUowO3lPk0fy+WB8sh1ttfl5bgTeMuPIXftjZ8ye5IKU91+Iq0Rq1YfFJ1GQzOcZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479635; c=relaxed/simple;
	bh=R/mMGKjzQTaooyIF3PJX6TqpXnfMhdRKraYq9NmqNsk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qNh6MkmI0Ga6LESNZa63wsnbjyBeX8/Yf44h6acqs+2nNZRNse+vROvSAVU5f5k77zQJpxO9f0a7F+m8TBCWIZuoyT94QuZxuK+7SVt1eTCQ11lMqxb7m4eXGimVp7vnwS5xJfG0OGk1BdnoAfWFbXRr5mAjkbsKARHZO/tLUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-368a49f06f1so8256085ab.3
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 12:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479623; x=1712084423;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwBoSkAexwwZT22uv2xlJaKJZLAqlwLtukfnnb8tOGI=;
        b=kN/tIeNlDTTxyuyD3Mtj+1DaNdnIXIkglxC30EIKv/ebHh2AEkTK8IA3qI3sSPuxOR
         FD0xlov1KuWVXlwQVL6KXi7KHuGoQ5tdSxvoVzEYtTfvQH+njfqnQVfS9XtHWIUgBE/c
         Ev4JD6ZKw+Al9Xe7cPvVuJJpq0gLnRGuOuzdgzl4RAuQtXFsMzFnkqOjBEqrZj3tRZ8B
         XnVNYns/FXgBcgoSaLePv/cKpHaAX0PwfuQGLMvQAqQLxon0XonaibcIAWCcNYMLlWEI
         NnZxSpkDwdjOjpKUQ0gmek5+NPnbqKh+BJEBGnxrUn9jlCMQeyxa4x5W+Xs52NUOqOON
         OzAg==
X-Forwarded-Encrypted: i=1; AJvYcCV+wJcPZmiikagI7UbOtiScWfpctPRJ/A3xJHyJ+y4xHQRRnzz5u9UOZyauUsAiBUBK5+h1q8qkiO/3Vjq8zlPMedSv
X-Gm-Message-State: AOJu0YyHQR5wt4tqAXhV5uJD4roq7XP5oeZybZ/e/yHKRKITmqSDfn3e
	dH32cZAnrRivP9FS4tnv+ocoyo9SnUQ35BSsWCsKbXraO4TEx9k8zERLeuvYS7FYptHl7wTr8cz
	plE1QMbIS8f8ht7H/TlK0d8JcEM/WQXLH8FuCCd05H7Whlz6hIOXFqOc=
X-Google-Smtp-Source: AGHT+IEbt0OOJBHB47eYY914zC+CUvv42tj6QW2+e3un017KnOgzAtQXZ/0HgDwYsXQB2nGGcI770tpDfvPN15BZj9JBlXtu+2k9
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:368:8224:d1db with SMTP id
 j8-20020a056e02154800b003688224d1dbmr168555ilu.4.1711479623105; Tue, 26 Mar
 2024 12:00:23 -0700 (PDT)
Date: Tue, 26 Mar 2024 12:00:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9ce6d061494e694@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in trie_delete_elem
From: syzbot <syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f55aa85a874 Merge tag 'fbdev-for-6.9-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a8dc6e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
dashboard link: https://syzkaller.appspot.com/bug?extid=603bcd9b0bf1d94dbb9b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/991fcbce770a/disk-4f55aa85.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd716e5d2c3c/vmlinux-4f55aa85.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf1151dbf5fc/bzImage-4f55aa85.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_trie.c:448
 trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_trie.c:448
 ____bpf_map_delete_elem kernel/bpf/helpers.c:77 [inline]
 bpf_map_delete_elem+0x5c/0x80 kernel/bpf/helpers.c:73
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run128+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x132/0x320 kernel/trace/bpf_trace.c:2421
 __bpf_trace_kmem_cache_free+0x31/0x40 include/trace/events/kmem.h:114
 trace_kmem_cache_free include/trace/events/kmem.h:114 [inline]
 kmem_cache_free+0x6da/0xa80 mm/slub.c:4343
 mt_free_one lib/maple_tree.c:172 [inline]
 mas_destroy+0x56c9/0x5cd0 lib/maple_tree.c:5612
 mas_store_prealloc+0x39c/0x550 lib/maple_tree.c:5487
 vma_iter_store mm/internal.h:1290 [inline]
 vma_complete+0x9b0/0x14e0 mm/mmap.c:535
 __split_vma+0x1037/0x1200 mm/mmap.c:2385
 split_vma mm/mmap.c:2411 [inline]
 vma_modify+0x37c/0x4c0 mm/mmap.c:2452
 vma_modify_flags include/linux/mm.h:3303 [inline]
 mprotect_fixup+0x790/0x1170 mm/mprotect.c:635
 do_mprotect_pkey+0x1159/0x1850 mm/mprotect.c:809
 __do_sys_mprotect mm/mprotect.c:830 [inline]
 __se_sys_mprotect mm/mprotect.c:827 [inline]
 __ia32_sys_mprotect+0x98/0xf0 mm/mprotect.c:827
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xba/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x7a/0x84

Local variable stack created at:
 __bpf_prog_run128+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x132/0x320 kernel/trace/bpf_trace.c:2421

CPU: 0 PID: 14388 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-13006-g4f55aa85a874 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
