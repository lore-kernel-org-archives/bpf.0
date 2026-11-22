Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795352239;
	b=q6OlJcpJKNoYnUggFoXKrFDOkV89zV2zZsja/bQkrpsvG+UgamPfm5SiU3EZ495WkIqe
	 e9bmK5QNBNeT2gfeAUDSoI4ncaMnow5d+1wxmuyWmGLeKGw34ETtzFGkopSkE9e69tcea
	 kpy3K6Ed1E3E8dcX4rEwiU7+czfCiukYileN0SjCjxDrnunBPhTHIDKsqH2Eg/e7aPCzq
	 kY4oJKQ5h34Kn/E0PI4BRWtH+mDdVLgSzd8Msipvubdmli3w79lLksOmCpg8Nl3oECMA6
	 bUwm8+7yp48aWncwTFurJ3GLzo991sMSbFlxHetxc3ew9+T+yJSTCp+ZqdV8Rs1VWHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795352239;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=4xHQW/T87LXpAZok/8rPkM87sOXxWyck/eyqw2PC1us=;
	b=avD1VGoBT7Brrgr1XstiIkqoe3izYwv+z1F+PgaBV2jM1Qiy1Xl+Ppn9pDje5mHMFftV
	 yTuLWGmnNY9mHRNlSZmV3cizRsxPAhlE1kTxZSnvfg1akll3BB8kp5ECbK/8320KxpDtR
	 5nvHGo7OdBdFZLsrumm5plZwVMgh37Bf8y8x1rl/8ucGw35HZUkYlQQKZWB6y48rMPHfT
	 RXAYVP08d0ZQqPuat9HnKLgg50zELjKDRI0am9JqLvjWLDHHhyHa5XaZrq7hvTTFNR7B4
	 sc+Yn9cQWRpSs5qZuv/AdD24nKK4GNO1G3WI5zE9Io1djWe7PIHZgtvNoc84dlF29Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FlzmNU4T;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCC606A32A
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 12:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DCC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FlzmNU4T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=4xHQW/T87LXpAZok/8rPkM87sOXxWyck/eyqw2PC1us=; b=F
	lzmNU4TWwvown9AhYeDXE8v98vak01GB7YgkE3e/5SlgA2x3W/h07u1PiFM4IP9N
	ULll2QlTy8VGuakIGurAya5yhYMlodh3WvQ8ubKhSwtzz4L4JaxiqtHwOal22lJp
	tIpG0ln907vuh9oWzfTPTi7Qos9wAI7DF3iRVn0fmQ=
Date: Sun, 22 Nov 2026 20:55:55 +0800 (CST)
From: "Yun Lu" <luyun_611@163.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: Re:Re: [PATCH bpf-next v4 3/6] selftests/bpf: Test task work
 scheduling on a deleted value
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <1b146f18-a7b8-417d-90f3-3b0cdb3f9894@gmail.com>
References: <20261119033051.196177-1-luyun_611@163.com>
 <20261119033051.196177-4-luyun_611@163.com>
 <1b146f18-a7b8-417d-90f3-3b0cdb3f9894@gmail.com>
X-NTES-SC: AL_Qu2SB/+evUku4yaZY+kamU4Ugeo5WMa5s/Um1YBUc+sEmAzswgUKe2dGAmff28u/Mi2ckxO3djpt7cRZRpRDeTDFNtAYx8Ta42nYxz62bg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <27ac2d60.2127.1a20353d5e8.Coremail.luyun_611@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZCgvCgD3Hx9b5gJrEiJzAA--.76W
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6xsr+WsC5lusSgAA3Q
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDI2LTExLTIwIDE5OjEyOjEyLCAiTXlreXRhIFlhdHNlbmtv
IiA8bXlreXRhLnlhdHNlbmtvNUBnbWFpbC5jb20+IHdyb3RlOgo+Cj4KPk9uIDExLzE5LzI2IDM6
MzAgQU0sIFl1biBMdSB3cm90ZToKPj4gRnJvbTogWXVuIEx1IDxsdXl1bkBreWxpbm9zLmNuPgo+
PiAKPj4gQWRkIGEgZGVsZXRlZC12YWx1ZSBjYXNlIHRvIHRhc2tfd29ya19zdHJlc3MuIEEgc3lz
Y2FsbCBwcm9ncmFtIGxvb2tzIHVwCj4+IGEgSEFTSCB2YWx1ZSwgZGVsZXRlcyBpdCBhbmQgc2No
ZWR1bGVzIHRhc2sgd29yayB0aHJvdWdoIHRoZSByZXRhaW5lZAo+PiBwb2ludGVyLiBBc3NlcnQg
dGhhdCBzY2hlZHVsaW5nIHJldHVybnMgLUVOT0VOVDsgcG9zaXRpdmUgc3RlcCBjb2Rlcwo+PiBk
aXN0aW5ndWlzaCBzZXR1cCBmYWlsdXJlcyBmcm9tIHRoZSB1bmZpeGVkIGtlcm5lbCdzIHJldHVy
biB2YWx1ZSBvZiAwLgo+PiAKPj4gUmV1c2UgcHJvY2Vzc193b3JrKCksIHdoaWNoIG9ubHkgY291
bnRzIGNhbGxiYWNrcyBhbmQgZG9lcyBub3QgZGVyZWZlcmVuY2UKPj4gdGhlIG9sZCBrZXkgb3Ig
dmFsdWUuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBZdW4gTHUgPGx1eXVuQGt5bGlub3MuY24+Cj4+
IC0tLQo+PiAgLi4uL2JwZi9wcm9nX3Rlc3RzL3Rhc2tfd29ya19zdHJlc3MuYyAgICAgICAgICB8
IDE4ICsrKysrKysrKysrKysrKysrKwo+PiAgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGFza193
b3JrX3N0cmVzcy5jICAgICB8IDE3ICsrKysrKysrKysrKysrKysrCj4+ICAyIGZpbGVzIGNoYW5n
ZWQsIDM1IGluc2VydGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy90YXNrX3dvcmtfc3RyZXNzLmMgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy90YXNrX3dvcmtfc3RyZXNzLmMKPj4gaW5kZXggNDUw
ZDE3ZDkxYTU2Li45MGQ2ZDY5NjUzN2QgMTAwNjQ0Cj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Rhc2tfd29ya19zdHJlc3MuYwo+PiArKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy90YXNrX3dvcmtfc3RyZXNzLmMKPj4gQEAg
LTEyMSw4ICsxMjEsMjYgQEAgY2xlYW51cDoKPj4gIAl0YXNrX3dvcmtfc3RyZXNzX19kZXN0cm95
KHNrZWwpOwo+PiAgfQo+PiAgCj4+ICtzdGF0aWMgdm9pZCB0YXNrX3dvcmtfZGVsZXRlZCh2b2lk
KQo+PiArewo+PiArCUxJQkJQRl9PUFRTKGJwZl90ZXN0X3J1bl9vcHRzLCBvcHRzKTsKPj4gKwlz
dHJ1Y3QgdGFza193b3JrX3N0cmVzcyAqc2tlbDsKPj4gKwlpbnQgZXJyOwo+PiArCj4+ICsJc2tl
bCA9IHRhc2tfd29ya19zdHJlc3NfX29wZW5fYW5kX2xvYWQoKTsKPj4gKwlpZiAoIUFTU0VSVF9P
S19QVFIoc2tlbCwgIm9wZW5fYW5kX2xvYWQiKSkKPj4gKwkJcmV0dXJuOwo+PiArCWVyciA9IGJw
Zl9wcm9nX3Rlc3RfcnVuX29wdHMoYnBmX3Byb2dyYW1fX2ZkKHNrZWwtPnByb2dzLnNjaGVkdWxl
X2RlbGV0ZWRfdGFza193b3JrKSwKPj4gKwkJCQkgICAgICZvcHRzKTsKPj4gKwlpZiAoQVNTRVJU
X09LKGVyciwgInNjaGVkdWxlX2RlbGV0ZWRfdGFza193b3JrIikpCj4+ICsJCUFTU0VSVF9FUSgo
aW50KW9wdHMucmV0dmFsLCAtRU5PRU5ULCAiZGVsZXRlZCBzY2hlZHVsZSByZWplY3RlZCIpOwo+
PiArCXRhc2tfd29ya19zdHJlc3NfX2Rlc3Ryb3koc2tlbCk7Cj4+ICt9Cj4KPlRoaXMgaXMgbm90
IHJlYWxseSBhIHN0cmVzcyB0ZXN0LCBub3Qgc3VyZSBpZiBpdCdzIGEgZ29vZCBpZGVhIHRvIGhh
dmUgCj5pdCBpbiB0aGlzIGZpbGUuCj5NYXliZSBtb3ZlIHRvIHRoZSB0ZXN0X3Rhc2tfd29yay5j
IGFuZCBkaXRjaCB0aGUgdXNlcnNwYWNlIHBhcnQsIHVzaW5nIAo+X19yZXR2YWwgYW5kIFJVTl9U
RVNUUwpIaSBNeWt5dGEsCgpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBJbiBuZXh0IHZlcnNp
b24odjUpLCBJIHdpbGwgbW92ZSB0aGUKZGVsZXRlZC12YWx1ZSB0ZXN0IHRvIHRhc2tfd29ya19m
YWlsIGFuZCB1c2UgX19yZXR2YWwoLUVOT0VOVCkKd2l0aCB0aGUgZXhpc3RpbmcgUlVOX1RFU1RT
KHRhc2tfd29ya19mYWlsKSBydW5uZXIuIEFuZCByZW1vdmUKdGhlIGRlZGljYXRlZCB1c2Vyc3Bh
Y2Ugd3JhcHBlciBmcm9tIHRhc2tfd29ya19zdHJlc3MuCgotLS0KVGhhbmtzLAoKWXVuIEx1Cgo+
Cj4+ICsKPj4gIHZvaWQgdGVzdF90YXNrX3dvcmtfc3RyZXNzKHZvaWQpCj4+ICB7Cj4+ICsJaWYg
KHRlc3RfX3N0YXJ0X3N1YnRlc3QoImRlbGV0ZWQiKSkKPj4gKwkJdGFza193b3JrX2RlbGV0ZWQo
KTsKPj4gIAlpZiAodGVzdF9fc3RhcnRfc3VidGVzdCgibm9fZGVsZXRlIikpCj4+ICAJCXRhc2tf
d29ya19ydW4oZmFsc2UpOwo+PiAgCWlmICh0ZXN0X19zdGFydF9zdWJ0ZXN0KCJ3aXRoX2RlbGV0
ZSIpKQo+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rh
c2tfd29ya19zdHJlc3MuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90YXNr
X3dvcmtfc3RyZXNzLmMKPj4gaW5kZXggMWQ0Mzc4ZjM1MWVmLi41ZjQ3MTMzYWQzMDggMTAwNjQ0
Cj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90YXNrX3dvcmtfc3Ry
ZXNzLmMKPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rhc2tfd29y
a19zdHJlc3MuYwo+PiBAQCAtNzEsMyArNzEsMjAgQEAgaW50IGRlbGV0ZV90YXNrX3dvcmsodm9p
ZCAqY3R4KQo+PiAgCQlfX3N5bmNfZmV0Y2hfYW5kX2FkZCgmZGVsZXRlX3N1Y2Nlc3MsIDEpOwo+
PiAgCXJldHVybiAwOwo+PiAgfQo+PiArCj4+ICtTRUMoInN5c2NhbGwiKQo+PiAraW50IHNjaGVk
dWxlX2RlbGV0ZWRfdGFza193b3JrKHZvaWQgKmN0eCkKPj4gK3sKPj4gKwlzdHJ1Y3QgZWxlbSBl
bXB0eSA9IHt9LCAqdmFsdWU7Cj4+ICsJaW50IGtleSA9IDA7Cj4+ICsKPj4gKwlpZiAoYnBmX21h
cF91cGRhdGVfZWxlbSgmaG1hcCwgJmtleSwgJmVtcHR5LCBCUEZfTk9FWElTVCkpCj4+ICsJCXJl
dHVybiAxOwo+PiArCXZhbHVlID0gYnBmX21hcF9sb29rdXBfZWxlbSgmaG1hcCwgJmtleSk7Cj4+
ICsJaWYgKCF2YWx1ZSkKPj4gKwkJcmV0dXJuIDI7Cj4+ICsJaWYgKGJwZl9tYXBfZGVsZXRlX2Vs
ZW0oJmhtYXAsICZrZXkpKQo+PiArCQlyZXR1cm4gMzsKPj4gKwlyZXR1cm4gYnBmX3Rhc2tfd29y
a19zY2hlZHVsZV9zaWduYWwoYnBmX2dldF9jdXJyZW50X3Rhc2tfYnRmKCksCj4+ICsJCQkJCSAg
ICAgJnZhbHVlLT50dywgJmhtYXAsIHByb2Nlc3Nfd29yayk7Cj4+ICt9Cj4K
