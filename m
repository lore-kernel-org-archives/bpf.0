Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601342;
	b=UEyeuyUbK8O1rCB70HQqy8PqbbjlLUUNlIcLKl2a+J5ELo5/OX8QDHFpOH71YnXkUFDr
	 BnZsJi+gGqpOEeuefJL/zcAqcSRiVPIf1FDat+x7+MoSAE5kqei0y4C3l7QAqzrsxh5xX
	 Z04/207Ub4kccHwwwINn0ZRyp17O6UA/yzsas32lZW0KtvXL0JPnxRidJc/Na0eUUlHB9
	 mL99M0m8Dr4758H/okGOX0dMMmLryXmRgTHjuaQprLiu04vswNf8MyFrGhdLSsKqgbyhf
	 SJVJIiU4JgHgUXxJALpHykhLjOlCkBbkKjGdQwfFhummpNyT/4OL2+ebRbbPEt4rXoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=s5HRLWT3GJ5V57HOZzLlKs66p4zza+KZ/ooym+DPD/8=;
	b=P6Of7b+2JJqB8iCQs+N5QyA8VI+28ehM1lf8VkM1E5KyO//0+tpv3cQ860Gllp4Kesp/
	 6vwv1Pe49vI+7ZAARiqZltjjQWgL6mKMguCGuZ90Vf0r4lAhXgW2jprm0NONgnM9Tr5NO
	 jQF+692YE5TTIBeSOpSmU09X9LY6Huw2lL2yWuiIetR/da1BpUae0Iiq5BEYgI6Tu243X
	 9e9J8fXzIRdex7xV8x9HvPCO9QxxCikZAPhnJ88LfR8YzVOZKczTnSeTHehK7fur2zPP/
	 jHkVbFvt/YduEoAG6ppymGAVui1lns9XF6npeNa1c5D/1ZN4aIjg8J6uwtHk090wM4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wL9QWYYa;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A6606A899
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 20:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A38A6606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wL9QWYYa
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso691375eec.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 12:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601340; x=1795206140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s5HRLWT3GJ5V57HOZzLlKs66p4zza+KZ/ooym+DPD/8=;
        b=wL9QWYYa8TzOJZVMNIyc+YX+4aWHXvMAiO159H51XCo86sRljVLG9cSgH+BOWJZiP2
         6G2le+g8OtX74/MisNw15WdAoAWTDcvYg7tM3VF708EJMOGrOBUYzsjGUNGzc4V9dZto
         EYO9AFg6efIX7i5dit17/pqUx+ghyCOxB1VwYfSjW3FRdQTE0aGgSh6aEwa7oNzFuSpG
         g5wtAjhoE09wyLWJq6rj9H5RFxaTDKm+KXN18OL25Y/hsccmK9amysRVN2Lj8o6Zv/Va
         jsOoobBDuEuXWpHTpjiPTYd4nIgte5zLNnQscwGjiU0QRaiRX4JhfCcH0qT1+lod5ULc
         4HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601340; x=1795206140;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s5HRLWT3GJ5V57HOZzLlKs66p4zza+KZ/ooym+DPD/8=;
        b=08X+7o94v4UTc4vpCRRfPbGXYPmpCFQdWJ2j3ZRklhWKH2e70Et3ghuxbG6GYIZQ8D
         hlQVIj3tMal0p/cM+BDIrErlxTf4denEvcPAgvcnGoAMmWjAt8cs9wZ8nVdFmRIh9qa3
         KvTNSyWgISpBt+Yr1InRJ7bTTNp5GPgxBve7aq0pitSK79XkslzXS06n07bnpw5FK99b
         yofnRke+S31euvW8P2brZMEbi00ZXHgHL+krrzKxV0BaHDsDxbySHCQlAtBkkKJaoECo
         ktyn1GNdHBZ//Pj5pevZwb3tOtkZUfKmj9HQjz7Ps5PZhPLPP1XDjMcwuGnR88cKjT6a
         t6Cg==
X-Forwarded-Encrypted: i=1; AL+hErGQck5bbRqKfxnOhIosRUk5zKoqo6x9q9CfwycpwMXBzmbzAGJbyEflGL4psqrQ1L7nFOA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bhqsm0ysF/colhw46xFY1qLDQFVV/KZbMCFwc1BRU18N/2tOI
	rE4wdNTzHXfknS6tqkmJlF55cGqcmUBq2ZGPXnfL1eD486zaveklln1W
X-Gm-Gg: AYBFou2AU17M8gDbrl1PLrx+e3yuxXCVMSPuWg/IxW/kVHSZtq8zvZTCIeLZ7ZZ05ZY
	yE526EgIpZi7Nry6Epj65QRGEVpB+8j/pALph1ihAqOMGv3rD1TUePjkN8wVcaD0rdNyRsIDxDw
	18TvUttu+jgrwOukcqMGo4B4TRtqSRfjvzA0zQDkRu2TX/jQrBm4eLvO4WR27goKwoww07UTmIq
	62k2sW6ZL/pPP8hT9z+tIG5+Og3s3K9tRMG7WUwzDB+w9IXF2/UW38oTdH/kV7ZQTT8ie4fKzk0
	dmV5FUmisVWprm+GQOco1mdGGnIh2yF0iFAAXYHzilIwIwCAvbBv9gOFNTHcD2cnz4ZAW47F71K
	kbRPwyPDFkFwUrOaPIPHhGopy83z9Wm2nvLH8Rrw9S2RKh9IiKM7BVu5hyUSSj9UJuI4i1Zb76Z
	xoHIQnLPaGMeekCv6HSpVfAgT8vXMrr+dY0EqDF7Aw3QY5oZp039m6tuyueIioVDDIpMyYGSOlO
	dOTa3L2xw3B3EmdaCRJ2BMqTCjFSeSbhZjESf9SvSJYXVfuIydRrL5UgF4O9Izmy35B73EuO01N
	aVIlZ33oOHb7DTyPiEhUygU=
X-Received: by 2002:a05:701b:4594:20b0:1b2:4871:b1f7 with SMTP id a92af1059eb24-1b50313a743mr3055299c88.39.1794601339464;
        Fri, 13 Nov 2026 12:22:19 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d8f5sm15946929c88.3.2026.11.13.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:22:19 -0800 (PST)
Date: Fri, 13 Nov 2026 12:22:12 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 3/3] selftests: net: getsockopt_iter: cover tcp
Message-ID: <avdxbp3uCMtiO_KT@devvm16445.scu0.facebook.com>
References: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
 <20261112-getsockopt_phase7-v1-3-1eb759dd0929@debian.org>
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
Content-Disposition: inline
In-Reply-To: <20261112-getsockopt_phase7-v1-3-1eb759dd0929@debian.org>

On 11/12, Breno Leitao wrote:
> Add a fixture for do_tcp_getsockopt(). The setup keeps both ends of a
> loopback connection, with TCP_SAVE_SYN set on the listener, so the
> accepted socket has a saved SYN to report.
> 
> TCP_INFO and TCP_CONGESTION cover clamping the reply down to what fits,
> TCP_ULP covers reporting zero and writing nothing, and TCP_SAVED_SYN
> covers the length-then-EINVAL path, which the second half of that test
> uses to read the SYN back.
> 
> TCP_ZEROCOPY_RECEIVE reads its struct from optval and writes it back.
> With nothing queued it maps nothing and succeeds, so the tests cover
> the 16-byte struct glibc still declares, a larger buffer cut down to
> the kernel's struct, and one whose extra tail is not zero.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
