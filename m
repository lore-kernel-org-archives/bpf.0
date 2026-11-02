Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619311;
	b=bOp3Hyl8GTT7+wgMOQlJ8+k9aCCjGLEEB7UytbNXBr/MP0DJcHtXensDJRAsq/6iYs2A
	 OY4C77UepuEbooJV1dEau9zLJ2yYPa64q06mPjzpiOswiS98B6kWOfRAIFnr9PANWn2Lb
	 MKdgj8dao+0Y4dJ4FWO7N0tqimg5CoKg4PdBGNlBrW9iOYpcp4dpzeRpSf6gMhV1JNkVM
	 2KLyvCcCyHYeXZZmDZvZZP9BigzvBzWKYfN6u/NgK+5QYptM3Hs5K101A9ZRHi5oVCTgA
	 Cjbg0s5jBDGrJDUj4Mwt6vPyZV7C+hMDUVJszE4Df3BidRatetcsOMWszKr478qowfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619311;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=+eMQsb7jKvzR3qa46RTiK3hcC6y5Wq2i2fejLDdpUFg=;
	b=EDjtWU0mE8YAO9RIg3gIitoLJ7gSHWlUQm9Rk7RQxq0nx+WOtrDFOM/CNYZv6fU3wWWt
	 NqQLToyg7FfoACTyHY09ffbTGrpgZrzb+egBaxL+El2j9GauLplsiMak0r1aP29ixPcUi
	 4NtjiHqT1G3DyW/ODIKBnTPdmkM+1dy9nd2i1Lw63iLebhlXCZPw3XvS3gzYGXMX7Jy6a
	 y+Z8zmaF29q40EABJ7CJwx0oKAEPhpqOw/dt3rI0GrL/8uOc+rjIOZFuWZsqrRD3C/8w4
	 6HT92ZGJiX1LC2AjiKiiutWW6a6izKLTqS101dWhPPnvil+iPvP0RAuNbj5N98kFWEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJZd5cZy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA45606A326;
	Mon,  2 Nov 2026 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJZd5cZy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DED61F00A17;
	Mon,  2 Nov 2026 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619310;
	bh=+eMQsb7jKvzR3qa46RTiK3hcC6y5Wq2i2fejLDdpUFg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RJZd5cZyG8fIiBsSR7MPy0bzu+OEUJK3Np1RxIj/aPigoTr5exmljLk7zhQSU/VcJ
	 KjMJuyEmy9e4BS3TOCe2QM5xYn6vMZMCZhweBcHESDnhdBPlnFdncp2I8B/q/zis2I
	 MXFZUAPZtH3LsfZE4TTrgaeAvL5SamPZcRncgS4N1x/j42rdXo9VF18gTQyu/yJKwD
	 vvpBl1VPDjoSbEQhqFEj0PtqZ6tW+alYwnSmY4GGNdgeZlZVMER13myvWQ8AdbjqBW
	 VyZir4nK62faFBg37FyFe4xVxpYxjnwrSXd756hMepM7UM1R8of78YEmvtoZZrVA0y
	 GsAZAp/Y/Hh9Q==
Content-Type: multipart/mixed; boundary="===============5986803388787019227=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c634f73d0398f7731ec992fdad517fd5f48c97d3190ccaf12945b9d46c873f17@mail.kernel.org>
In-Reply-To: <20261102111509.357269-2-u.kleine-koenig@baylibre.com>
References: <20261102111509.357269-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH bpf-next] bpf: Use "new" URL to show if net-next is open
From: bot+bpf-ci@kernel.org
To: u.kleine-koenig@baylibre.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,corbet@lwn.net
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,skhan@linuxfoundation.org,rdunlap@infradead.org,bpf@vger.kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  2 Nov 2026 11:35:10 +0000 (UTC)

--===============5986803388787019227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Use "new" URL to show if net-next is open

TL;DR: Nit in the docs URL update: the unchanged text still credits David S.
Miller for the status page, which may be inaccurate for the new
netdev.bots.linux.dev host; consider rewording or noting it in the changelog.

> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
> index 4729efd657c3..7f1531f0848c 100644
> --- a/Documentation/bpf/bpf_devel_QA.rst
> +++ b/Documentation/bpf/bpf_devel_QA.rst
> @@ -243,7 +243,7 @@ a ``v*-rc1`` after the merge window, we continue processing of bpf-next.
>  For non-subscribers to kernel mailing lists, there is also a status
>  page run by David S. Miller on net-next that provides guidance:
>
> -  http://vger.kernel.org/~davem/net-next.html
> +  https://netdev.bots.linux.dev/net-next.html

This isn't a bug, but the sentence introducing the URL is unchanged:

  page run by David S. Miller on net-next that provides guidance:

That attribution matched the old ~davem page on vger.kernel.org.  Is it
still accurate for the new host?

Commit 524500873802 ("docs: netdev: update the netdev infra URLs"), which
the changelog cites, describes netdev.bots.linux.dev as a new DNS entry for
the netdev infrastructure, and Documentation/process/maintainer-netdev.rst
refers to the same page without naming David S. Miller.

Should the attribution be dropped or reworded, for example "a status page
maintained by the netdev infrastructure", or should the changelog mention
that the page is still run by David S. Miller?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41436735330
--===============5986803388787019227==--
