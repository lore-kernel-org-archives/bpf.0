Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054D3B4E9F;
	Fri, 19 Jun 2026 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884966; cv=none; b=jlysphCJutM0Fkv6aZWxsbT7IkwSlHogMaKP6aeDYDJ/KPvlUAy6fcQ/QCdtMF6p4ZPZNgFZBpVnACrc0Kje0DPioF60j3H9tw9spmepG+U8j9yMVJD98WOe1KIkw3A1UyBPPiGygDtOO9yvdFqEcuj/T2oEBQQPTbKbu7eUmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884966; c=relaxed/simple;
	bh=eBmalbFwvezsu6JqPrRtaeiAUEkMDlAo27YCsl8U1rE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=BhIZZmmq+sFkm6H1fWfUkR8Nsq5gbPK01NKYEk3wysLo/02vFcw8jWYVdXys5yAuWwYzVUqen8AscxzWAbgL+HA9ZP3h7I8hdASMSz6z2elvfpputJp3txyyB3RAj3aBkxX8ypsOXbcCV8JnVuBicCdAedWNpNOX7y+HOtMNgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=LBLMKbBB reason="signature verification failed"; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="LBLMKbBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=3ZSZ1GJmN9Ykp3wkoNvUZXy
	ZqxRc7nzDIIQpdknRQQU=; b=LBLMKbBBbjkmvmut3ar1p8RP5gqml8Ua9qO/PMg
	jQ8jIKbltGIQD8mOXxTEgudwjVhzso10qrgv0OKP0fgv4rCe6kgSRUcnf6lfwVWt
	eO4LQfOWxcw6BOtAh2JE7/Ly6xG6WgMy4z0jx4scjBlZsdw/o0F9xYUQBe8fKQQX
	+LyY=
Received: from gnq25$mails.tsinghua.edu.cn ( [183.172.62.193] ) by
 ajax-webmail-web2 (Coremail) ; Sat, 20 Jun 2026 00:02:14 +0800 (GMT+08:00)
Date: Sat, 20 Jun 2026 00:02:14 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
To: "Christian Loehle" <christian.loehle@arm.com>
Cc: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Andrea Righi" <arighi@nvidia.com>,
	"Changwoo Min" <changwoo@igalia.com>,
	"Shuah Khan" <shuah@kernel.org>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH bpf-next 0/2] sched_ext: Mark scx_bpf_cpu_rq()
 nullable
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <1b75c8ce-19c1-4a35-8747-d63e28dbbc16@arm.com>
References: <20260619-f01-14-scx-cpu-rq-ret-null-v1-0-3b4281cdf0da@mails.tsinghua.edu.cn>
 <1b75c8ce-19c1-4a35-8747-d63e28dbbc16@arm.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <41898842.82354.19ee09e5a42.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:yQQGZQC3k5sGaDVqDXtpAg--.741W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQMDA2o0b7D0-AA
	BsK
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiQ2hyaXN0aWFuIExvZWhs
ZSIgPGNocmlzdGlhbi5sb2VobGVAYXJtLmNvbT4KPiBTZW5kIHRpbWU6RnJpZGF5LCAxOS8wNi8y
MDI2IDIzOjMxOjU5Cj4gVG86ICJOdW9xaSBHdWkiIDxnbnEyNUBtYWlscy50c2luZ2h1YS5lZHUu
Y24+LCAiVGVqdW4gSGVvIiA8dGpAa2VybmVsLm9yZz4sICJEYXZpZCBWZXJuZXQiIDx2b2lkQG1h
bmlmYXVsdC5jb20+LCAiQWxleGVpIFN0YXJvdm9pdG92IiA8YXN0QGtlcm5lbC5vcmc+LCAiRGFu
aWVsIEJvcmttYW5uIiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+LCAiQW5kcmlpIE5ha3J5aWtvIiA8
YW5kcmlpQGtlcm5lbC5vcmc+Cj4gQ2M6ICJBbmRyZWEgUmlnaGkiIDxhcmlnaGlAbnZpZGlhLmNv
bT4sICJDaGFuZ3dvbyBNaW4iIDxjaGFuZ3dvb0BpZ2FsaWEuY29tPiwgIlNodWFoIEtoYW4iIDxz
aHVhaEBrZXJuZWwub3JnPiwgc2NoZWQtZXh0QGxpc3RzLmxpbnV4LmRldiwgYnBmQHZnZXIua2Vy
bmVsLm9yZywgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZwo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggYnBmLW5leHQgMC8yXSBzY2hlZF9l
eHQ6IE1hcmsgc2N4X2JwZl9jcHVfcnEoKSBudWxsYWJsZQo+IAo+IE9uIDYvMTkvMjYgMTU6NDUs
IE51b3FpIEd1aSB3cm90ZToKPiA+IHNjeF9icGZfY3B1X3JxKCkgY2FuIHJldHVybiBOVUxMIGZv
ciBpbnZhbGlkIENQVSBpbnB1dCBvciB3aGVuIG5vIFNDWAo+ID4gc2NoZWR1bGVyIGlzIGFjdGl2
ZSwgYnV0IGl0cyBrZnVuYyByZWdpc3RyYXRpb24gZG9lcyBub3QgYWR2ZXJ0aXNlIHRoZQo+ID4g
bnVsbGFibGUgcmV0dXJuIHRvIHRoZSB2ZXJpZmllci4KPiA+IAo+ID4gQWRkIEtGX1JFVF9OVUxM
IHRvIHNjeF9icGZfY3B1X3JxKCksIG1hdGNoaW5nIHRoZSBudWxsYWJsZSBtZXRhZGF0YSBhbHJl
YWR5Cj4gPiBwcmVzZW50IG9uIG5laWdoYm9yaW5nIFNDWCBhY2Nlc3NvcnMsIGFuZCBhZGQgYSBz
Y2hlZF9leHQgc2VsZnRlc3QgdGhhdCByZWplY3RzCj4gPiBhbiB1bmNoZWNrZWQgZGlyZWN0IHJ1
bnF1ZXVlIGZpZWxkIHJlYWQuCj4gPiAKPiAKPiBTZWUgNWM0OGQ4OGZlMDA0ICgic2NoZWRfZXh0
OiBkZXByZWNhdGlvbiB3YXJuIGZvciBzY3hfYnBmX2NwdV9ycSgpIikKPiBJIGd1ZXNzIEkgY2Fu
IHNlbmQgYSBwYXRjaCB0byByZW1vdmUgdGhlIGZ1bmN0aW9uLCBpdCdzIGJlZW4gYSB3aGlsZS4K
PiAKPiA+IFRoaXMgZml4ZXMgYSByZWdyZXNzaW9uIGludHJvZHVjZWQgYnkgNjIwM2VmNzNmYTVj
ICgic2NoZWQvZXh0OiBBZGQgQlBGCj4gPiBmdW5jdGlvbiB0byBmZXRjaCBycSIpLgo+IAo+IEhv
dyBzbz8KPiAKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTnVvcWkgR3VpIDxnbnEyNUBtYWlscy50
c2luZ2h1YS5lZHUuY24+Cj4gPiAtLS0KPiA+IE51b3FpIEd1aSAoMik6Cj4gPiAgICAgICBzY2hl
ZF9leHQ6IE1hcmsgc2N4X2JwZl9jcHVfcnEoKSBhcyBudWxsYWJsZQo+ID4gICAgICAgc2VsZnRl
c3RzL3NjaGVkX2V4dDogQ292ZXIgc2N4X2JwZl9jcHVfcnEoKSBudWxsIHJldHVybgo+ID4gCj4g
PiAga2VybmVsL3NjaGVkL2V4dC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MiArLQo+ID4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NjaGVkX2V4dC9NYWtlZmlsZSAgICAg
ICAgIHwgIDEgKwo+ID4gIC4uLi9zZWxmdGVzdHMvc2NoZWRfZXh0L2NwdV9ycV9yZXRfbnVsbC5i
cGYuYyAgICAgIHwgMjcgKysrKysrKysrKysrKysrCj4gPiAgLi4uL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3NjaGVkX2V4dC9jcHVfcnFfcmV0X251bGwuYyAgfCAzOCArKysrKysrKysrKysrKysrKysrKysr
Cj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
PiAtLS0KPiA+IGJhc2UtY29tbWl0OiBlNDI4N2JmMzRmOTdhODhjN2Q5MzIyZjViZGU4Mjg3MjRj
MDczYTZiCj4gPiBjaGFuZ2UtaWQ6IDIwMjYwNjE3LWYwMS0xNC1zY3gtY3B1LXJxLXJldC1udWxs
LTJlNzk1MzVhY2Q1Nwo+ID4gCj4gPiBCZXN0IHJlZ2FyZHMsCj4gPiAtLSAgCj4gPiBOdW9xaSBH
dWkgPGducTI1QG1haWxzLnRzaW5naHVhLmVkdS5jbj4KPiA+IAo+ID4gCgpUaGFua3MsIHlvdSdy
ZSByaWdodC4gIlJlZ3Jlc3Npb24iIHdhcyBpbmFjY3VyYXRlOyB0aGUgbWlzc2luZyBLRl9SRVRf
TlVMTAptZXRhZGF0YSBoYXMgYmVlbiB0aGVyZSBzaW5jZSB0aGUga2Z1bmMgd2FzIGludHJvZHVj
ZWQgYnkgNjIwM2VmNzNmYTVjLgoKSWYgdGhlIHByZWZlcnJlZCBkaXJlY3Rpb24gaXMgdG8gcmVt
b3ZlIHNjeF9icGZfY3B1X3JxKCksIEknbGwgZHJvcCB0aGlzIApzZXJpZXMuCg==
