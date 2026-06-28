Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA7340D574;
	Sun, 28 Jun 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782654462; cv=none; b=CahS9rkJO+Ay/spoo7DFVrY/2N+0r41egDNFiiH0dJHF27KJh4I3gQ86RElZfeVxO2iQQasN3D4ZhoxE4dtn3CMa39Tsd//eRqhGvzIZq46behAO06pcjYiy21u9cqXnY5GkkpoSGktYurFS+lEvPVXLfu7LaXqWsuWEjdPa7Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782654462; c=relaxed/simple;
	bh=lHAdd9Bt4UkSSAKWgZhHkneA/dtUc4NCHwof00gbCC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=OQsFqyM2MfXYaYEF1WBXSRVR0Qc3v3VyLN2T+lhJnNQTz8Q+NTKSuc8q3WRgL0skj7jxKwItK3GArhcoR1tLRGoWhunJEW7UfSD46y/pdX0MLNQzCekJrACXpzb0iSsGsyHHG07+CyGcS/1A2kFFkIvV3IYa8Ui2W/n1bz6GQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=EJhUE/RV reason="signature verification failed"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="EJhUE/RV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=TzsdnpLP/lb6IjiFrhh3kLS
	jIlgXuod2YhZF+JnDHu8=; b=EJhUE/RVChFs7CXrnDtajdLXu+OaB3rWj6ACFaA
	MW1F/A+li6nBuMXfic97jH7qoKVaZ1QVuoeYrqIgUPjmIx1VisnJqPYw5AXsblHQ
	yOlqfqWkJemqA7yjQZraKuijVBEpCqU3iuBYVmq4yokHuksp3EA8vG7Bv0oM1IRR
	fl+g=
Received: from gnq25$mails.tsinghua.edu.cn ( [223.91.120.74] ) by
 ajax-webmail-web5 (Coremail) ; Sun, 28 Jun 2026 21:47:26 +0800 (GMT+08:00)
Date: Sun, 28 Jun 2026 21:47:26 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"John Fastabend" <john.fastabend@gmail.com>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Shuah Khan" <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH bpf 2/2] selftests/bpf: Cover fastcall helper stack
 reads
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <34a46040b0e35eb63fa0fd22436bf9e9eee0bc97.camel@gmail.com>
References: <20260624-f01-12-fastcall-helper-stack-read-v1-0-e0a86085ef77@mails.tsinghua.edu.cn>
 <20260624-f01-12-fastcall-helper-stack-read-v1-2-e0a86085ef77@mails.tsinghua.edu.cn>
 <34a46040b0e35eb63fa0fd22436bf9e9eee0bc97.camel@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5de557bb.8f9b6.19f0e7c2cea.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:zAQGZQAnksHuJUFqqDbCAg--.52794W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgALA2o+-J1GFQA
	Dsv
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiRWR1YXJkIFppbmdlcm1h
biIgPGVkZHl6ODdAZ21haWwuY29tPgo+IFNlbmQgdGltZTpGcmlkYXksIDI2LzA2LzIwMjYgMDI6
MzU6MzkKPiBUbzogIk51b3FpIEd1aSIgPGducTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4sICJB
bGV4ZWkgU3Rhcm92b2l0b3YiIDxhc3RAa2VybmVsLm9yZz4sICJEYW5pZWwgQm9ya21hbm4iIDxk
YW5pZWxAaW9nZWFyYm94Lm5ldD4sICJBbmRyaWkgTmFrcnlpa28iIDxhbmRyaWlAa2VybmVsLm9y
Zz4sICJLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSIgPG1lbXhvckBnbWFpbC5jb20+Cj4gQ2M6ICJK
b2huIEZhc3RhYmVuZCIgPGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbT4sICJNYXJ0aW4gS2FGYWkg
TGF1IiA8bWFydGluLmxhdUBsaW51eC5kZXY+LCAiU2h1YWggS2hhbiIgPHNodWFoQGtlcm5lbC5v
cmc+LCBicGZAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3Jn
LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSCBicGYg
Mi8yXSBzZWxmdGVzdHMvYnBmOiBDb3ZlciBmYXN0Y2FsbCBoZWxwZXIgc3RhY2sgcmVhZHMKPiAK
PiBPbiBXZWQsIDIwMjYtMDYtMjQgYXQgMTY6MzkgKzA4MDAsIE51b3FpIEd1aSB3cm90ZToKPiA+
IEFkZCB2ZXJpZmllcl9icGZfZmFzdGNhbGwgdGVzdCB3aGVyZSBhIHNwaWxsL2ZpbGwgcGFpciBp
bml0aWFsaXplcyBhIHN0YWNrCj4gPiBzbG90LiBicGZfY3N1bV9kaWZmKCkgbGF0ZXIgcmVhZHMg
aXQgdGhyb3VnaCBBUkdfUFRSX1RPX01FTSB8IE1FTV9SRE9OTFkuCj4gPiAKPiA+IFRoZSB0cmFu
c2xhdGVkIHByb2dyYW0gbXVzdCBrZWVwIHRoZSBzcGlsbCBhbmQgZmlsbCBtYXRlcmlhbGl6ZWQu
IE90aGVyd2lzZQo+ID4gdGhlIGhlbHBlciByZWFkcyBzdGFjayBieXRlcyB0aGF0IG5vIGxvbmdl
ciBtYXRjaCB0aGUgdmVyaWZpZXIgbW9kZWwuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IE51b3Fp
IEd1aSA8Z25xMjVAbWFpbHMudHNpbmdodWEuZWR1LmNuPgo+ID4gLS0tCj4gCj4gQ291bGQgeW91
IHBsZWFzZSBhZGQgYSBrZnVuYyBiYXNlZCB0ZXN0IGNhc2UgYXMgd2VsbD8KPiAKPiBbLi4uXQpT
dXJlLCBJJ2xsIGFkZCBhIGtmdW5jLWJhc2VkIHZlcmlmaWVyIHRlc3QgYXMgd2VsbC4K
