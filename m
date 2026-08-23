Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDBE29B78F
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787515522; cv=pass; b=rstvFHNaDQO6EDYBEDBmdDu7yEzL/V09pQC0WHRMJSzFWOilWjJIDj0pwoIHZh2A83vGaMAHxaFj4Ix1g3j7uhYmanl581N3FNw+r25UBqFd0KCL06sMLx3OIcjX7aOONSO4s/SW3UeRqIvE7XBhzp3Rrb8LR4iARbiiHol5QYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787515522; c=relaxed/simple;
	bh=/6BI5WubpMDqx8+ZQ3ft70NuBXZgnd1gABzZNFUcAeA=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hfu4d0SSrF8CRs5ck+vQFy1HxM8GQQsYdMJvD9I0qWRFbGCXgG7eBL3EAmmQVZ0y6WLqiBKVjC3GiCy1jtJipS/MAYElr3CbOTOEZAHcXb5HLkDQFEVnGjnfjWIDYKI/j1Xm12By9qiRkdBv9srjT6iuHCeiqpmkeme5JquDpLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1PALAoz; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1PALAoz"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c5a818a3d6so2178894e0c.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 13:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787515519; cv=none;
        d=google.com; s=arc-20260327;
        b=rCOdlI7WKiOb1Mo95a0JdymTVAZZj4LC3mbC/UVGZJhnHijubH/37UAH4Nm3qB815U
         7vyGsx2qizhhL5yaBx4A6dQP3cwfeif9Zggk9iIgto+yv3qtiCjdsoXOW2B9dk0JjeA6
         CUX8u8WZf6vg18MgGrwcbHDllBAFByNuWoUsTUH3Jkxrza1PMKUNYQ6d9eJhFeehyLS8
         Y5sFHFh3X8L5UTrUdVufLzCB84t+RlicTivA9P0tsvJeJ7vEkB4kF+0G85gSDoWSjPVQ
         fw34kfZegFqzvl05jDrya1oImrd+WQcgwG6kowVG3d43lSSN5o588lSmHIR5psQSeWTr
         29tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=/6BI5WubpMDqx8+ZQ3ft70NuBXZgnd1gABzZNFUcAeA=;
        fh=gfPqSG0LBBDiK0+Lwb0mRmE9tV4Cc8oUHLQ+DV1GW9I=;
        b=QiONuCR2WTJ3VIys8mBdEj4JTY+LbZFBS0BV4toDAVwv8EJLC170mzMZ2uzKrUMr52
         G6bmS+V+pRpd6wbAK2qCM0L6fPABONulpAjSLqR1gQPJEnHZStbHOaQlZVFudhk/Hend
         2gIOhQ+Qb4p2aRRWLMP9xCoolvOOyvy7/PHO1zw2Qd+tNteBBW1ykPUOK7IgVNxiq+RP
         YgnFTYuQNG5kyx1IQdPZpupxIdQ+zLX7etQfRxAmXr/FldX68a/8nNdgw7EWEwMJWtYa
         irm+cFa8F1rP4qIl4GgVnSFdQcmvG3ZdlR+Ur4Tr16E9s/RubZN1fernL1zlXUQ+PTRn
         2c7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787515519; x=1788120319; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6BI5WubpMDqx8+ZQ3ft70NuBXZgnd1gABzZNFUcAeA=;
        b=g1PALAoz/aV9m5TLTJ0wNVrvvpQMYdo8l8mSMFnJsYf17VYzCaHIXbs+tB1T+JgBNm
         pf5tM0GiGz7CQeFKcrGYO+Z9g0EbduSIN/aOgiieZ2cBUDNetf0Vngz0oQPdS8luj6Lr
         hifp/eN3xTj5keKmi+0uQJNJeHf0hghh6c3twO+BELqsTsE6epvJeRoLn5bTpBvYcY1a
         FsakluQKfbz3oBsxa1VwnilSm/geYCfpT8rfzzEHOOY+JMfR/fQ+Bg6CJQ26YYBa2xJb
         oCluEHxWHGSyDPJfgX3u1KE8KPKZzKAEU+/Ef4NKmDZI0MX+yuOw72ZqW5LOk+NPXgV7
         xeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787515519; x=1788120319;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/6BI5WubpMDqx8+ZQ3ft70NuBXZgnd1gABzZNFUcAeA=;
        b=B+y3mYot8LM3b8EodXCtaM3TC4VKgKYLlSBRqpTBdhj0cXMl2ed34wNWAzgQaz+mtT
         OQoqiyxaCmgZ2WJjWr7ECM9f0HYH4gEWcNYNPM+AXTG0bzZDJ/uzKddEz5AhnjCJnNUU
         CzbOjEIBwQnw1TxqkjzdvDCTeGiBw8Ens9rk30g+ArqX7PT28PLvyQb0we9I5EA5jIe1
         RIhrniM8aox61M/8YQ1SYCiYDNUolsC6AKLS0o4I90Hs8AGZxpDXiQHM44syXrkO3ahX
         3FASrD8caNVMIZQM2w64uT8lpuKEJRshsbg2PTudlTmCNu0mD/t2uYJL/NObeTQcLWLH
         Fz9Q==
X-Forwarded-Encrypted: i=1; AHgh+RoUbzla/IHQsqZm+FP9htM0lPUYHJehoJuFmoqjGPlDJaoN4QsGTg9M8ztcd7+S9wAmH/o=@vger.kernel.org
X-Gm-Message-State: AFuF++m46k93UN8CKJwDrl9wKe3BmH7sn1SyNEk6cr1kcih+u8T3C5Ns
	VibWD6oBgX7XFM0e/WXHsbl3cJWuGXrznVypH8+Koha2CsmgJoEdUvagTHEHUaIqyTZKlLNu2/c
	U3JrU/eJXi1CSz+Nhe7Fp2qL81BAOcr4q1GX6
X-Gm-Gg: AR+sD12/TQZy2Qox4C/v8+saLW5D8XbAq0GKpm8iBCifSETsDJi2ulsJxYAy9AIDPZ2
	LkLzOJSIiwrI2EDaGj4Xjka+xzMN8jCNqClrn4qRiTworatGb5BXpDNauj6+zV6F2LSdIWGk7GV
	edSTw04veEz6x4FiqJnqrQDqBPaVjFewJpAHeTumG6d6Sl/Qyl1PzOLdziX7FdzepajMrRaRpa6
	CphsYhPxqSHkMBpYEEE9QNeaGz4ZE1M4BeQ0B6tB4O5pqPtataJuSE4aMBHry+XEveGm+iLSDIl
	U+QzFSaGX7G6Dq4pVKLe6HBEW8Vz42oJeYy5Ii/mxMPDKczWDkG6fSUlKTO6MZUtf6gks2fOB7h
	gIkXV3KtABn+kmOUf9sJqS1I7corK67lNWmtrjGakiY6BITTaH575OQrctzY=
X-Received: by 2002:a05:6102:94d:b0:77b:2ce5:76bc with SMTP id
 ada2fe7eead31-77b2cf4bcc8mr6924268137.13.1787515519619; Sun, 23 Aug 2026
 13:05:19 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 23 Aug 2026 15:05:18 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 23 Aug 2026 15:05:09 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Seunghyeon Lee <hyeon3125@gmail.com>
In-Reply-To: <CACvzRyD2ScyBt-6eS2FoWPRN5o1ZK-4RYruKY0k7QTSuohzbzA@mail.gmail.com>
References: <178004391665.3522.4865582628003357086@gmail.com>
 <DIVM9YXYJV5N.2TEM951JWKD95@gmail.com> <CACvzRyD2ScyBt-6eS2FoWPRN5o1ZK-4RYruKY0k7QTSuohzbzA@mail.gmail.com>
Date: Sun, 23 Aug 2026 15:05:18 -0500
X-Gm-Features: AcwNN1VVzOLXmYUMTZaDhf53TltwgqgNHoMGCRjqFXI5xAW8B6dzhkStrde48yU
Message-ID: <CACvzRyBgKYf+r+hFUOi8z8EebOHzXMXGVRTnRw1kNJ+QiB5BUA@mail.gmail.com>
Subject: Re: [PATCH RFC] bpf: add DAG fast-path in verifier to skip redundant
 state pruning
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Alexei, Daniel, Eduard,

A brief ping on the follow-up below. I may have missed newer work: has
the transfer + join prototype been posted somewhere public, and would
the tnum x cnum Kani model be useful to compare against it?

A one-line pointer, or "already covered / not useful", would be enough
for me to decide whether to continue or stop here.

Thanks,
Seunghyeon
