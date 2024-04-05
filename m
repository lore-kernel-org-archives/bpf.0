Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BD17333E
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347843; cv=none; b=NO5fk8ZnT67XU1op+6hwXafZsGSFy2ymVzRXAdvOijtD4lBLrV4pxDmsyUXcaxZV6Qf8Fquw2okT9CsUmqvmKiqw7Dk+tLjSL8UQPV1tHeKFQfZGZlWE3nbERmq24qbLEjphNQo+gD6YdwJuN1y59ksemGXwSSs++BE5eIpHlxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347843; c=relaxed/simple;
	bh=9YW0Y8b4xg4lzLARwYR15fKNx/UY5flUs0qSB9kBVP0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j2w7/9MqHkf9ZpRXK57IPH9DPmpWhT1e0T5hAbMjXkm0Byys8RwgxG/FRFU4WKbzqn6YzexlRgVDspTOVlw3qnyySOxP1yFCVcHWtOwH5sVGEzXc8A9IsSGKF85xcRbj/Rn8A06IHVD88HZAsjP4dblIclo9A+VKjGjys/nm1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nnrbKw3y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nnrbKw3y"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3c9300c65so7479335ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1712347841; x=1712952641; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F0ktRPrAubiV6tzXrp5mNzTouRHnVdtL1CTT4BjZr2w=;
        b=nnrbKw3yYrEj0jaqersIKGfSQVGrDJ2aU3k8S97syIaPyGERzKiznpMpJoKZkjao1y
         Qzhe9mkWmdh1mRQSGa/P3CgsursZ/lCA/uD/RhoG1WGtTCvLIDCKgRQVUi/JSE9pbzX9
         5/mQCwQ6DFONXDVZFLxA8fBK6NwdHzqB93ZduVuZsRcL9/iFfgv/QKC2pU03AXSanZgD
         Alv0PsdnuIclGvkTJfMqg/cT6YzkgMzMQRIJywsGLqI4lKLb07nFEUKkPLn37dDlyakN
         l41Xl5YLRIVuNENdmNUxdtn9SiTWD6fn51Bknjbuff1RWT1Oes8BW62s4syktQ+l0/A2
         DWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712347841; x=1712952641;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0ktRPrAubiV6tzXrp5mNzTouRHnVdtL1CTT4BjZr2w=;
        b=ez7IYgbBqpX5ySA4XqgJcTCKOSTiBbWULz7AIWjjct0HhKX8bkVYw7dzUlZcuBOGy1
         fTGSUtqb0l2QWZYst53MfZQ6PNuv648zdOheYyjn0Qw4cP0KqOxu8YYBKuIekeHrBEzZ
         gNQ+yIDSdKw2CQ3zVtS7GUDYSbp5RldadqTU9QleDxmH/wbFcBZBfOd5N89fFv+4yma5
         xJcXRsyXXH3vzRrBqqJdEQIPau1kIvvk1MdDP/dRZnGNibBPvuyypSqazCxKlV+ZJkof
         CxEdiJ6iMoI/ofHlec0PyDcpd3tT7gl6CAn+crQpGQY/v94f4phsY+iceOqpXLGfgVpe
         QT9A==
X-Gm-Message-State: AOJu0Yzj4iNQPJm0SFD/Bcpfo++WsUM7Tg3QS2etwPnkY7iNOg0piv04
	huVceBvr5F2gTD6B+oElqX2lr7mTLveVyatb6/dPQ1rt9tpUcYkdffgvn8euBZs=
X-Google-Smtp-Source: AGHT+IGaLSq+QaQrMdxp3Ca035Bhm0Mvjss3wRo+8BcoYw4lvSLDhMCBdi0U8T4HsAyQUBdNE52ysQ==
X-Received: by 2002:a17:902:f151:b0:1df:fd30:8b2d with SMTP id d17-20020a170902f15100b001dffd308b2dmr1717034plb.50.1712347840912;
        Fri, 05 Apr 2024 13:10:40 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b001e0e5722788sm2047295plk.17.2024.04.05.13.10.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 13:10:40 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
Subject: Follow up on "call helper function by address" terminology
Date: Fri, 5 Apr 2024 13:10:38 -0700
Message-ID: <0a0f01da8795$5496b250$fdc416f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdqHlNltCF6pC1IhQv+N9cwlwhj+TQ==
Content-Language: en-us

At IETF 119, we agreed that "by address" should be changed to something else
in the ISA.
The term "legacy ID" was used during the discussion but Christoph (if I
remember right)
pointed out that such IDs are not deprecated per se.  Hence "legacy" may not
be the
right word since we use that word with legacy packet access instructions
that are
deprecated. We decided to take further discussion to the list, hence this
email.

We need some term to distinguish them from BTF IDs, so another alternative
might be "non-BTF ID".

Thoughts, or other alternatives?

Dave

