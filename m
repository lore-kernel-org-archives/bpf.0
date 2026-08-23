Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166A25C804
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511260; cv=none; b=m9weQdCuZux8Z0E2SzWSfeaQUD9lt+xPFKdzFZn0gKuAOnuH1AdxsLTUdw5YxAx3nkoALJTi4u2qJoQkrEX3UCEvWXtMtIDnExsq1naftzE/gkVJsonUNVqrkcpFtHbkMZhnmyUraTVCOu0AvDul4f/tMSFvBn86ma3XB3ZQLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511260; c=relaxed/simple;
	bh=QGPwbQ4RFM4EaJgg5t2IUxauRaW0e936TPPG7qaKduM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=lZc08ogFqO7yyeSDXb2Sk+YYvQzOQeRQ7OQsPd9WmSRWLHzXX3Wuum3dQ5JdwrwYf16m1DyiU0+fevyoBYDleDhNi5wxWZqAVYr/aPrdNi1XxSIrERsK5s+IFVi1NHxX/VSFjeHEojV0Iy1HOsybwnJIdPQoqPPzGwYaaRLhJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWffjTAY; arc=none smtp.client-ip=74.125.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWffjTAY"
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6a3e9930062so2010086a12.0
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787511253; x=1788116053; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QGPwbQ4RFM4EaJgg5t2IUxauRaW0e936TPPG7qaKduM=;
        b=bWffjTAYxPZbR0esfZA2xdnSwl20WaBzbr5X7DXqWm1flg1dcQuAZrVNqKFNB70JkA
         duYV811H8pwF5WgmC97/nck3wD7lpHnwDI9NOulqTRoCp3x5S1QAMQgtY1EjbE1mTh4k
         YjjxuOYpk4O3zjuswTnlMQaH6+nHfim5SNpgv4kdld3dxVUlg0Nvb74ai3eFuVQY3kIs
         POLON7e8VG/paE5aJ6hTdZpID2JAB8/fIk9VZOCLhMEVvNWs14A/DBiPpS/rd2iGERaT
         dt2LbXf6aABhayLiBFv3p+nCiu5lehXGeGTJaVJC9HffNI/M0Q9KwKWAv0c7FWOWNaVN
         +4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787511253; x=1788116053;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QGPwbQ4RFM4EaJgg5t2IUxauRaW0e936TPPG7qaKduM=;
        b=CJAFosXsbd7133J0FZRYjCqpjn2UTT2YlDoc23KeqZtpUYj2OZ9ial7v/XXzwXDdhR
         gWai48+PdzC1VxJmaqW4iDgyAfCx7KMUfGb0jKYlkF9cdUvhy0+4/miyKJLYRIPg9Rd5
         /yJK1u8oZhXblk2StoqtOXjGmkkp3GXamhm2V0qf6r/tnPsdhjkTkT80MDY1vm4ekvRX
         tPikcaJqntZf/IMQya+pQyMb5PLQOe353OyBvPayud5YsPG+hEZqzz22UaZEue8CNLhq
         5iN7OPeEOn5uqf/5tUefi5y5JGaS7VFg5JJHDjz2a/Lk56sX/b6apMcoAvDf5tzZhVIn
         ViHA==
X-Forwarded-Encrypted: i=1; AHgh+RqNdENpnHtUJ4+nHMDrou1DjSMgi8fXw5pN3BMHl0QYcZPLKgXZ83kwGWXXE4yIxTxxMNE=@vger.kernel.org
X-Gm-Message-State: AFuF++noK52XeE9p2pYsPTTWD+aKixfGxX1P4pYyjsPupH5QzXGrtIMX
	mD/WH4gCtLa9bgZcIl89/TfMnSlFFV/NF8w6QgV8MZ0yLwM3yJIGS35NVW17CiFS
X-Gm-Gg: AR+sD134Rf4dCHUvJWN7B43KfurHfQhdW6nT8OBSAe/kqPXQVqwHo0/lA3Cg5GBeel7
	/rZ70OFUAo8Ns/+B/Pu7zJqbVAMxzNecEr0dcZuTY967nULrCHp9EfK27DCAahW31jde+wcR52t
	IbpbZzftQlWpChwi1dD91qokox1rHSZRPzjL9m5f3JfAqc09SxFeogLi1zFX6UIMSBbBUX595aI
	Rhi8+3wmq0+To2ERF1DUU7iXlGMM33SywlZtETg3ALSx08UoQBupt24TntL8t+JCC1JIiDOuCWm
	ssdAei6OeyAS/cXqyIS4f+S2qBUmys+uHy5wo0cO5TWpj0J8+mJ0fYZTNzYSur39H6VYg4rf6rh
	2BHavC8IqheMWY8y3KZdDtk9gN1RG9Znu5vgbsYOqUwgVY3fL6IOdJdUTVt3sCULX6vIA2VJNZU
	OXVijCiiIyBm0+ASznhcnFFKfQ3Vemj+VNhoBGgWcb5w/1ezdEDE8yweOIzGvaFIDvhbyuCVhGh
	QWaQq9M6h6C5JNm5F8/kkqihTKcRyjIkiVAxzzOQo0t65Of+NHTbFX7QoviLIv9F8IoarDY4M6G
	0TOXnArnkGHKQ9ZO9oPxYISprEU=
X-Received: by 2002:a05:6402:504e:b0:6a1:7825:5230 with SMTP id 4fb4d7f45d1cf-6a42f248146mr24313322a12.16.1787511253194;
        Sun, 23 Aug 2026 11:54:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0228f1sm2350a12.10.2026.08.23.11.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 11:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Aug 2026 20:54:12 +0200
Message-Id: <DKWJUSVD8RPW.1KKZBOACJD99T@gmail.com>
Subject: Re: [PATCH] libbpf: Ignore exception frame section
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tw" <tw19881113@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260823092057.82200-1-tw19881113@gmail.com>
In-Reply-To: <20260823092057.82200-1-tw19881113@gmail.com>

On Sun Aug 23, 2026 at 11:20 AM CEST, Tw wrote:
> Exception handing should not be the interest yet, let's skip it.
> BTW, I found this when building BPF with Zig compiler[1].
>

Please write a more meaningful commit message. "should not be the interest =
yet"?

> [1]: https://github.com/tw4452852/bb
>
> Signed-off-by: Tw <tw19881113@gmail.com>

Please use your full real name.

> Change-Id: I5ee6c05bd8a684261c53effe9c95d9f26a6a6964

Drop this.

pw-bot: cr
