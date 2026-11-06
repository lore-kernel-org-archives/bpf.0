Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993831;
	b=Hs8dNHcNFhGnksxdHvz0xnnNhoqUDYuVdsjvcXEbTSYHak/L6EtSeQxNw6fAeWpHI1yo
	 VTYJ5gSCVtFrAg47t59r2l+lMa1iMxh4mUcaXrKeA434myNaNG5Rw7/sNp/ZPeJnkw23C
	 gzVZCspc6rHuThScoYtjgRCql1d9zaCdhGqcXRFCLnMBDgbcyIS8OZW7QWr+Mt81NA73o
	 QlbiOOAyHh6071rGWlqII/7MA7VUEBAvhQB9ncDk6M1NesM0UBAuFfW2oTJmMSnmD2Zzw
	 PUVbsxUGLSdE9J3lLL5xDVLoEU7HAk9MzhmO1MYshEqvQeVdJbH3zELQDRkFsZ66wqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
	b=AtzseoKMqTQ8fBrAAITbkvHHegn3oXLDLTAfU3hTGVS2d+ffMcD7kCmV32xNjdkHnGmd
	 Okm1yuYNHOBLWSUw5Z3Rtl+zzK5BKkTkEhnN+MAZwBmOHmGDDlMPnV9IfuBtctpaSBmIe
	 x0xy7aPNgoHP33E3XbfKnA8/aYj2SpT8zJYK7Q4XKeuhjVq3a0g/yZ9NHbeAcFnuYMgXQ
	 KG3yG6cfxhYDbibOoaKJ8eAe/gZukYbc4J+NLO4QR0USP5uz3BZBvZjttT1hIljGAvW/X
	 Glb3W7MEnia4fAbKk2ofpZ3pMLus4AOg9oWjeK9llRqZZfDcLW0XY0jBM5ETaPejqzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dNYKX741;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106A606A337
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 19:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B106A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dNYKX741
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso386a12.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 11:37:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993829; cv=none;
        d=google.com; s=arc-20260327;
        b=F3RmhgDNrDgpErDQ1em03oFX7d9hb875dMOEft/xtkGeEy/3IujzWH9GeXEJAuIGWO
         p5sCmPbV0X5g2//IHuz0WRVGFUEwVJ4NNyDiZhzGCzZyppkk90iAnH4VSXRJHR7sBhiI
         EibKoXc7sXzY+YfJh9WLoHWrsUzk92DjZAquiM3uN4bJ159UqaCSeb1QPNDTb6jlFJIc
         RDvJPNVvpq9NPfE9/l2dc8p+Kr1ACcwgfXIqaE9sdvV75WY0QSxtR6rxVy740od6fddI
         mBUS/Oen6m2vwzJ1fw3SC+KoiyHXHnsccuTxv/Tp7RsrV0U1KoFEyRcKQYYMzkAqLKqC
         d7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
        fh=Kc50uQkg7fHgtaABCOZfVgguRyQ/eOr63QgdO8CsKLI=;
        b=isPtdZJWekDulzXRUScZ2LZSb1FllFnHGbJ51fffW2zL/2ccx63DFPvEGQhAzWB7t7
         jdE3riadPeZGLMvoOb0TVl4dof+kWtQbEZ/z8YbCBK0v4HwPQud1fsUwqrpsrdS22sHm
         0PTlSwNJXnnEZmB57gRuRtzuDXRUB41up4jzwovSyxrAZ2/h674h/jaRVR/LYZY8u5In
         JOeLkZHBSWAdxEt4BWOe8h1BLEF71yPwaNv0wSLgMH8rod/pRQ1g0/bJk9VGuziOegh8
         h8HZJU6pNaouDIzr7aPUS4HtRR+3hrAZFHH6IAPW9Zzp7K9LAYZ00gudq7BRfxWM72Wz
         i1FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793993829; x=1794598629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
        b=dNYKX741s1YqNe1FvA8HrV/YpGpoTnGJGFShNhnSitPQzFMAUPpOwNIQMFI2wQuupp
         Y3hUs2tFnqdC/VdRW0zFndWiN5AEQOPGp+56b9YRlp3KsWlNMpTSS8KsWRrwE1ANF2pq
         rqBZJYUR8FH+KjD7/HLOiENIbIrs3HrrM8TJb1M/BuyUNDbGddOYw2008Rdk4q5N0Uxl
         3EieS5hw2UL/IalHpELqKu13m9jSN1raX/4Zjd6KaK+E++zf5w71v7XhAlDRuezX6Udl
         f7kTAVTND9XsibslSTDmGJ+yIq9kviDckaPxMp7hBXFHpqA1f7fpqoKOW8Fvv9kEJQlq
         mUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993829; x=1794598629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
        b=WB+Ocd2MOCnB8kpHX9MmWad6DLFOgLkLd/V7R4Ud3iJifMPzRMs0wLol9DIPRNWpwO
         yCIcD3wT1hl7Xcm/Xl3mzwZhlSie0EKGItnxssSLwY+1Gw7ciCvgPdq3tQhyBb5VLOhY
         +L7cUjPiW5Cdq00AdHC+23wGAxyHL7it9746m7oKF/0Vv1INtsZnWO6O34AJgXgIv/tJ
         7ZIhXriYYX9qvwZpJxE+U5k2kMF2Eip0HsFKHa51IhRkAmBIGsYYCbzxWnSrK96l1jOH
         JcXLIcuIcAguk6gTn2KLf/mlys7O1mrAb6dKrYJiuHb48ZeC3vUvAwYnySiNxyux6Hlz
         tJJQ==
X-Forwarded-Encrypted: i=1; AL+hErHGTrI47kezCC/3VLy/KioFNYpLWbu+usB52qPbDc0ieN6/IuT2JAfJd7AsYZdz47hsvJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VVSIhSUCx1gtdkCPLBySb11yVoKe4jEPU55FGBrbXC9BF9cnC
	QPTWBovyxk/8sN7r+sBy2IiXLKtG+Auj0T9mwl/eMeJPiEZf1LFshfgOS0QHrZ+eJPlFxwJ/b8i
	QOVmP8Ae5l6Yx4lUwL9hAbdzQR8iOCo85i1yR8JgB
X-Gm-Gg: AYBFou2+HU0Lngmf4uNCFseJVH3AQHpqcpeCEx8qm8cpjNTAvYCUrW9AackzoQ1UkYM
	/pM8zM8T4mArnOnjQpSV+Q6mTNalb95HEF8CDv3q7q+70LwQf8mxB3saT98olpna9Wbi9LE4X8B
	/+S0ZvrXYXEVOLKIx1X+oLe0UJe24JMBXfGPzT7vj6Yyu2n64a1oD+0UF2c3BtlMl5Qgdb0Ovzz
	jurn+7/oMHZjWiyoRaOhLTJaRoMKkAhgLEs9kqPcgfKFa7ECHK88NLm5CMM5/fo/OK93M+HC0p2
	Bu85dllCEx9VLQYwTlPq5WyI2/Am7WKqnnp7bln5k9pWtRI8jL/0n7q7iaVQXa6brLc4Z6z47wf
	MKhEDwQ+r1+VnmONN8t0e8nC2dpe1rnIEoxeIDXEjwH4mANs+Uec0Uv8fOR3itg76OoQ=
X-Received: by 2002:a05:6402:23d0:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b6f845ff3cmr14348a12.15.1793993828178; Fri, 06 Nov 2026
 11:37:08 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103211424.127627-1-almasrymina@google.com>
 <20261103211424.127627-5-almasrymina@google.com> <sashiko-outbox-198073@kernel.org>
In-Reply-To: <sashiko-outbox-198073@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 6 Nov 2026 11:36:56 -0800
X-Gm-Features: AclHuK-XzQbdvaiv61WJyi_8ZqhwGRBCNFscgmlOjr77cMwMQUJZYeAEPiQPfDQ
Message-ID: <CAHS8izMDj5a0xyX4HAoAt=djt7As-Ko=LyEUfq9iJnPoCegXsA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/5] net: remove skb->pp_recycle and
 consolidate netmem refcounting
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, imx@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Willem de Bruijn <willemb@google.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Johannes Berg <johannes@sipsolutions.net>, Byungchul Park <byungchul@sk.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Wen Gu <guwen@linux.alibaba.com>, Philo Lu <lulie@linux.alibaba.com>, 
	Justin Chen <justin.chen@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vikas Gupta <vikas.gupta@broadcom.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Nicolai Buchwitz <nb@tipi-net.de>, Satish Kharat <satishkh@cisco.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Fan Gong <gongfan1@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Felix Fietkau <nbd@nbd.name>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Yibo Dong <dong100@mucse.com>, 
	Brett Creeley <brett.creeley@amd.com>, Justin Lai <justinlai0215@realtek.com>, 
	Larry Chiu <larry.chiu@realtek.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Paul Barker <paul@pbarker.dev>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	MD Danish Anwar <danishanwar@ti.com>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Ronak Doshi <ronak.doshi@broadcom.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>, Eric Joyner <eric.joyner@amd.com>, 
	Mohammad Heib <mheib@redhat.com>, Prabu Thayalan <prabu.ponrajthayalan@amd.com>, 
	Chintan Vankar <c-vankar@ti.com>, Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
	Alexander Sverdlin <alex@sverdlin.org>, Kevin Hao <haokexin@gmail.com>, 
	Karl Mehltretter <kmehltretter@gmail.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Meghana Malladi <m-malladi@ti.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, StanleyYP Wang <StanleyYP.Wang@mediatek.com>, 
	Frank.Li@kernel.org, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 1:15=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] page_pool: TOCTOU race in page_pool_unref_netmem() non-RMW f=
ast path
> - [High] tls: page leak between netmem kTLS records and mlx5 tx_sync_info=
_get()
> --

Real issues.

pw-bot: cr

--=20
Thanks,
Mina
