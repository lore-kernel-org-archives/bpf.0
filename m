Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1C390C89;
	Thu,  2 Jul 2026 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950419; cv=none; b=C86JTFLIz4JDnQj/ziEOnA7wLkCM+r9ZBCpSR51f34zVnczIC8E/EWj0m6L/vupv9Dao+SVCQvqn5b07+fYp9pc1I133FR6T6cipA7j2x+RqWI3RUaqmOQ8PT6wXQU4MFBzOexXV9mnOf1fsTT6AmMwN4HWkKJ5gCQls4GyFlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950419; c=relaxed/simple;
	bh=jqjbeFdIpVRXhFcW3JHkxpTxn2W1/ZUCXSwYSed7u3E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XdgI/g9gQ39CucrxkJSlReLciunrrSvE3A0nf559YF+OEyje7lTSAx5nKtWOOaBtx7aV74pW2gRikT+qjQsBD767rzLKc1lkW9wCGvRhn+Zdqz4sOp3y6PlTAImcebkAaSAdeQcVxRELeaCnLcRDLqC5xI/kr+vOf1Tt/UtXISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMT4kgVW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMT4kgVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5DC1F00ACF;
	Thu,  2 Jul 2026 00:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950418;
	bh=jqjbeFdIpVRXhFcW3JHkxpTxn2W1/ZUCXSwYSed7u3E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QMT4kgVWFI7QkeYtoq9/QtdxTQy6Tq1TAnZHIL2FV1UXIHs9mMQmLu/6QoslqWFyZ
	 tR0QsRtp1v1Pz/uvQwEm35yQzZGF/d/FrXXH11OtuCoSFlVTyky0OtiaFA5UxfESHV
	 3W/UB0QBxqKJsVfQNwrTFkwKx72MsqmbAKDFNZ1mUSRsENGiQ2hRVZkP+7nTQ5S7VC
	 tprrtUY7X2qJnatmnTOhplRhUKrziu8PVGlej2FB8hVL7wWKBsX4PKTtCuO0BB/UcF
	 iB2PrRWhHlVFyz+d4iVA8fXdyiHjMhI1kCFGg+nzURDA1gHan8N+eQqIGkOGdlN85P
	 abQV2U+cDZxdw==
Content-Type: multipart/mixed; boundary="===============4278333573925749137=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <03d8ce102b71c68c30e98be36feaebe539055195c2323ec3b3fd84f157487afd@mail.kernel.org>
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-3-ff8de8782468@rbox.co>
References: <20260702-sockmap-lookup-udp-leak-v3-3-ff8de8782468@rbox.co>
Subject: Re: [PATCH bpf v3 3/4] selftests/bpf: Adapt sockmap update error handling
From: bot+bpf-ci@kernel.org
To: mhal@rbox.co,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,edumazet@google.com,kuniyu@google.com,pabeni@redhat.com,willemb@google.com,davem@davemloft.net,kuba@kernel.org,horms@kernel.org,cong.wang@bytedance.com
Cc: mhal@rbox.co,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  2 Jul 2026 00:00:18 +0000 (UTC)

--===============4278333573925749137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc29j
a21hcF9saXN0ZW4uYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Nv
Y2ttYXBfbGlzdGVuLmMKPiBpbmRleCBjYzBjNjhiYWI5MDcuLmI4NzExOGFhYjdjNCAxMDA2NDQK
PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9zb2NrbWFwX2xp
c3Rlbi5jCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc29j
a21hcF9saXN0ZW4uYwoKWyAuLi4gXQoKPiBAQCAtOTMsOCArOTAsMTIgQEAgc3RhdGljIHZvaWQg
dGVzdF9pbnNlcnRfYm91bmQoc3RydWN0IHRlc3Rfc29ja21hcF9saXN0ZW4gKnNrZWwgX19hbHdh
eXNfdW51c2VkLAo+ICAJZXJybm8gPSAwOwo+ICAJdmFsdWUgPSBzOwo+ICAJZXJyID0gYnBmX21h
cF91cGRhdGVfZWxlbShtYXBmZCwgJmtleSwgJnZhbHVlLCBCUEZfTk9FWElTVCk7Cj4gLQlpZiAo
IWVyciB8fCBlcnJubyAhPSBFT1BOT1RTVVBQKQo+IC0JCUZBSUxfRVJSTk8oIm1hcF91cGRhdGU6
IGV4cGVjdGVkIEVPUE5PVFNVUFAiKTsKPiArCWlmIChzb3R5cGUgPT0gU09DS19TVFJFQU0pIHsK
PiArCQlBU1NFUlRfRVJSKGVyciwgIm1hcF91cGRhdGUiKTsKPiArCQlBU1NFUlRfRVEoZXJybm8s
IEVPUE5PVFNVUFAsICJlcnJubyIpOwo+ICsJfSBlbHNlIGlmIChlcnIpIHsKPiArCQlBU1NFUlRf
T0soZXJyLCAibWFwX3VwZGF0ZSIpOwo+ICsJfQoKVGhpcyBpc24ndCBhIGJ1ZywgYnV0IGNvdWxk
IHRoZSBVRFAgYnJhbmNoIGp1c3QgYmUgYGVsc2UgQVNTRVJUX09LKGVyciwKIm1hcF91cGRhdGUi
KTtgIOKAlCB0aGUgYGlmIChlcnIpYCBndWFyZCBsb29rcyByZWR1bmRhbnQgc2luY2UgQVNTRVJU
X09LIGlzCmEgbm8tb3Agb24gc3VjY2Vzcz8KCj4gIGNsb3NlOgo+ICAJeGNsb3NlKHMpOwo+ICB9
CgpbIC4uLiBdCgoKLS0tCkFJIHJldmlld2VkIHlvdXIgcGF0Y2guIFBsZWFzZSBmaXggdGhlIGJ1
ZyBvciBlbWFpbCByZXBseSB3aHkgaXQncyBub3QgYSBidWcuClNlZTogaHR0cHM6Ly9naXRodWIu
Y29tL2tlcm5lbC1wYXRjaGVzL3ZtdGVzdC9ibG9iL21hc3Rlci9jaS9jbGF1ZGUvUkVBRE1FLm1k
CgpDSSBydW4gc3VtbWFyeTogaHR0cHM6Ly9naXRodWIuY29tL2tlcm5lbC1wYXRjaGVzL2JwZi9h
Y3Rpb25zL3J1bnMvMjg1NTQ5MTExOTI=

--===============4278333573925749137==--
