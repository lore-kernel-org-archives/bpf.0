Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA01378D9C
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654050; cv=none; b=j8X7YhTcWc38+TZONzZ5YXti7QtQoIKJETApOF7qCrwjqWdiseMQm7IaQGB3FeXHW0NCNmiDw5lfg68yGbWvoPekCvqdBx2pqOECIboqWwmO/Bnt/XeQeTgwQ17TTc4bxcjrUOmASamKSfVUmVb1Z4p5EjdSqArFa5U5FY8a3M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654050; c=relaxed/simple;
	bh=GbxhNOuAhrej389PiwZtXg4TDWSkBi+WfrC5CEPF1xU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=KKL+q3cfCjFc/1oGtQTfGbIpr1j44cmxw09sU0twjU02i0pfA8twG+RAUMiYB6Xs4JBl39Jjw2SZrUOlwCf1HjeRkbUTGu73Xh5mFCpIwFl1C/MRILXfIWr/yLpg4oSkFFDPqM8GwgjmGieIn/7pVMt0a+mDwdVICw0Ab1XNneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=fp5drtiJ reason="signature verification failed"; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="fp5drtiJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=XMii2rZ8faarBxCwVdbPkxG
	AB05apktZFrrbclU3zSM=; b=fp5drtiJ+KEA4ja2pk0PDOTz5KkWIPcnTGDkp0t
	x9aT5SO1C7H8DU0c+CI5fbOjaI+R8JNKZ5/vc9Sok3XTri1oX6p6V22Uys38paUE
	xmKX1MgvL0ff/Jq/7CqN5BWdu2LLdT+h0ulf88K0wsv+bXjWQ5Mo7g3DvMpqa3pC
	Vw6Q=
Received: from gnq25$mails.tsinghua.edu.cn ( [183.173.85.98] ) by
 ajax-webmail-web2 (Coremail) ; Fri, 5 Jun 2026 18:07:21 +0800 (GMT+08:00)
Date: Fri, 5 Jun 2026 18:07:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: Re: Re: [PATCH bpf 0/2] bpf, verifier: fix PTR_TO_FLOW_KEYS
 constant-offset OOB
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <CAADnVQJCXbZ27oZRYcd6=9WdaKvkMc4-PAK2ocd1hmRU=1C2rA@mail.gmail.com>
References: <20260604150755.2487555-1-gnq25@mails.tsinghua.edu.cn>
 <CAADnVQJCXbZ27oZRYcd6=9WdaKvkMc4-PAK2ocd1hmRU=1C2rA@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1f66a74b.74fd1.19e97406869.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:yQQGZQCXcZnZnyJqKzAQAg--.4466W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQIJA2oiawholwA
	Bsc
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

VGhhbmtzLCB3aWxsIHJldGFyZ2V0IGJwZi1uZXh0LiBPbmUgY2xhcmlmaWNhdGlvbiBmb3IgbXkg
b3duIHVuZGVyc3RhbmRpbmcKb2YgdGhlIHNlY3VyaXR5IGJvdW5kYXJ5IGhlcmU6IGlzIHRoZSAi
bm90IGEgc2VjdXJpdHkgaXNzdWUiIGNsYXNzaWZpY2F0aW9uCmRyaXZlbiBwdXJlbHkgYnkgbm8g
cmVsZWFzZWQga2VybmVsIGJlaW5nIGFmZmVjdGVkLCBvciBhbHNvIGJ5IGZsb3cKZGlzc2VjdG9y
IGF0dGFjaCByZXF1aXJpbmcgQ0FQX05FVF9BRE1JTiBsaW1pdGluZyByZWFjaGFiaWxpdHk/IFdh
bnQgdG8gCm1ha2Ugc3VyZSBJIGNhdGVnb3JpemUgc2ltaWxhciB2ZXJpZmllciByZWdyZXNzaW9u
cyBjb3JyZWN0bHkgaW4gdGhlIGZ1dHVyZS4KCgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZXMtLS0t
LQo+IEZyb206ICJBbGV4ZWkgU3Rhcm92b2l0b3YiIDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwu
Y29tPgo+IFNlbmQgdGltZTpGcmlkYXksIDA1LzA2LzIwMjYgMDA6NDA6MTkKPiBUbzogIk51aXFp
IEd1aSIgPGducTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4KPiBDYzogIkFsZXhlaSBTdGFyb3Zv
aXRvdiIgPGFzdEBrZXJuZWwub3JnPiwgIkRhbmllbCBCb3JrbWFubiIgPGRhbmllbEBpb2dlYXJi
b3gubmV0PiwgIkFuZHJpaSBOYWtyeWlrbyIgPGFuZHJpaUBrZXJuZWwub3JnPiwgIkVkdWFyZCBa
aW5nZXJtYW4iIDxlZGR5ejg3QGdtYWlsLmNvbT4sIGJwZiA8YnBmQHZnZXIua2VybmVsLm9yZz4K
PiBTdWJqZWN0OiBSZTogW1BBVENIIGJwZiAwLzJdIGJwZiwgdmVyaWZpZXI6IGZpeCBQVFJfVE9f
RkxPV19LRVlTIGNvbnN0YW50LW9mZnNldCBPT0IKPiAKPiBPbiBUaHUsIEp1biA0LCAyMDI2IGF0
IDg6MDjigK9BTSBOdWlxaSBHdWkgPGducTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4gd3JvdGU6
Cj4gPgo+ID4gQSBjb25zdGFudCBvZmZzZXQgYWRkZWQgdG8gYSBQVFJfVE9fRkxPV19LRVlTIHJl
Z2lzdGVyIGxhbmRzIGluCj4gPiByZWctPnZhcl9vZmYsIGJ1dCBjaGVja19mbG93X2tleXNfYWNj
ZXNzKCkgYm91bmRzLWNoZWNrcyBvbmx5IGluc24tPm9mZgo+ID4gYW5kIG5ldmVyIGZvbGRzIHJl
Zy0+dmFyX29mZi52YWx1ZS4gIEEgQlBGX1BST0dfVFlQRV9GTE9XX0RJU1NFQ1RPUgo+ID4gcHJv
Z3JhbSBjYW4gdGhlcmVmb3JlIGRvICJmbG93X2tleXMgKz0gMHgxMDAwOyAqKGZsb3dfa2V5cyAr
IDApIiBhbmQgaGF2ZQo+ID4gaXQgYWNjZXB0ZWQsIHRoZW4gcmVhZC93cml0ZSBrZXJuZWwgc3Rh
Y2sgcGFzdCBzdHJ1Y3QgYnBmX2Zsb3dfa2V5cyBhdAo+ID4gcnVudGltZS4gIFBhdGNoIDEgZm9s
ZHMgcmVnLT52YXJfb2ZmLnZhbHVlIGludG8gdGhlIG9mZnNldCAoYW5kIHJlamVjdHMKPiA+IG5v
bi1jb25zdGFudCBvZmZzZXRzKSwgbWlycm9yaW5nIGNoZWNrX2N0eF9hY2Nlc3MoKTsgcGF0Y2gg
MiBhZGRzIHZlcmlmaWVyCj4gPiBzZWxmdGVzdHMuCj4gPgo+ID4gVGhpcyBpcyBhIHJlZ3Jlc3Np
b24gaW50cm9kdWNlZCBpbiB0aGUgNy4xIGRldmVsb3BtZW50IGN5Y2xlIGJ5IGNvbW1pdAo+ID4g
MDIyYWMwNzUwODgzICgiYnBmOiB1c2UgcmVnLT52YXJfb2ZmIGluc3RlYWQgb2YgcmVnLT5vZmYg
Zm9yIHBvaW50ZXJzIiksCj4gPiB3aGljaCBtb3ZlZCB0aGUgY29uc3RhbnQgb2Zmc2V0IGZyb20g
cmVnLT5vZmYgKGZvbGRlZCBnZW5lcmljYWxseSBiZWZvcmUKPiA+IDAyMmFjMDc1MDg4MykgaW50
byByZWctPnZhcl9vZmYgd2l0aG91dCB1cGRhdGluZyB0aGUgZmxvd19rZXlzIHBhdGguICBObwo+
ID4gcmVsZWFzZWQga2VybmVsIGlzIGFmZmVjdGVkOiB2Ny4wLnggcmVqZWN0cyB0aGUgcHJvZ3Jh
bSBhYm92ZSwgYW5kIHRoZSBidWcKPiA+IHJlcHJvZHVjZXMgb25seSBvbiB2Ny4xLXJjMS4ucmM1
LCBzbyBubyBzdGFibGUgYmFja3BvcnQgaXMgbmVlZGVkLgo+ID4KPiA+IEl0IHdhcyBmaXJzdCBy
ZXBvcnRlZCBwcml2YXRlbHkgdG8gc2VjdXJpdHlAa2VybmVsLm9yZzsgcGVyIHRoZWlyIGd1aWRh
bmNlCj4gPiBpdCBpcyBoYW5kbGVkIGluIHRoZSBvcGVuIGFzIGEgbm9ybWFsIHJlZ3Jlc3Npb24g
Zml4Lgo+IAo+IFJpZ2h0IGFuZCB0aGUgZml4IHNob3VsZCB0YXJnZXQgYnBmLW5leHQuCj4gSXQn
cyBub3QgYSBzZWN1cml0eSBpc3N1ZS4KPiAKPiBwdy1ib3Q6IGNyCg==
