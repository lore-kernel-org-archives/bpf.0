Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC83BB9E1
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260020; cv=none; b=XAGCL99AFJKeJu/PIx2uN8VxVKVwCUl6N38xM0P1TMtXiExC4w3Tj9ji/qPfe2kuLntuLBM6c4181bjALhfYGZLj4yH7/Tu4PVFQbvtXGIhoM6QZwyxSjYONxOhWqFqI+RcqIEOZV8UeXPQM9GhE1udgHqHYIKXAMonPPgImuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260020; c=relaxed/simple;
	bh=uUj/7pfRqNTrc58rMcrNWZ1ddSBdy5zDMuW/FvBckfs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=rKjA1M2moNQAon8aYeDh+0k6TzeK5mo2flVOq4yGwV6g27YRdEl5hJfhMYNWhEV2+1CPy3JkJtL9L1PDRmWP8En3r1i5JYEkXKeQlUALweZKsUBeKIGA9/fIji4sKLvHQtApe3WWtlQIhRdT6YsEina7HIAQJmY1ludghlJ2G8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIolqGrs; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIolqGrs"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc433d52421so961792a12.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790260015; x=1790864815; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uUj/7pfRqNTrc58rMcrNWZ1ddSBdy5zDMuW/FvBckfs=;
        b=NIolqGrsxUle2ezYAMv9hMr6r1HrMFs7BaRBtC3ipYoY7HBgZ0dl5O3dyIuufCKcsc
         zDiAKTtnBYySb4q9KK2NaU+tKf+2aoTDaPDTxlUvefPLQtd6uElbnZUmXVdeFBUKbMhs
         +Nd449TBjWDf1/DGJnyiqSSKQ1Wxc4tfjvOLxFeY4F0e4fBP5Y2Z6IDmbGCqj1626eyF
         e7hzi6K2ygBncvU3KaZDfeOUxhpyNiDyOJRZo3/kpbL8OFquopqNJar6W4pTWc8ZM0cr
         svwj0gNkB7LKgPXMin00R/UekUFqEiX02pEoVAdZLD6h/Pby7sgcCoQq5na0KZDl6ots
         ktZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790260015; x=1790864815;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uUj/7pfRqNTrc58rMcrNWZ1ddSBdy5zDMuW/FvBckfs=;
        b=P1rskMh9FjJ8s437eXZQZuDrSEhuB1DqPdhwo34BJ0XVAj+uLy7HujPMxVYP0Ay4se
         dYohORP3yJBNBlu862NnhOXDTTIznvnQBkM9zGvE8ruxCgY6I+vJfOgSxfGa9rn30EvC
         15Z7Yu/UUEFx+1VRgRt/fUWymQKSDMi7EkhOHjd/8eVbnCPLdCm9QJSkHSulcjWm4MSt
         ct2YVEijyMFXmVT/wbsMFphJEJDvM/nM/iZ34NZidyy2pAOidDR2IOLibs+tNuPaANii
         dEh0vhQSPfYhxZBAYCOKL79Ao0HzLdFS4IOqs34aFZ0lfAAQXO+NUgzLVl59E9h8YeKV
         GU8g==
X-Forwarded-Encrypted: i=1; AKwUvBzPJ9+T31juOALhvhZZwDu/+UARcc2WU12adVsbUoDeV9a1bQPVshUWaedFw6RNH0zccBY=@vger.kernel.org
X-Gm-Message-State: AFuF++kFASzZlCwM/K+79rLP/dj2rOWKabrlqI8HCZUtR27oUMVC8iF+
	kpyk/tdkhvuYJrqGi6jVx3V9aYTwCNzUCpgZpPPsBf6rURa8M22nHDoT
X-Gm-Gg: AYBFou3T6FQdYVgMSywf1PILMJn70N73UOhmjRlNmypCsIdV6KYRJw5DB8JE7q+ZRgt
	TgYTkdvrFOJs/Rkb/TRfETUTD6sVd5V5989UQX8fHhnVnYqi8RxFvhnMLy2Ox2c61LGwKzFGtIR
	oLQjmBqZf1BSlxpu5/BSh3F54Tgtfr7wjmCpPOhDliQHKNNTATGF72RneDVC0HEzL8kqRR+ew/6
	UDlLlKvQa07AITb6m+5bn8+D7ej0ZhMaFRvjE0NsSALgsVDCMumiOL67QrCeK9r0k3TEO7TTwxb
	5sBB5rGRGlZwVC2654K1AZ2Cloc8aAhbrKx2d/FKvqFRTii/QvM8OlKlzqgs7wIJ0qpw+IaYIm6
	mROeHn0o6P+SL5qPZCv2UM3QaeawENrRdLZeKZV+aXkWEquvrAtEw679Z1JJKDUsTFiiXG40v/x
	m+uPxgrPA8MaZiqK2MJcC50wHYt47IRak8lv+JkB4UZvoCs338DtaqoRNRtmURj4Dvm9Gx6Giif
	B2UDxj8JppcZbmlbKLATcb4OEEP4ztHmUNR/SPX9Lj1lobhohlTdEFQRp3wXGGz+ahqTiuGaouN
	nG8=
X-Received: by 2002:a17:903:1447:b0:2dd:ad74:ac35 with SMTP id d9443c01a7336-2df7e11ca4emr22565155ad.30.1790260014607;
        Thu, 24 Sep 2026 07:26:54 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a517069sm28507785ad.3.2026.09.24.07.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 07:26:53 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 14:26:52 +0000
Message-Id: <DLNM7JR51QLJ.13Z4D921BZOJD@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf: cpumap: fix use-after-free of dev_rx on
 netdev unregister
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20260924081828.26575-1-jiayuan.chen@linux.dev>
References: <20260924081828.26575-1-jiayuan.chen@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 04:18 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> The notifier has to ask every entry, a cpumap entry is not tied to a
> netns and any device can feed it. So an unregister anywhere drains
> every ring in the system, once per device, with RTNL held. That is
> bounded: qsize is capped at 16384, each entry consumes at most one
> ring plus a GRO flush, and the kthreads do it in parallel. Those
> frames had to be consumed anyway. Nothing changes on the hot path,
> the kthread reads one field per batch.

The code is the same as in v2. Only the commit log changed.

The number of frames is bounded. The time is not.
wait_event() has no timeout and sleeps with rtnl held until
every cpumap kthread in the system gets cpu, including the ones
with an empty ring.
flush_all_backlogs() had the same problem. See
commit 2de79ee27fdb ("net: try to avoid unneeded backlog flush").
The bug needs a kthread that doesn't get cpu during unregister.
With this patch such kthread blocks unregister of every netdev
in every netns while rtnl is held.

pw-bot: cr
