Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1F17333E
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347849; cv=none; b=L2qbB1viRVaZfMjZw/Qd/wx9s9iNB26Wqsao76Ncfu3G7YVUH0zS7BtWzjJ++1rYTbu89FQNn762HfdHuJIGpTX/f9Fcq+RTnxWjg2cfKmoUat3sgcftoBRdKqKK64y5o/VVGHGLfJ7R13mtItXcksNXMrgbEJWGDeKuCLsWmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347849; c=relaxed/simple;
	bh=yhcJSyrDxFVorA/B0zQGFYeUAdDbZpxjM6e19u2MaVA=;
	h=To:Date:Message-ID:MIME-Version:Subject:Content-Type:From; b=buFIvFfaRYdbEYwnuPoi7DbUflxHI5EgVrukO6KLrRAiFDYJriD1GLUd7XAnuS88MVPvVqI2rckJa/cGMujOUZEHYbbZ3wrVIVAwPIEtswas7dfODuik5OkT8K3vyK6JAy1pGOUzBJ2zDF+zw8s+eFK/jAeGaF5wmNeI3LOQpWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=yKuq70iF; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=GGGkHCeJ reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kckq05iC reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yKuq70iF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="GGGkHCeJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kckq05iC"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 84E39C180B6A
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712347847; bh=yhcJSyrDxFVorA/B0zQGFYeUAdDbZpxjM6e19u2MaVA=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=yKuq70iFz4EuVuMgZcEuMi/2WS9LPxR46TAv/Zqt5bR9hlNF/THKxANb73CaMS6jO
	 aKv8mUTqy20aBTtFYGd3EayEDaqQoOiDhyl8o02H7rqyGUEb5em3Nm3YO0JfLDtxZs
	 6S+Qg7Qj7qoNHl7CSjUh1LOuLoFxvxW4oHPFbxKc=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5B899C14F700;
 Fri,  5 Apr 2024 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1712347847; bh=yhcJSyrDxFVorA/B0zQGFYeUAdDbZpxjM6e19u2MaVA=;
 h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=GGGkHCeJf3O3cn4f1fXCya5j/uRMaKWicfFf1FxJzGeDAQelqky00oPYff0hJqEO/
 lV0l1pjuEExFLu8zZJB8MZIewABaFPSI6Lf6R2JQ9YCoBABOvkfrDgeqqt0/UqJS/W
 /W298CPZFOmV/6c+WmbQignqcmTU7ster0Io8QEM=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 99203C14F700
 for <bpf@ietfa.amsl.com>; Fri,  5 Apr 2024 13:10:46 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gqj3m8mAEwX3 for <bpf@ietfa.amsl.com>;
 Fri,  5 Apr 2024 13:10:42 -0700 (PDT)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1838DC14F6FE
 for <bpf@ietf.org>; Fri,  5 Apr 2024 13:10:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e0b889901bso23016275ad.1
 for <bpf@ietf.org>; Fri, 05 Apr 2024 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1712347841; x=1712952641; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=F0ktRPrAubiV6tzXrp5mNzTouRHnVdtL1CTT4BjZr2w=;
 b=kckq05iC+zKTlfgfb3NX6uzaQ0DbUr0MkEdKwUv5YYvGQ+HqvDIJZoTIf4WOqjJUwH
 XxrJx4cy6w7niPju3cGDEvHPQBSmSnQYy6RCviQUAvegh2v+FfD6CPZ++en+DHMerxm3
 Gg8SMAXIfIeygUg5mLFsVpTGkXzUjxdnOVQr2tyrrnGHFXRbLMlsm+QjA+URSpjFT/eG
 tunuVJNepcDpBJp/6dZ53pZmqpKvt+da4aF/U/i+1lxaFzDk18JYLZicjqqi+V6ml0cO
 8ChsflwOWN4zEjX1wMWfQzOcie/DHPKpIsIYUm9Fea+Y+dn0sk/SrDWq4wbfkX35LGkD
 M+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712347841; x=1712952641;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F0ktRPrAubiV6tzXrp5mNzTouRHnVdtL1CTT4BjZr2w=;
 b=Qv/u1xU6xaiSKj4iq/Re0ydCwOhUDR0+BJSPcy7XKOmsNeUTjyPCRGwNyVV3BuHrm7
 9gL5YsHg6C79dpFYNVvITu04yR6A9BfRRno5cuPkbhfOSO9IY7vj79sfLBahzAGu8aIK
 LLq3I3cdtVQBhDDFhGqudlRe66Ba+5RRFn1gROXF3F99ezVkuPd7gtOBNkWWMgQsMt3j
 GdFzdgE79HhJQHU7KVKiosd3JZUVMb0z6IaF+3V0guzpJXsxs1l1bDT1zxIKA5DNMyLM
 LJfNXXOO9LrN2GotOYIM2XuRQVc9GdXOBETCOdiS3zeXSmnxQl7xPEp1fVR4kfkJl/e4
 uhMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfJiUK1nKy4k9Xxr3yfeo16vTOQRIeVl5BybB8CUntPeu2+ukLOe9GR20Jk6xi3/Dizoe8a0zKo9oKy/8=
X-Gm-Message-State: AOJu0Yx38OfnzqUU6VoRk3KbFbzC4jGAycabnHvf+5cI7CIhpPQ9/fh0
 AP5Js50N1kftrVRTyrNs49ECeaVbBMP4VNHxfblCZ8vcDArM3OjvXeQEkZR0KjQ=
X-Google-Smtp-Source: AGHT+IGaLSq+QaQrMdxp3Ca035Bhm0Mvjss3wRo+8BcoYw4lvSLDhMCBdi0U8T4HsAyQUBdNE52ysQ==
X-Received: by 2002:a17:902:f151:b0:1df:fd30:8b2d with SMTP id
 d17-20020a170902f15100b001dffd308b2dmr1717034plb.50.1712347840912; 
 Fri, 05 Apr 2024 13:10:40 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 u8-20020a1709026e0800b001e0e5722788sm2047295plk.17.2024.04.05.13.10.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Apr 2024 13:10:40 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
Date: Fri, 5 Apr 2024 13:10:38 -0700
Message-ID: <0a0f01da8795$5496b250$fdc416f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdqHlNltCF6pC1IhQv+N9cwlwhj+TQ==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/2JwWQwFdOeMGv0VTbD0CKWwAOEA>
Subject: [Bpf] Follow up on "call helper function by address" terminology
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org
Message-ID: <20240405201038.j8-acn1GYq3WWUiXXwVsICOIw3-UkGojkfHZPQLFYXo@z>

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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf
