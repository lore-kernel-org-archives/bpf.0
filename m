Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A3DC4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 11:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBF22084B
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 11:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfDCLEH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:04:07 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:58827 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCLEH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 07:04:07 -0400
Received: by mail-it1-f198.google.com with SMTP id j203so5700850itb.8
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2019 04:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3qN9LVQZu3klRSxNZuClxEYR7nj02W6nPHM7AUw+rpk=;
        b=j3qje5AkmgnMx/Dwb4SwSP6NUQGcQL0JOtKmnRbWI5eelCCgl4TwxtywI30N4yjKQ6
         yGzlHAAKxJ69Vh625GTE8uhS6GTrD1q5cG5LOin0R/WCeWAJhDrrDN34JQy6Qv5BMn5S
         Ld/nqmwWo3M1bV+wV/cpbZdqlzbzhcunHbd0COWEqKNllMeWCtqTfGz06hdWaq3sLTUn
         UtcUF3Oj33UKScnsuJyxPhMPtbZDP57/rTl5pFU4+VraQ9ow/+0KI6gaRmOCIgp6n7um
         zvn4hm82H69FQhef1UTXVD3B5r0pJsrS9NinjbH0stsu0iPQCZJd9x5tmU0KusnLD7FR
         BREg==
X-Gm-Message-State: APjAAAXfzvDC86427lIZFRvi4DiY1+pJe8GJKIY89mvNWNdOkUfHTsxb
        GsRsu6zksdxfHtE/QfLeTYq0n1WVeDqD12PPXjuunJYp0Wkz
X-Google-Smtp-Source: APXvYqzJs6NNTkiVSUYK+uRCDhyLX736hKeMKN0eW1ug+rfqLdaCW0lWVaID1ysRKBWAh7pIMGCXDssUxBSNOLUK1yT+lzP2enLb
MIME-Version: 1.0
X-Received: by 2002:a02:c611:: with SMTP id i17mr14871jan.23.1554289445824;
 Wed, 03 Apr 2019 04:04:05 -0700 (PDT)
Date:   Wed, 03 Apr 2019 04:04:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bf9c805859e36d4@google.com>
Subject: BUG: using __this_cpu_read() in preemptible code in sk_mc_loop
From:   syzbot <syzbot+537175332b212b4d885b@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, ecree@solarflare.com, fw@strlen.de,
        idosch@mellanox.com, jiri@mellanox.com, kafai@fb.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        lirongqing@baidu.com, netdev@vger.kernel.org, petrm@mellanox.com,
        sd@queasysnail.net, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e1427237 macsec: add noinline tag to avoid a frame size wa..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11269673200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e9bc94c16d346a6
dashboard link: https://syzkaller.appspot.com/bug?extid=537175332b212b4d885b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147a3553200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ef9c4b200000

The bug was bisected to:

commit 97cdcf37b57e3f204be3000b9eab9686f38b4356
Author: Florian Westphal <fw@strlen.de>
Date:   Mon Apr 1 14:42:13 2019 +0000

     net: place xmit recursion in softnet data

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1084ac4b200000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1284ac4b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1484ac4b200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+537175332b212b4d885b@syzkaller.appspotmail.com
Fixes: 97cdcf37b57e ("net: place xmit recursion in softnet data")

check_preemption_disabled: 3 callbacks suppressed
BUG: using __this_cpu_read() in preemptible [00000000] code:  
syz-executor284/7845
caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]
caller is sk_mc_loop+0x1d/0x210 net/core/sock.c:705
CPU: 0 PID: 7845 Comm: syz-executor284 Not tainted 5.1.0-rc2+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __this_cpu_preempt_check+0x246/0x270 lib/smp_processor_id.c:47
  dev_recursion_level include/linux/netdevice.h:3052 [inline]
  sk_mc_loop+0x1d/0x210 net/core/sock.c:705
  ip_mc_output+0x2ef/0xf70 net/ipv4/ip_output.c:352
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  ip_push_pending_frames+0x64/0x80 net/ipv4/ip_output.c:1485
  raw_sendmsg+0x1e6d/0x2f20 net/ipv4/raw.c:676
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  kernel_sendmsg+0x44/0x50 net/socket.c:681
  sock_no_sendpage+0x116/0x150 net/core/sock.c:2716
  inet_sendpage+0x44a/0x630 net/ipv4/af_inet.c:820
  kernel_sendpage+0x95/0xf0 net/socket.c:3643
  sock_sendpage+0x8b/0xc0 net/socket.c:934
  pipe_to_sendpage+0x299/0x370 fs/splice.c:448
  splice_from_pipe_feed fs/splice.c:499 [inline]
  __splice_from_pipe+0x395/0x7d0 fs/splice.c:623
  splice_from_pipe+0x108/0x170 fs/splice.c:658
  generic_splice_sendpage+0x3c/0x50 fs/splice.c:828
  do_splice_from fs/splice.c:847 [inline]
  do_splice+0x70a/0x13c0 fs/splice.c:1154
  __do_sys_splice fs/splice.c:1424 [inline]
  __se_sys_splice fs/splice.c:1404 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1404
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4458b9
Code: e8 bc b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f10219b5da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dac58 RCX: 00000000004458b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dac50 R08: 0000000000010005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac5c
R13: 00007ffcadb0d1df R14: 00007f10219b69c0 R15: 20c49ba5e353f7cf
BUG: using __this_cpu_read() in preemptible [00000000] code:  
syz-executor284/7845
caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]
caller is sk_mc_loop+0x1d/0x210 net/core/sock.c:705
CPU: 0 PID: 7845 Comm: syz-executor284 Not tainted 5.1.0-rc2+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __this_cpu_preempt_check+0x246/0x270 lib/smp_processor_id.c:47
  dev_recursion_level include/linux/netdevice.h:3052 [inline]
  sk_mc_loop+0x1d/0x210 net/core/sock.c:705
  ip_mc_output+0x2ef/0xf70 net/ipv4/ip_output.c:352
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  ip_push_pending_frames+0x64/0x80 net/ipv4/ip_output.c:1485
  raw_sendmsg+0x1e6d/0x2f20 net/ipv4/raw.c:676
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  kernel_sendmsg+0x44/0x50 net/socket.c:681
  sock_no_sendpage+0x116/0x150 net/core/sock.c:2716
  inet_sendpage+0x44a/0x630 net/ipv4/af_inet.c:820
  kernel_sendpage+0x95/0xf0 net/socket.c:3643
  sock_sendpage+0x8b/0xc0 net/socket.c:934
  pipe_to_sendpage+0x299/0x370 fs/splice.c:448
  splice_from_pipe_feed fs/splice.c:499 [inline]
  __splice_from_pipe+0x395/0x7d0 fs/splice.c:623
  splice_from_pipe+0x108/0x170 fs/splice.c:658
  generic_splice_sendpage+0x3c/0x50 fs/splice.c:828
  do_splice_from fs/splice.c:847 [inline]
  do_splice+0x70a/0x13c0 fs/splice.c:1154
  __do_sys_splice fs/splice.c:1424 [inline]
  __se_sys_splice fs/splice.c:1404 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1404
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4458b9
Code: e8 bc b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f10219b5da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dac58 RCX: 00000000004458b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dac50 R08: 0000000000010005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac5c
R13: 00007ffcadb0d1df R14: 00007f10219b69c0 R15: 20c49ba5e353f7cf
BUG: using __this_cpu_read() in preemptible [00000000] code:  
syz-executor284/7845
caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]
caller is sk_mc_loop+0x1d/0x210 net/core/sock.c:705
CPU: 0 PID: 7845 Comm: syz-executor284 Not tainted 5.1.0-rc2+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __this_cpu_preempt_check+0x246/0x270 lib/smp_processor_id.c:47
  dev_recursion_level include/linux/netdevice.h:3052 [inline]
  sk_mc_loop+0x1d/0x210 net/core/sock.c:705
  ip_mc_output+0x2ef/0xf70 net/ipv4/ip_output.c:352
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  ip_push_pending_frames+0x64/0x80 net/ipv4/ip_output.c:1485
  raw_sendmsg+0x1e6d/0x2f20 net/ipv4/raw.c:676
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  kernel_sendmsg+0x44/0x50 net/socket.c:681
  sock_no_sendpage+0x116/0x150 net/core/sock.c:2716
  inet_sendpage+0x44a/0x630 net/ipv4/af_inet.c:820
  kernel_sendpage+0x95/0xf0 net/socket.c:3643
  sock_sendpage+0x8b/0xc0 net/socket.c:934
  pipe_to_sendpage+0x299/0x370 fs/splice.c:448
  splice_from_pipe_feed fs/splice.c:499 [inline]
  __splice_from_pipe+0x395/0x7d0 fs/splice.c:623
  splice_from_pipe+0x108/0x170 fs/splice.c:658
  generic_splice_sendpage+0x3c/0x50 fs/splice.c:828
  do_splice_from fs/splice.c:847 [inline]
  do_splice+0x70a/0x13c0 fs/splice.c:1154
  __do_sys_splice fs/splice.c:1424 [inline]
  __se_sys_splice fs/splice.c:1404 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1404
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4458b9
Code: e8 bc b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f10219b5da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dac58 RCX: 00000000004458b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dac50 R08: 0000000000010005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac5c
R13: 00007ffcadb0d1df R14: 00007f10219b69c0 R15: 20c49ba5e353f7cf
BUG: using __this_cpu_read() in preemptible [00000000] code:  
syz-executor284/7845
caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]
caller is sk_mc_loop+0x1d/0x210 net/core/sock.c:705
CPU: 0 PID: 7845 Comm: syz-executor284 Not tainted 5.1.0-rc2+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __this_cpu_preempt_check+0x246/0x270 lib/smp_processor_id.c:47
  dev_recursion_level include/linux/netdevice.h:3052 [inline]
  sk_mc_loop+0x1d/0x210 net/core/sock.c:705
  ip_mc_output+0x2ef/0xf70 net/ipv4/ip_output.c:352
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  ip_push_pending_frames+0x64/0x80 net/ipv4/ip_output.c:1485
  raw_sendmsg+0x1e6d/0x2f20 net/ipv4/raw.c:676
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  kernel_sendmsg+0x44/0x50 net/socket.c:681
  sock_no_sendpage+0x116/0x150 net/core/sock.c:2716
  inet_sendpage+0x44a/0x630 net/ipv4/af_inet.c:820
  kernel_sendpage+0x95/0xf0 net/socket.c:3643
  sock_sendpage+0x8b/0xc0 net/socket.c:934
  pipe_to_sendpage+0x299/0x370 fs/splice.c:448
  splice_from_pipe_feed fs/splice.c:499 [inline]
  __splice_from_pipe+0x395/0x7d0 fs/splice.c:623
  splice_from_pipe+0x108/0x170 fs/splice.c:658
  generic_splice_sendpage+0x3c/0x50 fs/splice.c:828
  do_splice_from fs/splice.c:847 [inline]
  do_splice+0x70a/0x13c0 fs/splice.c:1154
  __do_sys_splice fs/splice.c:1424 [inline]
  __se_sys_splice fs/splice.c:1404 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1404
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4458b9
Code: e8 bc b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f10219b5da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dac58 RCX: 00000000004458b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dac50 R08: 0000000000010005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac5c
R13: 00007ffcadb0d1df R14: 00007f10219b69c0 R15: 20c49ba5e353f7cf
BUG: using __this_cpu_read() in preemptible [00000000] code:  
syz-executor284/7845
caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]
caller is sk_mc_loop+0x1d/0x210 net/core/sock.c:705
CPU: 0 PID: 7845 Comm: syz-executor284 Not tainted 5.1.0-rc2+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __this_cpu_preempt_check+0x246/0x270 lib/smp_processor_id.c:47
  dev_recursion_level include/linux/netdevice.h:3052 [inline]
  sk_mc_loop+0x1d/0x210 net/core/sock.c:705
  ip_mc_output+0x2ef/0xf70 net/ipv4/ip_output.c:352
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  ip_push_pending_frames+0x64/0x80 net/ipv4/ip_output.c:1485
  raw_sendmsg+0x1e6d/0x2f20 net/ipv4/raw.c:676
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  kernel_sendmsg+0x44/0x50 net/socket.c:681
  sock_no_sendpage+0x116/0x150 net/core/sock.c:2716
  inet_sendpage+0x44a/0x630 net/ipv4/af_inet.c:820
  kernel_sendpage+0x95/0xf0 net/socket.c:3643
  sock_sendpage+0x8b/0xc0 net/socket.c:934
  pipe_to_sendpage+0x299/0x370 fs/splice.c:448
  splice_from_pipe_feed fs/splice.c:499 [inline]
  __splice_from_pipe+0x395/0x7d0 fs/splice.c:623
  splice_from_pipe+0x108/0x170 fs/splice.c:658
  generic_splice_sendpage+0x3c/0x50 fs/splice.c:828
  do_splice_from fs/splice.c:847 [inline]
  do_splice+0x70a/0x13c0 fs/splice.c:1154
  __do_sys_splice fs/splice.c:1424 [inline]
  __se_sys_splice fs/splice.c:1404 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1404
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4458b9
Code: e8 bc b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f10219b5da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dac58 RCX: 00000000004458b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dac50 R08: 0000000000010005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac5c
R13: 00007ffcadb0d1df R14: 00007f10219b69c0 R15: 20c49ba5e353f7cf
BUG: using __this_cpu_read() in preemptible [00000000] code:  
syz-executor284/7845
caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]
caller is sk_mc_loop+0x1d/0x210 net/core/sock.c:705
CPU: 0 PID: 7845 Comm: syz-executor284 Not tainted 5.1.0-rc2+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __this_cpu_preempt_check+0x246/0x270 lib/smp_processor_id.c:47
  dev_recursion_level include/linux/netdevice.h:3052 [inline]
  sk_mc_loop+0x1d/0x210 net/core/sock.c:705
  ip_mc_output+0x2ef/0xf70 net/ipv4/ip_output.c:352
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  ip_push_pending_frames+0x64/0x80 net/ipv4/ip_output.c:1485
  raw_sendmsg+0x1e6d/0x2f20 net/ipv4/raw.c:676
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  kernel_sendmsg+0x44/0x50 net/socket.c:681
  sock_no_sendpage+0x116/0x150 net/core/sock.c:2716
  inet_sendpage+0x44a/0x630 net/ipv4/af_inet.c:820
  kernel_sendpage+0x95/0xf0 net/socket.c:3643
  sock_sendpage+0x8b/0xc0 net/socket.c:934
  pipe_to_sendpage+0x299/0x370 fs/splice.c:448
  splice_from_pipe_feed fs/splice.c:499 [inline]
  __splice_from_pipe+0x395/0x7d0 fs/splice.c:623
  splice_from_pipe+0x108/0x170 fs/splice.c:658
  generic_splice_sendpage+0x3c/0x50 fs/splice.c:828
  do_splice_from fs/splice.c:847 [inline]
  do_splice+0x70a/0x13c0 fs/splice.c:1154
  __do_sys_splice fs/splice.c:1424 [inline]
  __se_sys_splice fs/splice.c:1404 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1404
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4458b9
Code: e8 bc b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f10219b5da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dac58 RCX: 00000000004458b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dac50 R08: 0000000000010005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac5c
R13: 00007ffcadb0d1df R14: 00007f10219b69c0 R15: 20c49ba5e353f7cf
BUG: using __this_cpu_read() in preemptible [00000000] code:  
syz-executor284/7845
caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]
caller is sk_mc_loop+0x1d/0x210 net/core/sock.c:705
CPU: 0 PID: 7845 Comm: syz-executor284 Not tainted 5.1.0-rc2+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __this_cpu_preempt_check+0x246/0x270 lib/smp_processor_id.c:47
  dev_recursion_level include/linux/netdevice.h:3052 [inline]
  sk_mc_loop+0x1d/0x210 net/core/sock.c:705
  ip_mc_output+0x2ef/0xf70 net/ipv4/ip_output.c:352
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  ip_push_pending_frames+0x64/0x80 net/ipv4/ip_output.c:1485
  raw_sendmsg+0x1e6d/0x2f20 net/ipv4/raw.c:676
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  kernel_sendmsg+0x44/0x50 net/socket.c:681
  sock_no_sendpage+0x116/0x150 net/core/sock.c:2716
  inet_sendpage+0x44a/0x630 net/ipv4/af_inet.c:820
  kernel_sendpage+0x95/0xf0 net/socket.c:3643
  sock_sendpage+0x8b/0xc0 net/socket.c:934
  pipe_to_sendpage+0x299/0x370 fs/splice.c:448
  splice_from_pipe_feed fs/splice.c:499 [inline]
  __splice_from_pipe+0x395/0x7d0 fs/splice.c:623
  splice_from_pipe+0x108/0x170 fs/splice.c:658
  generic_splice_sendpage+0x3c/0x50 fs/splice.c:828
  do_splice_from fs/splice.c:847 [inline]
  do_splice+0x70a/0x13c0 fs/splice.c:1154
  __do_sys_splice fs/splice.c:1424 [inline]
  __se_sys_splice fs/splice.c:1404 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1404
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4458b9
Code: e8 bc b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f10219b5da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dac58 RCX: 00000000004458b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dac50 R08: 0000000000010005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac5c
R13: 00007ffcadb0d1df R14: 00007f10219b69c0 R15: 20c49ba5e353f7cf
BUG: using __this_cpu_read() in preemptible [00000000] code:  
syz-executor284/7845
caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]
caller is sk_mc_loop+0x1d/0x210 net/core/sock.c:705
CPU: 0 PID: 7845 Comm: syz-executor284 Not tainted 5.1.0-rc2+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __this_cpu_preempt_check+0x246/0x270 lib/smp_processor_id.c:47
  dev_recursion_level include/linux/netdevice.h:3052 [inline]
  sk_mc_loop+0x1d/0x210 net/core/sock.c:705
  ip_mc_output+0x2ef/0xf70 net/ipv4/ip_output.c:352
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  ip_push_pending_frames+0x64/0x80 net/ipv4/ip_output.c:1485
  raw_sendmsg+0x1e6d/0x2f20 net/ipv4/raw.c:676
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  kernel_sendmsg+0x44/0x50 net/socket.c:681
  sock_no_sendpage+0x116/0x150 net/core/sock.c:2716
  inet_sendpage+0x44a/0x630 net/ipv4/af_inet.c:820
  kernel_sendpage+0x95/0xf0 net/socket.c:3643
  sock_sendpage+0x8b/0xc0 net/socket.c:934
  pipe_to_sendpage+0x299/0x370 fs/splice.c:448
  splice_from_pipe_feed fs/splice.c:499 [inline]
  __splice_from_pipe+0x395/0x7d0 fs/splice.c:623
  splice_from_pipe+0x108/0x170 fs/splice.c:658
  generic_splice_sendpage+0x3c/0x50 fs/splice.c:828
  do_splice_from fs/splice.c:847 [inline]
  do_splice+0x70a/0x13c0 fs/splice.c:1154
  __do_sys_splice fs/splice.c:1424 [inline]
  __se_sys_splice fs/splice.c:1404 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1404
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4458b9
Code: e8 bc b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f10219b5da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dac58 RCX: 00000000004458b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dac50 R08: 0000000000010005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac5c
R13: 00007ffcadb0d1df R14: 00007f10219b69c0 R15: 20c49ba5e353f7cf
BUG: using __this_cpu_read() in preemptible [00000000] code:  
syz-executor284/7845
caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]
caller is sk_mc_loop+0x1d/0x210 net/core/sock.c:705
CPU: 0 PID: 7845 Comm: syz-executor284 Not tainted 5.1.0-rc2+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __this_cpu_preempt_check+0x246/0x270 lib/smp_processor_id.c:47
  dev_recursion_level include/linux/netdevice.h:3052 [inline]
  sk_mc_loop+0x1d/0x210 net/core/sock.c:705
  ip_mc_output+0x2ef/0xf70 net/ipv4/ip_output.c:352
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  ip_push_pending_frames+0x64/0x80 net/ipv4/ip_output.c:1485
  raw_sendmsg+0x1e6d/0x2f20 net/ipv4/raw.c:676
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  kernel_sendmsg+0x44/0x50 net/socket.c:681
  sock_no_sendpage+0x116/0x150 net/core/sock.c:2716
  inet_sendpage+0x44a/0x630 net/ipv4/af_inet.c:820
  kernel_sendpage+0x95/0xf0 net/socket.c:3643
  sock_sendpage+0x8b/0xc0 net/socket.c:934
  pipe_to_sendpage+0x299/0x370 fs/splice.c:448
  splice_from_pipe_feed fs/splice.c:499 [inline]
  __splice_from_pipe+0x395/0x7d0 fs/splice.c:623
  splice_from_pipe+0x108/0x170 fs/splice.c:658
  generic_splice_sendpage+0x3c/0x50 fs/splice.c:828
  do_splice_from fs/splice.c:847 [inline]
  do_splice+0x70a/0x13c0 fs/splice.c:1154
  __do_sys_splice fs/splice.c:1424 [inline]
  __se_sys_splice fs/splice.c:1404 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1404
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4458b9
Code: e8 bc b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f10219b5da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dac58 RCX: 00000000004458b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dac50 R08: 0000000000010005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac5c
R13: 00007ffcadb0d1df R14: 00007f10219b69c0 R15: 20c49ba5e353f7cf
BUG: using __this_cpu_read() in preemptible [00000000] code:  
syz-executor284/7845
caller is dev_recursion_level include/linux/netdevice.h:3052 [inline]
caller is sk_mc_loop+0x1d/0x210 net/core/sock.c:705
CPU: 0 PID: 7845 Comm: syz-executor284 Not tainted 5.1.0-rc2+ #118
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __this_cpu_preempt_check+0x246/0x270 lib/smp_processor_id.c:47
  dev_recursion_level include/linux/netdevice.h:3052 [inline]
  sk_mc_loop+0x1d/0x210 net/core/sock.c:705
  ip_mc_output+0x2ef/0xf70 net/ipv4/ip_output.c:352
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  ip_push_pending_frames+0x64/0x80 net/ipv4/ip_output.c:1485
  raw_sendmsg+0x1e6d/0x2f20 net/ipv4/raw.c:676
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  kernel_sendmsg+0x44/0x50 net/socket.c:681
  sock_no_sendpage+0x116/0x150 net/core/sock.c:2716
  inet_sendpage+0x44a/0x630 net/ipv4/af_inet.c:820
  kernel_sendpage+0x95/0xf0 net/socket.c:3643
  sock_sendpage+0x8b/0xc0 net/socket.c:934
  pipe_to_sendpage+0x299/0x370 fs/splice.c:448
  splice_from_pipe_feed fs/splice.c:499 [inline]
  __splice_from_pipe+0x395/0x7d0 fs/splice.c:623
  splice_from_pipe+0x108/0x170 fs/splice.c:658
  generic_splice_sendpage+0x3c/0x50 fs/splice.c:828
  do_splice_from fs/splice.c:847 [inline]
  do_splice+0x70a/0x13c0 fs/splice.c:1154
  __do_sys_splice fs/splice.c:1424 [inline]
  __se_sys_splice fs/splice.c:1404 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1404
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4458b9
Code: e8 bc b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f10219b5da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dac58 RCX: 00000000004458b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006dac50 R08: 0000000000010005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
