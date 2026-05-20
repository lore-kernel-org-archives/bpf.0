Received: from mail2.ietf.org (mail2.ietf.org [166.84.6.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4B245005
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.6.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292042; cv=none; b=MPpXnv7UGovrADPTRcpCGN9CRQxsgYWzOIpGhX7yrQw2w3xMZ6lK/AM2RTsKFNFBaoZIOn6rSavRpUS1VzpR3PtwRsSTbr3zbWXG7DvrT+aZSkK6nxcVlByKWx06xeCOGn3b8/tzd8qRikslTSJkX0IjsageJg78R+Dn9oXZPnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292042; c=relaxed/simple;
	bh=m57FM+OgD135Z/oWduhF+ss80aUI9c9ozR8EgkwD+9c=;
	h=Mime-Version:Date:Message-Id:To:References:In-Reply-To:CC:Subject:
	 Content-Type:From; b=kcnxddJVtLV7jKGEIVIGkvCLdEDNbeAY2Qip0IEzws0+4yqeszPraxHyfo4bcLcgcJntd8ocNCotVIhZwmbtThlURxv2dT4Q38JoWrU4DU2ifYcW14xn7hQSPqQO1W0Icvc6SYivaeFoavt0BPNuV05sr4S3lDoqv9TLyXmt+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=hXg5gZN4; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=IFkZM0C0 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kw6X2Lwj reason="signature verification failed"; arc=none smtp.client-ip=166.84.6.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="hXg5gZN4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="IFkZM0C0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kw6X2Lwj"
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 3397FF1ADB79
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 08:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1779292038; bh=m57FM+OgD135Z/oWduhF+ss80aUI9c9ozR8EgkwD+9c=;
	h=Date:To:References:In-Reply-To:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hXg5gZN4c32BBjKoonLGkyx4Z8VeFETMT8b/+EVxNj2zfxagA3yWRAC3OcgPtHZ6n
	 i2XX1bk0jTLWOVbYvoTTzmZY+1hYU1miVJhRZBSwM8OVPzRIgiC2SYDWkNWQ89wtym
	 lYEw8lRGYS5QfTes8mCDVUt6BOTSTe6QbRjumzU0=
Received: from mail2.ietf.org (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id 2E12AF1ADB78
 for <bpf@vger.kernel.org>; Wed, 20 May 2026 08:47:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id F346EF1ADA3F
 for <bpf@mail2.ietf.org>; Wed, 20 May 2026 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1779292033; bh=TZH+rMvDegQFwVaH2eD2Rg2dbmHi6ZAZjsZrA9rPr38=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To;
 b=IFkZM0C0Ovn0xUX4OSFAQzbkfPNwEdmt/9JJ2Z7eB1AW9hu7/20iWBLDRiAEdwmwh
 5LkHRW43wMcu+R5+mj+nYIdXXC2G/xglujYbjXrH7MM+qQr0IdDB7VApoYfka2hvqK
 rKvLLtj4++9w+aVcSiL51NMFxXDg9vJd489ycmz0=
X-Virus-Scanned: amavisd-new at ietf.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
Authentication-Results: mail2.ietf.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=bootlin.com
Received: from mail2.ietf.org ([166.84.6.31])
 by localhost (mail2.ietf.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mELnHJLQHVU4 for <bpf@mail2.ietf.org>;
 Wed, 20 May 2026 08:47:12 -0700 (PDT)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by mail2.ietf.org (Postfix) with ESMTPS id 741DAF1AD941
 for <bpf@ietf.org>; Wed, 20 May 2026 08:46:35 -0700 (PDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8570D1A363F;
 Wed, 20 May 2026 15:46:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5685060019;
 Wed, 20 May 2026 15:46:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E16D7107EA299; Wed, 20 May 2026 17:46:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779291986; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=cfRNTAH818IUWJGgb+bd+5zxVp7Fbl8Z1v24qdUzGL0=;
 b=kw6X2Lwju3TtqEBuOKmLsB+JigNLGt59g+g/cA5d6IuQt/telkpinXB0YbLU683p4uIA6n
 V5Igu5qKadZccexFqmTviykYCbfSQRgYJ2eN4V8OPCiqsLd0mvZlut0eSp+O8zTFnG8b5y
 wpyEd+6Apvg05qvhSGxQxrNciwTHSMCt6M9pubSzyejSEasLD29mi/j5BkOdsTMsuIiecS
 fIHviMkJOS9TdXU9SEpdLbpG4zWd0BMWSnwlXdy6M+K8rOg+7KnzDh0l4GpzgW3mw5Fguk
 VbR959r0UCY63T9B1NB178G3x6DkQtOMwFB/o1u0oGpAXd5GecudhILUpvtzIw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 20 May 2026 17:46:21 +0200
Message-ID: <DINMD7Y3ZG8Q.3GZGX7SX9CN57@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>,
 <void@manifault.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <corbet@lwn.net>, <skhan@linuxfoundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520-bpf-insn-doc-v1-1-74d7dada9bfc@bootlin.com>
 <ffe4e22a8e5d0fceefa7f9ecb378e038b4686aa417addd57d2af243b67607c0a@mail.kernel.org>
In-Reply-To: <ffe4e22a8e5d0fceefa7f9ecb378e038b4686aa417addd57d2af243b67607c0a@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: GFL2XHAXC3K5RTBQIDCKOMJYW5X2CYMW
X-Message-ID-Hash: GFL2XHAXC3K5RTBQIDCKOMJYW5X2CYMW
X-MailFrom: alexis.lothore@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, bpf@vger.kernel.org, bpf@ietf.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_add_LOAD=5FAQC?=
 =?utf-8?q?UIRE_and_STORE=5FRELEASE_instructions?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/O3rI-7SZsME1xAyN1p0oy-dmnT8>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?=
 <alexis.lothore=40bootlin.com@dmarc.ietf.org>
Message-ID: <20260520154621.jBUpI6bi1TDk47ptUwP2489B7-XQHtZu6-p6-Yhd9XY@z>

T24gV2VkIE1heSAyMCwgMjAyNiBhdCA1OjE4IFBNIENFU1QsIGJvdCticGYtY2kgd3JvdGU6DQo+
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0
aW9uLXNldC5yc3QgYi9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rp
b24tc2V0LnJzdA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2lu
c3RydWN0aW9uLXNldC5yc3QNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXph
dGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQo+PiBAQCAtNjk1LDIyICs2OTUsMjQgQEANCj4+ICAg
ICoodTY0ICopKGRzdCArIG9mZnNldCkgKz0gc3JjDQo+Pg0KPj4gIEluIGFkZGl0aW9uIHRvIHRo
ZSBzaW1wbGUgYXRvbWljIG9wZXJhdGlvbnMsIHRoZXJlIGFsc28gaXMgYSBtb2RpZmllciBhbmQN
Cj4+IC10d28gY29tcGxleCBhdG9taWMgb3BlcmF0aW9uczoNCj4+ICtmb3VyIGNvbXBsZXggYXRv
bWljIG9wZXJhdGlvbnM6DQo+Pg0KPj4gIC4uIHRhYmxlOjogQ29tcGxleCBhdG9taWMgb3BlcmF0
aW9ucw0KPj4NCj4+ICAgID09PT09PT09PT09ICA9PT09PT09PT09PT09PT09ICA9PT09PT09PT09
PT09PT09PT09PT09PT09PT0NCj4+ICAgIGltbSAgICAgICAgICB2YWx1ZSAgICAgICAgICAgICBk
ZXNjcmlwdGlvbg0KPj4gICAgPT09PT09PT09PT0gID09PT09PT09PT09PT09PT0gID09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPj4gLSAgRkVUQ0ggICAgICAgIDB4MDEgICAgICAgICAgICAg
IG1vZGlmaWVyOiByZXR1cm4gb2xkIHZhbHVlDQo+PiAtICBYQ0hHICAgICAgICAgMHhlMCB8IEZF
VENIICAgICAgYXRvbWljIGV4Y2hhbmdlDQo+PiAtICBDTVBYQ0hHICAgICAgMHhmMCB8IEZFVENI
ICAgICAgYXRvbWljIGNvbXBhcmUgYW5kIGV4Y2hhbmdlDQo+PiArICBGRVRDSCAgICAgICAgMHgw
MDAxICAgICAgICAgICAgbW9kaWZpZXI6IHJldHVybiBvbGQgdmFsdWUNCj4+ICsgIFhDSEcgICAg
ICAgICAweDAwZTAgfCBGRVRDSCAgICBhdG9taWMgZXhjaGFuZ2UNCj4+ICsgIENNUFhDSEcgICAg
ICAweDAwZjAgfCBGRVRDSCAgICBhdG9taWMgY29tcGFyZSBhbmQgZXhjaGFuZ2UNCj4+ICsgIExP
QURfQUNRICAgICAweDAxMDAgICAgICAgICAgICBhdG9taWMgbG9hZCB3aXRoIGJhcnJpZXINCj4+
ICsgIFNUT1JFX1JFTCAgICAweDAxMTAgICAgICAgICAgICBhdG9taWMgc3RvcmUgd2l0aCBiYXJy
aWVyDQo+PiAgICA9PT09PT09PT09PSAgPT09PT09PT09PT09PT09PSAgPT09PT09PT09PT09PT09
PT09PT09PT09PT09DQo+Pg0KPj4gIFRoZSBgYEZFVENIYGAgbW9kaWZpZXIgaXMgb3B0aW9uYWwg
Zm9yIHNpbXBsZSBhdG9taWMgb3BlcmF0aW9ucywgYW5kDQo+PiAtYWx3YXlzIHNldCBmb3IgdGhl
IGNvbXBsZXggYXRvbWljIG9wZXJhdGlvbnMuICBJZiB0aGUgYGBGRVRDSGBgIGZsYWcNCj4+IC1p
cyBzZXQsIHRoZW4gdGhlIG9wZXJhdGlvbiBhbHNvIG92ZXJ3cml0ZXMgYGBzcmNgYCB3aXRoIHRo
ZSB2YWx1ZSB0aGF0DQo+PiAtd2FzIGluIG1lbW9yeSBiZWZvcmUgaXQgd2FzIG1vZGlmaWVkLg0K
Pj4gK2Fsd2F5cyBzZXQgZm9yIHRoZSBgYFhDSEdgYCBhbmQgYGBDTVBYQ0hHYGAgY29tcGxleCBh
dG9taWMgb3BlcmF0aW9ucy4gIElmDQo+PiArdGhlIGBgRkVUQ0hgYCBmbGFnIGlzIHNldCwgdGhl
biB0aGUgb3BlcmF0aW9uIGFsc28gb3ZlcndyaXRlcyBgYHNyY2BgIHdpdGgNCj4+ICt0aGUgdmFs
dWUgdGhhdCB3YXMgaW4gbWVtb3J5IGJlZm9yZSBpdCB3YXMgbW9kaWZpZWQuDQo+Pg0KPj4gIFRo
ZSBgYFhDSEdgYCBvcGVyYXRpb24gYXRvbWljYWxseSBleGNoYW5nZXMgYGBzcmNgYCB3aXRoIHRo
ZSB2YWx1ZQ0KPj4gIGFkZHJlc3NlZCBieSBgYGRzdCArIG9mZnNldGBgLg0KPg0KPiBbIC4uLiBd
DQo+DQo+PiBAQCAtNzIxLDYgKzcyMywxMSBAQA0KPj4gIHZhbHVlIHRoYXQgd2FzIGF0IGBgZHN0
ICsgb2Zmc2V0YGAgYmVmb3JlIHRoZSBvcGVyYXRpb24gaXMgemVyby1leHRlbmRlZA0KPj4gIGFu
ZCBsb2FkZWQgYmFjayB0byBgYFIwYGAuDQo+Pg0KPj4gK1RoZSBgYExPQURfQUNRYGAgYW5kIGBg
U1RPUkVfUkVMYGAgb3BlcmF0aW9ucyBpbXBsZW1lbnQgbGlnaHRlciBMT0FEIGFuZA0KPj4gK1NU
T1JFIG1lbW9yeSBiYXJyaWVycyB0aGFuIGZ1bGwgYmFycmllcnMuIFRoZSBjb3JyZXNwb25kaW5n
IGFjY2Vzc2VzIG11c3QNCj4+ICtiZSBhbGlnbmVkLCBidXQgYXJlIGFsbG93ZWQgZm9yIGFueSBh
Y2Nlc3Mgc2l6ZSAoOC1iaXQgdXAgdG8gNjQtYml0DQo+PiArb3BlcmF0aW9ucykuDQo+DQo+IERv
ZXMgdGhlIExPQURfQUNRIGRvY3VtZW50YXRpb24gbmVlZCB0byBjbGFyaWZ5IGl0cyBub24tc3Rh
bmRhcmQgcmVnaXN0ZXINCj4gc2VtYW50aWNzPyBCUEYgYXRvbWljIG9wZXJhdGlvbnMgYXJlIGVu
Y29kZWQgYXMgU1RYIGluc3RydWN0aW9ucywgd2hpY2gNCj4gY29udmVudGlvbmFsbHkgdXNlIGRz
dCBhcyB0aGUgbWVtb3J5IGJhc2UgcG9pbnRlciBhbmQgc3JjIGFzIHRoZSB2YWx1ZQ0KPiByZWdp
c3Rlci4gSG93ZXZlciwgTE9BRF9BQ1EgcmV2ZXJzZXMgdGhpcyBwYXR0ZXJuIGJ5IHVzaW5nIHNy
YyBhcyB0aGUNCj4gbWVtb3J5IGJhc2UgcG9pbnRlciBhbmQgZHN0IGFzIHRoZSBkZXN0aW5hdGlv
biByZWdpc3RlciBmb3IgdGhlIGZldGNoZWQNCj4gdmFsdWUsIGFjdGluZyBsaWtlIGFuIExEWCBp
bnN0cnVjdGlvbi4NCg0KVHJ1ZSwgSSBjYW4gc3BlY2lmeSB0aGF0IGJvdGggYXJlIGFueXdheSBz
dXBwb3J0ZWQgYnkgYSBTVFggaW5zdHJ1Y3Rpb24uIA0KDQo+IEFkZGl0aW9uYWxseSwgc2hvdWxk
IHRoZSBkb2N1bWVudGF0aW9uIGNsYXJpZnkgdGhhdCB0aGUgbG9hZGVkIHZhbHVlIGlzDQo+IHpl
cm8tZXh0ZW5kZWQgaW50byB0aGUgNjQtYml0IGRlc3RpbmF0aW9uIHJlZ2lzdGVyIGZvciA4LCAx
NiwgYW5kIDMyLWJpdA0KPiBhY2Nlc3Nlcz8gT21pdHRpbmcgdGhlc2UgZGV0YWlscyBtaWdodCBs
ZWFkIHRvIGluY29ycmVjdCBpbXBsZW1lbnRhdGlvbnMNCj4gYmFzZWQgb24gc3RhbmRhcmQgU1RY
IHJ1bGVzLg0KDQpJIGd1ZXNzIEkgY2FuIGFkZCB0aGlzIGRldGFpbCwgeWVzLg0KDQo+IFRoaXMg
Y29udHJhZGljdGlvbiBjcmVhdGVzIHNwZWNpZmljYXRpb24gYW1iaWd1aXR5OiB0aGUgZG9jdW1l
bnRhdGlvbg0KPiBzdGF0ZXMgdGhhdCBMT0FEX0FDUSBhbmQgU1RPUkVfUkVMICJhcmUgYWxsb3dl
ZCBmb3IgYW55IGFjY2VzcyBzaXplDQo+ICg4LWJpdCB1cCB0byA2NC1iaXQgb3BlcmF0aW9ucyki
LCBidXQgZWFybGllciBpbiB0aGUgZG9jdW1lbnQgKGxpbmUgNjcxKQ0KPiBleHBsaWNpdGx5IHN0
YXRlcyAiOC1iaXQgYW5kIDE2LWJpdCB3aWRlIGF0b21pYyBvcGVyYXRpb25zIGFyZSBub3QNCj4g
c3VwcG9ydGVkLiINCj4NCj4gVGhlIGluc3RydWN0aW9uIGVuY29kaW5nIHNlY3Rpb24gKGxpbmVz
IDY2Ny02NzEpIG9ubHkgZGVmaW5lcyB0d28gc2l6ZQ0KPiBlbmNvZGluZ3MgZm9yIEFUT01JQyBt
b2RlOg0KPiAtIHtBVE9NSUMsIFcsIFNUWH0gZm9yIDMyLWJpdCBvcGVyYXRpb25zDQo+IC0ge0FU
T01JQywgRFcsIFNUWH0gZm9yIDY0LWJpdCBvcGVyYXRpb25zDQo+DQo+IE5vIGVuY29kaW5nIGlz
IHNob3duIGZvciBCIChieXRlLzgtYml0KSBvciBIIChoYWxmLXdvcmQvMTYtYml0KSB3aXRoDQo+
IEFUT01JQyBtb2RlLg0KPg0KPiBJZiBMT0FEX0FDUS9TVE9SRV9SRUwgdHJ1bHkgc3VwcG9ydCA4
LWJpdCBhbmQgMTYtYml0IHNpemVzLCBzaG91bGRuJ3QgdGhlDQo+IGVuY29kaW5nIHNlY3Rpb24g
ZG9jdW1lbnQgaG93IEIgYW5kIEggc2l6ZSBtb2RpZmllcnMgd29yayB3aXRoIEFUT01JQw0KPiBt
b2RlLCBhbmQgbGluZSA2NzEgY2xhcmlmeSB0aGUgZXhjZXB0aW9uPw0KDQpUaGlzIHBvaW50LCBh
bmQgdGhlIGNvcnJlc3BvbmRpbmcgbWVudGlvbnMgdG8gdGhlICJhdG9taWMzMiBjb25mb3JtYW5j
ZQ0KZ3JvdXAiIGFuZCAiYXRvbWljNjQgY29uZm9ybWFuY2UgZ3JvdXAiLCBtYWRlIG1lIHJlYWxp
emUgdGhhdCB0aGUga2VybmVsDQpkb2Mgc2VlbXMgdG8gYmUgaW4gc3luYyB3aXRoIHRoZSBlQlBG
IElTQSBSRkMNCihodHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjOTY2OS5odG1sKS4g
SXQgbWFrZXMgbWUgd29uZGVyIGlmDQppdCdzIHJlYWxseSBvayB0byBhZGQgdGhvc2UgTE9BRF9B
Q1FVSVJFL1NUT1JFX1JFTEVBU0UgbWVudGlvbnMgaW4gdGhlDQprZXJuZWwgZG9jIG9ubHkgPw0K
DQo+IEFsdGVybmF0aXZlbHksIGlmIExPQURfQUNRL1NUT1JFX1JFTCBvbmx5IHN1cHBvcnQgMzIt
Yml0IGFuZCA2NC1iaXQgc2l6ZXMNCj4gbGlrZSBvdGhlciBhdG9taWMgb3BlcmF0aW9ucywgc2hv
dWxkIGxpbmUgNzI4IGJlIGNvcnJlY3RlZCB0byBzdGF0ZQ0KPiAiMzItYml0IGFuZCA2NC1iaXQg
b3BlcmF0aW9ucyIgaW5zdGVhZCBvZiAiOC1iaXQgdXAgdG8gNjQtYml0IG9wZXJhdGlvbnMiPw0K
Pg0KPiBGb3IgYSBzdGFuZGFyZGl6ZWQgaW5zdHJ1Y3Rpb24gc2V0IHNwZWNpZmljYXRpb24gdXNl
ZCBieSBtdWx0aXBsZQ0KPiBpbXBsZW1lbnRhdGlvbnMgKHZlcmlmaWVyLCBKSVQgY29tcGlsZXJz
LCBwb3RlbnRpYWxseSBvdGhlciBCUEYgcnVudGltZXMpLA0KPiBpbnRlcm5hbCBjb250cmFkaWN0
aW9ucyBjYW4gbGVhZCB0byBpbXBsZW1lbnRhdGlvbiBkaXZlcmdlbmNlIGFuZA0KPiBpbnRlcm9w
ZXJhYmlsaXR5IGlzc3Vlcy4NCj4NCj4+ICsNCj4+ICA2NC1iaXQgaW1tZWRpYXRlIGluc3RydWN0
aW9ucw0KPj4gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pg0KPg0KPg0KPiAtLS0N
Cj4gQUkgcmV2aWV3ZWQgeW91ciBwYXRjaC4gUGxlYXNlIGZpeCB0aGUgYnVnIG9yIGVtYWlsIHJl
cGx5IHdoeSBpdCdzIG5vdCBhIGJ1Zy4NCj4gU2VlOiBodHRwczovL2dpdGh1Yi5jb20va2VybmVs
LXBhdGNoZXMvdm10ZXN0L2Jsb2IvbWFzdGVyL2NpL2NsYXVkZS9SRUFETUUubWQNCj4NCj4gQ0kg
cnVuIHN1bW1hcnk6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9u
cy9ydW5zLzI2MTcwNjI4NjY4DQoNCg0KDQoNCi0tIA0KQWxleGlzIExvdGhvcsOpLCBCb290bGlu
DQpFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQpodHRwczovL2Jvb3RsaW4u
Y29tDQoNCi0tIApCcGYgbWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmli
ZSBzZW5kIGFuIGVtYWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=
