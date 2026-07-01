Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59BF41931D;
	Wed,  1 Jul 2026 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902683; cv=none; b=FWbWudISS9wc3M0GtZyBbhnCJyl5yiEQ9hU0wmLUSB2kKJsZZXDWK3KZok9sfKS1VLajCNdg3DSmdNNnjH+oZrfFCUX4a/dyRo6nclyNGg9bfWAWCSAKGvouBRiTAUHWrqSs/NFg5oXDhRYVbyCEASaeuk/iYaHnO/0S+0nM68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902683; c=relaxed/simple;
	bh=tQ/7wdLnB7SaZzgOmv5/Q3hQ8CU/AjcJqJXfAvTcrq8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iD233mUWXg3bbZQVIloXI6U0B35uM7BhkdPFw3XnHkDsxeTrEiABee8XMIr1/suUbSm2mnUyh6WEfnuIWBjISjhR/tefii90WBUX7wwi3mJw7Y0jmXqZkwZo0pWsgj/50rb0dzQQhxlcxDr1oH2OEJShcBteuvev3EIc/4ubvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwcG1t0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwcG1t0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52A01F00A3D;
	Wed,  1 Jul 2026 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782902682;
	bh=tQ/7wdLnB7SaZzgOmv5/Q3hQ8CU/AjcJqJXfAvTcrq8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JwcG1t0/ie7HIwTRe6gNi2NuSlDiJq4ex2G0doBaBac7tS/bZNUt/xsP/pZOxDm7+
	 CusWAiHqsv222mKGn+3BoOYC9iNCW7SRoahrXMuzj4BcPJY/v0GT/XLrf+ORYos1cf
	 k+Efb9e9aCXrNXJxqClLvD6xgFLRYl6hq7TM32DndfEk0xACULGXqKP8ZIKDq+Ktwh
	 mU1ysFvbcvZoMXDygGEI2XAFVDjcN/+vyJgwjwjHjYaB4vwfNvACxXtBCtlvC7LvPb
	 b15saRRVDJaCA8nQsM1n16dfhV0kbT4IlZc5qHT54D0iSrakOBA3dITMgnEs5/FPf/
	 XAuOuhkFqi91Q==
Content-Type: multipart/mixed; boundary="===============2526195576906088752=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb4bf057c5071cd1db9bf211d39047a3dddcd0ba35ce2c1b3a1a863891ee22ae@mail.kernel.org>
In-Reply-To: <20260701-kasan-v3-3-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-3-bd09bb942d86@bootlin.com>
Subject: Re: [PATCH bpf-next v3 03/10] bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,tglx@kernel.org,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mingo@redhat.com,andreyknvl@gmail.com
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 10:44:41 +0000 (UTC)

--===============2526195576906088752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiAgICAgQWRkIGEgbmV3IEtjb25maWcgb3B0aW9uIENPTkZJR19CUEZfSklUX0tBU0FOIHRoYXQg
YXV0b21hdGljYWxseSBlbmFibGVzCj4gICAgIGdlbmVyaWMgS0FTQU4gKEtlcm5lbCBBZGRyZXNz
IFNBTml0aXplcikgbWVtb3J5IGFjY2VzcyBjaGVja3MgZm9yCj4gICAgIEpJVC1jb21waWxlZCBC
UEYgcHJvZ3JhbXMgYXMgd2VsbCwgd2hlbiBib3RoIEtBU0FOX0dFTkVSSUMgYW5kIEpJVAo+ICAg
ICBjb21waWxlciBhcmUgZW5hYmxlZC4gVGhpcyBuZXcgS2NvbmZpZyBpcyBub3QgYSB1c2VyIHNl
bGVjdGFibGUgb25lOiBpdAo+ICAgICBpcyBlaXRoZXIgYXV0b21hdGljYWxseSBlbmFibGVkIGlm
IEtBU0FOIGlzIGVuYWJsZWQgb24gYSBjb21wYXRpYmxlCj4gICAgIHBsYXRmb3JtLCBvciBkaXNh
YmxlZC4gV2hlbiBlbmFibGVkLCB0aGUgSklUIGNvbXBpbGVyIHdpbGwgZW1pdCBzaGFkb3cKPiAg
ICAgbWVtb3J5IGNoZWNrcyBiZWZvcmUgbWVtb3J5IGxvYWRzIGFuZCBzdG9yZXMgdG8gZGV0ZWN0
IHVzZS1hZnRlci1mcmVlIG9yCj4gICAgIG91dC1vZi1ib3VuZHMgYWNjZXNzZXMgYXQgcnVudGlt
ZS4gVGhlIG9wdGlvbiBpcyBnYXRlZCBiZWhpbmQKPiAgICAgSEFWRV9FQlBGX0pJVF9LQVNBTiwg
YXMgaXQgbmVlZHMgcHJvcGVyIGFyY2gtc3BlY2lmaWMgaW1wbGVtZW50YXRpb24uCj4KPiAgICAg
QXMgS0FTQU4gaW5zdHJ1bWVudGF0aW9uIGZvciBlQlBGIHByb2dyYW0gd2lsbCBkZXBlbmQgb24g
dGhlIGluZm8gdGhhdAo+ICAgICBjYW4gYmUgYWNjZXNzZWQgZHVyaW5nIGVhY2ggaW5zdHJ1Y3Rp
b24gdmVyaWZpY2F0aW9uLCB0aGVyZSBtYXkgYmUKPiAgICAgaW5zdHJ1Y3Rpb25zIHRoYXQgd2ls
bCBiZSBpbnN0cnVtZW50ZWQgZXZlbiBpZiB0aGV5IGRvbid0IHJlYWxseSBuZWVkIHRvCj4gICAg
IChlZzogZ2xvYmFsIHN1YnByb2dyYW1zIHRoYXQgYWNjZXNzIGNhbGxlciBzdGFjayBtZW1vcnkg
cGFzc2VkIGFzCj4gICAgIGFyZ3VtZW50KS4gVG8gbWFrZSBzdXJlIHRoYXQgdGhvc2UgYWRkaXRp
b25hbCBjaGVja3MgZG8gbm90IHRyaWdnZXIgYW55Cj4gICAgIGNyYXNoLCBtYWtlIHN1cmUgdGhh
dCBWTUFQX1NUQUNLIGlzIGVuYWJsZWQgc28gdGhhdCBwcm9ncmFtcyBzdGFjayBoYXMKPiAgICAg
c2hhZG93IG1lbW9yeSBhbGxvY2F0ZWQuCj4KPiAgICAgU2lnbmVkLW9mZi1ieTogQWxleGlzIExv
dGhvcsOpIChlQlBGIEZvdW5kYXRpb24pIDxhbGV4aXMubG90aG9yZUBib290bGluLmNvbT4KClRo
aXMgaXNuJ3QgYSBidWcsIGJ1dCB0aGUgY2hhbmdlbG9nIGRlc2NyaWJlcyB0aGUgZW5hYmxpbmcg
Y29uZGl0aW9uIGFzCiJLQVNBTl9HRU5FUklDIGFuZCBKSVQgY29tcGlsZXIiLCB3aGlsZSB0aGUg
YWRkZWQgZGVmYXVsdCBsaW5lIGFsc28KcmVxdWlyZXMgS0FTQU5fVk1BTExPQzoKCgljb25maWcg
QlBGX0pJVF9LQVNBTgoJCWJvb2wKCQlkZXBlbmRzIG9uIEhBVkVfRUJQRl9KSVRfS0FTQU4KCQlk
ZWZhdWx0IHkgaWYgQlBGX0pJVCAmJiBLQVNBTl9HRU5FUklDICYmIEtBU0FOX1ZNQUxMT0MgJiYg
Vk1BUF9TVEFDSwoKQ291bGQgdGhlIGNoYW5nZWxvZyBzdGF0ZSB0aGUgZnVsbCBzZXQgb2YgY29u
ZGl0aW9ucyB0aGF0IGVuYWJsZQpCUEZfSklUX0tBU0FOIChpbmNsdWRpbmcgS0FTQU5fVk1BTExP
Qykgc28gdGhlIGRlc2NyaWJlZCBiZWhhdmlvciBtYXRjaGVzCnRoZSAiZGVmYXVsdCB5IGlmIiBs
aW5lPwoKCi0tLQpBSSByZXZpZXdlZCB5b3VyIHBhdGNoLiBQbGVhc2UgZml4IHRoZSBidWcgb3Ig
ZW1haWwgcmVwbHkgd2h5IGl0J3Mgbm90IGEgYnVnLgpTZWU6IGh0dHBzOi8vZ2l0aHViLmNvbS9r
ZXJuZWwtcGF0Y2hlcy92bXRlc3QvYmxvYi9tYXN0ZXIvY2kvY2xhdWRlL1JFQURNRS5tZAoKQ0kg
cnVuIHN1bW1hcnk6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9u
cy9ydW5zLzI4NTEwNDI0ODgx

--===============2526195576906088752==--
