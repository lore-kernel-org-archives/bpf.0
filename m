Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4BD217F27;
	Wed, 17 Jun 2026 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706365; cv=none; b=dHrXT7XS2gOzBW3Qs+WE7WQRO0L8OK0ohLHxoIjgK8NoNhy4RuIOawNgR5CdPcU0re8ddL5e3zg8usySBqVbbymCoxn/DUIdBzOSARC0HICXbwi6xZlNHqhtDCghy9Iho5Cr9OoFZULaNFmGZNvK7jI3y8yfrLcm3H5Q/QNwFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706365; c=relaxed/simple;
	bh=WhYbhmTimzXV0DLL7tx/fRIspiZZC/Ou1otC3RLLRes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=qe0XedW/sJdTfj1SXo2U61hQhf85rnCkmFghPMwHcObwsHMXvUl0BU/9vynCXwpjLAsvikCJEFA/n3zrK5R4WylVD8mnDRdSkaotaQ1nzeT/MvsZNlUmGgQL1necgiKq2UX6hAPJAn72ambpuDDcSmfDXmfbIkhXvo5Ye5Hrx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=q6b8CMx8 reason="signature verification failed"; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="q6b8CMx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=dAVtTN98vnuJ60CDUNlNwPB
	3oVJ8GgGt4oQ8I3pU88E=; b=q6b8CMx8HiqJpeBpzOwEEuwoRm8uuQDnyBxfaZ3
	fZHE4REFjXOF2CFuuuPrM17A1KEIpLWz9ZTcsXb0uabNUJYTCS5ClN+WFUcWVxe3
	Bnqonb92Y974JwLbr5VNhf495XZYD4m04w/YH7gK+7RRXxpTtI1Arwmj4wknx2RE
	55sk=
Received: from gnq25$mails.tsinghua.edu.cn ( [59.66.19.181] ) by
 ajax-webmail-web4 (Coremail) ; Wed, 17 Jun 2026 22:25:37 +0800 (GMT+08:00)
Date: Wed, 17 Jun 2026 22:25:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: "Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	"John Fastabend" <john.fastabend@gmail.com>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Luis Gerhorst" <luis.gerhorst@fau.de>,
	"Shuah Khan" <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH bpf 1/2] bpf: Fix stack slot index in nospec checks
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <14d43777-e979-42b4-a9ec-cc5d46f4e01e@linux.dev>
References: <20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn>
 <20260617-f01-11-stack-nospec-slot-index-v1-1-e3a080b0cd7e@mails.tsinghua.edu.cn>
 <14d43777-e979-42b4-a9ec-cc5d46f4e01e@linux.dev>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4228110d.7e56d.19ed5f92d1a.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:ywQGZQDX66BhrjJqZXhTAg--.34152W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEBA2oyQ831mAA
	As5
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiSmlheXVhbiBDaGVuIiA8
amlheXVhbi5jaGVuQGxpbnV4LmRldj4KPiBTZW5kIHRpbWU6V2VkbmVzZGF5LCAxNy8wNi8yMDI2
IDE5OjA4OjQwCj4gVG86ICJOdW9xaSBHdWkiIDxnbnEyNUBtYWlscy50c2luZ2h1YS5lZHUuY24+
LCAiQWxleGVpIFN0YXJvdm9pdG92IiA8YXN0QGtlcm5lbC5vcmc+LCAiRGFuaWVsIEJvcmttYW5u
IiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+LCAiQW5kcmlpIE5ha3J5aWtvIiA8YW5kcmlpQGtlcm5l
bC5vcmc+LCAiRWR1YXJkIFppbmdlcm1hbiIgPGVkZHl6ODdAZ21haWwuY29tPiwgIkt1bWFyIEth
cnRpa2V5YSBEd2l2ZWRpIiA8bWVteG9yQGdtYWlsLmNvbT4sICJFbWlsIFRzYWxhcGF0aXMiIDxl
bWlsQGV0c2FsYXBhdGlzLmNvbT4KPiBDYzogIkpvaG4gRmFzdGFiZW5kIiA8am9obi5mYXN0YWJl
bmRAZ21haWwuY29tPiwgIk1hcnRpbiBLYUZhaSBMYXUiIDxtYXJ0aW4ubGF1QGxpbnV4LmRldj4s
ICJMdWlzIEdlcmhvcnN0IiA8bHVpcy5nZXJob3JzdEBmYXUuZGU+LCAiU2h1YWggS2hhbiIgPHNo
dWFoQGtlcm5lbC5vcmc+LCBicGZAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rc2VsZnRlc3RAdmdl
ci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBicGYgMS8yXSBicGY6IEZpeCBzdGFjayBzbG90IGluZGV4IGluIG5vc3BlYyBjaGVj
a3MKPiAKPiAKPiBPbiA2LzE3LzI2IDEyOjU3IEFNLCBOdW9xaSBHdWkgd3JvdGU6Cj4gPiBjaGVj
a19zdGFja193cml0ZV9maXhlZF9vZmYoKSBjb21wdXRlcyB0aGUgYnl0ZSBzbG90IGZvciBhIGZp
eGVkLW9mZnNldAo+ID4gc3RhY2sgd3JpdGUgYXMgLW9mZiAtIDEsIGFuZCByZWNvcmRzIGVhY2gg
d3JpdHRlbiBieXRlIGluIHNsb3RfdHlwZVtdIHdpdGgKPiA+IChzbG90IC0gaSkgJSBCUEZfUkVH
X1NJWkUuCj4gPgo+ID4gVGhlIFNwZWN0cmUgdjQgc2FuaXRpemF0aW9uIHByZS1jaGVjayB1c2Vz
IHNsb3RfdHlwZVtpXSBpbnN0ZWFkLiBGb3IgYQo+ID4gNC1ieXRlIHdyaXRlIGF0IGZwLTggYWZ0
ZXIgdGhlIGxvd2VyIGhhbGYgb2YgZnAtOCBoYXMgYmVlbiB6ZXJvZWQsIHRoZQo+ID4gcHJlLWNo
ZWNrIHNjYW5zIGJ5dGVzIDAuLjMgYW5kIHNlZXMgU1RBQ0tfWkVSTyB3aGlsZSB0aGUgYWN0dWFs
IHdyaXRlIHVwZGF0ZXMKPiA+IGJ5dGVzIDcuLjQuIFRoYXQgY2FuIGxlYXZlIHRoZSBzZWNvbmQg
aGFsZi1zbG90IHdyaXRlIHdpdGhvdXQgbm9zcGVjX3Jlc3VsdAo+ID4gZXZlbiB0aG91Z2ggdGhl
IGJ5dGVzIGJlaW5nIG92ZXJ3cml0dGVuIHN0aWxsIHJlcXVpcmUgc2FuaXRpemF0aW9uLgo+ID4K
PiA+IFVzZSB0aGUgc2FtZSBzbG90IGluZGV4IGluIHRoZSBzYW5pdGl6YXRpb24gcHJlLWNoZWNr
IHRoYXQgdGhlIHdyaXRlIHBhdGggdXNlcwo+ID4gd2hlbiB1cGRhdGluZyBzbG90X3R5cGVbXS4K
PiA+Cj4gPiBGaXhlczogZTRmNGRiNDc3OTRjICgiYnBmOiBGaXggcG9pbnRlci1sZWFrIGR1ZSB0
byBpbnN1ZmZpY2llbnQgc3BlY3VsYXRpdmUgc3RvcmUgYnlwYXNzIG1pdGlnYXRpb24iKQo+ID4g
U2lnbmVkLW9mZi1ieTogTnVvcWkgR3VpIDxnbnEyNUBtYWlscy50c2luZ2h1YS5lZHUuY24+Cj4g
Cj4gCj4gSSB0aGluayB0aGUgRml4ZXMgdGFnIHNob3VsZCBiZcKgIDIwMzlmMjZmM2FjYSAoImJw
ZjogRml4IGxlYWthZ2UgZHVlIHRvIAo+IGluc3VmZmljaWVudCBzcGVjdWxhdGl2ZSBzdG9yZSBi
eXBhc3MgbWl0aWdhdGlvbiIpID8KPiAKPiBPdGhlcndpc2UsIGxvb2tzIGdvb2QgdG8gbWUuCj4g
Cj4gUmV2aWV3ZWQtYnk6IEppYXl1YW4gQ2hlbiA8amlheXVhbi5jaGVuQGxpbnV4LmRldj4KClRo
YW5rcy4KSSdsbCBjaGFuZ2UgdGhlIEZpeGVzIHRhZyBpbiB2MiB0bzoKRml4ZXM6IDIwMzlmMjZm
M2FjYSAoImJwZjogRml4IGxlYWthZ2UgZHVlIHRvIGluc3VmZmljaWVudCAKc3BlY3VsYXRpdmUg
c3RvcmUgYnlwYXNzIG1pdGlnYXRpb24iKQo=
