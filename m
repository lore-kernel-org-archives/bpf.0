Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC0A43DEAB
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682997; cv=pass; b=jLukkdqLCAH99Wgw7V3J0EuTBZ7BPgzvO5S3KQqQ1jmwQV6GnhnBroxOl7dL2TJVw3mASre/ZaAy5c5WlXFvYGrmGKVMONy1y5a11pIUdiZlPbHDLYBsFS09CGn1XZSE2+kBFonB5XNzDly+VwwzWfBs/zZ58xfR1FvVzxfD6DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682997; c=relaxed/simple;
	bh=J6SyjgSH6kKttxlcaQY5Q56ih5xn1TTo0a++egsS52Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWdPPp0ZQ90pEnIM8hno9E41U0s7nfOuhRRHJfdnAA8G2vZ5w/Q1AT+QgQ83LoVNC0VP020oqsHvhY5GQcOfMtbKEx1NTCcH+uS4/px+8AvVObE+8NvfeEBYtQRsaTmV2+uPwiC8mLl1l9F1db8g6xC/zWTw4Dln9emiWowEA/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lswfejBb; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lswfejBb"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so35177a91.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 15:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789682995; cv=none;
        d=google.com; s=arc-20260327;
        b=UKSFIl7Axboa1Jstk5aVMx8A5roSIF0kykIq9kK65EzVJ5kwL0QpSWbdYSYzxfdTiB
         gL7HO65lOHaZeiunBtepTEaYkHRgEKMtQX+DpHpSCYByJynFq5rbdip4BjVn6o5uSuov
         1Pg6OApdKfoa8AuahHiWx/ToKwIA1bs7+yp4TkAXEUQe7FebYqzkQE4skog/1gWzlZ09
         P4hUHGSx1cMYejfMddsywzptPUK+C50YVOmY1wCsVHzXdiKb+f1A2ymaGLsY3LuihZbK
         mc//AVCJlT/YaHihEYfWhqsTnDr4VyWLf+bBReqhluJ3rlK4n57Ht/lgwRivfNHSmMgJ
         P0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wQRtY5QKl9FkRvfYTUErV4Q5sEVG3iTso9QeFHxPq6U=;
        fh=N4q98aQPuHTUe2/SXaUIJ6k9rBXzx+Y4IL6Bkl7t+/w=;
        b=O5Xc6CsWfLyd6dTjv6itFiHuUbyu+7xb8SBXnHtl7XVTYR2Z3qbKTI9ya1b/KuCtqG
         bEkem9N6G1CY+HDmuseSinNq+YtgSBk5cap6Koy+sUd64yzWENls/uP0ah/E+1eenf3p
         X51PR2i6ZjLzlXKtYRRZXfcxbu37BWO238UZNFxXT0iS1botInHnkPK3RpcZ6vAD5Mv+
         8cggmYq1VwLsYzblSkAc1dyw20UNAu6Qb6GnTclVtPvrU1snCiOxI62F5CFKZQaVGACX
         Uaedq/3nybeqI390lGlDVqHSEXwr7c2a/dG9Ca5DeGtwqOFCUF4tLS8it5zZgB/aBnuN
         7+dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789682995; x=1790287795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wQRtY5QKl9FkRvfYTUErV4Q5sEVG3iTso9QeFHxPq6U=;
        b=lswfejBbnFiro7zTvnv7ohsJkWJ7rkQ1ar3et/tAPsK7KCiI/9CXgArI/dsb9GWkUN
         VSTQAo1g+yFzRB4fjqbtjJ65hNPnRMAfD+XHLB1mb8sWHr9PcIVo1mls15WPx2ZrQbO4
         4xVmL/J7G0kXnneNoyXTLdPF80TGG4m03Url4JcYatOduQdzvKLUsP/7DQYqXPn7fNeb
         ZyDPOMdhIILHCL6/nCNgE9NkxpcYL6193RXoDeW27Z49FA81Y8B5lT5TDqjVaP5UVhob
         3Z81S4P+evxtrrBvnImQCgC2NoVLOYQR2BOm2TEYEr3sT8Q9ji3/6W3qqb6ffHF3InIC
         eiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682995; x=1790287795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQRtY5QKl9FkRvfYTUErV4Q5sEVG3iTso9QeFHxPq6U=;
        b=guu2E5rlIYoCFX/DPRpf04eCrkcdVue2hsRBehzfJ0d79+Y+i0IPp4hFRSfY2J+Y8Z
         f3jqrTA5sY+z7eecucNjLeZ2ir6L0xvBUrSifSM3XzN0yInrAFse2eXMT3/HX2UsohzL
         pf6QR/MS66vj0TM29F9QaCb+eZnjjBxCv8Xc/ShO1/GDxDRfk8X9zN+1LkKHZFs9mHA8
         9dNPKUZslKtQVompBvdv21Cl6jqZkTMr5zbPdMlj95zCXwK4p7Cb/MID7PFiAtxCTrje
         LfeWAE4Ypbu+SScfEfEa3Bm3+l/A9NQ1AE8L8KKxjZqFMalvKwL61b1HK+v1Yy1Rg/N5
         fjng==
X-Gm-Message-State: AFuF++l/NqRGl/tmk4nTfNUyyE72zWuH2WTBf+VC9+BTCPpuqWz4vTxk
	noQaZbPXmn5QuMtlFZB2NG2UpGjH5ijnEuKwVRbPCl4uA5Oqpsnhf8gWU9mwWg0JIaRaKNzjYk0
	r/R7yYnC7uny60J+Wr1KWhBzwbSuAp+I=
X-Gm-Gg: AYBFou0HXmNPP3H3TvoODO9JNvW9Wb9uChyge6PtEUu7VQ/8Ixj/iyyMEai3eAlMogd
	1mhXrYH+/gFx4Tes8rlmd/TdOLHgAnTL4v0bs0h6OjmERNTLvDmR7g/QPuORtUEKjgKMsLgS275
	xaeMzu+8K5FbPvcBjgIJ7ZKIVFMn4Q8BbA9ffExc6GT+Y2KhIWS+HbZca0+yZWnQ4YSZhGujdBz
	4AFnpMrsgbVwwVDLWvT2PA5CB5ufq9IPsLocUuFMe6CrYHGnynUPABb+FSSFgT15dkWftmlvHyf
	XUL16RIQdmIFSpXrV0m/Evg08oL3ZBo7Cnt1E9mEShcIj3uEkzCVVAtQVq6VkOTEaUAxq/feMnJ
	I8Vl1lJ0dP6OgHLMO1098Vx76W/yMeO+F2u/w7zF01MvWNzf3y57w
X-Received: by 2002:a17:90b:5143:b0:39b:5622:d645 with SMTP id
 98e67ed59e1d1-39e5513d689mr482743a91.0.1789682995305; Thu, 17 Sep 2026
 15:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915080255.48929-1-tasos.papagiannnis@gmail.com> <20260915080255.48929-3-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260915080255.48929-3-tasos.papagiannnis@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Sep 2026 15:09:41 -0700
X-Gm-Features: AcwNN1WTXc_NwWK6MQi-iRZUsTUWGjz1v6pzQXRB3O-GWxbyeKhFKxC4Xn1Cz6w
Message-ID: <CAEf4BzbfScpCi+x+QTdLifbaXPOR=DJ-7nM7F-Lki7vzD9L4OA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/5] exec: Clear bprm->mm before dropping its reference
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>, brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@kernel.org, 
	akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kpsingh@kernel.org, ljs@kernel.org, 
	matt@bobrowski.net, memxor@gmail.com, song@kernel.org, 
	sun.jian.kdev@gmail.com, utilityemal77@gmail.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:03=E2=80=AFAM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> Once mmput() drops the final reference to bprm->mm, the pointer must no
> longer remain accessible through struct linux_binprm.
>
> The successful exec path and the bprm initialization error path already
> clear bprm->mm when ownership is transferred or released. Do the same in
> free_bprm() before calling mmput().
>
> This is required for BPF kfuncs where bprm->mm is either NULL or points
> to a live mm_struct to ensure safe access.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  fs/exec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>

Christian, you ok if we take this through bpf-next? ack?

> diff --git a/fs/exec.c b/fs/exec.c
> index 745f6eb5279e..4ddd403fd91c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1456,9 +1456,12 @@ void bprm_drop_loader(struct linux_binprm *bprm)
>
>  static void free_bprm(struct linux_binprm *bprm)
>  {
> -       if (bprm->mm) {
> +       struct mm_struct *mm =3D bprm->mm;
> +
> +       if (mm) {
>                 acct_arg_size(bprm, 0);
> -               mmput(bprm->mm);
> +               bprm->mm =3D NULL;
> +               mmput(mm);
>         }
>         if (bprm->user_ns)
>                 put_user_ns(bprm->user_ns);
> --
> 2.55.0
>
