Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446849;
	b=ahfj6HDAwlq/AOkcGwtwezvGt2Yyc5yHCFDm7nhQ+ByX5USjQIkxfgSth8XYNsWwcfi2
	 p0g1kkQK8Nl57giiIrLT2C58YuOXNK5qKOlAtGKDJx0zw80YdQKV39F9ynbL8fHHe89a7
	 f7ySIblME2QwmqYFzQyQNmeVsM+0jMMaXRMFC47Lokd61gYl4yFr7N71qpXuKrpe3ZlLe
	 fWoVFz1h8FjETj5Avjjy2PBKNOUrpiHVO6ozXHsbt8+jYhMcXtMiiGszteAYe8USu9dJv
	 8me+01yrO5M1NG1Ujn7oU769UuVvpY8XwSQ1YtQvGAHR4Yfosfs5gJLFXks2PbNxw7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446849;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=REW/9j+OlAseSVUPZSaGZcgsaYuUzx8Jih/oiiyk91c=;
	b=caxF8sy51/nW52CjiXe7kh6PDLORowtwYhi+Rfi1jw+MoBl1wkRBB7emNT1jg71UxocD
	 E8G4p5p9ZCUgDT4aVeBPVkBxg1cDqmq8S/TVFjFhkXCUSKyT2cDpS/RqxjsBe7CYfFzBi
	 gdi+C1nMRkgiFQ5BQxj/hNHgpHRahlZMKPoNU1sN984+1QVkekE5TYzZlUVLi2QXPWA5o
	 KS3eQKu5blRXTCX+gtqrm8Ubm0PFZNDRozt4Zr4zK25GW0sSOu67/XkBK+uNcSF1gcVFa
	 Ot/ZLh5JI6J0IX9FMFF83V0GU+o7gMzgrAmMUnlHDWs9kUyaU8gMwEK+0+qOvLE+xeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=H7ONmosJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=izJT5KbY;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2E1606A319;
	Mon, 19 Oct 2026 21:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB2E1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=H7ONmosJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=izJT5KbY
Date: Mon, 19 Oct 2026 23:54:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792446846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REW/9j+OlAseSVUPZSaGZcgsaYuUzx8Jih/oiiyk91c=;
	b=H7ONmosJ6zh6o9SpTnoFSdKuZJWBx2Yxqc+G+jHtUPhx7c7ud9ydR+LVE3+lN0RMh8C4KS
	8G3nCCbis88zqCsmMSaVdNcHGhP7wLEwCFalK2lFBg1ZBu+HqXebx/QtKf3a3g+YLfc4Lh
	jV/cE6BoOXG4Zs8W/cV3V90pkjzr0oqjs2acZbgyqKr9Yz069Kg7dPlLvmJSy4csDxNyun
	uL1+4pZlCS6DGRgIgrEel5QLllBEvfuCQjsxDEcEeoIJ/0A8NKgtNHFW+KBt0Vrpnrkz/B
	9VY8PfjKWnH4lBmJvus7ioEmA7P2iPj9Nf/IAhhUDL0kxyz2WT29JUYWkryHxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792446846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REW/9j+OlAseSVUPZSaGZcgsaYuUzx8Jih/oiiyk91c=;
	b=izJT5KbYwxJdCKsI4l1Onn0ZAkS1NLhodI8dZ38boqdNTaLmtDi5UQr/YUzocMRSNfjxjt
	UeZZ20yI2vUpysCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
Message-ID: <20261019215405.OCzrrKYw@linutronix.de>
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
 <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
 <20261016220930.i32JEcqe@linutronix.de>
 <DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>

On 2026-10-19 09:04:38 [-0400], Daniel Zahka wrote:
> >> An RCU approach is used because ndo_get_stats64 is not called with the
> >> instance lock.
> >
> > Why do you have the two mpnic_base_stats and fold the stats into into
> > it? My guess would be that on stop the counters are reset and you want
> > to preserve the stats.
> >
> 
> Not sure I understand. I think you are asking about two things:
> 
> 1. Why have two mpnic_base_stats?
> 
> To avoid a separate heap allocation that can fail. Handling an
> allocation failure in the ndo_stop path when doing the aggregation into
> the base stats is tricky.

Right. But looking at hinic3_get_stats64() for instance (I just grabbed
a random one) it simply does query the stats for each queue, add up,
return. It probably does not drop the queues on down, just reallocates
them while changing the number of queues (and maybe MTU).

> 2. Why split stats into base stats and per queue stats, and why reset
> the per queue counts when the device transitions down?
> 
> This is the way the stats in netdev.yaml are exposed depending on the
> 'scope' request attribute. My reading of the relevant kernel docs is
> that the per queue counters are counting events for the current live
> queue, so it makes sense to reset them and fold those counts into the
> base stats when the interface is transitioned down.

Is there any other driver doing this?
There is ::get_sset_count() and so on for the per-queue stats.
If the interface goes down and frees all its queues, then the stats are
gone, true. But preserving them at the price of two (down+up) forced RCU
grace period, I don't know. It looks like a bit too much.

> >> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Sebastian
