Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626746;
	b=OZ3gCggQHqkNZrREVnjpcOsqgisZj4of2yly46nHcJYtaPKGsjv0/ZFV8uw76fkpg576
	 ZWB+oQH50V3UFmLgtaMj5OoqVqt7JhopiDZQw6nI64xxk2YoEckUs5vEZ8cwxCQ/LXkYB
	 F8SfSDfaLTe6K7TWc/X/ZvNVvEcJJoOpwf6LHnzyOVxgudxla/M4EUmQ5PqXeN7kup0u8
	 qpu1+fHqaHZ7mRSof0ae8plz0PzXU+SdMoub7Ys2DH8I12irYsiFCmNaN/ejbWskxxPpO
	 rVfgsoWahTTGPCV20d36RMm8MJGdL/E80LL+vFPjZd2Xep23cqVTsp/6dtNgylsE6Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0ECBJQL8Vh8RvECNcJ1CF1oSG2EUEVKrzykxBdK9hDQ=;
	b=IRrYV7ZciexuyfYm+m0qjS5j7Gpld1LIDhXvT4/449wRO4U5naA0eOPqcQqp6vz6Ogm7
	 XLUTUrGi+r1mqtHde7gQHCQnbVbHI7mpo/q/tg+w+wMCrGe57qvks3HHMrJznhzwRd6QS
	 YdpH7x2sMRwot7+vTMWjP6UCk8MiGkR49sYRnz04usWthZk2OHY4XNmlazaox5MFEDJM1
	 QEwJy5ZMjUgr6jThgumJ4t+wfM8ejj7kyqQeZeA877LpCdua9ZSxH847fdquGl4IEw8zF
	 miLatoTy2XoZBEExNztBIJkWwptBqoi0JmD5nUjICKzSWFiQOn4vzFaXtfK3oaBzDKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocD9F2gJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8F606A336
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92E8F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocD9F2gJ
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e46e449e8so3910144f8f.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 09:12:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795626745; cv=none;
        d=google.com; s=arc-20260327;
        b=O0riR9a5jCKud8f3evz0bh/s8EY479Y8ZMHmDkK3u6TeFezjkF00CT+BoO27+z1apO
         8T+JfUD3qRcgT3MOk5KPO0UBTN9BLGBiIZE8tlICEKLXFoPFJ1GYiS4jDB+hgYioxqUr
         iXSWkfROedcPdce5MEmEHk3oeoicZGBuFU579mVa8iA6mQpAof/M2S9U+vOvWcNC28uD
         6OawYYdVUavwsLXx+e2KHXzYwxQzI9GfI+bMBnweHVdDIKzqgJK+FV1hNx9D1s0IWs4a
         9aweE80IGsLqtN4WEGlyGXCfEPosX9uaCB/LdY/tPU8tGwEB+7lVHACbG08QJBp22cSf
         1feg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0ECBJQL8Vh8RvECNcJ1CF1oSG2EUEVKrzykxBdK9hDQ=;
        fh=JLJYAhMhy/k7hVXtXu3F22uxhX+vJXdnz9irKU+pADA=;
        b=kzujTC7wrC6t/OO8hFCbn12rm25aI0txO6as48o24ldrt58uZHeLBgqKsIqa2wZOQ3
         r4Gkog5KDqCUUOHrVVeM2qStNrwgEOsanzXSwn/Ik7TwFQ+ytPPJsPBK3quv7kHNwtAh
         wI2yOqDd1+Xcq6xcSOmih8fBu1wYsytmu65qhXyZHw8QSH5S35ncHGTe1omTihKfDlHj
         ivp28RldY3B4KPhjF9sbmceX4qFItYzl/oFNVXx/n4bTZsh4F1GRTYhN62S+iVzyB/ff
         AnGbR4blkEyDROmaGI/5Zke2bvZg0mKq5diHaXPdJJv4nAx7RI+sIMm2GQuFiNkEa81G
         U8Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795626745; x=1796231545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0ECBJQL8Vh8RvECNcJ1CF1oSG2EUEVKrzykxBdK9hDQ=;
        b=ocD9F2gJExhP/avZYYow/WKZcW4dOuBQ5OB7sGKTiIY0aS0B0iMchUncy0j77h9QT3
         NREg1SFg0iIeoo0Ld5T4UztbybK0HHpzowc/J3jwfPYWcKESNbmEFMmI4y3umUuENFKr
         8aK1yrPkvz6uFRinHiCjwF0ZViSsHdSrPJHoLAhUGbf2Dwnz0A3Eeocc25PSrjImogHZ
         rM7gWQLdW7AQUF1EdQJ1SRrnHvyvDUor0SdLZdI03TM901abQt+7c5tb/q57OZI/nwRj
         /DlIwOf+lB3OSoAm3YvAmXlZKR3GkdSY5kA3UUD9mQvbTdHzAm3w23KVz/nsemyycuko
         BDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626745; x=1796231545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ECBJQL8Vh8RvECNcJ1CF1oSG2EUEVKrzykxBdK9hDQ=;
        b=IEV/f1GTb9FPUg62kzcGPuVYQCxX7ZsiqIaufQE9bMxDhAtHOysWymrakDyjzdiVwp
         R+sqznX1NSuX/TGRW159PDX6U4Q/Oy68owTz5/t92/Hx/SH+8DdKkgm0CUuLjm3YHg1K
         HZ9P+Wrywuw8ZJFuZH6cchrdZC/DTwPmQwmluE7S16o4rdJSg/slb9SCQEJLVwKET0ry
         lG59dkGIxqi4rzfILYkwUxYw1Hl+XEuhNmRFkM/iuD2Ag+wlqLgOaqfgrfvjJBnCQRKI
         1LdB8ldGHh6f7N+pCY/T8/fnv8jP8oIIy4PA5kp5vu8u2ABdub0AOh6vxIFjcbb73XMt
         Tkmg==
X-Forwarded-Encrypted: i=1; AL+hErGHjjST7Nzp14SXrn7tcPg5SF5L71lvwa6VgBW5mqpsa6SCHwzgonAILkCbZa7tqtiHP/s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9f+c/AmsI0WHn8iBa3MmbBD2KeXElP0rA3GrVqNe99FZX4U3Dz
	FIYEg6Bug3SFmap8wOxljS6s6dGk8dzNaaF4O4jj3dfIRqIcs9zyCSXmYhoACdB1z21w0A44MUe
	Mv/d8qlixgv4qGm/8ZBqQcJeQt/HIgVw=
X-Gm-Gg: AZFdTZd34GZnHI5sNdkUAYhfSM0yPH/4PWI5c1+q4faVMsGzjQGe8L0P13aCsbvJ3GY
	6T02i94flK8h82jQ1OZcD5ztFGxcMu41DpLzvoNB2xkl6E4jTWC3RNCbhiy0l8qvWzvvtuhqgcu
	xlI6kJP5XJolpOKPKXgxca1vRG2gWs8plVq68tQDiHAeS/bMvmrRbagHJdRpivxa1Cyke8baWSs
	meAM/ZWeKWV7X7O0ndgSg1YrJfVSgBtIWCCtcnBUB3SH6SKCD0F3LJCKxfyX+Xrp6ZbV4jqN8WL
	5oufjWH4RSQl268JZfHOrHHF/BhIOLeAF5KQuUvQM74D6VdmxJUlouYkrIrbj08WdIc2xnMfXMw
	Ik9t9jqTPJ6i5irfrap+XvwX3+100KxpqhkF6bVDduNFxAa77UXai1GRMMJ1RRDyxBtB2O7PoiU
	/FrKf7ulVM9ngCr4duZtU/2RTEipEN5b7xfE+mrmcqIPBnQAOwH2hvmuDtMAOAMA2f9PyBgTWtY
	q8=
X-Received: by 2002:a05:6000:22c2:b0:4ad:5e91:8fcb with SMTP id
 ffacd0b85a97d-4ad5e918ff5mr40436095f8f.25.1795626744643; Wed, 25 Nov 2026
 09:12:24 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125095201.98279-1-tianyi@cloudflare.com>
In-Reply-To: <20261125095201.98279-1-tianyi@cloudflare.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 25 Nov 2026 09:11:48 -0800
X-Gm-Features: Aa3M54q8-DxDcUDtWvuQUs-FdItJ_4u0pWoknbY5prhGbfAwCOiyuV9WM_nf0wM
Message-ID: <CAKgT0UcvdZgtNtURJGPqAJ3dPGnCpa1DbpX_KBbEmoK==WXNSg@mail.gmail.com>
Subject: Re: [PATCH net v2] ice: do not report CHECKSUM_COMPLETE when an XDP
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
	Lorenzo Bianconi <lorenzo@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, tianyi.gao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 1:52=E2=80=AFAM Tianyi Gao <tianyi@cloudflare.com> =
wrote:
>
> On E830, ice reports CHECKSUM_COMPLETE with the generic checksum (GCS)
> that the hardware computes over the received frame. If an XDP program
> changes the packet and returns XDP_PASS, that checksum no longer
> matches. The stack then checks the packet again in software and calls
> netdev_rx_csum_fault().
>
> On Cloudflare servers, an XDP load balancer removes the encapsulation
> of the packets that it accepts locally. Our production traffic hits
> netdev_rx_csum_fault() all the time.

Thank you for addressing my comments. My biggest concern as this point
is still this opens up potential holes for exploitation. While it
doesn't appear to directly enable an exploit it is one of those things
that can be stacked to allow for someone to take advantage of things.
I would rank it up there with the e1000e jumbo frames packet
truncation issue/fix from back in the day
(CVE-2009-4536/CVE-2009-1385).

I will give this my "Reviewed-by" as there is some level of XDP-based
shooting yourself in the foot required to trigger this. However, that
said my suggestion would be to be very careful stripping headers like
this as it could lead to future exploits.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
