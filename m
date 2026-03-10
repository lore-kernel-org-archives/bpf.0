Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F9138B7CB
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143699; cv=none; b=sVGqQSIsQVmEoAf96LLMAcOuUqTY3SNRXcWw9zyX207nrzYrKXXhHQlFrkUDwb9Ry2WG1XsXwk8IRCwoKrkxzejF6+xVCtV9DKEhfRoME3ClR8sM5g+foXnnfjtOy+5IMpNlF2EB1ZzRvU8fTAUDJ3oWvG6eHkvwV8GJ2vNi3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143699; c=relaxed/simple;
	bh=NwrFKeZsGphgH1uImf5cIal46lgZGJ+EvMRZf6qCBvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=AUW7+Fplms3VzO+LRp707KbPUO7h6jjyvEqEL0CG/FFwKMkeu36fQrK02n7muIJ2qJWZWKaL79Ftl2PcoFZWYH4o595KZ/+zQPjM4utnUMlYamuOiTBtdFi4VUfwl4va4dStIeAWlAGHS/gyGcRzJWD0vGxQ7BavGhOJxrE/Dng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.98.105])
	by mtasvr (Coremail) with SMTP id _____wBHP2ZrBrBpNgUpAQ--.3025S3;
	Tue, 10 Mar 2026 19:54:20 +0800 (CST)
Received: from tangyazhou$zju.edu.cn ( [10.162.98.105] ) by
 ajax-webmail-mail-app2 (Coremail) ; Tue, 10 Mar 2026 19:54:18 +0800
 (GMT+08:00)
Date: Tue, 10 Mar 2026 19:54:18 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yazhou Tang" <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn,
	glapt.pro@outlook.com
Subject: Re: [PATCH bpf v2 0/2] bpf: Reset register ID for BPF_END value
 tracking
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <20260304083228.142016-1-tangyazhou@zju.edu.cn>
References: <20260304083228.142016-1-tangyazhou@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a4862b0.82304.19cd7991169.Coremail.tangyazhou@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zC_KCgCHMUZqBrBpjFsyBg--.28745W
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgwGCmmvIoomHQAAsT
X-CM-DELIVERINFO: =?B?/3t1kQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9ClO/q6ZOkCasTqtJfKs9+lFqAVkmb8L9N+c/2WwFWNxbif0LERvv8RvYWiQn4AmYf/H
	Dk43/Vp3Y/eRgmm0mOopPm4w1n/RKGnYzHnI9RHy5DoQNbWLyxcSUZklOKRwhQ==
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gr1fAw4rJr17JF47CrW3urX_yoWDJFcEkw
	10qFykWrWqg3WxCFyavF17Zry8CrW2gr13KF4UXF47Ary7Xr1UGrZ5GryrZ34jgFWfXFsr
	Gr1a9asYyr47uosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbPkYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFcxC0VAYjxAxZF0Ew4CEw7xC0wACY4xI67k04243AVC20s07M4II
	rI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4xI67k042
	43AbIYCTnIWIevJa73UjIFyTuYvjxU2jXdDUUUU

SGkgYWxsLAoKSnVzdCBhIGdlbnRsZSBwaW5nIG9uIHRoaXMgcGF0Y2hzZXQuCgpTaW5jZSBpdCBm
aXhlcyBhIHBvdGVudGlhbCBvdXQtb2YtYm91bmRzIGFjY2VzcyBpc3N1ZSBhbmQgYWxyZWFkeSBj
YXJyaWVzIEVkdWFyZCdzIEFja2VkLWJ5LCBJIHdhbnRlZCB0byBjaGVjayBpZiB0aGVyZSBpcyBh
bnl0aGluZyBlbHNlIG5lZWRlZCBmcm9tIG15IHNpZGUsIG9yIGlmIGl0J3MgZ29vZCB0byBnbz8K
ClRoYW5rcywKCllhemhvdQoKCgpPbiAzLzQvMjYgMTY6MzIsIFlhemhvdSBUYW5nIHdyb3RlOgoK
Cgo+IEZyb206IFlhemhvdSBUYW5nIDx0YW5neWF6aG91NTE4QG91dGxvb2suY29tPgo+IAo+IFRo
aXMgcGF0Y2hzZXQgZml4ZXMgYSByZWdpc3RlcidzIHNjYWxhciBJRCBpc3N1ZSBmb3IgQlBGX0VO
RCBvcGVyYXRpb25zCj4gcmVwb3J0ZWQgYnkgR3VpbGxhdW1lIExhcG9ydGUuIFBsZWFzZSBzZWUg
Y29tbWl0IGxvZyBvZiAxLzIgZm9yIG1vcmUgZGV0YWlscy4KPiAKPiAtLS0KPiAKPiBDaGFuZ2Vz
IHYxID0+IHYyOgo+IAo+IDEuIFJlc2V0IHJlZ2lzdGVyIElEIGluc2lkZSBzY2FsYXJfYnl0ZV9z
d2FwKCkgY29uZGl0aW9uYWxseS4gKEVkdWFyZCkKPiAKPiB2MTogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYnBmLzIwMjYwMzAzMDkzOTU2LjM5NTA3Ni0xLXRhbmd5YXpob3VAemp1LmVkdS5jbi8K
PiAKPiBZYXpob3UgVGFuZyAoMik6Cj4gICAgYnBmOiBSZXNldCByZWdpc3RlciBJRCBmb3IgQlBG
X0VORCB2YWx1ZSB0cmFja2luZwo+ICAgIHNlbGZ0ZXN0cy9icGY6IEFkZCB0ZXN0IGZvciBCUEZf
RU5EIHJlZ2lzdGVyIElEIHJlc2V0Cj4gCj4gICBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgNyArKysrKysKPiAgIC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dz
L3ZlcmlmaWVyX2Jzd2FwLmMgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKysKPiAgIDIgZmls
ZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQo+IAoKCgo=

