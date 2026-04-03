Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C0303A37
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775254425; cv=none; b=R8YzUhniKX1Uv80eikYitkMuknYaQ1WP/KXBmw7HsVVq0+XijtInX+VXlhCYGQuJtREYt6OsvPWaIYaT1h618oC0iTT7IYrHi5mSwWcGIxhg/c5hjtCGfDWYsoNfJshLuPIWHIlwIAiJ6hyDz19RjnqMmehzK/jwgNiqnAvEtNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775254425; c=relaxed/simple;
	bh=i2stwrrYi3BJRej6viO3wQSpQKnMRQSGmOxZFtwf1pg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=hKtD0MjkBagcXGXkSdvR3pQULip8deqwErI3f9cBdM9ffamUJU5pG8dalDMI9HG01rifbp7O8MZp7whkCYb4mgNY4k9ehualuV/JXEN0whS8j95lr/mvudNxwG9x7nXLbvH71BN+8V19R+DSnVdNoZrex/mDkck+/OYU8koJQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=bWARULfA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="bWARULfA"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c76af7b0f94so1413874a12.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 15:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775254423; x=1775859223; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdtPCPoOgnbaxywOs43fzhXUUBODqat19mF/GDkNglg=;
        b=bWARULfA7L8/+B9Dh0DGb/lefyhbpW2bdkIvK0snLD4zGFcIKKmsXDo91SMP1ECxtR
         ByBrqFwJzU07Fnm2mKr9TlT6l9uoHZpEsfekZTF0an4HquwjTLmB9bJVDBuXflzCLwIQ
         gc9hp8Q7sXCpnRpGjJAXUtc3TBOvKy5BCMMTUkwha8jN+d7WZ4I0+Y/CLXqITrELZOPn
         52okzs+1OLNHN6GyEAO/pls/kNuMBy6v1+UWjGCJlcZvjpUbSoIKxXFSWU9egxSaK1kE
         0U3WBIdtAW5Q/dhqE0naR4D/hWcjTy4HY/fWd/FshOA1bFKbBQziG37PGBJU7+uKfY/w
         OG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775254423; x=1775859223;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdtPCPoOgnbaxywOs43fzhXUUBODqat19mF/GDkNglg=;
        b=keVN6jCTxuV6h+8j+BXOR9wfD0EzttuGluLmCv1G6UhPnOgFHkkU5p9RfFQ6QNk19Q
         9D/dbnwzRNFyGzuXNCP9hdE4IqV2KvO0R0sxYFNozd1W60Kb9naLAQRJ1IqjnSRlg90q
         5r328n6kyz3SwdNkaOZ2R+SNte720i5YDwf/dAdlQEZOpL5S1ZHw5WSSt0yrMq5+cwCE
         rua3XdOWZQ0znzZfCw9R3NPYC2ekG0V+4PWdMWj+RoytgmpaNr9iDkT+ixZxegYnhdUM
         cUGFzgiO2deGjoWdHKPG6Rhet6bmLsaIcTAbRaPZfGm4vRJ0HDKdyQHxe7YdmNhAjcGm
         Dcag==
X-Forwarded-Encrypted: i=1; AJvYcCXNAyJms9hVVbBQEGyMbDnqWPD4bj2yC9APbtmXeJ2zuKUdcCIcTB/y8HoIjAxwwvM10XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLu8mEWfDBrAe3kmrrKMHx3IeDVVtrbZW9+sUZz7KvtD1IMcZ2
	dokM9hNEga1HQqbUitkKOhkq0vFzpNfob9scazHn5cnUQ4fCUZ60RPbWBMsK7asTnd4=
X-Gm-Gg: ATEYQzy8Tm7gEzSX5+J3W5RpY7/OEi1pc0WhT1Sv2GpqiS5Lg3HoMqHm+sBCeWrtUdD
	7vft0Cpf1zU04vp44feky5vNTdgVMXTI11VKpB1KUZFiGcQCmOQ8s2PcZOxF9iRdnegfMM0hYvQ
	56Q/0LiQZTAIyUhekAHBeb0kLAOXkHzUEnfbDdu8cEuvvRJ4sGyA/kqnkYoHZLiHW2JeSnISXUu
	nr+1I+SC1/gJwQRtOBa1fyrrbLV2mkmW3GGcvMP1vaqXGPMtMIX8BPWi4PLmDE2DKseQqC2TU98
	6oe5XuAI8Ak1oQlwY4cYIHZr0cBRbxtnMbDk1b0CwW+uSLKdQrGn3wmrDOpKe7klMCoEZ1/ng4f
	cRS9tQzk6i+PuQdEMsInKLa40Dy0eie8YNql1a2fdFMTBIRPf1hYRQNUb++wFC1AmNb+CWSLgDr
	qRpt28g4g=
X-Received: by 2002:a05:6a20:430a:b0:395:ccae:d494 with SMTP id adf61e73a8af0-39f2ee10e34mr4634200637.20.1775254422915;
        Fri, 03 Apr 2026 15:13:42 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3aaeesm7348618b3a.13.2026.04.03.15.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 15:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 18:13:41 -0400
Message-Id: <DHJV66NESCIC.230BWL0DNXZ18@etsalapatis.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 <bpf@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH bpf] bpf: reject negative CO-RE accessor indices in
 bpf_core_parse_spec()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260403035111.4031084-2-bestswngs@gmail.com>
In-Reply-To: <20260403035111.4031084-2-bestswngs@gmail.com>

On Thu Apr 2, 2026 at 11:51 PM EDT, Weiming Shi wrote:
> CO-RE accessor strings are colon-separated indices that describe a path
> from a root BTF type to a target field, e.g. "0:1:2" walks through
> nested struct members. bpf_core_parse_spec() parses each component with
> sscanf("%d"), so negative values like -1 are silently accepted.  The
> subsequent bounds checks (access_idx >=3D btf_vlen(t)) only guard the
> upper bound and always pass for negative values. When -1 reaches
> btf_member_bit_offset() it gets cast to u32 0xffffffff, producing an
> out-of-bounds read far past the members array.
>
> A crafted BPF program with a negative CO-RE accessor on any struct that
> exists in vmlinux BTF (e.g. task_struct) crashes the kernel during
> BPF_PROG_LOAD:
>
>  BUG: unable to handle page fault for address: ffffed11818b6626
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 7f74e067 P4D 7f74e067 PUD 0
>  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>  CPU: 0 UID: 0 PID: 85 Comm: poc Not tainted 7.0.0-rc6 #18 PREEMPT(full)
>  Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 19=
96), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>  RIP: 0010:bpf_core_parse_spec (tools/lib/bpf/relo_core.c:348)
>  RAX: 00000000ffffffff RBX: ffff88800c5b3128 RCX: 0000000000000000
>  Call Trace:
>   <TASK>
>   bpf_core_calc_relo_insn (tools/lib/bpf/relo_core.c:1319)
>   bpf_core_apply (kernel/bpf/btf.c:9507)
>   bpf_check (kernel/bpf/verifier.c:26031)
>   bpf_prog_load (kernel/bpf/syscall.c:3089)
>   __sys_bpf (kernel/bpf/syscall.c:6228)
>   __x64_sys_bpf (kernel/bpf/syscall.c:6339)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>   </TASK>
>
> CO-RE accessor indices are inherently non-negative (field index, array
> index, or enumerator index), so reject them after parsing.
>
> Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algor=
ithm")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> igned-off-by: Weiming Shi <bestswngs@gmail.com>

As mentioned by the bot, there is a missing S here.

For the patch itself:

1) Please add a selftest for this. The offending CO:RE program should
work.

2) Judging from your description, the code below just band-aids the problem=
 on
the libbpf side. This sounds like a bounds checking issue directly in
the kernel.

> ---
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
> --
> 2.43.0

