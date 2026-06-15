Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910E53FD95E
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535131; cv=none; b=oO1WrTpNHYE2gzCbaI/+NqV/RoW9vtvMpgXAT5X8Qtff1QpU/eEDO2DRyblVTTxKMdBs4TmbjN75a0cVSf2SVQ/3Lvi6cUAYPq1LeL4I31FgdY9Ss35ewfQm7g0YA6g6paJmGr5QWzak1wkYNKv/iR/3I0ahDt3DJXpHSw61SMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535131; c=relaxed/simple;
	bh=aTVkq/u6zt6iEd5gCgZVyEehhD2Hiiw+5SzHMCHf/6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Z8EqeY5eXaFg47vrW34aZtm9p+obMpeg1b4v3zDOslrPOo0qZpjpcALIONIPQZc6/6JfeN1f5FeHinoBzf4w9XIy6lu0KnhH8ShoxSs48rzIJT0Izt9JswPwwZP5sOhZzO2OU0FChcCEgNFXvRqmQBWWrhVDLqpDMf/jKOBjDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.196.136.25])
	by mtasvr (Coremail) with SMTP id _____wC3v0ePETBqslKkAg--.11038S3;
	Mon, 15 Jun 2026 22:51:59 +0800 (CST)
Received: from ziye$zju.edu.cn ( [10.196.136.25] ) by ajax-webmail-mail-app1
 (Coremail) ; Mon, 15 Jun 2026 22:51:59 +0800 (GMT+08:00)
Date: Mon, 15 Jun 2026 22:51:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5pu55aSp6LWQ?= <ziye@zju.edu.cn>
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	tangyazhou518@outlook.com, shenghaoyuan0928@163.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for non-const src
 shift
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <2df8605762574ef5a3a93bbd7997649f00cc599c.camel@gmail.com>
References: <20260612093818.18609-1-ziye@zju.edu.cn>
 <20260612093818.18609-3-ziye@zju.edu.cn>
 <2df8605762574ef5a3a93bbd7997649f00cc599c.camel@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7fa682ce.168a6.19ecbc497a0.Coremail.ziye@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yy_KCgBna6WPETBqPBT8AQ--.28795W
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/1tbiAhMDA2ovBBIjJAAEsB
X-CM-DELIVERINFO: =?B?RaFpngXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083j6ToKl9cyaTORebfNb2KBgQ+TAWo2uAWzZD6AMPcy1e4q7WDd4mieD8ZtUh7GrY+NwV
	XThO7pxczIpHAD3MFJLXdWBzE53tS3mqCL5TJySQYD2b815uerPgVPNkif4LOw==
X-Coremail-Antispam: 1Uk129KBj93XoWruw43Aw4rKr13uw4kZry7urX_yoW8Jryfpa
	93Kry5A3yDJF98uF92q3W7XFy5Ars3Z390yF1UKr1ktFWv9w1Ygr4qkrZa9rnxZr4qv34a
	yrykZas8Ww1DGacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUQFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwAC
	I402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJwCE64xvF2IEb7
	IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x07jjQ6JUUUUU=

T24gNi8xMy8yNiA1OjI5LCBFZHVhcmQgWmluZ2VybWFuIHdyb3RlOgo+IE9uIEZyaSwgMjAyNi0w
Ni0xMiBhdCAxNzozOCArMDgwMCwgVGlhbmNpIENhbyB3cm90ZToKPiAKPiBbLi4uXQo+IAo+PiAr
U0VDKCJzb2NrZXQiKQo+PiArX19kZXNjcmlwdGlvbigicHVyZSBib3VuZHMgY2hlY2sgYWZ0ZXIg
bm9uLWNvbnN0IDMyLWJpdCBhcml0aG1ldGljIHJpZ2h0IHNoaWZ0IikKPj4gK19fc3VjY2VzcyBf
X2xvZ19sZXZlbCgyKQo+PiArX19tc2coIncxIHM+Pj0gdzIge3suKn19OyBSMT1zY2FsYXIoc21p
bj11bWluPXVtaW4zMj0weGZmZmZmZmZjLHNtYXg9dW1heD0weGZmZmZmZmZmLHNtaW4zMj0tNCxz
bWF4MzI9LTEsdmFyX29mZj0oMHhmZmZmZmZmYzsgMHgzKSkgUjI9c2NhbGFyKHNtaW49dW1pbj1z
bWluMzI9dW1pbjMyPTEsc21heD11bWF4PXNtYXgzMj11bWF4MzI9NCx2YXJfb2ZmPSgweDA7IDB4
NykpIikKPj4gK19fbmFrZWQgdm9pZCBzaGlmdF93aXRoX25vbl9jb25zdF9zcmNfYXJzaF8zMih2
b2lkKQo+PiArewo+PiArCWFzbSB2b2xhdGlsZSAoIgkJCQkJXAo+PiArCWNhbGwgJVticGZfZ2V0
X3ByYW5kb21fdTMyXTsJCQlcCj4+ICsJdzIgPSB3MDsJCQkJCVwKPj4gKwl3MiAmPSAzOwkJCQkJ
XAo+PiArCXcyICs9IDE7CQkJCQlcCj4+ICsJdzEgPSAtODsJCQkJCVwKPj4gKwl3MSBzPj49IHcy
OwkJCQkJXAo+PiArCWV4aXQ7CQkJCQkJXAo+PiArIgk6OiBfX2ltbShicGZfZ2V0X3ByYW5kb21f
dTMyKQo+PiArCTogX19jbG9iYmVyX2FsbCk7Cj4+ICt9Cj4KPiBJIHRoaW5rIHdlIG5lZWQgdGVz
dCBjYXNlcyBleGVyY2lzaW5nIGFsbCB0aHJlZSBwYXRocyB0aGF0IGNhbiBiZSB0YWtlbiBmb3Ig
YXJzaC4KPiBBbHNvLCBJJ2QgYWRkIGEgdGVzdCBjYXNlIHdpdGggbm9uLWNvbnN0IHNyYyByZWdp
c3RlciB0aGF0IGhpdHMgb3ZlcmZsb3cgbG9naWMgb3IgbHNoIHBhdGguCkFncmVlZC4gSSB3aWxs
IGFkZCB0ZXN0cyBjb3ZlcmluZzoKLSBhcnNoOiBzbWluID49IDAgKGUuZy4gcjEgaW4gWzQsOF0s
IHNoaWZ0IGluIFsxLDRdIC0+IHIxIGluIFsxLDRdKQotIGFyc2g6IHNtYXggPCAgMCAoZS5nLiBy
MSBpbiBbLTgsLTRdLCBzaGlmdCBpbiBbMSw0XSAtPiByMSBpbiBbLTQsLTFdKQotIGFyc2g6IG1p
eGVkICAgICAoZS5nLiByMSBpbiBbLTgsOF0sIHNoaWZ0IGluIFsxLDRdIC0+IHIxIGluIFstNCw0
XSkKLSBsc2gvcnNoL2Fyc2g6ICBub24tY29uc3Qgc3JjIHJlYWNoaW5nIGJpdG5lc3MgYm91bmRh
cnkK

