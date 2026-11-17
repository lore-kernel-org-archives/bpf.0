Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794954007;
	b=VfxinIyKG1hzmPoB95vEgB4IFtDhgzm467u03FWx7ysRKp1u3lex0he3vPivJPOJRux7
	 G6NZTSOoffnk+kszDYZm2aXuUcvkt/LW/S2FwUzJuoqPR3Ur3VbzuDCp8IhajHJbYhUyc
	 FLf9SmfD5Ow2ecfWQewN4wjYBEa0+7zLXjj3gSDYt2JlsEQKru6ZZpJGKqr+60IX1r4Tn
	 l0bIrKZndN3YVc3uEjmR9MogiToks96fFbT+wcFrSqcGfugDlz8pzJyBLOQ6cUwDRyCoX
	 j+KeHgXg45E3qZdCceEj+jBMxqIONb9SbumcU40WKY6fJTlITDDMBb4pkcA25l/9acQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954007;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=MrBB22VyQQ34wvgxAVrSinsIzWNGkBwccDyrerQ8zrY=;
	b=Bz44KGw536gkcVOwZCGSd1PKF5nai2WrVV7HiNXURqgDsvbIaKv6LmVl/erkKwsCTsc4
	 U2wCEgVFDcJoe6vqSoJ3xeJ032glPzbrHK0PDn6VKl8x0yLqgpmEpOYjZckzyYiaoeFX4
	 /CzHEDkq3xc8SV2oarw5pSg5e79NZx/cjAVVbQgQZqv+2wF3Z/gLpaSglq/ysONME+gXJ
	 bRCjpFTsirRGhdSrAYEEf/CPfT4IrwIqPZwVFEP+aDlz4qbRgK2JEJrfUfPrYDd9o3XhP
	 SMmMaKiYOpPdepr2m37Q7w5lGj4VlvWJ8AdHEzKjbGr2dkOU1c2gRGmh9roNU5ebfeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=de3QWr9u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3637606A338
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 22:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3637606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=de3QWr9u
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHM28og1933633
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:20:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=MrBB22VyQQ3
	4wvgxAVrSinsIzWNGkBwccDyrerQ8zrY=; b=de3QWr9uJo7zpRux5nSBZrQPJI1
	ZuT9RzWRGoDJ4aCQ9SrU4Xxw9lwDJ7b3OmHlR8+w5tIEz3UPpJzxlfS7NWR2ntEF
	Sx5JJxBsNLgjr1SvG/Lb2/HWRTnrHpAqHnl2JEhCnWbe7ecSMNitIJpelIQxT7L/
	5ownN3a8BAw3B6TX+M2l1KOePj+0a7YZornHlcIw3dusVrCnZ3PNUvjXrb1W3Jbq
	9eI4VDUod9rq0HPbutUCHOxnMkEyvDODXmpDon9TP7Jv9fAYKQLTeTydSUIZhpUC
	6/Ldc6GrPMpfUutcKYiSWDp5WJmepsbra64rsMl8Xl+kkyO3/xGEv7ORWJQ==
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0mn0xqyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:20:05 -0800 (PST)
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so241653f8f.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:20:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794954004; cv=none;
        d=google.com; s=arc-20260327;
        b=oi/SUMg2m02yT42nmLFNJKvXAIx9WZSNm0y0YFS7cfOyYYm2+puiasePkq0mN1DaFC
         aV2x5TI7eX40QLvQcfOnFgZUs9aeHKf3GUqIn/EkMgK7S3wCm2A6m9F8GZFmADslao55
         ytRR5xfT/w/3iRmwljWemfrugyTqQtAiy1yHCENd8338C7Lja2ah20lY7kRmxlVOv1Rm
         W688z9mvjWDmC4y6BU38XgMMRzF15ix31htk19fnkmloKs03tLS4LQ2tVWeFJGScJnM3
         EswixUlUHHQBbUvADGy74vI2p/aRUaYiBu1M1GTlw1h2MmYlrKUBeiqtCep2zGrhhzRm
         vhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=MrBB22VyQQ34wvgxAVrSinsIzWNGkBwccDyrerQ8zrY=;
        fh=nMQlQ+kaEgvIoXvPYYRp0O2CtpzV1a/aUSMvoFUbuuk=;
        b=QHNLrxy1yMt8Ih666I5uzRCdG0xVBT2atwRspNT3LxGFBM1GM37Bt5NhrdYpPNVIoF
         mPF/tEACS8b4AMoLwyybMPmFX/HSrq6NaIJ2CGGzYgJEGtq2Q/y7zNYppT+Jni6U5z2Q
         U0ij4qumNsq9PEKnpR4kzAX5sUJ7SRnftlkL14clSvIY6FgpjSsTeYYDeaKRy1a7EazV
         7a6567eddHr5S1LX+IeE6VT/9/A8JafAPL44sCbVXdZx8F4kHN0vbAaJT01QF3WhDX2Q
         FbbNiuv0B5X1rXyrxpArC8bjYMJl8w+Tq9REh+6EULO567fRJMHBfX2GALiDZIvedyHZ
         m1RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794954004; x=1795558804;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MrBB22VyQQ34wvgxAVrSinsIzWNGkBwccDyrerQ8zrY=;
        b=jRx37h2QhKPLAz4SF1dcaKEQCbE6o2g/P7fPgp89E7KhTl8sdNy5lAKsJWvNGyVbzD
         qL7dJ2blZ1d6sYPx+dTjFWrr3Coluh71BNE82zkwwfN3f+AU4G12QeIfQqZEaibKprpy
         CIaIyaEHLRsrbSR1Gq6fK4TiJZm5q5lxG3AfM4isOWmzZzAcarX3BSvJu4ehpnt0jUm7
         Bn2VPHZFCEADAXwwMbWXsK0IFThH0Kb13zuXRefPT/I/fNCKGNETXKqlDOUyTtkO3GDb
         EUF9YMeqL+/s7+BGeVRrRP0woqk+IZfEB+fh+s36Cdelu/dW+2NlSb1t71hUKORH9fpA
         bwGQ==
X-Forwarded-Encrypted: i=1; AL+hErEE9kW22pAjvxCa/MoFOvlzHn14aMnIzg86Pm/zSbuP4XGuquBjdH5Oj2UAbARM864eGoQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YB1RUZI+DPUlV1wJO8Cqr0Ztf57AW06OHc3WF5PIL/wWYjRim
	ovbWEMD7prG0OJi+xcZwbLOeo5QEU0mOXLx7os7dbzcWTUqC8ekH7JOCwaFE3+IVwOVRxm24nHx
	xvQ1klTM6J0RIuH4MdJdr2BVQFXKOiWehOc7iCLK3wF5/HpIfj0fjRx414umsr4M9dWzWCHTXGq
	NJ5N0LsqC1FlTz4zsU0wSF/71zdGM=
X-Gm-Gg: AZFdTZdoXaMe8Wq4WT7eWUnnpZfH0bbPLh/JXUtGDrHwvcCLs6MB0SwkxvtjPr2TnTU
	NvXuSkCJwh2Q1VOhnB/mw8JuqsZ2bDR+iRHVcPthOY7BAacGiQ4RYwPXqmmVlkboaK6iow3mxcG
	C+cwdaMjA9hd5E6l6OKdYU3QOKpZYka+bUng2VDUkrOb9IxP3katdFTfTtDo1PibTeDlc7Je44y
	7ffWQwhbd7RuInz7L5+DWaU0CAE9CmDbLtUNcfdrrH/YdFyoeE=
X-Received: by 2002:a05:6000:2383:b0:490:f98f:addd with SMTP id ffacd0b85a97d-4a6331c6cdamr2082680f8f.4.1794954004414;
        Tue, 17 Nov 2026 14:20:04 -0800 (PST)
X-Received: by 2002:a05:6000:2383:b0:490:f98f:addd with SMTP id
 ffacd0b85a97d-4a6331c6cdamr2082645f8f.4.1794954004046; Tue, 17 Nov 2026
 14:20:04 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-5-toddfreed@meta.com> <179471269504.2199510.18115986956046547098@kernel.org>
In-Reply-To: <179471269504.2199510.18115986956046547098@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Tue, 17 Nov 2026 14:19:49 -0800
X-Gm-Features: Aa3M54pE3seHebOeBtbI3cDpMgrW25pWhWq5MbBS5In6ZJStfYB2VZ8sEpNY7Bs
Message-ID: <CADh2yMyRSH4ZKZaGxFLVXHTE6v3XF38jh2OykqXRxvP4=0TKgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 04/15] psp: add support for socket-less psp associations
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
        bjorn@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        daniel.zahka@gmail.com, donald.hunter@gmail.com, edumazet@kernel.org,
        kuba@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
        john.fastabend@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, martin.lau@linux.dev, pabeni@redhat.com,
        saeedm@nvidia.com, horms@kernel.org, tariqt@nvidia.com,
        weiwan@google.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4OCBTYWx0ZWRfXxzmGpsAr8Z5j
 1MDfywikBs4F8qW+d2cWSDvs1g73QWGc8e3w77HKk3SZ9SXr7gIpprRlwwwLQ6C3USgRV3cdSIZ
 k64VBeEto1gGOx6GE1PpkkYy/cvP6qjJq1QP0lnk0UrftRcE9gGtNpD/qWKQNVh5qvsa07bK1ZU
 XudboRmQEEkhufUcXwXhgK1NcNyQxSj5mOuM86/ZvybX2D1cHu8ERfU5colT4mzCxm+gT7e7sEv
 iorWIsvOd1+HHMGcefRfYTtIW7ChIzAmxy6uIifkq9pTZ/ZEaW4NeFtMpFdEjqr1y928cJqbmGt
 x6f4k88YC9Dmj9S6rdm70nAriFnQcPoMVYXmhpBTbwVfT+bMBJ+WB/ovUpVRU3mKbSb5vsPW0B4
 IhaUexeyKbm9f7UYOFW6RbacSbOnM+z06tQrqtg5EMsah47xvYoq/mOmLVhPtJjT6sjTJdHUX8T
 NnS0ajKU8Stw2jsN4BQ==
X-Proofpoint-ORIG-GUID: wPxFOvZEwqis36r9LrYYZ7aPxY9rDehE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4OCBTYWx0ZWRfXwl6mzLSB5mGX
 Lca0UiJghHKnmxzv80H3ZrpjE1MhKVpd8gktBb6EDqOFhF5F5FTlh3NHM3f0ujiu+QpFs8rh+g9
 ABqLbPg/6Lq0q/CB0NUWF54UjCxw8Mk=
X-Authority-Analysis: v=2.4 cv=HcmB3SE8 c=1 sm=1 tr=0 ts=6afcd315 cx=c_pps
 a=I6ewnrIBtnKHmb6SxpX7Vg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=6yLQ_yHwUL-M3baYCL4A:9 a=QEXdDO2ut3YA:10 a=MqNruPmfsT8GavliLQMe:22
X-Proofpoint-GUID: wPxFOvZEwqis36r9LrYYZ7aPxY9rDehE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01

> > key material enters through netlink and is never reported back. no key
> > is stored for rx associations, and users reference associations by id
> > and never handle keys
>
> [Severity: Medium]
> Is this paragraph accurate? The code in this patch seems to do the
> opposite in two places.
>
> ...
>
> So user space does handle keys, and rx-spi-alloc does report key
> material back.
>
> Could the commit message describe that more precisely? For example:
> "the Rx key is returned once, by rx-spi-alloc, and is never stored or
> reported by assoc-get".

Yes. In v2 it will say the Rx key is returned from rx-spi-alloc, but not
stored. In v2 rx-spi-alloc won't create an association at all.

-Todd
