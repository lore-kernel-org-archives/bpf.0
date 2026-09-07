Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD6521222
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788804808; cv=none; b=XXtL/X/8USDfzsTdaAd6mvyGx7wdE1mDwDhqEX++klI8jkPI96twb8jXGRfYwGN4Tx7yiED3M+af7tzm0Mlf1Gvz01z2N/EZyALD6umfspHicBHSREWQ4+0P3vsAvdbw8kyJJoPgo8UP9J1tO8ZM3oH+r7TU5PW+OaGM1kxWFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788804808; c=relaxed/simple;
	bh=qCWRk6NNvF6vDMpmZHo9Ueq40DPrOWuJ7dexK/0j/yo=;
	h=From:Message-ID:Date:Subject:To:Cc:MIME-Version:Content-Type; b=e60LkRIdp9SAg6k60XiSb26FA3EQqBz70LGe0+Xh7Mxf2D+Uvc5BHqflTaexJ98aBfm111tVT5IZPlm+M5nmaFmhKkumc9EXI6/gbMZowVXLwcLtOMMNu5UGKjdwttO3nCTL9Ix8cbAVQMBKn8iceAIx+W2kjoQOIRCFk2NdEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=f6Ksgo7m; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=YsadLwD+; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="f6Ksgo7m";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="YsadLwD+"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=Cc:To:Subject:Date:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1788804806; x=1789409606; bh=Y1k9M3m0T020G6VgZc
	BGnYVq9doEsBQQyGYyOLclWTY=; b=f6Ksgo7m4NZWhYkfYAcyzgA9SG/kf1jyzO+Smfvknbgx+
	MgNI/9yuLc0W0f/9EJdg2Y49rC9UspwNPCqiKgHTFJmZIiTKaElzqPT7IRvBKmmnC4oP7FSXK44
	WLbdZLnbHeE9p6iyEHLOAM166LeBQJcz036qmZ8IsFNVFx0NlavjYFTfh+N+m7qwyPsdoEBep3Z
	e3LMi77fjLOGDe1MAJFFiwmvlCP52H0BAaiiTUyY+e+sujHm1eq9LBh/CvkbEuOwI70zuwvGr41
	LfrWuV1T1lOTXWKVYPiHs90fKKbC44Jd8z895zJFoqt/k6O4djQtigq23Bov2nqfND8wzOGg==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=Cc:To:Subject:Date:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1788804806; x=1789409606; bh=Y1k9M3m0T020G6VgZc
	BGnYVq9doEsBQQyGYyOLclWTY=; b=YsadLwD+XQnAoBlyCeOaln67O68DZ7i+Q36Huv1ocE6eK
	fVRzN2bkZAkUVINapUXwW1enDVsB5NH3ZMPqryikwRtLZ21XsMks8CFuecneq/QeAJI8a4uQTn1
	TBZQs+qirfywaVCXBz/5M4/ky8Yld9+acr0kD62E3QVe8as+03QIvT6P+4CLr8Dted4a6/OyFsk
	YIT78I+v3sRNWpNSeO1UHl892B9IoV4q73HlAL7jMom8MH6ZxuLlBSUgsQOazD0tWnLO1wT7KZQ
	8aexsXX2+v3w7zeqWvYtaJWp6ymqOOKRx0IdNlrHcyeTqnVb1ZR6oM43OP3SouiMtSpFaLKQ==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+adfca3e91be95776@bugs.sh>
Message-ID: <GCy0KRM2IcQGoJQTjJEU9D0maBxXzEDHuQpq@bugs.sh>
Date: Mon, 07 Sep 2026 18:13:15 +0000
Subject: [BUG] net/ipv6: use-after-free in seg6_bpf_has_valid_srh()
To: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Simon Horman" <horms@kernel.org>, "David
 Lebrun" <dlebrun@google.com>, "Mathieu Xhonneux" <m.xhonneux@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, co <co+adfca3e91be95776@bugs.sh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    net/ipv6
    crash   use-after-free in seg6_bpf_has_valid_srh()
    commit  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/trace/linux-trace")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+adfca3e91be95776@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/adfca3e91be95776/patch.diff
        report.md   https://bugs.sh/b/adfca3e91be95776/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/trace/linux-trace")
    VM setup       https://bugs.sh/b/adfca3e91be95776/run.sh
    config         https://bugs.sh/b/adfca3e91be95776/config.gz
    poc            https://bugs.sh/b/adfca3e91be95776/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in seg6_bpf_has_valid_srh (net/ipv6/seg6_lo=
cal.c:1411)
Write of size 1 at addr ffff88803012c6b1 by task exploit/5008
CPU: 0 UID: 0 PID: 5008 Comm: exploit Not tainted 7.2.0-07242-g7cbfb180945c=
 #65 PREEMPT(full)
Call Trace:
<IRQ>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
seg6_bpf_has_valid_srh (net/ipv6/seg6_local.c:1411)
input_action_end_bpf (net/ipv6/seg6_local.c:1463 (discriminator 1))
seg6_local_input_core (net/ipv6/seg6_local.c:1628)
seg6_local_input (net/ipv6/seg6_local.c:1650 (discriminator 1))
lwtunnel_input (net/core/lwtunnel.c:465)
ipv6_rcv (./include/net/dst.h:480 (discriminator 7) net/ipv6/ip6_input.c:11=
9 (discriminator 7) ./include/linux/netfilter.h:325 (discriminator 7) ./inc=
lude/linux/netfilter.h:319 (discriminator 7) net/ipv6/ip6_input.c:351 (disc=
riminator 7))
__netif_receive_skb_one_core (net/core/dev.c:6264 (discriminator 1))
__netif_receive_skb (net/core/dev.c:6377)
process_backlog (net/core/dev.c:6728)
__napi_poll.constprop.0 (net/core/dev.c:7787)
net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
handle_softirqs (kernel/softirq.c:645)
do_softirq (kernel/softirq.c:546 (discriminator 20) kernel/softirq.c:533 (d=
iscriminator 20))
</IRQ>
__local_bh_enable_ip (kernel/softirq.c:473)
__dev_queue_xmit (./include/linux/bottom_half.h:33 (discriminator 1) ./incl=
ude/linux/rcupdate.h:914 (discriminator 1) net/core/dev.c:4961 (discriminat=
or 1))
packet_xmit (./include/linux/netdevice.h:3461 net/packet/af_packet.c:277)
packet_sendmsg (net/packet/af_packet.c:3110 net/packet/af_packet.c:3142)
__sys_sendto (net/socket.c:800 (discriminator 1) net/socket.c:815 (discrimi=
nator 1) net/socket.c:2281 (discriminator 1))
__x64_sys_sendto (net/socket.c:2288 net/socket.c:2284 net/socket.c:2284)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:8=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Allocated by task 5008:
Freed by task 5008:
The buggy address belongs to the object at ffff88803012c680
which belongs to the cache skbuff_small_head of size 704
The buggy address is located 49 bytes inside of
freed 704-byte region [ffff88803012c680, ffff88803012c940)
The buggy address belongs to the physical page:
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__=
GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pi=
d 1, tgid 1 (swapper/0), ts 23240374303, free_ts 0
page_owner free stack trace missing
Memory state around the buggy address:
ffff88803012c580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup


