Received: from mail2.ietf.org (mail2.ietf.org [166.84.6.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E1308F15
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.6.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288388; cv=none; b=EBAqdvw+85t2IfLZvHp2R06ULIP44XU6ibx4yGIadRqty9Hsh6Tfr/99+tEXPE3p7klDz9X9dwb22boJxhk15MttPywjq51//MU3orvk3oDzcWsolzYq8PW1aRRCylQ8FhIP9sECIjnsArZkre/zR3DSneFJhluk1ln80+4Atr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288388; c=relaxed/simple;
	bh=CR5+I580kj5UfAHlqShHFsz4R3ZBvlzDE4279WXlvW4=;
	h=Date:MIME-Version:Content-Type:Message-Id:To:CC:Subject:From; b=ttrv6ONORmXypkgY+5O6G+YxPtSdCYR4rNulOElAYnyVYmHgg7698SFWgAloYprt3s2etsI/UtDnV1rMX3mbkzXDfKuri/p3NpdLwrNr6x8t0tubmL3ZOd3eMMT96EYdiqB7oc5GdlxspY5A4A0Ge+P2iSC1IrNVBnAjk5M2hK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=VAkkr8/u; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Dxp73xss reason="signature verification failed"; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aZAy/V/U reason="signature verification failed"; arc=none smtp.client-ip=166.84.6.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="VAkkr8/u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Dxp73xss";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aZAy/V/U"
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id D812CF1A2203
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1779287990; bh=CR5+I580kj5UfAHlqShHFsz4R3ZBvlzDE4279WXlvW4=;
	h=Date:To:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=VAkkr8/uVqqwuS0LFz4iilKGoCyDGLaJkFQB6XukWQ6ML/5WYsoxj0OLEHliFwaDk
	 xr+XToPWNSmEz623NT2x58za3Ty2kTk6YeayPPm96bUboTLUrscqTfuJyaLCI/wzgG
	 Sg9DiodVueF7gfPBmaxa5zj0/23SQMou0hmDJ1qo=
Received: from mail2.ietf.org (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id D3C8FF1A2202
 for <bpf@vger.kernel.org>; Wed, 20 May 2026 07:39:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id DB48CF1A1FE9
 for <bpf@mail2.ietf.org>; Wed, 20 May 2026 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1779287881; bh=RHAKs9OGxFYI3rNTfld3tJbh+rGAuDUFivZwqZSuFmo=;
 h=From:Date:Subject:To:Cc;
 b=Dxp73xss7qnuJANeIJtvFjE3jf2uxMkmUuVM8V0Penvdlfx8Z/31miRl3UA2N3RFw
 i4nRovaXf2N27d+yAoy7L5Ob5LmRlAbM5IaWPNO92cQ97B8mjTGraItdTIs+oc8QD4
 Me9aeQpzw7p/3S/SmCuD0/Q70ViS45scUBqMI2Mw=
X-Virus-Scanned: amavisd-new at ietf.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
Authentication-Results: mail2.ietf.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=bootlin.com
Received: from mail2.ietf.org ([166.84.6.31])
 by localhost (mail2.ietf.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xLCCzOxqm-wX for <bpf@mail2.ietf.org>;
 Wed, 20 May 2026 07:38:01 -0700 (PDT)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by mail2.ietf.org (Postfix) with ESMTPS id 3C97AF1A1E74
 for <bpf@ietf.org>; Wed, 20 May 2026 07:36:37 -0700 (PDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 71F8BC2B9FC;
 Wed, 20 May 2026 14:37:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B180560019;
 Wed, 20 May 2026 14:36:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 46FCB107EA209; Wed, 20 May 2026 16:36:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779287788; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=jdt8tHz+qF7hLZ7fl9e5TxL4zWnt+ACbt2uON1wGzgs=;
 b=aZAy/V/UkbKD6Yp/TQJFjz6OCBGwe8BZ//R6XLDu0D8QQTzN8ZNYFXBhzxP1TU2HjfPmyy
 vdsAMzRBDh5nH55471imk+dCLt8iC9cByHkBEnIkrtBnVi5afZcsSGafc4eBWukDof9T5y
 nYFUdDW7STP5uq/EwS7Ai1csEecGMJtIY7DspKsi2xltwRb4SWv6wIYAZxreEysso6Ypnq
 hobs7mnCA1mUXj+HDjDg2UbWXKqsnOtpozGYPDd616m7DoYhGlAC+deWghyeM+ho7NIuO2
 4yHa1XscLrggfleAt6QdidjUspjCZHw3XGWmC2VUdY+idR+kJb388zHKpoqacw==
Date: Wed, 20 May 2026 16:36:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260520-bpf-insn-doc-v1-1-74d7dada9bfc@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw6DMAwFr4LeupbSINLPVaouSDCtuzAopggJc
 XdCuxy9N7PCOAsb7tWKzLOYDFrgfKqQ3q2+mKQrDO98cI13FMeeRE2pGxJdmhDrcEtt7a8oypi
 5l+WXe+B4Ki8Tnv/FvvHDaTpq2LYdBIOXnnoAAAA=
X-Change-ID: 20260520-bpf-insn-doc-756b369ca328
To: David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 7A2CIVFFP73SYBC7MUYZDLU2M7MVAEWF
X-Message-ID-Hash: 7A2CIVFFP73SYBC7MUYZDLU2M7MVAEWF
X-MailFrom: alexis.lothore@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 bpf@ietf.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_add_LOAD=5FAQCUIRE_a?=
 =?utf-8?q?nd_STORE=5FRELEASE_instructions?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/u-2lKrcsrJZdS4X1JlNg2oDem9Y>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Transfer-Encoding: base64
X-Original-From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore=40bootlin.com@dmarc.ietf.org>
Message-ID: <20260520143619.ruoAK0kKBUl1hdo1XdaRgCXMG0kniz395UgfgbgLZ_w@z>

Q29tbWl0IDg4MDQ0MjMwNWEzOSAoImJwZjogSW50cm9kdWNlIGxvYWQtYWNxdWlyZSBhbmQgc3Rv
cmUtcmVsZWFzZQ0KaW5zdHJ1Y3Rpb25zIikgaW5zdHJvZHVjZWQgdGhlIExPQURfQUNRVUlSRSBh
bmQgU1RPUkVfUkVMRUFTRSBhdG9taWMNCmluc3RydWN0aW9ucyBtb2RpZmllcnMuIFRob3NlIGFy
ZSBjdXJyZW50bHkgbm90IGRlc2NyaWJlZCBpbiB0aGUNCmRvY3VtZW50YXRpb24sIGRlc3BpdGUg
YmVpbmcgdXNlZCBpbiB0aGUgdmVyaWZpZXIgYW5kIHRoZSB2YXJpb3VzIEpJVA0KY29tcGlsZXJz
IHN1cHBvcnRpbmcgdGhlbS4NCg0KQWRkIHRoZSBtaXNzaW5nIGVudHJpZXMgaW4gdGhlIGluc3Ry
dWN0aW9uIHNldCBkb2N1bWVudGF0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGV4aXMgTG90aG9y
w6kgKGVCUEYgRm91bmRhdGlvbikgPGFsZXhpcy5sb3Rob3JlQGJvb3RsaW4uY29tPg0KLS0tDQog
Li4uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCAgICAgICAgIHwgMjEg
KysrKysrKysrKysrKystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFy
ZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJk
aXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQppbmRleCAzOWM3NDYxMTc1MmIuLjRmMTBiY2Qw
MzE1MCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0
cnVjdGlvbi1zZXQucnN0DQorKysgYi9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24v
aW5zdHJ1Y3Rpb24tc2V0LnJzdA0KQEAgLTY5NSwyMiArNjk1LDI0IEBAIGFyaXRobWV0aWMgb3Bl
cmF0aW9ucyBpbiB0aGUgJ2ltbScgZmllbGQgdG8gZW5jb2RlIHRoZSBhdG9taWMgb3BlcmF0aW9u
Og0KICAgKih1NjQgKikoZHN0ICsgb2Zmc2V0KSArPSBzcmMNCiANCiBJbiBhZGRpdGlvbiB0byB0
aGUgc2ltcGxlIGF0b21pYyBvcGVyYXRpb25zLCB0aGVyZSBhbHNvIGlzIGEgbW9kaWZpZXIgYW5k
DQotdHdvIGNvbXBsZXggYXRvbWljIG9wZXJhdGlvbnM6DQorZm91ciBjb21wbGV4IGF0b21pYyBv
cGVyYXRpb25zOg0KIA0KIC4uIHRhYmxlOjogQ29tcGxleCBhdG9taWMgb3BlcmF0aW9ucw0KIA0K
ICAgPT09PT09PT09PT0gID09PT09PT09PT09PT09PT0gID09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KICAgaW1tICAgICAgICAgIHZhbHVlICAgICAgICAgICAgIGRlc2NyaXB0aW9uDQogICA9
PT09PT09PT09PSAgPT09PT09PT09PT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09
DQotICBGRVRDSCAgICAgICAgMHgwMSAgICAgICAgICAgICAgbW9kaWZpZXI6IHJldHVybiBvbGQg
dmFsdWUNCi0gIFhDSEcgICAgICAgICAweGUwIHwgRkVUQ0ggICAgICBhdG9taWMgZXhjaGFuZ2UN
Ci0gIENNUFhDSEcgICAgICAweGYwIHwgRkVUQ0ggICAgICBhdG9taWMgY29tcGFyZSBhbmQgZXhj
aGFuZ2UNCisgIEZFVENIICAgICAgICAweDAwMDEgICAgICAgICAgICBtb2RpZmllcjogcmV0dXJu
IG9sZCB2YWx1ZQ0KKyAgWENIRyAgICAgICAgIDB4MDBlMCB8IEZFVENIICAgIGF0b21pYyBleGNo
YW5nZQ0KKyAgQ01QWENIRyAgICAgIDB4MDBmMCB8IEZFVENIICAgIGF0b21pYyBjb21wYXJlIGFu
ZCBleGNoYW5nZQ0KKyAgTE9BRF9BQ1EgICAgIDB4MDEwMCAgICAgICAgICAgIGF0b21pYyBsb2Fk
IHdpdGggYmFycmllcg0KKyAgU1RPUkVfUkVMICAgIDB4MDExMCAgICAgICAgICAgIGF0b21pYyBz
dG9yZSB3aXRoIGJhcnJpZXINCiAgID09PT09PT09PT09ICA9PT09PT09PT09PT09PT09ICA9PT09
PT09PT09PT09PT09PT09PT09PT09PT0NCiANCiBUaGUgYGBGRVRDSGBgIG1vZGlmaWVyIGlzIG9w
dGlvbmFsIGZvciBzaW1wbGUgYXRvbWljIG9wZXJhdGlvbnMsIGFuZA0KLWFsd2F5cyBzZXQgZm9y
IHRoZSBjb21wbGV4IGF0b21pYyBvcGVyYXRpb25zLiAgSWYgdGhlIGBgRkVUQ0hgYCBmbGFnDQot
aXMgc2V0LCB0aGVuIHRoZSBvcGVyYXRpb24gYWxzbyBvdmVyd3JpdGVzIGBgc3JjYGAgd2l0aCB0
aGUgdmFsdWUgdGhhdA0KLXdhcyBpbiBtZW1vcnkgYmVmb3JlIGl0IHdhcyBtb2RpZmllZC4NCith
bHdheXMgc2V0IGZvciB0aGUgYGBYQ0hHYGAgYW5kIGBgQ01QWENIR2BgIGNvbXBsZXggYXRvbWlj
IG9wZXJhdGlvbnMuICBJZg0KK3RoZSBgYEZFVENIYGAgZmxhZyBpcyBzZXQsIHRoZW4gdGhlIG9w
ZXJhdGlvbiBhbHNvIG92ZXJ3cml0ZXMgYGBzcmNgYCB3aXRoDQordGhlIHZhbHVlIHRoYXQgd2Fz
IGluIG1lbW9yeSBiZWZvcmUgaXQgd2FzIG1vZGlmaWVkLg0KIA0KIFRoZSBgYFhDSEdgYCBvcGVy
YXRpb24gYXRvbWljYWxseSBleGNoYW5nZXMgYGBzcmNgYCB3aXRoIHRoZSB2YWx1ZQ0KIGFkZHJl
c3NlZCBieSBgYGRzdCArIG9mZnNldGBgLg0KQEAgLTcyMSw2ICs3MjMsMTEgQEAgVGhlIGBgQ01Q
WENIR2BgIG9wZXJhdGlvbiBhdG9taWNhbGx5IGNvbXBhcmVzIHRoZSB2YWx1ZSBhZGRyZXNzZWQg
YnkNCiB2YWx1ZSB0aGF0IHdhcyBhdCBgYGRzdCArIG9mZnNldGBgIGJlZm9yZSB0aGUgb3BlcmF0
aW9uIGlzIHplcm8tZXh0ZW5kZWQNCiBhbmQgbG9hZGVkIGJhY2sgdG8gYGBSMGBgLg0KIA0KK1Ro
ZSBgYExPQURfQUNRYGAgYW5kIGBgU1RPUkVfUkVMYGAgb3BlcmF0aW9ucyBpbXBsZW1lbnQgbGln
aHRlciBMT0FEIGFuZA0KK1NUT1JFIG1lbW9yeSBiYXJyaWVycyB0aGFuIGZ1bGwgYmFycmllcnMu
IFRoZSBjb3JyZXNwb25kaW5nIGFjY2Vzc2VzIG11c3QNCitiZSBhbGlnbmVkLCBidXQgYXJlIGFs
bG93ZWQgZm9yIGFueSBhY2Nlc3Mgc2l6ZSAoOC1iaXQgdXAgdG8gNjQtYml0DQorb3BlcmF0aW9u
cykuDQorDQogNjQtYml0IGltbWVkaWF0ZSBpbnN0cnVjdGlvbnMNCiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KIA0KDQotLS0NCmJhc2UtY29tbWl0OiBjZWViM2FhMzdiZmY4OTUxMTY5
NDRhY2Y0MzQ3ZmNkZWQwYjc2OTJkDQpjaGFuZ2UtaWQ6IDIwMjYwNTIwLWJwZi1pbnNuLWRvYy03
NTZiMzY5Y2EzMjgNCg0KQmVzdCByZWdhcmRzLA0KLS0gIA0KQWxleGlzIExvdGhvcsOpIChlQlBG
IEZvdW5kYXRpb24pIDxhbGV4aXMubG90aG9yZUBib290bGluLmNvbT4NCg0KLS0gCkJwZiBtYWls
aW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8g
YnBmLWxlYXZlQGlldGYub3JnCg==
