Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A327F2857F0
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104179; cv=none; b=MwAutabnRyWF9H3xyJ5rAdBxjkKwsIClbbOGtkWvHclpSLiJ4i89AbCQ0ZqwGh6bGo2Nt4QL/h/GAz6Bw8Zdhs5SBsJgdvEeQchLMH7ovKZkPBlcHb9YgwLja4RnfayI/t1EbEcAnLfQ1VSPi72xHR1TnxdTxFI7Be/QNICTejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104179; c=relaxed/simple;
	bh=s92oNkNafdfctXObvGE8NO7WzoqZ9IG1GiDPjJn/QNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFT9KxbLSah/RWkEAtuSHHFeuehIDvZZeL8U2r/5jfzOFDFI56EhGLjUH8UurQSxjtlfF2us9SZEoSmCAn3JhYJUAeSIo3YqHXcqhQxehAJbWq/QsAVheB1MMlE/6MPW/gjsDDuRXnk42838+y4avKywU8WCbCWb8rr5GfaZvtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=niT0J8ON; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="niT0J8ON"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3598b95ad7dso6653450a91.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 17:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773104177; x=1773708977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJEBP0vpmZGuD2IAuFkbf5IyeDyevKXoGpCUDihNGFI=;
        b=niT0J8ONWOM5X9QsHidoXN6qlgqpVY14B/BCbo4RSGfsOGflrQRKWu8Olq28x0IvdT
         vb6e6AbAcmr9Y3XjELLTlMTjJk2B7bHS2+qIyEwWeyyGX7UB0O/g1vw/e8XBw7PplaQX
         XU7Ofi+gLC0KeNs10PTDAofpxtTkGdKL+Gbg5D1eGTLJivHJcnreKfsVLTTyyBaudfUs
         4hkTghxjC95RZJQ712bRilDjqcADxLq3X3DCCdKcaipMrgRAaMZUcBPOi3pSurBNZmZR
         /Tk0nPLnnzAtM3GYkKZtXcLNI21WRVnGeXqv17t37G3TtNKtreJPXBiISWpcAXEbJvSY
         ZLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773104177; x=1773708977;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJEBP0vpmZGuD2IAuFkbf5IyeDyevKXoGpCUDihNGFI=;
        b=uf3GCCeWLLXLD3jltjd26hcXsiXa6LkZBwpTeP7euXoK566ZHngJPYYHXHfgrWxLOP
         oZSYKhhCK9AxJIkRJy4zkTm9OYtHYtczrr1oD9wpUWssHytvZ7x+06MGhldpJie0/qo4
         DGWd5CFh5vzKa6bgnSDsIOUlpo1CzzUci4HALsuQyZDR5G3GksQ/lOxPGKT38Eo2k2/R
         QfRSrFSLsh9Wg0Q9F3NXPsS2JiVRtFhZ0uJZR9tgqV2JzNLRMUmYU4o1Ep26Ruh2VzZt
         fRf7OZJRw1T5DtFXHx64aTjpJZcgF06ieKPeDfu8MnLRg9TYVoJ5sTiFb/UMrsYrigpU
         Ki4A==
X-Forwarded-Encrypted: i=1; AJvYcCUylfGCkYJl7ATm7gJZyYPUHq0ma71EJMRHjReH7Ly8DABhRvJyXiPnFJfL8cGLfpJwAqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3eej5TNjlSBbZZ+BpsXIQ4uI8D01XdmbRTII895opf6xE0fJ8
	QPRD+j67nocMGJiL6e9dV+nom47VZRp1+SRUGVHti2dXwTprPAp5O6pgaKKUdDHPoFw=
X-Gm-Gg: ATEYQzw3uzUzPdgT/M6NUA42AlIoEMsHjLoUI+hj5j6JpoMsVhxaODpH+70l9ihEHiq
	qw4IHVBDXatOMvenDzoWmkxc5QNVCFvjPrlgDR1kEAiujfmNnuRGVe6S+RFLe+vaY7X3EpWctJL
	SzQLDsjPXLkgQjGQVC4Y2UjWCz56+3Ey6CnEtHdAH0fWkc5AIKY97DzYFczWZVRNtu5vs9CojaE
	MCwSnwB1xte9o9zDsOIIKQkDkcI87IqX/dP3lOhRe4UmfT6MSnOkwDiJM5x1iTCc+OBrlnS0A1f
	K0ib8AuB21/xKSav/6xT3Xzd2DTK5oZNMQ4gDDTliXYr6/mQsmvhlNJuXkgN8qoIb6ocRdq9Bn8
	8tjWOrC69H1nMX0SrR+0d0+WqmnheMw+tHL9SQfM95nHHR7TXcZiMG7CRpLfB0esAs49ZvzaEIu
	NP
X-Received: by 2002:a17:90b:2792:b0:359:7eb:d91d with SMTP id 98e67ed59e1d1-359be3861e3mr11145247a91.26.1773104177009;
        Mon, 09 Mar 2026 17:56:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bbac3c0asm4844336a91.0.2026.03.09.17.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:56:16 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:56:15 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/5] bnxt_en: Implement XDP RSS hash metadata
 extraction
Message-ID: <aa9sL/L3J4LVbybw@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-3-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-3-carges@cloudflare.com>

On Fri, Mar 06, 2026 at 05:00:17PM -0600, Chris J Arges wrote:
> Add support for extracting RSS hash values and hash types from hardware
> completion descriptors in XDP programs for bnxt_en.
> 
> Add IP_TYPE definition for determining if completion is ipv4 or ipv6. In
> addition add ITYPE_ICMP flag for identifying ICMP completions.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++
>  4 files changed, 57 insertions(+)

Looks unchanged from the v2, so:

Reviewed-by: Joe Damato <joe@dama.to>
