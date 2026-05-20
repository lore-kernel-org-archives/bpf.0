Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E52348C70
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779251338; cv=pass; b=RU8Pfy846H4p7FbY6LEK2xTeYDdBBQ4/xPho9bC5uVly7eTjLB+kVooSoPVmwZJdWHPns6zUjJZlNV1lYzwve8Wyl/GvA0+ZHBFLxPGBdDTmm60M1qft2hhuRr1cfQsMJ6BTs/rkMxNVS+BW+bf+J7EqnlLFFAGTUAR2EznXQ8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779251338; c=relaxed/simple;
	bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUgNz1bxxADSK3TGc+zgK+Rq8IKC41ma+ho4iHqJytfm3zCe70KWUc31IORCB/rXrtVLX7EhXC2V5pXtbbs09wOVyv8Qb40GX85/mLVNl5XU8X92+gulwTFchgUrrL6dmFbvwlFDeaIfVhCWFy8jypV4hBJvS7LfKXzIrbn0vM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pf/xdFFt; arc=pass smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pf/xdFFt"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5a8ee4b703fso4265457e87.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 21:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779251335; cv=none;
        d=google.com; s=arc-20240605;
        b=EAXQRCWIHe4KkOgeVxMboi/0teYrpouUiwWm2xY++V9LrEY1bMb6ESE33vOdFjsl5C
         7QjIVeEBERc3uhmbiipI/0SZa5hnF+Tw5HfV6ZaxEAs88tp/p7io7taG96k+Z4TaZIIc
         Kg6YMos1XBYBCb0gbR5jY5VwvtDX94fEL/mG8R58LHmRMZNvacQVfMfHE1eBsubdCmJC
         x71a/LUXYvsRDT5J9plSyEKwnkl7j2pS4lJgd64w7/k8ZMx1Eh6C/2l7ccugyXMOXbrF
         6+VgfY4cC+KzBeMcXJud3mzG49Qq+RZjedmPuPCvPMThsgUE+dFl1SM4dF/KWWU0Aa8N
         +tvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
        fh=dn+7Hu5V9wbkYtxr9Zgwj0M9qeWVKXh233s+j7U9Wwc=;
        b=kXZnH++pqR9n8Jf79lzqLTfpgGIuvB2qXey6AvcriRTzxUq88TjeTtI8nIEAreLlo5
         bXOy/cWEZLgQ6+b9/0BQDs1tSHRwrhPgRuduY57+cL2Xtgy4X2HBkUXsxLj6zGJkGQ51
         NMyFp+nF37jCG13qvfSoLWLKgiN9D/TMxgcCFOTCKmsKixLgKMe0YdwARj9ZpEA+bB2s
         7aPzjqUZGiPPH9SoxskDWmZwJzRPsBmwfCc3N3odQHu93tT+U4sCuCi8IY4OfQR//xCN
         /ZkJUEZX3/N0AT7RYXoy9WXKI34qScebEbAiiTYckFNBqUzquDGrtH7pXNe+avRtrnhb
         GfWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779251335; x=1779856135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
        b=pf/xdFFt04fdFs1N64CxC0xgaN2rRfa5Xp1aYJ0hEr0FlVQTG4l5JqWGzdYZxJai5O
         Q/PjDVKIg2BSkneXzSmJSgIIqHTVYLZJYj/Cx27CnPMhQltpP94bGk6zFv4n0ln5Bouy
         WnerPoDC9NnQfRUyilijsVOURO4dzwFlAfxIiPYZn1EHa4uhjt0kH8tGAKD8098ByXM6
         xnmm2kNQ2bUL3sHFZXHKMezzgrg/jpNeKN3kBpzTKfr4dg/z50C+bEULRrmCGod7mxLV
         il37h52WNVMJlIrMyVfQjKz4m9LGjjL1OeLlO3884O0Yl/Rsk8a74pqQVzE1F77lzvYu
         H8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779251335; x=1779856135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
        b=dC1VlWke9hAd31smm60aLEONYumPqjnqXdRcADMAt8CAt+N/wO2ocm5hxLrFdD+mSc
         1QkGvT6D8CjxZBO0gv5qlaNGpNeGVJSEaQow+OqSmFUNlCM4qXZMuxejUibQ6KL1I/pK
         AasHMfWss7IqhGO64wXHPthpRf3/dr5pBSHzKlqjPaQO3d/BPOlFzzCbR2cnoTp+xzPS
         5LEk7wrDl6imqcy5rL0O8dc+KemhH9aSRpKMq67ezRCG3bLz5JD/9bh/AtKls7sFXuvq
         fPguVUe1C0JghycXoeGhJCM7sAAnZHRY2Q9OoburLknapvnVIMBpYGz6084k72DPX4JC
         aNVA==
X-Forwarded-Encrypted: i=1; AFNElJ+6MvHtZzYRTRTXdkwfanthOvbl15pLRQvi5urxM0QMLGcL+0FQ3ys3yWWSpJ9oU6QRtJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq6vKpchlu8HGTrbD6bLrc2BZqvkwp/ZWhq9TUFJTJa+pEcpGP
	36VsOewulhOq7710+/8l+89hYUF8C6iz52mi2xuYkpBhxmpcHas76YkR1ovpa2FbKHCPmJMVI2P
	gHGb6TEW3rVRtyuh1+c3A7m9z/MfQynM=
X-Gm-Gg: Acq92OGy+vrrVqRG2/ryHA2UyFEz7hppus4yvU8HNR4sBUZpUr9DEI7GEvvtu15ZdrY
	60ktBq0WPTXNoxaC80jGeHlKTtL5F3x5IZENqiHPW2S4i5z0g++3vNlGMyuVgSUO3v+nnJldcEQ
	1B0vFGa7QGvU8h5y2YJHHfxEKmzXNMnCsisw62/eK5gC/Rh95sjLDLSrkNq+xNwk4UeWeq+gGjS
	T4ue7MX80cGe6iLF4d618oT3/6h8usq9Nf/kuZRnznzpD+4C6e4e9/wjkmIsyNXV8DwqyYiWb6I
	vGdmqilamMbrl1puZCF6tp5gHv9FMg==
X-Received: by 2002:a05:6512:118a:b0:5a8:e32f:6edd with SMTP id
 2adb3069b0e04-5aa0e5baa13mr6949512e87.0.1779251335198; Tue, 19 May 2026
 21:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517121626.406516-1-rollkingzzc@gmail.com>
 <rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroopeohspfnyv@7ryrgezzs63q>
 <CAB7XQsGe8ZA_WRYcGgkOa--f+XdB6d98_g4VedbFPK01eH0rBw@mail.gmail.com> <rn5uidhakwmnjb4ngkyvzzjnwb573ie35xu34z4fbmlp7spd2o@hr4ifc4lqcj7>
In-Reply-To: <rn5uidhakwmnjb4ngkyvzzjnwb573ie35xu34z4fbmlp7spd2o@hr4ifc4lqcj7>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Wed, 20 May 2026 12:28:42 +0800
X-Gm-Features: AVHnY4KqC33UsVo9KfyspcxLS3cGw-I0fQb_5ohSI4s38uJsussh1K0hTuQ2Shc
Message-ID: <CAB7XQsEhgsgXTLvE=Dr92Ydex0e3jbZ1CeCs5NjWsJF6yBXn_w@mail.gmail.com>
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, 2045gemini@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Wed, May 20, 2026 at 03:29, John Fastabend wrote:

>
> Great. I think its fine to address the tools extra callouts in a follow
> on PR if you want. If it helps get this merged sooner lets do that. All
> the tooling keeps hitting this and we have lots of duplicate reports.

Thanks.

Since we have not worked with the BPF selftest infrastructure before, it
may take us some time to prepare a proper test. To avoid delaying the main
fix, we will first focus on addressing the main issues in v2 and try to
send v3 soon.

We will follow up separately with a patch series for the selftest and the
extra issues.

Thanks,
Zhang Cen
