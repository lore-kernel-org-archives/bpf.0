Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795870325;
	b=lUS6BuT1IopIL5P55l7hqZka0lLEIUpf/FxgmoUhcSzxwMa2Bq8DtMlVOrvtMF3GbVe8
	 I6UqbKrZ7wlAK+ErlZWU+hgyBsL5Lv5ra3ROm19wWAdgM2gxdlKBvCVers9O6GqpxYnCd
	 55pc4qRYr4yKHaUBkC58M2dbsYiDoZ4FfTb6gvuB11ZEja5OlKN/AXTBMV2rhkFk2rWhJ
	 5cQQZqVMiFkGe5ZVFFWUB3+zvRisTtOAQhpB2TYTyPPuxkHmDj218WIVwlhNdIoJh7r9t
	 7Odv/ZAN03sSLz5H6Mm2svC0Ni5BMqZxi4WVqkcUfxRy8U9b4xNUpHcGpv2pQCO/90g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795870325;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:Date:X-Clacks-Overhead:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=otHOLoKCYNrrj4Igcfdx6kJLm2bDPmuOQZCBpPeXJJE=;
	b=EAkaxoPPWvgaJ4HhC/05Bm9+o/B0Qt4EeHd+yYXYpfePmQvExE6VhwmcM3MMKYtnVfLC
	 fqMLYIyrpqP40j3NQIW+eCTTdFHn+ykNaC03CImml1G8YFuJNwSpVBY2ul4nkf6TbXV6L
	 bNIK2SPmZEiWOLIYeX2UL9ypgOhKIZ8wMSAU2BcmfHTkB+28cQGs4FNMrIz6IHKXP+gI5
	 Y6eBxOZviF4MwKyyaYyJh6dXbm3SkNJgJB0tQ72gzEQsBvXCFQuXhvxjrxFbmrWIc6Vdm
	 xoEIgt6cwaBRSsDlMhGCHP9m92K43nwtzckyepz+wIMQn9uJLtMC1sJfak0OJPQobUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=nR5GyqYr;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850C606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 12:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0850C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=nR5GyqYr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795870315; bh=otHOLoKCYNrrj4Igcfdx6kJLm2bDPmuOQZCBpPeXJJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nR5GyqYr5jVPUHnqxZYKpI55GRlgJq/+VHlYcHzOfXzjvlndyz2DQc4psTxjYMpPA
	 2vKO5tTJSv79BORJlGmqZtOKxBzsFAD0RE4FEqg2iK5rgxfJZji3jIJ73q/FL9z7tC
	 QLxb1/xqzO9+iZ9JtW9WfMBv7m/tdjzyTnr0WGYPkBEglbBt1oO+m7bhS1cAB1t+SL
	 ZHJGXOdu6hkY1SvcfHVALGfwse52oSXfkSBv0sqddwAIhNVrPH/9fsKIVNF/eCPps+
	 36cI7IqD2rD+gwR+7QtXBmk6HhNw3Mp4n0JfPjZIF+qzNQR/cnsWJhJW5rQH/yOn+6
	 anALmXNct6NcA==
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Relax BPF_*_GET_NEXT_ID permission
 checks to CAP_BPF and bpf_token
In-Reply-To: <DN6IAUGCNHGW.1C7HQ1O3S82Q8@gmail.com>
References: <20261126-bpf-relax-get-next-id-v3-0-338e1d3077e7@toke.dk>
 <20261126-bpf-relax-get-next-id-v3-1-338e1d3077e7@toke.dk>
 <DN6IAUGCNHGW.1C7HQ1O3S82Q8@gmail.com>
Date: Sat, 28 Nov 2026 13:51:54 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fqwlce51.fsf@toke.dk>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alexei Starovoitov" <alexei.starovoitov@gmail.com> writes:

> On Thu, Nov 26, 2026 at 06:51 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@t=
oke.dk> wrote:
>> Relax the permission check in bpf_obj_get_next_id() to
>> token_capable(CAP_BPF), without touching the operations that turn the
>> IDs into file descriptors (BPF_*_GET_FD_BY_ID commands). Update the
>> capability documentation accordingly.
>
> My bot thinks the following is a better path forward
> and I have to agree. wdyt?

Sure, I'll respin accordingly.

-Toke
