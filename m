Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980693;
	b=yj3kEdLrHK0gLIN42FXv4bCpt2IgtAO3Vz5njEj0JMhOKEq/NT0Zihh9c9t5F2D2PwSF
	 fWxfHiDDN/mkc3Tciig5Mf1JDgjjAs5pihvVhVbhAG38gzo+ntp4uqchRDhz4K4Dp6gpP
	 NX0ikRat73FXc/q2+FJopVdqhwFrGr2s1ffyHoz/vGJsAd0SuFnJkO8YGkVwo+IGPh96S
	 41M4msofL+Oi3vboG+92jJOya9Q5c2L1Y7eyGSdCjRKnD7UMDsvYMIvHKc2ZlJjIB7PLT
	 3q6tHyibIV5hk8tupJ/Je3k+GrrS/ZUiumn7Ug5lFIAT25Kq6kXEC0I4L52EJvOLKCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980693;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=m/XHSoz1deN/ONmn+rJC+0iAtRvNH3rJU7syscPU2ow=;
	b=w7sWe7Fq59DiqleqEFKXvIJEYF42veWiRK0WbQST00eFh8MnFJc0g0vBVyNzrkLJ5OLW
	 zfDi+PU7Jt+pthTCVUIuKvBkgyOvjsWe/WpgxtlALiMFNqE5net0s3AjKLVN2ZCV5GyuE
	 wFEwyvNhlDiGMPErfz232LRErkeC+Dv9Ug7njQkuy+pfKBeYz6I9FlpAHxNpUHXvWzcNi
	 hYfDMwEX4pk9K2BRyYKVE9dKNWhXvUKPs8q3P+VfTAMdU+Ko5q9n90dtKi7x6r9L7Og2i
	 aFrOxgDxegpN9wCsLCA3EgNo1ATAA8DZpvVIDF5dpaDv7M5yDXtLfVK/crD0tJKc6eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=elwkYRr0;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DE606A326;
	Fri,  6 Nov 2026 15:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D4DE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=elwkYRr0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m/XHSoz1deN/ONmn+rJC+0iAtRvNH3rJU7syscPU2ow=; b=elwkYRr0dqg+hDAASsQPtUIwGn
	K0oJEdbmDZYspUHyxDb2AkXDlVbNXc9F35rCmsoNBQkPr3f3zhxcp13P0Rm5EAkB+lXs8f6jSWZtG
	TnsAfnbI6v6gVz7/hQxvmXm60oOZoC5XFxmmwiYiiALZh0CgDvAeTuTNmEPCXX/+gzkP1NvQwDMND
	OQHrReVMGPaXJtzmUPncXiMdtUsJfMxpTd6MhFGmqJM7XDAiCeGCxlhlENF/kJmbNi4Re3cNxCQJv
	Y7Bw3r2IDnAFORObDNd0w+d9MAoht/D4Vf02jHxoIS2MtUfPUQOioHqXm2zBpzJPmvm4w++Vq+os6
	gbGnBUpw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xPMKM-009Od9-1i;
	Fri, 06 Nov 2026 15:58:06 +0000
Date: Fri, 6 Nov 2026 07:58:01 -0800
From: Breno Leitao <leitao@debian.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, acme@kernel.org
Cc: kuniyu@google.com, netdev@vger.kernel.org, llvm@lists.linux.dev, 
	ast@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org, kuba@kernel.org, 
	tj@kernel.org
Subject: Re: [BUG] bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with
 clang KCSAN
Message-ID: <au347UiVUe5oUuxM@gmail.com>
References: <au27Y9m78_3EH2v1@gmail.com>
 <a69dd097-7e71-41f0-9a6b-eda001773236@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69dd097-7e71-41f0-9a6b-eda001773236@linux.dev>
X-Debian-User: leitao

On Fri, Nov 06, 2026 at 09:16:24PM +0800, Jiayuan Chen wrote:
> Thanks for the report !
> 
> 
> On 11/6/26 7:38 PM, Breno Leitao wrote:
> > My arm64 KCSAN builds of linux-next fail since next-20261015, because
> > bpf_tcp_ops_set_rcvlowat() is missing from the vmlinux BTF:
> >
> >   WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
> >   WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
> >   Failed to generate BTF for vmlinux
> >   Try to disable CONFIG_DEBUG_INFO_BTF
> >   make[4]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
> 
> 
> 
> Has pahole fixed this issue?

I don't think so, see the line below:

> > This is clang 22.1.3 and pahole 1.31 (current pahole master behaves the
> > same),
