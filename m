Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D83947AC
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611635; cv=none; b=gUmMg/rV2w8ZVNxkRgJxvoORkl1MwNYjtQGfTvDW/NlaQ73Z3igVA0GhEnbXeIMgjlhnVjljtkVUBbx/LOpU1utBMDlyp366oKPMMpezB+WQZckw3Ydhe2g4O4qhpSvZS/JTDhPefC3647HZSEbMoY790MvOa+LHFBLM26/JG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611635; c=relaxed/simple;
	bh=rPn63S0h2dv5WF342vRecp9qdxxBLhfV+ClSY9vatQY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmPVflqugS9JJsA65JIJcAT08Df9TSS2t8fewL1C5uOwKs5yw3A1kbe2DpKevaeTGhnUdgPeReA86eoJZDh055Bbqa/o9zQ2NxAe80wAanxWgZetWJsJdNV7TQsKZKAWyKo3LSITiJEHsdSAmVwLb5H2H3ELhUGuatqypHlHiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J47IswC6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J47IswC6"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbee846deecso4613557a12.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787611633; x=1788216433; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rPn63S0h2dv5WF342vRecp9qdxxBLhfV+ClSY9vatQY=;
        b=J47IswC6Q0NiKyskRCfXiL0b3btbERCnd2kJ2QFTyW+GfXtXk3eekYrEWQ3rewjooy
         2xRBiNC9BCJlAkHsURmSD5h/ZWwiWgf0LNgrsv1NpaX6HTvVWWDTKTV1mbr4R/ticPvk
         n8RLPM6xT99TLak4hEF4786z2Qy9W0Ov0GC2fc7OJYpFaJ7Lnoqmd7gSdPIiorH3226C
         6OMZq4kiUm/pkzSDafZ9u28YftMuIEY2EBdQzthoXuVNDaA+zHx1bX+ntfZDNYPvNGYt
         /0psiaF1gN8VtPTdqc6b2vDlyCKbeXXyS88WG8Gp7KRQzwQxF43HXEx228JVKAleAAV9
         WQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787611633; x=1788216433;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPn63S0h2dv5WF342vRecp9qdxxBLhfV+ClSY9vatQY=;
        b=SJRNZFeUTXsFsXbE/wMz34lDSMTsCYBqoFNGs+9QC5IiPzn/Ms9rTt1j+3b4ZZ1ckd
         aXRhc/65caERRtcKcqzqgEEC/OxuArnBdVUlYlLQySIRcXq9mmBXlbpJpbl61TKK+Gvm
         ZFyWjfm349Cs00+fy/E5ikOQCFIFh+RP+rOiyThR+MjXE8VmGeAzAYrMHEDVrIcQQrRA
         IdYwErSmDisd6chH1mJSScOpRvxV9DPyOfwQjhlLwi/bVzeeAEi9grUFCOxH0xkpHuPr
         v19Yb29zw2xQgr1dvstnMNFHYYGLjH+TIVmo7rWwmmuVyhQfhBPVR3geKptyK25xDEVi
         aVMw==
X-Forwarded-Encrypted: i=1; AHgh+RoFtAnZN021MvXPuZuiySjMFhHIfd39+kYfl4HlFky3s7I7/K8YobTj8XFj5Qo5P58a9bI=@vger.kernel.org
X-Gm-Message-State: AFuF++lp2gPN3AG2MtRxPF/lY4ynyZQuJQabRf3gPOu+7CkBoLfQwSPt
	EaONrujuzzCg6WziO/7KJIGUOuOGtBRondDjz0IJGDgO1jDDLFXofIRdBOfiQ50veKU=
X-Gm-Gg: AR+sD11ALsc13acYW99G2tDykbj2MwJsRVrY8TuTfwp1kcpnTxRaXgpVQoXpe0BD2hl
	jwXn5eQVCSpkEbm1jrZLGXDjn4je5H8dNvUksz2URs0VqFHL0N2t1iF7OQCWy5G52Ry+HHtKkpX
	J30KjxGi40I11pCIB1QgGl+ArSBVadiKCaNFcuBFjxZ1iIM2KpHRNBWBQ8VQVYkNr3eWHSurbKr
	SV3rimdx7NoBLVZAxBvFNRbB/Vf2Lu7ELkiH1wODKT5CDwNMewMltdrEqn/esNrg5nAN77Kb9EV
	kiHkPfYF9gicoymuEcoQyK+oTniyRnd+4Ccrb711923YAU9cFVUsRpvmfwODs4/oibHHzMB6hOd
	g+6YZ5gc1WPv4sTaHQy9L7osY0jH5r5SNf+XYaThZ/9lUT87PPURK3U2vuzvJsXlInpchrHaNb9
	SziuH6bcGO4v0eJ0EI3vcqYJnTYhiq+8/X+sP1YsLbK9mftoL9mvpsyGddRYXoAgZrfJKNujLGL
	D2Q181OdULJ7MXqddVDoNbliGLRCCIxxorpsbXFLvGEwBkny9autOof
X-Received: by 2002:a05:6a20:6a0c:b0:3cd:3e77:1dcd with SMTP id adf61e73a8af0-3cd9103c9d7mr3717370637.1.1787611633125;
        Mon, 24 Aug 2026 15:47:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9099ce7sm27975259eec.5.2026.08.24.15.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:47:12 -0700 (PDT)
Message-ID: <08a3b5f472899c06ff43f0b8e71c6f9c4871143a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 2/9] selftests/bpf: drop stale lines,
 restore two header dependencies
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Mon, 24 Aug 2026 15:47:10 -0700
In-Reply-To: <20260823194241.3415152-3-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
	 <20260823194241.3415152-3-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-23 at 12:42 -0700, Mykola Lysenko wrote:
> Four target-specific lines name objects nothing builds. Three name
> the BPF objects by their pre-rename names: commit afef88e65554
> ("selftests/bpf: Store BPF object files with .bpf.o extension") left
> them without a target; the flow_dissector_load.o dependency names an
> intermediate the generic one-step compile+link rule does not produce.
>=20
> Three linked-skeleton dependency map entries (xsk_xdp_progs,
> xdp_hw_metadata, xdp_features) were dead on arrival: commit
> f0a249df1b07 ("selftests/xsk: get rid of built-in XDP program"),
> commit 297a3f124155 ("selftests/bpf: Simple program to dump XDP RX
> metadata") and commit 4dba3e7852b7 ("selftests/bpf: introduce XDP
> compliance test tool") each added one, mimicking the neighboring
> entries without adding the skeleton to LINKED_SKELS, the only place
> the -deps map is read from; these three skeletons are generated by
> the regular pattern rule, which never consults it.
>=20
> The '-fno-inline' pair (test_l4lb_noinline, test_xdp_noinline) had
> stopped taking effect even earlier, with commit 74b5a5968fe8
> ("selftests/bpf: Replace test_progs and test_maps w/ general rule"):
> since then the BPF compile recipe expands TRUNNER_BPF_CFLAGS, a
> simply-expanded copy of BPF_CFLAGS taken when the runner rules are
> instantiated, which a target-specific 'BPF_CFLAGS +=3D' cannot reach.
> Both programs have compiled without the flag since, and nothing was
> lost: every function they define
> carries a noinline annotation, except the SEC() entry points, which
> nothing in the file calls, and the single __always_inline helper in
> each, a deliberate exception the flag never overrode; and
> compiling with -fno-inline restored yields byte-identical objects.
>=20
> The two header dependencies with remaining value are restored in
> working form. flow_dissector_load.h moves to the binary itself, which
> is linked straight from its .c by the generic '$(OUTPUT)/%:%.c' rule
> - editing the header now rebuilds it - on the line that already lists
> the binary's helper object. cgroup_getset_retval_hooks.h -
> added by commit e7215f574079 ("selftests/bpf: Make sure
> bpf_{g,s}et_retval is exposed everywhere") days before the rename
> orphaned it - lived in the top directory, outside the progs/*.h
> blanket prerequisite of the BPF object rules, so editing it never
> rebuilt the BPF object. Move it under progs/, next to its only BPF
> consumer, where the blanket prerequisite covers it - the arrangement
> several other headers shared between progs/ and prog_tests/ already
> use. Its userspace consumer is tracked exactly by the
> compiler-generated dependency files.
>=20
> 'CURDIR :=3D $(abspath .)' redefines make's builtin to the value it
> already has, and 'OBJCOPY ?=3D $(CROSS_COMPILE)objcopy' defines a
> variable nothing in the selftests build or the included kselftest
> infrastructure ever reads; drop both.
>=20
> Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
