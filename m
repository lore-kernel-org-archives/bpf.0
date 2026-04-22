Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45130E831
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870193; cv=none; b=Oa0bel6jJtp+mqqex+B1o1/rR3DWIBBcN1I/IsyL77089vsjY5wAZrzLvkJVti+p3Qn63W0XGyK74+TEGq7+1eka3vjpqp1ORdzOvBDkNPhXj8abcD3DzT0t0vh95qjZ+cqCJZ2IHCFWnEGJ2oyZF4w+y5Q5QerzXQIQ7WPllpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870193; c=relaxed/simple;
	bh=lOFl6XRXBoUoOSiYAzvYsCUI5J9yq1KoIEk4JNlq8GI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WC6o62P18T/ySUnqV4OB/3F8e9WaiYLxAv+IMVbur5d3WjaS1Adcder2eD9qLiOxToAZoxtVvDVmZFKnE20Pc8pQpm6Eo2WpS8PeaJJgSlyXmTb7Q16mz1Kx+AVhManJceSAuAIV7MN+ed7+8BAjTLmD+KeQv0bdepMv50aViUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJGpoDRe; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJGpoDRe"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so4985284a34.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870191; x=1777474991; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8OwaB3DJ7fnEmN30yJaCu6WOEYGZS1yXKY4Fh8PqhI=;
        b=NJGpoDRe/nsBSeCCiaQTyU4e2OAFcXwo1rr1QHV9tkYicNSpCEc3ClWbP4oH5De/PT
         YujrSGBtskTgbL+Td9Ua9cW4EVSFVGjbrB6ZNHKn3J7h2knccXsyz19dJlbliR419/Z/
         1eDSTK/3StVAVV9rjm2Ws+TfbN1WKQhLJdmuiCUwacRhPrtjcm/71o7UZF6RwsB6pxXI
         qYh90OeI+rm5cl0i4nFbm0KXJENzSAURAFtIHaYcrcxg1YTZhVVEgo1i0a3NKJyXqglj
         BZmnF5rFRspGURamFHt4Hzu9PpfzTt+AjjAEdAMI3fFUr1GqKtyLnzfAQYIVcg7obBEK
         HJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870191; x=1777474991;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8OwaB3DJ7fnEmN30yJaCu6WOEYGZS1yXKY4Fh8PqhI=;
        b=d9G4C4IMi1p6M6lz5NCBUDxKV6f1aTP0OFEkp1pGNJfNWMLwa9UKLQx3PWmf4z+VK4
         W331Bq1hdkUz045iPOCjMQRNKvolh2CQLFm2uaXqnxtirg9i54Es4zkJGedJLIZU8tzG
         Se2ZCEGcZXW+dPsu+32ko80+GAC1xX/kTYzoXQNVI4gWn8ciOF1xuwCmzfhsCeBZ5otm
         xVnxMY3/2qHigbJ4zACoNv1vSblG8r6PTqrrqpelp4t3irW3rK/D2B+mI8taYcgCLRYT
         igHN4a7xUVOZojgum+xFeDcYshtAmjK6rn+8/Bo69Nruf4Nc9jdIskTBw9XvTbAkuzKn
         aPdw==
X-Forwarded-Encrypted: i=1; AFNElJ8Lk6QXU6Xi5yITwszm3kvRNyQvh/1qDUUVVRicWyn7J/7Z/IXEya0JGhRLLl6EJASRtyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGKair2fncByGCkufrFTMl0xJL1cvNOgqE1N+POc/OUtVX3HZ4
	p2Jq+Z8901Q4DdGNzI8gDEzPipJOxvugzg81UIC7Rjuqdy7EfQ0tp/vO
X-Gm-Gg: AeBDietJibv3nOfUTpAPbBEd05ytYeF1OxUznyWqL6Pjo3LsrdEZgCjuK5hyRZq9s/q
	3OEL8b+2Ktnu6eT6wlkVI2hTkA4iMZ5M0TcQhOAD7hM5jJARTPky01S8bqIAEpO2et5yA015JaD
	85gkwPNVQGvkvTby434Nr8uYtHyhGYt99yUNHbAwVSkzmLV0n1GZx7hfwdwLBu4bKjk+0PyToeA
	TmwH6Pqgs+QiXTjRv2L3+DzHLkzyh7NzqtKIMQ27G6CtAey+AZenhMu1BgXt1cWDWLWMWoKIa+p
	XHOe+ca2oERHTfsTds+CiqlPy+jzsTV1Kf2q12Y1rfmRqAJv32ONfOYqMk0r3G618o8LQok5rAq
	fGvQzLK8pTwjoJqTBCorVZh+cKzjk7przy1sWmFtoTPx45MLZ3uR5wcpmIWZet0hEOeazGpkjxc
	Z2aES3kRbSjeJny4w1W1co4F06oY0xPZbg9nFVrlelIbZ8GUSOdc4FHwsmTNiAO1ehUQGvv231J
	6iffMeXKC5b1Q3S1IR2XGg8E5Y=
X-Received: by 2002:a05:6830:2815:b0:7d9:b2b8:e06f with SMTP id 46e09a7af769-7dc951d6926mr15603354a34.21.1776870190595;
        Wed, 22 Apr 2026 08:03:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm5721162a34.24.2026.04.22.08.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 08:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 08:03:07 -0700
Message-Id: <DHZRWV9NZOPX.1PD401F76IUT9@gmail.com>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <shung-hsi.yu@suse.com>,
 <paul.chaignon@gmail.com>, <harishankar.vishwanathan@gmail.com>, "Shenghao
 Yuan" <shenghaoyuan0928@163.com>, "Tianci Cao" <ziye@zju.edu.cn>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with
 struct cnum{32,64}
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>, "Eduard Zingerman"
 <eddyz87@gmail.com>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <andrii@kernel.org>
X-Mailer: aerc
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
 <9d47111a-61c8-491b-8750-63fb79968125@zju.edu.cn>
In-Reply-To: <9d47111a-61c8-491b-8750-63fb79968125@zju.edu.cn>

On Wed Apr 22, 2026 at 7:50 AM PDT, Yazhou Tang wrote:
> This was built for potential integration into Solana BPF and is

we were thinking about adding these insns as well

uhmul64_imm	dst =3D ((u128)dst * (u128)imm)>>64	0x77	BPF_PQR	BPF_UHMUL | BP=
F_K	v2
uhmul64_reg	dst =3D ((u128)dst * (u128)src)>>64	0x7f	BPF_PQR	BPF_UHMUL | BP=
F_X	v2
shmul64_imm	dst =3D ((i128)dst * (i128)imm)>>64	0x87	BPF_PQR	BPF_SHMUL | BP=
F_K	v2
shmul64_reg	dst =3D ((i128)dst * (i128)src)>>64	0x8f	BPF_PQR	BPF_SHMUL | BP=
F_X	v2

if you have kernel patches for that please share.
