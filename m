Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4F1A23B9
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775326050; cv=none; b=uy3lCadC/V3Chb3aNkQEr26CX9Zo1Y/yv+gfNOL/wZWou74ys7hlXgnLgzXLpwUx5nR/W3SSy5wk+V1X/UpcEUDkAv7dxxOURZ6RxAF4O/qjDzIVf4hKMSqTE8tgHDxXmU8SauyHs3OY27HN9pmWbJXUYsB5BuG4vMP7ULVUZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775326050; c=relaxed/simple;
	bh=PsA0F0AYPxizy/4Voh/kmVVyZtNavGKNQ3bVV+OLyTc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UwfuAjwHVQjnvDMS+FuuqlreyYwVySrUZutt7Oi9j4jqY4jrjDF/64VYPUTq+RQYbBzRhNkLEYpVncsanj3pxtT9zLnrG1Idz8spfp1pz+bANLVvchRFyB/4s1SswtRrBPkUA2WXsO6fr1OfWvbGGe0lZfH0sEYYrgFLX3v7Ze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=PdrvTECT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="PdrvTECT"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82c70e4654eso1275110b3a.2
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775326048; x=1775930848; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tXypDeVe4Nnp+DHbOMj8Mu0Sf+t3Iv7t1GfKzTp2lI=;
        b=PdrvTECTCBR4hTJ/+JE1+yb+Up+DauPGz4v4r7/Dic42emHBX41DUT6MjjrDIypS27
         LjYxrACjirKL5Np4cOnYzSHhHdxxTo2GeeNqpEJZwzGfnhu3M9BNAKQJQ4Nb9W3TLmKN
         Do9KHQ2UiQoEYxGX7Iela0nRvgi/LXbgHjn51ofxs957nmHyZfhytOvqz1oldmn8/yir
         jx9qaIfi03cwhCIdy4gL4CcYkQBLNk8sj5OrFY0UYzG/6Jt1ga7JkF7w/L8XsHdmNwTI
         8CLjBxjGt8NCafX57ov1cJjmCP1yaJO0zM2vIpI8czUjuc6NFapqNL5fPjPbSA6GG91v
         bBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775326048; x=1775930848;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tXypDeVe4Nnp+DHbOMj8Mu0Sf+t3Iv7t1GfKzTp2lI=;
        b=AKKRu3NGKYgTXE9l8cT8jVSnYid6E9p8nRSHdSNsgnxIWcTaGYFRp/Y+lFezC6d5dc
         QUPnzm/Wb77plwS9JB2v9Bk+sF2H81RsYqClQI3a6zp4N8dWUF8A+c91k3hmo9hhXUyY
         eerMGhKLpyofBDHrRjED4mCk3PQ5QWKUzD5fZlRq+78iomcDnDunduvca37vGjauAGkI
         oZneOcSVRmdlp/BHMKurW0FNpi+Q30wlEBPg+VosTTPzNrtQsVeCfgL0ToyKpcbceAVB
         SnCTxhFKNEaieqJU69QWsQ6vbMVViFzkBi+SBZzPJqck6QsJnNmp9QVrYpE2My9nkYyj
         TK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYp7va1Cru01ODdRY4VveVKoJqpqbys1B80Xul6EPWhlXqdxMuNKkR75PuCQIkFwQ3VyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymafQrBILOpsVM8QzD9nbgfnEi+gC7gD+Cj8OyIYEPpAotUWw0
	VonlwElCSkMJTwFW/fwTKiAhLPcH7ag8Ru8BQvtr77bC0ox6LVHcMNZPWsnbBC2+5CY=
X-Gm-Gg: AeBDiet5zY9EvC/cgA4j9FFXbtarN2HG7Q6R+7ZTM8dU1a1wxFQpw3/X/R9NzPqHTJ+
	xXKmhee/kS6ck2/KONKNYfc5pO4VOXZbFPbq0k4+XOeRRsA7FBN0XHpHf34ctEMQk3sw4NFzbAR
	f+gEblm/lwLqO6Kyza/dY81yZYQlZyxWhhv2vDokRCWAWWCbXqrS3H+H0YynFO1tCgJoLUkjIqq
	QhScWpN+l+tAz1egbakcuZOHUgk8lYQtsZjhq+jTtyLZ0cWQm/SLx7MJFbboFuXwaUKGmkEQddn
	zF7ahiaNloP8eV4IJoMbQOzTQgDjnD8/hEh5HLdcc+4fGzdE4WVvGVfAo/whPyd3KEB2ZIGSUFx
	G1rhcZnZ98zVQ1uh5VdKHKln6hR1VFvTNiFzXmiiKRmiqyFzxcXestyMLPODGCK0MPEhFX5Tp5K
	ulRsjDvvxDFn+BlYK8FQ==
X-Received: by 2002:a05:6a00:4189:b0:827:3b3d:5c8 with SMTP id d2e1a72fcca58-82d0dbd43f4mr6546028b3a.54.1775326048335;
        Sat, 04 Apr 2026 11:07:28 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b6113dsm8460270b3a.23.2026.04.04.11.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 11:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 14:07:27 -0400
Message-Id: <DHKKK70L9RUP.18AD7WT96CVZU@etsalapatis.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 <bpf@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH bpf v3 1/2] bpf: reject negative CO-RE accessor indices
 in bpf_core_parse_spec()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260404161221.961828-1-bestswngs@gmail.com>
 <20260404161221.961828-2-bestswngs@gmail.com>
In-Reply-To: <20260404161221.961828-2-bestswngs@gmail.com>

On Sat Apr 4, 2026 at 12:12 PM EDT, Weiming Shi wrote:
> CO-RE accessor strings are colon-separated indices that describe a path
> from a root BTF type to a target field, e.g. "0:1:2" walks through
> nested struct members. bpf_core_parse_spec() parses each component with
> sscanf("%d"), so negative values like -1 are silently accepted.  The
> subsequent bounds checks (access_idx >=3D btf_vlen(t)) only guard the
> upper bound and always pass for negative values because C integer
> promotion converts the __u16 btf_vlen result to int, making the
> comparison (int)(-1) >=3D (int)(N) false for any positive N.
>
> When -1 reaches btf_member_bit_offset() it gets cast to u32 0xffffffff,
> producing an out-of-bounds read far past the members array.  A crafted
> BPF program with a negative CO-RE accessor on any struct that exists in
> vmlinux BTF (e.g. task_struct) crashes the kernel deterministically
> during BPF_PROG_LOAD on any system with CONFIG_DEBUG_INFO_BTF=3Dy
> (default on major distributions).  The bug is reachable with CAP_BPF:
>
>  BUG: unable to handle page fault for address: ffffed11818b6626
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>  CPU: 0 UID: 0 PID: 85 Comm: poc Not tainted 7.0.0-rc6 #18 PREEMPT(full)
>  RIP: 0010:bpf_core_parse_spec (tools/lib/bpf/relo_core.c:354)
>  RAX: 00000000ffffffff
>  Call Trace:
>   <TASK>
>   bpf_core_calc_relo_insn (tools/lib/bpf/relo_core.c:1321)
>   bpf_core_apply (kernel/bpf/btf.c:9507)
>   check_core_relo (kernel/bpf/verifier.c:19475)
>   bpf_check (kernel/bpf/verifier.c:26031)
>   bpf_prog_load (kernel/bpf/syscall.c:3089)
>   __sys_bpf (kernel/bpf/syscall.c:6228)
>   </TASK>
>
> CO-RE accessor indices are inherently non-negative (struct member index,
> array element index, or enumerator index), so reject them immediately
> after parsing.
>
> Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algor=
ithm")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> v3: added selftest=20
> v2: fix typo Signed-off-by tag (missing leading 'S')
>
>  tools/lib/bpf/relo_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 6eea5edba58a..0ccc8f548cba 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -292,6 +292,8 @@ int bpf_core_parse_spec(const char *prog_name, const =
struct btf *btf,
>  			++spec_str;
>  		if (sscanf(spec_str, "%d%n", &access_idx, &parsed_len) !=3D 1)
>  			return -EINVAL;
> +		if (access_idx < 0)
> +			return -EINVAL;
>  		if (spec->raw_len =3D=3D BPF_CORE_SPEC_MAX_LEN)
>  			return -E2BIG;
>  		spec_str +=3D parsed_len;

