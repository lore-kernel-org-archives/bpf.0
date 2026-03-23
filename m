Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB6394476
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277070; cv=none; b=RcBgqOGmpFuO9w8OumVcLfnsH0fcZg535TQcG67I+APEcsknz4SMODQcVt7kQ/OmQwbM3748wPqj6+Q7xHt0cjBvencobTU5JblIIdWNgT7FLnshLpRvzl7TfpkrwctThNhdhGrTt1xXEHPYFBCliHB3FvY4QcOXRF5x1BiiUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277070; c=relaxed/simple;
	bh=Sz8BjVHNR/2cFKMwkkMdh6g+P4C3BczN2D44AA+h7X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2bcgrk8vRKVv79pqJjLfBbSGGL8rhCTQhX9OPVrHPuznfiMWIRYrEmG+CHtwvXMHIBwl00Rg4/369v2bdLPYhJQsmGp8o1qxocsbHUJj4vQOQSWrYwXcR63vnUbJsfFmB5EJz+pfGJr58nSdaiBo/KelVjr2lMpxwq3H0ui3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a8KQOH0p; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a8KQOH0p"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b7481f9d3so761766f8f.3
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774277067; x=1774881867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Apeh08iQfW1zl1kubqYMTfp/o+HNBm1KzQrtiUj8S3o=;
        b=a8KQOH0pAiA+ZM2rly7YnfrDD2YqKsHDVUBb2o1l44+QTfjmWE6o4ws2LBQYAKyg/A
         +eCm2okHqUbQwMj5chUBGiBTgtm3Ya5EyVje19T/qC6taiNJXvdxIE4NrprbnMA4STy9
         ip5yGuHO1Buo1i8ncJKVrf0auBAfCz4cLaKq9v8lUFOo9YKogshshzYfksooJcaPacxX
         KxdBaI4VsVTasjEOc4O7XRzwD5shgDauAApetKvFkq5o+vj1ZHQhYPoMh72D1M+z5Fl2
         Stelny+pssN3keGJj7mTnZuVzbvYIP4xCItPgj3St3vgAxqzdKvSUcqIU0eREBTGHdxv
         yI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774277067; x=1774881867;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Apeh08iQfW1zl1kubqYMTfp/o+HNBm1KzQrtiUj8S3o=;
        b=cB2Dks39tF0JR8Krq25G1csgNG+FcJf4ib0JPkwXaimj4tS4H4HIHi4CH1hWyaoPfn
         X97313SY3oKGgQGzCmXCW/jKHAyJF9E6px8lFZ4MRe91OtzxxVlyZYCaHhnQZfMlSdus
         od1N/zy9hOFaPFfzx5/fYD2PxcCgN+u5I5kDryTfLAAGudtoZKlpRmftiPW5SDijnJvH
         f48QLTWtVVID7okKycPqxyl1djWABhwpQHTlhPKpobwTpseAVUp3mBJd9TRl8wL2rR/b
         fCIv8KvV/9neKZAjZq399s3IEK2KW78pPiVpGefDyVdYtOQ8tFI5Q6Zgy8ioEe0Q6dxu
         96dg==
X-Forwarded-Encrypted: i=1; AJvYcCWkFzZuvVXkrk/FdpS6e+BOpwKEszi7unXyhe5mFb35SSD6K3SHddooa6tWAeiJmqi26/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SEr36QF9XZf7IHZsbalGyHw62EXDwjBLr2tRlgW9wgY+sVPv
	+7qh6MgikI/YZYlw4jkXV1skY6FGv8Gwk1cxXRASp/EQ0MLxifc4i27uKdIfa+q26PM=
X-Gm-Gg: ATEYQzy8xK8kT4pstXwYIuQLExQ3KUFLfOV3ZzfbtsSA2FGhFiUtshfOCapkxLdxkGj
	wtFQq6R66qOlCZaXAivujyhhnNqmKZ60BS5Cz6j0nc74ocGlVkEpViw/4JPr5uZK8fTe0VylsHT
	jYQB2c9NctKriKhqKAKP4Vy0nXi0IolMENw2VMQ4ne04NTWK77ntJy99EE4y3bqkmNAosAZ2dCB
	10lbxd2A0S/cNQZGhah/T4tjTVhUo47LqP3UEOUpbXw7ZcHGEuT76JS/VudjqT8uAMcLETpko8I
	AFixz/guhr8jpG8DRt1JDNcKoi6hlyvVgyTcxr4y7H3CVEjk4nCTGFMWDRwfzE9iFWlKE7o2SS8
	P0/xYINwNClt2UZ0kAJ5m7a56+q1GvcXeiAqwEf5R5fTZrXs5jNEfRYcFDSGgGbc/fAS4ttvekM
	R4knFCfysEhaagoF0sgxBKx2c+Uw==
X-Received: by 2002:a05:6000:4381:b0:439:afd8:621c with SMTP id ffacd0b85a97d-43b6428b417mr17458154f8f.55.1774277067029;
        Mon, 23 Mar 2026 07:44:27 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.133.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd0dcsm29028576f8f.11.2026.03.23.07.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:44:26 -0700 (PDT)
Message-ID: <6c315cb3-b3a0-478e-b8ec-36d82684d310@suse.com>
Date: Mon, 23 Mar 2026 16:44:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/10] x86/bhi: Rename clear_bhb_loop() to
 clear_bhb_loop_nofence()
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 David Kaplan <david.kaplan@amd.com>, Sean Christopherson
 <seanjc@google.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 David Laight <david.laight.linux@gmail.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260319-vmscape-bhb-v7-0-b76a777a98af@linux.intel.com>
 <20260319-vmscape-bhb-v7-3-b76a777a98af@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260319-vmscape-bhb-v7-3-b76a777a98af@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19.03.26 г. 17:40 ч., Pawan Gupta wrote:
> To reflect the recent change that moved LFENCE to the caller side.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>


Nit: I think having the _nofence in the function name is leaking an 
implementation detail into the name/interface. I.e things change and we 
decide that the implementation of a particular function must change so 
we just do the change and substantiate it in the commit message or in a 
comment. Especially that we don't have a "with an lfence" version.

What's more I'd consider this a "private" function, that's called via 
the CLEAR_BRANCH_HISTORY macros, the only place it's called directly is 
in the bpf jit code, but that's more of an exception.

Still,

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

<snip>

