Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767B4C1503
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023815; cv=none; b=cg9slnEDZqgkObzkkaYY103Y5OY00J+jgFvMURB6bFn7RqoBlGBSSSZqkyZov27OqqXNcojgbHPmrZB8victasqVrqCvU+Z6EDThWAhsJI/T1xePJFIjA+IVK321V5+2mzH2JC2IvST/CPyt9HUpxr0BYXjcPVLXa/6Xj+lWsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023815; c=relaxed/simple;
	bh=zZDP+BUxTYverF2YsFJcsQhL9mL6T7bJo9J1gf8XrVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVDEQYVJH9VmGu+egGGIXBjj8THvcx5g86AlUWkjWOvTYybViqpzQlLu+F7NoE2c6JXK+TMGIRp0Fvvh2/BWqtncJOV2hN6Uc3mnxNADLf4e0hk3woZPVNd25dKGS5t4w60ybrz6qskp3SaNNWvbTtNsEOKamO6uLgxcRvlfKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGtYoiVX; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGtYoiVX"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2dae660f31bso30477625ad.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023809; x=1790628609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K2GjyH/smBenoTcMmVaPg55qIuCzt7uV7xXBVHGA+A0=;
        b=nGtYoiVX8BXQYMAiwuZ/ZFYU5DkQIsKnoPYyZ11RHp2WfMz5Wn8j+6iXogL++5UsX/
         VK+F0CRv/j8q8Tc5H2BR1vRRHdGJMwlz3DMJMUtEEliFoP0psjhNlF7qqY4czweQxdp1
         7bsT/iFkIFgs45FcL1r6skwH0vudgNBDWAX/ALosHXFvY15P3izuwelLrciP5rDvgFcT
         lbuX7Y0XeX+iWRGg+onZqjmSDFbB6E+JIA+cExc0xRXrSX+5D966HHqcBtlGOY/vOtkx
         6erwK5W+M+QZycYO9KjEW5IfS/3SswFr8/XaAonClUYRCIjRx1/YjLQc1bnQqTuWwNVY
         lXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023809; x=1790628609;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2GjyH/smBenoTcMmVaPg55qIuCzt7uV7xXBVHGA+A0=;
        b=bLKfd8HmdZ9na5c79zwpwb0lOZh5YENQNH5qipy1UonsCL/2Ru0nwQDcFG478dU11V
         DYbEAagHdmWycquL8/KthoF9Nd2tzTHRSDnHZa2gJJGhx0dAk50p+A77RyFkpx84LC1p
         PwJulwS7uemJCS7myRetVezHh1L/QfOXFBOhZn0WCnpnji5CyGwHdGrKIzEaWjsZ16zP
         qeBrN895nimDYO6pi4WL1QH7sQJqCzFe6shr4GAKO3GNC8nrYbP2JCl8kPsdq6t01loA
         ZJT5knyIyZvrEnovdbPXeQO9vRjvlqAgjTor2GmkgZmXSNrjLOsynRwIpvWSkgLA0Z6w
         LQ5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzDKofg/HWZcBcYWeASS5PLYaw8+WnIW1SsyUrfd8cCtj4TWXeRAanIBonuzz9dmuOH95o=@vger.kernel.org
X-Gm-Message-State: AFuF++kizIlk0tbL+1dRjpAfNGY8GB3Ov+OfG48LoQ1m20VWInALqG9C
	Uts0grAZWGb1kllbZP4gPlC/NN1WZPSZniHxNMG7ScihO6TNsbLJFlUl
X-Gm-Gg: AYBFou3XjaeU0FDZZsS29OfsKLBZyfNnzdzigBtVyZ85hGUq2/y4ukPEe/KOQ/MBfRN
	EaXv5TfELrP+7r66oV/opf9NfJ0Jf+xynw1LodcFWeDBYWIeuXcQaZn4DfI2yTA2ymg42FeGK4z
	9VsDgeIStr1J3YNkKQZht6lOFrtrWo5ZlFsXNuM6ukMIy3yciGgiO4Ppk8Jt0nNN5p3oHz9gMOR
	U8NdK4UdCgFG82shBJxEAZGHqNGADR9Yrswx/u6cFSj9PP/DeoLow83xh4SGlkOh45DLHVUMXve
	ivY19RBs5eRmoBovpD+n/eB1LxMLfJfaKfeZBWOKczzm2ls8Pdtkoli5Zs3iF3Ly6PBkqwe+ekT
	1pbJRMNWnlJ1/tH0fV7IVOQuN/ifqI6pCBBZFv9ljO+j1di8PBewCZZ+n8B5QLBGzVdPkpj0UzN
	tjecAZzQYQNwmq17Cnakut1o4P3V14MLGFVH+McogSC9z5QX/9rqEyu/kv5YGJYY7DEQ==
X-Received: by 2002:a17:903:2c0d:b0:2d9:123c:8c49 with SMTP id d9443c01a7336-2ddb1b9a1famr181080635ad.14.1790023809022;
        Mon, 21 Sep 2026 13:50:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5b8075f8sm472845ad.83.2026.09.21.13.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:50:08 -0700 (PDT)
Date: Mon, 21 Sep 2026 13:48:06 -0700
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
Subject: Re: [PATCH bpf-next 1/7] selftest: bpf: Use
 BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
Message-ID: <arGYABcr0mfrFXoX@devvm7509.cco0.facebook.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920195633.3033620-2-kuniyu@google.com>

On 09/20, Kuniyuki Iwashima wrote:
> Once bpf_sock_ops_cb_flags_set() supports a new flag,
> tcpbpf_user.c fails due to the hard-coded max value, 0x80.
> 
> Let's replace 0x80 with BPF_SOCK_OPS_ALL_CB_FLAGS + 1.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
