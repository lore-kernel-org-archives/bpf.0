Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444F348477
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446172; cv=none; b=DhQgBuS//w4KLWnujHNhy2g5clbYXkzkPvltTEY3LmxpDPBNbn3diS6FBIQAuoWPgfwuB9helJiB+Y0KdfUlTldggdQkObY1Hvkav8NMncEffDQvalhXdeHTn4g/G+fbqxE1ICqPCF+ftaTQT9MOeqqRY3qiC/aVupAdGarqm5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446172; c=relaxed/simple;
	bh=uHcXECLSgsppVhP+AhoOZulbAbBN77UIUBU86+28NXw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PfEUsLy315PYZyzQ4qX94M4ylJEjxFex2hTVUD2SZLF8hlsYje9LxbHhxk3POBiRrSG8FcJVGM+oykRw4Fnpa88Pi7H25pABACDgu5T0k7QQVBJlG2sSH2z7ut1GosQo9besrIdP2kdrnJ6z+xenQE2ZQrHmkz2YqISsmAqYt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3VpYOpB; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3VpYOpB"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7927b1620ddso69028157b3.0
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 08:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769446167; x=1770050967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzIM5S1aosasnRgv4fpJy7hXx99GJuvBk4X/AumVJ6E=;
        b=C3VpYOpBYH6j/6Ogy6nYwz33PkgKdn7zoo8DV+MsAPUKDOmRisXtm82KK7zpBFotFd
         KG3HZbVdskGhXmgESjGv3ZEUogwzPyjOLe09etNtZJ5I8ENxG4Ec0XpevpkO8s6eIY23
         Fq6bTrTjdxopBy4riRctLA/JUZn/LDLgm6ZFBGlSFzBLyjwAMr1fropAWpbywCnFobiX
         iYZDQxhrGKe8lXj9io+A/YUJTF2bXqxIlBtuPKe5oOzv7txsBTp4sXpGtj/phpq2Rc2H
         evXJsR49xTGdyULmbJqghynRdYxVPEfMLhE0EwS8/l05HSzQ5WHjvdXNqUsz25vXCCmL
         bhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446167; x=1770050967;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzIM5S1aosasnRgv4fpJy7hXx99GJuvBk4X/AumVJ6E=;
        b=Fa5+0cUNeblAM9eHHQq7hVoilAWlsevFVzv64ukKjW3/WoNal5u0vy61pdC7KWupTe
         l7RvbByJllEOFF5gOxzI3TK6hVUWaqHw73/WArFCV1b6IvR2pJrbcig9Zjz+aRe3odlS
         rnJfP0FHrmP84nCm6gKnD8Y24xFyCVfKsx69ENX7OD9k5CnahwQqiU7ecjgmk9cRY10Q
         U0oBUrs/gaijDFB5R1occ0LTzI9kl5jQQyRPynC8ZchX8nsxEhlJsS0JqIQArhK7Jhi3
         THZlLZKZ0eOqzvqurAJ+5guhnygBAUk8BxxINDnH/U8cSIbk/19Yf9zukJrMzSpszsr2
         U8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh99dvIlIsRxHL/ESS0fg7NSFhmsHpjdg3Yenf6CdPrz0ATAlC+nuHbMs9eQAm6vS53LY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywne8sZLRDyLExSI8sMEE+Ucc2I+q2iP8ubdT47c95H96RYOIMK
	qjwjIdwOjqHY1AZjzdS2ptHJH18jm6Y2KkIqms+w24vE8hb4aGBbhPcx
X-Gm-Gg: AZuq6aLsjq87djP2gJZ4fQWccsOg7oeGwIhIq/zY4wGA1GGOoC15CS5L0zg9dOJUj63
	jOxfa0VJ2q2mBeANF5eJPB0C8QsnZSu/t+/dcqY4TwEXhxd0WyTSYiQvLFlTX6wYXtwo+WghqKO
	kNgER/Gn0fmInnucWTj/6yQIcM6St4ASH08bUFSZ2tdpDhujHt8FADR8jgxfXdAzmYRCq+nRuEL
	dICE4Q+GXNviEWl0HNF44nxKuJhTvCbgFI1+ITbN3Uui1Qi5H6VONIikpKTclmTwgVY3NcrZYut
	2h7z5cNbIOaUX/rNc8z1dC6jaF0BG+7KX0ebAN1zgrWs9C10dvYh3mh6AQqRnmaRCvmzRNEU3jY
	0As/xn6f0Pill1K1wcN5kDSF5eebwiJqOWHNq/q/XJ7zkgvh7pjc8s/ho5cH4q38hsqiLsRTn4D
	isU0L6eS4YrBtJNQPmYAp4QXOSplvTG29eiBrzUNvelaz6G3C7xsM/j0OLxc4=
X-Received: by 2002:a05:690c:6809:b0:794:107f:12b8 with SMTP id 00721157ae682-7945abe5d41mr35771317b3.10.1769446167253;
        Mon, 26 Jan 2026 08:49:27 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943b2b9bfcsm49990507b3.38.2026.01.26.08.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:49:26 -0800 (PST)
Date: Mon, 26 Jan 2026 11:49:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jibin Zhang <jibin.zhang@mediatek.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 steffen.klassert@secunet.com
Cc: wsd_upstream@mediatek.com, 
 Jibin Zhang <jibin.zhang@mediatek.com>
Message-ID: <willemdebruijn.kernel.11a4b80935127@gmail.com>
In-Reply-To: <20260126152114.1211-1-jibin.zhang@mediatek.com>
References: <20260126152114.1211-1-jibin.zhang@mediatek.com>
Subject: Re: [PATCH v4] net: fix segmentation of forwarding fraglist GRO
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

[PATCH net v4]

Jibin Zhang wrote:
> This patch enhances GSO segment handling by properly checking
> the SKB_GSO_DODGY flag for frag_list GSO packets, addressing
> low throughput issues observed when a station accesses IPv4
> servers via hotspots with an IPv6-only upstream interface.
> 
> Specifically, it fixes a bug in GSO segmentation when forwarding
> GRO packets containing a frag_list. The function skb_segment_list
> cannot correctly process GRO skbs that have been converted by XLAT,
> since XLAT only translates the header of the head skb. Consequently,
> skbs in the frag_list may remain untranslated, resulting in protocol
> inconsistencies and reduced throughput.
> 
> To address this, the patch explicitly sets the SKB_GSO_DODGY flag
> for GSO packets in XLAT's IPv4/IPv6 protocol translation helpers
> (bpf_skb_proto_4_to_6 and bpf_skb_proto_6_to_4). This marks GSO
> packets as potentially modified after protocol translation. As a
> result, GSO segmentation will avoid using skb_segment_list and
> instead falls back to skb_segment for packets with the SKB_GSO_DODGY
> flag. This ensures that only safe and fully translated frag_list
> packets are processed by skb_segment_list, resolving protocol
> inconsistencies and improving throughput when forwarding GRO packets
> converted by XLAT.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Cc: stable@vger.kernel.org



