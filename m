Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61E33C584E;
	Tue, 23 Jun 2026 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204975; cv=none; b=VCCC/f3rJavrr6ekKej49wruflzweg/U2zS3MUE5RLhdHJliBfISLhrLzudJxM5YVIPsRdsxRpKAW90yyNfosL7i4PsQfeyIUuffMEbz8ugM3ozY/sGBtTkYaBtHiCkE2IZpeRdgaA4Na2fOzqy7Kzwi10rmJ8+f9wyTXfsVIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204975; c=relaxed/simple;
	bh=RGzV98LihW3v726clNcsU3f65eIkvBDC9cGShxHMtCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=fKfzuc4VBSPZrNv6ASgHCz5UUYWunXbRQkkZ6MIDMNDHsuU7op9QdSD4WMB/IxWSRGTe+SWMakYpgjCwURQD426Pxk5+Bj8Ww1k5N2WFhByEVk+q1ODxCmazcjXDEQEGm+HoF8BgYvN2jIFVWPJlBBEB9tPb40/hEvwmbD2JEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=DEIQH+lF reason="signature verification failed"; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="DEIQH+lF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=EFMnr5/UlendL3GC9nKaHAv
	hxLyj0cFu82ijQrc0DAo=; b=DEIQH+lFs+MRCfm+LTL/9dP1FiXVYu0CQsLu1vA
	iUIYZ+LjMBJyeBREntmivL2aKWzgKFFJM7YC0aRB+nWw0BGs7QOd8bWBygEMvfr7
	Aq2xnthqEe42oNqE3Buib/cndeSai2oNH11e4Kpge7GJOKdxrlAkWQrzLpNMP/dK
	gxNI=
Received: from gnq25$mails.tsinghua.edu.cn ( [223.91.120.130] ) by
 ajax-webmail-web2 (Coremail) ; Tue, 23 Jun 2026 16:56:05 +0800 (GMT+08:00)
Date: Tue, 23 Jun 2026 16:56:05 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, "Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Shuah Khan" <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH bpf-next v2 0/2] bpf: Enforce gotox targets against
 subprog bounds
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <ajlSDq+bBo0I34ZK@mail.gmail.com>
References: <20260609-f01-02-gotox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn>
 <20260613-f01-02-gotox-bpf-next-v2-send-v2-0-ff980bc5a329@mails.tsinghua.edu.cn>
 <ajlSDq+bBo0I34ZK@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4ef3f4bd.84fbc.19ef3b1a209.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:yQQGZQC3k5slSjpqCGp8Ag--.4531W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgMGA2o5f7gLMQA
	Dsp
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiQW50b24gUHJvdG9wb3Bv
diIgPGEucy5wcm90b3BvcG92QGdtYWlsLmNvbT4KPiBTZW5kIHRpbWU6TW9uZGF5LCAyMi8wNi8y
MDI2IDIzOjE3OjM0Cj4gVG86ICJOdW9xaSBHdWkiIDxnbnEyNUBtYWlscy50c2luZ2h1YS5lZHUu
Y24+Cj4gQ2M6IGJwZkB2Z2VyLmtlcm5lbC5vcmcsICJBbGV4ZWkgU3Rhcm92b2l0b3YiIDxhc3RA
a2VybmVsLm9yZz4sICJEYW5pZWwgQm9ya21hbm4iIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD4sICJB
bmRyaWkgTmFrcnlpa28iIDxhbmRyaWlAa2VybmVsLm9yZz4sICJFZHVhcmQgWmluZ2VybWFuIiA8
ZWRkeXo4N0BnbWFpbC5jb20+LCAiU2h1YWggS2hhbiIgPHNodWFoQGtlcm5lbC5vcmc+LCBsaW51
eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBicGYtbmV4dCB2MiAwLzJdIGJwZjogRW5mb3JjZSBnb3Rv
eCB0YXJnZXRzIGFnYWluc3Qgc3VicHJvZyBib3VuZHMKPiAKPiBPbiAyNi8wNi8xMyAwNTozM1BN
LCBOdW9xaSBHdWkgd3JvdGU6Cj4gPiBGb3IgZ290b3gsIENGRyBjb25zdHJ1Y3Rpb24gbW9kZWxz
IHRoZSBpbmRpcmVjdC1qdW1wIHRhcmdldCBzZXQgaW4KPiA+IGluc25fYXV4X2RhdGEtPmp0LCBi
dXQgZG9fY2hlY2soKSBsYXRlciBmb2xsb3dzIHRhcmdldHMgZnJvbSB0aGUgcnVudGltZQo+ID4g
UFRSX1RPX0lOU04gcmVnaXN0ZXIncyBvd24gSU5TTl9BUlJBWSBtYXAuIElmIHRoZSBzYW1lIGdv
dG94IGNhbiBiZQo+ID4gcmVhY2hlZCB3aXRoIFBUUl9UT19JTlNOIHZhbHVlcyBmcm9tIGRpZmZl
cmVudCBtYXBzLCBkb19jaGVjaygpIGNhbiBhY2NlcHQKPiA+IGEgdGFyZ2V0IG91dHNpZGUgdGhl
IHN1YnByb2cgdGhhdCBDRkcgYWxsb3dlZCBmb3IgdGhlIGdvdG94IGluc3RydWN0aW9uLgo+ID4g
Cj4gPiBPbiB4ODYsIHRoYXQgY2FuIHRyYW5zZmVyIGNvbnRyb2wgaW50byBhbm90aGVyIHN1YnBy
b2cgd2l0aG91dCBhIG1hdGNoaW5nCj4gPiBCUEYgY2FsbCBmcmFtZSBhbmQgY3Jhc2ggd2hlbiB0
aGUgcHJvZ3JhbSBpcyBydW4uCj4gCj4gV2h5IG9ubHkgb24geDg2Pwo+IApJIHdpbGwgYXZvaWQg
bWFraW5nIHRoZSB4ODYgd29yZGluZyBzb3VuZCBsaWtlIHRoZSB2ZXJpZmllciBpc3N1ZSBpcyB4
ODYtc3BlY2lmaWMuIApUaGUgaXNzdWUgd2FzIG9ic2VydmVkIHRocm91Z2ggdGhlIHg4NiBKSVQg
cGF0aCwgYnV0IHRoZSBpbnZhcmlhbnQgYmVpbmcgZml4ZWQgaXMgCnRoZSBnZW5lcmljIGdvdG94
IHN1YnByb2ctYm91bmRhcnkgY2hlY2suCgo+ID4gRml4IHRoaXMgYnkgcmVqZWN0aW5nIGdvdG94
IG1hcCB0YXJnZXRzIG91dHNpZGUgdGhlIGN1cnJlbnQgZ290b3ggc3VicHJvZy4KPiA+IEFkZCBh
IHJlZ3Jlc3Npb24gdGVzdCBjb3ZlcmluZyB0aGUgdHdvLW1hcCBjcm9zcy1zdWJwcm9nIGNhc2Uu
Cj4gPiAKPiA+IFZhbGlkYXRpb246Cj4gPiAKPiA+ICAgdW5wYXRjaGVkIGJwZi1uZXh0IDdiZmI5
M2UzNDc1YiB3aXRoIHRoZSBuZXcgc2VsZnRlc3Q6Cj4gPiAgICAgYnBmX2dvdG94L2NoZWNrLWNy
b3NzLXN1YnByb2ctZ290b3gtdGFyZ2V0OiBGQUlMCj4gPiAgICAgY3Jvc3Nfc3VicHJvZ19nb3Rv
eF9wcm9nX2xvYWQ6IGFjdHVhbCAyMyAhPSBleHBlY3RlZCAtMjIKPiA+ICAgICBfX1RFU1RfUFJP
R1NfUkNfXz0xCj4gPiAKPiA+ICAgcGF0Y2hlZCBicGYtbmV4dCA3YmZiOTNlMzQ3NWIgKyB0aGlz
IHNlcmllczoKPiA+ICAgICBicGZfZ290b3gvY2hlY2stY3Jvc3Mtc3VicHJvZy1nb3RveC10YXJn
ZXQ6IE9LCj4gPiAgICAgLi90ZXN0X3Byb2dzIC10IGJwZl9nb3RveC9jaGVjay1jcm9zcy1zdWJw
cm9nLWdvdG94LXRhcmdldAo+ID4gICAgIFN1bW1hcnk6IDEvMSBQQVNTRUQsIDAgU0tJUFBFRCwg
MCBGQUlMRUQKPiA+ICAgICBfX1RFU1RfUFJPR1NfUkNfXz0wCj4gCj4gV2h5IHRoZSBzZWNvbmQg
cGFydCBtZW50aW9ucyB0aGUgY2FsbCB0byAuL3Rlc3RfcHJvZ3MsIGFuZCB0aGUgZmlyc3QgZG9l
c24ndD8KPiBXaHkgdGhlIHRlc3QgcmVzdWx0IGdvZXMgYmVmb3JlIHRoZSB0ZXN0IHJ1bj8gSXMg
dGhpcyAiVmFsaWRhdGlvbiIgc2VjdGlvbiBldmVuIHJlcXVpcmVkPwo+IApBZ3JlZWQsIHRoZSBW
YWxpZGF0aW9uIHNlY3Rpb24gaXMgbm90IG5lZWRlZCBpbiB0aGUgY292ZXIgbGV0dGVyLiBJIHdp
bGwgZHJvcCBpdCAKaW4gdjMgaW5zdGVhZCBvZiB0cnlpbmcgdG8ga2VlcCB0aGUgY29tbWFuZC9v
dXRwdXQgZm9ybWF0dGluZyB0aGVyZS4KCj4gPiB2MSAtPiB2MjoKPiA+ICAgLSBWYWxpZGF0ZSBn
b3RveCBydW50aW1lIHRhcmdldHMgYWdhaW5zdCB0aGUgY3VycmVudCBzdWJwcm9nIGJvdW5kcyBp
bnN0ZWFkCj4gPiAgICAgb2Ygc2Nhbm5pbmcgdGhlIENGRyBqdW1wIHRhYmxlLgo+ID4gICAtIEZp
eCB0aGUgc2VsZnRlc3QgZXhwZWN0ZWQgZXJyb3IgZnJvbSAtRUFDQ0VTIHRvIC1FSU5WQUwuCj4g
PiAKPiA+IHYxOgo+ID4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9icGYvMjAyNjA2MDktZjAx
LTAyLWdvdG94LWJwZi1uZXh0LXYxLTAtYjQ0MWQ2M2ExNTU5QG1haWxzLnRzaW5naHVhLmVkdS5j
bi8KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTnVvcWkgR3VpIDxnbnEyNUBtYWlscy50c2luZ2h1
YS5lZHUuY24+Cj4gPiAtLS0KPiA+IE51b3FpIEd1aSAoMik6Cj4gPiAgICAgICBicGY6IEVuZm9y
Y2UgZ290b3ggdGFyZ2V0cyBhZ2FpbnN0IHN1YnByb2cgYm91bmRzCj4gPiAgICAgICBzZWxmdGVz
dHMvYnBmOiBBZGQgY3Jvc3Mtc3VicHJvZyBnb3RveCB0YXJnZXQgY292ZXJhZ2UKPiA+IAo+ID4g
IGtlcm5lbC9icGYvdmVyaWZpZXIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjEg
KysrKysrKwo+ID4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9n
b3RveC5jIHwgNzMgKysrKysrKysrKysrKysrKysrKysrKwo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
OTQgaW5zZXJ0aW9ucygrKQo+ID4gLS0tCj4gPiBiYXNlLWNvbW1pdDogN2JmYjkzZTM0NzViZTlk
ZTg5NGYxY2VjZDNhNzI3ZDNlMTY0OWIwMwo+ID4gY2hhbmdlLWlkOiAyMDI2MDYxMy1mMDEtMDIt
Z290b3gtYnBmLW5leHQtdjItc2VuZC04YzQ4YzkzNTdkZGUKPiA+IAo+ID4gQmVzdCByZWdhcmRz
LAo+ID4gLS0gIAo+ID4gTnVvcWkgR3VpIDxnbnEyNUBtYWlscy50c2luZ2h1YS5lZHUuY24+Cj4g
PiAKCgo=
