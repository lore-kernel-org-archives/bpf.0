Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E444DBD62
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010033; cv=none; b=U1oamUqYty3j+62xXrsrTh85m8k7q/t+Y/qwwftb4NpXfgblDD1AvHmI94N3yUpJsOzB5lObM2xCQUEHf55RJQVoYoPGbuU1XfNlrkydxgwT+QUGKtcSqkAtDXRCzy1dmO6yt7a/XtFL5/X6a7AWy8JlkGd8a5JhUXJ5Tk06LtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010033; c=relaxed/simple;
	bh=Y43PIXOdeszmbNim3OCLelWlcK6qfXVD1ElAmWr/8jg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tRPRkRkxZRcvgTyelQujYODAFQBGZFbz7hS+y06y5vFsk8qflRGhTJ/Bwf13Z054fs7jgV6CTobBVAPOjDFfa9b+0lGwpp5xusaoI7giJog+F2o6EIdRtfgzKE+txaQbXn8wSW0pXtrlQxf1Q/GXFwg/4PD/mNXu8ckQfMEXHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1HseG+c; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1HseG+c"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c3304833so2265529a12.3
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790010031; x=1790614831; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mxcdVkydxCyq7TdN9b82d69qwFX7gQ0EXm+jWdNWDGc=;
        b=p1HseG+cWWf1w17LdbHJIbXUAqqDMIyrYxUNB2SbYG/Wy+bD3nxvUO+2eZGg2oyB4E
         m+5URWR1LlQp1yMGdWwBUjZkgnOWjRsuE0wqqYuDKL7IEHcgUa7WvnoOC0ShD0lpbivl
         LN3oGqwbAJgm6nigOkfmwxZqB/5yPL3VRfcfq9niTdTcRcDzkhdTvSC+drhuc0lz9/6n
         cQP3b40YztsVezH7gO5EC0NraHTt5xkG2VBdVPQOSSvGnClcqtfFH6xh3OhzfGRcJcoo
         Q/CQY6Di5lPlU8SPs2zrQnx2pLBfxyWFP2mAbsaDc0ll3L6SVFsC9MmRjKWwPuO8aK0e
         GEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010031; x=1790614831;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mxcdVkydxCyq7TdN9b82d69qwFX7gQ0EXm+jWdNWDGc=;
        b=iarQT1/HLTUwLMsnuaJMyLPTli7wgg6kuTQ7Fu5sffNTYECi5MUptSaIaiLQ1iKCtI
         B2oJiypVkQVkLu4XThBFu2RuQKx+dkDVIAAXctqVo+e35eMeTvTJQYJ+YyP3liflLN08
         txveJu94nmQ0jHsUaGE66kUpo/amC2YKCS6Mn8DU/DB0TwGMl0wu56SdYlc6uEpJPAV6
         CVZBKlMoiAZN/z09hNEvseOsHUn0/giWQ18iN1bvGIm8sG52yikA1FvXcqdeRLxLMm44
         J+Nh8OraZKOF6+3u7ym5R3LZ12Oc3wQrgwVNtHQo1QimXlOR+N5UV+dGAS8OF+EDFEEy
         gkmw==
X-Forwarded-Encrypted: i=1; AKwUvBzGl6g1SzpnM98frnHksDhbFHw/iUrGQ4uHNShQhGbecQUXqSwPSkST2pI0BqzgIAqpHFM=@vger.kernel.org
X-Gm-Message-State: AFuF++laffbZTxxOKz353tryn1SYu6vhP9GF3HI5PLcXpRlIoVVKr0SL
	+LjuGgRyu4+fRF/jbvEoFDxMrTwzhGcJ7WG3wDiS4AYIaczVdtl0pI5C
X-Gm-Gg: AYBFou2Z6cWJ//w0poyPLGvwJPwdRyF44iwbNajymRVoSgp50FUnpkoWhGBFKdZ3Nq8
	pjNotrlh/EineO8TGOCoeEZpT99F7/JRD+SSaBskw+suzJJ+Pa0leVLlmxQyWpn4tjpaXuUmrny
	bxWPJO3sJVK1uKyH/eu+rCI6/oQovmHdEngQbkrBBDoXMKJmcjUUOGCd7cJFdQBL8jY01YIB+Mc
	ubrS2vs+dzN78Yok4MJ0Ha7Ze5Wi/7UF9kIDTtVi8pOZajvmR1pN9/PCSJcD9Y4IGHUOlQOuZEF
	arXsQt2Q86SVU8uo7AOQe98p2v9avGD3jD9p7RUi8TSvpXuU18fk5D5MRYoBcY0VCv+WiwBXfNe
	lS9tf7qcwMWIh4SnrscRTz+gzWdcdxidD1Xv4agZBAHFzYt5dxBFJ8lp/gCKM7Vpw1bvGvCLLUJ
	J8vq/4W1Wpz3pwRt1hPJGfx6NAErMwuvw+8+Qp9H0Jn18PQs4FE226Dhkqv/Ujjkn8y3/6IMa/K
	PV9LWwR3F2Tc4K7N7HUBBEluLcMQvh87r3NmNoRJpZTeXx2LPVO6h37q9SHmAihgZzKdNxk/2l+
	lRc=
X-Received: by 2002:a05:6a21:7782:b0:3dd:9483:48cf with SMTP id adf61e73a8af0-3dd94834975mr12751470637.6.1790010031393;
        Mon, 21 Sep 2026 10:00:31 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aeda98csm3797505a12.23.2026.09.21.10.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 10:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 17:00:30 +0000
Message-Id: <DLL5LJUBBBNP.K6GOQ6AV8OU0@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next] bpf: Speed up htab hashing for u32/u64 keys
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <kernel-team@meta.com>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com>
 <179000542526.3934731.994864591824564797@gmail.com>
In-Reply-To: <179000542526.3934731.994864591824564797@gmail.com>

On Mon Sep 21, 2026 at 3:43 PM UTC, Alexei Starovoitov wrote:
> >  static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hash=
rnd)
> >  {
> > -	if (likely(key_len % 4 =3D=3D 0))
> > +	const u32 *k =3D key;
> > +	u32 b;
> > +
> > +	if (key_len =3D=3D sizeof(u32))
> > +		b =3D 0;
> > +	else if (key_len =3D=3D sizeof(u64))
> > +		b =3D k[1];
> > +	else if (likely(key_len % 4 =3D=3D 0))
> >  		return jhash2(key, key_len / 4, hashrnd);

Nice improvement, but key_size is known at verification time.
Let's do a step further and specialize htab_map_gen_lookup
for small key sizes?

