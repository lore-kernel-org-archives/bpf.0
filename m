Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724257;
	b=3IY9+ZfTYhC/NHmk3FCT6Zj0fpBMyBzbM915D5xsVkRJXuiDOEfWtS0JLNZKJ50sp2YX
	 tBXoWnjM/ShWxQ+qSxF+7XUR7stTNUbvUCkv08TaMAKqAos/sAm0FmdP1hMqJiWn1/2VR
	 AlNcPw+/HOXsdzbcaJyeA+N4ZeiwCvkQDhakp4rViWTVHL2vrEZEhoejvgZd3z29xtY+9
	 HTSenqw+B1mhezgtjAelEMOJljyqFZnt3dbzVfNXWEVB2S8lKAUdNWgWg2iHcc+yt8pfE
	 /nuE0WZAxFiHLAFfsd2dUI3UIxiHSBgVnepU21cyPEDE8tmo5xnB8QECdifcy2BgnFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=VXn/XpmalFaorWxQyW2WApryIA+d6umQwuos+tyn2ZI=;
	b=PwNcbbH+p9obWAzisJ0N1rZwVYmELWQ98ngwO/ujt+vpVj54cuQ/Uok9LNvxEKfZyw79
	 pMEqo82/wpN7BwFH27x753p9lMXAzn3ZAsRYgvJL5oKkKzCNNsgbuY6MMSDJRHxco8LJe
	 Pjhb7z7McyYqI2mh/Ys3X1s2pAswroIHpRGLif3Q9WSjuAh+Gww0qDvx8F9AdUMfI9yCL
	 LXSLy6UAABuc5XzpiiOxVYoc4TLaEYPmh714wDL5I0qM1T7qn6OpD39lTqsqw+ia+hx40
	 0bwEJ/5OwQ0rMdck2MFMbQEtaGETXNVMwWqBVjhRid2z7t8mFuOfs+IWOmlX7lfKPoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dIXrw+PG;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEEE606A326
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 20:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDEEE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dIXrw+PG
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b271e573adso3169359b3a.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 12:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795724256; x=1796329056; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXn/XpmalFaorWxQyW2WApryIA+d6umQwuos+tyn2ZI=;
        b=dIXrw+PGUZ9JFJs2m6IaKkl/LIB/ng9aqcp5cpZYueYeHvzKgSF6UVxoSJfJeV3yDo
         vfHhawgOnGvwHyR7T6h8eyGAN4HfXCpBiOsD07y4j4BDjyQXiw5cf+rwbBQdX2rPqq1L
         a64HcF2K98qV8hPTQJd9nVIQg/Nmu4sAJGfqXljLu2g0SXqzT5SLrdt9PfnOLCaQIC2x
         s4+RTs4c8V8EV/X9VbeZHtN5+0WLYHpN1mR7l39YBfixENuqIPHQkFUzsMxhDyRmc3nj
         bAIrKOvMOzO9WIOWUWQXnwfM3Sl20C6UWcstdIOF+PO/fzGNcdt+/GQUUrY1r4iTrqiL
         6x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795724256; x=1796329056;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXn/XpmalFaorWxQyW2WApryIA+d6umQwuos+tyn2ZI=;
        b=OgW5qWYc31Kmr3ZJ4tvGFW1NTPZa5/GUAvHOZ1SzNtxROCW51mj0yRHNg0ZwAlnMM6
         hAr1is1+N71KkntO8RKo1BFlZ1PJ17zx8T338Gja6VP0K3+nRsPMb8XLQ3CZx/ZXGtQQ
         MfNg35plDn37oFOWJa42iB8elHKdb9GGJKhhwX4nbktMqlUs0un7UqTCQR0zhKxQE0ri
         wyyJdML/XN5DnaQSmB29rH6BOo6m8UX+SfnFN2jTzsRlhkXsZZ4zbmudzylMjWEMinor
         YHKKAbOga1AP57pO8mc6J7cPnqhm0fZjxdpjnOEynC94uq/5awEUXxsMlQdi/fn8Iaql
         cJOg==
X-Forwarded-Encrypted: i=1; AL+hErE/uFQQVEWMIVMC2m7YjZuy8N2GO6Gwm4BERscGr4vuvF3mlyHv7Y9ZDnWQGQGBoyQbyvA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5p3KQaEOlWNKkcoUhxPa2ph5BSrWJAlwQmry9FEI74Cf+IM0c
	EGbha3irxPWUP1DEvJwTud8Y6Od93FpU6wKrahff+azxF1wkG5wo6jf9
X-Gm-Gg: AZFdTZfdNSpd9uU1xZ0FEkaBYP16zYjsu/6P/77xcRlxMFNRBI8YTb+XKUqO7Kj9F0z
	FwDd0ygVamYeZSIQ2LgW6745WPC6Mxw8BsSpLa0gw11lrFY3gkLFF0V3aQeWys6U2IyPBX/gvg4
	x0YsBgTRI1CRxSchElJQusLbbi6Wjkscax4AcKyM2P5XrNgY3rmc73deO7fz4y6XOgWhwEAFWPV
	RsdIzQOYMQQ05UwlSO+aK5254eQyjIPPEI2jq2AX3FShkkrQzdflzPc7bhXtfm+zCNbZ3lXRGgC
	fhy999XqUSZDP88kIc1Sr2jY0KdMOIlPGE2K8qCtgI9ex1dPr1/TsDIjPJyooUhGFUFtpbYZViR
	p1pliiQ6OeorShcpxflcmh1nlE++OfeCMQtwB5dDFd7fw5Qk9LthI/nxkv/ijfu8dcjPnEh3/RF
	wZtrXPfi5GQ6JAUDisoEcp2pPes4zHDH+Veda/1/eE4j95oAayoGjCKlKq6cu5bACjH4LG/A+O+
	5VO43gO6eiKsGz4ifKVjFeFVHSpNy7D4C+qd+aF9TsT/WknRkDKQLF1r02uhAVfST9v9ycu5mNM
	L7Ety9vXXNogIIuvN8d8/TQxrNM4ubzRom+6MSWjmU2FO9p7zvizdot72/ElhE8gitLQyHGbuiY
	pBfRLt5epltqbzoh4p3CvHRZcc2rjVEsb3OU=
X-Received: by 2002:a17:90b:134e:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3b41c96764dmr22000708a91.49.1795724256067;
        Thu, 26 Nov 2026 12:17:36 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b50234fb25sm3468314a91.2.2026.11.26.12.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:17:35 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 20:17:35 +0000
Message-Id: <DN5F4EBDNESC.3UOJRTCXCL4HI@gmail.com>
Cc: "Kees Cook" <kees@kernel.org>, "Andy Lutomirski" <luto@amacapital.net>,
 "Will Drewry" <wad@chromium.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Jens
 Axboe" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 0/3] Introduce a classic BPF filter cache for
 seccomp
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <io-uring@vger.kernel.org>,
 <netdev@vger.kernel.org>
In-Reply-To: <309b8e49-2f9c-4a2f-9b40-8e7e7cce3455@huaweicloud.com>
References: <cover.1795139109.git.xukuohai@huaweicloud.com> <DN0AIFQ82CFP.34SDTH6ZFZC1G@gmail.com> <309b8e49-2f9c-4a2f-9b40-8e7e7cce3455@huaweicloud.com>
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

On Thu, Nov 26, 2026 at 07:02 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> After further profiling, I found that this collapse is
> mainly caused by Firecracker instances queuing on the
> global pack_mutex in bpf_prog_pack_alloc(). So a better
> approach is to replace the global mutex to per-pack locks.
> I will work on that instead.

Makes sense to fix it there. Every prog load benefits.
But I doubt that per-pack locks help.
bpf_prog_pack_alloc() walks pack_list from the head and takes the first
pack that has room. All loaders pick the same pack and queue on its lock.

I suspect the hold time comes from these:

  path   under pack_mutex            what it does
  -----  --------------------------  --------------------------------
  alloc  bpf_arch_pred_flush()       x86: IBPB via on_each_cpu()
  free   bpf_arch_text_invalidate()  x86: text_poke_set(), text_mutex
  free   bpf_arch_text_invalidate()  arm64: kick_all_cpus_sync()

Every free marks its pack dirty. A cBPF alloc from a dirty pack flushes.
The log of commit a9b1f19a6a67 ("bpf: Prefer packs that won't trigger
an IBPB flush on allocation") has ideas how to flush less.

bpf_arch_text_invalidate() doesn't need pack_mutex. The bits of the
chunks are still set in pack->bitmap at that point, so nobody can take
the chunks or free the pack.

What do you see in your profile?
