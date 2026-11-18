Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032996;
	b=RNttd9hiQ2Z+My/YZfgQVU2W4AUGrxy40FfObjUg0EnZ9QLHxeCbuL8EAib0Rnkv0CTk
	 2dBPiuEHwjZV975S7vIIig6Vw/UnowMildA7VETFJapI/tnRkb9bkS7yNcmupFoI2R4xc
	 MsL5twqvlXbvivQR831ZfQQn7lVy9euUvNbVB8Mr05HJcnl8BXUu5YDsnURlxazxB2WB4
	 sTZoRIZ29oxD8Do2gknXrN1gCIVVycUCI7nNt0OVjhEgthGvsdn3T5rbrCjPXfmYfOjoy
	 te4ww2OsdsQZ8YPbpf3yMUrdXL3L6IkzLw2xdL4GX3kaN3v2OmemUs+pxyIl7GHsqnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7BbG6Ibh3KVMcdt0G6qbp+g1C+02LBnBwZSTdZVSGeQ=;
	b=k4mDPeduRZGkAcYcGr45qXjUM9TyDrhFd0SLBfWNmuyb3LChcIJtzsSESqVOK2s1A1O1
	 hym7y1NYWBmYqLIBb0REu/e0mTqm5JqGGJGm+XK3mhBiTiczpn9Y0BCQ3TfDzCyba2Gq2
	 IPbAz3QIQTncaLjkaHCwiG4G+Ntwwy3JVOZRULVXFzZ/9utw3/gYZqqRSMssmmUuz8o5j
	 Mk+Y8WuqyH5cRfQpv1zwkMfNxiy0E283dTYeLmV14WMGEZse2pVoczhUUtvykR4ARKf6P
	 +9IY0Z16Gq7gdsgf0ID1lTLl+/LPupppE6PZkyLrMwWyzBWW2EGRlvWA8i4xkG+VTBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9OAzbGm;
	arc=none smtp.remote-ip=209.85.222.72
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A0606A32F
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 20:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 168A0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9OAzbGm
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-99c47fe8cacso1031100241.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 12:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795032995; x=1795637795; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7BbG6Ibh3KVMcdt0G6qbp+g1C+02LBnBwZSTdZVSGeQ=;
        b=Y9OAzbGm6kYJALJzjtZ05ZvviapuwbRA2eVXG9xEOzdMK987x+7hSsEHqwQVuCIutS
         e556beZWHU5xfLOYt3j8Ne0HwFTB4Afoz5gzgrmwd02Kh+evM7nRzJUNETZKD+54eZvQ
         krEGNSgdZBzxmXN5YmF24HT1azeHV6CAu+tcyEQwBjTYtPkfewUoVJZ+O8mpIc2V2AWw
         /JMyBBvxrA/v20EVokYkXHQ5JU0CphOLaul7I4AF16m9jvMrTYV8a48BcA+4Uzjy3Q3x
         o9g9kuf2KIM/1n8QiY1Rdzrt84dwJkxs/hcum5A26XOjIjnRdlXlw6MnHzcdxwIpCPnj
         xzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032995; x=1795637795;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7BbG6Ibh3KVMcdt0G6qbp+g1C+02LBnBwZSTdZVSGeQ=;
        b=E67JquqPQvGcXCVdFN65omN+VDZmgP5XyW5WI7GXnUE1Hb0owCH6eRYUNIB/yZ/HGV
         mVOi1rzxjwRQ+7FZdc2UnFUsoTFb2CpDZfEvd0GcGw6mPhcO2ZATY0PacguesrcXexSP
         fmftVRny4xeIJ/oytU+uZESUtzZrmaEce02m9b5iXljmIXJQVjoP7siI39aQ/1tp7SSp
         ocVdyQ3pymb2oMPmI9Zx2G76g1TKC6EbaFxqhBD4j1LandUwloe2HrImgQPTZqYIIr0p
         6kQVrO4dttROuhf2S+9fSwC3LoE89skqAiJ2bj6g4XTuByBlTDyHsooQl83X1n7D03Y+
         NbzA==
X-Forwarded-Encrypted: i=1; AL+hErGlE9Kfof2bCTTjBOiFTqGCL/VbiYmyeqeAPflERq5Hgkf2sW0lceeil9x7hQ4XhByyz1g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9s0b3rcMXDWQHfRkUp5rI/Md0tvkgdkkLbi7j159l60WpDpkyk
	FJJQGDHuDBEZVWW2DAtORHe2x2axXcyTHktpbhCWctFAfQkMfmYW8VM02qnrg8rGE4RXORdMeY5
	60jqb3QINMydakFdxir4i3fvCkw==
X-Received: from vsbbd17.prod.google.com ([2002:a05:6102:1571:b0:7c3:3c65:bb6d])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:149d:b0:7cc:1045:604 with SMTP id ada2fe7eead31-7d6ba4ca641mr1483449137.30.1795032994710;
 Wed, 18 Nov 2026 12:16:34 -0800 (PST)
Date: Wed, 18 Nov 2026 20:16:32 +0000
In-Reply-To: <sashiko-outbox-220941@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117124710.1338951-1-thaisonphan@google.com>
 <20261117124710.1338951-3-thaisonphan@google.com> <sashiko-outbox-220941@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261118201632.2447530-1-thaisonphan@google.com>
Subject: Re: [PATCH net v3 2/2] tcp: accecn: initialize AccECN fields in
 syncookie path
From: Thaison Phan <thaisonphan@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Thaison Phan <thaisonphan@google.com>, sashiko-bot@kernel.org, 
	Eric Dumazet <edumazet@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ij@kernel.org>, Olivier Tilmans <olivier.tilmans@nokia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, Stan Iliev <stani@google.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 18, 2026 at 12:47:28PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Does the syncookie path leave tp->saw_accecn_opt stuck at
> TCP_ACCECN_OPT_NOT_SEEN when the peer includes an AccECN option on the
> third ACK?
>
> In the normal SYN-RECV path, tcp_check_req() calls tcp_accecn_option_init()
> on the third ACK to update treq->saw_accecn_opt and treq->accecn_fail_mode
> before tcp_ecn_openreq_child() copies them to the child socket.  The
> syncookie path bypasses tcp_check_req(), and when tcp_child_process() later
> runs tcp_rcv_state_process() -> tcp_ack() on that third ACK, neither
> FLAG_FORWARD_PROGRESS nor FLAG_TS_PROGRESS is set, so
> __tcp_accecn_process() returns before calling tcp_accecn_process_option().

Agreed, this is a valid observation, though it is pre-existing missing
functionality in syncookie AccECN option handling rather than something
introduced by this patch. Per Eric's guidance on v2 [1], we will leave 3rd
ACK AccECN option initialization for a separate follow-up patch rather than
growing this fix series.

Marking v3 as changes-requested as I am sending v4 to guard the syn_ect_snt
update with !req->syncookie for the BPF custom syncookie path.

[1] https://lore.kernel.org/netdev/CAL4Wiir50_Z+m00GyU9BpRdAqgXs8V-L0S8kmmES=JiYyt==gg@mail.gmail.com/

pw-bot: cr
