Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186EF282F10
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627329; cv=none; b=o+N+VH6bRfHwXgbw0ZUptlHcc2Zy4lslQHz7MKBOmNlx3qDDjeKNwffbBfarGcf2yNCFsNqMGCcO10ReN90B+FQclVZj/rJN9jKj2tD+ZIkFYAqXHwNrJwTF9AxqQdWcrK+H/rDO+TiO8kI3fpZPaavevgZQCZOji3qcwIUkCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627329; c=relaxed/simple;
	bh=1F0OOLiW9fGjEY7d8dnB1zAqAude00vw8yI9xmEyLtg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rvbAPPEkJl7JJ8QvPy9djeh2MUp7cJCljPgoOkDS0f5G078fRSLAYvQXPmetqSBkBI85vWkpDLxLjGkvuvn++fVMPTwBxi28YgrgF/6D59uaBGv1hItSqm7yLmzhBnczo58r5m6x3eHSo6FVLM0N9dUOYQlFkbCyvvSMo1kx2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWIPM3mK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWIPM3mK"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-847aa193d98so119462b3a.3
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783627327; x=1784232127; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1F0OOLiW9fGjEY7d8dnB1zAqAude00vw8yI9xmEyLtg=;
        b=aWIPM3mKWiYm4cYHAXJ2e3QnP1NuiCwnLP3SiSr0pppgk4pjhgYxzUGgNDIYXbNP2Q
         6pKkfyGb46DxeIu2+FV4HPmIigU3AAjG+nnWhQ8TG8TXWOhyEuSn2NOndJj9uvorRTnU
         pqm7zagTANiJ5YfmQ3Y3UtzcgOVPceV4RAOICUYTGwsDreMUSR3sPwBQDNw2as1Rfpoo
         LJ0GA3Jig9bn/unLyp9zYTCLyr2ttmrlfG9pHy/gj5H28tT8fhKECMtgOOT0DVDhGqFz
         fQ1BPNFTuMrAfYtfeRWz3xHHBUyRA7+GpDg/gLxacFHxX/ZD4xO5Q2ad5dKTgBYFTChL
         shHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783627327; x=1784232127;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1F0OOLiW9fGjEY7d8dnB1zAqAude00vw8yI9xmEyLtg=;
        b=P6dIxky+1Lv8SeL8iWJ4QM8Cs+uvT+ClP0aAFvZVYOEzz7t4kcvJ7jZTjwKPC7gy87
         j6sbTSRL0IzUcW8YMacAAdfL/a/MwDAjYhOLvfxqG9AuJXPSiXD7e8QUT7JSBUC0+u+p
         pDkjH8sWFGGo9B23s1NvQXDp6h1Enunx2CDBc3JM1mB56D7i/g0BXzEQ7gnD4ABd50Ec
         gAlJTvEqR41sSiOqQL65tZRe2Jq+TP0WlsmV0QLNGdiBoGXM+WfwaaS3ISxZj7oFPJ0q
         4rcENErHvWrdrDN/VtEgPn3Yb5F9JF0AaxKbIoDdngD1TwnIvctuXC8pSniJ+fet0pVF
         WwHA==
X-Forwarded-Encrypted: i=1; AHgh+Rpz8XX5hMiVo0bAJSu7BKE8G8n/CFOiyVh8Kcedt1Nb38ZSWoEwB/GAG1m0I9H9xbLyy0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKp4hmo4r2aVeeP2J5hOTq8iEDz7ipRqssMBhY+xy9svCYGapC
	aABammoBdF5fCWwnY0aLdvmjx6qx1mvPeWaJm5fEYIa65kZ8dVWK0dbA
X-Gm-Gg: AfdE7cmx4pOJ1QQsIX8KQKjZfH6gn/YU/YmwtX55OjgMSp0qsKCahwSarUy3DH46OP5
	LTj1q2zbtDVlPNeQUVNdB6eEW0zwS4Ai2wyfg8jqnFNyBnn+crbtUA+NtPw/E+3FYAqkCNf9Bcp
	F/IfCQmQkgwzoJNL93rPao3a02ec4vjav4Bwdf6KFZeBrZif4wnDdO5AyBtDEsiKqZXZjxENPas
	stE0Fy8tk8ZsQDeGnGk3aeW4A+UomdX5AvxBBw3UTNmRFYEJ3Zu7lu2U95lZsCijm/AHzD8Xyix
	rOgFRNLz3B4NNqgCwdNi5frZjr7LRQk8d5xYoG3lTmBv/IYJfNh3fPoeHhzRq5RZJJAqfunHfS0
	Wxsw7mLgkA7hIkZbtQK5SBMSSvKUc7uklP4EGzqX/VQUf03mexrbAbRtoO+cFqdQsEepe5gtcHj
	8SG3m6e/Wmx0LRa4Kin+vKAkOtDzwhUTozONMO4yz1
X-Received: by 2002:a05:6a00:813:b0:848:467d:293a with SMTP id d2e1a72fcca58-848467d4b6fmr7550807b3a.35.1783627327250;
        Thu, 09 Jul 2026 13:02:07 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8486768c89dsm948447b3a.17.2026.07.09.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:02:07 -0700 (PDT)
Message-ID: <65fa1c2274f24cb72dadc4a2fe62a24e7ed1b003.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject rdonly/rdwr_buf_size kfunc
 arguments that exceed u32 max
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nicholas Dudar <main.kalliope@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Date: Thu, 09 Jul 2026 13:02:03 -0700
In-Reply-To: <20260709155837.1879230-2-main.kalliope@gmail.com>
References: <20260709155837.1879230-1-main.kalliope@gmail.com>
	 <20260709155837.1879230-2-main.kalliope@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-09 at 11:58 -0400, Nicholas Dudar wrote:

Hi Nicholas,

Thank you for the patch. This patch-set lgtm, but please try to make
commit messages more concise in future submissions. E.g. for this one
Claude added a completely unnecessary amount of details.

> check_kfunc_args() detects a kfunc argument named rdonly_buf_size or
> rdwr_buf_size and stores reg->var_off.value into meta->r0_size, a u64,
> and does not bound it. check_kfunc_call() later copies that value into
> the returned register's mem_size field:
>=20
> =C2=A0 meta->r0_size =3D reg->var_off.value;
> =C2=A0 ...
> =C2=A0 regs[BPF_REG_0].mem_size =3D meta.r0_size;
>=20
> regs[BPF_REG_0].mem_size is u32. A constant whose upper 32 bits are
> set, such as 2^64 - 192, truncates to 0xffffff40 instead of causing a

Nit: reference to a specific constant is misleading here.

> load-time rejection, so the verifier records a PTR_TO_MEM register
> with an approximately 4 GiB mem_size for whatever allocation the kfunc
> returned. A later access check against that register uses the
> truncated, wrong bound.
>=20
> check_kfunc_args() is the site that stores this value for kfuncs that
> declare an rdonly_buf_size or rdwr_buf_size argument.
> hid_bpf_get_data() (drivers/hid/bpf/hid_bpf_dispatch.c) takes an
> rdwr_buf_size argument this way and is reachable from a
> BPF_PROG_TYPE_STRUCT_OPS HID-BPF program; io_uring/bpf-ops.c:26,47
> declares one as well. The fix belongs at check_kfunc_args(), the
> truncation site. The kfunc's runtime check still guards its allocation
> bound, but it should not have to defend against a size the verifier
> already mis-recorded.
>=20
> bpf_obj_new refuses a local type ID that does not fit u32
> (check_special_kfunc()). check_kfunc_args() does not bound the
> rdonly_buf_size/rdwr_buf_size value that feeds mem_size.

Nit: the above two paragraphs are not necessary.

> Reject rdonly_buf_size/rdwr_buf_size values that exceed U32_MAX at the
> point meta->r0_size is set,

Nit: the below paragraph is not necessary.

> ahead of mark_chain_precision() and the
> later PTR_TO_MEM assignment. The preceding tnum_is_const() check
> already requires the argument to be a known constant, so
> reg->var_off.value is the exact size and rejecting it is sound. U32_MAX
> is the minimal bound that keeps the recorded mem_size within the u32
> field; a tighter semantic maximum is out of scope.
>=20
> Fixes: eb1f7f71c126 ("bpf/verifier: allow kfunc to return an allocated me=
m")
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
