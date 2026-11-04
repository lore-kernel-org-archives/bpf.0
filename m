Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752190;
	b=5qpwbfkTrl4L6y+rrik49Ra90r8dHxKg8lB7XpawvJt/V68weRP4MibeErxgiwTg2VOg
	 aFoA53CP1M6ZbCqonFYZ44ErHLgrLMAWWnJh1MZYpdto3jLm0iHa/UkOizI9quw6kxrgp
	 M1JXBUIDbzEa76HBdxsuz2ytMVIBSWH7BFdVYf4BLFt0FNA1CzlgTuobVs2b1ASoSqWyG
	 /lFzZ/+2+zOYoz8dLi3e8NjOaZA76W8CIG2TlVxezvQBZGI7lWTUZ25MIagWMzu83BqWt
	 qQ+1H5ok/mScKK1TdqOLamK9R32gGwu5hs70yCEFkFIos2MaPefuMJnRUUIy49dLIKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gLFQSHxO4gGr22ybqjiMEW9byafCmVvekiJO/cKrO1Q=;
	b=EgBrnQhLpmJHIpSygkmwBvrRBn7gkobNRXye4/i5zSoFsCumWwbZvhNP5B81to22Ng+F
	 BINlVZBmyb/95CTCfi8bzW8PG5/ezQDXiPjnC0V+fxoTYv8/7+q+1orCQLV8Vf942/34u
	 f8jV1s4ifs1cc+5/GE4qWlQ8MA7CCzUuixZJ/coro8wJ1xxIE/E9iEeCYN7P67flwAcqo
	 ex35CF4Wpr1xS3dBUQVyD1XRkixlqx15UYepE6HT4phQmysbT1bR3FNLDgeXEi6VjNfyv
	 3DWWmo6riwKxLkO5pZ1fBmBKsKeGpvIQseRhPKg/DLsufAZZ7fVdIDu+QZcVfYG4bdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xjX00fYx;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B7D606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09B7D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xjX00fYx
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso68688a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 16:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752189; x=1794356989; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gLFQSHxO4gGr22ybqjiMEW9byafCmVvekiJO/cKrO1Q=;
        b=xjX00fYxVz0C5LjLk+NtFhJOKKqfjNjgWARkozAxE3Xnti9OROsLwpnCuQkHhGg/WA
         V4PLR2qbe+yp82UmUbpn1REbcLOlVUogKhCHbKEulXXIDMrT8XM/MtgEfJlnQ5rJDwQh
         D9NNsz1RoI0NVuIFfpIFlqiLrNiqV+4U8oZc/Nd5M0Z4yiVeGEvyk+5lHeuU1f/jr3Fd
         7g1F6H5/YS1dkgcmfOKrEwzwhdBuRgOZjfI3r7ozz3BZp3Ts78ePkvLoCfIDCIC0iAqp
         6LH/xd/KrpDWT7oE9VrL1rnd0EeEQvZ/RynACvOC1G9VFtptzPCZK+I+FGxP9hkhKsSx
         EGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752189; x=1794356989;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gLFQSHxO4gGr22ybqjiMEW9byafCmVvekiJO/cKrO1Q=;
        b=HUhai31ejj95xlEhNvh5Bklg4P07pPetYDiERWcUHMM3ZHBnD/u5H13Iy4At1QhAtl
         wpWokhtk83w3dcA3iR1TJCQLYCMTkJy/fHDbh/DqTMTtepCspWRnoV6Mqfkm9atflGeT
         KZkKNv9SXovX6HO6CaVAJlOtY1a3OoCXRTaQFGjPsJjXY748bOA+YOE3KQU0l+WFvgWo
         uwHbWTOMeR4GzZPOixZuptT6LosQTLQ0E3bV9qneGAjlxov4F7AEIlYdJyqaxi1At20D
         ibMe0J5sEHU8xfchyOEKRw3MdxmdRL3p+LKgvo10dlZyq8wSC87sx2PughrqaL7KO5pV
         wA5A==
X-Gm-Message-State: APuU4Z8YlHNdPWDB7Gm4bBpZ/wlfYvm3/4oqecqeTOHn2CxdBnEXh8oD
	ms8IeSaEJRhoPcLsbxJ01zvhtYnv0ejuj6NmWvSefDCnA5brt/i18r+w
X-Gm-Gg: AYBFou3Z4YE/eQEUNCImKcxqa76gl2hfwvVWL1S2TYfjj2NSHgsloWT/F7siuoIFfhD
	sPU+4bxdYRi7JpJ8SR0GxUUr52W+CRvgMsdP6aJ1Hb+oFv29xhmBXuN4Y4UJW3KhMtWsNdHrQZ6
	qD8tG6pRKLblxbqHrIPa0MjdexZiAxFTUBWLt5NcGRYnQ+3a4+zCYpiSp8iDh1+yIQRAPY1EXb9
	L9QMT5G6E6FvXWGKX/4JrEZBm2gxeZHDHSaJYar+2SDc5zPqzAcFWp0GUAqWFKNFXB+WaB67tEJ
	RLw0uRF9H6ypc5XYUyaEW70oU1Jd4V4t8lJFU3FDXxUY06jYzdNVeMOAxfFOdpcmgJaqfeCmvAY
	czce9EQt9ggNvtY2iRf5epTN/u3j3h4GHMKSxByxTQX0xHkTNlGMxJJpbqVJdNIXjtHRkOA3OTx
	Om4vgfH4LRM8G2iBL0ZHSBqSEuXUk0v6UbO15MEvPjd12MoksERDdHHDOzpXVkB4CXjItF8FpSy
	2RQMowK1NfZAaAXo99nmElMC7t6kF44DwLpeTpmPEqIvHumOXYRTFmgd94ux+A6uUPGiZhrf6ah
	D2Y8KyocvopYIf6n52NrYMEdqScqtmWdoyAnx3iwfOPSbgjF+mBRsgJaqwvOwXKppt1n8A6UwaC
	5f12fArIAS8gNekazpKDH/ekQy2w1bNBYFg==
X-Received: by 2002:a17:90b:2006:b0:3b0:9310:b252 with SMTP id 98e67ed59e1d1-3b09310d1e7mr631008a91.30.1793752189425;
        Tue, 03 Nov 2026 16:29:49 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944ea360sm1208878a91.14.2026.11.03.16.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:29:48 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:29:48 +0000
Message-Id: <DMM02ZEK63KB.3KNTQTKEJD0G3@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 09/15] bpf, sockmap: Check the TCP state in
 recvmsg()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374188255.488855.9131092470801455035@kernel.org>
References: <20261102072112.4160195-10-alexei.starovoitov@gmail.com> <179374188255.488855.9131092470801455035@kernel.org>
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

On Tue, Nov 03, 2026 at 01:38 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
> Would it help to mention this path, and that TCP_LISTEN is covered as
> well, in the commit message?

Not worth a respin.

> Should data that arrived on an earlier connection be kept out of the
> copied_seq update too, and not only out of __tcp_cleanup_rbuf()?

yeah. It's an old bug, not from this patch.
msg->sk == sk says that the data is from this socket. It doesn't say
from which connection.
To hit it the app has to call connect(AF_UNSPEC) and connect() with
unread data on the psock.
