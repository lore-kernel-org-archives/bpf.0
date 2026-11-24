Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490840;
	b=ZuHxYG1rlBfJC0jC8vWLvrXdTHmRfANsGCjaL2QZW3HgVRJ26azDumBxV7c+1Uxn74Wj
	 rUz267f4j9yOFWdLmTRpYvVGlrwNda4NMQYXqNA+pukibEEu4uM6ijLfJQs9hSWOaIqSl
	 zaMfcsp/vrB6qkTIA9d+8JsjozoHlAgKbph7qZFGfOJdqj6XZV5JSq/fCNAJ8nMbMKRWQ
	 CNBi7j4w4Es62gKrdJioLQ7rFrHeOz1hzX59SdauiZiNs6bdLc8Xkx3bceAlmmgyNtAen
	 muPGmIqYFdTOtFi6f6VUFtWAEBHngqjVV8SM4W2neWXcbADFsmVQ/Z4MdDLEmQCzsvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IFvpmd3WeFOGphC5U52MqXeNCsWhU8pIXy/FEgt8bNo=;
	b=Usj75XOaeYikBBRb2qyGre4GwVfPhaw2bjY7xoREp6RClG3dW5fo4kzLjg0k4R9PyAgL
	 SA6DlTPPy6F5pyk2hZVjx+jmomXuzVnMn2D1F/APAjd3I8Qh2Rvvq3z7prnLRQSfk6QHQ
	 Qo5/16OHrWCYOIZYDBCEuRtnCps9WVYWBxstorr8+o26kaD6gzzFTpJ1s24KmJMFXZ3A0
	 1FzCeYjC/h6h5+Df3CyT5ngrGVhzlltCJ5BdJWThrMaWnb+qExJWvWD7MIehGdNZZMOII
	 1fdBXIVSFdZokX4iXOlVAhHEo9Hl/9F44xIy792q2XfZIqHVRlz4EM5sJpsRoEN/BrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M7ckrYC8;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657C606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 03:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6657C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M7ckrYC8
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f06ff94acfso13383195ad.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 19:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795490840; x=1796095640; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFvpmd3WeFOGphC5U52MqXeNCsWhU8pIXy/FEgt8bNo=;
        b=M7ckrYC8PWxJnAuy2eh+px5zXmgv02RH0JbcWpZ1z1GWwVPMlLRaJQkkSdEL1hZcBe
         AqCTGjFz3snnX7bU1Ztz6y6VSSSG3JkvvAGsd269BLAOarxNoQe6i7VrBQBuru6yoM0Q
         1QMKwYGLTwjWmoc1iTxlLAmDXtdUkw+LOKjO9Efl6M+ARl0KeoQAs915avDSIAgPamvj
         WMYv2InyPeGSJciAV8GYJp9Im4rl4XPNe1ql/eTLaYqIja8ayfkCa1dV1T4l1l9wRJFQ
         lvd187L0dKkzQs8NH5WS++Jhix48rWo64gJ4eGAL7Or8DMtjB9QoqLgl2QgtH/ifjIeG
         1VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490840; x=1796095640;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFvpmd3WeFOGphC5U52MqXeNCsWhU8pIXy/FEgt8bNo=;
        b=iU0DtexhwnQtDIWbRdhbKJzDM2YScQ4U2JvAbNWB76kwnH+iOQXKh3/iV5zGRZM8w9
         32i2Z91v0SKVujHCjBfoMmltabRy2LhdJGNU5pZA46GjI7MO4t5lcbg7txs2Ncz9apCt
         S01YZYbWI48dAuPefv+dNMdSi4jcuUrkXTxcR9wcjhapMb+yJSi4bbatvVBzu33/fIPv
         XFFCioMzO7ucPO+4YPzxpqMDIBQQP07n6mrnkQORUAhZVgSV8pA7DD2utfZZxPzHz4BL
         Iofl/2e2X5vXKguMVNWFfYYHxPHkmAbQbjY1kX8v7GxA0YiqbzMaOzE0EFlOUTQEVGtH
         0Csw==
X-Gm-Message-State: APuU4Z9qMFaZ+paCTygdYALz5dAkL4Ugmtf/C8xm/lNNYrUo1diu7kmh
	nt5INp61VnRrltJi5vUTRTP5xd4ypI6ySiqdCmYaC8c7bQhAErAGWq8x0qKdhw==
X-Gm-Gg: AZFdTZfaXFARLkXtj0LhP3Xru3dXMWk9b0y6X0eFTTvubq3LwjnfUhLBcl4WXq1utcV
	oX7Prega5XQgR7Y+SaLgo7dEWcmG/OVLosX0XjiJGAowyXf98YJQrpw6ZaJz0RNt0RXpjJRiZmG
	Ic/GysOZJWaDwK7tqQZix36C/m1BfXjWaUnXPWS0df1pd2zll+MgidRUaiZnxIxF7mABuFc0R/H
	rIvXPwoAh3kh+gE08tLvMKO01y8VLSvGZ+S4IHxqjK+DnRFn9c7JEpc4teqgJswwPcPdmzA9B8o
	SDmK8UF8R7R+OdAMWF+iNEUIIEhnR4sFfp5kE9hIYIq4bLQacKCVlwUZ6O/OOcBfGNZmMrf3toz
	T33+JFb6S8Jsyn7fK52Y0KoUO68SPMPDjPFIXA19M1HTLRj3vKTtpzXRO6Xkrh41im1/nMJIj1c
	xypeLG3Vlv958+ndxkR1oPVL674Q7PwPGVKAQ+4izNvxsGSwKEYEat61E8VrMI72e7x6Rmack0F
	3sqltPVM4bGdbb6Jihy9eWBT9be3VDrVDRvGrnVA/EGndpVRzC+JF7LL70v57jHoJCdgIMBN3mV
	JztYASeQZcr1hzWDJULRCjNnTGEFNnsDKjazACHJhQqOxl03dj/ebTqwQLk893r8WGwQezDpN/F
	gtv5jPhr4yw3JiGqPekERUp09c+Pc9TyU6d8AjIwBuQzqVyDx6cXfqQ4=
X-Received: by 2002:a17:902:ce0b:b0:2e9:5059:4468 with SMTP id d9443c01a7336-2f03ef594efmr126592345ad.7.1795490839459;
        Mon, 23 Nov 2026 19:27:19 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f105b76sm62243415ad.50.2026.11.23.19.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 19:27:19 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 03:27:18 +0000
Message-Id: <DN34DSBL68MS.2RHLVBAKXACD4@gmail.com>
Subject: Re: ebpf program can cause verifier crash in check_return_code()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <rtm@csail.mit.edu>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>
Cc: <bpf@vger.kernel.org>
In-Reply-To: <43917.1795463809@30-11-166.wireless.csail.mit.edu>
References: <43917.1795463809@30-11-166.wireless.csail.mit.edu>
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

The following should fix it. Pls test it and send an official patch.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dea18409f480..5c8e84c80a9e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19928,7 +19928,8 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		 * matches the operator's return type and is in its unmodified
 		 * form. A scalar zero (i.e., a null pointer) is also allowed.
 		 */
-		reg_type = reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
+		reg_type = base_type(reg->type) == PTR_TO_BTF_ID ?
+			   btf_type_by_id(reg->btf, reg->btf_id) : NULL;
 		ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
 						prog->aux->attach_func_proto->type,
 						NULL);
