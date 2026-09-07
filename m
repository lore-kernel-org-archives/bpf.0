Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374F2C11EE;
	Mon,  7 Sep 2026 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776377; cv=none; b=LRPl2+X1juVbl29haDYfVSBWTScqNoo1Obu48JwZo3GstyvBmh7tuD//QnOzxMXGNwk+df73YmKLY6X5Xug5bbQXCqJP4JumMYCwDK3NaOPQeuQDPI50w7h19kQll9eUg86kymrIbNT3jyxU4Pyv9P7BKOsDB2oJNOW39zStNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776377; c=relaxed/simple;
	bh=6d7gMyjKxr/l7HlxfudaAzuJOUwkTRvMW6NcYfHRJmU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YhG6Apw8MS26f2Pnc5LxuGGH+qxoDMOYdTsEtJ7cn9yhJ134dG7T2eJ29bhBzKmXt4Ln2r7hU5dOdIJ3niJrgmg8oUcjEa016q49z2atqGK5vCDtCXeSdlQdnHbvZx6UYI6PGj3xnc2rBA0uZv2uE7+quUSVE0kHpW4eQEDTX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVIhlkvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVIhlkvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E381F00A3A;
	Mon,  7 Sep 2026 10:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776375;
	bh=uJpEQumiMK8QBjz1f4FE6/TgKaoIasT/3Xx2aix74JQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TVIhlkvnVb16X7uiy3QySHSeop9L+rdNyBJaQSRoy+u9yf3enRT/TBoBl+CxyqtT/
	 Z1oF/oLZVvDUwbVITa5j1IycsTAkr9RuMYqh0J9du+9BBBl0P4hyR19mjuJ5FYw1E+
	 htw/bXQS18M6fqPsuY5Xq9TkSqOn0UrcJp7oY7Rsf7XKKruc5iabTpggWeJvl/4ojU
	 Pmf/UaYlcfkF6xeVf1tHk9ZTc96WRRDfIa+c843mg9vY75uuU9qqpamHQf9a4poQna
	 jb6CnCwl35jxOpwYw+xIX4L5o/QZbBcvgFbMZibtoY9acIdAOl2YRa1Gt/k+Lat3l/
	 rpzRF9Z6FOfcA==
Message-ID: <9857cc27cd1c5bb8778141263fd79b29298fe24a.camel@kernel.org>
Subject: Re: [PATCH v2] bpf, sockmap: Fix self-redirect copied_seq
 double-counting
From: Geliang Tang <geliang@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Mon, 07 Sep 2026 18:19:28 +0800
In-Reply-To: <949b0983-4491-474f-b105-5a69925dab69@linux.dev>
References: 
	<1d2370f4c81f10834b8dd77524924575c629a464.1788591198.git.tanggeliang@kylinos.cn>
	 <949b0983-4491-474f-b105-5a69925dab69@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiayuan,

On Mon, 2026-09-07 at 09:34 +0800, Jiayuan Chen wrote:
> 
> On 9/5/26 3:03 PM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > When a BPF stream_verdict program redirects an skb back to the same
> > socket (self-redirect with BPF_F_INGRESS), sk_psock_verdict_apply()
> > calls tcp_eat_skb() which advances tcp_sk->copied_seq. However, the
> > skb is then delivered to the socket's psock ingress queue and later
> > read by tcp_bpf_recvmsg_parser(), which also advances copied_seq
> > via
> > the copied_from_self accounting path. This double-counting causes
> > copied_seq to advance by 2x the actual data length, triggering:
> > 
> >    TCP recvmsg seq # bug 2: copied BF2E806, seq BF2E7FD, \
> > 			   rcvnxt BF2E806, fl 0
> >    WARNING: net/ipv4/tcp.c:2745 at tcp_recvmsg_locked+0x72b/0x2640
> >    Call Trace:
> >     tcp_recvmsg+0x10a/0x500
> >     sock_recvmsg+0x168/0x1d0
> >     __sys_recvfrom+0x19a/0x2a0
> >     __x64_sys_recvfrom+0xe4/0x1f0
> >     do_syscall_64+0xf7/0x530
> >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> >    cleanup rbuf bug: copied BF2E806 seq BF2E806 rcvnxt BF2E806
> >    WARNING: net/ipv4/tcp.c:1609 at tcp_cleanup_rbuf+0xf2/0x1c0
> >    Call Trace:
> >     tcp_recvmsg_locked+0x8d1/0x2640
> >     tcp_recvmsg+0x10a/0x500
> >     sock_recvmsg+0x168/0x1d0
> >     __sys_recvfrom+0x19a/0x2a0
> >     __x64_sys_recvfrom+0xe4/0x1f0
> >     do_syscall_64+0xf7/0x530
> >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Fix this by converting self-redirect verdict to __SK_PASS at the
> > beginning of sk_psock_verdict_apply(). This bypasses the
> > __SK_REDIRECT case entirely (which calls sk_psock_eat_skb), letting
> > the __SK_PASS path queue the skb to the psock ingress queue. The
> > data is then read via tcp_bpf_recvmsg_parser(), which advances
> > copied_seq exactly once through copied_from_self. Cross-socket
> > redirects continue through __SK_REDIRECT with sk_psock_eat_skb()
> > unchanged.
> > 
> > Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling
> > copied_seq")
> > Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > v2:
> >   - fixup the verdict as Jakub and Jiayuan suggested.
> > 
> > v1:
> >   -
> > https://patchwork.kernel.org/project/netdevbpf/patch/b840c35fdfdf36e9fddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn/
> > ---
> >   net/core/skmsg.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index 2521b643fa05..df385a5a961e 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -1000,6 +1000,10 @@ static int sk_psock_verdict_apply(struct
> > sk_psock *psock, struct sk_buff *skb,
> >   	int err = 0;
> >   	u32 len, off;
> >   
> > +	if (verdict == __SK_REDIRECT && skb_bpf_ingress(skb) &&
> > +	    skb_bpf_redirect_fetch(skb) == psock->sk)
> > +		verdict = __SK_PASS;
> > +
> >   	switch (verdict) {
> >   	case __SK_PASS:
> >   		err = -EIO;
> 
> 
> LGTM.
> 
> Please target to bpf tree so that BPF CI cat capature it.

Sorry, I forgot to add the prefix. It's been a while since I last sent
a patch to the bpf mailing list. Just to confirm, I should use [PATCH
bpf] instead of [PATCH bpf-next] for this fix, correct?

Thanks,
-Geliang

> 
> 
> Thanks
> 
