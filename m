Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1303FC5D0
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535016; cv=none; b=LWYOmup0TelSh8H6QWdYKQHPAranssw80RKMnALpI+u85oMXZusEHvz+Txymlz7SEcHohMr1Pb2q6tFE6wDU5ZVMXTkdK79dwjPRQ9S9kJs9wiqCHsMYdBlmj7fysDcKgqUpQEVMS4JBbPDcmnczYGfYW2E+OPkzMHF6M4b+lj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535016; c=relaxed/simple;
	bh=jsI3cHn0QT/Y56ELPcWLBraDzt5JvgcgWuvALC2nNAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=cfL/RAck43LNICx/Md8J/Evg0KqiyZxT6A4CFEiCqAVzMY8tjideVV3NnFYmpamALS6U0wf++QM7UJEQwHhYtK1mYiMbBkjZMZYBOLg/upLaRjNXmm+ZBHnbpRDHL/JYt0f6Safuqwxg/MywLz8KrqDo9DUQXR+Orc7nE7/LVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.196.136.25])
	by mtasvr (Coremail) with SMTP id _____wDn7aUgETBqb0+kAg--.10637S3;
	Mon, 15 Jun 2026 22:50:08 +0800 (CST)
Received: from ziye$zju.edu.cn ( [10.196.136.25] ) by ajax-webmail-mail-app1
 (Coremail) ; Mon, 15 Jun 2026 22:50:08 +0800 (GMT+08:00)
Date: Mon, 15 Jun 2026 22:50:08 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5pu55aSp6LWQ?= <ziye@zju.edu.cn>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com
Subject: Re: [PATCH bpf-next 1/2] bpf: support shift operations with
 non-const src operand
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <DJ7793EEL4P5.1HFCXFENJM2VT@gmail.com>
References: <20260612093818.18609-1-ziye@zju.edu.cn>
 <20260612093818.18609-2-ziye@zju.edu.cn>
 <DJ7793EEL4P5.1HFCXFENJM2VT@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <34e0414b.168a1.19ecbc2e50a.Coremail.ziye@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yy_KCgDHFp8gETBqLhL8AQ--.28761W
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/1tbiAhMDA2ovBBIjJAACsH
X-CM-DELIVERINFO: =?B?FaeWJQXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083j6ToKl9cyaTORebfNb2KBhEp0CW0ylEv4lTciiwL9LacTjOBoHGZasXraY1We1Ezvg/
	i97rBcWmyJ1c8zuvuWdZB4yYrc0GW75pkNDDePQKFUC00p/VNXtOaOv/n+rntw==
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar43Wr45XrWrtFy7Xr1rXwc_yoW8XFWxpr
	yfKwn7W3WvyrWv9w1xAF45JrWUZrs7CayYqF95XFnrAFn0q3W3XrWfKFyY9ay7Xrs2yw42
	qrWIqa4Du3W8AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUQYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwAC
	I402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0VAYjx
	AxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU1Kii3UUUUU==

T24gNi8xMi8yNiA5OjA5LCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3JvdGU6Cj4gT24gRnJpIEp1biAx
MiwgMjAyNiBhdCAyOjM4IEFNIFBEVCwgVGlhbmNpIENhbyB3cm90ZToKPiA+IEN1cnJlbnRseSwg
dGhlIEJQRiB2ZXJpZmllciBvbmx5IGFsbG93cyBzaGlmdCBvcGVyYXRpb25zIHdoZW4gdGhlIHNo
aWZ0Cj4gPiBhbW91bnQgaXMgYSBrbm93biBjb25zdGFudC4gVGhpcyBpcyBvdmVybHkgcmVzdHJp
Y3RpdmUgZm9yIGNhc2VzIHdoZXJlCj4gPiB0aGUgc2hpZnQgYW1vdW50IGlzIGJvdW5kZWQgYnV0
IG5vdCBmdWxseSBkZXRlcm1pbmVkIGF0IHZlcmlmaWNhdGlvbiB0aW1lLgo+ID4gRm9yIGV4YW1w
bGUsIHRoZSBmb2xsb3dpbmcgY29kZSBpcyByZWplY3RlZCBieSB0aGUgdmVyaWZpZXIgZXZlbiB0
aG91Z2gKPiA+IHRoZSBzaGlmdCBhbW91bnQgaXMgYm91bmRlZCB0byBbMSwgNF06Cj4gPgo+ID4g
ICAgIHUzMiBzaGlmdCA9IGJwZl9nZXRfcHJhbmRvbV91MzIoKTsKPiA+ICAgICBzaGlmdCAmPSAz
OyAgICAvLyBzaGlmdCBpcyBpbiByYW5nZSBbMCwgM10KPiA+ICAgICBzaGlmdCArPSAxOyAgICAv
LyBzaGlmdCBpcyBpbiByYW5nZSBbMSwgNF0KPiA+ICAgICByMSA8PD0gc2hpZnQ7ICAvLyBub24t
Y29uc3QgYnV0IGJvdW5kZWQgc2hpZnQgYW1vdW50Cj4KPiBSZWplY3RlZD8gSSBkb24ndCBiZWxp
ZXZlIHNvLiBUaGUgdmVyaWZpZXIgYWNjZXB0cyBpdCwgYnV0IGZhbGxzCj4gYmFjayB0byBjb25z
ZXJ2YXRpdmUuCgpSaWdodCwgSSBzaG91bGQgaGF2ZSBzYWlkICJmYWxscyBiYWNrIHRvIGNvbnNl
cnZhdGl2ZSIuIFRoZSBkc3QKcmVnaXN0ZXIganVzdCBiZWNvbWVzIHVua25vd24uIFNvcnJ5IGZv
ciB0aGUgY29uZnVzaW9uLgoKPiBXaGF0IHRoaXMgaXMgZm9yPwo+IERvIHlvdSBzZWUgc3VjaCBj
b2RlIGdlbmVyYXRlZCBieSBjb21waWxlciBpbiByZWFsIHByb2dyYW1zPwo+IERvZXMgaXQgY2F1
c2UgaXNzdWVzIHdpdGggYWNjZXB0aW5nIHN1Y2ggX3JlYWxfIHByb2dyYW1zID8KPgo+IElmIG5v
dCwgc29ycnksIHdlIHNob3VsZCBub3QgY29tcGxpY2F0ZSB0aGUgdmVyaWZpZXIgZm9yIHRoZW9y
ZXRpY2FsIGNhc2UuClRoZSBtb3RpdmF0aW9uIGhlcmUgaXMgcHVyZWx5IGFib3V0IHJlbGF4aW5n
IGFuIG92ZXJseQpzdHJpY3QgY2hlY2sgaW4gdGhlIHZlcmlmaWVyLiBJbiBvdXIgb3Bpbmlvbiwg
dGhlICJzaGlmdCBhbW91bnQgbXVzdApiZSBmdWxseSBjb25zdGFudCIgcnVsZSBpcyBtb3JlIGNv
bnNlcnZhdGl2ZSB0aGFuIG5lY2Vzc2FyeS4KVGhlIHZlcmlmaWVyIGFscmVhZHkgdHJhY2tzIFt1
bWluLCB1bWF4XSBmb3IgdGhlIHNyYyByZWdpc3RlciwKYW5kIGEgYm91bmRlZC1idXQtbm9uLWNv
bnN0IHNoaWZ0IGNhbiBiZSBoYW5kbGVkIHNvdW5kbHkgd2l0aCB2ZXJ5CnNpbXBsZSBsb2dpYy4g
VGhlIHBhdGNoIGV4dGVuZHMgdGhlIGV4aXN0aW5nIHNjYWxhcl9taW5fbWF4XyoKaGVscGVycyB0
byB0YWtlIGFkdmFudGFnZSBvZiB0aGlzLiBIYXBweSB0byBoZWFyIG90aGVyIHRob3VnaHRzCm9u
IHdoZXRoZXIgdGhpcyBpcyB3b3J0aCBsYW5kaW5nLgoKCgo=

