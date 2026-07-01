Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2D412265
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934723; cv=none; b=Pp4y2LYiFvf4XpZMy5KdMee8xKw5dlnPH9K6zOv7CdGo8pZYCk3tyWU8PAJr2KB2JjvnnB7iL8Eu68P41TNyU/k79yGNLamo9Uv9y3zFzmx12EOSX7CGIszz1M4uSUv21+joNFVUBAFXJoDViw5OxdxvCvvmgO9W7uaXu01JZtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934723; c=relaxed/simple;
	bh=GH5U9UEASh9zzhvkbdsu3xvCcYA399B4xmJ9NWQT+OU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZbWSOLu3JXWXqSTqWOJwnPpeLMiVxtj51bclGE+dyAw8OXur8tZZlucyRkE1T75NcvXRPI5z0J91/fHAjSIsUESMHhPU71J42/yPft91+3fBm7DMEHozYWQVoHzTVjcCcNcrCEC+sykOkTmBuCQynr0WXgcTdjRr6/jde2E4408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp4jkox2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp4jkox2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34E11F000E9;
	Wed,  1 Jul 2026 19:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934722;
	bh=GH5U9UEASh9zzhvkbdsu3xvCcYA399B4xmJ9NWQT+OU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Jp4jkox2DVMY8nokzn8HpfjkOAMuUvYt5o/wGqErwbHbfTrNG14zNr0iByYygSfgA
	 aEUgdWS595BFzCqU1WQ3iFpqHOLQcWxVwTeNL3bTwBw4/IEOM4aidAh2b49de2xQPi
	 xeOLvkJLgL7EONEe1iFkGMwjexGKxw3yQZ0r0XQwDnovpbWee6B1puiqe0vdTObhrn
	 CBNoQUWiNz8i9aLOw6hBu6d9zHcapeEszEUJRlI1KGYz/F3n8/HCqOZYK2zmPlr8UY
	 tSH9cFm2+sCYn4qGBQju3Hi3pXPOJj8drxObB0ZglelRbnNeBQ1hiugZ4ymyJ/BG3h
	 qpeyAz4wpIp1w==
Content-Type: multipart/mixed; boundary="===============3109401648654284684=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0a2d62da36c9cb3f7b8c33316d99797b42c7e3fe7bfd3822750b5ef4e58c7195@mail.kernel.org>
In-Reply-To: <20260701185235.4516-5-emil@etsalapatis.com>
References: <20260701185235.4516-5-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2 4/5] selftests/bpf: libarena: Add bitmap selftets
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,mattbobrowski@google.com,song@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 19:38:41 +0000 (UTC)

--===============3109401648654284684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBzZWxmdGVzdHMvYnBmOiBsaWJhcmVuYTogQWRkIGJpdG1hcCBzZWxmdGV0cwoKVGhpcyBpc24n
dCBhIGJ1ZywgYnV0IHRoZSBzdWJqZWN0IHNheXMgInNlbGZ0ZXRzIiDigJQgZGlkIHlvdSBtZWFu
CiJzZWxmdGVzdHMiPwoKCi0tLQpBSSByZXZpZXdlZCB5b3VyIHBhdGNoLiBQbGVhc2UgZml4IHRo
ZSBidWcgb3IgZW1haWwgcmVwbHkgd2h5IGl0J3Mgbm90IGEgYnVnLgpTZWU6IGh0dHBzOi8vZ2l0
aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy92bXRlc3QvYmxvYi9tYXN0ZXIvY2kvY2xhdWRlL1JFQURN
RS5tZAoKQ0kgcnVuIHN1bW1hcnk6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9i
cGYvYWN0aW9ucy9ydW5zLzI4NTQxMzQ4MDE2

--===============3109401648654284684==--
