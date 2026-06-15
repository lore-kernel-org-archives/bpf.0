Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB93E2F7F0F
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516198; cv=none; b=ZxqUzqgV1ojNpWxzZRO8Htmm6seesb+PFFuptNI3KGzI6jpz6iv0S+Zrzk0DkDypUWBKvKxYvBDLF+D5WxdmTh4YPJteUxXVrOqK/JouVspue0WhbDGlLLYT6XG+YJGpjN6a5xqRirzXCIZu84ViYemVg2m3OnRutHqLBlQ+QAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516198; c=relaxed/simple;
	bh=VmF5v62cc1NkFDCbD05zoYa2Jf2Oc5ZRzO/8/yuDtZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=JYWgHVdoAybLXf1ls18Dd5LmnJNtbZWgLicch68I8szRFboeUsJYPwidxMWuc9lcAdpma/O7FXaHukAGjmTuUrlHxuUPh9Ap7PRxFakkodBHMLfP5u32BXjy073W6m2R8nGV/z1SbAWCUlBkeyVzpNf4itMWxlmCBsw4L34+Qmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=fail (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=U4Fi2qJm reason="signature verification failed"; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="U4Fi2qJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Cc:
	Subject:In-Reply-To:References:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID; bh=RQFhuO/HnA3f+FeJvjwfwnH
	JxK48RWLq0bfJgQhSXbU=; b=U4Fi2qJmgr1pCkXzi2r1u2yI1QZsHXcuN5QdAC6
	L+Hq6dOD8v9xAzkME6YAayFIKI3s9IcfeIQxMpdmURokIIMNJSoeivIYgvuhjjvu
	gqXHZQuLzWqxfPxJ71WrOB1CI7NkO2FqNJip2TAwwwN/yRJm65rtMFxewB+WhM8k
	ka54=
Received: from gnq25$mails.tsinghua.edu.cn ( [183.173.82.101] ) by
 ajax-webmail-web2 (Coremail) ; Mon, 15 Jun 2026 17:36:31 +0800 (GMT+08:00)
Date: Mon, 15 Jun 2026 17:36:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: Re: [PATCH bpf 2/2] selftests/bpf: Cover dynptr probe-read
 kfunc capability gate
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT5 build
 20250909(015d6f0a) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
In-Reply-To: <20260615084155.8ECDA1F000E9@smtp.kernel.org>
References: <20260615-f01-07-dynptr-probe-read-cap-v1-2-e626cd61a381@mails.tsinghua.edu.cn>
 <20260615084155.8ECDA1F000E9@smtp.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <41aba881.7e105.19ecaa3c6bd.Coremail.gnq25@mails.tsinghua.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:yQQGZQCXcZmfxy9qLJdPAg--.16760W
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQETA2ovr0If+gA
	IsV
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiBzYXNoaWtvLWJvdEBrZXJu
ZWwub3JnCj4gU2VuZCB0aW1lOk1vbmRheSwgMTUvMDYvMjAyNiAxNjo0MTo1NQo+IFRvOiAiTnVv
cWkgR3VpIiA8Z25xMjVAbWFpbHMudHNpbmdodWEuZWR1LmNuPgo+IENjOiBicGZAdmdlci5rZXJu
ZWwub3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSCBicGYgMi8yXSBzZWxmdGVzdHMvYnBmOiBDb3Zl
ciBkeW5wdHIgcHJvYmUtcmVhZCBrZnVuYyBjYXBhYmlsaXR5IGdhdGUKPiAKPiBUaGFuayB5b3Ug
Zm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAxIHBvdGVudGlh
bCBpc3N1ZShzKSB0byBjb25zaWRlcjoKPiAtIFtNZWRpdW1dIFRoZSBjb21taXQgbWVzc2FnZSBj
bGFpbXMgdG8gZGVjbGFyZSBleHBsaWNpdCBrZnVuYyBwcm90b3R5cGVzIGxvY2FsbHkgaW4gYGR5
bnB0cl9zdWNjZXNzLmNgLCBidXQgdGhlIHBhdGNoIGZhaWxzIHRvIGluY2x1ZGUgdGhlc2UgZGVj
bGFyYXRpb25zLgo+IC0tCj4gCj4gY29tbWl0IGQzZGVkYTFiZmQ1MGUwYWY2NmUwZGNlZDAwNTQy
M2VkZDk5YzBkMDMKPiBBdXRob3I6IE51b3FpIEd1aSA8Z25xMjVAbWFpbHMudHNpbmdodWEuZWR1
LmNuPgo+IAo+IHNlbGZ0ZXN0cy9icGY6IENvdmVyIGR5bnB0ciBwcm9iZS1yZWFkIGtmdW5jIGNh
cGFiaWxpdHkgZ2F0ZQo+IAo+IFRoaXMgY29tbWl0IGFkZHMgc2VsZnRlc3QgcHJvZ3JhbXMgdG8g
dmVyaWZ5IHRoYXQgdGhlIG5vZmF1bHQgcHJvYmUtcmVhZAo+IGR5bnB0ciBrZnVuY3MgZmFpbCB3
aXRoIC1FQUNDRVMgd2hlbiBjYWxsZWQgd2l0aG91dCBDQVBfUEVSRk1PTiBhbmQKPiBDQVBfU1lT
X0FETUlOLiBJdCB0ZXN0cyB0aGUgcG9saWN5IGJvdW5kYXJ5IGZvciB0aGVzZSBrZnVuY3MgdXNp
bmcKPiBjYXBhYmlsaXRpZXMuCj4gCj4gPiBBZGQgZm9jdXNlZCBkeW5wdHIgc2VsZnRlc3QgcHJv
Z3JhbXMgdGhhdCBsb2FkIHNvY2tldC1maWx0ZXIgcHJvZ3JhbXMgdXNpbmcKPiA+IGJwZl9keW5w
dHJfZnJvbV9tZW0oKSBmb2xsb3dlZCBieSBlYWNoIG5vZmF1bHQgcHJvYmUtcmVhZCBkeW5wdHIg
a2Z1bmM6Cj4gPiBicGZfcHJvYmVfcmVhZF91c2VyX2R5bnB0cigpLCBicGZfcHJvYmVfcmVhZF9r
ZXJuZWxfZHlucHRyKCksCj4gPiBicGZfcHJvYmVfcmVhZF91c2VyX3N0cl9keW5wdHIoKSwgYW5k
IGJwZl9wcm9iZV9yZWFkX2tlcm5lbF9zdHJfZHlucHRyKCkuCj4gPiBEZWNsYXJlIHRoZSBkeW5w
dHIga2Z1bmNzIHVzZWQgYnkgdGhpcyBCUEYgb2JqZWN0IGxvY2FsbHkgaW4KPiA+IGR5bnB0cl9z
dWNjZXNzLmMgc28gdGhlIGR5bnB0ciBCUEYgb2JqZWN0IGJ1aWxkcyB3aXRoIGV4cGxpY2l0IHBy
b3RvdHlwZXMuCj4gCj4gW1NldmVyaXR5OiBNZWRpdW1dCj4gSXMgdGhpcyBkZXNjcmlwdGlvbiBh
Y2N1cmF0ZSBmb3IgdGhlIGluY2x1ZGVkIGNoYW5nZXM/Cj4gCj4gVGhlIGNvbW1pdCBtZXNzYWdl
IG1lbnRpb25zIGFkZGluZyBleHBsaWNpdCBsb2NhbCBkZWNsYXJhdGlvbnMgZm9yIHRoZSBkeW5w
dHIKPiBrZnVuY3MgaW4gZHlucHRyX3N1Y2Nlc3MuYywgYnV0IHRoZXNlIGRlY2xhcmF0aW9ucyBk
byBub3QgYXBwZWFyIHRvIGJlCj4gaW5jbHVkZWQgaW4gdGhlIGNvZGUuIFdlcmUgdGhleSBhY2Np
ZGVudGFsbHkgb21pdHRlZCBmcm9tIHRoaXMgcGF0Y2gsIG9yCj4gaXMgdGhlIGNvbW1pdCBtZXNz
YWdlIG91dGRhdGVkPwo+IAo+IC0tIAo+IFNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8vc2Fz
aGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDYxNS1mMDEtMDctZHlucHRyLXByb2JlLXJlYWQtY2Fw
LXYxLTAtZTYyNmNkNjFhMzgxQG1haWxzLnRzaW5naHVhLmVkdS5jbj9wYXJ0PTIKClRoaXMgc2Vu
dGVuY2UgaXMgc3RhbGUgZnJvbSBhbiBlYXJsaWVyIHZlcnNpb24gb2YgdGhlIHBhdGNoLiBUaGUK
Y3VycmVudCBwYXRjaCBubyBsb25nZXIgYWRkcyBsb2NhbCBkZWNsYXJhdGlvbnMgaW4gZHlucHRy
X3N1Y2Nlc3MuYywgCnNvIEknbGwgZHJvcCB0aGF0IHNlbnRlbmNlIGZyb20gdGhlIGNvbW1pdCBt
ZXNzYWdlLgo=
