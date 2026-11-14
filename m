Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794683333;
	b=G8iR1u+mE4ml4N8a4TA19pCBJ7NTm057AZMW03jNIwWjT/nC/r0hyvFLfyaqP9k/rU7o
	 GWpk72DZ1+U9foFQzKGp+m4U/V+NJOpesYto/hJ7FF9Qn7nLevKHXAuwsMlZQLTiVua7S
	 QFvQyMEITLbqyV2FJbbDAa1YvApooG3vJ6wHN74bZX5WlUGVqEOCeJTD+sKvXH7K93jBv
	 qySOQL7UX4hf8gJ5i1qJ1gt5V9ePCcqWTLe99m/WShEh5aST1t8SWmuS3+PnwLrXCi+1C
	 eOxW07KdeXY6p7L6utlwshQu/A24k13cd50UmL7bOxzxG52xZMR0tx5RoiC6YSHs9tA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794683333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=lxmRDFoHxpt+qxahysWPY8cNjC08++XK90U4r6nVLsw=;
	b=g1+5bX1s1soNryR2/VbXf1EIgMrc9ZMbdOlMYn00UI0pxL5NpJ80kW6UIYSKu0ROG2iK
	 IrO7VaOAvdnDydWj6tEMnFoiMETygcqJKDmKFmMGKXuMGrpfhQXYVQj7JAXTVcgXQawRN
	 jwLQ/Q52DXxU19gdc+4/oYB/PVZPK6tAI8PQ4CWy9F70uMK/AhgOoBsA98ey7T/goKijZ
	 X6lgiBSmgxhlaFTqISaClWrHH9EHkpozOyuwJBJZTShNwB1jX2F+np+zIAZGCi/LAh+Kk
	 wBrxvhZwFz5EvTdlMCExLQgLZzF3+vm6AxMvj0/+Z9fhlyulaYdjWkR0s8+Rf9sspdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hX6nwmg8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91689606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 19:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91689606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hX6nwmg8
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e987a2ba0cso11621815ad.3
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 11:08:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794683333; cv=none;
        d=google.com; s=arc-20260327;
        b=kgfa+L8AAJdijCdYFQ2P8m7aFbUu7oPtq8NqTWccoGTMSeGzEHDdIWEnSkfnJUA2KG
         3XvKr+r0KqWS5FLmyXdkaNsesE9DKgX7yxyKct0B0p9RdhdXOaqqHUaOxIWZ6AAlgTNr
         1xUoKT921tUfg66BJgSk9mcoGWPl2oxbi6Mdxp/r3VmgmTXfv/Dt/Wd/zBqbgMJO1hhf
         Try9puTFJ5PgLBU4zfOeRABoyfm/RnNFJBe8+LtmTlIryhFGk06JgBfovpyt7FgxbL4R
         ZsvJ15xRgsk76aV/KYo1bwBPV7yO93LymR6aDBHh4ez/krS7fmAzvhs2+4F6xDWtVMQE
         5I2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxmRDFoHxpt+qxahysWPY8cNjC08++XK90U4r6nVLsw=;
        fh=pEYwSXBrQA3iHjmAtZkC/joUX6hwyWYKBb4zPqGp9vw=;
        b=H97D4o9Kr/j7t6SgMGmeWRl/Mb4OGe9df9tUN/hATqO8ICfJSkfMjns28746VzDjMo
         3yenyXgf41lpz0JO4AQCLOeaNC3/wbTKrazncVERvUGuIeNh8QN62UhqiDIE1T8jCJC9
         00Cs/AY86ZkYbsrgwXw5nhp+ONoMSM20PvPakzwbQvQx0mzcO9cIBV8WSgJiGnFZvOuk
         Or6TjnA/j8t1VnNY1QVfuQChjTQ96mkVXqJTFWZ+TtrA40n546NWtb0Tj+vZPurcdp+r
         F1JX6u4JpNKKtE/JOpzx3ssiS8hj0HsKBarBmuaTeMtM+3kvZU0fQCSGitQTaMmuWmF6
         ghKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794683333; x=1795288133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lxmRDFoHxpt+qxahysWPY8cNjC08++XK90U4r6nVLsw=;
        b=hX6nwmg8Rs65GoXZ5zZB7Gd+AOh9hOUa96uBWwnYwRTzYswLc3aPgt1QSSWIWJ2ZNL
         w1OYUFY9NOmjZaShrhx2Jj1npiVNQ04Y6Hhu/S4bTfRY274mBn73KcPczVJKNfaDyTq/
         s3EPjaXHTJx4ZUmVMtOGA+yLUeLpUtEhqR20JdQzsRQOCACtHjU4EzlwKOZC7SIxXH1w
         /D4nbX2IcT9o7JbKePam36e+s+dAAKf2HaVd137ni10RqdwaEWxW0E6gqIN2/d1OAQBG
         HpgEmk+cE8pKWnk/iVZuCp+BQ/Maeb2RHfQd/nXiMu3P8rJ1lUkCy8bZejy+nfIARXfJ
         sWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794683333; x=1795288133;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxmRDFoHxpt+qxahysWPY8cNjC08++XK90U4r6nVLsw=;
        b=pWQUuAX+yJnGopx/EWkjPqwIrEY0pzhrgt74ZaVwcNNxZn5NgVPZNZNbpmV3sR0bOb
         +sq1eLl9omq8PWXUOK5NXpXyP6y+JJXb8HGgPMow3SNoTw+Bt4e7Uy3TDPnCyxgN3Pc0
         z3ou7XZwDgg9U1mr8YjEh+8tVZW4zWFts9FlNyBJDpe+MH+ZjcsPHiEUHQhcrtmD11xe
         kAWc70VLYCQT04K2u39HFwZWfbazEMw/lG3ocBrNnfFNnYwgbrjs158nnuCgbPU87QtW
         fM1+sK60n3GGLGdfM+FNK7DT+NmA6PClkoZe5uHCSh3P1PPIBLdqLTVXP3mZ0fcQdEzW
         gemQ==
X-Gm-Message-State: APuU4Z+w3Fx2kNxRmjyqocDyHTUCE1PAQSbWCKy3c2X4aJ/zz1EeYsly
	7wQAFuMiwGoSiyE/ztu06c2SJt7BULavcsjB4ZStovlEpxIoJbUZn/XcAFuQDTjEDC07mElz6oG
	nDKRlimKTyKjjLuonhhkHsaCiZWG6oVU=
X-Gm-Gg: AYBFou2IkBZwVtuyVUWHaveaS18iYeQJG9bKsZLmQqeVWBznxSZWyIphREQRKQW+7l4
	vXZHiHYP/NLR2t8JRhikIzCj8spQzYwpFpS6VCZivk9pcprCWIjUJu6Q5WD9GLvVQWUcT6WjKt0
	V9xO6wleCVxsJxaJ40GeLNtt3l0Fa0Wh94rCyHnH2LsMX/4DM3S7UGcfXkgHczefMod1ro68gGf
	R+wDKpAmDRwc4w3i5QNYcYozPlXj6XQqFrJxfahoOvk90p+3cgWVB0M1aU0sa4HxbBCRSemjj0w
	f8lWB7Y0hVceyX7IOIpDNTKpBqbZ2E2+gR2jcmRuFTo4Ld2C/k3KjIziV5qzN8Szr7TOZ2MvXCJ
	q6V4y0lHya+n5u3f24LdLcYldW/KhiE8LlVZKZDOVhcKZO/ePvGzQETV83YbxeTaxqcIHe7Cx06
	09tD2tLl9B/QeCJgVegM68jqhb2er9nwxv5WgaAslJ3/Zjg8WfXq8=
X-Received: by 2002:a17:902:da86:b0:2ed:1fb0:7784 with SMTP id
 d9443c01a7336-2ee0da7bd5fmr58535095ad.10.1794683332797; Sat, 14 Nov 2026
 11:08:52 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030042138.73739-1-kylebot@openai.com>
In-Reply-To: <20261030042138.73739-1-kylebot@openai.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 14 Nov 2026 11:08:40 -0800
X-Gm-Features: AclHuK--H_3_n6VCnyOL61NaQc63vtDDD0D0yPb0rGJY-Xl4-Bos2pmaPEQ1p5E
Message-ID: <CAADnVQJ=nsuU6GTJFG8VnF1drWW9pQOy9=fB3UhUyRYAOUmGuQ@mail.gmail.com>
Subject: Re: [PATCH] net: skmsg: fix copy cursor when coalescing clones
To: Kyle Zeng <kylebot@openai.com>
Cc: bpf <bpf@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	outbounddisclosures@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 9:22=E2=80=AFPM Kyle Zeng <kylebot@openai.com> wrot=
e:
>
> A splice or zero-copy append can leave the destination copy cursor at
> sg.end. If sk_msg_clone() subsequently coalesces with the last entry,
> sg.end does not advance and the cursor still points at an unused slot.
> sk_msg_memcopy_from_iter() can then walk around the ring and write into
> older entries, including file pages spliced from a read-only descriptor.
>
> Software TLS can reach this with an ordinary MSG_MORE send after a file
> splice and a splice from another TCP socket. Both TCP and the TLS
> encrypted-message allocation can use the sending task's page fragment,
> so the TCP-sourced plaintext can be contiguous with the next cloned
> encrypted-message range.
>
> When coalescing with an exhausted destination, move the copy cursor to
> the tail and set copybreak to its old length before extending it. Find
> the actual tail on each iteration using the ring iterator, including
> when end wraps to zero. Leave an existing copy cursor unchanged and
> preserve the normal coalescing, reference counting, and memory charging.
>
> Fixes: fda497e5f5b8 ("Optimize sk_msg_clone() by data merge to end dst sg=
 entry")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

pls respin and target bpf tree.

pw-bot: cr
