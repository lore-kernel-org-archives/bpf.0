Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759236;
	b=ui1LS82qsrecmJQvYqP+UOVJ6/jGee1UZgQTMQm2Lj5gsqXgJTZvh3yPUUMMmtjlBYku
	 eXT7FJ3i4P5FLaNYLqL0dTk7BCk+QYkQTFAg5HZ4DKH/rc3SXrbIu6XKKiZf+rDu0avwE
	 H8u3JPzkeIfjZ3uL+2fdPLsExiZ0DugfwN6DsRNEHFNaB2X+rHsqRz3ooBQcyPcDN6qMw
	 xQ3AgJr4rPaf3r30zfgeyblfRy8QUwJmJDBZFd9QUIAISZNzN/rkVFo0RR1v/IEbvfl3u
	 RzSk7Nl5KQwN3+q4lvrEHd7DrglDs21+R3NgMfyZXULG2pe2wrYBUidPcqWb+ctntFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=WreHQ+ctfIQVAJ04YTajYP11NvK53JcUXlDQxWzL2OM=;
	b=VvK/xmHTaSnrOQSzzAeZJ+KqWAuogwg9LeKGD2715TAfJyMk/Ui1bIEi6V5aZN8M+qG2
	 6WL+zhSHRzZ+yx6oFjSeidFe7A+Om+lVAhH4kQY16AjcLWHgEmWfZ8dfrsfTLd1YvpyMa
	 lNyVcKPyDi8l2W2Vm0whbGIDEkYEAyBgRzmkFip5q5NRMs2Rn2CuaLiZzsLT5eqXZQnU4
	 u/rAB3BuvqQ2Kf6g5v7jtVM5Z3ACS4VhEFygY/E8Rc5R1++Xc3JyakQoLE2T1wwo5zHv8
	 AD90KEgKweRtEb8w8JFCh6CSuhRFucNg0OSA7yPMK9cEOVbhZrBUXbqRTCnbVoFBiTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q7Aqq8Yp;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205B606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4205B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q7Aqq8Yp
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so146222a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 18:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793759236; x=1794364036; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WreHQ+ctfIQVAJ04YTajYP11NvK53JcUXlDQxWzL2OM=;
        b=Q7Aqq8YphUZDFDNoBsT5P/HOehgJ9c2UdTd3tOtAeoi7xIjNDPEoitwgwSNiiVmqG+
         VJXso021xyD1qGWiRJn1ddj5i1lvFGEsMurHhUIZoiWuIaRS+YlRCm28OLVx0+1+cdmF
         J8pVVzJggZ6ltY5EiGdEzzvDNQ1poQqpEQmReB+TdbDkXpo7ZpOBWTSKr9DMPo9aAQ6q
         XKMqZeVF9PwJ4n8SU4QnU4dXhCcrkTwBRGckjFhZClMw7NaSpiwDjklxGTjil7BtRJSm
         F6pwt1BYVj2yV2o+O4A7qCtFxLlIB+o3LI9hssrkuC47d29vhFCz3ImTleCZSxNaD7gk
         AFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793759236; x=1794364036;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WreHQ+ctfIQVAJ04YTajYP11NvK53JcUXlDQxWzL2OM=;
        b=WSlxI2PRIr1T4/fkXyf0I22v2uxBal2QrPQWFSGblZpXfgBIQKltauLWVR8TrebSY2
         reRuc9hg4OZL2ToKHhXtyOxEDy+UlRWi3LZtT9xO79Hyf0LUufhMEOdryiw7Jq64ICeU
         0WiyyRUmR3DVtUvesIilBuXdeoxNfZ+PwHd9fqSZTC2UBxvrxxS+SDhm7IqqZVqgP64K
         82vV1pQUQU3sf7G6ayXv9KTuxDflZ7cQUTsyK5EUdAYwl0GUtqjvI/kmK2aasFFNV8Yd
         KYKhx+J6aPp7kFdYEinP1auRmmyo1IKiu9gLbBiMWZw/rDy9dd3SItz+4sMxnvb5jqw6
         7zWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxL6OhCLmoFURuWdISUmWnyZMXJvNzMV1cNQS9tnguO2zAUORK2Q8WMUKYF+BYz771hN1s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AvrxBzhY5GsXj5NFd4YG8aMk0WzyOmcsInjJkR8/ZKgw32zjE
	7PTHqXgS2Sl5IF6dSArHQVVxU8b/QgnbCEw3SVILo//qjuD5m3zZVSN7
X-Gm-Gg: AYBFou3+9nlIuUPSmOLDwZEnqEp0slmpe+fGuPTvu/AN8aXCmNF47KAQA2ZOvbogZH7
	hjrBHbFjF1wIWDduv8s9KPvB8rwJj04KoQXX6ykGyIk4U4xq/AA06NZLcNMsuxZQN3rrTNBiFXl
	tQPm3TjKtFBnX+o98MXhYwNGSXnasrY9aGVmkNMOSNuylQjMcJlxkZsHNOZPlB7V/xuAp9oChZL
	zHSohlnLcFUgPqHSunJqAn7bGhit3vqP9IAoRd/EUTKp5nyYWT4gn9/XD7xAMg3CdNmDhrK9dKe
	cdYQSVYt602dSJlb+J22bktPr1QoR/X7rszp6t3FPOtHX6TUX22Ho6sLQMjU5HfnSj0gkLx2mYh
	rBjWaIo483a0so0T/mTQu/pLvY/IVXaW7GOAV6F+V41bJ28yGTI27cANdtxDlFlvJR6ZSwymUhP
	rRZ3x6MDJwNlXIj1eZUqzpHgN//WGYrXr5dycMGummI8aw82ijoi3L3atbQyhBj6COiiNXC25Vt
	ACGI1HzdK8p6KtcdGUdCb/xT1tggjuo+FHy+5OHFkeJLMrHJ7Gs/8ldO1+JWskKq2mZq+7zGCPi
	2P0CVDjGRMIMMUlHzlQl4ggvSE+fpQLkLFWCwoPewrjbGdAtYzQRohs2ByBeLt5YdPXzzJlFpun
	aA7OqYByOYSYTWW/1iLcXEFLe585+YFKl3A==
X-Received: by 2002:a17:90b:4c08:b0:3ac:adce:60a9 with SMTP id 98e67ed59e1d1-3ae8957cc59mr12525443a91.9.1793759235515;
        Tue, 03 Nov 2026 18:27:15 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9b0ec5sm6762493a91.16.2026.11.03.18.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:27:15 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:27:14 +0000
Message-Id: <DMM2KWGK3JH9.2TE6OINCZTTY@gmail.com>
To: "Tianyi Chen" <hi@tychen.cc>, <bpf@vger.kernel.org>
Cc: <qmo@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <ihor.solodrai@linux.dev>, <linux-kselftest@vger.kernel.org>,
 <skokovmaksimevg@gmail.com>, <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v10 2/4] selftests/bpf: Check bpftool map info
 across mixed BTF maps
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <2c25cf3d118cce558cc58a207449b25c5f66b3a6.1793732336.git.hi@tychen.cc>
References: <cover.1793732336.git.hi@tychen.cc> <2c25cf3d118cce558cc58a207449b25c5f66b3a6.1793732336.git.hi@tychen.cc>
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

On Tue, Nov 03, 2026 at 11:01 AM Tianyi Chen <hi@tychen.cc> wrote:
> Create a typed map followed by a smaller untyped map with the same name.
> Check that full and named listings do not report BTF for the untyped map,
> JSON dumps match independently dumped contents, and plain dumps use raw
> output when the selected maps do not all have BTF.

This test cannot hit the bug from patch 1.
So the four subtests pass with and without patch 1.

pw-bot: cr
