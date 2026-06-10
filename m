Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF013406822;
	Wed, 10 Jun 2026 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093811; cv=none; b=pVDb3w4I01/RXtbxKlnTai51DlresuPgb5A+fMLwxBkdJdTwFRh1ZmXUidWZuFo8wHCYdmDDOeGtctbBSzT5bH/P5e4Ocir0C/QWtIfMvcucDNooETbS0S8BPM1u7iaD52rQpfTz8uRqhBXi2zl8I2+TyXCLd8EZo1l2GGVbs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093811; c=relaxed/simple;
	bh=zALaufOLMYLnsWwx7+2sF1JJMuzq3viR/a0vJQ1dwWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=cBws1rMf3KeRcDYBiz2qvgAwNUmMFC3IAJJrpZvf4KEUQtDw1jIy3nvJmlkSXGGvZ/9fFsGmw3+H9R0sFOg2LTvzJJk1uwn7HBchKdVQgvKP2+dm8Vxo4lZ33NSrFzrIOM/Krt4cOeBWpdVrrlWJ2ysZLI1xaVB7HpPMaMJlf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ZhmfxllV reason="signature verification failed"; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ZhmfxllV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=QQQUOTyb3L4y+c+DtR3LhZZ
	rBdjJRFyBZess1u4JjIU=; b=ZhmfxllVTe/G6L1npuRuHfLJc897ICuNnxU500j
	hm6SJtM9pkw4zUFCWrLrYPrP4Nxx/BoTQWSKq8Xe2b43eSRALZMX1YXARVrPGZrF
	7MbbcgOcwXCWcbCpcmmtxXPdjc0dfSNqdxmV5R5sQoz85KdygvgCu9caVJmproB4
	9iYA=
Received: from gnq25$mails.tsinghua.edu.cn ( [59.66.19.181] ) by
 ajax-webmail-web2 (Coremail) ; Wed, 10 Jun 2026 20:16:21 +0800 (GMT+08:00)
Date: Wed, 10 Jun 2026 20:16:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"John Fastabend" <john.fastabend@gmail.com>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: Re: [PATCH bpf-next 1/2] bpf: Reject scalar addition from
 untrusted memory
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <DJ4Q75GQJ6MW.2TNULY7BLDWA0@etsalapatis.com>
References: <20260609-f01-03-scalar-add-bpf-next-v1-0-e6212e274155@mails.tsinghua.edu.cn>
 <20260609-f01-03-scalar-add-bpf-next-v1-1-e6212e274155@mails.tsinghua.edu.cn>
 <c6cf40ef2957b6b2acf8820bce10becda20d9dfd.camel@gmail.com>
 <DJ4Q75GQJ6MW.2TNULY7BLDWA0@etsalapatis.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <551f4852.79a12.19eb176505e.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:yQQGZQA3FJyVVSlqVF0oAg--.51498W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEOA2ooki9lEAA
	BsG
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiRW1pbCBUc2FsYXBhdGlz
IiA8ZW1pbEBldHNhbGFwYXRpcy5jb20+Cj4gU2VuZCB0aW1lOldlZG5lc2RheSwgMTAvMDYvMjAy
NiAwMjoyMTo0OQo+IFRvOiAiRWR1YXJkIFppbmdlcm1hbiIgPGVkZHl6ODdAZ21haWwuY29tPiwg
Ik51b3FpIEd1aSIgPGducTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4sICJBbGV4ZWkgU3Rhcm92
b2l0b3YiIDxhc3RAa2VybmVsLm9yZz4sICJEYW5pZWwgQm9ya21hbm4iIDxkYW5pZWxAaW9nZWFy
Ym94Lm5ldD4sICJBbmRyaWkgTmFrcnlpa28iIDxhbmRyaWlAa2VybmVsLm9yZz4KPiBDYzogIkt1
bWFyIEthcnRpa2V5YSBEd2l2ZWRpIiA8bWVteG9yQGdtYWlsLmNvbT4sICJKb2huIEZhc3RhYmVu
ZCIgPGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbT4sICJNYXJ0aW4gS2FGYWkgTGF1IiA8bWFydGlu
LmxhdUBsaW51eC5kZXY+LCAiU29uZyBMaXUiIDxzb25nQGtlcm5lbC5vcmc+LCAiWW9uZ2hvbmcg
U29uZyIgPHlvbmdob25nLnNvbmdAbGludXguZGV2PiwgIkppcmkgT2xzYSIgPGpvbHNhQGtlcm5l
bC5vcmc+LCAiU2h1YWggS2hhbiIgPHNodWFoQGtlcm5lbC5vcmc+LCBicGZAdmdlci5rZXJuZWwu
b3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rc2VsZnRlc3RAdmdlci5r
ZXJuZWwub3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSCBicGYtbmV4dCAxLzJdIGJwZjogUmVqZWN0
IHNjYWxhciBhZGRpdGlvbiBmcm9tIHVudHJ1c3RlZCBtZW1vcnkKPiAKPiBPbiBUdWUgSnVuIDks
IDIwMjYgYXQgMTowMSBQTSBFRFQsIEVkdWFyZCBaaW5nZXJtYW4gd3JvdGU6Cj4gPiBPbiBUdWUs
IDIwMjYtMDYtMDkgYXQgMjI6NTUgKzA4MDAsIE51b3FpIEd1aSB3cm90ZToKPiA+PiBzY2FsYXIg
Kz0gcmRvbmx5X3VudHJ1c3RlZF9tZW0gcmVhY2hlcyBhZGp1c3RfcHRyX21pbl9tYXhfdmFscygp
IHdpdGggdGhlCj4gPj4gcG9pbnRlciBhcyB0aGUgc291cmNlIHJlZ2lzdGVyLiBUaGUgdW50cnVz
dGVkIFBUUl9UT19NRU0gY2FzZSByZXR1cm5zIHRoZXJlCj4gPj4gd2l0aG91dCB1cGRhdGluZyB0
aGUgc2NhbGFyIGRlc3RpbmF0aW9uLCBsZWF2aW5nIHN0YWxlIHZlcmlmaWVyIHN0YXRlLgo+ID4+
IAo+ID4+IFJlamVjdCB0aGF0IGFkZGl0aW9uIGJlZm9yZSB0aGUgZWFybHkgcmV0dXJuLiBQb2lu
dGVyICs9IHNjYWxhciByZW1haW5zCj4gPj4gaGFuZGxlZCBieSB0aGUgZXhpc3RpbmcgdW50cnVz
dGVkLW1lbW9yeSBydWxlLgo+ID4+IAo+ID4+IEZpeGVzOiBmMjM2MmE1N2FlZmYgKCJicGY6IGFs
bG93IHZvaWQqIGNhc3QgdXNpbmcgYnBmX3Jkb25seV9jYXN0KCkiKQo+ID4+IFNpZ25lZC1vZmYt
Ynk6IE51b3FpIEd1aSA8Z25xMjVAbWFpbHMudHNpbmdodWEuZWR1LmNuPgo+ID4+IC0tLQo+ID4+
ICBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMgfCA4ICsrKysrKysrCj4gPj4gIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykKPiA+PiAKPiA+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi92ZXJp
Zmllci5jIGIva2VybmVsL2JwZi92ZXJpZmllci5jCj4gPj4gaW5kZXggYzhkOTgwZmRkNzA5Li5j
NmIzNTBmOTU4NWEgMTAwNjQ0Cj4gPj4gLS0tIGEva2VybmVsL2JwZi92ZXJpZmllci5jCj4gPj4g
KysrIGIva2VybmVsL2JwZi92ZXJpZmllci5jCj4gPj4gQEAgLTE0ODIzLDYgKzE0ODIzLDE0IEBA
IHN0YXRpYyBpbnQgYWRqdXN0X3JlZ19taW5fbWF4X3ZhbHMoc3RydWN0IGJwZl92ZXJpZmllcl9l
bnYgKmVudiwKPiA+PiAgCQkJCSAqIFRoaXMgaXMgbGVnYWwsIGJ1dCB3ZSBoYXZlIHRvIHJldmVy
c2Ugb3VyCj4gPj4gIAkJCQkgKiBzcmMvZGVzdCBoYW5kbGluZyBpbiBjb21wdXRpbmcgdGhlIHJh
bmdlCj4gPj4gIAkJCQkgKi8KPiA+PiArCQkJCWlmIChvcGNvZGUgPT0gQlBGX0FERCAmJgo+ID4+
ICsJCQkJICAgIGJhc2VfdHlwZShzcmNfcmVnLT50eXBlKSA9PSBQVFJfVE9fTUVNICYmCj4gPj4g
KwkJCQkgICAgKHNyY19yZWctPnR5cGUgJiBQVFJfVU5UUlVTVEVEKSkgewo+ID4+ICsJCQkJCXZl
cmJvc2UoZW52LCAiUiVkIHRyaWVkIHRvIGFkZCBmcm9tICVzIHRvIHNjYWxhclxuIiwKPiA+PiAr
CQkJCQkJaW5zbi0+ZHN0X3JlZywKPiA+PiArCQkJCQkJcmVnX3R5cGVfc3RyKGVudiwgc3JjX3Jl
Zy0+dHlwZSkpOwo+ID4+ICsJCQkJCXJldHVybiAtRUFDQ0VTOwo+ID4+ICsJCQkJfQo+ID4+ICAJ
CQkJZXJyID0gbWFya19jaGFpbl9wcmVjaXNpb24oZW52LCBpbnNuLT5kc3RfcmVnKTsKPiA+PiAg
CQkJCWlmIChlcnIpCj4gPj4gIAkJCQkJcmV0dXJuIGVycjsKPiA+Cj4gPiBTaG91bGQgdGhlIGZp
eCBiZSBsaWtlIHRoaXM6Cj4gPgo+ID4gICBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi92ZXJpZmll
ci5jIGIva2VybmVsL2JwZi92ZXJpZmllci5jCj4gPiAgIGluZGV4IDdkMjdiYTM5NmQzMi4uOWM4
NWRkNjgwYTQ2IDEwMDY0NAo+ID4gICAtLS0gYS9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMKPiA+ICAg
KysrIGIva2VybmVsL2JwZi92ZXJpZmllci5jCj4gPiAgIEBAIC0xMzU5Myw4ICsxMzU5MywxMCBA
QCBzdGF0aWMgaW50IGFkanVzdF9wdHJfbWluX21heF92YWxzKHN0cnVjdCBicGZfdmVyaWZpZXJf
ZW52ICplbnYsCj4gPiAgICAgICAgICAgICogQWNjZXNzZXMgdG8gdW50cnVzdGVkIFBUUl9UT19N
RU0gYXJlIGRvbmUgdGhyb3VnaCBwcm9iZQo+ID4gICAgICAgICAgICAqIGluc3RydWN0aW9ucywg
aGVuY2Ugbm8gbmVlZCB0byB0cmFjayBvZmZzZXRzLgo+ID4gICAgICAgICAgICAqLwo+ID4gICAt
ICAgICAgIGlmIChiYXNlX3R5cGUocHRyX3JlZy0+dHlwZSkgPT0gUFRSX1RPX01FTSAmJiAocHRy
X3JlZy0+dHlwZSAmIFBUUl9VTlRSVVNURUQpKQo+ID4gICArICAgICAgIGlmIChiYXNlX3R5cGUo
cHRyX3JlZy0+dHlwZSkgPT0gUFRSX1RPX01FTSAmJiAocHRyX3JlZy0+dHlwZSAmIFBUUl9VTlRS
VVNURUQpKSB7Cj4gPiAgICsgICAgICAgICAgICAgICAqZHN0X3JlZyA9ICpwdHJfcmVnOwo+ID4g
ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPiAgICsgICAgICAgfQo+ID4gICAgCj4gPiAg
ICAgICAgICAgc3dpdGNoIChiYXNlX3R5cGUocHRyX3JlZy0+dHlwZSkpIHsKPiA+ICAgICAgICAg
ICBjYXNlIFBUUl9UT19DVFg6Cj4gPgo+ID4gSW5zdGVhZD8KPiAKPiBTZWNvbmRlZCwgQUZBSUNU
IHRoZXJlIGlzIG5vIHJlYXNvbiB0byBmYWlsIHZlcmlmaWNhdGlvbiBzaW5jZSB3ZSBqdXN0Cj4g
dGhlIHBvaW50ZXIncyB2YWx1ZSB0byB0aGUgc2NhbGFyLiBXaGV0aGVyIHRoZSBvcGVyYXRpb24g
bWFrZXMgc2Vuc2UgaXMKPiB1cCB0byB0aGUgcHJvZ3JhbW1lciB0byBkZWNpZGUuCgpUaGFua3Mu
CgpBZ3JlZWQsIHJlamVjdGluZyBzY2FsYXIgKz0gcG9pbnRlciBpcyBub3QgdGhlIHJpZ2h0IHNl
bWFudGljIGZpeC4gVGhlIGJ1ZyBpcwp0aGF0IHRoZSB1bnRydXN0ZWQgUFRSX1RPX01FTSBlYXJs
eSByZXR1cm4gbGVhdmVzIGRzdCBzdGF0ZSBzdGFsZS4KCkknbGwgc2VuZCB2MiBtb3ZpbmcgdGhl
IGZpeCBpbnRvIGFkanVzdF9wdHJfbWluX21heF92YWxzKCkuCg==
