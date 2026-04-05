Received: from mail2.ietf.org (mail2.ietf.org [166.84.6.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304B136F433
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.6.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775426012; cv=none; b=H6yG6COdF6Df4B/SLDdPx3oE1qEoTLmOua7l+/3aWJubirndi2cUzTvNuKjEDslQNGC/k8JlMqHMwlQUnqPg0765qTfUXWIK6s7lHuq4gMePAhh8MPCbscgjJXuI6MU7IMLUrDr2Ax3ZJCnMmpj3QbPhj6k9qAD89gKUw/zCxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775426012; c=relaxed/simple;
	bh=uG4+H1iE4wzSLAIVZ1JL6vlwLiKs5GaXF1QFKwPLR00=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:CC:
	 Subject:Content-Type; b=cmCs4EOS5BvKaZAeIlPO9o7+Zqmy/w/KJPgSB3RhGJCTtYsS1w3XuMWB1B3OqhxhTIogm0Ur/R7HZG8ia0hmj+2VLsx8Ydwn04UuS1Qt7HH7zpM7SPqVPt2tLDLnaTGGKMYmIpcv1qrDBJ8FBBLVsVyNl7Mt4yyoxhSXVwyA6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=R8HDs0rg; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=HTrQCloW reason="signature verification failed"; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fYH8wH6r reason="signature verification failed"; arc=none smtp.client-ip=166.84.6.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="R8HDs0rg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="HTrQCloW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fYH8wH6r"
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id EE15CD6C8302
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1775425603; bh=uG4+H1iE4wzSLAIVZ1JL6vlwLiKs5GaXF1QFKwPLR00=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=R8HDs0rgOFj9e/DaKZCN30NPNzfkZguDCrbYUSxHS4VffBndTvZ5PLersjeBUA89m
	 ui0z8PG4S2KEIHiTy4OXFr1Q6vel8ktRvIAVErj2ozP2KMDr02ff8c9Oc7LbE+pMJi
	 VAiZ7FFEsp6hym1CbqDqduyF476Se5rVLXWRsUoU=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Sun Apr  5 14:46:43 2026
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id E9517D6C8300
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 14:46:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 0F2D5D6C81C2
	for <bpf@mail2.ietf.org>; Sun,  5 Apr 2026 14:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1775425553; bh=Nuh5W6Dif1FcQuPWLzM1kFOsFdJJQjg6/xAFrToGiIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HTrQCloWzzSD/oYNFLl8KIl5UKV0zCssaZEFA0vmuXrDfLnnGrNdiBDE+39xXUDV+
	 eSGcAhgGldGhcf01/EaDp380HLUEdc8y1HDqaJw0i/fgTS1/yCSL2noB3Jr0ltxRkd
	 2RxOjgbX91bR3wXXPdaI9UCSCWcT+yOl/vEtKSQc=
X-Virus-Scanned: amavisd-new at ietf.org
X-Spam-Flag: NO
X-Spam-Score: -2.799
X-Spam-Level: 
Authentication-Results: mail2.ietf.org (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail2.ietf.org ([166.84.6.31])
	by localhost (mail2.ietf.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T20Csxxxb0MF for <bpf@mail2.ietf.org>;
	Sun,  5 Apr 2026 14:45:52 -0700 (PDT)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail2.ietf.org (Postfix) with ESMTPS id 7C377D6C81BD
	for <bpf@ietf.org>; Sun,  5 Apr 2026 14:45:52 -0700 (PDT)
Message-ID: <8b6c9b74-b132-4746-aced-a1fbb8f71885@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775425544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7Q59gLIjHQtgAVWEvB23qA4/yMcSHSeqQV6Kq7EJTc=;
	b=fYH8wH6rgZ3Mbge8f6SW5uCZomcJpO1AzP5G9yIAhNqEZNSBmYgRJiRdCqVj+sZBAZ7Qcu
	K4ZjDlFVu5QC1SofTViKW9XtlDrW9Ew2k5E+dR/aAsvJ8zfn6nQ+bEkZCpZ2YSxroFlOJY
	gthSI0nQqIVcpa4s1VgDTElg0qm5XVQ=
Date: Sun, 5 Apr 2026 14:45:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20260403164040.73269-1-vineet.gupta@linux.dev>
 <20260403164040.73269-3-vineet.gupta@linux.dev>
 <CAADnVQKOzLwz+V7CNgOYRZ+UykMrR-=OGMg0DjX_NM6B8dSr1g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: 
 <CAADnVQKOzLwz+V7CNgOYRZ+UykMrR-=OGMg0DjX_NM6B8dSr1g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: I5GNGJTAMUNIYLZJFDSJNIBQTY3GMH2E
X-Message-ID-Hash: I5GNGJTAMUNIYLZJFDSJNIBQTY3GMH2E
X-MailFrom: vineet.gupta@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf <bpf@vger.kernel.org>, bpf@gcc.gnu.org,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org, void@manifault.com
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_v3_2/2=5D_bpf=2C_doc=3A_Improve_MOV/MOVSX?=
 =?utf-8?q?_documentation_and_add_examples?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/mDZe7sDcqCy64rFUen0V452AkDM>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Message-ID: <20260405214537.q6dW9Z7pn7bhytPKdDf2Kpm_dmPJ5olHpNifJvgFKZs@z>

DQpPbiA0LzQvMjYgMjA6MzMsIEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToNCj4gT24gRnJpLCBB
cHIgMywgMjAyNiBhdCA5OjQx4oCvQU0gVmluZWV0IEd1cHRhIDx2aW5lZXQuZ3VwdGFAbGludXgu
ZGV2PiB3cm90ZToNCj4+ICAgLSBBZGQgbWlzc2luZyBmb3JtIHtNT1YsIEssIEFMVX0uDQo+Pg0K
Pj4gICAtIEFkZCBzb21lIGFzc2VtYmx5IChwc2V1ZG8tQykgc25pcHBldHMuDQo+Pg0KPj4gICAt
IFJlYXJyYW5nZTogTU9WIGNvbnRlbnQgY29tZXMgYmVmb3JlIE1PVlNYLg0KPj4NCj4+ICAgLSBN
T1ZTWCBjb250ZW50IGl0c2VsZiByZWFycmFuZ2VkOiBjYW5vbmljYWwgc2lnbiBleHRlbnNpb24g
dmFyaWFudA0KPj4gICAgIGZvciB7OCwxNiwzMn0tPiA2NCBtb3ZlZCBhaGVhZCBvZiB0aGUgc3Bl
Y2lhbCB2YXJpYW50IHdoaWNoIG9ubHkNCj4+ICAgICBzaWduIGV4dGVuZHMgdG8gMzIgYW5kIHpl
cm9lcyBvdXQgdGhlIHVwcGVyIGJpdHMuDQo+Pg0KPj4gICAtIFJlbW92ZSB0aGUgaHlwaGVuICct
JyBpbiAic2lnbi1leHRlbnNpb24iIHRvIG1ha2UgZ3JlcCBoaXQgYWxsDQo+PiAgICAgaW5zdGFu
Y2VzIHdpdGggb25lIHBhdHRlcm4uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmluZWV0IEd1cHRh
IDx2aW5lZXQuZ3VwdGFAbGludXguZGV2Pg0KPj4gLS0tDQo+PiBDaGFuZ2VzIHNpbmNlIHYyOg0K
Pj4gICAtIEZpeGVkIFJTVCBtYXJrdXAgZm9yIGFzbSBleGFtcGxlICJ3NSA9IHc5Ig0KPj4gICAt
IEFkZGVkIGFzbSBleGFtcGxlICJ3NSA9IChzOCl3OSIgZm9yIHtNT1ZTWCwgWCwgQUxVfQ0KPj4g
LS0tDQo+PiAgIC4uLi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QgICB8
IDQ5ICsrKysrKysrKysrKysrKy0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlv
bnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCBiL0RvY3VtZW50YXRpb24v
YnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQo+PiBpbmRleCA5NjE4MTU2
NTkwNmYuLjg2M2EwY2MyMmE3NSAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vYnBmL3N0
YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9u
L2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KPj4gQEAgLTQxNCwyNSAr
NDE0LDU0IEBAIGV0Yy4gVGhpcyBzcGVjaWZpY2F0aW9uIHJlcXVpcmVzIHRoYXQgc2lnbmVkIG1v
ZHVsbyBNVVNUIHVzZSB0cnVuY2F0ZWQgZGl2aXNpb24NCj4+DQo+PiAgICAgIGEgJSBuID0gYSAt
IG4gKiB0cnVuYyhhIC8gbikNCj4+DQo+PiAtVGhlIGBgTU9WU1hgYCBpbnN0cnVjdGlvbiBkb2Vz
IGEgbW92ZSBvcGVyYXRpb24gd2l0aCBzaWduIGV4dGVuc2lvbi4NCj4+IC1gYHtNT1ZTWCwgWCwg
QUxVfWBgIDp0ZXJtOmBzaWduIGV4dGVuZHM8U2lnbiBFeHRlbmQ+YCA4LWJpdCBhbmQgMTYtYml0
IG9wZXJhbmRzIGludG8NCj4+IC0zMi1iaXQgb3BlcmFuZHMsIGFuZCB6ZXJvZXMgdGhlIHJlbWFp
bmluZyB1cHBlciAzMiBiaXRzLg0KPj4gLWBge01PVlNYLCBYLCBBTFU2NH1gYCA6dGVybTpgc2ln
biBleHRlbmRzPFNpZ24gRXh0ZW5kPmAgOC1iaXQsIDE2LWJpdCwgYW5kIDMyLWJpdA0KPj4gLW9w
ZXJhbmRzIGludG8gNjQtYml0IG9wZXJhbmRzLiAgVW5saWtlIG90aGVyIGFyaXRobWV0aWMgaW5z
dHJ1Y3Rpb25zLA0KPj4gLWBgTU9WU1hgYCBpcyBvbmx5IGRlZmluZWQgZm9yIHJlZ2lzdGVyIHNv
dXJjZSBvcGVyYW5kcyAoYGBYYGApLg0KPj4gK0ZvciBtb3ZlIG9wZXJhdGlvbnMsIHRoZSBgYE1P
VmBgIGluc3RydWN0aW9uIGhhcyBhIGZldyBkaWZmZXJlbnQgZm9ybXMuDQo+PiArDQo+PiArYGB7
TU9WLCBYLCBBTFU2NH1gYCBtZWFuczo6DQo+PiArDQo+PiArICBkc3QgPSBzcmMNCj4+ICsNCj4+
ICtlLmcuIGBgcjEgPSByMmBgDQo+Pg0KPj4gICBgYHtNT1YsIEssIEFMVTY0fWBgIG1lYW5zOjoN
Cj4+DQo+PiAgICAgZHN0ID0gKHM2NClpbW0NCj4+DQo+PiAtYGB7TU9WLCBYLCBBTFV9YGAgbWVh
bnM6Og0KPj4gK2UuZy4gYGByMSA9IC00YGANCj4+ICsgICAgIGBgcjUgPSA5MjgyMDA5YGANCj4+
ICsNCj4+ICtgYHtNT1YsIEssIEFMVX1gYCBtZWFuczo6DQo+PiArDQo+PiArICBkc3QgPSAodTMy
KWltbQ0KPj4gKw0KPj4gK2UuZy4gYGB3MSA9IC00YGANCj4+ICsgICAgIGBgdzUgPSA3MzAyMDA0
YGANCj4+ICsNCj4+ICtgYHtNT1YsIFgsIEFMVX1gYCBoYXMgemVybyBleHRlbnNpb24gc2VtYW50
aWNzICh1cHBlciAzMiBiaXRzIGFyZSB6ZXJvZWQpOjoNCj4+DQo+PiAgICAgZHN0ID0gKHUzMilz
cmMNCj4+DQo+PiArZS5nLiBgYHc1ID0gdzlgYA0KPj4gKw0KPj4gK1RoZSBgYE1PVlNYYGAgaW5z
dHJ1Y3Rpb24gZG9lcyBhIG1vdmUgb3BlcmF0aW9uIHdpdGggc2lnbiBleHRlbnNpb24gYW5kIGhh
cw0KPj4gK2EgY291cGxlIG9mIGZvcm1zLg0KPj4gKw0KPj4gK2Bge01PVlNYLCBYLCBBTFU2NH1g
YCA6dGVybTpgc2lnbiBleHRlbmRzPFNpZ24gRXh0ZW5kPmAgOC1iaXQsIDE2LWJpdCwgYW5kIDMy
LWJpdA0KPj4gK29wZXJhbmRzIGludG8gNjQtYml0IG9wZXJhbmRzLg0KPj4gKw0KPj4gK2UuZy4g
YGByMSA9IChzOClyMmBgDQo+PiArDQo+PiArVGhlIGBge01PVlNYLCBYLCBBTFV9YGAgZm9ybSBo
YXMgc2xpZ2h0bHkgZGlmZmVyZW50IHNlbWFudGljczogaXQNCj4+ICs6dGVybTpgc2lnbiBleHRl
bmRzPFNpZ24gRXh0ZW5kPmAgOC1iaXQgYW5kIDE2LWJpdCBvcGVyYW5kcyBpbnRvDQo+PiArMzIt
Yml0IG9wZXJhbmRzLCBhbmQgemVyb2VzIHRoZSByZW1haW5pbmcgdXBwZXIgMzIgYml0cyAoc2lt
aWxhciB0byBgYE1PVmBgKS4NCj4gVGhpcyByZWFkcyB0b28gY29udmVyc2F0aW9uYWwuIFRoaXMg
aXMgYSBzcGVjLiBJdCdzIHN1cHBvc2VkIHRvIGJlIGRyeS4NCg0KUGVyaGFwcyB0aGVyZSBpcyBz
b21lIGV4dHJhIGNvbW1lbnRhcnkgaW4gdGhpcyBwYXJ0IHdoaWNoIGNhbiBiZSB0b25lZCBkb3du
Lg0KDQpCdXQgSSB0aGluayB0aGUgYWN0dWFsIGFzbSBleGFtcGxlcyBhcmUgd2FycmFudGVkIGZv
ciwgY29uc2lkZXJpbmcgdGhpcyANCmlzIGFuIElTQSBkb2MuIEp1c3QgY2FwdHVyaW5nIHRoZSBh
YnN0cmFjdCBvcGVyYXRpb25zIGRvZXNuJ3QgZ2l2ZSB0aGUgDQpmdWxsIHBpY3R1cmUsIHNwZWNp
YWxseSBzaW5jZSB0aGlzIGlzIGNvbnNpZGVyZWQgc2luZ2xlIHNvdXJjZSBvZiB0cnV0aCANCmZv
ciB0aGUgSVNBLg0KDQplLmcuIGNvbnNpZGVyIGRzdCA9ICh1MzIpKHMzMikoczgpc3JjDQpJIHRy
aWVkIHRvIGZlZWQgdGhpcyB0byBhc3NlbWJsZXJzLCBidXQgbmVpdGhlciBsbHZtL2dudSBjYW4g
Z3JvayBpdCANCnNpbmNlIHRoZSBhY3R1YWwgaW5zbiBpcyBXTiA9IChzOCl3TQ0KDQo+IE92ZXJh
bGwgSSdtIG5vdCBzdXJlIGl0J3MgYW4gaW1wcm92ZW1lbnQuDQo+IE9ubHkgKE1PViwgSywgQUxV
KSB3b3J0aCBhZGRpbmcuDQo+IFBsZWFzZSBjYyBEYXZpZCBWZXJuZXQgaW4gdGhlIGZ1dHVyZSBw
YXRjaGVzIGFuZCBicGYgQCBpZXRmLg0KPg0KPiBJIGZlZWwgdGhhdCBib3RoIHBhdGNoZXMgYXJl
IHdpa2kgb3IgZmFxIG1hdGVyaWFsIHRoYW4gSUVURiBzcGVjLg0KDQpUaHgsDQotVmluZWV0DQoN
Ci0tIApCcGYgbWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=
