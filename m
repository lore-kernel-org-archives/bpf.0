Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0061485934;
	Mon, 28 Sep 2026 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586560; cv=none; b=m5he/nPAnTzd9vAKVhbtac5pOGL+NYlVCteCCMUrRnBWcwD+9MGbfPeRGTxDa0ZD7xCYOyZcmxgiJaKF824fgOMRgf2btd9Ag+Sfde86SQ9q2ZbGewN2CkSgtWs8dxwbW0KvNCouXOERZbOtYPPJzgiFmGM/haFJAJU0AeI4vlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586560; c=relaxed/simple;
	bh=1CHtrpq+frNOoLssI0kZZ/Blr9NHUn+Ls7VEG3RkKmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=KBZEEWhyqP05Neh8+j5aKgbN3JupGzCYfKhCc0bzjMT7ehGBCiWVdtUIZfODb3dGaw8U7SZecEeij7wJnMo7cz4wyJ+Iq8wwxGI5wLFg0KrqgRoT4QOoOBJuigmV1XCxwEOlFrVaFBvzlsFO6aqD+DJavtxBeYJdXrpbF/ogJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AbQejhnE; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AbQejhnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=1CHtrpq+frNOoLssI0kZZ/Blr9NHUn+Ls7VEG3RkKmI=; b=A
	bQejhnE3mt7Gka0KheoqPNimkk1p5I8laO7bkeYiKX73XbhsEa7L0SFipHD+9tpC
	O90kgPToonMdbWuDarz2AgBJlbuR+NGqHA2Gmd3AQKdgdzMGQnGjpU0ZPVyN/1eZ
	mNXHLvLC7jUK/0kFSB8/st4yRKQ+6Fwj4gxu4BY/2k=
Date: Mon, 28 Sep 2026 17:08:39 +0800 (CST)
From: chenyuan  <chenyuan_fl@163.com>
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	"Yuan Chen" <chenyuan@kylinos.cn>
Subject: Re:Re: [PATCH bpf-next] bpf: Roll back freplace link state when
 bpf_arch_text_poke() fails
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <d675af17-6b59-44c1-b90f-8fb468cc1d63@linux.dev>
References: <4669addf.91e8.1a0d2da9b9c.Coremail.chenyuan_fl@163.com>
 <20260925043500.28030-1-chenyuan_fl@163.com>
 <d675af17-6b59-44c1-b90f-8fb468cc1d63@linux.dev>
X-NTES-SC: AL_Qu2SAvmTuU0q7ySdY+kdnUYWg+8/X8W3svwi2YVUc/oEhgzm1QIGWntvNmnM6cGrGzG1tB6RaRt21sRFe6l1fWtS9QD8+dUglsFBkpU9Tg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <56074a5.8632.1a0e745ffa8.Coremail.chenyuan_fl@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cigvCgD3twKYLrpqzKlPAA--.3947W
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAhj6uGq6Lph9XAAA3f
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

ClRoYW5rcyBmb3IgdGhlIHJldmlldy7CoHYyIGFkZHMgdGhlIGJlODcwNGZmMDdkMiBGaXhlcyB0
YWcgYW5kIGNvbGxlY3RzIHlvdXIgQWNrLgoKCgoKCgoKCgpBdCAyMDI2LTA5LTI1IDE0OjA1OjU5
LCAiTGVvbiBId2FuZyIgPGxlb24uaHdhbmdAbGludXguZGV2PiB3cm90ZToKPk9uIDI1LzkvMjYg
MTI6MzUsIGNoZW55dWFuX2ZsQDE2My5jb20gd3JvdGU6Cj4+IEZyb206IFl1YW4gQ2hlbiA8Y2hl
bnl1YW5Aa3lsaW5vcy5jbj4KPj4gCj4+IEEgZnJlcGxhY2UgYXR0YWNoIGNsYWltcyB0aGUgdGFy
Z2V0IHByb2cgYnkgYnVtcGluZwo+PiB0Z3RfcHJvZy0+YXV4LT5mcmVwbGFjZV9saW5rX2NudCBh
bmQgc2V0dGluZyB0ci0+ZXh0ZW5zaW9uX3Byb2cuCj4+IGJwZl9hcmNoX3RleHRfcG9rZSgpIHRo
ZW4gbWFrZXMgdGhlIGV4dGVuc2lvbiB0YWtlIGVmZmVjdC4gIElmIHRoZQo+PiBwb2tlIGZhaWxz
LCB0aGUgY2xhaW1zIGFyZSBuZXZlciByZWxlYXNlZDogdGhlIGF0dGFjaCB1bndpbmRzCj4+IHRo
cm91Z2ggYnBmX2xpbmtfY2xlYW51cCgpLCB3aGljaCBjbGVhcnMgbGluay0+cHJvZywgc28KPj4g
YnBmX3RyYW1wb2xpbmVfdW5saW5rX3Byb2coKSBuZXZlciBydW5zLgo+PiAKPj4gRHJvcCB0aGUg
bGluayBjb3VudCB1bmRlciBleHRfbXV0ZXggb24gdGhlIGVycm9yIHBhdGgsIGFuZCBzZXQKPj4g
dHItPmV4dGVuc2lvbl9wcm9nIG9ubHkgYWZ0ZXIgdGhlIHBva2Ugc3VjY2VlZGVkLiAgVGhlIGNv
dW50IGlzCj4+IHN0aWxsIGJ1bXBlZCBiZWZvcmUgdGhlIHBva2U6IGl0IGJsb2NrcyBwcm9nX2Fy
cmF5IHVwZGF0ZXMgd2hpbGUKPj4gdGhlIGVudHJ5IGlzIHBhdGNoZWQuCj4+IAo+PiBGaXhlczog
ZDYwODNmMDQwZDVkICgiYnBmOiBQcmV2ZW50IHRhaWxjYWxsIGluZmluaXRlIGxvb3AgY2F1c2Vk
IGJ5IGZyZXBsYWNlIikKPgo+WW91ciBjb21taXQgbXNnIGFsc28gc2F5cyB0aGUgaXNzdWUgYWJv
dXQgdHItPmV4dGVuc2lvbl9wcm9nLgo+Cj5BbiBleHRyYSBGaXhlcyB0YWcgZm9yIHRyLT5leHRl
bnNpb25fcHJvZyBzaG91bGQgYmUgYWRkZWQuCj4KPkZpeGVzOiBiZTg3MDRmZjA3ZDIgKCJicGY6
IEludHJvZHVjZSBkeW5hbWljIHByb2dyYW0gZXh0ZW5zaW9ucyIpCj4KPlRoZSBjaGFuZ2VzIGJl
bG93IGxndG06Cj4KPkFja2VkLWJ5OiBMZW9uIEh3YW5nIDxsZW9uLmh3YW5nQGxpbnV4LmRldj4K
Pgo+VGhhbmtzLAo+TGVvbgo+Cj4+IFN1Z2dlc3RlZC1ieTogTGVvbiBId2FuZyA8bGVvbi5od2Fu
Z0BsaW51eC5kZXY+Cj4+IFNpZ25lZC1vZmYtYnk6IFl1YW4gQ2hlbiA8Y2hlbnl1YW5Aa3lsaW5v
cy5jbj4KPj4gLS0tCj4+ICBrZXJuZWwvYnBmL3RyYW1wb2xpbmUuYyB8IDEzICsrKysrKysrKyst
LS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+
PiAKPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdHJhbXBvbGluZS5jIGIva2VybmVsL2JwZi90
cmFtcG9saW5lLmMKPj4gaW5kZXggZGE4NWJkNTgwZWYwLi5iZjRhYjBhYzI2NGUgMTAwNjQ0Cj4+
IC0tLSBhL2tlcm5lbC9icGYvdHJhbXBvbGluZS5jCj4+ICsrKyBiL2tlcm5lbC9icGYvdHJhbXBv
bGluZS5jCj4+IEBAIC05NzMsMTAgKzk3MywxNyBAQCBzdGF0aWMgaW50IF9fYnBmX3RyYW1wb2xp
bmVfbGlua19wcm9nKHN0cnVjdCBicGZfdHJhbXBfbm9kZSAqbm9kZSwKPj4gIAkJZXJyID0gYnBm
X2ZyZXBsYWNlX2xpbmtfdGd0X3Byb2codGd0X3Byb2cpOwo+PiAgCQlpZiAoZXJyKQo+PiAgCQkJ
cmV0dXJuIGVycjsKPj4gKwkJZXJyID0gYnBmX2FyY2hfdGV4dF9wb2tlKHRyLT5mdW5jLmFkZHIs
IEJQRl9NT0RfTk9QLAo+PiArCQkJCQkgQlBGX01PRF9KVU1QLCBOVUxMLAo+PiArCQkJCQkgbm9k
ZS0+bGluay0+cHJvZy0+YnBmX2Z1bmMpOwo+PiArCQlpZiAoZXJyKSB7Cj4+ICsJCQkvKiBVbmRv
IHRoZSBjbGFpbSBmcm9tIGJwZl9mcmVwbGFjZV9saW5rX3RndF9wcm9nKCkuICovCj4+ICsJCQln
dWFyZChtdXRleCkoJnRndF9wcm9nLT5hdXgtPmV4dF9tdXRleCk7Cj4+ICsJCQl0Z3RfcHJvZy0+
YXV4LT5mcmVwbGFjZV9saW5rX2NudC0tOwo+PiArCQkJcmV0dXJuIGVycjsKPj4gKwkJfQo+PiAg
CQl0ci0+ZXh0ZW5zaW9uX3Byb2cgPSBub2RlLT5saW5rLT5wcm9nOwo+PiAtCQlyZXR1cm4gYnBm
X2FyY2hfdGV4dF9wb2tlKHRyLT5mdW5jLmFkZHIsIEJQRl9NT0RfTk9QLAo+PiAtCQkJCQkgIEJQ
Rl9NT0RfSlVNUCwgTlVMTCwKPj4gLQkJCQkJICBub2RlLT5saW5rLT5wcm9nLT5icGZfZnVuYyk7
Cj4+ICsJCXJldHVybiAwOwo+PiAgCX0KPj4gIAllcnIgPSBicGZfdHJhbXBvbGluZV9hZGRfcHJv
Zyh0ciwgbm9kZSwgY250KTsKPj4gIAlpZiAoZXJyKQo=
