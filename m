Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758463176E0
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865909; cv=pass; b=OCP2a1DaSIAKZZAbWSqlu+MuL/6VjJ+eqzSs+Vv/HTEc4KjXTgP9+1I4146k2CxIlV8+bkWblKjyP/fgaWnTi6JutjViYVKnW6AiGSGjqfDEddWcG86HlriMWU1EIh12kAv7X+fdSY5VMh/y3+5Uh4gvQIWsIYk4n/nfPDgQ//c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865909; c=relaxed/simple;
	bh=8O35ywf3frONs/mR3sh+Q3y4PGU/DxQ4aRR+Ww+VwB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8NcL3VTVC/NYgOgfBvXnevon5D+O4P6bvRmLMGnwvvZm7RNGn1hgpw6juaBS3TsNiDOxfchL4SjsxgHn+oD2HgGkw5eHInD+VK0KhNqKTiJWYJjbX1nA1v2ZWQfiQDNok4428M6L4waXhGTwRm3wu9zeUwJ9Dc3RgQqNXlcB9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReOT2Foh; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReOT2Foh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4837907f535so41112825e9.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 08:58:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771865907; cv=none;
        d=google.com; s=arc-20240605;
        b=MVTqZC+2poxDQLYybPPuww5KYpwRpikQdJ4Y3IyFAMM0bBDz/5oSCsCHm826yI0PA8
         yl4bK2oDwl4cMYR9kTgBhV+tGhcOG6GvHqp9E1gKONpSFuo88DH2YU2YQb2nYj9NAocU
         KfkVtFxaO1JL9NVCyy0BarNKwgYo3/jDMtu4WEdH2sW4ozm4iUpe/GkKP6cYDE03tVPf
         YPzRgFzi+NUC0ri8LHkHt0Hd7vMO9RxgFhwXnB4PZRJTd9rXd0+VcxPOdtvnnGuE+wcN
         me9Q3YfMap2GiPkLaExqihr9zmmbtGLALmTpsFrPJ1/P2AADgsLCsZEKvmTTWPMB1j1A
         9BKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2/TWRW3byuvHDEl1Ok9W0sAe5kheK+6oFHQAV5r5ghw=;
        fh=avahKAf924smMndtTEqfpnY6Hc7TmC/pPDjF5khxAZg=;
        b=afBK8r23CSIypfqLVxlGAlgJ+/ZmGfJrzV8zN7Il88l8435b/1Dxp0UJcmKb5oRX0T
         6C+12OFDsyLfmU0wUXwlkopT+xRV3FT/UT4qociMy0YKENj72usqWTBRubf2izlfgrae
         k4uSggeJidWNzC+NS/aBF5JVTPF5xA3fqt7KiQF9BWAKnDMVzsz06mThlnnGcujxzxyH
         IyHtrqzTvoqLQMc+B0MkTpzgansbSQX/WsaZdphajxiBn/FMrxhSp0UTQTBj03OnGB6P
         K21rzrd/l1IKito1h4+lOdTmA/kKKXbNB+3/eRcB+dLb2sDf8rPs02DWRb+hR1auwR2t
         JE4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771865907; x=1772470707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/TWRW3byuvHDEl1Ok9W0sAe5kheK+6oFHQAV5r5ghw=;
        b=ReOT2Fohn+NNBBbUJpNuYk384nuMXyiNFHVPkouNela1ImQm4WI0vsXiu/VNIdP6kD
         J7zbFeV4UpXHLousND1iqZaEXqe2OhDCBiKP2hwdHCwglau583RVveXojmoNacSCTSgg
         ZO94CAlMcp5+NTKBV46d1C7X0HXfTisdBfXxhXbmsz2f6J56rMF41e0IBOw3uio2OqDs
         Y7lh77oFr7d9wjKEiiren2rJNRHlWDpzGIxplX76MbVhCIwSxuXXXVI62qJg103EPqDG
         aEboVMp0zMDHAPCj4Zefd6zEJ6AWFRPjMVdc8LREdbMEmcphSQEHPfJvAkQk1LmVgffc
         LrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771865907; x=1772470707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/TWRW3byuvHDEl1Ok9W0sAe5kheK+6oFHQAV5r5ghw=;
        b=gtOs8/DyCJSJRdp1i3IvuEghGopwSJ5hCqgd6BWN9ZkWwxhfusNxu4PXwplzzOzY76
         yhSTjg6I8a6Ii3zvZLYBHHnsDWwIzSC+Dv7CB/YQ1m+nv5gQ7iJfeyVWDMFUEOam1/0E
         2wWML8dfTen/gny9MN2t25utKd9HVnxd6GQPZalUXIJQOI+jM/7Xu5RS9b9ROxgbwjqH
         Wa1FP2epUwvMzSA+aslZ/r/1k5UW3XAD1thn6hgU/MoKp3X4zZI9gT5djSx14eRWn7Xj
         Cxr0OQYvrCzmWs6cNqOsxQmxnVtOriOe6nU9AuqIw8gAYGbJZX7jvjg2mlomp/IZoh2v
         uI3w==
X-Forwarded-Encrypted: i=1; AJvYcCXGlUwJ1SZy1iOhYVDf6TrvLpUmnzqj0RcyIOZqUkPG2jAq5FnSDyBgC97/JGZY1sa3LCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyOkMf4l1wYhdQQbHGFFAjwgv5ZKiwxHxMa2NUocUnqM52vQE
	2CudIG7fpa60q9V0FIcy8WX2hJBAqE0N1qNkUT4waJp4slaFgeuIp4HWe9toLfkPJzeNXAoMOfQ
	iffZgODPLRqburj+ySPr1fpidC1+HdBc=
X-Gm-Gg: AZuq6aKJSOfHgv8mVH7hKUTGnGHptad52f1Wv8+G4BRaNVInNKJfRkPR6xgYFv3co1s
	hoAD7bJ5K1voXhW2Tkhp/gQcCkMdlxJm40rolzYC7tJrlEejpMn7lqkLdTuO+0BJchlFcvCKm39
	oiKgIa2SUv+gvVU7MzllKMD4rz9Exg0ajQfKRH/3SThuRGxmdx3M6W61lznGQLNU4p47ZFLF3eh
	xIyTjnWz+uxd/oxhVtDLo+rVeEmP/03Arl8X39AHI6yy7RncU4Og0QExcqYZr7xVp5vDx//eK/x
	b7pSwKcrEzmLRraltYZQBKAGpT7bS7vwau9Teqg3D+LRyimdyoZ5YIg6hOM4kqZzNgpP+Vr44nt
	g0Qpyz5KWr793HTBQMRE=
X-Received: by 2002:a05:600c:3484:b0:483:7f4e:fef6 with SMTP id
 5b1f17b1804b1-483a95fa4e7mr119430205e9.26.1771865906614; Mon, 23 Feb 2026
 08:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <692c1f3c4b95e9b8a2bbaf333f4618f1ca1c3cc36fc8b0246b094cd67ed62dbd@mail.kernel.org>
 <20260223104743.37713-1-slava.imameev@crowdstrike.com>
In-Reply-To: <20260223104743.37713-1-slava.imameev@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Feb 2026 08:58:14 -0800
X-Gm-Features: AaiRm53gF6QRXkPAEJJjxdjdGlfFi_H0IJde1Ne6TGCB64Ct4fuwj2XfM2Yoyyg
Message-ID: <CAADnVQ+okfKHvKzCy9vLQkpevhvHMFXhincqmFOQX9zN_vtQyA@mail.gmail.com>
Subject: Re: Re: [PATCH bpf-next v3 1/2] bpf: Support multi-level pointer
 params via SCALAR_VALUE for trampolines
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: bot+bpf-ci@kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, Chris Mason <clm@meta.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Eduard <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Simon Horman <horms@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Network Development <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 2:48=E2=80=AFAM Slava Imameev
<slava.imameev@crowdstrike.com> wrote:
>
> I think support for broader types can be provided in a compatible way
> with future annotated support, as I explained in my reply to the v2
> review:
>
> "
>   > so I suggest treating 'void **' as a scalar as Eduard suggested.
>   > This particular sb_eat_lsm_opts() hook
>   > doesn't have a useful type behind it anyway.
>   > I'm less certain about 'char **'. If we make it scalar too
>   > it will be harder to make it a pointer to nul terminated string later=
.
>
>   > So I would do 'void **' -> scalar for now only.
>
>   I changed to scalar in v3, keeping broader scope for pointer types.
>
>   We encountered double pointers of various types that required
>   workarounds, such as:
>
>   int __posix_acl_chmod(struct posix_acl **acl, gfp_t gfp, umode_t mode)
>
>   Adding support for void** alone doesn't address the broader issue
>   with other double pointer types.
>
>   When annotated array support (including char**) is added in the
>   future, it should remain compatible with the scalar approach for
>   legacy (unannotated) parameters. Unannotated parameters will
>   continue using scalar handling.
> "

but then there is no need to relax it for double pointers only.

-       if (is_void_or_int_ptr(btf, t))
+       if (is_void_or_int_ptr(btf, t) || !btf_type_is_struct_ptr(btf, t))

would make 'scalar' a fallback for anything unrecognized,
and we can argue that making it smarter in the future
maybe hopefully won't break progs.
