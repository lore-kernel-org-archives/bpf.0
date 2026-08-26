Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5346D3B27FB
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776650; cv=none; b=bHL1qW9Cpm7Klc10En586r6uFNQFq+yzpRZIClbAJ0XvWprso/gMg8m+sPyH3sLxZx6VX6/yJ9e2viEz4KY0xEJGjxbnNd8PllzCZxhpFojXRhzltBVOId6sowmDkXCok32HWdAxF8/eIToXFjUNm5Ob/B+az9rDOigU8Y99ugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776650; c=relaxed/simple;
	bh=LXfrlFG99DEOIw0cRJCftUGoI0X9FJkiYZEtUZxba1A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u3iym8GG0j5g/RIxNDkXx7zcXDa75w5bwliHDOAZWg12FctO+IMOXEJrr+fBuRUmdDUBMU6WXMwxO6STLZdHP5Q2DaO6z20BKtsbLPtaHax41vkacoaIRC6U/ODB0gC5MR5n7PWYOyMCj+BWVJIp1ImV1w0EygqMutoSP3W76JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-455efbd6e96so554418fac.1
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 13:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787776648; x=1788381448;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4+jspPqcElMTjRhnOz3CLRLOL16gFXFE8Y2iqUKNCqc=;
        b=d432DKspYEg6S+53T647mOHGI36C9XHpynDCpx8iBXgSjKqsOQv8CRibuVl5kHodGZ
         0qhqO1R80qGQuGH3G1aX4U9yZeqCp/kjmsznrzJng7wfCI1+1B3cWhHr6m28UoSZly8O
         MyD/zKPvcECdpk5XuqrOr240DPWShDaqxf68jlralDRrcHJw/YSiO/y/3hQoEpp0qCUv
         dikoFurOsqvUzU5zt2/3ZLWSWY0+5Gx4aTaLUkUoGPouEjJ1LaAZGZTU+EwxGcuPZOxy
         8HA+QHK0598IGHsoGCRwwVhYF7kPzgZIPadlK/b9cW0qdDq7n4tGpEDLdme74y96vHRK
         eLOg==
X-Forwarded-Encrypted: i=1; AHgh+RoGfrE4C90ZGOmqlByfdsnW3O7SzUJ0dqRj8S2DwPBdw3JYF6JWQUg9By7s4fFtjbuXW4w=@vger.kernel.org
X-Gm-Message-State: AFuF++neq0pGWmCzgRyVSeK4Bhw8ecTeWKZsQWsXFmHQSRYlZXEVMRkY
	S6Njgv5VRFfuGiNo7ClAxYiSfQtghtj8j6k2g2d4hudtg0B3zVJLhlZlFvAgp7EF8fklMi4JabH
	zeQXEA8qlXY477/TILXjZfvOhWDciRmEgLvwWrGUKFTckLIXg5eNPyETayrc=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:906:b0:6b1:b31f:132e with SMTP id
 006d021491bc7-6b1b31f134bmr780445eaf.6.1787776648316; Wed, 26 Aug 2026
 13:37:28 -0700 (PDT)
Date: Wed, 26 Aug 2026 13:37:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8f4e88.27659fcc.2ceef7.0008.GAE@google.com>
Subject: [syzbot] [bpf?] general protection fault in btf_type_show
From: syzbot <syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135ef179580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=37b56485bbbf90ad8489
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1437a179580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-818bebeb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6e4100526b12/vmlinux-818bebeb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/723c4783ee96/bzImage-818bebeb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37b56485bbbf90ad8489@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 2 UID: 0 PID: 5908 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:btf_type_show+0x223/0x2e0 kernel/bpf/btf.c:8232
Code: c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 48 8b 1c dd 40 25 fd 8b 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 77 48 8b 43 28 48 8b 0c 24 48 83 c4 08 4d 89 e9 5b
RSP: 0018:ffffc900034bf868 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000028
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc900034bf970 R11: 0000000000000001 R12: ffffffff9b96b140
R13: ffffc900034bf8e0 R14: ffff888035e3f600 R15: 0000000000000003
FS:  00005555665e7500(0000) GS:ffff8880d5da2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 0000000027a0f000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 btf_type_seq_show_flags+0xca/0x120 kernel/bpf/btf.c:8250
 htab_map_seq_show_elem+0x12e/0x350 kernel/bpf/hashtab.c:1669
 map_seq_show+0x13d/0x1e0 kernel/bpf/inode.c:293
 traverse.part.0.constprop.0+0x107/0x650 fs/seq_file.c:112
 traverse fs/seq_file.c:99 [inline]
 seq_read_iter+0x93f/0x1270 fs/seq_file.c:196
 seq_read+0x344/0x4d0 fs/seq_file.c:163
 vfs_read+0x1e4/0xb40 fs/read_write.c:572
 ksys_pread64 fs/read_write.c:764 [inline]
 __do_sys_pread64 fs/read_write.c:772 [inline]
 __se_sys_pread64 fs/read_write.c:769 [inline]
 __x64_sys_pread64+0x1eb/0x250 fs/read_write.c:769
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa99f79e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8937c6c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
RAX: ffffffffffffffda RBX: 00007fa99fa25fa0 RCX: 00007fa99f79e0d9
RDX: 0000000000000083 RSI: 0000200000002240 RDI: 0000000000000007
RBP: 00007fa99f835024 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000e5d6 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa99fa25fac R14: 00007fa99fa25fa0 R15: 00007fa99fa25fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btf_type_show+0x223/0x2e0 kernel/bpf/btf.c:8232
Code: c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 48 8b 1c dd 40 25 fd 8b 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 77 48 8b 43 28 48 8b 0c 24 48 83 c4 08 4d 89 e9 5b
RSP: 0018:ffffc900034bf868 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000028
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc900034bf970 R11: 0000000000000001 R12: ffffffff9b96b140
R13: ffffc900034bf8e0 R14: ffff888035e3f600 R15: 0000000000000003
FS:  00005555665e7500(0000) GS:ffff8880d5da2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 0000000027a0f000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	c1 ea 03             	shr    $0x3,%edx
   3:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   7:	0f 85 90 00 00 00    	jne    0x9d
   d:	48 8b 1c dd 40 25 fd 	mov    -0x7402dac0(,%rbx,8),%rbx
  14:	8b
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 8d 7b 28          	lea    0x28(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 77                	jne    0xa7
  30:	48 8b 43 28          	mov    0x28(%rbx),%rax
  34:	48 8b 0c 24          	mov    (%rsp),%rcx
  38:	48 83 c4 08          	add    $0x8,%rsp
  3c:	4d 89 e9             	mov    %r13,%r9
  3f:	5b                   	pop    %rbx


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
