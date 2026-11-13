Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544439;
	b=z1hTcqC3ZiDb/LmMxw3jOSK8/jMt+Oj8eCPNkdPYZ0iQrsXILLtiFUILF+LO8UzoEcJz
	 AmOvrL5cfgsZQd5MbsBTi8Cemo03jaXP4UEtwaz8asVwi2i7qytCHXNmbyPHRegxinrXw
	 1oiUhm4ItgHLT9MdjnypRs9pYQabqFKzMxc7pXPi2TboOYzAQTgiH+utsjrQnL7n/XcxO
	 81GEt11kLu/8pzZsp0yhYtGb/0/0JygGIAuR/xMJvQLsF6KQSnx/ROj06Fgo0Imb5cZD9
	 dc0+Z6MUOFwvkBVwhV7iy92jFznbWaLlRB1m7YsToz9lD0sdMkyddv52dEoxpt13ACg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=aPxT5oD/vbUSmdWDmpwYPafMdbhb+bVNm7XNt+G51Xg=;
	b=Zr+1mwl3KkBLI2X3HdrM3H2phUCpB5QgUwu4IkpvWB5vV26jD+cecqLO9Y+mLgXFyfw3
	 QoATiJ5zIJduwSUDAbfGPbp+a4k8wn6rimFmo0QmAhwewoKl+xTguw7645jHBkRi766xU
	 HN6zTCmZk8l0GLAgrQHow+5RTCQrhBoPFSSLRnbtR4QoNiYXk2croHv9VRTFEl12vLkEi
	 9mIDlMLJumOZPxIofVIbncXrkv/48oFv/9sU608z6otVE42wHcdx0Az8hU9IUDEep1Jjf
	 91VbNmHtscGMR1+RGgaJYrRXGhQ8Ig90sXoW6x4LLyDw9qXEmoSARv0LbPWOCsvA2OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHMJ+F4s;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4E606A321
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 04:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DE4E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHMJ+F4s
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b600fae14dso305072b3a.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794544438; x=1795149238; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aPxT5oD/vbUSmdWDmpwYPafMdbhb+bVNm7XNt+G51Xg=;
        b=qHMJ+F4sRb19CQTTcwA/cen4WjSrhQUjM5h5lcW+Iv1Z/tojW9aBcQFP0IemRR3Pm8
         OF/hgCec+3oO9yuExs+lxxcD7bf0FieftLokddY9B41R9SrHT50qJ3Wcwtf0kX5PFxgc
         8/OI6odne/AlQ/mSWxuPOOHPZ/Pv8RhXsfqZFnLpBiXc0RVS+BJ6W3o7LHdlnmhyy+8j
         +/jiJJsJdt7BD7CFqvvJu+1xUgYIKl5hWkAb5rwBU4OW2BCryGBjMRWrpBaE1czKB3Fx
         HjwikaVHBredEePeW/KjhaGZJTpcoBhzpcUIXsEuokliDLIcd4x9itZz2aiBC6MWQ0dl
         u6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794544438; x=1795149238;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPxT5oD/vbUSmdWDmpwYPafMdbhb+bVNm7XNt+G51Xg=;
        b=PleygE8Wfl3qTTRyvzmuR63GJO++4HmwRGAHG6zzfUu+8m/w4fCGRNX064tXkRfUTz
         lGZ0vzidvF+fPwMZrBpzUGg1EGrC9dymAyfu5I9gImgR/2J2pGyXpui+9znmRs02o0lc
         PqtXUomHxF5l+AXicfE3rud6pKzAZyP0RVIXXbbX/mFndQDE24d/1Xez1+iOjabOf5Tc
         7Qw/os8FkdQBUG+9W4e3T5eR+6rtGNTGWDEiaIMTnd6ilPyJ7QFIO1TETAyJUXpUit39
         n6mCtYbCjE8rNo6inL22l2LTKIWukiAAy6YzUkWOZbyELr5cwFpH6BbwajfvYGW3MDxT
         v1AQ==
X-Forwarded-Encrypted: i=1; AL+hErEs/acWWHm/mbY7Bn9Eksf59x0TXVYn6Syj4JixgcE1LnqGGT455pyoZi50ZWf2bUa0tok=@vger.kernel.org
X-Gm-Message-State: APuU4Z98+q3LsiunBTH8m7fSnGMuOz5FYBmKhwOQRmDJMhVK9oExtBCs
	GAVGmfmqYKFM46HQomYf3cHgDq0ni4PBjvtFsYMjq4ATCqm15bgIvdwm
X-Gm-Gg: AYBFou24nbHNr5fg90l/7Zj8+WjafptSj5dsfwSLPWMBK48P3AAhMEIZIkFYlhMMZaq
	aeTXeIeYUIsTjO+vcyDjpB0dzlN496LiXOt+hZB350VAbuxvHgmIK8m/kHn01BnnYrJmeNAWuPJ
	4oevPWqXTdaIaf6uOHlojVlRxCKEwniHgzFCavZH21VzI23oE7LZiNXkKTUTo+n3oXyd+eXh4HJ
	PQnR1UvOTxMkYhzbJNEZpKxlR0SduGr1/kMseWe3PGp4kQL8snGYRi81dF0I3Y6baJEMe+ZmV3k
	Zki10PQ1hgxvbOfeFhMhic82xntYdZTwx2TYr1HhlBpnnOkko67WawtHR8GpXXg/Gf75z1SBAMK
	EFk+7JCNTH2w4q9H+8LnyQhIYsz9E4Zy3EO2Su2eyRFS2qUO5ksKWhWfc1ecXCn8IG9OIPad4mH
	1KUAx4detdzVjZ35jAjpuElXRaFvyRy3NgqX9ea5smxcyE+ECjNhP+LfYymg2/PcG/UjPJT/Rr4
	GhqH8iT+4dbr180UYDQ/xIAyR34rba6r6GamYujOrrv5xPXJdeaAO1YMi7khZwZiLYmJ1+XtD/T
	eHL5Uh85s7lWcH3XqDly8E/Xa52nYCkppaM2rEUrR8lMkOoZgQIuO9lbm30FQIPkUmg4Shnsz0M
	dMDtfrBJFvz2bPx/eGHlZ+TlKRt+Rf/1sLe0=
X-Received: by 2002:a05:6a00:340f:b0:874:705d:f64e with SMTP id d2e1a72fcca58-8beb6199b3dmr1224059b3a.28.1794544438305;
        Thu, 12 Nov 2026 20:33:58 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6db9asm428290b3a.22.2026.11.12.20.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 20:33:57 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 04:33:57 +0000
Message-Id: <DMTSWTHS6PIL.36XSJNJDKSKDA@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, <netdev@vger.kernel.org>, "Nick Hudson"
 <nhudson@akamai.com>, "Felix Fietkau" <nbd@nbd.name>
Subject: Re: [RFC bpf-next v3 2/3] bpf: Add PPPoE encap/decap kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "ThisSeanZhang" <thisseanzhang@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261111032141.525444-3-thisseanzhang@gmail.com>
References: <20261111032141.525444-1-thisseanzhang@gmail.com> <20261111032141.525444-3-thisseanzhang@gmail.com>
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

On Tue, Nov 10, 2026 at 07:21 PM ThisSeanZhang <thisseanzhang@gmail.com> wrote:
> Previously, a TC program could add or remove the header bytes
> manually, but the skb would keep a stale skb->protocol: forwarded GSO
> packets larger than the PPPoE MTU could not reach the PPPoE
> segmentation path registered for ETH_P_PPP_SES and could be dropped.
> bpf_skb_adjust_room() cannot be used for the decapsulation direction
> either, because it only accepts ETH_P_IP or ETH_P_IPV6 in
> skb->protocol.

Sorry, it is still a no go.
It works today without new kfuncs.

Encap: bpf_redirect() to the ppp device. It has no TSO, so
validate_xmit_skb() segments the GSO skb as plain IP.
pppoe_xmit() adds the header to every segment.

Decap: XDP removes the 8 bytes with bpf_xdp_adjust_head() before the skb
exists. The skb is plain IP and GRO handles it like any IP packet.

A prog that adds the header itself can update skb->protocol too.
__skb_vlan_pop() takes it from the packet. Not tested:

	bpf_skb_adjust_room(skb, 8, BPF_ADJ_ROOM_MAC, 0);
	/* write the PPPoE header and h_proto = ETH_P_PPP_SES */
	bpf_skb_vlan_push(skb, bpf_htons(ETH_P_8021Q), 0);
	bpf_skb_vlan_push(skb, bpf_htons(ETH_P_8021Q), 0);
	bpf_skb_vlan_pop(skb);
	bpf_skb_vlan_pop(skb);
	/* skb->protocol == ETH_P_PPP_SES */

I think you said earlier that it cannot. Prove me wrong.

pw-bot: cr
