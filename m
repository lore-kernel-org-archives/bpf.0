Received: from mail2.ietf.org (mail2.ietf.org [166.84.6.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3353806C6
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.6.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314999; cv=none; b=Mr7qSggPsLejM0IAQfyL0FbsCU8WMGcQ5tmbsI8zyi471yAhwbTWUHYGQG4I9YMwX3aj5KO3sUHTsVUli4p/hmFMpCSzWLvaOjMJOXL3Op0RiEthCNaJcoLfkBHRsyECac/QGvfPpUdxu05foWHC2HXFy6sK30LKgfDB6FkJsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314999; c=relaxed/simple;
	bh=hFeQyjQ6ZP2ElP//PtFpQo8eJiw72QkglI93OFBe6Fg=;
	h=Date:MIME-Version:Content-Type:Message-Id:To:CC:Subject:From; b=Nr/mQOuOTV7KRUT+xlglLs8jhro1+adqfzesWwYNFp83/w42xhbrFPS8ZUxOBV7/1YkglOLH7dXhIEesOGzsDcw12seRpHFDVtRUwwVqOxGZHzi5pEsCYKZD5La7G/YaUVl23dH1BXiTpr+hi4Lq9nK60fpK9xP5ebtX33Oor6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=h/gyOR+q; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ihKjz4X7 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JY/2N9wD reason="signature verification failed"; arc=none smtp.client-ip=166.84.6.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="h/gyOR+q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ihKjz4X7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JY/2N9wD"
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 97809F1F731B
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1779314997; bh=hFeQyjQ6ZP2ElP//PtFpQo8eJiw72QkglI93OFBe6Fg=;
	h=Date:To:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=h/gyOR+qJSzv6/Z54g04MSylAAOH5ednsnrS3ZoLE5Re5m9avh42pUamqDR40xYf4
	 m7VfIsAG2h+HY4anIIna5cknUSRLMiLvpN69xPuWMXxKFVtuk6Q+ShWtnHnGTyIxk1
	 aXFLbNgwZenuDl7RyhUdCcAjyu00ELQDdeeyi3aU=
Received: from mail2.ietf.org (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id 92A4CF1F731A
 for <bpf@vger.kernel.org>; Wed, 20 May 2026 15:09:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id DFD9AF1F722A
 for <bpf@mail2.ietf.org>; Wed, 20 May 2026 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1779314991; bh=sESrtnEkiukd957DKW4R4u+5NVgNWu0Rox+HVle5NOc=;
 h=From:Date:Subject:To:Cc;
 b=ihKjz4X7PSzPXk++5i2EwmUBuRcbTo5gS2lUZxFhgcKcSTdnKzCkjz5zLHYYdYZ1I
 C6dmKmU9omOc4ZMlgHB5rFowDJzX+LKdLSv4f+U+vPnWsbGcLlT1kKzVtARs8gYN5c
 MN+rXxRlr/CRkvJ0QO79Y1ATaXV6yiB2CvCzAI6o=
X-Virus-Scanned: amavisd-new at ietf.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
Authentication-Results: mail2.ietf.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=bootlin.com
Received: from mail2.ietf.org ([166.84.6.31])
 by localhost (mail2.ietf.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ni3s8_Vgq1uu for <bpf@mail2.ietf.org>;
 Wed, 20 May 2026 15:09:51 -0700 (PDT)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by mail2.ietf.org (Postfix) with ESMTPS id C601DF1F7217
 for <bpf@ietf.org>; Wed, 20 May 2026 15:09:50 -0700 (PDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id BFBBBC2C649;
 Wed, 20 May 2026 22:10:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C1E7C60019;
 Wed, 20 May 2026 22:09:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 76A47107EA218; Thu, 21 May 2026 00:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779314987; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=k2dpDAzX+92g0x+C7pCYldq5Fu4ePZOO/ElZAdhgYyk=;
 b=JY/2N9wDK5+hiyRFaCppsT37VKYC9Nb9y01lTE4KuA22D047rlTEUb13AOGEQBmw5shxad
 bkBRv1IIsJu521Nf/g5NSdRhNGYSiuqFIAoBPSKuvBespd5kKDCdFOQKU2Xe8OgbH9ZIc5
 9zRB/XY9AYfzVdtXlWeYze5anzwAHpE6wdJSiCvF3ubWxOS6A5S1c8FXeN0t8ZQPe+fAlU
 cHtJnkmvtBkFAXHPnni3F4ayWnS8oYf2GDI2gRtza2xRT+t/Aqwr9qKQpGssrS9EP1iDDM
 i81ksRtKCdl/doxaT1whcP7dxFN0SmVTLDOjLQHNdvLalfptovkYBDiGRYz/kw==
Date: Thu, 21 May 2026 00:09:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NzQ6CMBCEX4Xs2TVQBMST72E49GeRNdqStjYYw
 rsLePU4mW++mSGQZwpwyWbwlDiws2sQhwz0IO2dkM2aQeSiziuRoxp7ZBssGqexqWpV1q2WpTj
 DOhk99TztuhtspKUpQvdrwls9SMfNtrEDh+j8Z39Oxb74f5IKLLA5mcZII1vV66tyLj7ZHrV7Q
 bcsyxcx6oKexgAAAA==
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
Message-ID-Hash: ZEOEIMYBQMDJHLSSD2OWQKS7PXQZDTOO
X-Message-ID-Hash: ZEOEIMYBQMDJHLSSD2OWQKS7PXQZDTOO
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
Subject: =?utf-8?q?=5BBpf=5D_=5BPATCH_bpf-next_v2=5D_bpf=2C_docs=3A_add_LOAD=5FACQUIR?=
 =?utf-8?q?E_and_STORE=5FRELEASE_instructions?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/zptgZazejDOR3wSENu4_95f1uS8>
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
Message-ID: <20260520220911.CFvlnyVcHmbbf-7TW9sOJLUFR5zWx_ZUaYCOvpNAHpc@z>

Q29tbWl0IDg4MDQ0MjMwNWEzOSAoImJwZjogSW50cm9kdWNlIGxvYWQtYWNxdWlyZSBhbmQgc3Rv
cmUtcmVsZWFzZQ0KaW5zdHJ1Y3Rpb25zIikgaW5zdHJvZHVjZWQgdGhlIExPQURfQUNRVUlSRSBh
bmQgU1RPUkVfUkVMRUFTRSBhdG9taWMNCmluc3RydWN0aW9ucyBtb2RpZmllcnMuIFRob3NlIGFy
ZSBjdXJyZW50bHkgbm90IGRlc2NyaWJlZCBpbiB0aGUNCmRvY3VtZW50YXRpb24sIGRlc3BpdGUg
YmVpbmcgdXNlZCBpbiB0aGUgdmVyaWZpZXIgYW5kIHRoZSB2YXJpb3VzIEpJVA0KY29tcGlsZXJz
IHN1cHBvcnRpbmcgdGhlbS4NCg0KQWRkIHRoZSBtaXNzaW5nIGVudHJpZXMgaW4gdGhlIGluc3Ry
dWN0aW9uIHNldCBkb2N1bWVudGF0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGV4aXMgTG90aG9y
w6kgKGVCUEYgRm91bmRhdGlvbikgPGFsZXhpcy5sb3Rob3JlQGJvb3RsaW4uY29tPg0KLS0tDQpD
aGFuZ2VzIGluIHYyOg0KLSBmaXggY29tbWl0IG1lc3NhZ2UgdHlwbw0KLSBjbGFyaWZ5IHplcm8t
ZXh0ZW5zaW9uIGFuZCByZWdpc3RlcnMgbWVhbmluZyBmb3IgTE9BRF9BQ1ENCi0gY2xhcmlmeSBp
bnNuIGVuY29kaW5nIGZvciBMT0FEX0FDUSBhbmQgU1RPUkVfUkVMDQotIExpbmsgdG8gdjE6IGh0
dHBzOi8vcGF0Y2gubXNnaWQubGluay8yMDI2MDUyMC1icGYtaW5zbi1kb2MtdjEtMS03NGQ3ZGFk
YTliZmNAYm9vdGxpbi5jb20NCg0KVG86IERhdmlkIFZlcm5ldCA8dm9pZEBtYW5pZmF1bHQuY29t
Pg0KVG86IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+DQpUbzogRGFuaWVsIEJv
cmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD4NClRvOiBBbmRyaWkgTmFrcnlpa28gPGFuZHJp
aUBrZXJuZWwub3JnPg0KVG86IE1hcnRpbiBLYUZhaSBMYXUgPG1hcnRpbi5sYXVAbGludXguZGV2
Pg0KVG86IEVkdWFyZCBaaW5nZXJtYW4gPGVkZHl6ODdAZ21haWwuY29tPg0KVG86IEt1bWFyIEth
cnRpa2V5YSBEd2l2ZWRpIDxtZW14b3JAZ21haWwuY29tPg0KVG86IFNvbmcgTGl1IDxzb25nQGtl
cm5lbC5vcmc+DQpUbzogWW9uZ2hvbmcgU29uZyA8eW9uZ2hvbmcuc29uZ0BsaW51eC5kZXY+DQpU
bzogSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPg0KVG86IEpvbmF0aGFuIENvcmJldCA8Y29y
YmV0QGx3bi5uZXQ+DQpUbzogU2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4N
CkNjOiBlYnBmQGxpbnV4Zm91bmRhdGlvbi5vcmcNCkNjOiBCYXN0aWVuIEN1cnV0Y2hldCA8YmFz
dGllbi5jdXJ1dGNoZXRAYm9vdGxpbi5jb20+DQpDYzogVGhvbWFzIFBldGF6em9uaSA8dGhvbWFz
LnBldGF6em9uaUBib290bGluLmNvbT4NCkNjOiBicGZAdmdlci5rZXJuZWwub3JnDQpDYzogYnBm
QGlldGYub3JnDQpDYzogbGludXgtZG9jQHZnZXIua2VybmVsLm9yZw0KQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCi0tLQ0KIC4uLi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0
aW9uLXNldC5yc3QgICAgICAgIHwgMjcgKysrKysrKysrKysrKysrLS0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QgYi9E
b2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KaW5k
ZXggMzljNzQ2MTE3NTJiLi5lOGIzMzM3NGJkMDkgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9u
L2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KKysrIGIvRG9jdW1lbnRh
dGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCkBAIC02NjgsNyAr
NjY4LDggQEAgdGhhdCB1c2UgdGhlIGBgQVRPTUlDYGAgbW9kZSBtb2RpZmllciBhcyBmb2xsb3dz
Og0KICAgcGFydCBvZiB0aGUgImF0b21pYzMyIiBjb25mb3JtYW5jZSBncm91cC4NCiAqIGBge0FU
T01JQywgRFcsIFNUWH1gYCBmb3IgNjQtYml0IG9wZXJhdGlvbnMsIHdoaWNoIGFyZQ0KICAgcGFy
dCBvZiB0aGUgImF0b21pYzY0IiBjb25mb3JtYW5jZSBncm91cC4NCi0qIDgtYml0IGFuZCAxNi1i
aXQgd2lkZSBhdG9taWMgb3BlcmF0aW9ucyBhcmUgbm90IHN1cHBvcnRlZC4NCisqIGBge0FUT01J
QywgSCwgU1RYfWBgIChvbmx5IGZvciBMT0FEX0FDUS9TVE9SRV9SRUwpDQorKiBgYHtBVE9NSUMs
IEIsIFNUWH1gYCAob25seSBmb3IgTE9BRF9BQ1EvU1RPUkVfUkVMKQ0KIA0KIFRoZSAnaW1tJyBm
aWVsZCBpcyB1c2VkIHRvIGVuY29kZSB0aGUgYWN0dWFsIGF0b21pYyBvcGVyYXRpb24uDQogU2lt
cGxlIGF0b21pYyBvcGVyYXRpb24gdXNlIGEgc3Vic2V0IG9mIHRoZSB2YWx1ZXMgZGVmaW5lZCB0
byBlbmNvZGUNCkBAIC02OTUsMjIgKzY5NiwyNCBAQCBhcml0aG1ldGljIG9wZXJhdGlvbnMgaW4g
dGhlICdpbW0nIGZpZWxkIHRvIGVuY29kZSB0aGUgYXRvbWljIG9wZXJhdGlvbjoNCiAgICoodTY0
ICopKGRzdCArIG9mZnNldCkgKz0gc3JjDQogDQogSW4gYWRkaXRpb24gdG8gdGhlIHNpbXBsZSBh
dG9taWMgb3BlcmF0aW9ucywgdGhlcmUgYWxzbyBpcyBhIG1vZGlmaWVyIGFuZA0KLXR3byBjb21w
bGV4IGF0b21pYyBvcGVyYXRpb25zOg0KK2ZvdXIgY29tcGxleCBhdG9taWMgb3BlcmF0aW9uczoN
CiANCiAuLiB0YWJsZTo6IENvbXBsZXggYXRvbWljIG9wZXJhdGlvbnMNCiANCiAgID09PT09PT09
PT09ICA9PT09PT09PT09PT09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgIGlt
bSAgICAgICAgICB2YWx1ZSAgICAgICAgICAgICBkZXNjcmlwdGlvbg0KICAgPT09PT09PT09PT0g
ID09PT09PT09PT09PT09PT0gID09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLSAgRkVUQ0gg
ICAgICAgIDB4MDEgICAgICAgICAgICAgIG1vZGlmaWVyOiByZXR1cm4gb2xkIHZhbHVlDQotICBY
Q0hHICAgICAgICAgMHhlMCB8IEZFVENIICAgICAgYXRvbWljIGV4Y2hhbmdlDQotICBDTVBYQ0hH
ICAgICAgMHhmMCB8IEZFVENIICAgICAgYXRvbWljIGNvbXBhcmUgYW5kIGV4Y2hhbmdlDQorICBG
RVRDSCAgICAgICAgMHgwMDAxICAgICAgICAgICAgbW9kaWZpZXI6IHJldHVybiBvbGQgdmFsdWUN
CisgIFhDSEcgICAgICAgICAweDAwZTAgfCBGRVRDSCAgICBhdG9taWMgZXhjaGFuZ2UNCisgIENN
UFhDSEcgICAgICAweDAwZjAgfCBGRVRDSCAgICBhdG9taWMgY29tcGFyZSBhbmQgZXhjaGFuZ2UN
CisgIExPQURfQUNRICAgICAweDAxMDAgICAgICAgICAgICBhdG9taWMgbG9hZCB3aXRoIGJhcnJp
ZXINCisgIFNUT1JFX1JFTCAgICAweDAxMTAgICAgICAgICAgICBhdG9taWMgc3RvcmUgd2l0aCBi
YXJyaWVyDQogICA9PT09PT09PT09PSAgPT09PT09PT09PT09PT09PSAgPT09PT09PT09PT09PT09
PT09PT09PT09PT09DQogDQogVGhlIGBgRkVUQ0hgYCBtb2RpZmllciBpcyBvcHRpb25hbCBmb3Ig
c2ltcGxlIGF0b21pYyBvcGVyYXRpb25zLCBhbmQNCi1hbHdheXMgc2V0IGZvciB0aGUgY29tcGxl
eCBhdG9taWMgb3BlcmF0aW9ucy4gIElmIHRoZSBgYEZFVENIYGAgZmxhZw0KLWlzIHNldCwgdGhl
biB0aGUgb3BlcmF0aW9uIGFsc28gb3ZlcndyaXRlcyBgYHNyY2BgIHdpdGggdGhlIHZhbHVlIHRo
YXQNCi13YXMgaW4gbWVtb3J5IGJlZm9yZSBpdCB3YXMgbW9kaWZpZWQuDQorYWx3YXlzIHNldCBm
b3IgdGhlIGBgWENIR2BgIGFuZCBgYENNUFhDSEdgYCBjb21wbGV4IGF0b21pYyBvcGVyYXRpb25z
LiAgSWYNCit0aGUgYGBGRVRDSGBgIGZsYWcgaXMgc2V0LCB0aGVuIHRoZSBvcGVyYXRpb24gYWxz
byBvdmVyd3JpdGVzIGBgc3JjYGAgd2l0aA0KK3RoZSB2YWx1ZSB0aGF0IHdhcyBpbiBtZW1vcnkg
YmVmb3JlIGl0IHdhcyBtb2RpZmllZC4NCiANCiBUaGUgYGBYQ0hHYGAgb3BlcmF0aW9uIGF0b21p
Y2FsbHkgZXhjaGFuZ2VzIGBgc3JjYGAgd2l0aCB0aGUgdmFsdWUNCiBhZGRyZXNzZWQgYnkgYGBk
c3QgKyBvZmZzZXRgYC4NCkBAIC03MjEsNiArNzI0LDE0IEBAIFRoZSBgYENNUFhDSEdgYCBvcGVy
YXRpb24gYXRvbWljYWxseSBjb21wYXJlcyB0aGUgdmFsdWUgYWRkcmVzc2VkIGJ5DQogdmFsdWUg
dGhhdCB3YXMgYXQgYGBkc3QgKyBvZmZzZXRgYCBiZWZvcmUgdGhlIG9wZXJhdGlvbiBpcyB6ZXJv
LWV4dGVuZGVkDQogYW5kIGxvYWRlZCBiYWNrIHRvIGBgUjBgYC4NCiANCitUaGUgYGBMT0FEX0FD
UWBgIGFuZCBgYFNUT1JFX1JFTGBgIG9wZXJhdGlvbnMgYWxsb3cgdXNpbmcgbGlnaHRlciBsb2Fk
IGFuZA0KK3N0b3JlIG1lbW9yeSBiYXJyaWVycyByYXRoZXIgdGhhbiBmdWxsIGJhcnJpZXJzLiBU
aGUgY29ycmVzcG9uZGluZyBhY2Nlc3Nlcw0KK211c3QgYmUgYWxpZ25lZCwgYnV0IGFyZSBhbGxv
d2VkIGZvciBhbnkgYWNjZXNzIHNpemUgKDgtYml0IHVwIHRvIDY0LWJpdA0KK29wZXJhdGlvbnMp
LCB3aXRoIDgtYml0IGFuZCAxNi1iaXQgYGBMT0FEX0FDUWBgIGxvYWRlZCB2YWx1ZXMgYmVpbmcN
Cit6ZXJvLWV4dGVuZGVkLiBBcyBhdG9taWNzIGFyZSBlbmNvZGVkIGFzIHN0b3JlcywgdGhlIG1l
YW5pbmcgb2YgZHN0IGFuZCBzcmMNCithcmUgZGlmZmVyZW50IGZvciBgYExPQURfQUNRYGAsIGVm
ZmVjdGl2ZWx5IHVzaW5nIHNyYyBhcyBtZW1vcnkgYmFzZWQNCitwb2ludGVyIGFuZCBkc3QgYXMg
ZGVzdGluYXRpb24gcmVnaXN0ZXIgZm9yIHRoZSBmZXRjaGVkIHZhbHVlLg0KKw0KIDY0LWJpdCBp
bW1lZGlhdGUgaW5zdHJ1Y3Rpb25zDQogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAN
Cg0KLS0tDQpiYXNlLWNvbW1pdDogY2VlYjNhYTM3YmZmODk1MTE2OTQ0YWNmNDM0N2ZjZGVkMGI3
NjkyZA0KY2hhbmdlLWlkOiAyMDI2MDUyMC1icGYtaW5zbi1kb2MtNzU2YjM2OWNhMzI4DQoNCkJl
c3QgcmVnYXJkcywNCi0tICANCkFsZXhpcyBMb3Rob3LDqSAoZUJQRiBGb3VuZGF0aW9uKSA8YWxl
eGlzLmxvdGhvcmVAYm9vdGxpbi5jb20+DQoNCi0tIApCcGYgbWFpbGluZyBsaXN0IC0tIGJwZkBp
ZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9y
Zwo=
