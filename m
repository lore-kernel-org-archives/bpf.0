Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1547532E
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023816; cv=none; b=QskBxjbcE9kNZ9XhJAvQgMFcPHjk0pDu8WkQlJ0p13XpSoWJnH8ZEVQ1Xnqi6apdOqlb56B+hUYMIfTZL5Mtk/1te04W1jmPnzBUUZTpjb7GiRIwoggGoAxUuh8FLExdz7+sTaWTc3N0foz2V6MXVLTU3dLCqW0vbnM7oeoxz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023816; c=relaxed/simple;
	bh=+QO5fuCHnr/fPc4AyODnXGvj66246F2XCk1g3Rm1Hy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ta5xpWh/yjxQbZdMJWU+5zZXn41KIlkta8xJz2Xw9mfZ4CrHLPz1XNFybHmwOHiPVoOTHpKiI6dtJuR+78khjBDT/6oQvhOc5xiZ+1BzzlY0OHCre+2C3moUYtiX14ZaiL+o/hpIGjRzVRC0CxsEjIGjgazfXzY+pvXi1wdlu1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaAILNqC; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaAILNqC"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d6f9dddd99so21234325ad.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 13:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023811; x=1790628611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I6IpwoNNaH7cJ2kkXNuM2goEpGU4JS7nUBIfFryM28s=;
        b=aaAILNqC4thu0XEgwNYoQGvh1fzBrwhztmtqZ2ocVdCbPGx6ed4axkea9QrkBH/u8N
         mnCMWl/DJsHPjbM88mxSVCs3a3YXQJnxiwnVLCVU5tG3+13THVo2dyap2+vwFSDg8pFF
         PzdTFSgJ8Mw1twux4Hg0Ssgb+zBqNJnOodlyhb6r6I3PR2rd5/peg1vOB2KtolCDvDW8
         jv/+mk0+5suzUamXbat1BaSNCfKcvpDbacU3kDgY5UGB98Erq861sOX7FqcmgjPI+i7N
         Xvh5ZeiBznFcRKWgNk3TTarZZsp1dky1sDeWqENS9cEM25SR4BgoW+o03fOOln86HbIR
         QzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023811; x=1790628611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I6IpwoNNaH7cJ2kkXNuM2goEpGU4JS7nUBIfFryM28s=;
        b=XcStiADCmWanWZrgKoZtl+1bbiqll0LX4IEbXL+IijhX1cJ66KVs2OiL1YIGlBDSso
         vqr1Fzzdt0Dlfg+2bX/5bBhD6A5gvMtzV1PRlk4kmIrnVc9naEB5BWEC6UHNL/Hz4xI7
         VLGhXFIcqpGgT6LuG4o3YJZcKNmGfTqkLQeTANknBRqAI15ZFcVH7i551W5TgGufPRVj
         5GGTXbxcoD/whwqA4AOegCbz9J3kX6ZI/2NKDK9c+uHNPG/hm8+Wyy5bq0DA8hFikJyH
         74dIcy9mgcGKh3KYh707qXdHeeb2Zoe5rPFEE2KOoZl2IvK3KSMOkqmO4+sWFkNnjS3T
         Omdw==
X-Forwarded-Encrypted: i=1; AKwUvBwMJOVFOQodyDSUkAd+9gp9Yi2SFBuJIsEcwDSk/fdcky3ZUt6yk9yETxlqGpsmJmeiSL8=@vger.kernel.org
X-Gm-Message-State: AFuF++lE7eOgLe9K1mKxLlc42lNEXo/AMFHJCiqyLQaP8Z3VD+6s4bLr
	sIZgoQSAD0MCRFY7knNhHdR6Y8l1f73Fq9LXJzNhmmvIX1jzwI+SvxI6
X-Gm-Gg: AYBFou1asDiJwJjeT4DCTZ3eACaQIs5OOxQnBYhgQJaWbYxCoWnvLeGp7HGfFjzlnik
	ikVDK22iCqAVKcJVxnqwjWnSu9AlF1FCXrOC/IrR5GddaBtaIcDCxo4Kf7VQIMJjDCAmTdcdgTC
	z3WWQe/a04Ns9b9wzS7OUr0I7r+Pk6LQf/1smRUGKdlIHsDtbJpfEbr/wfc0pMJ6aUZ8ppxC/oe
	fQH+QLVbsdCg/+kIUl+y9n7dSkcc3lAHIhto9wL0nouSAJkljj1uagDTTrMhSFU6SEiOEBlfQlm
	9K4gpjMvOyr/fyzTEvr/emCvmhSCx67yf7vV/rjseIAkr7waEkHdYkSODLBi/JqPvn+h4e/kml5
	ToW7qI9smjQh+VRDf/41jlF1B4Qc+NBcPMgQo1Vz/83uwnHAz/QZkhy5703n5pip/yLEGc1/9ri
	qiMBL7amPqN+VW4z7ROEaQR01At0VJKOf+JtBHk+nLD3fnsTTagZi0LIvItEx+9H4=
X-Received: by 2002:a17:903:3885:b0:2dd:ad73:c97f with SMTP id d9443c01a7336-2ddb1b86daamr169079715ad.23.1790023811040;
        Mon, 21 Sep 2026 13:50:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5b7c0cb6sm527045ad.61.2026.09.21.13.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:50:10 -0700 (PDT)
Date: Mon, 21 Sep 2026 13:48:42 -0700
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
Subject: Re: [PATCH bpf-next 3/7] bpf: tcp: Support
 bpf_sock_ops_cb_flags_set() for bpf_tcp_ops.
Message-ID: <arGYI_SuoXb6urB-@devvm7509.cco0.facebook.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920195633.3033620-4-kuniyu@google.com>

On 09/20, Kuniyuki Iwashima wrote:
> When an error occurs in bpf_tcp_ops.{enqueue,dequeue}_rcvq(),
> we want to clear BPF_SOCK_OPS_RCVQ_CB_FLAG to stop invoking
> the callbacks.
> 
> In addition, bpf_sock_ops_cb_flags_set() is often used during
> setup or just after 3WHS completes to enable opt-in hooks.
> 
> Let's support bpf_sock_ops_cb_flags_set() in the following
> callbacks: connect, listen, {active,passive}_established,
> {enqueue,dequeue}_rcvq.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
