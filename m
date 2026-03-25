Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C123F7870
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461075; cv=pass; b=RbZPfUw2+BRQU+fFWBO/5R7ogtLdOo0cs5QON9DTqoc/YffF0d6FpXR7N1Gky8isworHpws2mtGCyfJNCpE52FQJOQo66knY9bBoQeXht4+lf5ZHsC0iskF6gmgrjCvSXsqGs166UzlZhqHqmWp5tAI3tXkMFsCVif73qhcInrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461075; c=relaxed/simple;
	bh=LfOHx404KK+zENd5k0iKvf2df8c1QUv6Mhd4nnrA2k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBwaJLkNYHJV5YEuxevIJXaON4NaAibN8ReSTa8QYqP4PbtGrI+QyZM86x2ztryzd1n5RwI+8VJDXzIpCZDvTXM3wM+BbWtFiQ3WX2LGOXcIUF2JCq5CjCx1gCHJ1kqcNRk+SHDueAQz8ED342ej2mthZLQ2puxR5UysrJ70I7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dfl+pF2P; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfl+pF2P"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6628cc1bd69so1099a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 10:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774461073; cv=none;
        d=google.com; s=arc-20240605;
        b=Q3eAWfPnEev7wyMV6d376foaptKSsBtZleLzOu+ENReKHgCDBnWKLgNqPy3pzfghI5
         UX6dS2AT4yMUBm04DN0yxNxCCEhmK0t32FyHqDF9T72kVrApLdXtEX4PLiaSF8KGw6Nq
         LSaBhhKCwBtc9AKtW6fwCelerZ7ALEXUc8JRzGKWcvEJdZ5O2MN87aUcWYok3N6REAhv
         kz2sWqU7Bs9MHZvqoP+Mimp1SsHOI8pnS1i0ll392bxnQoyHxsV2okV5EQde3tpLfsUd
         esuElg9abRKywfXrqfW4MPUiCFbgZZIzse6BzQ8KGbVyRZqIGPwxwuvClqzZNL+l2IoO
         L86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lcdS5CNtdEsSElOVQqwojbHt2Qxr4nffxvoalO1pdQk=;
        fh=6hM25cn8YRtC9FHLgYJO82KgGMsjlUWF6HPWHM20y+c=;
        b=Gn98/RnKeh6BIqkHZhQhoVPqhSBVP5Avfw6LXkvEocZGuRLTXAX8ytA69whcJr4Z+z
         rWGg0g6pSEncv+c6RryccwxeypgJF1aJOEsQSM3g+m/hVyZIS6wdosVEiu9HysN6p4GW
         KIiXrpaW2TIvqZEKQXVp3MEWK0QADcGIS1W16H6U3Q8hoP749glpEMVtzMRy5AJzM2Qe
         PlBVoBGhlCPEFhFrOnTStS9YdMVD3bL0AmsP3NxPtAfSAMwUvS1Jd8iP9C8CpzekRPlQ
         Fop5MOwgQ1KUVGPMOzFkTTaugR8KIFW5FVG71T0UZxUqEGQ4P6r8r1y7vnqbSNc5nzYq
         FlsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774461073; x=1775065873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcdS5CNtdEsSElOVQqwojbHt2Qxr4nffxvoalO1pdQk=;
        b=dfl+pF2PhlOSL6iG9cI/eNprk8ZTDAdh7yZPvVJoiii8dnxP4ffSAoPzCHcSK8l8xi
         g0SjFdBtNEhLpHKEoRwNjhffIvM9las8rkTkHvziL3Mxi5e1lewylzMVKDJptAQt9qKF
         yKSbWprn1zK4Ptp3sa6mcVOjhNuayGDqID88GN2qORDF6SlDDTCZlv83St0i0wMlOVtl
         4jd4feuZ0cdJBu2OlnDgnMkCKcM6u7ks/NDFcfkKmvuBTHbQs5uNFwbD5kNqiIHp9ZOR
         Xlv/jMtwtqM8d7p+tAHHgPxCuUIE1rkRhRt07M/Xbaxrew+Hveo7Vc9Is77855Lr6mhN
         JlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774461073; x=1775065873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lcdS5CNtdEsSElOVQqwojbHt2Qxr4nffxvoalO1pdQk=;
        b=UTEdNiWQ2HJqC6XZJdKLA1/7kIOyaTbNjZId3A7XDNMhQJVxNEqLVuV1DHuGm0UN2H
         CjcFu+jKUTI3LHPYQMgzqWObKeHhNoR7xcQKZzNNThSFXdX5VLSML6vlSLUv6NdOa3oY
         fXSiE9gA2KYpI/qboGOTePfMBpyDVTlRtE3pryURTjQntaEGSFIoB0ZOhAC4ojDuBM1S
         QV0s7/7wQZL28Amz/rD3RNSG/hi02VY0MEE3sJy8PwpujHb+EWleSEY/aqTywKDdoAOK
         8eGszL8Nbz5qjH+2O0L8Zjq3kvLvr2hqwknZi7J5npOz6kXJH5SOH8b0TQmzh7lfoNEc
         tn7g==
X-Forwarded-Encrypted: i=1; AJvYcCXZIDIC8apvOjVgI8ccHqWUkwDSk4LdLelmFSWlVdpfZAaZ5M95j0Juvtm2CDJcvCCzJsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsO4fY6ZE4Zk/f0kK23rDi7Fy8Zle6hi2isUeypphxdsm2p7O
	XKFV+oxdb6dJKgj8mG0NNjrxRbx51oKkLrkhmUUZqyaDup7bhbQouazuviVYyuLnE2xKf7Me3Fh
	PRHW944LOQVUwiueHVCreOtvZZPm3QieornuMKzBZ
X-Gm-Gg: ATEYQzw8A4italhqYI4a3sRzkOTHZXkq4pZyjkUi3kQDWMzSiSvUGWHI+qu3nxW4BdH
	PB+cp140uQZUSkj4SpPgb38tDnivSyHaD+weKbHhbu9ajpMlV/1ru0hsI5Kw+QKr5XMGGD/7XWJ
	GvQc7CYvlPep9P5lcSpF5cWFS3nJ6CB8XEeUWOvzJwHeok5yMjXRbTfmILW0Fl1lhrmR3LnmWyA
	nRSgBQabFZAed8JY0Nh35YgRJWmfoWxL307maoHzuBtNSFVapvSy+7CE4tBxixamnbrBwAbDtOr
	w2s//O8=
X-Received: by 2002:a05:6402:1451:b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-66ad9575059mr2781a12.7.1774461072029; Wed, 25 Mar 2026 10:51:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com> <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
In-Reply-To: <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 25 Mar 2026 10:50:58 -0700
X-Gm-Features: AQROBzDwHlJH5nkrozA8k_jCaaxMY2azgH1uzVE_N9olWzdVjI8yDoxoWPHYtxY
Message-ID: <CALMp9eTZRucL+CUSp1yUPG0aSTpyQ=po1EmurZhX9+R+vxgbPA@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:19=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> As a mitigation for BHI, clear_bhb_loop() executes branches that overwrit=
es
> the Branch History Buffer (BHB). On Alder Lake and newer parts this
> sequence is not sufficient because it doesn't clear enough entries. This
> was not an issue because these CPUs have a hardware control (BHI_DIS_S)
> that mitigates BHI in kernel.
>
> BHI variant of VMSCAPE requires isolating branch history between guests a=
nd
> userspace. Note that there is no equivalent hardware control for userspac=
e.
> To effectively isolate branch history on newer CPUs, clear_bhb_loop()
> should execute sufficient number of branches to clear a larger BHB.
>
> Dynamically set the loop count of clear_bhb_loop() such that it is
> effective on newer CPUs too. Use the hardware control enumeration
> X86_FEATURE_BHI_CTRL to select the appropriate loop count.
>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/entry/entry_64.S   | 21 ++++++++++++++++-----
>  arch/x86/net/bpf_jit_comp.c |  7 -------
>  2 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 3a180a36ca0e..8128e00ca73f 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1535,8 +1535,17 @@ SYM_CODE_END(rewind_stack_and_make_dead)
>  SYM_FUNC_START(clear_bhb_loop)
>         ANNOTATE_NOENDBR
>         push    %rbp
> +       /* BPF caller may require %rax to be preserved */
> +       push    %rax

Shouldn't the "push %rax" come after "mov %rsp, %rbp"?

>         mov     %rsp, %rbp
> -       movl    $5, %ecx
