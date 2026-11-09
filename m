Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248893;
	b=kFL9qAGVXO5xRB+7Z21QoeNBhFd3JKCaCcYjCY479XQNXXni31lX0BaiFNXdZsdyABm6
	 QX/Yg3yRyVHqTe8G6at8gO3T14Z0MNsnUhjGuMlD2B78lzWvUzJz84al5DORRSNTAd1s4
	 IcwvtknZ4KEf8A8wCFEltC1/pcrctbxVn48G9Ee8iYMf5cnacSiNwF48yU7WblAk0iZzs
	 PuxYOWchxPnDZPd2el+enleWvQffs4orTgWXt5hcBl8fuS+SDgxgU9nxw2nYowf/pRdhh
	 5BwoPz8ORjaZLHqR8A9J3iHHW/eCEy63cuQK9LLcbj/Idn3mG6Qk7ARSMU2JPE6HWrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=NACPSyw1YEcSH2IAB9Wwd7Vm1dNQu1NVn53ce1z7x0E=;
	b=QXYJ5k1130mv5AExsx3tVDPzNhSL3SebuhG+ibl206YY5axncqF5HlgOcXL1Pkoh380R
	 xh2C/LBjuyf3myHslFLZHG8r9/QjQCG4dLYCIGYWUg9XvMQpRCLCirN2NC1XcG0WeRdPI
	 IHUk9u8EFZ517VPm04kw3Y14O5dYWXdDfHhGSUFpxjBwLqXtTBbLQLxTZRtPQuwmPAKGT
	 xlQj6cVKjBNd5zvhEH73OGTj5HdwVvYtJnc4+nBclFueCizHapgagHb44+LXYQ07JONhG
	 aXtf1HXSLLHZOjTueqJNTjOSnFiahRjCcvRnfvBObuZbwYFlug9DiM5zIXpaP2ppyhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIxKDl2P;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634D60A262A
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C634D60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIxKDl2P
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so463319a12.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794248892; x=1794853692; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NACPSyw1YEcSH2IAB9Wwd7Vm1dNQu1NVn53ce1z7x0E=;
        b=WIxKDl2PWWvYHDm7GZNdMtGp2IwAi++Mlt4NjZVdksFBSHfw0bmtD9y6jtW7MR9Qqg
         YurJsA8IfYzAPYSpyoguPmxqzXViAHRj1XjK+yMX3Y3la8fb7qyK9armND+CuLqwBO9o
         QnlfWLNgc+nmVv14Kf4O4V4SSmHEUu+f/XYou6Wwu2bq+XvvwMeO4r/RqqtPhxNTwXlP
         9fytmkIqyf2EpWwrM5kNkvOJhrQqLHxbB7sRWjwnie2MEY3OjGlA0YEjU1/sKi5QCqak
         ilAR3Afwocnc5WItnpfPvf3R5AzHSAIObz5taRUpw5fyre4R89xUaO3YCnRRg/uUlCRV
         9IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248892; x=1794853692;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NACPSyw1YEcSH2IAB9Wwd7Vm1dNQu1NVn53ce1z7x0E=;
        b=NT3m9l+hmAKRDLtdinviQoT+IsnY+KCiggOGRgLbo9sxztW4FvSsAFOQvachGr/RXD
         EFhOCOGuBkVJRQ1S4ujIYjLMohqn/GwNe6n+aQ1ZHqmt8fg6HxZLavuiYTUAUWkuqJTy
         ptWIB1rPpVUXq1tuxGR/Q/drZqMn2kGLagyGlvng7nktusGAdFgGtjV0AP3JRXpSTuup
         q4wpIZ+GTimXaGJY7oALKneivyXjDBRu7z1O0btrY3CsokCYoyCBQWeiF5qfEKT46lc2
         ZF1xoDk1U0ULBiE2IGuYQCO2Zl0lOyWL/JjTIJoH5jsjjP10bkUj88s786im2t2S2bLt
         Ox9w==
X-Forwarded-Encrypted: i=1; AL+hErEUSsEEEfKNEkeVi5WzLM4o+5n0gvWFYN1BWcOaAHzo8GS4cHdZ33ObGj1RZV73gGIx8Z8=@vger.kernel.org
X-Gm-Message-State: APuU4Z82+ZmWBDCEgWVan6Ieuq/elu2ZZZCofct12FPZWt3mE+glocxs
	InS5/bU50sSCIjBqcQITIzc5X0dJUOmiWxm6RbTN+MdYXfmNvHY4s2Kw
X-Gm-Gg: AYBFou0J7EdMNsK65t7aNCnKrQBx3TQm1IJ9fLswv2FB/9LLJtM0flK1PPAAMY4ssjr
	Xxh2oOpsKJHu+gCUFLVRAGkbbyPZJrh/TlcVU01K4G6K21jgAgi4FMR5LU0dOEelI5Kl96IYpsy
	S7C3fiI8iDPO5fjurttjdbWS2PDhOK/0UnxM7IozPURGrLEAiZg+g9x+g6YUcBgLA4GhkSE5djO
	0SlzD75ixQaxSTTMrpXy3KMgHp0qMWWbq1lEp7Ru2x7x1+oRRpg2lvoG9gtfABGgWNyZKWPPppZ
	Zjob3l69Jrhxb2r/8B48/qH7psHNeXO8Hf7BjxC6QB44H1zaiSkW2DeXPTPqaVKrARfJTMnI4ZJ
	L0kKz0LM6S8nw41fvi6En3Zh+f60NwNbfXREnoyn7dCUqo1Jf1qaEOojsh/XK/kfrTLJkCheCEK
	ooDQGeVhDZMsb8BIVS9uU25REB7e1VAeKIcouElnf8FOUO3byGymo7iu5lm9YEMRMhvLH3eFuk9
	4XbWLsMC0ugZINi7a0QWWP5ruVPHJrQTsEc5vkecX0N44+QSCbG/kzW8lcZIB+/wxcpqxslDbfX
	MY5JNOlS8vjqjSO0GdEHqURzO/Xsmvaol2oyYW+y6L75LXsHlfpy0auNRrY18YL+qlydveEDJgH
	uMbSi8UYj6cZCjD1RmYkDaIJkuAmAUOjNOQ==
X-Received: by 2002:a17:90a:d444:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3b166e3ebbemr416091a91.67.1794248891799;
        Mon, 09 Nov 2026 10:28:11 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16769c195sm505135a91.3.2026.11.09.10.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 10:28:10 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 18:28:10 +0000
Message-Id: <DMQW5CZKKR8Q.2ASEAH53BMYV9@gmail.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <void@manifault.com>, <vega@nebusec.ai>,
 <rakukuip@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Reject user ringbuf backlogs larger than
 total ring size
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ren Wei" <weir@nebusec.ai>, <bpf@vger.kernel.org>
In-Reply-To: <ecf1a73cac8881d58b0b5957fb72caaeaa055339.1793951856.git.rakukuip@gmail.com>
References: <cover.1793951856.git.rakukuip@gmail.com> <ecf1a73cac8881d58b0b5957fb72caaeaa055339.1793951856.git.rakukuip@gmail.com>
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

On Sun, Nov 08, 2026 at 07:03 PM Ren Wei <weir@nebusec.ai> wrote:
> When bpf_user_ringbuf_drain() drains the ring buffer, cons_pos wraps
> around the physical buffer repeatedly within the oversized unread window,
> replaying stale or already-consumed samples without new writes from user
> space. In the worst case, this leads to excessive CPU consumption and
> watchdog softlockups.

No.
Stop the slop

pw-bot: cr
