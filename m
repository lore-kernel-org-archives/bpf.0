Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765725;
	b=ulcVpY75Ey/m+VKznzIuk5T+lNiXcFh4lVJ1TG8WJ8N3aDalbb61111pU9eO20BHsCVu
	 UNqIEV4nIDQ7PygG5YEJQ0cV4HktyVT0XN5z0P0qhv1QX4PVG6DVOpssRqg1wvppagZj8
	 lX3JILY0f18K8LIGS/Gve3r9siprvze7Nb0/sImHH6mast/BR/pLdvPpDCMcvIHz/ZRLb
	 vOQtTd1e0X/TreZ55WgxEi95h/seUKq+JGJ4/zJ11EzXgHnGR6qbZApqWkYarNmE59dtt
	 nRrR7X/SVaX+xW1sPUvJpHPig/9+m0QobF3C19Yh6tZzwGlqe5c0ANoqD4e8l/JvzQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=jJGFz/S2j3hPiSr3TOku2e+EdJAJmyIi18CZsDBrgDo=;
	b=XUm5XFwDkbhv0rWM+2+EdFvL/gjpCkMAFXN5CcDnKeghdX37XL6JUlKWcTS0cP0lScw/
	 RZ10G+/z24e5ClC0qL+gXo85z+R3tbZt3Y9NvOsRvVrhHvKeipNgL4jFNy4xBi9iYu3U8
	 oqfu1edxeFWGsgtSmwO8unb6HwsKpArmUQgZaODiqkyXWkNcr7mIALxGYkX/hnr9fwpNg
	 WpDJsIBRUta/kK7K5xMZF218ppv/biTDuGna2GyIEAG7ItyB4ec631Rp+xxM8dLSPv6Mr
	 q3IAbhlEsZNHpjKY0c4gexn+xcBy+gVmhDKHvMtxGwyiquwsLEhGMS5tvjgA++TNcCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cHNRkMeq;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C692606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 04:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C692606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cHNRkMeq
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so187789a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 20:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793765724; x=1794370524; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jJGFz/S2j3hPiSr3TOku2e+EdJAJmyIi18CZsDBrgDo=;
        b=cHNRkMeqkjC6Bok68Z0/IwC55+5GSYe3CkAqa7VSV2vSN8LXE68QvYwCn9wjWyDPoT
         U/Yp47rN0B9OC97hHlSNNtmni3AGOQG2ReyS0osoVfRIkIulDc94NNXQ9zpZ4Y/Cx+RT
         9frYO3ZYy33DEB8S00Q0xFR1V2KGFZ/iMkhCQQGvXDBxVfIssC8WuwGNKWf3XgUAxfEH
         Fsq0KK7VXyMdZsQ+KtjeOei6WHZz37/iviBnTpONA6Weaofh7thr17A1K3v2uJKqqo3B
         iqbDQFHyGXb2a4Y2DxK66Csj0Uzju1UwkzkpGXTCosIGg390Lxs9H6DDLYiYXpikNaEk
         hJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793765724; x=1794370524;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJGFz/S2j3hPiSr3TOku2e+EdJAJmyIi18CZsDBrgDo=;
        b=U1LKJ1SnRR3s92hk+C7VcubW+DwFb26zvGLdhqFxbMU/rHYj5BN2HGOI6BdtoVV/kH
         6fws66m+9+pMTt4u0uHrGPvPbMmav7IliQLj8WektPX2+3wuxiJsy0x5LzTJkhOhTIux
         QXnrHiPRZBVL2IhjtM06uqx7FOVhS1NblVaGfRJhmeHTg4EKb1Zw6Y46GzYRA/8H4DQH
         7r+W2B1ZhgK5iiRVSJVcwSvF2n2P6S2tmlps7BMmSut+pLyC3lCR5u8Mr6Qj53E/I0uU
         YnFAg5sZTKQ1qSWwfwfU4p23c9J/7XhMFOVcdsGu9osPPKQOeU4jD/vxgAjYxiZaST0b
         M89g==
X-Forwarded-Encrypted: i=1; AKwUvBys4CszAYhVBZYL9XjOtqnW+XvUbgNJXsPJ2W7fpU1asV+PqzbyxJn9s9obT7KRGuA0hL8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oUG8Ogf76QxEC+JLlzFNfPb6fBjweXyDDXesT4ao8f2zlGJAS
	/SXWaEOXzf3ADuChFH012wdIAzaMT0qORNxzsYp2kPA7G73kt1SkXcEP
X-Gm-Gg: AYBFou2phXeaB94bNw5OOC5q6H0rRG10NnJm4bSZoQ8II3KRzaq8kw6wP4dH4GS6NI/
	Os/LAF6lr7ciJF+hxYVLISo88OA5pPDckBmMBsV03+FLP6cAbb51jEzBMdKRSlRqG645OSBlqZs
	eiUyFDa/tn1AlsgyQ7ZOqyb7DLF9N1pIl/QSv+z9XvQo18qWf/EawTnqvHVu+frv6TZExw8ePtN
	kNohqbihRTY/IpDEAOUNsgFmBuGhr0fcgTIz6e8P38xG0vLhTXI0V5jDryE+5hSPyRB9llHkoaa
	oIescqlJALRi6Q5OBBAjD70Cx4sV2l2Q6ooz7PzR9tBparl/8bDbAvdkDTYx+pk3FM0/CB15sG5
	JR6UFxJ3xgo/m+BQkzja7x2AJGcMiDi89sUgB9kayfkgInU9KQplfNcOEmQwkdoptn6SZ2RfXrU
	Jic7Wbz4wQMnD5uvY6YWfUvW4EDouV1pBHUB1DZoLqCs40WfzYIbURXS6SdS3wWmrNqRWiyMgNo
	cbBdSpAG1YjH1dagM0jUBKgybKFTs0C0HdgWJ+ft3FkEg82y7oKVSTabYfsso0Qn/zC842+4MAH
	W7oxQ28ZBLqAvf3fc793Wj9iOrmj5+7BXnFYWsWnbHsfYbmpazbvQghOtbDvJYpNRfZCOsroQ46
	Qv3y614TNCO+Ho7pSDHugE+lINsg6LH3Yh20=
X-Received: by 2002:a17:90b:3194:b0:3ae:a4fe:7ad4 with SMTP id 98e67ed59e1d1-3aea4fe7dd4mr6853169a91.2.1793765724403;
        Tue, 03 Nov 2026 20:15:24 -0800 (PST)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09449bff2sm1810028a91.9.2026.11.03.20.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 20:15:24 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 04:15:23 +0000
Message-Id: <DMM4VPCRUGPX.2NW9IS2F4A3FX@gmail.com>
To: "zhangchujun" <zhangchujun@cmss.chinamobile.com>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>
Subject: Re: [PATCH] samples/bpf: hbm: check the return value of fopen()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261104035317.1133-1-zhangchujun@cmss.chinamobile.com>
References: <20261104035317.1133-1-zhangchujun@cmss.chinamobile.com>
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

On Tue, Nov 03, 2026 at 07:53 PM zhangchujun <zhangchujun@cmss.chinamobile.com> wrote:
> run_bpf_prog() passes the FILE pointer returned by fopen() directly
> to fscanf() without checking it for NULL.  When the file cannot be
> opened (e.g. the network interface is not named eth0), fscanf()
> dereferences NULL and the program crashes.

samples/bpf/ are dead.
'hbm -w' works with eth0 only. Usage() says so.
Without eth0 it fails with and without this patch.
I don't think we need this patch.

pw-bot: cr
