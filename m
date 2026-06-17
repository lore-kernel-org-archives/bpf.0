Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9812F7F06;
	Wed, 17 Jun 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705206; cv=none; b=eCKHq0QEonh0d70edPVGt+wmZZGDUG9FuFOPPll+Ps7OIifB9Fax4+MFLG87u6uR8bpHl5TyRDYn81E/Hj+E2j1KdJwHIC0MSOdMz+ybT5it8w6+Qr0lYeIYf5/LFx5y6F9xq8KyYxvtQaK0ro+AjgZj56+zUxZjl8EPATBRORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705206; c=relaxed/simple;
	bh=3hsN54I4SmZ3/pcalc9UrFu3bjZa5plWsx/1GzoFmG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=UGt3dLR/ZXdmZvSybmDTkAV/KA2sdVQc0r3r1BTRcx9wchATLxc7ffdVeloqJhPtTUUNyEEuotg/BufvAMRTqP4rQX5Dnc4A8JvNpf6DZOtWSX3l4h6eWxFYRDEo1Z8ar/aKz4eaa+uQe9yBrAqc0yKETV74hih7I0amX1MYYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=EFzWAkXC reason="signature verification failed"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="EFzWAkXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=2/Z3hUzcdXG1CKnSkuzlAZO
	kiYtAhMpGpMwn+XV/O6o=; b=EFzWAkXCpOb2apVhGSbtlblntac361UxqYSEfg9
	dlbE2osxjSUr81mN3Cd8HV8CXXOMxzHi4VwXwPC0YClr9BIwbv1rGc/4iOAcTsKP
	LdAq+md9ncxjWs7I6YY3DDVtclWMA6hoxM3In/masrlgQdnEIfFNBhFb3LDvCXeU
	RSmM=
Received: from gnq25$mails.tsinghua.edu.cn ( [59.66.19.181] ) by
 ajax-webmail-web4 (Coremail) ; Wed, 17 Jun 2026 22:06:20 +0800 (GMT+08:00)
Date: Wed, 17 Jun 2026 22:06:20 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
To: "Luis Gerhorst" <luis.gerhorst@fau.de>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"John Fastabend" <john.fastabend@gmail.com>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Shuah Khan" <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH bpf 2/2] selftests/bpf: Cover stack nospec slot
 indexing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <871pe5v9kx.fsf@fau.de>
References: <20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn>
 <20260617-f01-11-stack-nospec-slot-index-v1-2-e3a080b0cd7e@mails.tsinghua.edu.cn>
 <871pe5v9kx.fsf@fau.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5c64a230.7e51b.19ed5e78649.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:ywQGZQDX66DcqTJqSllTAg--.34089W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQYBA2oyQ815QwA
	Est
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiTHVpcyBHZXJob3JzdCIg
PGx1aXMuZ2VyaG9yc3RAZmF1LmRlPgo+IFNlbmQgdGltZTpXZWRuZXNkYXksIDE3LzA2LzIwMjYg
MTY6NDU6NTAKPiBUbzogIk51b3FpIEd1aSIgPGducTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4s
ICJFZHVhcmQgWmluZ2VybWFuIiA8ZWRkeXo4N0BnbWFpbC5jb20+LCAiS3VtYXIgS2FydGlrZXlh
IER3aXZlZGkiIDxtZW14b3JAZ21haWwuY29tPgo+IENjOiAiQWxleGVpIFN0YXJvdm9pdG92IiA8
YXN0QGtlcm5lbC5vcmc+LCAiRGFuaWVsIEJvcmttYW5uIiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+
LCAiQW5kcmlpIE5ha3J5aWtvIiA8YW5kcmlpQGtlcm5lbC5vcmc+LCAiSm9obgo+ICBGYXN0YWJl
bmQiIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+LCAiTWFydGluIEthRmFpIExhdSIgPG1hcnRp
bi5sYXVAbGludXguZGV2PiwgIlNodWFoIEtoYW4iIDxzaHVhaEBrZXJuZWwub3JnPiwgYnBmQHZn
ZXIua2VybmVsLm9yZywgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZywgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZwo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggYnBmIDIvMl0gc2VsZnRl
c3RzL2JwZjogQ292ZXIgc3RhY2sgbm9zcGVjIHNsb3QgaW5kZXhpbmcKPiAKPiBOdW9xaSBHdWkg
PGducTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4gd3JpdGVzOgo+IAo+ID4gQWRkIGEgdmVyaWZp
ZXIgdGVzdCBmb3IgdGhlIGZpeGVkLW9mZnNldCBzdGFjayB3cml0ZSBjYXNlIHdoZXJlIHR3byA0
LWJ5dGUKPiA+IHN0b3JlcyBpbml0aWFsaXplIG9wcG9zaXRlIGhhbHZlcyBvZiB0aGUgc2FtZSBz
dGFjayBzbG90Lgo+ID4KPiA+IFRoZSB0ZXN0IHVzZXMgdGhlIENBUF9CUEYtd2l0aG91dC1DQVBf
UEVSRk1PTiBsb2FkZXIgbGFuZSBzbyBTcGVjdHJlIHY0Cj4gPiBtaXRpZ2F0aW9uIHJlbWFpbnMg
YWN0aXZlLiBJdCBleHBlY3RzIGJvdGggaGFsZi1zbG90IHdyaXRlcyB0byBlbWl0IG5vc3BlYwo+
ID4gaW4gdGhlIHRyYW5zbGF0ZWQgcHJvZ3JhbS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBOdW9x
aSBHdWkgPGducTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4KPiA+IC0tLQo+ID4gIC4uLi90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJfdW5wcml2LmMgIHwgMjMgKysrKysrKysr
KysrKysrKysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy92ZXJpZmll
cl91bnByaXYuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy92ZXJpZmllcl91
bnByaXYuYwo+ID4gaW5kZXggYzE2ZjgzODJjZjE3ZC4uOWViYmQ0YjUzMWRmMSAxMDA2NDQKPiA+
IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy92ZXJpZmllcl91bnByaXYu
Ywo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3ZlcmlmaWVyX3Vu
cHJpdi5jCj4gPiBAQCAtOTc2LDQgKzk3NiwyNyBAQCBsMF8lPToJZXhpdDsJCQkJCQlcCj4gPiAg
CTogX19jbG9iYmVyX2FsbCk7Cj4gPiAgfQo+ID4gIAo+ID4gK1NFQygic29ja2V0IikKPiA+ICtf
X2Rlc2NyaXB0aW9uKCJub3BlcmZtb246IFNwZWN0cmUgdjQgc3RhY2sgd3JpdGUgc2xvdCBpbmRl
eCIpCj4gPiArX19zdWNjZXNzIF9fc3VjY2Vzc191bnByaXYKPiA+ICtfX2NhcHNfdW5wcml2KENB
UF9CUEYpCj4gCj4gTm90IHN1cmUgaWYgdGhlIGNvbmRpdGlvbnMgdGhhdCBsZWQgS2FydGlrZXlh
IGFuZCBFZHVhcmQgdG8gYWRkCj4gX19jYXBzX3VucHJpdihDQVBfQlBGKSBleHBsaWNpdGx5IGZv
ciBzb21lIHRlc3RzIGFsc28gYXBwbHkgaGVyZS4KPiAKPiBJdCBzZWVtcyBhZGRpbmcgaXQgdG8g
dGhpcyB0ZXN0IHdpbGwgbm90IHByb3ZpZGUgbXVjaCBiZW5lZml0IGJlY2F1c2UKPiB0aGUgb3Ro
ZXIgdGVzdHMgaW4gdmVyaWZpZXJfdW5wcml2LmMgYWxyZWFkeSBhc3N1bWUKPiBzeXNjdGxfdW5w
cml2aWxlZ2VkX2JwZl9kaXNhYmxlZD0wLgo+IAo+IEJlY2F1c2UgdGhpcyBhbHJlYWR5IGFmZmVj
dHMgdGhlIG1vcmUgcmVzdHJpY3RlZCAndW5wcml2IHByb2Nlc3MgdW5kZXIKPiBzeXNjdGxfdW5w
cml2aWxlZ2VkX2JwZl9kaXNhYmxlZD0wIHdpdGhvdXQgQ0FQX0JQRicgZW52aXJvbm1lbnQsIEkK
PiBzdWdnZXN0IGRyb3BwaW5nIF9fY2Fwc191bnByaXYoQ0FQX0JQRikgaXQuCj4gCj4gPiArX19y
ZXR2YWwoMCkKPiA+ICsjaWZkZWYgU1BFQ19WNAo+ID4gK19feGxhdGVkX3VucHJpdigicjAgPSAw
IikKPiA+ICtfX3hsYXRlZF91bnByaXYoIioodTMyICopKHIxMCAtNCkgPSByMCIpCj4gPiArX194
bGF0ZWRfdW5wcml2KCJub3NwZWMiKQo+ID4gK19feGxhdGVkX3VucHJpdigiKih1MzIgKikocjEw
IC04KSA9IHIwIikKPiA+ICtfX3hsYXRlZF91bnByaXYoIm5vc3BlYyIpCj4gPiArX194bGF0ZWRf
dW5wcml2KCJleGl0IikKPiA+ICsjZW5kaWYKPiA+ICtfX25ha2VkIHZvaWQgc3RhY2tfd3JpdGVf
bm9zcGVjX3Nsb3RfaW5kZXgodm9pZCkKPiA+ICt7Cj4gPiArCWFzbSB2b2xhdGlsZSAoIgkJCQkJ
XAo+ID4gKwlyMCA9IDA7CQkJCQkJXAo+ID4gKwkqKHUzMiAqKShyMTAgLSA0KSA9IHIwOwkJCVwK
PiA+ICsJKih1MzIgKikocjEwIC0gOCkgPSByMDsJCQlcCj4gPiArCWV4aXQ7CQkJCQkJXAo+ID4g
KyIJOjo6IF9fY2xvYmJlcl9hbGwpOwo+ID4gK30KPiA+ICsKPiA+ICBjaGFyIF9saWNlbnNlW10g
U0VDKCJsaWNlbnNlIikgPSAiR1BMIjsKPiAKPiBBY2tlZC1ieTogTHVpcyBHZXJob3JzdCA8bHVp
cy5nZXJob3JzdEBmYXUuZGU+CgpUaGFua3MuCgpJJ2xsIGRyb3AgX19jYXBzX3VucHJpdihDQVBf
QlBGKS4K
