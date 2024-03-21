Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C185943
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033889; cv=none; b=cINbNXZltGHCOEDwy91gmobFA9c6q1ICd/EHRULjV7uvuVhfZKABoiQOYxVjicXGFw4ATyosAkoXcpfI/XKrEUVqRT8arheu/+oQiIY8PFDEaEq6GsiZ/qbR902p6leVMtU2p83NOrG2Yzbp5A/uBoi4ZlHugLcH1ep3gwzl8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033889; c=relaxed/simple;
	bh=9zmkg4p+eJVELsapNlpB8LYHjd6AcvSjUhjf9kgm20k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iiQHG4fPp8haWinFrWzwVtVJ7e5Z7/lEPXccDoYmMSOW1uSGRSXUS++/1O51/5mMGcobtCOKICL3F/JdyLH7DpD6b6xMI0LlUYwj3jnmJvDtZSwtxXF0PJ5e+lkg0tzGWB88xH0nvk4A/8JQmgQwj+Jd0lh0RSYODG3Yt5WNOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c88a694b46so94029839f.1
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 08:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711033887; x=1711638687;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxffvMMY6BtsinlTcMoPF9ObULz9u+FTRKPjOCskb8o=;
        b=fTL0bfx8hQ6eDsljCVS/1tX+vX8e3TBOieN9G0ZxQuqhOnHkNYbGHupvILzPlVeurm
         HMr0wZILLkpYCPwyBH7gh+CE8iqRg/d53UkfLIiW7D5BXAtsVxAKIMsmXWPdH/0dihLn
         5EJ27bbVJ2JKjrgN3xO+eHa1G3on6TuICrAy2qjGXAlqiJ7fiC2E1Jv/xDhoPg1FWoDZ
         wIeEXloqmiG3lMea3VHX8pMBJEnf4hq6HnynfBWd4qK/4TzOfB+GBJuEcbPuBOfDcxya
         uwUpLjQ3/KiICiFgYEswiEvFtQ21aSUZX3LTfX65Hl4rcHFNuGaxT/3BcIm3qN4Bvrg9
         /07g==
X-Forwarded-Encrypted: i=1; AJvYcCXLlWgBthDEREKgH9WGUH2JYD6yk7nSxhJciuV3lY6SpbeSO++kH6I4TwglMh7yT7o+HTKqIN5V+VG5O9Dmd0tF+doI
X-Gm-Message-State: AOJu0YyKroGd/DEGI4FU1ijp7Pv9YzrhgnrSolrhMS/XMC8Xlv33jsw3
	kftMmwzvejU/Nma/42Uw+/Agk1IzGqNxDj0uDP75eTVKvhBKAeTRT7fS+O7Tg4HU3LDNgOpvNbU
	x5OmCdHWWI6Tz/3gROdjhkfD0WbRzBCjg98NUJq3zLjP1+zPT5V9xs80=
X-Google-Smtp-Source: AGHT+IG5+H4ZwVOaUl1nX2P+vJlaHJah0bVHGr+YYFMzKtOCUg0sLiKqaD3daAPGXBkz+3GLJoM0z89vOPVdR7uTLlvv8SMV021H
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:601c:b0:7cc:ce74:4280 with SMTP id
 fr28-20020a056602601c00b007ccce744280mr279101iob.1.1711033887315; Thu, 21 Mar
 2024 08:11:27 -0700 (PDT)
Date: Thu, 21 Mar 2024 08:11:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d69b206142d1ff7@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in trie_lookup_elem
From: syzbot <syzbot+d2b113dc9fea5e1d2848@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    741e9d668aa5 Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ec5ac9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
dashboard link: https://syzkaller.appspot.com/bug?extid=d2b113dc9fea5e1d2848
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129b7946180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17be1546180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/20ec6fc7fdfe/disk-741e9d66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81cd64abe7a8/vmlinux-741e9d66.xz
kernel image: https://storage.googleapis.com/syzbot-assets/180340ffa1c7/bzImage-741e9d66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2b113dc9fea5e1d2848@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in trie_lookup_elem+0x4b9/0x510 kernel/bpf/lpm_trie.c:234
 trie_lookup_elem+0x4b9/0x510 kernel/bpf/lpm_trie.c:234
 ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
 bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
 __bpf_trace_skb_copy_datagram_iovec+0x2c/0x40 include/trace/events/skb.h:73
 trace_skb_copy_datagram_iovec include/trace/events/skb.h:73 [inline]
 skb_copy_datagram_iter+0x15e/0x200 net/core/datagram.c:545
 skb_copy_datagram_msg include/linux/skbuff.h:4045 [inline]
 tcp_recvmsg_locked+0xcf6/0x3680 net/ipv4/tcp.c:2500
 tcp_recvmsg+0x279/0xad0 net/ipv4/tcp.c:2578
 inet_recvmsg+0x167/0x6a0 net/ipv4/af_inet.c:883
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x235/0x340 net/socket.c:1068
 sock_read_iter+0x333/0x3c0 net/socket.c:1138
 call_read_iter include/linux/fs.h:2102 [inline]
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0xda3/0xef0 fs/read_write.c:476
 ksys_read+0x20f/0x4c0 fs/read_write.c:619
 __do_sys_read fs/read_write.c:629 [inline]
 __se_sys_read fs/read_write.c:627 [inline]
 __x64_sys_read+0x93/0xe0 fs/read_write.c:627
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Local variable stack created at:
 __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420

CPU: 0 PID: 5010 Comm: sshd Not tainted 6.8.0-syzkaller-11339-g741e9d668aa5 #0
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

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
