Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2163859E9
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599798; cv=none; b=gDv0kDGKi8lRYXeceqRB8xrXTpHtuE/S1YdwUqs77Xcyk/qDHL0pX0KTAubqZDdCg9bDsr7VmG1FYswf4VR4gu+tJrolBPmaBdEhyccxBzMYbhcx+ab3fjfAjYJ0bmtyirYAsVh9XbHtfUh3wpJPStsDnHNlTX6jpyZnKUi3Sko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599798; c=relaxed/simple;
	bh=zifGuOdN5ZevE3gymhi79C8oJCbhUeEMc9C6UEgU2/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OnBFkvTpZ6EJa8g+bd/IZu2dwBQjhmSJGHMyX0Yvwr8ftsHbtN4Zsm/mz8UM2Qw9U/RC6NSLQYB4UJ7321bf232gqUy70xXkAcoPA/7WkPWFYFg4ckmpgseN/c5SXbNgf1dUfsLSxJENpNRN9r33Vow8D6mwvqEpkFPV30qWAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNxIZAtH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNxIZAtH"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacf197759so50678965ad.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787599796; x=1788204596; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zifGuOdN5ZevE3gymhi79C8oJCbhUeEMc9C6UEgU2/s=;
        b=KNxIZAtHJ4rFirPA9Z9LWyDI+shZ6ivUTx9G4QsktAq1iLTqU8n41yCGquNhdFj9Cz
         3g5iRNRyg/dsHhxwslK+5fhsI0/0MWSFdFaRDdSlGxwY3Ra8eG97R6SfXQlLhU+5025v
         huc64uscYXIAvNMD97vdcdljnrM50MtuQI6/Nx5AfB+rQhbKj2+rZOGGdMGY+Layd2pV
         OLCAPRmpWgpyYuwxnRr980dcCbyBdd17yoYZlqCs1yEdxxepUSpSA8PsKGn0JgqFGqyT
         KlehUL9H6BcG9RaV5GyMtHtF9MF7WHb/1weWpp1nb+iemPWLM3xV05eKjqEpezXfnMgG
         6tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787599796; x=1788204596;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zifGuOdN5ZevE3gymhi79C8oJCbhUeEMc9C6UEgU2/s=;
        b=WqQ7VrQoNwDNp0jfSVeD14YGpjTFMFuiFjcAP0PGkv/AiGS8VEhTuw14rQz5aREWYN
         Ri1t5/k2JVMB5O3YS2R3XNYo/Qenajxy4cwQqA69favINmTtsiQX+OOt3IayoyOKytdv
         QSqukiJVL0KEzASamGJeYSchcnOE3LX4AFpDZDVuk1gMvZKHMup7Xc6ZPsAzQCkUtMn+
         EGs26Ha4LoZVvReNFKFMljk0xQYx1karu/pXxKh8bPMQcZd654rkuVwprpZPJ5QfsuUU
         INTiD8iE7Eq2kLE7OjYj6ykkuJaWMtUrd1gco5p0smpYrMaK0exL6sYP7rGMtezGxPDE
         ChOw==
X-Forwarded-Encrypted: i=1; AHgh+RokdRfK5dqa0cyUxZLa/Y6xFJtJy4hwO8Txko7PXYM8lJyKelKKPn5U1h/JusS1aBzwGXg=@vger.kernel.org
X-Gm-Message-State: AFuF++lN78t9TLuO0wDvUUoVvq0IVjLNMKNze5S00fDf9Pyn54nqXKte
	AzimAVLB6dzcL4f0mVFeRTe8ufHdwMTx5vdZT0OtUCktNa6Bzhiw5DGV
X-Gm-Gg: AR+sD10gim2I6rATj6sPiwxbKPVt90mLNZPREgNyOP2bv26XRwVXIEHChWd3t6GZQKY
	eZipvyq1PjMKHxxr4hO4UWvKu8ey4e+4htSq93BIGyv45RNvi7zqa+U9qJa8qajPK3MbxZIwOft
	BboWW1+o3MlJKZdXVSNXFfbrHpQgJTTJKaPZq/Mcuy2smus1ZrlXpmoH5i9xiRFlYWeBl41EpHx
	ezBFTTutlrYqb+N8FTKiq69hMzJJgimOC8AreZSIuYVCkcPXIlG814fPQ4HYXixJwpW7NvPa++R
	9WSn17fmv5oIfkIuGAhDfr2jHsEZRHHk8nmuz6vN21JfVwZQixzktIWHaTH6KRAAn8knq3RrTmk
	Zmyl64ZgXgLbz2ryF0iNWIHBOvuEi4mXo8RBoTqVCGOhqcossgsy0kKWLxyV7vA42nVVFz1R//e
	DKYkrshK0tB8U2ZtbrEgUv/9xfYT7excHvF05j50vrT1+WNbZLPypolCNN39JpOyogpnPvbNilB
	1uGRBCTVVlyY/t0KkvE+W+gP2zXrFVm+4pvlnah0OBbWA==
X-Received: by 2002:a17:902:d54a:b0:2d0:cc92:f7ae with SMTP id d9443c01a7336-2d6dcadc96emr31713895ad.3.1787599796444;
        Mon, 24 Aug 2026 12:29:56 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9209f51sm47284796eec.22.2026.08.24.12.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 12:29:56 -0700 (PDT)
Message-ID: <46c1cd1bc396ffce77024b1bb7e2bb8c81c20905.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Record each half of a paired return
 value in verifier diagnostics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Mon, 24 Aug 2026 12:29:54 -0700
In-Reply-To: <20260824144943.991316-1-yonghong.song@linux.dev>
References: <20260824144943.991316-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-24 at 07:49 -0700, Yonghong Song wrote:
> A subprogram returning more than 8 bytes comes back in the R0:R2 register
> pair, and prepare_func_exit() copies both registers into the caller. The
> diagnostic modification scope around that copy names only R0, so the writ=
e
> into R2 is never recorded.
>=20
> Fix it by opening a diagnostic modification scope for each return registe=
r.
> This way, both return registers are recorded.
>=20
> Fixes: 0630ad00d96d ("bpf: Add verifier support for 16-byte returns in R0=
: R2")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
