Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638240;
	b=nTL9G9VP5+dqD77B1JgupU4mDmRm8y7q8otBWbsiwfGIhwXsOdah4w6k+Ij3tI5XKWlW
	 RBwGfNaceggoOpNIPt6X74oP1HNHAlM+pIMb7Mzv5hqZYoDQUBiBzLbUV8FC9zekKbgn/
	 r3kfso5ajPcSGkNbTB6DWfcDy4CCcyOTtjshQif/pzC/TqK8fml/oQqRVOhqiyDd6Dp1Y
	 yBJkYMnFxhFx+VKkGtghyqoMM1n9UeLm5sYRkGVuW7J+Y4aZamEAQA/X1W53mYiRVILEU
	 cL+Ao9ZZDR9AF++s7+uQZ3tkdrnK5Qrul/Sp8uFyv/ACdmqXPSVjwDtO91AoAgweqjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=I+MJWuTHvHgN/FhY5omphd4Ba1tdxtV5zHdjWOwg5V0=;
	b=yal2HjekncO/Vv8O78MsdCv/f67TQXSw50P+WoA+a6miwnccGoPXcLoDhdJ7T4Vby/BL
	 5OcWJIEYJQJPkIZBpabCLrLvGDGolDl9neSj6u1XQQAulkrWGgscZeMJb0NJ0TbSusnd5
	 DL+QNWQtrHgnoqZBu0P7ZuzlTzOHBtzwMKEgHfZQmfQ+diNSlIqA3J1pnSpxgv3y71y2d
	 c0VgHcVefGhPe4zZmupQNATytL9AGC66Ce4/sgaLSHkB9HCP5wQMCBlUxO84UpjtokMdA
	 D4Mf1oAGzZMbKeVldNVXQeXrl5KJ7FVwMAs3P54ZZXgQA5cZB8pUy7L0zJKFOUAhSiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bS16b14r;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA16074647
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 16:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BA16074647
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bS16b14r
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1455397a91.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 08:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638239; x=1794243039; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+MJWuTHvHgN/FhY5omphd4Ba1tdxtV5zHdjWOwg5V0=;
        b=bS16b14rPOrL3wo4ue5Txv+qnV3i3hmCoMiwjUFcZ2NO+0DnPvtzWW4UzXlRcRDmED
         8lghrxfcDBb/NrgVeaPkPP1AMRPtPXwrMCqbr7q1u02svA+63NbtsPLtZX6YsFyMlxba
         LjmHqJnMdbwsoPeLBe0PgE1EE779Fx7MslOYPUxveDssom+iac/04doEZuQmrlrb0+w6
         nI5Arqpu3To6Pq7TUFHDlMe1+k/YUumGYmRgLvI8M8orbsAMeNRrIvyRXUYYuHT3FLuu
         s4/65OwiQ6Q+KBGInUl7DEEJofV2FMe8Tc0iEFliJ5Y+JTHyL3RTfcFqHzYdZcS+jAE4
         Ix7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638239; x=1794243039;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I+MJWuTHvHgN/FhY5omphd4Ba1tdxtV5zHdjWOwg5V0=;
        b=KMslGWh2IQJ6gzjzTlOhSoQLTnXXYLgJSFOtfIe48lkWBsiDvf0HqIGLfs22A5pa0Y
         fHnsGTE+6F/Us2gNnoYQSsulxQBR/YkzAfJIbc3xZgZwXbrHJxE9KOU2Tn3WFUGRlxvh
         U6jOnDfqO2nmyq6rqKqlNyHjwPaUls3AIMoyoPDulyqgm4LEIzbVDQ0jXCbAQUZu5Tgf
         a9yfqb55qUcDdPLnce40KaqmlbWKsvvFSQSC+aXimOPhHFhEw/blDR6p8Qt1lzffeSb0
         wbU8yMUpXl2PjxiIJlgyf9HiX31eddCIqL3vL2hxou7p4d8ZjoNBITw3geDspB2WYAMu
         FTWg==
X-Forwarded-Encrypted: i=1; AKwUvBzIPjigFTctq36ljUm/ENuUWyz9gEuVYpzMXG8JwsVoQIDZJnsJoIRCs1i+LywIVTevAcE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iQtI+sZrprgHYETpWrasd5UppQix7+LuvF42mDMjTCddv2QXV
	5iUFHZ4JntqAlR3uNbLmklO6wTCoKJFGAT7R0Y4uFULfDwhquII0lY4w
X-Gm-Gg: AYBFou1hawPGHsomj45QV/cSCce0ePz9EMkKakI3fYtzOOHIsB+2cpqa78H6FmfsJY3
	xJvIeORJU5NWotJfN4XhU+MJoEVWEORMCH9JJLcXGXzcPAOFwx2SHJmAmv3Fntg67Ulzs49U3hK
	44y0Gjj1JQgCFqfiyjqFpAYNDQRlhYln3JnjhewSd15x2aT7C6s1OHEoxgWEkBmY13xLWs/Dt3C
	LjoIBheQwlsx3c84vosFZ1Yf3d79CltX1sp1R/lNBeZS7ZZrGNNTahtzMNcdinaDPXggcwfI/i6
	oKlVAfFH5ESa3i6djAHcey1XE5lBv3PjgHhNSQ7VGRXgmsa40rEqpbeyAK/sA/aTZH5ZrKwW/4m
	4iSUsA46901N5jcOiX8TMyAYnePCMcftui6/an/RKMhk9nWu+PodjeoxBjYBZDnz19Dmxm9lxAq
	960w4+p1SwIh5W1+UZMpXWaZujqL6hFm6TITarf9nZhRnc/Nul6pFFYh37M2LS7VO8he9ZRGwas
	WaCAup9avF1e7nTV77qaWOx3X1k2hcPfmYpSolBChGezneIG3N0Dq1daJToyutjjzrU7HlZ+2RM
	Tuxb/fL20Poas5V+fZc7X+Wg8/abJgNod6ONaCpUCUPtia5OLV3F0ytFXWRMAgpEL2KcJEs4DGz
	JQEkfHyy6A5Zy1vmkcPVzPCan/3zxvkC39A==
X-Received: by 2002:a17:90b:2d90:b0:3ac:9e76:aa9b with SMTP id 98e67ed59e1d1-3ae8957cca9mr8105797a91.7.1793638238825;
        Mon, 02 Nov 2026 08:50:38 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84542a13sm14956309a91.5.2026.11.02.08.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:50:37 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 16:50:37 +0000
Message-Id: <DMKVOUX2GDZN.2Y8MKLR367NU8@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, <bpf@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Use "new" URL to show if net-next is open
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261102111509.357269-2-u.kleine-koenig@baylibre.com>
References: <20261102111509.357269-2-u.kleine-koenig@baylibre.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 03:15 AM Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
>  For non-subscribers to kernel mailing lists, there is also a status
>  page run by David S. Miller on net-next that provides guidance:
>
> -  http://vger.kernel.org/~davem/net-next.html
> +  https://netdev.bots.linux.dev/net-next.html

The link is not the only stale part. The whole paragraph is wrong.
We apply patches during the merge window too.

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 4729efd..f6b9533 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -231,19 +231,9 @@ load or urgency.

 Q: Are patches applied to bpf-next when the merge window is open?
 -----------------------------------------------------------------
-A: For the time when the merge window is open, bpf-next will not be
-processed. This is roughly analogous to net-next patch processing,
-so feel free to read up on the netdev docs at
-Documentation/process/maintainer-netdev.rst about further details.
-
-During those two weeks of merge window, we might ask you to resend
-your patch series once bpf-next is open again. Once Linus released
-a ``v*-rc1`` after the merge window, we continue processing of bpf-next.
-
-For non-subscribers to kernel mailing lists, there is also a status
-page run by David S. Miller on net-next that provides guidance:
-
-  http://vger.kernel.org/~davem/net-next.html
+A: Yes.

pw-bot: cr
