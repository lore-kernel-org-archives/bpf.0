Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661F40B111
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834600; cv=none; b=B6XRDkAnpq6ygt9jVsA0YIK+M1KhuKy+Dq9n0iU8P9GKQbh8qKIrzEb69Mr/AsbuLelTcRQBPGtNBAHEC2bj+WQHTqTKGKVkFLREOWjl3inyWFPFuftjW2816zHMXc0M2vKO6FRKwBUHPd20ZM7FEWvhkv2ngFCEgLcnF8/AJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834600; c=relaxed/simple;
	bh=MRSnGejNdcct+4F9BQgiS4v8hDQnk5+Q9r8jg9KUXa8=;
	h=From:Message-ID:Date:Subject:To:MIME-Version:Content-Type; b=ArzLH50N0M286J+d0axblmfhi4UEdA7t0bjimRMGLnmmh4jK/WH081+ZEeCyIXiKJlmPiz/mt7+xfXD1AYl5YqePwlyBB8STrWHb3Y3p+u/e+ta2OR2MPwBxxJUWtFA/C8USpAwhSldTDo7neKHsF2FW/FX7Ra4V3lCX95GDYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=Jol0Bv6s; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=ESqal6fj; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="Jol0Bv6s";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="ESqal6fj"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834591; x=1788439391; bh=W4fm0u3HZdhfMBbhRO
	VOx1cU3LnYi3RVandcTDjcu3E=; b=Jol0Bv6sUhvBU4ktFdEyl++yy/5n7vz8myBOXeaSGkpdU
	akOVqqo3hijnL0hMi8QtguPpTFma7zNo4z2vdcF0NgUeU06sBKSVuXWEG+aCoTO/uRQVoWNBy7v
	X3WhtrowcirdfyKmZRkKgt5qGjODCAcz4SSXFo77oYTfCmGJ7Tirb082ZqTAcH4CSG4+vDKzhhE
	rFMEhC+XWrxpV8DnEskPj+A/728QblsMq6Pjh7L68UNola0z97/VPnrOreSQyZzHch6B2K16VBI
	Tq6ivTDx0JwC3+G03/qVKsoAd5HIsj1U+AFeY7iibweuQHiPWKTy3hQMsv9ey9vFSTw0GDyg==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834591; x=1788439391; bh=W4fm0u3HZdhfMBbhRO
	VOx1cU3LnYi3RVandcTDjcu3E=; b=ESqal6fjBRjl8zZIKAHrenPh8B8gjgx145Azm1F9SeqrX
	pZbHXvIBwiPX3BRmuwiThX7NFl2sJH3m95dMZ2CoWHwg+ulfGAR4YWykddkA7V0ZUrEJj8fKLvI
	xX+J6jWoNFJh3MEv+27CuPVq3VpFhK/lpMQ+5QuvN/AvX2Wu7t3YFxRdDLfdViy89NEAZhBQejx
	N9AsoSPUhKcED21KLXhEiJvM9eiat6X3VmjJYWEMu1zN8wuzNf4hWR2ynHkw186wcHpxnbnTqy1
	bOYWVUM/ijX2o7ZpVjy+KFWc3KamhG4vp33w1jIkvTF6IQFvkVMnIjCtQ6sF7VChDcEd9y9w==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+6155a794e60d2ebf@bugs.sh>
Message-ID: <BC0kQFzqFlua7hmRFXYJxLDaLlY5VAVsVW2p@bugs.sh>
Date: Thu, 27 Aug 2026 12:43:03 +0000
Subject: [BUG] net/core: use-after-free in sock_def_readable()
To: netdev@vger.kernel.org, bpf@vger.kernel.org, "John Fastabend" <john.fastabend@gmail.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Sabrina Dubroca" <sd@queasysnail.net>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    net/core
    crash   use-after-free in sock_def_readable()
    commit  4e15e89faac9 ("net: bnxt: ring the doorbell when SW USO exits e=
arly")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+6155a794e60d2ebf@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/6155a794e60d2ebf/patch.diff
        report.md   https://bugs.sh/b/6155a794e60d2ebf/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  4e15e89faac9 ("net: bnxt: ring the doorbell when SW USO =
exits early")
    VM setup       https://bugs.sh/b/6155a794e60d2ebf/run.sh
    config         https://bugs.sh/b/6155a794e60d2ebf/config.gz
    poc            https://bugs.sh/b/6155a794e60d2ebf/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in sock_def_readable+0x294/0x2d0
Read of size 8 at addr ffff888100477188 by task exploit/149
CPU: 1 UID: 0 PID: 149 Comm: exploit Tainted: G        W           7.0.0+ #=
131 PREEMPT(lazy)
Call Trace:
<IRQ>
dump_stack_lvl+0xb8/0xf0
print_report+0xd0/0x630
kasan_report+0xca/0x100
sock_def_readable+0x294/0x2d0
tcp_data_ready+0x115/0x580
tcp_data_queue+0x2569/0x4c30
tcp_rcv_established+0xa0f/0x37e0
tcp_v4_do_rcv+0x56c/0xb10
tcp_v4_rcv+0x2808/0x3f00
ip_protocol_deliver_rcu+0x6f/0x420
ip_local_deliver_finish+0x3bb/0x560
ip_local_deliver+0x2a7/0x300
ip_rcv+0x37e/0x400
__netif_receive_skb_one_core+0x19c/0x1f0
process_backlog+0x263/0x900
__napi_poll+0xba/0x6c0
net_rx_action+0x482/0xc90
handle_softirqs+0x1db/0x6a0
do_softirq.part.0+0x70/0x90
</IRQ>
__local_bh_enable_ip+0x7c/0x80
__dev_queue_xmit+0x99e/0x39a0
ip_finish_output2+0xf93/0x1860
__ip_finish_output+0x271/0x4a0
ip_finish_output+0x78/0x3d0
ip_output+0x19b/0x310
ip_local_out+0xd6/0x110
__ip_queue_xmit+0x905/0x1950
__tcp_transmit_skb+0x3918/0x4ca0
tcp_write_xmit+0xef3/0x78e0
__tcp_push_pending_frames+0xb0/0x340
tcp_push+0x48e/0x720
tcp_sendmsg_locked+0x1851/0x43a0
tcp_sendmsg+0x2f/0x50
inet_sendmsg+0xba/0x140
__sys_sendto+0x454/0x500
__x64_sys_sendto+0xe1/0x1c0
do_syscall_64+0x12f/0xc00
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x425e1a
Allocated by task 149:
kasan_save_stack+0x2f/0x50
kasan_save_track+0x10/0x30
__kasan_slab_alloc+0x6a/0x70
kmem_cache_alloc_lru_noprof+0x1d1/0x580
sock_alloc_inode+0x27/0x290
alloc_inode+0x65/0x240
sock_alloc+0x43/0x240
__sock_create+0xc1/0x520
__sys_socket+0x14e/0x260
__x64_sys_socket+0x73/0xb0
do_syscall_64+0x12f/0xc00
entry_SYSCALL_64_after_hwframe+0x76/0x7e
Freed by task 0:
kasan_save_stack+0x2f/0x50
kasan_save_track+0x10/0x30
kasan_save_free_info+0x37/0x60
__kasan_slab_free+0x3f/0x60
kmem_cache_free+0xfe/0x4d0
i_callback+0x47/0x70
rcu_core+0x8dc/0x1110
handle_softirqs+0x1db/0x6a0
__irq_exit_rcu+0x146/0x240
sysvec_apic_timer_interrupt+0x9d/0xc0
asm_sysvec_apic_timer_interrupt+0x16/0x20
Last potentially related work creation:
kasan_save_stack+0x2f/0x50
kasan_record_aux_stack+0x88/0xa0
__call_rcu_common.constprop.0+0x76/0x8e0
destroy_inode+0x131/0x1b0
evict+0x54b/0x850
iput+0x5ca/0x7b0
dentry_unlink_inode+0x2ad/0x490
__dentry_kill+0x1d8/0x600
finish_dput+0x4b/0x260
dput.part.0+0x2d1/0x3f0
dput+0x20/0x30
__fput+0x51c/0xb90
fput_close_sync+0x119/0x250
__x64_sys_close+0x8c/0x120
do_syscall_64+0x12f/0xc00
entry_SYSCALL_64_after_hwframe+0x76/0x7e
The buggy address belongs to the object at ffff888100477100
which belongs to the cache sock_inode_cache of size 768
The buggy address is located 136 bytes inside of
freed 768-byte region [ffff888100477100, ffff888100477400)
The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x100474
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x100000000000040(head|node=3D0|zone=3D2)
page_type: f5(slab)
raw: 0100000000000040 ffff888100b1a280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000800120012 00000000f5000000 0000000000000000
head: 0100000000000040 ffff888100b1a280 dead000000000122 0000000000000000
head: 0000000000000000 0000000800120012 00000000f5000000 0000000000000000
head: 0100000000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
Memory state around the buggy address:
ffff888100477080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff888100477100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888100477180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff888100477200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff888100477280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000000


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


