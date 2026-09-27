Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76AD3DD85E;
	Sun, 27 Sep 2026 23:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553327; cv=none; b=ZCEr7Hq7Mu5faBSjHSL2hNKxfB4v1cA4UT/Biqg3mtX/QP4S8vXl5JxT3RgUZSyW14CGT3mI2kuZPMuQZWaplSQBdd06TaXV4IMviSOtlBz63nVuZP1qUXu5UmDdneAhPCFdoXlJBIgBizXS8pYjcNjkT3mOgYiuVkwWx/cVAvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553327; c=relaxed/simple;
	bh=E1uHkH2WiXAgc7R6ZJWhqM8g4LhOU/R6TmwrsAaFi1A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cyCe7JU+TAK7q9dSTG2KJCY6AfZ4aYWtSG8nH9X7uXmUB1BVamwioO9mtAhukeqricE+n4GeqIeyNZFm7UUTsmTBxj2YaP3q13yr/GdojVKZBabF0+CVEXjBVSSobar2RTwJzSKQGeMD1HR1c9IOe9zEd6dlRmJy8Yil2zoPVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUJro4Nh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUJro4Nh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F2E1F000FF;
	Sun, 27 Sep 2026 23:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790553326;
	bh=E1uHkH2WiXAgc7R6ZJWhqM8g4LhOU/R6TmwrsAaFi1A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LUJro4NhDYoubaTMJs/UR6RAZuKOwvse2Ggt/Gi6Al4srnY7ueUZHS/Knh2DB/Dvw
	 Nos9dO+6FBRkgde4ctUrcQ6Cg6ydaQpyg5hIjEUXK2IfTrGyfkLMfj5Bg3UekV3yWw
	 vTzdo0zvMff1g3qns/pyBZvK8J+RnqoRlDo8XevuiVYnhnWUSH2PazbN3Og6mkWUHd
	 5UMOjxAPZXRrfKTnTzCQcZC0Ka/vfeUsztG/LMMWoqPf3DYn6OoWdLSB6JVEH8trMZ
	 99ZPw/4BIADnsDjAU9QzllMvbaedkQp5jpzMNFUROzCfMDqrrIks1OzKY882ucNuH2
	 c+FifocUaNEvA==
Content-Type: multipart/mixed; boundary="===============6793949663222856225=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02e24e11e7c406888fd5751a1f7341fdb6271ed894d8a5f7946092e97d610339@mail.kernel.org>
In-Reply-To: <20260927230822.417683-1-omermetekaya0@gmail.com>
References: <20260927230822.417683-1-omermetekaya0@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_loop() depth check to use 32-bit max for nr_loops
From: bot+bpf-ci@kernel.org
To: omermetekaya0@gmail.com,ast@kernel.org,daniel@iogearbox.net
Cc: john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,omermetekaya0@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 23:55:25 +0000 (UTC)

--===============6793949663222856225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBicGY6IEZpeCBicGZfbG9vcCgpIGRlcHRoIGNoZWNrIHRvIHVzZSAzMi1iaXQgbWF4IGZvciBu
cl9sb29wcwo+Cj4gYnBmX2xvb3AoKSB0YWtlcyBhIHUzMiBucl9sb29wcyBhcmd1bWVudC4gQXQg
cnVudGltZSwgbnJfbG9vcHMgaXMKPiBwYXNzZWQgYXMgYSB1MzIgdmlhIHRoZSBCUEZfQ0FMTF80
IHNpZ25hdHVyZToKPgo+ICAgICBCUEZfQ0FMTF80KGJwZl9sb29wLCB1MzIsIG5yX2xvb3BzLCAu
Li4pCj4KPiBIb3dldmVyLCB0aGUgdmVyaWZpZXIgY29tcGFyZXMgY2FsbGJhY2tfZGVwdGggKHUz
MikgYWdhaW5zdAo+IHJlZ191bWF4KCksIHdoaWNoIHJldHVybnMgdGhlIDY0LWJpdCB1cHBlciBi
b3VuZCBvZiBSMS4gSWYgdGhlIHVwcGVyCj4gMzIgYml0cyBvZiBSMSBhcmUgc2V0LCByZWdfdW1h
eCgpIGNhbiBiZSBVNjRfTUFYLCBjYXVzaW5nIHRoZSBkZXB0aAo+IGNoZWNrIHRvIHJlbWFpbiBp
bmVmZmVjdGl2ZSBhbmQgdHJpZ2dlcmluZyBleGNlc3NpdmUKPiBwdXNoX2NhbGxiYWNrX2NhbGwo
KSBpbnZvY2F0aW9ucyB1bnRpbCB0aGUgY29tcGxleGl0eSBsaW1pdCBpcyBoaXQuCj4KPiBVc2Ug
cmVnX3UzMl9tYXgoKSBpbnN0ZWFkLCBtYXRjaGluZyB0aGUgMzItYml0IHJhbmdlIGFjdHVhbGx5
IHVzZWQgYnkKPiBicGZfbG9vcCgpIGFuZCBhdm9pZGluZyB1bm5lY2Vzc2FyeSBzdGF0ZSBleHBs
b3JhdGlvbiB3aGVuIFIxIGhhcyBhCj4gbGFyZ2UgNjQtYml0IHJhbmdlLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogw5ZtZXIgTWV0ZSBLYXlhIDxvbWVybWV0ZWtheWEwQGdtYWlsLmNvbT4KClRoZSBjaGFu
Z2Vsb2cganVzdGlmaWVzIHRoZSBzd2l0Y2ggdG8gcmVnX3UzMl9tYXgoKSBieSBzYXlpbmcgdGhl
IHJ1bnRpbWUKb25seSBldmVyIHVzZXMgdGhlIGxvdyAzMiBiaXRzIG9mIFIxICgibnJfbG9vcHMg
aXMgcGFzc2VkIGFzIGEgdTMyIHZpYSB0aGUKQlBGX0NBTExfNCBzaWduYXR1cmUiLCAibWF0Y2hp
bmcgdGhlIDMyLWJpdCByYW5nZSBhY3R1YWxseSB1c2VkIGJ5CmJwZl9sb29wKCkiKS4KClRoYXQg
aG9sZHMgZm9yIHRoZSBvdXQtb2YtbGluZSBoZWxwZXIgaW4ga2VybmVsL2JwZi9icGZfaXRlci5j
LCBidXQgbm90CmZvciB0aGUgaW5saW5lZCB2YXJpYW50LiBXaGVuIGxvb3BfaW5saW5lX3N0YXRl
LmZpdF9mb3JfaW5saW5lIGlzIHNldAooZmxhZ3Mga25vd24gemVybyBhbmQgYSBzaW5nbGUgY2Fs
bGJhY2sgc3VicHJvZyksIHdoaWNoIGlzIHRoZSBjb21tb24gY2FzZSwKYnBmX29wdGltaXplX2Jw
Zl9sb29wKCkgcmVwbGFjZXMgdGhlIGNhbGwgd2l0aCBpbmxpbmVfYnBmX2xvb3AoKSBpbgprZXJu
ZWwvYnBmL2ZpeHVwcy5jLiBUaGF0IGNvZGUgd29ya3Mgb24gdGhlIGZ1bGwgNjQtYml0IFIxOgoK
ICAgIGluc25fYnVmW2NudCsrXSA9IEJQRl9KTVBfSU1NKEJQRl9KTEUsIEJQRl9SRUdfMSwgQlBG
X01BWF9MT09QUywgMik7CiAgICBpbnNuX2J1ZltjbnQrK10gPSBCUEZfTU9WMzJfSU1NKEJQRl9S
RUdfMCwgLUUyQklHKTsKICAgIC4uLgogICAgaW5zbl9idWZbY250KytdID0gQlBGX01PVjY0X1JF
RyhyZWdfbG9vcF9tYXgsIEJQRl9SRUdfMSk7CiAgICAuLi4KICAgIGluc25fYnVmW2NudCsrXSA9
IEJQRl9KTVBfUkVHKEJQRl9KR0UsIHJlZ19sb29wX2NudCwgcmVnX2xvb3BfbWF4LCA1KTsKCkZv
ciBleGFtcGxlLCBSMSA9IDB4MTAwMDAwMDA1IHJ1bnMgdGhlIGNhbGxiYWNrIDUgdGltZXMgdGhy
b3VnaCB0aGUgaGVscGVyCmJ1dCByZXR1cm5zIC1FMkJJRyB3aXRoIHplcm8gaXRlcmF0aW9ucyB3
aGVuIGlubGluZWQuCgpUaGUgcGF0Y2ggaXMgc3RpbGwgc291bmQgZm9yIGJvdGggdmFyaWFudHMu
IEFueSBSMSB3aXRoIHVwcGVyIGJpdHMgc2V0CmZhaWxzIHRoZSA2NC1iaXQgUjEgPD0gQlBGX01B
WF9MT09QUyBjaGVjayBpbiB0aGUgaW5saW5lZCBjb2RlLCBhbmQgYW55IFIxCnRoYXQgcGFzc2Vz
IGl0IGVxdWFscyAodTMyKVIxIDw9IGNudW0zMl91bWF4KHIzMikuIEhvd2V2ZXIsIHRoZSBjaGFu
Z2Vsb2cKZG9lcyBub3QgbWFrZSB0aGF0IGFyZ3VtZW50LCBhbmQgaXRzIHdvcmRpbmcgaW1wbGll
cyB0aGVyZSBpcyBhIHNpbmdsZQozMi1iaXQgcnVudGltZSBzZW1hbnRpYy4KCkZvciBhIGNoYW5n
ZSB0aGF0IHJlZHVjZXMgaG93IG1hbnkgY2FsbGJhY2sgaXRlcmF0aW9ucyB0aGUgdmVyaWZpZXIK
c2ltdWxhdGVzLCB0aGUgc291bmRuZXNzIGFyZ3VtZW50IGZvciB0aGUgaW5saW5lZCBwYXRoIHNo
b3VsZCBiZSBpbiB0aGUKY29tbWl0IG1lc3NhZ2UuIEEgc2VsZnRlc3Qgd2hlcmUgUjEgaGFzIHVu
a25vd24gdXBwZXIgMzIgYml0cyBhbmQgYm91bmRlZApsb3cgMzIgYml0cyB3b3VsZCBhbHNvIGhl
bHAsIGZvciBleGFtcGxlIGEgSk1QMzIgYm91bmQgb24gYSA2NC1iaXQgdmFsdWUuCgpDb3VsZCB0
aGUgY2hhbmdlbG9nIGJlIHVwZGF0ZWQgdG8gY292ZXIgdGhlIGlubGluZWQgYnBmX2xvb3AoKSBj
YXNlPwoKCi0tLQpBSSByZXZpZXdlZCB5b3VyIHBhdGNoLiBQbGVhc2UgZml4IHRoZSBidWcgb3Ig
ZW1haWwgcmVwbHkgd2h5IGl0J3Mgbm90IGEgYnVnLgpTZWU6IGh0dHBzOi8vZ2l0aHViLmNvbS9r
ZXJuZWwtcGF0Y2hlcy92bXRlc3QvYmxvYi9tYXN0ZXIvY2kvY2xhdWRlL1JFQURNRS5tZAoKQ0kg
cnVuIHN1bW1hcnk6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9u
cy9ydW5zLzM2MzU4NjkwMzI2

--===============6793949663222856225==--
