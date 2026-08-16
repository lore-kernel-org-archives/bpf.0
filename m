Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D622A4E9
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786889508; cv=none; b=J2WnpzQGS/HBdP3yCsC9bXXnGhjz5TpB7QfTT8/xdstNL8Wso+DUvrzK71+f/tvLZ6LF7QBYzhxmEcekBwiVpqjxf9zQ1p+ObuZzWZVs+ZRsdQ7s03mI2AjxljjCbWLeqDFqvdZ5gJgSvMb66duPkRQzjmECA+sptCkaJiepgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786889508; c=relaxed/simple;
	bh=JvzbmD28/bNeGCCQoldoWDuq4Wtj8kCRwNsgVLm/HzA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HNrEIUo1O0/q1VLlfhy1MApMXxL/MxmBzfkeiERLbqT1fC1uE6nES8numhLGZryw5kkrsaNIE5TeahlkGh1Nvh81ZogRVWUEXDzYVw5c2RkS+AHGQYv87Pv0PRR9OnuVA+ZMKrmKrQl3xGjwnhwGgmINnJE1hF3mlQkESAB0sFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=komJFJSg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="komJFJSg"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3900e39d935so2368671a91.0
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786889507; x=1787494307; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zAUnw4mdqI35ASBg3kZRAyJOQp+N9wA36536RXbz8QE=;
        b=komJFJSggft2Xix3MPZKmGjRxc8JR6U58fnJDg7XCwI5lBeWLz0mBPx8XUi+7aOVyO
         1r9AuZg8o1jert1hUbvuWduN+9yHILmHk9PQ8wxTz29kkoupnzWooRdvosDCT0aLnVv0
         hxwRQnFBRViewrRo1d0UgpOVwycvYqfmOup0tb71NdIDFkzbq3Cmkgbe/rE583hAsf4D
         4SvGkLFSCmjlJooReTPIZfvAy5ankqUdX96F0/aiymLJEK4yquNrxLucPlPnC9Ukta8B
         e8j/BGCER9VE8CpBl6FbcFMsMoEZAoxamIOtU6xgCQ1ELs9Sf/e918vBVifXUxoMnEch
         hyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786889507; x=1787494307;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zAUnw4mdqI35ASBg3kZRAyJOQp+N9wA36536RXbz8QE=;
        b=PnP5Ur58kzbxk8SZoeQY8f1PUiU6p6zBNca5ihRixKNnbJGgzPY44EhgQB+9Vc050/
         cjvRKmjTpOJVblM8FXGJIACol6Wvd5bYdVlnxnLXlBuIbgAi2GC8TDjPzLdIGvter0BS
         xB2Rdi+B0luh5pUBbdBDlHHvNxR2Bb+sPH3mfznH+WNJC7/FpNvw18smapZrA+wxjA+u
         I/PM/MbxZ2a/ewoqEcrUDAN+UiaEIx2kLyL4xvs6FSupVizGvIAGVuadmUVZJr4sjH1u
         /6sWYZpniaOEsU+W3kC6XlQ8agFCYHET6XKawyLzBYKDnsXatHzZxYOpCqdhnDA3Avsm
         0AYg==
X-Gm-Message-State: AOJu0Yzuuv46UnTaT0rsuEo9BH0YdMKaor5AxYgItS9ymKJBaySgFTqv
	oiLLpyoz8FbQElA9CdXN1n8/AVtS6T3pbY+a1H0c2aTyOILoIzBxgBPv
X-Gm-Gg: AR+sD10G8bwxSbyVlfXpTtipdVtJK8hAmVhX+JPDKQZBQUyy1qEEAkUK0bXWDhwuSMS
	Y8bRy+zIi3d/gyYdOnBRSKjA+viwtsnCL1kEvM6/PR6a6HdPIKYWZINVFpPiQ7kjYckJoXtxUcR
	nrWcg3wpoBeM/ekowKxTUzvtOXH3F0buydlsE3VUdiNrb43pCDRsNxd+fppc7gcB2tyyMxMVdcX
	TY5MppFgIFSKR60tYhhwqWpUAAB9p2Cw0p/LJJJA2qxXtYlwUC2DiXDf+nORcWcobE6W8iUF9fn
	EwH8q5V/EKFEviGF0B65qkY/5GzmFrtrCp25OK6MfVphsmvnk0/5BR9AelmOXQ2XEq2VTh+6y8o
	wrdhJSTjau6L72eu8fRF51eB6cizEpnJf/gpcKjTFEJ3XgSo7SWehstFekLSBrKzcLOzWMktf+X
	lM6SZswPJKeTN8uQEtxJ7IJPwsQQ4TvI04MfK4dWCephRPANFID6wiDG0fTunzEkaRacVh2cvAr
	8WfpqYRIxVoLu8Y0OHcRvI=
X-Received: by 2002:a17:90a:e7c1:b0:36a:8240:2477 with SMTP id 98e67ed59e1d1-3933ed1ba09mr18711493a91.19.1786889506906;
        Sun, 16 Aug 2026 07:11:46 -0700 (PDT)
Received: from smtpclient.apple ([144.52.150.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531fbc08bsm1618477a91.12.2026.08.16.07.11.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Aug 2026 07:11:44 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next 13/14] selftests/bpf: Test skb_ext read from
 sk_skb stream verdict hook
From: Jack Wang <163wangjack@gmail.com>
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-13-767edd862656@cloudflare.com>
Date: Sun, 16 Aug 2026 22:11:23 +0800
Cc: bpf@vger.kernel.org,
 kernel-team@cloudflare.com,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDD06D53-6209-47BE-944C-B02F1DA82246@gmail.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-13-767edd862656@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

On Fri Aug 14, 2026 at 4:14 PM CST, Jakub Sitnicki wrote:
> +	n =3D send(p1, test_payload, TEST_PAYLOAD_LEN, 0);
> +	if (!ASSERT_EQ(n, TEST_PAYLOAD_LEN, "send"))
> +		goto cleanup;
> +
> +	n =3D recv(c1, buf, sizeof(buf), 0);
send() and recv() are stream sockets,so either operation may return a =
short count
even though this will usually not happen on loopback. Maybe use =
send/receive helpers
or loop til TEST_PAYLOAD_LEN bytes is a better choice,the blocking =
recv() can leave
the test stuck instead of reporting a timeout when data path regresses.

cheers
Jack Wang
