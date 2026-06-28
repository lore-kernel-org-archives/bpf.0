Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8414A60F;
	Sun, 28 Jun 2026 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782654439; cv=none; b=QRDFz67vkXVOZHZ8TsLnAo0Yk3CMhZ7//ETzDRgzbugxPQ8H+lCEVSyoCFmPYkM44kjqV3mlbtFLdXWWExDn3e4UTfUXmogENiT9M2uAp8Nj4O0fGIfpIhYGzdLNjb/J2CoghOdIF88OIVJnix5JfoHFUeoLhLE+IiVyXdAJ5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782654439; c=relaxed/simple;
	bh=FuK6gfwAMDQWmqwi0Ss5ih2VwH2mSY3+2PRUBQFb78U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=fJ92+4/xQm23EKJXYyHiV1ytTr3gBKy7wiJ7gKYAXzOJT+Q8OuJ6JR2SKuqE4Yov8KoNwaWCpatvzaF9hBGJ6tjXcjPtFmxSG5aSvI36fh0suZ7TliK7EFC2VWY0aIypHV/EyH8epjnHU+LtmkRnHTNgies6zdboodC3/KY4YWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=nmQRH6Y0 reason="signature verification failed"; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="nmQRH6Y0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=BOlgDdxUOU9GUCKDwvd8CJM
	njfclfYSYdjVDYLjrlLM=; b=nmQRH6Y0UAaRRjUyiOcIqwH2AeQUy8AzYQY5AGy
	7TFVTUeJ6BmAz/ZE8rAL8SGMOtPi/Ot+0jnYEpT4Y+BvWWkkoyX0/7mAHL9mcIb8
	DIqLpeFr4kDQs8MJ2BszDkrpC9Z8/9o8PTM+31F6mmnRyGarrH4jUVbY0zsoUFCX
	MEwY=
Received: from gnq25$mails.tsinghua.edu.cn ( [223.91.120.74] ) by
 ajax-webmail-web5 (Coremail) ; Sun, 28 Jun 2026 21:46:55 +0800 (GMT+08:00)
Date: Sun, 28 Jun 2026 21:46:55 +0800 (GMT+08:00)
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
Subject: Re: Re: [PATCH bpf 1/2] bpf: Keep fastcall spills for helper stack
 reads
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <860e915356c571791712be02c636405aadfc6467.camel@gmail.com>
References: <20260624-f01-12-fastcall-helper-stack-read-v1-0-e0a86085ef77@mails.tsinghua.edu.cn>
 <20260624-f01-12-fastcall-helper-stack-read-v1-1-e0a86085ef77@mails.tsinghua.edu.cn>
 <860e915356c571791712be02c636405aadfc6467.camel@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <62784b34.8f9b3.19f0e7bb2bf.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:zAQGZQAnksHQJUFq_jXCAg--.52791W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgALA2o+-J1GFQA
	Csu
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiRWR1YXJkIFppbmdlcm1h
biIgPGVkZHl6ODdAZ21haWwuY29tPgo+IFNlbmQgdGltZTpGcmlkYXksIDI2LzA2LzIwMjYgMDI6
MzI6MzIKPiBUbzogIk51b3FpIEd1aSIgPGducTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4sICJB
bGV4ZWkgU3Rhcm92b2l0b3YiIDxhc3RAa2VybmVsLm9yZz4sICJEYW5pZWwgQm9ya21hbm4iIDxk
YW5pZWxAaW9nZWFyYm94Lm5ldD4sICJBbmRyaWkgTmFrcnlpa28iIDxhbmRyaWlAa2VybmVsLm9y
Zz4sICJLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSIgPG1lbXhvckBnbWFpbC5jb20+Cj4gQ2M6ICJK
b2huIEZhc3RhYmVuZCIgPGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbT4sICJNYXJ0aW4gS2FGYWkg
TGF1IiA8bWFydGluLmxhdUBsaW51eC5kZXY+LCAiU2h1YWggS2hhbiIgPHNodWFoQGtlcm5lbC5v
cmc+LCBicGZAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3Jn
LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSCBicGYg
MS8yXSBicGY6IEtlZXAgZmFzdGNhbGwgc3BpbGxzIGZvciBoZWxwZXIgc3RhY2sgcmVhZHMKPiAK
PiBPbiBXZWQsIDIwMjYtMDYtMjQgYXQgMTY6MzkgKzA4MDAsIE51b3FpIEd1aSB3cm90ZToKPiA+
IFRoZSBmYXN0Y2FsbCBzcGlsbC9maWxsIHJld3JpdGUgaXMgb25seSBzb3VuZCB3aGlsZSB0aGUg
c3RhY2sgc2xvdHMgdXNlZCBieQo+ID4gdGhlIHBhdHRlcm4gYXJlIG5vdCBhY2Nlc3NlZCBvdXRz
aWRlIHRoZSBwYXR0ZXJuLiBEaXJlY3Qgc3RhY2sgbG9hZHMgYW5kCj4gPiBzdG9yZXMgYWxyZWFk
eSBjYWxsIGNoZWNrX2Zhc3RjYWxsX3N0YWNrX2NvbnRyYWN0KCkgdG8gZW5mb3JjZSB0aGlzLgo+
ID4gCj4gPiBIZWxwZXIgYW5kIGtmdW5jIG1lbW9yeS1hcmd1bWVudCBjaGVja3MgY2FuIHZhbGlk
YXRlIFBUUl9UT19TVEFDSyByZWFkcwo+ID4gdGhyb3VnaCBjaGVja19zdGFja19yYW5nZV9pbml0
aWFsaXplZCgpIHdpdGhvdXQgYXBwbHlpbmcgdGhlIHNhbWUgY29udHJhY3QuCj4gPiBXaGVuIHN1
Y2ggYSByZWFkIG92ZXJsYXBzIGEgZmFzdGNhbGwgc3BpbGwgc2xvdCwKPiA+IGJwZl9yZW1vdmVf
ZmFzdGNhbGxfc3BpbGxzX2ZpbGxzKCkgY2FuIHN0aWxsIHJlbW92ZSB0aGUgc3BpbGwvZmlsbCBw
YWlyLgo+ID4gSXQgY2FuIHRoZW4gc2hyaW5rIHRoZSBzdWJwcm9ncmFtIHN0YWNrIGRlcHRoIGV2
ZW4gdGhvdWdoIGEgaGVscGVyIG9yIGtmdW5jCj4gPiByZWFkcyB0aGF0IHN0YWNrIGFkZHJlc3Mu
Cj4gPiAKPiA+IEFwcGx5IGNoZWNrX2Zhc3RjYWxsX3N0YWNrX2NvbnRyYWN0KCkgZnJvbSBjaGVj
a19zdGFja19yYW5nZV9pbml0aWFsaXplZCgpCj4gPiBhZnRlciB0aGUgY29uY3JldGUgc3RhY2sg
cmFuZ2UgaXMga25vd24uIFplcm8tc2l6ZWQgYWNjZXNzZXMgZG8gbm90IHJlYWQgb3IKPiA+IHdy
aXRlIG1lbW9yeSwgc28gbGVhdmUgdGhlIGZhc3RjYWxsIG9wdGltaXphdGlvbiB1bmNoYW5nZWQg
Zm9yIHRob3NlLgo+ID4gCj4gPiBGaXhlczogNWI1ZjUxYmZmMWI2NiAoImJwZjogbm9fY2FsbGVy
X3NhdmVkX3JlZ2lzdGVycyBhdHRyaWJ1dGUgZm9yIGhlbHBlciBjYWxscyIpCj4gPiBTaWduZWQt
b2ZmLWJ5OiBOdW9xaSBHdWkgPGducTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4KPiA+IC0tLQo+
ID4gIGtlcm5lbC9icGYvdmVyaWZpZXIuYyB8IDQgKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIu
YyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwo+ID4gaW5kZXggZmY5YjFmNjhjZWNhNC4uZDc3MzMy
ZWVhYjM1OSAxMDA2NDQKPiA+IC0tLSBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYwo+ID4gKysrIGIv
a2VybmVsL2JwZi92ZXJpZmllci5jCj4gPiBAQCAtNjg3Myw2ICs2ODczLDEwIEBAIHN0YXRpYyBp
bnQgY2hlY2tfc3RhY2tfcmFuZ2VfaW5pdGlhbGl6ZWQoCj4gPiAgCQltYXhfb2ZmID0gcmVnLT5z
bWF4X3ZhbHVlICsgb2ZmOwo+ID4gIAl9Cj4gPiAgCj4gPiArCWlmIChhY2Nlc3Nfc2l6ZSkKPiA+
ICsJCWNoZWNrX2Zhc3RjYWxsX3N0YWNrX2NvbnRyYWN0KGVudiwgc3RhdGUsIGVudi0+aW5zbl9p
ZHgsCj4gPiArCQkJCQkgICAgICBtaW5fb2ZmKTsKPiA+ICsKPiAKPiBUaGFuayB5b3UgZm9yIGZp
bmRpbmcgdGhpcyBidWcuCj4gSSB0aGluayB0aGF0IHBsYWNpbmcgdGhlIGNoZWNrX2Zhc3RjYWxs
X3N0YWNrX2NvbnRyYWN0KCkgY2FsbCBoZXJlCj4gbWFrZXMgdGhlIHNhbWUgY2FsbCB1bm5lY2Vz
c2FyeSBpbiB0aGUgY2hlY2tfc3RhY2tfcmVhZF92YXJfb2ZmKCksCj4gYXMgaXQgY2FsbHMgdG8g
Y2hlY2tfc3RhY2tfcmFuZ2VfaW5pdGlhbGl6ZWQoKSB3aXRoIHplcm9fc2l6ZV9hbGxvd2VkPT1m
YWxzZS4KPiAKPiA+ICAJaWYgKG1ldGEgJiYgbWV0YS0+cmF3X21vZGUpIHsKPiA+ICAJCS8qIEVu
c3VyZSB3ZSB3b24ndCBiZSBvdmVyd3JpdGluZyBkeW5wdHJzIHdoZW4gc2ltdWxhdGluZyBieXRl
Cj4gPiAgCQkgKiBieSBieXRlIGFjY2VzcyBpbiBjaGVja19oZWxwZXJfY2FsbCB1c2luZyBtZXRh
LmFjY2Vzc19zaXplLgoKVGhhbmtzLsKgSSdsbCByZW1vdmUgdGhlIHJlZHVuZGFudCBjYWxsIGZy
b20gY2hlY2tfc3RhY2tfcmVhZF92YXJfb2ZmKCkgaW4gdjIuCg==
