Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04DC33B6E3
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853904; cv=none; b=TsyC2G99eUX3YkdCBmYLhzZ1/GkpkJ16OrI3Yd+R3m+fu1ic8m5eu6J3+fqtR763PKCaDYtwzBg5a0D8clzlD1iGoc4Rk1yuEoz9SElxeecoJtzBG24fi5mUZu/eaeZEt8iVMvRKyLE7BUoQhI4v5E4aNQJHAEIRL2L+IgLKDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853904; c=relaxed/simple;
	bh=WHrrJnUA1Gwb1fi90Z02txD+a9lWPjigxap6iidN4Dg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OdQ3TRV+e/J2BdMi0o+9KQLr83iysMNGzN+zdf40s51cyKNND4HvWnJH6b9/8IDmWPjioZIawSHosXg16EN21vRsaAunwT6UmLWC2c7TIv7RLVOA450Ha+r974pmY5O+jAR19gBRuSib2jIPP/oaRnErOK1RParCncKxzvbaU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYFK390D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYFK390D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2295AC19421;
	Wed, 18 Mar 2026 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773853904;
	bh=WHrrJnUA1Gwb1fi90Z02txD+a9lWPjigxap6iidN4Dg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZYFK390D0Tm4LAIsnkYZ82NnkArU7lhlPwjw4HyRvc+Hj8o+yjsOa1h4zhTs0mNd5
	 4GQpEIbT7QbaQGysIcfwG2mmjCkj+mKkMjz4jWk7rwamHmP00PtFM8R8hhvu5/7iGs
	 xNEsrgr7naCNj26s7vMtk3/vdvcQvs91Z1SKSpkCwbZU0yJ4g5IGglqxDtu8F6F4Il
	 Rg1JENTCllIJ/elFyF5B4zcgF4RY/7j8sLuuOV+SG9h6BJY0z9b6YpJs1y0qgfboOP
	 bSGfT7amkzCOfMtXi9R4FkSWTMvQO2eJsIMAhBv0IOy7uHq5zy2L292qdKM/WGqgLu
	 VCc3YVmEaph4Q==
Content-Type: multipart/mixed; boundary="===============5251731519004381388=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7fc04fca0467c59969f8658f6955ba7ec3b76b7317a1d17cfa64bde7e3e87249@mail.kernel.org>
In-Reply-To: <20260318-cnum-sync-bounds-v1-1-1f2e455ea711@gmail.com>
References: <20260318-cnum-sync-bounds-v1-1-1f2e455ea711@gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 1/4] bpf: representation and basic operations on circular numbers
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,shung-hsi.yu@suse.com,paul.chaignon@gmail.com,harishankar.vishwanathan@gmail.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 18 Mar 2026 17:11:44 +0000 (UTC)

--===============5251731519004381388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9jbnVtLmMgYi9rZXJuZWwvYnBmL2NudW0uYwo+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwMDAwLi5kYTUwYTQwZTc5YWMKPiAt
LS0gL2Rldi9udWxsCj4gKysrIGIva2VybmVsL2JwZi9jbnVtLmMKClsgLi4uIF0KCj4gKy8qCj4g
KyAqIFN1cHBvc2UgJ2EnIGFuZCAnYicgYXJlIGxhaWQgb3V0IGFzIGZvbGxvd3M6Cj4gKyAqCj4g
KyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDY0LWJpdCBudW1iZXIgYXhpcyAtLS0+Cj4gKyAqCj4gKyAqIE4qMl4zMiAgICAgICAgICAg
ICAgICAgICAoTisxKSoyXjMyICAgICAgICAgICAgICAgIChOKzIpKjJeMzIgICAgICAgICAgICAg
ICAgKE4rMykqMl4zMgo+ICsgKiB8fC0tLS0tLXwtLS18PT09PT18LS0tLS0tLXx8LS0tLS0tLS0t
LXw9PT09PXwtLS0tLS0tfHwtLS0tLS0tLS0tfD09PT09fC0tLS18LS18fAo+ICsgKiAgICAgICAg
IHwgICB8PCBiID58ICAgICAgICAgICAgICAgICAgIHw8IGIgPnwgICAgICAgICAgICAgICAgICAg
fDwgYiA+fCAgICB8Cj4gKyAqICAgICAgICAgfCAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIHwKPiArICogICAgICAgICB8PC0t
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSBhIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSstLS0+fAo+ICsgKiAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+ICsgKiAgICAgICAgICAgICB8PC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tIHQgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+fAo+ICsgKgo+
ICsgKiBJbiBzdWNoIGEgY2FzZSBpdCBpcyBwb3NzaWJsZSB0byBpbmZlciBhIG1vcmUgdGlnaHQg
cmVwcmVzZW50YXRpb24gdAo+ICsgKiBzdWNoIHRoYXQg4oiAIHYg4oiIIGEsICh1MzIpYSDiiIgg
YjogdiDiiIggdC4KPiArICovCgpTaG91bGQgKHUzMilhIGJlICh1MzIpdiBoZXJlPyAgQXMgd3Jp
dHRlbiwgdGhlIGNvbmRpdGlvbiAodTMyKWEgZG9lcwpub3QgZGVwZW5kIG9uIHYsIHdoaWNoIG1h
a2VzIHRoZSBxdWFudGlmaWVyIHRyaXZpYWwuICBUaGUgZnVuY3Rpb24KY29tcHV0ZXMgdGhlIHRp
Z2h0ZXN0IHJhbmdlIHQgY29udGFpbmluZyBhbGwgdiBpbiBhIHdob3NlIGxvdyAzMiBiaXRzCmZh
bGwgaW4gYiwgc28gdGhlIHNwZWNpZmljYXRpb24gc2hvdWxkIHJlYWQ6CgogIHN1Y2ggdGhhdCDi
iIAgdiDiiIggYSwgKHUzMil2IOKIiCBiOiB2IOKIiCB0LgoKCi0tLQpBSSByZXZpZXdlZCB5b3Vy
IHBhdGNoLiBQbGVhc2UgZml4IHRoZSBidWcgb3IgZW1haWwgcmVwbHkgd2h5IGl0J3Mgbm90IGEg
YnVnLgpTZWU6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy92bXRlc3QvYmxvYi9t
YXN0ZXIvY2kvY2xhdWRlL1JFQURNRS5tZAoKQ0kgcnVuIHN1bW1hcnk6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzIzMjU2MzQwMjg3

--===============5251731519004381388==--
