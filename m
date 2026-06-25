Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70119C54E
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354281; cv=none; b=Qqgr/GOxNsAU6lHBaHS2d6SsIFqseTJFiUPr+UiBapKumlihSXjTgg9IlHQ0Y5vD1Wu3kK9XcNSuf01JkVGdmBIbSaXvvKL8xPLbT7s3TGgKcWyUxs+/Y+cmeGPUxKN+7vl16T3LGVzMTN+6MrHEaYT7Z8iOfZC5x7E0NUjsibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354281; c=relaxed/simple;
	bh=mpSudVXv29bchl6BkISiq7/mrsz2U3ZD/3HwOLpk9xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=XpKckE6g6v02ChBeJC7dr3IOsetkgDfO71xCqd+8Vdyn9NwtrW+0RwGro4sR4kJKpAZ6acdz1ONSo7iYLqA5K+zE2/Eow7/8HY2GHTY5xbKZ84MrIh1gVYneboADhPqQ9U/pENxm8uGm+tewJOklZ1TVhh6gbIPTFUWWqDB80ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mkvLKn2r; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mkvLKn2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=mpSudVXv29bchl6BkISiq7/mrsz2U3ZD/3HwOLpk9xA=; b=m
	kvLKn2rfzxA9dCBs2LupkcKEBUU/G+ArsY9kPOn4xc1Arjm+PQD2M5QfGWwLxap1
	/m0oa1rDplmnxaYZX5wOXdj1sEbyowx7lh3TXgqkk75rtmNcL1eBVJgq20AVeZV+
	1sYPqvdc1wjKzTSTlro4ngstxQJooIcSECk6pR0oA8=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Thu, 25 Jun 2026 10:24:12 +0800
 (CST)
Date: Thu, 25 Jun 2026 10:24:12 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, bpf@vger.kernel.org,
	"Tang Longjun" <tanglongjun@kylinos.cn>
Subject: Re:Re: [PATCH bpf-next v2 0/5] bpf: add bpf_memcmp and bpf_strpbrk
 kfuncs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <DJHKZQ8DHCW5.QCBIXNEWDLEC@gmail.com>
References: <20260624093638.117062-1-lange_tang@163.com>
 <DJHKZQ8DHCW5.QCBIXNEWDLEC@gmail.com>
X-NTES-SC: AL_Qu2TAP+eu0ou5CaZYukcn08QhOo9Wsu0v/0u1YRQc+EEshDr4y0QV25BGnT54MK0KSOwoAO0WwNQ+tpZYKtfQWeB/IX62KI5+RascRaz5w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <59efbf7b.22b2.19efc979350.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aigvCgD3X2FNkTxqx3sQAA--.588W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4Q0hT2o8kU1Q1QAA3N
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wNi0yNSAwNTowMTo0MSwgIkFsZXhlaSBTdGFyb3ZvaXRvdiIgPGFsZXhlaS5zdGFy
b3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOgo+T24gV2VkIEp1biAyNCwgMjAyNiBhdCAyOjM2IEFN
IFBEVCwgTG9uZ2p1biBUYW5nIHdyb3RlOgo+PiBGcm9tOiBMb25nanVuIFRhbmcgPHRhbmdsb25n
anVuQGt5bGlub3MuY24+Cj4+Cj4+IFRoaXMgc2VyaWVzIGFkZHMgdHdvIG5ldyBCUEYga2Z1bmNz
IHRvIGtlcm5lbC9icGYvaGVscGVycy5jLgo+Pgo+PiA9PT0gYnBmX21lbWNtcCgpID09PQo+Pgo+
PiBCUEYgcHJvZ3JhbXMgZnJlcXVlbnRseSBuZWVkIHRvIGNvbXBhcmUgcmF3IGJpbmFyeSBidWZm
ZXJzLCBzdWNoIGFzOgo+PiAtIE1BQyBhZGRyZXNzZXMgKDYgYnl0ZXMpIGluIFhEUC9UQyBmb3Ig
TDIgZmlsdGVyaW5nIGFuZCBmb3J3YXJkaW5nOwo+PiAtIFVVSURzICgxNiBieXRlcykgYW5kIGhh
c2ggZGlnZXN0cyBmb3IgYWxsb3dsaXN0L2RlbnlsaXN0IHBvbGljaWVzOwo+Pgo+PiBDdXJyZW50
bHkgdGhlcmUgaXMgbm8gc2FmZSB3YXkgdG8gZG8gdGhpcyChqiBicGZfc3RybmNtcCAoaGVscGVy
KSBzdG9wcwo+PiBhdCBudWxsIGJ5dGVzIHdoaWNoIGNvcnJ1cHRzIGJpbmFyeSBkYXRhLCBhbmQg
aGFuZC1yb2xsZWQgbG9vcHMgYXJlCj4+IGZyYWdpbGUgd2l0aCB0aGUgdmVyaWZpZXIgKGFzIGV2
aWRlbmNlZCBieSB0aGUgbG9jYWxfbWVtY21wKCkgd29ya2Fyb3VuZAo+PiBpbiBzZWxmdGVzdHMv
YnBmL3Byb2dzL2R5bnB0cl9zdWNjZXNzLmMpLiBfX2J1aWx0aW5fbWVtY21wIG1heSB3b3JrIGlu
Cj4+IHNvbWUgY2FzZXMgYnV0IGlzIG5vdCB2ZXJpZmllci1zYWZlIGZvciBhcmJpdHJhcnkga2Vy
bmVsIG1lbW9yeS4KPgo+SGFuZCByb2xsZWQgbG9vcHMgd2VyZSBmcmFnaWxlIGluIHRoZSBwYXN0
LCBidXQgbm90IGFueSBtb3JlLgo+V2l0aCBicGZfZm9yKCkgYW5kIG1heV9nb3RvL2Nhbl9sb29w
IHRoZSBsb29wcyBjYW4gYmUgbGFyZ2UuCj5Gb3IgTUFDIGFuZCBVVUlEcyBldmVuIG9sZCB2ZXJp
ZmllcnMgY2FuIGRlYWwganVzdCB3aXRoIHdpdGggImJvdW5kZWQgbG9vcCIuCj4KPlNvcnJ5LCBi
dXQgSSBkb24ndCBzZWUgYSBodW1hbiBkcml2ZW4gbW90aXZhdGlvbiBpbiB0aGlzIHBhdGNoLgo+
TG9va3MgbGlrZSBBSSBmbGFnZ2VkIHNvbWV0aGluZyBhbmQgQUkgc2xvcGVkIGEgcGF0Y2ggaW4g
cmVzcG9uc2UuCgpBcG9sb2dpZXMsIHNvbWUgb2YgdGhlIGNvbnRlbnQsIGluY2x1ZGluZyB0aGUg
Y292ZXIgbGV0dGVyLCB3YXMgaW5kZWVkIEFJLWdlbmVyYXRlZC4KVGhlIG1lbWNtcCBzdWJtaXR0
ZWQgaGVyZSBtYXkgbm90IGJlIHN0cmljdGx5IG5lY2Vzc2FyeSwgYnV0IGl0IGNhbiBhdm9pZCBo
YW5kIHJvbGxlZCBsb29wcyBmb3IKc2NlbmFyaW9zIGxpa2UgY29tcGFyaW5nIE1BQyBvciBVVUlE
cy4KPgo+cHctYm90OiBjcgo=
