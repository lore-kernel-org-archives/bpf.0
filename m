Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804F41DE13
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788234615; cv=pass; b=lt6k9OCb5Mm1/Wy8Yzr2z8jbWmVMQTT2+W2jIeNxwWGu1Z9O9f7+DM989JoQ4id61X3iS+zZN97W4I1Myps2E0qaaNziJhnGuopNhWjodg5iNzAR8pKZtGWFujysIDm2O0G22LzQMoToJjdnpcHQvYwxO0CNrGxZOMnKgNDU5Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788234615; c=relaxed/simple;
	bh=7FzqKOy31dFK2JByQDOuvX61eLKgIqvkGkZe4Vjl9BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aG2xp3oFZSh024u1Tmnnbqlec1X4v+FFtY7ekszPnTjM7hgvbgOxm0zmzqYXeb8UdiG6jkVk5rJtxusXm5hWneLv8nQPQ4/e4quOTgb9YL0S/kbtRWSlwJQJJCcDLEWyJuTGCitOtq4DeecvI3ffOR8XY87ZH/06MyyNIEYFsq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXi60cKZ; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXi60cKZ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66c70cff944so662954d50.0
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 20:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788234613; cv=none;
        d=google.com; s=arc-20260327;
        b=KIeZFHJZ3mGmGyqj3ND3/CXJH+YY3yJqaneiQSrxRwK3pmM9O2ZG9JevbiU7RT2xbe
         gZwlMpI5Dl6Yt/SIY4zC99qbvy9wSEHtAX0bl8Pe41sGcT0vsyEUkXcTXgRbDaVunpmc
         Lfe9opLb5pc0r6xjRl6qEPZY6EVA2wTY9hTDjiRP6slYDqYyU1tmQUMLGAXFnjQc6kqd
         /FF+eJLjLsi+546Rfszz0B5cg9TdmA5YVoqweq0rWZnDUV5RvmUt+WPBrnUnsgqY9WtN
         IKSfdRqxkqJjrDlr0NgVVUxfx9sIm6TApBL28alrKwQCkb1PXN3g+LbIVf6AJCcvVQtA
         VS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oS+YgxWiYLpVEf2e6Auv3kRGzGPNIEMUh3WyA4TvRpc=;
        fh=WV/XN5X1oEf527+V7W8SMtugzL9N6qpwP4JTepq8Hy0=;
        b=bMPjT91SOdwnAz1HoHHaQ5NebTgLOWFmFP6SEHaiUqdeFWlnwRH4K9yPgQCkVHd2o3
         dQkorVWOJT0GGZkCAVjad8P2MDwT+KdwPpzjYg8ASf2VnJyZUrUkzEOYos6vDHaf/XYF
         DmJPSOt5dbgvdTdxGRQSHuny0kSvFK6tXJg8pq2Zcmuh+5qIE12GQtshRwP3u3MCADXi
         SZyhEvXIcN1q9zmSiZOM2D2RmNLlJYJ8fNpP+w6aFy4df87J1Z5MjVWziS1bFpUWejaM
         nHuJLDTOAxZpzl/tdS6msJH2YSQAo3FUprRhHIPdUQHsnlM5pOazR2uBuQi/5PWnOnH4
         GYug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788234613; x=1788839413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oS+YgxWiYLpVEf2e6Auv3kRGzGPNIEMUh3WyA4TvRpc=;
        b=VXi60cKZ6KLoOfpQas1D1MZa9jydnFHL089jOajoV5u2rImq27zhvC85UYKe7utpYr
         mXXetnAJBtv/HXu8QQ6u4fwetu+DK6jsBqf0CFNew/kEw/xNNP9f/nNy/JLfNwcNg/5z
         Fs+A0t7BvqIIyyMIeMltoF4wOzuFEpwP9AD43p0ag6C4YXgRnCAyo0v1j7hbHkRbbjWp
         nCOaeW1CuBJ05066zK5BL2xwJYbO2hGcKcDPCHr3fl8CwMeyDYKsPWnaalQmUXqOj015
         rCAHxNebnhHekcZPaQ8CJH4WIiS66ZvBQ+WwigePSyp87+r7rt9LkhhAM6Wleplg+nSU
         7q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788234613; x=1788839413;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oS+YgxWiYLpVEf2e6Auv3kRGzGPNIEMUh3WyA4TvRpc=;
        b=nybUU9eM0SWmioaZPBuJCosGCpql62PsQb+p5FnfR7YoyrOplJGM//qdri+cPGQLvg
         04cba+aQk2AEi2G1xAgm4BlB01Qs3w/ih6vt1lJyo33VRMwL8AJPEi0hfJi9xyQRCedO
         YR4aZ1WHfSZyVCOX71VzsDd2ByQY/2Phv++EhYoxa7hLF0epLry8chHIOrtLKXTyhMof
         fuFii3anPnf15EH/oFn9XRhjiFH81rxu81YYHwX/sWjrXKwyDjxTI1THaQR/TqIyUTNc
         /P4jbAnhCmuea4F55QEv2Mk2FHB0oQiTMxL1ExNLA5T3zg+/Php/Lcm4qBsAO8eNCeT4
         Cvgw==
X-Gm-Message-State: AFuF++nhlj/5TjyjjlsA+Kvvu9OCRp6NMZ9TZ977BUI2RnM9pfTTKm6P
	0trNiXHeD+gNolR/J9pXn5PjM01i73U1hUGgXUYPA1qnWxuWrj+4STUKBPELgpxjTZZj+AXVYdk
	Idc3LyI3lAjbMzPHr4qkPwYQEZPU5kfQ=
X-Gm-Gg: AYBFou0Ppp7Z8JZHOI1+LRIiiGVy/+GeWmDdQ6lYnyKTH8Av+nkc0l1LV6zJkqsgKq7
	aqemhLCL3TFjvKla0fFWAXdT29HwdNm/xZVvIxf5WBkYWnGLtTDt3cpIo41iNMdxxnXoccwjoFI
	nd0jvaXh1+tzud6cp5gJcgVsVu6PcKO84Jxg7j8X5LvEqg7VFc+ssp7nFnhAWyvxRNrrfZV9OE7
	DDI+iuyQwRhCglG/09P7Fu+5wAt5houCH5npoftgx2cW+eTU3TIEBDO+Tr9eEXLj/ZNZTUYuKgS
	WlJJMhUkDQVQOmDmNw9cmVBXduDCRzQ6MxT0cxo8a7FNMeOJh1nssspuJer/ZYrnQN4VSxQiqE/
	6tLXsOxDwY8AcbNnpPeJSAII=
X-Received: by 2002:a05:690e:4888:20b0:66c:71a4:6ef7 with SMTP id
 956f58d0204a3-66e4c76ec48mr7226022d50.35.1788234612985; Mon, 31 Aug 2026
 20:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com> <20260831092305.42062-7-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260831092305.42062-7-tasos.papagiannnis@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 1 Sep 2026 11:50:08 +0800
X-Gm-Features: AcwNN1U-TrFQ78uGmPSlh5DKr82QMmwSDUwbspb3nZbsW6N1XhgnhGW6LFmWno4
Message-ID: <CABFUUZEwY7B0VOvhbhieHXHuvms4dx_GO3gw99vL1zk8q+ESTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: Mark linux_binprm->mm as trusted-or-null
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	kpsingh@kernel.org, matt@bobrowski.net, song@kernel.org, 
	utilityemal77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 5:28=E2=80=AFPM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
> can pass it to kfuncs after a NULL check. The linux_binprm owns this mm
> throughout the bprm_check_security hook and clears the pointer only after
> exec_mmap() installs the new address space.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 386401fe051d..584c79326b9c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5958,6 +5958,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
>         struct inode *d_inode;
>  };
>
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
> +       struct mm_struct *mm;
> +};
> +
>  BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
>         struct sock *sk;
>  };
> @@ -6012,6 +6016,7 @@ static bool type_is_trusted_or_null(struct bpf_veri=
fier_env *env,
>  {
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
> +       BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm))=
;
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct=
));
>
>         return btf_nested_type_is_trusted(&env->log, reg, field_name, btf=
_id,
> --
> 2.55.0
>
>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
