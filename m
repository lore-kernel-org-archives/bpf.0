Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203320;
	b=K3qlqW3rWfLOxWUPKF8BvvyVqGj8yrWhx4oNJSO4FmwAceP4ctchH4YnlulpLrrDt2gG
	 4+YC/PYBAz2bD24qfbaSTtPmEtLJY0baxW9QJ23ZtD6WAsf15fZclpfwD4iLRG9unNezN
	 8PlmwAcM+tnQcgeEDmS2Fs5ZtuNhNnO5gcGuwqneRCanDXrLdZO4W3TH+C+rAwnburazd
	 lYebEHK4Ltkuk60GP4kJMrKUhhYitrS4K4rYR/YzcbinSXhgVuAurCaqLsG0LYWBPi6H8
	 tjEU7COmUfpx7LqF25vvWhzz9W1kR2z6MbGbYY8FIkIPUS2ZM4DCOhYqJV4+u3nRqNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
	b=zRW5wr8Qen9ychcFJu5fqFighQCTf4DgHnhXneedS30dJSirrrFmA27l48RM6g5YGxQ2
	 kdNCWF3uOjutbTn9EQy+/FgA9ceEFmsRDBviOX98oUZvs1zbr/rLq9vRZVKTnEXzvu1Yl
	 GVQAxd5f5qxOs/MBq2GzVgxK9ABbecaXsHTCp+eGk45tNTp19CH4XoWWWWJevCH044Z4N
	 obogZAt36aL0HjjNj5a3NhkjLr0+iBtr7daJcM+P5Ci1MV7Z+Jgg7zM5aZogES5E/l1dL
	 Le+Bu0Af5iCfIbffG5pnmVINwf9mcClMX07g0xltn0hMRDqXQRlWqN6glTaMfXsGNMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mEayzNdI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856C60A260A
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 19:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9856C60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mEayzNdI
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c40e30c26a4so512396766b.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 11:35:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795203317; cv=none;
        d=google.com; s=arc-20260327;
        b=cgPDN7PkzUVGgQEJLL6dAW8m7tgoYqrtjsv4uiUoi3uHnVwHEuPG59kkeAosV2YDdI
         qbSEVlhXKoR0zz65LFmPj3I8oa3pF0ikoik9rrX3PaZ5fSZoX97WLM96K8RoI5Xp5S8Y
         M2a87pk9PXBcxD9atqqLwDGtlOiGu1MEdTHPTgVA+Ah3XMkMMkUjc1jcQkbozS4q2QDj
         5UuQqJWQX417btQgK86eGCXKNZJ8uM9yk8pyN4trvXMkzKKuyfF0Cy87WNJKFllgKXld
         MLq3vqk4g8FsVkkZgGXacOZsN+pZZiYRiv3RI0o5CDFQ9ouPn4F7TOXWt8LXyLLIzmvc
         65hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
        fh=ycVVaSWOTe2qQbhC7WXOkmzmMTM3EeIo8b3biOrY/eQ=;
        b=rJrmJPHb32z0Mt8jwnPJGTblk/jdr27TxXY+Y3/nwaPONyzx71KXfKxz25VCxcIAYC
         I+zZudoXx5Ff2DYee6/3KWgrGBvFkBH2vY/qvgcTNleYvtc6a8tciSGwF1V9KrvIkI47
         G8wg/LpEFB1z3lE28i2bJtaIBqs70AdXHfWkhiWZSjq5kbD8EICH5Xj+4Rfwr/JsmZgG
         ef272nOohK54fAztMRgnQp9FSDGvEZiIg0FQ6Guytb0XfCLICtfUItdBlY14+92HCX9M
         JFZizID6wjLG+q7jfKXuYrxfnwkZBRfJIHseXIn2TuyxMrTzxDCojVvN6RxUTpGDt2+f
         egng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795203317; x=1795808117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
        b=mEayzNdI3RbBXowLZsBRN9QL9E85SiUM+2Zma239sU2Kh5ksSQzTSY0ziLpiHV59CM
         7SYo/SGHf9f/BuaQcw7L2iv8PrZbptbwejj5saAaosdugF+c/B6mu2N2VcFs3P0J30Xs
         iJONriwUSnCKSsvV3YNuTBiMdGh2ko87iKPSXKaspCKEn8Eg4sIKq9PASEMF25S3rqL+
         ikrtvub/lopTx+V9oIV7ULiuNbYeJREQZANEFrs6J/Ra/Ji6BEJHH9f6CAD3wgAgK2ZV
         tPPXZ4d3w3MMsU/kZaH+NVG54K7lHkycb/em4YaaXq8r36ZApv2ERWimswbtCLQ2nAOA
         NkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203317; x=1795808117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVJmHutVQZugQ3dWxOPlJ+2HDsz3aYGVNDsjIuC8ZbE=;
        b=Qyr8PAgGxuM/+m2JCEfv6Uzbhu3UIBK81CSfq30ADREwPuCPXNErYUYSZ41KfyHR/p
         d31xkV2cu4jaLV3sDd78w/X9or02tGiH30otaFhuIg85KmwstrIakZDasAvLrsK5FHGB
         GeoVJIgdTJOOfBX+O7N/Ts0mceifgKzhlWqPwl14/i1wGdG+J9DNcuMNzvesQ2flO9Ks
         OUSFVm/+fHzcRNh+hTXPeYCHcVFTObk1VD7wh+Ej6yCAic78XNt3OW/0Kw+PfY8gYUV2
         R+Jw/RSNea67Ku1iy0RYn8vGSUxt3c9IpM3JZl+u5B0l8czKlwL3YZT12HOOR0rbkwOh
         SQ0A==
X-Forwarded-Encrypted: i=1; AL+hErEICLMaFDPApe8l7Pdpoa7RSWfIbyF7od93bg4WPBIGhWOEcHisYAzeD50FvDF9izxGaOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9N6AabfPTg4T46ozUw5LqXS3KxZW0UEAxvkaf69ibvItfJF5dK
	xHLAIlXC/bt4Uw2xtZ+UNsdwGCTPpkC8VmIZTEUEsWSHaCL8UebCF093IFaWS0sQ+Ugnd/foDm5
	NfvVsLTlRYEpF6UnuZ6tBZLxycQt62Tuezfq4WHFd
X-Gm-Gg: AZFdTZeVG+44878sPQKOgTC+t0mI1mZJgeWltxtBufnHLAQiZkxj8LAbpzQLVnYTNUX
	qHh/n7WPR2tpXh0ZjD7KMIu7V2B5TBykfS0QYGyDP8lkjQXNEvSng0xRJ3Xi57Ke9YoRBkGE8iM
	K3Vjij1KR2xKpgUDKBxj0Xg/0OquUAjwOt/gdIlvcvSvR+BDG7FSwZPajQNKlVlX44G4/7rdfSU
	P+XCOZUNVugZWmXb93O33TKQFFWGrxw2qbDpdPlqum1EfCTLCXs7GYxqPw1ZYYtV++/QAYhTfxq
	v3mo6gSTsCwSSuNiCHJLsXRgAKEZE6eCATvAo8iGZRqi7fWvSA0dtLE1iRo5LV2UVpfigTpMSKE
	vzdG9oVOayVoJt5DJo54Fvzr/rEgoreuWabSp/6BscHSc2BYkXzJxN5/3nxWYjDyOf4uk
X-Received: by 2002:a17:907:60ce:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c51317e322amr590730366b.6.1795203316417; Fri, 20 Nov 2026
 11:35:16 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-12-wusamuel@google.com> <20261120-antitoxisch-flott-sense-8c2a09fc9679@brauner>
In-Reply-To: <20261120-antitoxisch-flott-sense-8c2a09fc9679@brauner>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 20 Nov 2026 11:35:05 -0800
X-Gm-Features: Aa3M54pZ23SffgU83N8qfNlS7foyPp12zk6Rc2qBKf5ucMmFiR6202xmw20UsI0
Message-ID: <CAG2Kctri9R6b-_OiKcsabdBmLdeWGVY_zmpqqFgDHLKKCDDezA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] Documentation: ioctl-number: Add
 PROCFS_IOCTL_MAGIC range 0x10-0x11
To: Christian Brauner <brauner@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:23=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Nov 13, 2026 at 02:12:46PM -0800, Samuel Wu wrote:
> > +'f'   10-11  linux/fs.h                                               =
 conflict! procfs ioctls (PROCFS_IOCTL_MAGIC)
>
> Those are PAGEMAP_SCAN (16) and PROCMAP_QUERY (17) which are already
> in the tree. The two ioctls this series adds are 48 and 49, i.e.,
> 'f' 30-31, and they aren't registered here at all. Please add them as
> well.

Patch 1/9 here only backfills the existing PAGEMAP_SCAN (16) and
PROCMAP_QUERY (17) entries. 'f' 30-31 for 48 and 49 are respectively
in patches 3/9 and 4/9, where their functionalities are added.

Patch 1/9 is standalone, so it can be picked up independently (or I
can resend it separately).

Thanks!
Sam
