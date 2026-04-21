Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC973BE175
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770203; cv=none; b=WjNyFgdsDP2BnnyF5x4CjxoYPaTYquIcA+FNnkjMHxpi8JwhmDA5loRbINJcZNwbrswe6pEWE7ZViwu5SiWiFcwd+UDwtUu7LjW4uonGDDJJ8Q1n8Mj5iXKdQpKKfnRkHIG7+T8oGFammEte+wo/dHlIU0LogUYkHewfAKxLH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770203; c=relaxed/simple;
	bh=N34aNxI6cjj7gEJUcr9cnUHeKD32/K+XLnrofan3EZY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Lxi7u8AxKgLCiv5QX2moxD2/XTYB+hRrr220WVr4waZ5AG+U4nu2gA/MIUamT7PsvKjpxtWbqE/XU15GQpA2vKmTbWDjRpsf1k0JWNo2xy462qj+ThgWy8WkZdU6AyFs3fME2xc6pkrtVLGrL4myyJQOLH9Wb6IVttkm97rWjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CicIUDg8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CicIUDg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848EBC2BCB0;
	Tue, 21 Apr 2026 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776770202;
	bh=N34aNxI6cjj7gEJUcr9cnUHeKD32/K+XLnrofan3EZY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CicIUDg8gbkwOA+M2hUeRNejyvt2JM4gAUvnfXsPGHDoRopwRBHdE9HxFAn1Y278L
	 e5nxtxNc7kgbXYIECtm0YLJ6ueRYW12eUb8NagiR8ge/HayS4yUgoNwAYOJUZdIdn4
	 pUZ0vV0S/rByOlLwXmkj7yGiDzFP4ioqNyplQ/uVw0pYXLr/sqJKXeyxOY5gQuZ7us
	 Vv3fVTCnabHimcXOtgfBXqeP6s5Dk/J6zLApx4ejdTNTOLJ1t/rlUwLU6r2YZZD+x+
	 /46f2ZJoCu/M1GLTl2JFiVPUCzBKFG4YIartnivU+Zj97ig9TAW8bSgpRTIG/5aRBS
	 8Ci/nY2DaMh1g==
Content-Type: multipart/mixed; boundary="===============2625353504842052436=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dbe2597dc9abde731dd699e878309842163433a4c0860f009233297e65663124@mail.kernel.org>
In-Reply-To: <20260421-cnums-everywhere-rfc-v1-v1-3-8f8e98537f48@gmail.com>
References: <20260421-cnums-everywhere-rfc-v1-v1-3-8f8e98537f48@gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/4] bpf: replace min/max fields with struct cnum{32,64}
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,shung-hsi.yu@suse.com,paul.chaignon@gmail.com,harishankar.vishwanathan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 11:16:42 +0000 (UTC)

--===============2625353504842052436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiAvKiBJbiBzdWNoIGEgY2FzZSBpdCBpcyBwb3NzaWJsZSB0byBpbmZlciBhIG1vcmUgdGlnaHQg
cmVwcmVzZW50YXRpb24gdAo+ICAqIHN1Y2ggdGhhdCDiiIAgdiDiiIggYSwgKHUzMilhIOKIiCBi
OiB2IOKIiCB0Lgo+ICAqLwoKU2hvdWxkIHRoaXMgcmVhZCAnKHUzMil2IOKIiCBiJyBpbnN0ZWFk
IG9mICcodTMyKWEg4oiIIGInPyBBcyB3cml0dGVuLAp0aGUgY29uZGl0aW9uICh1MzIpYSBkb2Vz
IG5vdCBkZXBlbmQgb24gdiwgd2hpY2ggbWFrZXMgdGhlIHF1YW50aWZpZXIKdHJpdmlhbC4gVGhl
IGZ1bmN0aW9uIGNvbXB1dGVzIHRoZSB0aWdodGVzdCByYW5nZSB0IGNvbnRhaW5pbmcgYWxsIHYK
aW4gYSB3aG9zZSBsb3cgMzIgYml0cyBmYWxsIGluIGIuCgpFZHVhcmQgYWNrbm93bGVkZ2VkIHRo
ZSBpc3N1ZSBpbiBoaXMgcmVzcG9uc2Ugb24gTWFyY2ggMTggMjAyNiwgc2F5aW5nCiJZZXMsIGl0
IHNob3VsZCBoYXZlIGJlZW4gKHUzMil2IOKIiCBiIiwgYnV0IHRoZSBjb21tZW50IHdhcyBub3QK
Y29ycmVjdGVkIGluIHRoZSBjdXJyZW50IEFwcmlsIDIxIDIwMjYgcGF0Y2ggdmVyc2lvbi4KClJl
ZmVyZW5jZToKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmLzdmYzA0ZmNhMDQ2N2M1OTk2OWY4
NjU4ZjY5NTViYTdlYzNiNzZiNzMxN2ExZDE3Y2ZhNjRiZGU3ZTNlODcyNDlAbWFpbC5rZXJuZWwu
b3JnLwoKCi0tLQpBSSByZXZpZXdlZCB5b3VyIHBhdGNoLiBQbGVhc2UgZml4IHRoZSBidWcgb3Ig
ZW1haWwgcmVwbHkgd2h5IGl0J3Mgbm90IGEgYnVnLgpTZWU6IGh0dHBzOi8vZ2l0aHViLmNvbS9r
ZXJuZWwtcGF0Y2hlcy92bXRlc3QvYmxvYi9tYXN0ZXIvY2kvY2xhdWRlL1JFQURNRS5tZAoKQ0kg
cnVuIHN1bW1hcnk6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9u
cy9ydW5zLzI0NzE3OTY4ODM2

--===============2625353504842052436==--
