Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793987600;
	b=n8wssiuzdIW7/LofdoeFH9wMoQAoWCoYQkJkMGDah4nH0cl13NIsOLomR2pMrArHCQcE
	 0PeO3//j7qpK3AAD9x4y0468l8ZD35LznEPclQQJ7zZo443jf0irWAOzONp3482/EnnBh
	 cXzwgbRe4+B1uKDrAs06dGFPKzmbUyNNxDg9FggrHc84SjeVt5Peq65+eCgCsK5bDjXVR
	 qh7sjihBLDBht/DfdCotjnInX/vnYOJyfjat01IRhzBz21WX+FQxds/vAzRlwMLeZuGAS
	 bR4ZtDHbe07lCfKiCzqt42yKfILNzRT6T86uMyNPMJJLmxALAlKZ/Dh5dEl+SvtyebQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
	b=mG0cKFWi/c8pHtenzaX9VYcTv0kAvamAwlibrv85gHS4ZguVFy0X25kknskeX5Rshj17
	 E96o9+kJ2qQ19wQK1qa2+m8Js630RzBEeNd5qtoZHG2nuCEhcB85CS12r1N9rg6RMvxsY
	 uKdwRPrZsiGOhKBLV2O5bZCbTznG6IFqUtBbqhcGfF93mU7tG83UY48p45YzOyqSelY83
	 6WYw3owXnUc4gEUJJkMs0oInIe8qbCzFXTWvPiGXsAKqN2mltc80mdnKTp1PjS/mJ9ebb
	 OMEByzU4Da3vNZx638+1+MTAboYLBVYIHBLlmCcqXoyeGnnoJmReL24MYxpUL2JzOzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jlcDAy1q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318F606A330
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 17:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7318F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jlcDAy1q
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso4020a12.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 09:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793987599; cv=none;
        d=google.com; s=arc-20260327;
        b=GAZSBtOH1cHqvqey1mt2B2v8CbzN+jsTV51O7OFqillPtMdBO9iEW613Dz8qK54OUe
         YYd8rIoEVjgC/bjMEwrHat541Ng0f1/hA0s2ZRDSc8J1u3D6ptxc4Hn74/5EiD0kuL8c
         GlK71FjgxF4XXblo+4Lsk0qCVFBGujYu5d4iK5/TnkiniA2xJ3LPo5Q6mVWqSDmx/MO2
         ej0rJMilw9YwNts4LXoMQwugTkEc4cNuva6E7HnQF2DReEUK3LFFN7jE6gzfJit9P8ro
         TKl3Cnx6vxxrCArnnb8d2JRBqwnKbK1VBqRJMXvS9ulYTIP94C4XyYv1NQO9rp6JSVGa
         +6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        fh=mF7cDyosFiUUQ562GeLeP3CPK+Eh2qw69MAzWo+WhhE=;
        b=GAIsAJJc37n4PwP6da9XB2DQmjI66am+tuNLYPkt8X/CDx0MdrHMJ6j/UmxPbzTUK0
         7u8AFsIMG2A64yW9gaM6Ptpr7vxNAZVrxsDbE+tD76LvphTk/gakn5T6E6qBrELqq7JZ
         VFM8znXoEW4fLy9R64M35t1LQF0GWDQ3/826BUCHVm6b8G/MwzQgWeL3mDClSgjxC1Tf
         AjqJmFb/g4X0tK3ebYcAvg7bQSJSLhtj8YBSTi2iL+V+YjM23kLK8VBfYYCKHvBSQcsA
         2mrYkQjkAPMySX8/FftzzHVcrYi+BeGRbASZrp41tec1ihUBCkhfLNbtCjXLjKvsHuIj
         nrLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793987599; x=1794592399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        b=jlcDAy1qwlP8CV/J8ziGOhM7zgiwe1Yqasgt18zZ9BLFfbdjvFbOPJHelnnlWn7/NF
         Iv0y6BvcfswTFEAK+vaTKFWw4pm1SC9i7SkbSqJgyIWek4Oq+yCZaP0CXyGrm6BTXeAy
         PMZhXc8r+FCA+Uan8Tn54ozp3MQPEOEFZdVxBH5ggJzVX08faCYPNZDo3xsJ3VF8tmEg
         pX3urwYaX0msYCvMLpruaNTx6NxqPVTVZ/iC58DSiI1w9TNgPQSmlsdvsWkpbFzggva5
         DeXnKd9qGJxbmFLWSsqwsQR8pJQE3NG/l6oFkjRU8+PfaF5R3/yJ38vi2guHN24z+b5U
         +fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987599; x=1794592399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        b=oyHCeM6MhA0a8bEjOuDqcBHanM0zL3p+VmpHxspQ6xUqJoXPhLvHDB3C8+esWVt8Ls
         wCyHAHA4pLmid77g+dGZb8iThwmEzbNlrKzDvP+FF3uoGugADquFXk9TklyDM6sdCjDl
         g0QOwKogf5xPc4n59lV5NYTg+vx5bXdYaf5xr5kY7kJSn7ZkABucyLwv71+OzzljKFJh
         mmvg1uQImsWoopP1DUWPvPHOQolNzE9d33AlJacBNBeg13H8pvU+ruaDrP604xlJMxlt
         xNftWVD8Ty3WedG3fn7RN1sbP4meFIpzmYVxEZgxYZij+u3Hh2l2olTzcR5Mb3yuzYgM
         Qtig==
X-Forwarded-Encrypted: i=1; AL+hErGbVez54Db0aKoESXmsIxkHef272BZ7+lV/rQOqcEZLPJFc/MwhasJR4d47vZF8UYMibks=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8XkLecAIth8za72/J0YCIy/7Rv0rEFAsP3JzFT4TKEpwC1s80
	t4PqXNLda/uLx93kyOuZdJZfOZ1vjJECD9k6ZR2wq0258XEkkAKQajO/TZKBrZaJg2f0ak06neN
	ecgEtfeB1y6gLpRNA7H5NsK+MREknJEtY8Kxz520o
X-Gm-Gg: AYBFou3sjf6t/kCINSi0h9dMVdtNqaDARj0LqeMK4RpM+L8mRgowQ4I//046iBB+0aM
	D8bQYHKeZDKU9iqJCdaL7b+7uVxBDMbpjAIoqdqVBc6ooOvFiLnoOztBut2ZKWz/reyQypv55VX
	U0i2xvOUYqlpOf925I9epiqL4X1abP4TsDzLHqb+TXisVSyhjfZztpKd0DoUCMCZX6gMrLZaZ8D
	jeg06IjcDu4ghSdonsEs+v8O8qbbtMlb67Wy3Y3kyC0yI8cwUxpcoOujoUVYY4DARjkQeWAqAUq
	fJnli9phaAmPNLBuXmiQVA/Gvw0P3b6mv+kDQURLVyrYVeTufwZt2rn7ZwDP5SAyBY5pY5s4K1g
	jd+8oVHVnj2626fkjtEDOqKl8Nfp8mmp8oichWRQoGjUc48FBuyeK0d8kQXp0sr8o8XM=
X-Received: by 2002:a05:6402:20d2:10b0:6af:97c0:ce51 with SMTP id
 4fb4d7f45d1cf-6b6f84514ccmr6722a12.13.1793987598073; Fri, 06 Nov 2026
 09:53:18 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103211424.127627-1-almasrymina@google.com> <cf2e3292-d591-42a4-bf6e-76f4567604c6@kernel.org>
In-Reply-To: <cf2e3292-d591-42a4-bf6e-76f4567604c6@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 6 Nov 2026 09:53:06 -0800
X-Gm-Features: AclHuK9NbTvBEPfZwCm6iqd7sXh-jqNYXp8FMPv7QJO9bGGBVmf4WllHJrUhzyo
Message-ID: <CAHS8izO7QmD1qp=QfUsCq-R+p7OuOVUtqPJZh1k+u7H1J3KnoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/5] net: deprecate skb->pp_recycle and skb_mark_for_recycle()
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, imx@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, 
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
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Johannes Berg <johannes@sipsolutions.net>, 
	Byungchul Park <byungchul@sk.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Wen Gu <guwen@linux.alibaba.com>, 
	Philo Lu <lulie@linux.alibaba.com>, Justin Chen <justin.chen@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>, Satish Kharat <satishkh@cisco.com>, 
	Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
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
	Jacob Keller <jacob.e.keller@intel.com>, StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:36=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 11/3/26 22:14, Mina Almasry wrote:
> > Remove the per-SKB skb->pp_recycle bitfield and skb_mark_for_recycle()
> > helper, and reference-count netmems directly by their underlying type
> > via netmem_is_pp() inside netmem_inc_ref() and netmem_dec_ref().
> >
> > This series simplifies SKB and netmem reference counting:
> > - Reclaims 1 bit from struct sk_buff (skb->pp_recycle).
> > - Unifies reference counting of SKB fragment netmems and regular netmem=
s
> >    under netmem_inc_ref() and netmem_dec_ref(), eliminating the separat=
e
> >    skb_netmem_ref(), skb_netmem_unref(), and skb_mark_for_recycle() API=
s.
>
> Part of the performance gain from page_pool was to completely avoid the
> atomic refcnt operation, when we can see that page refcnt=3D=3D1.
> Are you removing this?
>

I am not, and this is a very sharp observation, because retaining that
optimization was one of the things I struggled with my LLM to come up
with a way to retain that optimization without pp_recycle. Patch 4
includes verification from pp-bench that the fast path remains just as
fast:

   - no-softirq-page_pool01 (fast path): 37 cycles (18.7 ns) baseline
vs      36-37 cycles (18.5 ns) patched.
   - no-softirq-page_pool02 (ptr_ring): 77-78 cycles (38.9 ns)
baseline vs      76-77 cycles (38.4 ns) patched.

But the sashiko comments indicates there is at least 1 race related to
this we missed. It looks like a smp_rmb() after checking the page is
exclusively owned may fix it. Let me see if that works.

--=20
Thanks,
Mina
