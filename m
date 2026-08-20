Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C72F6920
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787258874; cv=none; b=LfKRkgaLSA+8NV1JzyD70Xr9KQaXbBMuQUwmtOiEqLNiBDdzwfBAhYbd/d3paN1NRiz91OWmgoo9xxWL5WyEufO7nihhmwDOapJXJn4Y6Zz8aF4Cm2/f8+y7JiKV86ib/78TeGdr8YLQ8voUyIAPDEl8MG0KYlu+o1SBK3cudl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787258874; c=relaxed/simple;
	bh=xbRzKehp0mKJfPWK6dyVKPGNp/C3P3L1uG21m49mBz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aaJTwSgIbEhGeK6whevaPAUvIJkklrKxr1MQ/Fdav3u/PvaFKsHQApJxlM/Y9KGLyqcdeDK5D9owiVQmuUqk4tqZwEdGv0VZxHgnDFEx4oPsOnBX0SD8AR28lWEXeURCAop36zuQCMkC+yKeGeJd4UMqkbyzUltcYJiLSAfSKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ksm7a+W4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ksm7a+W4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cedda2ce6fso2019905ad.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787258873; x=1787863673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xbRzKehp0mKJfPWK6dyVKPGNp/C3P3L1uG21m49mBz8=;
        b=Ksm7a+W46B3XzarZ4JOKZPr+ZUMyAlBbm9tS9C9xr3r7aHnH2YW82E1sx3rPF+2gjH
         llxBH2L1BmFrn3sid742rhidHTV6Aiqa6FC96oqJwqfb54VFEppyrPe1ufJ7IOXmq0NW
         RTlp6hEAkI8oZAvbHDUi/KrzkV9BnEIu2KnZWD+pzB0hR5L/6sZstHhkfnrmfwABYHgO
         9CIUu3qMdNBsN70kOPVrVTh4jILcMYdV6WiF4v9Pio/qT/+Gv0O1usi7BoBlhDxO+QLe
         j2HPHsevxOwoGdqecd7MGu0xzsKlsVdIra0bZS2F80HxHycp1JF8Hl/YoMYnSVTb1OI9
         1MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787258873; x=1787863673;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbRzKehp0mKJfPWK6dyVKPGNp/C3P3L1uG21m49mBz8=;
        b=O4qp8fUR6jkRU5WQu/eLwHj87fvanVrNs4oPDjB2PFYPmcznZWK69T/vAzR/Pqi+U4
         +oE/3LK7ck9j2rAAv+G8D3DdMLwhBVAZYDTiM2SvFXf2rUg6jX+WcUXTifoWoG32gLJU
         TxAifO/64c2NYgCYlQ013aOBIWXTOGwsI0KrjF8gfWaaX/Dgd/Q+YPM3E3ncDw5byt2C
         xzc8lxPp/bGsvUJLqueuAxX8qirh8L26RQhKhgknULJdf2IHcVvRM6B+mw0VlbOWTNI9
         C1IVFZ0vfhAQGRFaJedSqZe2b66GqWyBF2dFtDgftWx1hCOuQrpiehrcY612MsAkQjI9
         whjw==
X-Gm-Message-State: AFuF++m3fMVXI6C6mDw2qWkxrI0kM2AMlIfwFFOI+d4lH7wM66PSOo6/
	DimsmvNQnRw9D22yY2bRqOlqyqP9SeSLJGbakMIZbs0xvuxS3X6YuMdA
X-Gm-Gg: AR+sD12PchpNEMC3AX3AurWLwakPg2Te0rfdFkrAzUo5SXMefrtnMpNvFCDGNraK/kC
	KHWSGlnvs34iqXOZZcVUnIqwW9fMC9o9f67Y0sG8RDeOeQfiTtmvSdcaN+dWT87x/x9gPhEvw5+
	z+nOKpgwpl0yISW/74+JRug7P13Pt/ccst3EpiL6V3OsRVfGIU3R0arBlAY/aM0fRGqRDmxPJ4y
	H2HmZm3+fIcoju/xdOA+YLoT5+li9lvt6c1Bt2wZJwRBkqqwUSP9+lgYhys4qVRwOsRUOpbtVM+
	BWA5H0O29MI0fELeprHV8TTbxHFt8iATnB2VNfnbiYO8e1ZmkmRkK+KcBvFEzVCc2ay/bu5/Sko
	6hJT+t88vYdUYWII0CnCqxQ+F7i6GvsOO9XNTQuZnrGSavMRvUODF7Ikt5fYzyUa0M9SBRZ7XEo
	kWjd2GlfUvzqgji8BZDVFnuWWqv7gqY6wh/jktAc18UyCyV4NOgniU4TPw3w/pVLfsPd2a3UPpI
	mSZ0LgPag5PXBbLjZ8fdMeiC3+aqqK+KfmQXDKN9TtJ0Hk=
X-Received: by 2002:a17:902:fd8c:b0:2cc:864b:539 with SMTP id d9443c01a7336-2d64addb782mr28590615ad.6.1787258872668;
        Thu, 20 Aug 2026 13:47:52 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:89bc:48d2:9457:6223? ([2620:10d:c090:500::6:c5ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf1970b0sm19741155eec.29.2026.08.20.13.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 13:47:52 -0700 (PDT)
Message-ID: <478fbefa108d7da8eb28897998857ab72467b276.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpftool: Don't drop a type in the
 sorted C dump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Date: Thu, 20 Aug 2026 13:47:50 -0700
In-Reply-To: <20260820000627.3826188-4-ihor.solodrai@linux.dev>
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
	 <20260820000627.3826188-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-19 at 17:06 -0700, Ihor Solodrai wrote:
> The C dump sorts types by default, so that generated headers are
> diffable. The sorted dump emits one type fewer than the unsorted dump
> of the same BTF.
>=20
> dump_btf_c() starts its loop at index 1 to skip the void type at BTF
> type ID 0. That holds for the unsorted dump, where the array index is
> the type ID, but not after qsort(): position 0 is then the lowest ranked
> type, and btf_type_rank() ranks an anonymous enum 0 while void takes the
> default rank of 10. So the enum is skipped, and void is emitted instead
> as a no-op.
>=20
> Skip by type ID rather than by position.
>=20
> Fixes: 94133cf24bb3 ("bpftool: Introduce btf c dump sorting")
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
