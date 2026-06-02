Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39C3672B1
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 02:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368891; cv=pass; b=pjmz1AQ4cg6tSLbl645chpIU56IYVqlkuAGSn0xZ6nAAaaUQPQ5xWYHxvWInwd+n5s1tnGmLJiW3C1RlGaPYInuarAN3OBI5B8KfwURpqvkZAWld3f/lWE7Yv3jeeangrhc7otKuO3R3SpwGwaO7okkMEp7NWCYQ0jnmwgKJ9og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368891; c=relaxed/simple;
	bh=uk8nt9ouI40xzhsPA/qfbYMVtdM0sI2i4uGVOYhG3+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/5korU6NPPlbTQrV17ZVI4G508GEbYJ62T2dz+7pGawZ2IzE2yC0hSZsiDhplA3kzMTvSP16pJHGPqDcSTXJggEH1D2me1rHYo1Oq45O0uw8J1437uuphbsTDgcaX8VUUOOfVq46Hf3m2mNMT39/RAXUvobk+XE+wTmC8uIpH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3dJthJ9; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3dJthJ9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so9518365e9.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 19:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780368887; cv=none;
        d=google.com; s=arc-20240605;
        b=f8IyeZGL3QmIJ+HjtpXMxQ/ks4P3BKaPWw37/3DwwviuT2I/7R2Est0bqK2U2M6IHy
         rJcLyqFbQx/r1j0bMGW3+YnQh9TwZD8XUS8KzbG8J7VmiSNcmlPcrusw542rCOyd0e7d
         3bfi2BUMzgkvBDAcA8NUyBKwIIFy/Ax+RD0qlEJ4Ll8bx6MNbNVff6RIyP1g7XBf+PJd
         aVbQR/InuK3InfIeaGiWHSbJj78gnEjfHaWjJL/8spmNFQTDPkvkczXY3OWnb4FzfV2d
         AAOGlOVQRYaS0qRQgDzzJKEMmA/3yxnIQqtqwRPf2g9avqW/wDH2zWWPIjZ90kkXXbnX
         zBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mDG5+g9iIEZV7nrldZOyGtoDTEDk6jB64JHVWJByCPU=;
        fh=1Dk8x+tXchltRV2c1EiZb5IiZJB0bsqcwBrPNWgoqRc=;
        b=ABCp7B+QAY8GdotQCppjwF61KwL3pSkxfFy/Nhp8TNzaZhXYA4fGf+OO3q0wXPQz16
         /04QdSWt4/3SNOHho9x9Bb6HimT6NObC7Y3dHyBeJBCU0182vxGuOuRyFPYN9m3K6Neh
         GBO+xd1tisCFH+V6ClcJl098DK+aSA4CuFLLyYO2suMHvKkJxzbM2z7VVVqNFFB7jlMG
         Mwp3I+VxDGt/sBq8fu9Ava/ggQ5ZZACz40wU6Qy+qb5s/V1yKj8G9QpWztXdYBcTjv1Y
         WNX9qG4xKGw9frtEIdR9m7LpJ2gwDql2v3PN26u9B7Tz/507Yq+KW+srnne4x7paJvfc
         JLhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780368887; x=1780973687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDG5+g9iIEZV7nrldZOyGtoDTEDk6jB64JHVWJByCPU=;
        b=D3dJthJ9rkgtoczlZofPBQOsCuVzFkPCMpa3p97173m9rsSNSqME3IMZ0Br35ToR6t
         vAsVOT0svPv4Iw2hViBR3bjFkViJCXH1jIobCWH/NCVmQyDpvpbpfcHHiBsZNS9DzMz1
         ZwZoBGA1pkuZ9w+zTUAvkCnhMC2YsTO4XtQbtQvaSwyarBaD1XzyeKrOX0NOUgDrUkDa
         KckKTm8BYhwqC21zYYImZzH2cfrMU4z/enbldi33knbsRJLbd15u4v/eksRG7PpBfJgF
         1tbzCHsjSrDP1TrCbqlMpb1dc0Mv800bH5RwTRcq5omg5JUHGk1AAp5PJui6ZFL3QM6D
         N8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780368887; x=1780973687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mDG5+g9iIEZV7nrldZOyGtoDTEDk6jB64JHVWJByCPU=;
        b=WZrEtAOw1ZAPgatX1vtlAgGmC1M+xSJkO6AeQA8iuvbXofbxxvKI4XiKpBysSi/vri
         G9JUNPOJq1q6wHDQFTlOYCJYF1VT6wkTjQwRNO1SoKPyIjxwmjpgxPB+SCaCIvhqGgP0
         mdXM0S1I9rthV46WjefHUwRSUqm7oaY8O1fLq9RcIj0nMrawmDuI+20g+cEQMfrXH1US
         BALsgSjFbuk7vZVUjVdF3tjaX06iivZcR4av3f0ULltsfi5IijfFYjNKfnicagE077Dn
         uvq1iX0O18yaRVuXz71YOIvkpB0E3wzz67DMYDmeL44rqCrkAYD8/gBt7umveQpWo9k5
         TcqA==
X-Forwarded-Encrypted: i=1; AFNElJ9xDr6VM0aB0JXwV29ZjDVEM8ibv0OnksG5l+jEYk9xVNBJYxZhumVapewfzAFXM1bjdc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIYwciO1Kk+BAmh44C4g8i+MG3gOheEkeB9QhimlFtoWSyZSH
	ANsiqmVAQ5Os4XxIM4usLI7Of3mqwTcrD3i7oCm9TDB43c5ZhUGVwHf0srNpc0edG2dPu1tU39H
	tCEpL+z38neiTpJdbH1aeBkiuF9/4JPk=
X-Gm-Gg: Acq92OGxbWR2QayjAg91ZTTHRngMHQtPrIkqntBkhrAejig2BJsW+4SR8a+4p3YSHH6
	0L2UJURTUC0pdSPyw/EkSz3UcpeOLJPQDXxQP3IjqoHQBy8/aPaRrFcuskqVdn236jGAUBffpIC
	yNOQ98R7kdD/+sD+JnWmHNXjo5E5LscxK5ICpWD8cPBtUw8Kh+0977jhPlqQSB4J8xsTzmtyxPO
	DcNi0iCWjxLcYHooRwdwnTOdK4XiNpQsoVfYURJWHFi+cIQqm2S8m6svJAYMMv7zGfq633j59qq
	iY6eY6eEnbQdyCiiD1laUdX9xNoounpvB1+Z5paYSBVVt1szw9n/x6OBHeIn+Hv0L+nx/Umva3v
	XwHbHub7rZOR2fzB+DKp/ApPYdYhSotUDis7t
X-Received: by 2002:a05:600c:4fc4:b0:490:3890:605b with SMTP id
 5b1f17b1804b1-490a29637dfmr240549225e9.31.1780368886942; Mon, 01 Jun 2026
 19:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602025249.113828-1-kartikey406@gmail.com>
In-Reply-To: <20260602025249.113828-1-kartikey406@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 1 Jun 2026 19:54:35 -0700
X-Gm-Features: AVHnY4ItVn_ZmoGz-PLsQ88eISNvVcC_6yPcvm1sSpMBp8dMI9EwyksdBynnQnI
Message-ID: <CAADnVQ+TAm1Mow5sHej5wUGz7j+BLSxw9gGwgP6rP1cw8cRXPA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: fix UAF by restoring RCU-delayed inode freeing in bpffs
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jiri Olsa <jolsa@kernel.org>, KaFai Wan <kafai.wan@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 7:53=E2=80=AFPM Deepanshu Kartikey <kartikey406@gmai=
l.com> wrote:
>
> commit 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning
> htab with internal structs") moved inode cleanup from ->free_inode()
> into ->destroy_inode() to avoid sleeping in RCU context when calling
> bpf_any_put(). However this removed the RCU delay on freeing the
> inode itself and the cached symlink body (i_link), both of which
> can be accessed by RCU pathwalk (pick_link, may_lookup etc.).
>
> This causes a use-after-free when a concurrent unlinkat() drops the
> last inode reference and destroy_inode() frees the inode immediately,
> while another task is still walking the path in RCU mode and reads
> inode->i_opflags (offset +2) inside current_time() -> is_mgtime().
>
> KASAN reports:
>   BUG: KASAN: slab-use-after-free in is_mgtime include/linux/fs.h:2313
>   Read of size 2 at addr ffff8880407e4282 (offset +2 =3D i_opflags)
>
> The rules (per Al Viro):
>   ->destroy_inode()  called immediately, can sleep, use for blocking
>                      cleanup e.g. bpf_any_put()
>   ->free_inode()     called after RCU grace period, use for freeing
>                      inode and anything RCU-accessible e.g. i_link
>
> Fix: split the two concerns properly:
>   - keep bpf_any_put() in bpf_destroy_inode() since it is blocking
>     and needs to run promptly
>   - introduce bpf_free_inode() to handle kfree(i_link) and
>     free_inode_nonrcu() with proper RCU delay, preventing the UAF
>
> Fixes: 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning htab =
with internal structs")
> Reported-by: syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D36e50496c8ac4bcde3f9
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20260423043906.GN3518998@ZenIV/
> Link: https://lore.kernel.org/all/20260602002607.110866-1-kartikey406@gma=
il.com/T/ [v1]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v2:
>   - NAK on v1 fix in fs/namei.c (pick_link) by Al Viro
>   - v1 was papering over the symptom not fixing root cause
>   - real fix is in kernel/bpf/inode.c as suggested by Al Viro

Al,
please ack.
