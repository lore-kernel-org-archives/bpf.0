Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA134B1A7
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777258658; cv=pass; b=LBQhYvNs9PTPyiSryUAqkADja3aosPdNeXSdv3S8JAsBfSlxSbW+y9WRBsdKjq9ameiD1NU6IHDMjN/Gj1UmyPC0anS9w/iqRuOcYGDIxuBaALgu6jVr545pVw79f7ZfA4TAm4RuhwdBkQDQShw66XfMMrdjbVN+Nq5bjARxO0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777258658; c=relaxed/simple;
	bh=8dMygFUytJEMs1YRWIK3+Tn4nrEm8XrSROj0X+itmw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE56I6NmNaiwtq7agIwO0ORfip3/I57HS5Q/B0hhSuRuSSr/lYmuyLopIeOjwjcPxjx/q/ocfiTAhgbtuDQRKYPwhGJEKKZueC99EyNVNZL0tVYs6xgpp0TihxqB5Idz77WMhIM023U4ui6xFKS0qBXzc8Icu+8b9vuR9moY9pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL4uGMKP; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL4uGMKP"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so162736055e9.2
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777258655; cv=none;
        d=google.com; s=arc-20240605;
        b=TZ2kW56ISsRbI/D6+LQd6jZdNcH1x7dGO55wc+8yIUeH3+RyTAd+4QAhpe+RUoFBrR
         iSgLMbgVZb9rz1A++KfFHr29bAaWbolwR/tAPrYfjbMh+7zDP7YvCspqISz1A+A2fAw7
         N83lovyO2NF7r6XDV1gRG3s+yt1r9bDCnWV7BoXWw7EIdPpBRZvYnYVbpbktJcTwnz1q
         /Jm+Ujej4f4F1RYFg8/XDx1ZWYjSB802v3c/lIIHU+eKnZ1hsuzbXGTS2iDSsl6yH7qJ
         czYxjxxxn4YY4Z98gqXeAs/ELTZez6D/y1ofLUBT5HTq6J73rU7143XzVW7TGODTHRKx
         q/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZmRJmusgqsQpznZKGOW2aBXk2DJZZmsblMgmOD3i09c=;
        fh=cgN0/sYkXeWwXuqTq0mDxzy/mFETqDze6H8eR+sLDP4=;
        b=hJ1HHc1IZiWoPsw0WDjfjetJA5NM/tFMxnU/fN4s9zDtil7phNPlVqSRPnzy8WGzq0
         eZx13+MM3Ao47PBNic1/IX5WuFp2OtHTyB88uOwMJ5mXFg4ETKgQCZs/ZpSOgAs/hDbZ
         J/8KT/1riqK01wXvxg/MuaHOusw8+1i1zfALGGfu4fd8TD9drhSobs/p0VNkv26RObL/
         KZYVMsOmqWg5SEouRyretrg6j3oSjrHxMqjmwC5bJ3bAL5rxYp20UwuaLSv28jG00q3A
         QyJ/IqEXKPZ5zCRcP685eBJKSXGb5in8ZOzUps64XyRz0X+cBJ/DbHUCwLdg6j+tclTd
         rwXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777258655; x=1777863455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmRJmusgqsQpznZKGOW2aBXk2DJZZmsblMgmOD3i09c=;
        b=RL4uGMKPedmGYKsYoiSlXHqEWi6hPR3deTBR+SosuKfBtDMTJ/IYnchiCj4u/8BEgJ
         Zct5GCQ8qup3tnlrekMr60VHRYULH8XE2rU0ctIVw+zBKyCpmP5s5ztlvAOPKYUVzGgn
         qY22EsTPtzOs2ggoQ/130ggmmgFDeAjxy21TNrX+GZrLsUw61sPohNeEeRyv2Pz3UUQa
         ysbyCw+Adi53AhSgyO33KOS3D13XQYfzJjoH79vBLOLYVpKuAv+s/NtsQ1XhOcGGyCLd
         MeBVKmqUX2agfAvkF9D6tAZFNsOcFaCWF24nIBSaCs6y8iw6WIRt+ZioMHVcbRA+XqA7
         69HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777258655; x=1777863455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmRJmusgqsQpznZKGOW2aBXk2DJZZmsblMgmOD3i09c=;
        b=gvoQBvvw2vaCIC/QRLK5EHtxJ8HQeHU9U/CC1DM/KKF/5PiRacMv7F5O6x8ck948Vc
         INF3zzqh/SlwTj1364R+j4cF68Y7ADvygRIThgkitdX4yxiETvjfKVuxPXV0nPkFGIhw
         ibk4UYhxAoeX/LVy+cEvxbor5U2mg9PjcM1DxjlKepjJzPsGukZKk7MWXF50gEUIb6FE
         k+1bLyFF/TGderR/kyJIUJqzwMS6X08+duFFeSuVhAT2yeVLEi1G8ZwLkrjLfkHbxAue
         cfMq1HWXWJxhrdJR88zM+ctAjhfVP/xMsNuBpnwN6zU6mSsMcfQzcbX28WjNaH5FxrN+
         XGMw==
X-Forwarded-Encrypted: i=1; AFNElJ9mZFSpCkIuAzxGIas8SEA8l8opeVaHePcAsEtWdl0TT5Y6WnYbzarMQMkQtgUU1+bSfEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NDGCucho3nNvtObGAXFpn/1YLAdcajJyAWXdZ3fUs4fRtyFe
	WRj+BfvRssT9+pgKXhq35w094+twax+wfUprQnGUBPMT5Nhx0Go0slOUEOGiyznxDsCAPqGurln
	oBFuRhB7tgyZCHjNW14Z/i4d35+E1//E=
X-Gm-Gg: AeBDiesFpV61VZHfezDQxt0i2aJ92sBAjjKze7rDPW+MQoPkWWiph1IFrtA+37/xcBx
	FlgDEk0tJTF1pJBml4BbjcrVx2BcHYnOOBRKfKNwi1zRDlP9+cWKy58MiYS961Mucv6BzmKIK9V
	qdfWCpEc+fYYQook0FB+Pvw2JVgXmfFee0+l33yGGLmpcx17yzq/RVjnJoa/kSnzCQr/t6Nn6D2
	NuEXQGGXzRPLZtDNhgRzDtSlIERY3HWG+fz97ZU4sernVAMbLYS0DqxA6unEptA4kPt/l00g5fz
	+ke/zQTSl3DIlwomyKKrIGgDx3wU+HQctD2EA8k8wYwx9yuf+pYxlmY0KItOk1nVjXBqsPzld9L
	53/6jH6DECrk8jKa53SytCAzZkvHLjXzkdodOaTseE+QsNlKbsgfMisezkckRFKhZVR5A
X-Received: by 2002:a05:600c:530e:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-488fb768db3mr597309375e9.19.1777258655215; Sun, 26 Apr 2026
 19:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
In-Reply-To: <20260427001602.38353-2-dwindsor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 27 Apr 2026 04:56:59 +0200
X-Gm-Features: AVHnY4IcRwbwGGwdvR03dSV3hJJNxJUEaPLWc8-Ba8wrzAXUvhv-i_8JYRb3CeY
Message-ID: <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Song Liu <song@kernel.org>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrote:
>
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via inode_init_security hook using lsm_get_xattr_slot().
>
> lsm_get_xattr_slot() claims a slot by writing to xattr_count, which BPF
> programs cannot do: hook arguments are not directly writable from BPF.
> To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> value), and the verifier transparently rewrites each call into
> bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs and
> xattr_count are extracted from the hook context, which the verifier
> spills to the stack at program entry since R1 is clobbered during normal
> execution.
>
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant. We take advantage of this by
> passing the name directly. Because we rely on the hook-specific ctx
> layout, the kfunc is restricted to lsm/inode_init_security.
>
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---

The explanation and code make no sense to me. Why not pass xattrs and
xattr_count directly as arguments, even if you choose to restrict the
kfunc to a specific hook? Why does the verifier core need the hack to
spill the context and extract the two arguments?

pw-bot: cr

>  [...]
