Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B8224AFA
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775269278; cv=pass; b=YB6sI7CYBGapEeNvEhNzs26OGbHc5EhkQIe+YL0M7vtVkhdQYJvdLUX34qNSWX0K973YrS8EEJKPjf1OlZ0UNlQnf6xANyX6yX74qL/BotfwYjqo9UH2jHnLqhyW9XyGTa/CMGvSeAaO8XDUjasQkc0lTD3VgytxqkfzvTQ4VoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775269278; c=relaxed/simple;
	bh=QKK3vfyE3OByfcbnSQwgv55pP7KZYyyoT/ZClNEydVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISmBQfNNinRElbkC6qnVt8b8zSAFoz9LpZWkGEgWW1zhLi/mCJ9NnXOIqh/roceBEuA9rqClTx6esFKfibAwpihp3MsU0IgVQTCpID+lC9q3HtorGMhxUdK9P0LGuQENhQCIB3BGPPPHyS1BrrFE6juni5A5FWQP+SSoFfc+vu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mFZ5CNRz; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFZ5CNRz"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso12921a12.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 19:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775269275; cv=none;
        d=google.com; s=arc-20240605;
        b=AJoNhHLpxzxVPUbTec1bNcuTNtEN5IsGW0cRXzmE2gpvhFSH5oEEESd/ZG7AJZSMuM
         8VfjCK8LkzEBkM7qi+gJ5rbaZ7jXt8Aipy8meBZsn9xpqt+mgHyOmv11PVP/TNHdMI8m
         nrI5oH0ulAyW+YUylFac0DmqED7GcvMpVANKNnS7RpoxDjtrP+pFbnfdAgrrJvTuJbsN
         BDg/puQPsBnMZneQeJhtaVWWdELDpZN4PhPE5gT05zc9wkX6JTif90UR4wgrlvjnJUtV
         W+ZzhXprcIf6yXhAJfUdlmEaO8EoyiLISnSmvMV6qGng1nouon/Myg+CFdLzHPpV4C5R
         IiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BxC/1pvEk7t6X+wjHIJcWrBYzvtuyxfvAHewlXa9Reg=;
        fh=7ols3kJMBGeC8gUrHCl/YGe9VX1AbgZj2ek0v9e+y+w=;
        b=EizO6jT1H8ZMSAXDcfqi0kM0MtIpnC3o69NUG+Tj93/zz4tsE2qgIljDVgKC9MnLPS
         Yv11dO6s+OWLwG5VsrLw/vrdeuhhjt2TXjUQJPNaDDaGxHb2VOdCeoAt17mTGIzz/V1w
         W270aEo2fGJk8S0pKaHdfK/ZijGP7C6K1j/1P5Eb7QXp/1qFAw0CL8n8NM/8dya5lnPa
         QUR3tLglWD+Y14iISUEmcsIzm3HaLfGEFZLjlpFPI30KsYyCAS5oOHOuHPIc3oa1yPrT
         4ZpiIBypFDFL6kyDaJrUA2XWA2Qy4Yw/G7JusYr+q4iUMXGoYDW2WCXA/Arv6khixSGk
         fnaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775269275; x=1775874075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxC/1pvEk7t6X+wjHIJcWrBYzvtuyxfvAHewlXa9Reg=;
        b=mFZ5CNRzhSAbWxV9qEwfLjfxOOP7DEerPOJ44lwZkjp5L0uoXrsRQWWpXvSSDN4Cwo
         k3qLye3m7czPV1KRG1YwJLNmVknn90IHrEFd+SEYT83REKPPEDEF27RQJWOaYm8vr5Mc
         ARt2SMt9qNbsDFnF1i/h13uotWnRYenua3pnrUqy5O1F/7zThm1qfGM5Fc55s75pWyY0
         q4FZWGS8Xs928aEmrZOHOfrCI6S7QgmhPn0SlpxVv8Cq7JNHWWU4jT8KhFsVsqaifCqU
         8LTPEk17nAIKfFlYGH/o2e/+7vrvBzxwJc9f4mXHfqtkt9b3pw64CSnJbIhLfgpHkhBS
         4zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775269275; x=1775874075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxC/1pvEk7t6X+wjHIJcWrBYzvtuyxfvAHewlXa9Reg=;
        b=di5yhsfrQpQ5K9JRoaal3xce5XHSHXBpU7ZrhbGdRWTTTMf+Hvegd/oyBME1IBoKtu
         jEYfibhp+Dj95OhjSuTkpQ+dcbzcuHIbQX86MY6WzmwhVwIRD5n0Dc/wgA1F4++hZ8xw
         Sm4t2lEsyVXXAhEhxJwU8zy93U7wwa3J9/FQ4RmLu73JecFvS58z0ysZ568NJBvS4K1z
         p2nBC/uTdo22fb+2fxMp1PmN5zwZRId0nJ7qZy8dlU9kHXjwCiXszEAPwwEGquyvASg2
         dl11j8WPpS2onyMf55w4jADt6YN0DxFohH1ySyuTfxHPzcQeTx7TMRlDcJMusHp0QYGK
         3Weg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Vh1fDCNGVW7j/YEVBESBbIVu6xVRzsHUDz34Ad9dFt4+dQke3pJQgSp1DdO4Xrj8R9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzutFSMIIEkQXXbLwcqjaYOrZ0mRx6RGt/j6nEAucz+GaCl62J
	4cpnvogJzZVCM3niSnXhf0fqGVHeyHWnnNea26fXIcib0+x86/queHTslQmT6Y1kpBZMbcaBWLT
	NFL/LFnk82h0TJdi8UTyuzXj0wfjzsmr/mt6e9zmE
X-Gm-Gg: AeBDieuy4rhQDKSX1MirM1GMx3NooaET7l1OIVuT0nYiHPzHy+R03aoZv5/gsFdlXNv
	3ucm7GNvnslkw7gcUjRcO7mDD0Az6EznrsKbisap5FVL0LWSYSxKlBNCC/64f3wmGja/kNUCG4w
	1Bh/C7ynhaeb8ahqE8f1Gq+6swROjVYAJ/evmsezmh1sUTOmhOBzN2Q9egRvr9cwP0IMQXQZAWD
	XI5GatuI1iScGt6yLH1gBfuYjI+sLdQbbiTAXhIZvLrI2lxZRbePTghxrJQl+dzpXsJczAd/WxI
	kG+IVkknD9ANlYd9nQ==
X-Received: by 2002:a05:6402:1804:b0:66b:ed69:a85c with SMTP id
 4fb4d7f45d1cf-66e43f22b75mr45332a12.7.1775269275001; Fri, 03 Apr 2026
 19:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-vmscape-bhb-v9-2-94d16bc29774@linux.intel.com>
 <CALMp9eSLVvr00mJ0J2f2_SPeCW-VS58kxMcxHgUW6etML+_+QA@mail.gmail.com>
 <20260403185236.sjgetnkha3o3a4d3@desk> <CALMp9eSPkMpKQELTnsaj6=gXD+EyE0n2_p93n4maDc93bPFe+w@mail.gmail.com>
 <20260403213445.xzb4rxbfbg5un7li@desk> <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk>
In-Reply-To: <20260404002149.wtayv6a64vzuppgp@desk>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 3 Apr 2026 19:21:02 -0700
X-Gm-Features: AQROBzBosyujpEg2ULZMen-BYMNgkEIJxtpk1WSLwb-MqoCqV3Cx2KzliC39bhw
Message-ID: <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
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
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 5:22=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Fri, Apr 03, 2026 at 04:39:54PM -0700, Jim Mattson wrote:
> > > Since cloud providers have greater control over userspace, the decisi=
on to
> > > use BHI_DIS_S or not can be left to them. KVM would simply follow wha=
t it
> > > is asked to do by the userspace.
> >
> > I feel like we've gone over this before, but if userspace tells KVM
> > not to enable BHI_DIS_S, how do we inform Windows that it needs to do
> > the longer clearing sequence, despite the fact that the virtual CPU is
> > masquerading as Ice Lake?
>
> IMO, if an OS is allergic to a hardware mitigation, and is also aware tha=
t
> it is virtualized, it should default to a sw mitigation that works everyw=
here.

Agreed. So, without any information to the contrary, VMs should assume
the long BHB clearing sequence is required.

Returning to my earlier comment, the test should be:

+       if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL) ||
cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
+               bhb_seq_outer_loop =3D 12;
+               bhb_seq_inner_loop =3D 7;
+       }
