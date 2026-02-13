Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A634F256
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976608; cv=none; b=otpzWlnjZUTMODCUtl8fVQwl3n/prCj926dg7WqJ86U89kE9QRRKpmPNIaOYHpLQLd5QSR6yWQgO4w3gLh4+hegrkyrW+71A6qZOltNQbn8lZyDxrRNVyRHRvBfGiRnIdsH6ZkGFT8cWBDZsUui8PWKUMhN5krkUpAfXi1OV+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976608; c=relaxed/simple;
	bh=zAsZsQnQ1Z2ko4DjOSLeznDg/5At8mkjsLF/X7E5Ijg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=lWAe50PBq6mevv6NSwCxJBNzPlyIXHCmbo165e2HAq60BlMZHNqGGiKI+nTlZvQwIgTcZiuvRRp3qReEIgWXj5kv6Tpb2dYVTd8yaO0EupGhs5vUEC/ml3uK/9FkAgXmStqrXtLS+2mkQbpOSZN+eRKxroG3gwRu00KaVq82Nc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uy/pur07; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uy/pur07"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 94F4CC237F8;
	Fri, 13 Feb 2026 09:56:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7FF4606CC;
	Fri, 13 Feb 2026 09:56:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 926A010368E39;
	Fri, 13 Feb 2026 10:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770976603; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zAsZsQnQ1Z2ko4DjOSLeznDg/5At8mkjsLF/X7E5Ijg=;
	b=Uy/pur07IpJi/aDkx2v5cN6MJPeMq1nYolqnTlXW3W0pg4GL2m0dTqGCRGHIqbHTy5pVQy
	SUlDsSHXesiJatw2pZolUzBmz76aEodXI4G6aJPuZl9K/FVnuQt2INY/kNuR6+kj8go2zO
	eg6LFhFUMhEXBc60ZW0mbnm+pP3EscYNlFDIwT3DvOYUsR1k2a7vXovWmfycyRbxvLLRuI
	MPpfIC6JIrPLllTZxTCyDbhNajv+QC7XYvYxrP4FnOmKGKKQ4TfhGMEI7wZhVzf0Hg8V9l
	cswKTjkdCXSCKb0RnXboEdCca7bWufFlYb5NHjAvMyDN+VlVbaFsVExd+8DU1A==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 10:56:39 +0100
Message-Id: <DGDQT62A8859.2EKJ8YQGJIH3R@bootlin.com>
Subject: Re: [PATCH bpf-next v1 04/14] selftests/bpf: Refactor
 bpf_get_ksyms() trace helper
Cc: "Amery Hung" <ameryhung@gmail.com>, "Mykyta Yatsenko"
 <yatsenko@meta.com>, =?utf-8?q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260212011356.3266753-5-ihor.solodrai@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ihor,

On Thu Feb 12, 2026 at 2:13 AM CET, Ihor Solodrai wrote:
> ASAN reported a memory leak in bpf_get_ksyms(): it allocates a struct
> ksyms internally and never frees it.
>
> Moe struct ksyms to trace_helpers.h and return it from the
> bpf_get_ksyms(), giving ownership to the caller. Add filtered_syms and
> filtered_cnt fields to the ksyms to hold the filtered array of
> symbols, previously returned by bpf_get_ksyms().

small typo: s/Moe/Move/g

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

