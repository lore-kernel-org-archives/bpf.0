Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1A3290A5
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126529; cv=pass; b=QQNWK7nkRxC7i+HlOGs0bnruf3Rm9K/wVHFgwNnBnm7bybtjkUZJmsxKnuMvMdBR6nqXqxdUIjZn10+KXkXZk4VZ905j/mizn4xlXkcaUh3ZbpL9cA+cpYHU4GC0R3GqDJiTjYVTz3qfhqivhIgKGlqKkJyztHu8FaLCQQjlobc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126529; c=relaxed/simple;
	bh=74qgg5SJJYPKqJmOzG3s1YhVXh8RU3o1jEAY2JTGo2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLurbVdt3V1Ye305YyrQQt5utx1A02yj5VlmT2W8DMpd861XbzTOhGuPPVffAyIOuWrTSziWG729JMyHozURmnxn951fC9Vx+kPYusVQgro2akBnx4Hioh0gusAtwJ06cvz8TffSj50OQaCwn7Qruj8IWrUgcbBWWW/NYjnr3L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/ZBFCnF; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/ZBFCnF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso9401255e9.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:22:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772126526; cv=none;
        d=google.com; s=arc-20240605;
        b=EVhcnDh62myFvJp2fGqTRZfYS9YlfmBJScJLYTxQAzAtvyxBobVCYDCmlG698CqLu8
         m9xx8I4RUT/p1etljdy10Y4jq+jIbKyw+Ccc4DRhibwmTdtPVC83roDcC8VKl9xzupPo
         qrCClfjRlutjpwzpo/H/89uM+3CXWD3ASZ541kKkI4Oz1dNi5XbW+cjtekE+8gg3HE/x
         I2MzwXT+bdbhHdoHmdi0OEQyS0u2ryRkr3YjWNebZLy3ohzECSnMU4ipfsH4tHczFwbi
         vkNnX7s6XVx0LRwBsx6rI3QGS2IJ93Kr58hy6TcCECudIiWfZSzlFRUf1JxOYqH70B+x
         BbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=74qgg5SJJYPKqJmOzG3s1YhVXh8RU3o1jEAY2JTGo2o=;
        fh=0AshWrwtA6EWTqzu+9vOapc88FgTJKyUM4s0U73WJnM=;
        b=GusmoYIMYKYcGIs7t8kTzKIVjWZomLUmUyQNXO7Yn0/pqb/77mrKeqOKS7nfha2LIi
         yWK4Lfp8au9RJLNawWVf428HUpUMwYmKSLDOvvSM7A+6vbB+R8gMdL9UQ70NclKbsJFJ
         PE29iTwQGyf0JbOjSrepYSsKM3u2JScAUz1/wzW9X44MOrhW8GMVyAir4jRvkY+anIpn
         8Rd9isXta8n9V3usZec1/2xAEKmgzIWubptmSfYHrlD8SVQjHnD/3yf83D8z9a9rKbtZ
         vcEiHvi1eFx9Lk7mqdUXSSWRkmHIEcsDrshmFTq6jlx5tmVgXb2vZ7OdkjBPJdxVX1QM
         QEcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772126526; x=1772731326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74qgg5SJJYPKqJmOzG3s1YhVXh8RU3o1jEAY2JTGo2o=;
        b=h/ZBFCnFM165OdJM/PQQ8TAZJnndWYv9Y77AWglq6ATeGR2LzKnDf7pkBM5B9U68Eo
         undvdPudxMvopvvE6MlRsOEYLUHJI8MO2hFs9BfCDv9AqISLMSORx9LP1kaLI3wnibDV
         8vnMI2M8DoyjwcPBZxviVtS3Ho0f2IuArsDLp298ber3Ud9pK132EUhCYDKmvOd5xpdh
         mNmfXpyd5qn7T+Gt2B1JiKbzk1gFrJvETz3PNd4f5rJFdgAVlVzD0MNYHkxT2yljS7iP
         MzQu1giRfTGtR8y5VetXgw7SwOSzE6QP5+VaijCQD7qvYxbXLwvmLmfOlSSAwvBPvtBp
         3z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772126526; x=1772731326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=74qgg5SJJYPKqJmOzG3s1YhVXh8RU3o1jEAY2JTGo2o=;
        b=xH7hcJEAxHjl5uKyAcZsHcUbl8691VACa5lLPoMISoJRH8W/WuGWn73hcjDIAmy/zj
         DGrYBzZhYWSb9ipKbc7ijxj1btEkjh2HmaijTzDpJmJWanWQoeZIg2U+G9B+HFH+aiWz
         67GG7UhDwKiZZJ12qK1zX/BWO12zvQFbRKC9g2RUVl6t98bx5xNzwL1gfWPCgY9Hr7Z1
         kPZoxp2Qaw+IVygBrljrQVl5fyFDBL4DsdxbE0jQhTuYUSj9GlAu0Y+6FQcQijVG9WpY
         pdmgbPGtnEX+HLbpgLSUMwx2btSbs9pPwqyYRX10Lxn1+iirSwHchAuSo37YykpxNnh+
         NJNw==
X-Gm-Message-State: AOJu0YzvlNI0VrXDo8l1wdCJMUXRTbUQs9ugNCeT7YV90XPTga66cRMQ
	2KFOIeb+TPnjgbAyLB+Zc+gTsIi7GGW5YOoaqZeKGd8QCLYAayKDTe08UTcdvptR0dszx74h68n
	JOMGwy8zl3AReJK1tzuDoa2CdB6qARf+LVw==
X-Gm-Gg: ATEYQzyhOMJxV3Z/9HETO0njgBIdY2KOZgxD92qxcfogyLfSziFkEGX/Gy33D140aLb
	03q5+hx+RV2X+VYY+0Idsp3md4Ec2vXkpZtzahgDn4u74oGNk/L4lW5RtzVAApCr18ktYaAqpmQ
	NemkqNUqAXLrL3Tc99IIe+s3CygX5W9UG3b8c5t5wimFqYnSR7efWgSyPv2dQ+DEO37VGEiRMXH
	gD0EzNqNlFK78XA3eJ0qG60svB3vL+WHLPejXJY8IhE0dHO6Ucfv+UamAqmtSTbycD0Ko/vqTL+
	h6/hAB0tkkhBIV9+zr7x+kgK6Yizq82ejncAsmzqXxtZYqRHLxsyTrwu62Kifsezpe78Vt+EcPP
	xV2gLDfZ/
X-Received: by 2002:a05:600c:6812:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-483c3dee17fmr39194405e9.25.1772126526208; Thu, 26 Feb 2026
 09:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DGOTPHTTR5ZE.Q7ALRR86ZZ6N@bootlin.com>
In-Reply-To: <DGOTPHTTR5ZE.Q7ALRR86ZZ6N@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Feb 2026 09:21:55 -0800
X-Gm-Features: AaiRm534F1J34rJ7kh8hSVim5MtGmblXU1UcmGZYNyuBYkm5GWjDPjFqUbdl2iI
Message-ID: <CAADnVQKM3zCvUv_ja+QCCO20eHZ0qrYpReNguXToZpaf46vEFg@mail.gmail.com>
Subject: Re: [Question] json parsing and bpf selftests dependencies
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 2:36=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hello,
> I am pursuing my quest to convert standalone bpf tests (from
> tools/testing/selftests/bpf) into the test_progs framework so they can
> be executed automatically by the CI tooling.
>
> I would like to continue on the bpftool tests, especially
> test_bpftool.py ([1]).

I think it outlived itself long ago.
Just delete it.
Any new bpftool features can be tested through test_progs.
No need to test json output specifically.
It's diminishing returns.
