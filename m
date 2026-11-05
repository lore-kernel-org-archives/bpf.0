Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896388;
	b=BtJEDzi0SBSwc8V5NO/BPNYX0pnQDaYSJz4BRFq7WwQKyDlB7qkttRuSHL9B3HdVlHeq
	 APElAJD1J2HB8LEOBkJ27L1rah+OlRX3Evo9Mhoky1wHDQIKJk1CzKKt9vqXl8MBc2YYh
	 ev8tnOcExofYpUkUEh+i64wmCBJZVCgfRBxNfCEPEssrQqYvm9AOh9PKsoNljHLSJjv17
	 6uAHLdSn4AmMqsYO15+2EZc2QXveSgQX/fzS9NIyo2rsuyq6W8h/Q1rT7xRMbftAV4vLV
	 rzTkhV1Wq5NdADg0fLl4BSI+phzNdIrgiZ5hBnKpoz1VJqt5CpVNox9i+WFlib6NhDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=5Uc2g2hvaCFwQG9h609ltIsV/XoOq7CrvBoGftgfcXk=;
	b=FyFRcgAKnvYWB2khzB7WQ3jAVOy5vMiyw5czwaQGQEmI4G3nznn3ZVGMvXq8aA6E57TV
	 bFl0JlryWcMUsV491pO0Zm8N01hm/UoYPYI+y9kTE/LwcG44oAIPUtHLpET1ZWXK+sHia
	 7Qx1dPQXIirNqTGu6wLVk6YCmDbcwY5vQpIe4jdv9gJam3ETsZoDsvW7O4EmcXvOXFDeJ
	 +BRvy3wh75jaGo8PYCTrTG5DL8wvVV1L5LuvdCQc6vyN5a6GYVPQaIMOI9UkAB+3R93xF
	 B4Cjh1UMWIJZUgE7ZcRTEkaw0FU3/nlY0AZDt1SoLfBs1TsCk5TmRLKhLs0XuNGSfJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="D/E3eQMV";
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA867606F936
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 16:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA867606F936
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D/E3eQMV
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a058315c79so1171730b3a.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793896387; x=1794501187; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Uc2g2hvaCFwQG9h609ltIsV/XoOq7CrvBoGftgfcXk=;
        b=D/E3eQMVsSW/XtCiKS3wBT0/NIhunKT/gatNBDnPZ3dEiFBSYpUQbXW3VoO8NjGCTs
         YBKGaLmO33DxeHnSmViUJ6axr75REyBvyRowReJHqzHXvxH3XecapFelUb/MbSmO75Od
         o8XBdVZsDAXZ4V7ml55dbOFu3M56epfmT5FtkKgGYCBuQdqmkrWJnImjE7wXcFWeO5HT
         5lcA876DFq2W+/SMm61mBs87ArKUu4C4yh9fL1u3lQLRrpL2xx+qsTZvGKwhYL3mrdA1
         cA6WESiFtdrlNJ2XoIDM+kyezshg3z0YLGOljQBpEmYgvqZM4tVJ5AlTsr+BkHGn1kjS
         rKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896387; x=1794501187;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Uc2g2hvaCFwQG9h609ltIsV/XoOq7CrvBoGftgfcXk=;
        b=FSNFCL5jLROy8WbZDMNI+MknrRbx3BYYGdj5w7x631IexEjz3Ksfpb4H8AucAqe+3K
         u5Ni5J/zwGXdqtA003LMuo+LwZ3wn2VnTtltR9lW9RBftQEasZasikylnIqor9DAN1iI
         /NXZV6OA4A/Bezmgq+Qs3KqgXA3LOQvPdeXl5pF3orZ+CmRsiY43+ZaslK9SMQmSRauu
         WmmVUTKUNSBEnT15leSlVX72HIPo0uYOh4J8yuNynMMYD0v8s+slasKZF7LQKfSKk+Ei
         Nj1sGWUkdWQW3Mn0WXLkL9teNuYtsnmM+sRVa7qqnlmSHy/xrgOjqITh9Hc/M5FJhNj5
         LfQw==
X-Forwarded-Encrypted: i=1; AKwUvByhrHUlYQZ6ft+2C0st2TniwFhBixrF0iefgOyxTYlLpf6XU5J2zVH2K+4eGYpeUQOVg7w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Rfou/TEZrSu6IxHz2i9XnVFnTE6K4APTuzpjHa2Qsqej6j36r
	fOIrT8WcmYHayJsDM4fALjHJnITK8M33aBKI8cIJYtvQIiOTs3kJmNKI
X-Gm-Gg: AYBFou0RAanYAWwFm984Ij0+3m1DOyadmRa5Qwb2oIDM1D3qWIHhjpsYtAZJ5NJLQvM
	JBD/qQd5IFc5UIrL1dOK9SKnOggT14c1P7lmSKZAAMnJdmJuQyzScOgN2y9P/YMPa5IlNOza5Dh
	GuKxURTJUci0JmS20vL9IDr8oGC4IlhwR2/4mk+GO56rkB9B0q2u7xKfWmKMYaLbr4yqWBRBWF0
	ThVrs3cOV+YjOh6g1tUNSZcdmKB6rErqoqDYt0z85dhqgVONt2qkESIPeMENl5lJI37VqfiK22b
	BSUte6lUH4BKvlKGOwBt+p/4nl48Kx5zAkhTCJf6QagNcVmj5R0t0uRJJc/UNn6yUzTCx2Z1LDk
	q8tpCPuz/aKz+sKGsm61wkAYfuY44o5CGQhV8GLiL5c+vNVbGR/KQRI1QKBbUubUa26oOkmkF8h
	pU8In9yZVsGtHScYH5TqwO2sPS9NEZ6p3uC1BDEFhB5XPOzMmpub9RJuUvfIXJllnFNrH7BCi8D
	Z8he0qlXUWCu945RtOiZbxt9PMNcOyoZNT/IL2t7+bVJWLNJ5eEawE4dWC7CYIvXnKFJzg6aSDA
	E8ksvcGuB+bhIQ2XR+3Km0ud0yetQEZjpo62xTpMHMKxtQ4WDAV9/6D3fEf5edtgPSSAPaWnXQ2
	Ydo7skx8RRuYAS+AjksNLl5PYLiCpgowZhw==
X-Received: by 2002:a05:6a00:3c90:b0:89f:d620:232 with SMTP id d2e1a72fcca58-8a9bdcc6647mr14065326b3a.35.1793896386624;
        Thu, 05 Nov 2026 08:33:06 -0800 (PST)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b1bef63b9csm1241319b3a.17.2026.11.05.08.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 08:33:06 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 16:33:05 +0000
Message-Id: <DMNF72R03D9U.3NZIHZP7N2HAZ@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next v4 0/2] Fix OOB read in BTF dumper zero-scan
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gu Bin" <gubin@cmss.chinamobile.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261104025806.1693-1-gubin@cmss.chinamobile.com>
References: <20261103032619.1378-1-gubin@cmss.chinamobile.com> <20261104025806.1693-1-gubin@cmss.chinamobile.com>
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

On Tue, Nov 03, 2026 at 06:58 PM Gu Bin <gubin@cmss.chinamobile.com> wrote:
> out, the sign fix has since landed as commit ab332ec8953d ("libbpf:
> Fix struct and union zero detection in BTF dumper"), so this respin
> is rebased on top of it and covers the OOB only.  The overflow check

Doesn't apply and CI is red. Pls debug and fix.

pw-bot: cr
