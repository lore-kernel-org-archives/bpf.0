Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506D3E558A
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916823; cv=none; b=VmiGZuHeLqDEpUdjXwNe7q/P+RObf2EwCHdBmxlAnh4IqdRrUwlarladBFYBy7xH77/RvqNNnwjGh2A9G2M1vD41nNj8qoSJrORSCEXnJ+pjDAyH1uamJFPhnHTIJGurdua+q3Dw9/N56FqZWtXX2oSTc/4l0vC80jhj8XLWi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916823; c=relaxed/simple;
	bh=5rKMMPjZfyBh34XncWy6OpAC8bc8/u1GLvwXUhf45j4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZX/poeumnuVaPFLDkJLuChIv5A4qL367JxqLfBEIbfFHi9CEvpjtzKO6nZ+Ntg2Op7Tpci3rUQyH1QeE10Jytw4KSAvLg3rmFxizyNJ5hhEAuc7s40sBHrxpHyX1QI+y6p7cphQsbsvumnjjar8FEIGUMvLk9nPeMfri9NzE/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwul3Ajd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwul3Ajd"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso457603a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785916820; x=1786521620; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5rKMMPjZfyBh34XncWy6OpAC8bc8/u1GLvwXUhf45j4=;
        b=pwul3AjdNS0BfNDaZMTrsPqNGn28qKHKslotybrMoOkOjtdSbXFPKeDy8Tf0bvC0fs
         mkcSPqfIU+5UhL8N76i9AEuft8NX/kH50xGH1OtappQ61y+ZFYZW3oOGZ4lytEpdkxWv
         t72+QwLu3E2SeVEkI+WirjhFSQK/kiRG1dXwxQzKsAtNkcOq3kTDpva7K32TfL+XIEjj
         +Er5p5+j7Hbd7T+FW/Q/CVEhQxtq1s8lKclBNXi/wN/+JprpwVcwU9ADvH/JPv59kh33
         psQi9GJbF3hf03ei3Bjw88JNGb6uaES+rXDlnIQf/mlCko2CAMAE28d8KsxIj/KNXRrj
         S+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785916820; x=1786521620;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5rKMMPjZfyBh34XncWy6OpAC8bc8/u1GLvwXUhf45j4=;
        b=R3uprRFSGYMqt8iOhK2a5FqFcwauqwb615/KxvZXUf0rbeibs7cuh07C9rQtbPMzZo
         w7ba2kofmL5MVCoXE0MLQnd8UUeAx2ydt23xvqYcefvq3gqwal7hKviRNucasbY7CfYs
         h7AgnM4w6Bx4X+bXc/mji6dJSWXiPIioi3mkgTqxkJHhrZx4MaBFIG8FVOYXJwvETOZu
         dCxmBhEl4uaVJH8jolWKMlGVzz3c7ljUKmrkqnxfmLKIC/su3p+K+/06d3SwDJEA83EQ
         SWqDeENnfWS+WH6ZdkHPCMS6XhVokmw1CMFnsT0lHAvWqn5v4u3vs168USVJpzA2iLu2
         iVMA==
X-Forwarded-Encrypted: i=1; AHgh+RqWP3i89KvPYbIB7JYE1zqVMbZrzQiMZFFYyOjtGygDE9kUdtL/VLnDeQvCQSL26uekTkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTnwlaaqNAa87IBOO0MuNuwDdTfZFF2/GG3Wp5dg3ph+FQBrW
	XPV6tHJy9CCy6a2qtS3KOvJTwFcSpLb3t+vrPRLNWxntlz0cIbkno2hR
X-Gm-Gg: AR+sD12yi6FOpN7O3OAjqiaoFOMCKCTxTFJAdVJq/0bHw/p73A3y6YcTvpPx49EmI9a
	55qhafiiPxJeih6UY6onjbGCIxJpaqlbkH/pXos9yWgbEBYcJGRktmCf83ZmHVbxrGkP73utzZo
	ylg/pXLchZe0ea8IE77xW8pny1mpzoVH8AEftPpT1gafUF+BpMkarRpFqIE5UxzFUtKYjPKvtKE
	uXA07hu5GHSlQXC7tj9pdfvZkMHsnfvoesnxJyMK6dTL3vcZa4tiVgKEnADMgJtqvF3lP+cbebO
	n467M7+HU+He5rgjM3o8sTofSrPS3+sTop97xuNe52BVvIpYkGBMdrX9IY7ksrAHOzADUuFFe+/
	ejfFI4+XFEECa4KxS7xpBGaVWszeVjdd1yvmRA6w5x80O5+mlDM6ia6pDrwxDzQZBM8GzPdgmpo
	gQLu/zcIdlw70WhrkRyK7BVbuqlxQT4a2oX42EtF8ealhPgUMmC8ctX5b8TspRz6GEn3frvOdal
	hp4utK7x8V6GNpe
X-Received: by 2002:a05:6a00:22cc:b0:848:2c6c:dfc0 with SMTP id d2e1a72fcca58-84f2e04ea1amr4864948b3a.24.1785916819838;
        Wed, 05 Aug 2026 01:00:19 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e4d3f58sm551570b3a.39.2026.08.05.01.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:00:19 -0700 (PDT)
Message-ID: <f65591b1944cad791a6f952f62e958b4b689a7a7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 8/9] bpf, x86: Fix stack-passed arguments
 for indirect trampolines
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Tejun Heo <tj@kernel.org>, Alexei
 Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>,
 kkd@meta.com, 	kernel-team@meta.com
Date: Wed, 05 Aug 2026 01:00:16 -0700
In-Reply-To: <20260803125115.2264733-9-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
	 <20260803125115.2264733-9-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 14:51 +0200, Kumar Kartikeya Dwivedi wrote:
> From: Tejun Heo <tj@kernel.org>
>=20
> save_args() reads stack-passed arguments relative to rbp assuming two
> return addresses sit between the saved rbp and the arguments, which
> holds when the trampoline is entered through the fentry call from a
> traced function. An indirect trampoline is called through a function
> pointer, so only the caller's return address is on the stack and the
> arguments start at rbp + 16, not rbp + 24. Every stack-passed argument
> of a struct_ops callback with more than six argument slots is read one
> slot off.
>=20
> This has gone unnoticed because no in-tree struct_ops member passes
> arguments on the stack. The jmp-entry form already accounts for having
> a single return address; treat BPF_TRAMP_F_INDIRECT the same way.
>=20
> Fixes: 473e3150e30a ("bpf, x86: allow function arguments up to 12 for TRA=
CING")
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

...
