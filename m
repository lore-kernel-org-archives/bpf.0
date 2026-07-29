Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD873A9DA2;
	Wed, 29 Jul 2026 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305956; cv=none; b=MxaffRaKnBf2b4b3BdMc2/2rXO1Hvj4BGMhinjXmdka+5joWlgDp4mPHoQo7w65wWUflI7K+SlzflI3D/3Ue7XmEb5O2uA5Uqvgf7MPsmYoG3EhodhhzrdM0gEWbkdcNNYZRbwqThJ64ddGVKQ7+IsIhtGXMIz45TCwZ7NwAvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305956; c=relaxed/simple;
	bh=qz44UAtO7AdyJmwwD/K1woukfgLcTtVb9zzDOSnRXko=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=iC/1F3J+N1jWVAIuMYGhcOIFF+WVnRnXtnRcSH9m3xky1kDxYzQInLXsGHw+2QeZuFjCz7My3XzC/RBaT5TspicJcLB/Ytv63cpDkFIP1l3Z53yT11dVxgBWMADU1+dVHoOcqCOou9dtDfU3IT9crBoaTSKdzJCzgzqdhiu0nZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GOMgr0ko; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GOMgr0ko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785305945; x=1785910745; i=markus.elfring@web.de;
	bh=El/mzm1rF0aZflL2YJq9q9jDQviDw70X8NWbEdmU0ws=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GOMgr0koYscXyyVnJsxMhQfIErNJ2puE6rnxivqYTsYO63zLgxm5aGQSLxCFkkY8
	 PW5+ZiRjlhWHsd4aklFLx+6COA3HVy8Dwafnkx+GitvVRfFCrGUf08tUpkcwkOc60
	 CpOfO7sa9bmjviuxrjZVRNBeGTxcGfypYj0kbLtb0mrnBGR9O27z+pGM+Dk+UU6py
	 nvhhZVbGJ0O6MZv9r4+4X8HP1oOj0RKRZ+ry39wGvhjpowF1nCgRMjgpgvOmgi02K
	 /Ak+j2sd0IuIiANJFwt7tMsdskgijRYsEnNkQ6aRcg1m/7EqVz6aN+57BxCjIeAhQ
	 6e0hLx3CfsXl+2quog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1x9llV2NAa-010SIU; Wed, 29
 Jul 2026 08:19:05 +0200
Message-ID: <aa8628c4-0106-4dcf-afea-b350daef0f96@web.de>
Date: Wed, 29 Jul 2026 08:18:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
 bpf@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <cover.1785158244.git.sean@mess.org>
Subject: Re: [PATCH v4 00/15] media: Fix leaks in rc core
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cover.1785158244.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wg8bXsyVfuS8RSFIUQxfqEjtv13yMkPvxot025O4MlwUBm0fw9y
 ZpWSSZYEk7pRxzQ5Qt+DbY1U5esiFl4Ja9QQV0maa+ngE9KhAAICBVd2z7xgbRFu13XMRDv
 DzZ32jSeDNXsLFrM/OsaW/z9tEFmjVO9UPOBcWy2VPcsSmMsl6eBcZavlXpufshM6EVkXyZ
 dqhOJiEfFFuqeazXRTHbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lnztmk5GyqY=;zu4IcieqlTXp6igDqEDqGN95U1p
 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

=E2=80=A6
>   media: rc: Fix use after free in bpf progs
>   media: cx88: Specify rc type at rc_allocate_type()
>   media: saa7134: Specify rc type at rc_allocate_type()
>   media: rc: Fix race condition during rc_register_device()
=E2=80=A6

How do you think about to reorder desirable adjustments for affected modul=
es?

Regards,
Markus
