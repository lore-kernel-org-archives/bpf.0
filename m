Return-Path: <SRS0=GR7L=RI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703D8C43381
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 17:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B5F20661
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 17:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xv6Q1O5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfCERbk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:31:40 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:48183 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfCERbj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Mar 2019 12:31:39 -0500
Received: by mail-yw1-f74.google.com with SMTP id i21so13864787ywe.15
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2019 09:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=fJJcDLI76E3jQBRmfxjhzi6Klcat3Bj3NmhLf4cXxFk=;
        b=Xv6Q1O5IlISrrOIzXcTglxYm7X/wM901414G3rkMwfWed6HOz0Ut4iKlpL70bmx36Q
         COvlv8CdJ208pkeZv5+stYokysH5lx2E7rTJNq+gSOOVqzevHpo5nf2hUDB80SqNmXK7
         WatHxHGITKolVsKgCCpC/EmW1+aeXIneot9BQfCxrJbOBvsaTf8+c3Fm9LDTKyxe/VHa
         DHYfO6/aDOuKLoLNfF2PHORiErqCfb/PZsgf+AYmtiCsmYEHgZq/CQYI4YDgl0EASxAj
         ZWYYdUxE2sOGOyyh/idauEOTpt6eAp7vcH8bGzUSDVOJocfblUEpbrRi0Ahzt9sUfnXv
         +wfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=fJJcDLI76E3jQBRmfxjhzi6Klcat3Bj3NmhLf4cXxFk=;
        b=XnaoM8h6OKWRsjFiLIzHdqhrac+lkpz/CLgbGweuKRB7VCnLkO31POeY7Bd+0NfOvz
         3d907A7J1x53bUmNoJAPiObUMdzmDWp468xsWZG7IpIqJG8ZMioJ52W8NSAok2aIVy56
         IgDRQ5+1+8rgOQo0NiDrXvxxbJa36kraqvSBrPBVO+eIPAvANTf9DtEBgNKkGo20ipA9
         od+0VtQHshsSdfxw6Yg01eGPfjhYhDAY4W81bR01hhzHQMw1T6fuf3Dxn0O0vrWvYsF0
         WprMZGyOVmwv4NAv2//564x71cwNI3MVwuyDQ2CUZ0VE/JeiDxCGPt2wvoC2S+N5kdKS
         5BoQ==
X-Gm-Message-State: APjAAAUskRKI+uA2Qcta4Jl4LxICy8TIY9uifRizTpyFoG3atoLyebNe
        i/jQuO1CrBgAL0MkuLSmO6LF4G+kq66J6w==
X-Google-Smtp-Source: APXvYqzSqyEObMDKJ0bvm2WYYEqE/wh5veMKP2IRcbuph9+prDHE16pA/IE/Px6eChfkY/6RMizUvHx6vW6OEQ==
X-Received: by 2002:a25:9b82:: with SMTP id v2mr1734813ybo.58.1551807098246;
 Tue, 05 Mar 2019 09:31:38 -0800 (PST)
Date:   Tue,  5 Mar 2019 09:31:26 -0800
Message-Id: <20190305173126.167142-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH net] xsk: fix potential crash in xsk_diag_put_umem()
From:   Eric Dumazet <edumazet@google.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        bpf <bpf@vger.kernel.org>, syzbot <syzkaller@googlegroups.com>,
        "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes two typos in xsk_diag_put_umem()

syzbot reported the following crash :

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7641 Comm: syz-executor946 Not tainted 5.0.0-rc7+ #95
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 01/01/2011
RIP: 0010:xsk_diag_put_umem net/xdp/xsk_diag.c:71 [inline]
RIP: 0010:xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
RIP: 0010:xsk_diag_dump+0xdcb/0x13a0 net/xdp/xsk_diag.c:143
Code: 8d be c0 04 00 00 48 89 f8 48 c1 e8 03 42 80 3c 20 00 0f 85 39 04 00 =
00 49 8b 96 c0 04 00 00 48 8d 7a 14 48 89 f8 48 c1 e8 03 <42> 0f b6 0c 20 4=
8 89 f8 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85
RSP: 0018:ffff888090bcf2d8 EFLAGS: 00010203
RAX: 0000000000000002 RBX: ffff8880a0aacbc0 RCX: ffffffff86ffdc3c
RDX: 0000000000000000 RSI: ffffffff86ffdc70 RDI: 0000000000000014
RBP: ffff888090bcf438 R08: ffff88808e04a700 R09: ffffed1011c74174
R10: ffffed1011c74173 R11: ffff88808e3a0b9f R12: dffffc0000000000
R13: ffff888093a6d818 R14: ffff88808e365240 R15: ffff88808e3a0b40
FS:  00000000011ea880(0000) GS:ffff8880ae900000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000008fa13000 CR4: 00000000001406e0
Call Trace:
 netlink_dump+0x55d/0xfb0 net/netlink/af_netlink.c:2252
 __netlink_dump_start+0x5b4/0x7e0 net/netlink/af_netlink.c:2360
 netlink_dump_start include/linux/netlink.h:226 [inline]
 xsk_diag_handler_dump+0x1b2/0x250 net/xdp/xsk_diag.c:170
 __sock_diag_cmd net/core/sock_diag.c:232 [inline]
 sock_diag_rcv_msg+0x322/0x410 net/core/sock_diag.c:263
 netlink_rcv_skb+0x17a/0x460 net/netlink/af_netlink.c:2485
 sock_diag_rcv+0x2b/0x40 net/core/sock_diag.c:274
 netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
 netlink_unicast+0x536/0x720 net/netlink/af_netlink.c:1336
 netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1925
 sock_sendmsg_nosec net/socket.c:622 [inline]
 sock_sendmsg+0xdd/0x130 net/socket.c:632
 sock_write_iter+0x27c/0x3e0 net/socket.c:923
 call_write_iter include/linux/fs.h:1863 [inline]
 do_iter_readv_writev+0x5e0/0x8e0 fs/read_write.c:680
 do_iter_write fs/read_write.c:956 [inline]
 do_iter_write+0x184/0x610 fs/read_write.c:937
 vfs_writev+0x1b3/0x2f0 fs/read_write.c:1001
 do_writev+0xf6/0x290 fs/read_write.c:1036
 __do_sys_writev fs/read_write.c:1109 [inline]
 __se_sys_writev fs/read_write.c:1106 [inline]
 __x64_sys_writev+0x75/0xb0 fs/read_write.c:1106
 do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440139
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcc966cc18 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440139
RDX: 0000000000000001 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000004 R11: 0000000000000246 R12: 00000000004019c0
R13: 0000000000401a50 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 460a3c24d0a656c9 ]---
RIP: 0010:xsk_diag_put_umem net/xdp/xsk_diag.c:71 [inline]
RIP: 0010:xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
RIP: 0010:xsk_diag_dump+0xdcb/0x13a0 net/xdp/xsk_diag.c:143
Code: 8d be c0 04 00 00 48 89 f8 48 c1 e8 03 42 80 3c 20 00 0f 85 39 04 00 =
00 49 8b 96 c0 04 00 00 48 8d 7a 14 48 89 f8 48 c1 e8 03 <42> 0f b6 0c 20 4=
8 89 f8 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85
RSP: 0018:ffff888090bcf2d8 EFLAGS: 00010203
RAX: 0000000000000002 RBX: ffff8880a0aacbc0 RCX: ffffffff86ffdc3c
RDX: 0000000000000000 RSI: ffffffff86ffdc70 RDI: 0000000000000014
RBP: ffff888090bcf438 R08: ffff88808e04a700 R09: ffffed1011c74174
R10: ffffed1011c74173 R11: ffff88808e3a0b9f R12: dffffc0000000000
R13: ffff888093a6d818 R14: ffff88808e365240 R15: ffff88808e3a0b40
FS:  00000000011ea880(0000) GS:ffff8880ae800000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001d22000 CR3: 000000008fa13000 CR4: 00000000001406f0

Fixes: a36b38aa2af6 ("xsk: add sock_diag interface for AF_XDP")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
---
 net/xdp/xsk_diag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index 661d007c3b2887223ecf417e1fb6f970b50146e8..d5e06c8e0cbf9f30fdcdfb6a6ce=
65f7356c9d89e 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -68,9 +68,9 @@ static int xsk_diag_put_umem(const struct xdp_sock *xs, s=
truct sk_buff *nlskb)
 	err =3D nla_put(nlskb, XDP_DIAG_UMEM, sizeof(du), &du);
=20
 	if (!err && umem->fq)
-		err =3D xsk_diag_put_ring(xs->tx, XDP_DIAG_UMEM_FILL_RING, nlskb);
+		err =3D xsk_diag_put_ring(umem->fq, XDP_DIAG_UMEM_FILL_RING, nlskb);
 	if (!err && umem->cq) {
-		err =3D xsk_diag_put_ring(xs->tx, XDP_DIAG_UMEM_COMPLETION_RING,
+		err =3D xsk_diag_put_ring(umem->cq, XDP_DIAG_UMEM_COMPLETION_RING,
 					nlskb);
 	}
 	return err;
--=20
2.21.0.352.gf09ad66450-goog

