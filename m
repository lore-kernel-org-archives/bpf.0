Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230928;
	b=OveQZmp6QxR7GxaAODRlVv9qO/Ew/prWfA/57z8ibip/nTLe4d//UGOrkoD/wZymj7sy
	 JOLK5Eimkje1+t2sDSDCrCgQIbcJeIvVro2FNuUJj3+FKbOrpX8VZYCNQ7Qeg9u1dWem+
	 Ue8IgTa6gkOfx3y9L9PmZ8U9BZDkwDu8juG+4TXK+BpEJoAio/DDXwuXcLBfjTC+xiM/c
	 q8VOkRxCACFl7EVx46qS7Yvx3OYiULS3yL9vu4pfSssr6kdXsKsZ2ZgOpwWMXS2ZsVFNJ
	 k2GC86PUIDNLqZsN0JLpVdHX0E10nHtZWN27sWUlwhOUAUWuJLcv23mL9ctmoO/KePA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rsswYF+09a+rKyP1kcfLJoXu1lPtWtvOWjlekD34MxU=;
	b=YwzAIfYPzfEoFZBQEgtRixV1oetf7Vp914NfISkwJslStHY5Z/ZrL6wqWkXcbZNlQoUp
	 JlXs5CRJaEphmH4j42rbxtqV4nbOrBxYIaJ97oXuudsn0RMBSleXMWnkA9YXFOd9yDtrx
	 i7LvXnBVSjupitHioViGQ2o+atcZlZtk05TV8gSMO9dGjKfDboyAv1ms1Oan9F71z+zp7
	 4YKWDwIuiLvmse8navDXdiZB29E5dhrhQSOdq3CQaat2Ei4V3U00u7scfpDoCxKlfjlSo
	 Sg3U7EilxORrcWLf0xU5deoN4jkHa8YDHrDIegey1dvGzpS5mGRrSBz8liTsRMeuFmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q2PFAHXV;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66DD606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 13:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B66DD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q2PFAHXV
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so8634765e9.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 05:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794230926; x=1794835726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rsswYF+09a+rKyP1kcfLJoXu1lPtWtvOWjlekD34MxU=;
        b=q2PFAHXVc+qNSn8OFchCGNzLImP53bGX9+CY9a8Kj0gIjN9u9C/YHGrLURQqvnPz5O
         aYyEmxlXRfZeKhc9EfbboBdPCSU0gxrRIma9vyDqInwuKvJ4Hfv0DB01lJIxJNS6XtqJ
         p0nCs2L+V5cy5m8WyvXKrfoFZKsZloZ0jxREaXC/RWDWa0pEmdmmvkHbArfcEHF88LIR
         ZNJcueXbCVEVd0XOoHZUziWP817JHum9ki5fIhQ5lLVM6R+kwG1wEv5r4Qffd9qUS725
         P2s17QJS6scIDiHJWe2/dbnx9cxw6ZI5vChsK+k1UxcbB/L6hRY8Ird58rnqqKWQv+1X
         x3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230926; x=1794835726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsswYF+09a+rKyP1kcfLJoXu1lPtWtvOWjlekD34MxU=;
        b=p4PIMs24jpa65D+Oet0uEH2RyqCtL23UeusReBsIQUePicDUkrVMiegMYWIdjXMr8H
         qPp41BThucKkah60JHMakXPucbUIPatY49A4k+3dG311GQmvPe85tTcr8D1JNJ6ckYpe
         YpfqVVsIXnwriECpbt8zGryDK8XNOk/zOvHk152FzffMJK8ziZICxkjKzJc+RRVAZ76v
         lYm3D/fYE6NSjqyQDqWxjXuNzePVE1Pw5lghHWvHfYsvT/tKUkvqTUQk2cUovj1Hm7g+
         tAb2Xaiy1pNd7alg6A9sPsyiPd65ZUIOwJjTFwY8ke4FEsE4l0sx4QJ8Az7MbmDRvW+f
         6qzw==
X-Forwarded-Encrypted: i=1; AL+hErHR7Hr9DYYJ7Bh4P1pdvlIMzLLAg6ysmvhFRvqEIbopYNxjEDm/WUY/7M6ilSdpadupFc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NSWh5JiyVm6JvliK6epnL9LR4uL/HE1fDCF7gR1aK3Ur015ZX
	8yjrohPyuguvrv4hYc3JHxznCnelY0eKLRhyQ9Y6Q1QUQXeCoRjQzU1I
X-Gm-Gg: AYBFou2SywUQIhTNLgFRrRCIHNZlsUa73QT2B5Sz+uOBuWryfYE/VB0d+lvkUTUNOJu
	kFfGrSnfdD+2rYJTsRxCjwPN3CM/oI+LT5SxxpmXWpmy6c+N5npa5BufMbd+6DjhSq/D1BpE4tE
	CNkFQE/JJlxBalZ8MQW56MMuk3MlXt2oR5rrJycx4LrmuQBDwYeuKU1PxeDEdWZSq801FyE9kaz
	9jX0A/2jGDDA7L52nrS71spmoc8mcjx5FHFdyl3QO2xSFmdYcT/tW2PqEut+RsUlvQY2kaY2XAU
	E+WREfpW9TdNf3pmRsA9G3C0ReyiwcNVjjH1iTUpIGqN9klay0+a/bv4yg4TDp//K1OoF2HWFin
	H8TcY2FkTLHsiQmXXpDL/ewGQn7DKbQwScHgGTStBo3ppwhHaDfx/v5MN85rXZ6eqgcjUwCRovW
	O/wxW77MaPMhjMX9zidQRs7dNWOE/CEzZeHotbZ0HV77hROz6U8NOxlnfAs74qZ3g4bV2PLC1Dg
	8x3FY3sIOKG5otQxAKCKg4VznSxSmE/Q9jOLnDTewoGdLiHgE1k55UsIVMkRhOsNUZTH6f3QcXB
	Vv+Ns3hnYccHC2vfgVVpoT0Gs33JfllZ4YjR
X-Received: by 2002:a05:600c:4505:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4b963c85de8mr77785245e9.33.1794230925937;
        Mon, 09 Nov 2026 05:28:45 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm282951965e9.1.2026.11.09.05.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:28:45 -0800 (PST)
Date: Mon, 9 Nov 2026 13:40:19 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, almagui@kernel.org,
	john.fastabend@gmail.com, qmo@kernel.org, brauner@kernel.org,
	kpsingh@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, sashal@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v1 bpf-next 18/18] bpftool: List and show fmod_ret targets
Message-ID: <avHNQ00KldUBEM29@mail.gmail.com>
References: <20261106210314.1767267-18-a.s.protopopov@gmail.com>
 <148800382a0df555432654e0021a940d6bcd283955b5e1ec88ba885d4f28cfff@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148800382a0df555432654e0021a940d6bcd283955b5e1ec88ba885d4f28cfff@mail.kernel.org>

On 26/11/06 09:35PM, bot+bpf-ci@kernel.org wrote:
> > bpftool: List and show fmod_ret targets
> 
> TL;DR: Nit only: in bpftool fmodret.c collect_targets(), the
> TAG_FMODRET_RETVAL lookup may be unneeded, since the only caller's list path
> doesn't appear to read ->retval.

Yes, thanks, will fix.

> [ ... ]
