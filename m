Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3291F5858
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535095; cv=none; b=ElVr0tAslwfl1d2MRshuj/h2DFW4GtZbX297yhBsubDLdeLTWsw+r8fuB7fkio+O4fxN03Vcd5P1eSexirUy7pQLIJy0xPjK3/koivvELF4SgY310vUFvc2EIwkaWp2WafszZfj/sSiuGDROcC12aSLpfGF3Ml87MugYvDcW8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535095; c=relaxed/simple;
	bh=s7r4p0eogpuGOE5XsfKgQlg3F/1J8/dkXwVrIpTSuDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=P+UjqFBV5vZ7NWAT9z0fgVSEMgHzVDQqTg5S+ITdnH5ut5/daKl1w5HzfbCJaJIV4CRPUFdn8YBuEOKzXqiowjMg2KBRJxacfhZWoOUuP5aKJ2xDwlkx56hD0EQzBvj07ki1P7xUKWCY+jwC1GRjX3ehFPwSlkGvSFk+qIAXIpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.196.136.25])
	by mtasvr (Coremail) with SMTP id _____wA3eKRqETBqrlGkAg--.37357S3;
	Mon, 15 Jun 2026 22:51:22 +0800 (CST)
Received: from ziye$zju.edu.cn ( [10.196.136.25] ) by ajax-webmail-mail-app1
 (Coremail) ; Mon, 15 Jun 2026 22:51:21 +0800 (GMT+08:00)
Date: Mon, 15 Jun 2026 22:51:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5pu55aSp6LWQ?= <ziye@zju.edu.cn>
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	tangyazhou518@outlook.com, shenghaoyuan0928@163.com
Subject: Re: [PATCH bpf-next 1/2] bpf: support shift operations with
 non-const src operand
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <b9b5ce121db4204090adb6fe9a803345735fbfb8.camel@gmail.com>
References: <20260612093818.18609-1-ziye@zju.edu.cn>
 <20260612093818.18609-2-ziye@zju.edu.cn>
 <b9b5ce121db4204090adb6fe9a803345735fbfb8.camel@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6ecb6360.168a4.19ecbc405dc.Coremail.ziye@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yy_KCgCHiqRpETBqfRP8AQ--.28553W
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/1tbiAhMDA2ovBBIjJAADsG
X-CM-DELIVERINFO: =?B?rXZROQXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083j6ToKl9cyaTORebfNb2KBhhnXWgRJGXddvLSor6VIakDeWnYFn92UW0AVV7jMxozjmt
	3tp3wQZX0f+ZoDgoyCVyCTYQW4wxdiYL9g3bCTTDbOp2FbXITzwvKl+5nA84Cg==
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFyDKF13ZF18uw4rZFW5urX_yoWkWFb_uw
	4xK3WUCw40grsxJ3W7AFnxXa1rWr4Dt39xX34vqa1kZ3WSqayDAanY9ryUKF1Iga4xKFZI
	krn0qw1rJr9rZosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbPkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFcxC0VAYjxAxZF0Ew4CEw7xC0wACY4xI67k04243AVC20s07M4II
	rI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4xI67k042
	43AbIYCTnIWIevJa73UjIFyTuYvjxU7-B_UUUUU

T24gNi8xMy8yNiA1OjE3LCBFZHVhcmQgWmluZ2VybWFuIHdyb3RlOgo+IE9uIEZyaSwgMjAyNi0w
Ni0xMiBhdCAxNzozOCArMDgwMCwgVGlhbmNpIENhbyB3cm90ZToKWy4uLl0KPiAKPj4gQEAgLTE0
MzIwLDE0ICsxNDM1MCwzNiBAQCBzdGF0aWMgdm9pZCBzY2FsYXJfbWluX21heF9hcnNoKHN0cnVj
dCBicGZfcmVnX3N0YXRlICpkc3RfcmVnLAo+PiAgIAkJCQlzdHJ1Y3QgYnBmX3JlZ19zdGF0ZSAq
c3JjX3JlZykKPj4gICB7Cj4+ICAgCXU2NCB1bWluX3ZhbCA9IHJlZ191bWluKHNyY19yZWcpOwo+
PiArCXU2NCB1bWF4X3ZhbCA9IHJlZ191bWF4KHNyY19yZWcpOwo+PiArCXM2NCBzbWluID0gcmVn
X3NtaW4oZHN0X3JlZyk7Cj4+ICsJczY0IHNtYXggPSByZWdfc21heChkc3RfcmVnKTsKPiAKPiBO
aXQ6IHRoZSBuYW1pbmcgYmVjb21lcyBjb25mdXNpbmcgd2hlbiByZWFkaW5nICdzbWluID4+IHVt
YXhfdmFsJy4KPiAgICAgICBJJ2QgdXNlIHNvbWV0aGluZyBsaWtlICdzbWluID4+IG1heF9zaGlm
dCcuCkFncmVlZC4gSSB3aWxsIG1ha2UgdGhpcyBjaGFuZ2UgaW4gdjIuCgo+PiAtCS8qIFVwb24g
cmVhY2hpbmcgaGVyZSwgc3JjX2tub3duIGlzIHRydWUgYW5kIHVtYXhfdmFsIGlzIGVxdWFsCj4+
IC0JICogdG8gdW1pbl92YWwuCj4+ICsJLyoKPj4gKwkgKiBCUEZfQVJTSCAoYXJpdGhtZXRpYyBy
aWdodCBzaGlmdCkgb24gNjQtYml0IHJlZ2lzdGVyLgo+PiArCSAqIFNhbWUgdGhyZWUtYnJhbmNo
IGxvZ2ljIGFzIHRoZSAzMi1iaXQgdmFyaWFudCAoc2NhbGFyMzJfbWluX21heF9hcnNoKToKPj4g
KwkgKgo+PiArCSAqICAgc21pbiA+PSAwOiByZXN1bHQgaW4gW3NtYXggPj4gdW1heF92YWwsIHNt
aW4gPj4gdW1pbl92YWxdCj4+ICsJICogICAgICAgICAgICAgIGUuZy4gWzQsOF0gPj4gWzEsMl0g
4oaSIFsxLDRdCj4gCj4gTml0OiBJJ20gbm90IHN1cmUgdGhhdCByZXBlYXRpbmcgdGhlIGNvZGUg
c25pcHBldCBpbiB0aGUgY29tbWVudCBpcyBoZWxwZnVsLCB0YmguCj4gICAgICAgTWF5YmUganVz
dCBoYXZlIGFuIGV4YW1wbGUgZm9yIGVhY2ggY2FzZSBhbmQgZXhwbGFpbiBpdCBpbiB0ZXJtcyBv
ZiBkaXZpZGluZwo+ICAgICAgIGJ5IHNtYWxsZXN0IG9yIGJpZ2dlc3QgZGl2aXNvci4KPiAKCkFn
cmVlZC4gSSB3aWxsIG1vdmUgc29tZSBjb21tZW50cy4KCj4gCj4gWy4uLl0KCgoK

