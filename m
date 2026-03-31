Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A4426D3F
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979574; cv=none; b=njwQJwyRJRCAQH/PeiXFGADgzu61ipIiwi7P6mBFyblpRIgpUJGhm91S3FqEMH0PWTo9KH+D2dglfFCMrrEWthKhw7G5hHTUO1sdIkUr4xatQg4kSMd2fdVoNWyT0VBOGwpkqkf2NauiiplN+qYMOERwVSgB3ZnSCxm5Y2eRND8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979574; c=relaxed/simple;
	bh=WG0XqdQVk2difKi1kZnyOfWQ1GWK3QSdU0NwzOsttTE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C0qrHqo+Mx+9ZvOfh53Jw0LWu7EGwtY4FHCt5sOeX0SnnMY6xzBL/CO2GtnEig0MRjxNlKAHUzDhVoLeiL0yDpu+ySphTYfRYIu1L818ctKN93dO73kAjOk6NFe5QVe2ajsVny2QTkQYY8Kgh7UrmLhC9iRpbStaAyhSW9EoF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5Yiv58g; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5Yiv58g"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso3748026a91.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774979570; x=1775584370; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PN+vSRpFOX6zWW2OP/Dh1hEl+/CNQTASH18viWFc53s=;
        b=L5Yiv58gehZOXnqXqw3bCtU5dxh6s3JiwSEUDVNog+KcGIoZbtmwZqhY8dD74w7d2q
         XGkm2lFuD+MgDtbzbF5Lb3hVty1f461/OCV/whxTxcUocN+DbCNJfa+cEDFWM19f6TMX
         mL0Lqu5TMulNycm0Xf9bHNYvelggegHUBzGk/ChFLJVFypNdVGf5/PLyfjKhXSVFlbU8
         jCJlouqfOdsC/UTqwcjXFPo5PEbQ4WD2DkMUh0vNPg/2YiAOUusn+RMn/TqchznU0z01
         y+Y2t9/FR0nZ15l9B9KkEHIJUeGfJ9/ccETcUEQgCAPQM58CLfdsV8VqjYRjFyT10Dfh
         chlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979570; x=1775584370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PN+vSRpFOX6zWW2OP/Dh1hEl+/CNQTASH18viWFc53s=;
        b=BEgPAqc9b4Y6k17w5cbbYHWoXuLWE1NeLkQenylB/zH+h3BkvhLeXxIu8mLfRA48YF
         ACl1wMJdNIyX/Tmsmw+LXWuGsl50MlAyDHEnN1qn5zP7m+VAb9/bmZI1V380Zi/PBLXX
         4Q7201fu6lwAbY1Qev9EKY8aYZs/CWEOGNKFVv1ZN4RjIvSCjbcqmP5OFW9t9owy+5GW
         r5c4H1WK1EFIilqJxSVjftTLV0wAuqGGYWdWPPlqjx2hq5e80lXSKq6Gu07Tco0jhBTs
         i5AfPzA2sEtpUN3P9mxOe52lTmuZwL9eRgxxkkm70YyzjksInqW0R3oaGVM7m4PQ9smD
         wxzg==
X-Forwarded-Encrypted: i=1; AJvYcCWRyf17nYdPa5Qxpq0hGj6QZfJgQvAL+wMFgyxO8zbwJpewwnxwK0oye0zObZgShv1c9Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8srlQiYUD3tGMmMzJCFMOGtdFKPKOwXFH8GuKYBnDBHO7k1CP
	cWseePLVNXXtr+jV8iSekl68IR8op0I3PRD6jwdVluTniB5WX+1X/Q9C
X-Gm-Gg: ATEYQzy8R4F2Qfb59OKngtXg4RviKgU96tk4uKgs9Ah87p3Z3M7pihacQR6MPyheP6p
	7RSG+Q/YPrYIbHml1OHxTOirLMlkWZB2usOIPfBirfTW+kzmFCg0jvwIgOU7FyS7h6DyIiUq47+
	xGwo3ZPw8JPFSzKXNb20t2gkQx25S/b2E43I/xLbNzsuycbFW6g5igTSba5bfEo35wd4JtgQq9Y
	cCQ4RyV/wif9t+XyKFQLTXTzfluIUlWoZKJjOCXe5SP0hE88UVg7hZJku+6G090u3YwM0fOLLSY
	GscFyIXtWelsJjQHJc0r7tf2qVD6uhk5pJqcYZPMiCmyXBfFNAC6xppxga7gRKxGbfzPvtvZ+Nm
	MMbg5i/Lc67dkCHKQrzt11Aopjt/PjdE2O0Bub2Ue9b0gAsIq5aXm/3GKQKCPpXdmPf+w/3SJMY
	CgXKjdh7wK5fPwCaUwYA6b7HtNh/bWtgME71ng6ZjRdAWRo6oQ6UTX
X-Received: by 2002:a17:90b:3d92:b0:35b:90e7:c453 with SMTP id 98e67ed59e1d1-35dc6e43b12mr252177a91.6.1774979570235;
        Tue, 31 Mar 2026 10:52:50 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe62f5dbsm2275826a91.8.2026.03.31.10.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:52:49 -0700 (PDT)
Message-ID: <d4beb34296d815059c8935fe7f0229e43674ec37.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: impose global ordering
 for test decl_tags
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bot+bpf-ci@kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, cupertino.miranda@oracle.com, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev, Puranjay
 Mohan	 <puranjay12@gmail.com>
Date: Tue, 31 Mar 2026 10:52:47 -0700
In-Reply-To: <m2mrzo17ai.fsf@kernel.org>
References: 
	<20260330-selftests-global-tags-ordering-v2-3-c0ac61e81098@gmail.com>
	 <fdf52b7b106f1747fc2e4bf11fa34b28f140b5abb1c698c6800ad167130c10b6@mail.kernel.org>
	 <m2mrzo17ai.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-31 at 14:02 +0100, Puranjay Mohan wrote:
> bot+bpf-ci@kernel.org writes:
>=20
> > > diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testin=
g/selftests/bpf/test_loader.c
> > > index 50ca1b6ec8150..3f784cc76f8f5 100644
> > > --- a/tools/testing/selftests/bpf/test_loader.c
> > > +++ b/tools/testing/selftests/bpf/test_loader.c
> >=20
> > [ ... ]
> >=20
> > > +static const char **collect_decl_tags(struct btf *btf, int id, int *=
cnt)
> > > +{
> > > +	const char **tmp, **tags =3D NULL;
> > > +	const struct btf_type *t;
> > > +	int i;
> > > +
> > > +	*cnt =3D 0;
> > > +	for (i =3D 1; i < btf__type_cnt(btf); i++) {
> > > +		t =3D btf__type_by_id(btf, i);
> > > +		if (!btf_is_decl_tag(t) || t->type !=3D id || btf_decl_tag(t)->com=
ponent_idx !=3D -1)
> > > +			continue;
> > > +		tmp =3D realloc(tags, (*cnt + 1) * sizeof(*tags));
> > > +		if (!tmp) {
> > > +			free(tmp);
> > > +			return ERR_PTR(-ENOMEM);
> > > +		}
> >=20
> > Should free(tmp) be free(tags) here? When realloc fails, tmp is NULL,
> > so free(tmp) is a no-op. The previously allocated tags array would be
> > leaked.
> >=20
>=20
> This is correct, realloc() will return NULL on failure, we should do free=
(tags)

Yeap, need to send a v3.
