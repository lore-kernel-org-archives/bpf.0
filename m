Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636468;
	b=qEafUjKtP4ewWeHNFWoAawENMEnlW98lXRst7CnOFyWRXV4Q2i/Ux+S+Q9cirl4zV5ig
	 +QJQZqFDkCv7UPw/lf2BaMGX1eAuQtJPbLhA2m9OfyGnHVAoqS1RRDksbQsAPueXxd0sD
	 vLnQ3xMldY+24xt4Tm8GmspM3Jz3FzSZu8E1CnEwXbsgF7XZKP1mk2KwpE/3gU1JHGzak
	 5o90P5rEFz3UDKOhWU7T31UH4NhGLPuDJlFsg9bXKwT8mcdqwaFmPKSsLSuB+FYaV7yqj
	 PpzEDJbfrO6O4zXKtwTf0+flJ8c7GOgKUY3NtOWbOKeufQsXoMKbOWbAzsrxlUMjA9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=5mo//5iszunT69Ntkv8F5KhrsTxnizkW5ppwaMrOTwU=;
	b=V0RUNVlYYMKJMzVwdsPW35+OezDYnKOEpc+FL7t2sIwHBsPsLPFvqd+1vpwdCgSYVvTw
	 bOYiHJrCKQ4z/rDnz3GUtjJEeBEB6tVr4OgcBDvMN1hCjCWE4K4iDbsDKrwRHwBc+8aum
	 ggMu/FLUROBP7VOldKwV2nCYNVoJamGmfM2dYjQp3eSKKKJjXSBZSSqyn3LwRnx4vb/lj
	 D43R/i2qA0NUljXEIB1XBDffJ6oIkFxXD6Az19D64DXRj/eH6B10PCaN03v29aotHjzJG
	 fZyGRU8upkz/jeNlr+HhmW5Ge5HbZWq0tjj03uyzdbyBDocn/Ij9/0+w+/60h7+J4kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlWMI7ef;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427E60703BC
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 16:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9427E60703BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlWMI7ef
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso1900191a91.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 08:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636468; x=1794241268; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5mo//5iszunT69Ntkv8F5KhrsTxnizkW5ppwaMrOTwU=;
        b=hlWMI7eftQ8W/OE8uU3ILgMYzQHry+3zhXjvPuTaEaRJcpSsrbQHF4OF/9RCyzKcre
         QbfN+fMOFcIfH1vIe2QYShyHlsMrQiqkP/r1JJMP9WnuYgzGkX7uhuqNqgaEA3lVj5Q3
         1lgjCB2OOCjtZ4r99ogWkCgzewD6Tc20aV/ryg2L8mGEHZHgI14mfOJulrzLihKlJNP7
         y0+CN5VBHjwRNaCRq/KSaBZnxNv8EDfuXZWlhKgguoaWKaLwXH/uYDZbG+J6SoXlWDdD
         VdncapUpaMiXFOBDItiBK9S+SvjdzRrkYUSWMNSo0DYaTzKOHPuxb1nzrf2Jw60WPQy1
         oRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636468; x=1794241268;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5mo//5iszunT69Ntkv8F5KhrsTxnizkW5ppwaMrOTwU=;
        b=n0Hq+wTfuNLWXFLVEk/YrHU6+EwNyf82+czMnr7oOCD75HJS6TDUyoxtWcXOoyTtv0
         lihT9XiDbPfXi/UeQe7Yff4yvEmWpLWBbcTdiT/uLSe8+d/FX7DipMutnHnXEcaVmAYd
         t0tqcVlYrxFduQmM4S3bpslW5HdzkvSRery+tzEOFSo5gliknM4iCCemjcclRjzmh/6i
         thu0HhpRnYxTpNhv0l0cRrX8T9SciJbvLiuVumYMwrJ5GVs1lAx7x2Eo9Fs8yrk97+iT
         nWycscEssvk5uExtAK4zcXHzEeA6CVk7sbO7G2+FlclJvaGT4K2H1X+lxM4MwnK7pVam
         MfHA==
X-Forwarded-Encrypted: i=1; AKwUvByWGvHVrLfAKZXTd5eCvaLpCA6xV68Ri8PVXPsd++p9xYBCstQM8shwRcC4IVeOrL56Y2Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5Qz2uzF9ySV58alsu2WX4bpuZMCmAPQnBv8qlW9mdU1OU2C1F
	zSKEYC1L6uKYiq1jPLmjsEhlWcSBc02DGa0+IxDcHPUV3GGqgAePSmqB9/X+pA==
X-Gm-Gg: AYBFou1JT0OpRLKbuNXczGkAuLH57y1IK1hD1JTFdKii+3vzEPS2uvSWUJXHr5svPsa
	13XQEuuGjurPKt5Ospq883EtlqMWLS1SsMCk1uR6w+IGgGh8wmlHwq1/m2KwRKp13wcS5Hek5eJ
	a4HcB2jAfJvNupC3yDrDz1Y5LE+lnDbnlbv8p3uVgxAqL0XveeC85wujSlPurwQrvd+zEghvbvM
	y7vr4kaebTPsdPcCf2Z+rL+9C5A++TVR9H/sPOtXkTiZ2/DV6FxDkiPRa5C/9UC5vvG80aHhMUj
	24AYxliFCF4+HErPplCqJYZmf6KGsgli3C4FmoAw4zjiw0ihdWzcvShe28MgX4RJ2mGQmJIwor7
	U8zNAOHDOvbzIwnwq9tXClweUf8kLbwPUpukVl9iWClB6Fi+Z0Jpn34cT2CL0KyhhjWWj0KAusR
	tTynrRbGeWtDcEq0IO4e1zLcg7l1eH8S1lBVX8WUdB7iLtQ04FxtguvieOoCO8hS9LPuBrjeaKi
	tNR3Ogmvw2ed1OTLGLtOBGhShXIgA/7z0G/mTwat/+Tu7W8U6glNnLXyL+SeP4e5Gt4m6VE4f5G
	/N54dfuWlEk15GKosUfon0Yk5rzeb5EG6/EivmmgCU0gg2iN7CR78p3NbNKv1jYLf/vZc4gF4u3
	pVJJ/kwNOE2+sjIpouSt2Fw/cpmFTU5arOg==
X-Received: by 2002:a17:90b:4b8a:b0:3ac:9259:122c with SMTP id 98e67ed59e1d1-3ae8977737emr7944503a91.40.1793636467693;
        Mon, 02 Nov 2026 08:21:07 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d5b8csm19939285a91.1.2026.11.02.08.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:21:06 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 16:21:06 +0000
Message-Id: <DMKV29CMKFZB.11MEZ8S0HXFE4@gmail.com>
Subject: Re: [PATCH 1/2] HID: bpf: serialize hardware operations with device
 destruction
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yifan Zhang" <yfzhang23@stu.pku.edu.cn>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>,
 <linux-input@vger.kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <179362071770.29269.481376767482231629@stu.pku.edu.cn>
References: <179362071770.29269.16022650793604369465@stu.pku.edu.cn> <179362071770.29269.481376767482231629@stu.pku.edu.cn>
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

On Mon, Nov 02, 2026 at 03:58 AM Yifan Zhang <yfzhang23@stu.pku.edu.cn> wrote:
> Hold prog_list_lock across HID-BPF hardware operations.  Device destruction
> sets destroyed while holding the same lock, so it waits for an operation
> that has already started.  Later operations return -ENODEV before reaching
> the low-level driver.  Apply the same lifetime rule to output reports.

sashiko is right. This will deadlock.

pw-bot: cr
