Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DC81799F;
	Sat, 20 Jun 2026 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781969701; cv=none; b=rCXF2FpEtmpmfvPqH6qYYgcl9InfojxZtF00qixLvrWzEGIcZVVWJqruSQgls1gsssK6NRmChY+F05ywxH2rRC76MmAx+/CiukqXKDD36xnbBth3qYpk/JzQ5eymkDp9g6OZGr12Q5A7Z4/qdqgNMi9U7foW236xm4H8KptCMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781969701; c=relaxed/simple;
	bh=cXnS4WTJpdUdpO3YNL4uAfLDYuzcAD+7TDHztoN6plE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=IsabaIoF72767wmhZ3pYd7FU1E5sEkmkXSIUXzIqlvarvTVu0PfGyJgnb6spXInXIR1BMjUcYLnUBsoSbqtSKLmTk9EDt+FLn2t0dfZiTi5I0MVLORyhbxDxdlFooFlh4fqaggYn6/B8Phv68IUYGPrMRIoRQMxAoLonoiCFmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=I1W6KfE1 reason="signature verification failed"; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="I1W6KfE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=RB2L/5sJ4lHGv9B2ahqS5kJ
	Ha3I8hfyX8JrE8eZGv3Q=; b=I1W6KfE1c1WlFeIVLosQloVufDAsK6A0oyj9Ek9
	xV1Zx6y8mOSkMlxFv9YTKsJx+xFrKR4ED2WweeJckn7ka7CgVjxVmxVFUWXaRNBH
	RXuWGpsLOjdjmWpUQhuUR7GnG28Re3YoEtViyJWzQzHHbIcbOZ7pHY1YKBruu+Mw
	A1g4=
Received: from gnq25$mails.tsinghua.edu.cn ( [223.91.120.5] ) by
 ajax-webmail-web2 (Coremail) ; Sat, 20 Jun 2026 23:34:38 +0800 (GMT+08:00)
Date: Sat, 20 Jun 2026 23:34:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Jiri Olsa" <jolsa@kernel.org>,
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	"Hao Luo" <haoluo@google.com>,
	"John Fastabend" <john.fastabend@gmail.com>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Shuah Khan" <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH bpf-next 1/2] bpf: Require CAP_BPF for pseudo-BTF
 ksym loads
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <a15079723c8834a2baf3f35c6a8ed52c63addeb9.camel@gmail.com>
References: <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-0-f950f69fe60c@mails.tsinghua.edu.cn>
 <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-1-f950f69fe60c@mails.tsinghua.edu.cn>
 <a15079723c8834a2baf3f35c6a8ed52c63addeb9.camel@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7f299d22.8290e.19ee5ab7010.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:yQQGZQC3k5sOszZqb8ltAg--.1293W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEEA2o1wTCwjQA
	AsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiRWR1YXJkIFppbmdlcm1h
biIgPGVkZHl6ODdAZ21haWwuY29tPgo+IFNlbmQgdGltZTpTYXR1cmRheSwgMjAvMDYvMjAyNiAw
NDowNToyMgo+IFRvOiAiTnVvcWkgR3VpIiA8Z25xMjVAbWFpbHMudHNpbmdodWEuZWR1LmNuPiwg
IkFsZXhlaSBTdGFyb3ZvaXRvdiIgPGFzdEBrZXJuZWwub3JnPiwgIkRhbmllbCBCb3JrbWFubiIg
PGRhbmllbEBpb2dlYXJib3gubmV0PiwgIkFuZHJpaSBOYWtyeWlrbyIgPGFuZHJpaUBrZXJuZWwu
b3JnPiwgIkt1bWFyIEthcnRpa2V5YSBEd2l2ZWRpIiA8bWVteG9yQGdtYWlsLmNvbT4sICJTb25n
IExpdSIgPHNvbmdAa2VybmVsLm9yZz4sICJZb25naG9uZyBTb25nIiA8eW9uZ2hvbmcuc29uZ0Bs
aW51eC5kZXY+LCAiSmlyaSBPbHNhIiA8am9sc2FAa2VybmVsLm9yZz4sICJFbWlsIFRzYWxhcGF0
aXMiIDxlbWlsQGV0c2FsYXBhdGlzLmNvbT4sICJIYW8gTHVvIiA8aGFvbHVvQGdvb2dsZS5jb20+
Cj4gQ2M6ICJKb2huIEZhc3RhYmVuZCIgPGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbT4sICJNYXJ0
aW4gS2FGYWkgTGF1IiA8bWFydGluLmxhdUBsaW51eC5kZXY+LCAiU2h1YWggS2hhbiIgPHNodWFo
QGtlcm5lbC5vcmc+LCBicGZAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rc2VsZnRlc3RAdmdlci5r
ZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBicGYtbmV4dCAxLzJdIGJwZjogUmVxdWlyZSBDQVBfQlBGIGZvciBwc2V1ZG8tQlRGIGtz
eW0gbG9hZHMKPiAKPiBPbiBTYXQsIDIwMjYtMDYtMjAgYXQgMDA6MDQgKzA4MDAsIE51b3FpIEd1
aSB3cm90ZToKPiA+IEJQRl9QU0VVRE9fQlRGX0lEIGlzIHJlc29sdmVkIGJlZm9yZSB0aGUgbWFp
biB2ZXJpZmllciBwYXNzLiBUaGUgcmVzb2x2ZXIKPiA+IGxvb2tzIHVwIHRoZSByZWZlcmVuY2Vk
IGtlcm5lbCBzeW1ib2wgdGhyb3VnaCBrYWxsc3ltcyBhbmQgcmV3cml0ZXMgdGhlCj4gPiBsZGlt
bTY0IGltbWVkaWF0ZSB0byB0aGUgY29uY3JldGUgYWRkcmVzcyB0aGF0IGxhdGVyIGJlY29tZXMg
dmVyaWZpZXIKPiA+IHN0YXRlLgo+ID4gCj4gPiBSZXF1aXJlIENBUF9CUEYgYmVmb3JlIGRvaW5n
IHRoYXQgbWF0ZXJpYWxpemF0aW9uLiBUaGlzIGtlZXBzIHR5cGVkIGtzeW0KPiA+IGFkZHJlc3Mg
cmVzb2x1dGlvbiBvbiB0aGUgcHJpdmlsZWdlZCBzaWRlIGFuZCBwcmV2ZW50cyBsb2FkZXJzIHdp
dGhvdXQKPiA+IENBUF9CUEYgZnJvbSByZWNlaXZpbmcgYSB2ZXJpZmllciBsb2cgdGhhdCBjb250
YWlucyB0aGUgcmVzb2x2ZWQgYWRkcmVzcy4KPiA+IAo+ID4gRml4ZXM6IDQ5NzZiNzE4YzM1NTEg
KCJicGY6IEludHJvZHVjZSBwc2V1ZG9fYnRmX2lkIikKPiA+IFNpZ25lZC1vZmYtYnk6IE51b3Fp
IEd1aSA8Z25xMjVAbWFpbHMudHNpbmdodWEuZWR1LmNuPgo+ID4gLS0tCj4gPiAga2VybmVsL2Jw
Zi92ZXJpZmllci5jIHwgNSArKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYyBiL2tlcm5lbC9i
cGYvdmVyaWZpZXIuYwo+ID4gaW5kZXggZWQ3YmEwZTZhOWNlLi5kYmY1ZGY5OTVmYzIgMTAwNjQ0
Cj4gPiAtLS0gYS9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMKPiA+ICsrKyBiL2tlcm5lbC9icGYvdmVy
aWZpZXIuYwo+ID4gQEAgLTE3NjM5LDYgKzE3NjM5LDExIEBAIHN0YXRpYyBpbnQgY2hlY2tfcHNl
dWRvX2J0Zl9pZChzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LAo+ID4gIAlpbnQgYnRmX2Zk
Owo+ID4gIAlpbnQgZXJyOwo+ID4gIAo+ID4gKwlpZiAoIWVudi0+YnBmX2NhcGFibGUpIHsKPiA+
ICsJCXZlcmJvc2UoZW52LCAiQlBGX1BTRVVET19CVEZfSUQgbG9hZHMgcmVxdWlyZSBDQVBfQlBG
XG4iKTsKPiA+ICsJCXJldHVybiAtRUFDQ0VTOwo+ID4gKwl9Cj4gPiArCj4gCj4gVGhhbmsgeW91
IGZvciBpZGVudGlmeWluZyB0aGlzIGlzc3VlLgo+IEkgdGhpbmsgdGhlIGNvcnJlY3Qgd2F5IHRv
IGZpeCBpdCBpcyB0byBleHRlbmQgdGhlIGBpc19wdHIgJiYgIWFsbG93X3B0cl9sZWFrc2AKPiBs
b2dpYyBpbiBrZXJuZWwvYnBmL2Rpc2FzbS5jOnByaW50X2JwZl9pbnNuKCkuCj4gTm90ZSB0aGF0
IGl0IHNlZW1zIHRoZXJlIGFyZSBhZGRpdGlvbmFsIGNhc2VzIHRoYXQgYXJlIG5vdCBjb3ZlcmVk
LAo+IHNvbWV0aGluZyBsaWtlIGJlbG93IHNlZW0gd2FycmFudGVkOgo+IAo+IAo+ICAgYm9vbCBp
c19wdHIgPSBpbnNuLT5zcmNfcmVnID09IEJQRl9QU0VVRE9fTUFQX0ZEICAgIHx8Cj4gICAgICAg
ICAgICAgICAgIGluc24tPnNyY19yZWcgPT0gQlBGX1BTRVVET19NQVBfVkFMVUUgIHx8Cj4gICAg
ICAgICAgICAgICAgIGluc24tPnNyY19yZWcgPT0gQlBGX1BTRVVET19NQVBfSURYICAgIHx8Cj4g
ICAgICAgICAgICAgICAgIGluc24tPnNyY19yZWcgPT0gQlBGX1BTRVVET19NQVBfSURYX1ZBTFVF
IHx8Cj4gICAgICAgICAgICAgICAgIGluc24tPnNyY19yZWcgPT0gQlBGX1BTRVVET19CVEZfSUQ7
Cj4gCj4gQ291bGQgeW91IHBsZWFzZSBkb3VibGUgY2hlY2s/Cj4gCj4gPiAgCWJ0Zl9mZCA9IGlu
c25bMV0uaW1tOwo+ID4gIAlpZiAoYnRmX2ZkKSB7Cj4gPiAgCQlidGYgPSBidGZfZ2V0X2J5X2Zk
KGJ0Zl9mZCk7CgpUaGFua3MgZm9yIHRoZSBndWlkYW5jZS4gwqBJJ2xsIHJld29yayB0aGlzIHRv
IGV4dGVuZCB0aGUgcG9pbnRlci1saWtlIApsZGltbTY0IHNhbml0aXphdGlvbiBpbiBwcmludF9i
cGZfaW5zbigpLgo=
