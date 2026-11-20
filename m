Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795217027;
	b=m6t/4u88fqpXLKVTry3Qbo8ZBpp6nuNvmwSkryVPHvVq84igA5/FHW0pymYH8nqToJ11
	 2FQLrxl0tqLylt1r8gqYhdG5hl5CFd7YdTXvWHS37iR/lXil6FOKoX6qFiJtgcwmaP+Bz
	 YlGYR8boqCOj5MYh0oiRHDU8p8Aoo/WW0wPC/D/5oJboyZJE8gUVjvErlqW+lNbNpCq2X
	 8hoINaa2lpPuPA5v6SaNhdb2ws3OcLs6WcptKHxm0leDF/zna750Ps2ds0t6C5zKGhTFy
	 nqf/PSfb4Ob5kMDAIpeqodjBVxm+oJfi2rHUpVAKQzKL7zxJ+j2BP8euTl4yF5EwfcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795217027;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TGWLnIfO8Lat7Y9NAAZx//6gPQdAxKgN9VEcDXQpR2g=;
	b=YNPIY2eHuSb42r074k/nccn/1glnzfl38fjYDxZSKcwwd9aPPZurIbJtOMEPuXB0U5JE
	 ImHptz7/PG/XPJ0xzm/THpeCf4p69Rm+M4yTGb5T9g4hao6lfAlzTv+Mc66aa+1qjAjdb
	 io5tfGuvniA3E/SgRe8yP4oMRkM8/QubRZoUr4iwVuUKkUr6U0BYiSghnE42ChDnM9mKr
	 AcVvgj1AW7Mo39vKHITV7RcLALXlcGxohxxWg+Yr1VRLXp/UGBqPpybvcUJEmN3rDS5LM
	 XY0UY6o0qdC7etGQugqbTlYqgEthn6IayOA/S64XwgWYNi2MpEJZbMNfSun8JnbWX2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E4606A6A8
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 23:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B3E4606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-945e6d9ceeaso131220985a.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 15:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795217026; x=1795821826;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TGWLnIfO8Lat7Y9NAAZx//6gPQdAxKgN9VEcDXQpR2g=;
        b=I/D8BjQ5KStJmYT3GJ9f3RoLiyWARNfwIWIFWgX7/36bAuF6FOmrfKDNBCWXuUoRm1
         0sxEBzjopX4oDeZqryl6U34DGWKu9U2OKVgFDC7HfiHi6/n0RZGiTN5dRv6GIsIzqWV0
         qiv/2Ikcj1jb7h/CCeonmKJDqsPCqD54uht5a7mzfLnI0QX3OlMYW1m09noYaozSzWp0
         GGmegsNkaE5+PoO9+gaQ4LVda4uxZPKDqvs0SL7tnvlV5fEpJ0zW9s9HzAZvGbzmW4pt
         H1eH5PF4oQBtEDiQT6F7Ad3F7SAARZAjkYVP79o7gM1oEJuWdZ3LCzHoclRxLuWq5ASs
         ytUw==
X-Forwarded-Encrypted: i=1; AL+hErHRNI4hF79Y6ADN57jmzq99oMvDXRD0tH25FyaySGjP4fVlEeGL03XlC2Pebv5wadgSWGY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RAfJZVlugYyw63kMEV8lyacfapybx2JLNfsMgt/PnDTav8U7f
	Rkcl7x/jfs0BlCFFDKWA4BlL7DGE1xV1UHk2XuJbdnjK2/HhGUij8DbM
X-Gm-Gg: AYBFou3489TwD2El6Jf2EiYDpZ1AXCNdYY7BmwCDiE4zkx7p58CXIm3k571UV0xKvdt
	wc+QZ/N7qjRoMfhxMJU0ZPX8cOsgHXskXA23aAdWS8LZyYxOX7xeGrtmoKMV9oXwDkwA7Y2hect
	P85m0mJytLTpldrQASB+sBeN6Jw0odXFLiYJ8RrU7JUoT//PQ2/mm9OQ6k98t0a9OolJuzERIcI
	QhMZOSvXFthMhsSc5/FNR5lFmA8JLQKjR5I2ZDrVwzgF5HyfS7En09NIAwYPE+qgYw1tJQxWrMc
	llaL99HxEQDlDn7zagTO9SlNQjQRMLC1097AOcReioOwRfxrQ+kzFveyWCkWziqQrcEEtYxrgZU
	Mt6IJdGjhsHakyVlfnCnJqVROZNoUBaPnHppSsuD/5Q1PfG7eyO44bBiu33NIwvS351sbQydkMW
	DxM/z2NhbmnkNOsNV8O/jIeNl6ZIOsBQ+FL5S4m43S24iAOMo5PipEdoJHuXyYtBrTuqAplXQj1
	d0q2bEs1G7JAGKqAsckKIcTvqDJt3PUTXoZir85Bi+GugeYc52bODMxJjg6wDox/hp2+Kdtp5uy
	S82udUUtX2q611ZmQesPYXxUsTSPMiUJoeBlFI3bBR6tVDFP9bBfCyrrSFZLbtk+EWZUFo4frfG
	b/L/t4x1uSu6XlN3s0R/0M7WgKYARMruvoPRU7ed7EUuz/5KPkxj5
X-Received: by 2002:a05:620a:458d:b0:949:73bc:c763 with SMTP id af79cd13be357-949baa13d87mr880796285a.58.1795217026434;
        Fri, 20 Nov 2026 15:23:46 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41a341sm303706185a.37.2026.11.20.15.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 15:23:45 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, shuah@kernel.org, arighi@nvidia.com, xukuohai@huawei.com, billy@starlabs.sg, void@manifault.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, awerner32@gmail.com, andriin@fb.com, martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH bpf-next v3 2/8] libbpf: ringbuf: Use compiler atomics
Date: Fri, 20 Nov 2026 17:38:22 -0500
Message-ID: <179521430208.33161.11588030194941155653@kernel.org>
In-Reply-To: <8676fc63d1b69002f39adee94811f9384c19bb8f6e89d08576e5aaab283c6aa2@mail.kernel.org>
References: <20261120-bpf-ringbuf-fixes-v3-2-ff7ca15d6c37@kernel.org> <8676fc63d1b69002f39adee94811f9384c19bb8f6e89d08576e5aaab283c6aa2@mail.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

> Could the fence patch come first, or could this patch carry the fence?

Combined in v4, with the arm64 RCpc ordering dependency
explained in the commit message.
