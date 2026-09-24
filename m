Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF19B1C5D72
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265271; cv=none; b=esn3SHydJmOMtC+5cZbKUw0o8XVv4hutGoe4TtsrsmQenHmXtEU02SukjimfLDrkpxIue0LGCblNHuaMXjKI4Dua2hMaALRguJQfcVDPzDrQOc0Zc9OZ/yIet6Sl0WTtALb+u4bEU98if8M2QfLMD2k+ojw0ZuLfOfvAj8LdWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265271; c=relaxed/simple;
	bh=BAkQ2U6Dgp8aoHur+vjQIurqRFLJ6nuDA+/I7BXKXZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4xcAszb9F4Vmuux5Ha2gPJDNA+344PzN4unShH/MHJw82zBxleB0fFOPKEqwwmvnMa5IsLBYMAq1kdIiDjGvjjS/n1L3OywpECEXiefNIuZN/HKTlplPK4ZLH0t68PLjuv2+S8KmZqV+z2vMEGJHf+WEq8rNAaVVo5PnpXvU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWY2aCxB; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWY2aCxB"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2db1be98255so13052125ad.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265270; x=1790870070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FHI7px9tREpEQ/rqg1xo81x8XQPKrvVBlshNX5vePa4=;
        b=HWY2aCxBrRZshVUAJVYxR6qxkFUOdkLxzSHoAolfXFs37H/UtEVdRMC548VQ6BXpxN
         3PWmoPDZ6WeqII46Efu6wDzDuGGlky6V9PO+lQonjlYrSsOc1AL7Q5dNivmIxyAY19fw
         Bn40hhGXgVLglxPReLsgCIRI2nQAhp+wPJnltF4NRCIa//z0JjBajDyV8HazwFQLk/EQ
         QMDla0IrfqYC8mikSSMexGpm2ehcpubJDX0nSmMxpVXu1yoONHn/j561UFuByHJTLiHS
         OYIMhH5ImreSt7+CSXNPaqrenAstCk45vkloJvOVxI8v8dPekWqrOpodq8aXFNW1GTU3
         XQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265270; x=1790870070;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHI7px9tREpEQ/rqg1xo81x8XQPKrvVBlshNX5vePa4=;
        b=AXbbVSwRG7zoZksQcPb5F6WmcnjUscqVNTXjaLKoqvHNv4609uUvU1uDetPHLNA5Fr
         RDrr3mPkVsv0j2TMmK0rdMrGbLf7YHdqpiZdM6jzQoJrQFhoCs1TzdpPQa9oDCSQZtRd
         v0S3KVuhDAMN+58p+dbelv087ulN4tnLu4o+uIHuNebZ+zeK1CCJm6pRQgW2UMkyHRTj
         MZ039QFlkJrFEAxAgMSP88AdVsZeIEdLBuikZbl9KNExXFM4zYFBX6KInWTfyZX1L6Vx
         UVpx/DkQuxQ8VNLet5k6d/3ADtYDW83ytyM7y2+A+mKYofy9jurIPjWtVQblHWzwNv66
         20Cg==
X-Forwarded-Encrypted: i=1; AKwUvBxl3Nftb/69f+J/GfRq2qqP549biEMDeBkCOgTYxLSynWHc9IaPAWLXym2NPWFduSEf5jg=@vger.kernel.org
X-Gm-Message-State: AFuF++mA5ZmH/0mmdP9l18oSQZ4HrwI24V6FV9VPEH/Ah3kaPAJjA7YY
	/G1ol8Wk69Nilk120ayfswBvcXjeduVk0AbxCni419stvuzTH0mP3tJc
X-Gm-Gg: AYBFou3L7ZTxeMcavwYW3+iTso9UwMXky033lwNQuNJw7ARE54LJ71b6ixBh96nJM79
	EDd1QeJd9JNhHJH5XhDRDzs4BTygUXuGu47jQ2Ld3bGyh2X04D92h25Ien5xG1nH63wlJ3zB8PP
	/EZwT0m4dOlFEkrnfBXEFemXqmhKk9z+yKSUXgmLa3Qt3/WpvFvu1O5yvZ5+LzEgPmhu0MTw2RP
	sjsL5LnuEFwJWKJ9yp/bSyln8bLNwsXJ2D6UkRqU36kuKhoGTjdJ1+J+gGE6b7UfSiMiLIr3FnM
	HGC+SaWkkdGaMHGXm7dISDy4WBcnWPtIejTTFmB4ac+VpJdqcSt/fQv3KjnCIjvWd1ZY7kdK12P
	rekFPrOAKW7qLq9s8XaFq+QfMd3bFZSnzmvuKJsfyMSSzMwSz3VR164KMUha9je4tzk6mgHUWwk
	9nN0yO10I+0nTD9sdumOA+th9w93jA1EBNeYtx8W+qk/Yv0ILTDkk37EaCcGxVmRmA3jmQKzQbv
	Q==
X-Received: by 2002:a17:902:ccd2:b0:2dd:c100:943a with SMTP id d9443c01a7336-2df7e65e22dmr25503715ad.56.1790265270026;
        Thu, 24 Sep 2026 08:54:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5c316bsm30074495ad.37.2026.09.24.08.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:54:29 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:53:57 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 1/8] bpf: tcp: Convert deny-list for
 bpf_{get,set}sockopt() to allow-list.
Message-ID: <arVHjxxCfOm89WV7@devvm7509.cco0.facebook.com>
References: <20260923213719.224838-1-kuniyu@google.com>
 <20260923213719.224838-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260923213719.224838-2-kuniyu@google.com>

On 09/23, Kuniyuki Iwashima wrote:
> Currently, four bpf_tcp_ops callbacks are not allowed to call
> bpf_setsockopt() and bpf_getsockopt().
> 
> However, the deny-list is fragile, and when a new callback is
> added, we might re-open a can of worms. [1][2]
> 
> Let's convert it to allow-list.
> 
> Note that it can be written as offsetof(,X) <= moff <= offsetof(,Y)
> but clang can optimise to similar code anyway.
> 
> Link: https://lore.kernel.org/r/20220929070407.965581-5-martin.lau@linux.dev/ #[0]
> Link: https://lore.kernel.org/bpf/20260421155804.135786-1-kafai.wan@linux.dev/ #[1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
