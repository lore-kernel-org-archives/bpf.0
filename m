Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB043148D8
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770375771; cv=none; b=VtcQeM6jTuDp8bZDDjbj6M1yno7SyEvwKa6QGvy9rasQEluBcZcHpcUenP4y+EDni0vzaJRArK0r6L0aNdgfnrzseNFZAQNS1DKkt5leNiQlcggagbPpz5oFL4Uypqu1AYstcY2P6fRCuVpPKdYGf4jGb0cgXOCnqYsfvpOV49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770375771; c=relaxed/simple;
	bh=c/HL+hLMk1S54ZdP/yEhYQJxVhG8qWcHT5w266q1DZo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=gU+lqubxpZawT7933T2LL4scSxpTLwPEHNeN2KLQrFxasW9W63VzWNVIpFdefY/QcwOYUa4k6Fh076iF84C/F9MexCL9kyLY5D1ntF5ChL/J+fTxekzYMaP8CB4xJeA4kNVJEEscsyH9Jln5bEA3UdFZ9Qx3VBH9Myg3dRUkNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-66b612efb4aso6446068eaf.0
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 03:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770375770; x=1770980570;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9VdhVgIGjmOOKTCWSn/jv6x+s4k2P/EWeOh2kleuP4=;
        b=eHzglZA6E25fd2xIGXhUVBdzJ98nrGBs+SuGcsH+niCewoumCADIngnf6AbqjpKrmK
         yZlI8Bf9P8xA3DhEt72GuLr50MPEuv+MgSUDCc9Xz9AvNNBNEzR+RPTJOGTlrYXXKQv3
         Wd9HpAHJg3n0xyBF+nVlFcUaAp6SzMyDNFY8tNNxBu2s0SN1oJSJAhZZytWuBEgSB3Y8
         Mm6J3y9xarAD6nx5KCxgPeD9cj4F4RHBtjml3HHYAyUFY69bSrf1fdLkWf1stavEwXME
         AOfABqCt9FsxjCH5nuZnGVIdHdPacA6lR0m48QUlP+K86QSyui1st3ZNLO6SAkb598yc
         E8LQ==
X-Gm-Message-State: AOJu0YxO6QM1o07ikva8PDVgpXE1eNWJcxVlFqCbbWWxIUXY6dvpZnpJ
	PgNfs2P293pyya8ZXZvYPKAXaWBCNvmNAeC41Idegk035cuaBidkTguaPBMvCL25F9AZnUWqZtd
	r2to6gREmtUalD3qCrLh+8sgY4IIFc8TaV00PnSrAiLRZrzM4boMj9dTR5GM=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2107:b0:66b:2d47:a773 with SMTP id
 006d021491bc7-66ba7d810c4mr2942377eaf.36.1770375769897; Fri, 06 Feb 2026
 03:02:49 -0800 (PST)
Date: Fri, 06 Feb 2026 03:02:49 -0800
In-Reply-To: <20260206055113.63476-1-yangfeng59949@163.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6985ca59.050a0220.3b3015.003c.GAE@google.com>
Subject: [syzbot ci] Re: bpf: test_run: Fix the null pointer dereference issue
 in bpf_lwt_xmit_push_encap
From: syzbot ci <syzbot+ci413db63641e7571b@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, yangfeng59949@163.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
https://lore.kernel.org/all/20260206055113.63476-1-yangfeng59949@163.com
* [PATCH v3] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap

and found the following issue:
WARNING in skb_dst_set_noref

Full report is available here:
https://ci.syzbot.org/series/ebdff606-6251-4db9-ab50-448f5433094a

***

WARNING in skb_dst_set_noref

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      1ace9bac1ad2bc6a0a70baaa16d22b7e783e88c5
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/673700c1-fa90-4aa2-8342-e6b397961829/config
C repro:   https://ci.syzbot.org/findings/ad5a5f81-3d84-45ac-90ec-9a169eb16405/c_repro
syz repro: https://ci.syzbot.org/findings/ad5a5f81-3d84-45ac-90ec-9a169eb16405/syz_repro

------------[ cut here ]------------
!rcu_read_lock_held() && !rcu_read_lock_bh_held()
WARNING: ./include/linux/skbuff.h:1235 at skb_dst_set_noref+0x14a/0x1a0 include/linux/skbuff.h:1235, CPU#1: syz.0.17/5979
Modules linked in:
CPU: 1 UID: 0 PID: 5979 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:skb_dst_set_noref+0x14a/0x1a0 include/linux/skbuff.h:1235
Code: 5d 00 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 9b 80 e9 01 cc e8 95 58 30 f8 90 0f 0b 90 e9 2f ff ff ff e8 87 58 30 f8 90 <0f> 0b 90 e9 5d ff ff ff 44 89 e1 80 e1 07 38 c1 0f 8c 76 ff ff ff
RSP: 0018:ffffc90004487a20 EFLAGS: 00010293
RAX: ffffffff89923f99 RBX: ffffc90004487ba0 RCX: ffff888103713a80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffc90004487be3 R09: 1ffff92000890f7c
R10: dffffc0000000000 R11: fffff52000890f7d R12: 0000000000000000
R13: ffff88817331d858 R14: 1ffff1102e663b0b R15: ffff88817331d800
FS:  0000555590ae6500(0000) GS:ffff8882a9928000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fb63fff CR3: 00000001139cc000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 bpf_prog_test_run_skb+0xed8/0x1eb0 net/bpf/test_run.c:1164
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4721
 __sys_bpf+0x643/0x950 kernel/bpf/syscall.c:6246
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6339
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f21c579acb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4c8461d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f21c5a15fa0 RCX: 00007f21c579acb9
RDX: 0000000000000050 RSI: 0000200000000780 RDI: 000000000000000a
RBP: 00007f21c5808bf7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f21c5a15fac R14: 00007f21c5a15fa0 R15: 00007f21c5a15fa0
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.
