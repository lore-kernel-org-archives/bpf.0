Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8864
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771618653; cv=none; b=P7f77/Uo/alCI5X8Yl3mcVt+UaqgAdbF9lzjXDutgbxwQc/q2U34wHLsK2S4HLVrVk8bDgRXUX1DouFmuTcvOGAnJXtKi3Fso8rKSGl33DolLob/SwsPD8OVDiwT8U6X3K7adltE5c4DhQvaMMM0XkkBtsreMAp/DwruzI8jgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771618653; c=relaxed/simple;
	bh=Co59+2+qV9JyaUMj6xDB6ykkOt68zRPuYxSecVBzYoY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jjavmeg1NJjCJPhaIg/GdToEiq1md6DtPD+GkvxWbzJYwvyioj501WjRQdVEPkOyz6V1O4FzVeX49moei1LBCLYDns0oMD071OXAaf248qMLs2nvgjqH9+UqhQpZAyygW1f3fWuMkh+b7XU4YE+fOuFSPxfOopQznshFkfXhHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXE5+KEQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXE5+KEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DE5C116C6;
	Fri, 20 Feb 2026 20:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771618653;
	bh=Co59+2+qV9JyaUMj6xDB6ykkOt68zRPuYxSecVBzYoY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CXE5+KEQFU28UlO+RFMCXA9nhK4zRJRtU0ap4ujVjUW7cphGXO0gYcKCrgkHTIOJs
	 kVlP6nnEEyH6gGwxN0rN8IUFuFJP5r+zgnz5fYKEr4dnMFAz9FgfMlm3u3UgEUmZs7
	 1nbur38XLEfSP4Y16F2Xih5tocmz5hTd+M3nFe22QAIAz0sSfFqGSVcOXMZq2Rnbi3
	 GMlQv2y5xHxW5tfgYOxmzi1evo3Jt4hr98mFuY8JmvoC3FbNqwirEX/d5hhHQ0I+Uu
	 THdCrnnfIvJ8CONrMYeV283D+fbRntkbThuvAt6JluuiR+8IYzhsVd0wbph8r1v++Q
	 a2NGlaBTqXDgA==
Content-Type: multipart/mixed; boundary="===============3905128171394996640=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ec18b3fff23d741473f801d205aafcc210723d9e1aff3ac6ff25f687cb9aacd2@mail.kernel.org>
In-Reply-To: <b2266866dd310ee411345565a5f4febb745cd326.1771616227.git.josef@toxicpanda.com>
References: <b2266866dd310ee411345565a5f4febb745cd326.1771616227.git.josef@toxicpanda.com>
Subject: Re: [PATCH v2 2/3] bpftool: support merging multiple module BTFs in btf dump
From: bot+bpf-ci@kernel.org
To: josef@toxicpanda.com,bpf@vger.kernel.org
Cc: noreply@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 20 Feb 2026 20:17:32 +0000 (UTC)

--===============3905128171394996640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBkaWZmIC0tZ2l0IGEvdG9vbHMvYnBmL2JwZnRvb2wvYnRmLmMgYi90b29scy9icGYvYnBmdG9v
bC9idGYuYwo+IC0tLSBhL3Rvb2xzL2JwZi9icGZ0b29sL2J0Zi5jCj4gKysrIGIvdG9vbHMvYnBm
L2JwZnRvb2wvYnRmLmMKClsgLi4uIF0KCj4gKwkJaWYgKG5yX2ZpbGVzID09IDEpIHsKPiArCQkJ
LyogU2luZ2xlIGZpbGUg4oCUIHByZXNlcnZlIGV4aXN0aW5nIGJlaGF2aW9yIGV4YWN0bHkgKi8K
ClsgLi4uIF0KCj4gKwkJCWJ0ZiA9IGJ0Zl9fcGFyc2Vfc3BsaXQoZmlsZXNbMF0sIGJhc2UgPzog
YmFzZV9idGYpOwo+ICsJCQlpZiAoIWJ0Zikgewo+ICsJCQkJZXJyID0gLWVycm5vOwo+ICsJCQkJ
cF9lcnIoImZhaWxlZCB0byBsb2FkIEJURiBmcm9tICVzOiAlcyIsCj4gKwkJCQkgICAgICBmaWxl
c1swXSwgc3RyZXJyb3IoZXJybm8pKTsKPiArCQkJCWdvdG8gZG9uZTsKPiArCQkJfQo+ICsJCX0g
ZWxzZSB7CgpbIC4uLiBdCgo+ICsJCQljb21iaW5lZCA9IGJ0Zl9fbmV3X2VtcHR5X3NwbGl0KHZt
bGludXhfYmFzZSk7Cj4gKwkJCWlmICghY29tYmluZWQpIHsKPiArCQkJCXBfZXJyKCJmYWlsZWQg
dG8gY3JlYXRlIGNvbWJpbmVkIEJURjogJXMiLAo+ICsJCQkJICAgICAgc3RyZXJyb3IoZXJybm8p
KTsKPiArCQkJCWVyciA9IC1lcnJubzsKPiArCQkJCWdvdG8gZG9uZTsKPiArCQkJfQoKVGhlIHNp
bmdsZS1maWxlIHBhdGggYWJvdmUgY2FwdHVyZXMgZXJyID0gLWVycm5vIGJlZm9yZSBjYWxsaW5n
CnBfZXJyKCkuICBIZXJlIHRoZSBvcmRlciBpcyByZXZlcnNlZCAtLSBwX2VycigpIGNhbGxzIGZw
cmludGYgd2hpY2gKY2FuIG1vZGlmeSBlcnJubyBiZWZvcmUgaXQgaXMgY2FwdHVyZWQuICBDb3Vs
ZCBlcnIgZW5kIHVwIHdpdGggdGhlCndyb25nIHZhbHVlIGhlcmU/Cgo+ICsJCQlmb3IgKGogPSAw
OyBqIDwgbnJfZmlsZXM7IGorKykgewo+ICsJCQkJbW9kID0gYnRmX19wYXJzZV9zcGxpdChmaWxl
c1tqXSwgdm1saW51eF9iYXNlKTsKPiArCQkJCWlmICghbW9kKSB7Cj4gKwkJCQkJcF9lcnIoImZh
aWxlZCB0byBsb2FkIEJURiBmcm9tICVzOiAlcyIsCj4gKwkJCQkJICAgICAgZmlsZXNbal0sIHN0
cmVycm9yKGVycm5vKSk7Cj4gKwkJCQkJYnRmX19mcmVlKGNvbWJpbmVkKTsKPiArCQkJCQllcnIg
PSAtZXJybm87Cj4gKwkJCQkJZ290byBkb25lOwo+ICsJCQkJfQoKU2FtZSBvcmRlcmluZyBjb25j
ZXJuIGhlcmUsIGFuZCBidGZfX2ZyZWUoY29tYmluZWQpIHNpdHMgYmV0d2VlbiB0aGUKZmFpbGlu
ZyBjYWxsIGFuZCB0aGUgZXJybm8gY2FwdHVyZSBhcyB3ZWxsLiAgYnRmX19mcmVlKCkgY2FsbHMg
Y2xvc2UoKQpvbiB0aGUgQlRGIGZkIHdoaWNoIGNhbiBhbHNvIGNsb2JiZXIgZXJybm8uICBJZiBh
IGZpbGUgZmFpbHMgdG8gcGFyc2UsCmVyciBtaWdodCBlbmQgdXAgYXMgMCBvciBzb21lIHVucmVs
YXRlZCB2YWx1ZSBpbnN0ZWFkIG9mIHRoZSBhY3R1YWwKZXJyb3IsIGdpdmluZyBjYWxsZXJzIGFu
ZCBzY3JpcHRzIGEgd3JvbmcgZXhpdCBjb2RlLgoKWyAuLi4gXQoKCi0tLQpBSSByZXZpZXdlZCB5
b3VyIHBhdGNoLiBQbGVhc2UgZml4IHRoZSBidWcgb3IgZW1haWwgcmVwbHkgd2h5IGl0J3Mgbm90
IGEgYnVnLgpTZWU6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy92bXRlc3QvYmxv
Yi9tYXN0ZXIvY2kvY2xhdWRlL1JFQURNRS5tZAoKQ0kgcnVuIHN1bW1hcnk6IGh0dHBzOi8vZ2l0
aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzIyMjM4ODYzNzY0CgpBSS1h
dXRob3JzaGlwLXNjb3JlOiBoaWdoCkFJLWF1dGhvcnNoaXAtZXhwbGFuYXRpb246IENvbW1pdCBl
eHBsaWNpdGx5IGluY2x1ZGVzIENvLUF1dGhvcmVkLUJ5OiBDbGF1ZGUgT3B1cyA0LjYgdGFnIGlu
ZGljYXRpbmcgZGlyZWN0IEFJIGludm9sdmVtZW50IGluIHdyaXRpbmcgdGhlIGNvZGUuCmlzc3Vl
cy1mb3VuZDogMQppc3N1ZS1zZXZlcml0eS1zY29yZTogbG93Cmlzc3VlLXNldmVyaXR5LWV4cGxh
bmF0aW9uOiBlcnJubyBpcyBjYXB0dXJlZCBhZnRlciBwX2VycigpIGFuZCBidGZfX2ZyZWUoKSBj
YWxscyBpbiB0aGUgbXVsdGktZmlsZSBlcnJvciBwYXRocywgd2hpY2ggY2FuIGNsb2JiZXIgZXJy
bm8gYW5kIHByb2R1Y2UgYSB3cm9uZyBleGl0IGNvZGUgZnJvbSBicGZ0b29sLgo=

--===============3905128171394996640==--
