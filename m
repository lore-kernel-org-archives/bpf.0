Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5543B52F1
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022271; cv=none; b=Tj7nsovG0hFM2WArarZ8m59kowNTav+FEL36bDTsNVjIY5cXwkAroK8i8zTKU9hyFf0tmXHZefeC38fqic8b4L0YWzQJW1VLUHMbmiQ7QxdfGKSHpmk6p18gZdfe+ucdwqNPwHpVYUNCJfGUOdPb81kQKe8LrpmDWrqqaycH3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022271; c=relaxed/simple;
	bh=w0RkkI60n0NfVjeD3GCvWy9379xhuF9l5DYLh+Frc74=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lcHVojBZEeZbjUbvb8umaKp5HXlNZRwOc/TiqADg78331nusFXYGj20FJZsxWDkZlBitnRV1P/mAft9Gw1U5/qcqELEgUiFemSZHEvxmvbJ8fT8cGWoHmUSQZnvDUQ/MODSSbzPoG0ZuGl0vC6HfWsFqbocnhjowuYFNRraW088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-663006e4c3cso77692080eaf.2
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 04:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022269; x=1772627069;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vxgM2+7tBarSdr5Mf2egulRHzkOHvLOxJK/f02SHmAk=;
        b=eD15YFFOzvsAC4nKBp5bdZUd372XS3+K+TsHuzAlL4cVMnqpM+gIu/p3/+n53NxoSC
         SYTRiUC3hnX62VQeVotO9gRGlVqUdJ+BR2w3Wy/HX+WLV+4xjC6u5vvkNQH1GNdXq9JY
         u4/wEVuh6+otdSWB+4RQcuxTgp5HXuaj1TbhZSbXPd48unDX45CzViRcqdGK4TRaVSXw
         MfoY6WE306VVkz9iQdq89yRz350wAYJk4wgxD+Gk2BYgxmPmxSWCipRbxpj2+HYNJqwB
         50TL+oPZ7C5HrC/rxo11ArClXjnTWt9v75kGO5qndyXlHyWIl3S2jZw36+zl/53D3e3t
         fMRA==
X-Forwarded-Encrypted: i=1; AJvYcCUXhARO5DZKhyV314fu0o4YUnxQqBJoGQe5qgyQQm7w//7Kru+V67ftHQF9CJ1Oc2lgjgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/ojyIa/ZtF4NVgR0rSHJJtmcTfblPe7ReFUv/ymaCZjNz1WS
	cboldjlbe7iLmgCH70tyA1zYe2npTPt9XB3AY3lPJIvhwW9GDD8mZPGiaG8MZy612OzssGJEfj3
	MK9tLpzGP7lhXy0j2Jbz+wtZ2pLZMFChqHQcsEm24gJUqZUxjC3bhxwVMf+c=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a3:b0:679:94ff:6ea7 with SMTP id
 006d021491bc7-679c4251e3dmr8290560eaf.15.1772022268917; Wed, 25 Feb 2026
 04:24:28 -0800 (PST)
Date: Wed, 25 Feb 2026 04:24:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699ee9fc.050a0220.1cd54b.0009.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] KCSAN: data-race in sk_psock_drop / unix_stream_sendmsg
From: syzbot <syzbot+87f770387a9e5dc6b79b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    23b0f90ba871 Merge tag 'sysctl-7.00-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f3695a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70c3ed59b49365c3
dashboard link: https://syzkaller.appspot.com/bug?extid=87f770387a9e5dc6b79b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae3bcc875a04/disk-23b0f90b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a4dbd53da8f/vmlinux-23b0f90b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c3824777f5c/bzImage-23b0f90b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87f770387a9e5dc6b79b@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in sk_psock_drop / unix_stream_sendmsg

write to 0xffff88810220dc08 of 8 bytes by task 3611 on cpu 1:
 sk_psock_stop_verdict net/core/skmsg.c:1311 [inline]
 sk_psock_drop+0x12f/0x270 net/core/skmsg.c:896
 sk_psock_put include/linux/skmsg.h:506 [inline]
 sock_map_unref+0x2a5/0x300 net/core/sock_map.c:185
 __sock_map_delete net/core/sock_map.c:426 [inline]
 sock_map_delete_from_link net/core/sock_map.c:439 [inline]
 sock_map_unlink net/core/sock_map.c:1608 [inline]
 sock_map_remove_links+0x228/0x340 net/core/sock_map.c:1623
 sock_map_close+0xa1/0x340 net/core/sock_map.c:1684
 unix_release+0x4e/0x80 net/unix/af_unix.c:1183
 __sock_release net/socket.c:662 [inline]
 sock_close+0x6b/0x150 net/socket.c:1455
 __fput+0x29b/0x650 fs/file_table.c:469
 fput_close_sync+0xad/0x190 fs/file_table.c:574
 __do_sys_close fs/open.c:1509 [inline]
 __se_sys_close fs/open.c:1494 [inline]
 __x64_sys_close+0x55/0xf0 fs/open.c:1494
 x64_sys_call+0x275d/0x3020 arch/x86/include/generated/asm/syscalls_64.h:4
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88810220dc08 of 8 bytes by task 3605 on cpu 0:
 unix_stream_sendmsg+0x7f8/0xbb0 net/unix/af_unix.c:2480
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x5af/0x600 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2681
 x64_sys_call+0x194c/0x3020 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffffffff8486dd00 -> 0xffffffff8472c9f0

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3605 Comm: syz.4.30 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
==================================================================


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
