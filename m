Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248713;
	b=KBbUWTZP/cZe212+uNpZvWIkC961KQGaABU6o7OQR5rUYqjaxPrLZnZ2946GazmS8y5g
	 8VQEp9yyV8TLQjVyahJ98WhlbbNcr7oxTlVeR6JBvDB7qubE8Uvs69RbnE6c+C1yOVgz0
	 R02miU+3FlGgF0GyyJqa0pwcLZH+hV0SywJigjcfmk2HcTIfMdtDs9W/TrCWLbcNeMHkk
	 bEcBhfgGQ5V5Zi4Jl2epuiWmHxX/h3Mj0URUEjInl/10CuVpjQoxA1oZaru4OfuLnShBK
	 r3EclDWW+XUuP95HDVm+Elivyz18AfjRjnqktylS/K76rPdQFF16prInIwlxeZUvI0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=y4Cmesc6c6L7Z5O7qy6m8HiVqUJHOjQyHRE0+sJjwZY=;
	b=vBV7te0eY+Xzu4ZB0JU8g79QMLc9TlEOrp0Dt0IFOZwcZ7XsvEphIROsNXjuioGywd0m
	 dXDbq8z5vuElVrMA+GdC6Fu6c3z9V6bgNjWqFsTangurDFHu60QFPC6IEcMvm5DsT4sbJ
	 0qns7JZ1onERy/mF+LAqUXZSWUsKQJB3yoGFOvw16OB/b8bL9r36b4N83gOmPrX1+EiU3
	 RA5vYGbXXDqRe0AcuhJl9bW521ZoL8WGu6wKHHs5Czd3Tqq7z2MXtBH4WRwdSsFxDXcQc
	 U6ufrgaRHeVgVN7rqYsx6Qy3MRB3hfHya8/FB5RwKUcFA+ps0i1wJQ1BlTzbO7lYSdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cy8VJhEL;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6794C606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6794C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cy8VJhEL
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso524037a12.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794248713; x=1794853513; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y4Cmesc6c6L7Z5O7qy6m8HiVqUJHOjQyHRE0+sJjwZY=;
        b=cy8VJhELDsAbY6OD8RSOgHDNr5+Izvp1G1izy3CZX55p1Flzc/yCUo6nJUJJMogsCt
         XbSjh5CEFF87B92J8+MZIPiECD+jrDLQEkIBDSgwXOqNH6ItiDsCLPzdQmQ75pbnuLC3
         7NT//xHO4jSN01rhV/HF3+uEZExPAkSjoC1aycC+CgXftd+WVgu+u/ax9CNGe/8Ow/j4
         +pAyioRuEn1PEA/DzG3reQoKEOfv+NSbqhyNfkE6MaOug2UuS8tqRgUfizBkdplHBZ2B
         aQrGeCHB3dmZixuZg7mr7MLYzx379clAowsVE08SDRFop5JRxQx9REIv4ifKgn2aOwD0
         EwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248713; x=1794853513;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4Cmesc6c6L7Z5O7qy6m8HiVqUJHOjQyHRE0+sJjwZY=;
        b=GL0zEoiNizBy1BtYt/6SU46F/71t0bqPwGYl3J0h3dzlXQL2tJG7MjpTXHYQu02xEH
         V5bKkjha/6PyPTCwSiHa6p2fkmjTQhzb5gQIjYeiDnPtjb6y9Xj9BqheGz+dFEZhcDD+
         JU7fBn0DOoYnJCA1URI0fEwjD2lKaxGA45TOtIjfYYqhKeFCopma24PIehdMCalvZZtU
         X5BbB7oY/qEFZG8BPUJJB2DxO/8km8roP7sqmYyFHb9FJjQJLdoMHKKeqXzscvLt2PBa
         P6I1Kq56jE1nli0/nDgswCtgWqAPAVroNFrQPv4IbWjNR8s7QUA+ZWJZPDG39sc1espv
         6WxA==
X-Forwarded-Encrypted: i=1; AL+hErG7Nw7J/fLjwYvbLADdMtOVtUnqQObo5qRyd5s6uWqXxvKhgpqAhJYzZHGNp8/N2zOo2LY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ErP6GWefMxWIGyryw4xLk89WSoox5qD69M8lCMtK0xL2J2kmc
	m1B9LlotaCOAKEHkM1vTS6pXUE85ptSAVQ44/VkITX5K2o58lRY3O028
X-Gm-Gg: AYBFou3ezlxgC6AlDcRmNgALTkPRvF1qc32r2AUJ4EjMRX23z88/yATjssBl2s9naDG
	M3ylsbjoUHYHhj3Ed8y+U9RIMv+daMamTgcWdoajImIEiAnWXdKNSHpBD0RWHLaWfuirZh567FJ
	KjDLlNSJxYtogXttWa1IcWqLeW80uzqb7NdWi3qKozfNpxGelpxkaDgoAUCXQ/7CQiX/IMwdbMj
	W0/d2HiqRdThkH4jOBGOlQhiuqpkgHBSzHtW2sYii9mmIRD6wfwAsMAAvdFzM1x6x78m86nWkdl
	cDE/PqeaapY4ralIw+LkmiwaNw1KiVxjtSHLcgzochFmvrpndyg0bvQIh6zldCTG0X9FRHynnkm
	/tU975M4QNQXkRAS8ovxeF2TSJiZRqUA2z9ORc0X3vsyyDSePbsHV82xA9ftb0Qunxgxy24yffv
	PlDwDKllbkuNYuhBGusIJ2/Opoo7p+rye7tDkIUmh5RI7KB59MIY2UlAnskWfC9lPf1VMgQchEq
	Gb3NdgW6fVQ0nJPN+wMqjPiTw+kxh0ZMcUnAy0Os/2ZBbDRXotIU5RXP5YjXBC+u8mwj8ncpuSd
	7/mP6Q5JnVmDl1DQyViB9Ml7JeQDkeG0vgw+NWySJxfoM59LS4LvcMgMC7zVy/tYtNim3p/p6aS
	aeRz7cNWR+8ZMmVdwdD0ADbFAnRMEjsVgHjk=
X-Received: by 2002:a17:90b:4a46:b0:3b1:6689:a016 with SMTP id 98e67ed59e1d1-3b167931c23mr197925a91.16.1794248712676;
        Mon, 09 Nov 2026 10:25:12 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1678d4e49sm436923a91.8.2026.11.09.10.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 10:25:11 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 18:25:11 +0000
Message-Id: <DMQW32TTNOPX.24GN6Q7VI6QJR@gmail.com>
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Harry Yoo" <harry@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Hao Li" <hao.li@linux.dev>, "Christoph
 Lameter" <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>
Cc: <linux-mm@kvack.org>, <loongarch@lists.linux.dev>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/slub: Genericize x86-specific cmpxchg16b comment
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261109035906.10857-1-yangtiezhu@loongson.cn>
References: <20261109035906.10857-1-yangtiezhu@loongson.cn>
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

On Sun, Nov 08, 2026 at 07:59 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> atomic primitive is satisfied by different hardware implementations:
> (1) arm64: satisfies it via LSE atomics ('casp' instruction)
[...]
> Update the comment to "double-width atomic cmpxchg", which provides the
> following advantages:
> (1) Accurately describes the cross-platform hardware invariant.

You ignored Hao's point about shorter commit logs.

I dropped all of your pending patches.

pw-bot: cr
