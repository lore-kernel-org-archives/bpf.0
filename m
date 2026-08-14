Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB07415F3B;
	Fri, 14 Aug 2026 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693777; cv=none; b=UQ41PW25quiwyRPd1zbpoHRx+YqmdFHRrALYe4UE4wueCUtHYbfY6BJg87xHMzeJMSbHMIJRZ9ElzZpKmB+roXNZ2jTYb3kMUXdwAf8uu/4OTkfo1GoqdYmtgThwG0/3ChHrrTbsIb9Gs4HOTWtmnFa61iUObObNBUEWPnWkNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693777; c=relaxed/simple;
	bh=IGcJH8MziLTIkppT7J9/sjWmFByS19SX5etMRNc7h7k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ylu4/6GsyErY2nHRTCSoyDx2r03rU/K0qkEbBIzzbWPb9IUot3WFsXjR1sFFRbfPL7nNtcbqItZy1jGGjwT26xEXV/oYNqdJALcVu36V9UgBcA+yN5En5mvA8q4+uKANzguATdK/T5pC+ZjNXGyk7J+OWvUkLdJxRofaOCnfGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8HpFqk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8HpFqk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BA31F000E9;
	Fri, 14 Aug 2026 07:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786693772;
	bh=IGcJH8MziLTIkppT7J9/sjWmFByS19SX5etMRNc7h7k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=J8HpFqk6s3VTvxtwb1IQ0zddEorS8IiJxIqUOwcdYHmYqaZcJWggbRyJJlbbJlWNM
	 f9L0rwUBPdkXuvCBRapw6PMhcMVA0KSuSSxbmcx1lx6YLBafeJ27RE1Nama+BXy3mC
	 B+mRXkCJHdVd5ecUdzi8FcuLbTIM8CBYofYRUopdP2cfO2niBt9uply5sBrRmj7f0e
	 H6ztXRjiMH0djRlzTsZhBNM0hVA0GcqPKMOoZkJUeSm3OE/NwPfInP4OjcWdwtvKyT
	 sFzKGqKgAm/1ogOqj5Kd1ys6r+JGQ+Sog/1ZPtgAxH8ndTrpSaXQUR7G+6u2VXLTma
	 pQUfsclzwGLNA==
Content-Type: multipart/mixed; boundary="===============1755425199160881240=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a93509e0a9d3c7761982e98a4cea76d2e493121794c410719d9d8f36efc79b6e@mail.kernel.org>
In-Reply-To: <20260814-tc_tunnel_flaky-v5-1-5b93d030c42c@bootlin.com>
References: <20260814-tc_tunnel_flaky-v5-1-5b93d030c42c@bootlin.com>
Subject: Re: [PATCH bpf v5 1/2] bpf/selftests: fix comment style in network_helpers.c
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,ihor.solodrai@linux.dev
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 07:49:31 +0000 (UTC)

--===============1755425199160881240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBicGYvc2VsZnRlc3RzOiBmaXggY29tbWVudCBzdHlsZSBpbiBuZXR3b3JrX2hlbHBlcnMuYwo+
Cj4gQlBGIHN1YnN5c3RlbSByZXF1aXJlcyBtdWx0aS1saW5lIGNvbW1lbnRzIHRvIGhhdmUgdGhl
IG9wZW5pbmcgLyogc3RhcnQKPiBvbiBpdHMgb3duIGxpbmUuCj4KPiBVcGRhdGUgbXVsdGktbGlu
ZSBjb21tZW50cyBpbiBuZXR3b3JrX2hlbHBlcnMuYyB0byBmb2xsb3cgdGhpcwo+IHJlcXVpcmVt
ZW50Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p
IDxhbGV4aXMubG90aG9yZUBib290bGluLmNvbT4KClRoaXMgaXNuJ3QgYSBidWcsIGJ1dCB3b3Vs
ZCAnc2VsZnRlc3RzL2JwZjonIGJlIHRoZSBleHBlY3RlZCBzdWJqZWN0CnByZWZpeCBoZXJlPyAg
VGhlIHJlc3Qgb2YgdGhlIGRpcmVjdG9yeSB1c2VzIHRoYXQgY29udmVudGlvbiAoMzUxCm9jY3Vy
cmVuY2VzIG9mICdzZWxmdGVzdHMvYnBmOicgdmVyc3VzIDAgb2YgJ2JwZi9zZWxmdGVzdHM6JyBp
biB0aGUKcmVjZW50IGhpc3RvcnkpLCBhbmQgdGhlIGZvbGxvd2luZyBwYXRjaCBpbiB0aGlzIHNl
cmllcyB1c2VzCidzZWxmdGVzdHMvYnBmOicuCgoKLS0tCkFJIHJldmlld2VkIHlvdXIgcGF0Y2gu
IFBsZWFzZSBmaXggdGhlIGJ1ZyBvciBlbWFpbCByZXBseSB3aHkgaXQncyBub3QgYSBidWcuClNl
ZTogaHR0cHM6Ly9naXRodWIuY29tL2tlcm5lbC1wYXRjaGVzL3ZtdGVzdC9ibG9iL21hc3Rlci9j
aS9jbGF1ZGUvUkVBRE1FLm1kCgpDSSBydW4gc3VtbWFyeTogaHR0cHM6Ly9naXRodWIuY29tL2tl
cm5lbC1wYXRjaGVzL2JwZi9hY3Rpb25zL3J1bnMvMzE3Nzk1MTAwMDM=

--===============1755425199160881240==--
