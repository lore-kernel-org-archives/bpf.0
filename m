Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0953325706
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412551; cv=none; b=DA8llcLWtsmIDAMX+grPCUYH60dbPbBR64YTbtmdTQF76V+9m/l6bw6BwutYKM9a4BdUtdzNL1YUrL+DI9SLM7U2sRRmtJqucCFcn/lNOV7Mo4MnPlbitnNuWYjku2Ol7h19hPFn1uzlMyFPsq8RxI4kwSdj2eFyuLD2rdeSj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412551; c=relaxed/simple;
	bh=pbnQvUObWHChwdeU78kOb32OMWw/eiCrDdOE9qMKDbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ule4YIrI8LzUHdfZ2wvtzGQL06c9cyOH5DYupUbrZ32tMns9+4tLDAn3OG2C38VcWOXWHYt1P5Pse2YFpd4t7CWFmF0eqVB93atTBbAkqOHWohVbxybwtQ74acMtqIYhosm514E27/bmUggHXKhTzFUu5yyeRsYIaAJKvA1viRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yk/F8Cu5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk/F8Cu5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37df6d9ec2dso77182a91.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 11:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782412550; x=1783017350; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pbnQvUObWHChwdeU78kOb32OMWw/eiCrDdOE9qMKDbw=;
        b=Yk/F8Cu5z9Qftq4kL0YbHWeIynpcRxizHquF1lznHRBvb3b3w1LvYe28m4/RXuv9Dj
         T6Cg/q46U4vH9/QcRmoc0ldENQvifiGxKvm296GB6V7EuasCC0ZytIc6HZQd5HSrEgEE
         aQAxMMYBYC3+CPXAhRocG3GSWB97CUeie2ckISbY1Ns/AWaPX1Ix9MfFi9vxknulDTTw
         jA8AaWmgrQuPQwbwascNaGLIz7cADlUC768Tiv9b5nug81d4snqB/OfW8zqIfCte6ctr
         rvuxTiraCKE4pqbJ3NMWdp1KSrG1gzP9m75PM3Mnfi6sVj1IRiW6Flk12bdrMW8SYMaU
         6Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782412550; x=1783017350;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbnQvUObWHChwdeU78kOb32OMWw/eiCrDdOE9qMKDbw=;
        b=OWKcWcR2gVblNzHQf8m3kMNlD5drjbYFe7NuB4aHtpoFu3YOxXq/zP+ig9BS0T3Sv1
         j+7sOWXS7za9VRaFjEo+5CiCABZPxFA0KkK7aC56mEN1QGpVnQ5mwvyCHxvQcHPL+HGW
         /RKSj/zC9V/kGp3NbOVsgGphOYkcQoafhRnfBWQ+AIe+ai2oSqbzJtbUBY63cR9AU1g4
         LZzJIFzmPYUOpd6wKxOkQ1w/We7V6TpSO0pv0Il+RhBMvebGX5EwKweEbjSYClBNxXyw
         lGqzss7neFAWWIJEkLsNOMlsX4vf53nnNMGt+2XzKJQmb4PByBG1Z9sUMh/t5yq/brBq
         eMbQ==
X-Forwarded-Encrypted: i=1; AHgh+RrValQ9o24NiU/U8xvben2fA4YAShPBecsAInGIkCXVz2kmceh0SaBaiulrdc3OacwM+Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySsZeHYcVlHD/AxhXaqH54ZaHBstb03ImsUpfnEHGXMQNwk6dD
	M2P202iO2NxIZOOfvWJFhq/lHaQmecWqb7oUK73oIzaCC3mCGQbYy8IA
X-Gm-Gg: AfdE7cmLbMZUsx/pyCmt/RMWJwASJ3uXLg8Tpml6MDSG5Rtp7NrgL+OWvD3YSRHHJao
	6xeHCVtHwOkQjSgjgDtZpnuQs8zFAgjapIwGHCSV/fu1GzVW6126b3DrxeWVHJJ4bDOBXdLCWnv
	WVjS7oFZ1ihBrq6lWOC9WC/YRi3cjMJMNX2r1ls9Kg6b2aUalKpwU3QFnHHlqhfZOIu55u9FarA
	greBl04iEhZsIeZNU1cUBk6b5AgwV2uxNhqc7BjPmFhZ7Kuz0XX09OHRwXEOM671NBz7x1H3kVX
	AhOfshp5pJ+eMAkne2gPkEpdRv4L+SR3BoUHu5srQLiiEWfpNZxIki4U9Buk7pd0ENcOshbm80s
	9rUGds85XVE0Czz2lir0NvP4NtD5IUb+ddq8N2R73mP0zVdvIzNKI/eJXGi8SFg7QMUyPgNBeCn
	PyoSw4kkEKO57eHIXzY9OxHQx1SISR56yMHHfo62qxYQ==
X-Received: by 2002:a17:90b:270b:b0:37d:edb2:830d with SMTP id 98e67ed59e1d1-37dfa1f3e14mr3498559a91.9.1782412550118;
        Thu, 25 Jun 2026 11:35:50 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df4127356sm2326548a91.17.2026.06.25.11.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 11:35:49 -0700 (PDT)
Message-ID: <34a46040b0e35eb63fa0fd22436bf9e9eee0bc97.camel@gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover fastcall helper stack reads
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 25 Jun 2026 11:35:39 -0700
In-Reply-To: <20260624-f01-12-fastcall-helper-stack-read-v1-2-e0a86085ef77@mails.tsinghua.edu.cn>
References: 
	<20260624-f01-12-fastcall-helper-stack-read-v1-0-e0a86085ef77@mails.tsinghua.edu.cn>
	 <20260624-f01-12-fastcall-helper-stack-read-v1-2-e0a86085ef77@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-24 at 16:39 +0800, Nuoqi Gui wrote:
> Add verifier_bpf_fastcall test where a spill/fill pair initializes a stac=
k
> slot. bpf_csum_diff() later reads it through ARG_PTR_TO_MEM | MEM_RDONLY.
>=20
> The translated program must keep the spill and fill materialized. Otherwi=
se
> the helper reads stack bytes that no longer match the verifier model.
>=20
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

Could you please add a kfunc based test case as well?

[...]
