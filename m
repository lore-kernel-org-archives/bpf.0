Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D793362149
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778339; cv=none; b=oxA7UMmyx6SNwIph+orOmEJwtmbdBd99sA3YblPf9/IUBsyi/hPVw+GUqeBYQHffwP1XFk1cDNd3BFsg8+cue1u8GJ2xIE3XcPxqps9VVgLorP6pF09RtS/Oms2fsvxEcV4tKfTOap52Qtuz2fCCelZKmepWRn68cGLAXSIpGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778339; c=relaxed/simple;
	bh=arSEEFXFQVdqCW0J+7+aF8D80655DPiP8sYSGDClKlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXggAlJVUfNFwb9gnRu9cbcTOagbgDQymlq2enhOIX13IliGdAAXIxb4awEdb3bQgRZhS1WmEA2DvnZvRkP8ZskfzEtLGjEbCDMirDPKJBgVndan8E4iLA66rVaNusy69rxicNbltaxrz3AIwse1rFJ6QXHkhgPtpzJC11FtiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B+XyUiFD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B+XyUiFD"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15f47e6297so22676766b.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784778335; x=1785383135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wvdorMdSMyG6e2Iuu6rHoLJQpWLzhl4z4BJUQ5L+CIQ=;
        b=B+XyUiFDNiK2CJWCk+Aa66iUsAjRyjYKz99uU19n0oH7pHbIMPaP7Qj8hMVXj/dgAQ
         7ipvHdUBtvadVEFvBpELtU6DJKUOW5ocVNUcEHH33fGEY78VA76U2ny7ZE5UmRZWFK87
         g89mswajwakEqXtWhV90BVOt+RYfli5tIpJ1zgR0vpEqUJ7nAWUfT6NmGj25YlKY/1EI
         wlxJy0jZUx/nfiZ+puV/5nQQgb5dXbvzdJXB6Z4dlo9wG92vdWOMObZN9fOFXAXQfiLo
         r9pDBPzuQtGDF/gcTV1fAI2PQEAnIahORf8c3L7jQFGTpaQuDBqGUcSm05UxfpbB5vGt
         K5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778335; x=1785383135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wvdorMdSMyG6e2Iuu6rHoLJQpWLzhl4z4BJUQ5L+CIQ=;
        b=JzWZHl8FTQ6oVRwgMP3peoNxW6NTW+hJv0kUZC4BUbPm0QqP5RohssJmHcWi3RSL8v
         PjFuv5QIQb1zadul/Dpj/iOdDGp/VvRvgBaFPAuMLPB6LadV07TPikoCTFo96GyW9ksR
         T4u9C7D9x/YE03Mkk9kBbCh06qpmu93JEhE4FzaxtggsDJCDTJLbGWNIAK3cRAjDMjkk
         HVMt55MljGotzGA658GtEs9PQghMKgOeChfNg7xdbnVYtEFIoGidmG2+L2fwnIhwx0Wf
         iGMrhGhC3UorJlrF0uUBzEbgPYwj3JL2jEkwv6umE33526YCMVQfRyb0gCtqeoeAXSoQ
         6S7A==
X-Forwarded-Encrypted: i=1; AHgh+RqfvmcKuIJW9Dw28knaxr2DfYW/feJ40Vx8kDxKC+3mYtKhsv0M72SdJ8RebvC45KAThAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsP37ysT7MlyTC9IYyxFU70LzmOyNc+e1QqHngJM5wnBw1BG7X
	xbQ0ikTToq9UfTB8SgFySh4eKPplj6lW/HS0ZbsstCylZxWMd1oXe1Mt8QaWb6uSn3g=
X-Gm-Gg: AR+sD13qLWNOmtxUR1J5oI0h71YZ80v38AYSHssAVTe4nRM8SMKKLUPgt67pQ5lA2Rg
	C0scKU3Ijx/mDMIC9MwfIMhho8gATYipCNIeV4IX3bewGs5vKj76/Wh3rXhpAGqhzMfAJ63H3ti
	L12fNCroFIIr7QnD/VTxstaCDhjfU5ZBeaRxOkCPwLhFlaamn7AYT/h/4ib4EKQXrCV6sVFLdF3
	lA7mgQOb4iglmYPSadj1mscATvSWi9Tv/VahYON3a2f6iV2RfYrE0s2lTCrpsgwI/IxrVnHliUp
	9v7fK87T19CNNdQXiK5bHP5nYs9nAgPb41SFUwnqvzF4Fv1J5f9rVzUWR2wn0MdIWfllvSq1LW9
	WgZA3X1ot43YSsUBxwIyrwT7o3/82ol/uaaQpv4AkEz94H9gsT1q+UzU/hwuoDrEzl2ZY7c5VFk
	K6CVWc7FyiwCLtlBNA//0=
X-Received: by 2002:a17:907:8dcf:b0:c16:9ca5:e551 with SMTP id a640c23a62f3a-c1c50783c3emr55161966b.14.1784778335399;
        Wed, 22 Jul 2026 20:45:35 -0700 (PDT)
Received: from u94a (27-53-97-40.adsl.fetnet.net. [27.53.97.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd88f7sm24726105ad.22.2026.07.22.20.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:45:34 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:45:26 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Preserve pointer state for commuted
 arithmetic
Message-ID: <amGN9sUvWFi3xfle@u94a>
References: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
 <004a83de52a36e9f3acd6c3fa2d0dfd0a013460d.1784696372.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004a83de52a36e9f3acd6c3fa2d0dfd0a013460d.1784696372.git.chenyy23@mails.tsinghua.edu.cn>

Oops, missed there was already v3 yesterday. Reposting comments here.

On Wed, Jul 22, 2026 at 05:27:31AM +0000, Yiyang Chen wrote:
> When scalar += pointer is handled in adjust_ptr_min_max_vals(), the
> destination register inherits the pointer state from the source pointer.
> Copying only selected fields is fragile because pointer provenance is
> tracked by several bpf_reg_state fields.
> 
> Use verifier-env scratch storage to preserve the scalar operand while
> replacing the destination with the full pointer state. This preserves the
> frame number for PTR_TO_STACK registers and keeps parent identity fields
> consistent.
> 
> Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")

Nit: This doesn't look right. Without bpf2bpf there is just one frame,
hence there isn't a bug at this point. I think the commit f4d7e40a5b71
("bpf: introduce function calls (verification)") the you mentioned in v1
should be used here instead.

[...]
