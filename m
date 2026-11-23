Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455957;
	b=2ih/1NNfrOeFZDuYc5AhqU26JLqWJBRfRlm0ja8bA/wPnyoDLZh2c3aH199hVUjpe7sm
	 pwZDWARW8N5Uo6Lt9E2BdBR6nMsT/YlS4jVjv/dPtFptE9M4CH3xsr6nKTwqKZQi7GTDg
	 tkfE0ZSo6t5RnQwcy5MzSM2pNfzIU/cjicZfwd9+p/sXNFNtBF9tlTCZt2w46TQorCYwH
	 bxhpl6j19YNp+LSumXnUkxlTNaAzOaprsTmJiAznt4cz8c+ju0I14HlNY0t2p/VHVzYLV
	 HzAFVydB4tZXmiKAe/qbxnMfoh04EY8Yvt39Zuvh5vEs4yuKLx2QzMQJ5DrFGV6Qn/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=qcANCWGAJ8v7ww3IZ9+0hMXfYGL5s4SZdvLXFfwNhk0=;
	b=XfVdUoiZKu7Msql/UDnx58Flc23QphGhYDKejCAq6z0YcnRhyZu/70+acCn+GKM7ZxGO
	 6mXcqEr5mCiBpQvu520z1Us/oPFE0pyLPaLiAwRAITKNES8uPSEFVGIc/KnAmgzaBEunL
	 MOeN5YbvOZOtNyBSXWnumAhPLaEEKYnBDsu9/siS5hBu0pySPOQkQvTM5lS8piuDTAZIc
	 yK8kICDdwMUw9sAJPMaFSGDMViGC8bWBBExvrxcvZrHzRm3KGvQS+0sJFnl+0PhPgjzhV
	 r7ysHISlOYDgiVSh+b7tH2+ZC1uTBNUOrgm1oKB0cc6Wn/TFmKEDNi9IdRQp0vSRvTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I33oaVgo;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A5606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 17:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC4A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I33oaVgo
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f0458cc9easo26678995ad.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 09:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455956; x=1796060756; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qcANCWGAJ8v7ww3IZ9+0hMXfYGL5s4SZdvLXFfwNhk0=;
        b=I33oaVgoeC04uPk9h5eByaIVsok4c6UhJtmflUX3V2efNwbC2ua34GM40Vo76ocl5g
         RB5JFSekVkITxOHHiUd0bD/6DtZlQlTZVEMRQufd/OJKvbZ154myh/iP6FWzZ66ho0bw
         tJOiasroCsrir4H2KFZuR40THn+Pd62gw9Yb/ltcjsR8wSZW4V5xfGN3h6abrUvYO0z9
         HRFh/hfP44+WLrQx/nXejj0BBfkAldkK5/luHYs+QZ9XL7ikY9r0zwdLA+yqVUYcqg/C
         ghqfGyTbK5QL7xonrnJDxCFb6p5gBGHM13Kp9gsA0HnkLdYfFnnPV6u4L7M3dUtIC5hN
         pglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455956; x=1796060756;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qcANCWGAJ8v7ww3IZ9+0hMXfYGL5s4SZdvLXFfwNhk0=;
        b=EzLDGxqaBVAfMWTUOxOFBBaJdSAcHrhDqmrIDZ06klaqPvTDDaAm4SW2OtvQ3rlGNg
         cVE8fvZiZyXTDc4m+DRImmxeZScwjtn5nUd4aAMTWiv1dZQP48s9NeDH5kuOPR07L8m2
         BSBxNbseHi6FnwHdF5KpYzS84HcwCKNDx/9ZyUgZLpEJzVNz0TF2uYJa6O3uqUeu6UeA
         zkpryk1sqGop4Eo1e0JpuswdB+3uh9OYlXuRN9JJmfjcGOOBSjic6p5NFOC44KbUBYEO
         WzEhrBZdNa9xgNNTJ8ukIUz9s5FCGbJoSmJdVB2nK1+XUTjo63nNWJ+3GzjrrHJsrLga
         PYfQ==
X-Forwarded-Encrypted: i=1; AL+hErGNrUV++ynriYdVWZq4ojuBfUFUNhP5WvXPGMeeMS8R6SIBrgaMVH2Hdj1EBEQLiLA/UG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8nwIMsCVvAz+aPzlgrsKJQNpex5QVYjOH34ElmQTvqa/+lx5A
	w4rz30i8EOqxQx0+b9xMy9DWD0nzO+NiWZlYniyPW0LuzkQVHl6UnNot
X-Gm-Gg: AZFdTZdyVJ+F3OWAJJY1MXAtUrusOZCUYuQLD+XfAHVwGZsM3v8tw/W3+t7eTX61OVX
	MvLERsu/a5DuoIr5EVSh7o6NZHKWgQTWI8DgmpfMNf78CgG5yar83MbffhwmHOGBZB+JP1vugAe
	dy2U2MKfaigl/Rz2XUhrhTR4U3Xob48QHcF8Q/1vzByaBavWN0EHw8X9TH9/s2QKXkdwVldKyZt
	CRqVBBcuPFBs3OMS3yXpBWc/D4WkDC0tk+LKRJWr25yzWm7Mz0NabNeq4kwpD6UMwT7wi1qFIYI
	lVVOTf7SRTZKjgz0JfzGOLsN3jwRSv372yyDCQfuMsaauBk5h0yLiDJlkK1Zya1s5G57f10DEnb
	qd241C8UTQF7aRTFiywP3aoC5uiRX+GDto6lQ5iqgiIm7CS8j1pd8kzirH0sH6v83srkVeHWHFu
	oEDxHIPX6Pu0BE6ziuuuxeR2vpdPMkrjVj8GdUhhMF5xfMpF/ySq342nOBY2x6SBCNS5MaoTT/M
	RJu7cBPkZ/Zxj6XUjGpAV5ix7gTl+wrWJL0KYGUxO+CIK9vrcy+PDwhzfzud8z9+lWew4UmOUe9
	YMdfa4LHKywMFjskvCNqPY2Kv2DsBkrlell+lmPfskAiyGyYHJypCD3azw==
X-Received: by 2002:a17:902:f54c:b0:2e9:734c:5025 with SMTP id d9443c01a7336-2f03f17ce04mr120911505ad.21.1795455956061;
        Mon, 23 Nov 2026 09:45:56 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04ed9620esm48478255ad.26.2026.11.23.09.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:45:55 -0800 (PST)
Message-ID: <fc517c55e7060cf7c0da6e797a602488cea403fd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 0/3] libbpf: Fix CO-RE relocations of
 unsigned 32-bit enum values
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, vineet.gupta@linux.dev
Date: Mon, 23 Nov 2026 10:45:54 -0700
In-Reply-To: <20261120214957.868409-1-yonghong.song@linux.dev>
References: <20261120214957.868409-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-20 at 13:49 -0800, Yonghong Song wrote:
> For a BPF_CORE_ENUMVAL_VALUE relocation, libbpf sign-extends the value
> of a 32-bit enumerator even if the enum is unsigned. A value in
> [0x80000000, 0xffffffff], e.g., DCACHE_PRIVATE of enum dentry_flags,
> then doesn't match the zero-extended value clang emits, and the whole
> object is refused. And a target value in that range is patched
> sign-extended.
>=20
> Patch 1 zero-extends the 32-bit values of unsigned enums, i.e., with
> the kflag 0, which is the form clang emits. The kernel builds the same
> relo_core.c, so it gets the fix too.
>=20
> GCC emits every 32-bit enum value sign-extended, since its
> __builtin_preserve_enum_value() returns int. So with the change above
> alone, GCC objects that load today would be refused. Patch 1 therefore
> also accepts the sign-extended form of an unsigned value, and patches
> the target value in the same form.

Hi Yonghong,

I checked LLVM and GCC definitions for __builtin_preserve_enum_value().
LLVM:

  clang/include/clang/Basic/BuiltinsBPF.td:

  def PreserveEnumValue : TargetBuiltin {
    let Spellings =3D ["__builtin_preserve_enum_value"];
    let Attributes =3D [CustomTypeChecking];
    let Prototype =3D "long int(...)";
  }

  ---

  gcc/config/bpf/bpf.cc:

    def_builtin ("__builtin_preserve_enum_value",
                 BPF_BUILTIN_PRESERVE_ENUM_VALUE,
                 build_function_type_list (integer_type_node, ptr_type_node=
,
                                           integer_type_node, integer_type_=
node,
                                           0));
  gcc/tree.cc:

    integer_type_node =3D make_signed_type (INT_TYPE_SIZE);


Meaning that the two indeed disagree. Given that GCC version can't
express 64-bit values, it appears that GCC side definition needs an
update. Would this allow to avoid GCC-specific workaround in libbpf?

...
