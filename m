Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795801639;
	b=vOQIfU7YBrmp2K3f1XpdTonVhi32IH6dkN6sCosjhHB+aOVjJfaaUW7E2zFFgleoOAHW
	 0bDq0/0TresDJROuASrk9P1pXzNJf82i8IMK80/fA/2xmQsfZ16UIzkDAK6faFusoSGvd
	 ljPADEWzgf3Vv4OnRTSGGsxMIzhkf3JtoZLjsIBe5sGGfiszYfJT2Ux+vz5GW+qJcam79
	 5Lv3q4cAN4jm0Zyn3vuvaLd4Ie8Ji5lTmbkagzRdms9cs6H/UlLIl+axzQVuR/vQIMAgu
	 CXRrZN4sDi9l7au1aLl1V3oDIl7dp2vKRhX1ohoIGa2vxKXXr4CnWpF22ZL9u1o+lig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801639;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xsCAkQrZqOlyqp+K6FyPHaXXiUliiHj9e9iQ/EMedeI=;
	b=bbJfMzSibVH58srMwfvn5aLTslIBlRwdlcm8oYBVaKTUQm52d3cjPNbprFG2bOwru9x9
	 CdkJHEBbTPOEC0737BQcI38N4C2wEAOlXvBA3ohUDbR1msEd6Gy7fY3qS9feTdEHM7GQG
	 oBad1XsKe6GLSd/cfxEr6C8Yn1Ob/d4QmGyHgaotv5awo5+WGZuzXlJUytklnmJFomnUY
	 ugoNI5iVyd3aRYYKPCuxffZl//0uFX8uwWXY/tgAs8dATnNd6DzCzVc93W4txYma6UwVX
	 T5lgKRXNHmfBcuTLdlXlM0oBlBEAoz5+gXZXiUMj6BUPFbBIOACwb8XcC0TYjCyZ0Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwFZ6jy5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389D606A31C;
	Fri, 27 Nov 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwFZ6jy5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22C01F00893;
	Fri, 27 Nov 2026 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795801639;
	bh=xsCAkQrZqOlyqp+K6FyPHaXXiUliiHj9e9iQ/EMedeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DwFZ6jy5i7v0Ce0szyaN47D+IYRGf2KxZHgass/2jatppBSNDhzbCNMg/dOAsvrDm
	 LIxYonfPd6ldLs58BdFVkaiXXvOUqU4pY69Lg7nV0uuNwraX4n12BAPxP0KWhRiKWX
	 uVvM3snSL3nMhGVtVm7om2KLrLvCzm18x1Lp18lGljJsrzaN6bRiGIKePxYoXg/pH/
	 /aPhMjVNI9E0a9aNWal4NDJv6TlKfwSUVGlHUrR3rLd/UZO4BNDKNaE4ooNOEoUD3R
	 wOE8mx7L4Ei6V5Awp7KzQ1e71EfbWSWQVGu/mSLN8Xxq8mNWcmkmziXLXkH6c2iS71
	 crvqyaUKM1Kdg==
Date: Fri, 27 Nov 2026 17:47:10 +0000
From: Will Deacon <will@kernel.org>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxwell Bland <mbland@motorola.com>,
	Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf] bpf, arm64: Fix jited line info off by kCFI hash
Message-ID: <awnCHo7Y0erVfoQu@willie-the-truck>
References: <20260925-b4-arm64-bpf-linfo-cfi-v1-1-e930ab335170@linux.dev>
 <awmhAIbMV7qo608O@willie-the-truck>
 <20261127-jf-arm64-bpf-linfo-reply-will-r2-648665e850e0@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127-jf-arm64-bpf-linfo-reply-will-r2-648665e850e0@linux.dev>

On Fri, Nov 27, 2026 at 05:31:35PM +0000, Jose Fernandez (Anthropic) wrote:
> On Fri, Nov 27, 2026 at 03:25:52PM +0000, Will Deacon wrote:
> > I'm just chasing up old patches sitting around in my inbox and noticed
> > this one. It doesn't _look_ like it's been applied anywhere. Is it still
> > needed?
> 
> No, please drop it. v2 fixed this in the BPF core and landed in
> v7.4-rc2 as commit 3e4279dc5144 ("bpf: Fix jited line info off by the
> CFI preamble").

Ah, thanks for the pointer. That looks like a much nicer fix :)

Will
