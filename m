Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C738E5C4
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538202; cv=none; b=UqRDoQ1mTzwGicpPng4RAB5NwKknL8vgQ1OdK0N6umh+DVw2Oc8iCtiTB7VHXaX7rxGFC2kXEk7NbSc30/2wE++4StOMzEcSQ94H//0gO7zQuXqYdjOZ8QU0rRyIIJJag5pGOX1LgDHhTqM62RCheOvo05VYmAhrShqhkkLzSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538202; c=relaxed/simple;
	bh=UDTVDnUXu9J4XV3/ptQRkzdtrgJX58vF/HFgVsvjVOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eF81XbboJ5Zz1wQhghwDbEwGgAGD4fqW98GMN7QBpTy8/kmMsdTm4FHfquwMdHYIIc8RcmFZj10UkuKpQH4fYpDmx7cs9FSqRmApKsRmPzg6ef0kGBJ5QWhgb2EGLoiEHel33A6LxNcCCVzqHxkBzClfxYlyokW4Qct8FcsO8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPTkwd7i; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPTkwd7i"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso335912a91.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538200; x=1790143000; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UDTVDnUXu9J4XV3/ptQRkzdtrgJX58vF/HFgVsvjVOI=;
        b=iPTkwd7iD+A2arVEdrUvIkZ9nRw0nHyXKpA6fm6eKLm052eHAy6eqCSZ1DX1IbLiEI
         NEudfCJq7UG1cUC1hfv9bF/17z24o31ltPwpqRfi2ieBUIO4d06KsprA6AuKi9yxJNG2
         mwkqtJRJTL/Mc2CrbBXST5toXDcWPfwuxl/0Qs/yLOVzty+h/8auf4EXucaNh+G61KRv
         ln4n5S1ZFcjfepUFIibkyRZy6LTSLzSzGHCCSSVwd6gNPxcjQD4LnXUc47dMg+kvloZE
         XDEv3oYnaRpDN7GFDC7RI12jQVCyaVzN01gqWWuj9nEjEGDN4M/FYKnu0FoeW0Vf3yVn
         ozIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538200; x=1790143000;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDTVDnUXu9J4XV3/ptQRkzdtrgJX58vF/HFgVsvjVOI=;
        b=G8N389sD5puT1Zc/c8gmi7gf6/MtMpzwL1OcJSLJR01RasVm+gN/IjY3JRC9ERbnNi
         TvQmLCrHXXTuGzAWSCQTJXdyb4a8mKyJ+7uNEt0S34sJjc2RU/uJZjwNZeyWyYxZKVKu
         HVYRn4BcMYs39yjQPyyDEAOFKujZeCPchUZ5OKtk7HsCIMkHCeS7eHlyVBZZLdv6tgGt
         HqeM6bsBwrf5lhiyTjRNsx0PCN9tn1mMq+D/rMAN6UyYIVo/FPexW8YTDHaa5eXZ+xX1
         DO8dSVsvbEqTC5LWTGks3PusL87ANxLSkrKdnfVHp0BL5zqMXjscCtSdKRxbJzlgRHVw
         RGow==
X-Forwarded-Encrypted: i=1; AKwUvByM4NsCDQNCPYR8nnkdG0wfEjC0hiWV6n0xGaEcCshhXBe3xHcXkSq8mhWmq5ddRh6qp6k=@vger.kernel.org
X-Gm-Message-State: AFuF++m432pnbzx5fQiuvKF545X0yl3vmT1DuF2NkHVb45Ot7JTNG7+3
	x7Ze4AQmepBId16BIgzGNy6JWxpAV9m/2HaoZMoc/K3QGrkSE7ERbqC1
X-Gm-Gg: AYBFou2zhFg9w2CqSQL7sdp1DZW1LL8rUGgxqNH7gRALlgWyhRxANCPwBJLDzeGUHP1
	fGtP0kIgOy289+NR/xMJh9K4SOvfQ2PflKgZ3kOsKr3cW6d6UwMJidzzoq+Vb3ujMFBHVVGspLr
	VTNoIWG+315GYdb1j28VWf0fiSi1n0gpNM5RPc5/7b2DF8eB9ovoNzWrkqZMuxV0LW0UGF6GoMB
	ddCunsz7O0K+WRBhvQHOp7IWBxQmXXyT1w/+9rcPBt5tyIfHoiFMmCCQrgE3KqVoYUvwtilIOQr
	70+A2K4Vlv2m/clfs5hgT2zuAuDlcNpMHn+KEbLwZIeEjCelqR+dAq9vePEjidPjzYPmIfLnsup
	tCFf1yLr76KyoeAaT1LD2Iz07RsncFmyCobDARZ8e8q8bvwTCPat/50ZSkJBnOVTiWsH8WGNGEG
	PrDhBcgHJOma1Yyiiv3u57hPzv1PvVKTA0xrfpgGaE1+6ZIMWlHPCD/bXeoBAZGUwYVnPpmko3Z
	S/7mj54mHmk75+DFz3xkirv3JKQewDs40gPAA==
X-Received: by 2002:a17:90b:2f0c:b0:39d:f08e:e6e7 with SMTP id 98e67ed59e1d1-39e1e308bddmr3661926a91.9.1789538200130;
        Tue, 15 Sep 2026 22:56:40 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1e25f446sm2128570a91.17.2026.09.15.22.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:56:39 -0700 (PDT)
Message-ID: <595090cd29f18845ed00d87f13b49907aa4b4c12.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Cover generic __uninit
 kfunc output buffers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Tejun Heo <tj@kernel.org>, 
	kkd@meta.com, kernel-team@meta.com
Date: Tue, 15 Sep 2026 22:56:36 -0700
In-Reply-To: <20260915141004.1196460-4-memxor@gmail.com>
References: <20260915141004.1196460-1-memxor@gmail.com>
	 <20260915141004.1196460-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 16:10 +0200, Kumar Kartikeya Dwivedi wrote:
> Exercise scalar, scalar-only struct and sized output buffers, both with
> uninitialized stack storage and with a checkpoint that poisons prior stor=
es.
> Run the accepted programs and check the values written by the kfuncs.
>=20
> Use the annotation-driven loader to repeat cases with CAP_BPF and
> CAP_NET_ADMIN, but without CAP_PERFMON or CAP_SYS_ADMIN. Prepare module B=
TF
> before dropping capabilities with __prepare_priv so the cases reach the
> verifier. Cover stack-passed output pointers and outputs following by-val=
ue
> arguments in both capability modes.
>=20
> Cover multiple outputs, an independent output next to a variable-size
> buffer, variable offsets, and write-only maps. Check that read-only maps,
> out-of-bounds outputs, uninitialized aliased inputs, and reads beyond the
> initialized range retain their expected rejection.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

I think this is a bit over-enthusiastic on adding more tests.
For the actual fix only the following tests are necessary:
- struct_poisoned_at_checkpoint
- sized_buffer_poisoned_at_checkpoint
- uninitialized_input_alias

Also __prepare_priv is kind of a hack.
It works now, but I don't think libbpf was designed with an idea of
dropping capabilities mid-flight in mind.

...
