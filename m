Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06913546F7
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782347790; cv=none; b=K4BPywI+OPMS6jmXkX+FT7eCSQehFO2hj72qKfMc2n/JFhbu7rQ/3ZoJnD1uLCgC8YHWaVSkvHS1QiJo8qutRhOevYsAHAf2s5l1R7Fa7GpLD6MIC8pKh0aVYVBAO8DLFezTCPckEUB1zVscnkAjnsoPP69tx3hHuWIVc6ZTwjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782347790; c=relaxed/simple;
	bh=UWBUZ6Tvh/iLP1B9hEs6D3T8vKBDn26N+TPn4M/aH8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uUTyS8bBxcpnHczoQ1n62k3hmNSOU/5KY5w78esvVRoFrbqZDXkbI1FfJHb5pSbME2P9mnGnOS87pg9WCDy+fkswItQCFIO4RW1VpeGTpQcPs8jzfN6JA8CZvsqUCOIwaCDQT0MXGR9pEURAeZn18q3EookKMli0GB7iCm17ifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYYxIy8t; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYYxIy8t"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8894387780so613771a12.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 17:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782347780; x=1782952580; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UWBUZ6Tvh/iLP1B9hEs6D3T8vKBDn26N+TPn4M/aH8I=;
        b=BYYxIy8tukEtyrD8N+lHOgeRnPwBdDLeprpuSEQ4GodGzvZ280p8NxO7+zZV5Z5mAc
         nNR6tcbTsTQp3FVVTY33NSmgAbRgvj8lU1J47QMoSdXOOkz4VcjsYFFE19aPvHAZM998
         m9pDFC/+N5Le2PUnZQjcFTI7+MQBRnUGp3k9YmV59QWVTA56nRe23e+CDZRg5bBkPSTC
         Aa759BkUFI7T3dtjPyqf1fm2k3hYzt7CcEoIEvn1TxRrwgm7MFhwKyW7Axh+8vf0tg+C
         xNI3gAal7IRY40s1m2jxNS7+v5+liQOqhkWnaaWFScNi1s1IbFocS1Q+GiYohvk+5sp9
         AnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782347780; x=1782952580;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWBUZ6Tvh/iLP1B9hEs6D3T8vKBDn26N+TPn4M/aH8I=;
        b=Lfdy82CMjF+LuctSo3LaHdz9QU1dKNLmd3ZM1Lg63B+zp17luqYsBq52R8btFBsCjJ
         CaHSLTQ4uhQj5XRHnn3e5Q0zsFNpWQU82jqanHqrfqdXgcEtmVLHWwmVGthvIl3cd+pF
         3J6Ds8jzXWAYlStu6Nt9G+HCxNsHgZY0a4z0ikbwsI1HrGuI/TuM3NMDzTOKqfUCCcDn
         2aSie3jv8xG+y5+MB8bV7B3xOuyo+gypiqxiVKIZX65O8oMi0T40t6TMRvVH+SYuCA2r
         CJd0MMsPnqrHOrIKWu7EBg2K5BltSEcwmD+IwADYEODz9SAPbZl36Q1Zvg9yVKPD4csH
         fRkw==
X-Forwarded-Encrypted: i=1; AFNElJ/ihHlu43paI0fDDCmOXNd8jLsCh33SDALz9Fx+s0a0iKY2rl3CdVTfYBW/UHlY9Xm4hTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZbysOujrPO3gkHndE37XLbR/cv4YQ90Y2RlNVNnvd9FTrW+Q
	0v2WXDzOzsvLzEmPMRv4i3bhYMqqPsIgDFU0+bt8ALdSpYLrU3hpSU+U
X-Gm-Gg: AfdE7cmkfrlbqbmOQeaKacGi04N39Zp7bjXpxePctInn+4GnvZQng3gtTfo3kd7TLi/
	smKzWIPVLhKwTqAaFkC36o4hiYRzPUiiruimsAMwjGbuirnNC4N+scPEZWDjrdbw9GmTkUF2JUp
	pgNWRGp21ebae7VFlH2bH21NXlto0PR5LEv3frq0B44E2a3OGo9celtA9thiSX4CvrpfF9zL6o4
	mr7742NlnUi7huGPHNSbFa7NGf5Ttlf4ZbVw0//q3vQJ3SxiJa/HZCuFQOi1hesp5t7wU5UwUEU
	Z0i+FOl9iJHczs5IRyWrbGYEXKTWnjYWDCo2qLQLQf7ID96u7Jlb9cXTSNQfMzi4dR6ON7jc8LN
	HExwh7VkRkHUl01zOL9OyIMo6txKZRlwU8FKEepMgou7LBFI2nWPxcRfFHMXzWbkEFUbFYc+Gf/
	hHzXCpiajcNrgc+fVFU+xjzHzWMdDWuJEz+R5Dw6lhrg==
X-Received: by 2002:a05:6a20:d52c:b0:398:9662:10ff with SMTP id adf61e73a8af0-3bd4ac04201mr415040637.4.1782347780453;
        Wed, 24 Jun 2026 17:36:20 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b96ec0besm618620a12.1.2026.06.24.17.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:36:20 -0700 (PDT)
Message-ID: <689a679760f9acaee35e1d250aec2dfc6c57b4e9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 14/17] bpf: Report Policy helper and kfunc
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 24 Jun 2026 17:36:13 -0700
In-Reply-To: <20260619205934.1312876-15-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-15-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 22:59 +0200, Kumar Kartikeya Dwivedi wrote:
> Augment selected helper and kfunc allowability failures with Policy repor=
ts.
> These reports explain which requested operation is forbidden and why, wit=
hout
> adding path history for non-path-dependent policy checks.
>=20
> Cover unprivileged bpf2bpf and kfunc use, helper program-type restriction=
s,
> GPL-only helpers, helper-specific allow callbacks, kfunc allowability, an=
d
> destructive kfunc capability checks.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
