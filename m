Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FBC409113;
	Fri, 10 Jul 2026 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783724296; cv=none; b=RTMK2P4OVbzvvRWmwi8vikjPyhs4IesrcnAsr+AycP4KUpeaBbv/f0x/3drH0/tGUv5PFz2BydoTuZpc/vyN1Dgz4LN3lpDO8s1LS7/Q0xA/IP124M2+5LX1ARF+Dq9rMEzxZvTMqXS4w4Y/rRgQeNCDcmnC7gLCNEtUBBuNuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783724296; c=relaxed/simple;
	bh=ksk5xHB55C1gKPFKRtj+3WonSiaIUl5BUqL+zBJMUSo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZqRyIewGi3guOFtWU4kQGFWVWkWxrzVl+IXXZNzCcsIDcODPCsNd2exY+GVIOj1HIU5lCMFqCm1/XT3LiaBb9C1ddaE9ZN/QgGbv7/z32zFhQZsuMkSiHmIu9Gh6VGDf9+Yooq+gH5ZGI7zDPtnnPhaoh/osK15rS+n/C3E22BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp/Vt/Q2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp/Vt/Q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19DA1F00A3D;
	Fri, 10 Jul 2026 22:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783724295;
	bh=ksk5xHB55C1gKPFKRtj+3WonSiaIUl5BUqL+zBJMUSo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jp/Vt/Q2RrYsDMxOPy2ypsXz2I5dT3bnIEuw0mvudzhrLevg9vhfBQs8Y7bJrssz2
	 RI9CedBQjEXoNBgomZNwJBA8Rn9jh7sVvEm37zvVIN8QLQO6BBUge18PIbYqnjIUeb
	 eq5p3Wlm+SIor5mSs7aJefo5DXfseHpbHo9kyWGAyRPnAtngMHkiAnB9cN8TA30xxD
	 7RA25DrTVvaegPuAx2/2rYIwLhe87sTSNFCoJshm4SU+yuNH8odUr5yLfkpPhCJSVt
	 mB3uP0YOaaoUm9mNxOBb9OwDzqRf7dqUUi4uBsguND56GSH6HBfpOguwXK83nqAzKK
	 ORQTDKTrAU2nA==
Content-Type: multipart/mixed; boundary="===============7832514225920395158=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <05a45237020c1f414f43eb56439781f439671e039d14d8384e5ed852d52ee3bd@mail.kernel.org>
In-Reply-To: <20260710-selftests-bpf_fixes-v1-4-aa24dfd6f4f9@suse.com>
References: <20260710-selftests-bpf_fixes-v1-4-aa24dfd6f4f9@suse.com>
Subject: Re: [PATCH 4/4] libbpf: Search /lib64 and /lib in resolve_full_path()
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,alexis.lothore@bootlin.com,ihor.solodrai@linux.dev,brauner@kernel.org
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Jul 2026 22:58:14 +0000 (UTC)

--===============7832514225920395158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiAgICAgbGliYnBmOiBTZWFyY2ggL2xpYjY0IGFuZCAvbGliIGluIHJlc29sdmVfZnVsbF9wYXRo
KCkKPgo+ICAgICBhdHRhY2hfcHJvYmUvdXByb2JlLWxpYiBhbmQgdXByb2JlX2F1dG9hdHRhY2gg
c2VsZnRlc3RzIGZhaWwgd2l0aCAiZmFpbGVkCj4gICAgIHRvIHJlc29sdmUgZnVsbCBwYXRoIGZv
ciBsaWJjLnNvLjYiIG9uIG9sZGVyIG5vbi11c3JtZXJnZWQgZGlzdHJvcywgd2hlcmUKPiAgICAg
bGliYy5zby42IGxpdmVzIHVuZGVyIGEgdG9wLWxldmVsIC9saWI2NCBvciAvbGliIHJhdGhlciB0
aGFuIC91c3IvbGliNjQgb3IKPiAgICAgL3Vzci9saWIuIEFkZCAvbGliNjQ6L2xpYiB0byB0aGUg
c2VhcmNoIHBhdGhzLCBhbG9uZ3NpZGUgdGhlIGV4aXN0aW5nCj4gICAgIC91c3IvbGliNjQ6L3Vz
ci9saWIgYW5kIERlYmlhbiBtdWx0aWFyY2ggZW50cmllcy4KPgo+ICAgICBTaWduZWQtb2ZmLWJ5
OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKVGhpcyBsb29rcyBsaWtlIGEg
YnVnIGZpeCBmb3IgdGhlIHNoYXJlZC1saWJyYXJ5IHNlYXJjaCBwYXRoLiAgU2hvdWxkCnRoaXMg
aW5jbHVkZSBhIEZpeGVzOiB0YWc/CgpyZXNvbHZlX2Z1bGxfcGF0aCgpIHdhcyBpbnRyb2R1Y2Vk
IHdpdGggYSBzZWFyY2gtcGF0aCBsaXN0IG9mIG9ubHkKTERfTElCUkFSWV9QQVRIIGFuZCAiL3Vz
ci9saWI2NDovdXNyL2xpYiIsIHdoaWNoIG9taXR0ZWQgdGhlIHRvcC1sZXZlbAovbGliNjQgYW5k
IC9saWIgZGlyZWN0b3JpZXMgZnJvbSB0aGUgc3RhcnQuICBUaGUgbGF0ZXIgYWRkaXRpb24gb2Yg
dGhlCkRlYmlhbiBtdWx0aWFyY2ggL2xpYi88dHJpcGxlPiBwYXRocyBkaWQgbm90IGFkZCAvbGli
NjQ6L2xpYiBlaXRoZXIsIHNvCnRoZSBvbWlzc2lvbiBoYXMgZXhpc3RlZCBzaW5jZSB0aGUgZnVu
Y3Rpb24gd2FzIGNyZWF0ZWQ6CgogIEZpeGVzOiAxY2UzYTYwZTNjMjggKCJsaWJicGY6IGF1dG8t
cmVzb2x2ZSBwcm9ncmFtcy9saWJyYXJpZXMgd2hlbiBuZWNlc3NhcnkgZm9yIHVwcm9iZXMiKQoK
Ci0tLQpBSSByZXZpZXdlZCB5b3VyIHBhdGNoLiBQbGVhc2UgZml4IHRoZSBidWcgb3IgZW1haWwg
cmVwbHkgd2h5IGl0J3Mgbm90IGEgYnVnLgpTZWU6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwt
cGF0Y2hlcy92bXRlc3QvYmxvYi9tYXN0ZXIvY2kvY2xhdWRlL1JFQURNRS5tZAoKQ0kgcnVuIHN1
bW1hcnk6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5z
LzI5MTI3NjY4NzA4

--===============7832514225920395158==--
