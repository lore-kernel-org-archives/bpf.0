Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E233F58B
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154276; cv=none; b=jOxKF3aILo+cs3EubNsAWu4vLcvLOa05ZccC7R/aEFjp0p/RKMmtdaPdubzA6OwclhZwoQ5vH7FTSZVberBI1GRjbPzIXmikhkp9gkEl9YH07eYdPibyoP7AMqzmsUJNAgZLOs+R2yeeXKWUCcRg2B4cVGjsKbURBw3EvcajNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154276; c=relaxed/simple;
	bh=6UIQirELPadVMjM0vUy1/xS19vG9UcIUXiKx10fU0u0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHZag58s0kQtLVXYvqtbSBTFMvgfqFFi4p9+jdX+7/LruAuvJZ64pgyCF8Plsr1cA7/gENumia5sU3YljScxyp4HPSkSzRpCUlY97aRIi6MaXqst3V9jOYZ1prphAgoRRCZUyf2sx7g/56N4NVSEesNHk168ze4JNqloQraTZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeP4nh0L; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeP4nh0L"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-139a5f4ca15so3342919c88.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782154274; x=1782759074; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6UIQirELPadVMjM0vUy1/xS19vG9UcIUXiKx10fU0u0=;
        b=VeP4nh0LzHki/gljTQ5NRvRV5oYNZY61x2h6AXttAp4J8B3P8LqCh0VKTfwtfqPsc8
         hihRlFishlhVUoSB64AjJdJxiuugTTX53hplFbAvVkCDuM0COJZ9dpEH/wfuu2QthdjV
         24mrQuMsO6g/4oCwFuLZE3vmHZDy/gsHR/pIlUMMVPH4yk1RLE3yPgM7oaALGSNpHoy2
         5r1C5AW8Rn3Phh0vD7DEMC3ATlEw0UOdyI2gUn+W6NC6Ako4diXrCFU1WanVdlqhLyVg
         AmhnpNjchMZM1/Nqh9JtpRF1j6HVQAHj9fEm2+yGP3qdj00SUJ5+DubqoODzF99JYyNX
         ckWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154274; x=1782759074;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UIQirELPadVMjM0vUy1/xS19vG9UcIUXiKx10fU0u0=;
        b=cEwYjMuOY3+7w8Y91DiCDxZ5TKRrgwk04oXjPzDHPyVvfI/lO+grlcwqgK0iYJglLy
         c223gx25IivmPWeDNL/JrEeED4YnZKJrucLbP3Po+fYZURhdBAKLXugUnrx3f/gIDcT2
         MwQO7C0DElM2nPQociaBLZ0NcEFJYT3nlMNeyjNLz55tl93spFZRwKO22hfwJ98aK6lS
         hzQzbf20Cry2EldpEQppkKyHS87XoZWDhhZcTS+w7B1+FsBCGxPVvSt+eHtQiKB5kYfh
         /zcfOA09ie6KWTlCmPM/iKX3EeH6vOvNlCaw2ZR/MR2MNrD2700bALUbUI+yfxRoKc5z
         NwKA==
X-Forwarded-Encrypted: i=1; AFNElJ8rZlOLl57isAB/y/TYi2bvlY0jhmsnjBVukbinhVdzNr2kaHz8OoG84834jVDAQtLW0Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi56T4YEb8PPOKBp08zIPB8D+PK/PnPWpflZJlsT3SFL1zlay9
	ESGbkVKUuYuFOoHpqHQ+b8cnznO5b9S2BOaa7va8Iy3W8bK67+ogGDtq
X-Gm-Gg: AfdE7clw64RtsKjyK1LhAP+jF4pxjIgIK5NfYKEJlyVdfBM/zQaq/WwZsotfZkr1xf0
	2oHyymN31utrTpndKDazzhVr2PxRNykojI907V+FfY8Mn4kFWHADZi0Tva6leNrqG+giuhqDTGs
	Ipgy4y64jbWSNhtxS/Tde2H9z3mthf8Ula5g+edYkrdw4ZVukW3BxxWj0lASdzXXj64IooFGNU0
	w0HNRDUHQDRpGpivGp1Rnbmuk0xNx2Yqlpnv1F1iKAMsKWQdGwCNeWEai8EjFp3FRoTXBJAkACY
	5wslElRR0ZW+gKfGLLmTSY/WlPV4TpAtCNwRZf+Izto8O1FSxnRCEkDEoSi3mgMAGq4ZsedA00V
	Uvatlhxa6dlNbpP73UBXrDcCVfws5ghZSnB8FrXCpVzonvaH86WW/R6rmcQ+t+1OaIttG2x0hQq
	ejbIk2ZtZMiVbaXqpsQrvUAJVgy72TRuOS6NNotPMTVu4LCHBRne3Tc3ObHGNWRs/3z1Q=
X-Received: by 2002:a05:7022:ff44:b0:136:5c88:d917 with SMTP id a92af1059eb24-139a34dbbaamr8472687c88.2.1782154274017;
        Mon, 22 Jun 2026 11:51:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:6e2:c699:67c:63fe? ([2620:10d:c090:500::1:5387])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcc5f14sm9247956c88.6.2026.06.22.11.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 11:51:13 -0700 (PDT)
Message-ID: <935a7c6dd40466aca387d270c233ce9a8fa4eea1.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover flexible-array
 allocation rejection
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Jun 2026 11:51:11 -0700
In-Reply-To: <5b0ecdf774f8f5de5c1d8ecd56368720afb5a14d.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
	 <5b0ecdf774f8f5de5c1d8ecd56368720afb5a14d.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 04:56 +0000, Yiyang Chen wrote:
> Add a linked_list negative loader case for a program-BTF type whose last
> member is a zero-length flexible array. The program writes through the
> first flexible-array element so an incorrect allocation-time acceptance
> would leave the verifier to approve an access outside the allocated objec=
t.
>=20
> Use the explicit _impl kfunc forms in this negative test so the case is
> scoped to the allocation type check and not to implicit kfunc wrapper
> resolution.
>=20
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
