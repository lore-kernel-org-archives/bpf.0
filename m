Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918443E9C9
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979416; cv=none; b=f1CFblp4/rKuQBdMCDlxaD1Al34MYDFXMon2tltAVYu29k+0jnM2s6DeKqJTxJw/dCYDLRVHC3aRwidzcpvsjH6M2igUC84u2oM4BNFtcT5NgNrv417sEV0yf9BGFyHbMrRRN7ca6breSdKXtjcHyoXUJG6O9+4LkVy6Z9LrfJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979416; c=relaxed/simple;
	bh=VgUis9s6Qpjfluu+1DI7P/hWgNf6BSkMHZzWmBjouEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W/Dv+1CzDska99u3169T0abodUtjw/sAC4hHUOB6N3eWeCo4lxBHKn3ZtADNVTsjhS58VJsEmjeF9Hqa5BI1OQ1XGwyBeSWGgpezi0K6OnJccYKPRdeFQwNd3rxGSMgaKIqhd7mDEPu04VakiUr7eQpyLWDJwFqo90bi1PkrQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tUS2xhE4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUS2xhE4"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a88a2704fso60150b3a.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774979415; x=1775584215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBeMy8Rw/5TjXCLG+UKpazz3KysoPcTZt6O2J4Vg6kM=;
        b=tUS2xhE4G6sHOzS3dSEfRi88IwOQzU558/DD3p2JsuYOjcd776/U9PVI25VTBC4fo3
         kLiQ22ChBW3e3TMBI8j9/qoouqK5aPXkruqVz+OjvTT7MpLLSAwYLuQ2Qju+YGK5l8+5
         67WAJmGNsmcCeG6TeXyk+z/kS/9Wl7LB1cPH1MeaOROML/9ZlQ8PnfuDY1b1tV1sMgrM
         Low6kvgAPWNsKauJM7qqC47LD48YtE/lJ//V5RNoPhnU7ck3eecr7S0+EkCFo1NXu3oZ
         SqzjkM7hirh1nl9SG5CzmtGdAHOKkqSwZgQxiiklw7hgt3emG17C+Yj8JXb1GfLWs9fl
         d/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979415; x=1775584215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBeMy8Rw/5TjXCLG+UKpazz3KysoPcTZt6O2J4Vg6kM=;
        b=gXHtuRV9DTdJP91IGxcLBF8sAKUup6l2kohdsuwhYTt30KwTH6555li02Fek9+3EIV
         FginUFIiRdtjIKLzuOoT8xClbbcjvRS49M40Jx4ltIWlt+E7ZwKsjySFX1X/fKzAEfwp
         5MhM2QnwhsAvzMkIH/PKntMXiXqs5fEOj68Id1jhtisiR6AW3Ty7hoGHK6BYFEgqlpw8
         qTp5QADsE8+WOBjaJmmVqEYB+yL2dtUJTRh31g85B373hja1j1WRyyQ7U2qqXJq/Cgce
         bDEX9hjarVZjTSxfqhUlBwZ8buMtbyjcASNOdjWriIn23eRYl7wJ7yEXNoHi9x/kd1Wd
         +4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCV/JeH246P2Z3+9BXR2q7cNUJQd/SSh0AECRiowqptvoPGd3/WlwA2aRqlW0M/DOBwpbK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDzmn9lBmoE4G/DH0FI1gOaS9aiRyW9xoh7P0GAEv2tJszbuNx
	A8W5W8P9QYNEJR7/uRs79HA24CjN2/FLS2NMsdUC7k2+yrJ7YCz5pfxJyIXa1han4UxoJXmpAta
	YdSj6BA==
X-Received: from pfbg26.prod.google.com ([2002:a05:6a00:ae1a:b0:829:7b74:e1a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e97:b0:829:7a62:6a
 with SMTP id d2e1a72fcca58-82ceaadcfc0mr197450b3a.22.1774979414552; Tue, 31
 Mar 2026 10:50:14 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:50:13 -0700
In-Reply-To: <20260324-vmscape-bhb-v8-4-68bb524b3ab9@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com> <20260324-vmscape-bhb-v8-4-68bb524b3ab9@linux.intel.com>
Message-ID: <acwJVUeW9KoLft4d@google.com>
Subject: Re: [PATCH v8 04/10] x86/vmscape: Rename x86_ibpb_exit_to_user to x86_predictor_flush_exit_to_user
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	David Laight <david.laight.linux@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 24, 2026, Pawan Gupta wrote:
> With the upcoming changes x86_ibpb_exit_to_user will also be used when BHB
> clearing sequence is used. Rename it cover both the cases.
> 
> No functional change.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
