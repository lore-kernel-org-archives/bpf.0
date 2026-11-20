Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141471;
	b=S5E54nsX7iAnoJ9BRN4fXOdAIfeuunbOddKv7Gho293co3aMrAuxVDxcHU3PIuIp5W67
	 JtCG628DDeh8lYTKdyP/BXCZFm8O8Zi35un5g8KBDqOPe9Pu8lSKs9v69JchgM75sokHk
	 z4fqkFb48kYLze3pfWjiQHXPEDm2DdHN1RyMsapNyXq90z+wGsjA7YQLHgKxC3h5DTonJ
	 HCwtm4t4VF5AKO/ZEmqXT4RB07UmyuIGAXZdj2z9ZzweeXMAOMIIZk6qyXGIsKk0NIQqQ
	 xIdsvI6Pv5gMAD0Kqxi1TibLIp6+ORfsBr+0PPsufgYdr1tzjltVEQ4Vs231LnHRmFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141471;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=87Q3iVLWtuj55C4RlB6+1wZEhmO58MaKa1CtAE9L5Fg=;
	b=iDMvmCD6rrhxS1i3i51eck0PFZaU2q/3x5L8BZBHsBMJiovtWp+sLmU1lTsGQg0BEDnR
	 dbX9/V57km+mWXnmCOQnqywX1E8ysQCg3n1Nd/U71/9CdJBcBX60ujbfVUZOedFCqz8Oc
	 S2MCqPvheljKvt292KihqqlO8BHvyG8AyOrOv/g94UCs7WsmwH7+qTrr0ynP3zscndoNq
	 k8vY+3OOPy1z7HKAJ6mv56W+h/Sv6Nbu3HGkRJrHefRS7h9Umvs41hcMWA12Vp2s53Mna
	 RSLOdeeL9tnEuFooPouUrTT2IA55BIRormsqqbmfordz8tyFFm0ymEA0V4JB2WqKXgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=C+tO3VaB;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE02606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 02:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EE02606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=C+tO3VaB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=87Q3iVLWtuj55C4RlB6+1wZEhmO58MaKa1CtAE9L5Fg=; b=C
	+tO3VaBoMXO35uLNKwdsSJA04daEQaYkvNUuEOt83tI+/3OGXEs1Ni4+jv1fEojZ
	p8tS5wsS8HMr99tmgObamaAxEzukw07Pzq9b3FVoMXRIA9Hfl67BKKr8gJ6dKYBN
	jJ2oYNK+k+pSbPjDpPgt0zJ8w/JUmbHjqamTt2aQdE=
Date: Fri, 20 Nov 2026 10:24:20 +0800 (CST)
From: chenyuan  <chenyuan_fl@163.com>
To: "Nirmoy Das" <nirmoyd@nvidia.com>
Cc: bpf@vger.kernel.org
Subject: Re:Re: [PATCH bpf v6 0/2] bpf: Fix kfunc implicit arg injection and
 add selftest
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261118205130.3014100-1-nirmoyd@nvidia.com>
References: <20260608142618.3064380-1-chenyuan_fl@163.com>
 <20260609125214.3096351-1-chenyuan_fl@163.com>
 <20261118205130.3014100-1-nirmoyd@nvidia.com>
X-NTES-SC: AL_Qu2SB/2fvkwt5iKdbekdnUYWg+8/X8W3svwi2YVUc+gGvDHy4D0iVmR6FFTb9uOEMySpqCWrbgNTxOtYZ5dmI8chApDUEK1cvlIywkNYQg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <27e514c4.221a.1a1f6c4e12d.Coremail.chenyuan_fl@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iCgvCgD3X3ZVr_9q8OhxAA--.645W
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAhWbWWr-r1UcFQAA3z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgTmlybW95LApTb3JyeSwgdGhpcyBwYXRjaCBzZXJpZXMgc2xpcHBlZCBvZmYgbXkgcmFkYXIu
IFRoYW5rcyBmb3IgdGhlIGZvbGxvdy11cCBhbmQgZm9yIHRlc3RpbmcgdjYhCkknbGwgcHJlcGFy
ZSBhbmQgc2VuZCBvdXQgdjcgYXMgc29vbiBhcyBwb3NzaWJsZS4KVGhhbmtzIGFnYWluIGZvciB5
b3VyIGhlbHAhCkJlc3QgcmVnYXJkcywKWXVhbgoKCgoKCgpBdCAyMDI2LTExLTE5IDA0OjUxOjI4
LCAiTmlybW95IERhcyIgPG5pcm1veWRAbnZpZGlhLmNvbT4gd3JvdGU6Cj5IaSBZdWFuLAo+Cj5J
IHRlc3RlZCB2NiBvbiBhIDcuMyBrZXJuZWwgd2l0aCBhIG1vZHVsZSBCVEYgbWlzbWF0Y2guIFRo
ZSB1bnBhdGNoZWQKPmtlcm5lbCBvb3BzZWQsIGFuZCB2NiByZWplY3RlZCB0aGUgcHJvZ3JhbSBh
dCBsb2FkIHRpbWUuCj4KPkFyZSB5b3UgcGxhbm5pbmcgdG8gcG9zdCBhIHY3IG9mIHRoaXMgc2Vy
aWVzPyBXZSdkIGxpa2UgdG8gZ2V0IHRoaXMKPmZpeGVkIHVwc3RyZWFtLCBhbmQgSSdkIGJlIGhh
cHB5IHRvIHRlc3QgdGhlIG5leHQgcmV2aXNpb24uCj4KPlRoYW5rcywKPk5pcm1veQo=
