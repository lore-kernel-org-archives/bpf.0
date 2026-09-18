Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19E364EB2;
	Fri, 18 Sep 2026 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707929; cv=none; b=gTWNTVb8DQ6vra9eK6CQPl/AsQjBBaVjwTZU6b2YRvE7IbLFhHXSMOmR2DmKPdXV09vqTnMJZJneLNHWd1pjN/WBgZ6G1EAnmiNY0fgEWm6AwLE0Lnh8Z+imyGp2VrXpy0hOICjdTi9bosym59K20/WIC66HBjaFcbw1fDk7ix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707929; c=relaxed/simple;
	bh=LQYvK2g9+t94cvvoJlO4sw+o6YJgytD5BTAEKx++9Uk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WIDeYsy3lFh8qAfaAQ+8igIA5TG02GaYLV80A5Uo5Vnfuc+x9WsWChcB8oooMBX+qtSJOBly9MEQ49IfAcfTclslACdwDYxGmEjbtETxaRPF98aD4YqvfPzV09rEzRdIWuh7ByOFH7ReV2o33LkIYNEgV945QNuxJOQfS7lnnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCp+xEJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCp+xEJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFF21F000FF;
	Fri, 18 Sep 2026 05:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789707928;
	bh=LQYvK2g9+t94cvvoJlO4sw+o6YJgytD5BTAEKx++9Uk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kCp+xEJEffeZ3+sQPTGfSXj7k/yVSED4DCLLna2W1BvNQH8T0wpWL7K5y61YBG+b3
	 Xd5gZeXPvGuuRQ/Ao6D13QT5u+b55rzE7StCsw8MUSLsWiF/YhaeTt74k2JaFbP6gQ
	 3N94n7Wh487tnsV6s/JfeBN5vj5lgg0x7HBPlflAU+Oh7p+l/ZWJLtz+OTYG3KtPXw
	 aMlSBAuskDl4tCvvwx7NmFDfny0efdhSoXvpHXQ+hzEQQ3xpzHigzrT2yCJSH1CVU3
	 7H/5m9aQPGqddrtaLxBJQcRK/OUbwwCKpPujlQBRyRawVr6QPFOT1MCfFLN7JIlxim
	 JCufOgt/c4+sw==
Content-Type: multipart/mixed; boundary="===============2031900917106036265=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1a854da66d611f079d8ff186b9bf73845ee18b73fac2481ef468a86fc777990@mail.kernel.org>
In-Reply-To: <20260918040919.3402577-3-tweek@google.com>
References: <20260918040919.3402577-3-tweek@google.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add iter subtest using lskel in global_data_init
From: bot+bpf-ci@kernel.org
To: tweek@google.com,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org,tweek@google.com,kpsingh@kernel.org,leon.hwang@linux.dev,emil@etsalapatis.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 05:05:27 +0000 (UTC)

--===============2031900917106036265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBJbiB0ZXN0X2dsb2JhbF9wZXJjcHVfZGF0YS5jLCBkdW1wX3BlcmNwdV9kYXRhIGlzIGRlZmlu
ZWQgYWZ0ZXIgdHdvCj4gbm9uLWF1dG9sb2FkIFNFQygiP2twcm9iZSIpIHByb2dyYW1zICh2ZXJp
Zmllcl9zdHJuY21wIGFuZAo+IHZlcmlmaWVyX3NucHJpbnRmKS4gSWYgYnBmdG9vbCBkb2VzIG5v
dCBza2lwIG5vbi1hdXRvbG9hZCBwcm9ncmFtcyB3aGVuCj4gZ2VuZXJhdGluZyBsaWdodCBza2Vs
ZXRvbnMsIGR1bXBfcGVyY3B1X2RhdGEucHJvZ19mZCBpcyBsZWZ0IGludmFsaWQgb3IKPiB1bnBv
cHVsYXRlZC4KPgo+IEZhY3RvciBvdXQgYSB0ZXN0X2dsb2JhbF9wZXJjcHVfZGF0YV9pdGVyX2Zk
KCkgaGVscGVyIHRoYXQgb3BlcmF0ZXMKPiBkaXJlY3RseSBvbiBwcm9nL21hcCBmaWxlIGRlc2Ny
aXB0b3JzLCBhbmQgYWRkIGFuIGl0ZXJfbHNrZWwgc3VidGVzdCB0bwo+IHZlcmlmeSB0aGF0IGR1
bXBfcGVyY3B1X2RhdGEgaXMgcHJvcGVybHkgbG9hZGVkIGFuZCBleGVjdXRlcyBjb3JyZWN0bHkK
PiB3aGVuIHVzaW5nIHRoZSBsaWdodCBza2VsZXRvbi4KPgo+IEZpeGVzOiA0YzkyNDFiZDczMWEg
KCJzZWxmdGVzdHMvYnBmOiBBZGQgdGVzdHMgdG8gdmVyaWZ5IGdsb2JhbCBwZXJjcHUgZGF0YSIp
Cj4gRml4ZXM6IDFlZDIyOTRiMzFmYyAoInNlbGZ0ZXN0cy9icGY6IFRlc3QgdmVyaWZpZXIgbG9n
IGZvciBnbG9iYWwgcGVyY3B1IGRhdGEiKQo+IFNpZ25lZC1vZmYtYnk6IFRoacOpYmF1ZCBXZWtz
dGVlbiA8dHdlZWtAZ29vZ2xlLmNvbT4KCkFyZSB0aGUgRml4ZXM6IHRhZ3MgYXBwcm9wcmlhdGUg
Zm9yIHRoaXMgY29tbWl0PyBUaGlzIHBhdGNoIG9ubHkgYWRkcyBuZXcKdGVzdCBjb3ZlcmFnZSAo
YSBuZXcgaXRlcl9sc2tlbCBzdWJ0ZXN0KSBhbmQgcmVmYWN0b3JzIGV4aXN0aW5nIHRlc3QgY29k
ZQooZmFjdG9yaW5nIG91dCB0ZXN0X2dsb2JhbF9wZXJjcHVfZGF0YV9pdGVyX2ZkKCkgd2l0aCBu
byBiZWhhdmlvcmFsIGNoYW5nZQp0byB0aGUgZXhpc3RpbmcgIml0ZXIiIHN1YnRlc3QpLiBJdCBk
b2Vzbid0IGZpeCBhbnl0aGluZyB0aGF0CjRjOTI0MWJkNzMxYSBvciAxZWQyMjk0YjMxZmMgZ290
IHdyb25nLgoKVGhlIGJ1ZyBiZWluZyB0ZXN0ZWQgaXMgaW4gYnBmdG9vbCwgaW50cm9kdWNlZCBi
eSBkNTEwMjk2ZDMzMWEKKCJicGZ0b29sOiBVc2Ugc3lzY2FsbC9sb2FkZXIgcHJvZ3JhbSBpbiAi
cHJvZyBsb2FkIiBhbmQgImdlbiBza2VsZXRvbiIKY29tbWFuZC4iKSBhbmQgYWN0dWFsbHkgZml4
ZWQgYnkgdGhlIHR3byBwcmVjZWRpbmcgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcwooMjAyZWU5MGRl
ZTM2OCBhbmQgODQzNzYyZTZmNDY2NSksIGJvdGggb2Ygd2hpY2ggYWxyZWFkeSBjYXJyeSB0aGUg
Y29ycmVjdApGaXhlczogZDUxMDI5NmQzMzFhIHRhZy4KClRoZXJlJ3MgYWxzbyBhIGJhY2twb3J0
IGNvbmNlcm4uIFRoZSBGaXhlczogdGFncyBtYWtlIHRoaXMgcGF0Y2ggYQpjYW5kaWRhdGUgZm9y
IEFVVE9TRUwvc3RhYmxlIHBpY2t1cCBpbmRlcGVuZGVudGx5IG9mIDIwMmVlOTBkZWUzNjggYW5k
Cjg0Mzc2MmU2ZjQ2NjUuIFNpbmNlIHRoaXMgaXMgdGhlIGxhc3QgcGF0Y2ggb2YgdGhlIHNlcmll
cywgYmFja3BvcnRpbmcgaXQKYWxvbmUgd291bGQgbGFuZCB0aGUgbmV3IGl0ZXJfbHNrZWwgc3Vi
dGVzdCBpbiBhIHRyZWUgd2l0aCB0aGUgdW5maXhlZApicGZ0b29sLCB3aGVyZSBza2VsLT5wcm9n
cy5kdW1wX3BlcmNwdV9kYXRhLnByb2dfZmQgaXMgbGVmdCBhdCAwIGFuZApicGZfbGlua19jcmVh
dGUoMCwgMCwgQlBGX1RSQUNFX0lURVIsICZvcHRzKSBmYWlscy4gVGhlIHN1YnRlc3Qgd291bGQg
ZmFpbApieSBjb25zdHJ1Y3Rpb24uCgpTaG91bGQgdGhlIEZpeGVzOiB0YWdzIGJlIHJlbW92ZWQs
IG9yIGlmIHRoZXkncmUgaW50ZW5kZWQgdG8gYmUga2VwdCwKc2hvdWxkIHRoZSBkZXBlbmRlbmN5
IG9uIHRoZSB0d28gYnBmdG9vbCBwYXRjaGVzIGJlIHN0YXRlZCB2aWEKQ2M6IDxzdGFibGVAdmdl
ci5rZXJuZWwub3JnPiBwcmVyZXF1aXNpdGUgbGluZXM/CgoKLS0tCkFJIHJldmlld2VkIHlvdXIg
cGF0Y2guIFBsZWFzZSBmaXggdGhlIGJ1ZyBvciBlbWFpbCByZXBseSB3aHkgaXQncyBub3QgYSBi
dWcuClNlZTogaHR0cHM6Ly9naXRodWIuY29tL2tlcm5lbC1wYXRjaGVzL3ZtdGVzdC9ibG9iL21h
c3Rlci9jaS9jbGF1ZGUvUkVBRE1FLm1kCgpDSSBydW4gc3VtbWFyeTogaHR0cHM6Ly9naXRodWIu
Y29tL2tlcm5lbC1wYXRjaGVzL2JwZi9hY3Rpb25zL3J1bnMvMzUzMDY0MDQ2NjM=

--===============2031900917106036265==--
