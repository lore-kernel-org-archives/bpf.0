Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B9D4854ED
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262773; cv=none; b=WcF/TwizXZBtx0Kd96HttF1VbLbOPJR0OPySrln+xMu2KMgXBPKgbG25AWKoxYQfv8vRQrGEV4mpKStOaXVGqIjq0MK0RffQMo4goAze7uelv3vYeqANaawHaTuBkO1+IVbvs83byxrpyNPQI7wFQcP2Wz7Ebsw4IRngZ0EBIMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262773; c=relaxed/simple;
	bh=JpgBke/JjVNFxU3pQATjnBoTHzf7n6UOIVD/oEzarCQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=GqXkc3e+jmM537t06mExFDUbeGvopOfNBBRQmre5Zx5pxQWI5rOASnxLV80a3c4QYFlrllmqwnqe518ZrOjPclcObltrpzYbSYyEmp0eUiNuCFEZe5jTV6ekwW9ChNBMVSaJF9Lj994rueifQ6BCHcohIwiFq9ZxeHAGENoiDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC4B/rND; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC4B/rND"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca06a25so10725375ad.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790262771; x=1790867571; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gvSKNoOn4vM5/R0bP+3l0LZ3cRQeqnoPEjhgdn22ZdU=;
        b=bC4B/rND7JfkAvoIxmBZXIIOBMN3gd+qUaEQyRTg55SIj1ZfcV3btv5FWGEs/8YeQJ
         twEKbE79/Oz1vmj8uE9uqOBrXQt7NGEQrC95drBmtohj6HonT8qPCgYWkxrV4X0y772G
         t4BnwkOQ9iZT+oOcHmgAOYojbuqaZoID1GVuzBvAZqCH/fRqHYuwzZZkeYVTKFZwqUjE
         6vTgU/pMFg6W0TS2nXP3jotLyVfhiZ7FavKv5bTZW33GN4hE0anwu572LtYHfENhebok
         PzdujddDN81Nvc2Q8YjiRYVHIOLOWSfZdGX58wVuqueONLc2MIkf/Pj8pA0/lZKrbrwH
         hc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262771; x=1790867571;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gvSKNoOn4vM5/R0bP+3l0LZ3cRQeqnoPEjhgdn22ZdU=;
        b=xPCldIRowfpPAf2menxKSC9sPrSkSUFD/mpEEbIJ5wrPAX4C68HmiINI2Te0o1ia0P
         9OXibjxzgjRLqxGNpOeoneUlXoZuBSW0ojaM/00Ne4AmzJy2DVg2tLI3CSDINL4vvIhR
         4Mf1+v3CwDEk/FBx46B+OloeBnCb9q+FVFLClqyXdDlYqo6v1o94UD9PFrfb1oH9kdF6
         8eW9TM//HMX6A32j/FqpBz9nN25oWqJQ4gaQD3ae7eVEI145kV0vJHtnayI2rWOINDXL
         BieMGp0XG/eYpLiedll3rJkQQcP1Jiy4VPmIIFLigX4eCicN+PrmKgknu92TPEdYhX+b
         IvvA==
X-Forwarded-Encrypted: i=1; AKwUvBz7NvubWcB7o7ZFEI+LFEq5knK/TWfFxD+9m1XboePi6BABb3EV3M+oOgN73iZvfBfPaSc=@vger.kernel.org
X-Gm-Message-State: AFuF++lFApwXKKCMu/CI15FZA79osk26zd45qhI+CAQ6ZD0il6hNqcv0
	FoejvSgQzP/5zqR7jBCd3q/SkUVFDyY62MpGc49CfFqrIWgJ0Opdq4Dj
X-Gm-Gg: AYBFou1vRwGonGdMtedXzXv6iMEoUG3kCj0BdJEgmXwAz4dMjCN1xQeTPQuAuuORkq7
	1pOq+uAB+UuNyw/Y/6DZycKfNS+cDXCGL+nGrJ/ErI9drkbpPvRNe/j4DyVxQ9EaLmx63NoZW4H
	ohcUNjQg4h3GAOFqZvRzqbdRDFO2nQR8TlxUtvVjENmtm9k8RJeRChduN+MBExzMweijsQc1Lbd
	xBKQb2eaylbdkxq7gkLG5/401ZcuU/rDM9X5sd1PGeAJ/TckhmGMEoQlYfaBcH4nUbGrzMAzNMO
	r1wHro1mN8LjmqYGzgglD+v07jULzfeCvxXYGYbTteoUzdGAkFcA5EltRHium07JRl68M30hXAQ
	CSENO5WnKaXDZjAEp3wVXVoedzjtqhde57Gi5GUV4Py1IORe3pkWAF3pGLrv98+uF+qfgACLEkg
	3nj0rP9quUP7BqbcmFAmpaZpfxYQfwToGZIJY2iXI/i1050/PyXN54yK1jaE4wHkbDY7CKAimZb
	m4Fo9lrKKRWRQ0O92YH8H1jWej2dbLv5r77e42iLJ3y83LVtB3kN4Bu0sVSRqX9xn0h/J29GaZH
	SIQ=
X-Received: by 2002:a17:903:2f8c:b0:2dd:c053:e0f9 with SMTP id d9443c01a7336-2df7e43e249mr21645835ad.40.1790262766431;
        Thu, 24 Sep 2026 08:12:46 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a7b76sm29253555ad.20.2026.09.24.08.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 08:12:45 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 15:12:44 +0000
Message-Id: <DLNN6OBVQG1W.3QKYZXB09YNWO@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Tejun Heo" <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 07/18] bpf: Size liveness stack masks by the
 stack each frame uses
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260924082607.2695649-8-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com> <20260924082607.2695649-8-memxor@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 10:25 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> -	at_stack_in = kvmalloc_objs(*at_stack_in, len, GFP_KERNEL_ACCOUNT);
> +	at_stack_in = kvmalloc_objs(*at_stack_in, (size_t)len * nslots, GFP_KERNEL_ACCOUNT);

at_stack_in is now len * nslots * sizeof(struct arg_track).
One 8-byte store at fp-2048 makes nslots 256, so the subprog pays
2560 bytes per insn instead of 640.
A subprog with 900K insns and one such store asks kvmalloc for more
than 2G and hits WARN_ON_ONCE(size > INT_MAX) in
__kvmalloc_node_noprof().

Should we clamp it somehow?

