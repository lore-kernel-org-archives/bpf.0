Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1D16F288
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788124996; cv=none; b=ZwyTbK6ZBgQ3xHH2atW+jUKiewQQcD8AwEi6ueWXZPKASc0Mqy4KnqC9zHZfzhzCH7JlcAH42eAHKROmvKvGhrFwfYWFZ4cJ9jCrZfTeX037tevSLWPQOiyHINV97wavzvIR4/JXe48jr8jK59EoWdGfiQ8E/4ke55qt0LXc1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788124996; c=relaxed/simple;
	bh=noxdCxBTOJYd9u3M9mz8sS3eKpGxBtTJNiFJ53+QoLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUlME05BQ+9nUgCV4baAkm+BrgYjCMFs4yRRmbObc3MiZnU6R/xSwbDvgQtGx3/YRuFSVq0VJ7Cyj0nR5Zp/bgnRVwjTiOWxqoxbQNg0C62RLEa7AUA7ukI+FzpzpTuq38ZM8QL81iA4K07EG9EdC+BbJHeCeUZFw67LsuzgqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPhx2I9j; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPhx2I9j"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-861f30636f9so12940157b3.0
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 14:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788124994; x=1788729794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dux6nks3ScI/W1I3RtYItmlPEB2o40tc65RGc+Gd5Eg=;
        b=HPhx2I9jUjd/iDNUvS3uf6nJorxWhPwLV2phizpQf40pU5e77sghFk5y9owKhuMwPn
         uUmYrt8iYv8cqGquObEokF36b5irTbtf33HrAqnbNYqMnVTdl1t065UqXJTPkFTeBzab
         tDLAbS4rjTGIv6S3GnsT0GXJZGfaYkgdicI7hbvMqqIIzgl9Y+Gsf7sQibgKeA8gpNrj
         nzu0WJS/qbgKLmp/r9gnlo2xEc0LSj1FfAlT9pbZ1w9apwQitXARKsfzAtd3a2s/zPIj
         rHU+vWd35ZC/3lks2vHUbW9cn5ONDTyOftAVRTPMDtx/DfoVq+AfYanYX8hE3xBxP810
         kz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788124994; x=1788729794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dux6nks3ScI/W1I3RtYItmlPEB2o40tc65RGc+Gd5Eg=;
        b=f7VwGKZls03rV59asMZSEKuubFJDpbIcAAVm8kFVbuVMAXhjVQq5rUz56Uk/RDCPH9
         T4fRLCK1L9WTiKjfBfTHziVZC49gEa11NMJ3uLfuOXes1PVu9nnDYm+t/bPV7SEpPidq
         NwVXtD7mnuaSwQFBtDJGMbx5FyRIsf0w/PyJWqXRkp/WrWPllvgmxPhrDoCc4hxRS+HU
         6CxF/2SfzQp8J/c+jLY8dYUtjWTssAhqBBdK3o+m32oQK/wqXNwekRw3iJfhLK7Qq7lv
         tsOjr+07HtDpUEDh8yWVv847+YBhMI9BGlJUohs+rn/srx5UuSg2VjNQxeeKr6t5lGj8
         0RbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwH9i6hd8yhI/qkJiVYWBcpXlioPilOR0RLxZgufDwlslz3xx4I9YLDCl+NuDc20tJHkTg=@vger.kernel.org
X-Gm-Message-State: AFuF++k7KF0ip7g9USt06KLy3mEjSv7+JeWewjKPBs+FlvFyXl/4QssK
	x9Xn1mXd0jF6fcZxni83cimXaC5TSxQTWPXLGuUVQzjl0dLZ7ZMfzF9u
X-Gm-Gg: AYBFou3MYhdnwVkFC36XI7urHr2N0cbfY8HXniNt3rbZ/nXOGwJPKkB5gmPFXD6f+Lb
	WFTv4Emkw58N34xbT0RZ0d7zRlO+/Ujw9Xw14tUjPmW6k7YfSFbS2PfuOL595P2OktIOJ2qZC68
	WRNwERbqg/Oq21qh0qbct+Fj++9m2xXHHZdmu5ZqaWFHtDtg0w/skeenEVQYeamLguleW5/YKzt
	ANRu3tT1VowxkdcQIHfZKqALBZkfs758KNG8tCAe1pctdAhp+HM7RH8UgrNf1y0SaNTzS+BewTl
	UVvrFriFHe7flUlMBflKqjvpuMiaJ6fGA7UbiQHNr75xHLZQbmRbpAnsPE8vI2Ma2w9Ydc2oVeb
	6TrP9+E+jhs8O922MleMwj1Yb5Qon1NkqrJvEkgL6U7bLKPZUEx3fJrfkgsOUlesw/0+oVE9jJd
	AfDUTsqj7gv7m2+Krn4rK180NR04zY/xmmp8gLLxGoAopLWkBd7qUDx51cSjKcgCK7MsV+S37Rc
	LnazU5tXscmPQCWJBVbKlMG8yDzUptsctVwnGgTszZFaWgZFmmi8s2OrRAQo+zjvb8NtD+eFw1i
	8NVXhAknow==
X-Received: by 2002:a05:690e:810:10b0:66c:e845:c0e5 with SMTP id 956f58d0204a3-66e4c698fb4mr4913441d50.17.1788124994298;
        Sun, 30 Aug 2026 14:23:14 -0700 (PDT)
Received: from intrepid.netbird.selfhosted ([177.161.242.155])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ecf1f6fsm4454271d50.13.2026.08.30.14.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 14:23:13 -0700 (PDT)
From: Fabricio Gava <fabriciogava@gmail.com>
To: Florian Schauer <florian@schauer.to>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Bruno Xavier <bfxavier@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linyunsheng@huawei.com
Subject: Re: [PATCH net v2] page_pool: keep frag_offset aligned for odd-sized requests
Date: Sun, 30 Aug 2026 18:23:00 -0300
Message-ID: <20260830212301.545982-1-fabriciogava@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828060822.2628276-1-florian@schauer.to>
References: <20260828060822.2628276-1-florian@schauer.to>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 28, 2026 at 08:08:22AM +0200, Florian Schauer wrote:
> Tracing page_pool_alloc_frag_netmem() over one such run shows the
> amplification -- two odd-sized requests, nine misaligned offsets:
>
>   requested size & 7:   0: 17035    5: 1    7: 1
>   frag_offset & 7:      0: 17028    3: 1    4: 1    5: 1    6: 1    7: 5

Two things you may not have: a competing patch for this same defect, and a
measurement of how far the amplification goes under a different load.

The competing patch fixes the caller instead of the allocator:

net: skbuff: keep the page_pool fragment offset aligned in skb_pp_cow_data()
  Bruno Xavier <bfxavier@gmail.com>, 2026-08-27
  https://lore.kernel.org/netdev/20260827122926.31123-1-bfxavier@gmail.com/

Its Notes: section describes your change as "the alternative" and offers to
send that version instead -- the two look to have been written
independently, a day apart. Both are in state "new" with no review comments
on either thread, so a maintainer opening one cannot see the other. I have
copied Bruno here.

On the numbers: an independent reproduction on a third configuration.
Fedora 44, kernels 7.1.8 / 7.1.9 / 7.1.10, Intel i5-13420H, NetBird v0.77.1,
which attaches a SEC("xdp.frags") program to lo and holds an unbound raw
IPPROTO_UDP socket. Eight panics, all skb_clone+0x159, six from
raw_v4_input() and two from ipv6_raw_deliver(). Same tracing as yours, over
a 12 s run of a reproducer generating UDP datagrams of 1400..63000 B on
loopback:

                                        total    aligned    misaligned
  size requested from
    page_pool_alloc_frag_netmem()     1876609      23.7%         76.3%
  *offset returned by the pool        1876609      31.9%         68.1%
  skb->head from napi_build_skb()     2314689      91.8%          8.2%

Your trace shows 2 odd-sized requests out of 17037 (0.01%); driving
skb_pp_cow_data()'s fragment loop with varied datagram sizes puts it at 76%.
Once an odd-sized request has moved frag_offset off alignment, the
allocations carved out of that page afterwards are misaligned too, until the
accumulated sizes happen to land back on a multiple of 8 -- which is why the
share of misaligned offsets (68%) is so much higher than the rate of odd
requests alone would suggest. If the changelog needs an argument for the
stable backport, this is one: the rate is workload-dependent, and it is not
bounded by anything.

On coverage, which is the part that may bear on which fix is preferred:
skb_pp_cow_data() is not the only caller passing a raw length to the per-cpu
system_page_pool. xdp_copy_frags_from_zc() does the same, at
net/core/xdp.c:700:

	const skb_frag_t *frag = &xinfo->frags[i];
	u32 len = skb_frag_size(frag);
	u32 offset, truesize = len;
	struct page *page;

	page = page_pool_dev_alloc(pp, &offset, &truesize);

and its caller xdp_build_skb_from_zc() takes that pp from
this_cpu_read(system_page_pool.pool) at xdp.c:753, then feeds
page_pool_dev_alloc_va() at xdp.c:754 into napi_build_skb() at xdp.c:758. So
that path both leaves odd frag_offsets behind and consumes the head
allocations that follow them, on the same per-cpu pool. All three callers
of page_pool_dev_alloc() in the tree pass an unrounded size --
enic_rq.c:277-291 asks for netdev->mtu + VLAN_ETH_HLEN, plus xdp.c:702 and
skbuff.c:988 -- and
where a caller is safe it is because it rounds on its own beforehand, as
virtio_net does with ALIGN(len, L1_CACHE_BYTES) at virtio_net.c:2710.

I measured the attribution rather than only arguing it, and it does not
settle the question: over ~75 s and some 8.6 million fragment requests, the
probe saw none originating outside skb_pp_cow_data(). That is what one
should expect on this box, which drives neither the AF_XDP zero-copy path
nor a page_pool-backed NIC driver, so no other producer was exercised. It
says the caller-side fix would be enough for this workload, not that it is
enough.

One observation for the changelog, if useful: the skbs that actually panic
are small and linear (48..222 B, data_len == 0, ordinary DNS traffic). The
large non-linear packets are what leave frag_offset odd; they are not the
victims. That makes the failure look unrelated to the traffic causing it,
and it is why reports of this are easy to misattribute to whatever process
happened to be running the softirq.

We have not built and run the patch here; a Tested-by: will follow
separately if we measure a patched kernel.

Thanks,
Fabricio Gava
