Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932179;
	b=kIfuJP2OpmbBjILxLXdoAlj8AXZI+ymLM6Zr7A9/hkiZrkEgeIQvMuy5hVCaSM8GAtMU
	 dKDHhfqqY9SVlp/u1OEVr8v0IUsYySYYfCzGf3mixy+RCrY2gKjavxO805PjhAArlufvO
	 9zjG58oJu/2MjuUF9/jqX33HYL+GNc1dBazaFk7pD5FDsXJ2mQq/9ZKTUAFDJWOpMgfS3
	 6ZHau2uriU9/WzKXd0yUHfK1Dti83YVNuIaN001MGjZebriZWyEmxLT9d1nqgDnjBu4Vu
	 ZvunAWq62nDxgC/yMiS2XOTdHyynRHw6EKXl+u0w56sWrZyzy99Pu427iB9pJ17aOZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hz2h34D2UVi4lF1fkvfUed+mfNI6Bvl3fG3Jdcvoc04=;
	b=mP6IHDZ86Q7YohN6O7Aa52HeYk0NCPFLS2di2wrPAts/cxGwi2znRTPVM2SE/47iCyMF
	 YAotljds5BTPaeMZKvszLpsFy8ykDMtyq1ZapZtQb9UdwWH0Lgmw06tnDlDVxO0+sIKzV
	 BE/G0ix5QVbv8kT9aP6Oz3OUAKV4qySyRvZY/PKeBW/Zz8Y8S8ANnTkmsDWJltGStPcuI
	 QjO32gPb9uR6gRuX62Jlr2wk281dTooho8hHet/85ateaSIkbKbiKRR+9I5MQVF4gsJnV
	 jAfHvg/Z5jxglcm537T0558NF6tKF2M6lVW191F31iupqIDN+EyZUkT+7g2ntSV5/dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=eTRhz3yX;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113DA606A330
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 16:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 113DA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=eTRhz3yX
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c505186727fso337154066b.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 08:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794932177; x=1795536977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hz2h34D2UVi4lF1fkvfUed+mfNI6Bvl3fG3Jdcvoc04=;
        b=eTRhz3yXeGq7o8PaIB0KhMDF0Dgn6xXT29+EpPZuu+KBJKM7DJSi9Uwy8wzRCFNI7W
         3017OSQlEyeCV3+d/j+y5rDBu4rEIEyTOwoYBq+cSmRs59RH/sImL6zq06IAMbu/iQYI
         ksfUESf3RIuIn2XoXwvueHGogtL73M8xsXI1ow/sliepz6kEe0ST19yErFYOsqhpsA37
         pyrhL36q7ba+4qxqOipLdyPKTsgEzXwH+d20T5DZ6MQ/K30TDGLRfJ4FlMJTWy3taUNc
         e76cfal27IsHenpLMhlo2EQOqSCwL0AGkS2GySCa4jx6RI/XR6lXufXrGVFuRzcWQRLN
         PgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794932177; x=1795536977;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hz2h34D2UVi4lF1fkvfUed+mfNI6Bvl3fG3Jdcvoc04=;
        b=e+XdLYEBQm6QlIxby8I37E/9ahFeWoQh30N+TLRn2+neh1J4Uyxj4+tngBAWBs2ysv
         6VSh+YXCWR4Su5vgikNzxPBlhbI46RiF//GUqxO1RLg3vr0qMpgj/UqUBLXKg64mXMVr
         3DtrJpS3i+KuJ/xo3Vge1EiuKNOudlsaOYQ7m6jLkZ6/L7jPgBDFTypV7CBZhH84AhbV
         m0TI44vb73DhJ1unqLfPbxCwdOpNSSV3bpCDb/bhaO7Sf4HWs9C1XFSVpuI5jHrDmtST
         B+vXsh2WT0ET2iqbbSTqARmBaM0InDumhU2h4q4Qxu9VqPfpco7T1XKeoLcFiJnBLIuh
         Q26w==
X-Forwarded-Encrypted: i=1; AL+hErHI4t2nHv4j0VOIVTFCOYUYd6hfThx76reyR4O3FX569q6RmexdhGHnME9gUMoCZsriMfw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UW2qr+Ur8wyvXPVhWlbP/1c30LFkJeAtIZ+WaTSPDwKzDSOaM
	77g7bCkW94AspoI+7NYW15rkrekXpNKXH5p+g/ppW5rC2AXbyTrDiWrFST99dv027Js=
X-Gm-Gg: AYBFou3O4ALaNiZXEVpJyuUNUaotrjH5ffbU5OejZu34pqeN53JdwSQjR30r0mwPMWT
	xCELpJZEsUa1JDle4OvDchEewqIclrhbmE6KGtMcSEo5XUHbrm3RtkgsV3zb9ryw2+XQbG/pTYF
	yxyvDqozuC1fDkXMlqEJ+wIjTS1zqt7JQQdC7w5H0CgKlN02TAeIv+twtnkURN5uHz0LoJ6qC25
	UzZSkhQHhdrz5PirnMjLSTLOeFytlzIvshjLu3On/PBvkKHfPWo9zVwMQHNLZ0UAf0HTckwsY06
	rn8yzoIKLKpZp1o2WEuYgkPW0Yr4Te64SBHBfWp3aNeYAHrdJj0OnlFbiNpSbEnmwpTTzIz4nrz
	bgHyeCaj6bgX0GuNlw/FnblDdb2KQn22MLkxXHOB9LV4b3gjIYGrQsYvmDjXJWO8fB4hWruN11l
	+ehtEomls6Y6kwWZVaCia/w7+4R81612PdsUydft3fMNZcGNAtJjR9iXEAw9gtheT5ojRSqk1LU
	IKuEjZXWbZiTB5fP0V4VaqUF6q/7x7JG+OOArMhhlfAIwPqB/Ldorw7xfnQ9okVMopdpoiDBu6I
	5mfBSidTXwtI37GRrokX+8jTgxDeC/8khD5tRKNoBRGigwQ=
X-Received: by 2002:a17:906:4795:b0:c42:2f4e:522a with SMTP id a640c23a62f3a-c509636a806mr1177152466b.25.1794932177483;
        Tue, 17 Nov 2026 08:16:17 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f31csm1746566b.10.2026.11.17.08.16.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 08:16:16 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bot+bpf-ci@kernel.org
Cc: Slawomir Stepien <sst@poczta.fm>,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	ihor.solodrai@linux.dev,
	tavip@google.com,
	maciej.fijalkowski@intel.com,
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	mason@kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH v6 bpf 1/3] xdp: introduce xdp_convert_skb_to_buff()
Date: Tue, 17 Nov 2026 16:16:03 +0000
Message-ID: <20261117161602.62553-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <9b616d465e6f88aab813a79cc84c51ed358861e201bfb23921864e62fc9dc023@mail.kernel.org>
References: <20261104121316.1155680-2-sst@poczta.fm> <9b616d465e6f88aab813a79cc84c51ed358861e201bfb23921864e62fc9dc023@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Wed, Nov 04, 2026 at 12:53:35PM +0000, bot+bpf-ci@kernel.org wrote:
> Could mem.type be saved and restored around the program run, or could
> bpf_prog_test_run_xdp() set the mem type it needs (or use its own
> xdp_rxq_info)?  The later veth commits in this series only touch
> drivers/net/veth.c and do not address this.

I think test_run should just use its own copy of the rxq, which is also
easier to backport.
