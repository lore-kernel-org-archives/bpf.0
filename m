Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C9B3EC801;
	Wed, 29 Jul 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337061; cv=none; b=jLrEbc+foFxpU2b17T/l4+BloQ9jAFOVAkZ91Yy105Rg2O5pYGSp2ykpj6VCsdsdihifL7KO9WbUQb6BxyucJhm+daeblRDKXO8/P2lbh0g9iRgaKMq+1vTbQIql3MEhu4PeXP5AfN08omHLcm1dW4oPhhB798J67YLoDuseNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337061; c=relaxed/simple;
	bh=kwTzCpStkmaiEYwZiSizoIIbS8dAU8QVCIBuDw9oYHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFu5ghg0SVEEPbUIxH8N0y0UZFduaNbQxUwcJAiFYDz06N0HaCux7yVjSNseJ0aB7xLcQwL2+oyXKMV8OtBTkGr0jRYDUmNW7nFJbcaw68Y8Luefi0CKjnzjUQDkcmx6WTJuBwtHJXYeFLl+v7G7JGLUToV/DMjLC0CKg1JS2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Jq/PpMst; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Jq/PpMst"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785337056; x=1785941856; i=markus.elfring@web.de;
	bh=I4gUHIkqas/70ho9LgtcWee1qa3Xq2OY0hiL/UkUef8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Jq/PpMstKqSkyT8JK2PbQ5KOz2fs+E8gjCUggzg//oEw0gnD00BvJN4bLex7Mzup
	 bvI3umWGNrAzN/a1gaNngPVgBbqQH1Wo5S7/8a4h9WuDQphT5kIu97ibg9Ifa/1HP
	 KGjeIy5KnxA4HwzY69dC+oxpFdu/lKm72Y7k0Ve1q277JxGfk2VoSz6mRFvg/E5tw
	 rPSo3iy3wpPvWoYd98lsKRmu86ftIwtTCKpx0uI2TlvHqdi/BI1pf3trKwnaBnXiU
	 hEHXhvscmuALOp5YSA6jQHkC0lY45HqMOjdAiVhR6v4Bb0EGKF4pouvm4BFFuPZun
	 zYl6Pb9+5QrutI1ogg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRMB-1xRRQF3XLT-00gDNe; Wed, 29
 Jul 2026 16:57:36 +0200
Message-ID: <fb7722ec-245b-4104-a41b-3b5cfdc0e74f@web.de>
Date: Wed, 29 Jul 2026 16:57:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 00/15] media: Fix leaks in rc core
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org
Cc: bpf@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <cover.1785158244.git.sean@mess.org>
 <aa8628c4-0106-4dcf-afea-b350daef0f96@web.de>
 <amoUNjKOyFMudlDJ@extorris.mess.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <amoUNjKOyFMudlDJ@extorris.mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WgKmyFfUSoqAbw0FP8RRFj1W0GWQmbRBiGgFe0OC0qNxZkFn/9M
 7CgaKSncZ0KwJwnK0sR+PTzhO6pkCPO6EGOUuW5RqJr18ojrPuzuV1DzQtiTnwXIxsJr8IH
 Q0UDBNdtQS91OfoAyllZk7lhb0zBzynzT0S9G8+uUZBGQcUbBS01EvhM3Lz789lcTT+p+Z9
 WgABt4mNLY40nAJJwfY8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0VVaLXRWJ9A=;RTdEE/Vo9IMgGgBMHXOTZqUqmAn
 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
 B6TBdvg3ZBgsVS/zMoVTFc/0jodgGs

>> =E2=80=A6
>>>   media: rc: Fix use after free in bpf progs
>>>   media: cx88: Specify rc type at rc_allocate_type()
>>>   media: saa7134: Specify rc type at rc_allocate_type()
>>>   media: rc: Fix race condition during rc_register_device()
>> =E2=80=A6
>>
>> How do you think about to reorder desirable adjustments for affected mo=
dules?
>=20
> I'm not entirely sure what you mean. Do you mean just sort the
> commits so that media: rc: .. sits next to each other?
Yes (for example).

Regards,
Markus
