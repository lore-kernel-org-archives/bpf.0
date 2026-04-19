Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9725030BF67
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776639103; cv=pass; b=OAicHK5zEuKKZIxbFeOHEXJNQKcRMSZjpRdlsuAvnd2rC1jqDItoOXRFUU3bHE+5oXQh7q/rU7h3+BskU5fJvugBL063OvxuaEIhGGuQZTFKQYz9c/tsTz+z+J3rsBLeuE+rSdw9CZo4N0dfWi0sHQx9PlQ6tzIR+m7SjLMdIHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776639103; c=relaxed/simple;
	bh=nGI8q1vIW2YCqL8DB2swQpMBunXNj9M7QpTu5vxe99c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9GcjMkzimXN1QLy38o41hxeHCgt9j7SQJs36p4zBJfikojPhP1TTIxerqu0jg8R9bG1UPfv4L8vNhytgalgswbnCAaSBtsYQkZPPrIGe/fTXi2vTUzCVHNrBOFTq4KsFhgh9ppkcpgeEjwmjwt5jmueg+uvTS0HC2ksD9jIJ3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIVyWv+N; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIVyWv+N"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfbd17589so1754347f8f.0
        for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 15:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776639100; cv=none;
        d=google.com; s=arc-20240605;
        b=Ac3tUAOZrMEsbjRwTXedAqMjl32ZOhtcme2qTVxb8BsXqjjNwJEXL9ih2mAknaGXqp
         DMK8H9NHKOgQGj4PVwiLWBmtnVPMaUOler9Nk4F0TVa+GtLaJlkGtJ58E5qtfOXyTnkN
         SNOkyzU3cckbOR92pGy1zRbZfAmVNNCTbkgJ+z7HfSSxyb2Yu/Am1OrHwm5WDUeVxs1w
         nioUgHoKE6F+rduyoIrQq89262HSrlAiY9XgSEuC7gF3yexw+edNCUVzQNNhM8ieRyFd
         WqSOcw1D85XbvLPOaSZ23L9imIHXEJLF5uiRv1F5Tdb82YYWmsx4JZOo5jCJJAQJZ+kV
         I9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nGI8q1vIW2YCqL8DB2swQpMBunXNj9M7QpTu5vxe99c=;
        fh=1h85ZoyzfYBWqDarArU7/pG2qXnocBpgVcQ06xjQ3/s=;
        b=hEt6/fJGzyHyFoYusM8e3XmyZX2uzlFehO4Ja6fqieErS/cFlO46MUS6WEq/fyYOcN
         50jRUOeTvSr/JSRmB/g8LUJwNg9wLniYMqVThRzsh5xXzYe/p0LeZJgcmn8EAeR7EgR5
         gmLJWgwqZKBUa5COw2oBSk3AXZpmFlib8jHIbzyiBbcn2BiF1G+BZ9YhuStmrXCBm11z
         GYi8FXJa9dvs11beKvxWW/DbjXrm4nBERnKRhY81E7NWtI9YTEZg1u64iqK+Ga4TsGGz
         spOVTmbiPTqdGpFQZu7gqDgUVvprWT0w8nE+8DTyZlRCihavdAg/jdSaqvS2MCv7nN6k
         k9/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776639100; x=1777243900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGI8q1vIW2YCqL8DB2swQpMBunXNj9M7QpTu5vxe99c=;
        b=PIVyWv+NVODk1fM6YRVoPCmpL9zUGbaduJRw4E4FoAIegZ+uqMEy9ajZ7vRe5i/8N+
         RT36e8bOpdX9w73YACH/l0FcEzpiJaZbl7xGoROLu5Q/LnEJ8rZ3Mt8JKc5Pajbb+qnF
         pHHG8o8xDfgi4ZgoAibFk2eVuMZf9wCPxXFBXKcgJsGLpAtCQg9jpRnSv7l0KGYzx9gc
         mw0kJUbWR4s0+qaiBqMamkwWwAQrjkcbjRoQPeeYL9jTYaeelFQDGyXHhEijC3J2I8Cf
         hwxUMXRFR1zLB6O0gi72EtXG75ami26eD2t1jPZW5QUxbx+Q8nPooW8yXDDOzwVJ67vH
         kxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776639100; x=1777243900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGI8q1vIW2YCqL8DB2swQpMBunXNj9M7QpTu5vxe99c=;
        b=UB34m5uJypQae/ZTVh0Ihc2qVoGTvlcTTgmuYx2hAxf/+lWvY1Lrp6qRjD+WndRAVt
         iEseB914dtb238cHbgpK35/jEnif8dJAEG6BlQpkE4Tsb4R6UN6AD7YZzmY1xG1KLHkI
         Rkm8Jej59XmzxZ5Ja2Uey9kcAIUw8pgi6knYObLjkDzulh1lkyM24wchyFTzUvsemsbu
         tG523PVCakMxfdqRcyi3jBcr5AoiWR0sTeTzrQGhVEFlFwsoKZ2i6+stVApWO8ULDohW
         xuxSRZVefDdydamlqnR4Z8AW8EDMz7ou6Wc3VO13tyqlFikluYCc3eyw7D2ShTN1g3Wk
         KWrA==
X-Forwarded-Encrypted: i=1; AFNElJ+wdlkzEgadKcYLKvQ2Goe2IKmGaHdX5owsOmu7MeeEj/1t8aUXG1NX4a8FjgyHqyS1KPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIk8T0Zb5vx87UkoTJSBM+YW+TIDZ4yaKhX2PvncBdSOyW0wZP
	1ex+7X4BzlH431eWHxEOBcqmDAqOqjt+TQaK+2fVppVxMB2kTmjAjQjhe/zsFYH+qD0Fgtk6sUU
	cI5Qv/GwrxzwV13cRjXeIK8TVbCY58I4=
X-Gm-Gg: AeBDievpg6u2I936dg4K2L6X/M9EdzOb/arNtEaOrcjR+/7N4wIzFYaUHrpagR7HyiS
	e+c/Ab4CVX34UPxG7Y+T1ZXGCGdLyqKf4fN0qnIlW3I442FI+hhubpnxqwLZ1oI/51SGQUn3R3z
	miv5mQpAAUCe6QUKANSyvyHsFNK+nM2Aje5oYNMf/bWICwTgAVQ4vU+Tuw1yipyvcC3nmNQnKkS
	65FtUuu3FfmWU/01ey7VqbB0plvMtEv/OR4We0m/PcKaGzk72Dp3KO8XHoJJbsWxdmkzvx7+2vp
	Z9ZTcfjh/QCpEnZMy1ojzTcgm3D6CCSWHFWSgiHU3sZi4+ztOCE8yjPo24057VE28fCY0mRFWCm
	5JD0+4auh3NUqH4AdvKFMCcrW82gRCmevNdq2
X-Received: by 2002:a05:6000:22ca:b0:43d:7883:87ce with SMTP id
 ffacd0b85a97d-43fe3dfd265mr15420059f8f.34.1776639099627; Sun, 19 Apr 2026
 15:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com> <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
 <CA+fCnZd31GzdpEqR8VhfK4JtUKyyRMgbBoAbeGACJgm7WvB6Vw@mail.gmail.com>
 <CAADnVQKv5y+gq=TnOAEXSqgBRpmHNjwqCfxpLaw5XkcbQ+23bg@mail.gmail.com> <CA+fCnZe-b0Qqbo5gGv3HN20twquQETDfYYkE1r9tPr9zUFbW9Q@mail.gmail.com>
In-Reply-To: <CA+fCnZe-b0Qqbo5gGv3HN20twquQETDfYYkE1r9tPr9zUFbW9Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 19 Apr 2026 15:51:28 -0700
X-Gm-Features: AQROBzDew-foTfJLq_z3E45rMJ3PdE7WT5G5Kb1cNLd7o7s_NLhMVNDGxKf8D94
Message-ID: <CAADnVQKuptG_opA12O=Xb9_+cHf3f=ycAZdfUp17P2HBYQzdsg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 2:49=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Tue, Apr 14, 2026 at 5:58=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > I think we're talking past each other.
> > We're not interested in KASAN_SW_TAGS or KASAN_HW_TAGS.
> > We're not going to modify arm64 JIT at all.
> >
> > This is purely KASAN_GENRIC and only on x86-64.
> > JIT will emit exactly what compilers emit for generic
> > which is __asan_load/store. This is as stable ABI as it can get
> > and we don't want to deviate from it.
>
> OK, I supposed that's fair. You did throw me off point with your
> performance comment. But if you decide to add SW_TAGS support at some
> point, I think this discussion needs to be revisited.
>
> But please add a comment saying that those functions are only exposed
> for BPF JIT and they are not supposed to be used by other parts of the
> kernel. And in case you do end up adding a new config option, guard
> the public declarations by a corresponding ifdef.

I feel concerns of misuse are overblown.
Being in include/linux/kasan.h doesn't make them free-for-all
all of a sudden, but if you prefer we can just copy paste:
+void __asan_load1(void *p);
+void __asan_store1(void *p);
into bpf_jit_comp.c

> > The goal here is to find bugs in the verifier.
> > If something got past it, that shouldn't have,
> > kasan generic on x86-64 is enough.
>
> FWIW, I suspect HW_TAGS KASAN already just works with JITed BPF code.

Ohh. Good point. Looks like modern arm64 cpus in public clouds
don't have that enabled, so one would need pixel phone to
catch verifier bugs via hw_tags.
So we still need this x86-specific jit kasan.
I guess eventually it can be removed when hw_tags support is widespread.
