Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965020;
	b=vyzUyPF1LQauStylwp7KhsjSwBD56uxT99HpVDqFnHvjSmHWrDpks9HjHVs9AMzVcPqL
	 R+j0Gp6bRKWEkh7JFuq+4UJHbU5kUK3BEmjcUlkdsDW/hQjykJ3QnxOFGopJCfuVG6+ez
	 4CD0rnYZAzeSL+HJg+LgYgtphYrsvUMZHeXKLi5JsFcVLGdW2ymanUtZWzunDgDmh0bn5
	 C4IN4kBdGk+2bRf+lANt0IWjYmBpPWdLo9RPdboexxkdGuirdz2/pFiwdsjezsboYR+Ls
	 8e2PwFwCqUfd8MpQuCahS+arwRbw2h6zBqXodJb0HpCNHw5VEcQSNaJYJ0PDOR6rYDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965020;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LsG010wFX4LfYov4otAxRQz5shuNP8OrzTqH27+uU04=;
	b=Oi7sr+2aOe6qH1Wp7+Q4qhjjwutwdxTUmapzX2a7oFAGqFgW1tKE24ca2G83AXW/mK9/
	 LOxVIE2PrBxS0Ldqta9QsmwVHKziHOaNlAWzft8REz9hYagyv9WGPzrpfIzBbKx3mMYmf
	 5nzGurWeBPtDhjFbwR1R/cch3STLrbdASfNMtVjR1W52F82KZGkSv9ylYVI3OGaFYSPpi
	 IG1G+N2hxOA9YbjWAjj0RkcdcuCMin9TkhHHi3hP0my/UyYY3AypU4F2X3RLECdnYXmg+
	 cevSGsjdu/Ri9YA893M3TdkKygs51CmueqEgqyTbJbpkmfUfTGABxSigoD1W1LDoTGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=hxhcxg8X;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=8L6Av8tC;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D3606C6C9;
	Fri,  6 Nov 2026 11:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E12D3606C6C9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=hxhcxg8X;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=8L6Av8tC
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793964997; bh=LsG010wFX4LfYov4otAxRQz
	5shuNP8OrzTqH27+uU04=; b=hxhcxg8XWNsXD/4lRzhQdmLZ1jEz2JvpjFlg3ElaO6tO8MkKm6
	1Y827wB2HE7IPOkXz3M5RJIvcesXDneasFotHKaDVWrHYeLuKg1Esbvmuiqp8BNFZ8XBJw7eRYF
	c2abZRsF8mZjUQsx96+ojnhj2JbqjHfA3IlBSrpxJ0GjttTeiUBfOfCV6Za7vTp1v1/w6RrI76V
	TVN4uyqAZADw2H/nZKUVEzsRpg81HwnfEnuXNQIvulDFG8Twhaok+Cui5X/nRlgqpip8FaN9nvE
	nsNzuNwGzJIe8Lp9wg5Dn+caI6zFEXqivuJLsPyxvfXHnKDVckKPybHpjUeZhFdZh3g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793964997; bh=LsG010wFX4LfYov4otAxRQz
	5shuNP8OrzTqH27+uU04=; b=8L6Av8tCGUyhtOYwdYpuuQdXqMVQ/3ELRWVGKb36u5Msmbmiti
	5ab8ryPVklCkEKnAkgw65PGTxw7udUqnpJAQ==;
Date: Fri, 06 Nov 2026 11:36:36 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Andrea Parri <parri.andrea@gmail.com>, Kees Cook <kees@kernel.org>
CC: Tycho Andersen <tycho@kernel.org>, Cong Wang <cwang@multikernel.io>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Sargun Dhillon <sargun@sargun.me>, Hui Peng <benquike@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH 0/4] seccomp: fix user-notification state transitions
In-Reply-To: <20261106113253.78866-1-parri.andrea@gmail.com>
References: <20261104103736.71956-1-parri.andrea@gmail.com> <20261106113253.78866-1-parri.andrea@gmail.com>
Message-ID: <8D7553DC-3134-4C3B-AC05-2BCF96A59005@mainlining.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 6 November 2026 11:32:49 GMT, Andrea Parri <parri.andrea@gmail.com>
wrote:
>I've reconsidered my earlier plan to send patch 4 on its own, and I'm
>dropping this series.  Patches 1-3 go as discussed with Tycho.  For
>patch 4, it looks possible for a signal during a RECV whose copy then
>fails to make the target return EINTR even with RESTART_BEFORE_RECV
>alone.  I don't plan to pursue this further.  If anyone wants to pick it
>up, the fix could be limited to RESTART_BEFORE_RECV filters, leaving the
>others unchanged.

Your dropping the entire series?

>
>Thanks,
>  Andrea
>

--- Thanks!
