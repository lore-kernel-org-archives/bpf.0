Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD294CEE4E
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583265; cv=none; b=bq9Wjk2V0svnzZOlpOSNvFWDf3+dI849YMOyoMgrMaVcHsPQ285vyYCZDGXO4i7EyskR4hf2abzZbcHmJ2a0iAlImcdRXIu+Bdb0GxJr/CM/KDv8ieWNz8FZWSyL1i/3NbryeguLWPndyNowwI/TQYg/cO+19Icp5BuvBso5o2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583265; c=relaxed/simple;
	bh=DBsJODLpHhq7Xo4SP61U6kyETTZY0DJlFzY+2HvCH3A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A77hIO/XrDeRiGaIl/WEnaXlVMC4dnVNvsWsw/xr4XGF+VCUhXAUw/tkUJ/eNxp2+ZoAmXxTK9e6JFfqVx8+Ig3FtB9htyHYKlQoJKS/Kbk4mnkm2d7WO58uIo+oyPqiqFASmUR56TvMEzMRvLXuhKS8x5cZI2BG89afMrmP9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzarjrEf; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzarjrEf"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8633a38df87so794715b3a.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789583247; x=1790188047; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bp/x+Uurpq3Gw4sHJWHd6TpM6cF791YHOEvuK1s41+Q=;
        b=nzarjrEfveEBKtFbr35O/QFFczuWEEMpoxluVQGCgwSnSmhD3n39PhEKe5oG8jFwDv
         QFxI27nAW/f3L2sqAmJefBQ7W2P8tHu8O+k3wXzEitnPIR0nzS5Pa6g3/hWD7UzsO6W8
         k/17DmmWX3o+8nP1YT+lgm2NCjxv+IjjSQpIw2etKUI0W+WIhVIJgD37SjiUlzHbkbZf
         WB291iNgKabAlQuyarvfOLF6dS4E94ZqGE7OC7GZLkp+litbyDyI08LAM+u4D2QZ3u6I
         VJsKKmTzBPxdaretcQ4RPQa8Rf84gLP1myYi4ysw17gkKy6gUNfEmyDk8b6Exvmp8CgY
         Vuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583247; x=1790188047;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bp/x+Uurpq3Gw4sHJWHd6TpM6cF791YHOEvuK1s41+Q=;
        b=QBlXhDrmmJOdJjMhqoofQWKrZD0FQJRc0zuAH1PE4WActgFOV2BKHMGmaz8OTi5GPw
         oO5/UNbcHvVx1nrOowPHlpYWsw7+ue6sTJ6MkDXxyIxZtolPEBf63WupyFa1gjmmC/Ei
         frosOSdP6KTbYCmPT2wyaIGQwwGZWuDyNcPJPHStu9NOhqrnl8keOe/hbziAAcEyCN/R
         4/Fc+drkAt9RWnqbpqXrMPUDOxRrBPy7F2YDGuZdMFT5+egTaWxD5w1Il3xYzmv0Ng/U
         H0Z6FrzRP14bvs0HahJJYfs6GdbmuPCd8rcql/CXHHSnT2VJhcwH290yEhEneYMwwISC
         H8eA==
X-Forwarded-Encrypted: i=1; AKwUvBzJrBkZS8i3I3MEYlWFGp8v4AgoSDJxsmlOidVXR3+08UsG4DIdDRYNxsbmAap1qHtbhGU=@vger.kernel.org
X-Gm-Message-State: AFuF++lxMkgpsL+GFB/Xc2rE7xn8+U/wCJgptdrxjaxTEdoqacf5bMNh
	8eTKUojHq9GIMAvvv6gV37k3de74KxLR6N7dcz7rWm3HmSXdteSE8VOp16xTdIky
X-Gm-Gg: AYBFou2fzPjktN6Jb0ZKxo9ino1TbkqXH8T7T5EG1p8p5fZ4YKeOeygHMaPoD/EGfM9
	bSMyCSXODbtf59DQwLIpNV+F4gt+fuPjB0D9fQotECacCthufQKrBxdk+IF9mzstMCch91C1vZU
	L3ykcPpt6IDY1UrwlB2VecjLF8jz30wNByEneHsG8KhlgbvibpupNhoyF6M1P6DPDXJ1FNGdzk+
	xhwl3eORKyDujv4B+z+jxKObTTwDKORUGloBj1VloF9BlSSXf3TcqT92up9DwHmwpxlZ/Tlb7DZ
	S+S1PQmdF5sUSAetiBKXfZHTdQ6oju+s+Kbo0jDaipSeOAyoBr2AlhRHuoZSoxEOqrqV44swOQk
	eYKzfqKMMlTht5KVv3x6B0Njd/cCLLCKmiVOMSPT1Jl7gKrhyuWTQZj7ksogoAt0hqO023Re0pb
	7q0GdogcVjT4Fys+PPLfj/GI54Ne3HvhKQToBnvTvo9h4OuKvY7NdQlYDAsoXIYN3sKcmhdpr0I
	R9NuD8kykZfo2NCcDbzwTQAd54=
X-Received: by 2002:a05:6a00:2990:b0:85b:8606:627f with SMTP id d2e1a72fcca58-8723a49f3a0mr8580905b3a.26.1789583246693;
        Wed, 16 Sep 2026 11:27:26 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87201d1800bsm1702918b3a.47.2026.09.16.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 11:27:26 -0700 (PDT)
Message-ID: <1157c4ae43fb3bb79c8f2b542dc339e912c3963d.camel@gmail.com>
Subject: Re: [PATCH bpf v4 07/11] selftests/bpf: Test CO-RE instruction
 poisoning restrictions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Wed, 16 Sep 2026 11:27:23 -0700
In-Reply-To: <20260914222514.1635018-8-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
	 <20260914222514.1635018-8-memxor@gmail.com>
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
> Add raw CO-RE relocations that fail to resolve their target enum value.
> Place each supported and unsupported instruction form in dead code.
> Unsupported targets must fail relocation with a diagnostic even when they
> are unreachable. Supported ALU immediates, memory accesses, and ldimm64
> instructions must still be poisoned and removed as dead code, allowing th=
e
> program to load. Check that both halves of ldimm64 are poisoned.
>=20
> Update the subprogram terminator regression to require rejection at the
> relocation step now that an exit is not accepted as a relocation target.
> Load every program without relocations first to ensure that rejection is
> caused by the relocation rather than the original instruction stream.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> @@ -127,7 +149,49 @@ static void test_early_core_relo(void)
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum_id, access_str_off, =
2, true);
> =C2=A0		if (!ASSERT_LT(prog_fd, 0, "poisoned_load"))
> =C2=A0			goto cleanup;
> -		ASSERT_HAS_SUBSTR(log, "last insn is not an exit or jmp", "poisoned_lo=
ad_log");
> +		ASSERT_HAS_SUBSTR(log, unrecognized, "poisoned_load_log");
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
> +		struct bpf_insn insns[] =3D {
> +			BPF_MOV64_IMM(BPF_REG_0, 0),
> +			BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
> +			tests[i].insns[0],
> +			BPF_MOV64_IMM(BPF_REG_0, 0),
> +			BPF_MOV64_IMM(BPF_REG_0, 0),
> +			BPF_EXIT_INSN(),
> +		};
> +		bool is_ldimm64 =3D insns[2].code =3D=3D (BPF_LD | BPF_DW | BPF_IMM);
> +		int insn_cnt =3D ARRAY_SIZE(insns);
> +
> +		if (!test__start_subtest(tests[i].name))
> +			continue;
> +		if (is_ldimm64) {
> +			insns[3] =3D tests[i].insns[1];
> +		} else {
> +			insns[1].off =3D 1;
> +			insns[4] =3D BPF_EXIT_INSN();
> +			insn_cnt--;
> +		}

And I had a nit regarding the `if` and `insn_cnt` not being necessary.
But again, if there are no other changes to this series let's land as-is.

...
