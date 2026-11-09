Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236891;
	b=Qrmd1auYoGEpYCo73WmGEMA+snn7n00CcLNSfrxwyntA/bvVHXJ5n92hClilxoAt4FhJ
	 Q0VZWrFfwI7th1dTGLOIegQh5I7Jx60Q+1dIOjt+J0D3GawHmfj5P9LwMYBa0jLCnLmmD
	 amHlBxwTEluY0KNjeqfPeZv+4j+5ZT5PEI05OthIgGjkR1eGbXQ+Nr+7LBBXdXrsLXfzt
	 DikbGAsSZtGjtEWh0BzRZKx7OjFq4QoRN5NLlrxyXJW671goZFaQKmV7S+rqkFqpYNHsg
	 UkWjsY44le/f/+G1Vbr281bT1wZ7EzG+olbGOemMZhxXvJkoA0oHgbh9+R2SqMIxcMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236891;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=VApTwWJ3qmohUJ+gUV6MygaZwmFVLWa//DQWS1mUyZI=;
	b=AHdosWafV0ktYAwBSL123PgHQiJcvWHYZQLJSnTy146QHMGGXjlKRzN/evBXDltphtCW
	 sRCsPwiXb5aMFjStOT2+lsGN+aY9d/hnL5GC5Da4J8ogNjicqdZAMH4l60jN0HErJA8uf
	 swlxYjtOfs+Rfx8V7973QYOfZMpjs3grvVqrhZyTwJRbb1EXv5vjMNeEJ55uknAEyGBov
	 /RZhKzkjj4c47aewtYymiIne0bPZRFyKAsMxBIlyZ/P2v3kyef4MsI5wcRY1GiSyIyeM7
	 5ABMwYLhOTQjlB7FyNQe7Ap2/Es1ejVk7Myo8LIEq6xqTYgzyNdoMIDsxVZalbimTbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=roblab.la;
	spf=pass smtp.mailfrom=roblab.la;
	dkim=pass header.d=roblab.la header.i=@roblab.la header.a=rsa-sha256 header.s=fm2 header.b=w5qs0gob;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AmBY2ipQ;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C1606A33D
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 15:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 007C1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roblab.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roblab.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roblab.la header.i=@roblab.la header.a=rsa-sha256 header.s=fm2 header.b=w5qs0gob;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AmBY2ipQ
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id C34A01D00177
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 10:08:09 -0500 (EST)
Received: from ams-imap-01 ([10.64.2.21])
  by ams-compute-02.internal (MEProxy); Mon, 09 Nov 2026 10:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roblab.la; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794236886;
	 x=1794323286; bh=VApTwWJ3qmohUJ+gUV6MygaZwmFVLWa//DQWS1mUyZI=; b=
	w5qs0gobz7jEhvbu42EoNe0kdY1t6ZxaOYdWduC3+oH27epLriRSwWilYlhmId25
	KnHFHd+rHat28gkgW6JHqtY/E5Y4JaAmwR1+zENdO6fgLeHKfv2rBKK5w+0m21rn
	jWQvSg32Tw1jYkvuPqw7P3wl+duMZcnPSfYDwteCQlnHAMDhFXEeL+wtg6xYppz/
	eagRLTdeE6BuQGyZfeNsIyiL01t6Fn+Op2BfSOMzopv4IJ6xhunOA4XUAXXGP5vs
	gHIrrIHBReqXQxd+45Dbmjfsu2M4pKj5UB7TLf/BlNOgXoCby4rbwJuwAcrFhKCa
	lfkY0RfO/HjcLgQLyyJ1jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794236886; x=
	1794323286; bh=VApTwWJ3qmohUJ+gUV6MygaZwmFVLWa//DQWS1mUyZI=; b=A
	mBY2ipQrm+6pDwTlkvMWIR3iwNKrvdC6t2q/OLyHd/ynclOGmYNSQpFSr1NNXZLL
	up5j9F6USIH39S+tB6EAsmDVpcvgjHgN2yeeQdUAzwzDiC5wc9K5rehDHUJafwwD
	JBgBYRNNwoYCFOD0fefwVslUR4eO4ehMmFiKKde5SpstHV02wddQfp6HSv1kscx6
	MMU/tRr/3FghVClAtboTg62D83nN2g/DHX/10aqHA0QfvTE/9exXWJEdUpx1Z0/G
	d0peQLwPuEzFrA1bowVTtYJd496fPx4RQXvjGMahnFaCAx6l1eT4YgDIAPJNqOuL
	6VXMUguYvMd9hwnPp9AxA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=roblab.la a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794236886; d=roblab.la;
	mf=PGxpbnV4QHJvYmxhYi5sYT4=; rt=PGJwZkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:M1KNewT9dgyghyh5Jx5X2Zvf4UqcigxcrdLHS38BK1c110g
	zj8RpA7fWKAu/XfL4Q/SudyjC3mJWnxNAKIjaC5BNuVBrVNWlNnof3moUf43c/Nf
	ORlvFZLEU+GfNJRrcVSNaN8uMo4HlwzYRfXY6sdgViSlc7KM9KbRWMP2FiWqbFRE
	z8rbZ7XUnxMgif4CdO9KS8lR3p+WILlI/pDGzltcjJQR2RZm2I5J4Jqq0HRzPDH8
	JFK5SQPspFOc2Ng/7rqRq6wgdH+r27EQo0MnrP1gESAsjL9TELiyUwzLtDh34egm
	kwWXQUHd7WrknIdj8zmuXCJeJVR5DLr2Ocz1JPg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ddwfNLPp0IsKXzeqZm/tuCizgfx94OIjmVEDFx1AhQ0=:K3DqAWrmELiptr52b2dyq/LsiQ1CiyUr9uR6+OXPP3s=;
X-ME-Sender: <xms:0uHxanJY2BUty-rF6d7WbZiiY4kog_zqhazhZRwbHyKNGjQIpsjnvw>
    <xme:0uHxal_oOu3nYRuz-mbK42dEid5ndgcLZgH8aFdX0Qx_P9JdwYRyw8kyjZTj3TS1R
    dN5Q-5WFfezeCa23LGb40rHdibjzq3nL4XTouu0jwUmiRfolshCgwxW>
X-ME-Proxy-Cause: dmFkZTFwNPAAGVjalJ2RlYQLODA8FyDd+IjZJLDJzZnhOTGrb2yAfnzg9QaRSawQl7DVJr
    IUJc+bPV7ePb0ZpfHMD144cd1AuB8CuZFQ/ONKYEnweJg7/jPt/alh0tLlrmMU9EEeG9lN
    WzUKFZdZgcuq3NpsQZDyrqLZURx7ZFWaihgPcjyJafMMEy/fnTt2lmoXpm5vQ2FoGRfmLd
    i9gUFKBZTRYXO85hS7iMD+Q9e6wjhmQVMfxa9EgBldypk/ZGIJh05M2hqOxPCCILUQh8Ml
    FC2WdzTXcZ5idgTnN6/yKzVJtwjcMTry8kLLPyY9ZmtBVARQPT0WyQrSRRLz3B0UPVgEOZ
    ef3m2z18ItEFcMl7cL+2xvxu3lXQI7qFiL/1G06abo8phPKGCID4ijnrBoMA7a9fuPZKKS
    AXg2NlmJRIIIzRARp+e5PHNojY1K0IUgWwO1pXsdPwXH6kvxT5/qizddITjHmKS9SxjXgy
    ujB4DQ7ZmJjk6vLPCtMu+RcngFkY+i9s1RDkPSpHRRLSh27Sez50HZAf7WXWXLAVBtciQr
    OfYpd8MQZaH9fNF59yuoKrGWJT7Wy7VzdxJcxZh3GXayFbWvgzLAerXiC+g5317bYhl8vi
    Kjg5ZUZhUqQGsZk8iEnV4MPIUOezi6csRgz4iFkSOXhEfAu1rJo6sqi2W/1w
X-ME-Proxy: <xmx:1OHxat5e2-nxVUpQBEN-txPwu4yv0ViWlmn1zgd_Abp8DHRyWLJWug>
    <xmx:1OHxate4_tQruJWIjUrT6wpPWPfeeB-mqstgG5TH2HxmmZ1a_YdhJw>
    <xmx:1OHxaoGy1-lldS9ItGS10Nj4zgIs3jkU5M5zFFqQMdR_JZxi_3SZjQ>
    <xmx:1OHxamScr9WHq7-cfTn-A9BfBWYxVT8iao8fAphsyRmSOuNzGWWtDQ>
    <xmx:1uHxarTgFlNq_bsRwIb1Kbnjs4f2Vd2DEX1MvAYM-GZoWBCYymyWpMRu>
Feedback-ID: iddd147b3:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3584EFA0090; Mon,  9 Nov 2026 10:08:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AgAAt5wBJ-mw
Date: Mon, 09 Nov 2026 16:07:34 +0100
From: roblabla <linux@roblab.la>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 "Paul Moore" <paul@paul-moore.com>, "Daan De Meyer" <daan@amutable.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 paul.mabileau@harfanglab.fr, linux-kernel@vger.kernel.org,
 "Andrii Nakryiko" <andrii@kernel.org>
Message-Id: <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com>
In-Reply-To: 
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com>
 <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently breaks BPF
 LSMs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Thanks for the replies!

> LSMs that need to provide a stable API must provide an abstraction
> layer between the LSM hook callbacks and their stable API.  The LSM
> framework is not responsible for the stability of individual LSM APIs.

Understood, that lines up with my expectations. I think the biggest
thing here would not necessarily be stability guarantees, but rather to
make sure that the eBPFs fail to load when the compatibility is broken.
But that's probably a problem for the eBPF side, and not LSM, I assume.

> So, in short, would it be possible to send a follow up to Daan's
> commit and move `struct mnt_idmap *idmap` to the end of LSM argument
> list?

If this is possible, that'd be nice so that we avoid this breakage in
the short term, since the change isn't in a released kernel yet.

> Having said that, there is a way to handle this, although ugly and
> *everyone* using specific LSMs would need to do this on their own.
> Instead of using convenience BPF_PROG() macro to define BPF program,
> you just use raw `u64 ctx[]` access, and then cast ctx[0] to either
> `struct mnt_idmap *` on new kernel, or `struct dentry *` on old
> kernel.

So, we already do similar tricks in the software we ship (which uses
various eBPF program types, not just LSM) to cover kernels 4.11 to 7.3,
using a mixture of CO-RE tricks similar to what you describe and
per-kernel builds selected at runtime.

Here's the problem though: We ship to customers, and we don't control
when they upgrade their kernel relative to our agent. When the kernel
changes a hook signature, a program built before we could handle that
new version still loads fine and just reads the wrong arguments, which
causes some really gnarly bugs that can cause really bad breakage (such
as accidentally denying events that should have been allowed, often
resulting in machines left broken).

So what would be really nice is a way to make eBPF code robust against
kernel changes such that it either works, or fails to load, but doesn't
do the halfway "loads but silently misbehaves". Here are two ideas that
have been in the back of my mind that could help solve this issue (though
I understand that they may be rather large changes, I'm putting them out
there mostly as a conversation starter):

1. Could libbpf/the kernel have a mismatch check on hook arguments? I
   understand that libbpf and the verifier don't know the types a
   program expects, since BPF_PROG() only casts u64s. But the macro
   does know the types at compile time. Could it (or an opt-in variant)
   record the expected prototype in the program's BTF, so that libbpf
   can compare it against the LSM hook's prototype in vmlinux BTF and
   refuse to load on a mismatch?

2. Since kernel BTF has parameter names for the bpf_lsm_* functions,
   could we maybe have CO-RE-style relocation to resolve "the argument
   named dentry" to the argument index at load time? This way, adding a
   new argument could happen anywhere in the argument list without
   breaking eBPFs, and removing an argument will (correctly) cause our
   eBPF to stop loading. It does mean the eBPF programs must provide the
   same argument names, but maybe that's an acceptable tradeoff?

Thanks,
roblabla
