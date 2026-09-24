Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E78C4078C0
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244015; cv=none; b=kSTzrRDfFhLG95rYzYJtHtXJ1Z0abTxJSB/wZ+du/nJpGCQleGsiNNkVzw5UDvZmmrJtpY9FYvygDx0qKlMJ6YKiMYIPLJVbh0n3555g7nnCG/WS6y7qTzM9pOj/Wph7hl7JTpuz2Dc16654J/IhR4xAUu4fx5awed0JKjkb4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244015; c=relaxed/simple;
	bh=he1OUgcYO6WkvuDtjG/NbRZFIZrry1JMZz4DuaDTaO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=CN2WjJ53yp0RY9OuNUB8DX/PgOn0ZzEVzneIHp97PBRJ1+jugsOYkttBYX+hncVze+ZJqXQI/AFveGkPZxhh+68vV7uNs7N6RiX2R++n913p5gOZYvp9qzJ7gsZ453/5u+gavJTkoxvxUxgZN1IVw5vkWKhQPnlqwWb0uz26+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pMLNjKtk; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pMLNjKtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=he1OUgcYO6WkvuDtjG/NbRZFIZrry1JMZz4DuaDTaO0=; b=p
	MLNjKtk2vaRoSyQqUkqpE6OofayJGvCtmUhan6BI1Jk5WmHhIUxnTAb7DAOj3928
	lIpcNQyo/cRGqGNq1PRe/+xFRKaEJ+PDHRLEC26X07ZHswMjzzB2kqKi2co0FMuT
	/g62/PPK3sdeNhTfXB18vntyfpwNoQkYpVdjR/bO9w=
Date: Thu, 24 Sep 2026 17:58:57 +0800 (CST)
From: chenyuan  <chenyuan_fl@163.com>
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: alexei.starovoitov@gmail.com, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, martin.lau@linux.dev, yonghong.song@linux.dev,
	john.fastabend@gmail.com, song@kernel.org, ihor.solodrai@linux.dev,
	"Yuan Chen" <chenyuan@kylinos.cn>
Subject: Re:Re: [PATCH bpf-next v2 1/2] bpf: Keep target extended until its
 last freplace link detaches
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <d3e65c94-45d9-4c67-a276-103c5e7fa052@linux.dev>
References: <20260924023737.1140521-1-chenyuan_fl@163.com>
 <20260924023737.1140521-2-chenyuan_fl@163.com>
 <d3e65c94-45d9-4c67-a276-103c5e7fa052@linux.dev>
X-NTES-SC: AL_Qu2SAv6fvEEo4SCYZ+kdnUYWg+8/X8W3svwi2YVUc+IEtxnL6zE7XnpIHWHm19KtCjiRuxSSfDtq1OtecKd/xaJ2qpmfEt8YF+4V+CBiqA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4669addf.91e8.1a0d2da9b9c.Coremail.chenyuan_fl@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bSgvCgDX30Zh9LRqOqZOAA--.8613W
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5gEd2mq09GFwgQAA3a
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

ClRoYW5rcyBmb3IgdGhlIHJldmlldy4gVGhpcyBpcyBhIHByZS1leGlzdGluZyBidWcgaW4gdGhl
IGxpbmsgcGF0aCwgbm90IGludHJvZHVjZWQgYnkgdGhpcyBwYXRjaC4gSSdsbCBzZW5kIGEKc2Vw
YXJhdGUgZml4IGZvciB0aGUgcm9sbGJhY2sgbGF0ZXIuIFRoaXMgcGF0Y2ggc3RheXMgZm9jdXNl
ZCBvbiB0aGUgaXNfZXh0ZW5kZWQgY291bnRpbmcuCgoKCgoKCgoKCgoKCgpBdCAyMDI2LTA5LTI0
IDE1OjA2OjE2LCAiTGVvbiBId2FuZyIgPGxlb24uaHdhbmdAbGludXguZGV2PiB3cm90ZToKPk9u
IDI0LzkvMjYgMTA6MzcsIGNoZW55dWFuX2ZsQDE2My5jb20gd3JvdGU6Cj4+IEZyb206IFl1YW4g
Q2hlbiA8Y2hlbnl1YW5Aa3lsaW5vcy5jbj4KPj4gCj4+IFRoZSBpc19leHRlbmRlZCAvIHByb2df
YXJyYXlfbWVtYmVyX2NudCBwcm90b2NvbCBpbnRyb2R1Y2VkIGJ5IGNvbW1pdAo+PiBkNjA4M2Yw
NDBkNWQgKCJicGY6IFByZXZlbnQgdGFpbGNhbGwgaW5maW5pdGUgbG9vcCBjYXVzZWQgYnkgZnJl
cGxhY2UiKQo+PiBrZWVwcyBhIHByb2cgZXh0ZW5kZWQgYnkgYSBmcmVwbGFjZSBwcm9ncmFtIG91
dCBvZiBwcm9nX2FycmF5IG1hcHMsIGFuZAo+PiB2aWNlIHZlcnNhOiBvbmNlIGEgdGFpbCBjYWxs
IHJlLWVudGVycyBhbiBleHRlbmRlZCBzdWJwcm9ncmFtLCBpdHMKPj4gdGFpbF9jYWxsX2NudCBy
ZXNldHMgb24gZXZlcnkgZXhlY3V0aW9uIGFuZCB0aGUgbG9vcCBuZXZlciB0ZXJtaW5hdGVzLgo+
PiAKPj4gQnV0IGlzX2V4dGVuZGVkIGlzIGEgcGxhaW4gYm9vbGVhbiwgd2hpbGUgb25lIHRhcmdl
dCBwcm9nIGNhbiBjYXJyeQo+PiBzZXZlcmFsIGZyZXBsYWNlIGxpbmtzIGF0IHRoZSBzYW1lIHRp
bWUsIG9uZSBvbiBpdHMgZW50cnkgYW5kIG9uZSBvbiBhCj4+IGdsb2JhbCBzdWJwcm9ncmFtLiAg
X19icGZfdHJhbXBvbGluZV91bmxpbmtfcHJvZygpIGNsZWFyZWQgaXNfZXh0ZW5kZWQKPj4gd2hl
bmV2ZXIgKmFueSogZnJlcGxhY2UgbGluayBkZXRhY2hlZCwgc28gZGV0YWNoaW5nIG9uZSBvZiB0
d28gbGlua3MKPj4gcmUtYXJtZWQgdGhlIHVuYm91bmRlZCBsb29wIHRocm91Z2ggdGhlIHJlbWFp
bmluZyBvbmUuCj4KPkEgcHJvZyBtYXkgaGF2ZSBtdWx0aXBsZSBnbG9iYWwgc3VicHJvZ3MuIEFu
ZCBlYWNoIG9mIHRoZSBzdWJwcm9ncyBjYW4KPmJlIGF0dGFjaGVkIHdpdGggZnJlcGxhY2UgcHJv
Zy4gV2hlbiBhbGwgdGhlIHN1YnByb2dzIGFyZSBhdHRhY2hlZCB3aXRoCj5mcmVwbGFjZSBwcm9n
cyB0aGVuIGRldGFjaCBvbmUgb2YgdGhlIGZyZXBsYWNlIHByb2csIHRoZSAqaXNfZXh0ZW5kZWQq
Cj5iZWNvbWVzICpmYWxzZSosIHdoaWNoIHJlbGF4ZXMgdGhlIHJlc3RyaWN0aW9uIGJldHdlZW4g
dGFpbGNhbGwgYW5kCj5mcmVwbGFjZSBpbnRyb2R1Y2VkIGJ5IHRoZSBjb21taXQgZDYwODNmMDQw
ZDVkICgiYnBmOiBQcmV2ZW50IHRhaWxjYWxsCj5pbmZpbml0ZSBsb29wIGNhdXNlZCBieSBmcmVw
bGFjZSIpLgo+Cj4+IAo+PiBSZXBsYWNlIHRoZSBpc19leHRlbmRlZCBib29sZWFuIHdpdGggYSBj
b3VudCBvZiB0aGUgZnJlcGxhY2UgbGlua3MKPj4gYXR0YWNoZWQgdG8gZWFjaCB0YXJnZXQgcHJv
Zywgc28gdGhlIHRhcmdldCBzdGF5cyBleHRlbmRlZCB1bnRpbCBpdHMKPj4gbGFzdCBsaW5rIGRl
dGFjaGVzLiAgQWxzbyByZW5hbWUgYnBmX2ZyZXBsYWNlX2NoZWNrX3RndF9wcm9nKCkgdG8KPj4g
YnBmX2ZyZXBsYWNlX2xpbmtfdGd0X3Byb2coKSwgYXMgdGhlIGhlbHBlciBoYXMgbmV2ZXIgYmVl
biBhIHB1cmUKPj4gY2hlY2s6IGl0IHJlc2VydmVzIHRoZSB0YXJnZXQgcHJvZyBvbiBzdWNjZXNz
Lgo+PiAKPj4gRml4ZXM6IGQ2MDgzZjA0MGQ1ZCAoImJwZjogUHJldmVudCB0YWlsY2FsbCBpbmZp
bml0ZSBsb29wIGNhdXNlZCBieSBmcmVwbGFjZSIpCj4+IFNpZ25lZC1vZmYtYnk6IFl1YW4gQ2hl
biA8Y2hlbnl1YW5Aa3lsaW5vcy5jbj4KPj4gCj4KPlsuLi5dCj4KPj4gQEAgLTkzMyw3ICs5MzMs
NyBAQCBzdGF0aWMgaW50IF9fYnBmX3RyYW1wb2xpbmVfbGlua19wcm9nKHN0cnVjdCBicGZfdHJh
bXBfbm9kZSAqbm9kZSwKPj4gIAkJLyogQ2Fubm90IGF0dGFjaCBleHRlbnNpb24gaWYgZmVudHJ5
L2ZleGl0IGFyZSBpbiB1c2UuICovCj4+ICAJCWlmIChjbnQpCj4+ICAJCQlyZXR1cm4gLUVCVVNZ
Owo+PiAtCQllcnIgPSBicGZfZnJlcGxhY2VfY2hlY2tfdGd0X3Byb2codGd0X3Byb2cpOwo+PiAr
CQllcnIgPSBicGZfZnJlcGxhY2VfbGlua190Z3RfcHJvZyh0Z3RfcHJvZyk7Cj4+ICAJCWlmIChl
cnIpCj4+ICAJCQlyZXR1cm4gZXJyOwo+PiAgCQl0ci0+ZXh0ZW5zaW9uX3Byb2cgPSBub2RlLT5s
aW5rLT5wcm9nOwo+Cj4gICAgICAgICAgICAgICAgcmV0dXJuIGJwZl9hcmNoX3RleHRfcG9rZSh0
ci0+ZnVuYy5hZGRyLCBCUEZfTU9EX05PUCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEJQRl9NT0RfSlVNUCwgTlVMTCwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG5vZGUtPmxpbmstPnByb2ctPmJwZl9mdW5jKTsKPgo+Cj5JIHRo
aW5rIHRoZXJlIGFyZSBleGlzdGluZyBpc3N1ZXMgaGVyZTogaWYgYnBmX2FyY2hfdGV4dF9wb2tl
KCkgcmV0dXJucwo+ZXJyb3IsIHRoZSB0ci0+ZXh0ZW5zaW9uX3Byb2cgYW5kIGF1eC0+ZnJlcGxh
Y2VfbGlua19jbnQgc2hvdWxkIGJlCj5yb2xsYmFja2VkLgo+Cj5UaGFua3MsCj5MZW9uCj4KPj4g
QEAgLTk3OSw3ICs5NzksNyBAQCBzdGF0aWMgaW50IF9fYnBmX3RyYW1wb2xpbmVfdW5saW5rX3By
b2coc3RydWN0IGJwZl90cmFtcF9ub2RlICpub2RlLAo+PiAgCQkJCQkgdHItPmV4dGVuc2lvbl9w
cm9nLT5icGZfZnVuYywgTlVMTCk7Cj4+ICAJCXRyLT5leHRlbnNpb25fcHJvZyA9IE5VTEw7Cj4+
ICAJCWd1YXJkKG11dGV4KSgmdGd0X3Byb2ctPmF1eC0+ZXh0X211dGV4KTsKPj4gLQkJdGd0X3By
b2ctPmF1eC0+aXNfZXh0ZW5kZWQgPSBmYWxzZTsKPj4gKwkJdGd0X3Byb2ctPmF1eC0+ZnJlcGxh
Y2VfbGlua19jbnQtLTsKPj4gIAkJcmV0dXJuIGVycjsKPj4gIAl9Cj4+ICAJYnBmX3RyYW1wb2xp
bmVfcmVtb3ZlX3Byb2codHIsIG5vZGUpOwo=
