Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2774BD346
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582965; cv=none; b=tJicEIvKXmL5azHaVs0erOLFqG5CBGEyDNNLFEQP20Hcce4R9R/P//Lm80o4BU5ZnPwGYWqrYj7N8G3aNIvDW9bjp0efLvPvaFQaeCnxkO1MYeqTOYmwqiL+E4GRcwIFRZSn1mDprb/4L1n9eXWRh3LdE++N7wHtI3YT04cxXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582965; c=relaxed/simple;
	bh=ioQuxj1ib8blpos2M1AjclaxSh8ESwBZNT82NmHNObs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o21gLOlD3SYCF8CzKTTs7MCaT8v1N7fCv919yTzZSVpCGa7F68dG6L8VjNMsaDwokyEtSiSZVB47Dv8TcSfTls3NFgcLmNkg2HfcIRvyU+dRgdiTFarQsvQjj6K/XkgzTG9ekctskoWmaC+WH8cwmPI4OvWB14vbiOlY9qGDyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ2X7lEj; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ2X7lEj"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4adso1065222a12.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789582953; x=1790187753; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ioQuxj1ib8blpos2M1AjclaxSh8ESwBZNT82NmHNObs=;
        b=QJ2X7lEj8+32+QyItAnuELo6qhtt8Qs3WfeXAE/sSWx5+rnnw2NzDiXLN3prxawwa1
         c01cUrLb5mx2Q9EXErm16bvP5KxclBTDdaOIT1WDqaCtKt5Gx7MYZ10ngFYEFr19svjk
         MhSnfw85o8M7TQH5uP1HKXosHz8ILqLBO8f7FqXAgIHvrjusb5bn8F58oqTbVQRgEHJ/
         wF8La5unH0Vdbt2QgE+6FfOv/uDCLYEfuNf3lew9AMbi93tV0RSjBzm4IbmdfQXV3omh
         XCB7JMJMjfkwSZQRJj4liMWKslQHZWrpXNfjNH7ZrKKWBbV49luFhrNrro64ClIglauc
         xzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789582953; x=1790187753;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ioQuxj1ib8blpos2M1AjclaxSh8ESwBZNT82NmHNObs=;
        b=j1LCerP4Np2REze39ALKQQOr8H5VeRZMhfGPydPRC5u5kGM2pF9k2Rx3cTgVdKFLa4
         TXxickRnNpaYP/w5JbRZOnR5SOAQGKOZN77+UW8Dcu6FckgMfqskFZvWlhtDXbwCarmc
         ar3a6LdPUiRYmYPNLPdhPnNVtppSJTuDd2O+I7GTT0mANqPCobHZUcNJq4fhopTyVRzx
         u2AlNZ+EWz5yU546hdHl8fx9cgPli2qaOiyQhTypwlP8JD5KRJPLpDtZCXA4mBnwcT1E
         IUEJrSszgZa4jXZV0OfQrkVVUwI9uQOyukMStcmKAzaLbb4J8Z4zo+LTy74TVdS+IMst
         yzCw==
X-Forwarded-Encrypted: i=1; AKwUvBxwiB4P2Sl+gHqINgKXP0LUD2iRGQW96rXWWatES56XIbzE7r8YRXeNjXnAJCkOko+Y5R0=@vger.kernel.org
X-Gm-Message-State: AFuF++kr+3dR8XtIiUUcdW3Ap9ai7Orlsh4Di0Jhhb35r59ZmScG9Cs2
	eFPsYDK2Y3H7omn8jcZzCclWvJFC7zwDJAurcyIvTbzhu/p+CaasRdcrWCvF0TmY
X-Gm-Gg: AYBFou0ylScrtkRbE064Y9iKNDXlK+C7FGhrOSx80ojq+LDYCrvwbn5mh0oig4eaKqz
	4blbMxCqzpH2nDCBMA1d6Jccs3awn4cO5LTKe/3BufoqMPNtvGH/07L8RFu9SrzkYej6nVitLEg
	KRFwqylbelLDfXIAJOpKd/YMVPHNSOl9U3Qy/7UlmiI3PIDE0K8NkyH4yC1FLoCi499schwhcKk
	AXvvBaLW2ikFedF0tmdaRgKd3bfOMOSq086dYN7IKIncymFeRh3cLGenXxghFyqldGx3KVdxoPX
	gKpo5CIHecdsbNFCVDfQqyfpfzd8Q6S1EVLw2GNqfgfoXmJJh1ZwwTi4URTHIySl3QzuRFvVTCg
	ON27ek/Xaw1exN/DFXYmU0HgOSJxL9lHcR/pqOKhV9xbTmt7qdF4FFlcBJApO8x75LWZne8ylYj
	RqFFf6CRLemvt8HfpXn4IfmlIOFWfs3b1rD5Vy3vkEEfIoclU6Qg8Ymo7VcuR+pxF1YzoNmXEz0
	bjafD3LR/aMbjFKrisPtu7QiP5pCshqNtMmqg==
X-Received: by 2002:a17:90b:510a:b0:39e:423:bb8f with SMTP id 98e67ed59e1d1-39e1e24fa7amr10509214a91.1.1789582953074;
        Wed, 16 Sep 2026 11:22:33 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36096735sm713646a91.12.2026.09.16.11.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 11:22:32 -0700 (PDT)
Message-ID: <0605b7b2539b2530ebf10c36551c6e10d98d1924.camel@gmail.com>
Subject: Re: [PATCH bpf v4 04/11] bpf: Apply CO-RE relocations before
 subprogram validation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil Tsalapatis
 <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Wed, 16 Sep 2026 11:22:30 -0700
In-Reply-To: <20260914222514.1635018-5-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
	 <20260914222514.1635018-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 00:25 +0200, Kumar Kartikeya Dwivedi wrote:
> check_subprogs() verifies that each subprogram ends in an exit or an
> unconditional jump before in-kernel CO-RE relocations are applied. An
> unresolved relocation can then replace that terminal instruction with an
> invalid helper call. The resulting fall-through into another subprogram
> breaks the CFG invariant used by postorder and stack liveness analysis,
> which can write past their per-subprogram arrays.
>=20
> Apply CO-RE relocations immediately after preparing the program BTF, befo=
re
> subprogram discovery and validation. Keep func_info and line_info validat=
ion
> after subprogram discovery because those records depend on the complete
> subprogram layout.
>=20
> Include core_relo_cnt when deciding whether to prepare program BTF. A loa=
d
> that supplied only CO-RE relocation metadata previously skipped both BTF
> setup and relocation processing.
>=20
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
