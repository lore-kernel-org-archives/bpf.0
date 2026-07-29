Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A15255F52
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286467; cv=none; b=oeyNgLilmGiJ0fqeUY/G/Hf4rmaimIATdVOWFdVfS/vnZV6sKKpBjwNENIgsRwBmR1QVxFUI8w32L3fs9fckDnOlvBvXFa6MSTIxRTL2uIXhC51JlNrMvoisG8DoR5DPOazjbz46vLGVR2pqGfeuUVllatNty40xux9RtPePr6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286467; c=relaxed/simple;
	bh=5Lr5IjUyDlxwY8dBQ/hmJQBVPhCGetFAfVOSN4wo3ro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LzwKWI7vooNkU82zIQCFaCnQaA1DlZD+SjI8/DF8uZh2MUTb8ju6kEuHXB596z7j00D2cg6NBu6woaaKyW6HrnmWa9QtjaCoZ+Xj+LrDpkAHmBCVfvlAXDK/ENlXPoimaP9NqVml5I+Pb6PKbg1R1dD85TowXk6y4FD10NvQ1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeU+3Vqh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeU+3Vqh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so330466a91.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 17:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785286465; x=1785891265; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZbHvEL7dXUPa0tTQnGqai5VPfxBX3kXlGujGxijLDec=;
        b=UeU+3VqhxSTZSyaKBdD+SYhY0DOXpKLaaNdwAuUxS3z00K7+fbdW38pmH83OlUdybm
         CxYDyj4/VJvq6h9fAjRpwYWfbX9zoNUP8uaidbQIBh5l/ZBneo6O7XoPLKuHVwOLG97A
         JEW7h6sMBIcI7+yOM3q3GO41pIIe9HHMPOVIXksZOej9mxdNPkf1BlmH31Lnib44Lo2R
         xzHkpJszWR2M8XCd3XQlLNBJ4qrVnRX9kLpJzSXApUwQ094LgKO2+00aQRnctmqrOpRf
         74EPzkTvC3bI2qbUug4whR1AVcZ2QR59uDKv3fj5BW9Nx/zEI/STQpDD9y4z00mtQMR3
         KXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785286465; x=1785891265;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbHvEL7dXUPa0tTQnGqai5VPfxBX3kXlGujGxijLDec=;
        b=qp5nKq+Z798cc82mO6GmVqyknyHHqQmcRPxxKYSzKbOyQMFjMZEqw6WcrDMVzlTpKv
         3AbfPBya1Z0oQgQxbR+InsfhcAnc5Tybo/SStP5JBcbpRyvFAfuqbe8uAc2N3E1AivPp
         l5PTSUxwiE1ZzsT4sPEcpqPWbdIbbSy+c9RQ4OzNM7+pfRPmLZuiHz3R+hBao6vPZBY1
         mYgk/aS/CKnGmuZQL9D3DwZs1UJAO1ulpg2LOkKaAopMswnh2r4j/E5QNb6t+Gks9C9R
         CCbDLRqC4nA80kLC0c7dx9YGBYWe98froEZHtjfrR1mNGJ+FfPlJLiO8ATnBc8oSfuP8
         fE9w==
X-Forwarded-Encrypted: i=1; AHgh+Rpa/edvRtf/KhXWhR9/mb9Cfrbc6ihaCtRe6YJDUB8Gu7fvbLHLqofxPaPSp2SobfXyJgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3X8liJNqlEBtBqIVEZPR6/aCgjda5FRJ021WJG16EK2C1/CPV
	+GB8jWIPJUHmHws2LHBtn4VQjJWL2rw8AzI7vAJdNvOyr8xnhdjSlQcR
X-Gm-Gg: AR+sD12j2LtJ/BKFxd2a1epzK5r+43Zcql4n4OAbplhmy9mKxCdILWDPi5IKyUI20du
	5dia+NcXvu55dNxJumhiXXm1h+IhrS7BxHv1dsoU2v+66NmpvUzKG633bYfGKU6KT2uwr5dqtA+
	B5iBYnkorUfbzBeoWwCRKDneJjph0u6sC4Is8KqUM/QBRYvo9qp3I+t6e7QPxDpUKTyOvLJoZxt
	g6NqfiiJUi5kW5F4D8ANcmqgwN15pFHvmZx0UOAcqdtUmH2NAKVGR2a6sf+GEkLVz7rE8QQdH6x
	Ko1xUNKIk1xAEEbnWyFAVBR4Md2RWWztHqx+mIipnoXSTlCJ5rIo3ZXuRFg8/b3YGzYnzV96L8L
	XgWSHG4lYgIm6KQ/lFJ55Znk5i0NBDZNyK3K+4Zl4tIEQ7XnavRlSzHZsk0m/PN21YnwFM07+6I
	pN+7TXxWFZ71xgOxKu7YjvYq/fH+n00Bp8XXJZ+LG6b9LlJ6Fg+DoAd9iagfYyE2LtLEoLlkVIY
	VXbZJ7pSqolqXeDO6XdYNMkkMGov0R5yDJ874Bnq+vj7A==
X-Received: by 2002:a17:90b:4cc6:b0:381:5a08:6291 with SMTP id 98e67ed59e1d1-38f6a557bacmr4735473a91.20.1785286465024;
        Tue, 28 Jul 2026 17:54:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a4d1:33fd:cfd0:d646? ([2620:10d:c090:500::7:3a0a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7265010esm3407972c88.6.2026.07.28.17.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:54:24 -0700 (PDT)
Message-ID: <e847bd1af74a5b8e5f0bb7741335fd4a5c647bdf.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] libbpf: Export
 btf__find_by_name_kind_own()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 17:54:22 -0700
In-Reply-To: <20260722233518.778854-5-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-22 at 16:35 -0700, Ihor Solodrai wrote:
> btf__find_by_name_kind() searches the base BTF before the split BTF,
> so in case of a name collision between base and split it always
> returns a base type. Tools that process split BTF may need to restrict
> a lookup to the split's own types.
>=20
> The internal helper btf__find_by_name_kind_own() already does exactly
> that. Make it a public API.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...

> +++ b/tools/lib/bpf/btf.h
> @@ -172,6 +172,8 @@ LIBBPF_API __s32 btf__find_by_name(const struct btf *=
btf,
>  				   const char *type_name);
>  LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
>  					const char *type_name, __u32 kind);
> +LIBBPF_API __s32 btf__find_by_name_kind_own(const struct btf *btf,
> +					    const char *type_name, __u32 kind);

Nit: please add a docstring.

...
