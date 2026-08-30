Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323B31A55B
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788127890; cv=none; b=FbROqbhuZc/hS1iySjVCUvFYyxyXfZNprXDQ6irjkbaUOqrhdUHaub8pajUN73WflgFUt2HHPzpJLG5MxvH0ZjGnZ+CEjEOzEPzn7CelNaqnD5/te9XWh3VqjfMQjK42RmJh8Pg5JlBEB36QGsAk6Y1UbkxHYxViE+q8zXxSRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788127890; c=relaxed/simple;
	bh=Y6yLX+OH+OYRFjbkV2SAEGuyDJWmPr67ZnqS5SQ9Jmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4uagbpfm6ZGEKF1rLLgf8TUZrY6gxnDNrQaySflzEXiAyeRKk/CmrOZMoxMjzh3XDKgJoE2hDtK6FTTttBgETVHzVfPEgj8lS0pHIoFzE8SXiYYpzzlZXuj4QxYqPx0U+nl9Cz4LiuC3wbT/j2owYw+KShjgJqDNRDSpkNTW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NInALk7k; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NInALk7k"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso459175866b.1
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 15:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788127887; x=1788732687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ke7q6OPG+H0JyMbKGhae9IDTSIoPnu+4UA6wm856/Ak=;
        b=NInALk7kf6ZL/GWMT0IDNzoUpg3FQ3U66LKvBviHAZpXq4k7xzVRl7ECa7NADTdAZg
         fjXxGyeoyHFYmf9HQ8tb+xsvwXQgBOhw5TEzh6M6aG5R4ZzbuKy5PWbmr/MIEqj8UJ38
         VuJw5WtCZSTVEOhnLqoNH9bPA/qeoLv8g05LAMTIRJrywr1HygbEQupRBIcLUs80JunZ
         d7VNKS1tboG4uFee0Bl2j84KHorv4uS603fGkbTT/Tb6EqvT971XDG9GNWb52Q5trP74
         vVu2+QVlvBkVz6UbABrXmRUuS4WGroHg2RlcnDILcvEycEqYxjV56bKUfIi6uL8aiK2D
         6pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788127887; x=1788732687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ke7q6OPG+H0JyMbKGhae9IDTSIoPnu+4UA6wm856/Ak=;
        b=NXAdO76j1dgyzR/H2usVQfamlCsVh3aWtX3zksao/saaEsxso9+quPGfV64BK7SN6T
         moqe0WQEYFyDc9chH1NCq2Yh+HsROBJ5/PPN7YB93W5+DaaRAj/W8r32Tw/v0ioUls00
         lEdKFEtuOk3QDygwjyCOZLt+9HtHlQ2GUTlvHaLOf21qy00Ci6XPoVJkvtQs2YpJlLMd
         IJd+6NpLENWchsTfHq1MMbkTL66rlLR8WYIB4ad4YvZvbxqfNKDvVilqZEQCuojmLYB4
         zT5b9RrDaT1FnEQpq2/iShOXCaFbC8TFqoMTi33peVvg8x05DLzFtkToAw+IFYm8FmiM
         F9rA==
X-Forwarded-Encrypted: i=1; AHgh+RpKv3IhXXl56OHYbLNi79Sr7JqjBEsD0tgCxDIUTYcyas2Qx6z3jWjS/XAdOhJGIEBgbx8=@vger.kernel.org
X-Gm-Message-State: AFuF++kozZ1zVyutRRVWtfamHaug5nAwvPMABq9Ndr2UJqHvxh3z7Xib
	sXndCkYHqdgVqkDNADaA7RCJXF669SRemxM3kIyrfgSjOrzjbTwzAbHb
X-Gm-Gg: AR+sD10NtddEpJgh0IDQZ0AzfD24w8MoeZh/FFnMOLQdMNfykoZKk1zSjw6pmSYEZt3
	5pkUI6rkxZYf16pXHxpfgrPM2Sj/eH6Z8u50E3M9Y0rIty7raXC1J3Q1bHgaf0M+Nv8wwbqz0Xy
	p2ETKC1kOz8heZpyRuZnyyAGp95ztpfZTiBIXCtVYKTWPwsx7W8nwS+E/adEJKG7D25/RKE7Dfo
	Iux8dGKAMfF0guzbrDCrZSFCKvsga1HsUB1g43GKVrXnLa2Zt1/dGVo0LxRTz6MYj4TNL3mCdp/
	CIJnMyKa75BLKIwp0Y/Il1rMg/3z64JCFWi3DJ/tUUm1JFAd9vdArOM4TU3ekTic+aGXX0PAaRj
	QqZXZo//CLsunwwG+X9+kzIB/RL5pPBBYWe7lIgErEolJetUkk/3d6HDCCCjpAk7IgtZ7kRTlhH
	pIz1H6VQNNe6Aze35ht15L9EWOf9T9jkCqK2iONSq0dTTjecOyMWNm9N75NC30MCHg+KK5WojRm
	YuTb49I3rcktE44wFn0z20H1Gab6LPokJl8cTlfMo/dlzLwB7a94s1PFGf6LNmcOKlgqjbcTy4t
	v0cxyYVMnDSby7APWLgbbIJmsH2P1hfXo+Omf1uSAQCGnNBaF1tI4XsV
X-Received: by 2002:a17:906:6a20:b0:c25:6c9a:88bc with SMTP id a640c23a62f3a-c25a69498f9mr10903066b.19.1788127887214;
        Sun, 30 Aug 2026 15:11:27 -0700 (PDT)
Received: from fedora.home.arpa (77-162-219-136.fixed.kpn.net. [77.162.219.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255eacf6bbsm340084166b.0.2026.08.30.15.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 15:11:25 -0700 (PDT)
From: Bruno Xavier <bfxavier@gmail.com>
To: florian@schauer.to,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Cc: fabriciogava@gmail.com,
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
	linyunsheng@huawei.com,
	Bruno Xavier <bfxavier@gmail.com>
Subject: Re: [PATCH net v2] page_pool: keep frag_offset aligned for odd-sized requests
Date: Mon, 31 Aug 2026 00:11:24 +0200
Message-ID: <20260830221124.1238312-1-bfxavier@gmail.com>
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
> Round the fragment size up to at least the alignment struct skb_shared_info
> requires, so fragments are always suitably aligned for the objects callers
> build on them.

I sent a caller-side fix for the same defect a day after your v1, without
having seen it:

  net: skbuff: keep the page_pool fragment offset aligned in skb_pp_cow_data()
  https://lore.kernel.org/netdev/20260827122926.31123-1-bfxavier@gmail.com/

Fabricio connected the threads. xdp_copy_frags_from_zc() at
net/core/xdp.c:700 passes a raw length to the same per-cpu pool, so the
caller-side fix is not enough. Yours is the right one and I have asked for
mine to be dropped.

skb_pp_cow_data() is also called from veth, drivers/net/veth.c:762, so the
fragment loop runs outside generic XDP mode as well. Good to flag that in
the changelog.

The skbs that actually panic are small and linear, not the large packets
that leave frag_offset odd. skb->end was 114 to 178 on my traces against
384 to 955 in ordinary traffic, because the tail fragment of a page is the
one that gets an arbitrary size, page_pool_alloc_netmem() setting
*size = max_size - *offset. Your patch aligns that remainder too, and it
is the case that actually reaches cache-line offset 61 to 63.

Another configuration for the record. ThinkPad T14 Gen 6, Fedora 44,
7.1.9-200.fc44, netbird attaching a generic XDP program to lo and holding
a raw IPv4 socket. Four panics, all skb_clone+0x159, split-lock detection
in the sld_warn state that still dies on kernel split locks. Tracing
napi_build_skb() on the same box puts the misaligned heads on
skb_pp_cow_data() <- netif_receive_generic_xdp <- do_xdp_generic, and the
clones that hit them on raw_v4_input().

Building your v2 here now, Tested-by to follow.

Thanks,
Bruno
