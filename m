Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693009;
	b=jRcCw/8cjX/NBV6vVUo+f1J5taCQaD2jB/mYVRu7WKGuT6mgn/JlduOkGaifSk6465aZ
	 5LECTznxxh48DvzeCx5TCWCJrgWkfQA0ACcMj2XaERoDdYb1UUnjTPTG6S/ALXLZ9HXn0
	 emrk0Oa4N7CJYtL3cLPIE/2XV/G+Bqg4Ly4V5ilmKeCcCBSW4yG8EUXkBxdXDb1ktTcOD
	 62FUaA7hLfT1WnfOTp6hCZjjUGrBuLQlyHJZGHZpqsj1K7+E+Mt296p6/lg4NY0WCSnYT
	 dIvuxU/JZAjwg1+k3eEPtXxT3ECVZkItzSCTcwkW4wJBSYeM8wRajxuP3vL5XOQFGRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693009;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=enhxf3grehHMDIgvB+Z10c3xYp3FBwv9aKRumc3Y59Y=;
	b=3EEGYInMu2v9X9CC+TzuzsMil7YijnY+fDETBm3pO1y8wPQ3H1h/2PXtlvYmTT0rckXj
	 GHpOC/aDFQu1ZMFu9T2FIi4jTjx2cvwuw9BRnyYH5cQAeXY/dl65tPpjzz4NZyGXWDh0V
	 PO0MiCGK330xSMXe0RvTCxweUBKF6O6t0bcLBrXUdum/FO+uanQo++kFk8P4XjzZEWt55
	 6jsvzoF4rpja9E2QnwvBpZ0cGUWl+OsKI57YEvJrCjQagXSsIchOKB6yLdSiVAX6wEAoG
	 XWTk1I+45AjOP5mcjRJnxzR399owERVzi4zn+ZhjnpR0odWx+BHIbBN8X8SCxvaKgaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=e1Y7go5R;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64836606A324;
	Tue,  3 Nov 2026 08:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64836606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=e1Y7go5R
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F51FA1648;
	Tue, 03 Nov 2026 09:03:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793693003; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=enhxf3grehHMDIgvB+Z10c3xYp3FBwv9aKRumc3Y59Y=;
	b=e1Y7go5R9tw/Hv+CwAxGtAPMkX1GSK0Ef79e3aXnasSML74WNdFcCeVL963SnCv3zs5AeZ
	ePnTYEpDOQWdhmfd5tkGjOALd+B8nniKV+NwIz0ig9g27ycC/IhB3jE4AZ8asOv8BVkpEq
	Thu6rnRMxb+szt4AKGKFSQvVqMXpTVllGFRIRhUd36nJYmvxucl5Q8ouZ0L3+7P+WPWpkJ
	rJ1cWg+BeUyHT6H17+GIL4Lh2lqH6hVGIJuGI1YolgE0SUltGdczyr+2+BhKdoBajmkqTi
	T0zfhxMVhhKOAonZIHzPgqx6vKEEefXLntGwQgNw1Id6vrvuU6hQuGX66cHiDw==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 09:03:20 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, sumang@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-pf: fix XDP frames freed as skbs on
 interface down
In-Reply-To: <179365033465.3131.17188664588787330051@kernel.org>
References: <20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de>
 <179365033465.3131.17188664588787330051@kernel.org>
Message-ID: <61f8b7a5d2b72f05c1b59d46f375eb7c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 2.11.2026 21:12, netdev-bot+sashiko@kernel.org wrote:

> [...]

> [Severity: Medium]
> The new CQ_XDP branch fills in xsk_frames, but is it ever used after
> the loop?

Daniel already pointed this out. Will fix this in v2.

> [...]

> [Severity: Medium]
> Should xsk_frames be reported back to the XSK pool after this loop?

Same. Will fix this in v2.

> [...]

> [Severity: Medium]
> This is a pre-existing issue, but it is on the same XDP teardown path.
> otx2_free_pending_sqe() only walks the regular TX SQs:
> [...]
> [Severity: High]
> This isn't a bug introduced by this patch. The commit message mentions
> "when the XDP program is replaced". On that path, is ndo_xdp_xmit kept
> away from the XDP SQ teardown?
> [...]
> [Severity: High]
> This is a pre-existing issue, but can NAPI run at the same time as this
> cleanup loop? otx2_stop() does:

All three pre-existing issues will probably need to change the teardown 
ordering.
As I don't have any hardware to test, this is probably better done by 
the maintainers.

> [...]

> [Severity: High]
> This isn't a bug introduced by this patch. However, the new branch adds
> another consumer of sg->skb values that may be bogus in AF_XDP 
> zero-copy
> mode.

Also pre-existing and this seems worth fixing in another patch. AFAIU 
the zero
copy branch can jump past the buffer init, so XDP_TX and _PASS would 
work with
an uninitialized xdp_buff. The fix is probably to switch to
xdp_convert_buff_to_frame(xsk_buff) for TX and xdp_build_skb_from_zc for 
PASS.

Ideally someone with hardware would fix this ... Marvell?

> [...]

--
pw-bot: cr

