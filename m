Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057499;
	b=wgj2VLf1BCbfL7zlQPzPWNMsVq8+Z71ujLvl7GhojRMzNnca6YBDM/grLDqkJyCRn5be
	 jR9uRxb95M291kWza7OFo2Ygyary5c0aLN8F69R4KfygPM89L3F/darosLiUET9cRXsUg
	 cjlEsNPvHYZeW15Dfb8xJonN1r7cqKYN04e3YeFDdRIMAW8njBhZqPXQR35jlWp6JfAPg
	 HjRRF4C8obVsnicyPLL7nRF74vusxWwn+1QQbrgfR0IKR87ijEx0eJfb7SHzIT81jW0Yx
	 Di4wujyqP/bWoLoWF/AgFp/50DVKfV/Tecxo3JwBhrjTuUPcCajm4w11Nf9fcom1gKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
	b=URDJowgh7wdAiuCsYiizwrdvqB+a4AJER5d72QnmLfl6bhVZo929KQk4HycTpitC2kCD
	 6L5oc6m7v1E5SVzWdW9XbWz1QOU4YYmExRAUqeZTZXNIZvT7H/+0RTvU5zuxhq+QmAFeV
	 ZvNfbRx4qzBk4D8Qmtf1E7UMR9OQXTbzTjRDpWl1vBvGnUyz2rEx+eSQPh/ewESpByAEC
	 YzTNnjvG7PDnzSEDYEkPWfTPEE2W6Px1T5gqtLb2ynawxke81EgFpS+ygavq6suu14wrp
	 8wVE4xER2Bbk5MV0f3+zy2SEwOD9oSZv8FP+t1MqwLISZ9m7JqTA2X6kMcNuwRasbFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="NV/brdlI";
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E6606A326
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E2E6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NV/brdlI
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e60f9af6e6so30572985ad.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057499; x=1793662299; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
        b=NV/brdlIm/TuLhSF4NjeqNzM1PHfukJQnnGZ9bTpCILFizEdQUMsFtq7b5UMvLbjVa
         kxM811X6dWeM+zRT1gLhyyoBW2AXk9+oEm2z57RGUs1hn7oZvQNq7XV2HCrlhJde/HQV
         x5JcXglSOlEL7r82xWwt8HWzIyfCCM+Fg7vz5VItHODO7Ph3YdkCRyPnbRl6JqVOpL72
         AnGWWK0u9voc96aqUrn7GzvY1TcacWupUg0DdfWWRf03Qp00sf0OmelsWZfX9u6qb5yQ
         QCDFOCuUTy/G7BMfglpUlV9odeFRZhR7zjY3xDWStpxqyViOoVqufwZPc7J7LWpXtgzF
         K0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057499; x=1793662299;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNAuIEGmBIPL3LGhEiC7AZdHVvxraynZTpB2Bey0XaQ=;
        b=X4TYNJUKk/2zs2MODoCm0V5r4RukCZGyqyBQBh2H1TYbaabOQvIWkOchsdoIllXXz9
         fs82nhTQ/+c2yTFa29FiDzKon4txwOgdsLsWES6i1qPNJYZiMBeNK3Z+ljlpHiy4dqDA
         0f5IadMD59tvN0JqdTcc9F8RslW81Y4EBdWy9VdLhrBscMG84kaTubBwZxJMtF0sWzEX
         QTUzOKg5ckglDQcAHcFbTc2RZ3pt7EMWBtOIM/3S5eMP2tgLI12jsoc2rCY2slVTON2I
         Bd4hPqyBz8XuYw8ivsTvO1TIic1qdy3HfgVtkRgK+CZdaSSd1oyxsFw3rHuE8aALSlcl
         vSCg==
X-Forwarded-Encrypted: i=1; AKwUvBzX/9v/JKqgEj9K6gdRXX8/CI6vkCV/W+2SzF6Y5DMpACyXPlMRJr0M36Jh0z9yz6fWJYQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIb0nU9SbbuetTjF7ROb0nE8qg00hvrRJTiVYgWWHIL2Hn3iRWj
	Lcgk/8VguAT14+eYryuh6BOqb+XEBxZrvg0yZktO0LMY/9C2/Q8yGtJu
X-Gm-Gg: AYBFou3t2AMwUdDvaLl1cmIE2iFAAUPQ8DdKcMHnMQqdVMca6Utt3prRsWLbpqU9V6n
	zzUFuMzFLm5T++WDSlcijIpKQDiTDEio9j5mlwz7DKJxvozCDJ4KgxKAd03NHZvhTF7qn07mNpB
	uRHibVrZrInB9+iII4HvRznBwVqD8hZYVUUAd5HdZhyozrcRHeh3xtrDQG9djvqdejpd33aQgS6
	lNe9Kz/pJGH4yWR1Vq4WR8+AjMX7+MYh7FK6Xct2QOe5JzT554dpxkJ7oZyH90uoXCn1eGD/2UG
	LwhkvMLrAUlwYjStbvrD1qpGXKafu+8xD2IyaXdqTc97tJXjAcpkg7ErCUls6XLR7BqOVbKCcQq
	zcSX++5AstrD88/fw9IRhQuHY9Z3jHZlU+YsEfaZTZlXxlqIQESvdvpvFtgY4vm8T8CMf2GQTRo
	DhjKBY2x7dqlyWv7N1ul9r2cc1Y9pBimChNN4k1THMfpSGXidBY08YDE47v9MMxcyAvUlQhXNnT
	VWwZ9NpTOL3CYy3oL/Q8lv9w4Ly1CL5p9wfyg3K/vjje95tsBRKZbXlgxN9Ujx6tS1JCwj5b1WL
	WiX8CQBzQHWd9hKUp9R6iRCyfS3v6Puwe+wwxYQZg3+awC1gZ2QMGAhvKzCqBNK3g8OkEPulPqc
	dxNQg9vY=
X-Received: by 2002:a17:90b:528c:b0:3ac:8897:7b9d with SMTP id 98e67ed59e1d1-3ade9b2ee97mr7287988a91.1.1793057494026;
        Mon, 26 Oct 2026 16:31:34 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba38910sm6631220a91.1.2026.10.26.16.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 16:31:33 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 23:31:32 +0000
Message-Id: <DMF5U0PAK4HE.2QQ66SZMEMQLA@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <bpf@vger.kernel.org>
Cc: <linux-security-module@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Paul Moore" <paul@paul-moore.com>,
 <netdev@vger.kernel.org>, <stable@kernel.org>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Mon, Oct 26, 2026 at 02:57 AM Christian Brauner <brauner@kernel.org> wrote:
> I'd want to get the first three patches into v7.4 since the hooks are
> new this cycle. The systemd change I have for this uses the
> namespace_free hook whenever the kernel has it. On a kernel with the
> hook but without the first fix it would never learn about dead user
> namespaces.

Why not the whole series?
Otherwise 7.4 will be the only release where namespace_init sees
ns_id == 0 and bpf progs that key by it will have to deal with that.
Also the test for patch 1 is in patch 8 and it needs patch 5.

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
