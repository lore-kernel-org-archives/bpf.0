Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795644159;
	b=eNHpunnxex/uMSlgJgAW3iFrKqoDPlm7pk4fbyxmYJEjr2Y8nIFb5JJr7c4/htfkkiQA
	 bzmT5ql04vQRw4bSx2IZpRb3km0uUE2bC10Tz4NwOZzRdqfwbijc24m/DxqKZqEzecJrw
	 c+n0nCquaNcyvR4LdQqzHD8af8WBofzPTazha993cQSQrioHB8L7fiba5mUI4QRrbrPip
	 Mc+YP8J1fk4npjQF/PuZxRzmKauGyqwkC790nTmmnAwbEtiOXb5CvtZmsTs82bPfCswtZ
	 03DBeMhsYsH5BZw//cqn1GhLPEt/7naqJpr7G3/wU0Kf/Zf3BLfr5DtUzjORFSwbcCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oHR1tBRCrTp4GdTSuulB2NpPvXunoIK0pVzcT18XLsE=;
	b=bMIRHRrwRG/tOPqMmSVN5vi9YFTegyVa4py+eBHL/IzqX4bqlQomqdoAulj11R9NLEEQ
	 tcn4gZ3KCDbi1FfgGGPN/lTM5MXRuFvvcd3cdq8TKH9wPk/6QjfbDN+0GCnQSv56Uydzr
	 wOGwLmtBzUNOx5B+LEb5r0JY5+xu0r+rOkhXj7i2BY1tdTUncn40/RdFqKNqq+d6NqH/L
	 BbQKw+spuLfby2YhteUQjzI/+F1w5N5NdHlmWXxpN8+tJb9W9XzTymYjqilqeGCWmC0RR
	 uW4I9mnC1Z9gs6xJ5J955AoTKeUD9W3FrhSCfAlDWtSr6pJg7R0KOiTWgXFV7BTDgKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUdMaKJu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9166606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 22:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9166606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUdMaKJu
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so67938435e9.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:02:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795644157; cv=none;
        d=google.com; s=arc-20260327;
        b=oeCVfwz3B3P3Mg7fY5Ntn/hCfMqMq4vfE6lAazCAPeUBxd3AXHZzHhwv7pNsfZ/mRr
         MgrpqxNLG/nzyB5z1sjv9k4NIlqgG7NPW77vHisFVc9Mwh4qtlUYzigrnQlR8+VVn8mY
         ZFFbUBfyVeLpSKCC/k/4H3ZIL/MXYNfN1V6X8umlJOfqfQzuxWeiXbCbnSt/6a3TqP0s
         RdzFo3PrAj99BsqbiXrQGuOVghajx0YXwP60+KwVgKYWx1TebljtJRrVc1bsmDc/ibb7
         7Y/9rBnxsH59AGjLBNZHyJTz0rPbgdVPKc8O44b8lVebp39TfhU13Gh+1zHsJc6BXX9+
         1bOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oHR1tBRCrTp4GdTSuulB2NpPvXunoIK0pVzcT18XLsE=;
        fh=/pEexQIve92NxpYL9gy7+r5SgziaRhiu2qYcwB3WxqY=;
        b=MGz+00SorNFWJojkumemPcxsV89MqVsXzYPczyDcvBmChM5kmp4F7TwI8fTMAHFWN6
         TS55wdwkxS0EYOotHqeMCj+CalKa+bWKb1ktOL+P/rn017mKSzsWpRIupSq61m5d+9Gk
         SGtMtRrPg3e03/kbWr0W39+2uXVt4/ixcR/ZEIJS1VFRIFt0UehsMnMIDzNvDN6pGKTE
         nDhnUhfRXmFmVi+zVwTgO77JR1IlKFWVSU7rw3LH4sTQSJt8dTKmHnm++SUBG06T574c
         Z1EsuEh90ZfxZgPmhY6q14+f5JYfxoFuYR+fLT3Rpcl4agnLCYarap/HawLil375scg+
         E/Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795644157; x=1796248957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oHR1tBRCrTp4GdTSuulB2NpPvXunoIK0pVzcT18XLsE=;
        b=DUdMaKJuwUDdxlYTSZPt5gtur2Cj9hzVh8bPg61VMEQMGvBXDTBSV2l1KSbZUUd+3c
         pNloy/PZqJPvY0K+zoeDZdmMBMexEcq2qjE1sav+r/rQi3yKJzmSw4eLM3x73s7Po+7X
         MMuIyP0+MAD8ZWCE3NnngRYnJBd56qkXAhSgPhYogAX5E2swZ9yLF0/NRbY6Fmz8VsRQ
         EiZog8ujkcs7ujBC++CLtQYmXJTqeiVIBmnEzQNmJ0P16SnuENvK0HcckjXInSIFpeRf
         B6vKBy/0rgpzNVyfp3IDFFlZwFz4/z9k3E8nA8YGJWRZQ6n7DyGnN0Kv0UkU8HcRO4MG
         6oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644157; x=1796248957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHR1tBRCrTp4GdTSuulB2NpPvXunoIK0pVzcT18XLsE=;
        b=MZgHPvhjmU2mRr2xG/YuMT2Sr83UvWgvOaTKGFjAaYMfQSoHNr+KwOs/PUmdJL6qVD
         885cXxdYJC0UVCcdopcxfa58DIBn4fd+eboyhhM+yatAWivsdGq6DNriLcbJKnimQiME
         /M2h6qmC4C1KMBu3i08WYs7bB9+n5ALx1mtvHIO78znht7fi2KFPDyombE4WLPo1N08Y
         k7JxS8KrTL8NPq9tFiWI4fLvvL4bqM2oXR5e3JESof8GpsqGGrSPPoYXaUltPZJB/JyS
         ci0/OMsCx8srBx3yhAj7maYMSzE45WFZMCxti9wwHlkrygKMwKg1iQK/vjNPcduTXaWp
         RAYg==
X-Forwarded-Encrypted: i=1; AL+hErHit900/dOCc3NCfvOA8xl6EhqOIvWAXQ64R16+HD6gwhNnICPYeBiVAGiAsTFIRRc25kA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NoTDbntwbSbdpQuxnSzNuIaNpRwDjX+739YRYZ9RTVZt3584G
	Cf892kFLT3D5z2nH7O5aylDA3MWlEEsGnlAukygyiRK8U63hQEXBhvPDEXcLshbZ6dSyecPx1pJ
	P43DH/ynZCfqvxjQRA6c/TM9bfEy2mlc=
X-Gm-Gg: AZFdTZeCGeGNNfsZxKKs7z9YSL7hMa5UgjdSvD50vLFJhWykh7ybJ5AdGYvrc/ZC73a
	jlRfeSKN3YuGX1yGCAd/BtVSNFK3vGornm4+f6w4LXF15qW/PbwYI/3iSbqVlGGhEZ2vOcGjIuJ
	FrmbA1grP7at8fVPrhgyAVtcVhDr9Dl0fY1dX5fvV9zvmzq3U8NTCpMyvLENZ621ROwLmUg7/b7
	p2ca6hTDjzwTMrdUUCnzAnqujeTq9ABLcYn0BHHy6ugPzxuvdmSeTVx0Eta0NVxyI1V/Lv15G/j
	kV84s2zpeRjufWAVYQLpoGPbfbeHSNHSt90BHM7F2Kv39fhEoUrdnAKv7IfBaeUsWTj5fkg6tvW
	Gr9aB8//mHkOLJsOrGs1p/80m4rfSGYhiXOq8rUj00Q5fx5SQ2vm3kO00HulsGp5MYTSkPgllSW
	11KzpgrAnGJRHHBkuz5+Cf7FF6oOhg6U9El+LY9CRj+yTvBsAe1BGUZg==
X-Received: by 2002:a05:600c:4e0d:b0:4a5:e6fd:65e5 with SMTP id
 5b1f17b1804b1-4bb88922a67mr378017515e9.31.1795644156940; Wed, 25 Nov 2026
 14:02:36 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com> <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
 <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com>
 <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
 <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
 <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com>
 <20261125090732.69233-1-tianyi@cloudflare.com> <CAKgT0UcFnSvTO6ATw76qVHYxRusTYXpRVi0_GR5QnMhhoXwXsA@mail.gmail.com>
 <20261125183125.25801-1-tianyi@cloudflare.com>
In-Reply-To: <20261125183125.25801-1-tianyi@cloudflare.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 25 Nov 2026 14:02:00 -0800
X-Gm-Features: Aa3M54o80FY0kbVxOnhE-mBTpxSO-3Img4pRNLDvWi5ZvexKf5BGtRjI4tXLTnA
Message-ID: <CAKgT0Ueso=OQ7=GJp7m8nr90kBUp-+N6ko+Qy4e29MZv6tLQfQ@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Paul Greenwalt <paul.greenwalt@intel.com>, Alice Michael <alice.michael@intel.com>, 
	Eric Joyner <eric.joyner@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	tianyi.gao@linux.dev, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 10:31=E2=80=AFAM Tianyi Gao <tianyi@cloudflare.com>=
 wrote:
>
> On Wed, 2026-11-25 at 08:32 -0800, Alexander Duyck wrote:
> > Realistically speaking there is an easy solution to this in the
> > program itself. It would be to look at using something like the
> > REDIRECT action instead of just stripping the tunnels and passing it
> > back to the original interface. It would then take the frame and stop
> > processing the remaining descriptor data. As it stands that would be
> > the more correct solution as you could then just redirect it to the
> > tunnel interface I assume you have stacked on top of it and have it
> > receive the frame instead of having received it at the interface that
> > just head the header stripped.
> >
> > It would also match up better with how the stack would actually expect
> > this to work if you didn't have the XDP program in place.
>
> That is exactly what we are trying to do. Our traffic will be
> redirected anyway, to a cpumap for load balancing. We tried to keep the
> RX metadata across the redirect autonomously in [2], but this has been
> strongly opposed so far [5][6].
>
> [2] https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.co=
m/
> [5] https://lore.kernel.org/all/20261117161856.6f6c2ce9@kernel.org/
> [6] https://lore.kernel.org/all/20250716142015.0b309c71@kernel.org/

The thing is once you start making modifications to the frame all that
metadata should probably be thrown out anyway since none of it is
really valid. I would probably treat it like we would a namespace
leak. I get that you want things like the RSS hash to provide some
entropy but it is basically just snooping into fields that you
wouldn't want getting passed on anyway like details about the outer
headers. Same thing for CHECKSUM_UNNECESSARY. It was making
assumptions about the frame that you likely changed, as a result you
can't really trust the flag when it is provided.

If anything, the path you are taking now with disabling
CHECKSUM_COMPLETE is the opposite direction of how I would probably go
about this. If you are wanting something that is more universal
focusing more on CHECKSUM_COMPLETE would more than likely be the way
to go as it doesn't care about what the outer or inner protocols are
and the math is pretty lightweight as you only have to fold in the
header checksums as you modify them and don't have to mess with the
entire frame. Your modified frame could return whatever the value is
that you want to pass out to indicate that it is modified, and you
would then be able to just pass the checksum modification out as part
of the metadata in some expected format that the drivers could then
process.

By disabling it you are basically forcing yourself into a
vendor/protocol lock in as you can only get checksum info on the
packet types the hardware supports. The issue is that
CHECKSUM_UNNECESSARY doesn't convert well to anything once you strip
the header. That is why back in the day we had strongly encouraged
people to use non-zero UDP checksum on their tunnels and had added the
ability to convert the CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE when
decapsulating generic UDP tunnels. With that we could support most
NICs instead of the 2 or 3 that supported all the new tunnel types
that were coming out that then had to parse all the way to the inner
headers.
