Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50731314D0B
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900892; cv=pass; b=j47T2AmHkCY3aobA1/JAOjUVcA3AVME7kCr4OO4V1ArkXqczJHs8+uoSgvxRdSKnpuq0pXGzPGJgQlzz88Fbz/cK1IHQT5WBv3mKs4BtJljEpXtGeYQvrHuT/yWXqPonJ9Ne31+wNze3Ggx7rlAaZCDS0WYZDEIa8j39gtzyO3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900892; c=relaxed/simple;
	bh=ahj5e8v5Ei0e7fMom0NKavN5sfGycf2Srrr3iKT0Cc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eg3e+AuAK2WuDKDqAK73j3iFOvJ11PJuLEo950VcQIRMadD9YLFUViUW7rju1TeIlc48NBdh41PL8VLMMeBYicmFh36hVxbUuxqoG13GLmfKkQDqFgOsisWKlLCeZt0WBSe0vXlFfSdyBY9WQTN6np09AQUYRtyXCeN84ptvX0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW5aviW/; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW5aviW/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-485392de558so2994945e9.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 23:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773900888; cv=none;
        d=google.com; s=arc-20240605;
        b=QTbikgGL2hJAnnNh/18qF9HxpG6WqLgEOBpS71nJMnAQmmoPzK6kHY6JhklOhqUSpl
         OT2tPy33a2idqVaHjJbA+lnL0L2aTdwhxw/f6g5A5LiakVQjFpMBQs7e44S+MoYYrK9C
         RXZ4ZwM/MfWi1mgaDF64whyt5DXzjVD8XeQrMz3z7q5HXKhGf7DywkdEVY43RcHi1e6Z
         KixSyRQpOt9HrCPyGpIF+hR82Z/R4sSba0Uqo1govpBDKdpvELK6AkCQTu6Y9n5vKzoU
         9uLIfZfNsB6FiJBklY5yYvP2Xy9eYHhfdzmIeh/kOCDhsoyhOPsKAh30p2H1+yZqAxuw
         SJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LYmV+yVLZmo+hPcweb4z07eI5e4Eab7WRQcbmZBHF40=;
        fh=gj3rsj2IgUOWlfwuiueoFSRZ7gmHDF5Xswz8SkEpAag=;
        b=Ahj3CqXU9NbdkeWY4J3Q1KshzfWOb73GOGPNyn6uuKykvNx3KBQVkhQ+g6lXE8VBFF
         nL5ymZ0pxE28lr69RFSt0yzV4W4YxmaoBZMFr7rAgvrh+45eFUS0wjyJYiwnbG1OQpWH
         Fm3mkRtQN+ajdTrAJPOIflPRDqdLEiPe2tcco0lQzOlKpZ+E+gnT/Llu0tknTwjKX7/Z
         rzq643m/Gs2wb3zmMfnAtmA4y4ObKKAgWgTgYAzj6+RhyOE9sQ06VUaYqwjEPZ4XLOP8
         8MuuvCGe4Lr+XaN5Y0SGFcXFDuU9O2aEDzbNRswsvnKKEXwPrn0ifUc8vk9iMEW6H66j
         y++w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773900888; x=1774505688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYmV+yVLZmo+hPcweb4z07eI5e4Eab7WRQcbmZBHF40=;
        b=kW5aviW/rZaCpdigsX9LlfgsSZV1fPuaKKfTwEO9aaw/d99RSW39+HaS9I2Yfo4y1y
         7JlYaVMo560R/ReN8m2BDG2xkAE8wKBHVh9IKLB2dDGGdtXSoXEB61PeeKm2SYQM0+qP
         qI50irdATv2W++pIPSNkMlN0SO6W5jw0fOKUQmZtpC1YTcJ7lQRp+nkygCH6T8pRH2Qo
         9SLCER9z49p5Bgr960WOWB/zGdb8y6sRTdKgM1N8A/3wr12aF3EBPI4CiLxrlYjtHkqH
         bJCibAgUDWsHolW2YV0w3pOkLwcolFK4K8R+k9diowkvpAvY1s4sqjIkxeuPeaDisrTz
         PCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773900888; x=1774505688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYmV+yVLZmo+hPcweb4z07eI5e4Eab7WRQcbmZBHF40=;
        b=S8wO4gzES9OTpeffg+PwXtD20+LXyHLMFK3eLyk04tsfI2w8yIX9HtFKRCtVtpdF1C
         pFTqIhWHNdRjutRPXR9I28DSl6cXp9lz+Bv4OFVxIKTns7Sxk/C3GBvifWRhtlSEz7PA
         XknObb61UnkUI7ZDEUQ8WjJs3MBlysM73vpuuVmvabNxzD7TS7tdh1zZXzKIlqN2MF7E
         u9PvHAq8E6o61XsaEBN5wR7z7MWWVMV3Nw5QyOvbXE/IGRCtRjjHwA9VW4h8NYWJzo9I
         2bOodTZ8o5STnj53yXw1Hne2InOxZ+EP6lzc1+d35dtUzeDy8Zno367V/UPEjVDxWbHs
         blBA==
X-Forwarded-Encrypted: i=1; AJvYcCWc/nvRKIU+gf4IVa9kpd34MkOt0n9ZJvGmPoqBWgVUYeiEwgx77++fXT7+pwY3M3+rENs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGn3AoB84emKe775lS8CNQhlFKmCMPkPApnkxVBVMPNxYjf2i
	w2dmw5oMJdgk3qttNXCOnCBTEHd/bu6eUREFDr3JtxuG9GaLxMdzV3/K61IHdKcDsf+s5rfiD+v
	DpnMyvkUVjru/JN12tv76jm8RLnHerIo=
X-Gm-Gg: ATEYQzxstlGhlSocvHht/MolHg3YjXv70P4zzO2/8ZDhrAzuloyBdgxG/FBr3Gc6crh
	YF3vUdeLgPRqgRvDXJTy/BCpyXQCz4ueWrpZiKWYwtzmuc6KBbcQQW43dndboNL/c6aMuGZP55O
	yZcOiKXtlWyRqihAhP65XmkzfqOA7+tp5OZn1mQARsJYPdAAO6AQFKCB42lARCOG2zMQE4pv4tv
	vkhGq3WVSTMEULMq+mP4/S2Nl1fbhBZZwP5R0PH08pAR8BNMdxZlsF7FrvEvmzT0iEghMEmKeCd
	HHK2sJC0aDi4ZzxcwcmZ0YhT3EjtqxIQ6n1Y8wW4KHUEI/cQ+if1ocg6NPuUseMcdsAAGNTuB56
	3mGTnZyk7nvzRlix4amzrFLXjeg==
X-Received: by 2002:a05:600c:8706:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-486f445fac2mr90958645e9.25.1773900888388; Wed, 18 Mar 2026
 23:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319031227.330505-1-sun.jian.kdev@gmail.com> <20260319040337.366375-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260319040337.366375-1-sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Mar 2026 23:14:37 -0700
X-Gm-Features: AaiRm52DskLo1ZppEqz-30QTaNt_fpupNrXKzogunioIvSEXOJSrNHANtDzQT_A
Message-ID: <CAADnVQJAg1hYmsbVaHcR0jYZY2v3A4iNOiPaMAWRVGpf0qPN_w@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: move trampoline_count to dedicated
 bpf_testmod target
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 9:04=E2=80=AFPM Sun Jian <sun.jian.kdev@gmail.com> =
wrote:
>
> trampoline_count fills all trampoline attachment slots for a single
> target function and verifies that one extra attach fails with -E2BIG.
>
> It currently targets bpf_modify_return_test, which is also used by
> other selftests such as modify_return, get_func_ip_test, and
> get_func_args_test. When such tests run in parallel, they can contend
> for the same per-function trampoline quota and cause unexpected attach
> failures. This issue is currently masked by harness serialization.
>
> Move trampoline_count to a dedicated bpf_testmod target and register it
> for fmod_ret attachment. This keeps the test semantics unchanged while
> isolating it from other selftests, so it no longer needs to run in
> serial mode. Remove the TODO comment as well.
>
> Tested:
>   ./test_progs -t trampoline_count -vv
>   ./test_progs -t modify_return -vv
>   ./test_progs -t get_func_ip_test -vv
>   ./test_progs -t get_func_args_test -vv
>   ./test_progs -j$(nproc) -t trampoline_count -vv
>   ./test_progs -j$(nproc) -t
>     trampoline_count,modify_return,get_func_ip_test,get_func_args_test,\
> kprobe_multi_test -vv
>   20 runs of:
>     ./test_progs -j$(nproc) -t
>     trampoline_count,modify_return,get_func_ip_test,get_func_args_test,\
> kprobe_multi_test
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

if you want to land these patches please participate in code reviews:
https://lore.kernel.org/bpf/CAADnVQ+TKKptnNB25V3=3Dbcdybh5G6c2DyW2sYtXvyRaV=
nPN8MA@mail.gmail.com/
