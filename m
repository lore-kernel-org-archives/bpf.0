Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694151;
	b=mBIz2TJxsvBBSOWsM4NnHqD6BVNIyqi+T4edY818e02nv20fcXkrm22zpz93JJAfQPUS
	 8hdO3xtxVzjox5IGaY3qbnlA3JopRA+9sA2kBkS5emtE4Bd37BArY9owZw5uQoiDvKcIL
	 z9IcVrv4wK+gkNGaG9WuS53//IBtEJP85B72ep9Jhd1m6owfi0fyB6gp5SNuGODIYzKv3
	 Ldyod94FCx0S9OrIDL6xsDaLNHRABSN0tqM5m+T2ZQKvTPoFLEIcKHTUZcDnylKgLYk28
	 tfsGRM4XFoWhPWU7JZfq6V7SAaqS1e1EcgsT1Z05mVr+unSk+bCpX/mlscJujMc/0Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ywEpiDPK4X4lwtwqfGUxqJF97k3enH7AorttNznK9fM=;
	b=CcDZCcxcSQze2sLr/BnGbMmsVKDgvl6dYxcKT1CmV+2elLQDv7Oz1oj82FI895HJ1NhN
	 DVGlUVCko4vtpo5v/8b6zdJMn/1BVY+hdEi07avfPQlEbFj0JWcSbeB+4rg3gn2kebpjG
	 0p3wvns4SVRrc5tLFqJKCfj1WJGupGAryDWMGqXRIevBPnhHAfqBH1TTpqG20pLJ1hNwB
	 l5QCzrmrfsHdytfdXhNSbtt7h0Cizch3Nwheqz3ALtfHbAY/OauN4vOjtDbDORoi7/BOX
	 SbnAmmmILzFoeOY1y/iCj06YiXwDLOtzkFs6ppwWAaCbL4m5MvYrwvNmZgmSE7AztmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Vb+RDi0Z;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41956606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41956606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Vb+RDi0Z
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b060ec084so2259984f8f.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 00:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793694149; x=1794298949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ywEpiDPK4X4lwtwqfGUxqJF97k3enH7AorttNznK9fM=;
        b=Vb+RDi0ZvJcLQv+YaQuOnDH/hs+afajV0HP9eGbv8wEvjgVDVTEv3v2q6L9+2fjW5i
         temELTC+iAKXODYvGzIstOgV5u+HWtOy423elq1hrjb5JF5lkma4HToNgh9q5cBHe+Xl
         CK/3u0l4cl5m9m+d970COeXBSq5CRBcFxhKwSr0JWwZh2VH1sf1UysBi5ReGYIEA7qDA
         lCcQXbHaSPlQd9Ni3Ch/Q7isklgnAWb9atdpyMWXk1UjCdqB+jwH3sQOJpt2FIE5tffP
         t2JEHtfuRee6qbIcPeWidsLgHDhn8ZmRruheumVreNsdwBoQwIc1rrY+PWfXzGhbCy75
         WG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694149; x=1794298949;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywEpiDPK4X4lwtwqfGUxqJF97k3enH7AorttNznK9fM=;
        b=fWSKljvEfVLNRUvk6zE702XjMKT48mYSd22oOBjIF6IdgpuUJiKV220UAtxBq3COMD
         Ra8nKwQh6FjR5FSd+Qv2R3KOo5vqbzAuanYukco5VBxynuwkZ58gsYymR3RewaYNn696
         8JTsKcnahtcDVCsmXkwitgx5G8wBP1smju4bdSpLDAZQ2UVTRn5OVjwboSdqwBhAkLli
         kWfu8MHBUB8qFSpCKeiJSlbPUSzjynB5Oa/Zr2wevmbMw6uSA2niZr4MBK6HI69qH1D6
         /AGwMyLn03bhwWBayxkjtmO1U/qlS1yzBL81vrHK/IrC0tgzIU2l7NCHigHHeOw6CT0j
         LXOw==
X-Forwarded-Encrypted: i=1; AKwUvByO6DEylGkpsR9KSiiXRKONFhLZPP7U8smjPEOwy8s/+VYdwyk6C33O8MCoZ53pmZzunzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cKRyQhmbM5Iy9yXJEJok4YiK/wuVPhJXF2C1YUfZUStF3Y2a2
	ih8pF9bffoaL6ZWygwYiVbwpgJ10SW2nYfa9O2Tq0DDXTRsP9XZjur11Ry+v3djdLn0=
X-Gm-Gg: AYBFou1eDM18tmg2c7VQo3R4LWt2Ck3J9xRrl9FvjhE0Sn9MGQemkdQH/6265Ighqsn
	njEWwHe1241DQCqbBffzMYhz0G1KrLClIIshIZ012SSxnIP2/PQuzRsCyDCP7eANnSTTa70viB+
	C5pJmLPogkgKbOVTxUXoJkt5IWnb98eMMV70qDYmoh0PBP0V2oGVgbc77/jPPZ6VQwS/KvNSm43
	GAYjLnvo09L1/XZk9f2WdDIJcTjAEJ24LzPO1fudyey2oVOaHQVvC3Zq61YwjCdc0iF5eXHjLIu
	RAnUzGy2J3zai17FJEbmNGQpMerMNTZsrVISt705vXWIzDnys9sH6XjUDmcsKldC4c3qV1ZGddN
	jK157p8GDznrnNQe+r3MLBvBwHPs8ykxOpnu0tSd79e2Bf0hRF6dBchkhZgKJ4m27NmVQKd5RiS
	JNhKZfWlbrY26nBxsvMg4bTfM6ZOmsLrXw/OEpz8GJI3VNStWi8mRYuJB/I2KEdq9bYvG8LKZpi
	ea0G34iYlVtjUM8o7YJBdXyZf4dfsrOZqODsSMDrkK8Z5p5IHhVNHKB/gcUyy04940ULEDWg8VV
	ZYrRWOP/+3o0Jt2A9PpEkgru/SnsI49tlTj7gyEIZSAEAmFGc9UyT350c65CIe3ZHq+Byh1QweP
	aaBgg6hifTcPiFeg=
X-Received: by 2002:a05:6000:4312:b0:48d:f36e:fbcb with SMTP id ffacd0b85a97d-48e6e2eb205mr29662965f8f.14.1793694149346;
        Tue, 03 Nov 2026 00:22:29 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7270asm23867730f8f.11.2026.11.03.00.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:22:29 -0800 (PST)
Date: Tue, 3 Nov 2026 09:22:26 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bpf@vger.kernel.org, dsahern@kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process
 documentation
Message-ID: <20261103092226.2e8ab229@stephen-xps.local>
In-Reply-To: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Nov 2026 22:35:56 -0500
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> +
> +Patches are tracked in patchwork under the netdevbpf project and delegated
> +to 'shemminger' for further processing:
> +

Minor nit. David Ahern (dsa) handles the iproute-next patches.
I stick to only iproute. 
