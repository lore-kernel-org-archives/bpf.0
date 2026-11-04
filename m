Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757883;
	b=1eKoeXmbhdrOghBTZZk6u3EAxSS6jYRnSilaw7rSnsPfaQxf31dWSkvF76LeFDFkccHx
	 2THS7UfkpW9b+vqU5MtnOGZWF/7jomnVgJL3UsQsyXb70RLr9I58aTNBixRnrsV2SbCYW
	 blI1RJ1WzAqK8HFnwCV/i8rP7fe5Ems6k1yA/Ywd59s+MZKx8Ng2ML494Y7jRHY8MiT5G
	 2vIHUyRriKsV7gv+xMUkN16SKNxPpkvopJ6i5YPSJv1VMaGp0cil+URSe56kqD45tCFNz
	 6IKm7ezrIODcJ89+BmDTTEnmPz3fP+cnKUuLepN1/9AjxfH5/AT97srVhRn/5h/9vuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=i5DyPuoQ2QtooVZJkj1fmVXJYWMukRTdT9UmVFgbpUc=;
	b=qYDOhwQzKUErU7SnnprdJXQFEqocCTm6I638FPCJzZ0OKgEyHQ35eBT9IX7au6KgdQ1g
	 Wj4pe9WAuGSY8j0qsdtToXzyM5nIVt1SEfqKFI707GdWHN6ZTLo1dX5y1gwuUpY5SYhtR
	 I9WPu2LywFX02XnIxqCn1Kqe2pUnJjzjJu4FCcnL8kytZhBXWqTgtGD2IkoY4xqAfQfvk
	 Tt6EMwhKBBRmcNEUkxPJJFejK5+7VuM0e/g8G0dQzSNbTM6z8x5+LFaHzGcNqouCMaASe
	 HtrQvOMVH/98bjSWJoIwVnO69bY2DM2IHSKJadhd2vAhTJSzZDOQ49Ru70Znjo8hHXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IkMqmVb+;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEEB606A329
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FEEB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IkMqmVb+
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e96502e447so1449695ad.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 18:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793757882; x=1794362682; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i5DyPuoQ2QtooVZJkj1fmVXJYWMukRTdT9UmVFgbpUc=;
        b=IkMqmVb+s7eQXz9CRvobFAuhMp454C/jf+ZIpYugWSUX8QxHFjn8nf5QeJtQO9OSGB
         57QeCNwuigRQgzjCPjjJ4XfQnBiphfCdDiwMjAtOhUdJ17e9VAFRZZSdwbos1/UwYqth
         4tUHXGaJz7XgeC00BldzMMa+mCtV7r46X4WOMOHAMsg3qVMLWzDa9wWTMgYEQNiukexy
         qL+OZcDmCjTVgftVHFtL/axcExcDwglF7mKlVdjYlHk454YgBWJNTQfmGWuPX8Q5XWca
         pmIcTokqfn11vp50ZxY6fpgpvWfYAq46HkTSzIp3HPQt4QtHmNaNp5n1JXmY+bTOhbiW
         dbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793757882; x=1794362682;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5DyPuoQ2QtooVZJkj1fmVXJYWMukRTdT9UmVFgbpUc=;
        b=W13KX781LMmWfFIEL/ibCFenNa0EMwlQf0Xz/T3mUoUczQ9p8nZ36n8ODTWvrNYs5l
         5hpCaAdvogDxDxhHTaXQhTy5e9muRpXIJMZb/W8Pd9V5QZp2xU6iYG3A1TKHjcwjy1ll
         GrhzbqO0QykJPJ4WoHWIUoDpZjccwy6mvHX/mXKyeft+apuhtmfzrGYwxH3LafppDr4h
         h53TJCvi5w8Gwl1z9Mnefld0ZK3rMtmY70Y02I8oyFstclP3LGfDhbTzmboSGZrU6biJ
         cFEREEoYN6CWOs13wLXELMkLF2b9pvuwBqoiJKGH+kh7+UHifMyJ2zQ7onM1XDQzKdQp
         BSNQ==
X-Gm-Message-State: APuU4Z+Eo/X4RPMtY7tfULI5D/OZp3Ifx2c0Cb+/3o1BC+d38zv8c4do
	h3Kb6T9MbIDYZ4xmft/JXvAjU9HbKfxb4Rav4txZXmiQftsOxjGBomID
X-Gm-Gg: AYBFou0HfHMJacMq5BjpfkRoOgC9ayCgRBA06HTFn1m891W5V7NfCNiEUmhS+6ZYfGe
	PODVzyA+rEamSNYFd2g362KTDX0T/7GTVmVAf3BJtK/7W0I43Ny5PTTkOwTZwWuLh8nvc+9ozde
	LRdV/nxlvJ2m4YhtuEF+spu4XamPuN/NVtKNZM/Q6z8A0fIauh4DXpLE65OVm5Ih+3ZJAplyjy+
	H7Jo9xDAokXjosYy+zu2vbmIMYxM748EuLCcgRM15UfIiVkTxbW5SpP0N8g9jiA2hFAiE6P7SvL
	itTjxg9XjwInpx8Oh5VUItW61AlzAkRBWy0sBMwh8sdskKnhmg0+/vaZdV4QJTFTfN22wCsR9pL
	vAUv8t+ejMkPufOfZICXubKk6I1cR5fX+QVlD15fyPRCNdpRoRdpmkzSnYH8PCaPl1TXOJgF4Qj
	TnGijWetqtv8VQ/2o6ANL3q/mQ+/1FGkPWfCunUmtAeHY7yJ2YzL3ulNk9xWIzyju0Mon9o1prH
	sHiMOFHQ7sDYuxrut/5z8DjTeqruBrUhT9zuVQdoDuHixc3sqWubHchMAbHgXJrmCWhzDZTRLiC
	vUykhv1VETKfqU6J7imKTKYH1ODcXDFx+VtclERRw2jiCwn/j4OnLsPEaBYyn1ttpJGLAT0JrGM
	FMPxqQLe4HChRUOczbHxG/kjTO32caUlK8g==
X-Received: by 2002:a17:90b:48d0:b0:3ac:80de:44e8 with SMTP id 98e67ed59e1d1-3ae8983c697mr11675852a91.43.1793757882013;
        Tue, 03 Nov 2026 18:04:42 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944bb7d0sm1356275a91.11.2026.11.03.18.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:04:41 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:04:40 +0000
Message-Id: <DMM23MFOQ7ZL.3P1ZUMR0MKVEM@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <davem@davemloft.net>,
 <edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <kuniyu@google.com>, <willemb@google.com>,
 <matttbe@kernel.org>, <mptcp@lists.linux.dev>, <mason@kernel.org>,
 <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <netdev-bot+sashiko@kernel.org>
In-Reply-To: <4d3b8639-a313-444b-831a-f1f069882b86@linux.dev>
References: <20261102072112.4160195-4-alexei.starovoitov@gmail.com> <179374187706.488855.8366350890804573396@kernel.org> <DMM01WTK5E12.1RIGV9OGW23PZ@gmail.com> <4d3b8639-a313-444b-831a-f1f069882b86@linux.dev>
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

On Tue, Nov 03, 2026 at 05:32 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> The log of patch 13 says that a cork is not safe for two senders.
>> Jiayuan proposed to serialize the senders in the reply to that patch.
>
>
> I will pick up thoes pre-existing issues and organize others reported by sashiko.

Thanks, but make sure to create reproducers for all sashiko findings.
Most of them are wrong.

I'm waiting for netdev maintainers to ack net/core/ bits.
