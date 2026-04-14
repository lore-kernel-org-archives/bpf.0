Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB622A4EE;
	Tue, 14 Apr 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179796; cv=none; b=s5Euf08BOgFfTmr4DXxNWkXtPJqAJw8u85iTp848bQQnXDzQAiNC2nfNoJGtjWYmxMkSSC40MHJrlUDiF4k1hYh2d/j3fxIQCH+L8LukTYyGXDM+wfHpf99N8oVtuH6OCiXebr24ZXs7/ksu8s00eaGUcv3qM8HyXRaHC4Lqk+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179796; c=relaxed/simple;
	bh=taFpJsD3cqIQOrfDn60ksBezLhwXN4BUzm+oTo6qMes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbBNyWxXMFQS4glpNMLtWod52AO0MGInVQln/12fB9ulpdqXHD5gEsf7riEM8SYZVSFTIYXYP1gPuD5AKSBsdeatBtXD2MZoCvLbKtpdOV8jxAyx3C1Znfth+/LEwP3lknniqXcEaQykfGXjE2ye8fYyUfsvcwiltsTGCAoin4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=wMlkdLdy; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="wMlkdLdy"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWL-00FB5S-Cc; Tue, 14 Apr 2026 16:13:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=4eT1He741IBIbbJ2jmi515EMC/YD4I27qYRlmYaD+Bo=; b=wMlkdLdytFjiDq4XynqAPmggfN
	OknHwajgelQAKtjdqwm38RwDRn3oVGeup/b36BGlYufvwIZ7aRZzB3KH/V6vh1uXRQsU5NubiUFFZ
	BXcAlO7LwlQAqP24AYRNbx33oO8d7LuIHugLDBYkeNaGQuFBvBOi9f3qt1Fz8M461WSBcyhujY0Yp
	PWpzpUYu87OsiQeJ01+ssM2NPFOjeonOcSbNi1bhrVZnRVcmNpzY5PD8V78KroYsJsbdviOXhIsp1
	Bd4CKvB96mud5vqejnFe5djIHJSMb68MwfAq4+np+EqFn4XbjcW/J7QRng8T/wvaYS7INf5bZcfG2
	TN0+k61Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wCeWL-0000Uf-1x; Tue, 14 Apr 2026 16:13:41 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wCeWF-00DhbX-Jw; Tue, 14 Apr 2026 16:13:35 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 14 Apr 2026 16:13:19 +0200
Subject: [PATCH bpf v4 5/5] bpf, sockmap: Take state lock for af_unix iter
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-unix-proto-update-null-ptr-deref-v4-5-2af6fe97918e@rbox.co>
References: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
In-Reply-To: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

When a BPF iterator program updates a sockmap, there is a race condition in
unix_stream_bpf_update_proto() where the `peer` pointer can become stale[1]
during a state transition TCP_ESTABLISHED -> TCP_CLOSE.

        CPU0 bpf                          CPU1 close
        --------                          ----------
// unix_stream_bpf_update_proto()
sk_pair = unix_peer(sk)
if (unlikely(!sk_pair))
   return -EINVAL;
                                     // unix_release_sock()
                                     skpair = unix_peer(sk);
                                     unix_peer(sk) = NULL;
                                     sock_put(skpair)
sock_hold(sk_pair) // UaF

More practically, this fix guarantees that the iterator program is
consistently provided with a unix socket that remains stable during
iterator execution.

[1]:
BUG: KASAN: slab-use-after-free in unix_stream_bpf_update_proto+0x155/0x490
Write of size 4 at addr ffff8881178c9a00 by task test_progs/2231
Call Trace:
 dump_stack_lvl+0x5d/0x80
 print_report+0x170/0x4f3
 kasan_report+0xe4/0x1c0
 kasan_check_range+0x125/0x200
 unix_stream_bpf_update_proto+0x155/0x490
 sock_map_link+0x71c/0xec0
 sock_map_update_common+0xbc/0x600
 sock_map_update_elem+0x19a/0x1f0
 bpf_prog_bbbf56096cdd4f01_selective_dump_unix+0x20c/0x217
 bpf_iter_run_prog+0x21e/0xae0
 bpf_iter_unix_seq_show+0x1e0/0x2a0
 bpf_seq_read+0x42c/0x10d0
 vfs_read+0x171/0xb20
 ksys_read+0xff/0x200
 do_syscall_64+0xf7/0x5e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Allocated by task 2236:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_slab_alloc+0x63/0x80
 kmem_cache_alloc_noprof+0x1d5/0x680
 sk_prot_alloc+0x59/0x210
 sk_alloc+0x34/0x470
 unix_create1+0x86/0x8a0
 unix_stream_connect+0x318/0x15b0
 __sys_connect+0xfd/0x130
 __x64_sys_connect+0x72/0xd0
 do_syscall_64+0xf7/0x5e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 2236:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x70
 __kasan_slab_free+0x47/0x70
 kmem_cache_free+0x11c/0x590
 __sk_destruct+0x432/0x6e0
 unix_release_sock+0x9b3/0xf60
 unix_release+0x8a/0xf0
 __sock_release+0xb0/0x270
 sock_close+0x18/0x20
 __fput+0x36e/0xac0
 fput_close_sync+0xe5/0x1a0
 __x64_sys_close+0x7d/0xd0
 do_syscall_64+0xf7/0x5e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Fixes: 2c860a43dd77 ("bpf: af_unix: Implement BPF iterator for UNIX domain socket.")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/unix/af_unix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 590a30d3b2f7..15b48cc6e9b0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3737,6 +3737,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
 		return 0;
 
 	lock_sock(sk);
+	unix_state_lock(sk);
 
 	if (unlikely(sock_flag(sk, SOCK_DEAD))) {
 		ret = SEQ_SKIP;
@@ -3748,6 +3749,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
 	prog = bpf_iter_get_info(&meta, false);
 	ret = unix_prog_seq_show(prog, &meta, v, uid);
 unlock:
+	unix_state_unlock(sk);
 	release_sock(sk);
 	return ret;
 }

-- 
2.53.0

