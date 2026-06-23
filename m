Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9826056C;
	Tue, 23 Jun 2026 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243170; cv=none; b=UhEvVu/hCSYIOJgFrEKyXd2PauRKgZkdtA4QVO0/6YqcC0F28+zzsPwwDb8Tg+yvoyjfhwRFIFai9dSzaIiRdeqMiknOv95bk0y19HVyPFxlqSv/bC/oAVn+RJE5T/wWhgGYIKpiFxCQVs+RPlSR1fVm7RW5XQ4AuUU4h6l7gdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243170; c=relaxed/simple;
	bh=ZhyYAv1LAk9Fd5ym1hfpDchpJgpRnThHsYVxslIz6hY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UP+o9NAPTdnT4e8WMdqVMHAop44SIvTZNdpPapjEQz+yKl32FDNfrd4ndmeNV3MBiEol8wk/6XSQumCNd0Vm5ctxFzRTr+XAdOSVIRdC1qLZkQ05qd10XSpWlx5tEWLTEJOIHTdHkGw/IY4ivJXpd9AzajOG52KSM7VcQWL2XZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjZcuymf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjZcuymf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB4F1F000E9;
	Tue, 23 Jun 2026 19:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782243168;
	bh=zjmjqIXfFLoKYyECjDc2KJQLsVIQCOnpPpM/XShRwso=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mjZcuymftxtlGpBNIhpghDdGRjBp2Eocq6XDg2sUogJ5H12rH/9wPJIj51NyxiRty
	 MmJYyVZa8F6XcHJojx4R/eiGCIaHwlGWPt3Peol7oZfFWEqstXUy+5d6rLplPRhr2L
	 ouAGTytVdpp/nAuUGB6ToqvwiPfnFgN36fw7dJW7uMsBXPtAdeugUHQeLD4m9kQ78T
	 jPHxM8Qm4KrG3G5NfLYt6tRGkb4a664RHOc7+Wrem1wupP81L0ZVjgr/z53szr5FIE
	 oxKkYHI3zjDH2H06WGC/EpZEYecx3MtdtpM+FVhlqjnM9ND2BojWej+bBmWPWogsXA
	 VZt+QDy6qH0Hw==
Content-Type: multipart/mixed; boundary="===============8256220830597851060=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bd4abd3f584c38f1fc512a9d3ae1f90c2a374588fa23529b32b7f1aed6ab2ead@mail.kernel.org>
In-Reply-To: <20260623-sockmap-lookup-udp-leak-v1-2-05804f9308e4@rbox.co>
References: <20260623-sockmap-lookup-udp-leak-v1-2-05804f9308e4@rbox.co>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for UDP sock leak on sockmap lookup-bind-release
From: bot+bpf-ci@kernel.org
To: mhal@rbox.co,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,cong.wang@bytedance.com,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,mhal@rbox.co,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 19:32:47 +0000 (UTC)

--===============8256220830597851060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add test for UDP sock leak on sockmap lookup-bind-release
>
>     Setup and join a cgroup, then attach a cgroup/connect4 program that runs
>
>        sk = bpf_map_lookup_elem(sockmap, 0)
>        bpf_bind(ctx, sa, sizeof(sa))
>        bpf_sk_release(sk)
>
>     Unpatched kernel leaks the socket.
>
>     Signed-off-by: Michal Luczaj <mhal@rbox.co>

This test reproduces a UDP socket leak across sockmap lookup-bind-release,
but there is no Fixes: tag.

The sibling fix commit a2510dc351c5 ("bpf, sockmap: Don't leak UDP socks on
lookup-bind-release") carries a Fixes: tag pointing at the commit that lifted
the socket-state restriction allowing unbound UDP sockets into sockmap.

Should this test carry the same tag so it stays backportable alongside the
fix?

  Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28049771327
--===============8256220830597851060==--
