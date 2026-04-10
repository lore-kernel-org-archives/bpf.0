Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673C3DD504
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857380; cv=none; b=sljqFpZLuA9qaqdNHNvAsgZfNFvgjk6M6uHcpjPknnnU0DfY5JX2QzbAaCa68FiKMfRSxmO44yAiUZye0Df6r+J9Rv25vDNk0DepDkaa8KuB7nCoZEd6CpQ0IdUlA4EDJaYBzXDt9/vGENl8gX0tSq+raGtSrz/TMaBBpCWaouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857380; c=relaxed/simple;
	bh=HeyaM3mTAFyS+c0s/5ObZzTxh2LHrZ/Wz6Lek0n6tD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AelEh8KOAYO6kXErREnMjL72mcbFQ4V7uUPrhuQqMuKqkL7s4gum4NRq6stLorF3LRXYrI1ie7J+ExilJ1clnGCthA+ea+TMiB9F6e9sxptA44ECOyQekjPMOo7R+xb4M7bLxLibTKIL2BN+Hx8GPe+hK3y1y3cUn3zYi73p3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIsmp9eK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIsmp9eK"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f0fc82c76so452025b3a.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775857377; x=1776462177; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HeyaM3mTAFyS+c0s/5ObZzTxh2LHrZ/Wz6Lek0n6tD4=;
        b=ZIsmp9eKevpino0eYjhRM3dW8HMV3xV81+IE3r/suojFSz+3HMW78OuhGymTDNNiEM
         TniozEm38CyeZId1DcqNK7mAy9QW7Jm7PjV3mOuj3kt7rlQF9MBQEOzl6gOHfV6XOa8j
         k02umLFK5pYGSh88PWK3Em1BaL1f2M/PrDOpfnEVunqUL73jP2h77o8khbw5S7Oh07kB
         li7RBqBpHCZo33thJi/fPaNaO7oWLctonHYbFXfPI1WUMhRbft9Y0ZcYH7XCAKb8sk7B
         sFSyJzBgoFiURzKhfsJ5Rml+Pzvnn7mpUi7sRftgZFFC17Z3EZ4omwsPVdO8AcMqMCwX
         Qzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775857377; x=1776462177;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HeyaM3mTAFyS+c0s/5ObZzTxh2LHrZ/Wz6Lek0n6tD4=;
        b=O3RnD880u4FSls0pYWYLO06LXMKdcMeo3rR36lMj+xXW8rLtssxJhDOeQnV0QkNPcS
         8nC3CpiM9DdxIGhqU8sPlVieXuhpuJX/xJU4SBEKNr9qAXekh+ElIJUDAvuYduIHglLl
         E1wpRE3iKQWvGX+ZriVXWwsuVf0DAaM1wmBGZ2XHAxwFJTda0qjHSQD2/pHIrnnFRRU9
         IbJkQvDOnrI+vIIAfZ7+Qy3cQKLxK4TXLpH2V/OrgG6heugvlA3TEf3Zo3mwPnxNWGDM
         Ewz4odw1IirFuOqMYQFPc2do+ovvBx2xJ2jDa0+XLCk8BzUkRTEXoUei60WlgAUHRqaR
         UVow==
X-Gm-Message-State: AOJu0YxnScHAPuxmHDZ57/o18DcBUm7ruc6uT/I+Ry0emdgeN7VOhfDp
	2Q6VUb6mJg6oql7OoHpxvcgNFwW6xpP+dOBeVEeQ7IWOLv7ZeKpf4NLH
X-Gm-Gg: AeBDievL8q1Cr8kFWMVEfcg8d/bO4bXEJCJtmk/VgNdFVsqzGlNYCY7UGfcHsbJxNLt
	TrfDkUIdOWmOy0DJXFoqt1ADwC10B5Ocvx7eNRiqRaO+CQKLpGeEjPtlUrUKdLiXP1iYPJpqN7t
	3aiO5kylkY+raCOa9MX6Fi+KdhvgEb8j4O+Vo40+QI7vb6JyijYEX4ZGc+UWa0VGR+1QH/DHKw3
	GTeziEFcNXdVZSViAN6ec2NHLzAAQ9xmDAtcnY0s2V+aD+exmHZQSDVmiO0Jf5haI1KL+wXNium
	wzw6f8MYdgBDezfwslpRzg99pP92XGNb3vuiOljNkYxiu3JVcy2sWqhv0qpohvJEuscXrbVuF9X
	WLivpxcUuAYjfBPkIA4JqGISCq2ayUdF6VF9allgm323YRdeo5QhjUT2wsyFEo2AvndMgACBwNR
	L+ZlQJbttsX2PLIag9Rx10uwgU4hZT0wAwhF7jSnWN73HyDIwrvgV0yIav4BzPVq0=
X-Received: by 2002:a05:6a00:4fcf:b0:827:441a:c970 with SMTP id d2e1a72fcca58-82f0c12f194mr5109882b3a.6.1775857377061;
        Fri, 10 Apr 2026 14:42:57 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4dd37asm3889878b3a.42.2026.04.10.14.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:42:56 -0700 (PDT)
Message-ID: <fb4290b261d2265e9cf64cd6f67df9d0e1a1ac74.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 09/14] bpf: simplify liveness to use
 (callsite, depth) keyed func_instances
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Apr 2026 14:42:53 -0700
In-Reply-To: <adlt_kFLi-rA_zTR@Tunnel>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
	 <20260410-patch-set-v4-9-5d4eecb343db@gmail.com> <adlt_kFLi-rA_zTR@Tunnel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-10 at 23:39 +0200, Paul Chaignon wrote:

[...]

> I tested this series with Cilium's complexity test suite [1]. We have a
> lot of different configuration and some producing larger programs than
> covered in the cover letter.
>=20
> Overall, the impact is quite good. It reduces the number of processed
> instructions by more than 60k instructions for some of our largest
> programs. It also increases the number of processed instructions by up
> to 20k in fewer other cases, but I think it's manageable because they
> are not the largest programs so we have some room. The mean diff over
> all programs is a reduction of a few thousands processed instructions.

Hi Paul,

Thank you for testing this series!
Are the regressing program open-source?
If so, could you please point to a few?

[...]
