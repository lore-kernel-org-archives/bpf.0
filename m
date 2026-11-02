Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578379;
	b=RQ1kH66ITgCpPQAg/XsSVRLCGgsiW0niyTaT74kLesIdQWPuhx+/pfUHUVzI95Q50OSg
	 ZHAhNmfFcRevsuZhTNPqUh430+9LUsReqP9l7BUpThNLgV+Xf6o6xrJ+P+mNVjSZV1PVi
	 Mmk4HIpbhKnHz15hU9qJqRuccA9e1D+10eK9QxSyiREx7SPqTTVHvFc4SXfGSyHyGfYAi
	 A7A4AVCj4bd2inoIfVSetWmVLlD+PmBI3cvNqI+Kx4hrrAgjngPmlq/5DfnCwLCSTJnhp
	 p8S/1OsAvllWv1AWTxKmbo7j44xs3KSuAnqhlp5sAu0hu/J2UNQnokJzg16ovpkPXSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=r55ksc87JwXivuVN2gH+ISb2ZN/whXRaMO67zlj7Qq0=;
	b=MpRlsXDFF8uFZLfMZuoe9YBdVdqQJ4nA4Iuiw/oCeR1CrsrdT+qb+bx75Oua2s4pGc3Z
	 LVLPBtmxUJAWA0cZrFesJ9vkq1YVV2Afi7m+obuMGrACuNSNilW7ykWakaNAMWoO5s0vc
	 YtafkajHs8RgVsf38b3TRWvGC9KrjUUZwnXkegAxxsKRUahhsdIhrWjbQIsq3JWfmgSTq
	 M3alt0v3cVpa1pRvjz+ZT6bu3eFaqP2+0KOGc/VidYOzUshPT5kN7ps5Le6chbQN2azYY
	 PYnkNgX8qAD8qHjBlJbJRIpv8oAd/p7PWtnLVjFLeVLHo+8vB0PeXQmbtgrVeDyVfUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ls+rWigg;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E0606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 00:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 781E0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ls+rWigg
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ea138a3497so14273525ad.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 16:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793578379; x=1794183179; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r55ksc87JwXivuVN2gH+ISb2ZN/whXRaMO67zlj7Qq0=;
        b=Ls+rWiggSnDIvVbLZxsL0Xw54xHKJRwnQBLrePwZP2DwH6zX6ET7aw/Yq3IlEi5lHn
         jSl/6twBY0vl8+igVrSvExO+qlLMbevuK6tdmA3o08QIxd0AgXtu2eqyV5XbbEh6fmbx
         bAUhPMgDCODB3Nuoiu6NOJgA/8vI6eqLD3oZlfFnjQ0hv+FWOAwyC2N2fKOAfewDjq94
         ejiEIUJ3JqyuIITnfbtGnw91VSqrf15kOBfaI3tFNfMg93PoAGoG/D+SH379SrVns10H
         EVcejvYrNxhNOMl3XsSqwCpqUQPLjZsaNaEAom2pI6u8nAhG5Mj0bHD3Dmp5AG98stad
         /aFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578379; x=1794183179;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r55ksc87JwXivuVN2gH+ISb2ZN/whXRaMO67zlj7Qq0=;
        b=TOhaV6enml1VptrEm+yHi5Hr9KyOr/SmHu0Jp3c3N8rJOB54xfxSLdKXYIFh8c1K1K
         9XSrUglmo92IcPUZXhF87JlwDgyRDJjxlHQMpwiDyW7SFj1YE8cN/h4C+PDihUpsuNp6
         PsYhhuhFJz0QOODZQOkaIbpeZZgNNnhdY7d9sxZDCsppM42BUtVYp1M8UyVtoDbSXLCJ
         kXNGtEKVrlaftlxCZ+gBf3p3cibKdDqAtHTNjLouGegsFwHHqCOi/DjIBvlisCg7QvY/
         zw2vO4yr/CaDqpCHrYdTthNXFRmow8MZQnxM14kM04Kjghc7PKweiY3UTNK1hCkW1nXH
         iDtw==
X-Forwarded-Encrypted: i=1; AKwUvBwbPODoTXXLDY4ZfMWUvhEmWqJBNmfJlEupcvDnp2n+9ZMTaRX3t/bj4UPeD1kvqlbFPsA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DgGW0WMRe0GWHzde8H42HH1LtJQL+seF1xy9vs1pPRukZ7uGV
	vAwCpIr1ic48R/PYbJKn8W1IkCq6ImlS4o2NU9/0oMzpJ+m1NSmt12ok
X-Gm-Gg: AYBFou0nozB2GtBLZ0dBCeCQIPVBehaBMDqPFMkwZUd4i1TFe8smOacJ/m1xZSdnlBv
	nwzW6oEOGMTYg2zztAtqxjAXX5bjy5i5XkZFZpiq7/apfBXTyQJXaqMEvl1CRo4HoqlE50JvKxW
	NM9I/HRuKLNNp6qsXf30NTAvnuO8l1HanYUarv4aRpZR9Z167P3wlDN1Dwg1fIEf8VZZqHNf4Lr
	tdFOomkF/u7HU69Bwkq6dAR/e+UUF71w5Jj8zTL6pd5JgEIOdhZG7KVP/UO0s8fTlSqWq16rNa0
	8HObjmjFx3txQ1nG4VbmnOWeQxaZQyytyMggX0kp1FV6Ogwd8rkMvVJm1iP5aLob7yyApzt4G6J
	sapXQ1vuBp5yqt7SwPbJHN74vaDWSKgY5ne2Rma64ptGWlk3+ErkHMZeexT/rVBuokQKD2k4dm9
	VaVQOwmFekzUhT5uQe59iyst5/SK7mHWAsjnEDHD6ih27lzZy68aDsxCk9tLpR1JhaByyZmI14Q
	UBIuHwRTKPrwn2mVGY5I/DlWDQov0wlflwR8PEcNyR6TrJqIzi6f1vLHqLSEksA3SPfuYINokce
	Q573MDUUm8Y/6xdtMqpcV7Lv89v3ISA1HtpF/qylSoMZY64CM146fjRfyDcXIjFTFHvTbpIFJyF
	jilGuiJJGgflUce/pSWKDnxoBVzTB9w/MbA==
X-Received: by 2002:a17:90b:35d1:b0:3ae:8410:ae6a with SMTP id 98e67ed59e1d1-3ae897ccd18mr7190934a91.22.1793578378878;
        Sun, 01 Nov 2026 16:12:58 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm11401007a91.6.2026.11.01.16.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 16:12:58 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 00:12:57 +0000
Message-Id: <DMKAGZX7Z7PZ.32DXKAE6UIZNN@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <josef@toxicpanda.com>, <mason@kernel.org>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf 17/27] bpf: Set a dst for test runs of lwt_in progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <2f1f9e07591b012765b2ca2697e1aa4da38a03aef3e68122e86dc557beef0623@mail.kernel.org>
References: <20261101190535.1454146-18-alexei.starovoitov@gmail.com> <2f1f9e07591b012765b2ca2697e1aa4da38a03aef3e68122e86dc557beef0623@mail.kernel.org>
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

On Sun, Nov 01, 2026 at 11:38 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> TL;DR: Commit message only: the Fixes: tag may point at the wrong commit;
> cd3092c7f8db, which first let lwt_in progs call the helper in test runs, looks
> more accurate. Backport scope is the same either way.

no. the tag is correct.
