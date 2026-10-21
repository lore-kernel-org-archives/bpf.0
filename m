Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551920;
	b=rsbBYdeqjD28dsIbCXDKMusBO31W/kbyXN8HnAZeSWQXioaz7utKmyAWckm2yIYEae+y
	 HHT3bkGhfDLuXFx+AG9CZE7JDFrCc2bHa4fNbNt6RMEaxjyiRNO9StVcYuE3PPUfR/Y/9
	 5xDBcPTaT81fyxvd2Hgr1U1apdqTHvz3ddjQ3N8P2LjPzH3vkS5NAZ1Lwxfr7ksvlAfj3
	 4Jd70XQtiDvNwO0aT3bZ29yu0TUMXYljxu2pTRFblieomqHShF/NkBWebDy+HpSpOwazC
	 p9JxvCIzwbr2qGHk6mHXC9NBgV8wmyo/FOavS/nDVdU6h/V2QDCyYkKj2xQzMtGl4dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=aSbx+2JIYEzrqnyu5Jxh+14HH5G/iqzw/BzmiivGbiQ=;
	b=zoVV/1owUBM6jMBH1MjkHG0BROH6e0NWBOWvGhbEoGrrrwqVAFPUt0yjTlNWBrz6f91a
	 CGswzhpic1TMFcXWjLb+X2YovAkN9KNmnNpT/7u0EIf5u3MNqmD/1QZsPfu1z/qFEpPPf
	 X7M8+ILAw/GYDvDb+iO+WqN/3r2hRu3bkejXmeHJP/dZsV2l0yGiMRwmpgBqQfrZCcMVw
	 yG3je58fCpDYbjxcDyswPXDsB6o/pMLpmozMP6DBXHXoUiD0BPpfIIqRDVbPcfqrF2Dpn
	 J9OF/B/V5i2s1vvU6oduWNaC1d3iKk+G6/2vioCqCBMc696mALWKLq3Kr5L806INbaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTUhIXqc;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F7606A31D
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 03:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A12F7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTUhIXqc
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so270236a91.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 20:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792551919; x=1793156719; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSbx+2JIYEzrqnyu5Jxh+14HH5G/iqzw/BzmiivGbiQ=;
        b=jTUhIXqcHD5paioHMBgpX/nNDFeI6GefwrBU5JCZ9L6hQkgDCCR5V9qDyK90TWxB63
         BUeHPqsNqUAWjxsKRzhiYWN4gg/2tWiSqAFA02QpOTMVZ8HDrd/73VlSzZ/z6Q6Zcjmb
         y/SpBz7FnPTQZRm1MiEuoSZnfDeQH8kZYfIu4tSt+PzCSc9QM3JzSGKAPbcRqH35wiGt
         iIVaNSX1r/6k7vkTPWGRrKb3k7KNyal3wwC2/NRW0KdNFdIthL0IVESKxGtAtYSu8Cn8
         cBxQ9fMunJcJn3KmG5zDQHXwvhba1VSFsi76J/0MovajXPhER5CLkwBZRb//TPZDUhXi
         dl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792551919; x=1793156719;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSbx+2JIYEzrqnyu5Jxh+14HH5G/iqzw/BzmiivGbiQ=;
        b=eRESALBgxgvSuoQ942Xb1gT+wTf5oCxnZCdw5kiQs2HY2ehSpKoUAlgwjKZu35I53G
         vHXS7wmxhjH1UcTCyDHAKPmCE3Eo9TOa7wVs9RJm0rvwcG44fcuOHHi/NN7W3urKyjJF
         9aQ1/3+7pE7MZ5CJVKE+R23t7veBJIj/n/xrZ0m4YtSKLpMF4do+ehBh4+mprygKjVou
         gMR9BU3DnBs0yzOeaWvUfyd/xPHWQXygjZlnhwzZsIUpMyVCioVb9GjW2tMgGx3msmLf
         TGMTVQKoqTz5+K7jEF+W3xs11DIltR476bvPuabpgelzWQ+BMwMOCtr1vzXmtOulY5HH
         nBVA==
X-Forwarded-Encrypted: i=1; AKwUvBz8rTxdml083ObSgFhtkiNWXw1ZKdx11tjFMp2sciqhj1z6Tu+dK7GjN3WZhdWmEHuN1sQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZaJbN+YoQAvC19wl/IAOQqFKNVJEB8cyDUb0MFk2U54a9ZwXd
	faQhXZBB9G97n5p8WMoVkYkDPvjREOZgRhBzMXQw1B7/XL3s+X4HW3p6
X-Gm-Gg: AYBFou28dermu5HnNZtgmu26ILqCFTiqQiK0ehijD8bmG/GD/q4kE32ADp382hLfJ28
	+FEvaT7jgSYyx16auAJHQXJmFCFihdIVLfbRIvVXGpRDwGa48vGJOL4VnXBbDyJ5ml6cLfBTQoG
	lVKtsZ+ZWvpbyGlfnfxBH7p2ozlgLxNWe8jClJiC/TdHNoQ/gPAh7T48wTq0ugv5ajOd6OSo+7U
	bI4U5nOzXTSa5jtse5CH3KbpX3KKbrN//1aG0w7jZxj0o/4Niiqxb9a26DeBCZB/m+FaWWypXq8
	Qa8I875CvRuqs8Rc8BJ/vGcMITgiB5BexHy8Xs+OFU5CQIce+3A7kboeNCGjyBp5pPa91FMZVLs
	jkZDE7AoB98MIKOFgwu4r6WqdldUXnPTObxC+dpV54GtIfbIKEaSZUh686gpu6bOj2pd2V7Vyrb
	KxB6U6dhBNiDNjNxbXjx6JqAwPU0ZWwNu3y45pH52PZl4bR0T+OTCcToWgBLn7Y/l3V+288I4FQ
	ymkDtl7jAQ90R+VJmPpPQrqtbIwd0T+1WEiwjw2kGNIbu6dP0HJf2hYSJj7OoLFAVRQdeACrd5j
	0uHCOLgvz/3wJVgPWTMI/sctVm/rjv8lZdX9jIi+ytbIBmVLhtH2jdQHJfmK
X-Received: by 2002:a17:90b:2710:b0:3ac:7556:8ed9 with SMTP id 98e67ed59e1d1-3ad86c79924mr698658a91.10.1792551918978;
        Tue, 20 Oct 2026 20:05:18 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad812c565esm1924550a91.10.2026.10.20.20.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:05:17 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 03:05:16 +0000
Message-Id: <DMA6ME9P5EQG.3EI83DBIFMBDE@gmail.com>
Cc: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <shuah@kernel.org>, <kuniyu@google.com>,
 <liuhangbin@gmail.com>, <mkarsten@uwaterloo.ca>, <masashi.honma@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/6] bpf: Add syscall common attrs support
 for xdp link_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
In-Reply-To: <20261020182700.655edf14@kernel.org>
References: <20261020152804.39863-1-leon.hwang@linux.dev> <179253001886.208021.6536312952037292688.git-patchwork-notify@kernel.org> <20261020182700.655edf14@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 06:27 PM Jakub Kicinski <kuba@kernel.org> wrote:
> Please don't merge changes touching core networking without an ack from
> networking maintainers. I haven't even finished mopping up all the ways
> the XDP link bypasses normal XDP safety checks :/

Fair point. Will wait for an ack next time.

Leon,
pls send a follow up asap.

