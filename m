Received: from mail2.ietf.org (mail2.ietf.org [166.84.6.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381EE286D5E
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.6.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439065; cv=none; b=nou5EX5O7SS6nFzVEeVVFWcPqQ4kPwWHZPxlu7mgWHSeBSpWp9J8rfh1JeRdwi3Nhp9hqRTUeoqrCfCWvB/UDXx6+b8dskaZ7KV/jBnNlLWmRLt3RLhuQr+mQnY0VMYYdeFMpVJn3ar2RHjOTRXHXqFZAY2QDHc8qlfe2dwt16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439065; c=relaxed/simple;
	bh=ykrqE35mYER04fobRgvTn/sDEzrYm75MbCE1WRGsCNo=;
	h=Mime-Version:Date:Message-Id:To:References:In-Reply-To:CC:Subject:
	 Content-Type:From; b=HU2Yc0FfR9NIaohOeADeVcfRFWwyqWRrK9BAGvX+o5fgUHy9XfMu7yPuPG0UZXqmc91wkq1PM8PCN5dWRhvuvxwkAXot4NVoAEq/5IMobAMYBKBg0n5/ia7tCkFiHC4YmDrATMsNrF8tNkECuszcBdj7JyQKxL5/co3tkpESEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Et3lBpHM; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=v82+0CBa reason="signature verification failed"; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iSWlrrrf reason="signature verification failed"; arc=none smtp.client-ip=166.84.6.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Et3lBpHM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="v82+0CBa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iSWlrrrf"
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 5EC97F312126
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1779439038; bh=ykrqE35mYER04fobRgvTn/sDEzrYm75MbCE1WRGsCNo=;
	h=Date:To:References:In-Reply-To:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Et3lBpHMynu0B5YUdLN077MixnyuGUMJUwAU9xKdVtfEy/44n///8wEH9reuRicNd
	 v0FtTbWwIweaAV04Qjy6Hn8a9ewqx7Be8tDukivJfpscXk5zXWeGIa2PthFN1HmUKS
	 SNTtOc/X6LAiFvD5+vdJuP5XTSFwZsJzWOKJLFkg=
Received: from mail2.ietf.org (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id 5A608F312125
 for <bpf@vger.kernel.org>; Fri, 22 May 2026 01:37:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id 7EC1BF311FF2
 for <bpf@mail2.ietf.org>; Fri, 22 May 2026 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1779439033; bh=LmAISd4ebyhJ9FVXp8zS8g49akLmSgWRCgJZkG99Ad8=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To;
 b=v82+0CBauUYC8HXpXQ3KfHNnnwyembzVXbcYfwu+Oc4QUhEM/+Nb0u6NX4E8ziz2i
 SPL2fzLmGWkb5d5h1AgjqRdl1Yx+iNsf8j3MB9cXL1rURICwrO6rLsGKVPiTG+18bg
 n0AvSarGxRb8LTy9GvQJKI3Rx2cJOlSqJRiTMpU0=
X-Virus-Scanned: amavisd-new at ietf.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
Authentication-Results: mail2.ietf.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=bootlin.com
Received: from mail2.ietf.org ([166.84.6.31])
 by localhost (mail2.ietf.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aODI2X-kmQo3 for <bpf@mail2.ietf.org>;
 Fri, 22 May 2026 01:37:12 -0700 (PDT)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by mail2.ietf.org (Postfix) with ESMTPS id 29096F311E7E
 for <bpf@ietf.org>; Fri, 22 May 2026 01:35:32 -0700 (PDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A7E484E42D29;
 Fri, 22 May 2026 08:35:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 605016003C;
 Fri, 22 May 2026 08:35:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 112AF107E8C99; Fri, 22 May 2026 10:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779438925; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=LmAISd4ebyhJ9FVXp8zS8g49akLmSgWRCgJZkG99Ad8=;
 b=iSWlrrrfXmy+lWXhawqaGpYEiJ30wtFRKRUfb8mhYrOMLLPuo/cYatFTxvnUWyKLxGVrBk
 TjYj3La+MguZ1oomkRcsMD29RefU8hX3ZxXrkAsDlLz4L4iUSLfS5PBaZQyi6/X87uM1cu
 4HxyVKGz0QXF9F2qtWmFVFttLnU5C4ExBS+8bZmKaCfotkONfBqKs45dJwmqZmLnoLK0/v
 pj4Ltp67XP6oIuMFumNyToPVAZ333lRCpFZn4zIhgrFGgw/fnbTpkm7gv3CSVkzryxasu5
 I9TcJxHAu44dOq4QXvDTcBGOkK3YvKE4pv1GX8Z+CPY1VrRXMQ8eIIopHiITDg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 22 May 2026 10:35:20 +0200
Message-ID: <DIP2GAUG3O18.29B8U0FOVEVET@bootlin.com>
To: "David Vernet" <void@manifault.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
 <iulf7fwwvfrvvspg4e5xyx3tcxe2yonfjllnze2phgfgpynrlh@kodf3fy3l32q>
In-Reply-To: <iulf7fwwvfrvvspg4e5xyx3tcxe2yonfjllnze2phgfgpynrlh@kodf3fy3l32q>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 3XWVVI3ODMZJHXDEIE3HPBTPE32PGD6C
X-Message-ID-Hash: 3XWVVI3ODMZJHXDEIE3HPBTPE32PGD6C
X-MailFrom: alexis.lothore@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 ebpf@linuxfoundation.org, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 bpf@ietf.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next_v2=5D_bpf=2C_docs=3A_add_LOAD=5F?=
 =?utf-8?q?ACQUIRE_and_STORE=5FRELEASE_instructions?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/VzHZfcmNpcZauRk0NfZsB2gMFRo>
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
Message-ID: <20260522083520.CJyiIyUnvCA0o0F369Xs706I3hQBuwySQ6ItaMsKxOo@z>

SGkgRGF2aWQsDQoNCk9uIFRodSBNYXkgMjEsIDIwMjYgYXQgNDoxNyBBTSBDRVNULCBEYXZpZCBW
ZXJuZXQgd3JvdGU6DQo+IE9uIFRodSwgTWF5IDIxLCAyMDI2IGF0IDEyOjA5OjExQU0gKzAyMDAs
IEFsZXhpcyBMb3Rob3LDqSAoZUJQRiBGb3VuZGF0aW9uKSB3cm90ZToNCj4NCj4gSGkgQWxleGlz
LA0KPg0KPiBUaGFua3MgZm9yIHdvcmtpbmcgb24gdGhpcy4NCj4NCj4+IENvbW1pdCA4ODA0NDIz
MDVhMzkgKCJicGY6IEludHJvZHVjZSBsb2FkLWFjcXVpcmUgYW5kIHN0b3JlLXJlbGVhc2UNCj4+
IGluc3RydWN0aW9ucyIpIGluc3Ryb2R1Y2VkIHRoZSBMT0FEX0FDUVVJUkUgYW5kIFNUT1JFX1JF
TEVBU0UgYXRvbWljDQo+DQo+IGludHJvZHVjZWQNCj4NCj4+IGluc3RydWN0aW9ucyBtb2RpZmll
cnMuIFRob3NlIGFyZSBjdXJyZW50bHkgbm90IGRlc2NyaWJlZCBpbiB0aGUNCj4+IGRvY3VtZW50
YXRpb24sIGRlc3BpdGUgYmVpbmcgdXNlZCBpbiB0aGUgdmVyaWZpZXIgYW5kIHRoZSB2YXJpb3Vz
IEpJVA0KPj4gY29tcGlsZXJzIHN1cHBvcnRpbmcgdGhlbS4NCj4+IA0KPj4gQWRkIHRoZSBtaXNz
aW5nIGVudHJpZXMgaW4gdGhlIGluc3RydWN0aW9uIHNldCBkb2N1bWVudGF0aW9uLg0KPj4gDQo+
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4aXMgTG90aG9yw6kgKGVCUEYgRm91bmRhdGlvbikgPGFsZXhp
cy5sb3Rob3JlQGJvb3RsaW4uY29tPg0KPg0KPiBBbGV4ZWkgZXQgYWwgLS0gaWYgeW91IHBsYW4g
dG8gZG8gYSBzdWJzZXF1ZW50IFJGQywgaXQgd2lsbCBpbmZsdWVuY2UNCj4gaG93IHRoaXMgZG9j
dW1lbnQgbmVlZHMgdG8gYmUgc3RydWN0dXJlZC4gWzBdIGV4cGxhaW5zIHRoZSBwcm9jZXNzIGZv
cg0KPiBhZGRpbmcgbmV3IGluc3RydWN0aW9ucy4gVG8gcXVvdGU6DQo+DQo+PiBPbmNlIGEgY29u
Zm9ybWFuY2UgZ3JvdXAgaXMgcmVnaXN0ZXJlZCB3aXRoIGEgc2V0IG9mIGluc3RydWN0aW9ucywg
bm8NCj4+IGZ1cnRoZXIgaW5zdHJ1Y3Rpb25zIGNhbiBiZSBhZGRlZCB0byB0aGF0IGNvbmZvcm1h
bmNlIGdyb3VwLiBBDQo+PiBzcGVjaWZpY2F0aW9uIHNob3VsZCBpbnN0ZWFkIGNyZWF0ZSBhIG5l
dyBjb25mb3JtYW5jZSBncm91cCB0aGF0DQo+PiBpbmNsdWRlcyB0aGUgb3JpZ2luYWwgY29uZm9y
bWFuY2UgZ3JvdXAsIHBsdXMgYW55IG5ld2x5IGFkZGVkDQo+PiBpbnN0cnVjdGlvbnMuIEluY2x1
c2lvbiBvZiB0aGUgb3JpZ2luYWwgY29uZm9ybWFuY2UgZ3JvdXAgaXMgZG9uZSB2aWENCj4+IHRo
ZSAiaW5jbHVkZXMiIGNvbHVtbiBvZiB0aGUgQlBGIEluc3RydWN0aW9uIENvbmZvcm1hbmNlIEdy
b3Vwcw0KPj4gcmVnaXN0cnksIGFuZCBpbmNsdXNpb24gb2YgbmV3bHkgYWRkZWQgaW5zdHJ1Y3Rp
b25zIGlzIGRvbmUgdmlhIHRoZQ0KPj4gImdyb3VwcyIgY29sdW1uIG9mIHRoZSBCUEYgSW5zdHJ1
Y3Rpb24gU2V0IHJlZ2lzdHJ5Lg0KPg0KPiBTbyB5b3Ugd291bGQgaGF2ZSB0byBjcmVhdGUgYSBu
ZXcgY29uZm9ybWFuY2UgZ3JvdXAgZm9yIHRoZXNlIG5ldw0KPiBhdG9taWNzIC0tIHlvdSBjYW4n
dCBqdXN0IGFkZCB0aGVtIHRvIHRoZSBleGlzdGluZyBvbmUuIEluIGdlbmVyYWwgaXQNCj4gbWln
aHQgYmUgZWFzaWVyIC8gYWR2aXNlZCB0byBzbmFwc2hvdCB0aGlzIGZpbGUgdG8gUkZDIDk2Njkg
YW5kIGNyZWF0ZSBhDQo+IG5ldyBvbmUgZm9yIHRoZSBuZXcgaW5zdHJ1Y3Rpb25zIHRvIG1ha2Ug
aXQgZWFzaWVyIHRvIHRlYXNlIHRoaXMgc3R1ZmYNCj4gYXBhcnQgbGF0ZXIuIElmIHRoYXQncyBz
b21ldGhpbmcgeW91IHdhbnQsIEknbSBoYXBweSB0byBnZXQgdXMgc3RhcnRlZA0KPiB3aXRoIGEg
c2tlbGV0b24gZmlsZS4gQWdhaW4sIHRob3VnaCwgdGhhdCdzIG9ubHkgbmVjZXNzYXJ5IGlmIHlv
dSBwbGFuDQo+IHRvIHN1Ym1pdCBhIG5ldyBkb2N1bWVudCB0byB0aGUgSUVURiBXRy4NCj4NCj4g
WzBdOiBodHRwczovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjOTY2OS5odG1sI25hbWUtYWRk
aW5nLWluc3RydWN0aW9ucw0KDQpJIGRvbid0IGtub3cgaG93IGhlYXZ5L2xvbmcgdGhlIHByb2Nl
c3MgaXMgdG8gc3VibWl0IHRoaXMga2luZCBvZiBSRkMNCnVwZGF0ZSwgYnV0IHlvdXIgcG9pbnQg
bWFrZXMgaXQgc291bmQgbGlrZSBpdCBtYWtlcyBtb3JlIHNlbnNlIHRvIGp1c3QNCmdvIGRpcmVj
dGx5IGZvciB0aGUgcHJvcGVyIHdheSwgaWUgYWRkaW5nIHRoZSBjb25mb3JtYW5jZSBncm91cCBh
bmQgdGhlbg0KYWRkaW5nIHRob3NlIG5ldyBvcHMgaW4gdGhlcmUsIHJhdGhlciB0aGFuIHVwZGF0
aW5nIHRoZSBrZXJuZWwgZG9jIGFzIG15DQpzZXJpZXMgaXMgcHJvcG9zaW5nLCBhbmQgdGhlbiBs
YXRlciByZXZlcnRpbmcgdG8gYSBwcm9wZXIgY29uZm9ybWFuY2UNCmdyb3VwLg0KDQotLSANCkFs
ZXhpcyBMb3Rob3LDqSwgQm9vdGxpbg0KRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVl
cmluZw0KaHR0cHM6Ly9ib290bGluLmNvbQ0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZA
aWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5v
cmcK
