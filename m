Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB007492528
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563693; cv=none; b=XJf4nb2ze2oPa50wJ4KmiQGyVrxGG8SwrI7iMQdiuMvs/XRiNMkMe3NXDGvxvgEojnsMxwE8UioTVNdFXxWZf7G2X5FyPSWfmGGl6wsla5yajK6nKeHORUvDfFA8Nl3v8wZBBmdwMgPIPtRXhZBB1JGkEID5JiFRB8V4gbZFsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563693; c=relaxed/simple;
	bh=ttzqQEcVrPb/nmW7Y+klXQCF2FmI64whE3fDRja4xHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZ7ThQQYnLufV3EEt8va8u8RPHst2pKdg5pZ+4uCBMr/ErwOIampudeOsw6jXcgKwDfjxea3cXeGz8NAczEuKSL0MtzrbWbNZrTE5yc8tLB2tfC69DeCcAXD/huzbMqfJJn752r6225R6N9XBZTnTwnqnx4P6s1q8WC+eT1eP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=zm5leosn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="zm5leosn"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-824a3509a12so2764075b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 10:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772563690; x=1773168490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/gvGEJPIh9oms2y2n2+7WYpJ/cio0F68+jb7Mp93Es=;
        b=zm5leosnHjkYW8qnNHi3Vasu4XmWIklY8SJ2SMXSMzwKSHcu2M2L/PakC4owyAtP/Y
         2bdup48hepvbjVdSivCQRUwAGsFMQiPdwenjid0a5NylzS3w1CZmaixQfUf1eDNu9jW/
         Ca4GZvW3FTCEdW+Ijp3o7ds1OMJKinQoNr3gvNALVdMCkX3uaDRNtlkYixcefhAnHnyp
         dPlXVpKJu5Uhr1kV1D+MLEDPLRZYnGPw8UyfinDX3tZH4wiEbAtBoixHaaBWU9SYrt98
         4AGaVibPmTuAcJEfzU8mDfl4FAA147aKLAsjPtF95khhDuPbb5S8XqUBYb/CTWMNhXrO
         UTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563690; x=1773168490;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/gvGEJPIh9oms2y2n2+7WYpJ/cio0F68+jb7Mp93Es=;
        b=MOMUrRGnZnFsyiOTNKmVB8wmamTAK4fAQxNG+6BOUdgYUSr+iZFyyNj2wehxw/fSuR
         KdL72s9l9S/j09/5KeQ3beOeUQr6WOvOtRZq0143JaUlDZMer+muf1xeFw/g5SB9tiMf
         oJmpussZWd6BeIjZ59NiSpI9x6XTBxIwt3RNyOEIctpULrfpWmgxv62wN644DjhjKvXg
         rAVCsmgXgrmkE4axX7bi2NUucwyeIFULBCsYZtpIYeRASq/103Yu1wSP3p3ldJuU/4H6
         AYAWkTK4ugd/6GDi10NpdbvuApCitEkw/LLpNVIdKwXIvIBUU9eQLPIBcPU1cBFdBdeP
         YOXg==
X-Forwarded-Encrypted: i=1; AJvYcCXbwc7FMO62XCfTooOb/sVVJFERtlWh2p2LTJKqIQFurQrWk5dLoLKjwu1se8+721e2GJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYeGPVA+hmPHZVLaROVCQ/84i1Y9Xt8g1JwoQyZYNPk1csE+Jm
	Es7YqI075+WpASYERV0eFPe+lVZOY1Tl9hkCD0qTMQVykUJNldKzEiuF9w0aodoZliI=
X-Gm-Gg: ATEYQzyArJ2ZeZdFva2oZp60X4mZQApph/NqwIoL/iYIsvvTY85qTODuZiosDVvggxc
	I0HWJi7E2uEcy8t22BoLy7Eu+pFc+UKGgeTBFbBDbCHRheeJ/bUGs9eeSqc+4cZCfRrHNnMsLyT
	9KraVwgo7JP5TxrlILww7PE8cYI2xZAj/hwHZ44hdUNgUR206DgPmTtUzWuZHZra7yk+UKhlHPN
	ZpUMf4A15dXDPVf+vcN0R2lwsuGnXWRmgGF562GE9dfiS144p/l0gXZxk/sC0AvK+C481d08ieP
	AJVFstZd+Y2i3CCpeGbxTlarFvc/IiylkReVd39puhyPUmK5ory5uI1ycJx0VnaD3nu9dInESJ4
	WMhVNn9HaWN5JmUDity6b4omvJuLoo1Fic/t3h+S20QpYUQ+0mHGub8tGRLsVEPlzJMoN3ffXl2
	60n28A
X-Received: by 2002:a17:90b:2747:b0:340:bc27:97bd with SMTP id 98e67ed59e1d1-35965c3475bmr14809639a91.9.1772563690200;
        Tue, 03 Mar 2026 10:48:10 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c3abc40sm2916519a91.14.2026.03.03.10.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:48:09 -0800 (PST)
Date: Tue, 3 Mar 2026 10:48:08 -0800
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] selftests: net: move common xdp.py
 functions into lib
Message-ID: <aacs6Nli7ku7uuTn@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
References: <20260213192449.1294830-1-carges@cloudflare.com>
 <20260303024510.644962-1-carges@cloudflare.com>
 <20260303024510.644962-4-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303024510.644962-4-carges@cloudflare.com>

On Mon, Mar 02, 2026 at 08:43:51PM -0600, Chris J Arges wrote:
> This moves a few functions which can be useful to other python programs
> that manipulate XDP programs. This also refactors xdp.py to use the
> refactored functions.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  .../selftests/drivers/net/lib/py/__init__.py  |  2 +
>  tools/testing/selftests/drivers/net/xdp.py    | 95 +++++--------------
>  .../testing/selftests/net/lib/py/__init__.py  |  2 +
>  tools/testing/selftests/net/lib/py/bpf.py     | 68 +++++++++++++
>  4 files changed, 95 insertions(+), 72 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib/py/bpf.py

Took a quick look and it didn't seem like anything changed in this patch from
the last revision I reviewed:

Reviewed-by: Joe Damato <joe@dama.to>
