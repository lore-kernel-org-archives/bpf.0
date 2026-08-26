Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B92456E07;
	Wed, 26 Aug 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766089; cv=none; b=kUNJxi6gYxQj9sgqAY3mFeYPp6JauYBrO7umk9VEVi2UWaEzdtndPRDCwlG2i9GbDeJ4sdaG5nK0dUI7v8cDY62jBfQQIWaH0xpR33iF/r702t/8E+B/W9/wm4ds1D5D4nubmJhHZZvTKuCCX57T5o3iDfoCZKBUvSR58uZywsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766089; c=relaxed/simple;
	bh=22r0YqOsDM3Wiu3pgnz9LlaM/qoRUmtVmNRbgkuy5kY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jVT6prfNqNR7fin3KpAHuNgPmybXTK+pf/jDQ4CUWKSo7w/X9Dt0aMKFbCUt3dJGPnTmAxT2HnjMPGVqYI+5Vwp8pzmvZD6EooDoeEhzzvRoIGfXFwQTDe3YWKnC4CFvbW0pFL71xu0uYJNqe7Z0LkOL1SwGcz3+X7566I+QG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2k1r/b3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2k1r/b3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109CD1F000E9;
	Wed, 26 Aug 2026 17:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766074;
	bh=cjbjfevmjX+6bh4sGbywuCu9uNTHgaNb51IEw952Kzw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=f2k1r/b3ZiW/KudAXSbiIm0YfCxy/m0pFrTK+uBAS8gdt1lkHESXNg8d4LZ2JF3z/
	 H/l1V6HSM7SYCtLZLvuoZQUX+/f8aqEGHfTLKfPuywvUg9fPnffDassTS02dQeqZE9
	 MVp1E0bpzt40jn685x5EUE8LbPpBN62t5Zqtlih9QHD1cmOqsKHMiPk0oI0yg9YNtR
	 WUd2fqCgU13A8IvQlhrWTuUmUWtNnKirBaqAkLqD78Sypw8SqkSrm4wU8Kk0xYH55B
	 jRrK2X+ktSGNIitgH/eINT/cS1S6nNAte9EPPeOrFJHVN/gQS2k4LdCpcxFzJzsdjo
	 zfG2XgKYAZ3WQ==
Content-Type: multipart/mixed; boundary="===============8719649204354848873=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d69c13a8e271e1bc257c5642ca6a378c0dc04a9400be37a5c9a429b0bda3be19@mail.kernel.org>
In-Reply-To: <20260826162110.99879-1-ahemadkhawar123@gmail.com>
References: <20260826162110.99879-1-ahemadkhawar123@gmail.com>
Subject: Re: [PATCH bpf-next v2] xsk: Fix circular locking dependency in xsk_notifier
From: bot+bpf-ci@kernel.org
To: ahemadkhawar123@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,sdf@fomichev.me,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,kuba@kernel.org,pabeni@redhat.com,edumazet@google.com,horms@kernel.org,syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 17:41:14 +0000 (UTC)

--===============8719649204354848873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     xsk: Fix circular locking dependency in xsk_notifier
>
>     syzbot reported a circular locking dependency involving &net->xdp.lock,
>     &xs->mutex, and netdev_lock_ops():
>
>     -> #2 (&net->xdp.lock):
>            xsk_notifier
>            unregister_netdevice_many_notify
>
>     -> #1 (&xs->mutex):
>            xsk_diag_dump
>
>     -> #0 (netdev_lock_ops):
>            xsk_bind

Does this lockdep chain match the syzbot report? Looking at the cited
report (message ID 6a8c9fd9.dbb3a75c.7844.000c.GAE@google.com), it shows
a four-lock cycle, not three:

    -> #3 (&net->xdp.lock)
           xsk_notifier <- ipvlan_device_event <-
           unregister_netdevice_many_notify <- rtnl_dellink
    -> #2 (&port->pnodes_lock)
           ipvlan_device_event
    -> #1 (&dev_instance_lock_key#23)
           netdev_lock_ops in xsk_bind+0x331 net/xdp/xsk.c:1627
    -> #0 (&xs->mutex)
           xsk_diag_fill net/xdp/xsk_diag.c:113 / xsk_diag_dump:166

    Chain exists of:
      &xs->mutex --> &port->pnodes_lock --> &net->xdp.lock

The report includes &port->pnodes_lock from drivers/net/ipvlan as a
load-bearing link in the chain, which this description omits entirely.

The lock numbering is also reversed. The report uses #3/#2/#1/#0 with
&xs->mutex as #0 (the lock being acquired that triggers the warning),
whereas the commit message renumbers them as #2/#1/#0 and places
netdev_lock_ops as #0 instead.

The causal analysis seems inconsistent too. The commit message states
"In xsk_notifier(), xp_clear_dev() was called while holding &xs->mutex...
this created a nested dependency of &xs->mutex -> netdev_lock_ops."

However, the report attributes the &xs->mutex -> netdev_lock edge to
xsk_bind(), not xsk_notifier(). The report's #1 entry shows:

    -> #1 (&dev_instance_lock_key#23){+.+.}-{4:4}:
           netdev_lock include/linux/netdevice.h:2861 [inline]
           netdev_lock_ops include/net/netdev_lock.h:42 [inline]
           xsk_bind+0x331/0x11d0 net/xdp/xsk.c:1627

Could the commit message be revised to accurately describe the lockdep
chain from the cited report, including all four locks and the correct
code paths that create each dependency?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32990621157
--===============8719649204354848873==--
