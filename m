Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E823BD1B;
	Fri,  4 Sep 2026 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788495222; cv=none; b=HV+8y1K6fQuawHTN6Rtsf3hDjIsTJiP2GtnRJy5bxryQkmAzH5C+6dz+Xs8alwa5dDrq/lVlFw/8jYmUhtG3kqg/+crp94G5SV5rAtzNkkmwdFZUwUUaZLjTjD+981r5KF40ItvU0ztmsBg0koW9gC7mEC7KP/pnDJ+PKSfdpYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788495222; c=relaxed/simple;
	bh=Ovg+QgZFjgwPM6VxGpptzrugWCyGFgm1zCQ39i/p8W8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c7Y3vMeFlS8Ens47C9dSLmSmSKVq4xkuD7++6bA1FvCNHEnN97gOFDZkjXbw0Z5pOqCs6vcWwFYdLrPg1DO2oyojK5rvh7udEExo+M7sQ1lE8NKmGZlqspSI4vq+iBcrh07qbJdZw03BMo2RByIGKil6+ifHAvYH++9O0SOEi9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlL32qaH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlL32qaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD0C1F00A3D;
	Fri,  4 Sep 2026 04:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788495219;
	bh=Ovg+QgZFjgwPM6VxGpptzrugWCyGFgm1zCQ39i/p8W8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FlL32qaHfcA1RJ7GJu0KbLvf+B3sB2GXkgBWqruEijyDZdcTShQzRXu8AIRQfpCmt
	 dniEimjbRRhPR9KW1Nf9rBhvZaEBFYki6OfoyBL5HeO2Y+ovqFraVZYVGsEqWZ+4+p
	 ojyX+Ag3lOtJg6pqvpKZKhtcnYKESXgWXt4w9PLfFOwE5506lunSRbQ8ismNre2p5y
	 5/JF0gAI6zRr/m5NxJeITdazR6Jze3+JAAKoQ5DDUlxZcomBl8YYQSijR3jkBCFSiS
	 WeV8LObrxWvPCZ9HBmMJAXzkKKKXCrKInGG/wefabpXUArLb/QB8j0buov1vAImPf1
	 t/kznrsxUCkmQ==
Content-Type: multipart/mixed; boundary="===============4158003370620922930=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4fc647167cbe57eccef94e639af9c89c00481b0c06a23df95a8ac27dea12edc0@mail.kernel.org>
In-Reply-To: <20260904031912.2133476-2-tweek@google.com>
References: <20260904031912.2133476-2-tweek@google.com>
Subject: Re: [PATCH bpf-next 2/2] bpftool: Reject non-autoload programs for light skeletons
From: bot+bpf-ci@kernel.org
To: tweek@google.com,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org,leon.hwang@linux.dev,emil@etsalapatis.com,tweek@google.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,sidnayyar@google.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 04:13:38 +0000 (UTC)

--===============4158003370620922930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBjb21taXQgMmY1OWQyNTQ0MjI3M2EzZGQ0ZTQ2YmQ0YTc3Y2E0YmJmMTYzM2UzYwo+IEF1dGhv
cjogVGhpw6liYXVkIFdla3N0ZWVuIDx0d2Vla0Bnb29nbGUuY29tPgo+IERhdGU6ICAgRnJpIFNl
cCA0IDEzOjE5OjEyIDIwMjYgKzEwMDAKPgo+ICAgICBicGZ0b29sOiBSZWplY3Qgbm9uLWF1dG9s
b2FkIHByb2dyYW1zIGZvciBsaWdodCBza2VsZXRvbnMKPgo+ICAgICBXaGVuIGdlbmVyYXRpbmcg
YSBsaWdodCBza2VsZXRvbiAoYnBmdG9vbCBnZW4gc2tlbGV0b24gLUwpLCB0aGVyZSBpcyBubwo+
ICAgICBsaWJicGYgcnVudGltZSBvYmplY3Qgb3IgYnBmX3Byb2dyYW1fX3NldF9hdXRvbG9hZCgp
IEFQSSBhdmFpbGFibGUgdG8KPiAgICAgZW5hYmxlL2Rpc2FibGUgdGhlIGF1dG9sb2FkaW5nIG9m
IHByb2dyYW1zLiBJZiBhIEJQRiBwcm9ncmFtIGluIHRoZQo+ICAgICBvYmplY3QgaGFzIGF1dG9s
b2FkIGRpc2FibGVkIChlLmcuIHZpYSBTRUMoIj8uLi4iKSksIGJwZl9vYmplY3RfX2xvYWQoKQo+
ICAgICBzaWxlbnRseSBza2lwcyBsb2FkaW5nIGl0LiBicGZ0b29sIHN0aWxsIGdlbmVyYXRlcyBz
dHJ1Y3QgYnBmX3Byb2dfZGVzYwo+ICAgICBmaWVsZHMgYW5kIGF0dGFjaCBmdW5jdGlvbnMgaW4g
dGhlIGxpZ2h0IHNrZWxldG9uIGhlYWRlciwgbGVhdmluZwo+ICAgICBza2VsLT5wcm9ncy48bmFt
ZT4ucHJvZ19mZCB1bmluaXRpYWxpemVkICgwKS4KPgo+ICAgICBFeHBsaWNpdGx5IHJlamVjdCBu
b24tYXV0b2xvYWRlZCBwcm9ncmFtcyB3aGVuIHVzZV9sb2FkZXIgaXMgdHJ1ZSB3aXRoCj4gICAg
IGFuIGVycm9yIG1lc3NhZ2UsIHByZXZlbnRpbmcgdGhlIGdlbmVyYXRpb24gb2YgYnJva2VuIGxp
Z2h0IHNrZWxldG9uCj4gICAgIGhlYWRlcnMuCj4KPiAgICAgU2lnbmVkLW9mZi1ieTogVGhpw6li
YXVkIFdla3N0ZWVuIDx0d2Vla0Bnb29nbGUuY29tPgoKVGhpcyBsb29rcyBsaWtlIGEgYnVnIGZp
eCBmb3IgbGlnaHQgc2tlbGV0b24gZ2VuZXJhdGlvbi4gU2hvdWxkIHRoaXMKaW5jbHVkZSBhIEZp
eGVzOiB0YWc/CgogIEZpeGVzOiBkNTEwMjk2ZDMzMWEgKCJicGZ0b29sOiBVc2Ugc3lzY2FsbC9s
b2FkZXIgcHJvZ3JhbSBpbiBcInByb2cgbG9hZFwiIGFuZCBcImdlbiBza2VsZXRvblwiIGNvbW1h
bmQuIikKCgotLS0KQUkgcmV2aWV3ZWQgeW91ciBwYXRjaC4gUGxlYXNlIGZpeCB0aGUgYnVnIG9y
IGVtYWlsIHJlcGx5IHdoeSBpdCdzIG5vdCBhIGJ1Zy4KU2VlOiBodHRwczovL2dpdGh1Yi5jb20v
a2VybmVsLXBhdGNoZXMvdm10ZXN0L2Jsb2IvbWFzdGVyL2NpL2NsYXVkZS9SRUFETUUubWQKCkNJ
IHJ1biBzdW1tYXJ5OiBodHRwczovL2dpdGh1Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL2FjdGlv
bnMvcnVucy8zMzgzMzU2NzY3Mg==

--===============4158003370620922930==--
