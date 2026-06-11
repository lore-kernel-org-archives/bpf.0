Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CAE37187F
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216509; cv=none; b=ZwVYhny5yLFuNfVzHMdS39hVyvJpkpSEYOok8UywBFu0lr5pWCFKY8Nh0hxg9so3rH5UId48D5ossYvD8fbZIjy6YAa19xVR7mr7AHO58eIL6xPEuPt/6Oxgyvbzz97Mg+R17o0lgK1RTB4XyBRHclWqPuC/oYAOrgW9AdnCgas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216509; c=relaxed/simple;
	bh=03zOrgILckneEiMyuAdOeRem4RM/lLOfEanNgT8gOrU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dw2VzDtxIDMyp1F+EvY5pqj6DzITXGSoRcqvu4c/fDnz+muPtJd4D5CpZTXWRq6aFq4bB5IDTrR6yVbJFOuiqVsgkaIgoUip4U5521tdYmNSWIjS+UlBrP/MP8pKSGyyG8Bb2TRIybXeC3hLrtdSC4td1Sa9UkdgP99ThAqE/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=lC9XW+bq; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="lC9XW+bq"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304df7ff4c2so920353eec.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 15:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781216505; x=1781821305; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCnO02eYeJt2uyHOY/DCYVdDPKyN1BpC+esypIRAZjg=;
        b=lC9XW+bqW6mK582x2dJ7ekMLaWB9jorFeJz5Hg8XafGzeiAzF+NbJ2fwSbW2bKhO9m
         qKExLmR046Qd2UFp+DT8w63fdS1FzJ0CGvK96TzyqUDYwHMnNb+B3saRh/d6FzXIlN6e
         pYOdA/ojcfZfp0hLj3qO2P7Ollz6YHrQVpcB2MX2IpSobjb7AFwT81WgjEJO3c4N9IZF
         7acd6zcI0XwHLe2ru0UaYfA69ky3qinSaFVx/025++Cyq0KA7bois6+NCFRLxHk4avOK
         442cry2tqR0SNTXXpitS6xydCm9+I103OMiL3/9znWkmCT77L+/0bby9ClJSBB/aIDfl
         f+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781216505; x=1781821305;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCnO02eYeJt2uyHOY/DCYVdDPKyN1BpC+esypIRAZjg=;
        b=JI9cznq5tcZrcU98fbVSq9rc+UXK7sGsH571W/IzPBYgWpJ3g0x3DZF7i3unKyomQ6
         nCnZJ49lmEtUOxmzw8XJUlN+UlIr07cAkhiXViRn049+mbu0Ri+olCElYgafI/HUAEpj
         gkGmVQQAuQ0IgCjNOhbM3vw4H/Odb7sEVlVclzzSAq30bOI47q0dOiacVkgmWwLxEOLt
         5CGmEVx+2uiIM4jtnTq9ERCxIxKgM5CLviS4wW+p13bHyD19JXZI6HHMYKycDYOZnXYa
         ynYp+cITcvfCRT6b5LNIVoAqkrlmXFg3bJH7itXDv+MbYJoZvhTnCFS/4pQop86obMre
         Apsg==
X-Forwarded-Encrypted: i=1; AFNElJ/DEt0bP14t8vQtyl+T3n71dIYIlO3BDK/VCF+vCqtTU1PQdQ9Sg/h0MqPDjYvc8pWiZG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aSqZgBXpLJx/vgRvWkgH17NNtHbeqlZHj8iqsAOnDcSHTync
	HdnrSdynOPQxUjpu5E+lJE7ENy+0XEsmq884bsZOTNJVLJ2ds1MFQYaOSgGud5qp0neIT7WwrpX
	uYezTWvg=
X-Gm-Gg: Acq92OGmjBUj2HCIuGGzedo1fBRJeci6VrEViE/7US/lv4yMLLtkXJZ8KvA8yf6oF3i
	j0wS475uvEMUMTAmyxvQlZjmm/ZAjM1PxEBmhDJ0E2KW2ol9SOjZ0R4bHDx6/hDVBkjiM9Eyqwk
	g56UDocxJNWd3Z4UMvHcQqn1YzppcZh/VAvWxxNkXhXc2LslwkfRF76a+Ff+SrLR5sqXPEUwoVj
	ZLFEvI3jT3jcZglmsmWqZUkS24TJWqU5vXw9Vp9aHxr4NyRMbdOlbXJxllzxRtRigiCRuCzZ+e5
	6LM2WXAM4ZSidb37bWMDMMuaZm26hvWxMv4mUYGe7kCMFO25ineT9tfoJLechvWKx90R9emfPwq
	uDNpuzYRVKgsorGvzHQ1siHb+fzzqOr2pPduDKrYjtEcGnnVxzQBFiNioZA7OCbvIgftDJK8juE
	VTqFG0
X-Received: by 2002:a05:7300:dc05:b0:304:d600:8731 with SMTP id 5a478bee46e88-3081f046f4emr360989eec.15.1781216505333;
        Thu, 11 Jun 2026 15:21:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::3c95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e489536sm667389eec.2.2026.06.11.15.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 15:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 18:21:42 -0400
Message-Id: <DJ6KJWQZ3GYR.162GLFN364ELE@etsalapatis.com>
Subject: Re: [PATCH bpf v2 5/7] sockmap: Fix use-after-free in
 udp_bpf_recvmsg()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Kuniyuki Iwashima" <kuniyu@google.com>,
 <syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, "Sechang Lim" <rhkrqnwk98@gmail.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Cong Wang"
 <cong.wang@bytedance.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-6-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-6-jiayuan.chen@linux.dev>

On Thu Jun 11, 2026 at 8:34 AM EDT, Jiayuan Chen wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> syzbot reported use-after-free of struct sk_msg in sk_msg_recvmsg(). [0]
>
> sk_msg_recvmsg() peeks sk_msg from psock->ingress_msg under a lock,
> but its processing is lockless.
>
> Thus, sk_msg_recvmsg() must be serialised by callers, otherwise
> multiple threads could touch the same sk_msg.
>
> For example, TCP uses lock_sock(), and AF_UNIX uses unix_sk(sk)->iolock.
>
> Initially, udp_bpf_recvmsg() had used lock_sock(), but the cited
> commit accidentally removed it.
>
> Let's serialise sk_msg_recvmsg() with lock_sock() in udp_bpf_recvmsg().
>
> Note that holding spin_lock_bh(&sk->sk_receive_queue.lock) is not
> an option due to copy_page_to_iter() in sk_msg_recvmsg().
>
> [0]:
> BUG: KASAN: slab-use-after-free in sk_msg_recvmsg+0xb54/0xc30 net/core/sk=
msg.c:428
> Read of size 4 at addr ffff88814cdcf000 by task syz.0.24/6020
>
> CPU: 1 UID: 0 PID: 6020 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 0=
1/13/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xba/0x230 mm/kasan/report.c:482
>  kasan_report+0x117/0x150 mm/kasan/report.c:595
>  sk_msg_recvmsg+0xb54/0xc30 net/core/skmsg.c:428
>  udp_bpf_recvmsg+0x4bd/0xe00 net/ipv4/udp_bpf.c:84
>  inet_recvmsg+0x260/0x270 net/ipv4/af_inet.c:891
>  sock_recvmsg_nosec net/socket.c:1078 [inline]
>  sock_recvmsg+0x1a8/0x270 net/socket.c:1100
>  ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2812
>  ___sys_recvmsg+0x215/0x590 net/socket.c:2854
>  do_recvmmsg+0x334/0x800 net/socket.c:2949
>  __sys_recvmmsg net/socket.c:3023 [inline]
>  __do_sys_recvmmsg net/socket.c:3046 [inline]
>  __se_sys_recvmmsg net/socket.c:3039 [inline]
>  __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3039
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb319f9aeb9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb31ad97028 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> RAX: ffffffffffffffda RBX: 00007fb31a216090 RCX: 00007fb319f9aeb9
> RDX: 0000000000000001 RSI: 0000200000000400 RDI: 0000000000000004
> RBP: 00007fb31a008c1f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000040000021 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fb31a216128 R14: 00007fb31a216090 R15: 00007ffe21dd0a98
>  </TASK>
>
> Allocated by task 6019:
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
>  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
>  kasan_kmalloc include/linux/kasan.h:263 [inline]
>  __kmalloc_cache_noprof+0x3d1/0x6e0 mm/slub.c:5780
>  kmalloc_noprof include/linux/slab.h:957 [inline]
>  kzalloc_noprof include/linux/slab.h:1094 [inline]
>  alloc_sk_msg net/core/skmsg.c:510 [inline]
>  sk_psock_skb_ingress_self+0x60/0x350 net/core/skmsg.c:612
>  sk_psock_verdict_apply net/core/skmsg.c:1038 [inline]
>  sk_psock_verdict_recv+0x7d9/0x8d0 net/core/skmsg.c:1236
>  udp_read_skb+0x73e/0x7e0 net/ipv4/udp.c:2045
>  sk_psock_verdict_data_ready+0x12d/0x550 net/core/skmsg.c:1257
>  __udp_enqueue_schedule_skb+0xc54/0x10b0 net/ipv4/udp.c:1789
>  __udp_queue_rcv_skb net/ipv4/udp.c:2346 [inline]
>  udp_queue_rcv_one_skb+0xac5/0x19c0 net/ipv4/udp.c:2475
>  __udp4_lib_mcast_deliver+0xc06/0xcf0 net/ipv4/udp.c:2585
>  __udp4_lib_rcv+0x10f6/0x2620 net/ipv4/udp.c:2724
>  ip_protocol_deliver_rcu+0x282/0x440 net/ipv4/ip_input.c:207
>  ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
>  NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
>  dst_input include/net/dst.h:474 [inline]
>  ip_sublist_rcv_finish+0x221/0x2a0 net/ipv4/ip_input.c:584
>  ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
>  ip_sublist_rcv+0x5c6/0xa70 net/ipv4/ip_input.c:644
>  ip_list_rcv+0x3f1/0x450 net/ipv4/ip_input.c:678
>  __netif_receive_skb_list_ptype net/core/dev.c:6195 [inline]
>  __netif_receive_skb_list_core+0x7e5/0x810 net/core/dev.c:6242
>  __netif_receive_skb_list net/core/dev.c:6294 [inline]
>  netif_receive_skb_list_internal+0x995/0xcf0 net/core/dev.c:6385
>  netif_receive_skb_list+0x54/0x410 net/core/dev.c:6437
>  xdp_recv_frames net/bpf/test_run.c:269 [inline]
>  xdp_test_run_batch net/bpf/test_run.c:350 [inline]
>  bpf_test_run_xdp_live+0x1946/0x1cf0 net/bpf/test_run.c:379
>  bpf_prog_test_run_xdp+0x81c/0x1160 net/bpf/test_run.c:1396
>  bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4703
>  __sys_bpf+0x5cb/0x920 kernel/bpf/syscall.c:6182
>  __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 6021:
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
>  poison_slab_object mm/kasan/common.c:253 [inline]
>  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
>  kasan_slab_free include/linux/kasan.h:235 [inline]
>  slab_free_hook mm/slub.c:2540 [inline]
>  slab_free mm/slub.c:6674 [inline]
>  kfree+0x1be/0x650 mm/slub.c:6882
>  kfree_sk_msg include/linux/skmsg.h:385 [inline]
>  sk_msg_recvmsg+0xaa8/0xc30 net/core/skmsg.c:483
>  udp_bpf_recvmsg+0x4bd/0xe00 net/ipv4/udp_bpf.c:84
>  inet_recvmsg+0x260/0x270 net/ipv4/af_inet.c:891
>  sock_recvmsg_nosec net/socket.c:1078 [inline]
>  sock_recvmsg+0x1a8/0x270 net/socket.c:1100
>  ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2812
>  ___sys_recvmsg+0x215/0x590 net/socket.c:2854
>  do_recvmmsg+0x334/0x800 net/socket.c:2949
>  __sys_recvmmsg net/socket.c:3023 [inline]
>  __do_sys_recvmmsg net/socket.c:3046 [inline]
>  __se_sys_recvmmsg net/socket.c:3039 [inline]
>  __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3039
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: 9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy")
> Reported-by: syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GAE@=
google.com/
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/ipv4/udp_bpf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 9f33b07b14813..ad57c4c9eaab6 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -50,7 +50,9 @@ static int udp_msg_wait_data(struct sock *sk, struct sk=
_psock *psock,
>  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>  	ret =3D udp_msg_has_data(sk, psock);
>  	if (!ret) {
> +		release_sock(sk);
>  		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> +		lock_sock(sk);
>  		ret =3D udp_msg_has_data(sk, psock);
>  	}
>  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> @@ -79,6 +81,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>  		goto out;
>  	}
> =20
> +	lock_sock(sk);
>  msg_bytes_ready:
>  	copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
>  	if (!copied) {
> @@ -90,11 +93,17 @@ static int udp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  		if (data) {
>  			if (psock_has_data(psock))
>  				goto msg_bytes_ready;
> +
> +			release_sock(sk);
> +
>  			ret =3D sk_udp_recvmsg(sk, msg, len, flags);
>  			goto out;
>  		}
>  		copied =3D -EAGAIN;
>  	}
> +
> +	release_sock(sk);
> +
>  	ret =3D copied;
>  out:
>  	sk_psock_put(sk, psock);

