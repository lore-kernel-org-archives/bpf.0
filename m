Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168330;
	b=WF9TMc5iKzr3XUFTY+vwDiBszu3u0ebRZ+xiEftE4xmgANpU8zWwqd+hx7o/1fp+3J1P
	 OUK00vphQVAtjhJ1PE4NcSadEGSA0QSogLf2RP0lCftd6+0b1FyDshCFBRhF2A9YEfVhV
	 i0xRw4V7rBoCEF6xFPZdXDQQyFIZTdjw0XgIgv4IK5ZnDIN2d11WAzcVxW4FRcu3XLiyn
	 uP/Pq+5m8kSbL94vJ5/CA8fTuf9R57rG7bY3gtmKkN7Hg7urI6XubrfvGbMGjE9tqszNc
	 TsgZTKEVQZX3uOcFxHfReWXkIsNCr1UxKLwnrBFihXWKc4KsbjqJOo+stgnwSS378gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NsI7ZZLkYjCZutUVEg7TJNtNpCk2xGDMbVs7o+8cm3Y=;
	b=RAcuakNDqKE5QFfwJaI3YEEzxsBWBXhItDq5iqF8Jxu0eLKCbPK2oFhBA/LeWpYPw1O3
	 vT3MwvLmsfbTr1nf+6/CSCz5XAdgL/xps+DCNm3M0kH2vM5spg4xstfq4pkN3SlAsCSef
	 aykoJaykVtVi+5MUnyXivWDc1/4xHMrLw45/zDeZPTgD75RHMhziriZsJwdsRh4NFm3Pw
	 iZxn6TUlhR2TialIGCm3ZxjbLgMilPLqIT35kCBUlnDHPQhkAfcYUCY0D0fx1CDPehh+X
	 AWFYkSjvJjAZ/D9Gio97m5t6JYEzv70FTVDaqjKGtQ1Fa8gBHmGJ0jM9YJuY+YTJN6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ib7c6P66;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4C606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 20:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44B4C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ib7c6P66
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so1606045e9.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 12:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794168329; x=1794773129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NsI7ZZLkYjCZutUVEg7TJNtNpCk2xGDMbVs7o+8cm3Y=;
        b=ib7c6P66JcABRQVIYvbAfEuMzOdspSzPtZfn7p5hZaB2Rr9aWYVjAA8lHghOcTHkfP
         W1IBKWn61CtXgoJPbCEozcqCpgRPGxULcN94D7ITtmHErVGmr3isoGCQ02nfNqhbH+4n
         lUM22s4MKp/l6fyffg7/TutUQVALjesHSFnC4w+1WVPSvW0J5rknAYGDJAl4xvCRXDT5
         fBdxAtmJXU6SiF6lguNdvRiiwtq6Km8nyFGsRU6Tq+7fwVjsnnI/ZpxcJdUfsPAfNVOr
         BXFpKVyK/3a7Qj/Qjq4EwXbAdcjWWztzIsYea9a0P/MiY6n2EtEGPByGhhhA0f0X0qYJ
         P5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794168329; x=1794773129;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NsI7ZZLkYjCZutUVEg7TJNtNpCk2xGDMbVs7o+8cm3Y=;
        b=A1el5Zkl73VApcnrvQqVSO8pt+wnekET7gfRplI8NIOx3cCVGoZglEj7R2omSobW9j
         IeW5F5n/mw8YHj3SxWdt4bvt0TAjbAb3ZG96nUYBz+QA4k5YBIWYgxMVfssRZbl0ELmW
         Q0nr3fWcRnZBpuAo+pDYqKyHIZz6CivF5p3K5Byw1ceHPqE2rpajznGoSfdFEkN+lB1F
         Hx0A8HOo2G+hD6z3THuaHG9wHxOlWJ3tA5kQV3lD0GjWwtX1TEmyIUHem8M/rRHoKhoo
         ywOBcAHUJIDU6ip4HAnukgQy4sMRnuy+2vOPE6d8uO6mV9jxSyyN1G0s3i6MPGexVLId
         ehRw==
X-Forwarded-Encrypted: i=1; AL+hErFVIt3AFtn/c2H6e/h8iuh0s4cdAhVLE8eg3puLSaeGCsdnxT+X0iGDJTqoYbHO6IT4WDM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hkYO0GZ2R1LkILUnORRtRN6W0lCghYJF/lvMRZayYAui1WAQ/
	TccABUCMZYW66VL7eUZfU3tHGgECnODX22zG6SPRD+nTcjKVmUjwhybj
X-Gm-Gg: AYBFou1b3VFhrA2W74TAgwcdEAgHMsV962AxyEtWZ6b+dnj+pd/v8sbabv+K6detVgp
	NfJyg2PgbwUzpIlwlRtA9smNBYJNtBYcF/3wnCM7TD2WN39OGayvDDKRuo5JT5oCDIOePTeRPyU
	KgrgWJhhfS7m0KJ7LUaAmmTzHmPDKpOHO6qBLbVudnkH58oCSSw2VhDESgVVumBOgP2rbZAqgeP
	at18DyZOOXtTCbPZg5y8i2Oau8wdJbUGlnkj0nwCKyJFJwk1477xroyxJbt84wjq0a0iQtX1/9x
	ThoQrb/q+4Dg2rZShjDMGzMWsKwApCllGDuIbs7waakZvo4qvYBdtQZ3K8FYGZQXtSlOfUXkLXX
	Om0fD7ZnoZ+YTUbwCLEXhhPZbUYUAdXWQczGJeu+BO923m3qh96gQptPq+mz6q2YKys56LB7tKg
	6PChykp+MMVFaFuzS3kHs4JJwCuVHb74Q8MU8kRTLRjsx9K587hpsQNH3B24ZchtvIziP3w+6Dl
	8TPgizXiMRCQVNDNECtUJJMLXZCl7bppYa+ISTcdHSuZLiRCyJ2WBly8Nr5aQZAN1I57Ja7xx+4
	UzQ3iMixZDe+Yjzd/HDMg4y+W9AxhSn3CSEUZZiujHP50AOjBQ3a3aajNUPcbOYYLIyIWsciCx0
	jQtF9C01+yA==
X-Received: by 2002:a05:600c:1c0c:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4b963c69d23mr43591205e9.19.1794168328561;
        Sun, 08 Nov 2026 12:05:28 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186ec5sm5768522f8f.33.2026.11.08.12.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:05:28 -0800 (PST)
Date: Sun, 8 Nov 2026 20:05:26 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 David Howells <dhowells@redhat.com>, bpf@vger.kernel.org,
 dm-devel@lists.linux.dev, fsverity@lists.linux.dev,
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-security-module@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Alex Shi <alexs@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>,
 Benjamin Marzinski <bmarzins@redhat.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Dongliang Mu <dzm91@hust.edu.cn>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, James Morris <jmorris@namei.org>, Jiri Olsa
 <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Paul
 Moore <paul@paul-moore.com>, Randy Dunlap <rdunlap@infradead.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Shuah Khan <skhan@linuxfoundation.org>, Song
 Liu <song@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Yanteng Si
 <si.yanteng@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 2/3] KEYS: Replace assoc_array with rhashtable
Message-ID: <20261108200526.43579e2a@pumpkin>
In-Reply-To: <20261106090516.GA1973@sol>
References: <20261105031401.956609-1-jarkko@kernel.org>
	<20261105031401.956609-3-jarkko@kernel.org>
	<27015846-0161-4700-b810-4643e1f7b63a@suse.de>
	<20261106090516.GA1973@sol>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 01:05:16 -0800
Eric Biggers <ebiggers@kernel.org> wrote:

> Side note: fips=1 actually has little do with security, and in some
> cases it actually decreases security.  See for example
> https://lore.kernel.org/linux-crypto/20261026183332.11402-1-ebiggers@kernel.org/
> where I'm fixing a vulnerability caused by fips=1.

Then there is the 'fips compliant' server we used for routing 911 calls between
TDM and VoIP.
Any kind of PCIe error gets routed out the the motherboard management module
which then proceeds to inform the kernel with an NMI.
At which point Linux crashes.
The NMI is too late to stop the kernel having to handle the ~0 from a read.
And even happens when there is no driver using that device.

David
